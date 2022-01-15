#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by bscuser on Sat Jan 15 08:53:45 CET 2022
# 
#  cmd:    swerv -target=default -set=build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'tec_rv_icg' => 'clockhdr',
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
            'config_key' => '32\'hdeadbeef',
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'dccm' => {
                        'dccm_bank_bits' => 3,
                        'dccm_index_bits' => 11,
                        'dccm_region' => '0xf',
                        'dccm_offset' => '0x40000',
                        'dccm_num_banks' => '8',
                        'dccm_rows' => '2048',
                        'dccm_data_width' => 32,
                        'dccm_ecc_width' => 7,
                        'dccm_enable' => 1,
                        'dccm_size_64' => '',
                        'lsu_sb_bits' => 16,
                        'dccm_bits' => 16,
                        'dccm_eadr' => '0xf004ffff',
                        'dccm_size' => 64,
                        'dccm_data_cell' => 'ram_2048x39',
                        'dccm_byte_width' => '4',
                        'dccm_fdata_width' => 39,
                        'dccm_sadr' => '0xf0040000',
                        'dccm_reserved' => '0x2004',
                        'dccm_width_bits' => 2,
                        'dccm_num_banks_8' => ''
                      },
            'nmi_vec' => '0x11110000',
            'memmap' => {
                          'external_data' => '0xc0580000',
                          'unused_region7' => '0x00000000',
                          'unused_region4' => '0x30000000',
                          'external_mem_hole' => '0x90000000',
                          'unused_region1' => '0x60000000',
                          'serialio' => '0xd0580000',
                          'debug_sb_mem' => '0xa0580000',
                          'unused_region3' => '0x40000000',
                          'unused_region5' => '0x20000000',
                          'consoleio' => '0xd0580000',
                          'unused_region0' => '0x70000000',
                          'external_data_1' => '0xb0000000',
                          'unused_region6' => '0x10000000',
                          'unused_region2' => '0x50000000'
                        },
            'csr' => {
                       'mfdht' => {
                                    'mask' => '0x0000003f',
                                    'shared' => 'true',
                                    'number' => '0x7ce',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'reset' => '0x0',
                                    'exists' => 'true'
                                  },
                       'mitctl1' => {
                                      'number' => '0x7d7',
                                      'reset' => '0x1',
                                      'mask' => '0x0000000f',
                                      'exists' => 'true'
                                    },
                       'meicurpl' => {
                                       'comment' => 'External interrupt current priority level.',
                                       'number' => '0xbcc',
                                       'exists' => 'true',
                                       'mask' => '0xf',
                                       'reset' => '0x0'
                                     },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'mhpmevent3' => {
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0',
                                         'exists' => 'true'
                                       },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'mrac' => {
                                   'comment' => 'Memory region io and cache control.',
                                   'number' => '0x7c0',
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'mask' => '0xffffffff',
                                   'shared' => 'true'
                                 },
                       'mhartstart' => {
                                         'shared' => 'true',
                                         'mask' => '0x0',
                                         'comment' => 'Hart start mask',
                                         'number' => '0x7fc',
                                         'exists' => 'true',
                                         'reset' => '0x1'
                                       },
                       'micect' => {
                                     'number' => '0x7f0',
                                     'reset' => '0x0',
                                     'mask' => '0xffffffff',
                                     'exists' => 'true'
                                   },
                       'dicago' => {
                                     'debug' => 'true',
                                     'mask' => '0x0',
                                     'reset' => '0x0',
                                     'exists' => 'true',
                                     'number' => '0x7cb',
                                     'comment' => 'Cache diagnostics.'
                                   },
                       'mhpmevent6' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'mhpmevent5' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'mfdc' => {
                                   'exists' => 'true',
                                   'reset' => '0x00070040',
                                   'shared' => 'true',
                                   'mask' => '0x00071f4d',
                                   'number' => '0x7f9'
                                 },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'dcsr' => {
                                   'debug' => 'true',
                                   'mask' => '0x00008c04',
                                   'reset' => '0x40000003',
                                   'exists' => 'true',
                                   'poke_mask' => '0x00008dcc'
                                 },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'mhartnum' => {
                                       'comment' => 'Hart count',
                                       'number' => '0xfc4',
                                       'exists' => 'true',
                                       'reset' => '0x1',
                                       'mask' => '0x0',
                                       'shared' => 'true'
                                     },
                       'miccmect' => {
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'mask' => '0xffffffff',
                                       'number' => '0x7f1'
                                     },
                       'mip' => {
                                  'poke_mask' => '0x70000888',
                                  'reset' => '0x0',
                                  'mask' => '0x0',
                                  'exists' => 'true'
                                },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'meipt' => {
                                    'reset' => '0x0',
                                    'mask' => '0xf',
                                    'exists' => 'true',
                                    'number' => '0xbc9',
                                    'comment' => 'External interrupt priority threshold.'
                                  },
                       'mvendorid' => {
                                        'reset' => '0x45',
                                        'mask' => '0x0',
                                        'exists' => 'true'
                                      },
                       'mhpmcounter3' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mhpmcounter4h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'mitcnt0' => {
                                      'number' => '0x7d2',
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff',
                                      'exists' => 'true'
                                    },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'tselect' => {
                                      'exists' => 'true',
                                      'mask' => '0x3',
                                      'reset' => '0x0'
                                    },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'mitbnd1' => {
                                      'number' => '0x7d6',
                                      'exists' => 'true',
                                      'reset' => '0xffffffff',
                                      'mask' => '0xffffffff'
                                    },
                       'mhpmcounter6h' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff'
                                          },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'reset' => '0x3',
                                     'mask' => '0x0'
                                   },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'mstatus' => {
                                      'exists' => 'true',
                                      'reset' => '0x1800',
                                      'mask' => '0x88'
                                    },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'marchid' => {
                                      'mask' => '0x0',
                                      'reset' => '0x00000011',
                                      'exists' => 'true'
                                    },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'dmst' => {
                                   'reset' => '0x0',
                                   'exists' => 'true',
                                   'number' => '0x7c4',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'debug' => 'true',
                                   'mask' => '0x0'
                                 },
                       'mhpmevent4' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'mitbnd0' => {
                                      'number' => '0x7d3',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff',
                                      'reset' => '0xffffffff'
                                    },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mnmipdel' => {
                                       'number' => '0x7fe',
                                       'comment' => 'NMI pin delegation',
                                       'reset' => '0x1',
                                       'exists' => 'true',
                                       'shared' => 'true',
                                       'mask' => '0x1'
                                     },
                       'mie' => {
                                  'reset' => '0x0',
                                  'mask' => '0x70000888',
                                  'exists' => 'true'
                                },
                       'mitcnt1' => {
                                      'number' => '0x7d5',
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0xffffffff'
                                    },
                       'mpmc' => {
                                   'exists' => 'true',
                                   'mask' => '0x2',
                                   'reset' => '0x2',
                                   'number' => '0x7c6'
                                 },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter6' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mscause' => {
                                      'number' => '0x7ff',
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0x0000000f'
                                    },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'mcpc' => {
                                   'number' => '0x7c2',
                                   'comment' => 'Core pause',
                                   'mask' => '0x0',
                                   'reset' => '0x0',
                                   'exists' => 'true'
                                 },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'dicawics' => {
                                       'debug' => 'true',
                                       'mask' => '0x0130fffc',
                                       'comment' => 'Cache diagnostics.',
                                       'number' => '0x7c8',
                                       'exists' => 'true',
                                       'reset' => '0x0'
                                     },
                       'mhpmcounter5h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'dicad1' => {
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7ca',
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'mask' => '0x3',
                                     'debug' => 'true'
                                   },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'mhartid' => {
                                      'poke_mask' => '0xfffffff0',
                                      'reset' => '0x0',
                                      'mask' => '0x0',
                                      'exists' => 'true'
                                    },
                       'mhpmcounter3h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'mfdhs' => {
                                    'reset' => '0x0',
                                    'mask' => '0x00000003',
                                    'exists' => 'true',
                                    'number' => '0x7cf',
                                    'comment' => 'Force Debug Halt Status'
                                  },
                       'mhpmcounter4' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'mitctl0' => {
                                      'number' => '0x7d4',
                                      'reset' => '0x1',
                                      'mask' => '0x00000007',
                                      'exists' => 'true'
                                    },
                       'meicidpl' => {
                                       'number' => '0xbcb',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'reset' => '0x0',
                                       'mask' => '0xf',
                                       'exists' => 'true'
                                     },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'mdccmect' => {
                                       'reset' => '0x0',
                                       'mask' => '0xffffffff',
                                       'exists' => 'true',
                                       'number' => '0x7f2'
                                     },
                       'misa' => {
                                   'exists' => 'true',
                                   'reset' => '0x40001105',
                                   'mask' => '0x0'
                                 },
                       'dicad0' => {
                                     'mask' => '0xffffffff',
                                     'debug' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'number' => '0x7c9',
                                     'exists' => 'true',
                                     'reset' => '0x0'
                                   },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'mcountinhibit' => {
                                            'reset' => '0x0',
                                            'mask' => '0x7d',
                                            'exists' => 'true',
                                            'poke_mask' => '0x7d',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.'
                                          },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mcgc' => {
                                   'number' => '0x7f8',
                                   'poke_mask' => '0x000003ff',
                                   'reset' => '0x200',
                                   'exists' => 'true',
                                   'shared' => 'true',
                                   'mask' => '0x000003ff'
                                 }
                     },
            'target' => 'default',
            'max_mmode_perf_event' => '516',
            'bus' => {
                       'ifu_bus_tag' => '4',
                       'sb_bus_id' => '1',
                       'sb_bus_tag' => '1',
                       'dma_bus_id' => '1',
                       'bus_prty_default' => '3',
                       'lsu_bus_prty' => '2',
                       'ifu_bus_id' => '1',
                       'dma_bus_tag' => '1',
                       'lsu_bus_tag' => '4',
                       'ifu_bus_prty' => '2',
                       'lsu_bus_id' => '1',
                       'dma_bus_prty' => '2',
                       'sb_bus_prty' => '2'
                     },
            'iccm' => {
                        'iccm_num_banks_4' => '',
                        'iccm_bank_hi' => 3,
                        'iccm_sadr' => '0xee000000',
                        'iccm_reserved' => '0x1000',
                        'iccm_size' => 64,
                        'iccm_data_cell' => 'ram_4096x39',
                        'iccm_bits' => 16,
                        'iccm_eadr' => '0xee00ffff',
                        'iccm_rows' => '4096',
                        'iccm_bank_index_lo' => 4,
                        'iccm_size_64' => '',
                        'iccm_enable' => 1,
                        'iccm_region' => '0xe',
                        'iccm_offset' => '0xe000000',
                        'iccm_num_banks' => '4',
                        'iccm_index_bits' => 12,
                        'iccm_bank_bits' => 2
                      },
            'core' => {
                        'bitmanip_zba' => 1,
                        'icache_only' => 'derived',
                        'bitmanip_zbf' => 0,
                        'fpga_optimize' => 1,
                        'iccm_only' => 'derived',
                        'bitmanip_zbp' => 0,
                        'timer_legal_en' => '1',
                        'atomic_enable' => '1',
                        'dma_buf_depth' => '5',
                        'bitmanip_zbb' => 1,
                        'bitmanip_zbr' => 0,
                        'lsu_num_nbload' => '8',
                        'fast_interrupt_redirect' => '1',
                        'no_iccm_no_icache' => 'derived',
                        'div_new' => 1,
                        'lsu_stbuf_depth' => '10',
                        'bitmanip_zbe' => 0,
                        'div_bit' => '4',
                        'num_threads' => 1,
                        'iccm_icache' => 1,
                        'bitmanip_zbs' => 1,
                        'lsu_num_nbload_width' => '3',
                        'bitmanip_zbc' => 1
                      },
            'testbench' => {
                             'clock_period' => '100',
                             'RV_TOP' => '`TOP.rvtop',
                             'lderr_rollback' => '1',
                             'datawidth' => '64',
                             'build_axi4' => 1,
                             'build_axi_native' => 1,
                             'ext_addrwidth' => '32',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'ext_datawidth' => '64',
                             'TOP' => 'tb_top',
                             'SDVT_AHB' => '1',
                             'sterr_rollback' => '0',
                             'assert_on' => ''
                           },
            'reset_vec' => '0x80000000',
            'numiregs' => '32',
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
            'physical' => '1',
            'icache' => {
                          'icache_bank_bits' => 1,
                          'icache_tag_lo' => 13,
                          'icache_enable' => 1,
                          'icache_banks_way' => 2,
                          'icache_beat_addr_hi' => 5,
                          'icache_ln_sz' => 64,
                          'icache_tag_num_bypass_width' => 2,
                          'icache_waypack' => '1',
                          'icache_fdata_width' => 71,
                          'icache_data_index_lo' => 4,
                          'icache_num_ways' => 4,
                          'icache_index_hi' => 12,
                          'icache_tag_depth' => 128,
                          'icache_ecc' => '1',
                          'icache_beat_bits' => 3,
                          'icache_bank_lo' => 3,
                          'icache_num_beats' => 8,
                          'icache_bypass_enable' => '1',
                          'icache_bank_hi' => 3,
                          'icache_num_lines_way' => '128',
                          'icache_data_width' => 64,
                          'icache_data_cell' => 'ram_512x71',
                          'icache_bank_width' => 8,
                          'icache_tag_num_bypass' => '2',
                          'icache_num_bypass' => '4',
                          'icache_tag_index_lo' => '6',
                          'icache_data_depth' => '512',
                          'icache_size' => 32,
                          'icache_tag_bypass_enable' => '1',
                          'icache_scnd_last' => 6,
                          'icache_status_bits' => 3,
                          'icache_num_lines_bank' => '64',
                          'icache_num_bypass_width' => 3,
                          'icache_num_lines' => 512,
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_2banks' => '1'
                        },
            'num_mmode_perf_regs' => '4',
            'harts' => 1,
            'target_default' => '1',
            'pic' => {
                       'pic_meigwctrl_count' => 127,
                       'pic_meigwclr_mask' => '0x0',
                       'pic_meitp_mask' => '0x0',
                       'pic_meitp_offset' => '0x1800',
                       'pic_meidels_count' => 127,
                       'pic_size' => 32,
                       'pic_offset' => '0xc0000',
                       'pic_meipl_count' => 127,
                       'pic_mpiccfg_count' => 1,
                       'pic_2cycle' => '1',
                       'pic_total_int' => 127,
                       'pic_int_words' => 4,
                       'pic_total_int_plus1' => 128,
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_base_addr' => '0xf00c0000',
                       'pic_region' => '0xf',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meidels_mask' => '0x1',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meipl_offset' => '0x0000',
                       'pic_meipl_mask' => '0xf',
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_meip_count' => 4,
                       'pic_meitp_count' => 4,
                       'pic_meie_count' => 127,
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_meie_offset' => '0x2000',
                       'pic_bits' => 15,
                       'pic_meip_offset' => '0x1000',
                       'pic_meigwclr_count' => 127,
                       'pic_meie_mask' => '0x1',
                       'pic_meip_mask' => '0x0'
                     },
            'protection' => {
                              'inst_access_mask4' => '0xffffffff',
                              'data_access_addr4' => '0x00000000',
                              'data_access_enable5' => '0x0',
                              'inst_access_enable7' => '0x0',
                              'inst_access_enable4' => '0x0',
                              'data_access_mask5' => '0xffffffff',
                              'data_access_enable6' => '0x0',
                              'inst_access_addr2' => '0xa0000000',
                              'inst_access_addr5' => '0x00000000',
                              'data_access_enable0' => '1',
                              'data_access_mask2' => '0x1fffffff',
                              'inst_access_enable2' => '1',
                              'inst_access_addr6' => '0x00000000',
                              'data_access_enable3' => '1',
                              'inst_access_addr7' => '0x00000000',
                              'data_access_addr0' => '0x0',
                              'inst_access_mask3' => '0x0fffffff',
                              'data_access_addr1' => '0xc0000000',
                              'data_access_mask7' => '0xffffffff',
                              'data_access_mask6' => '0xffffffff',
                              'inst_access_mask1' => '0x3fffffff',
                              'data_access_addr3' => '0x80000000',
                              'inst_access_mask0' => '0x7fffffff',
                              'data_access_enable1' => '1',
                              'inst_access_enable1' => '1',
                              'inst_access_addr0' => '0x0',
                              'data_access_mask3' => '0x0fffffff',
                              'inst_access_addr1' => '0xc0000000',
                              'data_access_addr6' => '0x00000000',
                              'inst_access_enable3' => '1',
                              'data_access_addr7' => '0x00000000',
                              'data_access_mask1' => '0x3fffffff',
                              'inst_access_addr3' => '0x80000000',
                              'data_access_mask0' => '0x7fffffff',
                              'inst_access_mask7' => '0xffffffff',
                              'inst_access_mask6' => '0xffffffff',
                              'inst_access_enable6' => '0x0',
                              'data_access_addr2' => '0xa0000000',
                              'inst_access_mask5' => '0xffffffff',
                              'inst_access_mask2' => '0x1fffffff',
                              'data_access_enable2' => '1',
                              'data_access_addr5' => '0x00000000',
                              'inst_access_enable0' => '1',
                              'data_access_mask4' => '0xffffffff',
                              'inst_access_enable5' => '0x0',
                              'data_access_enable7' => '0x0',
                              'data_access_enable4' => '0x0',
                              'inst_access_addr4' => '0x00000000'
                            },
            'even_odd_trigger_chains' => 'true',
            'xlen' => 32,
            'bht' => {
                       'bht_array_depth' => 128,
                       'bht_ghr_pad' => 'fghr[2:0],3\'b0',
                       'bht_addr_lo' => '3',
                       'bht_ghr_pad2' => 'fghr[3:0],2\'b0',
                       'bht_size' => 512,
                       'bht_addr_hi' => 9,
                       'bht_ghr_size' => 7,
                       'bht_ghr_range' => '6:0',
                       'bht_ghr_hash_1' => '',
                       'bht_hash_string' => 0
                     },
            'btb' => {
                       'btb_toffset_size' => '12',
                       'btb_index2_lo' => 10,
                       'btb_use_sram' => '0',
                       'btb_bypass_enable' => '1',
                       'btb_btag_fold' => 0,
                       'btb_size' => 512,
                       'btb_addr_hi' => 9,
                       'btb_btag_size' => 5,
                       'btb_index2_hi' => 16,
                       'btb_fold2_index_hash' => 0,
                       'btb_num_bypass_width' => 4,
                       'btb_index3_hi' => 23,
                       'btb_index1_lo' => '3',
                       'btb_num_bypass' => '8',
                       'btb_addr_lo' => '3',
                       'btb_array_depth' => 128,
                       'btb_index1_hi' => 9,
                       'btb_index3_lo' => 17
                     },
            'regwidth' => '32'
          );
1;
