//
// This is the DUT interface
//
interface dut_interface(input Clk, input Reset);
    reg Pushin;
    reg FirstData;
    reg signed [16:0] DinR;
    reg signed [16:0] DinI;
    reg PushOut;
    reg [47:0] DataOut;

    modport in_dut(input Clk, input Reset,
                input Pushin, input FirstData,
                input DinR, input DinI,
                output PushOut, output DataOut);


endinterface : dut_interface