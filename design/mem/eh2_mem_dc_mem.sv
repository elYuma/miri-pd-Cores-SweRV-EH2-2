/**
 * Instruction cache.
 *
 */

`define CACHE_OP_TYPE_WIDTH 2
`define CACHE_OP_BYTE 0
`define CACHE_OP_WORD 1
`define CACHE_OP_CACHE_LINE 2
`define PHYSICAL_ADDR_WIDTH 20
`define CACHE_LINE_WIDTH 128
`define CACHE_LINES_WIDTH 2 // 4 cache lines.

module eh2_lsu_dc_mem# () (input wire clk,                                       // Clock.
             input wire reset,                                     // reset the data of the Cache.
             input wire [`PHYSICAL_ADDR_WIDTH-1:0] addr_tag,       // @addr for tag access.
             input wire [`PHYSICAL_ADDR_WIDTH-1:0] addr_data,      // @addr for data output acces.
             input wire write_data,                                // 1 when you want to write on the cache using the addr of the tag.
             input wire write_tag,                                 // 1 when you want to write on the cache using the addr of the data.
             input wire [`CACHE_OP_TYPE_WIDTH-1:0] op_type_data,   // Operation type of the data access (byte, word or cache-line).
             input wire [`CACHE_LINE_WIDTH-1:0] din_data,          // Data input of the data port.
             input wire [`CACHE_LINE_WIDTH-1:0] din_tag,           // Data input of the tag port.
             output reg [`CACHE_LINE_WIDTH-1:0] dout_data,         // Data out of the data port.
             output reg [`CACHE_LINE_WIDTH-1:0] dout_tag,          // Data out of the tag port.
             output wire [`PHYSICAL_ADDR_WIDTH-1:0] dout_addr_tag, // Addr out of the tag port.
             output wire hit,                                      // Tag port hit?
             output wire dirty);                                   // Tag port dirty?

    localparam CACHE_LINES = 2 ** `CACHE_LINES_WIDTH;

    wire [`CACHE_LINES_WIDTH-1:0] tag_idx = addr_tag[5:4];
    wire [14:0] tag_tag = addr_tag[19:6];
    wire [3:0] tag_byte = addr_tag[3:0];
    wire [1:0] tag_word = addr_tag[3:2];

    wire [`CACHE_LINES_WIDTH-1:0] data_idx = addr_data[5:4];
    wire [14:0] data_tag = addr_data[19:6];
    wire [3:0] data_byte = addr_data[3:0];
    wire [1:0] data_word = addr_data[3:2];

    reg cache_valid[CACHE_LINES-1:0];
    reg cache_dirty[CACHE_LINES-1:0];
    reg [14:0] cache_tags[CACHE_LINES-1:0];
    reg [7:0] cache_data[CACHE_LINES-1:0][(`CACHE_LINE_WIDTH / 8)-1:0]; // cache with 4 cache lines with blocks size of 4, 8 words

    integer i, j;

    assign hit = cache_valid[tag_idx] && cache_tags[tag_idx] == tag_tag;
    assign dirty = cache_valid[tag_idx] && cache_dirty[tag_idx];
    assign dout_addr_tag = {cache_tags[tag_idx], tag_idx, 4'b 0000};

    initial begin
        dout_data <= 0;
        dout_tag  <= 0;
        for (i = 0; i < CACHE_LINES; i = i + 1) begin
            cache_valid[i] <= 0;
            cache_dirty[i] <= 0;
            cache_tags[i]  <= 0;
            for (j = 0; j < (`CACHE_LINE_WIDTH / 8); j = j + 1) begin
                cache_data[i][j]  <= 0; 
            end
        end
    end

    /**
     * Write data into the Cache.
     *
     */
    task write(input [`CACHE_LINE_WIDTH - 1:0] din,      // Data to write.
                     [`CACHE_OP_TYPE_WIDTH-1:0] op_type, // Operation type (byte, word, cache-line).
                     [14:0] tag,                         // Tag.
                     [3:0] byte,                         // Byte.
                     [1:0] word,                         // Word.
                     [`CACHE_LINES_WIDTH-1:0] idx);      // Index of the cache.
        begin

            cache_valid[idx] <= 1;
            cache_dirty[idx] <= tag == cache_tags[idx] && cache_valid[idx];
            cache_tags[idx]  <= tag;

            if (op_type == `CACHE_OP_BYTE) begin
                cache_data[idx][byte] <= din[7:0];
            end
            else if (op_type == `CACHE_OP_WORD) begin
                cache_data[idx][word * 4 + 0] <= din[7:0];
                cache_data[idx][word * 4 + 1] <= din[15:8];
                cache_data[idx][word * 4 + 2] <= din[23:16];
                cache_data[idx][word * 4 + 3] <= din[31:24];
            end
            else if (op_type == `CACHE_OP_CACHE_LINE) begin
                cache_data[idx][0] <= din[7:0];
                cache_data[idx][1] <= din[15:8];
                cache_data[idx][2] <= din[23:16];
                cache_data[idx][3] <= din[31:24];

                cache_data[idx][4] <= din[39:32];
                cache_data[idx][5] <= din[47:40];
                cache_data[idx][6] <= din[55:48];
                cache_data[idx][7] <= din[63:56];

                cache_data[idx][8]  <= din[71:64];
                cache_data[idx][9]  <= din[79:72];
                cache_data[idx][10] <= din[87:80];
                cache_data[idx][11] <= din[95:88];

                cache_data[idx][12] <= din[103:96];
                cache_data[idx][13] <= din[111:104];
                cache_data[idx][14] <= din[119:112];
                cache_data[idx][15] <= din[127:120];
            end
        end
    endtask

    /**
     * Read data from the Cache.
     *
     */
    task read(output [`CACHE_LINE_WIDTH-1:0] dout,       // Data output.
              input [`CACHE_OP_TYPE_WIDTH-1:0] op_type,  // Operation type (byte, word, cache-line).
                    [3:0] byte,                          // Byte.
                    [1:0] word,                          // Word.
                    [`CACHE_LINES_WIDTH-1:0] idx);       // Index of the cache.
        begin
            if (op_type == `CACHE_OP_BYTE) begin
                dout[7:0] = cache_data[idx][byte];

                dout[127:8] = 0;
            end
            else if (op_type == `CACHE_OP_WORD) begin
                dout[7:0]   = cache_data[idx][word * 4 + 0];
                dout[15:8]  = cache_data[idx][word * 4 + 1];
                dout[23:16] = cache_data[idx][word * 4 + 2];
                dout[31:24] = cache_data[idx][word * 4 + 3];

                dout[127:32] = 0;
            end
            else if (op_type == `CACHE_OP_CACHE_LINE) begin
                dout[7:0]   = cache_data[idx][0];
                dout[15:8]  = cache_data[idx][1];
                dout[23:16] = cache_data[idx][2];
                dout[31:24] = cache_data[idx][3];

                dout[39:32] = cache_data[idx][4];
                dout[47:40] = cache_data[idx][5];
                dout[55:48] = cache_data[idx][6];
                dout[63:56] = cache_data[idx][7];

                dout[71:64] = cache_data[idx][8];
                dout[79:72] = cache_data[idx][9];
                dout[87:80] = cache_data[idx][10];
                dout[95:88] = cache_data[idx][11];

                dout[103:96]  = cache_data[idx][12];
                dout[111:104] = cache_data[idx][13];
                dout[119:112] = cache_data[idx][14];
                dout[127:120] = cache_data[idx][15];
            end 
        end
    endtask    

    always @(cache_valid, cache_tags, op_type_data, 
             tag_tag, tag_idx, tag_byte, tag_word, 
             data_tag, data_idx, data_byte, 
             data_word, cache_data) begin

        read(dout_tag, `CACHE_OP_CACHE_LINE, tag_byte, tag_word, tag_idx);
        read(dout_data, op_type_data, data_byte, data_word, data_idx);  
    end
    
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < CACHE_LINES; i = i + 1) begin
                cache_valid[i] <= 0;
                cache_dirty[i] <= 0;
            end
        end
        else begin
            if (write_tag) begin
                write(din_tag, `CACHE_OP_CACHE_LINE, tag_tag, tag_byte, tag_word, tag_idx);
                cache_valid[tag_idx] <= dirty ? 0 : 1; // If we are performing a dirty eviction, the data in the line is now not-valid.
            end
            if (write_data) begin
                write(din_data, op_type_data, data_tag, data_byte, data_word, data_idx);
            end
        end
    end    
endmodule