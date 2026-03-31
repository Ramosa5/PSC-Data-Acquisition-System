package ElectricalComponents {
    private import ISQ::*;
    private import ScalarValues::*;
    private import EnvironmentalConditions::*;
    private import Components::*;
    private import DAQActions::*;

    part def GeneralElectricalComponent {
        doc /*
         * Generic base definition for electrically relevant hardware.
         * name may be used for an engineering or configuration identifier.
         * mass represents the component mass.
         * powerConsumption represents nominal or allocated electrical consumption.
         */
        attribute name : String;
        attribute mass : MassValue;
        attribute powerConsumption : PowerValue;
    }

    port def PowerBus {
        doc /*
         * Electrical power port.
         * voltage is the across variable exposed at this port.
         * current is the through variable exposed at this port.
         */
        out voltage : ISQ::SourceVoltageValue;
        out current : ISQ::ElectricCurrentValue;
    }

    port def MPPTControl :> DataBus {
        doc /*
         * Command and telemetry port used for MPPT-related control and reporting.
         */
        in power : PowerValue;
        in voltage : ISQ::SourceVoltageValue;
        in current : ISQ::ElectricCurrentValue;
    }

    port def ElectricalMeasurementPort :> DataBus {
        doc /*
         * Generic measurement interface for electrical sensing.
         */
        out voltage : ISQ::SourceVoltageValue;
        out current : ISQ::ElectricCurrentValue;
    }

    port def IrradianceMeasurementPort :> DataBus {
        doc /*
         * Measurement interface for irradiance sensing.
         */
        out irradiance : Real;
    }

    port def RadiationMeasurementPort :> DataBus {
        doc /*
         * Measurement interface for radiation-related sensing.
         */
        out radiationLevel : Real;
    }

    port def SpectrumMeasurementPort :> DataBus {
        doc /*
         * Measurement interface for spectral sensing.
         */
        out wavelength : Real;
        out intensity : Real;
    }

    interface def PowerTransferInterface {
        doc /*
         * Reusable interface for electrical power transfer between two power ports.
         */
        end sourcePort : PowerBus;
        end targetPort : PowerBus;
    }

    interface def MPPTControlInterface {
        doc /*
         * Reusable interface for MPPT control interaction between two MPPT control ports.
         */
        end controllerPort : MPPTControl;
        end controlledPort : MPPTControl;
    }

    interface def EnvironmentalInputInterface {
        doc /*
         * Reusable interface for delivery of environmental conditions to a component.
         */
        end sourceEnvironment : StellarEnvironment;
        end targetEnvironment : StellarEnvironment;
    }

    interface def ElectricalMeasurementInterface {
        doc /*
         * Reusable interface for electrical measurement exchange.
         */
        end sensingPort : ElectricalMeasurementPort;
        end receivingPort : ElectricalMeasurementPort;
    }

    interface def TemperatureMeasurementInterface {
        doc /*
         * Reusable interface for temperature reporting.
         */
        end sensingPort : TemperaturePort;
        end receivingPort : TemperaturePort;
    }

    interface def IrradianceMeasurementInterface {
        doc /*
         * Reusable interface for irradiance reporting.
         */
        end sensingPort : IrradianceMeasurementPort;
        end receivingPort : IrradianceMeasurementPort;
    }

    interface def RadiationMeasurementInterface {
        doc /*
         * Reusable interface for radiation reporting.
         */
        end sensingPort : RadiationMeasurementPort;
        end receivingPort : RadiationMeasurementPort;
    }

    interface def SpectrumMeasurementInterface {
        doc /*
         * Reusable interface for spectral measurement reporting.
         */
        end sensingPort : SpectrumMeasurementPort;
        end receivingPort : SpectrumMeasurementPort;
    }

    connection def PowerConnection {
        doc /*
         * Generic connection definition for electrical power linkage.
         */
        end supplier : PowerBus;
        end consumer : PowerBus;
    }

    connection def DataConnection {
        doc /*
         * Generic connection definition for command/status data linkage.
         */
        end source : DataBus;
        end target : DataBus;
    }

    part def SolarArray specializes GeneralElectricalComponent {
        doc /*
         * Generic solar array component.
         * powerGeneration should be interpreted as a nominal or modeled generated power value.
         * The array interacts with the external stellar environment and the MPPT interface.
         */
        attribute powerGeneration : PowerValue;

        port electrodeConnection : ~MPPTControl;
        port solarInput : ~StellarEnvironment;
    }

    part def PerovskiteSolarArray specializes SolarArray {
        doc /*
         * Specialized solar array based on perovskite technology.
         */
        attribute manufacturer : String;
    }

    part def MPPTUnit specializes GeneralElectricalComponent {
        doc /*
         * Maximum Power Point Tracking unit.
         * Receives MPPT control inputs and provides conditioned electrical output.
         */
        port mpptControl : MPPTControl;
        out port powerSupplyBus : PowerBus;
    }

    part def Resistor specializes GeneralElectricalComponent {
        doc /*
         * Passive resistive component.
         */
        attribute resistance : ResistanceValue;
    }

    part def TemperatureSensor specializes GeneralElectricalComponent {
        doc /*
         * Temperature sensing component with a measured temperature output.
         */
        attribute temperatureMeasurement : ISQ::TemperatureValue;

        port temperaturePort : TemperaturePort;
        bind temperaturePort.temperature = temperatureMeasurement;

        perform action readTemperature : ReadTemperature {
            bind temperature = temperatureMeasurement;
        }
    }

    part def IVSweepLoadMOSFET specializes GeneralElectricalComponent {
        doc /*
         * MOSFET element used in the IV sweep and reverse-bias circuitry.
         */
    }

    part def IVSweepLoadOpAmp specializes GeneralElectricalComponent {
        doc /*
         * Operational amplifier used in the IV sweep and reverse-bias circuitry.
         */
    }

    part def IVSweepLoadDAC specializes GeneralElectricalComponent {
        doc /*
         * DAC used to control IV sweep operating conditions.
         */
    }

    part def CurrentAndVoltageSensingBlock specializes GeneralElectricalComponent {
        doc /*
         * Measurement block for current and voltage sensing.
         */
        port voltageCurrentSenseMeasurement : ~ElectricalMeasurementPort;
    }

    part def IrradianceSensor specializes GeneralElectricalComponent {
        doc /*
         * Sensor for incident solar irradiance.
         */
        port irradianceSensorMeasurement : ~IrradianceMeasurementPort;
    }

    part def RadiationDoseSensor specializes GeneralElectricalComponent {
        doc /*
         * Sensor for radiation dose or related radiation environment measurements.
         */
        port radiationSensorMeasurement : ~RadiationMeasurementPort;
    }

    part def LightSpectrumSensor specializes GeneralElectricalComponent {
        doc /*
         * Sensor for spectral measurement of incident light.
         */
        port spectrometerSensorMeasurement : ~SpectrumMeasurementPort;
    }

    part def PowerFilteringUnit specializes GeneralElectricalComponent {
        doc /*
         * Power conditioning and filtering unit for internal electrical supply stabilization.
         */
        in port unfilteredInput : PowerBus;
        out port filteredOutput : PowerBus;
    }

    part def DigitalAnalogConverter specializes GeneralElectricalComponent {
        doc /*
         * Generic digital-to-analog conversion component.
         */
        port controlPort : DataBus;
    }
}