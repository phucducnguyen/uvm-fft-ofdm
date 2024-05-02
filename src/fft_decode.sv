// FFT - Decode class - Scoreboard
// take 128 fixed-point complex number from DRIVER and covert to 48 bits
// send to COMPARE scoreboard

class fft_decode extends uvm_scoreboard;
    `uvm_component_utils(fft_decode) // uvm_macro

    // Ports //
    uvm_tlm_analysis_fifo #(complex_t) fftdec_analysis_fifo;
    uvm_analysis_port #(reg[47:0]) fft_dec_port;

    complex_t transactions;
    complex_t fft_value[127:0];
    reg[47:0] rdata;

    function new(string name="fft_decode",uvm_component parent=null); //create constructor
        super.new(name,parent);
        fftdec_analysis_fifo = new("fftdec_analysis_fifo", this);
        fft_dec_port = new("fft_dec_port",this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("FFT_DECODE","BUILD PHASE",UVM_MEDIUM);
    endfunction : build_phase
    
    task run_phase(uvm_phase phase);
        forever begin
            for(int i=0; i<128; i++) begin
                fft_value[i] = new();
            end
            for(int i=0; i<128; i++) begin
                fftdec_analysis_fifo.get(transactions);
                fft_value[i].equal(transactions);
                // transactions.display();
            end
            ifft_fft(fft_value,1'b1);
            decode(fft_value);
            // $display("FFT-DECODE value: %h",rdata);
            fft_dec_port.write(rdata);
        end

    endtask : run_phase

    // """Encodes 48 bits to frequency amounts""" //
    function void decode(complex_t spectrum[127:0]);
        floating_point full_scale;
        floating_point temp1 = 0.0;
        floating_point fsq;
        reg[47:0] bv;

        floating_point decision_points[3]; //= floating_point'{0.166666*full_scale, (0.166666+0.333333)*full_scale, (0.166666+0.666666)*full_scale};
        full_scale = max(spectrum[55].absolute(),spectrum[57].absolute());
        // $display(full_scale);
        for (int i = 0; i < 3; i ++) begin
            temp1 = floating_point'(i) * 0.333333;
            // $display(temp1);
            decision_points[i] = abs( (0.166666+temp1) * floating_point'(full_scale) );
            // decision_points[i] = abs( decision_points[i] );
            // $display(decision_points[i]);
        end       
        rdata = 0;
        for (int x = 4; x < 52; x += 2) begin
            fsq = spectrum[x].absolute();
            bv=3;
            for(int dx = 0; dx < 3; dx ++)begin
                if (fsq < decision_points[dx]) begin
                    bv = dx;
                    break;
                end
            end
            bv = bv << (x-4);
            // $display(bv);
            rdata = rdata|bv;
        end
        // $display(rdata);
    endfunction : decode
    
endclass : fft_decode