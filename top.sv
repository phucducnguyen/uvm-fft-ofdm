`timescale 1ns/10ps
`include "src/interface.sv"
`include "dut.svp"
package IFFT;
    import uvm_pkg::*;
    `include "src/sequence_item.sv" 
    `include "src/sequences.sv"
    `include "src/sequencer.sv"
    `include "src/driver.sv"
    // `include "src/ifft_agent.sv"
    `include "src/encode.sv"
    `include "src/environment.sv"
    `include "src/test.sv"
endpackage : IFFT

module top();
    import uvm_pkg::*;
    import IFFT::*;
    
    reg clk,rst;
    dut_interface dut_if(clk,rst);
    
    initial begin
        clk=0;
        rst=1;
        #15;
        rst = 0;
        repeat(1000000) begin
            #5 clk=1;
            #5 clk=0;
        end
        $display("\n\n\nRan out of clocks\n\n\n");
        $finish;
    end

    // initial begin
    //     $dumpfile("dump.vcd");
    //     $dumpvars();
    // end

    initial begin
        uvm_config_db #(virtual dut_interface)::set(null, "*", "dut_interface" , dut_if);
        run_test("test");
    end

    ofdmdec dut_inst(.Clk(dut_if.Clk), .Reset(dut_if.Reset),
               .Pushin(dut_if.Pushin), .FirstData(dut_if.FirstData),
               .DinR(dut_if.DinR), .DinI(dut_if.DinI),
               .PushOut(dut_if.PushOut), .DataOut(dut_if.DataOut));

endmodule