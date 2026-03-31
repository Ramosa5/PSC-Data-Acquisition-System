package DAQPackage {
    private import ISQ::*;
    private import ScalarValues::*;
    private import ElectricalComponents::*;
    private import EnvironmentalConditions::*;
    private import Components::*;
    private import DAQActions::*;

    part def PowerFilteringBlock {
        doc /*
         * Power filtering and conditioning block for internal DAQ supply rails.
         * Separate filter units are used for the 3V3 and 5V rails so that
         * each rail can be connected explicitly through interfaces.
         */
        port powerBus3V3 : PowerBus;
        port powerBus5V : PowerBus;
        port powerBusFiltered5V : ~PowerBus;
        port powerBusFiltered3V3 : ~PowerBus;

        part powerFilter3V3 : PowerFilteringUnit;
        part powerFilter5V : PowerFilteringUnit;

        interface input3V3Feed : PowerTransferInterface
            connect powerBus3V3 to powerFilter3V3.unfilteredInput;

        interface output3V3Feed : PowerTransferInterface
            connect powerFilter3V3.filteredOutput to powerBusFiltered3V3;

        interface input5VFeed : PowerTransferInterface
            connect powerBus5V to powerFilter5V.unfilteredInput;

        interface output5VFeed : PowerTransferInterface
            connect powerFilter5V.filteredOutput to powerBusFiltered5V;
    }

    part def SolarCellsBlock {
        doc /*
         * Solar cell block containing perovskite and silicon reference arrays,
         * together with connector and protection hardware.
         */
        part perovskiteSolarArrayCoupon : PerovskiteSolarArray [1..*];
        part referenceSiliconSolarArrayCoupon : SolarArray [1..*];
        part pscConnectorAndProtection : PerovskiteCellConnectorAndProtection;

        port solarInput : ~StellarEnvironment;
        port mpptController : MPPTControl;
    }

    part def MPPTBlock {
        doc /*
         * Maximum Power Point Tracking block with MPPT unit and dump resistor.
         */
        port powerBusFiltered3V3 : PowerBus;
        port mpptController : MPPTControl;

        part mpptUnit : MPPTUnit [1..*];
        part powerDumpResistor : Resistor [1..*];
    }

    part def IVSweepAndReverseBiasBlock {
        doc /*
         * Electrical block supporting IV sweep acquisition and reverse-bias operation.
         */
        port powerBusFiltered5V : PowerBus;

        part ivSweepLoadShuntResistor : Resistor [1];
        part ivSweepLoadMOSFET : IVSweepLoadMOSFET [1];
        part ivSweepLoadOpAmp : IVSweepLoadOpAmp [1];
        part ivSweepLoadDAC : IVSweepLoadDAC [1];
        part currentAndVoltageSensingBlock : CurrentAndVoltageSensingBlock [1];
    }

    part def EnvironmentSensorsBlock {
        doc /*
         * Environmental sensing block providing temperature, irradiance,
         * radiation, and spectrum-related outputs.
         */
        port powerBusFiltered3V3 : PowerBus;

        port temperatureOut : OnBoardStatus;
        port irradianceOut : OnBoardStatus;
        port radiationOut : OnBoardStatus;
        port spectrumOut : OnBoardStatus;
        port solarInput : ~StellarEnvironment;

        part environmentTemperatureSensor : TemperatureSensor;
        part irradianceSensorBlock : IrradianceSensor;
        part radiationDoseSensor : RadiationDoseSensor;
        part spectrometer : LightSpectrumSensor;

        perform action readPayloadTemperature : ReadTemperature;

        bind readPayloadTemperature.temperature =
            environmentTemperatureSensor.temperatureMeasurement;
    }

    part def DataAcquisitionSystem {
        doc /*
         * Top-level data acquisition system integrating power filtering,
         * solar cell interfaces, MPPT, IV sweep and reverse-bias circuitry,
         * and environmental sensing.
         *
         * Port-to-port relationships are modeled with interfaces.
         * Action and item relationships remain modeled with bindings.
         */
        port powerBus3V3 : ~PowerBus;
        port powerBus5V : ~PowerBus;
        port dataBus : ~DataBus;
        port solarInput : ~StellarEnvironment;

        part powerFilteringBlock : PowerFilteringBlock;
        part solarCellsBlock : SolarCellsBlock;
        part mpptBlock : MPPTBlock;
        part ivSweepAndReverseBiasBlock : IVSweepAndReverseBiasBlock;
        part environmentSensorsBlock : EnvironmentSensorsBlock;

        interface incoming3V3Power
            connect powerBus3V3 to powerFilteringBlock.powerBus3V3;

        interface incoming5VPower
            connect powerBus5V to powerFilteringBlock.powerBus5V;

        interface filtered3V3ToEnvironmentSensors : PowerTransferInterface
            connect powerFilteringBlock.powerBusFiltered3V3
            to environmentSensorsBlock.powerBusFiltered3V3;

        interface filtered5VToIVSweepBlock : PowerTransferInterface
            connect powerFilteringBlock.powerBusFiltered5V
            to ivSweepAndReverseBiasBlock.powerBusFiltered5V;

        interface filtered3V3ToMPPTBlock : PowerTransferInterface
            connect powerFilteringBlock.powerBusFiltered3V3
            to mpptBlock.powerBusFiltered3V3;

        interface externalEnvironmentToSolarCells
            connect solarInput to solarCellsBlock.solarInput;

        interface externalEnvironmentToSensors
            connect solarInput to environmentSensorsBlock.solarInput;

        interface solarCellsToMPPTControl : MPPTControlInterface
            connect solarCellsBlock.mpptController
            to mpptBlock.mpptController;

        perform action applyReverseBias : ApplyControlledReverseBiasToPSC;
        perform action measureIVCurves : MeasureIVCurvesOfPSC;
        perform action maintainMaximumPowerPoint : MaintainMaximumPowerPoint;
        perform action collectExperimentalData : CollectExperimentalData;

        bind applyReverseBias.applyReverseBiasVoltageCommand =
            dataBus.command;
        bind measureIVCurves.measureIVCurvesOfPSCCommand =
            dataBus.command;
        bind maintainMaximumPowerPoint.maintainMPPCommand =
            dataBus.command;
        bind collectExperimentalData.collectExperimentalDataCommand =
            dataBus.command;

        bind environmentSensorsBlock.radiationOut =
            collectExperimentalData.measuredRadiationStatus;
        bind environmentSensorsBlock.temperatureOut =
            collectExperimentalData.measuredTemperatureStatus;
        bind environmentSensorsBlock.spectrumOut =
            collectExperimentalData.measuredSpectrumStatus;
        bind environmentSensorsBlock.irradianceOut =
            collectExperimentalData.measuredIrradianceStatus;

        bind dataBus.data = applyReverseBias.voltageApplicationStatus;
        bind dataBus.data = measureIVCurves.measuredIVCurvesStatus;
        bind dataBus.data = maintainMaximumPowerPoint.mppStatus;

        bind dataBus.data = environmentSensorsBlock.radiationOut;
        bind dataBus.data = environmentSensorsBlock.temperatureOut;
        bind dataBus.data = environmentSensorsBlock.spectrumOut;
        bind dataBus.data = environmentSensorsBlock.irradianceOut;
    }
}