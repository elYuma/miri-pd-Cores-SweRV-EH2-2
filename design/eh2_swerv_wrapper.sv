// SPDX-License-Identifier: Apache-2.0
// Copyright 2020 Western Digital Corporation or its affiliates.
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

//********************************************************************************
// $Id$
//
// Function: Top wrapper file with eh2_swerv/mem instantiated inside
// Comments:
//
//********************************************************************************
module eh2_swerv_wrapper
import eh2_pkg::*;
#(
`include "eh2_param.vh"
) (
   // Input / Output definitions for Core 0  
   input logic                       clk,
   input logic [pt.NUM_CORES-1:0]                       rst_l,
   input logic [pt.NUM_CORES-1:0]                       dbg_rst_l,
   input logic [pt.NUM_CORES-1:0] [31:1]                rst_vec,
   input logic [pt.NUM_CORES-1:0]                       nmi_int,
   input logic [pt.NUM_CORES-1:0] [31:1]                nmi_vec,
   input logic [pt.NUM_CORES-1:0] [31:1]                jtag_id,


   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [63:0] trace_rv_i_insn_ip,
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [63:0] trace_rv_i_address_ip,
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0]  trace_rv_i_valid_ip,
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0]  trace_rv_i_exception_ip,
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [4:0]  trace_rv_i_ecause_ip,
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0]  trace_rv_i_interrupt_ip,
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [31:0] trace_rv_i_tval_ip,

   // Bus signals

`ifdef RV_BUILD_AXI4
   //-------------------------- LSU AXI signals--------------------------
   // AXI Write Channels
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_awvalid,
   input  logic [pt.NUM_CORES-1:0]                            lsu_axi_awready,
   output logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]       lsu_axi_awid,
   output logic [pt.NUM_CORES-1:0] [31:0]                     lsu_axi_awaddr,
   output logic [pt.NUM_CORES-1:0] [3:0]                      lsu_axi_awregion,
   output logic [pt.NUM_CORES-1:0] [7:0]                      lsu_axi_awlen,
   output logic [pt.NUM_CORES-1:0] [2:0]                      lsu_axi_awsize,
   output logic [pt.NUM_CORES-1:0] [1:0]                      lsu_axi_awburst,
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_awlock,
   output logic [pt.NUM_CORES-1:0] [3:0]                      lsu_axi_awcache,
   output logic [pt.NUM_CORES-1:0] [2:0]                      lsu_axi_awprot,
   output logic [pt.NUM_CORES-1:0] [3:0]                      lsu_axi_awqos,

   output logic [pt.NUM_CORES-1:0]                            lsu_axi_wvalid,
   input  logic [pt.NUM_CORES-1:0]                            lsu_axi_wready,
   output logic [pt.NUM_CORES-1:0] [63:0]                     lsu_axi_wdata,
   output logic [pt.NUM_CORES-1:0] [7:0]                      lsu_axi_wstrb,
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_wlast,

   input  logic [pt.NUM_CORES-1:0]                            lsu_axi_bvalid,
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_bready,
   input  logic [pt.NUM_CORES-1:0] [1:0]                      lsu_axi_bresp,
   input  logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]       lsu_axi_bid,

   // AXI Read Channels
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_arvalid,
   input  logic [pt.NUM_CORES-1:0]                            lsu_axi_arready,
   output logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]       lsu_axi_arid,
   output logic [pt.NUM_CORES-1:0] [31:0]                     lsu_axi_araddr,
   output logic [pt.NUM_CORES-1:0] [3:0]                      lsu_axi_arregion,
   output logic [pt.NUM_CORES-1:0] [7:0]                      lsu_axi_arlen,
   output logic [pt.NUM_CORES-1:0] [2:0]                      lsu_axi_arsize,
   output logic [pt.NUM_CORES-1:0] [1:0]                      lsu_axi_arburst,
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_arlock,
   output logic [pt.NUM_CORES-1:0] [3:0]                      lsu_axi_arcache,
   output logic [pt.NUM_CORES-1:0] [2:0]                      lsu_axi_arprot,
   output logic [pt.NUM_CORES-1:0] [3:0]                      lsu_axi_arqos,

   input  logic [pt.NUM_CORES-1:0]                            lsu_axi_rvalid,
   output logic [pt.NUM_CORES-1:0]                            lsu_axi_rready,
   input  logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]       lsu_axi_rid,
   input  logic [pt.NUM_CORES-1:0] [63:0]                     lsu_axi_rdata,
   input  logic [pt.NUM_CORES-1:0] [1:0]                      lsu_axi_rresp,
   input  logic [pt.NUM_CORES-1:0]                            lsu_axi_rlast,

   //-------------------------- IFU AXI signals--------------------------
   // AXI Write Channels
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_awvalid,
   input  logic [pt.NUM_CORES-1:0]                            ifu_axi_awready,
   output logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]       ifu_axi_awid,
   output logic [pt.NUM_CORES-1:0] [31:0]                     ifu_axi_awaddr,
   output logic [pt.NUM_CORES-1:0] [3:0]                      ifu_axi_awregion,
   output logic [pt.NUM_CORES-1:0] [7:0]                      ifu_axi_awlen,
   output logic [pt.NUM_CORES-1:0] [2:0]                      ifu_axi_awsize,
   output logic [pt.NUM_CORES-1:0] [1:0]                      ifu_axi_awburst,
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_awlock,
   output logic [pt.NUM_CORES-1:0] [3:0]                      ifu_axi_awcache,
   output logic [pt.NUM_CORES-1:0] [2:0]                      ifu_axi_awprot,
   output logic [pt.NUM_CORES-1:0] [3:0]                      ifu_axi_awqos,

   output logic [pt.NUM_CORES-1:0]                            ifu_axi_wvalid,
   input  logic [pt.NUM_CORES-1:0]                            ifu_axi_wready,
   output logic [pt.NUM_CORES-1:0] [63:0]                     ifu_axi_wdata,
   output logic [pt.NUM_CORES-1:0] [7:0]                      ifu_axi_wstrb,
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_wlast,

   input  logic [pt.NUM_CORES-1:0]                            ifu_axi_bvalid,
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_bready,
   input  logic [pt.NUM_CORES-1:0] [1:0]                      ifu_axi_bresp,
   input  logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]       ifu_axi_bid,

   // AXI Read Channels
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_arvalid,
   input  logic [pt.NUM_CORES-1:0]                            ifu_axi_arready,
   output logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]       ifu_axi_arid,
   output logic [pt.NUM_CORES-1:0] [31:0]                     ifu_axi_araddr,
   output logic [pt.NUM_CORES-1:0] [3:0]                      ifu_axi_arregion,
   output logic [pt.NUM_CORES-1:0] [7:0]                      ifu_axi_arlen,
   output logic [pt.NUM_CORES-1:0] [2:0]                      ifu_axi_arsize,
   output logic [pt.NUM_CORES-1:0] [1:0]                      ifu_axi_arburst,
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_arlock,
   output logic [pt.NUM_CORES-1:0] [3:0]                      ifu_axi_arcache,
   output logic [pt.NUM_CORES-1:0] [2:0]                      ifu_axi_arprot,
   output logic [pt.NUM_CORES-1:0] [3:0]                      ifu_axi_arqos,

   input  logic [pt.NUM_CORES-1:0]                            ifu_axi_rvalid,
   output logic [pt.NUM_CORES-1:0]                            ifu_axi_rready,
   input  logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]       ifu_axi_rid,
   input  logic [pt.NUM_CORES-1:0] [63:0]                     ifu_axi_rdata,
   input  logic [pt.NUM_CORES-1:0] [1:0]                      ifu_axi_rresp,
   input  logic [pt.NUM_CORES-1:0]                            ifu_axi_rlast,

   //-------------------------- SB AXI signals--------------------------
   // AXI Write Channels
   output logic [pt.NUM_CORES-1:0]                            sb_axi_awvalid,
   input  logic [pt.NUM_CORES-1:0]                            sb_axi_awready,
   output logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]        sb_axi_awid,
   output logic [pt.NUM_CORES-1:0] [31:0]                     sb_axi_awaddr,
   output logic [pt.NUM_CORES-1:0] [3:0]                      sb_axi_awregion,
   output logic [pt.NUM_CORES-1:0] [7:0]                      sb_axi_awlen,
   output logic [pt.NUM_CORES-1:0] [2:0]                      sb_axi_awsize,
   output logic [pt.NUM_CORES-1:0] [1:0]                      sb_axi_awburst,
   output logic [pt.NUM_CORES-1:0]                            sb_axi_awlock,
   output logic [pt.NUM_CORES-1:0] [3:0]                      sb_axi_awcache,
   output logic [pt.NUM_CORES-1:0] [2:0]                      sb_axi_awprot,
   output logic [pt.NUM_CORES-1:0] [3:0]                      sb_axi_awqos,

   output logic [pt.NUM_CORES-1:0]                            sb_axi_wvalid,
   input  logic [pt.NUM_CORES-1:0]                            sb_axi_wready,
   output logic [pt.NUM_CORES-1:0] [63:0]                     sb_axi_wdata,
   output logic [pt.NUM_CORES-1:0] [7:0]                      sb_axi_wstrb,
   output logic [pt.NUM_CORES-1:0]                            sb_axi_wlast,

   input  logic [pt.NUM_CORES-1:0]                            sb_axi_bvalid,
   output logic [pt.NUM_CORES-1:0]                            sb_axi_bready,
   input  logic [pt.NUM_CORES-1:0] [1:0]                      sb_axi_bresp,
   input  logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]        sb_axi_bid,

   // AXI Read Channels
   output logic [pt.NUM_CORES-1:0]                            sb_axi_arvalid,
   input  logic [pt.NUM_CORES-1:0]                            sb_axi_arready,
   output logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]        sb_axi_arid,
   output logic [pt.NUM_CORES-1:0] [31:0]                     sb_axi_araddr,
   output logic [pt.NUM_CORES-1:0] [3:0]                      sb_axi_arregion,
   output logic [pt.NUM_CORES-1:0] [7:0]                      sb_axi_arlen,
   output logic [pt.NUM_CORES-1:0] [2:0]                      sb_axi_arsize,
   output logic [pt.NUM_CORES-1:0] [1:0]                      sb_axi_arburst,
   output logic [pt.NUM_CORES-1:0]                            sb_axi_arlock,
   output logic [pt.NUM_CORES-1:0] [3:0]                      sb_axi_arcache,
   output logic [pt.NUM_CORES-1:0] [2:0]                      sb_axi_arprot,
   output logic [pt.NUM_CORES-1:0] [3:0]                      sb_axi_arqos,

   input  logic [pt.NUM_CORES-1:0]                            sb_axi_rvalid,
   output logic [pt.NUM_CORES-1:0]                            sb_axi_rready,
   input  logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]        sb_axi_rid,
   input  logic [pt.NUM_CORES-1:0] [63:0]                     sb_axi_rdata,
   input  logic [pt.NUM_CORES-1:0] [1:0]                      sb_axi_rresp,
   input  logic [pt.NUM_CORES-1:0]                            sb_axi_rlast,

   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
   input  logic [pt.NUM_CORES-1:0]                         dma_axi_awvalid,
   output logic [pt.NUM_CORES-1:0]                         dma_axi_awready,
   input  logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]    dma_axi_awid,
   input  logic [pt.NUM_CORES-1:0] [31:0]                  dma_axi_awaddr,
   input  logic [pt.NUM_CORES-1:0] [2:0]                   dma_axi_awsize,
   input  logic [pt.NUM_CORES-1:0] [2:0]                   dma_axi_awprot,
   input  logic [pt.NUM_CORES-1:0] [7:0]                   dma_axi_awlen,
   input  logic [pt.NUM_CORES-1:0] [1:0]                   dma_axi_awburst,


   input  logic [pt.NUM_CORES-1:0]                         dma_axi_wvalid,
   output logic [pt.NUM_CORES-1:0]                         dma_axi_wready,
   input  logic [pt.NUM_CORES-1:0] [63:0]                  dma_axi_wdata,
   input  logic [pt.NUM_CORES-1:0] [7:0]                   dma_axi_wstrb,
   input  logic [pt.NUM_CORES-1:0]                         dma_axi_wlast,

   output logic [pt.NUM_CORES-1:0]                         dma_axi_bvalid,
   input  logic [pt.NUM_CORES-1:0]                         dma_axi_bready,
   output logic [pt.NUM_CORES-1:0] [1:0]                   dma_axi_bresp,
   output logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]    dma_axi_bid,

   // AXI Read Channels
   input  logic [pt.NUM_CORES-1:0]                         dma_axi_arvalid,
   output logic [pt.NUM_CORES-1:0]                         dma_axi_arready,
   input  logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]    dma_axi_arid,
   input  logic [pt.NUM_CORES-1:0] [31:0]                  dma_axi_araddr,
   input  logic [pt.NUM_CORES-1:0] [2:0]                   dma_axi_arsize,
   input  logic [pt.NUM_CORES-1:0] [2:0]                   dma_axi_arprot,
   input  logic [pt.NUM_CORES-1:0] [7:0]                   dma_axi_arlen,
   input  logic [pt.NUM_CORES-1:0] [1:0]                   dma_axi_arburst,

   output logic [pt.NUM_CORES-1:0]                         dma_axi_rvalid,
   input  logic [pt.NUM_CORES-1:0]                         dma_axi_rready,
   output logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]    dma_axi_rid,
   output logic [pt.NUM_CORES-1:0] [63:0]                  dma_axi_rdata,
   output logic [pt.NUM_CORES-1:0] [1:0]                   dma_axi_rresp,
   output logic [pt.NUM_CORES-1:0]                         dma_axi_rlast,

`endif


`ifdef RV_BUILD_AHB_LITE
 //// AHB LITE BUS
   output logic  [31:0]               haddr,
   output logic  [2:0]                hburst,
   output logic                       hmastlock,
   output logic  [3:0]                hprot,
   output logic  [2:0]                hsize,
   output logic  [1:0]                htrans,
   output logic                       hwrite,

   input logic  [pt.NUM_CORES-1:0][63:0]                hrdata,
   input logic                        hready,
   input logic                        hresp,

   // LSU AHB Master
   output logic  [31:0]               lsu_haddr,
   output logic  [2:0]                lsu_hburst,
   output logic                       lsu_hmastlock,
   output logic  [3:0]                lsu_hprot,
   output logic  [2:0]                lsu_hsize,
   output logic  [1:0]                lsu_htrans,
   output logic                       lsu_hwrite,
   output logic  [63:0]               lsu_hwdata,

   input logic  [pt.NUM_CORES-1:0][63:0]                lsu_hrdata,
   input logic                        lsu_hready,
   input logic                        lsu_hresp,
   // Debug Syster Bus AHB
   output logic  [31:0]               sb_haddr,
   output logic  [2:0]                sb_hburst,
   output logic                       sb_hmastlock,
   output logic  [3:0]                sb_hprot,
   output logic  [2:0]                sb_hsize,
   output logic  [1:0]                sb_htrans,
   output logic                       sb_hwrite,
   output logic  [63:0]               sb_hwdata,

   input  logic  [pt.NUM_CORES-1:0][63:0]               sb_hrdata,
   input  logic                       sb_hready,
   input  logic                       sb_hresp,

   // DMA Slave
   input logic                        dma_hsel,
   input logic  [31:0]                dma_haddr,
   input logic  [2:0]                 dma_hburst,
   input logic                        dma_hmastlock,
   input logic  [3:0]                 dma_hprot,
   input logic  [2:0]                 dma_hsize,
   input logic  [1:0]                 dma_htrans,
   input logic                        dma_hwrite,
   input logic  [63:0]                dma_hwdata,
   input logic                        dma_hreadyin,

   output logic  [63:0]               dma_hrdata,
   output logic                       dma_hreadyout,
   output logic                       dma_hresp,

`endif


   // clk ratio signals
   input logic [pt.NUM_CORES-1:0]                       lsu_bus_clk_en, // Clock ratio b/w cpu core clk & AHB master interface
   input logic [pt.NUM_CORES-1:0]                       ifu_bus_clk_en, // Clock ratio b/w cpu core clk & AHB master interface
   input logic [pt.NUM_CORES-1:0]                       dbg_bus_clk_en, // Clock ratio b/w cpu core clk & AHB master interface
   input logic [pt.NUM_CORES-1:0]                       dma_bus_clk_en, // Clock ratio b/w cpu core clk & AHB slave interface

 // all of these test inputs are brought to top-level; must be tied off based on usage by physical design (ie. icache or not, iccm or not, dccm or not)

   input eh2_dccm_ext_in_pkt_t     [pt.NUM_CORES-1:0][pt.DCCM_NUM_BANKS-1:0] dccm_ext_in_pkt,
   input eh2_ccm_ext_in_pkt_t      [pt.NUM_CORES-1:0][pt.ICCM_NUM_BANKS/4-1:0][1:0][1:0] iccm_ext_in_pkt,
   input eh2_ccm_ext_in_pkt_t      [pt.NUM_CORES-1:0][1:0] btb_ext_in_pkt,
   input eh2_ic_data_ext_in_pkt_t  [pt.NUM_CORES-1:0][pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] ic_data_ext_in_pkt,
   input eh2_ic_tag_ext_in_pkt_t   [pt.NUM_CORES-1:0][pt.ICACHE_NUM_WAYS-1:0] ic_tag_ext_in_pkt,

   input logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0]  timer_int,
   input logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0]  soft_int,
   input logic [pt.NUM_CORES-1:0] [pt.PIC_TOTAL_INT:1] extintsrc_req,

   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0] dec_tlu_perfcnt0,                  // toggles when perf counter 0 has an event inc
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0] dec_tlu_perfcnt1,                  // toggles when perf counter 1 has an event inc
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0] dec_tlu_perfcnt2,                  // toggles when perf counter 2 has an event inc
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] [1:0] dec_tlu_perfcnt3,                  // toggles when perf counter 3 has an event inc

   // ports added by the soc team
   input logic [pt.NUM_CORES-1:0]                       jtag_tck,    // JTAG clk
   input logic [pt.NUM_CORES-1:0]                       jtag_tms,    // JTAG TMS
   input logic [pt.NUM_CORES-1:0]                       jtag_tdi,    // JTAG tdi
   input logic [pt.NUM_CORES-1:0]                       jtag_trst_n, // JTAG Reset
   output logic [pt.NUM_CORES-1:0]                      jtag_tdo,    // JTAG TDO

   input logic [pt.NUM_CORES-1:0] [31:4]     core_id, // Core ID


   // external MPC halt/run interface
   input logic [pt.NUM_CORES-1:0]  [pt.NUM_THREADS-1:0] mpc_debug_halt_req, // Async halt request
   input logic [pt.NUM_CORES-1:0]  [pt.NUM_THREADS-1:0] mpc_debug_run_req,  // Async run request
   input logic [pt.NUM_CORES-1:0]  [pt.NUM_THREADS-1:0] mpc_reset_run_req,  // Run/halt after reset
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] mpc_debug_halt_ack, // Halt ack
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] mpc_debug_run_ack,  // Run ack
   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] debug_brkpt_status, // debug breakpoint

   output logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0] dec_tlu_mhartstart, // running harts

   input logic [pt.NUM_CORES-1:0]          [pt.NUM_THREADS-1:0]         i_cpu_halt_req,      // Async halt req to CPU
   output logic [pt.NUM_CORES-1:0]         [pt.NUM_THREADS-1:0]         o_cpu_halt_ack,      // core response to halt
   output logic [pt.NUM_CORES-1:0]         [pt.NUM_THREADS-1:0]         o_cpu_halt_status,   // 1'b1 indicates core is halted
   output logic [pt.NUM_CORES-1:0]         [pt.NUM_THREADS-1:0]         o_debug_mode_status, // Core to the PMU that core is in debug mode. When core is in debug mode, the PMU should refrain from sendng a halt or run request
   input logic [pt.NUM_CORES-1:0]          [pt.NUM_THREADS-1:0]         i_cpu_run_req, // Async restart req to CPU
   output logic [pt.NUM_CORES-1:0]         [pt.NUM_THREADS-1:0]         o_cpu_run_ack, // Core response to run req
   input logic [pt.NUM_CORES-1:0]                       scan_mode, // To enable scan mode
   input logic [pt.NUM_CORES-1:0]                       mbist_mode // to enable mbist

);

   // DCCM ports
   logic [pt.NUM_CORES-1:0]         dccm_wren;
   logic [pt.NUM_CORES-1:0]         dccm_rden;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_wr_addr_lo;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_wr_addr_hi;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_rd_addr_lo;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_rd_addr_hi;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_wr_data_lo;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_wr_data_hi;

   logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_rd_data_lo;
   logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_rd_data_hi;

   // PIC ports

   // Icache & Itag ports
   logic [pt.NUM_CORES-1:0] [31:1]  ic_rw_addr;
   logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]   ic_wr_en  ;     // Which way to write
   logic [pt.NUM_CORES-1:0]         ic_rd_en ;


   logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]   ic_tag_valid;   // Valid from the I$ tag valid outside (in flops).

   logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]   ic_rd_hit;
   logic [pt.NUM_CORES-1:0]         ic_tag_perr;    // Ic tag parity error

   logic [pt.NUM_CORES-1:0] [pt.ICACHE_INDEX_HI:3]  ic_debug_addr;      // Read/Write addresss to the Icache.
   logic [pt.NUM_CORES-1:0]         ic_debug_rd_en;     // Icache debug rd
   logic [pt.NUM_CORES-1:0]         ic_debug_wr_en;     // Icache debug wr
   logic [pt.NUM_CORES-1:0]         ic_debug_tag_array; // Debug tag array
   logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]   ic_debug_way;       // Debug way. Rd or Wr.

   logic [pt.NUM_CORES-1:0] [pt.ICACHE_BANKS_WAY-1:0] [70:0] ic_wr_data;           // Data to fill to the Icache. With ECC
   logic [pt.NUM_CORES-1:0] [63:0]                           ic_rd_data;          // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
   logic [pt.NUM_CORES-1:0] [70:0]                           ic_debug_rd_data;    // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
   logic [pt.NUM_CORES-1:0] [25:0]                           ictag_debug_rd_data;  // Debug icache tag.
   logic [pt.NUM_CORES-1:0] [70:0]                           ic_debug_wr_data;     // Debug wr cache.
   logic [pt.NUM_CORES-1:0] [pt.ICACHE_BANKS_WAY-1:0]        ic_eccerr;
    //
   logic [pt.NUM_CORES-1:0] [pt.ICACHE_BANKS_WAY-1:0]        ic_parerr;


   logic [pt.NUM_CORES-1:0] [63:0]  ic_premux_data;
   logic [pt.NUM_CORES-1:0]         ic_sel_premux_data;

   // ICCM ports
   logic [pt.NUM_CORES-1:0] [pt.ICCM_BITS-1:1]  iccm_rw_addr;
   logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0]iccm_buf_correct_ecc_thr;                // ICCM is doing a single bit error correct cycle
   logic [pt.NUM_CORES-1:0]                     iccm_correction_state, iccm_corr_scnd_fetch;
   logic [pt.NUM_CORES-1:0]                     iccm_stop_fetch;                     // ICCM hits need to ignored for replacement purposes as we have fetched ahead.. dont want to stop fetch through dma_active as it causes timing issues there

   logic [pt.NUM_CORES-1:0]           ifc_select_tid_f1;
   logic [pt.NUM_CORES-1:0]           iccm_wren;
   logic [pt.NUM_CORES-1:0]           iccm_rden;
   logic [pt.NUM_CORES-1:0] [2:0]     iccm_wr_size;
   logic [pt.NUM_CORES-1:0] [77:0]    iccm_wr_data;
   logic [pt.NUM_CORES-1:0] [63:0]    iccm_rd_data;
   logic [pt.NUM_CORES-1:0] [116:0]   iccm_rd_data_ecc;

   // BTB
   // REVISE THIS
   eh2_btb_sram_pkt [pt.NUM_CORES-1:0]btb_sram_pkt;
   logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0] btb_vbank0_rd_data_f1;
   logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0] btb_vbank1_rd_data_f1;
   logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0] btb_vbank2_rd_data_f1;
   logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0] btb_vbank3_rd_data_f1;
   logic [pt.NUM_CORES-1:0]                                              btb_wren;
   logic [pt.NUM_CORES-1:0]                                              btb_rden;
   logic [pt.NUM_CORES-1:0] [1:0] [pt.BTB_ADDR_HI:1]             btb_rw_addr;  // per bank
   logic [pt.NUM_CORES-1:0] [1:0] [pt.BTB_ADDR_HI:1]             btb_rw_addr_f1;  // per bank
   logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0] btb_sram_wr_data;
   logic [pt.NUM_CORES-1:0] [1:0] [pt.BTB_BTAG_SIZE-1:0]                 btb_sram_rd_tag_f1;

   logic [pt.NUM_CORES-1:0]           active_l2clk;
   logic [pt.NUM_CORES-1:0]           free_l2clk;

   logic [pt.NUM_CORES-1:0]        core_rst_l;     // Core reset including rst_l and dbg_rst_l

   logic [pt.NUM_CORES-1:0]        dccm_clk_override;
   logic [pt.NUM_CORES-1:0]        icm_clk_override;
   logic [pt.NUM_CORES-1:0]        dec_tlu_core_ecc_disable;
   logic [pt.NUM_CORES-1:0]        btb_clk_override;

   // DMI signals
   logic [pt.NUM_CORES-1:0]                   dmi_reg_en;                // read or write
   logic [pt.NUM_CORES-1:0] [6:0]             dmi_reg_addr;              // address of DM register
   logic [pt.NUM_CORES-1:0]                   dmi_reg_wr_en;             // write enable
   logic [pt.NUM_CORES-1:0] [31:0]            dmi_reg_wdata;             // write data
   logic [pt.NUM_CORES-1:0] [31:0]            dmi_reg_rdata;             // read data

   // zero out the signals not presented at the wrapper instantiation level
`ifdef RV_BUILD_AXI4

 //// AHB LITE BUS
   logic [pt.NUM_CORES-1:0] [31:0]                 haddr;
   logic [pt.NUM_CORES-1:0] [2:0]                  hburst;
   logic [pt.NUM_CORES-1:0]                        hmastlock;
   logic [pt.NUM_CORES-1:0] [3:0]                  hprot;
   logic [pt.NUM_CORES-1:0] [2:0]                  hsize;
   logic [pt.NUM_CORES-1:0] [1:0]                  htrans;
   logic [pt.NUM_CORES-1:0]                        hwrite;

   logic [pt.NUM_CORES-1:0] [63:0]                 hrdata;
   logic [pt.NUM_CORES-1:0]                        hready;
   logic [pt.NUM_CORES-1:0]                        hresp;

   // LSU AHB Master
   logic [pt.NUM_CORES-1:0] [31:0]                 lsu_haddr;
   logic [pt.NUM_CORES-1:0] [2:0]                  lsu_hburst;
   logic [pt.NUM_CORES-1:0]                        lsu_hmastlock;
   logic [pt.NUM_CORES-1:0] [3:0]                  lsu_hprot;
   logic [pt.NUM_CORES-1:0] [2:0]                  lsu_hsize;
   logic [pt.NUM_CORES-1:0] [1:0]                  lsu_htrans;
   logic [pt.NUM_CORES-1:0]                        lsu_hwrite;
   logic [pt.NUM_CORES-1:0] [63:0]                 lsu_hwdata;

   logic [pt.NUM_CORES-1:0] [63:0]                 lsu_hrdata;
   logic [pt.NUM_CORES-1:0]                        lsu_hready;
   logic [pt.NUM_CORES-1:0]                        lsu_hresp;

   // Debug Syster Bus AHB
   logic [pt.NUM_CORES-1:0] [31:0]                 sb_haddr;
   logic [pt.NUM_CORES-1:0] [2:0]                  sb_hburst;
   logic [pt.NUM_CORES-1:0]                        sb_hmastlock;
   logic [pt.NUM_CORES-1:0] [3:0]                  sb_hprot;
   logic [pt.NUM_CORES-1:0] [2:0]                  sb_hsize;
   logic [pt.NUM_CORES-1:0] [1:0]                  sb_htrans;
   logic [pt.NUM_CORES-1:0]                        sb_hwrite;
   logic [pt.NUM_CORES-1:0] [63:0]                 sb_hwdata;

   logic [pt.NUM_CORES-1:0] [63:0]                 sb_hrdata;
   logic [pt.NUM_CORES-1:0]                        sb_hready;
   logic [pt.NUM_CORES-1:0]                        sb_hresp;

   // DMA Slave
   logic [pt.NUM_CORES-1:0]                        dma_hsel;
   logic [pt.NUM_CORES-1:0] [31:0]                 dma_haddr;
   logic [pt.NUM_CORES-1:0] [2:0]                  dma_hburst;
   logic [pt.NUM_CORES-1:0]                        dma_hmastlock;
   logic [pt.NUM_CORES-1:0] [3:0]                  dma_hprot;
   logic [pt.NUM_CORES-1:0] [2:0]                  dma_hsize;
   logic [pt.NUM_CORES-1:0] [1:0]                  dma_htrans;
   logic [pt.NUM_CORES-1:0]                        dma_hwrite;
   logic [pt.NUM_CORES-1:0] [63:0]                 dma_hwdata;
   logic [pt.NUM_CORES-1:0]                        dma_hreadyin;

   logic [pt.NUM_CORES-1:0] [63:0]                 dma_hrdata;
   logic [pt.NUM_CORES-1:0]                        dma_hreadyout;
   logic [pt.NUM_CORES-1:0]                        dma_hresp;

   // IFU
   assign  hrdata[0][63:0]                           = '0;
   assign  hrdata[1][63:0]                           = '0;
   assign  hready[pt.NUM_CORES-1:0]                                 = '0;
   assign  hresp[pt.NUM_CORES-1:0]                                  = '0;
   // LSU
   assign  lsu_hrdata[0][63:0]                       = '0;
   assign  lsu_hrdata[1][63:0]                       = '0;
   assign  lsu_hready[pt.NUM_CORES-1:0]                             = '0;
   assign  lsu_hresp[pt.NUM_CORES-1:0]                              = '0;
   // SB
   assign  sb_hrdata[0][63:0]                        = '0;
   assign  sb_hrdata[1][63:0]                        = '0;
   assign  sb_hready[pt.NUM_CORES-1:0]                              = '0;
   assign  sb_hresp[pt.NUM_CORES-1:0]                               = '0;

   // DMA
   assign  dma_hsel[pt.NUM_CORES-1:0]                               = '0;
   assign  dma_haddr[0][31:0]                        = '0;
   assign  dma_haddr[1][31:0]                        = '0;
   assign  dma_hburst[0][2:0]                        = '0;
   assign  dma_hburst[1][2:0]                        = '0;
   assign  dma_hmastlock[pt.NUM_CORES-1:0]                          = '0;
   assign  dma_hprot[0][3:0]                         = '0;
   assign  dma_hprot[1][3:0]                         = '0;
   assign  dma_hsize[0][2:0]                         = '0;
   assign  dma_hsize[1][2:0]                         = '0;
   assign  dma_htrans[pt.NUM_CORES-1:0][1:0]                        = '0;
   assign  dma_hwrite[pt.NUM_CORES-1:0]                             = '0;
   assign  dma_hwdata[0][63:0]                       = '0;
   assign  dma_hwdata[1][63:0]                       = '0;
   assign  dma_hreadyin[pt.NUM_CORES-1:0]                           = '0;

`endif //  `ifdef RV_BUILD_AXI4


`ifdef RV_BUILD_AHB_LITE
   logic [pt.NUM_CORES-1:0]                           lsu_axi_awvalid;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_awready;
   logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]      lsu_axi_awid;
   logic [pt.NUM_CORES-1:0] [31:0]                    lsu_axi_awaddr;
   logic [pt.NUM_CORES-1:0] [3:0]                     lsu_axi_awregion;
   logic [pt.NUM_CORES-1:0] [7:0]                     lsu_axi_awlen;
   logic [pt.NUM_CORES-1:0] [2:0]                     lsu_axi_awsize;
   logic [pt.NUM_CORES-1:0] [1:0]                     lsu_axi_awburst;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_awlock;
   logic [pt.NUM_CORES-1:0] [3:0]                     lsu_axi_awcache;
   logic [pt.NUM_CORES-1:0] [2:0]                     lsu_axi_awprot;
   logic [pt.NUM_CORES-1:0] [3:0]                     lsu_axi_awqos;

   logic [pt.NUM_CORES-1:0]                           lsu_axi_wvalid;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_wready;
   logic [pt.NUM_CORES-1:0] [63:0]                    lsu_axi_wdata;
   logic [pt.NUM_CORES-1:0] [7:0]                     lsu_axi_wstrb;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_wlast;

   logic [pt.NUM_CORES-1:0]                           lsu_axi_bvalid;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_bready;
   logic [pt.NUM_CORES-1:0] [1:0]                     lsu_axi_bresp;
   logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]      lsu_axi_bid;

   // AXI Read Channels
   logic [pt.NUM_CORES-1:0]                           lsu_axi_arvalid;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_arready;
   logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]      lsu_axi_arid;
   logic [pt.NUM_CORES-1:0] [31:0]                    lsu_axi_araddr;
   logic [pt.NUM_CORES-1:0] [3:0]                     lsu_axi_arregion;
   logic [pt.NUM_CORES-1:0] [7:0]                     lsu_axi_arlen;
   logic [pt.NUM_CORES-1:0] [2:0]                     lsu_axi_arsize;
   logic [pt.NUM_CORES-1:0] [1:0]                     lsu_axi_arburst;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_arlock;
   logic [pt.NUM_CORES-1:0] [3:0]                     lsu_axi_arcache;
   logic [pt.NUM_CORES-1:0] [2:0]                     lsu_axi_arprot;
   logic [pt.NUM_CORES-1:0] [3:0]                     lsu_axi_arqos;

   logic [pt.NUM_CORES-1:0]                           lsu_axi_rvalid;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_rready;
   logic [pt.NUM_CORES-1:0] [pt.LSU_BUS_TAG-1:0]      lsu_axi_rid;
   logic [pt.NUM_CORES-1:0] [63:0]                    lsu_axi_rdata;
   logic [pt.NUM_CORES-1:0] [1:0]                     lsu_axi_rresp;
   logic [pt.NUM_CORES-1:0]                           lsu_axi_rlast;

   //-------------------------- IFU AXI signals--------------------------
   // AXI Write Channels
   logic [pt.NUM_CORES-1:0]                           ifu_axi_awvalid;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_awready;
   logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]      ifu_axi_awid;
   logic [pt.NUM_CORES-1:0] [31:0]                    ifu_axi_awaddr;
   logic [pt.NUM_CORES-1:0] [3:0]                     ifu_axi_awregion;
   logic [pt.NUM_CORES-1:0] [7:0]                     ifu_axi_awlen;
   logic [pt.NUM_CORES-1:0] [2:0]                     ifu_axi_awsize;
   logic [pt.NUM_CORES-1:0] [1:0]                     ifu_axi_awburst;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_awlock;
   logic [pt.NUM_CORES-1:0] [3:0]                     ifu_axi_awcache;
   logic [pt.NUM_CORES-1:0] [2:0]                     ifu_axi_awprot;
   logic [pt.NUM_CORES-1:0] [3:0]                     ifu_axi_awqos;

   logic [pt.NUM_CORES-1:0]                           ifu_axi_wvalid;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_wready;
   logic [pt.NUM_CORES-1:0] [63:0]                    ifu_axi_wdata;
   logic [pt.NUM_CORES-1:0] [7:0]                     ifu_axi_wstrb;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_wlast;

   logic [pt.NUM_CORES-1:0]                           ifu_axi_bvalid;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_bready;
   logic [pt.NUM_CORES-1:0] [1:0]                     ifu_axi_bresp;
   logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]      ifu_axi_bid;

   // AXI Read Channels
   logic [pt.NUM_CORES-1:0]                           ifu_axi_arvalid;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_arready;
   logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]      ifu_axi_arid;
   logic [pt.NUM_CORES-1:0] [31:0]                    ifu_axi_araddr;
   logic [pt.NUM_CORES-1:0] [3:0]                     ifu_axi_arregion;
   logic [pt.NUM_CORES-1:0] [7:0]                     ifu_axi_arlen;
   logic [pt.NUM_CORES-1:0] [2:0]                     ifu_axi_arsize;
   logic [pt.NUM_CORES-1:0] [1:0]                     ifu_axi_arburst;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_arlock;
   logic [pt.NUM_CORES-1:0] [3:0]                     ifu_axi_arcache;
   logic [pt.NUM_CORES-1:0] [2:0]                     ifu_axi_arprot;
   logic [pt.NUM_CORES-1:0] [3:0]                     ifu_axi_arqos;

   logic [pt.NUM_CORES-1:0]                           ifu_axi_rvalid;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_rready;
   logic [pt.NUM_CORES-1:0] [pt.IFU_BUS_TAG-1:0]      ifu_axi_rid;
   logic [pt.NUM_CORES-1:0] [63:0]                    ifu_axi_rdata;
   logic [pt.NUM_CORES-1:0] [1:0]                     ifu_axi_rresp;
   logic [pt.NUM_CORES-1:0]                           ifu_axi_rlast;

   //-------------------------- SB AXI signals--------------------------
   // AXI Write Channels
   logic [pt.NUM_CORES-1:0]                           sb_axi_awvalid;
   logic [pt.NUM_CORES-1:0]                           sb_axi_awready;
   logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]       sb_axi_awid;
   logic [pt.NUM_CORES-1:0] [31:0]                    sb_axi_awaddr;
   logic [pt.NUM_CORES-1:0] [3:0]                     sb_axi_awregion;
   logic [pt.NUM_CORES-1:0] [7:0]                     sb_axi_awlen;
   logic [pt.NUM_CORES-1:0] [2:0]                     sb_axi_awsize;
   logic [pt.NUM_CORES-1:0] [1:0]                     sb_axi_awburst;
   logic [pt.NUM_CORES-1:0]                           sb_axi_awlock;
   logic [pt.NUM_CORES-1:0] [3:0]                     sb_axi_awcache;
   logic [pt.NUM_CORES-1:0] [2:0]                     sb_axi_awprot;
   logic [pt.NUM_CORES-1:0] [3:0]                     sb_axi_awqos;

   logic [pt.NUM_CORES-1:0]                           sb_axi_wvalid;
   logic [pt.NUM_CORES-1:0]                           sb_axi_wready;
   logic [pt.NUM_CORES-1:0] [63:0]                    sb_axi_wdata;
   logic [pt.NUM_CORES-1:0] [7:0]                     sb_axi_wstrb;
   logic [pt.NUM_CORES-1:0]                           sb_axi_wlast;

   logic [pt.NUM_CORES-1:0]                           sb_axi_bvalid;
   logic [pt.NUM_CORES-1:0]                           sb_axi_bready;
   logic [pt.NUM_CORES-1:0] [1:0]                     sb_axi_bresp;
   logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]       sb_axi_bid;

   // AXI Read Channels
   logic [pt.NUM_CORES-1:0]                           sb_axi_arvalid;
   logic [pt.NUM_CORES-1:0]                           sb_axi_arready;
   logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]       sb_axi_arid;
   logic [pt.NUM_CORES-1:0] [31:0]                    sb_axi_araddr;
   logic [pt.NUM_CORES-1:0] [3:0]                     sb_axi_arregion;
   logic [pt.NUM_CORES-1:0] [7:0]                     sb_axi_arlen;
   logic [pt.NUM_CORES-1:0] [2:0]                     sb_axi_arsize;
   logic [pt.NUM_CORES-1:0] [1:0]                     sb_axi_arburst;
   logic [pt.NUM_CORES-1:0]                           sb_axi_arlock;
   logic [pt.NUM_CORES-1:0] [3:0]                     sb_axi_arcache;
   logic [pt.NUM_CORES-1:0] [2:0]                     sb_axi_arprot;
   logic [pt.NUM_CORES-1:0] [3:0]                     sb_axi_arqos;

   logic [pt.NUM_CORES-1:0]                           sb_axi_rvalid;
   logic [pt.NUM_CORES-1:0]                           sb_axi_rready;
   logic [pt.NUM_CORES-1:0] [pt.SB_BUS_TAG-1:0]       sb_axi_rid;
   logic [pt.NUM_CORES-1:0] [63:0]                    sb_axi_rdata;
   logic [pt.NUM_CORES-1:0] [1:0]                     sb_axi_rresp;
   logic [pt.NUM_CORES-1:0]                           sb_axi_rlast;

   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
   logic [pt.NUM_CORES-1:0]                           dma_axi_awvalid;
   logic [pt.NUM_CORES-1:0]                           dma_axi_awready;
   logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]      dma_axi_awid;
   logic [pt.NUM_CORES-1:0] [31:0]                    dma_axi_awaddr;
   logic [pt.NUM_CORES-1:0] [2:0]                     dma_axi_awsize;
   logic [pt.NUM_CORES-1:0] [2:0]                     dma_axi_awprot;
   logic [pt.NUM_CORES-1:0] [7:0]                     dma_axi_awlen;
   logic [pt.NUM_CORES-1:0] [1:0]                     dma_axi_awburst;


   logic [pt.NUM_CORES-1:0]                           dma_axi_wvalid;
   logic [pt.NUM_CORES-1:0]                           dma_axi_wready;
   logic [pt.NUM_CORES-1:0] [63:0]                    dma_axi_wdata;
   logic [pt.NUM_CORES-1:0] [7:0]                     dma_axi_wstrb;
   logic [pt.NUM_CORES-1:0]                           dma_axi_wlast;

   logic [pt.NUM_CORES-1:0]                           dma_axi_bvalid;
   logic [pt.NUM_CORES-1:0]                           dma_axi_bready;
   logic [pt.NUM_CORES-1:0] [1:0]                     dma_axi_bresp;
   logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]      dma_axi_bid;

   // AXI Read Channels
   logic [pt.NUM_CORES-1:0]                           dma_axi_arvalid;
   logic [pt.NUM_CORES-1:0]                           dma_axi_arready;
   logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]      dma_axi_arid;
   logic [pt.NUM_CORES-1:0] [31:0]                    dma_axi_araddr;
   logic [pt.NUM_CORES-1:0] [2:0]                     dma_axi_arsize;
   logic [pt.NUM_CORES-1:0] [2:0]                     dma_axi_arprot;
   logic [pt.NUM_CORES-1:0] [7:0]                     dma_axi_arlen;
   logic [pt.NUM_CORES-1:0] [1:0]                     dma_axi_arburst;

   logic [pt.NUM_CORES-1:0]                           dma_axi_rvalid;
   logic [pt.NUM_CORES-1:0]                           dma_axi_rready;
   logic [pt.NUM_CORES-1:0] [pt.DMA_BUS_TAG-1:0]      dma_axi_rid;
   logic [pt.NUM_CORES-1:0] [63:0]                    dma_axi_rdata;
   logic [pt.NUM_CORES-1:0] [1:0]                     dma_axi_rresp;
   logic [pt.NUM_CORES-1:0]                           dma_axi_rlast;

   // LSU AXI
   assign lsu_axi_awready[pt.NUM_CORES-1:0]                         = '0;
   assign lsu_axi_wready[pt.NUM_CORES-1:0]                          = '0;
   assign lsu_axi_bvalid[pt.NUM_CORES-1:0]                          = '0;
   assign lsu_axi_bresp[pt.NUM_CORES-1:0][1:0]                      = '0;
   assign lsu_axi_bid[pt.NUM_CORES-1:0][pt.LSU_BUS_TAG-1:0]         = '0;

   assign lsu_axi_arready[pt.NUM_CORES-1:0]                         = '0;
   assign lsu_axi_rvalid[pt.NUM_CORES-1:0]                          = '0;
   assign lsu_axi_rid[pt.NUM_CORES-1:0][pt.LSU_BUS_TAG-1:0]         = '0;
   assign lsu_axi_rdata[pt.NUM_CORES-1:0][63:0]                     = '0;
   assign lsu_axi_rresp[pt.NUM_CORES-1:0][1:0]                      = '0;
   assign lsu_axi_rlast[pt.NUM_CORES-1:0]                           = '0;

   // IFU AXI
   assign ifu_axi_awready[pt.NUM_CORES-1:0]                         = '0;
   assign ifu_axi_wready[pt.NUM_CORES-1:0]                          = '0;
   assign ifu_axi_bvalid[pt.NUM_CORES-1:0]                          = '0;
   assign ifu_axi_bresp[pt.NUM_CORES-1:0][1:0]                      = '0;
   assign ifu_axi_bid[pt.NUM_CORES-1:0][pt.IFU_BUS_TAG-1:0]         = '0;

   assign ifu_axi_arready[pt.NUM_CORES-1:0]                         = '0;
   assign ifu_axi_rvalid[pt.NUM_CORES-1:0]                          = '0;
   assign ifu_axi_rid[pt.NUM_CORES-1:0][pt.IFU_BUS_TAG-1:0]         = '0;
   assign ifu_axi_rdata[pt.NUM_CORES-1:0][63:0]                     = '0;
   assign ifu_axi_rresp[pt.NUM_CORES-1:0][1:0]                      = '0;
   assign ifu_axi_rlast[pt.NUM_CORES-1:0]                           = '0;

   // Debug AXI
   assign sb_axi_awready[pt.NUM_CORES-1:0]                          = '0;
   assign sb_axi_wready[pt.NUM_CORES-1:0]                           = '0;
   assign sb_axi_bvalid[pt.NUM_CORES-1:0]                           = '0;
   assign sb_axi_bresp[pt.NUM_CORES-1:0][1:0]                       = '0;
   assign sb_axi_bid[pt.NUM_CORES-1:0][pt.SB_BUS_TAG-1:0]           = '0;

   assign sb_axi_arready[pt.NUM_CORES-1:0]                          = '0;
   assign sb_axi_rvalid[pt.NUM_CORES-1:0]                           = '0;
   assign sb_axi_rid[pt.NUM_CORES-1:0][pt.SB_BUS_TAG-1:0]           = '0;
   assign sb_axi_rdata[pt.NUM_CORES-1:0][63:0]                      = '0;
   assign sb_axi_rresp[pt.NUM_CORES-1:0][1:0]                       = '0;
   assign sb_axi_rlast[pt.NUM_CORES-1:0]                            = '0;

   // DMA AXI
   assign  dma_axi_awvalid[pt.NUM_CORES-1:0] = '0;
   assign  dma_axi_awid[pt.NUM_CORES-1:0][pt.DMA_BUS_TAG-1:0]       = '0;
   assign  dma_axi_awaddr[pt.NUM_CORES-1:0][31:0]                   = '0;
   assign  dma_axi_awsize[pt.NUM_CORES-1:0][2:0]                    = '0;
   assign  dma_axi_awprot[pt.NUM_CORES-1:0][2:0]                    = '0;
   assign  dma_axi_awlen[pt.NUM_CORES-1:0][7:0]                     = '0;
   assign  dma_axi_awburst[pt.NUM_CORES-1:0][1:0]                   = '0;

   assign  dma_axi_wvalid[pt.NUM_CORES-1:0]                         = '0;
   assign  dma_axi_wdata[pt.NUM_CORES-1:0][63:0]                    = '0;
   assign  dma_axi_wstrb[pt.NUM_CORES-1:0][7:0]                     = '0;
   assign  dma_axi_wlast[pt.NUM_CORES-1:0]                          = '0;

   assign  dma_axi_bready[pt.NUM_CORES-1:0]                         = '0;

   assign  dma_axi_arvalid[pt.NUM_CORES-1:0]                        = '0;
   assign  dma_axi_arid[pt.NUM_CORES-1:0][pt.DMA_BUS_TAG-1:0]       = '0;
   assign  dma_axi_araddr[pt.NUM_CORES-1:0][31:0]                   = '0;
   assign  dma_axi_arsize[pt.NUM_CORES-1:0][2:0]                    = '0;
   assign  dma_axi_arprot[pt.NUM_CORES-1:0][2:0]                    = '0;
   assign  dma_axi_arlen[pt.NUM_CORES-1:0][7:0]                     = '0;
   assign  dma_axi_arburst[pt.NUM_CORES-1:0][1:0]                   = '0;

   assign  dma_axi_rready[pt.NUM_CORES-1:0]                         = '0;

`endif //  `ifdef RV_BUILD_AHB_LITE

   dmi_wrapper  dmi_wrapper (
    // JTAG signals
        .jtag_id        (jtag_id),          // JTAG ID
        .trst_n         (jtag_trst_n),      // JTAG reset
        .tck            (jtag_tck),         // JTAG clock
        .tms            (jtag_tms),         // Test mode select
        .tdi            (jtag_tdi),         // Test Data Input
        .tdo            (jtag_tdo),         // Test Data Output
        .tdoEnable      (),                 // Test Data Output enable, NC

    // Processor Signals
        .core_rst_n     (dbg_rst_l),        // DM reset, active low
        .core_clk       (clk),              // Core clock
        .rd_data        (dmi_reg_rdata),    // Read data from  Processor
        .reg_wr_data    (dmi_reg_wdata),    // Write data to Processor
        .reg_wr_addr    (dmi_reg_addr),     // Write address to Processor
        .reg_en         (dmi_reg_en),       // access enable
        .reg_wr_en      (dmi_reg_wr_en),    // Write enable to Processor
        .dmi_hard_reset ()                  // hard reset of the DTM, NC
    );

   // Instantiate the eh2_swerv core
   eh2_swerv #(.pt(pt)) swerv_0 (
   .clk(clk),
   .rst_l(rst_l[0]),
   .dbg_rst_l(dbg_rst_l[0]),  
   .rst_vec(rst_vec[0]),
   .nmi_int(nmi_int[0]),
   .nmi_vec(nmi_vec[0]),

   .core_rst_l(core_rst_l[0]),   
   .active_l2clk(active_l2clk[0]),
   .free_l2clk(free_l2clk[0]),

   .trace_rv_i_insn_ip(trace_rv_i_insn_ip[0]),
   .trace_rv_i_address_ip(trace_rv_i_address_ip[0]),
   .trace_rv_i_valid_ip(trace_rv_i_valid_ip[0]),
   .trace_rv_i_exception_ip(trace_rv_i_exception_ip[0]),
   .trace_rv_i_ecause_ip(trace_rv_i_ecause_ip[0]),
   .trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip[0]),
   .trace_rv_i_tval_ip(trace_rv_i_tval_ip[0]),

   .dccm_clk_override(dccm_clk_override[0]),
   .icm_clk_override(icm_clk_override[0]),
   .dec_tlu_core_ecc_disable(dec_tlu_core_ecc_disable[0]),
   .btb_clk_override(btb_clk_override[0]),

   .dec_tlu_mhartstart(dec_tlu_mhartstart[0]), 

   // external halt/run interface
   .i_cpu_halt_req(i_cpu_halt_req[0]),    
   .i_cpu_run_req(i_cpu_run_req[0]),     
   .o_cpu_halt_status(o_cpu_halt_status[0]), 
   .o_cpu_halt_ack(o_cpu_halt_ack[0]),    
   .o_cpu_run_ack(o_cpu_run_ack[0]),     
   .o_debug_mode_status(o_debug_mode_status[0]), 

   .core_id(core_id[0]), 

   // external MPC halt/run interface
   .mpc_debug_halt_req(mpc_debug_halt_req[0]), 
   .mpc_debug_run_req(mpc_debug_run_req[0]),
   .mpc_reset_run_req(mpc_reset_run_req[0]),
   .mpc_debug_halt_ack(mpc_debug_halt_ack[0]), 
   .mpc_debug_run_ack(mpc_debug_run_ack[0]),
   .debug_brkpt_status(debug_brkpt_status[0]), 

   .dec_tlu_perfcnt0(dec_tlu_perfcnt0[0]),
   .dec_tlu_perfcnt1(dec_tlu_perfcnt1[0]),
   .dec_tlu_perfcnt2(dec_tlu_perfcnt2[0]), 
   .dec_tlu_perfcnt3(dec_tlu_perfcnt3[0]), 

   // DCCM ports
   .dccm_wren(dccm_wren[0]),
   .dccm_rden(dccm_rden[0]),
   .dccm_wr_addr_lo(dccm_wr_addr_lo[0]),
   .dccm_wr_addr_hi(dccm_wr_addr_hi[0]),
   .dccm_rd_addr_lo(dccm_rd_addr_lo[0]),
   .dccm_rd_addr_hi(dccm_rd_addr_hi[0]),
   .dccm_wr_data_lo(dccm_wr_data_lo[0]),
   .dccm_wr_data_hi(dccm_wr_data_hi[0]),

   .dccm_rd_data_lo(dccm_rd_data_lo[0]),
   .dccm_rd_data_hi(dccm_rd_data_hi[0]),

   // ICCM ports
   .iccm_rw_addr(iccm_rw_addr[0]),
   .iccm_buf_correct_ecc_thr(iccm_buf_correct_ecc_thr[0]),            
   .iccm_correction_state(iccm_correction_state[0]),               
   .iccm_stop_fetch(iccm_stop_fetch[0]),   
   .iccm_corr_scnd_fetch(iccm_corr_scnd_fetch[0]),                
   .ifc_select_tid_f1(ifc_select_tid_f1[0]),
   .iccm_wren(iccm_wren[0]),
   .iccm_rden(iccm_rden[0]),
   .iccm_wr_size(iccm_wr_size[0]),
   .iccm_wr_data(iccm_wr_data[0]),

   .iccm_rd_data(iccm_rd_data[0]),
   .iccm_rd_data_ecc(iccm_rd_data_ecc[0]),

   // ICache, ITAG  ports
   .ic_rw_addr(ic_rw_addr[0]),
   .ic_tag_valid(ic_tag_valid[0]),
   .ic_wr_en(ic_wr_en[0]),       
   .ic_rd_en(ic_rd_en[0]),

   .ic_wr_data(ic_wr_data[0]),
   .ic_rd_data(ic_rd_data[0]),
   .ic_debug_rd_data(ic_debug_rd_data[0]),    
   .ictag_debug_rd_data(ictag_debug_rd_data[0]),  
   .ic_debug_wr_data(ic_debug_wr_data[0]),     

   .ic_eccerr(ic_eccerr[0]),    
   .ic_parerr(ic_parerr[0]),

   .ic_premux_data(ic_premux_data[0]),     
   .ic_sel_premux_data(ic_sel_premux_data[0]), 

   .ic_debug_addr(ic_debug_addr[0]),      
   .ic_debug_rd_en(ic_debug_rd_en[0]),     
   .ic_debug_wr_en(ic_debug_wr_en[0]),     
   .ic_debug_tag_array(ic_debug_tag_array[0]), 
   .ic_debug_way(ic_debug_way[0]),       

   .ic_rd_hit(ic_rd_hit[0]),
   .ic_tag_perr(ic_tag_perr[0]),     

// BTB ports
   .btb_sram_pkt(btb_sram_pkt[0]),

   .btb_vbank0_rd_data_f1(btb_vbank0_rd_data_f1[0]),
   .btb_vbank1_rd_data_f1(btb_vbank1_rd_data_f1[0]),
   .btb_vbank2_rd_data_f1(btb_vbank2_rd_data_f1[0]),
   .btb_vbank3_rd_data_f1(btb_vbank3_rd_data_f1[0]),

   .btb_wren(btb_wren[0]),
   .btb_rden(btb_rden[0]),
   .btb_rw_addr(btb_rw_addr[0]),  
   .btb_rw_addr_f1(btb_rw_addr_f1[0]),  
   .btb_sram_wr_data(btb_sram_wr_data[0]),
   .btb_sram_rd_tag_f1(btb_sram_rd_tag_f1[0]),


   //-------------------------- LSU AXI signals--------------------------
   // AXI Write Channels
   .lsu_axi_awvalid(lsu_axi_awvalid[0]),
   .lsu_axi_awready(lsu_axi_awready[0]),
   .lsu_axi_awid(lsu_axi_awid[0]),
   .lsu_axi_awaddr(lsu_axi_awaddr[0]),
   .lsu_axi_awregion(lsu_axi_awregion[0]),
   .lsu_axi_awlen(lsu_axi_awlen[0]),
   .lsu_axi_awsize(lsu_axi_awsize[0]),
   .lsu_axi_awburst(lsu_axi_awburst[0]),
   .lsu_axi_awlock(lsu_axi_awlock[0]),
   .lsu_axi_awcache(lsu_axi_awcache[0]),
   .lsu_axi_awprot(lsu_axi_awprot[0]),
   .lsu_axi_awqos(lsu_axi_awqos[0]),

   .lsu_axi_wvalid(lsu_axi_wvalid[0]),
   .lsu_axi_wready(lsu_axi_wready[0]),
   .lsu_axi_wdata(lsu_axi_wdata[0]),
   .lsu_axi_wstrb(lsu_axi_wstrb[0]),
   .lsu_axi_wlast(lsu_axi_wlast[0]),

   .lsu_axi_bvalid(lsu_axi_bvalid[0]),
   .lsu_axi_bready(lsu_axi_bready[0]),
   .lsu_axi_bresp(lsu_axi_bresp[0]),
   .lsu_axi_bid(lsu_axi_bid[0]),

   // AXI Read Channels
   .lsu_axi_arvalid(lsu_axi_arvalid[0]),
   .lsu_axi_arready(lsu_axi_arready[0]),
   .lsu_axi_arid(lsu_axi_arid[0]),
   .lsu_axi_araddr(lsu_axi_araddr[0]),
   .lsu_axi_arregion(lsu_axi_arregion[0]),
   .lsu_axi_arlen(lsu_axi_arlen[0]),
   .lsu_axi_arsize(lsu_axi_arsize[0]),
   .lsu_axi_arburst(lsu_axi_arburst[0]),
   .lsu_axi_arlock(lsu_axi_arlock[0]),
   .lsu_axi_arcache(lsu_axi_arcache[0]),
   .lsu_axi_arprot(lsu_axi_arprot[0]),
   .lsu_axi_arqos(lsu_axi_arqos[0]),

   .lsu_axi_rvalid(lsu_axi_rvalid[0]),
   .lsu_axi_rready(lsu_axi_rready[0]),
   .lsu_axi_rid(lsu_axi_rid[0]),
   .lsu_axi_rdata(lsu_axi_rdata[0]),
   .lsu_axi_rresp(lsu_axi_rresp[0]),
   .lsu_axi_rlast(lsu_axi_rlast[0]),

   //-------------------------- IFU AXI signals--------------------------
   // AXI Write Channels
   .ifu_axi_awvalid(ifu_axi_awvalid[0]),
   .ifu_axi_awready(ifu_axi_awready[0]),
   .ifu_axi_awid(ifu_axi_awid[0]),
   .ifu_axi_awaddr(ifu_axi_awaddr[0]),
   .ifu_axi_awregion(ifu_axi_awregion[0]),
   .ifu_axi_awlen(ifu_axi_awlen[0]),
   .ifu_axi_awsize(ifu_axi_awsize[0]),
   .ifu_axi_awburst(ifu_axi_awburst[0]),
   .ifu_axi_awlock(ifu_axi_awlock[0]),
   .ifu_axi_awcache(ifu_axi_awcache[0]),
   .ifu_axi_awprot(ifu_axi_awprot[0]),
   .ifu_axi_awqos(ifu_axi_awqos[0]),

   .ifu_axi_wvalid(ifu_axi_wvalid[0]),
   .ifu_axi_wready(ifu_axi_wready[0]),
   .ifu_axi_wdata(ifu_axi_wdata[0]),
   .ifu_axi_wstrb(ifu_axi_wstrb[0]),
   .ifu_axi_wlast(ifu_axi_wlast[0]),

   .ifu_axi_bvalid(ifu_axi_bvalid[0]),
   .ifu_axi_bready(ifu_axi_bready[0]),
   .ifu_axi_bresp(ifu_axi_bresp[0]),
   .ifu_axi_bid(ifu_axi_bid[0]),

   // AXI Read Channels
   .ifu_axi_arvalid(ifu_axi_arvalid[0]),
   .ifu_axi_arready(ifu_axi_arready[0]),
   .ifu_axi_arid(ifu_axi_arid[0]),
   .ifu_axi_araddr(ifu_axi_araddr[0]),
   .ifu_axi_arregion(ifu_axi_arregion[0]),
   .ifu_axi_arlen(ifu_axi_arlen[0]),
   .ifu_axi_arsize(ifu_axi_arsize[0]),
   .ifu_axi_arburst(ifu_axi_arburst[0]),
   .ifu_axi_arlock(ifu_axi_arlock[0]),
   .ifu_axi_arcache(ifu_axi_arcache[0]),
   .ifu_axi_arprot(ifu_axi_arprot[0]),
   .ifu_axi_arqos(ifu_axi_arqos[0]),

   .ifu_axi_rvalid(ifu_axi_rvalid[0]),
   .ifu_axi_rready(ifu_axi_rready[0]),
   .ifu_axi_rid(ifu_axi_rid[0]),
   .ifu_axi_rdata(ifu_axi_rdata[0]),
   .ifu_axi_rresp(ifu_axi_rresp[0]),
   .ifu_axi_rlast(ifu_axi_rlast[0]),

   //-------------------------- SB AXI signals--------------------------
   // AXI Write Channels
   .sb_axi_awvalid(sb_axi_awvalid[0]),
   .sb_axi_awready(sb_axi_awready[0]),
   .sb_axi_awid(sb_axi_awid[0]),
   .sb_axi_awaddr(sb_axi_awaddr[0]),
   .sb_axi_awregion(sb_axi_awregion[0]),
   .sb_axi_awlen(sb_axi_awlen[0]),
   .sb_axi_awsize(sb_axi_awsize[0]),
   .sb_axi_awburst(sb_axi_awburst[0]),
   .sb_axi_awlock(sb_axi_awlock[0]),
   .sb_axi_awcache(sb_axi_awcache[0]),
   .sb_axi_awprot(sb_axi_awprot[0]),
   .sb_axi_awqos(sb_axi_awqos[0]),

   .sb_axi_wvalid(sb_axi_wvalid[0]),
   .sb_axi_wready(sb_axi_wready[0]),
   .sb_axi_wdata(sb_axi_wdata[0]),
   .sb_axi_wstrb(sb_axi_wstrb[0]),
   .sb_axi_wlast(sb_axi_wlast[0]),

   .sb_axi_bvalid(sb_axi_bvalid[0]),
   .sb_axi_bready(sb_axi_bready[0]),
   .sb_axi_bresp(sb_axi_bresp[0]),
   .sb_axi_bid(sb_axi_bid[0]),

   // AXI Read Channels
   .sb_axi_arvalid(sb_axi_arvalid[0]),
   .sb_axi_arready(sb_axi_arready[0]),
   .sb_axi_arid(sb_axi_arid[0]),
   .sb_axi_araddr(sb_axi_araddr[0]),
   .sb_axi_arregion(sb_axi_arregion[0]),
   .sb_axi_arlen(sb_axi_arlen[0]),
   .sb_axi_arsize(sb_axi_arsize[0]),
   .sb_axi_arburst(sb_axi_arburst[0]),
   .sb_axi_arlock(sb_axi_arlock[0]),
   .sb_axi_arcache(sb_axi_arcache[0]),
   .sb_axi_arprot(sb_axi_arprot[0]),
   .sb_axi_arqos(sb_axi_arqos[0]),

   .sb_axi_rvalid(sb_axi_rvalid[0]),
   .sb_axi_rready(sb_axi_rready[0]),
   .sb_axi_rid(sb_axi_rid[0]),
   .sb_axi_rdata(sb_axi_rdata[0]),
   .sb_axi_rresp(sb_axi_rresp[0]),
   .sb_axi_rlast(sb_axi_rlast[0]),

   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
   .dma_axi_awvalid(dma_axi_awvalid[0]),
   .dma_axi_awready(dma_axi_awready[0]),
   .dma_axi_awid(dma_axi_awid[0]),
   .dma_axi_awaddr(dma_axi_awaddr[0]),
   .dma_axi_awsize(dma_axi_awsize[0]),
   .dma_axi_awprot(dma_axi_awprot[0]),
   .dma_axi_awlen(dma_axi_awlen[0]),
   .dma_axi_awburst(dma_axi_awburst[0]),


   .dma_axi_wvalid(dma_axi_wvalid[0]),
   .dma_axi_wready(dma_axi_wready[0]),
   .dma_axi_wdata(dma_axi_wdata[0]),
   .dma_axi_wstrb(dma_axi_wstrb[0]),
   .dma_axi_wlast(dma_axi_wlast[0]),

   .dma_axi_bvalid(dma_axi_bvalid[0]),
   .dma_axi_bready(dma_axi_bready[0]),
   .dma_axi_bresp(dma_axi_bresp[0]),
   .dma_axi_bid(dma_axi_bid[0]),

   // AXI Read Channels
   .dma_axi_arvalid(dma_axi_arvalid[0]),
   .dma_axi_arready(dma_axi_arready[0]),
   .dma_axi_arid(dma_axi_arid[0]),
   .dma_axi_araddr(dma_axi_araddr[0]),
   .dma_axi_arsize(dma_axi_arsize[0]),
   .dma_axi_arprot(dma_axi_arprot[0]),
   .dma_axi_arlen(dma_axi_arlen[0]),
   .dma_axi_arburst(dma_axi_arburst[0]),

   .dma_axi_rvalid(dma_axi_rvalid[0]),
   .dma_axi_rready(dma_axi_rready[0]),
   .dma_axi_rid(dma_axi_rid[0]),
   .dma_axi_rdata(dma_axi_rdata[0]),
   .dma_axi_rresp(dma_axi_rresp[0]),
   .dma_axi_rlast(dma_axi_rlast[0]),

    //// AHB LITE BUS
   .haddr(haddr[0]),
   .hburst(hburst[0]),
   .hmastlock(hmastlock[0]),
   .hprot(hprot[0]),
   .hsize(hsize[0]),
   .htrans(htrans[0]),
   .hwrite(hwrite[0]),

   .hrdata(hrdata[0]),
   .hready(hready[0]),
   .hresp(hresp[0]),

   // LSU AHB Master
   .lsu_haddr(lsu_haddr[0]),
   .lsu_hburst(lsu_hburst[0]),
   .lsu_hmastlock(lsu_hmastlock[0]),
   .lsu_hprot(lsu_hprot[0]),
   .lsu_hsize(lsu_hsize[0]),
   .lsu_htrans(lsu_htrans[0]),
   .lsu_hwrite(lsu_hwrite[0]),
   .lsu_hwdata(lsu_hwdata[0]),

   .lsu_hrdata(lsu_hrdata[0]),
   .lsu_hready(lsu_hready[0]),
   .lsu_hresp(lsu_hresp[0]),

   //System Bus Debug Master
   .sb_haddr(sb_haddr[0]),
   .sb_hburst(sb_hburst[0]),
   .sb_hmastlock(sb_hmastlock[0]),
   .sb_hprot(sb_hprot[0]),
   .sb_hsize(sb_hsize[0]),
   .sb_htrans(sb_htrans[0]),
   .sb_hwrite(sb_hwrite[0]),
   .sb_hwdata(sb_hwdata[0]),

   .sb_hrdata(sb_hrdata[0]),
   .sb_hready(sb_hready[0]),
   .sb_hresp(sb_hresp[0]),

   // DMA Slave
   .dma_haddr(dma_haddr[0]),
   .dma_hburst(dma_hburst[0]),
   .dma_hmastlock(dma_hmastlock[0]),
   .dma_hprot(dma_hprot[0]),
   .dma_hsize(dma_hsize[0]),
   .dma_htrans(dma_htrans[0]),
   .dma_hwrite(dma_hwrite[0]),
   .dma_hwdata(dma_hwdata[0]),
   .dma_hreadyin(dma_hreadyin[0]),
   .dma_hsel(dma_hsel[0]),

   .dma_hrdata(dma_hrdata[0]),
   .dma_hreadyout(dma_hreadyout[0]),
   .dma_hresp(dma_hresp[0]),

   .lsu_bus_clk_en(lsu_bus_clk_en[0]),
   .ifu_bus_clk_en(ifu_bus_clk_en[0]),
   .dbg_bus_clk_en(dbg_bus_clk_en[0]),
   .dma_bus_clk_en(dma_bus_clk_en[0]),

   //DMI signals
   .dmi_reg_en(dmi_reg_en[0]),     
   .dmi_reg_addr(dmi_reg_addr[0]),   
   .dmi_reg_wr_en(dmi_reg_wr_en[0]),  
   .dmi_reg_wdata(dmi_reg_wdata[0]),  
   .dmi_reg_rdata(dmi_reg_rdata[0]),  

   .extintsrc_req(extintsrc_req[0]),
   .timer_int(timer_int[0]),   
   .soft_int(soft_int[0]),    
   .scan_mode(scan_mode[0])
       
   );
                               
   eh2_swerv #(.pt(pt)) swerv_1 (
   .clk(clk),
   .rst_l(rst_l[1]),
   .dbg_rst_l(dbg_rst_l[1]),  
   .rst_vec(rst_vec[1]),
   .nmi_int(nmi_int[1]),
   .nmi_vec(nmi_vec[1]),

   .core_rst_l(core_rst_l[1]),   
   .active_l2clk(active_l2clk[1]),
   .free_l2clk(free_l2clk[1]),

   .trace_rv_i_insn_ip(trace_rv_i_insn_ip[1]),
   .trace_rv_i_address_ip(trace_rv_i_address_ip[1]),
   .trace_rv_i_valid_ip(trace_rv_i_valid_ip[1]),
   .trace_rv_i_exception_ip(trace_rv_i_exception_ip[1]),
   .trace_rv_i_ecause_ip(trace_rv_i_ecause_ip[1]),
   .trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip[1]),
   .trace_rv_i_tval_ip(trace_rv_i_tval_ip[1]),

   .dccm_clk_override(dccm_clk_override[1]),
   .icm_clk_override(icm_clk_override[1]),
   .dec_tlu_core_ecc_disable(dec_tlu_core_ecc_disable[1]),
   .btb_clk_override(btb_clk_override[1]),

   .dec_tlu_mhartstart(dec_tlu_mhartstart[1]), 

   // external halt/run interface
   .i_cpu_halt_req(i_cpu_halt_req[1]),    
   .i_cpu_run_req(i_cpu_run_req[1]),     
   .o_cpu_halt_status(o_cpu_halt_status[1]), 
   .o_cpu_halt_ack(o_cpu_halt_ack[1]),    
   .o_cpu_run_ack(o_cpu_run_ack[1]),     
   .o_debug_mode_status(o_debug_mode_status[1]), 

   .core_id(core_id[1]), 

   // external MPC halt/run interface
   .mpc_debug_halt_req(mpc_debug_halt_req[1]), 
   .mpc_debug_run_req(mpc_debug_run_req[1]),
   .mpc_reset_run_req(mpc_reset_run_req[1]),
   .mpc_debug_halt_ack(mpc_debug_halt_ack[1]), 
   .mpc_debug_run_ack(mpc_debug_run_ack[1]),
   .debug_brkpt_status(debug_brkpt_status[1]), 

   .dec_tlu_perfcnt0(dec_tlu_perfcnt0[1]),
   .dec_tlu_perfcnt1(dec_tlu_perfcnt1[1]),
   .dec_tlu_perfcnt2(dec_tlu_perfcnt2[1]), 
   .dec_tlu_perfcnt3(dec_tlu_perfcnt3[1]), 

   // DCCM ports
   .dccm_wren(dccm_wren[1]),
   .dccm_rden(dccm_rden[1]),
   .dccm_wr_addr_lo(dccm_wr_addr_lo[1]),
   .dccm_wr_addr_hi(dccm_wr_addr_hi[1]),
   .dccm_rd_addr_lo(dccm_rd_addr_lo[1]),
   .dccm_rd_addr_hi(dccm_rd_addr_hi[1]),
   .dccm_wr_data_lo(dccm_wr_data_lo[1]),
   .dccm_wr_data_hi(dccm_wr_data_hi[1]),

   .dccm_rd_data_lo(dccm_rd_data_lo[1]),
   .dccm_rd_data_hi(dccm_rd_data_hi[1]),

   // ICCM ports
   .iccm_rw_addr(iccm_rw_addr[1]),
   .iccm_buf_correct_ecc_thr(iccm_buf_correct_ecc_thr[1]),            
   .iccm_correction_state(iccm_correction_state[1]),               
   .iccm_stop_fetch(iccm_stop_fetch[1]),   
   .iccm_corr_scnd_fetch(iccm_corr_scnd_fetch[1]),                
   .ifc_select_tid_f1(ifc_select_tid_f1[1]),
   .iccm_wren(iccm_wren[1]),
   .iccm_rden(iccm_rden[1]),
   .iccm_wr_size(iccm_wr_size[1]),
   .iccm_wr_data(iccm_wr_data[1]),

   .iccm_rd_data(iccm_rd_data[1]),
   .iccm_rd_data_ecc(iccm_rd_data_ecc[1]),

   // ICache, ITAG  ports
   .ic_rw_addr(ic_rw_addr[1]),
   .ic_tag_valid(ic_tag_valid[1]),
   .ic_wr_en(ic_wr_en[1]),       
   .ic_rd_en(ic_rd_en[1]),

   .ic_wr_data(ic_wr_data[1]),
   .ic_rd_data(ic_rd_data[1]),
   .ic_debug_rd_data(ic_debug_rd_data[1]),    
   .ictag_debug_rd_data(ictag_debug_rd_data[1]),  
   .ic_debug_wr_data(ic_debug_wr_data[1]),     

   .ic_eccerr(ic_eccerr[1]),    
   .ic_parerr(ic_parerr[1]),

   .ic_premux_data(ic_premux_data[1]),     
   .ic_sel_premux_data(ic_sel_premux_data[1]), 

   .ic_debug_addr(ic_debug_addr[1]),      
   .ic_debug_rd_en(ic_debug_rd_en[1]),     
   .ic_debug_wr_en(ic_debug_wr_en[1]),     
   .ic_debug_tag_array(ic_debug_tag_array[1]), 
   .ic_debug_way(ic_debug_way[1]),       

   .ic_rd_hit(ic_rd_hit[1]),
   .ic_tag_perr(ic_tag_perr[1]),     

// BTB ports
   .btb_sram_pkt(btb_sram_pkt[1]),

   .btb_vbank0_rd_data_f1(btb_vbank0_rd_data_f1[1]),
   .btb_vbank1_rd_data_f1(btb_vbank1_rd_data_f1[1]),
   .btb_vbank2_rd_data_f1(btb_vbank2_rd_data_f1[1]),
   .btb_vbank3_rd_data_f1(btb_vbank3_rd_data_f1[1]),

   .btb_wren(btb_wren[1]),
   .btb_rden(btb_rden[1]),
   .btb_rw_addr(btb_rw_addr[1]),  
   .btb_rw_addr_f1(btb_rw_addr_f1[1]),  
   .btb_sram_wr_data(btb_sram_wr_data[1]),
   .btb_sram_rd_tag_f1(btb_sram_rd_tag_f1[1]),


   //-------------------------- LSU AXI signals--------------------------
   // AXI Write Channels
   .lsu_axi_awvalid(lsu_axi_awvalid[1]),
   .lsu_axi_awready(lsu_axi_awready[1]),
   .lsu_axi_awid(lsu_axi_awid[1]),
   .lsu_axi_awaddr(lsu_axi_awaddr[1]),
   .lsu_axi_awregion(lsu_axi_awregion[1]),
   .lsu_axi_awlen(lsu_axi_awlen[1]),
   .lsu_axi_awsize(lsu_axi_awsize[1]),
   .lsu_axi_awburst(lsu_axi_awburst[1]),
   .lsu_axi_awlock(lsu_axi_awlock[1]),
   .lsu_axi_awcache(lsu_axi_awcache[1]),
   .lsu_axi_awprot(lsu_axi_awprot[1]),
   .lsu_axi_awqos(lsu_axi_awqos[1]),

   .lsu_axi_wvalid(lsu_axi_wvalid[1]),
   .lsu_axi_wready(lsu_axi_wready[1]),
   .lsu_axi_wdata(lsu_axi_wdata[1]),
   .lsu_axi_wstrb(lsu_axi_wstrb[1]),
   .lsu_axi_wlast(lsu_axi_wlast[1]),

   .lsu_axi_bvalid(lsu_axi_bvalid[1]),
   .lsu_axi_bready(lsu_axi_bready[1]),
   .lsu_axi_bresp(lsu_axi_bresp[1]),
   .lsu_axi_bid(lsu_axi_bid[1]),

   // AXI Read Channels
   .lsu_axi_arvalid(lsu_axi_arvalid[1]),
   .lsu_axi_arready(lsu_axi_arready[1]),
   .lsu_axi_arid(lsu_axi_arid[1]),
   .lsu_axi_araddr(lsu_axi_araddr[1]),
   .lsu_axi_arregion(lsu_axi_arregion[1]),
   .lsu_axi_arlen(lsu_axi_arlen[1]),
   .lsu_axi_arsize(lsu_axi_arsize[1]),
   .lsu_axi_arburst(lsu_axi_arburst[1]),
   .lsu_axi_arlock(lsu_axi_arlock[1]),
   .lsu_axi_arcache(lsu_axi_arcache[1]),
   .lsu_axi_arprot(lsu_axi_arprot[1]),
   .lsu_axi_arqos(lsu_axi_arqos[1]),

   .lsu_axi_rvalid(lsu_axi_rvalid[1]),
   .lsu_axi_rready(lsu_axi_rready[1]),
   .lsu_axi_rid(lsu_axi_rid[1]),
   .lsu_axi_rdata(lsu_axi_rdata[1]),
   .lsu_axi_rresp(lsu_axi_rresp[1]),
   .lsu_axi_rlast(lsu_axi_rlast[1]),

   //-------------------------- IFU AXI signals--------------------------
   // AXI Write Channels
   .ifu_axi_awvalid(ifu_axi_awvalid[1]),
   .ifu_axi_awready(ifu_axi_awready[1]),
   .ifu_axi_awid(ifu_axi_awid[1]),
   .ifu_axi_awaddr(ifu_axi_awaddr[1]),
   .ifu_axi_awregion(ifu_axi_awregion[1]),
   .ifu_axi_awlen(ifu_axi_awlen[1]),
   .ifu_axi_awsize(ifu_axi_awsize[1]),
   .ifu_axi_awburst(ifu_axi_awburst[1]),
   .ifu_axi_awlock(ifu_axi_awlock[1]),
   .ifu_axi_awcache(ifu_axi_awcache[1]),
   .ifu_axi_awprot(ifu_axi_awprot[1]),
   .ifu_axi_awqos(ifu_axi_awqos[1]),

   .ifu_axi_wvalid(ifu_axi_wvalid[1]),
   .ifu_axi_wready(ifu_axi_wready[1]),
   .ifu_axi_wdata(ifu_axi_wdata[1]),
   .ifu_axi_wstrb(ifu_axi_wstrb[1]),
   .ifu_axi_wlast(ifu_axi_wlast[1]),

   .ifu_axi_bvalid(ifu_axi_bvalid[1]),
   .ifu_axi_bready(ifu_axi_bready[1]),
   .ifu_axi_bresp(ifu_axi_bresp[1]),
   .ifu_axi_bid(ifu_axi_bid[1]),

   // AXI Read Channels
   .ifu_axi_arvalid(ifu_axi_arvalid[1]),
   .ifu_axi_arready(ifu_axi_arready[1]),
   .ifu_axi_arid(ifu_axi_arid[1]),
   .ifu_axi_araddr(ifu_axi_araddr[1]),
   .ifu_axi_arregion(ifu_axi_arregion[1]),
   .ifu_axi_arlen(ifu_axi_arlen[1]),
   .ifu_axi_arsize(ifu_axi_arsize[1]),
   .ifu_axi_arburst(ifu_axi_arburst[1]),
   .ifu_axi_arlock(ifu_axi_arlock[1]),
   .ifu_axi_arcache(ifu_axi_arcache[1]),
   .ifu_axi_arprot(ifu_axi_arprot[1]),
   .ifu_axi_arqos(ifu_axi_arqos[1]),

   .ifu_axi_rvalid(ifu_axi_rvalid[1]),
   .ifu_axi_rready(ifu_axi_rready[1]),
   .ifu_axi_rid(ifu_axi_rid[1]),
   .ifu_axi_rdata(ifu_axi_rdata[1]),
   .ifu_axi_rresp(ifu_axi_rresp[1]),
   .ifu_axi_rlast(ifu_axi_rlast[1]),

   //-------------------------- SB AXI signals--------------------------
   // AXI Write Channels
   .sb_axi_awvalid(sb_axi_awvalid[1]),
   .sb_axi_awready(sb_axi_awready[1]),
   .sb_axi_awid(sb_axi_awid[1]),
   .sb_axi_awaddr(sb_axi_awaddr[1]),
   .sb_axi_awregion(sb_axi_awregion[1]),
   .sb_axi_awlen(sb_axi_awlen[1]),
   .sb_axi_awsize(sb_axi_awsize[1]),
   .sb_axi_awburst(sb_axi_awburst[1]),
   .sb_axi_awlock(sb_axi_awlock[1]),
   .sb_axi_awcache(sb_axi_awcache[1]),
   .sb_axi_awprot(sb_axi_awprot[1]),
   .sb_axi_awqos(sb_axi_awqos[1]),

   .sb_axi_wvalid(sb_axi_wvalid[1]),
   .sb_axi_wready(sb_axi_wready[1]),
   .sb_axi_wdata(sb_axi_wdata[1]),
   .sb_axi_wstrb(sb_axi_wstrb[1]),
   .sb_axi_wlast(sb_axi_wlast[1]),

   .sb_axi_bvalid(sb_axi_bvalid[1]),
   .sb_axi_bready(sb_axi_bready[1]),
   .sb_axi_bresp(sb_axi_bresp[1]),
   .sb_axi_bid(sb_axi_bid[1]),

   // AXI Read Channels
   .sb_axi_arvalid(sb_axi_arvalid[1]),
   .sb_axi_arready(sb_axi_arready[1]),
   .sb_axi_arid(sb_axi_arid[1]),
   .sb_axi_araddr(sb_axi_araddr[1]),
   .sb_axi_arregion(sb_axi_arregion[1]),
   .sb_axi_arlen(sb_axi_arlen[1]),
   .sb_axi_arsize(sb_axi_arsize[1]),
   .sb_axi_arburst(sb_axi_arburst[1]),
   .sb_axi_arlock(sb_axi_arlock[1]),
   .sb_axi_arcache(sb_axi_arcache[1]),
   .sb_axi_arprot(sb_axi_arprot[1]),
   .sb_axi_arqos(sb_axi_arqos[1]),

   .sb_axi_rvalid(sb_axi_rvalid[1]),
   .sb_axi_rready(sb_axi_rready[1]),
   .sb_axi_rid(sb_axi_rid[1]),
   .sb_axi_rdata(sb_axi_rdata[1]),
   .sb_axi_rresp(sb_axi_rresp[1]),
   .sb_axi_rlast(sb_axi_rlast[1]),

   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
   .dma_axi_awvalid(dma_axi_awvalid[1]),
   .dma_axi_awready(dma_axi_awready[1]),
   .dma_axi_awid(dma_axi_awid[1]),
   .dma_axi_awaddr(dma_axi_awaddr[1]),
   .dma_axi_awsize(dma_axi_awsize[1]),
   .dma_axi_awprot(dma_axi_awprot[1]),
   .dma_axi_awlen(dma_axi_awlen[1]),
   .dma_axi_awburst(dma_axi_awburst[1]),


   .dma_axi_wvalid(dma_axi_wvalid[1]),
   .dma_axi_wready(dma_axi_wready[1]),
   .dma_axi_wdata(dma_axi_wdata[1]),
   .dma_axi_wstrb(dma_axi_wstrb[1]),
   .dma_axi_wlast(dma_axi_wlast[1]),

   .dma_axi_bvalid(dma_axi_bvalid[1]),
   .dma_axi_bready(dma_axi_bready[1]),
   .dma_axi_bresp(dma_axi_bresp[1]),
   .dma_axi_bid(dma_axi_bid[1]),

   // AXI Read Channels
   .dma_axi_arvalid(dma_axi_arvalid[1]),
   .dma_axi_arready(dma_axi_arready[1]),
   .dma_axi_arid(dma_axi_arid[1]),
   .dma_axi_araddr(dma_axi_araddr[1]),
   .dma_axi_arsize(dma_axi_arsize[1]),
   .dma_axi_arprot(dma_axi_arprot[1]),
   .dma_axi_arlen(dma_axi_arlen[1]),
   .dma_axi_arburst(dma_axi_arburst[1]),

   .dma_axi_rvalid(dma_axi_rvalid[1]),
   .dma_axi_rready(dma_axi_rready[1]),
   .dma_axi_rid(dma_axi_rid[1]),
   .dma_axi_rdata(dma_axi_rdata[1]),
   .dma_axi_rresp(dma_axi_rresp[1]),
   .dma_axi_rlast(dma_axi_rlast[1]),

    //// AHB LITE BUS
   .haddr(haddr[1]),
   .hburst(hburst[1]),
   .hmastlock(hmastlock[1]),
   .hprot(hprot[1]),
   .hsize(hsize[1]),
   .htrans(htrans[1]),
   .hwrite(hwrite[1]),

   .hrdata(hrdata[1]),
   .hready(hready[1]),
   .hresp(hresp[1]),

   // LSU AHB Master
   .lsu_haddr(lsu_haddr[1]),
   .lsu_hburst(lsu_hburst[1]),
   .lsu_hmastlock(lsu_hmastlock[1]),
   .lsu_hprot(lsu_hprot[1]),
   .lsu_hsize(lsu_hsize[1]),
   .lsu_htrans(lsu_htrans[1]),
   .lsu_hwrite(lsu_hwrite[1]),
   .lsu_hwdata(lsu_hwdata[1]),

   .lsu_hrdata(lsu_hrdata[1]),
   .lsu_hready(lsu_hready[1]),
   .lsu_hresp(lsu_hresp[1]),

   //System Bus Debug Master
   .sb_haddr(sb_haddr[1]),
   .sb_hburst(sb_hburst[1]),
   .sb_hmastlock(sb_hmastlock[1]),
   .sb_hprot(sb_hprot[1]),
   .sb_hsize(sb_hsize[1]),
   .sb_htrans(sb_htrans[1]),
   .sb_hwrite(sb_hwrite[1]),
   .sb_hwdata(sb_hwdata[1]),

   .sb_hrdata(sb_hrdata[1]),
   .sb_hready(sb_hready[1]),
   .sb_hresp(sb_hresp[1]),

   // DMA Slave
   .dma_haddr(dma_haddr[1]),
   .dma_hburst(dma_hburst[1]),
   .dma_hmastlock(dma_hmastlock[1]),
   .dma_hprot(dma_hprot[1]),
   .dma_hsize(dma_hsize[1]),
   .dma_htrans(dma_htrans[1]),
   .dma_hwrite(dma_hwrite[1]),
   .dma_hwdata(dma_hwdata[1]),
   .dma_hreadyin(dma_hreadyin[1]),
   .dma_hsel(dma_hsel[1]),

   .dma_hrdata(dma_hrdata[1]),
   .dma_hreadyout(dma_hreadyout[1]),
   .dma_hresp(dma_hresp[1]),

   .lsu_bus_clk_en(lsu_bus_clk_en[1]),
   .ifu_bus_clk_en(ifu_bus_clk_en[1]),
   .dbg_bus_clk_en(dbg_bus_clk_en[1]),
   .dma_bus_clk_en(dma_bus_clk_en[1]),

   //DMI signals
   .dmi_reg_en(dmi_reg_en[1]),     
   .dmi_reg_addr(dmi_reg_addr[1]),   
   .dmi_reg_wr_en(dmi_reg_wr_en[1]),  
   .dmi_reg_wdata(dmi_reg_wdata[1]),  
   .dmi_reg_rdata(dmi_reg_rdata[1]),  

   .extintsrc_req(extintsrc_req[1]),
   .timer_int(timer_int[1]),   
   .soft_int(soft_int[1]),    
   .scan_mode(scan_mode[1])
       
   );

   // Instantiate the mem
   eh2_mem #(.pt(pt)) mem (
        .clk(active_l2clk),
        .rst_l(core_rst_l),
        .*
        );

`ifdef RV_ASSERT_ON
initial begin
    $assertoff(0, swerv);
    @ (negedge clk) $asserton(0, swerv);
end
`endif

endmodule

