// Encode - IFFT class - Scoreboard
// take 48 bits and covert to 24 tones (24 frequency levels)
// send to IFFT

class encode_ifft extends uvm_scoreboard;
    `uvm_component_utils(encode_ifft) // uvm_macro

    // Ports //
    uvm_analysis_port #(complex_t) encode_ifft_port;
    uvm_analysis_imp #(sequence_item, encode_ifft) enc_imp;
    // uvm_analysis_port #(sequence_item) enc_to_ifft;

    // sequence_item transactions[$];
    // complex_t enc_packet;
    sequence_item transactions;
    complex_t res[127:0];
    complex_t res_reverse[127:0];
    // bit signed [127:0] out128;
    event new_data_available;
    bit simulation_done = 0;


    function new(string name="encode",uvm_component parent=null); //create constructor
        super.new(name,parent);
        enc_imp = new("enc_imp", this);
        encode_ifft_port = new("encode_ifft_port",this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("ENCODE","BUILD PHASE",UVM_MEDIUM);
    endfunction : build_phase

    // take sequence item and put into a fifo
    function void write(sequence_item item);
	    transactions = item;
	endfunction: write 

    task run_phase(uvm_phase phase); 
        phase.raise_objection(this);
        transactions = new();   // instantiate the transaction
        `uvm_info("ENCODE","RUN PHASE", UVM_LOW);
        encode(transactions.rand_48_bits);

        // $display("*********ENDOCDER - BEFORE");
        // display_complex_128(res);

        // $display("*********ENDOCDER - AFTER");
        // display_complex_128(res_reverse);
        #10

        mjifft(res);
        // display_complex_128(res);
        for (int i = 0; i < 128; i++) begin
            send_to_driver(res[i]);
            #50;
        end
        phase.drop_objection(this);
        
    endtask : run_phase

    // Send packet to Driver
    task send_to_driver(complex_t item);
        $display("*********Encoder - SENDING complex_item to Driver");
        // item.display();
        encode_ifft_port.write(item);
    endtask : send_to_driver

    // """Encodes 48 bits to frequency amounts""" //
    function void encode(reg[47:0] itm);
        floating_point xx;
        int fbin=4;
        // floating_point amp[4] = '{0.0,0.333333333333333333,0.666666666666666666,1.0};
        floating_point amp[4] = '{0.0,0.333,0.666,1.0};
        // $display("%f , %f , %f , %f",amp[0],amp[1],amp[2],amp[3]);
        for (int i = 0; i < 128; i++) begin
            res[i] = new();                         // becasue of class
        end
        while (fbin < 52) begin
            xx = amp[itm & 3];
            // $display("%d %h %f", fbin, itm, xx);
            itm >>= 2;
            res[fbin].equal_real(xx);               // set res[fbin] = xx
            res[128 - fbin].equal_real(xx);         // set res[128 - fbin] = xx
            fbin += 2;
        end
        res[55].equal_real(1.0);
        res[128-55].equal_real(1.0);
    endfunction : encode

    // """IFFT used by the test bench""" //
    function void mjifft(complex_t data[127:0]);
        complex_t wk[127:0];
        complex_t t,v,a,b;
        int spread = 2;
        for (int i = 0; i < 128; i++) begin
            wk[i] = new();
        end
        
        bit_reverse(data, wk);

        // $display("*********ENDOCDER - AFTER");
        // display_complex_128(wk);

        // $display("******************INSIDE mjifft");
        // display_complex_128(data);

        t = new();
        v = new();
        a = new(); 
        b = new();
        for (int i=0; i<7; i++) begin
            int bs =0;
            while (bs<128) begin
                for(int j=bs; j<(bs + spread/2) ;j++) begin
                    int twix = int '((j % spread)*(128/spread));
                    int i1 = j;
                    int i2 = j + spread / 2;
                    ifftwiddle_complex(twix, t);
                    // t.display();
                    v.multiply(wk[i2], t);
                    // v.display();
                    // wk[i1].display();
                    a.add(wk[i1], v);
                    // a.display();
                    b.subtract(wk[i1], v);
                    // b.display();
                    wk[i1].equal(a);
                    wk[i2].equal(b);
                end
                bs+=spread;
            end
            spread*=2;
        end
        // Divide 128
        for (int i = 0; i < 128; i++) begin
            data[i].divide_const(wk[i],128.0);
            data[i].equal_imag(0.0);
        end
        // display_complex_128(data);
    endfunction : mjifft

    
endclass : encode_ifft