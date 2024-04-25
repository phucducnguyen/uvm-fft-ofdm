// Encode class - Scoreboard
// take 48 bits and covert to 24 tones (24 frequency levels)
// send to IFFT

class encode extends uvm_scoreboard;
    `uvm_component_utils(encode) // uvm_macro

    // Ports //
    uvm_analysis_port #(sequence_item) encode_to_ifft_port;
    uvm_analysis_imp #(sequence_item, encode) enc_imp;
    // uvm_analysis_port #(sequence_item) enc_to_ifft;

    sequence_item transactions[$];
    complex_t enc_packet;


    function new(string name="encode",uvm_component parent=null); //create constructor
        super.new(name,parent);
        enc_imp = new("enc_imp", this);
        encode_to_ifft_port = new("encode_to_ifft_port",this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("ENCODE","BUILD PHASE",UVM_MEDIUM);
    endfunction : build_phase

    // take sequence item and put into a fifo
    function void write(sequence_item item);
	    transactions.push_back(item);
	endfunction: write 

    task run_phase(uvm_phase phase); 
        `uvm_info("ENCODE","RUN PHASE", UVM_LOW);
        forever begin
            sequence_item curr_trans;
            wait((transactions.size() != 0));
            curr_trans = transactions.pop_front();
            // need to assign value to encode_freq so it can send to ifft
            encode_freq(curr_trans);
            #10
            drive_ifft(curr_trans);
        end
    endtask : run_phase

    // where the encode happens
    // change to frequency domain
    // def encbits(d):
    // """Encodes 48 bits to frequency amounts"""
    //     amp=[0.0,0.333,0.666,1.0]
    //     res=[0+0j for x in range(128)]
    //     fbin=4
    //     while fbin < 52:
    //         xx=amp[d&3]
    // #        print(fbin,hex(d),xx)
    //         d>>=2
    //         res[fbin]=xx
    //         res[(128-fbin)]=xx  # placed in both positive and negative freqs
    //         fbin+=2
    //     res[55]=1.0
    //     res[128-55]=1.0
    //     return res
    bit signed [127:0] out128;
    task encode_freq(sequence_item curr_trans);
        $display("*********Encode/Task Encode_freq - sequence_item value: %10h ",curr_trans.rand_48_bits);
        enc_packet = enc(curr_trans.rand_48_bits);
        display_complex(enc_packet);
        // encbits_func(1'b1);
    endtask : encode_freq

    // Send packet to ifft
    task drive_ifft(sequence_item item);
        $display("*********Encoder - send sequence_item to IFFT");
        encode_to_ifft_port.write(item);
    endtask : drive_ifft

    function complex_t enc(reg[47:0] itm);
        complex_t res[128];
        shortreal amp[4] = '{0.0,0.333,0.666,1.0};
        $display("%f , %f , %f , %f",amp[0],amp[1],amp[2],amp[3]);
        initial begin
            for (int i = 0; i < 128; i++) begin
                res[i].real_part = 0.0;
                res[i].imag_part = 0.0;
            end
        end
        return res;
    endfunction

    function void display_complex(complex_t a);
        $display("Real %f - Imagine %f", a.real_part, a.imag_part);
	endfunction : display_complex

endclass : encode