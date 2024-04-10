// Driver

class ifft__driver extends uvm_driver;
    `uvm_component_utils(ifft__driver)
    function new(string name = "ifft__driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction //new()
endclass : ifft__driver