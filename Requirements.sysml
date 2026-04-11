package RequirementsPackage {
    private import ISQ::*;
    private import ScalarValues::*;
    private import VerificationPackage::*;

    requirement def <R_M_TEMPLATE> M_TEMPLATE { 
        doc /* The Mission shall TBA. */
            
        subject HEALIOS_Mission references InitializationPackage::HEALIOS_Mission;

        //frame concern Component_Reliability_Concern references StakeholderConcernsPackage::Component_Reliability_Concern;
    }

    requirement def <R_Payload_TEMPLATE> Payload_TEMPLATE_NAME specializes R_M_TEMPLATE {
        doc /* The Payload shall TBA. */
            
        subject Payload references InitializationPackage::Payload;

        requirement <R_Payload_TEMPLATE_a> Payload_TEMPLATE_NAME_a {
            doc /* The Payload shall TBA. */
        }
    }

    requirement def <R_Payload_001> Payload_Solar_Cell_Types {
        doc /* The Payload shall include silicon solar cells and perovskite solar cells. */
        
        subject Payload references InitializationPackage::Payload;

        requirement def <R_Payload_001_a> Payload_Solar_Cell_Types_Silicon_Nominal {
            doc /* The Payload shall provide a module with standard silicon solar cells operating under nominal conditions. */

            attribute method = VerificationMethod::ReviewOfDesign;
            attribute verificationDescription : String = "TBA";
            attribute status = VerificationStatus::NotStarted;
        }

        requirement def <R_Payload_001_b> Payload_Solar_Cell_Types_Perovskite_Nominal {
            doc /* The Payload shall provide a module with perovskite solar cells operating under nominal conditions. */
        }

        requirement def <R_Payload_001_c> Payload_Solar_Cell_Types_Perovskite_Healing {
            doc /* The Payload shall provide a module with perovskite solar cells operating under self-healing conditions. */
        }
    }

    requirement def <R_Payload_002> Payload_Measured_Values {
            doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells. */
            
            subject Payload references InitializationPackage::Payload;

            requirement def <R_Payload_002_a> Payload_Measured_Values_Voltage {
                doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells by measuring: open-circuit voltage. */
            }

            requirement def <R_Payload_002_b> Payload_Measured_Values_Current {
                doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells by measuring short-circuit current. */
            }

            requirement def <R_Payload_002_c> Payload_Measured_Values_Power {
                doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells by measuring maximum power output. */
            }

            /* AOCS Requirement Package includes the requirement on angle of incidence for solar panels measurements.*/
    }

    requirement def <R_Payload_003> Payload_Reverse_Bias_Control {
        doc /* The Payload shall control and apply a specified reverse-bias voltage to designated perovskite solar cell samples during eclipse phases. */

        subject Payload references InitializationPackage::Payload;

    requirement def <R_Payload_003_a> Payload_Reverse_Bias_Scheduling {
        doc /* The Payload shall be capable of applying a controlled reverse-bias voltage at predefined times, at least once per orbit. */
        }
    }

    requirement def <R_Payload_004> Payload_Data_Timestamping {
        doc /* The Payload shall enable the on-board computer to timestamp all acquired data. */

        subject Payload references InitializationPackage::Payload;
    }

    requirement def <R_Payload_005> Payload_Eclipse_Utilization {
        doc /* The Payload shall utilize natural orbital eclipse periods as the baseline dark recovery phase for perovskite solar cell samples. */

        subject Payload references InitializationPackage::Payload;
    }

    requirement def <R_Payload_006> Payload_External_Mounting {
        doc /* The Payload shall be mounted on at least one external side of a CubeSat wall to ensure direct and representative exposure to the space environment. */

        subject Payload references InitializationPackage::Payload;
    }

    requirement def <R_Payload_007> Payload_Data_Transmission {
        doc /* The Payload shall transmit all collected data to the on-board computer for storage and subsequent downlink to Earth. */

        subject Payload references InitializationPackage::Payload;
    }

    requirement def <R_Payload_008> Payload_Operational_Modes {
        doc /* The Payload shall support switching between Data Acquisition Mode and OFF Mode. */

        subject Payload references InitializationPackage::Payload;

        requirement def <R_Payload_008_a> Payload_Data_Acquisition_Mode {
            doc /* In Data Acquisition Mode, the Payload shall collect data from the solar cell samples at designated frequencies. */
        }

        requirement def <R_Payload_008_b> Payload_OFF_Mode {
            doc /* In OFF Mode, the Payload shall suspend all data collection and transmission activities to conserve power. */
        }

        requirement def <R_Payload_008_c> Payload_Mode_Launch {
            doc /* The Payload shall remain in the OFF Mode during the launch phase. */
        }
    }

    requirement def <R_Payload_009> Payload_Solar_Cell_Sample_Quantity {
        doc /* The Payload shall include multiple samples of both silicon and perovskite solar cells to ensure statistically significant performance analysis. */

        subject Payload references InitializationPackage::Payload;
    }

    requirement def <R_Payload_010> Payload_Operational_Lifetime {
        doc /* The Payload shall operate for a minimum duration of 12 months to enable long-term degradation and recovery analysis. */

        subject Payload references InitializationPackage::Payload;
    }
}


package VerificationPackage {
    private import ISQ::*;
    private import ScalarValues::*;

    enum def VerificationMethod {
        enum Test;
        enum Analysis;
        enum Inspection;
        enum ReviewOfDesign;
    }
    
    enum def VerificationStatus {
        enum NotStarted;
        enum InProgress;
        enum Passed;
        enum Failed;
    }
}