#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by marti on mar 16 nov 2021 14:25:00 CET
# 
#  cmd:    swerv -target=default_mt -set=build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'max_mmode_perf_event' => '516',
            'tec_rv_icg' => 'clockhdr',
            'reset_vec' => '0x80000000',
            'xlen' => 32,
            'physical' => '1',
            'core' => {
                        'bitmanip_zbs' => 1,
                        'icache_only' => 'derived',
                        'iccm_icache' => 1,
                        'load_to_use_bus_plus1' => '1',
                        'atomic_enable' => '1',
                        'bitmanip_zbb' => 1,
                        'bitmanip_zba' => 1,
                        'div_new' => 1,
                        'lsu_num_nbload' => '8',
                        'timer_legal_en' => '1',
                        'iccm_only' => 'derived',
                        'no_iccm_no_icache' => 'derived',
                        'fpga_optimize' => 1,
                        'div_bit' => '4',
                        'num_cores' => '2',
                        'lsu_num_nbload_width' => '3',
                        'bitmanip_zbc' => 1,
                        'bitmanip_zbr' => 0,
                        'dma_buf_depth' => '5',
                        'fast_interrupt_redirect' => '1',
                        'bitmanip_zbe' => 0,
                        'num_threads' => 2,
                        'lsu_stbuf_depth' => '10',
                        'bitmanip_zbf' => 0,
                        'bitmanip_zbp' => 0
                      },
            'target_default_mt' => '1',
            'memmap' => {
                          'external_mem_hole' => '0x90000000',
                          'external_data' => '0xc0580000',
                          'debug_sb_mem' => '0xa0580000',
                          'unused_region2' => '0x50000000',
                          'unused_region6' => '0x10000000',
                          'unused_region1' => '0x60000000',
                          'unused_region3' => '0x40000000',
                          'unused_region5' => '0x20000000',
                          'consoleio' => '0xd0580000',
                          'unused_region7' => '0x00000000',
                          'unused_region4' => '0x30000000',
                          'serialio' => '0xd0580000',
                          'unused_region0' => '0x70000000',
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
            'icache' => {
                          'icache_num_lines_way' => '128',
                          'icache_tag_index_lo' => '6',
                          'icache_2banks' => '1',
                          'icache_tag_num_bypass_width' => 2,
                          'icache_tag_lo' => 13,
                          'icache_fdata_width' => 71,
                          'icache_data_index_lo' => 4,
                          'icache_bank_bits' => 1,
                          'icache_status_bits' => 3,
                          'icache_data_width' => 64,
                          'icache_bypass_enable' => '1',
                          'icache_num_beats' => 8,
                          'icache_data_cell' => 'ram_512x71',
                          'icache_beat_addr_hi' => 5,
                          'icache_num_ways' => 4,
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_tag_depth' => 128,
                          'icache_bank_lo' => 3,
                          'icache_index_hi' => 12,
                          'icache_banks_way' => 2,
                          'icache_tag_num_bypass' => '2',
                          'icache_tag_bypass_enable' => '1',
                          'icache_beat_bits' => 3,
                          'icache_scnd_last' => 6,
                          'icache_data_depth' => '512',
                          'icache_num_bypass' => '4',
                          'icache_num_lines_bank' => '64',
                          'icache_num_bypass_width' => 3,
                          'icache_ln_sz' => 64,
                          'icache_enable' => 1,
                          'icache_bank_width' => 8,
                          'icache_size' => 32,
                          'icache_ecc' => '1',
                          'icache_bank_hi' => 3,
                          'icache_num_lines' => 512
                        },
            'config_key' => '32\'hdeadbeef',
            'bus' => {
                       'sb_bus_prty' => '2',
                       'sb_bus_tag' => '1',
                       'lsu_bus_prty' => '2',
                       'dma_bus_id' => '1',
                       'dma_bus_tag' => '1',
                       'dma_bus_prty' => '2',
                       'lsu_bus_id' => '1',
                       'lsu_bus_tag' => '4',
                       'sb_bus_id' => '1',
                       'ifu_bus_prty' => '2',
                       'ifu_bus_tag' => '4',
                       'ifu_bus_id' => '1',
                       'bus_prty_default' => '3'
                     },
            'harts' => 2,
            'numiregs' => '32',
            'regwidth' => '32',
            'pic' => {
                       'pic_bits' => 15,
                       'pic_meidels_offset' => '0x6000',
                       'pic_base_addr' => '0xf00c0000',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_region' => '0xf',
                       'pic_meie_mask' => '0x1',
                       'pic_meip_offset' => '0x1000',
                       'pic_meipl_count' => 127,
                       'pic_meie_count' => 127,
                       'pic_int_words' => 4,
                       'pic_meitp_count' => 4,
                       'pic_meidels_mask' => '0x1',
                       'pic_2cycle' => '1',
                       'pic_meidels_count' => 127,
                       'pic_total_int_plus1' => 128,
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_meitp_offset' => '0x1800',
                       'pic_meipl_mask' => '0xf',
                       'pic_meigwctrl_count' => 127,
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meigwclr_count' => 127,
                       'pic_mpiccfg_count' => 1,
                       'pic_meip_mask' => '0x0',
                       'pic_meie_offset' => '0x2000',
                       'pic_offset' => '0xc0000',
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meip_count' => 4,
                       'pic_total_int' => 127,
                       'pic_meigwclr_mask' => '0x0',
                       'pic_meipl_offset' => '0x0000',
                       'pic_size' => 32,
                       'pic_meitp_mask' => '0x0'
                     },
            'bht' => {
                       'bht_ghr_range' => '6:0',
                       'bht_ghr_size' => 7,
                       'bht_ghr_pad' => 'fghr[2:0],3\'b0',
                       'bht_hash_string' => 0,
                       'bht_addr_hi' => 9,
                       'bht_size' => 512,
                       'bht_addr_lo' => '3',
                       'bht_ghr_hash_1' => '',
                       'bht_array_depth' => 128,
                       'bht_ghr_pad2' => 'fghr[3:0],2\'b0'
                     },
            'num_mmode_perf_regs' => '4',
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'target' => 'default_mt',
            'testbench' => {
                             'TOP' => 'tb_top',
                             'ext_addrwidth' => '32',
                             'sterr_rollback' => '0',
                             'CPU_TOP' => '`RV_TOP.swerv_0',
                             'RV_TOP' => '`TOP.rvtop',
                             'clock_period' => '100',
                             'mt_build' => 1,
                             'build_axi_native' => 1,
                             'datawidth' => '64',
                             'build_axi4' => 1,
                             'lderr_rollback' => '1',
                             'assert_on' => '',
                             'SDVT_AHB' => '1',
                             'CPU_TOP_1' => '`RV_TOP.swerv_1',
                             'ext_datawidth' => '64'
                           },
            'dccm' => {
                        'dccm_reserved' => '0x2004',
                        'dccm_ecc_width' => 7,
                        'dccm_num_banks_8' => '',
                        'dccm_size_128' => '',
                        'dccm_width_bits' => 2,
                        'dccm_data_width' => 32,
                        'dccm_eadr' => '0xf005ffff',
                        'dccm_index_bits' => 12,
                        'dccm_region' => '0xf',
                        'lsu_sb_bits' => 17,
                        'dccm_bits' => 17,
                        'dccm_data_cell' => 'ram_4096x39',
                        'dccm_enable' => 1,
                        'dccm_bank_bits' => 3,
                        'dccm_fdata_width' => 39,
                        'dccm_byte_width' => '4',
                        'dccm_num_banks' => '8',
                        'dccm_sadr' => '0xf0040000',
                        'dccm_offset' => '0x40000',
                        'dccm_rows' => '4096',
                        'dccm_size' => 128
                      },
            'iccm' => {
                        'iccm_size' => 64,
                        'iccm_bank_hi' => 3,
                        'iccm_offset' => '0xe000000',
                        'iccm_rows' => '4096',
                        'iccm_num_banks' => '4',
                        'iccm_sadr' => '0xee000000',
                        'iccm_bits' => 16,
                        'iccm_data_cell' => 'ram_4096x39',
                        'iccm_enable' => 1,
                        'iccm_bank_bits' => 2,
                        'iccm_index_bits' => 12,
                        'iccm_region' => '0xe',
                        'iccm_num_banks_4' => '',
                        'iccm_bank_index_lo' => 4,
                        'iccm_reserved' => '0x1000',
                        'iccm_size_64' => '',
                        'iccm_eadr' => '0xee00ffff'
                      },
            'csr' => {
                       'mhpmevent6' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mimpid' => {
                                     'mask' => '0x0',
                                     'exists' => 'true',
                                     'reset' => '0x3'
                                   },
                       'mfdc' => {
                                   'exists' => 'true',
                                   'reset' => '0x00070040',
                                   'mask' => '0x00071f4d',
                                   'number' => '0x7f9',
                                   'shared' => 'true'
                                 },
                       'dmst' => {
                                   'debug' => 'true',
                                   'mask' => '0x0',
                                   'number' => '0x7c4',
                                   'reset' => '0x0',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'exists' => 'true'
                                 },
                       'tselect' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'mask' => '0x3'
                                    },
                       'mhpmcounter4h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'mitctl1' => {
                                      'mask' => '0x0000000f',
                                      'number' => '0x7d7',
                                      'exists' => 'true',
                                      'reset' => '0x1'
                                    },
                       'mhpmcounter6' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'dcsr' => {
                                   'mask' => '0x00008c04',
                                   'debug' => 'true',
                                   'exists' => 'true',
                                   'reset' => '0x40000003',
                                   'poke_mask' => '0x00008dcc'
                                 },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mscause' => {
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'number' => '0x7ff',
                                      'mask' => '0x0000000f'
                                    },
                       'meicurpl' => {
                                       'reset' => '0x0',
                                       'comment' => 'External interrupt current priority level.',
                                       'exists' => 'true',
                                       'mask' => '0xf',
                                       'number' => '0xbcc'
                                     },
                       'meipt' => {
                                    'exists' => 'true',
                                    'reset' => '0x0',
                                    'comment' => 'External interrupt priority threshold.',
                                    'mask' => '0xf',
                                    'number' => '0xbc9'
                                  },
                       'mhpmcounter3h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'mcgc' => {
                                   'shared' => 'true',
                                   'reset' => '0x200',
                                   'mask' => '0x000003ff',
                                   'number' => '0x7f8',
                                   'poke_mask' => '0x000003ff',
                                   'exists' => 'true'
                                 },
                       'mie' => {
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'mask' => '0x70000888'
                                },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'mfdht' => {
                                    'number' => '0x7ce',
                                    'mask' => '0x0000003f',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'exists' => 'true',
                                    'shared' => 'true',
                                    'reset' => '0x0'
                                  },
                       'mitbnd1' => {
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d6',
                                      'reset' => '0xffffffff',
                                      'exists' => 'true'
                                    },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'dicad0' => {
                                     'number' => '0x7c9',
                                     'mask' => '0xffffffff',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0'
                                   },
                       'mstatus' => {
                                      'mask' => '0x88',
                                      'exists' => 'true',
                                      'reset' => '0x1800'
                                    },
                       'mhpmcounter5' => {
                                           'mask' => '0xffffffff',
                                           'exists' => 'true',
                                           'reset' => '0x0'
                                         },
                       'mpmc' => {
                                   'mask' => '0x2',
                                   'number' => '0x7c6',
                                   'reset' => '0x2',
                                   'exists' => 'true'
                                 },
                       'mvendorid' => {
                                        'mask' => '0x0',
                                        'exists' => 'true',
                                        'reset' => '0x45'
                                      },
                       'mitcnt1' => {
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d5',
                                      'reset' => '0x0',
                                      'exists' => 'true'
                                    },
                       'dicago' => {
                                     'comment' => 'Cache diagnostics.',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'debug' => 'true',
                                     'number' => '0x7cb',
                                     'mask' => '0x0'
                                   },
                       'marchid' => {
                                      'reset' => '0x00000011',
                                      'exists' => 'true',
                                      'mask' => '0x0'
                                    },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mcountinhibit' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'poke_mask' => '0x7d',
                                            'mask' => '0x7d',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.'
                                          },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'misa' => {
                                   'mask' => '0x0',
                                   'exists' => 'true',
                                   'reset' => '0x40001105'
                                 },
                       'mfdhs' => {
                                    'exists' => 'true',
                                    'reset' => '0x0',
                                    'comment' => 'Force Debug Halt Status',
                                    'mask' => '0x00000003',
                                    'number' => '0x7cf'
                                  },
                       'mhpmcounter4' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'mrac' => {
                                   'comment' => 'Memory region io and cache control.',
                                   'exists' => 'true',
                                   'number' => '0x7c0',
                                   'mask' => '0xffffffff',
                                   'reset' => '0x0',
                                   'shared' => 'true'
                                 },
                       'mhpmcounter6h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'mitctl0' => {
                                      'reset' => '0x1',
                                      'exists' => 'true',
                                      'number' => '0x7d4',
                                      'mask' => '0x00000007'
                                    },
                       'mdccmect' => {
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'number' => '0x7f2',
                                       'mask' => '0xffffffff'
                                     },
                       'micect' => {
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'number' => '0x7f0',
                                     'mask' => '0xffffffff'
                                   },
                       'mhpmevent4' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'mitbnd0' => {
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d3',
                                      'exists' => 'true',
                                      'reset' => '0xffffffff'
                                    },
                       'dicad1' => {
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.',
                                     'mask' => '0x3',
                                     'number' => '0x7ca',
                                     'debug' => 'true'
                                   },
                       'mhpmevent3' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'mhartid' => {
                                      'mask' => '0x0',
                                      'exists' => 'true',
                                      'poke_mask' => '0xfffffff0',
                                      'reset' => '0x0'
                                    },
                       'miccmect' => {
                                       'number' => '0x7f1',
                                       'mask' => '0xffffffff',
                                       'reset' => '0x0',
                                       'exists' => 'true'
                                     },
                       'mhartstart' => {
                                         'exists' => 'true',
                                         'comment' => 'Hart start mask',
                                         'number' => '0x7fc',
                                         'mask' => '0x2',
                                         'reset' => '0x1',
                                         'shared' => 'true'
                                       },
                       'mcpc' => {
                                   'mask' => '0x0',
                                   'number' => '0x7c2',
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'comment' => 'Core pause'
                                 },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'meicidpl' => {
                                       'number' => '0xbcb',
                                       'mask' => '0xf',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'reset' => '0x0',
                                       'exists' => 'true'
                                     },
                       'mip' => {
                                  'reset' => '0x0',
                                  'poke_mask' => '0x70000888',
                                  'exists' => 'true',
                                  'mask' => '0x0'
                                },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'mitcnt0' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'number' => '0x7d2',
                                      'mask' => '0xffffffff'
                                    },
                       'mhpmcounter5h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'dicawics' => {
                                       'debug' => 'true',
                                       'mask' => '0x0130fffc',
                                       'number' => '0x7c8',
                                       'reset' => '0x0',
                                       'comment' => 'Cache diagnostics.',
                                       'exists' => 'true'
                                     },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter3' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmevent5' => {
                                         'mask' => '0xffffffff',
                                         'exists' => 'true',
                                         'reset' => '0x0'
                                       },
                       'mnmipdel' => {
                                       'exists' => 'true',
                                       'comment' => 'NMI pin delegation',
                                       'number' => '0x7fe',
                                       'mask' => '0x3',
                                       'reset' => '0x1',
                                       'shared' => 'true'
                                     },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mhartnum' => {
                                       'number' => '0xfc4',
                                       'mask' => '0x0',
                                       'comment' => 'Hart count',
                                       'exists' => 'true',
                                       'shared' => 'true',
                                       'reset' => '0x2'
                                     }
                     },
            'btb' => {
                       'btb_num_bypass_width' => 4,
                       'btb_index2_hi' => 16,
                       'btb_index3_lo' => 17,
                       'btb_btag_size' => 5,
                       'btb_addr_lo' => '3',
                       'btb_size' => 512,
                       'btb_index1_hi' => 9,
                       'btb_use_sram' => '0',
                       'btb_toffset_size' => '12',
                       'btb_array_depth' => 128,
                       'btb_addr_hi' => 9,
                       'btb_fold2_index_hash' => 0,
                       'btb_index2_lo' => 10,
                       'btb_index3_hi' => 23,
                       'btb_num_bypass' => '8',
                       'btb_bypass_enable' => '1',
                       'btb_btag_fold' => 0,
                       'btb_index1_lo' => '3'
                     },
            'nmi_vec' => '0x11110000',
            'even_odd_trigger_chains' => 'true',
            'protection' => {
                              'data_access_mask6' => '0xffffffff',
                              'inst_access_enable5' => '0x0',
                              'data_access_mask4' => '0xffffffff',
                              'inst_access_mask6' => '0xffffffff',
                              'data_access_enable5' => '0x0',
                              'inst_access_mask4' => '0xffffffff',
                              'inst_access_enable3' => '1',
                              'inst_access_enable1' => '1',
                              'inst_access_enable4' => '0x0',
                              'inst_access_addr3' => '0x80000000',
                              'inst_access_addr1' => '0xc0000000',
                              'data_access_enable3' => '1',
                              'data_access_enable1' => '1',
                              'data_access_enable4' => '0x0',
                              'data_access_addr3' => '0x80000000',
                              'data_access_addr1' => '0xc0000000',
                              'data_access_mask2' => '0x1fffffff',
                              'data_access_enable0' => '1',
                              'data_access_mask5' => '0xffffffff',
                              'inst_access_mask2' => '0x1fffffff',
                              'inst_access_enable0' => '1',
                              'inst_access_mask5' => '0xffffffff',
                              'inst_access_addr0' => '0x0',
                              'data_access_addr7' => '0x00000000',
                              'data_access_addr0' => '0x0',
                              'inst_access_addr7' => '0x00000000',
                              'data_access_enable6' => '0x0',
                              'data_access_enable7' => '0x0',
                              'inst_access_mask7' => '0xffffffff',
                              'data_access_mask0' => '0x7fffffff',
                              'inst_access_enable7' => '0x0',
                              'inst_access_enable6' => '0x0',
                              'data_access_mask7' => '0xffffffff',
                              'inst_access_mask0' => '0x7fffffff',
                              'inst_access_addr5' => '0x00000000',
                              'inst_access_addr2' => '0xa0000000',
                              'data_access_addr5' => '0x00000000',
                              'data_access_addr2' => '0xa0000000',
                              'data_access_mask1' => '0x3fffffff',
                              'data_access_mask3' => '0x0fffffff',
                              'inst_access_mask1' => '0x3fffffff',
                              'inst_access_mask3' => '0x0fffffff',
                              'inst_access_addr4' => '0x00000000',
                              'inst_access_enable2' => '1',
                              'inst_access_addr6' => '0x00000000',
                              'data_access_addr4' => '0x00000000',
                              'data_access_enable2' => '1',
                              'data_access_addr6' => '0x00000000'
                            },
            'triggers' => [
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
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
                          ]
          );
1;
