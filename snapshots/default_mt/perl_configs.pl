#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by yuma on sáb 15 ene 2022 17:42:26 CET
# 
#  cmd:    swerv -target=default_mt -set=build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'iccm' => {
                        'iccm_index_bits' => 12,
                        'iccm_size' => 64,
                        'iccm_bits' => 16,
                        'iccm_size_64' => '',
                        'iccm_reserved' => '0x1000',
                        'iccm_enable' => 1,
                        'iccm_sadr' => '0xee000000',
                        'iccm_offset' => '0xe000000',
                        'iccm_num_banks_4' => '',
                        'iccm_data_cell' => 'ram_4096x39',
                        'iccm_rows' => '4096',
                        'iccm_bank_index_lo' => 4,
                        'iccm_bank_hi' => 3,
                        'iccm_bank_bits' => 2,
                        'iccm_eadr' => '0xee00ffff',
                        'iccm_region' => '0xe',
                        'iccm_num_banks' => '4'
                      },
            'physical' => '1',
            'dccm' => {
                        'dccm_byte_width' => '4',
                        'dccm_enable' => 1,
                        'dccm_data_width' => 32,
                        'dccm_width_bits' => 2,
                        'dccm_num_banks_8' => '',
                        'dccm_fdata_width' => 39,
                        'dccm_ecc_width' => 7,
                        'dccm_reserved' => '0x2004',
                        'dccm_bits' => 17,
                        'dccm_index_bits' => 12,
                        'dccm_size' => 128,
                        'dccm_num_banks' => '8',
                        'lsu_sb_bits' => 17,
                        'dccm_region' => '0xf',
                        'dccm_eadr' => '0xf005ffff',
                        'dccm_bank_bits' => 3,
                        'dccm_size_128' => '',
                        'dccm_rows' => '4096',
                        'dccm_data_cell' => 'ram_4096x39',
                        'dccm_offset' => '0x40000',
                        'dccm_sadr' => '0xf0040000'
                      },
            'regwidth' => '32',
            'core' => {
                        'iccm_only' => 'derived',
                        'bitmanip_zbf' => 0,
                        'bitmanip_zba' => 1,
                        'bitmanip_zbp' => 0,
                        'bitmanip_zbs' => 1,
                        'icache_only' => 'derived',
                        'lsu_num_nbload_width' => '3',
                        'bitmanip_zbb' => 1,
                        'timer_legal_en' => '1',
                        'atomic_enable' => '1',
                        'bitmanip_zbr' => 0,
                        'iccm_icache' => 1,
                        'fast_interrupt_redirect' => '1',
                        'bitmanip_zbe' => 0,
                        'div_new' => 1,
                        'lsu_stbuf_depth' => '10',
                        'num_threads' => 2,
                        'dma_buf_depth' => '5',
                        'lsu_num_nbload' => '8',
                        'fpga_optimize' => 1,
                        'load_to_use_bus_plus1' => '1',
                        'div_bit' => '4',
                        'no_iccm_no_icache' => 'derived',
                        'bitmanip_zbc' => 1
                      },
            'harts' => 2,
            'xlen' => 32,
            'icache' => {
                          'icache_num_bypass_width' => 3,
                          'icache_tag_lo' => 13,
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_num_lines_way' => '128',
                          'icache_2banks' => '1',
                          'icache_tag_depth' => 128,
                          'icache_ln_sz' => 64,
                          'icache_num_lines' => 512,
                          'icache_bank_bits' => 1,
                          'icache_tag_num_bypass' => '2',
                          'icache_num_ways' => 4,
                          'icache_tag_bypass_enable' => '1',
                          'icache_scnd_last' => 6,
                          'icache_data_width' => 64,
                          'icache_bank_width' => 8,
                          'icache_bypass_enable' => '1',
                          'icache_tag_num_bypass_width' => 2,
                          'icache_beat_addr_hi' => 5,
                          'icache_bank_lo' => 3,
                          'icache_num_bypass' => '4',
                          'icache_size' => 32,
                          'icache_fdata_width' => 71,
                          'icache_data_depth' => '512',
                          'icache_data_index_lo' => 4,
                          'icache_bank_hi' => 3,
                          'icache_num_lines_bank' => '64',
                          'icache_data_cell' => 'ram_512x71',
                          'icache_ecc' => '1',
                          'icache_tag_index_lo' => '6',
                          'icache_num_beats' => 8,
                          'icache_status_bits' => 3,
                          'icache_beat_bits' => 3,
                          'icache_enable' => 1,
                          'icache_banks_way' => 2,
                          'icache_index_hi' => 12
                        },
            'memmap' => {
                          'debug_sb_mem' => '0xa0580000',
                          'external_data' => '0xc0580000',
                          'unused_region3' => '0x40000000',
                          'unused_region2' => '0x50000000',
                          'unused_region1' => '0x60000000',
                          'unused_region0' => '0x70000000',
                          'unused_region6' => '0x10000000',
                          'unused_region5' => '0x20000000',
                          'serialio' => '0xd0580000',
                          'unused_region7' => '0x00000000',
                          'external_mem_hole' => '0x90000000',
                          'unused_region4' => '0x30000000',
                          'consoleio' => '0xd0580000',
                          'external_data_1' => '0xb0000000'
                        },
            'perf_events' => [
                               1,
                               2,
                               3,
                               4,
                               5,
                               6,
                               7,
                               8,
                               9,
                               10,
                               11,
                               12,
                               13,
                               14,
                               15,
                               16,
                               17,
                               18,
                               19,
                               20,
                               21,
                               22,
                               23,
                               24,
                               25,
                               26,
                               27,
                               28,
                               29,
                               30,
                               31,
                               32,
                               34,
                               35,
                               36,
                               37,
                               38,
                               39,
                               40,
                               41,
                               42,
                               43,
                               44,
                               45,
                               46,
                               47,
                               48,
                               49,
                               50,
                               51,
                               52,
                               53,
                               54,
                               55,
                               56,
                               512,
                               513,
                               514,
                               515,
                               516
                             ],
            'testbench' => {
                             'ext_datawidth' => '64',
                             'clock_period' => '100',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'SDVT_AHB' => '1',
                             'RV_TOP' => '`TOP.rvtop',
                             'mt_build' => 1,
                             'ext_addrwidth' => '32',
                             'datawidth' => '64',
                             'TOP' => 'tb_top',
                             'sterr_rollback' => '0',
                             'build_axi_native' => 1,
                             'lderr_rollback' => '1',
                             'assert_on' => '',
                             'build_axi4' => 1
                           },
            'num_mmode_perf_regs' => '4',
            'csr' => {
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'misa' => {
                                   'reset' => '0x40001105',
                                   'exists' => 'true',
                                   'mask' => '0x0'
                                 },
                       'mpmc' => {
                                   'number' => '0x7c6',
                                   'reset' => '0x2',
                                   'mask' => '0x2',
                                   'exists' => 'true'
                                 },
                       'mrac' => {
                                   'mask' => '0xffffffff',
                                   'number' => '0x7c0',
                                   'comment' => 'Memory region io and cache control.',
                                   'exists' => 'true',
                                   'shared' => 'true',
                                   'reset' => '0x0'
                                 },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'dcsr' => {
                                   'mask' => '0x00008c04',
                                   'exists' => 'true',
                                   'poke_mask' => '0x00008dcc',
                                   'reset' => '0x40000003',
                                   'debug' => 'true'
                                 },
                       'mitcnt1' => {
                                      'mask' => '0xffffffff',
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'number' => '0x7d5'
                                    },
                       'mfdhs' => {
                                    'mask' => '0x00000003',
                                    'exists' => 'true',
                                    'number' => '0x7cf',
                                    'reset' => '0x0',
                                    'comment' => 'Force Debug Halt Status'
                                  },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'mitcnt0' => {
                                      'exists' => 'true',
                                      'mask' => '0xffffffff',
                                      'reset' => '0x0',
                                      'number' => '0x7d2'
                                    },
                       'mscause' => {
                                      'mask' => '0x0000000f',
                                      'exists' => 'true',
                                      'number' => '0x7ff',
                                      'reset' => '0x0'
                                    },
                       'micect' => {
                                     'mask' => '0xffffffff',
                                     'exists' => 'true',
                                     'number' => '0x7f0',
                                     'reset' => '0x0'
                                   },
                       'mhpmcounter6' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'mfdc' => {
                                   'exists' => 'true',
                                   'mask' => '0x00071f4d',
                                   'reset' => '0x00070040',
                                   'shared' => 'true',
                                   'number' => '0x7f9'
                                 },
                       'marchid' => {
                                      'mask' => '0x0',
                                      'exists' => 'true',
                                      'reset' => '0x00000011'
                                    },
                       'tselect' => {
                                      'mask' => '0x3',
                                      'exists' => 'true',
                                      'reset' => '0x0'
                                    },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'mstatus' => {
                                      'reset' => '0x1800',
                                      'exists' => 'true',
                                      'mask' => '0x88'
                                    },
                       'miccmect' => {
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'number' => '0x7f1'
                                     },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mhpmcounter5' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'mitbnd0' => {
                                      'reset' => '0xffffffff',
                                      'number' => '0x7d3',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff'
                                    },
                       'dicad1' => {
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7ca',
                                     'mask' => '0x3',
                                     'reset' => '0x0',
                                     'debug' => 'true',
                                     'exists' => 'true'
                                   },
                       'dicad0' => {
                                     'debug' => 'true',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'number' => '0x7c9',
                                     'comment' => 'Cache diagnostics.',
                                     'mask' => '0xffffffff'
                                   },
                       'mitbnd1' => {
                                      'mask' => '0xffffffff',
                                      'exists' => 'true',
                                      'number' => '0x7d6',
                                      'reset' => '0xffffffff'
                                    },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'dmst' => {
                                   'reset' => '0x0',
                                   'debug' => 'true',
                                   'exists' => 'true',
                                   'number' => '0x7c4',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'mask' => '0x0'
                                 },
                       'mhartstart' => {
                                         'shared' => 'true',
                                         'reset' => '0x1',
                                         'exists' => 'true',
                                         'number' => '0x7fc',
                                         'comment' => 'Hart start mask',
                                         'mask' => '0x2'
                                       },
                       'mhpmevent4' => {
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff',
                                         'exists' => 'true'
                                       },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mimpid' => {
                                     'mask' => '0x0',
                                     'exists' => 'true',
                                     'reset' => '0x3'
                                   },
                       'mhpmcounter4' => {
                                           'exists' => 'true',
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0'
                                         },
                       'mhartnum' => {
                                       'shared' => 'true',
                                       'reset' => '0x2',
                                       'exists' => 'true',
                                       'number' => '0xfc4',
                                       'comment' => 'Hart count',
                                       'mask' => '0x0'
                                     },
                       'mcpc' => {
                                   'exists' => 'true',
                                   'mask' => '0x0',
                                   'comment' => 'Core pause',
                                   'reset' => '0x0',
                                   'number' => '0x7c2'
                                 },
                       'mnmipdel' => {
                                       'exists' => 'true',
                                       'shared' => 'true',
                                       'reset' => '0x1',
                                       'mask' => '0x3',
                                       'number' => '0x7fe',
                                       'comment' => 'NMI pin delegation'
                                     },
                       'mhartid' => {
                                      'reset' => '0x0',
                                      'mask' => '0x0',
                                      'poke_mask' => '0xfffffff0',
                                      'exists' => 'true'
                                    },
                       'meicidpl' => {
                                       'mask' => '0xf',
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'number' => '0xbcb'
                                     },
                       'mfdht' => {
                                    'mask' => '0x0000003f',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'number' => '0x7ce',
                                    'exists' => 'true',
                                    'reset' => '0x0',
                                    'shared' => 'true'
                                  },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'mie' => {
                                  'exists' => 'true',
                                  'mask' => '0x70000888',
                                  'reset' => '0x0'
                                },
                       'mhpmcounter5h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'mvendorid' => {
                                        'reset' => '0x45',
                                        'exists' => 'true',
                                        'mask' => '0x0'
                                      },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'mcountinhibit' => {
                                            'reset' => '0x0',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.',
                                            'mask' => '0x7d',
                                            'poke_mask' => '0x7d',
                                            'exists' => 'true'
                                          },
                       'mip' => {
                                  'exists' => 'true',
                                  'poke_mask' => '0x70000888',
                                  'mask' => '0x0',
                                  'reset' => '0x0'
                                },
                       'dicawics' => {
                                       'mask' => '0x0130fffc',
                                       'comment' => 'Cache diagnostics.',
                                       'number' => '0x7c8',
                                       'exists' => 'true',
                                       'debug' => 'true',
                                       'reset' => '0x0'
                                     },
                       'mhpmcounter4h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mitctl0' => {
                                      'number' => '0x7d4',
                                      'reset' => '0x1',
                                      'mask' => '0x00000007',
                                      'exists' => 'true'
                                    },
                       'mhpmevent5' => {
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff',
                                         'exists' => 'true'
                                       },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter3' => {
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff',
                                           'exists' => 'true'
                                         },
                       'mitctl1' => {
                                      'reset' => '0x1',
                                      'number' => '0x7d7',
                                      'mask' => '0x0000000f',
                                      'exists' => 'true'
                                    },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter6h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'meicurpl' => {
                                       'comment' => 'External interrupt current priority level.',
                                       'reset' => '0x0',
                                       'number' => '0xbcc',
                                       'exists' => 'true',
                                       'mask' => '0xf'
                                     },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'meipt' => {
                                    'comment' => 'External interrupt priority threshold.',
                                    'reset' => '0x0',
                                    'number' => '0xbc9',
                                    'exists' => 'true',
                                    'mask' => '0xf'
                                  },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'mcgc' => {
                                   'reset' => '0x200',
                                   'shared' => 'true',
                                   'poke_mask' => '0x000003ff',
                                   'exists' => 'true',
                                   'number' => '0x7f8',
                                   'mask' => '0x000003ff'
                                 },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent3' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'mhpmevent6' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'mdccmect' => {
                                       'number' => '0x7f2',
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'mask' => '0xffffffff'
                                     },
                       'dicago' => {
                                     'mask' => '0x0',
                                     'number' => '0x7cb',
                                     'comment' => 'Cache diagnostics.',
                                     'exists' => 'true',
                                     'debug' => 'true',
                                     'reset' => '0x0'
                                   }
                     },
            'btb' => {
                       'btb_btag_size' => 5,
                       'btb_btag_fold' => 0,
                       'btb_index2_hi' => 16,
                       'btb_index2_lo' => 10,
                       'btb_addr_lo' => '3',
                       'btb_fold2_index_hash' => 0,
                       'btb_toffset_size' => '12',
                       'btb_num_bypass_width' => 4,
                       'btb_num_bypass' => '8',
                       'btb_index3_lo' => 17,
                       'btb_array_depth' => 128,
                       'btb_index3_hi' => 23,
                       'btb_size' => 512,
                       'btb_index1_hi' => 9,
                       'btb_index1_lo' => '3',
                       'btb_use_sram' => '0',
                       'btb_addr_hi' => 9,
                       'btb_bypass_enable' => '1'
                     },
            'target_default_mt' => '1',
            'tec_rv_icg' => 'clockhdr',
            'bus' => {
                       'ifu_bus_tag' => '4',
                       'lsu_bus_tag' => '4',
                       'dma_bus_prty' => '2',
                       'bus_prty_default' => '3',
                       'dma_bus_id' => '1',
                       'lsu_bus_prty' => '2',
                       'ifu_bus_prty' => '2',
                       'sb_bus_prty' => '2',
                       'dma_bus_tag' => '1',
                       'lsu_bus_id' => '1',
                       'ifu_bus_id' => '1',
                       'sb_bus_tag' => '1',
                       'sb_bus_id' => '1'
                     },
            'bht' => {
                       'bht_hash_string' => 0,
                       'bht_addr_hi' => 9,
                       'bht_ghr_pad2' => 'fghr[3:0],2\'b0',
                       'bht_addr_lo' => '3',
                       'bht_size' => 512,
                       'bht_ghr_pad' => 'fghr[2:0],3\'b0',
                       'bht_ghr_size' => 7,
                       'bht_ghr_hash_1' => '',
                       'bht_ghr_range' => '6:0',
                       'bht_array_depth' => 128
                     },
            'numiregs' => '32',
            'max_mmode_perf_event' => '516',
            'pic' => {
                       'pic_total_int' => 127,
                       'pic_meipl_offset' => '0x0000',
                       'pic_bits' => 15,
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_meip_offset' => '0x1000',
                       'pic_region' => '0xf',
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_meip_mask' => '0x0',
                       'pic_meitp_count' => 4,
                       'pic_2cycle' => '1',
                       'pic_meipl_mask' => '0xf',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_int_words' => 4,
                       'pic_meidels_mask' => '0x1',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meigwclr_count' => 127,
                       'pic_meip_count' => 4,
                       'pic_meipl_count' => 127,
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meie_offset' => '0x2000',
                       'pic_meitp_mask' => '0x0',
                       'pic_offset' => '0xc0000',
                       'pic_meidels_offset' => '0x6000',
                       'pic_base_addr' => '0xf00c0000',
                       'pic_meigwctrl_count' => 127,
                       'pic_meigwclr_mask' => '0x0',
                       'pic_size' => 32,
                       'pic_meidels_count' => 127,
                       'pic_meie_count' => 127,
                       'pic_meitp_offset' => '0x1800',
                       'pic_meie_mask' => '0x1',
                       'pic_mpiccfg_count' => 1,
                       'pic_total_int_plus1' => 128
                     },
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'triggers' => [
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ]
                            },
                            {
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            },
                            {
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ]
                            }
                          ],
            'target' => 'default_mt',
            'protection' => {
                              'inst_access_addr1' => '0xc0000000',
                              'data_access_addr2' => '0xa0000000',
                              'data_access_addr3' => '0x80000000',
                              'inst_access_enable5' => '0x0',
                              'data_access_enable1' => '1',
                              'inst_access_enable6' => '0x0',
                              'inst_access_mask4' => '0xffffffff',
                              'data_access_enable3' => '1',
                              'data_access_addr7' => '0x00000000',
                              'data_access_enable7' => '0x0',
                              'inst_access_addr5' => '0x00000000',
                              'inst_access_addr6' => '0x00000000',
                              'inst_access_mask0' => '0x7fffffff',
                              'data_access_enable4' => '0x0',
                              'data_access_mask1' => '0x3fffffff',
                              'inst_access_mask2' => '0x1fffffff',
                              'inst_access_mask3' => '0x0fffffff',
                              'data_access_enable0' => '1',
                              'data_access_addr4' => '0x00000000',
                              'inst_access_mask7' => '0xffffffff',
                              'data_access_addr0' => '0x0',
                              'data_access_mask6' => '0xffffffff',
                              'data_access_enable2' => '1',
                              'data_access_mask5' => '0xffffffff',
                              'inst_access_enable3' => '1',
                              'inst_access_addr7' => '0x00000000',
                              'inst_access_enable7' => '0x0',
                              'data_access_addr5' => '0x00000000',
                              'data_access_mask0' => '0x7fffffff',
                              'data_access_addr6' => '0x00000000',
                              'data_access_addr1' => '0xc0000000',
                              'inst_access_addr3' => '0x80000000',
                              'inst_access_addr2' => '0xa0000000',
                              'data_access_enable5' => '0x0',
                              'inst_access_enable1' => '1',
                              'data_access_enable6' => '0x0',
                              'data_access_mask4' => '0xffffffff',
                              'data_access_mask7' => '0xffffffff',
                              'inst_access_mask6' => '0xffffffff',
                              'inst_access_addr0' => '0x0',
                              'inst_access_enable2' => '1',
                              'inst_access_mask5' => '0xffffffff',
                              'inst_access_enable4' => '0x0',
                              'inst_access_enable0' => '1',
                              'data_access_mask3' => '0x0fffffff',
                              'data_access_mask2' => '0x1fffffff',
                              'inst_access_mask1' => '0x3fffffff',
                              'inst_access_addr4' => '0x00000000'
                            },
            'config_key' => '32\'hdeadbeef',
            'reset_vec' => '0x80000000',
            'nmi_vec' => '0x11110000',
            'even_odd_trigger_chains' => 'true'
          );
1;
