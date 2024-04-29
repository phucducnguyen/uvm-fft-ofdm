// Sequence class

class sequences extends uvm_sequence #(sequence_item);
    
    sequence_item seq_itm;
    task body();
        // $display("In sequences 1");
        seq_itm = new();
        repeat(1) begin // send 10 random sequence_item then stop
            start_item(seq_itm); // Start the item
            seq_itm.randomize();            
            finish_item(seq_itm); // Finish the item
        end
    endtask : body
endclass : sequences