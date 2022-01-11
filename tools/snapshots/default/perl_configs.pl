#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by bscuser on Sat Nov  6 13:41:57 CET 2021
# 
#  cmd:    swerv -target=default -set=build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'triggers' => [
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'mask' => [
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
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'poke_mask' => [
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
                              'mask' => [
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
            'reset_vec' => '0x80000000',
            'config_key' => '32\'hdeadbeef',
            'btb' => {
                       'btb_index3_hi' => 23,
                       'btb_bypass_enable' => '1',
                       'btb_index3_lo' => 17,
                       'btb_num_bypass_width' => 4,
                       'btb_index1_lo' => '3',
                       'btb_toffset_size' => '12',
                       'btb_index2_hi' => 16,
                       'btb_index1_hi' => 9,
                       'btb_addr_lo' => '3',
                       'btb_index2_lo' => 10,
                       'btb_btag_size' => 5,
                       'btb_fold2_index_hash' => 0,
                       'btb_num_bypass' => '8',
                       'btb_btag_fold' => 0,
                       'btb_addr_hi' => 9,
                       'btb_array_depth' => 128,
                       'btb_use_sram' => '0',
                       'btb_size' => 512
                     },
            'harts' => 1,
            'nmi_vec' => '0x11110000',
            'even_odd_trigger_chains' => 'true',
            'pic' => {
                       'pic_meitp_count' => 4,
                       'pic_offset' => '0xc0000',
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_int_words' => 4,
                       'pic_mpiccfg_count' => 1,
                       'pic_meitp_mask' => '0x0',
                       'pic_total_int_plus1' => 128,
                       'pic_meip_count' => 4,
                       'pic_meidels_count' => 127,
                       'pic_meidels_mask' => '0x1',
                       'pic_region' => '0xf',
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_meipl_mask' => '0xf',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meie_offset' => '0x2000',
                       'pic_meie_mask' => '0x1',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_bits' => 15,
                       'pic_meipl_count' => 127,
                       'pic_base_addr' => '0xf00c0000',
                       'pic_meigwclr_mask' => '0x0',
                       'pic_meitp_offset' => '0x1800',
                       'pic_size' => 32,
                       'pic_meie_count' => 127,
                       'pic_meip_offset' => '0x1000',
                       'pic_meip_mask' => '0x0',
                       'pic_total_int' => 127,
                       'pic_2cycle' => '1',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_meigwclr_count' => 127,
                       'pic_meipl_offset' => '0x0000',
                       'pic_meigwctrl_count' => 127
                     },
            'icache' => {
                          'icache_data_width' => 64,
                          'icache_status_bits' => 3,
                          'icache_bank_lo' => 3,
                          'icache_tag_num_bypass_width' => 2,
                          'icache_tag_num_bypass' => '2',
                          'icache_enable' => 1,
                          'icache_num_beats' => 8,
                          'icache_tag_index_lo' => '6',
                          'icache_waypack' => '1',
                          'icache_beat_addr_hi' => 5,
                          'icache_ln_sz' => 64,
                          'icache_tag_depth' => 128,
                          'icache_ecc' => '1',
                          'icache_num_bypass_width' => 3,
                          'icache_beat_bits' => 3,
                          'icache_num_lines_way' => '128',
                          'icache_num_bypass' => '4',
                          'icache_index_hi' => 12,
                          'icache_num_lines_bank' => '64',
                          'icache_scnd_last' => 6,
                          'icache_bank_width' => 8,
                          'icache_bank_hi' => 3,
                          'icache_size' => 32,
                          'icache_banks_way' => 2,
                          'icache_data_index_lo' => 4,
                          'icache_data_cell' => 'ram_512x71',
                          'icache_tag_lo' => 13,
                          'icache_data_depth' => '512',
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_tag_bypass_enable' => '1',
                          'icache_2banks' => '1',
                          'icache_fdata_width' => 71,
                          'icache_bank_bits' => 1,
                          'icache_num_ways' => 4,
                          'icache_num_lines' => 512,
                          'icache_bypass_enable' => '1'
                        },
            'xlen' => 32,
            'target_default' => '1',
            'num_mmode_perf_regs' => '4',
            'iccm' => {
                        'iccm_num_banks_4' => '',
                        'iccm_data_cell' => 'ram_4096x39',
                        'iccm_offset' => '0xe000000',
                        'iccm_enable' => 1,
                        'iccm_bits' => 16,
                        'iccm_sadr' => '0xee000000',
                        'iccm_size' => 64,
                        'iccm_bank_index_lo' => 4,
                        'iccm_region' => '0xe',
                        'iccm_size_64' => '',
                        'iccm_bank_bits' => 2,
                        'iccm_reserved' => '0x1000',
                        'iccm_index_bits' => 12,
                        'iccm_bank_hi' => 3,
                        'iccm_num_banks' => '4',
                        'iccm_eadr' => '0xee00ffff',
                        'iccm_rows' => '4096'
                      },
            'dccm' => {
                        'dccm_offset' => '0x40000',
                        'dccm_size' => 64,
                        'dccm_bits' => 16,
                        'dccm_sadr' => '0xf0040000',
                        'dccm_enable' => 1,
                        'dccm_data_cell' => 'ram_2048x39',
                        'dccm_num_banks' => '8',
                        'dccm_width_bits' => 2,
                        'lsu_sb_bits' => 16,
                        'dccm_rows' => '2048',
                        'dccm_eadr' => '0xf004ffff',
                        'dccm_byte_width' => '4',
                        'dccm_fdata_width' => 39,
                        'dccm_ecc_width' => 7,
                        'dccm_num_banks_8' => '',
                        'dccm_index_bits' => 11,
                        'dccm_reserved' => '0x2004',
                        'dccm_bank_bits' => 3,
                        'dccm_data_width' => 32,
                        'dccm_size_64' => '',
                        'dccm_region' => '0xf'
                      },
            'regwidth' => '32',
            'core' => {
                        'dma_buf_depth' => '5',
                        'fast_interrupt_redirect' => '1',
                        'bitmanip_zba' => 1,
                        'lsu_stbuf_depth' => '10',
                        'bitmanip_zbs' => 1,
                        'bitmanip_zbc' => 1,
                        'bitmanip_zbb' => 1,
                        'iccm_icache' => 1,
                        'lsu_num_nbload' => '8',
                        'div_bit' => '4',
                        'timer_legal_en' => '1',
                        'lsu_num_nbload_width' => '3',
                        'atomic_enable' => '1',
                        'iccm_only' => 'derived',
                        'bitmanip_zbr' => 0,
                        'bitmanip_zbe' => 0,
                        'bitmanip_zbp' => 0,
                        'num_threads' => 1,
                        'fpga_optimize' => 1,
                        'icache_only' => 'derived',
                        'div_new' => 1,
                        'no_iccm_no_icache' => 'derived',
                        'bitmanip_zbf' => 0
                      },
            'max_mmode_perf_event' => '516',
            'bus' => {
                       'sb_bus_id' => '1',
                       'lsu_bus_tag' => '4',
                       'lsu_bus_id' => '1',
                       'sb_bus_prty' => '2',
                       'dma_bus_prty' => '2',
                       'ifu_bus_prty' => '2',
                       'dma_bus_tag' => '1',
                       'ifu_bus_tag' => '4',
                       'bus_prty_default' => '3',
                       'ifu_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'lsu_bus_prty' => '2',
                       'sb_bus_tag' => '1'
                     },
            'testbench' => {
                             'RV_TOP' => '`TOP.rvtop',
                             'SDVT_AHB' => '1',
                             'sterr_rollback' => '0',
                             'clock_period' => '100',
                             'assert_on' => '',
                             'build_axi_native' => 1,
                             'ext_datawidth' => '64',
                             'TOP' => 'tb_top',
                             'datawidth' => '64',
                             'build_axi4' => 1,
                             'ext_addrwidth' => '32',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'lderr_rollback' => '1'
                           },
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'numiregs' => '32',
            'memmap' => {
                          'external_mem_hole' => '0x90000000',
                          'unused_region5' => '0x20000000',
                          'external_data' => '0xc0580000',
                          'unused_region3' => '0x40000000',
                          'unused_region1' => '0x60000000',
                          'external_data_1' => '0xb0000000',
                          'consoleio' => '0xd0580000',
                          'serialio' => '0xd0580000',
                          'unused_region6' => '0x10000000',
                          'debug_sb_mem' => '0xa0580000',
                          'unused_region2' => '0x50000000',
                          'unused_region7' => '0x00000000',
                          'unused_region4' => '0x30000000',
                          'unused_region0' => '0x70000000'
                        },
            'csr' => {
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'dicad1' => {
                                     'debug' => 'true',
                                     'reset' => '0x0',
                                     'mask' => '0x3',
                                     'number' => '0x7ca',
                                     'comment' => 'Cache diagnostics.',
                                     'exists' => 'true'
                                   },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'mitbnd1' => {
                                      'reset' => '0xffffffff',
                                      'number' => '0x7d6',
                                      'mask' => '0xffffffff',
                                      'exists' => 'true'
                                    },
                       'mfdhs' => {
                                    'number' => '0x7cf',
                                    'mask' => '0x00000003',
                                    'reset' => '0x0',
                                    'exists' => 'true',
                                    'comment' => 'Force Debug Halt Status'
                                  },
                       'mitcnt0' => {
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d2'
                                    },
                       'meicurpl' => {
                                       'exists' => 'true',
                                       'comment' => 'External interrupt current priority level.',
                                       'number' => '0xbcc',
                                       'mask' => '0xf',
                                       'reset' => '0x0'
                                     },
                       'meicidpl' => {
                                       'number' => '0xbcb',
                                       'mask' => '0xf',
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'comment' => 'External interrupt claim id priority level.'
                                     },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'mvendorid' => {
                                        'exists' => 'true',
                                        'reset' => '0x45',
                                        'mask' => '0x0'
                                      },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'mpmc' => {
                                   'mask' => '0x2',
                                   'number' => '0x7c6',
                                   'reset' => '0x2',
                                   'exists' => 'true'
                                 },
                       'micect' => {
                                     'number' => '0x7f0',
                                     'mask' => '0xffffffff',
                                     'reset' => '0x0',
                                     'exists' => 'true'
                                   },
                       'mhartstart' => {
                                         'exists' => 'true',
                                         'comment' => 'Hart start mask',
                                         'shared' => 'true',
                                         'mask' => '0x0',
                                         'number' => '0x7fc',
                                         'reset' => '0x1'
                                       },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'mhpmevent4' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mip' => {
                                  'reset' => '0x0',
                                  'mask' => '0x0',
                                  'poke_mask' => '0x70000888',
                                  'exists' => 'true'
                                },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'mitctl0' => {
                                      'exists' => 'true',
                                      'number' => '0x7d4',
                                      'mask' => '0x00000007',
                                      'reset' => '0x1'
                                    },
                       'mfdht' => {
                                    'mask' => '0x0000003f',
                                    'exists' => 'true',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'shared' => 'true',
                                    'number' => '0x7ce',
                                    'reset' => '0x0'
                                  },
                       'mhpmcounter4h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'marchid' => {
                                      'reset' => '0x00000011',
                                      'mask' => '0x0',
                                      'exists' => 'true'
                                    },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'reset' => '0x3',
                                     'mask' => '0x0'
                                   },
                       'mhartnum' => {
                                       'reset' => '0x1',
                                       'number' => '0xfc4',
                                       'comment' => 'Hart count',
                                       'shared' => 'true',
                                       'exists' => 'true',
                                       'mask' => '0x0'
                                     },
                       'mhpmcounter4' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mcpc' => {
                                   'exists' => 'true',
                                   'comment' => 'Core pause',
                                   'number' => '0x7c2',
                                   'mask' => '0x0',
                                   'reset' => '0x0'
                                 },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'mrac' => {
                                   'comment' => 'Memory region io and cache control.',
                                   'shared' => 'true',
                                   'exists' => 'true',
                                   'mask' => '0xffffffff',
                                   'reset' => '0x0',
                                   'number' => '0x7c0'
                                 },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'misa' => {
                                   'exists' => 'true',
                                   'reset' => '0x40001105',
                                   'mask' => '0x0'
                                 },
                       'mcgc' => {
                                   'shared' => 'true',
                                   'exists' => 'true',
                                   'mask' => '0x000003ff',
                                   'poke_mask' => '0x000003ff',
                                   'reset' => '0x200',
                                   'number' => '0x7f8'
                                 },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'dicad0' => {
                                     'debug' => 'true',
                                     'reset' => '0x0',
                                     'mask' => '0xffffffff',
                                     'number' => '0x7c9',
                                     'comment' => 'Cache diagnostics.',
                                     'exists' => 'true'
                                   },
                       'dmst' => {
                                   'exists' => 'true',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'mask' => '0x0',
                                   'number' => '0x7c4',
                                   'debug' => 'true',
                                   'reset' => '0x0'
                                 },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mhpmcounter5' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'mhartid' => {
                                      'poke_mask' => '0xfffffff0',
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0x0'
                                    },
                       'mdccmect' => {
                                       'mask' => '0xffffffff',
                                       'number' => '0x7f2',
                                       'reset' => '0x0',
                                       'exists' => 'true'
                                     },
                       'dicago' => {
                                     'number' => '0x7cb',
                                     'mask' => '0x0',
                                     'reset' => '0x0',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'comment' => 'Cache diagnostics.'
                                   },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent3' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'mitcnt1' => {
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff',
                                      'number' => '0x7d5',
                                      'exists' => 'true'
                                    },
                       'mie' => {
                                  'exists' => 'true',
                                  'mask' => '0x70000888',
                                  'reset' => '0x0'
                                },
                       'mitbnd0' => {
                                      'number' => '0x7d3',
                                      'mask' => '0xffffffff',
                                      'reset' => '0xffffffff',
                                      'exists' => 'true'
                                    },
                       'mhpmcounter5h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'mhpmcounter6' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'mstatus' => {
                                      'reset' => '0x1800',
                                      'mask' => '0x88',
                                      'exists' => 'true'
                                    },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'dcsr' => {
                                   'reset' => '0x40000003',
                                   'debug' => 'true',
                                   'mask' => '0x00008c04',
                                   'poke_mask' => '0x00008dcc',
                                   'exists' => 'true'
                                 },
                       'mcountinhibit' => {
                                            'exists' => 'true',
                                            'poke_mask' => '0x7d',
                                            'mask' => '0x7d',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.',
                                            'reset' => '0x0'
                                          },
                       'tselect' => {
                                      'exists' => 'true',
                                      'mask' => '0x3',
                                      'reset' => '0x0'
                                    },
                       'mhpmevent6' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'dicawics' => {
                                       'mask' => '0x0130fffc',
                                       'number' => '0x7c8',
                                       'debug' => 'true',
                                       'reset' => '0x0',
                                       'exists' => 'true',
                                       'comment' => 'Cache diagnostics.'
                                     },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter3h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter6h' => {
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0',
                                            'exists' => 'true'
                                          },
                       'miccmect' => {
                                       'mask' => '0xffffffff',
                                       'number' => '0x7f1',
                                       'reset' => '0x0',
                                       'exists' => 'true'
                                     },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'mnmipdel' => {
                                       'number' => '0x7fe',
                                       'reset' => '0x1',
                                       'exists' => 'true',
                                       'shared' => 'true',
                                       'comment' => 'NMI pin delegation',
                                       'mask' => '0x1'
                                     },
                       'meipt' => {
                                    'reset' => '0x0',
                                    'mask' => '0xf',
                                    'number' => '0xbc9',
                                    'comment' => 'External interrupt priority threshold.',
                                    'exists' => 'true'
                                  },
                       'mitctl1' => {
                                      'exists' => 'true',
                                      'reset' => '0x1',
                                      'mask' => '0x0000000f',
                                      'number' => '0x7d7'
                                    },
                       'mscause' => {
                                      'exists' => 'true',
                                      'mask' => '0x0000000f',
                                      'number' => '0x7ff',
                                      'reset' => '0x0'
                                    },
                       'mhpmcounter3' => {
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff',
                                           'exists' => 'true'
                                         },
                       'mfdc' => {
                                   'mask' => '0x00071f4d',
                                   'number' => '0x7f9',
                                   'reset' => '0x00070040',
                                   'exists' => 'true',
                                   'shared' => 'true'
                                 },
                       'mhpmevent5' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       }
                     },
            'bht' => {
                       'bht_ghr_pad' => 'fghr[2:0],3\'b0',
                       'bht_hash_string' => 0,
                       'bht_ghr_pad2' => 'fghr[3:0],2\'b0',
                       'bht_ghr_hash_1' => '',
                       'bht_addr_hi' => 9,
                       'bht_ghr_range' => '6:0',
                       'bht_array_depth' => 128,
                       'bht_size' => 512,
                       'bht_ghr_size' => 7,
                       'bht_addr_lo' => '3'
                     },
            'tec_rv_icg' => 'clockhdr',
            'protection' => {
                              'data_access_mask2' => '0x1fffffff',
                              'inst_access_addr2' => '0xa0000000',
                              'inst_access_addr4' => '0x00000000',
                              'data_access_mask5' => '0xffffffff',
                              'data_access_enable7' => '0x0',
                              'data_access_enable2' => '1',
                              'inst_access_addr5' => '0x00000000',
                              'data_access_mask4' => '0xffffffff',
                              'inst_access_enable6' => '0x0',
                              'data_access_addr0' => '0x0',
                              'data_access_enable1' => '1',
                              'inst_access_enable5' => '0x0',
                              'data_access_enable3' => '1',
                              'inst_access_mask0' => '0x7fffffff',
                              'inst_access_enable4' => '0x0',
                              'inst_access_mask1' => '0x3fffffff',
                              'inst_access_mask7' => '0xffffffff',
                              'inst_access_mask6' => '0xffffffff',
                              'data_access_enable0' => '1',
                              'inst_access_addr3' => '0x80000000',
                              'data_access_addr7' => '0x00000000',
                              'data_access_addr6' => '0x00000000',
                              'data_access_addr1' => '0xc0000000',
                              'data_access_mask3' => '0x0fffffff',
                              'data_access_enable5' => '0x0',
                              'data_access_mask0' => '0x7fffffff',
                              'inst_access_enable3' => '1',
                              'data_access_enable6' => '0x0',
                              'inst_access_enable1' => '1',
                              'inst_access_addr0' => '0x0',
                              'inst_access_addr1' => '0xc0000000',
                              'inst_access_addr7' => '0x00000000',
                              'inst_access_addr6' => '0x00000000',
                              'inst_access_mask3' => '0x0fffffff',
                              'data_access_mask6' => '0xffffffff',
                              'data_access_mask7' => '0xffffffff',
                              'data_access_mask1' => '0x3fffffff',
                              'data_access_enable4' => '0x0',
                              'inst_access_enable0' => '1',
                              'data_access_addr3' => '0x80000000',
                              'data_access_addr2' => '0xa0000000',
                              'inst_access_mask2' => '0x1fffffff',
                              'inst_access_enable2' => '1',
                              'inst_access_enable7' => '0x0',
                              'inst_access_mask4' => '0xffffffff',
                              'data_access_addr5' => '0x00000000',
                              'inst_access_mask5' => '0xffffffff',
                              'data_access_addr4' => '0x00000000'
                            },
            'physical' => '1',
            'target' => 'default',
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
                             ]
          );
1;
