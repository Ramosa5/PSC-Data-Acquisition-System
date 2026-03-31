package DAQActions {
    private import Components::*;
    private import ISQ::*;

    action def PerformSpaceSegmentMission {
        doc /*
         * Top-level mission action for payload-related space segment operations.
         */
    }

    action def ProvideScientificMeasurements specializes PerformSpaceSegmentMission {
        doc /*
         * Base action for science-related measurement and experiment activities.
         * The input command is constrained to measurement-related commands.
         */
        in performScientificActionCommand : OnBoardCommand [0..*] {
            :>> commandType = "MeasurementCommand";
        }
        out measuredData : OnBoardStatus [0..*];
    }

    action def ApplyReverseBiasVoltage {
        doc /*
         * Performs the actual reverse-bias voltage application.
         */
        in applyReverseBiasVoltageCommand : OnBoardCommand;
        out reverseBiasVoltage : ISQ::SourceVoltageValue;
    }

    action def AcquireIVCurvesOfPSC {
        doc /*
         * Performs I-V curve acquisition for perovskite solar cells.
         */
        in measureIVCurvesOfPSCCommand : OnBoardCommand;
        out ivCurvesData : OnBoardStatus;
    }

    action def MaintainMPP {
        doc /*
         * Performs maximum power point maintenance.
         */
        in maintainMPPCommand : OnBoardCommand;
        out mppData : OnBoardStatus;
    }

    action def ApplyControlledReverseBiasToPSC specializes ProvideScientificMeasurements {
        doc /*
         * Applies controlled reverse bias to a perovskite solar cell
         * and reports the resulting application status.
         */
        in applyReverseBiasVoltageCommand redefines performScientificActionCommand;
        out voltageApplicationStatus redefines measuredData;

        perform action applyReverseBiasVoltage : ApplyReverseBiasVoltage;

        bind applyReverseBiasVoltage.applyReverseBiasVoltageCommand =
            applyReverseBiasVoltageCommand;
        flow from applyReverseBiasVoltage.reverseBiasVoltage to voltageApplicationStatus;
    }

    action def MeasureIVCurvesOfPSC specializes ProvideScientificMeasurements {
        doc /*
         * Executes I-V curve measurements for the perovskite solar cells
         * and provides measurement status output.
         */
        in measureIVCurvesOfPSCCommand redefines performScientificActionCommand;
        out measuredIVCurvesStatus redefines measuredData;

        perform action acquireIVCurvesOfPSC : AcquireIVCurvesOfPSC;

        bind acquireIVCurvesOfPSC.measureIVCurvesOfPSCCommand =
            measureIVCurvesOfPSCCommand;
        flow from acquireIVCurvesOfPSC.ivCurvesData to measuredIVCurvesStatus;
    }

    action def MaintainMaximumPowerPoint specializes ProvideScientificMeasurements {
        doc /*
         * Maintains maximum power point operation and reports resulting status.
         */
        in maintainMPPCommand redefines performScientificActionCommand;
        out mppStatus redefines measuredData;

        perform action maintainMPP : MaintainMPP;

        bind maintainMPP.maintainMPPCommand = maintainMPPCommand;
        flow from maintainMPP.mppData to mppStatus;
    }

    action def MeasureRadiation {
        doc /*
         * Measures the radiation environment and produces a status output.
         */
        in measureRadiationCommand : OnBoardCommand;
        out radiationData : OnBoardStatus;
    }

    action def MeasureTemperature {
        doc /*
         * Measures temperature and produces a status output.
         */
        in measureTemperatureCommand : OnBoardCommand;
        out temperatureData : OnBoardStatus;
    }

    action def MeasureSpectrum {
        doc /*
         * Measures the incident light spectrum and produces a status output.
         */
        in measureSpectrumCommand : OnBoardCommand;
        out spectrumData : OnBoardStatus;
    }

    action def MeasureIrradiance {
        doc /*
         * Measures solar irradiance and produces a status output.
         */
        in measureIrradianceCommand : OnBoardCommand;
        out irradianceData : OnBoardStatus;
    }

    action def CollectExperimentalData specializes ProvideScientificMeasurements {
        doc /*
         * Composite action that collects environmental and experimental data
         * by invoking radiation, temperature, spectrum, and irradiance measurements.
         */
        in collectExperimentalDataCommand redefines performScientificActionCommand;

        out measuredRadiationStatus redefines measuredData;
        out measuredTemperatureStatus redefines measuredData;
        out measuredSpectrumStatus redefines measuredData;
        out measuredIrradianceStatus redefines measuredData;

        perform action measureRadiation : MeasureRadiation;
        perform action measureTemperature : MeasureTemperature;
        perform action measureSpectrum : MeasureSpectrum;
        perform action measureIrradiance : MeasureIrradiance;

        bind measureRadiation.measureRadiationCommand = collectExperimentalDataCommand;
        bind measureTemperature.measureTemperatureCommand = collectExperimentalDataCommand;
        bind measureSpectrum.measureSpectrumCommand = collectExperimentalDataCommand;
        bind measureIrradiance.measureIrradianceCommand = collectExperimentalDataCommand;

        flow from measureRadiation.radiationData to measuredRadiationStatus;
        flow from measureTemperature.temperatureData to measuredTemperatureStatus;
        flow from measureSpectrum.spectrumData to measuredSpectrumStatus;
        flow from measureIrradiance.irradianceData to measuredIrradianceStatus;
    }

    action def ReadTemperature {
        doc /*
         * Returns a temperature value from a temperature-sensing context.
         */
        out temperature : ISQ::TemperatureValue;
    }
}