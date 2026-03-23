interface fifo_if #(parameter WIDTH = 8, parameter DEPTH = 4);
    localparam int ADDR_BITS = $clog2(DEPTH) ;
    logic clk;
    logic rst_n;

    logic [WIDTH-1:0] w_data;
    logic w_enable;
    logic r_enable;
    logic downstream_ready;
    
    logic [WIDTH-1:0] key;
    logic [WIDTH-1:0] processed_data;
    logic [ADDR_BITS-1:0] head_idx;
    logic [ADDR_BITS-1:0] tail_idx;
    logic valid;
endinterface // 