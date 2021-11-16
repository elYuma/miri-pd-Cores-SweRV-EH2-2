//********************************************************************************
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

module eh2_mem
import eh2_pkg::*;
#(
`include "eh2_param.vh"
)
(
   input logic [pt.NUM_CORES-1:0]         clk,
   input logic [pt.NUM_CORES-1:0]         rst_l,
   input logic [pt.NUM_CORES-1:0]         dccm_clk_override,
   input logic [pt.NUM_CORES-1:0]         icm_clk_override,
   input logic [pt.NUM_CORES-1:0]         dec_tlu_core_ecc_disable,
   input logic [pt.NUM_CORES-1:0]         btb_clk_override,

   //DCCM ports
   input logic [pt.NUM_CORES-1:0]         dccm_wren,
   input logic [pt.NUM_CORES-1:0]         dccm_rden,
   input logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_wr_addr_lo,
   input logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_wr_addr_hi,
   input logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_rd_addr_lo,
   input logic [pt.NUM_CORES-1:0] [pt.DCCM_BITS-1:0]  dccm_rd_addr_hi,
   input logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_wr_data_lo,
   input logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_wr_data_hi,

   output logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_rd_data_lo,
   output logic [pt.NUM_CORES-1:0] [pt.DCCM_FDATA_WIDTH-1:0]  dccm_rd_data_hi,

   // REVISE THIS
   input eh2_dccm_ext_in_pkt_t  [pt.NUM_CORES-1:0][pt.DCCM_NUM_BANKS-1:0] dccm_ext_in_pkt,

   //ICCM ports
   input eh2_ccm_ext_in_pkt_t   [pt.NUM_CORES-1:0][pt.ICCM_NUM_BANKS/4-1:0][1:0][1:0]  iccm_ext_in_pkt,

   input logic [pt.NUM_CORES-1:0] [pt.ICCM_BITS-1:1]  iccm_rw_addr,
   input logic [pt.NUM_CORES-1:0] [pt.NUM_THREADS-1:0]iccm_buf_correct_ecc_thr,            // ICCM is doing a single bit error correct cycle
   input logic [pt.NUM_CORES-1:0]                     iccm_correction_state,               // We are under a correction - This is needed to guard replacements when hit
   input logic [pt.NUM_CORES-1:0]                     iccm_stop_fetch,                     // Squash any lru updates on the red hits as we have fetched ahead
   input logic [pt.NUM_CORES-1:0]                     iccm_corr_scnd_fetch,                // dont match on middle bank when under correction


   input logic [pt.NUM_CORES-1:0]         ifc_select_tid_f1,
   input logic [pt.NUM_CORES-1:0]         iccm_wren,
   input logic [pt.NUM_CORES-1:0]         iccm_rden,
   input logic [pt.NUM_CORES-1:0] [2:0]   iccm_wr_size,
   input logic [pt.NUM_CORES-1:0] [77:0]  iccm_wr_data,

   output logic [pt.NUM_CORES-1:0] [63:0]  iccm_rd_data,
   output logic [pt.NUM_CORES-1:0] [116:0] iccm_rd_data_ecc,
   // Icache and Itag Ports
   input  logic [pt.NUM_CORES-1:0] [31:1]  ic_rw_addr,
   input  logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]   ic_tag_valid,
   input  logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]          ic_wr_en  ,         // Which way to write
   input  logic [pt.NUM_CORES-1:0]         ic_rd_en,
   input  logic [pt.NUM_CORES-1:0] [63:0]  ic_premux_data,     // Premux data to be muxed with each way of the Icache.
   input  logic [pt.NUM_CORES-1:0]         ic_sel_premux_data, // Premux data sel

   input eh2_ic_data_ext_in_pkt_t   [pt.NUM_CORES-1:0][pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]         ic_data_ext_in_pkt,
   input eh2_ic_tag_ext_in_pkt_t    [pt.NUM_CORES-1:0][pt.ICACHE_NUM_WAYS-1:0]              ic_tag_ext_in_pkt,

   input logic [pt.NUM_CORES-1:0] [pt.ICACHE_BANKS_WAY-1:0] [70:0]               ic_wr_data,           // Data to fill to the Icache. With ECC
   output logic [pt.NUM_CORES-1:0] [63:0]               ic_rd_data ,          // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
   output logic [pt.NUM_CORES-1:0] [70:0]               ic_debug_rd_data ,    // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
   output logic [pt.NUM_CORES-1:0] [25:0]               ictag_debug_rd_data,  // Debug icache tag.
   input  logic [pt.NUM_CORES-1:0] [70:0]               ic_debug_wr_data,     // Debug wr cache.


   input logic [pt.NUM_CORES-1:0] [pt.ICACHE_INDEX_HI:3]           ic_debug_addr,      // Read/Write addresss to the Icache.
   input  logic [pt.NUM_CORES-1:0]                                 ic_debug_rd_en,     // Icache debug rd
   input  logic [pt.NUM_CORES-1:0]                                 ic_debug_wr_en,     // Icache debug wr
   input  logic [pt.NUM_CORES-1:0]                                 ic_debug_tag_array, // Debug tag array
   input  logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]        ic_debug_way,       // Debug way. Rd or Wr.


   output  logic [pt.NUM_CORES-1:0] [pt.ICACHE_BANKS_WAY-1:0]       ic_eccerr,
   output  logic [pt.NUM_CORES-1:0] [pt.ICACHE_BANKS_WAY-1:0]       ic_parerr,


   output logic [pt.NUM_CORES-1:0] [pt.ICACHE_NUM_WAYS-1:0]   ic_rd_hit,
   output logic [pt.NUM_CORES-1:0]         ic_tag_perr,        // Icache Tag parity error

   // BTB ports
 input eh2_ccm_ext_in_pkt_t   [pt.NUM_CORES-1:0][1:0] btb_ext_in_pkt,

 input logic [pt.NUM_CORES-1:0]                         btb_wren,
 input logic [pt.NUM_CORES-1:0]                         btb_rden,
 input logic [pt.NUM_CORES-1:0] [1:0] [pt.BTB_ADDR_HI:1] btb_rw_addr,  // per bank
 input logic [pt.NUM_CORES-1:0] [1:0] [pt.BTB_ADDR_HI:1] btb_rw_addr_f1,  // per bank
 input logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0]         btb_sram_wr_data,
 input logic [pt.NUM_CORES-1:0] [1:0] [pt.BTB_BTAG_SIZE-1:0] btb_sram_rd_tag_f1,

 output eh2_btb_sram_pkt btb_sram_pkt,

 output logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0]      btb_vbank0_rd_data_f1,
 output logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0]      btb_vbank1_rd_data_f1,
 output logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0]      btb_vbank2_rd_data_f1,
 output logic [pt.NUM_CORES-1:0] [pt.BTB_TOFFSET_SIZE+pt.BTB_BTAG_SIZE+5-1:0]      btb_vbank3_rd_data_f1,

 input  logic [pt.NUM_CORES-1:0]         scan_mode
);

   logic  [pt.NUM_CORES-1:0]active_clk;
   rvoclkhdr active_cg   ( .en(1'b1),         .l1clk(active_clk), .* );

   // DCCM Instantiation
   if (pt.DCCM_ENABLE == 1) begin: Gen_dccm_enable
      // DCCM Core 0
      eh2_lsu_dccm_mem #(.pt(pt)) dccm_0 (
		 .clk(clk[0]),                               
		 .active_clk(active_clk[0]),        
		 .rst_l(rst_l[0]),
		 .clk_override(dccm_clk_override[0]),

		 .dccm_wren(dccm_wren[0]),                        
		 .dccm_rden(dccm_rden[0]),                            
		 .dccm_wr_addr_lo(dccm_wr_addr_lo[0]),         
		 .dccm_wr_addr_hi(dccm_wr_addr_hi[0]),           
		 .dccm_rd_addr_lo(dccm_rd_addr_lo[0]),    
		 .dccm_rd_addr_hi(dccm_rd_addr_hi[0]), 
		 .dccm_wr_data_lo(dccm_wr_data_lo[0]),  
		 .dccm_wr_data_hi(dccm_wr_data_hi[0]),
		 .dccm_ext_in_pkt(dccm_ext_in_pkt[0]),  

		 .dccm_rd_data_lo(dccm_rd_data_lo[0]),   
		 .dccm_rd_data_hi(dccm_rd_data_hi[0]),  

		 .scan_mode(scan_mode[0])
      );
	  // DCCM Core 1
	  eh2_lsu_dccm_mem #(.pt(pt)) dccm_1 (
		 .clk(clk[1]),                               
		 .active_clk(active_clk[1]),        
		 .rst_l(rst_l[1]),
		 .clk_override(dccm_clk_override[1]),

		 .dccm_wren(dccm_wren[1]),                        
		 .dccm_rden(dccm_rden[1]),                            
		 .dccm_wr_addr_lo(dccm_wr_addr_lo[1]),         
		 .dccm_wr_addr_hi(dccm_wr_addr_hi[1]),           
		 .dccm_rd_addr_lo(dccm_rd_addr_lo[1]),    
		 .dccm_rd_addr_hi(dccm_rd_addr_hi[1]), 
		 .dccm_wr_data_lo(dccm_wr_data_lo[1]),  
		 .dccm_wr_data_hi(dccm_wr_data_hi[1]),
		 .dccm_ext_in_pkt(dccm_ext_in_pkt[1]),  

		 .dccm_rd_data_lo(dccm_rd_data_lo[1]),   
		 .dccm_rd_data_hi(dccm_rd_data_hi[1]),  

		 .scan_mode(scan_mode[1])
      );
   end else begin: Gen_dccm_disable
      assign dccm_rd_data_lo[pt.NUM_CORES-1:0] = '0;
      assign dccm_rd_data_hi[pt.NUM_CORES-1:0] = '0;
   end

if (pt.ICACHE_ENABLE == 1) begin : icache
   // ICM Core 0
   eh2_ifu_ic_mem #(.pt(pt)) icm_0  (
	  .clk(clk[0]),
      .active_clk(active_clk[0]),
      .rst_l(rst_l[0]),
      .clk_override(icm_clk_override[0]),
      .dec_tlu_core_ecc_disable(dec_tlu_core_ecc_disable[0]),

      .ic_rw_addr(ic_rw_addr[0]),
      .ic_wr_en(ic_wr_en[0]),       
      .ic_rd_en(ic_rd_en[0]),      
      .ic_debug_addr(ic_debug_addr[0]),    
      .ic_debug_rd_en(ic_debug_rd_en[0]),   
      .ic_debug_wr_en(ic_debug_wr_en[0]),    
      .ic_debug_tag_array(ic_debug_tag_array[0]), 
      .ic_debug_way(ic_debug_way[0]),    
      .ic_premux_data(ic_premux_data[0]),  
      .ic_sel_premux_data(ic_sel_premux_data[0]),

      .ic_wr_data(ic_wr_data[0]),   
      .ic_rd_data(ic_rd_data[0]),    
      .ic_debug_rd_data(ic_debug_rd_data[0]), 
      .ictag_debug_rd_data(ictag_debug_rd_data[0]),
      .ic_debug_wr_data(ic_debug_wr_data[0]),  

      .ic_eccerr(ic_eccerr[0]),               
      .ic_parerr(ic_parerr[0]),            
      .ic_tag_valid(ic_tag_valid[0]),            

      .ic_data_ext_in_pkt(ic_data_ext_in_pkt[0]),   
      .ic_tag_ext_in_pkt(ic_tag_ext_in_pkt[0]),

      .ic_rd_hit(ic_rd_hit[0]),  
      .ic_tag_perr(ic_tag_perr[0]), 
      .scan_mode(scan_mode[0])
   );
   // ICM Core 1
   eh2_ifu_ic_mem #(.pt(pt)) icm_1  (
	  .clk(clk[1]),
      .active_clk(active_clk[1]),
      .rst_l(rst_l[1]),
      .clk_override(icm_clk_override[1]),
      .dec_tlu_core_ecc_disable(dec_tlu_core_ecc_disable[1]),

      .ic_rw_addr(ic_rw_addr[1]),
      .ic_wr_en(ic_wr_en[1]),       
      .ic_rd_en(ic_rd_en[1]),      
      .ic_debug_addr(ic_debug_addr[1]),    
      .ic_debug_rd_en(ic_debug_rd_en[1]),   
      .ic_debug_wr_en(ic_debug_wr_en[1]),    
      .ic_debug_tag_array(ic_debug_tag_array[1]), 
      .ic_debug_way(ic_debug_way[1]),    
      .ic_premux_data(ic_premux_data[1]),  
      .ic_sel_premux_data(ic_sel_premux_data[1]),

      .ic_wr_data(ic_wr_data[1]),   
      .ic_rd_data(ic_rd_data[1]),    
      .ic_debug_rd_data(ic_debug_rd_data[1]), 
      .ictag_debug_rd_data(ictag_debug_rd_data[1]),
      .ic_debug_wr_data(ic_debug_wr_data[1]),  

      .ic_eccerr(ic_eccerr[1]),               
      .ic_parerr(ic_parerr[1]),            
      .ic_tag_valid(ic_tag_valid[1]),            

      .ic_data_ext_in_pkt(ic_data_ext_in_pkt[1]),   
      .ic_tag_ext_in_pkt(ic_tag_ext_in_pkt[1]),

      .ic_rd_hit(ic_rd_hit[1]),  
      .ic_tag_perr(ic_tag_perr[1]), 
      .scan_mode(scan_mode[1])
   );
end
else begin
   assign   ic_rd_hit[pt.NUM_CORES-1:0][3:0] = '0;
   assign   ic_tag_perr[pt.NUM_CORES-1:0]    = '0 ;
   assign   ic_rd_data[pt.NUM_CORES-1:0]  = '0 ;
   assign   ictag_debug_rd_data[pt.NUM_CORES-1:0]  = '0 ;
end

if (pt.ICCM_ENABLE == 1) begin : iccm
   // ICCM Core 0
   eh2_ifu_iccm_mem  #(.pt(pt)) iccm_0 (
				  .clk(clk[0]),
				  .active_clk(active_clk[0]),
				  .rst_l(rst_l[0]),
				  .clk_override(icm_clk_override[0]),

				  .ifc_select_tid_f1(ifc_select_tid_f1[0]),
				  .iccm_wren(iccm_wren[0]),
				  .iccm_rden(iccm_rden[0]),
				  .iccm_rw_addr(iccm_rw_addr[0][pt.ICCM_BITS-1:1]),
				  .iccm_buf_correct_ecc_thr(iccm_buf_correct_ecc_thr[0]),       
				  .iccm_correction_state(iccm_correction_state[0]),         
				  .iccm_stop_fetch(iccm_stop_fetch[0]),               
				  .iccm_corr_scnd_fetch(iccm_corr_scnd_fetch[0]),          

				  .iccm_wr_size(iccm_wr_size[0]),
				  .iccm_wr_data(iccm_wr_data[0]),


				  .iccm_ext_in_pkt(iccm_ext_in_pkt[0]),

				  .iccm_rd_data(iccm_rd_data[0][63:0]),
				  .iccm_rd_data_ecc(iccm_rd_data_ecc[0]),
				  .scan_mode(scan_mode[0])
                   );
	// ICCM Core 1			   
    eh2_ifu_iccm_mem  #(.pt(pt)) iccm_1 (
				  .clk(clk[1]),
				  .active_clk(active_clk[1]),
				  .rst_l(rst_l[1]),
				  .clk_override(icm_clk_override[1]),

				  .ifc_select_tid_f1(ifc_select_tid_f1[1]),
				  .iccm_wren(iccm_wren[1]),
				  .iccm_rden(iccm_rden[1]),
				  .iccm_rw_addr(iccm_rw_addr[1][pt.ICCM_BITS-1:1]),
				  .iccm_buf_correct_ecc_thr(iccm_buf_correct_ecc_thr[1]),       
				  .iccm_correction_state(iccm_correction_state[1]),         
				  .iccm_stop_fetch(iccm_stop_fetch[1]),               
				  .iccm_corr_scnd_fetch(iccm_corr_scnd_fetch[1]),          

				  .iccm_wr_size(iccm_wr_size[1]),
				  .iccm_wr_data(iccm_wr_data[1]),


				  .iccm_ext_in_pkt(iccm_ext_in_pkt[1]),

				  .iccm_rd_data(iccm_rd_data[1][63:0]),
				  .iccm_rd_data_ecc(iccm_rd_data_ecc[1]),
				  .scan_mode(scan_mode[1])
                   );
end
else  begin
   assign iccm_rd_data     = '0 ;
   assign iccm_rd_data_ecc = '0 ;
end

// BTB sram
if (pt.BTB_USE_SRAM == 1) begin : btb
   // BTB sram Core 0
   eh2_ifu_btb_mem #(.pt(pt)) btb_0  (
	  .clk(clk[0]),
      .active_clk(active_clk[0]),
      .rst_l(rst_l[0]),
      .clk_override(btb_clk_override[0]),

      .btb_ext_in_pkt(btb_ext_in_pkt[0]),
 
      .btb_wren(btb_wren[0]),
      .btb_rden(btb_rden[0]),
      .btb_rw_addr(btb_rw_addr[0]), 
      .btb_rw_addr_f1(btb_rw_addr_f1[0]),
      .btb_sram_wr_data(btb_sram_wr_data[0]),
      .btb_sram_rd_tag_f1(btb_sram_rd_tag_f1[0]),

      .btb_sram_pkt(btb_sram_pkt[0]),

      .btb_vbank0_rd_data_f1(btb_vbank0_rd_data_f1[0]),
      .btb_vbank1_rd_data_f1(btb_vbank1_rd_data_f1[0]),
      .btb_vbank2_rd_data_f1(btb_vbank2_rd_data_f1[0]),
      .btb_vbank3_rd_data_f1(btb_vbank3_rd_data_f1[0]),

     .scan_mode(scan_mode[0])
   );
   // BTB sram Core 1
   eh2_ifu_btb_mem #(.pt(pt)) btb_1  (
	  .clk(clk[1]),
      .active_clk(active_clk[1]),
      .rst_l(rst_l[1]),
      .clk_override(btb_clk_override[1]),

      .btb_ext_in_pkt(btb_ext_in_pkt[1]),
 
      .btb_wren(btb_wren[1]),
      .btb_rden(btb_rden[1]),
      .btb_rw_addr(btb_rw_addr[1]), 
      .btb_rw_addr_f1(btb_rw_addr_f1[1]),
      .btb_sram_wr_data(btb_sram_wr_data[1]),
      .btb_sram_rd_tag_f1(btb_sram_rd_tag_f1[1]),

      .btb_sram_pkt(btb_sram_pkt[1]),

      .btb_vbank0_rd_data_f1(btb_vbank0_rd_data_f1[1]),
      .btb_vbank1_rd_data_f1(btb_vbank1_rd_data_f1[1]),
      .btb_vbank2_rd_data_f1(btb_vbank2_rd_data_f1[1]),
      .btb_vbank3_rd_data_f1(btb_vbank3_rd_data_f1[1]),

     .scan_mode(scan_mode[1])
   );
end


endmodule
