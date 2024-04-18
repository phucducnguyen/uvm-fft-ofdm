// Sequencer

class seqr extends uvm_sequencer #(seq_item);
    `uvm_component_utils(seqr)
    function new(string name = "seqr", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : seqr