// Driver

class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    sequence_item seq_itm;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info("DRIVER", "BUILD PHASE", UVM_MEDIUM) 
        // if (!uvm_config_db#(virtual vend_intf)::get(this, "*", "my_interface", intf))
        // begin
        //         `uvm_fatal("DRIVER", "Could not get virtual interface") 
        // end
    endfunction : build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRIVER","RUN PHASE", UVM_MEDIUM);

        forever begin
            seq_item_port.get_next_item(seq_itm);
                
            
            
            seq_item_port.item_done();
        end
    endtask : run_phase
endclass : driver