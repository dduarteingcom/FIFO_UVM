class fifo_sequence extends uvm_sequence#(fifo_txn);
    fifo_txn req;

    `uvm_object_utils(fifo_sequence);

    function new(string name = "fifo_sequence");
        super.new(name);
    endfunction

    task body();
        for(int i = 0; i < 10; i++)begin
            $display("Iteration %0d", i);
            req = fifo_txn::type_id::create("req");
            `uvm_info(get_type_name(), "Sequence item created", UVM_LOW);
            assert(req.randomize());

            wait_for_grant();

            send_request(req);

            `uvm_info(get_type_name(), "Waiting for item_done", UVM_LOW);

            wait_for_item_done();
        end
    endtask
endclass