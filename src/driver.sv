// Driver
// Receive 48 bits packet from sequence-sequencer
// Send 48 bits packet to Encoder - IFFT
// Receive back 128 fixed-point complex number packet
// Send 128 fixed-point complex number pack to DUT and to Reference module (FFT - decoder)

class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)

    // Ports //
    uvm_analysis_port #(sequence_item) drv_to_encifft_port;
    uvm_analysis_port #(complex_t) drv_to_fftdec_port;
    uvm_tlm_analysis_fifo #(complex_t) drv_analysis_fifo;
    uvm_tlm_analysis_fifo #(reg) check_output;

    sequence_item seq_itm; // send to encode
    complex_t transactions; // floating-point complex receive from ifft
    complex_t#(fixed_point) transactions_fixed_array[127:0]; // array floating-point 128 complex receive from ifft
    complex_t#(fixed_point) transactions_fixed; // test array
    fixed_point DinR;
    fixed_point DinI;
    reg FirstData;
    reg Pushin;
    reg check_value;
    virtual dut_interface dut_if;

    function new(string name = "driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        if (!uvm_config_db #(virtual dut_interface)::get(this, "", "dut_interface" , dut_if))
			`uvm_fatal("TEST", "Could not get vitual interface")
        drv_to_encifft_port = new("drv_to_encifft_port",this);
        drv_to_fftdec_port = new("drv_to_fftdec_port",this);
        drv_analysis_fifo = new("drv_analysis_fifo",this);
        check_output = new("check_output",this);
        // `uvm_info("DRIVER", "BUILD PHASE", UVM_LOW)
        
    endfunction : build_phase

    task run_phase (uvm_phase phase);
        `uvm_info("DRIVER","RUN PHASE", UVM_LOW);

        forever begin
            seq_item_port.get_next_item(seq_itm);
            check_value = 1;
            // $display("********************** START ONE SEQUENCE ****************************");
            // $display("Packet 48bits received from Sequences: %h", seq_itm.rand_48_bits);
            drv_to_encifft_port.write(seq_itm); // Send seq_itm to encoder

            // receive complex floating point and stack everything inside an array
            for(int i=0; i<128; i++) begin
                drv_analysis_fifo.get(transactions); // Receive complex floating point from encoder
                drv_to_fftdec_port.write(transactions); // Send to FFT - Decoder
                transactions_fixed_array[i] = transactions.convert_to_fixed();
                // transactions.display();
            end

            FirstData = 1;
            Pushin = 1;
            for(int i=0; i<128; i++) begin
                // drv_analysis_fifo.get(transactions); // Receive complex floating point from encoder
                // drv_to_fftdec_port.write(transactions); // Send to FFT - Decoder
                // transactions_fixed = transactions.convert_to_fixed(); // Convert Floating Point to Fixed Point
                // transactions.display();
                // transactions_fixed.display(2);
                // $display("%h",transactions_fixed_array[i].get_real());
                // $display("%h",transactions_fixed_array[i].get_imag());

                transactions_fixed = transactions_fixed_array[i];

            //     // Todo - NEED TO SEND TO THE INTERFACE
                @(posedge dut_if.clk ) #1;
                dut_if.Pushin <= Pushin;
                // $display("Pushin %h",dut_if.Pushin);
                dut_if.FirstData <= FirstData;
                // $display("FirstData %h",dut_if.FirstData);
                dut_if.DinR <= transactions_fixed.get_real();
                // $display("DinR %h",dut_if.DinR);
                dut_if.DinI <= transactions_fixed.get_imag();
                // $display("DinI %h",dut_if.DinI);
                // $display("Sending to DUT real: %h - imag: %h", DinR, DinI);
                FirstData = 0;
            end
            // Pushin = 0;
            stop_pushin(0);
            // send_to_REF(transactions_array); // send to REF
            // #1210;
            check_output.get(check_value);
            wait_for_output(check_value);
            seq_item_port.item_done();
            // $display("****************************************************************************");
        end

    endtask : run_phase

    virtual task stop_pushin(reg Pushin);
        @(posedge dut_if.clk);
            dut_if.Pushin <= Pushin;
    endtask : stop_pushin

    virtual task wait_for_output(reg check_value);
        if (check_value != 1'b1) begin
            #10000;
        end
    endtask : wait_for_output

endclass : driver