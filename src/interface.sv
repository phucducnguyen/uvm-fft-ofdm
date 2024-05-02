//
// This is the DUT interface
//
interface dut_interface(input logic clk, input logic rst);
    reg Pushin;
    reg FirstData;
    reg signed [16:0] DinR;
    reg signed [16:0] DinI;
    reg PushOut;
    reg [47:0] DataOut;


endinterface : dut_interface