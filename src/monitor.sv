class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

	//instantiate interface, sequence item, analysis port
	uvm_analysis_port #(sequence_item) monitor_port;
	virtual dut_interface intf;
	sequence_item seq_itm;

	function new (string name = "monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor_port = new("monitor_port", this);

		if (!uvm_config_db#(virtual dut_interface)::get(this, "*", "my_interface", intf))
		begin
				`uvm_fatal("MONITOR", "Could not get virtual interface")
		end
	endfunction

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("MONITOR","RUN PHASE", UVM_MEDIUM);
		// seq_itm = sequence_item::type_id::create("seq_itm",this);
	
		// forever begin // :Forever
		// 	// use fork - join end?
		// end
	
	endtask

endclass : 
monitor