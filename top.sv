`timescale 1ns/10ps

package IFFT;
    import uvm_pkg::*;
    let max(a,b) = (a > b) ? a : b;
    let abs(a) = (a*a);
    `include "src/complex_class.sv"
    `include "src/factory.sv"
    `include "src/util.sv"
    `include "src/sequence_item.sv" 
    `include "src/sequences.sv"
    `include "src/sequencer.sv"
    `include "src/driver.sv"
    `include "src/encode_ifft.sv"
    `include "src/fft_decode.sv"
    `include "src/DUT_monitor.sv"
    `include "src/compare_sb.sv"
    `include "src/test.sv"
endpackage : IFFT

`include "src/interface.sv"
// `include "dut.svp"

module top();
    import uvm_pkg::*;
    import IFFT::*;
    
    reg clk,rst;
    dut_interface dut_if(.clk(clk),.rst(rst));
    
    ofdmdec dut(.Clk(dut_if.clk), .Reset(dut_if.rst), .Pushin(dut_if.Pushin), .FirstData(dut_if.FirstData),
               .DinR(dut_if.DinR), .DinI(dut_if.DinI),
               .PushOut(dut_if.PushOut), .DataOut(dut_if.DataOut));
    
    initial begin
        uvm_config_db #(virtual dut_interface)::set(null, "*", "dut_interface" , dut_if);
        run_test("test");
    end
    
    initial begin
        rst = 1;
        clk = 0;
        #1;
        rst = 0;
        #1;
        repeat(1000000000) begin
            #1 clk=1;
            #1 clk=0;
        end
        $display("\n\n\nRan out of clocks\n\n\n");
        $finish;
    end

    // initial begin
    //     $dumpfile("dump.vcd");
    //     $dumpvars();
    // end

endmodule