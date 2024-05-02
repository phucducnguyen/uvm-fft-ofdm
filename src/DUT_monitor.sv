// Compare Class
// This Class will receive data output from DUT and from Reference model
// Compare if they are equal

class DUT_monitor extends uvm_monitor;
    `uvm_component_utils(DUT_monitor) // uvm_macro

    virtual dut_interface dut_if;
	uvm_analysis_port #(reg[47:0]) DUT_monitor_port;
    uvm_analysis_port #(reg) out_put_available;
    // uvm_tlm_analysis_fifo #(reg[47:0]) from_REF;
    reg[47:0] value_REF;
    reg[47:0] value_DUT;

	function new(string name="DUT_monitor",uvm_component parent=null); //create constructor
        super.new(name,parent);
        DUT_monitor_port = new("DUT_monitor_port", this);
        out_put_available = new("out_put_available", this);
        // from_REF = new("from_REF",this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("COMPARE","BUILD PHASE",UVM_MEDIUM);
        if (!uvm_config_db #(virtual dut_interface)::get(this, "", "dut_interface" , dut_if))
			`uvm_fatal("TEST", "Could not get vitual interface")

    endfunction : build_phase

    task run_phase(uvm_phase phase);
        // super.run_phase(phase);

        // phase.raise_objection(this);
        // wait(!dut_if.rst) begin
        //     if(dut_if.PushOut == 1)begin
        //         value_DUT = dut_if.DataOut;
        //         $display("DUT-MONITOR value: %h",value_DUT);
        //     end
        // end
        // phase.drop_objection(this);

        // phase.raise_objection(this);
        forever begin
            // phase.raise_objection(this);
            // $display(dut_if.Pushin);
            // $display(dut_if.FirstData);
            // from_REF.get(value_REF);
            // $display("This is value from REF: %h",value_REF);
            // @(posedge dut_if.clk);
            // from_DUT.get(dut_if.DataOut);
            // receive_interface();
            // value_DUT =0;
            @(posedge dut_if.clk)#1;
            if (dut_if.PushOut == 1) begin
                value_DUT = dut_if.DataOut;
                // $display("DUT-MONITOR value: %h",value_DUT);
                DUT_monitor_port.write(value_DUT);
                out_put_available.write(1'b1);
            end
        end

    endtask : run_phase
endclass