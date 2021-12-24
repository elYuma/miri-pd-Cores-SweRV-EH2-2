// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
`ifdef RV_BUILD_AHB_LITE

module ahb_sif (
input logic [63:0] HWDATA,
input logic HCLK,
input logic HSEL,
input logic [3:0] HPROT,
input logic HWRITE,
input logic [1:0] HTRANS,
input logic [2:0] HSIZE,
input logic HREADY,
input logic HRESETn,
input logic [31:0] HADDR,
input logic [2:0] HBURST,

output logic HREADYOUT,
output logic HRESP,
output logic [63:0] HRDATA
);

parameter MAILBOX_ADDR = 32'hD0580000;

logic write;
logic [31:0] laddr, addr;
logic [7:0] strb_lat;
logic [63:0] rdata;

bit [7:0] mem [bit[31:0]];
bit [7:0] wscnt;
int dws = 0;
int iws = 0;
bit dws_rand;
bit iws_rand;
bit ok;

// Wires
wire [63:0] WriteData = HWDATA;
wire [7:0] strb =  HSIZE == 3'b000 ? 8'h1 << HADDR[2:0] :
                   HSIZE == 3'b001 ? 8'h3 << {HADDR[2:1],1'b0} :
                   HSIZE == 3'b010 ? 8'hf << {HADDR[2],2'b0} : 8'hff;


wire mailbox_write = write && laddr==MAILBOX_ADDR;


initial begin
    if ($value$plusargs("iws=%d", iws));
    if ($value$plusargs("dws=%d", dws));
    dws_rand = dws < 0;
    iws_rand = iws < 0;
end



always @ (negedge HCLK ) begin
    if(HREADY)
        addr = HADDR;
    if (write & HREADY) begin
        if(strb_lat[7]) mem[{laddr[31:3],3'd7}] = HWDATA[63:56];
        if(strb_lat[6]) mem[{laddr[31:3],3'd6}] = HWDATA[55:48];
        if(strb_lat[5]) mem[{laddr[31:3],3'd5}] = HWDATA[47:40];
        if(strb_lat[4]) mem[{laddr[31:3],3'd4}] = HWDATA[39:32];
        if(strb_lat[3]) mem[{laddr[31:3],3'd3}] = HWDATA[31:24];
        if(strb_lat[2]) mem[{laddr[31:3],3'd2}] = HWDATA[23:16];
        if(strb_lat[1]) mem[{laddr[31:3],3'd1}] = HWDATA[15:08];
        if(strb_lat[0]) mem[{laddr[31:3],3'd0}] = HWDATA[07:00];
    end
    if(HREADY & HSEL & |HTRANS) begin
`ifdef VERILATOR
        if(iws_rand & ~HPROT[0])
            iws = $random & 15;
        if(dws_rand & HPROT[0])
            dws = $random & 15;
`else
        if(iws_rand & ~HPROT[0])
            ok = std::randomize(iws) with {iws dist {0:=10, [1:3]:/2, [4:15]:/1};};
        if(dws_rand & HPROT[0])
            ok = std::randomize(dws) with {dws dist {0:=10, [1:3]:/2, [4:15]:/1};};
`endif
    end
end


assign HRDATA = HREADY ? rdata : ~rdata;
assign HREADYOUT = wscnt == 0;
assign HRESP = 0;

always @(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        laddr <= 32'b0;
        write <= 1'b0;
        rdata <= '0;
        wscnt <= 0;
    end
    else begin
        if(HREADY & HSEL) begin
            laddr <= HADDR;
            write <= HWRITE & |HTRANS;
            if(|HTRANS & ~HWRITE)
                rdata <= {mem[{addr[31:3],3'd7}],
                          mem[{addr[31:3],3'd6}],
                          mem[{addr[31:3],3'd5}],
                          mem[{addr[31:3],3'd4}],
                          mem[{addr[31:3],3'd3}],
                          mem[{addr[31:3],3'd2}],
                          mem[{addr[31:3],3'd1}],
                          mem[{addr[31:3],3'd0}]};
            strb_lat <= strb;
        end
    end
    if(HREADY & HSEL & |HTRANS)
        wscnt <= HPROT[0] ? dws[7:0] : iws[7:0];
    else if(wscnt != 0)
        wscnt <= wscnt-1;
end


endmodule
`endif

`ifdef RV_BUILD_AXI4
module axi_slv #(TAGW=1) (
input                   aclk,
input                   rst_l,
input [`RV_NUM_CORES-1:0]                   arvalid,
output reg [`RV_NUM_CORES-1:0]              arready,
input [`RV_NUM_CORES-1:0][31:0]            araddr,
input [`RV_NUM_CORES-1:0][TAGW-1:0]        arid,
input [`RV_NUM_CORES-1:0][7:0]             arlen,
input [`RV_NUM_CORES-1:0][1:0]             arburst,
input [`RV_NUM_CORES-1:0][2:0]             arsize,

output reg [`RV_NUM_CORES-1:0]              rvalid,
input [`RV_NUM_CORES-1:0]                  rready,
output reg [`RV_NUM_CORES-1:0][63:0]       rdata,
output reg [`RV_NUM_CORES-1:0][1:0]        rresp,
output reg [`RV_NUM_CORES-1:0][TAGW-1:0]   rid,
output  [`RV_NUM_CORES-1:0]                rlast,

input  [`RV_NUM_CORES-1:0]                 awvalid,
output [`RV_NUM_CORES-1:0]                 awready,
input [`RV_NUM_CORES-1:0][31:0]            awaddr,
input [`RV_NUM_CORES-1:0][TAGW-1:0]        awid,
input [`RV_NUM_CORES-1:0][7:0]             awlen,
input [`RV_NUM_CORES-1:0][1:0]             awburst,
input [`RV_NUM_CORES-1:0][2:0]             awsize,

input [`RV_NUM_CORES-1:0][63:0]            wdata,
input [`RV_NUM_CORES-1:0][7:0]             wstrb,
input [`RV_NUM_CORES-1:0]                  wvalid,
output [`RV_NUM_CORES-1:0]                 wready,

output  reg [`RV_NUM_CORES-1:0]            bvalid,
input [`RV_NUM_CORES-1:0]                  bready,
output reg [`RV_NUM_CORES-1:0][1:0]        bresp,
output reg [`RV_NUM_CORES-1:0][TAGW-1:0]   bid
);

parameter MAILBOX_ADDR = 32'hD0580000;
parameter MEM_SIZE_DW = 8192;

bit [7:0] mem [bit[31:0]];
bit [`RV_NUM_CORES-1:0][63:0] memdata;
wire [`RV_NUM_CORES-1:0][63:0] WriteData;
wire [`RV_NUM_CORES-1:0]mailbox_write;

wire[31:0] raddr, waddr;

assign mailbox_write[0] = awvalid[0] && awaddr[0]==MAILBOX_ADDR && rst_l;
assign WriteData[0] = wdata[0];

assign mailbox_write[1] = awvalid[1] && awaddr[1]==MAILBOX_ADDR && rst_l;
assign WriteData[1] = wdata[1];

always @ ( posedge aclk or negedge rst_l) begin
    if(!rst_l) begin
        rvalid[0]  <= 0;
        bvalid[0]  <= 0;
		
		// Core 1
		rvalid[1]  <= 0;
        bvalid[1]  <= 0;
    end
    else begin
        bid[0]     <= awid[0];
        rid[0]     <= arid[0];
        rvalid[0]  <= arvalid[0];
        bvalid[0]  <= awvalid[0];
        rdata[0]   <= memdata[0];
		
		// Core 1
		bid[1]     <= awid[1];
        rid[1]     <= arid[1];
        rvalid[1]  <= arvalid[1];
        bvalid[1]  <= awvalid[1];
        rdata[1]   <= memdata[1];
    end
end

assign raddr[0] = {araddr[0][31:3],3'b0};
assign waddr[0] = {awaddr[0][31:3],3'b0};

// Core 1
assign raddr[1] = {araddr[1][31:3],3'b0};
assign waddr[1] = {awaddr[1][31:3],3'b0};

always @ ( negedge aclk) begin
    if(arvalid[0]) memdata[0] <= {mem[raddr[0]+7], mem[raddr[0]+6], mem[raddr[0]+5], mem[raddr[0]+4],
                            mem[raddr[0]+3], mem[raddr[0]+2], mem[raddr[0]+1], mem[raddr[0]]};
    if(awvalid[0]) begin
        if(wstrb[0][7]) mem[waddr[0]+7] = wdata[0][63:56];
        if(wstrb[0][6]) mem[waddr[0]+6] = wdata[0][55:48];
        if(wstrb[0][5]) mem[waddr[0]+5] = wdata[0][47:40];
        if(wstrb[0][4]) mem[waddr[0]+4] = wdata[0][39:32];
        if(wstrb[0][3]) mem[waddr[0]+3] = wdata[0][31:24];
        if(wstrb[0][2]) mem[waddr[0]+2] = wdata[0][23:16];
        if(wstrb[0][1]) mem[waddr[0]+1] = wdata[0][15:08];
        if(wstrb[0][0]) mem[waddr[0]+0] = wdata[0][07:00];
    end
	
	// Core 1
	if(arvalid[1]) memdata[1] <= {mem[raddr[1]+7], mem[raddr[1]+6], mem[raddr[1]+5], mem[raddr[1]+4],
                            mem[raddr[1]+3], mem[raddr[1]+2], mem[raddr[1]+1], mem[raddr[1]]};
	if(awvalid[1]) begin
        if(wstrb[1][7]) mem[waddr[1]+7] = wdata[1][63:56];
        if(wstrb[1][6]) mem[waddr[1]+6] = wdata[1][55:48];
        if(wstrb[1][5]) mem[waddr[1]+5] = wdata[1][47:40];
        if(wstrb[1][4]) mem[waddr[1]+4] = wdata[1][39:32];
        if(wstrb[1][3]) mem[waddr[1]+3] = wdata[1][31:24];
        if(wstrb[1][2]) mem[waddr[1]+2] = wdata[1][23:16];
        if(wstrb[1][1]) mem[waddr[1]+1] = wdata[1][15:08];
        if(wstrb[1][0]) mem[waddr[1]+0] = wdata[1][07:00];
    end
end


assign arready[0] = 1'b1;
assign awready[0] = 1'b1;
assign wready[0]  = 1'b1;
assign rresp[0]   = 2'b0;
assign bresp[0]   = 2'b0;
assign rlast[0]   = 1'b1;

// Core 1
assign arready[1] = 1'b1;
assign awready[1] = 1'b1;
assign wready[1]  = 1'b1;
assign rresp[1]   = 2'b0;
assign bresp[1]   = 2'b0;
assign rlast[1]   = 1'b1;


endmodule
`endif

