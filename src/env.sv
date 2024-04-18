// Environment

class env extends uvm_env;
    `uvm_component_utils(env)
    function new(string name = "env", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : env