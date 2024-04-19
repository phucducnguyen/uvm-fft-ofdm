// Sequencer

class sequencer extends uvm_sequencer #(sequence_item);
    `uvm_component_utils(sequencer)
    function new(string name = "sequencer", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : sequencer