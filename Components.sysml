package Components {
    private import ScalarValues::*;
    private import ISQ::*;

    item def OnBoardStatus {
        doc /*
         * Generic on-board status item.
         */
        attribute statusType : String;
        attribute source : String;
    }

    item def OnBoardCommand {
        doc /*
         * Generic on-board command item.
         */
        attribute commandType : String;
        attribute target : String;
    }

    port def DataBus {
        doc /*
         * Generic logical interface for command and status exchange.
         */
        in data : OnBoardStatus;
        out command : OnBoardCommand;
    }

    port def TemperaturePort specializes DataBus {
        doc /*
         * Logical interface for command/status exchange with temperature output.
         */
        out temperature : ISQ::TemperatureValue [1..*];
    }

    part def PerovskiteCellConnectorAndProtection {
        doc /*
         * Connector and protection element for perovskite cell integration.
         */
        attribute name : String;
        attribute mass : MassValue;
        attribute maxVoltage : ISQ::SourceVoltageValue;
        attribute maxCurrent : ISQ::ElectricCurrentValue;
    }
}