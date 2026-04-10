package RequirementsPackage {
    private import ISQ::*;
    private import ScalarValues::*;
    private import InitializationPackage::*;

    requirement def <R_M_TEMPLATE> M_TEMPLATE { 
            doc /* The Mission shall TBA. */
            
            subject HEALIOS_Mission references InitializationPackage::HEALIOS_Mission;

            //frame concern Component_Reliability_Concern references StakeholderConcernsPackage::Component_Reliability_Concern;
        }

    requirement def <R_DAQ_TEMPLATE> DAQ_TEMPLATE_NAME specializes R_M_TEMPLATE {
            doc /* The DAQ shall TBA. */
            
            subject DAQ references InitializationPackage::DAQ;

            requirement <R_DAQ_TEMPLATE_a> DAQ_TEMPLATE_NAME_a {
                doc /* The DAQ shall TBA. */
            }
        }

    requirement def <R_M_001> M_Solar_Cell_Types { 
        doc /* The mission shall utilise traditional solar cells as a control group to benchmark the degradation rates of the perovskite solar cells payload. */
        
        subject HEALIOS_Mission references InitializationPackage::HEALIOS_Mission;
    }

    requirement def <R_DAQ_001> DAQ_Solar_Cell_Types specializes R_M_001 {
        doc /* The DAQ shall support acquisition and identification of multiple solar cell types for comparative analysis. */
        
        subject DAQ references InitializationPackage::DAQ;

        requirement <R_DAQ_001_a> DAQ_Solar_Cell_Types_a {
            doc /* The DAQ shall acquire data from standard silicon solar cells operating under nominal conditions. */
        }

        requirement <R_DAQ_001_b> DAQ_Solar_Cell_Types_b {
            doc /* The DAQ shall acquire data from perovskite solar cells operating under nominal conditions. */
        }

        requirement <R_DAQ_001_c> DAQ_Solar_Cell_Types_c {
            doc /* The DAQ shall acquire data from perovskite solar cells operating under self-healing conditions. */
        }
    }


    requirement def <R_M_002> M_Measured_Values { 
            doc /* The mission shall characterise the performance of Perovskite Solar Cells (PSC) by measuring: open-circuit voltage, short-circuit current, maximum power output, angle of incidence for solar panels. */
            
            subject HEALIOS_Mission references InitializationPackage::HEALIOS_Mission;
        }

    requirement def <R_DAQ_002> DAQ_Measured_Values specializes R_M_002 {
            doc /* The DAQ shall enable characterisation of the performance of Perovskite Solar Cells (PSC). */
            
            subject DAQ references InitializationPackage::DAQ;

            requirement <R_DAQ_002_a> DAQ_Measured_Values_a {
                doc /* The DAQ shall enable characterisation of the performance of Perovskite Solar Cells (PSC) by measuring: open-circuit voltage. */
            }

            requirement <R_DAQ_002_b> DAQ_Measured_Values_b {
                doc /* The DAQ shall enable characterisation of the performance of Perovskite Solar Cells (PSC) by measuring short-circuit current. */
            }

            requirement <R_DAQ_002_c> DAQ_Measured_Values_c {
                doc /* The DAQ shall enable characterisation of the performance of Perovskite Solar Cells (PSC) by measuring maximum power output. */
            }

            /* AOCS Requirement Package includes the requirement on angle of incidence for solar panels measurements.*/
        }
    
 }