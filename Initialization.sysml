package InitializationPackage {
    private import ISQ::*;
    private import ScalarValues::*;
    private import DAQPackage::*;

    part DAQ : DAQPackage::DataAcquisitionSystem;

    part HEALIOS_Mission {
        part ref DAQ : DAQPackage::DataAcquisitionSystem;
    }
}