`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_monitor extends uvm_monitor;

`uvm_component_utils(fifo_monitor)

virtual fifo_if vif;
uvm_analysis_port #(fifo_txn) monitor_p;

function new(string name = "fifo_monitor", uvm_component parent);
    super.new(name, parent);
    monitor_p = new("monitor_p", this);
endfunction

function build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))begin
        `uvm_fatal("NO_VIF", "Virtual interface not received in monitor");
    end
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fifo_txn txn;
    forever begin
        @(posedge vif.clk);
        if(vif.w_enable || (vif.r_enable && vif.valid && vif.downstream_ready)) begin
            txn = fifo_txn::type_id::create("txn");
            txn.processed_data = vif.processed_data;
            txn.head_idx = vif.head_idx;
            txn.tail_idx = vif.tail_idx;
            txn.valid = vif.valid;
            monitor_p.write(txn);
            `uvm_info(get_type_name(), $sformatf("Monitor observed processed_data = %08b, head_idx = %02b, tail_idx = %02b, valid = %0b",
            txn.processed_data, txn.head_idx, txn.tail_idx, txn.valid),UVM_LOW)
        end
    end
endtask

endclass