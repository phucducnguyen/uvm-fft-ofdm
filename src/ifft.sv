// IFFT class - Scoreboard
// send back to driver

class ifft extends uvm_scoreboard;
    `uvm_component_utils(ifft) // uvm_macro

    // Ports //
	uvm_analysis_port #(sequence_item) ifft_to_drv_port;
    uvm_analysis_imp #(sequence_item, ifft) ifft_imp;

    sequence_item transactions[$];

    function new(string name="ifft",uvm_component parent=null); //create constructor
        super.new(name,parent);
        ifft_imp = new("ifft_imp", this);
        ifft_to_drv_port = new("ifft_to_drv_port", this);
    endfunction : new

    function void build_phase(uvm_phase phase);     //build phase
        `uvm_info("IFFT","BUILD PHASE",UVM_MEDIUM);
        
    endfunction : build_phase

    // take sequence item and put into a fifo
    function void write(sequence_item item);
		$display("*********IFFT/Task write - Push Item to FIFO: %10h ",item.rand_48_bits);
	    transactions.push_back(item);
	endfunction: write 

    task run_phase(uvm_phase phase); 
        `uvm_info("IFFT","RUN PHASE", UVM_LOW);
        forever begin
            sequence_item curr_trans;
            wait((transactions.size() != 0));
            curr_trans = transactions.pop_front();
            ifft_freq(curr_trans);
			#10
            drive_drv(curr_trans);
        end
    endtask : run_phase

    // where the ifft happens
    // change to frequency domain
    task ifft_freq(sequence_item item);
        $display("*********IFFT/Task ifft_freq - sequence_item value: %10h ",item.rand_48_bits);
    endtask : ifft_freq

	// Send packet to back to driver
    task drive_drv(sequence_item item);
        $display("*********IFFT/Task drive_drv - send sequence_item back to driver: %10h ",item.rand_48_bits);
        ifft_to_drv_port.write(item);
    endtask : drive_drv

endclass : ifft