// Test class

class ifft_test extends uvm_test;
    `uvm_component_utils(ifft_test)
    function new(string name = "ifft_test", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction //new()
endclass : ifft_test