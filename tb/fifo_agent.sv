`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_agent extends uvm_agent;
    fifo_sequencer sqr_h;
    fifo_driver drv_h;

    `uvm_component_utils(fifo_agent)

    function new(string name = "fifo_agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sqr_h = fifo_sequencer::type_id::create("sqr_h", this);
        drv_h = fifo_driver::type_id::create("drv_h", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        drv_h.seq_item_port.connect(sqr_h.seq_item_export);
    endfunction
endclass