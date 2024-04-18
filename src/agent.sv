class main_agent extends uvm_agent;
        `uvm_component_utils(main_agent)

        function new (string name, uvm_component parent=null);
                super.new(name, parent);
        endfunction

        // create analysis port
        uvm_analysis_port #(sequence_item) main_agent_port;
		
        //Instantiate driver, sequencer, monitor
        my_driver drv;
        my_sequencer sqr;
        my_monitor mon;

        // function void build_phase (uvm_phase phase);
        //         drv = driver::type_id::create("DRIVER",this);
        //         sqr = sequencer::type_id::create("SEQUENCER",this);
        //         ifft_agent_port = new("ifft_agent_port",this);
        // endfunction

        // function void connect_phase(uvm_phase phase); //connect driver to sequencer
        //         drv.seq_item_port.connect(sqr.seq_item_export);
        // endfunction

endclass : main_agent