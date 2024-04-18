// Driver

class driver extends uvm_driver #(sequence_item);
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parrent = null);
        super.new(name,parrent);        
    endfunction

    sequence_item seq_itm;
    virtual dut_interface dut_if;

    function void build_phase(uvm_phase phase);
        super.build_phase (phase);
        `uvm_info("DRIVER", "BUILD PHASE", UVM_MEDIUM) 
        if (!uvm_config_db#(virtual dut_interface)::get(this, "*", "my_interface", dut_if))
        begin
            `uvm_fatal("DRIVER", "Could not get virtual interface") 
        end
    endfunction : build_phase

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRIVER","RUN PHASE", UVM_MEDIUM);
        /*
        reg Pushin;
        reg FirstData;
        reg signed [16:0] DinR;
        reg signed [16:0] DinI;
        reg PushOut;
        reg [47:0] DataOut;
        */
        forever begin
            seq_item_port.get_next_item(seq_itm);
            #20 dut_if.Pushin = 0;
            #20 dut_if.FirstData  = 1;
            #20 dut_if.DinR = 17'b0;
            #20 dut_if.DinI = 17'b0;
            seq_item_port.item_done();
        end
    endtask : run_phase
endclass : driver