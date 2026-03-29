`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_driver2 extends fifo_driver;

`uvm_component_utils(fifo_driver2)

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

task run_phase(uvm_phase phase);
    `uvm_info("DRV2", "Running fifo_driver2", UVM_LOW)
    super.run_phase(phase);
endtask

endclass