// Sequence_item class

class sequence_item extends uvm_sequence_item;

    // rand reg[47:0] rand_48_bits; // 48-bit data for IFFT
    reg[47:0] rand_48_bits = 48'hE23456789F1B; // 48-bit data for IFFT
    // reg[47:0] rand_48_bits = 48'h000000000000; // 48-bit data for IFFT
    // reg[47:0] rand_48_bits = 48'h555555555555; // 48-bit data for IFFT
    // reg[47:0] rand_48_bits = 48'haaaaaaaaaaaa; // 48-bit data for IFFT
    // reg[47:0] rand_48_bits = 48'hffffffffffff; // 48-bit data for IFFT

    // tcase(0xE23456789F1B)
    // tcase(0x000000000000)
    // tcase(0x555555555555)
    // tcase(0xaaaaaaaaaaaa)
    // tcase(0xffffffffffff)

endclass : sequence_item