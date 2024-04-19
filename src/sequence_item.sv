// Sequence_item class

class sequence_item extends uvm_sequence_item;

    rand reg[7:0] rand_seq_item; // 48-bit data for IFFT

endclass : sequence_item