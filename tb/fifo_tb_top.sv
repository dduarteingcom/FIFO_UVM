`include "uvm_macros.svh"
import uvm_pkh::*;

module fifo_tb_top;

    //Parameters
    localparam int WIDTH = 8;
    localparam int DEPTH = 4;

    //Interface instance
    fifo_if #(WIDTH, DEPTH) if();

    //DUT instation
    FIFO dut(
        .clk(if.clk),
        .rst_n(if.rst_n),
        .w_data(if.w_data),
        .w_enable(if.w_enable),
        .r_enable(if.r_enable),
        .downstream_ready(if.downstream_ready),
        .key(if.key),
        .processed_data(if.processed_data),
        .head_idx(if.head_idx),
        .tail_idx(if.tail_idx),
        .valid(if.valid)
    );

    //Clock generation;
    initial if.clk = 0;
    always #5 if.clk = ~if.clk;

    //Reset
    initial begin
        if.rst_n = 0;
        #20; 
        if.rst_n = 1;
    end
    //Start UVM
    initial begin
        uvm_config_db#(virtual fifo_if)::set(null, "*", "vif", if);
        run_test("fifo_test");
    end
    
endmodule