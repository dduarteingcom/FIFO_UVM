class fifo_driver extends uvm_driver #(fifo_txn);
    `uvm_component_utils(fifo_driver);

    virtual fifo_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        
    endfunction

endclass