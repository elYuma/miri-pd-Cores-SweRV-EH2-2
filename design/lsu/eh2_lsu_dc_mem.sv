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
////////////////////////////////////////////////////
//   DCACHE DATA & TAG MODULE WRAPPER              //
//   DCACHE DATA & TAG MODULE WRAPPER      (from ICACHE)        //
/////////////////////////////////////////////////////
module eh2_lsu_dc_mem
import eh2_pkg::*;
#(
`include "eh2_param.vh"
 )
  (

      input logic                                   clk,
      input logic                                   active_clk,
      input logic                                   rst_l,
      input logic                                   clk_override,
      input logic                                   dec_tlu_core_ecc_disable,

      input logic [31:1]                            dc_rw_addr,
      input logic [pt.ICACHE_NUM_WAYS-1:0]          dc_wr_en  ,         // Which way to write
      input logic                                   dc_rd_en  ,         // Read enable
      input logic [pt.ICACHE_INDEX_HI:3]            dc_debug_addr,      // Read/Write addresss to the Icache.
      input logic                                   dc_debug_rd_en,     // Icache debug rd
      input logic                                   dc_debug_wr_en,     // Icache debug wr
      input logic                                   dc_debug_tag_array, // Debug tag array
      input logic [pt.ICACHE_NUM_WAYS-1:0]          dc_debug_way,       // Debug way. Rd or Wr.
      input logic [63:0]                            dc_premux_data,     // Premux data to be muxed with each way of the Icache.
      input logic                                   dc_sel_premux_data, // Select the pre_muxed data

      input  logic [pt.ICACHE_BANKS_WAY-1:0][70:0]  dc_wr_data,         // Data to fill to the Icache. With ECC
      output logic [63:0]                           dc_rd_data ,        // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
      output logic [70:0]                           dc_debug_rd_data ,  // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
      output logic [25:0]                           dctag_debug_rd_data,// Debug dcache tag.
      input logic  [70:0]                           dc_debug_wr_data,   // Debug wr cache.

      output logic [pt.ICACHE_BANKS_WAY-1:0]        dc_eccerr,                 // ecc error per bank
      output logic [pt.ICACHE_BANKS_WAY-1:0]        dc_parerr,                 // ecc error per bank
      input logic [pt.ICACHE_NUM_WAYS-1:0]          dc_tag_valid,              // Valid from the I$ tag valid outside (in flops).

      input eh2_ic_data_ext_in_pkt_t [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] dc_data_ext_in_pkt,   // this is being driven by the top level for soc testing/etc
      input eh2_ic_tag_ext_in_pkt_t  [pt.ICACHE_NUM_WAYS-1:0]                          dc_tag_ext_in_pkt,

      output logic [pt.ICACHE_NUM_WAYS-1:0]         dc_rd_hit,   // dc_rd_hit[3:0]
      output logic                                  dc_tag_perr, // Tag Parity error
      input  logic                                  scan_mode
      ) ;


   EH2_DC_TAG #(.pt(pt)) dc_tag_data
          (
           .*,
           .dc_wr_en     (dc_wr_en[pt.ICACHE_NUM_WAYS-1:0]),
           .dc_debug_addr(dc_debug_addr[pt.ICACHE_INDEX_HI:3]),
           .dc_rw_addr   (dc_rw_addr[31:3])
           ) ;

   EH2_DC_DATA #(.pt(pt)) dc_data_data
          (
           .*,
           .dc_wr_en     (dc_wr_en[pt.ICACHE_NUM_WAYS-1:0]),
           .dc_debug_addr(dc_debug_addr[pt.ICACHE_INDEX_HI:3]),
           .dc_rw_addr   (dc_rw_addr[31:1])
           ) ;

 endmodule


/////////////////////////////////////////////////
////// DCACHE DATA MODULE    ////////////////////
/////////////////////////////////////////////////
module EH2_DC_DATA
import eh2_pkg::*;
#(
`include "eh2_param.vh"
 )
     (
      input logic clk,
      input logic active_clk,
      input logic rst_l,
      input logic clk_override,


      input logic [31:1]  dc_rw_addr,
      input logic [pt.ICACHE_NUM_WAYS-1:0]dc_wr_en,
      input logic                          dc_rd_en,           // Read enable

      input  logic [pt.ICACHE_BANKS_WAY-1:0][70:0]    dc_wr_data,         // Data to fill to the Icache. With ECC
      output logic [63:0]                             dc_rd_data ,                                 // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
      input  logic [70:0]                             dc_debug_wr_data,   // Debug wr cache.
      output logic [70:0]                             dc_debug_rd_data ,  // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
      output logic [pt.ICACHE_BANKS_WAY-1:0] dc_parerr,
      output logic [pt.ICACHE_BANKS_WAY-1:0] dc_eccerr,    // ecc error per bank
      input logic [pt.ICACHE_INDEX_HI:3]     dc_debug_addr,     // Read/Write addresss to the Icache.
      input logic                            dc_debug_rd_en,      // Icache debug rd
      input logic                            dc_debug_wr_en,      // Icache debug wr
      input logic                            dc_debug_tag_array,  // Debug tag array
      input logic [pt.ICACHE_NUM_WAYS-1:0]   dc_debug_way,        // Debug way. Rd or Wr.
      input logic [63:0]                     dc_premux_data,      // Premux data to be muxed with each way of the Icache.
      input logic                            dc_sel_premux_data,  // Select the pre_muxed data

      input logic [pt.ICACHE_NUM_WAYS-1:0]dc_rd_hit,
      input eh2_ic_data_ext_in_pkt_t  [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] dc_data_ext_in_pkt,   // this is being driven by the top level for soc testing/etc
      input  logic                         scan_mode

      ) ;


   logic [pt.ICACHE_TAG_INDEX_LO-1:1]                                             dc_rw_addr_ff;
   logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_WAYS-1:0]                        dc_b_sb_wren;    //bank x ways
   logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_WAYS-1:0]                        dc_b_sb_rden;    //bank x ways
   logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_rden;       //bank
   logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_rden_ff;    //bank
   logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_debug_sel_sb;


   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][70:0]                  wb_dout ;       //  ways x bank
   logic [pt.ICACHE_BANKS_WAY-1:0][70:0]                                          dc_sb_wr_data, dc_bank_wr_data, wb_dout_ecc_bank, wb_dout_ecc_bank_ff;
   logic [pt.ICACHE_NUM_WAYS-1:0] [141:0]                                         wb_dout_way, wb_dout_way_pre, wb_dout_way_with_premux;
   logic [141:0]                                                                  wb_dout_ecc;

   logic [pt.ICACHE_BANKS_WAY-1:0]                                                bank_check_en;
   logic [pt.ICACHE_BANKS_WAY-1:0]                                                bank_check_en_ff;


   logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_WAYS-1:0]                        dc_bank_way_clken;     // bank x way clk enables
   logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_bank_way_clken_final;  // ;
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                        dc_bank_way_clken_final_up;  // ;

   logic [pt.ICACHE_NUM_WAYS-1:0]                                                 dc_debug_rd_way_en;    // debug wr_way
   logic [pt.ICACHE_NUM_WAYS-1:0]                                                 dc_debug_rd_way_en_ff; // debug wr_way
   logic [pt.ICACHE_NUM_WAYS-1:0]                                                 dc_debug_wr_way_en;    // debug wr_way
   logic [pt.ICACHE_INDEX_HI:1]                                                   dc_rw_addr_q;
   logic [pt.ICACHE_BANKS_WAY-1:0] [pt.ICACHE_INDEX_HI : pt.ICACHE_DATA_INDEX_LO] dc_rw_addr_bank_q;
   logic [pt.ICACHE_TAG_LO-1 : pt.ICACHE_DATA_INDEX_LO]                           dc_rw_addr_q_inc;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                                 dc_rd_hit_q;



      logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_sram_en;
      logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_read_en;
      logic [pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_write_en;
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0] [31 : pt.ICACHE_DATA_INDEX_LO]  wb_index_hold;
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 write_bypass_en;     //bank
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 write_bypass_en_ff;  //bank
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 index_valid;  //bank
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 dc_b_clear_en;
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 dc_b_addr_match;
      logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 dc_b_addr_match_index_only;

      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_sram_en_up;
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_read_en_up;
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                                                dc_b_write_en_up;
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0] [31 : pt.ICACHE_DATA_INDEX_LO]  wb_index_hold_up;
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 write_bypass_en_up;     //bank
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 write_bypass_en_ff_up;  //bank
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 index_valid_up;  //bank
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 dc_b_clear_en_up;
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 dc_b_addr_match_up;
      logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                                 dc_b_addr_match_index_only_up;


   logic [pt.ICACHE_BANKS_WAY-1:0]                 [31 : pt.ICACHE_DATA_INDEX_LO] dc_b_rw_addr;
   logic [pt.ICACHE_BANKS_WAY-1:0]                 [31 : pt.ICACHE_DATA_INDEX_LO] dc_b_rw_addr_index_only;

   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                 [31 : pt.ICACHE_DATA_INDEX_LO] dc_b_rw_addr_up;
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                 [31 : pt.ICACHE_DATA_INDEX_LO] dc_b_rw_addr_index_only_up;



   logic                                                                          dc_rd_en_with_debug;
   logic                                                                          dc_rw_addr_wrap, dc_cacheline_wrap_ff;

   logic                                                                          dc_debug_rd_en_ff;


//-----------------------------------------------------------
// ----------- Logic section starts here --------------------
//-----------------------------------------------------------
   assign  dc_debug_rd_way_en[pt.ICACHE_NUM_WAYS-1:0] =  {pt.ICACHE_NUM_WAYS{dc_debug_rd_en & ~dc_debug_tag_array}} & dc_debug_way[pt.ICACHE_NUM_WAYS-1:0] ;
   assign  dc_debug_wr_way_en[pt.ICACHE_NUM_WAYS-1:0] =  {pt.ICACHE_NUM_WAYS{dc_debug_wr_en & ~dc_debug_tag_array}} & dc_debug_way[pt.ICACHE_NUM_WAYS-1:0] ;

   always_comb begin : clkens
      dc_bank_way_clken   = '0;

      for ( int i=0; i<pt.ICACHE_BANKS_WAY; i++) begin: wr_ens
       dc_b_sb_wren[i]        =  dc_wr_en[pt.ICACHE_NUM_WAYS-1:0]  |
                                       (dc_debug_wr_way_en[pt.ICACHE_NUM_WAYS-1:0] & {pt.ICACHE_NUM_WAYS{dc_debug_addr[pt.ICACHE_BANK_HI : pt.ICACHE_BANK_LO] == i}}) ;
       dc_debug_sel_sb[i]     = (dc_debug_addr[pt.ICACHE_BANK_HI : pt.ICACHE_BANK_LO] == i );
       dc_sb_wr_data[i]       = (dc_debug_sel_sb[i] & dc_debug_wr_en) ? dc_debug_wr_data : dc_bank_wr_data[i] ;
       dc_b_rden[i]           =  dc_rd_en_with_debug & ( ( ~dc_rw_addr_q[pt.ICACHE_BANK_HI] & (i==0)) |
                                                         (( dc_rw_addr_q[pt.ICACHE_BANK_HI] & dc_rw_addr_q[2:1] != 2'b00) & (i==0)) |
                                                         (  dc_rw_addr_q[pt.ICACHE_BANK_HI] & (i==1)) |
                                                         ((~dc_rw_addr_q[pt.ICACHE_BANK_HI] & dc_rw_addr_q[2:1] != 2'b00) & (i==1)) ) ;



       dc_b_sb_rden[i]        =  {pt.ICACHE_NUM_WAYS{dc_b_rden[i]}}   ;


       for ( int j=0; j<pt.ICACHE_NUM_WAYS; j++) begin: way_clkens
         dc_bank_way_clken[i][j] |= dc_b_sb_rden[i][j] | clk_override | dc_b_sb_wren[i][j];
       end
     end // block: wr_ens
   end // block: clkens

// bank read enables
  assign dc_rd_en_with_debug                          = ((dc_rd_en   | dc_debug_rd_en ) & ~(|dc_wr_en));
  assign dc_rw_addr_q[pt.ICACHE_INDEX_HI:1] = (dc_debug_rd_en | dc_debug_wr_en) ?
                                              {dc_debug_addr[pt.ICACHE_INDEX_HI:3],2'b0} :
                                              dc_rw_addr[pt.ICACHE_INDEX_HI:1] ;

   assign dc_rw_addr_q_inc[pt.ICACHE_TAG_LO-1:pt.ICACHE_DATA_INDEX_LO] = dc_rw_addr_q[pt.ICACHE_TAG_LO-1 : pt.ICACHE_DATA_INDEX_LO] + 1 ;
   assign dc_rw_addr_wrap                                        = dc_rw_addr_q[pt.ICACHE_BANK_HI] & dc_rd_en_with_debug & ~(|dc_wr_en[pt.ICACHE_NUM_WAYS-1:0]);
   assign dc_cacheline_wrap_ff                                   = dc_rw_addr_ff[pt.ICACHE_TAG_INDEX_LO-1:pt.ICACHE_BANK_LO] == {(pt.ICACHE_TAG_INDEX_LO - pt.ICACHE_BANK_LO){1'b1}};


   assign dc_rw_addr_bank_q[0] = ~dc_rw_addr_wrap ? dc_rw_addr_q[pt.ICACHE_INDEX_HI:pt.ICACHE_DATA_INDEX_LO] : {dc_rw_addr_q[pt.ICACHE_INDEX_HI: pt.ICACHE_TAG_INDEX_LO] , dc_rw_addr_q_inc[pt.ICACHE_TAG_INDEX_LO-1: pt.ICACHE_DATA_INDEX_LO] } ;
   assign dc_rw_addr_bank_q[1] = dc_rw_addr_q[pt.ICACHE_INDEX_HI:pt.ICACHE_DATA_INDEX_LO];


   rvdff #((pt.ICACHE_BANKS_WAY )) rd_b_en_ff (.*,
                                               .clk(active_clk),
                                               .din ({dc_b_rden[pt.ICACHE_BANKS_WAY-1:0]}),
                                               .dout({dc_b_rden_ff[pt.ICACHE_BANKS_WAY-1:0]})
                                               ) ;



   rvdff #((pt.ICACHE_TAG_INDEX_LO - 1)) adr_ff (.*,
                                                 .clk(active_clk),
                                                 .din ({dc_rw_addr_q[pt.ICACHE_TAG_INDEX_LO-1:1]}),
                                                 .dout({dc_rw_addr_ff[pt.ICACHE_TAG_INDEX_LO-1:1]})
);

   rvdff #(1+pt.ICACHE_NUM_WAYS) debug_rd_wy_ff (.*,
                                                 .clk(active_clk),
                                                 .din ({dc_debug_rd_way_en[pt.ICACHE_NUM_WAYS-1:0], dc_debug_rd_en}),
                                                 .dout({dc_debug_rd_way_en_ff[pt.ICACHE_NUM_WAYS-1:0], dc_debug_rd_en_ff})
                                                 );

 if (pt.ICACHE_WAYPACK == 0 ) begin : PACKED_0



    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS_WIDTH-1:0] wrptr_up;
    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS_WIDTH-1:0] wrptr_in_up;
    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]       sel_bypass_up;
    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]       sel_bypass_ff_up;
    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0][(71*pt.ICACHE_NUM_WAYS)-1:0]    sel_bypass_data_up;
    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                                 any_bypass_up;
    logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0]                                 any_addr_match_up;

`define EH2_DC_DATA_SRAM(depth,width)                                                                               \
           ram_``depth``x``width dc_bank_sb_way_data (                                                               \
                                     .ME(dc_bank_way_clken_final_up[i][k]),                                          \
                                     .WE (dc_b_sb_wren[k][i]),                                                       \
                                     .D  (dc_sb_wr_data[k][``width-1:0]),                                            \
                                     .ADR(dc_rw_addr_bank_q[k][pt.ICACHE_INDEX_HI:pt.ICACHE_DATA_INDEX_LO]),         \
                                     .Q  (wb_dout_pre_up[i][k]),                                                     \
                                     .CLK (clk),                                                                     \
                                     .ROP ( ),                                                                       \
                                     .TEST1(dc_data_ext_in_pkt[i][k].TEST1),                                         \
                                     .RME(dc_data_ext_in_pkt[i][k].RME),                                             \
                                     .RM(dc_data_ext_in_pkt[i][k].RM),                                               \
                                                                                                                     \
                                     .LS(dc_data_ext_in_pkt[i][k].LS),                                               \
                                     .DS(dc_data_ext_in_pkt[i][k].DS),                                               \
                                     .SD(dc_data_ext_in_pkt[i][k].SD),                                               \
                                                                                                                     \
                                     .TEST_RNM(dc_data_ext_in_pkt[i][k].TEST_RNM),                                   \
                                     .BC1(dc_data_ext_in_pkt[i][k].BC1),                                             \
                                     .BC2(dc_data_ext_in_pkt[i][k].BC2)                                              \
                                    );  \
if (pt.ICACHE_BYPASS_ENABLE == 1) begin \
                 assign wrptr_in_up[i][k] = (wrptr_up[i][k] == (pt.ICACHE_NUM_BYPASS-1)) ? '0 : (wrptr_up[i][k] + 1'd1);                                    \
                 rvdffs  #(pt.ICACHE_NUM_BYPASS_WIDTH)  wrptr_ff(.*, .clk(active_clk),  .en(|write_bypass_en_up[i][k]), .din (wrptr_in_up[i][k]), .dout(wrptr_up[i][k])) ;     \
                 assign dc_b_sram_en_up[i][k]              = dc_bank_way_clken[k][i];                             \
                 assign dc_b_read_en_up[i][k]              =  dc_b_sram_en_up[i][k]  &  dc_b_sb_rden[k][i];       \
                 assign dc_b_write_en_up[i][k]             =  dc_b_sram_en_up[i][k] &   dc_b_sb_wren[k][i];       \
                 assign dc_bank_way_clken_final_up[i][k]   =  dc_b_sram_en_up[i][k] &    ~(|sel_bypass_up[i][k]); \
                 assign dc_b_rw_addr_up[i][k] = {dc_rw_addr[31:pt.ICACHE_INDEX_HI+1],dc_rw_addr_bank_q[k]};       \
                 assign dc_b_rw_addr_index_only_up[i][k] = {dc_rw_addr_bank_q[k]};                                \
                 always_comb begin                                                                                \
                    any_addr_match_up[i][k] = '0;                                                                 \
                    for (int l=0; l<pt.ICACHE_NUM_BYPASS; l++) begin                                              \
                       any_addr_match_up[i][k] |= dc_b_addr_match_up[i][k][l];                                    \
                    end                                                                                           \
                 end                                                                                              \
                // it is an error to ever have 2 entries with the same index and both valid                       \
                for (genvar l=0; l<pt.ICACHE_NUM_BYPASS; l++) begin: BYPASS                                       \
                   // full match up to bit 31                                                                     \
                   assign dc_b_addr_match_up[i][k][l] = (wb_index_hold_up[i][k][l] ==  dc_b_rw_addr_up[i][k]) & index_valid_up[i][k][l];            \
                   assign dc_b_addr_match_index_only_up[i][k][l] = (wb_index_hold_up[i][k][l][pt.ICACHE_INDEX_HI:pt.ICACHE_DATA_INDEX_LO] ==  dc_b_rw_addr_index_only_up[i][k]) & index_valid_up[i][k][l];            \
                                                                                                                                                    \
                   assign dc_b_clear_en_up[i][k][l]   = dc_b_write_en_up[i][k] &   dc_b_addr_match_index_only_up[i][k][l];                                     \
                                                                                                                                                    \
                   assign sel_bypass_up[i][k][l]      = dc_b_read_en_up[i][k]  &   dc_b_addr_match_up[i][k][l] ;                                    \
                                                                                                                                                    \
                   assign write_bypass_en_up[i][k][l] = dc_b_read_en_up[i][k]  &  ~any_addr_match_up[i][k] & (wrptr_up[i][k] == l);                 \
                                                                                                                                                    \
                   rvdff  #(1)  write_bypass_ff (.*, .clk(active_clk),                                                                 .din(write_bypass_en_up[i][k][l]), .dout(write_bypass_en_ff_up[i][k][l])) ; \
                   rvdffs #(1)  index_val_ff    (.*, .clk(active_clk), .en(write_bypass_en_up[i][k][l] | dc_b_clear_en_up[i][k][l]),   .din(~dc_b_clear_en_up[i][k][l]),  .dout(index_valid_up[i][k][l])) ;       \
                   rvdff  #(1)  sel_hold_ff     (.*, .clk(active_clk),                                                                 .din(sel_bypass_up[i][k][l]),      .dout(sel_bypass_ff_up[i][k][l])) ;     \
                   rvdffe #((31-pt.ICACHE_DATA_INDEX_LO+1)) dc_addr_index    (.*, .en(write_bypass_en_up[i][k][l]),    .din (dc_b_rw_addr_up[i][k]), .dout(wb_index_hold_up[i][k][l]));         \
                   rvdffe #(``width)                             rd_data_hold_ff  (.*, .en(write_bypass_en_ff_up[i][k][l]), .din (wb_dout_pre_up[i][k][``width-1:0]),  .dout(wb_dout_hold_up[i][k][l]));     \
                end                                                                                                                       \
                always_comb begin                                                                                                         \
                 any_bypass_up[i][k] = '0;                                                                                                \
                 sel_bypass_data_up[i][k] = '0;                                                                                           \
                 for (int l=0; l<pt.ICACHE_NUM_BYPASS; l++) begin                                                                         \
                    any_bypass_up[i][k]      |=  sel_bypass_ff_up[i][k][l];                                                               \
                    sel_bypass_data_up[i][k] |= (sel_bypass_ff_up[i][k][l]) ? wb_dout_hold_up[i][k][l] : '0;                              \
                 end                                                                                                                      \
                 wb_dout[i][k]   =   any_bypass_up[i][k] ?  sel_bypass_data_up[i][k] :  wb_dout_pre_up[i][k] ;                            \
                 end                                                                                                                      \
             end                                                                                                                          \
             else begin                                                                                                                   \
                 assign wb_dout[i][k]                      =   wb_dout_pre_up[i][k] ;                                                     \
                 assign dc_bank_way_clken_final_up[i][k]   =  dc_bank_way_clken[k][i];                                                      \
             end





   for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: WAYS
      for (genvar k=0; k<pt.ICACHE_BANKS_WAY; k++) begin: BANKS_WAY   // 16B subbank
      if (pt.ICACHE_ECC) begin : ECC1
        logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] [71-1:0]        wb_dout_pre_up;           // data and its bit enables
        logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] [pt.ICACHE_NUM_BYPASS-1:0] [71-1:0]  wb_dout_hold_up;

        if ($clog2(pt.ICACHE_DATA_DEPTH) == 13 )   begin : size_8192
           `EH2_DC_DATA_SRAM(8192,71)
        end
        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 12 )   begin : size_4096
           `EH2_DC_DATA_SRAM(4096,71)
        end
        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 11 ) begin : size_2048
           `EH2_DC_DATA_SRAM(2048,71)
        end
        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 10 ) begin : size_1024
           `EH2_DC_DATA_SRAM(1024,71)
        end
        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 9 ) begin : size_512
           `EH2_DC_DATA_SRAM(512,71)
        end
         else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 8 ) begin : size_256
           `EH2_DC_DATA_SRAM(256,71)
         end
         else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 7 ) begin : size_128
           `EH2_DC_DATA_SRAM(128,71)
         end
         else  begin : size_64
           `EH2_DC_DATA_SRAM(64,71)
         end
      end // if (pt.ICACHE_ECC)

     else  begin  : ECC0
        logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] [68-1:0]        wb_dout_pre_up;           // data and its bit enables
        logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_BANKS_WAY-1:0] [pt.ICACHE_NUM_BYPASS-1:0] [68-1:0]  wb_dout_hold_up;
        if ($clog2(pt.ICACHE_DATA_DEPTH) == 13 )   begin : size_8192
           `EH2_DC_DATA_SRAM(8192,68)
        end
        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 12 )   begin : size_4096
           `EH2_DC_DATA_SRAM(4096,68)
        end
        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 11 ) begin : size_2048
           `EH2_DC_DATA_SRAM(2048,68)
        end
        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 10 ) begin : size_1024
           `EH2_DC_DATA_SRAM(1024,68)
        end
        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 9 ) begin : size_512
           `EH2_DC_DATA_SRAM(512,68)
        end
         else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 8 ) begin : size_256
           `EH2_DC_DATA_SRAM(256,68)
         end
         else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 7 ) begin : size_128
           `EH2_DC_DATA_SRAM(128,68)
         end
         else  begin : size_64
           `EH2_DC_DATA_SRAM(64,68)
         end
      end // else: !if(pt.ICACHE_ECC)
      end // block: BANKS_WAY
   end // block: WAYS

 end // block: PACKED_0

 // WAY PACKED
 else begin : PACKED_1

    logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS_WIDTH-1:0] wrptr;
    logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS_WIDTH-1:0] wrptr_in;
    logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                       sel_bypass;
    logic [pt.ICACHE_BANKS_WAY-1:0][pt.ICACHE_NUM_BYPASS-1:0]                       sel_bypass_ff;


    logic [pt.ICACHE_BANKS_WAY-1:0][(71*pt.ICACHE_NUM_WAYS)-1:0]  sel_bypass_data;
    logic [pt.ICACHE_BANKS_WAY-1:0]                               any_bypass;
    logic [pt.ICACHE_BANKS_WAY-1:0]                               any_addr_match;


// SRAM macros

`define EH2_PACKED_DC_DATA_SRAM(depth,width,waywidth)                                                                                                 \
            ram_be_``depth``x``width  dc_bank_sb_way_data (                                                                                           \
                            .CLK   (clk),                                                                                                             \
                            .WE    (|dc_b_sb_wren[k]),                                                    // OR of all the ways in the bank           \
                            .WEM   (dc_b_sb_bit_en_vec[k]),                                               // 284 bits of bit enables                  \
                            .D     ({pt.ICACHE_NUM_WAYS{dc_sb_wr_data[k][``waywidth-1:0]}}),                                                          \
                            .ADR   (dc_rw_addr_bank_q[k][pt.ICACHE_INDEX_HI:pt.ICACHE_DATA_INDEX_LO]),                                                \
                            .Q     (wb_packeddout_pre[k]),                                                                                            \
                            .ME    (|dc_bank_way_clken_final[k]),                                                                                     \
                            .ROP   ( ),                                                                                                               \
                            .TEST1  (dc_data_ext_in_pkt[0][k].TEST1),                                                                                 \
                            .RME   (dc_data_ext_in_pkt[0][k].RME),                                                                                    \
                            .RM    (dc_data_ext_in_pkt[0][k].RM),                                                                                     \
                                                                                                                                                      \
                            .LS    (dc_data_ext_in_pkt[0][k].LS),                                                                                     \
                            .DS    (dc_data_ext_in_pkt[0][k].DS),                                                                                     \
                            .SD    (dc_data_ext_in_pkt[0][k].SD),                                                                                     \
                                                                                                                                                      \
                            .TEST_RNM (dc_data_ext_in_pkt[0][k].TEST_RNM),                                                                            \
                            .BC1      (dc_data_ext_in_pkt[0][k].BC1),                                                                                 \
                            .BC2      (dc_data_ext_in_pkt[0][k].BC2)                                                                                  \
                           );                                                                                                                         \
                                                                                                                                                      \
              if (pt.ICACHE_BYPASS_ENABLE == 1) begin                                                                                                                                                 \
                                                                                                                                                                                                      \
                 assign wrptr_in[k] = (wrptr[k] == (pt.ICACHE_NUM_BYPASS-1)) ? '0 : (wrptr[k] + 1'd1);                                                                                                \
                                                                                                                                                                                                      \
                 rvdffs  #(pt.ICACHE_NUM_BYPASS_WIDTH)  wrptr_ff(.*, .clk(active_clk), .en(|write_bypass_en[k]), .din (wrptr_in[k]), .dout(wrptr[k])) ;                                               \
                                                                                                                                                                                                      \
                 assign dc_b_sram_en[k]              = |dc_bank_way_clken[k];                                                                                                                         \
                                                                                                                                                                                                      \
                                                                                                                                                                                                      \
                 assign dc_b_read_en[k]              =  dc_b_sram_en[k] &   (|dc_b_sb_rden[k]);                                                                                                       \
                 assign dc_b_write_en[k]             =  dc_b_sram_en[k] &   (|dc_b_sb_wren[k]);                                                                                                       \
                 assign dc_bank_way_clken_final[k]   =  dc_b_sram_en[k] &    ~(|sel_bypass[k]);                                                                                                       \
                                                                                                                                                                                                      \
                 assign dc_b_rw_addr[k] = {dc_rw_addr[31:pt.ICACHE_INDEX_HI+1],dc_rw_addr_bank_q[k]};                                                                                                 \
                 assign dc_b_rw_addr_index_only[k] = {dc_rw_addr_bank_q[k]};                                                                                                  \
                                                                                                                                                                                                      \
                 always_comb begin                                                                                                                                                                    \
                    any_addr_match[k] = '0;                                                                                                                                                           \
                                                                                                                                                                                                      \
                    for (int l=0; l<pt.ICACHE_NUM_BYPASS; l++) begin                                                                                                                                  \
                       any_addr_match[k] |= dc_b_addr_match[k][l];                                                                                                                                    \
                    end                                                                                                                                                                               \
                 end                                                                                                                                                                                  \
                                                                                                                                                                                                      \
                // it is an error to ever have 2 entries with the same index and both valid                                                                                                           \
                for (genvar l=0; l<pt.ICACHE_NUM_BYPASS; l++) begin: BYPASS                                                                                                                           \
                                                                                                                                                                                                      \
                   // full match up to bit 31                                                                                                                                                         \
                   assign dc_b_addr_match[k][l] = (wb_index_hold[k][l] ==  dc_b_rw_addr[k]) & index_valid[k][l];                                                                                      \
                   assign dc_b_addr_match_index_only[k][l] = (wb_index_hold[k][l][pt.ICACHE_INDEX_HI:pt.ICACHE_DATA_INDEX_LO] ==  dc_b_rw_addr_index_only[k]) & index_valid[k][l];                                                                                    \
                                                                                                                                                                                                      \
                   assign dc_b_clear_en[k][l]   = dc_b_write_en[k] &   dc_b_addr_match_index_only[k][l];                                                                                              \
                                                                                                                                                                                                      \
                   assign sel_bypass[k][l]      = dc_b_read_en[k]  &   dc_b_addr_match[k][l] ;                                                                                                        \
                                                                                                                                                                                                      \
                   assign write_bypass_en[k][l] = dc_b_read_en[k]  &  ~any_addr_match[k] & (wrptr[k] == l);                                                                                           \
                                                                                                                                                                                                      \
                   rvdff  #(1)  write_bypass_ff (.*, .clk(active_clk),                                                     .din(write_bypass_en[k][l]), .dout(write_bypass_en_ff[k][l])) ;            \
                   rvdffs #(1)  index_val_ff    (.*, .clk(active_clk), .en(write_bypass_en[k][l] | dc_b_clear_en[k][l]),   .din(~dc_b_clear_en[k][l]),  .dout(index_valid[k][l])) ;                   \
                   rvdff  #(1)  sel_hold_ff     (.*, .clk(active_clk),                                                     .din(sel_bypass[k][l]),      .dout(sel_bypass_ff[k][l])) ;                 \
                                                                                                                                                                                                      \
                   rvdffe #((31-pt.ICACHE_DATA_INDEX_LO+1)) dc_addr_index    (.*, .en(write_bypass_en[k][l]),    .din (dc_b_rw_addr[k]),      .dout(wb_index_hold[k][l]));                            \
                   rvdffe #((``waywidth*pt.ICACHE_NUM_WAYS))        rd_data_hold_ff  (.*, .en(write_bypass_en_ff[k][l]), .din (wb_packeddout_pre[k]), .dout(wb_packeddout_hold[k][l]));               \
                                                                                                                                                                                                      \
                end // block: BYPASS                                                                                                                                                                  \
                                                                                                                                                                                                      \
                always_comb begin                                                                                                                                                                     \
                 any_bypass[k] = '0;                                                                                                                                                                  \
                 sel_bypass_data[k] = '0;                                                                                                                                                             \
                                                                                                                                                                                                      \
                 for (int l=0; l<pt.ICACHE_NUM_BYPASS; l++) begin                                                                                                                                     \
                    any_bypass[k]      |=  sel_bypass_ff[k][l];                                                                                                                                       \
                      sel_bypass_data[k] |= (sel_bypass_ff[k][l]) ? wb_packeddout_hold[k][l] : '0;                                                                                                    \
                 end                                                                                                                                                                                  \
                                                                                                                                                                                                      \
                   wb_packeddout[k]   =   any_bypass[k] ?  sel_bypass_data[k] :  wb_packeddout_pre[k] ;                                                                                               \
                end // always_comb begin                                                                                                                                                              \
                                                                                                                                                                                                      \
             end // if (pt.ICACHE_BYPASS_ENABLE == 1)                                                                                                                                                 \
             else begin                                                                                                                                                                               \
                 assign wb_packeddout[k]   =   wb_packeddout_pre[k] ;                                                                                                                                 \
                 assign dc_bank_way_clken_final[k]   =  |dc_bank_way_clken[k];                                                                                                                        \
             end

 // generate IC DATA PACKED SRAMS for 2/4 ways
  for (genvar k=0; k<pt.ICACHE_BANKS_WAY; k++) begin: BANKS_WAY   // 16B subbank
     if (pt.ICACHE_ECC) begin : ECC1
        logic [pt.ICACHE_BANKS_WAY-1:0] [(71*pt.ICACHE_NUM_WAYS)-1:0]        wb_packeddout, dc_b_sb_bit_en_vec, wb_packeddout_pre;           // data and its bit enables

        logic [pt.ICACHE_BANKS_WAY-1:0] [pt.ICACHE_NUM_BYPASS-1:0] [(71*pt.ICACHE_NUM_WAYS)-1:0]  wb_packeddout_hold;

        for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: BITEN
           assign dc_b_sb_bit_en_vec[k][(71*i)+70:71*i] = {71{dc_b_sb_wren[k][i]}};
        end

        // SRAMS with ECC (single/double detect; no correct)
        if ($clog2(pt.ICACHE_DATA_DEPTH) == 13 )   begin : size_8192
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(8192,284,71)    // 64b data + 7b ecc
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(8192,142,71)
           end // block: WAYS
        end // block: size_8192

        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 12 )   begin : size_4096
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(4096,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(4096,142,71)
           end // block: WAYS
        end // block: size_4096

        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 11 ) begin : size_2048
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(2048,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(2048,142,71)
           end // block: WAYS
        end // block: size_2048

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 10 ) begin : size_1024
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(1024,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(1024,142,71)
           end // block: WAYS
        end // block: size_1024

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 9 ) begin : size_512
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(512,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(512,142,71)
           end // block: WAYS
        end // block: size_512

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 8 ) begin : size_256
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(256,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(256,142,71)
           end // block: WAYS
        end // block: size_256

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 7 ) begin : size_128
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(128,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(128,142,71)
           end // block: WAYS
        end // block: size_128

        else  begin : size_64
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(64,284,71)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(64,142,71)
           end // block: WAYS
        end // block: size_64


       for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: WAYS
          assign wb_dout[i][k][70:0]  = wb_packeddout[k][(71*i)+70:71*i];
       end : WAYS

       end // if (pt.ICACHE_ECC)


     else  begin  : ECC0
        logic [pt.ICACHE_BANKS_WAY-1:0] [(68*pt.ICACHE_NUM_WAYS)-1:0]        wb_packeddout, dc_b_sb_bit_en_vec, wb_packeddout_pre;           // data and its bit enables

        logic [pt.ICACHE_BANKS_WAY-1:0] [pt.ICACHE_NUM_BYPASS-1:0] [(68*pt.ICACHE_NUM_WAYS)-1:0]  wb_packeddout_hold;

        for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: BITEN
           assign dc_b_sb_bit_en_vec[k][(68*i)+67:68*i] = {68{dc_b_sb_wren[k][i]}};
        end

        // SRAMs with parity
        if ($clog2(pt.ICACHE_DATA_DEPTH) == 13 )   begin : size_8192
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(8192,272,68)    // 64b data + 4b parity
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(8192,136,68)
           end // block: WAYS
        end // block: size_8192

        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 12 )   begin : size_4096
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(4096,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(4096,136,68)
           end // block: WAYS
        end // block: size_4096

        else if ($clog2(pt.ICACHE_DATA_DEPTH) == 11 ) begin : size_2048
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(2048,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(2048,136,68)
           end // block: WAYS
        end // block: size_2048

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 10 ) begin : size_1024
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(1024,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(1024,136,68)
           end // block: WAYS
        end // block: size_1024

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 9 ) begin : size_512
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(512,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(512,136,68)
           end // block: WAYS
        end // block: size_512

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 8 ) begin : size_256
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(256,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(256,136,68)
           end // block: WAYS
        end // block: size_256

        else if ( $clog2(pt.ICACHE_DATA_DEPTH) == 7 ) begin : size_128
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(128,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(128,136,68)
           end // block: WAYS
        end // block: size_128

        else  begin : size_64
           if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(64,272,68)
           end // block: WAYS
           else   begin : WAYS
              `EH2_PACKED_DC_DATA_SRAM(64,136,68)
           end // block: WAYS
        end // block: size_64

       for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: WAYS
          assign wb_dout[i][k][67:0]  = wb_packeddout[k][(68*i)+67:68*i];
       end
     end // block: ECC0
     end // block: BANKS_WAY
 end // block: PACKED_1







   assign dc_rd_hit_q[pt.ICACHE_NUM_WAYS-1:0] = dc_debug_rd_en_ff ? dc_debug_rd_way_en_ff[pt.ICACHE_NUM_WAYS-1:0] : dc_rd_hit[pt.ICACHE_NUM_WAYS-1:0] ;


 if ( pt.ICACHE_ECC == 1) begin : ECC1_MUX
   assign dc_bank_wr_data[1][70:0] = dc_wr_data[1][70:0];
   assign dc_bank_wr_data[0][70:0] = dc_wr_data[0][70:0];

    always_comb begin : rd_mux
      wb_dout_way_pre[pt.ICACHE_NUM_WAYS-1:0] = '0;

      for ( int i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : num_ways
        for ( int j=0; j<pt.ICACHE_BANKS_WAY; j++) begin : banks
         wb_dout_way_pre[i][70:0]      |=  ({71{(dc_rw_addr_ff[pt.ICACHE_BANK_HI : pt.ICACHE_BANK_LO] == (pt.ICACHE_BANK_BITS)'(j))}}   &  wb_dout[i][j]);
         wb_dout_way_pre[i][141 : 71]  |=  ({71{(dc_rw_addr_ff[pt.ICACHE_BANK_HI : pt.ICACHE_BANK_LO] == (pt.ICACHE_BANK_BITS)'(j-1))}} &  wb_dout[i][j]);
        end
      end
    end

    for ( genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : num_ways_mux1
      assign wb_dout_way[i][63:0] = (dc_rw_addr_ff[2:1] == 2'b00) ? wb_dout_way_pre[i][63:0]   :
                                    (dc_rw_addr_ff[2:1] == 2'b01) ?{wb_dout_way_pre[i][86:71], wb_dout_way_pre[i][63:16]} :
                                    (dc_rw_addr_ff[2:1] == 2'b10) ?{wb_dout_way_pre[i][102:71],wb_dout_way_pre[i][63:32]} :
                                                                   {wb_dout_way_pre[i][119:71],wb_dout_way_pre[i][63:48]};

      assign wb_dout_way_with_premux[i][63:0]  =  dc_sel_premux_data ? dc_premux_data[63:0] : wb_dout_way[i][63:0] ;
   end

   always_comb begin : rd_out
      dc_debug_rd_data[70:0]     = '0;
      dc_rd_data[63:0]           = '0;
      wb_dout_ecc[141:0]         = '0;
      for ( int i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : num_ways_mux2
         dc_rd_data[63:0]       |= ({64{dc_rd_hit_q[i] | dc_sel_premux_data}}) &  wb_dout_way_with_premux[i][63:0];
         dc_debug_rd_data[70:0] |= ({71{dc_rd_hit_q[i] & dc_debug_rd_en_ff }}) &  wb_dout_way_pre[i][70:0];
         wb_dout_ecc[141:0]     |= {142{dc_rd_hit_q[i]}}  & wb_dout_way_pre[i];
      end
   end


 for (genvar i=0; i < pt.ICACHE_BANKS_WAY ; i++) begin : dc_ecc_error
    assign bank_check_en[i]    = |dc_rd_hit[pt.ICACHE_NUM_WAYS-1:0] & ((i==0) | (~dc_cacheline_wrap_ff & (dc_b_rden_ff[pt.ICACHE_BANKS_WAY-1:0] == {pt.ICACHE_BANKS_WAY{1'b1}})));  // always check the lower address bank, and drop the upper a
    assign wb_dout_ecc_bank[i] = wb_dout_ecc[(71*i)+70:(71*i)];

   rvdff #(1) encod_en_ff (.*,
                           .clk(active_clk),
                           .din (bank_check_en[i]),
                           .dout(bank_check_en_ff[i])
                           );

   rvdffe #(71) bank_data_ff (.*,
                             .en  (bank_check_en[i]),
                             .din (wb_dout_ecc_bank[i][70:0]),
                             .dout(wb_dout_ecc_bank_ff[i][70:0])
                             );

   rvecc_decode_64  ecc_decode_64 (
                                   .en               (bank_check_en_ff[i]),
                                   .din              ((bank_check_en_ff[i])?wb_dout_ecc_bank_ff[i][63:0]:64'd0),                  // [134:71],  [63:0]
                                   .ecc_in           ((bank_check_en_ff[i])?wb_dout_ecc_bank_ff[i][70:64]:7'd0),               // [141:135] [70:64]
                                   .ecc_error        (dc_eccerr[i])
                                   );

   // or the sb and db error detects into 1 signal called aligndataperr[i] where i corresponds to 2B position
  end // block: dc_ecc_error

  assign  dc_parerr[pt.ICACHE_BANKS_WAY-1:0]  = '0 ;
end // if ( pt.ICACHE_ECC )

else  begin : ECC0_MUX
   assign dc_bank_wr_data[1][70:0] = dc_wr_data[1][70:0];
   assign dc_bank_wr_data[0][70:0] = dc_wr_data[0][70:0];

   always_comb begin : rd_mux
      wb_dout_way_pre[pt.ICACHE_NUM_WAYS-1:0] = '0;

   for ( int i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : num_ways
     for ( int j=0; j<pt.ICACHE_BANKS_WAY; j++) begin : banks
         wb_dout_way_pre[i][67:0]         |=  ({68{(dc_rw_addr_ff[pt.ICACHE_BANK_HI : pt.ICACHE_BANK_LO] == (pt.ICACHE_BANK_BITS)'(j))}}   &  wb_dout[i][j][67:0]);
         wb_dout_way_pre[i][135 : 68]     |=  ({68{(dc_rw_addr_ff[pt.ICACHE_BANK_HI : pt.ICACHE_BANK_LO] == (pt.ICACHE_BANK_BITS)'(j-1))}} &  wb_dout[i][j][67:0]);
      end
     end
   end
   for ( genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : num_ways_mux1
      assign wb_dout_way[i][63:0] = (dc_rw_addr_ff[2:1] == 2'b00) ? wb_dout_way_pre[i][63:0]   :
                                    (dc_rw_addr_ff[2:1] == 2'b01) ?{wb_dout_way_pre[i][83:68],  wb_dout_way_pre[i][63:16]} :
                                    (dc_rw_addr_ff[2:1] == 2'b10) ?{wb_dout_way_pre[i][99:68],  wb_dout_way_pre[i][63:32]} :
                                                                   {wb_dout_way_pre[i][115:68], wb_dout_way_pre[i][63:48]};

      assign wb_dout_way_with_premux[i][63:0]      =  dc_sel_premux_data ? dc_premux_data[63:0]  : wb_dout_way[i][63:0] ;
   end

   always_comb begin : rd_out
      dc_rd_data[63:0]   = '0;
      dc_debug_rd_data[70:0]   = '0;
      wb_dout_ecc[135:0] = '0;

      for ( int i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : num_ways_mux2
         dc_rd_data[63:0]   |= ({64{dc_rd_hit_q[i] | dc_sel_premux_data}} &  wb_dout_way_with_premux[i][63:0]);
         dc_debug_rd_data[70:0] |= ({71{dc_rd_hit_q[i]}}) & {3'b0,wb_dout_way_pre[i][67:0]};
         wb_dout_ecc[135:0] |= {136{dc_rd_hit_q[i]}}  & wb_dout_way_pre[i][135:0];
      end
   end

   assign wb_dout_ecc_bank[0] =  wb_dout_ecc[67:0];
   assign wb_dout_ecc_bank[1] =  wb_dout_ecc[135:68];

   logic [pt.ICACHE_BANKS_WAY-1:0][3:0] dc_parerr_bank;

  for (genvar i=0; i < pt.ICACHE_BANKS_WAY ; i++) begin : dc_par_error
      assign bank_check_en[i]    = |dc_rd_hit[pt.ICACHE_NUM_WAYS-1:0] & ((i==0) | (~dc_cacheline_wrap_ff & (dc_b_rden_ff[pt.ICACHE_BANKS_WAY-1:0] == {pt.ICACHE_BANKS_WAY{1'b1}})));  // always check the lower address bank, and drop the upper a

      rvdff #(1) encod_en_ff (.*,
                              .clk(active_clk),
                              .din (bank_check_en[i]),
                              .dout(bank_check_en_ff[i])
                              );

      rvdffe #(68) bank_data_ff (.*,
                                .en  (bank_check_en[i]),
                                .din (wb_dout_ecc_bank[i][67:0]),
                                .dout(wb_dout_ecc_bank_ff[i][67:0])
                                );

     for (genvar j=0; j<4; j++)  begin : parity
      rveven_paritycheck pchk (
                           .data_in   (wb_dout_ecc_bank_ff[i][16*(j+1)-1: 16*j]),
                           .parity_in (wb_dout_ecc_bank_ff[i][64+j]),
                           .parity_err(dc_parerr_bank[i][j])
                           );
        end
  end

     assign dc_parerr[1] = |dc_parerr_bank[1][3:0] & bank_check_en_ff[1];
     assign dc_parerr[0] = |dc_parerr_bank[0][3:0] & bank_check_en_ff[0];
     assign dc_eccerr [pt.ICACHE_BANKS_WAY-1:0] = '0 ;

end // else: !if( pt.ICACHE_ECC )


endmodule // EH2_DC_DATA

//=============================================================================================================================================================
///\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ END OF IC DATA MODULE \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//=============================================================================================================================================================

/////////////////////////////////////////////////
////// DCACHE TAG MODULE     ////////////////////
/////////////////////////////////////////////////
module EH2_DC_TAG
import eh2_pkg::*;
#(
`include "eh2_param.vh"
 )
     (
      input logic                                               clk,
      input logic                                               active_clk,
      input logic                                               rst_l,
      input logic                                               clk_override,
      input logic                                               dec_tlu_core_ecc_disable,


      input logic [31:3]                                        dc_rw_addr,


      input logic [pt.ICACHE_NUM_WAYS-1:0]                     dc_wr_en,  // way
      input logic [pt.ICACHE_NUM_WAYS-1:0]                     dc_tag_valid,
      input logic                                              dc_rd_en,

      input logic [pt.ICACHE_INDEX_HI:3]                       dc_debug_addr,      // Read/Write addresss to the Icache.
      input logic                                              dc_debug_rd_en,     // Icache debug rd
      input logic                                              dc_debug_wr_en,     // Icache debug wr
      input logic                                              dc_debug_tag_array, // Debug tag array
      input logic [pt.ICACHE_NUM_WAYS-1:0]                     dc_debug_way,       // Debug way. Rd or Wr.
      input eh2_ic_tag_ext_in_pkt_t   [pt.ICACHE_NUM_WAYS-1:0]dc_tag_ext_in_pkt,

      output logic [25:0]                                       dctag_debug_rd_data,
      input  logic [70:0]                                       dc_debug_wr_data,   // Debug wr cache.

      output logic [pt.ICACHE_NUM_WAYS-1:0]                    dc_rd_hit,
      output logic                                              dc_tag_perr,
      input  logic                                              scan_mode
   ) ;


   logic [pt.ICACHE_NUM_WAYS-1:0] [25:0]                           dc_tag_data_raw;
   logic [pt.ICACHE_NUM_WAYS-1:0] [25:0]                           dc_tag_data_raw_ff;
   logic [pt.ICACHE_NUM_WAYS-1:0] [25:0]                           dc_tag_data_raw_pre;


   logic [pt.ICACHE_NUM_WAYS-1:0] [32:pt.ICACHE_TAG_LO]            w_tout;
   logic [pt.ICACHE_NUM_WAYS-1:0] [32:pt.ICACHE_TAG_LO]            w_tout_ff;

   logic [25:0]                                 dc_tag_wr_data ;
   logic [pt.ICACHE_NUM_WAYS-1:0] [31:0]                           dc_tag_corrected_data_unc;
   logic [pt.ICACHE_NUM_WAYS-1:0] [06:0]                           dc_tag_corrected_ecc_unc;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_single_ecc_error;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_double_ecc_error;
   logic [6:0]                                  dc_tag_ecc;

   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_way_perr ;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_debug_rd_way_en ;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_debug_rd_way_en_ff ;

   logic [pt.ICACHE_INDEX_HI: pt.ICACHE_TAG_INDEX_LO] dc_rw_addr_q;
   logic [31:pt.ICACHE_DATA_INDEX_LO]              dc_rw_addr_ff;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_wren;          // way
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_wren_q;        // way
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_rden_q;        // way
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_clken;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_debug_wr_way_en;   // debug wr_way
   logic [pt.ICACHE_NUM_WAYS-1:0]                                  dc_tag_valid_ff;
   logic                                                           dc_rd_en_ff;
   logic                                                           dc_rd_en_ff2;
   logic                                                           dc_wr_en_ff;     // OR of the wr_en

   logic                                                           dc_tag_parity;

   logic                                                           ecc_decode_enable;

   assign ecc_decode_enable = ~dec_tlu_core_ecc_disable & dc_rd_en_ff2;


   assign  dc_tag_wren [pt.ICACHE_NUM_WAYS-1:0]  = dc_wr_en[pt.ICACHE_NUM_WAYS-1:0] & {pt.ICACHE_NUM_WAYS{(dc_rw_addr[pt.ICACHE_BEAT_ADDR_HI:4] == {pt.ICACHE_BEAT_BITS-1{1'b1}})}} ;
   assign  dc_tag_clken[pt.ICACHE_NUM_WAYS-1:0]  = {pt.ICACHE_NUM_WAYS{dc_rd_en | clk_override}} | dc_wr_en[pt.ICACHE_NUM_WAYS-1:0] | dc_debug_wr_way_en[pt.ICACHE_NUM_WAYS-1:0] | dc_debug_rd_way_en[pt.ICACHE_NUM_WAYS-1:0];

   rvdff #(32-pt.ICACHE_TAG_LO) adr_ff (.*,
                                        .clk(active_clk),
                                        .din ({dc_rw_addr[31:pt.ICACHE_TAG_LO]}),
                                        .dout({dc_rw_addr_ff[31:pt.ICACHE_TAG_LO]})
                                        );

   rvdff #(pt.ICACHE_NUM_WAYS) tg_val_ff (.*,
                                          .clk(active_clk),
                                          .din ((dc_tag_valid[pt.ICACHE_NUM_WAYS-1:0] & {pt.ICACHE_NUM_WAYS{~dc_wr_en_ff}})),
                                          .dout(dc_tag_valid_ff[pt.ICACHE_NUM_WAYS-1:0])
                                          );

   localparam PAD_BITS = 21 - (32 - pt.ICACHE_TAG_LO);  // sizing for a max tag width.

   // tags
   assign  dc_debug_rd_way_en[pt.ICACHE_NUM_WAYS-1:0] =  {pt.ICACHE_NUM_WAYS{dc_debug_rd_en & dc_debug_tag_array}} & dc_debug_way[pt.ICACHE_NUM_WAYS-1:0] ;
   assign  dc_debug_wr_way_en[pt.ICACHE_NUM_WAYS-1:0] =  {pt.ICACHE_NUM_WAYS{dc_debug_wr_en & dc_debug_tag_array}} & dc_debug_way[pt.ICACHE_NUM_WAYS-1:0] ;

   assign  dc_tag_wren_q[pt.ICACHE_NUM_WAYS-1:0]  =  dc_tag_wren[pt.ICACHE_NUM_WAYS-1:0] | dc_debug_wr_way_en[pt.ICACHE_NUM_WAYS-1:0]   ;
   assign  dc_tag_rden_q[pt.ICACHE_NUM_WAYS-1:0]  =  ({pt.ICACHE_NUM_WAYS{dc_rd_en }}  | dc_debug_rd_way_en[pt.ICACHE_NUM_WAYS-1:0] ) &  {pt.ICACHE_NUM_WAYS{~(|dc_wr_en)  & ~dc_debug_wr_en}};


if (pt.ICACHE_TAG_LO == 11) begin: SMALLEST
 if (pt.ICACHE_ECC) begin : ECC1_W
           rvecc_encode  tag_ecc_encode (
                                  .din    ({{pt.ICACHE_TAG_LO{1'b0}}, dc_rw_addr[31:pt.ICACHE_TAG_LO]}),
                                  .ecc_out({ dc_tag_ecc[6:0]}));

   assign  dc_tag_wr_data[25:0] = (dc_debug_wr_en & dc_debug_tag_array) ?
                                  {dc_debug_wr_data[68:64], dc_debug_wr_data[31:11]} :
                                  {dc_tag_ecc[4:0], dc_rw_addr[31:pt.ICACHE_TAG_LO]} ;
 end

 else begin : ECC0_W
           rveven_paritygen #(32-pt.ICACHE_TAG_LO) pargen  (.data_in   (dc_rw_addr[31:pt.ICACHE_TAG_LO]),
                                                 .parity_out(dc_tag_parity));

   assign  dc_tag_wr_data[21:0] = (dc_debug_wr_en & dc_debug_tag_array) ?
                                  {dc_debug_wr_data[64], dc_debug_wr_data[31:11]} :
                                  {dc_tag_parity, dc_rw_addr[31:pt.ICACHE_TAG_LO]} ;
 end // else: !if(pt.ICACHE_ECC)

end // block: SMALLEST


else begin: OTHERS
  if(pt.ICACHE_ECC) begin : ECC1_W
           rvecc_encode  tag_ecc_encode (
                                  .din    ({{pt.ICACHE_TAG_LO{1'b0}}, dc_rw_addr[31:pt.ICACHE_TAG_LO]}),
                                  .ecc_out({ dc_tag_ecc[6:0]}));

   assign  dc_tag_wr_data[25:0] = (dc_debug_wr_en & dc_debug_tag_array) ?
                                  {dc_debug_wr_data[68:64],dc_debug_wr_data[31:11]} :
                                  {dc_tag_ecc[4:0], {PAD_BITS{1'b0}},dc_rw_addr[31:pt.ICACHE_TAG_LO]} ;

  end
  else  begin : ECC0_W
   logic   dc_tag_parity ;
           rveven_paritygen #(32-pt.ICACHE_TAG_LO) pargen  (.data_in   (dc_rw_addr[31:pt.ICACHE_TAG_LO]),
                                                 .parity_out(dc_tag_parity));
   assign  dc_tag_wr_data[21:0] = (dc_debug_wr_en & dc_debug_tag_array) ?
                                  {dc_debug_wr_data[64], dc_debug_wr_data[31:11]} :
                                  {dc_tag_parity, {PAD_BITS{1'b0}},dc_rw_addr[31:pt.ICACHE_TAG_LO]} ;
  end // else: !if(pt.ICACHE_ECC)

end // block: OTHERS


    assign dc_rw_addr_q[pt.ICACHE_INDEX_HI: pt.ICACHE_TAG_INDEX_LO] = (dc_debug_rd_en | dc_debug_wr_en) ?
                                                dc_debug_addr[pt.ICACHE_INDEX_HI: pt.ICACHE_TAG_INDEX_LO] :
                                                dc_rw_addr[pt.ICACHE_INDEX_HI: pt.ICACHE_TAG_INDEX_LO] ;

   rvdff #(pt.ICACHE_NUM_WAYS) tag_rd_wy_ff (.*,
                                             .clk(active_clk),
                                             .din ({dc_debug_rd_way_en[pt.ICACHE_NUM_WAYS-1:0]}),
                                             .dout({dc_debug_rd_way_en_ff[pt.ICACHE_NUM_WAYS-1:0]})
                                             );

   rvdff #(1) rden_ff (.*,
                       .clk(active_clk),
                       .din (dc_rd_en),
                       .dout(dc_rd_en_ff)
                       );

   rvdff #(1) rden_ff2 (.*,
                        .clk(active_clk),
                        .din (dc_rd_en_ff),
                        .dout(dc_rd_en_ff2)
                        );

   rvdff #(1) dc_we_ff (.*,
                        .clk(active_clk),
                        .din (|dc_wr_en[pt.ICACHE_NUM_WAYS-1:0]),
                        .dout(dc_wr_en_ff)
                        );





if (pt.ICACHE_WAYPACK == 0 ) begin : PACKED_0

   logic [pt.ICACHE_NUM_WAYS-1:0] dc_b_sram_en;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                                                               dc_b_read_en;
   logic [pt.ICACHE_NUM_WAYS-1:0]                                                                               dc_b_write_en;
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_TAG_NUM_BYPASS-1:0] [pt.ICACHE_INDEX_HI : pt.ICACHE_TAG_INDEX_LO]   wb_index_hold;
   logic [pt.ICACHE_NUM_WAYS-1:0]                               [pt.ICACHE_INDEX_HI : pt.ICACHE_TAG_INDEX_LO]   dc_b_rw_addr;
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 write_bypass_en;     //bank
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 write_bypass_en_ff;  //bank
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 index_valid;  //bank
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 dc_b_clear_en;
   logic [pt.ICACHE_NUM_WAYS-1:0][pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 dc_b_addr_match;




    logic [pt.ICACHE_NUM_WAYS-1:0] [pt.ICACHE_TAG_NUM_BYPASS_WIDTH-1:0] wrptr;
    logic [pt.ICACHE_NUM_WAYS-1:0] [pt.ICACHE_TAG_NUM_BYPASS_WIDTH-1:0] wrptr_in;
    logic [pt.ICACHE_NUM_WAYS-1:0] [pt.ICACHE_TAG_NUM_BYPASS-1:0]       sel_bypass;
    logic [pt.ICACHE_NUM_WAYS-1:0] [pt.ICACHE_TAG_NUM_BYPASS-1:0]       sel_bypass_ff;



    logic [pt.ICACHE_NUM_WAYS-1:0][25:0]  sel_bypass_data;
    logic [pt.ICACHE_NUM_WAYS-1:0]        any_bypass;
    logic [pt.ICACHE_NUM_WAYS-1:0]        any_addr_match;
    logic [pt.ICACHE_NUM_WAYS-1:0]        dc_tag_clken_final;

      `define EH2_DC_TAG_SRAM(depth,width)                                                                                                      \
                                  ram_``depth``x``width  dc_way_tag (                                                                           \
                                .ME(dc_tag_clken_final[i]),                                                                                     \
                                .WE (dc_tag_wren_q[i]),                                                                                         \
                                .D  (dc_tag_wr_data[``width-1:0]),                                                                              \
                                .ADR(dc_rw_addr_q[pt.ICACHE_INDEX_HI:pt.ICACHE_TAG_INDEX_LO]),                                                  \
                                .Q  (dc_tag_data_raw_pre[i][``width-1:0]),                                                                      \
                                .CLK (clk),                                                                                                     \
                                .ROP ( ),                                                                                                       \
                                                                                                                                                \
                                .TEST1(dc_tag_ext_in_pkt[i].TEST1),                                                                             \
                                .RME(dc_tag_ext_in_pkt[i].RME),                                                                                 \
                                .RM(dc_tag_ext_in_pkt[i].RM),                                                                                   \
                                                                                                                                                \
                                .LS(dc_tag_ext_in_pkt[i].LS),                                                                                   \
                                .DS(dc_tag_ext_in_pkt[i].DS),                                                                                   \
                                .SD(dc_tag_ext_in_pkt[i].SD),                                                                                   \
                                                                                                                                                \
                                .TEST_RNM(dc_tag_ext_in_pkt[i].TEST_RNM),                                                                       \
                                .BC1(dc_tag_ext_in_pkt[i].BC1),                                                                                 \
                                .BC2(dc_tag_ext_in_pkt[i].BC2)                                                                                  \
                                                                                                                                                \
                               );                                                                                                               \
                                                                                                                                                \
                                                                                                                                                \
                                                                                                                                                \
                                                                                                                                                \
              if (pt.ICACHE_TAG_BYPASS_ENABLE == 1) begin                                                                                                                                             \
                                                                                                                                                                                                      \
                 assign wrptr_in[i] = (wrptr[i] == (pt.ICACHE_TAG_NUM_BYPASS-1)) ? '0 : (wrptr[i] + 1'd1);                                                                                            \
                                                                                                                                                                                                      \
                 rvdffs  #(pt.ICACHE_TAG_NUM_BYPASS_WIDTH)  wrptr_ff(.*, .clk(active_clk), .en(|write_bypass_en[i]), .din (wrptr_in[i]), .dout(wrptr[i])) ;                                           \
                                                                                                                                                                                                      \
                 assign dc_b_sram_en[i]              = dc_tag_clken[i];                                                                                                                               \
                                                                                                                                                                                                      \
                 assign dc_b_read_en[i]              =  dc_b_sram_en[i]  &  (dc_tag_rden_q[i]);                                                                                                       \
                 assign dc_b_write_en[i]             =  dc_b_sram_en[i] &   (dc_tag_wren_q[i]);                                                                                                       \
                 assign dc_tag_clken_final[i]        =  dc_b_sram_en[i] &    ~(|sel_bypass[i]);                                                                                                       \
                                                                                                                                                                                                      \
                 // LSB is pt.ICACHE_TAG_INDEX_LO]                                                                                                                                                    \
                 assign dc_b_rw_addr[i] = {dc_rw_addr_q};                                                                                                                                             \
                                                                                                                                                                                                      \
                 always_comb begin                                                                                                                                                                    \
                    any_addr_match[i] = '0;                                                                                                                                                           \
                                                                                                                                                                                                      \
                    for (int l=0; l<pt.ICACHE_TAG_NUM_BYPASS; l++) begin                                                                                                                              \
                       any_addr_match[i] |= (dc_b_addr_match[i][l] & index_valid[i][l]);                                                                                                              \
                    end                                                                                                                                                                               \
                 end                                                                                                                                                                                  \
                                                                                                                                                                                                      \
                // it is an error to ever have 2 entries with the same index and both valid                                                                                                           \
                for (genvar l=0; l<pt.ICACHE_TAG_NUM_BYPASS; l++) begin: BYPASS                                                                                                                       \
                                                                                                                                                                                                      \
                   assign dc_b_addr_match[i][l] = (wb_index_hold[i][l] ==  dc_b_rw_addr[i]) & index_valid[i][l];                                                                                      \
                                                                                                                                                                                                      \
                   assign dc_b_clear_en[i][l]   = dc_b_write_en[i] &   dc_b_addr_match[i][l];                                                                                                         \
                                                                                                                                                                                                      \
                   assign sel_bypass[i][l]      = dc_b_read_en[i]  &   dc_b_addr_match[i][l] ;                                                                                                        \
                                                                                                                                                                                                      \
                   assign write_bypass_en[i][l] = dc_b_read_en[i]  &  ~any_addr_match[i] & (wrptr[i] == l);                                                                                           \
                                                                                                                                                                                                      \
                   rvdff  #(1)  write_bypass_ff (.*, .clk(active_clk),                                                     .din(write_bypass_en[i][l]), .dout(write_bypass_en_ff[i][l])) ;            \
                   rvdffs #(1)  index_val_ff    (.*, .clk(active_clk), .en(write_bypass_en[i][l] | dc_b_clear_en[i][l]),         .din(~dc_b_clear_en[i][l]),  .dout(index_valid[i][l])) ;             \
                   rvdff  #(1)  sel_hold_ff     (.*, .clk(active_clk),                                                     .din(sel_bypass[i][l]),      .dout(sel_bypass_ff[i][l])) ;                 \
                                                                                                                                                                                                      \
                   rvdffs #((pt.ICACHE_INDEX_HI-pt.ICACHE_TAG_INDEX_LO+1))  dc_addr_index      (.*, .clk(active_clk), .en(write_bypass_en[i][l]),    .din (dc_b_rw_addr[i]),               .dout(wb_index_hold[i][l]));   \
                   rvdffe #(``width)                                          rd_data_hold_ff  (.*, .en(write_bypass_en_ff[i][l]), .din (dc_tag_data_raw_pre[i][``width-1:0]), .dout(wb_dout_hold[i][l]));            \
                                                                                                                                                                                                      \
                end // block: BYPASS                                                                                                                                                                  \
                                                                                                                                                                                                      \
                always_comb begin                                                                                                                                                                     \
                 any_bypass[i] = '0;                                                                                                                                                                  \
                 sel_bypass_data[i] = '0;                                                                                                                                                             \
                                                                                                                                                                                                      \
                 for (int l=0; l<pt.ICACHE_TAG_NUM_BYPASS; l++) begin                                                                                                                                 \
                    any_bypass[i]      |=  sel_bypass_ff[i][l];                                                                                                                                       \
                    sel_bypass_data[i] |= (sel_bypass_ff[i][l]) ? wb_dout_hold[i][l] : '0;                                                                                                            \
                 end                                                                                                                                                                                  \
                                                                                                                                                                                                      \
                   dc_tag_data_raw[i]   =   any_bypass[i] ?  sel_bypass_data[i] :  dc_tag_data_raw_pre[i] ;                                                                                           \
                end // always_comb begin                                                                                                                                                              \
                                                                                                                                                                                                      \
             end // if (pt.ICACHE_BYPASS_ENABLE == 1)                                                                                                                                                 \
             else begin                                                                                                                                                                               \
                 assign dc_tag_data_raw[i]   =   dc_tag_data_raw_pre[i] ;                                                                                                                             \
                 assign dc_tag_clken_final[i]       =   dc_tag_clken[i];                                                                                                                              \
             end
   for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: WAYS


   if (pt.ICACHE_ECC) begin  : ECC1
      logic [pt.ICACHE_NUM_WAYS-1:0] [pt.ICACHE_TAG_NUM_BYPASS-1:0][25 :0] wb_dout_hold;

      if (pt.ICACHE_TAG_DEPTH == 32)   begin : size_32
                 `EH2_DC_TAG_SRAM(32,26)
      end // if (pt.ICACHE_TAG_DEPTH == 32)
      if (pt.ICACHE_TAG_DEPTH == 64)   begin : size_64
                 `EH2_DC_TAG_SRAM(64,26)
      end // if (pt.ICACHE_TAG_DEPTH == 64)
      if (pt.ICACHE_TAG_DEPTH == 128)   begin : size_128
                 `EH2_DC_TAG_SRAM(128,26)
      end // if (pt.ICACHE_TAG_DEPTH == 128)
       if (pt.ICACHE_TAG_DEPTH == 256)   begin : size_256
                 `EH2_DC_TAG_SRAM(256,26)
       end // if (pt.ICACHE_TAG_DEPTH == 256)
       if (pt.ICACHE_TAG_DEPTH == 512)   begin : size_512
                 `EH2_DC_TAG_SRAM(512,26)
       end // if (pt.ICACHE_TAG_DEPTH == 512)
       if (pt.ICACHE_TAG_DEPTH == 1024)   begin : size_1024
                 `EH2_DC_TAG_SRAM(1024,26)
       end // if (pt.ICACHE_TAG_DEPTH == 1024)
       if (pt.ICACHE_TAG_DEPTH == 2048)   begin : size_2048
                 `EH2_DC_TAG_SRAM(2048,26)
       end // if (pt.ICACHE_TAG_DEPTH == 2048)
       if (pt.ICACHE_TAG_DEPTH == 4096)   begin  : size_4096
                 `EH2_DC_TAG_SRAM(4096,26)
       end // if (pt.ICACHE_TAG_DEPTH == 4096)


         assign w_tout[i][31:pt.ICACHE_TAG_LO] = dc_tag_data_raw[i][31-pt.ICACHE_TAG_LO:0] ;
         assign w_tout[i][32]                  =  1'b0 ; // Unused in this context


      rvdffe #(26) tg_data_raw_ff (.*,
                                   .en(dc_rd_en_ff),
                                   .din ({dc_tag_data_raw[i][25:0]}),
                                   .dout({dc_tag_data_raw_ff[i][25:0]})
                                   );


      rvecc_decode  ecc_decode (
                                .en(ecc_decode_enable),
                                .sed_ded ( 1'b1 ),                                      // 1 : means only detection
                                .din(   (ecc_decode_enable)?{11'b0,dc_tag_data_raw_ff[i][20:0]}:32'd0),
                                .ecc_in((ecc_decode_enable)?{2'b0, dc_tag_data_raw_ff[i][25:21]}:7'd0),
                                .dout(dc_tag_corrected_data_unc[i][31:0]),
                                .ecc_out(dc_tag_corrected_ecc_unc[i][6:0]),
                                .single_ecc_error(dc_tag_single_ecc_error[i]),
                                .double_ecc_error(dc_tag_double_ecc_error[i]));

        assign dc_tag_way_perr[i]= dc_tag_single_ecc_error[i] | dc_tag_double_ecc_error[i]  ;
      end
      else  begin : ECC0


      logic [pt.ICACHE_NUM_WAYS-1:0] [pt.ICACHE_TAG_NUM_BYPASS-1:0][21 :0] wb_dout_hold;
      assign dc_tag_data_raw_pre[i][25:22] = '0 ;

      if (pt.ICACHE_TAG_DEPTH == 32)   begin : size_32
                 `EH2_DC_TAG_SRAM(32,22)
      end // if (pt.ICACHE_TAG_DEPTH == 32)
      if (pt.ICACHE_TAG_DEPTH == 64)   begin : size_64
                 `EH2_DC_TAG_SRAM(64,22)
      end // if (pt.ICACHE_TAG_DEPTH == 64)
      if (pt.ICACHE_TAG_DEPTH == 128)   begin : size_128
                 `EH2_DC_TAG_SRAM(128,22)
      end // if (pt.ICACHE_TAG_DEPTH == 128)
       if (pt.ICACHE_TAG_DEPTH == 256)   begin : size_256
                 `EH2_DC_TAG_SRAM(256,22)
       end // if (pt.ICACHE_TAG_DEPTH == 256)
       if (pt.ICACHE_TAG_DEPTH == 512)   begin : size_512
                 `EH2_DC_TAG_SRAM(512,22)
       end // if (pt.ICACHE_TAG_DEPTH == 512)
       if (pt.ICACHE_TAG_DEPTH == 1024)   begin : size_1024
                 `EH2_DC_TAG_SRAM(1024,22)
       end // if (pt.ICACHE_TAG_DEPTH == 1024)
       if (pt.ICACHE_TAG_DEPTH == 2048)   begin : size_2048
                 `EH2_DC_TAG_SRAM(2048,22)
       end // if (pt.ICACHE_TAG_DEPTH == 2048)
       if (pt.ICACHE_TAG_DEPTH == 4096)   begin  : size_4096
                 `EH2_DC_TAG_SRAM(4096,22)
       end // if (pt.ICACHE_TAG_DEPTH == 4096)


         assign w_tout[i][31:pt.ICACHE_TAG_LO] = dc_tag_data_raw[i][31-pt.ICACHE_TAG_LO:0] ;
         assign w_tout[i][32]                  = dc_tag_data_raw[i][21] ;

         rvdff #(33-pt.ICACHE_TAG_LO) tg_data_raw_ff (.*,
                                                      .clk(active_clk),
                                                      .din (w_tout[i][32:pt.ICACHE_TAG_LO]),
                                                      .dout(w_tout_ff[i][32:pt.ICACHE_TAG_LO])
                                                      );

         rveven_paritycheck #(32-pt.ICACHE_TAG_LO) parcheck(.data_in   (w_tout_ff[i][31:pt.ICACHE_TAG_LO]),
                                                   .parity_in (w_tout_ff[i][32]),
                                                   .parity_err(dc_tag_way_perr[i]));
      end // else: !if(pt.ICACHE_ECC)

   end // block: WAYS
end // block: PACKED_0

   // WAY PACKED
else begin : PACKED_1

   logic                                                                                dc_b_sram_en;
   logic                                                                                dc_b_read_en;
   logic                                                                                dc_b_write_en;
   logic [pt.ICACHE_TAG_NUM_BYPASS-1:0] [pt.ICACHE_INDEX_HI : pt.ICACHE_TAG_INDEX_LO]   wb_index_hold;
   logic                                [pt.ICACHE_INDEX_HI : pt.ICACHE_TAG_INDEX_LO]   dc_b_rw_addr;
   logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 write_bypass_en;     //bank
   logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 write_bypass_en_ff;  //bank
   logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 index_valid;  //bank
   logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 dc_b_clear_en;
   logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]                                                 dc_b_addr_match;




    logic [pt.ICACHE_TAG_NUM_BYPASS_WIDTH-1:0]  wrptr;
    logic [pt.ICACHE_TAG_NUM_BYPASS_WIDTH-1:0]  wrptr_in;
    logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]        sel_bypass;
    logic [pt.ICACHE_TAG_NUM_BYPASS-1:0]        sel_bypass_ff;



    logic [(26*pt.ICACHE_NUM_WAYS)-1:0]  sel_bypass_data;
    logic                                any_bypass;
    logic                                any_addr_match;
    logic                                dc_tag_clken_final;

`define EH2_DC_TAG_PACKED_SRAM(depth,width)                                                               \
                  ram_be_``depth``x``width  dc_way_tag (                                                   \
                                .ME  ( dc_tag_clken_final),                                                \
                                .WE  (|dc_tag_wren_q[pt.ICACHE_NUM_WAYS-1:0]),                             \
                                .WEM (dc_tag_wren_biten_vec[``width-1:0]),                                 \
                                                                                                           \
                                .D   ({pt.ICACHE_NUM_WAYS{dc_tag_wr_data[``width/pt.ICACHE_NUM_WAYS-1:0]}}), \
                                .ADR (dc_rw_addr_q[pt.ICACHE_INDEX_HI:pt.ICACHE_TAG_INDEX_LO]),            \
                                .Q   (dc_tag_data_raw_packed_pre[``width-1:0]),                            \
                                .CLK (clk),                                                                \
                                .ROP ( ),                                                                  \
                                                                                                           \
                                .TEST1     (dc_tag_ext_in_pkt[0].TEST1),                                   \
                                .RME      (dc_tag_ext_in_pkt[0].RME),                                      \
                                .RM       (dc_tag_ext_in_pkt[0].RM),                                       \
                                                                                                           \
                                .LS       (dc_tag_ext_in_pkt[0].LS),                                       \
                                .DS       (dc_tag_ext_in_pkt[0].DS),                                       \
                                .SD       (dc_tag_ext_in_pkt[0].SD),                                       \
                                                                                                           \
                                .TEST_RNM (dc_tag_ext_in_pkt[0].TEST_RNM),                                 \
                                .BC1      (dc_tag_ext_in_pkt[0].BC1),                                      \
                                .BC2      (dc_tag_ext_in_pkt[0].BC2)                                       \
                                                                                                           \
                               );                                                                          \
                                                                                                           \
              if (pt.ICACHE_TAG_BYPASS_ENABLE == 1) begin                                                                                                                                             \
                                                                                                                                                                                                      \
                 assign wrptr_in = (wrptr == (pt.ICACHE_TAG_NUM_BYPASS-1)) ? '0 : (wrptr + 1'd1);                                                                                                     \
                                                                                                                                                                                                      \
                 rvdffs  #(pt.ICACHE_TAG_NUM_BYPASS_WIDTH)  wrptr_ff(.*, .clk(active_clk), .en(|write_bypass_en), .din (wrptr_in), .dout(wrptr)) ;                                                                    \
                                                                                                                                                                                                      \
                 assign dc_b_sram_en              = |dc_tag_clken;                                                                                                                                    \
                                                                                                                                                                                                      \
                 assign dc_b_read_en              =  dc_b_sram_en  &  (|dc_tag_rden_q);                                                                                                               \
                 assign dc_b_write_en             =  dc_b_sram_en &   (|dc_tag_wren_q);                                                                                                               \
                 assign dc_tag_clken_final        =  dc_b_sram_en &    ~(|sel_bypass);                                                                                                                \
                                                                                                                                                                                                      \
                 // LSB is pt.ICACHE_TAG_INDEX_LO]                                                                                                                                                    \
                 assign dc_b_rw_addr = {dc_rw_addr_q};                                                                                                                                                \
                                                                                                                                                                                                      \
                 always_comb begin                                                                                                                                                                    \
                    any_addr_match = '0;                                                                                                                                                              \
                                                                                                                                                                                                      \
                    for (int l=0; l<pt.ICACHE_TAG_NUM_BYPASS; l++) begin                                                                                                                              \
                       any_addr_match |= dc_b_addr_match[l];                                                                                                                                          \
                    end                                                                                                                                                                               \
                 end                                                                                                                                                                                  \
                                                                                                                                                                                                      \
                // it is an error to ever have 2 entries with the same index and both valid                                                                                                           \
                for (genvar l=0; l<pt.ICACHE_TAG_NUM_BYPASS; l++) begin: BYPASS                                                                                                                       \
                                                                                                                                                                                                      \
                   assign dc_b_addr_match[l] = (wb_index_hold[l] ==  dc_b_rw_addr) & index_valid[l];                                                                                                  \
                                                                                                                                                                                                      \
                   assign dc_b_clear_en[l]   = dc_b_write_en &   dc_b_addr_match[l];                                                                                                                  \
                                                                                                                                                                                                      \
                   assign sel_bypass[l]      = dc_b_read_en  &   dc_b_addr_match[l] ;                                                                                                                 \
                                                                                                                                                                                                      \
                   assign write_bypass_en[l] = dc_b_read_en  &  ~any_addr_match & (wrptr == l);                                                                                                       \
                                                                                                                                                                                                      \
                   rvdff  #(1)  write_bypass_ff (.*, .clk(active_clk),                                                     .din(write_bypass_en[l]), .dout(write_bypass_en_ff[l])) ;                                  \
                   rvdffs #(1)  index_val_ff    (.*, .clk(active_clk), .en(write_bypass_en[l] | dc_b_clear_en[l]),         .din(~dc_b_clear_en[l]),  .dout(index_valid[l])) ;                                         \
                   rvdff  #(1)  sel_hold_ff     (.*, .clk(active_clk),                                                     .din(sel_bypass[l]),      .dout(sel_bypass_ff[l])) ;                                               \
                                                                                                                                                                                                      \
                   rvdffs #((pt.ICACHE_INDEX_HI-pt.ICACHE_TAG_INDEX_LO+1))  dc_addr_index    (.*, .clk(active_clk), .en(write_bypass_en[l]),    .din (dc_b_rw_addr),               .dout(wb_index_hold[l]));          \
                   rvdffe #(``width)                                        rd_data_hold_ff  (.*, .en(write_bypass_en_ff[l]), .din (dc_tag_data_raw_packed_pre[``width-1:0]), .dout(wb_packeddout_hold[l]));          \
                                                                                                                                                                                                      \
                end // block: BYPASS                                                                                                                                                                  \
                                                                                                                                                                                                      \
                always_comb begin                                                                                                                                                                     \
                 any_bypass = '0;                                                                                                                                                                     \
                 sel_bypass_data = '0;                                                                                                                                                                \
                                                                                                                                                                                                      \
                 for (int l=0; l<pt.ICACHE_TAG_NUM_BYPASS; l++) begin                                                                                                                                 \
                    any_bypass      |=  sel_bypass_ff[l];                                                                                                                                             \
                    sel_bypass_data |= (sel_bypass_ff[l]) ? wb_packeddout_hold[l] : '0;                                                                                                               \
                 end                                                                                                                                                                                  \
                                                                                                                                                                                                      \
                   dc_tag_data_raw_packed   =   any_bypass ?  sel_bypass_data :  dc_tag_data_raw_packed_pre ;                                                                                         \
                end // always_comb begin                                                                                                                                                              \
                                                                                                                                                                                                      \
             end // if (pt.ICACHE_BYPASS_ENABLE == 1)                                                                                                                                                 \
             else begin                                                                                                                                                                               \
                 assign dc_tag_data_raw_packed   =   dc_tag_data_raw_packed_pre ;                                                                                                                     \
                 assign dc_tag_clken_final       =  |dc_tag_clken;                                                                                                                                    \
             end

   if (pt.ICACHE_ECC) begin  : ECC1
    logic [(26*pt.ICACHE_NUM_WAYS)-1 :0]  dc_tag_data_raw_packed, dc_tag_wren_biten_vec, dc_tag_data_raw_packed_pre;           // data and its bit enables
    logic [pt.ICACHE_TAG_NUM_BYPASS-1:0][(26*pt.ICACHE_NUM_WAYS)-1 :0] wb_packeddout_hold;
    for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: BITEN
        assign dc_tag_wren_biten_vec[(26*i)+25:26*i] = {26{dc_tag_wren_q[i]}};
     end
      if (pt.ICACHE_TAG_DEPTH == 32)   begin : size_32
        if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(32,104)
        end // block: WAYS
      else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(32,52)
        end // block: WAYS
      end // if (pt.ICACHE_TAG_DEPTH == 32

      if (pt.ICACHE_TAG_DEPTH == 64)   begin : size_64
        if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(64,104)
        end // block: WAYS
      else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(64,52)
        end // block: WAYS
      end // block: size_64

      if (pt.ICACHE_TAG_DEPTH == 128)   begin : size_128
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(128,104)
      end // block: WAYS
      else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(128,52)
      end // block: WAYS

      end // block: size_128

      if (pt.ICACHE_TAG_DEPTH == 256)   begin : size_256
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(256,104)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(256,52)
        end // block: WAYS
      end // block: size_256

      if (pt.ICACHE_TAG_DEPTH == 512)   begin : size_512
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(512,104)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(512,52)
        end // block: WAYS
      end // block: size_512

      if (pt.ICACHE_TAG_DEPTH == 1024)   begin : size_1024
         if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(1024,104)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(1024,52)
        end // block: WAYS
      end // block: size_1024

      if (pt.ICACHE_TAG_DEPTH == 2048)   begin : size_2048
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(2048,104)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(2048,52)
        end // block: WAYS
      end // block: size_2048

      if (pt.ICACHE_TAG_DEPTH == 4096)   begin  : size_4096
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(4096,104)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(4096,52)
        end // block: WAYS
      end // block: size_4096


        for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin
          assign dc_tag_data_raw[i]  = dc_tag_data_raw_packed[(26*i)+25:26*i];
          assign w_tout[i][31:pt.ICACHE_TAG_LO] = dc_tag_data_raw[i][31-pt.ICACHE_TAG_LO:0] ;
          assign w_tout[i][32]                  =  1'b0 ; // Unused in this context

           rvdffe #(26) tg_data_raw_ff (.*,
                                        .en  (dc_rd_en_ff),
                                        .din ({dc_tag_data_raw[i][25:0]}),
                                        .dout({dc_tag_data_raw_ff[i][25:0]})
                                        );


           rvecc_decode  ecc_decode (
                                     .en(ecc_decode_enable),
                                     .sed_ded ( 1'b1 ),                                      // 1 : means only detection
                                     .din(   (ecc_decode_enable)?{11'b0,dc_tag_data_raw_ff[i][20:0]}:32'd0),
                                     .ecc_in((ecc_decode_enable)?{2'b0, dc_tag_data_raw_ff[i][25:21]}:7'd0),
                                     .dout(dc_tag_corrected_data_unc[i][31:0]),
                                     .ecc_out(dc_tag_corrected_ecc_unc[i][6:0]),
                                     .single_ecc_error(dc_tag_single_ecc_error[i]),
                                     .double_ecc_error(dc_tag_double_ecc_error[i]));


           assign dc_tag_way_perr[i]= dc_tag_single_ecc_error[i] | dc_tag_double_ecc_error[i]  ;

        end // for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++)

   end // block: ECC1


   else  begin : ECC0

    logic [(22*pt.ICACHE_NUM_WAYS)-1 :0]  dc_tag_data_raw_packed, dc_tag_wren_biten_vec, dc_tag_data_raw_packed_pre;           // data and its bit enables
    logic [pt.ICACHE_TAG_NUM_BYPASS-1:0][(22*pt.ICACHE_NUM_WAYS)-1 :0] wb_packeddout_hold;
    for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin: BITEN
        assign dc_tag_wren_biten_vec[(22*i)+21:22*i] = {22{dc_tag_wren_q[i]}};
     end
      if (pt.ICACHE_TAG_DEPTH == 32)   begin : size_32
        if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(32,88)
        end // block: WAYS
      else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(32,44)
        end // block: WAYS
      end // if (pt.ICACHE_TAG_DEPTH == 32

      if (pt.ICACHE_TAG_DEPTH == 64)   begin : size_64
        if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(64,88)
        end // block: WAYS
      else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(64,44)
        end // block: WAYS
      end // block: size_64

      if (pt.ICACHE_TAG_DEPTH == 128)   begin : size_128
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(128,88)
      end // block: WAYS
      else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(128,44)
      end // block: WAYS

      end // block: size_128

      if (pt.ICACHE_TAG_DEPTH == 256)   begin : size_256
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(256,88)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(256,44)
        end // block: WAYS
      end // block: size_256

      if (pt.ICACHE_TAG_DEPTH == 512)   begin : size_512
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(512,88)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(512,44)
        end // block: WAYS
      end // block: size_512

      if (pt.ICACHE_TAG_DEPTH == 1024)   begin : size_1024
         if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(1024,88)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(1024,44)
        end // block: WAYS
      end // block: size_1024

      if (pt.ICACHE_TAG_DEPTH == 2048)   begin : size_2048
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(2048,88)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(2048,44)
        end // block: WAYS
      end // block: size_2048

      if (pt.ICACHE_TAG_DEPTH == 4096)   begin  : size_4096
       if (pt.ICACHE_NUM_WAYS == 4) begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(4096,88)
        end // block: WAYS
       else begin : WAYS
                 `EH2_DC_TAG_PACKED_SRAM(4096,44)
        end // block: WAYS
      end // block: size_4096


      for (genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : WAYS
          assign dc_tag_data_raw[i]  = dc_tag_data_raw_packed[(22*i)+21:22*i];
          assign w_tout[i][31:pt.ICACHE_TAG_LO] = dc_tag_data_raw[i][31-pt.ICACHE_TAG_LO:0] ;
          assign w_tout[i][32]                 = dc_tag_data_raw[i][21] ;

          rvdff #(33-pt.ICACHE_TAG_LO) tg_data_raw_ff (.*,
                                                       .clk(active_clk),
                                                       .din (w_tout[i][32:pt.ICACHE_TAG_LO]),
                                                       .dout(w_tout_ff[i][32:pt.ICACHE_TAG_LO])
                                                       );

          rveven_paritycheck #(32-pt.ICACHE_TAG_LO) parcheck(.data_in   (w_tout_ff[i][31:pt.ICACHE_TAG_LO]),
                                                   .parity_in (w_tout_ff[i][32]),
                                                   .parity_err(dc_tag_way_perr[i]));
      end // block: WAYS



   end // block: ECC0
end // block: PACKED_1


   always_comb begin : tag_rd_out
      dctag_debug_rd_data[25:0] = '0;
      for ( int j=0; j<pt.ICACHE_NUM_WAYS; j++) begin: debug_rd_out
         dctag_debug_rd_data[25:0] |=  pt.ICACHE_ECC ? ({26{dc_debug_rd_way_en_ff[j]}} & dc_tag_data_raw[j] ) : {4'b0, ({22{dc_debug_rd_way_en_ff[j]}} & dc_tag_data_raw[j][21:0])};
      end
   end


   for ( genvar i=0; i<pt.ICACHE_NUM_WAYS; i++) begin : dc_rd_hit_loop
      assign dc_rd_hit[i] = (w_tout[i][31:pt.ICACHE_TAG_LO] == dc_rw_addr_ff[31:pt.ICACHE_TAG_LO]) & dc_tag_valid[i] & ~dc_wr_en_ff;
   end

   assign  dc_tag_perr  = | (dc_tag_way_perr[pt.ICACHE_NUM_WAYS-1:0] & dc_tag_valid_ff[pt.ICACHE_NUM_WAYS-1:0] ) ;
endmodule // EH2_DC_TAG
