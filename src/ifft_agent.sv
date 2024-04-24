// IFFT agent
// take 48 bits and covert to 24 tones (24 frequency levels)
class ifft_agent extends uvm_agent;
        `uvm_component_utils(ifft_agent)

        function new (string name, uvm_component parent=null);
                super.new(name, parent);
        endfunction

        encode enc;
        ifft ifft_main;

        // // create analysis port
        uvm_analysis_export #(sequence_item) ifft_agent_export; // connect driver port with encoder imp
        uvm_analysis_port #(sequence_item) ifft_agent_port; // connect ifft port with driver imp
        // uvm_analysis_port #(sequence_item) ifft_agent_port;


        function void build_phase (uvm_phase phase);
                enc = encode::type_id::create("enc",this);
                ifft_main = ifft::type_id::create("ifft_main",this);
                ifft_agent_export = new("ifft_agent_export",this);
                ifft_agent_port = new("ifft_agent_port",this);
        endfunction

        function void connect_phase(uvm_phase phase);
                `uvm_info("ifft_agent","Connect PHASE", UVM_LOW);
                ifft_agent_export.connect(enc.enc_imp);
                enc.encode_to_ifft_port.connect(ifft_main.ifft_imp);
                ifft_main.ifft_to_drv_port.connect(this.ifft_agent_port);
        endfunction

endclass : ifft_agent