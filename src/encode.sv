// Encode class - Scoreboard
// take 48 bits and covert to 24 tones (24 frequency levels)
// send to IFFT

class encode extends uvm_scoreboard;
    `uvm_component_utils(encode) // uvm_macro

    `uvm_analysis_imp_decl (_in)
    `uvm_analysis_imp_decl (_ref)

    uvm_analysis_imp_in #(sequence_item, encode) in_port;
    uvm_analysis_imp_ref #(sequence_item, encode) out_port;

    sequence_item seq_itm;
    sequence_item seq_itm_in;
    sequence_item seq_itm_out;

    sequence_item queue_in [$];
    sequence_item queue_out [$];

    virtual dut_interface intf;
    bit [7:0] error_flag;  

    function new(string name="encode",uvm_component parent=null); //create constructor
        super.new(name,parent);
        in_port =  new("in_port building",this);
        out_port =  new("out_port building",this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("ENCODE","BUILD PHASE",UVM_MEDIUM);
        // seq_itm = sequence_item::type_id::create("seq_itm",this);
        // seq_itm_in = sequence_item::type_id::create("seq_itm_in",this);
        // seq_itm_out = sequence_item::type_id::create("seq_itm_out",this);

        // error_flag = 8'd0;

        // if (!uvm_config_db#(virtual dut_interface)::get(this, "*", "my_interface", intf))
        // begin
        //     `uvm_fatal("ENCODE", "Could not get virtual interface")
        // end
    endfunction : build_phase

    virtual function void write_in(sequence_item seq_itm);
        queue_in.push_back(seq_itm);
    endfunction: write_in

    virtual function void write_ref(sequence_item seq_itm);
        queue_out.push_back(seq_itm);
    endfunction: write_ref

    task run_phase(uvm_phase phase); 
        forever begin
        @(posedge intf.Clk)
            wait(queue_in.size != 0 && queue_out.size != 0)
            begin
                seq_itm_in = queue_in.pop_front();
                seq_itm_out = queue_out.pop_front();
            end
        end
    endtask : run_phase
endclass : encode