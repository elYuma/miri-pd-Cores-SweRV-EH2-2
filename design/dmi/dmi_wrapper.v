// SPDX-License-Identifier: Apache-2.0
// Copyright 2018 Western Digital Corporation or it's affiliates.
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
//------------------------------------------------------------------------------------
//
//  Copyright Western Digital, 2018
//  Owner : Anusha Narayanamoorthy
//  Description:  
//                Wrapper module for JTAG_TAP and DMI synchronizer
//
//-------------------------------------------------------------------------------------

`ifndef RV_NUM_CORES
`define RV_NUM_CORES 2
`endif

module dmi_wrapper(

  // JTAG signals
  input [`RV_NUM_CORES-1:0]             trst_n,              // JTAG reset
  input [`RV_NUM_CORES-1:0]             tck,                 // JTAG clock
  input [`RV_NUM_CORES-1:0]             tms,                 // Test mode select   
  input [`RV_NUM_CORES-1:0]             tdi,                 // Test Data Input
  output [`RV_NUM_CORES-1:0]           tdo,                 // Test Data Output           
  output [`RV_NUM_CORES-1:0]            tdoEnable,           // Test Data Output enable             

  // Processor Signals
  input [`RV_NUM_CORES-1:0]             core_rst_n,          // Core reset                  
  input [`RV_NUM_CORES-1:0]             core_clk,            // Core clock                  
  input [`RV_NUM_CORES-1:0][31:1]       jtag_id,             // JTAG ID
  input [`RV_NUM_CORES-1:0][31:0]       rd_data,             // 32 bit Read data from  Processor                       
  output [`RV_NUM_CORES-1:0][31:0]      reg_wr_data,         // 32 bit Write data to Processor                      
  output [`RV_NUM_CORES-1:0][6:0]       reg_wr_addr,         // 7 bit reg address to Processor                   
  output [`RV_NUM_CORES-1:0]            reg_en,              // 1 bit  Read enable to Processor                                    
  output [`RV_NUM_CORES-1:0]            reg_wr_en,           // 1 bit  Write enable to Processor 
  output [`RV_NUM_CORES-1:0]            dmi_hard_reset  
);


  


  //Wire Declaration
  wire [`RV_NUM_CORES-1:0]                    rd_en;
  wire [`RV_NUM_CORES-1:0]                    wr_en;
  wire [`RV_NUM_CORES-1:0]                    dmireset;

 
  //jtag_tap instantiation
  // Core 0
 rvjtag_tap i_jtag_tap_0(
   .trst(trst_n[0]),                      // dedicated JTAG TRST (active low) pad signal or asynchronous active low power on reset
   .tck(tck[0]),                          // dedicated JTAG TCK pad signal
   .tms(tms[0]),                          // dedicated JTAG TMS pad signal
   .tdi(tdi[0]),                          // dedicated JTAG TDI pad signal
   .tdo(tdo[0]),                          // dedicated JTAG TDO pad signal
   .tdoEnable(tdoEnable[0]),              // enable for TDO pad
   .wr_data(reg_wr_data[0]),              // 32 bit Write data
   .wr_addr(reg_wr_addr[0]),              // 7 bit Write address
   .rd_en(rd_en[0]),                      // 1 bit  read enable
   .wr_en(wr_en[0]),                      // 1 bit  Write enable
   .rd_data(rd_data[0]),                  // 32 bit Read data
   .rd_status(2'b0),
   .idle(3'h0),                         // no need to wait to sample data
   .dmi_stat(2'b0),                     // no need to wait or error possible
   .version(4'h1),                      // debug spec 0.13 compliant
   .jtag_id(jtag_id[0]),
   .dmi_hard_reset(dmi_hard_reset[0]),
   .dmi_reset(dmireset[0])
);
  // Core 1
 rvjtag_tap i_jtag_tap_1(
   .trst(trst_n[1]),                     
   .tck(tck[1]),                        
   .tms(tms[1]),                       
   .tdi(tdi[1]),                     
   .tdo(tdo[1]),                       
   .tdoEnable(tdoEnable[1]),           
   .wr_data(reg_wr_data[1]),           
   .wr_addr(reg_wr_addr[1]),          
   .rd_en(rd_en[1]),               
   .wr_en(wr_en[1]),                
   .rd_data(rd_data[1]),        
   .rd_status(2'b0),
   .idle(3'h0),                   
   .dmi_stat(2'b0),           
   .version(4'h1),                
   .jtag_id(jtag_id[1]),
   .dmi_hard_reset(dmi_hard_reset[1]),
   .dmi_reset(dmireset[1])
);


  // dmi_jtag_to_core_sync instantiation
  // Core 0
  dmi_jtag_to_core_sync i_dmi_jtag_to_core_sync_0(
    .wr_en(wr_en[0]),                          // 1 bit  Write enable
    .rd_en(rd_en[0]),                          // 1 bit  Read enable

    .rst_n(core_rst_n[0]),
    .clk(core_clk[0]),
    .reg_en(reg_en[0]),                          // 1 bit  Write interface bit
    .reg_wr_en(reg_wr_en[0])                          // 1 bit  Write enable
  );
  // Core 1
  dmi_jtag_to_core_sync i_dmi_jtag_to_core_sync_1(
    .wr_en(wr_en[1]),                 
    .rd_en(rd_en[1]),                    

    .rst_n(core_rst_n[1]),
    .clk(core_clk[1]),
    .reg_en(reg_en[1]),                      
    .reg_wr_en(reg_wr_en[1])                     
  );

endmodule
