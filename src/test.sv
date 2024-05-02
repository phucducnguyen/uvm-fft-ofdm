// Test class

class test extends uvm_test;
    `uvm_component_utils(test)
    
    virtual dut_interface dut_if;
    sequencer seqr;
    driver drv;
    encode_ifft enc_ifft;
    fft_decode fft_dec;
    DUT_monitor mon_dut;
    compare_sb comp_sb;
    // seq_top ts;

    function new(string name = "test", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    function void build_phase(uvm_phase phase);
        // super.build_phase(phase);
        `uvm_info("TEST", "BUILD PHASE", UVM_MEDIUM)
        if (!uvm_config_db #(virtual dut_interface)::get(this, "", "dut_interface" , dut_if))
			`uvm_fatal("TEST", "Could not get vitual interface")
        seqr = sequencer::type_id::create("SEQUENCER",this);
        drv = driver::type_id::create("DRIVER",this);
        enc_ifft = encode_ifft::type_id::create("ENCODE_IFFT",this);
        fft_dec = fft_decode::type_id::create("FFT_DECODE",this);
        mon_dut = DUT_monitor::type_id::create("DUT_MON",this);
        comp_sb = compare_sb::type_id::create("COMPARE",this);
    endfunction : build_phase

    // function void end_of_elaboration_phase(uvm_phase phase);
    //     uvm_top.print_topology();
    // endfunction : end_of_elaboration_phase

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export); // driver to squencer
        drv.drv_to_encifft_port.connect(enc_ifft.encifft_analysis_fifo.analysis_export); // driver port to encode-ifft
        enc_ifft.enc_ifft_port.connect(drv.drv_analysis_fifo.analysis_export); // encode-ifft port to driver fifo
        drv.drv_to_fftdec_port.connect(fft_dec.fftdec_analysis_fifo.analysis_export); // driver port to fft-decode fifo
        mon_dut.DUT_monitor_port.connect(comp_sb.from_DUT.analysis_export);
        mon_dut.out_put_available.connect(drv.check_output.analysis_export);
        fft_dec.fft_dec_port.connect(comp_sb.from_REF.analysis_export);
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