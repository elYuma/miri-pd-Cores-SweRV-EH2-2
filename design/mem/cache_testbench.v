/**
 * cache testbench.
 *
 */

`define CACHE_OP_TYPE_WIDTH 2
`define CACHE_OP_BYTE 0
`define CACHE_OP_WORD 1
`define CACHE_OP_CACHE_LINE 2
`define PHYSICAL_ADDR_WIDTH 20
`define CACHE_LINE_WIDTH 128
`define CACHE_LINES_WIDTH 2 // 4 cache lines.

`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module cache_testbench();
    
    localparam CLK_period = 20;
    
    reg clk, reset;
    
    reg [`DATA_SIZE-1:0] addr_tag;
    reg [`DATA_SIZE-1:0] addr_data;
    reg [`CACHE_LINE_WIDTH-1:0] din;
    reg [1:0] cache_load_type = 0;
    reg read_tag = 1;
    reg cache_write = 0;
    reg read_data = 0;
    wire hit_tag;
    wire hit_data;
    wire dirty;
    wire [`CACHE_LINE_WIDTH-1:0] dout_tag;
    wire [`CACHE_LINE_WIDTH-1:0] dout_data;

    reg [`CACHE_LINE_WIDTH-1:0] in_RAM;
    
    cache cache(
        .clk(clk),
        .reset(reset),
        .addr_tag(addr_tag),
        .addr_data(addr_data),
        .din(din),
        .load_type(cache_load_type),
        .read_tag(read_tag),
        .read_data(read_data),
        .write(cache_write),
        .hit_tag(hit_tag),
        .hit_data(hit_data),
        .dirty(dirty),
        .dout_data(dout_data), 
        .dout_tag(dout_tag));
    
    initial begin
        reset = 0;
    end
    
    always begin
        clk = 1; // high edge
        #(CLK_period / 2); // wait for period
        
        clk = 0; // low edge
        #(CLK_period / 2); // wait for period
    end
    
    integer i, RAM_WAIT = 5, j;

    always @(posedge clk) begin
        #(CLK_period*5); // 100 ns

        // icache overflow
        cache_write = 1;
        read_data = !cache_write;
        cache_load_type = 2;

        addr_data = 32'h 0080;

        #(CLK_period); // 100 ns

        cache_write = 0;
        read_data = !cache_write;
        cache_load_type = 0;

        #(CLK_period); // 100 ns
    end
endmodule