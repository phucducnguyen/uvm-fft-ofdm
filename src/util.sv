    typedef struct {
        reg signed [15:0] real_part;
        reg signed [15:0] imag_part;
    } complex_t;

    /// complex conjugate
    // module conj(input complex_t in, output complex_t out);
    // 	out.real_part = in.real_part;
    // 	out.imag_part = -in.imag_part; 
    // endmodule

    function int encbits_func(input int in48);
        int out128;
        out128 = in48 + 4;
        return out128;
    endfunction : encbits_func

    /// encode bits
    // module encbits(
    //     input wire [47:0] in48,
    //     output wire [127:0] out128
    //     );
    //     reg [3:0] fbin = 'd4;
        // always_comb begin
        //     for (int i = 0; i < 52; i++) begin
        //         if ((i >= 4 && i <= 52) && (i != 55 && i != 57)) begin
        //             // Compute amplitude based on input data
        //             if (i % 2 == 0) begin
        //                 // Even bins represent 2 bits of data
        //                 amplitude[i] = {data_2_bits(real_in), data_2_bits(imag_in)};
        //             end else begin
        //                 // Odd bins are left unchanged
        //                 amplitude[i] = 2'b00;
        //             end
        //         end else begin
        //             // Fixed tones are either present or not
        //             amplitude[i] = fixed_tone_amplitude;
        //         end
        //     end
        // end

    // endmodule

    // module fft_and_slicing_block (
    //     input signed [15:0] real_in,       // Real part of input
    //     input signed [15:0] imag_in,       // Imaginary part of input
    //     output logic [1:0] slice_output    // Output representing 2 bits per frequency bin
    // );

    //     // Internal variables
    //     logic signed [15:0] fft_real [0:127];
    //     logic signed [15:0] fft_imag [0:127];
    //     logic [1:0] amplitude [0:51];
    //     logic [1:0] fixed_tone_amplitude;

    //     // FFT computation
    //     // (This is a simplified example and does not include actual FFT implementation)
    //     // You would need to replace this with your actual FFT implementation
    //     // This just copies the input to output for demonstration purposes
    //     assign fft_real[0] = real_in;
    //     assign fft_imag[0] = imag_in;

    //     // Slicing logic
    //     always_comb begin
    //         for (int i = 0; i < 52; i++) begin
    //             if ((i >= 4 && i <= 52) && (i != 55 && i != 57)) begin
    //                 // Compute amplitude based on input data
    //                 if (i % 2 == 0) begin
    //                     // Even bins represent 2 bits of data
    //                     amplitude[i] = {data_2_bits(real_in), data_2_bits(imag_in)};
    //                 end else begin
    //                     // Odd bins are left unchanged
    //                     amplitude[i] = 2'b00;
    //                 end
    //             end else begin
    //                 // Fixed tones are either present or not
    //                 amplitude[i] = fixed_tone_amplitude;
    //             end
    //         end
    //     end

    //     // Output fixed tone amplitude based on conditions
    //     always_comb begin
    //         if (fixed_tone_condition_met) begin
    //             fixed_tone_amplitude = 2'b11; // 100% amplitude
    //         end else begin
    //             fixed_tone_amplitude = 2'b00; // 0% amplitude
    //         end
    //     end

    //     // Function to encode 2 bits of data
    //     function logic [1:0] data_2_bits;
    //         input signed [15:0] data;
    //         begin
    //             // Encode the data based on the given encoding scheme
    //             // Example implementation: 00=0%, 01=33%, 10=66%, 11=100%
    //             if (data > threshold_1) begin
    //                 return 2'b11;
    //             end else if (data > threshold_2) begin
    //                 return 2'b10;
    //             end else if (data > threshold_3) begin
    //                 return 2'b01;
    //             end else begin
    //                 return 2'b00;
    //             end
    //         end
    //     endfunction

    // endmoduless