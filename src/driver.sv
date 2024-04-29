// Driver

class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)

    // Ports //
    uvm_analysis_port #(sequence_item) drv_to_enc_port;
    uvm_analysis_imp #(complex_t, driver) drv_imp;

    function new(string name = "driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    sequence_item seq_itm; // send to encode
    complex_t transactions[$]; // fifo to receive from ifft
    complex_t complex_item;
    virtual dut_interface dut_if;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        if (!uvm_config_db #(virtual dut_interface)::get(null, "", "dut_interface" , dut_if))
			`uvm_fatal("TEST", "Could not get vitual interface")
        drv_to_enc_port = new("drv_to_enc_port",this);
        drv_imp = new("drv_imp",this);
        // `uvm_info("DRIVER", "BUILD PHASE", UVM_LOW)
        
    endfunction : build_phase

    // take sequence item and put into a fifo
    function void write(complex_t item);
	    transactions.push_back(item);
        // $display("received complex packet inside driver");
        // $display(transactions.size());
	endfunction: write 


    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRIVER","RUN PHASE", UVM_LOW);
        
        // phase.raise_objection(this);
        @(posedge dut_if.Clk);
            ///////////////// Send to Encoder ///////////////////////
            seq_item_port.get_next_item(seq_itm);
            $display("*********In Driver - sequence_item value: %10h ",seq_itm.rand_48_bits);
            drive_encoder(seq_itm);
            seq_item_port.item_done();
            ///////////////// Receive from Encode-IFFT ///////////////////////
            forever begin
                wait((transactions.size() != 0)) begin
                    // $display(transactions.size());
                    complex_item = transactions.pop_front();
                    // $display("This is COMPLEX received from ENCODE_IFFT");
                    // need to assign value to encode_freq so it can send to ifft
                    // complex_item.display();
                    drive_DUT(complex_item);
                end
            end
            print_out_DATAOUT();
            
        // phase.drop_objection(this);
    endtask : run_phase

    // Send message to Encoder
    task drive_encoder(sequence_item itm);
        $display("*********Driver - send sequence_item to encoder");
        drv_to_enc_port.write(itm);
    endtask : drive_encoder

    // Send message to DUT
    virtual task drive_DUT(complex_t itm);
        // $display("*********Driver - send sequence_item to DUT");
        complex_t #(fixed_point) fixed_packet;
        fixed_packet = new();
        itm.display();
        itm.convert_to_fixed();
        itm.display();
        fixed_packet.equal(itm);
        fixed_packet.display();
        send_interface(fixed_packet);
        // print_out_DATAOUT();

    endtask : drive_DUT
    
    virtual task send_interface(complex_t#(fixed_point) itm);
        dut_if.Pushin = 1;
        dut_if.FirstData = 1;
        dut_if.DinR = itm.get_real();
        dut_if.DinI = itm.get_imag();
        dut_if.PushOut = 1;
    endtask : send_interface
    
    virtual task print_out_DATAOUT();
        $display(dut_if.DataOut);
    endtask

endclass : driver