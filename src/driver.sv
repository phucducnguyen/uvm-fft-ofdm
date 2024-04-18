// Driver

class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction
endclass : driver