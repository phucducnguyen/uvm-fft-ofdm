`timescale 1ns/10ps

`include "ifft_intf.sv"

package IFFT;
import uvm_pkg::*;
`include "ifft_seq_item.sv"
`include "ifft_seq.sv"
`include "ifft_driver.sv"
`include "ifft_env.sv"
`include "ifft_test.sv"
endpackage : IFFT

module top();
    import IFFT::*;
    intf ifft_intf();
endmodule