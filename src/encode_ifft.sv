// Encode - IFFT class - Scoreboard
// take 48 bits from driver and covert to 128 complex number - fixed point
// send back to driver

class encode_ifft extends uvm_scoreboard;
    `uvm_component_utils(encode_ifft) // uvm_macro

    // Ports //
    uvm_analysis_port #(complex_t) enc_ifft_port;
    uvm_tlm_analysis_fifo #(sequence_item) encifft_analysis_fifo;

    sequence_item transactions;
    complex_t ifft_value[127:0];
    complex_t packet_to_driver[127];
    // complex_t#(fixed_point) converted_ifft_value[127:0];

    function new(string name="encode_ifft",uvm_component parent=null); //create constructor
        super.new(name,parent);
        encifft_analysis_fifo = new("encifft_analysis_fifo", this);
        enc_ifft_port = new("enc_ifft_port",this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("ENCODE_IFFT","BUILD PHASE",UVM_MEDIUM);
    endfunction : build_phase
    
    task run_phase(uvm_phase phase);
        forever begin
            // complex_t #(fixed_point) fixed_packet;
            encifft_analysis_fifo.get(transactions);
            // $display("%h", transactions);
            encode(transactions.rand_48_bits);
            // mjifft(ifft_value);
            ifft_fft(ifft_value, 1'b0);
            for (int i = 0; i < 128; i++) begin
                enc_ifft_port.write(ifft_value[i]);

            end
        end 
    endtask : run_phase

    // """Encodes 48 bits to frequency amounts""" //
    function void encode(reg[47:0] itm);
        floating_point xx;
        int fbin=4;
        // floating_point amp[4] = '{0.0,0.333333333333333333,0.666666666666666666,1.0};
        floating_point amp[4] = '{0.0,0.333,0.666,1.0};
        // $display("%f , %f , %f , %f",amp[0],amp[1],amp[2],amp[3]);
        for (int i = 0; i < 128; i++) begin
            ifft_value[i] = new();                         // becasue of class
        end
        while (fbin < 52) begin
            xx = amp[itm & 3];
            // $display("%d %h %f", fbin, itm, xx);
            itm >>= 2;
            ifft_value[fbin].equal_real(xx);               // set ifft_value[fbin] = xx
            ifft_value[128 - fbin].equal_real(xx);         // set ifft_value[128 - fbin] = xx
            fbin += 2;
        end
        ifft_value[55].equal_real(1.0);
        ifft_value[128-55].equal_real(1.0);
    endfunction : encode
    
endclass : encode_ifft