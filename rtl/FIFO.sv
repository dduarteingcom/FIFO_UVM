module FIFO #( parameter int DEPTH = 4,
    parameter int WIDTH = 8,
    localparam int ADDR_BITS = $clog2(DEPTH))
    (input logic clk,
    input logic rst_n,
    input logic [WIDTH-1:0] w_data,
    input logic w_enable,
    input logic r_enable,
    input logic downstream_ready,
    input logic [WIDTH-1:0] key,
    output logic [WIDTH-1:0] processed_data,
    output logic [ADDR_BITS-1:0] head_idx,
    output logic [ADDR_BITS-1:0] tail_idx,
    output logic valid);

    logic [WIDTH-1:0] mem [0:DEPTH-1];
    logic [WIDTH-1:0] r_data;
    logic [ADDR_BITS:0] w_ptr;
    logic [ADDR_BITS:0] r_ptr;
    logic full, empty, writable, readable;

    always_ff @(posedge clk)begin
        if(!rst_n)begin
            w_ptr <= '0;
            r_ptr <= '0;
            r_data <= '0;
        end
        else begin
            if(readable)begin
                r_data <= mem[r_ptr[ADDR_BITS-1:0]];
                r_ptr ++;
            end
        
            if(writable)begin
                mem[w_ptr[ADDR_BITS-1:0]] <= w_data;
                w_ptr ++;
            end
        end
    end
    
    always_comb begin
        processed_data = ~(r_data ^ key);
        valid = !empty;
    end

    assign full = (w_ptr[ADDR_BITS -1:0] == r_ptr[ADDR_BITS -1:0]) 
        && (w_ptr[ADDR_BITS] != r_ptr[ADDR_BITS]);
    assign empty = w_ptr == r_ptr;
    assign writable = w_enable && (!full || readable);
    assign readable = r_enable && !empty && downstream_ready;
    assign head_idx = r_ptr[ADDR_BITS-1:0];
    assign tail_idx = w_ptr[ADDR_BITS-1:0];

endmodule