// Sequence class

class sequences extends uvm_sequence #(sequence_item);

    virtual task body();
        // seq_item seq_itm;

        // // Generate sequence items
        // for (int i = 0; i < 10; i++) begin
        //     `uvm_info("seq", "message is sent in the seq class", UVM_MEDIUM);
        //     // seq_itm = seq_item::type_id::create("seq_itm");
        //     seq_itm = new();
        //     start_item(seq_itm); // Start the item

        //     seq_itm.randomize(); // Randomize the data field
        //     `uvm_info(get_type_name(), $sformatf("Sequence item %0d generated", i), UVM_LOW)
        //     seq_itm.randomize(); // Randomize the data field
        //     `uvm_info(get_type_name(), $sformatf("Sequence item %0d generated", i), UVM_LOW)
            
        //     finish_item(seq_itm); // Finish the item
        // end
    endtask
endclass : sequences