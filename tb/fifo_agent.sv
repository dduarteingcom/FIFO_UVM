`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_agent extends uvm_agent;
    fifo_sequencer sqr_h;
    fifo_driver drv_h;
    fifo_monitor mtr_h;

    uvm_analysis_export#(fifo_txn) agt_ap;

    `uvm_component_utils(fifo_agent)

    function new(string name = "fifo_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sqr_h = fifo_sequencer::type_id::create("sqr_h", this);
        drv_h = fifo_driver::type_id::create("drv_h", this);
        mtr_h = fifo_monitor::type_id::create("mtr_h", this);
        agt_ap = new("agt_ap", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv_h.seq_item_port.connect(sqr_h.seq_item_export);
        mtr_h.monitor_p.connect(agt_ap);
    endfunction
endclass