package RequirementsPackage{
    private import ISQ::*;
    private import ScalarValues::*;
    private import InitializationPackage::*;

requirement def <R_DAQ_001> Mission_Duration { 
        doc /* The mission shall operate in orbit for a duration sufficient to generate statistically significant degradation and recovery data (Target: 1 Year). */
        
        subject DAQ references InitializationPackage::DAQ;

        //frame concern Component_Reliability_Concern references StakeholderConcernsPackage::Component_Reliability_Concern;
        //frame concern Perovskite_TRL_Advancement_Concern references StakeholderConcernsPackage::Perovskite_TRL_Advancement_Concern;
    }
}