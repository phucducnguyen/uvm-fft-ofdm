// Test class

class test extends uvm_test;
    `uvm_component_utils(test)
    
    sequencer seqr;
    driver drv;
    encode sb;
    // seq_top ts;

    function new(string name = "test", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    function void build_phase(uvm_phase phase);
        // super.build_phase(phase);
        `uvm_info("TEST", "BUILD PHASE", UVM_MEDIUM)
        seqr = sequencer::type_id::create("SEQUENCER",this);
        drv = driver::type_id::create("DRIVER",this);
        sb = encode::type_id::create("ENCODE",this);
    endfunction : build_phase

    // function void end_of_elaboration_phase(uvm_phase phase);
    //     uvm_top.print_topology();
    // endfunction : end_of_elaboration_phase

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
        // drv.driver_to_encode.connect(sb.in_port);
    endfunction : connect_phase

    task run_phase(uvm_phase phase);
        sequences seq=new();
        `uvm_info("TEST", "message is sent in the test class", UVM_MEDIUM);
        phase.raise_objection(this);
        seq.start(seqr);
        #50;
        phase.drop_objection(this);
    endtask
endclass : test