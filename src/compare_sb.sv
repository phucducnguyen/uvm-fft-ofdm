// Compare Class
// This Class will receive data output from DUT and from Reference model
// Compare if they are equal

class compare_sb extends uvm_scoreboard;
    `uvm_component_utils(compare_sb) // uvm_macro

    virtual dut_interface dut_if;
	uvm_tlm_analysis_fifo #(reg[47:0]) from_DUT;
    uvm_tlm_analysis_fifo #(reg[47:0]) from_REF;
    reg[47:0] value_REF;
    reg[47:0] value_DUT;

	function new(string name="compare",uvm_component parent=null); //create constructor
        super.new(name,parent);
        from_DUT = new("from_DUT", this);
        from_REF = new("from_REF", this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("COMPARE","BUILD PHASE",UVM_MEDIUM);
        if (!uvm_config_db #(virtual dut_interface)::get(this, "", "dut_interface" , dut_if))
			`uvm_fatal("TEST", "Could not get vitual interface")

    endfunction : build_phase

    task run_phase(uvm_phase phase);
        // super.run_phase(phase);        
        // phase.raise_objection(this);
        forever begin
            from_REF.get(value_REF);
            // $display("This is value from REF: %h",value_REF);
            from_DUT.get(value_DUT);
            // $display("This is value from DUT: %h",value_DUT);
            if(value_REF != value_DUT) begin
                `uvm_error("COMPARE_ERrOR", $sformatf("Ref value %h != %h DUT value",  value_REF, value_DUT));
            end 
            // else begin
            //     `uvm_info("COMPARE", "SAME", UVM_LOW)
            // end
        end
        // phase.drop_objection(this);

    endtask : run_phase

endclass