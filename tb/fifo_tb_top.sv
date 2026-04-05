`include "uvm_macros.svh"
import uvm_pkg::*;

module fifo_tb_top;

    //Parameters
    localparam int WIDTH = 8;
    localparam int DEPTH = 4;

    //Interface instance
    fifo_if #(WIDTH, DEPTH) dut_if();

    //DUT instation
    FIFO dut(
        .clk(dut_if.clk),
        .rst_n(dut_if.rst_n),
        .w_data(dut_if.w_data),
        .w_enable(dut_if.w_enable),
        .r_enable(dut_if.r_enable),
        .downstream_ready(dut_if.downstream_ready),
        .key(dut_if.key),
        .processed_data(dut_if.processed_data),
        .head_idx(dut_if.head_idx),
        .tail_idx(dut_if.tail_idx),
        .valid(dut_if.valid)
    );

    //Clock generation;
    initial dut_if.clk = 0;
    always #5 dut_if.clk = ~dut_if.clk;

    //Reset
    initial begin
        dut_if.rst_n = 0;
        #20; 
        dut_if.rst_n = 1;
    end
    //Start UVM
    initial begin
        uvm_config_db#(virtual fifo_if)::set(null, "*", "vif", dut_if);
        run_test("fifo_test");
    end
    
endmodule