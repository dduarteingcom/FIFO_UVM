class fifo_txn  extends uvm_sequence_item;

    rand logic write;
    rand logic read;
    rand logic [WIDTH-1:0] data;

    `uvm_object_utils(fifo_txn)

    function  new(string name = "fifo_txn");
        super.new(name);
    endfunction

endclass //className extends superClass