package PhotovoltaicModule {
    private import ISQ::*;
    private import ScalarValues::*;
    private import ElectricalComponents::*;
    private import EnvironmentalConditions::*;
    private import Components::*;
    private import PayloadActions::*;

    part def PhotovoltaicMountingPlateBlock {
        doc /*
         * External mechanical carrier for photovoltaic payload elements.
         * Provides physical support, alignment, and exposure to the space
         * environment for PSC samples, silicon reference cells, and local
         * environmental sensors.
         */
        port solarInput : ~StellarEnvironment;

        part photovoltaicMountingPlate : MountingPlate [1..*];
    }

    part def NominalPSCGroupBlock {
        doc /*
         * Group of perovskite solar-cell samples operating in nominal mode.
         * These samples remain under nominal photovoltaic operation during
         * sunlit phases and are used as untreated PSC references.
         */
        port solarInput : ~StellarEnvironment;
        port mpptController : MPPTControl;
        port daqElectricalInterface : PowerBus;

        part nominalPerovskiteSolarArrayCoupon : PerovskiteSolarArray [1..*];
        part nominalPSCConnectorAndProtection : PerovskiteCellConnectorAndProtection;

        interface environmentExposure
            connect solarInput to nominalPerovskiteSolarArrayCoupon.solarInput;
    }

    part def SelfHealingPSCGroupBlock {
        doc /*
         * Group of perovskite solar-cell samples assigned to reverse-bias
         * self-healing experiments. During sunlit phases they operate in
         * nominal photovoltaic mode; during eclipse they are routed to the
         * reverse-bias branch in the DAQ.
         */
        port solarInput : ~StellarEnvironment;
        port mpptController : MPPTControl;
        port daqElectricalInterface : PowerBus;

        part selfHealingPerovskiteSolarArrayCoupon : PerovskiteSolarArray [1..*];
        part selfHealingPSCConnectorAndProtection : PerovskiteCellConnectorAndProtection;

        interface environmentExposure
            connect solarInput to selfHealingPerovskiteSolarArrayCoupon.solarInput;
    }

    part def SiliconReferenceGroupBlock {
        doc /*
         * Group of silicon reference solar-cell samples used to benchmark
         * PSC degradation and performance under identical orbital conditions.
         */
        port solarInput : ~StellarEnvironment;
        port mpptController : MPPTControl;
        port daqElectricalInterface : PowerBus;

        part referenceSiliconSolarArrayCoupon : SolarArray [1..*];

        interface environmentExposure
            connect solarInput to referenceSiliconSolarArrayCoupon.solarInput;
    }

    part def PhotovoltaicHarnessBlock {
        doc /*
         * Electrical harness and routing block between the external
         * photovoltaic module and the internal DAQ module.
         * Provides dedicated channel separation for sample groups and sensors.
         */
        port nominalPSCInterface : ~PowerBus;
        port selfHealingPSCInterface : ~PowerBus;
        port siliconReferenceInterface : ~PowerBus;

        port nominalPSCToDAQ : PowerBus;
        port selfHealingPSCToDAQ : PowerBus;
        port siliconReferenceToDAQ : PowerBus;

        interface nominalPSCFeed : PowerTransferInterface
            connect nominalPSCInterface to nominalPSCToDAQ;

        interface selfHealingPSCFeed : PowerTransferInterface
            connect selfHealingPSCInterface to selfHealingPSCToDAQ;

        interface siliconReferenceFeed : PowerTransferInterface
            connect siliconReferenceInterface to siliconReferenceToDAQ;
    }

    part def PVModule {
        doc /*
         * Top-level external photovoltaic payload module.
         *
         * The module consists of:
         * - a dedicated mounting plate exposed to the space environment,
         * - PSC samples in nominal mode,
         * - PSC samples in self-healing mode,
         * - silicon reference cells,
         * - local environmental sensors,
         * - electrical harnessing to the DAQ module.
         *
         * The photovoltaic module is mechanically external and electrically
         * decoupled from the spacecraft power bus. Generated power is routed
         * only toward the DAQ-controlled measurement and loading electronics.
         */
        port solarInput : ~StellarEnvironment;

        port nominalPSCToDAQ : ~PowerBus;
        port selfHealingPSCToDAQ : ~PowerBus;
        port siliconReferenceToDAQ : ~PowerBus;

        port mpptControllerNominalPSC : ~MPPTControl;
        port mpptControllerSelfHealingPSC : ~MPPTControl;
        port mpptControllerSiliconReference : ~MPPTControl;

        port powerBusFiltered3V3 : ~PowerBus;

        part photovoltaicMountingPlateBlock : PhotovoltaicMountingPlateBlock;
        part nominalPSCGroupBlock : NominalPSCGroupBlock;
        part selfHealingPSCGroupBlock : SelfHealingPSCGroupBlock;
        part siliconReferenceGroupBlock : SiliconReferenceGroupBlock;
        part photovoltaicHarnessBlock : PhotovoltaicHarnessBlock;

        interface externalEnvironmentToMountingPlate
            connect solarInput to photovoltaicMountingPlateBlock.solarInput;

        interface externalEnvironmentToNominalPSC
            connect solarInput to nominalPSCGroupBlock.solarInput;

        interface externalEnvironmentToSelfHealingPSC
            connect solarInput to selfHealingPSCGroupBlock.solarInput;

        interface externalEnvironmentToSiliconReference
            connect solarInput to siliconReferenceGroupBlock.solarInput;

        interface nominalPSCMPPTControl : MPPTControlInterface
            connect mpptControllerNominalPSC
            to nominalPSCGroupBlock.mpptController;

        interface selfHealingPSCMPPTControl : MPPTControlInterface
            connect mpptControllerSelfHealingPSC
            to selfHealingPSCGroupBlock.mpptController;

        interface siliconReferenceMPPTControl : MPPTControlInterface
            connect mpptControllerSiliconReference
            to siliconReferenceGroupBlock.mpptController;

        interface nominalPSCToHarness : PowerTransferInterface
            connect nominalPSCGroupBlock.daqElectricalInterface
            to photovoltaicHarnessBlock.nominalPSCInterface;

        interface selfHealingPSCToHarness : PowerTransferInterface
            connect selfHealingPSCGroupBlock.daqElectricalInterface
            to photovoltaicHarnessBlock.selfHealingPSCInterface;

        interface siliconReferenceToHarness : PowerTransferInterface
            connect siliconReferenceGroupBlock.daqElectricalInterface
            to photovoltaicHarnessBlock.siliconReferenceInterface;

        interface harnessToDAQNominalPSC : PowerTransferInterface
            connect photovoltaicHarnessBlock.nominalPSCToDAQ
            to nominalPSCToDAQ;

        interface harnessToDAQSelfHealingPSC : PowerTransferInterface
            connect photovoltaicHarnessBlock.selfHealingPSCToDAQ
            to selfHealingPSCToDAQ;

        interface harnessToDAQSiliconReference : PowerTransferInterface
            connect photovoltaicHarnessBlock.siliconReferenceToDAQ
            to siliconReferenceToDAQ;
    }
}