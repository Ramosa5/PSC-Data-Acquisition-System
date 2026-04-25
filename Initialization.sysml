package Initialization {
    private import ISQ::*;
    private import ScalarValues::*;
    private import PayloadActions::*;
    private import PhotovoltaicModule::*;
    private import Components::*;

    part PVModule : PhotovoltaicModule::PVModule;
    part DAQ : DataAcquisitionModule::DAQModule;

    part Payload {
        ref part DAQ : DataAcquisitionModule::DAQModule;
        ref part PVModule : PhotovoltaicModule::PVModule ;
        state PayloadMode : SatelliteMode {
            doc /*
            * Defines the inner state of the mission Payload.
            */
            in abstract port switchCommand :>> switchCommand;
                entry;
                then NominalSunMode;

                state SafeMode {
                    doc
                    /* Stops all scientific & waits for command */
                }
                state NominalSunMode {
                    doc
                    /* Nominal sun opearations */
                }
                state NominalEclipseMode {
                    doc
                    /* Nominal eclipse operations */
                }

                transition SunToEclipse
                    first NominalSunMode
                    accept ProceedToEclipseCommand : OnBoardCommand
                    then NominalEclipseMode;

                transition Eclipse_To_Sun
                    first NominalEclipseMode
                    accept ProceedToSunCommand : OnBoardCommand
                    then NominalSunMode;

                transition Safe_To_Nominal
                    first SafeMode
                    accept ProceedToNominalCommand : OnBoardCommand
                    then NominalSunMode;

                transition NominalSunToSafe
                    first NominalSunMode
                    accept EnterSafeModeCommand : OnBoardCommand
                    do action EnterSafeMode : PayloadActions::EnterSafeMode
                    then SafeMode;

                transition NominalEclipseTo_Safe
                    first NominalEclipseMode
                    accept EnterSafeModeCommand : OnBoardCommand
                    do action EnterSafeMode : PayloadActions::EnterSafeMode
                    then SafeMode;
        }
    }

    part HEALIOS_Mission {
        ref part Payload;
    }
}