package EnvironmentalConditions {
    private import ScalarValues::*;
    private import ISQ::*;

    item def SolarSpectrumSample {
        doc /*
         * A single sample of the solar spectrum.
         * wavelength is expressed in nm.
         * intensity is expressed in W/m^2/nm.
         */
        wavelength : Real;
        intensity : Real;
    }

    item def SolarIrradiance {
        doc /*
         * Total incident solar irradiance.
         * value is expressed in W/m^2.
         */
        value : Real;
    }

    item def SolarIncidenceAngle {
        doc /*
         * Angle between the incident solar direction and the relevant surface normal.
         * value is expressed in degrees.
         */
        value : Real;
    }

    item def EnvironmentTemperature {
        doc /*
         * Environmental temperature relevant to the exposed payload or sensor context.
         */
        value : ISQ::TemperatureValue;
    }

    item def IlluminationState {
        doc /*
         * Indicates whether the system is currently illuminated by the Sun.
         */
        inSunlight : Boolean;
    }

    port def StellarEnvironment {
        doc /*
         * Environmental interface providing solar and thermal conditions
         * to connected parts.
         */
        out item irradiance : SolarIrradiance;
        out item spectrumSample : SolarSpectrumSample;
        out item incidenceAngle : SolarIncidenceAngle;
        out item temperature : EnvironmentTemperature;
        out item illuminationState : IlluminationState;
    }
}