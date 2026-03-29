`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_test extends uvm_test;
    fifo_env env_h;
    fifo_sequence seq_h;

    `uvm_component_utils(fifo_test)

    function new(string name = "fifo_test", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_type_override_by_type(fifo_driver::get_type(), fifo_driver2::get_type());

        uvm_factory::get.print();

        env_h = fifo_env::type_id::create("env_h", this);
        seq_h = fifo_sequence::type_id::create("seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        seq_h.start(env_h.agnt.sqr_h);
        phase.drop_objection(this);
    endtask
endclass