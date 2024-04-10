// Sequence class

class ifft_seq extends uvm_sequence #(ifft_seq_item);
    function new(string name = "ifft_seq", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction //new()
endclass : ifft_seq