// Sequencer

class ifft_seqr extends uvm_sequencer #(seq_item);
    `uvm_component_utils(seqr)
    function new(string name = "ifft_seqr", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction //new()
endclass : ifft_seqr