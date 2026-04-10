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
 }