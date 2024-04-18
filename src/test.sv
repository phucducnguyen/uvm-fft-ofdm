// Test class

class test extends uvm_test;
    `uvm_component_utils(test)
    function new(string name = "test", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction : build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction : end_of_elaboration_phase

    task run_phase(uvm_phase phase);
        `uvm_info("test", "message is sent in the test class", UVM_MEDIUM);
        
    endtask
endclass : test