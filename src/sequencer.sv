// Sequencer

class sequencer extends uvm_sequencer #(sequence_item);
    //`uvm_component_utils(sequencer)
    function new(string name = "sequencer", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    function void build_phase(uvm_phase phase);
        `uvm_info("sequencer","BUILD PHASE",UVM_MEDIUM);
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        `uvm_info("sequencer","packet sent",UVM_MEDIUM);
    endtask : run_phase
endclass : sequencer