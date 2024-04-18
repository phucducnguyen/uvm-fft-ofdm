`timescale 1ns/10ps

//`include "src/intf.sv"

package IFFT;
    import uvm_pkg::*;
    `include "src/seq_item.sv" 
    `include "src/seq.sv"
    `include "src/drv.sv"
    `include "src/env.sv"
    `include "src/test.sv"
endpackage : IFFT

module top();
    import uvm_pkg::*;
    import IFFT::*;
    // intf intf();
    initial begin
        run_test("test");
    end
    // initial begin
    //     $dumpfile("dump.vcd");
    //     $dumpvars();
    // end
endmodule