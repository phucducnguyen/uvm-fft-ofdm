// Sequence class

class sequences extends uvm_sequence #(sequence_item);

    sequence_item seq_itm;
    task body();
        repeat(100000) begin // send 5 random sequence_item then stop
            seq_itm = new();
            seq_itm.randomize();            
            // $display("%h", seq_itm.rand_48_bits);
            start_item(seq_itm); // Start the item
            finish_item(seq_itm); // Finish the item
        end
    endtask : body
endclass : sequences