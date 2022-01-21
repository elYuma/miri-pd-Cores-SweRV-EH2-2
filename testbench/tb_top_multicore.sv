// SPDX-License-Identifier: Apache-2.0
// Copyright 2019,2020 Western Digital Corporation or its affiliates.
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
// this is testbench file

`ifndef RV_NUM_CORES
`define RV_NUM_CORES 2
`endif

`ifdef VERILATOR
module tb_top ( input bit core_clk );
`else
module tb_top;
    bit                         core_clk;
`endif
    logic [`RV_NUM_CORES-1:0]                       rst_l;
    logic [`RV_NUM_CORES-1:0]                      porst_l;
    logic [`RV_NUM_CORES-1:0]                      nmi_int;

    logic        [31:0]         reset_vector; // REVISE THIS
    logic        [31:0]         nmi_vector; // REVISE THIS
    logic        [31:1]         jtag_id; // REVISE THIS

// AHB
    logic        [31:0]         ic_haddr;
    logic        [2:0]          ic_hburst;
    logic        [3:0]          ic_hprot;
    logic        [2:0]          ic_hsize;
    logic        [1:0]          ic_htrans;
    logic                       ic_hwrite;
    logic        [63:0]         ic_hrdata;
    logic                       ic_hready;
    logic                       ic_hresp;

    logic        [31:0]         lsu_haddr;
    logic        [2:0]          lsu_hburst;
    logic        [3:0]          lsu_hprot;
    logic        [2:0]          lsu_hsize;
    logic        [1:0]          lsu_htrans;
    logic                       lsu_hwrite;
    logic        [63:0]         lsu_hrdata;
    logic        [63:0]         lsu_hwdata;
    logic                       lsu_hready;
    logic                       lsu_hresp;

    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][63:0]    trace_rv_i_insn_ip;
    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][63:0]    trace_rv_i_address_ip;
    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][1:0]     trace_rv_i_valid_ip;
    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][1:0]     trace_rv_i_exception_ip;
    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][4:0]     trace_rv_i_ecause_ip;
    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][1:0]     trace_rv_i_interrupt_ip;
    logic [`RV_NUM_CORES-1:0][`RV_NUM_THREADS-1:0][31:0]    trace_rv_i_tval_ip;

    logic                       o_debug_mode_status;


    logic                       jtag_tdo;
    logic                       o_cpu_halt_ack;
    logic                       o_cpu_halt_status;
    logic                       o_cpu_run_ack;

    logic  [`RV_NUM_CORES-1:0]                     mailbox_write;
    logic        [63:0]         dma_hrdata;
    logic        [63:0]         dma_hwdata;
    logic                       dma_hready;
    logic                       dma_hresp;

    logic                       mpc_debug_halt_req;
    logic                       mpc_debug_run_req;
    logic                       mpc_reset_run_req;
    logic                       mpc_debug_halt_ack;
    logic                       mpc_debug_run_ack;
    logic                       debug_brkpt_status;

    bit        [31:0]           cycleCnt;
    logic [`RV_NUM_CORES-1:0]                      mailbox_data_val;

    wire                        dma_hready_out;
    int                         commit_count[`RV_NUM_CORES-1:0][2];

    logic [`RV_NUM_CORES-1:0][1:0]                 wb_valid;
    logic [`RV_NUM_CORES-1:0][1:0][4:0]            wb_dest;
    logic [`RV_NUM_CORES-1:0][1:0][31:0]           wb_data;
    logic [`RV_NUM_CORES-1:0][1:0]                 wb_tid;

   //-------------------------- LSU AXI signals--------------------------
   // AXI Write Channels
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_awvalid;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_awready;
    wire [`RV_NUM_CORES-1:0][`RV_LSU_BUS_TAG-1:0]  lsu_axi_awid;
    wire [`RV_NUM_CORES-1:0][31:0]                 lsu_axi_awaddr;
    wire [`RV_NUM_CORES-1:0][3:0]                  lsu_axi_awregion;
    wire [`RV_NUM_CORES-1:0][7:0]                  lsu_axi_awlen;
    wire [`RV_NUM_CORES-1:0][2:0]                  lsu_axi_awsize;
    wire [`RV_NUM_CORES-1:0][1:0]                  lsu_axi_awburst;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_awlock;
    wire [`RV_NUM_CORES-1:0][3:0]                  lsu_axi_awcache;
    wire [`RV_NUM_CORES-1:0][2:0]                  lsu_axi_awprot;
    wire [`RV_NUM_CORES-1:0][3:0]                  lsu_axi_awqos;

    wire [`RV_NUM_CORES-1:0]                       lsu_axi_wvalid;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_wready;
    wire [`RV_NUM_CORES-1:0][63:0]                 lsu_axi_wdata;
    wire [`RV_NUM_CORES-1:0][7:0]                  lsu_axi_wstrb;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_wlast;

    wire [`RV_NUM_CORES-1:0]                       lsu_axi_bvalid;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_bready;
    wire [`RV_NUM_CORES-1:0][1:0]                  lsu_axi_bresp;
    wire [`RV_LSU_BUS_TAG-1:0]  lsu_axi_bid;

    // AXI Read Channels
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_arvalid;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_arready;
    wire [`RV_NUM_CORES-1:0][`RV_LSU_BUS_TAG-1:0]  lsu_axi_arid;
    wire [`RV_NUM_CORES-1:0][31:0]                 lsu_axi_araddr;
    wire [`RV_NUM_CORES-1:0][3:0]                  lsu_axi_arregion;
    wire [`RV_NUM_CORES-1:0][7:0]                  lsu_axi_arlen;
    wire [`RV_NUM_CORES-1:0][2:0]                  lsu_axi_arsize;
    wire [`RV_NUM_CORES-1:0][1:0]                  lsu_axi_arburst;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_arlock;
    wire [`RV_NUM_CORES-1:0][3:0]                  lsu_axi_arcache;
    wire [`RV_NUM_CORES-1:0][2:0]                  lsu_axi_arprot;
    wire [`RV_NUM_CORES-1:0][3:0]                  lsu_axi_arqos;

    wire [`RV_NUM_CORES-1:0]                       lsu_axi_rvalid;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_rready;
    wire [`RV_NUM_CORES-1:0][`RV_LSU_BUS_TAG-1:0]  lsu_axi_rid;
    wire [`RV_NUM_CORES-1:0][63:0]                 lsu_axi_rdata;
    wire [`RV_NUM_CORES-1:0][1:0]                  lsu_axi_rresp;
    wire [`RV_NUM_CORES-1:0]                       lsu_axi_rlast;

    //-------------------------- IFU AXI signals--------------------------
    // AXI Write Channels
    wire [`RV_NUM_CORES-1:0]                       ifu_axi_awvalid;
    wire [`RV_NUM_CORES-1:0]                       ifu_axi_awready;
    wire [`RV_NUM_CORES-1:0][`RV_IFU_BUS_TAG-1:0]  ifu_axi_awid;
    wire [`RV_NUM_CORES-1:0][31:0]                 ifu_axi_awaddr;
    wire [`RV_NUM_CORES-1:0] [3:0]                  ifu_axi_awregion;
    wire [`RV_NUM_CORES-1:0] [7:0]                  ifu_axi_awlen;
    wire [`RV_NUM_CORES-1:0] [2:0]                  ifu_axi_awsize;
    wire [`RV_NUM_CORES-1:0] [1:0]                  ifu_axi_awburst;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_awlock;
    wire [`RV_NUM_CORES-1:0] [3:0]                  ifu_axi_awcache;
    wire [`RV_NUM_CORES-1:0] [2:0]                  ifu_axi_awprot;
    wire [`RV_NUM_CORES-1:0] [3:0]                  ifu_axi_awqos;

    wire [`RV_NUM_CORES-1:0]                        ifu_axi_wvalid;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_wready;
    wire [`RV_NUM_CORES-1:0] [63:0]                 ifu_axi_wdata;
    wire [`RV_NUM_CORES-1:0] [7:0]                  ifu_axi_wstrb;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_wlast;

    wire [`RV_NUM_CORES-1:0]                        ifu_axi_bvalid;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_bready;
    wire [`RV_NUM_CORES-1:0] [1:0]                  ifu_axi_bresp;
    wire [`RV_NUM_CORES-1:0] [`RV_IFU_BUS_TAG-1:0]  ifu_axi_bid;

    // AXI Read Channels
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_arvalid;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_arready;
    wire [`RV_NUM_CORES-1:0] [`RV_IFU_BUS_TAG-1:0]  ifu_axi_arid;
    wire [`RV_NUM_CORES-1:0] [31:0]                 ifu_axi_araddr;
    wire [`RV_NUM_CORES-1:0] [3:0]                  ifu_axi_arregion;
    wire [`RV_NUM_CORES-1:0] [7:0]                  ifu_axi_arlen;
    wire [`RV_NUM_CORES-1:0] [2:0]                  ifu_axi_arsize;
    wire [`RV_NUM_CORES-1:0] [1:0]                  ifu_axi_arburst;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_arlock;
    wire [`RV_NUM_CORES-1:0] [3:0]                  ifu_axi_arcache;
    wire [`RV_NUM_CORES-1:0] [2:0]                  ifu_axi_arprot;
    wire [`RV_NUM_CORES-1:0] [3:0]                  ifu_axi_arqos;

    wire [`RV_NUM_CORES-1:0]                        ifu_axi_rvalid;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_rready;
    wire [`RV_NUM_CORES-1:0] [`RV_IFU_BUS_TAG-1:0]  ifu_axi_rid;
    wire [`RV_NUM_CORES-1:0] [63:0]                 ifu_axi_rdata;
    wire [`RV_NUM_CORES-1:0] [1:0]                  ifu_axi_rresp;
    wire [`RV_NUM_CORES-1:0]                        ifu_axi_rlast;

    //-------------------------- SB AXI signals--------------------------
    // AXI Write Channels
    wire [`RV_NUM_CORES-1:0]                        sb_axi_awvalid;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_awready;
    wire [`RV_NUM_CORES-1:0] [`RV_SB_BUS_TAG-1:0]   sb_axi_awid;
    wire [`RV_NUM_CORES-1:0] [31:0]                 sb_axi_awaddr;
    wire [`RV_NUM_CORES-1:0] [3:0]                  sb_axi_awregion;
    wire [`RV_NUM_CORES-1:0] [7:0]                  sb_axi_awlen;
    wire [`RV_NUM_CORES-1:0] [2:0]                  sb_axi_awsize;
    wire [`RV_NUM_CORES-1:0] [1:0]                  sb_axi_awburst;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_awlock;
    wire [`RV_NUM_CORES-1:0] [3:0]                  sb_axi_awcache;
    wire [`RV_NUM_CORES-1:0] [2:0]                  sb_axi_awprot;
    wire [`RV_NUM_CORES-1:0] [3:0]                  sb_axi_awqos;

    wire [`RV_NUM_CORES-1:0]                        sb_axi_wvalid;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_wready;
    wire [`RV_NUM_CORES-1:0] [63:0]                 sb_axi_wdata;
    wire [`RV_NUM_CORES-1:0] [7:0]                  sb_axi_wstrb;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_wlast;

    wire [`RV_NUM_CORES-1:0]                        sb_axi_bvalid;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_bready;
    wire [`RV_NUM_CORES-1:0] [1:0]                  sb_axi_bresp;
    wire [`RV_NUM_CORES-1:0] [`RV_SB_BUS_TAG-1:0]   sb_axi_bid;

    // AXI Read Channels
    wire [`RV_NUM_CORES-1:0]                        sb_axi_arvalid;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_arready;
    wire [`RV_NUM_CORES-1:0] [`RV_SB_BUS_TAG-1:0]   sb_axi_arid;
    wire [`RV_NUM_CORES-1:0] [31:0]                 sb_axi_araddr;
    wire [`RV_NUM_CORES-1:0] [3:0]                  sb_axi_arregion;
    wire [`RV_NUM_CORES-1:0] [7:0]                  sb_axi_arlen;
    wire [`RV_NUM_CORES-1:0] [2:0]                  sb_axi_arsize;
    wire [`RV_NUM_CORES-1:0] [1:0]                  sb_axi_arburst;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_arlock;
    wire [`RV_NUM_CORES-1:0] [3:0]                  sb_axi_arcache;
    wire [`RV_NUM_CORES-1:0] [2:0]                  sb_axi_arprot;
    wire [`RV_NUM_CORES-1:0] [3:0]                  sb_axi_arqos;

    wire [`RV_NUM_CORES-1:0]                        sb_axi_rvalid;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_rready;
    wire [`RV_NUM_CORES-1:0] [`RV_SB_BUS_TAG-1:0]   sb_axi_rid;
    wire [`RV_NUM_CORES-1:0] [63:0]                 sb_axi_rdata;
    wire [`RV_NUM_CORES-1:0] [1:0]                  sb_axi_rresp;
    wire [`RV_NUM_CORES-1:0]                        sb_axi_rlast;

   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
    wire [`RV_NUM_CORES-1:0]                        dma_axi_awvalid;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_awready;
    wire [`RV_NUM_CORES-1:0] [`RV_DMA_BUS_TAG-1:0]  dma_axi_awid;
    wire [`RV_NUM_CORES-1:0] [31:0]                 dma_axi_awaddr;
    wire [`RV_NUM_CORES-1:0] [2:0]                  dma_axi_awsize;
    wire [`RV_NUM_CORES-1:0] [2:0]                  dma_axi_awprot;
    wire [`RV_NUM_CORES-1:0] [7:0]                  dma_axi_awlen;
    wire [`RV_NUM_CORES-1:0] [1:0]                  dma_axi_awburst;


    wire [`RV_NUM_CORES-1:0]                        dma_axi_wvalid;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_wready;
    wire [`RV_NUM_CORES-1:0] [63:0]                 dma_axi_wdata;
    wire [`RV_NUM_CORES-1:0] [7:0]                  dma_axi_wstrb;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_wlast;

    wire [`RV_NUM_CORES-1:0]                        dma_axi_bvalid;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_bready;
    wire [`RV_NUM_CORES-1:0] [1:0]                  dma_axi_bresp;
    wire [`RV_NUM_CORES-1:0] [`RV_DMA_BUS_TAG-1:0]  dma_axi_bid;

    // AXI Read Channels
    wire [`RV_NUM_CORES-1:0]                        dma_axi_arvalid;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_arready;
    wire [`RV_NUM_CORES-1:0] [`RV_DMA_BUS_TAG-1:0]  dma_axi_arid;
    wire [`RV_NUM_CORES-1:0] [31:0]                 dma_axi_araddr;
    wire [`RV_NUM_CORES-1:0] [2:0]                  dma_axi_arsize;
    wire [`RV_NUM_CORES-1:0] [2:0]                  dma_axi_arprot;
    wire [`RV_NUM_CORES-1:0] [7:0]                  dma_axi_arlen;
    wire [`RV_NUM_CORES-1:0] [1:0]                  dma_axi_arburst;

    wire [`RV_NUM_CORES-1:0]                        dma_axi_rvalid;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_rready;
    wire [`RV_NUM_CORES-1:0] [`RV_DMA_BUS_TAG-1:0]  dma_axi_rid;
    wire [`RV_NUM_CORES-1:0] [63:0]                 dma_axi_rdata;
    wire [`RV_NUM_CORES-1:0] [1:0]                  dma_axi_rresp;
    wire [`RV_NUM_CORES-1:0]                        dma_axi_rlast;

    wire [`RV_NUM_CORES-1:0]                       lmem_axi_arvalid;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_arready;

    wire [`RV_NUM_CORES-1:0]                       lmem_axi_rvalid;
    wire [`RV_NUM_CORES-1:0][`RV_LSU_BUS_TAG-1:0]  lmem_axi_rid;
    wire [`RV_NUM_CORES-1:0][1:0]                  lmem_axi_rresp;
    wire [`RV_NUM_CORES-1:0][63:0]                 lmem_axi_rdata;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_rlast;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_rready;

    wire [`RV_NUM_CORES-1:0]                       lmem_axi_awvalid;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_awready;

    wire [`RV_NUM_CORES-1:0]                       lmem_axi_wvalid;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_wready;

    wire [`RV_NUM_CORES-1:0][1:0]                  lmem_axi_bresp;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_bvalid;
    wire [`RV_NUM_CORES-1:0][`RV_LSU_BUS_TAG-1:0]  lmem_axi_bid;
    wire [`RV_NUM_CORES-1:0]                       lmem_axi_bready;


    string                      abi_reg[`RV_NUM_CORES-1:0][32]; // ABI register names
    wire[`RV_NUM_CORES-1:0][63:0]                  WriteData;
    wire[`RV_NUM_CORES-1:0]                        tck, tms, tdi, tdo, trstn, srstn;
    wire [`RV_NUM_CORES-1:0][31:0]                 minstret[2], mcycle[2];

`define DEC rvtop.swerv_0.dec
`define DEC_1 rvtop.swerv_1.dec

    assign mailbox_write[0] = lmem.mailbox_write[0];
    assign WriteData[0] = lmem.WriteData[0];
    assign mailbox_data_val[0] = WriteData[0][7:0] > 8'h5 && WriteData[0][7:0] < 8'h7f;

    assign minstret[0][0] = `DEC.tlu.tlumt[0].tlu.minstretl;
    assign mcycle[0][0]   = `DEC.tlu.tlumt[0].tlu.mcyclel;
    assign minstret[0][1] = `DEC.tlu.tlumt[`RV_NUM_THREADS-1].tlu.minstretl;
    assign mcycle[0][1]   = `DEC.tlu.tlumt[`RV_NUM_THREADS-1].tlu.mcyclel;
	
	// Core 1
	assign mailbox_write[1] = lmem.mailbox_write[1];
    assign WriteData[1] = lmem.WriteData[1];
    assign mailbox_data_val[1] = WriteData[1][7:0] > 8'h5 && WriteData[1][7:0] < 8'h7f;

    assign minstret[1][0] = `DEC_1.tlu.tlumt[0].tlu.minstretl;
    assign mcycle[1][0]   = `DEC_1.tlu.tlumt[0].tlu.mcyclel;
    assign minstret[1][1] = `DEC_1.tlu.tlumt[`RV_NUM_THREADS-1].tlu.minstretl;
    assign mcycle[1][1]   = `DEC_1.tlu.tlumt[`RV_NUM_THREADS-1].tlu.mcyclel;


    parameter MAX_CYCLES = 10_000_000;

    integer fd, tp, el;

    always @(negedge core_clk) begin
        cycleCnt <= cycleCnt+1;
        // Test timeout monitor
        if(cycleCnt == MAX_CYCLES) begin
            $display ("Hit max cycle count (%0d) .. stopping",cycleCnt);
            $finish;
        end
        // console Monitor
        if( mailbox_data_val[0] & mailbox_write[0]) begin
            $fwrite(fd,"%c", WriteData[0][7:0]);
            $write("%c", WriteData[0][7:0]);
        end
		// console Monitor Core 1
//         if( mailbox_data_val[1] & mailbox_write[1]) begin
//             $fwrite(fd,"%c", WriteData[1][7:0]);
//             $write("%c", WriteData[1][7:0]);
//         end
        // End Of test monitor
        if(mailbox_write[0] && WriteData[0][7:0] == 8'hff) begin
            $display("TEST_PASSED");
            $display("\nFinished Core 0, hart0 : minstret = %0d, mcycle = %0d", minstret[0][0],mcycle[0][0]);
            if(`RV_NUM_THREADS == 2)
                $display("Finished Core 0, hart1 : minstret = %0d, mcycle = %0d", minstret[0][1], mcycle[0][1]);
            $display("See \"exec.log\" for execution trace with register updates..\n");
            $finish;
        end
		// End Of test monitor Core 1
//         if(mailbox_write[1] && WriteData[1][7:0] == 8'hff) begin
//             $display("TEST_PASSED");
//             $display("\nFinished Core 1, hart0 : minstret = %0d, mcycle = %0d", minstret[1][0],mcycle[1][0]);
//             if(`RV_NUM_THREADS == 2)
//                 $display("Finished Core 1, hart1 : minstret = %0d, mcycle = %0d", minstret[1][1], mcycle[1][1]);
//             $display("See \"exec.log\" for execution trace with register updates..\n");
//             $finish;
//         end
        else if(mailbox_write[0] && WriteData[0][7:0] == 8'h1) begin
            $display("TEST_FAILED");
            $finish;
        end
// 		else if(mailbox_write[1] && WriteData[1][7:0] == 8'h1) begin
//             $display("TEST_FAILED");
//             $finish;
//         end
    end


    // trace monitor
    
    always @(posedge core_clk) begin
         wb_valid[0][1:0]  <= '{`DEC.dec_i1_wen_wb,   `DEC.dec_i0_wen_wb};
         wb_dest[0]        <= '{`DEC.dec_i1_waddr_wb, `DEC.dec_i0_waddr_wb};
         wb_data[0]        <= '{`DEC.dec_i1_wdata_wb, `DEC.dec_i0_wdata_wb};
         wb_tid[0]         <= '{`DEC.dec_i1_tid_wb,   `DEC.dec_i0_tid_wb};
		 
// 		 wb_valid[1][1:0]  <= '{`DEC_1.dec_i1_wen_wb,   `DEC_1.dec_i0_wen_wb};
//          wb_dest[1]        <= '{`DEC_1.dec_i1_waddr_wb, `DEC_1.dec_i0_waddr_wb};
//          wb_data[1]        <= '{`DEC_1.dec_i1_wdata_wb, `DEC_1.dec_i0_wdata_wb};
//          wb_tid[1]         <= '{`DEC_1.dec_i1_tid_wb,   `DEC_1.dec_i0_tid_wb};
// 		 for(int c=0; c<`RV_NUM_CORES; c++) begin // Process both cores

/*
			 for(int t=0; t<`RV_NUM_THREADS; t++) begin
				 if (trace_rv_i_valid_ip[0][t] !== 0) begin
					$fwrite(tp,"t%0d %b,%h,%h,%0h,%0h,3,%b,%h,%h,%b\n",t, trace_rv_i_valid_ip[0][t], trace_rv_i_address_ip[0][t][63:32], trace_rv_i_address_ip[0][t][31:0],
						   trace_rv_i_insn_ip[0][t][63:32], trace_rv_i_insn_ip[0][t][31:0],trace_rv_i_exception_ip[0][t],trace_rv_i_ecause_ip[0][t],
						   trace_rv_i_tval_ip[0][t],trace_rv_i_interrupt_ip[0][t]);
					// Basic trace - no exception register updates
					// #1 0 ee000000 b0201073 c 0b02       00000000
					for (int i=0; i<2; i++)
						if (trace_rv_i_valid_ip[0][t][i]==1) begin
							bit i0;
							i0 = i != 0 || trace_rv_i_valid_ip[0][t]!=3 && wb_tid[0][1] == t && wb_valid[0][1];
							commit_count[0][t]++;
							//$fwrite (el, "%10d : %8s %0d %h %h%13s ; %s\n",cycleCnt, $sformatf("#%0d",commit_count[c][t]), t,
							//		trace_rv_i_address_ip[c][t][31+i*32 -:32], trace_rv_i_insn_ip[c][t][31+i*32-:32],
							//		(wb_dest[c][i0] !=0 && wb_valid[c][i0]) ?  $sformatf("%s=%h", abi_reg[c][wb_dest[c][i0]], wb_data[c][i0]) : "             ",
							//		dasm(trace_rv_i_insn_ip[c][t][31+i*32 -:32], trace_rv_i_address_ip[c][t][31+i*32-:32], wb_dest[c][i0] & {5{wb_valid[c][i0]}}, wb_data[c][i0], t)
							//		);
						end
				end
			end
            if(`DEC.dec_nonblock_load_wen[0]) begin
                //$fwrite (el, "%10d : %10d%22s=%h ; nbL\n", cycleCnt, `DEC.lsu_nonblock_load_data_tid, abi_reg[0][`DEC.dec_nonblock_load_waddr[c]], `DEC.lsu_nonblock_load_data);
                tb_top.gpr[c][`DEC.dec_nonblock_load_waddr[c]] = `DEC.lsu_nonblock_load_data;
            end
			// Core 1
// 			if(`DEC_1.dec_nonblock_load_wen[c]) begin
//                 //$fwrite (el, "%10d : %10d%22s=%h ; nbL\n", cycleCnt, `DEC_1.lsu_nonblock_load_data_tid, abi_reg[1][`DEC_1.dec_nonblock_load_waddr[c]], `DEC_1.lsu_nonblock_load_data);
//                 tb_top.gpr[c][`DEC_1.dec_nonblock_load_waddr[c]] = `DEC_1.lsu_nonblock_load_data;
//             end
//         end
        if(`DEC.exu_div_wren) begin
            //$fwrite (el, "%10d : %10d%22s=%h ; nbD\n", cycleCnt, `DEC.div_tid_wb, abi_reg[0][`DEC.div_waddr_wb], `DEC.exu_div_result);
            tb_top.gpr[`DEC.div_tid_wb][`DEC.div_waddr_wb] = `DEC.exu_div_result;
        end
		// Core 1
// 		if(`DEC_1.exu_div_wren) begin
//             //$fwrite (el, "%10d : %10d%22s=%h ; nbD\n", cycleCnt, `DEC_1.div_tid_wb, abi_reg[1][`DEC_1.div_waddr_wb], `DEC_1.exu_div_result);
//             tb_top.gpr[`DEC_1.div_tid_wb][`DEC_1.div_waddr_wb] = `DEC_1.exu_div_result;
//         end*/

         for(int t=0; t<`RV_NUM_THREADS; t++) begin
             if (trace_rv_i_valid_ip[0][t] !== 0) begin
//                 $fwrite(tp,"t%0d %b,%h,%h,%0h,%0h,3,%b,%h,%h,%b\n",t, trace_rv_i_valid_ip[0][t], trace_rv_i_address_ip[0][t][63:32], trace_rv_i_address_ip[0][t][31:0],
//                        trace_rv_i_insn_ip[0][t][63:32], trace_rv_i_insn_ip[0][t][31:0],trace_rv_i_exception_ip[0][t],trace_rv_i_ecause_ip[0][t],
//                        trace_rv_i_tval_ip[0][t],trace_rv_i_interrupt_ip[0][t]);
                // Basic trace - no exception register updates
                // #1 0 ee000000 b0201073 c 0b02       00000000
                for (int i=0; i<2; i++)
                    if (trace_rv_i_valid_ip[0][t][i]==1) begin
                        bit i0;
                        i0 = i != 0 || trace_rv_i_valid_ip[0][t]!=3 && wb_tid[0][1] == t && wb_valid[0][1];
                        commit_count[0][t]++;
//                         $fwrite (el, "%10d : %8s %0d %h %h%13s ; %s\n",cycleCnt, $sformatf("#%0d",commit_count[0][t]), t,
//                                 trace_rv_i_address_ip[0][t][31+i*32 -:32], trace_rv_i_insn_ip[0][t][31+i*32-:32],
//                                 (wb_dest[0][i0] !=0 && wb_valid[0][i0]) ?  $sformatf("%s=%h", abi_reg[0][wb_dest[0][i0]], wb_data[0][i0]) : "             ",
//                                 dasm(trace_rv_i_insn_ip[0][t][31+i*32 -:32], trace_rv_i_address_ip[0][t][31+i*32-:32], wb_dest[0][i0] & {5{wb_valid[0][i0]}}, wb_data[0][i0], t)
//                                 );
                    end
            end
            if(`DEC.dec_nonblock_load_wen[t]) begin
//                 $fwrite (el, "%10d : %10d%22s=%h ; nbL\n", cycleCnt, `DEC.lsu_nonblock_load_data_tid, abi_reg[0][`DEC.dec_nonblock_load_waddr[t]], `DEC.lsu_nonblock_load_data);
                tb_top.gpr[t][`DEC.dec_nonblock_load_waddr[t]] = `DEC.lsu_nonblock_load_data;
            end
        end
        if(`DEC.exu_div_wren) begin
//             $fwrite (el, "%10d : %10d%22s=%h ; nbD\n", cycleCnt, `DEC.div_tid_wb, abi_reg[0][`DEC.div_waddr_wb], `DEC.exu_div_result);
            tb_top.gpr[`DEC.div_tid_wb][`DEC.div_waddr_wb] = `DEC.exu_div_result;
        end

    end

    initial begin
		for(int c=0; c<`RV_NUM_CORES; c++) begin // Process both cores
			abi_reg[c][0] = "zero";
			abi_reg[c][1] = "ra";
			abi_reg[c][2] = "sp";
			abi_reg[c][3] = "gp";
			abi_reg[c][4] = "tp";
			abi_reg[c][5] = "t0";
			abi_reg[c][6] = "t1";
			abi_reg[c][7] = "t2";
			abi_reg[c][8] = "s0";
			abi_reg[c][9] = "s1";
			abi_reg[c][10] = "a0";
			abi_reg[c][11] = "a1";
			abi_reg[c][12] = "a2";
			abi_reg[c][13] = "a3";
			abi_reg[c][14] = "a4";
			abi_reg[c][15] = "a5";
			abi_reg[c][16] = "a6";
			abi_reg[c][17] = "a7";
			abi_reg[c][18] = "s2";
			abi_reg[c][19] = "s3";
			abi_reg[c][20] = "s4";
			abi_reg[c][21] = "s5";
			abi_reg[c][22] = "s6";
			abi_reg[c][23] = "s7";
			abi_reg[c][24] = "s8";
			abi_reg[c][25] = "s9";
			abi_reg[c][26] = "s10";
			abi_reg[c][27] = "s11";
			abi_reg[c][28] = "t3";
			abi_reg[c][29] = "t4";
			abi_reg[c][30] = "t5";
			abi_reg[c][31] = "t6";
		end
    // tie offs
        jtag_id[31:28] = 4'b1;
        jtag_id[27:12] = '0;
        jtag_id[11:1]  = 11'h45;
        reset_vector = 32'h0;
        nmi_vector   = 32'hee000000;
        nmi_int   = 0;

        $readmemh("program.hex",  lmem.mem);
        $readmemh("program.hex",  imem.mem);
        tp = $fopen("trace_port.csv","w");
        el = $fopen("exec.log","w");
        $fwrite (el, "//   Cycle : #inst  hart   pc    opcode    reg=value   ; mnemonic\n");
        $fwrite (el, "//---------------------------------------------------------------\n");
        fd = $fopen("console.log","w");
        preload_dccm();
        preload_iccm();

`ifndef VERILATOR
        if($test$plusargs("dumpon")) $dumpvars;
        forever  core_clk = #5 ~core_clk;
`endif
    end


    assign rst_l = cycleCnt > 5 && srstn;
    assign porst_l = cycleCnt > 2;

   //=========================================================================-
   // RTL instance
   //=========================================================================-
eh2_swerv_wrapper rvtop (
    .rst_l                  ( rst_l),
    .dbg_rst_l              ( porst_l       ),
    .clk                    ( core_clk      ),
    .rst_vec                ( reset_vector[31:1]),
    .nmi_int                ( nmi_int       ),
    .nmi_vec                ( nmi_vector[31:1]),
    .jtag_id                ( jtag_id[31:1]),

`ifdef RV_BUILD_AHB_LITE
    .haddr                  ( ic_haddr      ),
    .hburst                 ( ic_hburst     ),
    .hmastlock              ( ),
    .hprot                  ( ic_hprot      ),
    .hsize                  ( ic_hsize      ),
    .htrans                 ( ic_htrans     ),
    .hwrite                 ( ic_hwrite     ),

    .hrdata                 ( ic_hrdata     ),
    .hready                 ( ic_hready     ),
    .hresp                  ( ic_hresp      ),

    //---------------------------------------------------------------
    // Debug AHB Master
    //---------------------------------------------------------------
    .sb_haddr               (),
    .sb_hburst              (),
    .sb_hmastlock           (),
    .sb_hprot               (),
    .sb_hsize               (),
    .sb_htrans              (),
    .sb_hwrite              (),
    .sb_hwdata              (),

    .sb_hrdata              ('0),
    .sb_hready              ('1),
    .sb_hresp               ('0),

    //---------------------------------------------------------------
    // LSU AHB Master
    //---------------------------------------------------------------
    .lsu_haddr              ( lsu_haddr       ),
    .lsu_hburst             ( lsu_hburst      ),
    .lsu_hmastlock          ( ),
    .lsu_hprot              ( lsu_hprot       ),
    .lsu_hsize              ( lsu_hsize       ),
    .lsu_htrans             ( lsu_htrans      ),
    .lsu_hwrite             ( lsu_hwrite      ),
    .lsu_hwdata             ( lsu_hwdata      ),

    .lsu_hrdata             ( lsu_hrdata      ),
    .lsu_hready             ( lsu_hready      ),
    .lsu_hresp              ( lsu_hresp       ),

    //---------------------------------------------------------------
    // DMA Slave
    //---------------------------------------------------------------
    .dma_haddr              ( '0 ),
    .dma_hburst             ( '0 ),
    .dma_hmastlock          ( '0 ),
    .dma_hprot              ( '0 ),
    .dma_hsize              ( '0 ),
    .dma_htrans             ( '0 ),
    .dma_hwrite             ( '0 ),
    .dma_hwdata             ( '0 ),

    .dma_hrdata             (),
    .dma_hresp              (),
    .dma_hsel               ( 1'b1 ),
    .dma_hreadyin           ( 1'b1 ),
    .dma_hreadyout          (),
`endif
`ifdef RV_BUILD_AXI4
//-------------------------- LSU AXI signals--------------------------
    // AXI Write Channels
    .lsu_axi_awvalid        (lsu_axi_awvalid),
    .lsu_axi_awready        (lsu_axi_awready),
    .lsu_axi_awid           (lsu_axi_awid),
    .lsu_axi_awaddr         (lsu_axi_awaddr),
    .lsu_axi_awregion       (lsu_axi_awregion),
    .lsu_axi_awlen          (lsu_axi_awlen),
    .lsu_axi_awsize         (lsu_axi_awsize),
    .lsu_axi_awburst        (lsu_axi_awburst),
    .lsu_axi_awlock         (lsu_axi_awlock),
    .lsu_axi_awcache        (lsu_axi_awcache),
    .lsu_axi_awprot         (lsu_axi_awprot),
    .lsu_axi_awqos          (lsu_axi_awqos),

    .lsu_axi_wvalid         (lsu_axi_wvalid),
    .lsu_axi_wready         (lsu_axi_wready),
    .lsu_axi_wdata          (lsu_axi_wdata),
    .lsu_axi_wstrb          (lsu_axi_wstrb),
    .lsu_axi_wlast          (lsu_axi_wlast),

    .lsu_axi_bvalid         (lsu_axi_bvalid),
    .lsu_axi_bready         (lsu_axi_bready),
    .lsu_axi_bresp          (lsu_axi_bresp),
    .lsu_axi_bid            (lsu_axi_bid),


    .lsu_axi_arvalid        (lsu_axi_arvalid),
    .lsu_axi_arready        (lsu_axi_arready),
    .lsu_axi_arid           (lsu_axi_arid),
    .lsu_axi_araddr         (lsu_axi_araddr),
    .lsu_axi_arregion       (lsu_axi_arregion),
    .lsu_axi_arlen          (lsu_axi_arlen),
    .lsu_axi_arsize         (lsu_axi_arsize),
    .lsu_axi_arburst        (lsu_axi_arburst),
    .lsu_axi_arlock         (lsu_axi_arlock),
    .lsu_axi_arcache        (lsu_axi_arcache),
    .lsu_axi_arprot         (lsu_axi_arprot),
    .lsu_axi_arqos          (lsu_axi_arqos),

    .lsu_axi_rvalid         (lsu_axi_rvalid),
    .lsu_axi_rready         (lsu_axi_rready),
    .lsu_axi_rid            (lsu_axi_rid),
    .lsu_axi_rdata          (lsu_axi_rdata),
    .lsu_axi_rresp          (lsu_axi_rresp),
    .lsu_axi_rlast          (lsu_axi_rlast),

    //-------------------------- IFU AXI signals--------------------------
    // AXI Write Channels
    .ifu_axi_awvalid        (ifu_axi_awvalid),
    .ifu_axi_awready        (ifu_axi_awready),
    .ifu_axi_awid           (ifu_axi_awid),
    .ifu_axi_awaddr         (ifu_axi_awaddr),
    .ifu_axi_awregion       (ifu_axi_awregion),
    .ifu_axi_awlen          (ifu_axi_awlen),
    .ifu_axi_awsize         (ifu_axi_awsize),
    .ifu_axi_awburst        (ifu_axi_awburst),
    .ifu_axi_awlock         (ifu_axi_awlock),
    .ifu_axi_awcache        (ifu_axi_awcache),
    .ifu_axi_awprot         (ifu_axi_awprot),
    .ifu_axi_awqos          (ifu_axi_awqos),

    .ifu_axi_wvalid         (ifu_axi_wvalid),
    .ifu_axi_wready         (ifu_axi_wready),
    .ifu_axi_wdata          (ifu_axi_wdata),
    .ifu_axi_wstrb          (ifu_axi_wstrb),
    .ifu_axi_wlast          (ifu_axi_wlast),

    .ifu_axi_bvalid         (ifu_axi_bvalid),
    .ifu_axi_bready         (ifu_axi_bready),
    .ifu_axi_bresp          (ifu_axi_bresp),
    .ifu_axi_bid            (ifu_axi_bid),

    .ifu_axi_arvalid        (ifu_axi_arvalid),
    .ifu_axi_arready        (ifu_axi_arready),
    .ifu_axi_arid           (ifu_axi_arid),
    .ifu_axi_araddr         (ifu_axi_araddr),
    .ifu_axi_arregion       (ifu_axi_arregion),
    .ifu_axi_arlen          (ifu_axi_arlen),
    .ifu_axi_arsize         (ifu_axi_arsize),
    .ifu_axi_arburst        (ifu_axi_arburst),
    .ifu_axi_arlock         (ifu_axi_arlock),
    .ifu_axi_arcache        (ifu_axi_arcache),
    .ifu_axi_arprot         (ifu_axi_arprot),
    .ifu_axi_arqos          (ifu_axi_arqos),

    .ifu_axi_rvalid         (ifu_axi_rvalid),
    .ifu_axi_rready         (ifu_axi_rready),
    .ifu_axi_rid            (ifu_axi_rid),
    .ifu_axi_rdata          (ifu_axi_rdata),
    .ifu_axi_rresp          (ifu_axi_rresp),
    .ifu_axi_rlast          (ifu_axi_rlast),

    //-------------------------- SB AXI signals--------------------------
    // AXI Write Channels
    .sb_axi_awvalid         (sb_axi_awvalid),
    .sb_axi_awready         (sb_axi_awready),
    .sb_axi_awid            (sb_axi_awid),
    .sb_axi_awaddr          (sb_axi_awaddr),
    .sb_axi_awregion        (sb_axi_awregion),
    .sb_axi_awlen           (sb_axi_awlen),
    .sb_axi_awsize          (sb_axi_awsize),
    .sb_axi_awburst         (sb_axi_awburst),
    .sb_axi_awlock          (sb_axi_awlock),
    .sb_axi_awcache         (sb_axi_awcache),
    .sb_axi_awprot          (sb_axi_awprot),
    .sb_axi_awqos           (sb_axi_awqos),

    .sb_axi_wvalid          (sb_axi_wvalid),
    .sb_axi_wready          (sb_axi_wready),
    .sb_axi_wdata           (sb_axi_wdata),
    .sb_axi_wstrb           (sb_axi_wstrb),
    .sb_axi_wlast           (sb_axi_wlast),

    .sb_axi_bvalid          (sb_axi_bvalid),
    .sb_axi_bready          (sb_axi_bready),
    .sb_axi_bresp           (sb_axi_bresp),
    .sb_axi_bid             (sb_axi_bid),


    .sb_axi_arvalid         (sb_axi_arvalid),
    .sb_axi_arready         (sb_axi_arready),
    .sb_axi_arid            (sb_axi_arid),
    .sb_axi_araddr          (sb_axi_araddr),
    .sb_axi_arregion        (sb_axi_arregion),
    .sb_axi_arlen           (sb_axi_arlen),
    .sb_axi_arsize          (sb_axi_arsize),
    .sb_axi_arburst         (sb_axi_arburst),
    .sb_axi_arlock          (sb_axi_arlock),
    .sb_axi_arcache         (sb_axi_arcache),
    .sb_axi_arprot          (sb_axi_arprot),
    .sb_axi_arqos           (sb_axi_arqos),

    .sb_axi_rvalid          (sb_axi_rvalid),
    .sb_axi_rready          (sb_axi_rready),
    .sb_axi_rid             (sb_axi_rid),
    .sb_axi_rdata           (sb_axi_rdata),
    .sb_axi_rresp           (sb_axi_rresp),
    .sb_axi_rlast           (sb_axi_rlast),

    //-------------------------- DMA AXI signals--------------------------
    // AXI Write Channels
    .dma_axi_awvalid        (dma_axi_awvalid),
    .dma_axi_awready        (dma_axi_awready),
    .dma_axi_awid           ('0),
    .dma_axi_awaddr         (lsu_axi_awaddr),
    .dma_axi_awsize         (lsu_axi_awsize),
    .dma_axi_awprot         (lsu_axi_awprot),
    .dma_axi_awlen          (lsu_axi_awlen),
    .dma_axi_awburst        (lsu_axi_awburst),


    .dma_axi_wvalid         (dma_axi_wvalid),
    .dma_axi_wready         (dma_axi_wready),
    .dma_axi_wdata          (lsu_axi_wdata),
    .dma_axi_wstrb          (lsu_axi_wstrb),
    .dma_axi_wlast          (lsu_axi_wlast),

    .dma_axi_bvalid         (dma_axi_bvalid),
    .dma_axi_bready         (dma_axi_bready),
    .dma_axi_bresp          (dma_axi_bresp),
    .dma_axi_bid            (),


    .dma_axi_arvalid        (dma_axi_arvalid),
    .dma_axi_arready        (dma_axi_arready),
    .dma_axi_arid           ('0),
    .dma_axi_araddr         (lsu_axi_araddr),
    .dma_axi_arsize         (lsu_axi_arsize),
    .dma_axi_arprot         (lsu_axi_arprot),
    .dma_axi_arlen          (lsu_axi_arlen),
    .dma_axi_arburst        (lsu_axi_arburst),

    .dma_axi_rvalid         (dma_axi_rvalid),
    .dma_axi_rready         (dma_axi_rready),
    .dma_axi_rid            (),
    .dma_axi_rdata          (dma_axi_rdata),
    .dma_axi_rresp          (dma_axi_rresp),
    .dma_axi_rlast          (dma_axi_rlast),
`endif
    .timer_int              ( '0  ),
    .extintsrc_req          ( '0  ),

    .lsu_bus_clk_en         ( 1'b1  ),
    .ifu_bus_clk_en         ( 1'b1  ),
    .dbg_bus_clk_en         ( 1'b1  ),
    .dma_bus_clk_en         ( 1'b1  ),


    .dccm_ext_in_pkt        ('0),
    .iccm_ext_in_pkt        ('0),
    .ic_data_ext_in_pkt     ('0),
    .ic_tag_ext_in_pkt      ('0),
    .btb_ext_in_pkt         ('0),
    .trace_rv_i_insn_ip     (trace_rv_i_insn_ip),
    .trace_rv_i_address_ip  (trace_rv_i_address_ip),
    .trace_rv_i_valid_ip    (trace_rv_i_valid_ip),
    .trace_rv_i_exception_ip(trace_rv_i_exception_ip),
    .trace_rv_i_ecause_ip   (trace_rv_i_ecause_ip),
    .trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip),
    .trace_rv_i_tval_ip     (trace_rv_i_tval_ip),

    .jtag_tck               ( tck  ),
    .jtag_tms               ( tms  ),
    .jtag_tdi               ( tdi  ),
    .jtag_trst_n            ( trstn  ),
    .jtag_tdo               ( tdo ),

    .mpc_debug_halt_ack     ( ),
    .mpc_debug_halt_req     ('0),
    .mpc_debug_run_ack      (),
    .mpc_debug_run_req      ('1),
    .mpc_reset_run_req      ('1),
     .debug_brkpt_status    (),

    .i_cpu_halt_req         ('0),
    .o_cpu_halt_ack         (),
    .o_cpu_halt_status      (),
    .i_cpu_run_req          ('0),
    .o_debug_mode_status    (),
    .o_cpu_run_ack          (),

    .dec_tlu_perfcnt0       (),
    .dec_tlu_perfcnt1       (),
    .dec_tlu_perfcnt2       (),
    .dec_tlu_perfcnt3       (),
    .dec_tlu_mhartstart     (),

    .soft_int               ('0),
    .core_id                ('0),
    .scan_mode              ( 1'b0 ),
    .mbist_mode             ( 1'b0 )

);

bit openocd;
initial begin
    openocd = $test$plusargs("openocd");
end

SimJTAG #2 jtag_drv(

    .clock(core_clk),
    .reset(~porst_l),

    .enable(openocd),
    .init_done(porst_l),

    .jtag_TCK(tck),
    .jtag_TMS(tms),
    .jtag_TDI(tdi),
    .jtag_TRSTn(trstn),

    .jtag_TDO_data(tdo),
    .jtag_TDO_driven(1'b1),
    .srstn(srstn),

    .exit()
);


function string dmi_reg_name ( int ra);
    case(ra)
    'h4:  return "DATA0    ";
    'h5:  return "DATA1    ";
    'h10: return "DM_CNTL  ";
    'h11: return "DM_STATUS";
    'h15: return "HAWINDOW ";
    'h16: return "AB_CS    ";
    'h17: return "AB_CMD   ";
    'h38: return "SB_CS    ";
    'h39: return "SB_ADDR0 ";
    'h3c: return "SB_DATA0 ";
    'h3d: return "SB_DATA1 ";
    'h40: return "HALTSUM  ";
    default: return $sformatf("0x%0h   ", ra);
    endcase
endfunction

bit reg_read;
bit[7:0] reg_addr;

// REVISE THIS
// Debug Module monitor
always @ (posedge core_clk) begin
    if(`CPU_TOP.dmi_reg_wr_en)
        $display("DM: %10d Write %s = %h", cycleCnt, dmi_reg_name(`CPU_TOP.dmi_reg_addr),`CPU_TOP.dmi_reg_wdata);
    reg_read <= `CPU_TOP.dmi_reg_en & ~`CPU_TOP.dmi_reg_wr_en;
    reg_addr <= `CPU_TOP.dmi_reg_addr;
    if(reg_read)
        $display("DM: %10d Read  %s = %h", cycleCnt, dmi_reg_name(reg_addr),`CPU_TOP.dmi_reg_rdata);
        
//     if(`CPU_TOP_1.dmi_reg_wr_en)
//     $display("DM: %10d Write %s = %h", cycleCnt, dmi_reg_name(`CPU_TOP_1.dmi_reg_addr),`CPU_TOP_1.dmi_reg_wdata);
//     reg_read <= `CPU_TOP_1.dmi_reg_en & ~`CPU_TOP_1.dmi_reg_wr_en;
//     reg_addr <= `CPU_TOP_1.dmi_reg_addr;
//     if(reg_read)
//         $display("DM: %10d Read  %s = %h", cycleCnt, dmi_reg_name(reg_addr),`CPU_TOP_1.dmi_reg_rdata);
end

`ifdef RV_BUILD_AHB_LITE

ahb_sif imem (
     // Inputs
     .HWDATA(64'h0),
     .HCLK(core_clk),
     .HSEL(1'b1),
     .HPROT(ic_hprot),
     .HWRITE(ic_hwrite),
     .HTRANS(ic_htrans),
     .HSIZE(ic_hsize),
     .HREADY(ic_hready),
     .HRESETn(rst_l),
     .HADDR(ic_haddr),
     .HBURST(ic_hburst),

     // Outputs
     .HREADYOUT(ic_hready),
     .HRESP(ic_hresp),
     .HRDATA(ic_hrdata)
);


ahb_sif lmem (
     // Inputs
     .HWDATA(lsu_hwdata),
     .HCLK(core_clk),
     .HSEL(1'b1),
     .HPROT(lsu_hprot),
     .HWRITE(lsu_hwrite),
     .HTRANS(lsu_htrans),
     .HSIZE(lsu_hsize),
     .HREADY(lsu_hready),
     .HRESETn(rst_l),
     .HADDR(lsu_haddr),
     .HBURST(lsu_hburst),

     // Outputs
     .HREADYOUT(lsu_hready),
     .HRESP(lsu_hresp),
     .HRDATA(lsu_hrdata)
);

`endif


`ifdef RV_BUILD_AXI4

axi_slv #(.TAGW(`RV_IFU_BUS_TAG)) imem(
    .aclk(core_clk),
    .rst_l(rst_l),
    .arvalid(ifu_axi_arvalid),
    .arready(ifu_axi_arready),
    .araddr(ifu_axi_araddr),
    .arid(ifu_axi_arid),
    .arlen(ifu_axi_arlen),
    .arburst(ifu_axi_arburst),
    .arsize(ifu_axi_arsize),

    .rvalid(ifu_axi_rvalid),
    .rready(ifu_axi_rready),
    .rdata(ifu_axi_rdata),
    .rresp(ifu_axi_rresp),
    .rid(ifu_axi_rid),
    .rlast(ifu_axi_rlast),

    .awvalid(1'b0),
    .awready(),
    .awaddr('0),
    .awid('0),
    .awlen('0),
    .awburst('0),
    .awsize('0),

    .wdata('0),
    .wstrb('0),
    .wvalid(1'b0),
    .wready(),

    .bvalid(),
    .bready(1'b0),
    .bresp(),
    .bid()
);


axi_slv #(.TAGW(`RV_LSU_BUS_TAG)) lmem(
    .aclk(core_clk),
    .rst_l(rst_l),
    .arvalid(lmem_axi_arvalid),
    .arready(lmem_axi_arready),
    .araddr(lsu_axi_araddr),
    .arid(lsu_axi_arid),
    .arlen(lsu_axi_arlen),
    .arburst(lsu_axi_arburst),
    .arsize(lsu_axi_arsize),

    .rvalid(lmem_axi_rvalid),
    .rready(lmem_axi_rready),
    .rdata(lmem_axi_rdata),
    .rresp(lmem_axi_rresp),
    .rid(lmem_axi_rid),
    .rlast(lmem_axi_rlast),

    .awvalid(lmem_axi_awvalid),
    .awready(lmem_axi_awready),
    .awaddr(lsu_axi_awaddr),
    .awid(lsu_axi_awid),
    .awlen(lsu_axi_awlen),
    .awburst(lsu_axi_awburst),
    .awsize(lsu_axi_awsize),

    .wdata(lsu_axi_wdata),
    .wstrb(lsu_axi_wstrb),
    .wvalid(lmem_axi_wvalid),
    .wready(lmem_axi_wready),

    .bvalid(lmem_axi_bvalid),
    .bready(lmem_axi_bready),
    .bresp(lmem_axi_bresp),
    .bid(lmem_axi_bid)
);


axi_lsu_dma_bridge # (`RV_LSU_BUS_TAG,`RV_LSU_BUS_TAG ) bridge(
    .clk(core_clk),
    .reset_l(rst_l),

    .m_arvalid(lsu_axi_arvalid[0]),
    .m_arid(lsu_axi_arid[0]),
    .m_araddr(lsu_axi_araddr[0]),
    .m_arready(lsu_axi_arready[0]),

    .m_rvalid(lsu_axi_rvalid[0]),
    .m_rready(lsu_axi_rready[0]),
    .m_rdata(lsu_axi_rdata[0]),
    .m_rid(lsu_axi_rid[0]),
    .m_rresp(lsu_axi_rresp[0]),
    .m_rlast(lsu_axi_rlast[0]),

    .m_awvalid(lsu_axi_awvalid[0]),
    .m_awid(lsu_axi_awid[0]),
    .m_awaddr(lsu_axi_awaddr[0]),
    .m_awready(lsu_axi_awready[0]),

    .m_wvalid(lsu_axi_wvalid[0]),
    .m_wready(lsu_axi_wready[0]),

    .m_bresp(lsu_axi_bresp[0]),
    .m_bvalid(lsu_axi_bvalid[0]),
    .m_bid(lsu_axi_bid[0]),
    .m_bready(lsu_axi_bready[0]),

    .s0_arvalid(lmem_axi_arvalid[0]),
    .s0_arready(lmem_axi_arready[0]),

    .s0_rvalid(lmem_axi_rvalid[0]),
    .s0_rid(lmem_axi_rid[0]),
    .s0_rresp(lmem_axi_rresp[0]),
    .s0_rdata(lmem_axi_rdata[0]),
    .s0_rlast(lmem_axi_rlast[0]),
    .s0_rready(lmem_axi_rready[0]),

    .s0_awvalid(lmem_axi_awvalid[0]),
    .s0_awready(lmem_axi_awready[0]),

    .s0_wvalid(lmem_axi_wvalid[0]),
    .s0_wready(lmem_axi_wready[0]),

    .s0_bresp(lmem_axi_bresp[0]),
    .s0_bvalid(lmem_axi_bvalid[0]),
    .s0_bid(lmem_axi_bid[0]),
    .s0_bready(lmem_axi_bready[0]),


    .s1_arvalid(dma_axi_arvalid[0]),
    .s1_arready(dma_axi_arready[0]),

    .s1_rvalid(dma_axi_rvalid[0]),
    .s1_rresp(dma_axi_rresp[0]),
    .s1_rdata(dma_axi_rdata[0]),
    .s1_rlast(dma_axi_rlast[0]),
    .s1_rready(dma_axi_rready[0]),

    .s1_awvalid(dma_axi_awvalid[0]),
    .s1_awready(dma_axi_awready[0]),

    .s1_wvalid(dma_axi_wvalid[0]),
    .s1_wready(dma_axi_wready[0]),

    .s1_bresp(dma_axi_bresp[0]),
    .s1_bvalid(dma_axi_bvalid[0]),
    .s1_bready(dma_axi_bready[0])
);

axi_lsu_dma_bridge # (`RV_LSU_BUS_TAG,`RV_LSU_BUS_TAG ) bridge_1(
    .clk(core_clk),
    .reset_l(rst_l),

    .m_arvalid(lsu_axi_arvalid[1]),
    .m_arid(lsu_axi_arid[1]),
    .m_araddr(lsu_axi_araddr[1]),
    .m_arready(lsu_axi_arready[1]),

    .m_rvalid(lsu_axi_rvalid[1]),
    .m_rready(lsu_axi_rready[1]),
    .m_rdata(lsu_axi_rdata[1]),
    .m_rid(lsu_axi_rid[1]),
    .m_rresp(lsu_axi_rresp[1]),
    .m_rlast(lsu_axi_rlast[1]),

    .m_awvalid(lsu_axi_awvalid[1]),
    .m_awid(lsu_axi_awid[1]),
    .m_awaddr(lsu_axi_awaddr[1]),
    .m_awready(lsu_axi_awready[1]),

    .m_wvalid(lsu_axi_wvalid[1]),
    .m_wready(lsu_axi_wready[1]),

    .m_bresp(lsu_axi_bresp[1]),
    .m_bvalid(lsu_axi_bvalid[1]),
    .m_bid(lsu_axi_bid[1]),
    .m_bready(lsu_axi_bready[1]),

    .s0_arvalid(lmem_axi_arvalid[1]),
    .s0_arready(lmem_axi_arready[1]),

    .s0_rvalid(lmem_axi_rvalid[1]),
    .s0_rid(lmem_axi_rid[1]),
    .s0_rresp(lmem_axi_rresp[1]),
    .s0_rdata(lmem_axi_rdata[1]),
    .s0_rlast(lmem_axi_rlast[1]),
    .s0_rready(lmem_axi_rready[1]),

    .s0_awvalid(lmem_axi_awvalid[1]),
    .s0_awready(lmem_axi_awready[1]),

    .s0_wvalid(lmem_axi_wvalid[1]),
    .s0_wready(lmem_axi_wready[1]),

    .s0_bresp(lmem_axi_bresp[1]),
    .s0_bvalid(lmem_axi_bvalid[1]),
    .s0_bid(lmem_axi_bid[1]),
    .s0_bready(lmem_axi_bready[1]),


    .s1_arvalid(dma_axi_arvalid[1]),
    .s1_arready(dma_axi_arready[1]),

    .s1_rvalid(dma_axi_rvalid[1]),
    .s1_rresp(dma_axi_rresp[1]),
    .s1_rdata(dma_axi_rdata[1]),
    .s1_rlast(dma_axi_rlast[1]),
    .s1_rready(dma_axi_rready[1]),

    .s1_awvalid(dma_axi_awvalid[1]),
    .s1_awready(dma_axi_awready[1]),

    .s1_wvalid(dma_axi_wvalid[1]),
    .s1_wready(dma_axi_wready[1]),

    .s1_bresp(dma_axi_bresp[1]),
    .s1_bvalid(dma_axi_bvalid[1]),
    .s1_bready(dma_axi_bready[1])
);

`endif

task preload_iccm;
bit[31:0] data;
bit[31:0] addr, eaddr, saddr;

bit core;

/*
addresses:
 0xfffffff0 - ICCM start address to load
 0xfffffff4 - ICCM end address to load
*/
`ifndef VERILATOR
	init_iccm();
// 	init_iccm_1();
`endif
addr = 'hffff_fff0;
saddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
if ( (saddr < `RV_ICCM_SADR) || (saddr > `RV_ICCM_EADR)) return;
`ifndef RV_ICCM_ENABLE
    $display("********************************************************");
    $display("ICCM preload: there is no ICCM in SweRV, terminating !!!");
    $display("********************************************************");
    $finish;
`endif
addr += 4;
eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
$display("ICCM_0 pre-load from %h to %h", saddr, eaddr);
for(addr= saddr; addr <= eaddr; addr+=4) begin
    data = {imem.mem[addr+3],imem.mem[addr+2],imem.mem[addr+1],imem.mem[addr]};
    slam_iccm_ram(addr, data == 0 ? 0 : {riscv_ecc32(data),data});
end

// addr = 'hffff_fff0; // Same address for now
// saddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
// if ( (saddr < `RV_ICCM_SADR) || (saddr > `RV_ICCM_EADR)) return;
// `ifndef RV_ICCM_ENABLE
//     $display("********************************************************");
//     $display("ICCM preload: there is no ICCM in SweRV, terminating !!!");
//     $display("********************************************************");
//     $finish;
// `endif
// addr += 4;
// eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
// $display("ICCM_1 pre-load from %h to %h", saddr, eaddr);
// for(addr= saddr; addr <= eaddr; addr+=4) begin
//     data = {imem.mem[addr+3],imem.mem[addr+2],imem.mem[addr+1],imem.mem[addr]};
//     slam_iccm_ram_1(addr, data == 0 ? 0 : {riscv_ecc32(data),data});
// end

endtask


task preload_dccm;
bit[31:0] data;
bit[31:0] addr, saddr, eaddr;

/*
addresses:
 0xffff_fff8 - DCCM start address to load
 0xffff_fffc - DCCM end address to load
*/
`ifndef VERILATOR
	init_dccm();
// 	init_dccm_1();
`endif

addr = 'hffff_fff8;
saddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
if (saddr < `RV_DCCM_SADR || saddr > `RV_DCCM_EADR) return;
`ifndef RV_DCCM_ENABLE
    $display("********************************************************");
    $display("DCCM_0 preload: there is no DCCM in SweRV, terminating !!!");
    $display("********************************************************");
    $finish;
`endif
addr += 4;
eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
$display("DCCM pre-load from %h to %h", saddr, eaddr);

for(addr=saddr; addr <= eaddr; addr+=4) begin
	data = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
	slam_dccm_ram(addr, data == 0 ? 0 : {riscv_ecc32(data),data});
end


// Core 1
// addr = 'hffff_fff8; // Same address for now
// saddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
// if (saddr < `RV_DCCM_SADR || saddr > `RV_DCCM_EADR) return;
// `ifndef RV_DCCM_ENABLE
//     $display("********************************************************");
//     $display("DCCM preload: there is no DCCM in SweRV, terminating !!!");
//     $display("********************************************************");
//     $finish;
// `endif
// addr += 4;
// eaddr = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
// $display("DCCM_1 pre-load from %h to %h", saddr, eaddr);
// 
// for(addr=saddr; addr <= eaddr; addr+=4) begin
// 	data = {lmem.mem[addr+3],lmem.mem[addr+2],lmem.mem[addr+1],lmem.mem[addr]};
// 	slam_dccm_ram_1(addr, data == 0 ? 0 : {riscv_ecc32(data),data});
// end

endtask

`define ICCM_PATH `RV_TOP.mem.iccm.iccm_0
`define ICCM_PATH_1 `RV_TOP.mem.iccm.iccm_1
`ifdef VERILATOR
`define DRAM(bk) rvtop.mem.Gen_dccm_enable.dccm_0.mem_bank[bk].ram.ram_core
`define IRAM(bk) `ICCM_PATH.mem_bank[bk].iccm_bank.ram_core
`define DRAM_1(bk) rvtop.mem.Gen_dccm_enable.dccm_1.mem_bank[bk].ram.ram_core
`define IRAM_1(bk) `ICCM_PATH_1.mem_bank[bk].iccm_bank.ram_core
`else
`define DRAM(bk) rvtop.mem.Gen_dccm_enable.dccm_0.mem_bank[bk].dccm.dccm_bank.ram_core
`define IRAM(bk) `ICCM_PATH.mem_bank[bk].iccm_0.iccm_bank.ram_core
`define DRAM_1(bk) rvtop.mem.Gen_dccm_enable.dccm_1.mem_bank[bk].dccm.dccm_bank.ram_core
`define IRAM_1(bk) `ICCM_PATH_1.mem_bank[bk].iccm_1.iccm_bank.ram_core
`endif


task slam_dccm_ram(input [31:0] addr, input[38:0] data);
int bank, indx;
bank = get_dccm_bank(addr, indx);
`ifdef RV_DCCM_ENABLE
case(bank)
0: `DRAM(0)[indx] = data;
1: `DRAM(1)[indx] = data;
`ifdef RV_DCCM_NUM_BANKS_4
2: `DRAM(2)[indx] = data;
3: `DRAM(3)[indx] = data;
`endif
`ifdef RV_DCCM_NUM_BANKS_8
2: `DRAM(2)[indx] = data;
3: `DRAM(3)[indx] = data;
4: `DRAM(4)[indx] = data;
5: `DRAM(5)[indx] = data;
6: `DRAM(6)[indx] = data;
7: `DRAM(7)[indx] = data;
`endif
endcase
`endif
endtask

task slam_dccm_ram_1(input [31:0] addr, input[38:0] data);
int bank, indx;
bank = get_dccm_bank(addr, indx);
`ifdef RV_DCCM_ENABLE
case(bank)
0: `DRAM_1(0)[indx] = data;
1: `DRAM_1(1)[indx] = data;
`ifdef RV_DCCM_NUM_BANKS_4
2: `DRAM_1(2)[indx] = data;
3: `DRAM_1(3)[indx] = data;
`endif
`ifdef RV_DCCM_NUM_BANKS_8
2: `DRAM_1(2)[indx] = data;
3: `DRAM_1(3)[indx] = data;
4: `DRAM_1(4)[indx] = data;
5: `DRAM_1(5)[indx] = data;
6: `DRAM_1(6)[indx] = data;
7: `DRAM_1(7)[indx] = data;
`endif
endcase
`endif
endtask

task init_dccm;
`ifdef RV_DCCM_ENABLE
    `DRAM(0) = '{default:39'h0};
    `DRAM(1) = '{default:39'h0};
`ifdef RV_DCCM_NUM_BANKS_4
    `DRAM(2) = '{default:39'h0};
    `DRAM(3) = '{default:39'h0};
`endif
`ifdef RV_DCCM_NUM_BANKS_8
    `DRAM(2) = '{default:39'h0};
    `DRAM(3) = '{default:39'h0};
    `DRAM(4) = '{default:39'h0};
    `DRAM(5) = '{default:39'h0};
    `DRAM(6) = '{default:39'h0};
    `DRAM(7) = '{default:39'h0};
`endif
`endif
endtask

task init_dccm_1;
`ifdef RV_DCCM_ENABLE
    `DRAM_1(0) = '{default:39'h0};
    `DRAM_1(1) = '{default:39'h0};
`ifdef RV_DCCM_NUM_BANKS_4
    `DRAM_1(2) = '{default:39'h0};
    `DRAM_1(3) = '{default:39'h0};
`endif
`ifdef RV_DCCM_NUM_BANKS_8
    `DRAM_1(2) = '{default:39'h0};
    `DRAM_1(3) = '{default:39'h0};
    `DRAM_1(4) = '{default:39'h0};
    `DRAM_1(5) = '{default:39'h0};
    `DRAM_1(6) = '{default:39'h0};
    `DRAM_1(7) = '{default:39'h0};
`endif
`endif
endtask


task slam_iccm_ram( input[31:0] addr, input[38:0] data);
int bank, idx;

bank = get_iccm_bank(addr, idx);
`ifdef RV_ICCM_ENABLE
case(bank) // {
  0: `IRAM(0)[idx] = data;
  1: `IRAM(1)[idx] = data;
  2: `IRAM(2)[idx] = data;
  3: `IRAM(3)[idx] = data;

 `ifdef RV_ICCM_NUM_BANKS_8
  4: `IRAM(4)[idx] = data;
  5: `IRAM(5)[idx] = data;
  6: `IRAM(6)[idx] = data;
  7: `IRAM(7)[idx] = data;
 `endif

 `ifdef RV_ICCM_NUM_BANKS_16
  4: `IRAM(4)[idx] = data;
  5: `IRAM(5)[idx] = data;
  6: `IRAM(6)[idx] = data;
  7: `IRAM(7)[idx] = data;
  8: `IRAM(8)[idx] = data;
  9: `IRAM(9)[idx] = data;
  10: `IRAM(10)[idx] = data;
  11: `IRAM(11)[idx] = data;
  12: `IRAM(12)[idx] = data;
  13: `IRAM(13)[idx] = data;
  14: `IRAM(14)[idx] = data;
  15: `IRAM(15)[idx] = data;
 `endif
endcase // }
`endif
endtask

task slam_iccm_ram_1( input[31:0] addr, input[38:0] data);
int bank, idx;

bank = get_iccm_bank(addr, idx);
`ifdef RV_ICCM_ENABLE
case(bank) // {
  0: `IRAM_1(0)[idx] = data;
  1: `IRAM_1(1)[idx] = data;
  2: `IRAM_1(2)[idx] = data;
  3: `IRAM_1(3)[idx] = data;

 `ifdef RV_ICCM_NUM_BANKS_8
  4: `IRAM_1(4)[idx] = data;
  5: `IRAM_1(5)[idx] = data;
  6: `IRAM_1(6)[idx] = data;
  7: `IRAM_1(7)[idx] = data;
 `endif

 `ifdef RV_ICCM_NUM_BANKS_16
  4: `IRAM_1(4)[idx] = data;
  5: `IRAM_1(5)[idx] = data;
  6: `IRAM_1(6)[idx] = data;
  7: `IRAM_1(7)[idx] = data;
  8: `IRAM_1(8)[idx] = data;
  9: `IRAM_1(9)[idx] = data;
  10: `IRAM_1(10)[idx] = data;
  11: `IRAM_1(11)[idx] = data;
  12: `IRAM_1(12)[idx] = data;
  13: `IRAM_1(13)[idx] = data;
  14: `IRAM_1(14)[idx] = data;
  15: `IRAM_1(15)[idx] = data;
 `endif
endcase // }
`endif
endtask

task init_iccm;
`ifdef RV_ICCM_ENABLE
    `IRAM(0) = '{default:39'h0};
    `IRAM(1) = '{default:39'h0};
    `IRAM(2) = '{default:39'h0};
    `IRAM(3) = '{default:39'h0};

`ifdef RV_ICCM_NUM_BANKS_8
    `IRAM(4) = '{default:39'h0};
    `IRAM(5) = '{default:39'h0};
    `IRAM(6) = '{default:39'h0};
    `IRAM(7) = '{default:39'h0};
`endif

`ifdef RV_ICCM_NUM_BANKS_16
    `IRAM(4) = '{default:39'h0};
    `IRAM(5) = '{default:39'h0};
    `IRAM(6) = '{default:39'h0};
    `IRAM(7) = '{default:39'h0};
    `IRAM(8) = '{default:39'h0};
    `IRAM(9) = '{default:39'h0};
    `IRAM(10) = '{default:39'h0};
    `IRAM(11) = '{default:39'h0};
    `IRAM(12) = '{default:39'h0};
    `IRAM(13) = '{default:39'h0};
    `IRAM(14) = '{default:39'h0};
    `IRAM(15) = '{default:39'h0};
 `endif
`endif
endtask

task init_iccm_1;
`ifdef RV_ICCM_ENABLE
    `IRAM_1(0) = '{default:39'h0};
    `IRAM_1(1) = '{default:39'h0};
    `IRAM_1(2) = '{default:39'h0};
    `IRAM_1(3) = '{default:39'h0};

`ifdef RV_ICCM_NUM_BANKS_8
    `IRAM_1(4) = '{default:39'h0};
    `IRAM_1(5) = '{default:39'h0};
    `IRAM_1(6) = '{default:39'h0};
    `IRAM_1(7) = '{default:39'h0};
`endif

`ifdef RV_ICCM_NUM_BANKS_16
    `IRAM_1(4) = '{default:39'h0};
    `IRAM_1(5) = '{default:39'h0};
    `IRAM_1(6) = '{default:39'h0};
    `IRAM_1(7) = '{default:39'h0};
    `IRAM_1(8) = '{default:39'h0};
    `IRAM_1(9) = '{default:39'h0};
    `IRAM_1(10) = '{default:39'h0};
    `IRAM_1(11) = '{default:39'h0};
    `IRAM_1(12) = '{default:39'h0};
    `IRAM_1(13) = '{default:39'h0};
    `IRAM_1(14) = '{default:39'h0};
    `IRAM_1(15) = '{default:39'h0};
 `endif
`endif
endtask


function[6:0] riscv_ecc32(input[31:0] data);
reg[6:0] synd;
synd[0] = ^(data & 32'h56aa_ad5b);
synd[1] = ^(data & 32'h9b33_366d);
synd[2] = ^(data & 32'he3c3_c78e);
synd[3] = ^(data & 32'h03fc_07f0);
synd[4] = ^(data & 32'h03ff_f800);
synd[5] = ^(data & 32'hfc00_0000);
synd[6] = ^{data, synd[5:0]};
return synd;
endfunction

function int get_dccm_bank(input[31:0] addr,  output int bank_idx);
`ifdef RV_DCCM_NUM_BANKS_2
    bank_idx = int'(addr[`RV_DCCM_BITS-1:3]);
    return int'( addr[2]);
`elsif RV_DCCM_NUM_BANKS_4
    bank_idx = int'(addr[`RV_DCCM_BITS-1:4]);
    return int'(addr[3:2]);
`elsif RV_DCCM_NUM_BANKS_8
    bank_idx = int'(addr[`RV_DCCM_BITS-1:5]);
    return int'( addr[4:2]);
`endif
endfunction

function int get_iccm_bank(input[31:0] addr,  output int bank_idx);
`ifdef RV_ICCM_NUM_BANKS_4
    bank_idx = int'(addr[`RV_ICCM_BITS-1:4]);
    return int'(addr[3:2]);
`elsif RV_ICCM_NUM_BANKS_8
    bank_idx = int'(addr[`RV_ICCM_BITS-1:5]);
    return int'( addr[4:2]);
`elsif RV_ICCM_NUM_BANKS_16
    bank_idx = int'(addr[`RV_ICCM_BITS-1:6]);
    return int'( addr[5:2]);
`endif
endfunction

/* verilator lint_off CASEINCOMPLETE */
`include "dasm.svi"
/* verilator lint_on CASEINCOMPLETE */



endmodule