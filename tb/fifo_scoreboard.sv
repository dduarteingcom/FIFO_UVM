`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fifo_scoreboard)

    int total_transactions;
    int pass_count;
    int fail_count;

    uvm_analysis_imp #(fifo_txn, fifo_scoreboard) sb_imp;

    function new(string name = "fifo_scoreboard", uvm_component parent);
        super.new(name, parent);
        sb_imp = new("sb_imp", this);
    endfunction

    function void write(fifo_txn txn);
        total_transactions++;
        `uvm_info(get_type_name(),
            $sformatf("Scoreboard received txn: processed_data=%0h head_idx=%0d tail_idx=%0d valid=%0b",
                      txn.processed_data, txn.head_idx, txn.tail_idx, txn.valid),
            UVM_LOW)
    endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info(get_type_name(), $sformatf("Total Transactions: %0d", total_transactions), UVM_LOW)
        // `uvm_info(get_type_name(), $sformatf("Pass Count: %0d", pass_count), UVM_LOW)
        // `uvm_info(get_type_name(), $sformatf("Fail Count: %0d", fail_count), UVM_LOW)
    endfunction

endclass