package RequirementsExample {
    requirement def <R_M_TEMPLATE> M_TEMPLATE { 
        doc /* The Mission shall TBA. */
            
        subject HEALIOS_Mission references InitializationPackage::HEALIOS_Mission;

        frame concern NameOfConcern references StakeholderConcernsPackage::Placeholder_Concern;
    }

    requirement def <R_Payload_TEMPLATE> Payload_TEMPLATE_NAME specializes R_M_TEMPLATE {
        doc /* The Payload shall TBA. */
            
        subject Payload references InitializationPackage::Payload;

        requirement <R_Payload_TEMPLATE_a> Payload_TEMPLATE_NAME_a {
            doc /* The Payload shall TBA. */
        }
    }
}
    
package RequirementsPackage {
    private import ISQ::*;
    private import ScalarValues::*;
    private import VerificationPackage::*;

    requirement def <R_Payload_001> Payload_Solar_Cell_Types {
        doc /* The Payload shall include silicon solar cells and perovskite solar cells. */
        
        subject Payload references InitializationPackage::Payload;

        requirement def <R_Payload_001_a> Payload_Solar_Cell_Types_Silicon_Nominal {
            doc /* The Payload shall provide a module with standard silicon solar cells operating under nominal conditions. */

            attribute mainMethod = VerificationMethod::ReviewOfDesign;
            attribute verificationDescription : String = "Review the payload design documentation (including Bill of Materials, electrical schematics, and mechanical layouts).";
            attribute status = VerificationStatus::NotStarted;
        }

        requirement def <R_Payload_001_b> Payload_Solar_Cell_Types_Perovskite_Nominal {
            doc /* The Payload shall provide a module with perovskite solar cells operating under nominal conditions. */

            attribute mainMethod = VerificationMethod::ReviewOfDesign;
            attribute verificationDescription : String = "Review the payload design documentation (including Bill of Materials, electrical schematics, and mechanical layouts).";
            attribute status = VerificationStatus::NotStarted;
        }

        requirement def <R_Payload_001_c> Payload_Solar_Cell_Types_Perovskite_Healing {
            doc /* The Payload shall provide a module with perovskite solar cells operating under self-healing conditions. */

            attribute mainMethod = VerificationMethod::ReviewOfDesign;
            attribute verificationDescription : String = "Review the payload design documentation (including Bill of Materials, electrical schematics, and mechanical layouts).";
            attribute status = VerificationStatus::NotStarted;
        }
    }

    requirement def <R_Payload_002> Payload_Measured_Values {
            doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells. */
            
            subject Payload references InitializationPackage::Payload;

            requirement def <R_Payload_002_a> Payload_Measured_Values_Voltage {
                doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells by measuring: open-circuit voltage. */

                attribute mainMethod = VerificationMethod::Test;
                attribute verificationDescription : String = "Conduct functional testing on the integrated payload to confirm it accurately measures the open-circuit voltage of the solar cell modules.";
                attribute status = VerificationStatus::NotStarted;
            }

            requirement def <R_Payload_002_b> Payload_Measured_Values_Current {
                doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells by measuring short-circuit current. */

                attribute mainMethod = VerificationMethod::Test;
                attribute verificationDescription : String = "Conduct functional testing on the integrated payload to confirm it accurately measures the short-circuit current of the solar cell modules.";
                attribute status = VerificationStatus::NotStarted;
            }

            requirement def <R_Payload_002_c> Payload_Measured_Values_Power {
                doc /* The Payload shall enable characterisation of the performance of silicon solar cells and perovskite solar cells by measuring maximum power output. */

                attribute mainMethod = VerificationMethod::Test;
                attribute verificationDescription : String = "Conduct functional testing on the integrated payload to confirm it accurately measures the maximum power output of the solar cell modules.";
                attribute status = VerificationStatus::NotStarted;
            }

            /* AOCS Requirement Package includes the requirement on angle of incidence for solar panels measurements.*/
    }

    requirement def <R_Payload_003> Payload_Reverse_Bias_Control {
        doc /* The Payload shall control and apply a reverse-bias voltage of -0.5 V to designated perovskite solar cell samples at predefined times, at least once per orbit. */

        subject Payload references InitializationPackage::Payload;
        
        attribute mainMethod = VerificationMethod::Test;
        attribute verificationDescription : String = "Conduct functional testing on the payload to confirm it successfully applies a -0.5 V reverse-bias to the designated perovskite samples at the scheduled intervals.";
        attribute status = VerificationStatus::NotStarted;
    }

    requirement def <R_Payload_004> Payload_Data_Timestamping {
        doc /* The Payload shall enable the on-board computer to timestamp all acquired data. */

        subject Payload references InitializationPackage::Payload;

        attribute mainMethod = VerificationMethod::Test;
        attribute verificationDescription : String = "Conduct system-levelfunctional data interface testing to confirm the on-board computer successfully applies accurate timestamps to all data generated by the payload.";
        attribute status = VerificationStatus::NotStarted;
    }

    requirement def <R_Payload_005> Payload_Integration {
        doc /* The Payload shall successfully integrate with the bus across power, data, and mechanical interfaces. */

        subject Payload references InitializationPackage::Payload;

        requirement def <R_Payload_005_a> Payload_Power_Interface {
                doc /* The Payload shall connect to the Electrical Power System using the specified electrical interface. */

                attribute mainMethod = VerificationMethod::Test;
                attribute secondaryMethod = VerificationMethod::ReviewOfDesign;
                attribute verificationDescription : String = "Conduct functional testing to confirm the payload successfully powers on and operates using the Electrical Power System interface, in accordance with the electrical interface control document.";
                attribute status = VerificationStatus::NotStarted;
            }

            requirement def <R_Payload_005_b> Payload_Data_Interface {
                doc /* The Payload shall connect to the on-board computer using the specified communication interface. */

                attribute mainMethod = VerificationMethod::Test;
                attribute secondaryMethod = VerificationMethod::ReviewOfDesign;
                attribute verificationDescription : String = "Conduct functional testing to confirm the payload successfully communicates with the on-board computer using the specified data interface, in accordance with the communication interface control document.";
                attribute status = VerificationStatus::NotStarted;
            }

            requirement def <R_Payload_005_c> Payload_Mechanical_Interface {
                doc /* The Payload shall connect to the mechanical subsystem using the specified interface. */

                attribute mainMethod = VerificationMethod::Test;
                attribute secondaryMethod = VerificationMethod::ReviewOfDesign;
                attribute verificationDescription : String = "Conduct a physical fit-check test to confirm the payload mechanically integrates with the CubeSat structure in accordance with the mechanical interface control document.";
                attribute status = VerificationStatus::NotStarted;
            }
    }

    requirement def <R_Payload_006> Payload_External_Mounting {
        doc /* The Payload shall be mounted on at least one external side of a CubeSat wall to ensure direct and representative exposure to the space environment. */

        subject Payload references InitializationPackage::Payload;

        attribute mainMethod = VerificationMethod::Inspection;
        attribute secondaryMethod = VerificationMethod::ReviewOfDesign;
        attribute verificationDescription : String = "Visually inspect the fully assembled CubeSat to confirm the payload is physically mounted on an external-facing wall with unobstructed outward exposure, in accordance with the mechanical interface control document.";
        attribute status = VerificationStatus::NotStarted;  
    }

    requirement def <R_Payload_007> Payload_Data_Format {
        doc /* The Payload shall provide format (TBC) of all generated data according to the predefined data packet structure before transmission. */

        subject Payload references InitializationPackage::Payload;

        attribute mainMethod = VerificationMethod::ReviewOfDesign;
        attribute verificationDescription : String = "Review the payload software architecture and interface control documents to confirm the programmed data output matches the specified packet structure.";
        attribute status = VerificationStatus::NotStarted;
    }

    requirement def <R_Payload_008> Payload_Operational_Modes {
        doc /* The Payload shall support switching between Data Acquisition Mode and OFF Mode. */

        subject Payload references InitializationPackage::Payload;

        requirement def <R_Payload_008_a> Payload_Data_Acquisition_Mode {
            doc /* In Data Acquisition Mode, the Payload shall collect data from the solar cell samples at designated frequencies. */
            
            attribute mainMethod = VerificationMethod::Test;
            attribute verificationDescription : String = "Conduct functional testing to confirm the payload actively samples and records data from the solar cells at the specified intervals when commanded into Data Acquisition Mode.";
            attribute status = VerificationStatus::NotStarted;
        }

        requirement def <R_Payload_008_b> Payload_OFF_Mode {
            doc /* In OFF Mode, the Payload shall suspend all data collection and transmission activities to conserve power. */
            
            attribute mainMethod = VerificationMethod::Test;
            attribute verificationDescription : String = "Conduct functional testing to confirm the payload ceases all data operations and drops to its specified baseline power draw when commanded into OFF Mode.";
            attribute status = VerificationStatus::NotStarted;
        }

        requirement def <R_Payload_008_c> Payload_Mode_Launch {
            doc /* The Payload shall remain in the OFF Mode during the launch phase. */
            
            attribute mainMethod = VerificationMethod::Test;
            attribute verificationDescription : String = "Conduct a system startup test to confirm the payload initializes and remains strictly in OFF Mode prior to receiving explicit deployment or activation commands.";
            attribute status = VerificationStatus::NotStarted;
        }
    }

    requirement def <R_Payload_009> Payload_Solar_Cell_Sample_Quantity {
        doc /* The Payload shall include multiple samples of both silicon and perovskite solar cells to ensure statistically significant performance analysis. */

        subject Payload references InitializationPackage::Payload;
        attribute mainMethod = VerificationMethod::ReviewOfDesign;
        attribute verificationDescription : String = "Review the payload design documentation, including the Bill of Materials and component specifications, to confirm the inclusion of multiple samples of both silicon and perovskite solar cells as specified in the payload requirements.";
        attribute status = VerificationStatus::NotStarted;
    }

    requirement def <R_Payload_010> Payload_Operational_Lifetime {
        doc /* The Payload shall operate for a minimum duration of 12 months to enable perovskite solar cells long-term degradation and recovery analysis. */

        subject Payload references InitializationPackage::Payload;

        attribute mainMethod = VerificationMethod::Test;
        attribute secondaryMethod = VerificationMethod::Analysis;
        attribute verificationDescription : String = "Conduct payload environmental testing campaign, including thermal cycling and vibration tests, to confirm functional performance, supported by analysis of the test data to verify compliance across all mission parameters.";
        attribute status = VerificationStatus::NotStarted;
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

package StakeholderConcernsPackage {
    private import ISQ::*;
    private import ScalarValues::*;

    concern def Placeholder_Concern_Definition {
        doc /* Placeholder concern for requirements that do not yet have an assigned stakeholder concern. */
        subject HEALIOS_Mission references InitializationPackage::HEALIOS_Mission;
        stakeholder stakeholder_name references Stakeholder;    
    }

    concern Placeholder_Concern : Placeholder_Concern_Definition {
        doc /* Placeholder concern for requirements that do not yet have an assigned stakeholder concern. */
    }

    part def Placeholder_Stakeholder {
        doc /* Placeholder for requirements that do not yet have an assigned stakeholder. */
    }

    part Stakeholder : Placeholder_Stakeholder {
        doc /* A stakeholder of the HEALIOS mission. */
    }
}