// Driver

class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)

    // Ports //
    uvm_analysis_port #(sequence_item) drv_to_enc_port;
    uvm_analysis_imp #(sequence_item, driver) drv_imp;

    function new(string name = "driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    sequence_item seq_itm; // send to encode
    sequence_item transactions[$]; // fifo to receive from ifft
    sequence_item curr_trans;
    virtual dut_interface dut_if;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        drv_to_enc_port = new("drv_to_enc_port",this);
        drv_imp = new("drv_imp",this);
        // `uvm_info("DRIVER", "BUILD PHASE", UVM_LOW) 
        // if (!uvm_config_db#(virtual dut_interface)::get(this, "*", "my_interface", dut_if))
        // begin
        //     `uvm_fatal("DRIVER", "Could not get virtual interface") 
        // end
    endfunction : build_phase

    // take sequence item and put into a fifo
    function void write(sequence_item item);
	    transactions.push_back(item);
	endfunction: write 


    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRIVER","RUN PHASE", UVM_LOW);
        forever begin
            seq_item_port.get_next_item(seq_itm);
            ///////////////// Send to Encoder ///////////////////////
            $display("*********In Driver - sequence_item value: %10h ",seq_itm.rand_48_bits);
            drive_encoder(seq_itm);

            ///////////////// Receive from IFFT ///////////////////////
            wait((transactions.size() != 0));
            curr_trans = transactions.pop_front();
            // need to assign value to encode_freq so it can send to ifft
            $display("*********Driver/Do what ever you need - send sequence_item to encoder: %12h",curr_trans.rand_48_bits);
            do_whatever_ifft(curr_trans);
            
            seq_item_port.item_done();
        end
    endtask : run_phase

    // task send_item(sequence_item item);
    //     forever begin
    //         seq_item_port.get_next_item(item);
    //         $display("*********In Driver - sequence_item value: %10h ",item.rand_48_bits);
    //         drive_encoder(item);
    //         #10
    //         seq_item_port.item_done();
    //     end
    // endtask : send_item

    // task receive_item();
    //     forever begin
    //         sequence_item curr_trans;
    //         wait((transactions.size() != 0));
    //         curr_trans = transactions.pop_front();
    //         // need to assign value to encode_freq so it can send to ifft
    //         $display("*********Driver/Do what ever you need - send sequence_item to encoder: %12h",curr_trans.rand_48_bits);
    //         do_whatever_ifft(curr_trans);
    //     end
    // endtask : receive_item

    // Send message to Encoder
    task drive_encoder(sequence_item itm);
        $display("*********Driver - send sequence_item to encoder");
        drv_to_enc_port.write(itm);
    endtask : drive_encoder

    task do_whatever_ifft(sequence_item itm);
        $display("*********Driver/Do what ever you need - received back from ifft");
    endtask : do_whatever_ifft


endclass : driver