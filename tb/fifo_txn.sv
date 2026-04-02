`include "uvm_macros.svh"
import uvm_pkg::*;

class fifo_txn  extends uvm_sequence_item;
    localparam int WIDTH = 8;
    localparam int DEPTH = 4;
    localparam int ADDR_BITS = $clog2(DEPTH);
    
    rand logic write;
    rand logic read;
    rand logic [WIDTH-1:0] data;
    rand logic [WIDTH-1:0] key;

    logic [WIDTH-1:0] processed_data;
    logic [ADDR_BITS-1:0] head_idx;
    logic [ADDR_BITS-1:0] tail_idx;
    logic valid;

    `uvm_object_utils(fifo_txn)

    function  new(string name = "fifo_txn");
        super.new(name);
    endfunction

endclass //className extends superClass