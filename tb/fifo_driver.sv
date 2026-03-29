`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_driver extends uvm_driver #(fifo_txn);

    `uvm_component_utils(fifo_driver);

    virtual fifo_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    fifo_txn req;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))begin
            uvm_fatal(get_type_name(), "Virtual interface not set");
        end
    endfunction

    task run_phase(uvm_phase phase);
        vif.w_enable = 0;
        vif.r_enable = 0;
        while(!vif.rst_n) @(posedge vif.clk);

        forever begin
            seq_item_port.get_next_item(req);
           
            @(negedge vif.clk);
            vif.w_enable = req.write;
            vif.r_enable = req.read;
            vif.w_data = req.data;
            vif.downstream_ready = 1;

            @(posedge vif.clk);
            `uvm_info(get_type_name(), "Transaction completed at DUT boundary", UVM_LOW);
            seq_item_port.item_done();

            @(negedge vif.clk);
            vif.w_enable = 0;
            vif.r_enable = 0;
        end
    endtask

endclass