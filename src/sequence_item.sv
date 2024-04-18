// Sequence_item class

class sequence_item extends uvm_sequence_item;
    //`uvm_object_utils(seq_item)

    rand reg[7:0] rand_seq_item; // 48-bit data for IFFT

    function new(string name = "");
        super.new(name);
    endfunction

endclass : sequence_item