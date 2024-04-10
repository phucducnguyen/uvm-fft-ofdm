// Environment

class ifft_env extends uvm_env;
    `uvm_component_utils(env)
    function new(string name = "ifft_env", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction //new()
endclass : ifft_env