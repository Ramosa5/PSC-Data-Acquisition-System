package InitializationPackage {
    private import ISQ::*;
    private import ScalarValues::*;

    part PVModule;
    part DAQ : DAQPackage::DataAcquisitionSystem;

    part Payload {
        ref part DAQ : DAQPackage::DataAcquisitionSystem;
        ref part PVModule;
    }

    part HEALIOS_Mission {
        ref part Payload;
    }
}