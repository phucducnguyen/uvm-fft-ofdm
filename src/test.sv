// Test class

class test extends uvm_test;
    `uvm_component_utils(test)
    
    virtual dut_interface dut_if;
    sequencer seqr;
    driver drv;
    encode_ifft enc;
    // seq_top ts;

    function new(string name = "test", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    function void build_phase(uvm_phase phase);
        // super.build_phase(phase);
        `uvm_info("TEST", "BUILD PHASE", UVM_MEDIUM)
        if (!uvm_config_db #(virtual dut_interface)::get(null, "", "dut_interface" , dut_if))
			`uvm_fatal("TEST", "Could not get vitual interface")
        seqr = sequencer::type_id::create("SEQUENCER",this);
        drv = driver::type_id::create("DRIVER",this);
        enc = encode_ifft::type_id::create("ENCODE_IFFT",this);
    endfunction : build_phase

    // function void end_of_elaboration_phase(uvm_phase phase);
    //     uvm_top.print_topology();
    // endfunction : end_of_elaboration_phase

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export); // driver to squencer
        drv.drv_to_enc_port.connect(enc.enc_imp); // driver port to ifft agent export
        enc.encode_ifft_port.connect(drv.drv_imp); // ifft agent port to driver imp
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