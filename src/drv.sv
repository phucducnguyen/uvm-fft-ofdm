// Driver

class drv extends uvm_driver #(seq_item);
    `uvm_component_utils(drv)
    function new(string name = "drv", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : drv