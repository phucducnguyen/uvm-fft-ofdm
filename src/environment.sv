// Environment

class environment extends uvm_env;
    `uvm_component_utils(environment)
    function new(string name = "environment ", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : environment 