`timescale 1ns/10ps

//`include "src/intf.sv"

package IFFT;
    import uvm_pkg::*;
    `include "src/sequence_item.sv" 
    `include "src/sequences.sv"
    `include "src/sequencer.sv"
    `include "src/driver.sv"
    `include "src/environment.sv"
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