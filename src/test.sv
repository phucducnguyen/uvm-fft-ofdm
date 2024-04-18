// Test class

class test extends uvm_test;
    `uvm_component_utils(test)
    function new(string name = "test", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : test