
// Display complex_t array - fix at length 128
function void display_complex_128(complex_t value[127:0]);
    for (int i = 0; i < 128; i++) begin
        value[i].display();
    end
endfunction : display_complex_128

// """Make a bit reversed copy of the input vector.
// Used by both the FFT and IFFT (DIT type code)"""
function void bit_reverse(complex_t in_complex[127:0], complex_t out_complex[127:0]);
    // complex_t out_complex[127:0];
    int ix, qq, wx, rx;
    // for (int ix = 0; ix < 128; ix++) begin
    //     $display("******************INSIDE BIT REVERSE");
    //     in_complex[ix].display();
    //     out_complex[ix].display();
    // end
    for (ix = 0; ix < 128; ix++) begin
        wx = ix;
        rx = 0;
        for (qq = 0; qq < 7; qq++) begin
            rx <<= 1;
            // $display("******************INSIDE BIT REVERSE - rx: %p", rx);
            if (wx & 1 != 0) begin
                rx |= 1;
                // $display("******************INSIDE BIT REVERSE - INSIDE IF LOOP - rx: %p", rx);
            end
            wx >>= 1;
        end
        out_complex[ix].equal(in_complex[rx]);
        // $display("******************INSIDE BIT REVERSE - rx: %p", rx);
        // $display("******************INSIDE BIT REVERSE - ix: %p", ix);
        // $display("******************INSIDE BIT REVERSE - in_complex[rx]: %p", in_complex[rx]);
        // $display("******************INSIDE BIT REVERSE - out_complex[ix]: %p", out_complex[ix]);
    end
endfunction



// apply IFFT or FFT base on the control bit
// check = 0 => IFFT
// check = 1 => FFT
function void ifft_fft(complex_t data[127:0], reg check = 1'b0);
    complex_t wk[127:0];
    complex_t t,v,a,b;
    int spread;
    int i, j, bs, twix, i1, i2;
    for (int i = 0; i < 128; i++) begin
        wk[i] = new();
    end
    t = new();
    v = new();
    a = new(); 
    b = new();
    
    bit_reverse(data, wk);

    // $display("*********ENDOCDER - AFTER");
    // display_complex_128(wk);
    
    // $display("******************INSIDE mjifft");
    // display_complex_128(data);
    spread = 2;
    for (i=0; i<7; i++) begin
        bs =0;
        while (bs<128) begin
            for(j = bs; j<(bs + spread/2) ;j++) begin
                twix = int '((j % spread)*(128/spread));
                i1 = j;
                i2 = j + spread / 2;
                if(check == 1'b0) begin
                    ifftwiddle_complex(twix, t);
                    // $display(bs);
                    // $display(spread);
                    // $display(i2);
                end
                else begin
                    fftwiddle_complex(twix, t);
                    // $display(j);
                    // $display(bs);
                    // $display(i1);
                    // $display(spread);
                    // $display(i2);
                    // wk[i2].display();
                end
                
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

    for (int i = 0; i < 128; i++) begin
        // Divide 128 - IFFT
        if(check == 1'b0) begin
            data[i].divide_const(wk[i],128.0);
            data[i].equal_imag(0.0);
            // out_complex[ix].equal(in_complex[rx])
            // wk[i].display();
        end
        // FFT
        else begin
            data[i].equal(wk[i]);
        end
    end
endfunction : ifft_fft