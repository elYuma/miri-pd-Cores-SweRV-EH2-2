#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by bscuser on Sat Jan 15 17:31:10 CET 2022
# 
#  cmd:    swerv -target=default -set=build_axi4 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'bus' => {
                       'lsu_bus_tag' => '4',
                       'sb_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'dma_bus_tag' => '1',
                       'lsu_bus_id' => '1',
                       'ifu_bus_prty' => '2',
                       'ifu_bus_tag' => '4',
                       'bus_prty_default' => '3',
                       'sb_bus_tag' => '1',
                       'dma_bus_prty' => '2',
                       'ifu_bus_id' => '1',
                       'lsu_bus_prty' => '2',
                       'sb_bus_prty' => '2'
                     },
            'xlen' => 32,
            'harts' => 1,
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
            'btb' => {
                       'btb_size' => 512,
                       'btb_use_sram' => '0',
                       'btb_num_bypass_width' => 4,
                       'btb_index2_hi' => 16,
                       'btb_index2_lo' => 10,
                       'btb_fold2_index_hash' => 0,
                       'btb_addr_hi' => 9,
                       'btb_addr_lo' => '3',
                       'btb_toffset_size' => '12',
                       'btb_index1_lo' => '3',
                       'btb_bypass_enable' => '1',
                       'btb_num_bypass' => '8',
                       'btb_array_depth' => 128,
                       'btb_index1_hi' => 9,
                       'btb_index3_lo' => 17,
                       'btb_btag_size' => 5,
                       'btb_index3_hi' => 23,
                       'btb_btag_fold' => 0
                     },
            'numiregs' => '32',
            'even_odd_trigger_chains' => 'true',
            'dccm' => {
                        'dccm_index_bits' => 11,
                        'dccm_width_bits' => 2,
                        'dccm_num_banks' => '8',
                        'dccm_fdata_width' => 39,
                        'dccm_size_64' => '',
                        'dccm_eadr' => '0xf004ffff',
                        'dccm_num_banks_8' => '',
                        'dccm_enable' => 1,
                        'dccm_data_width' => 32,
                        'dccm_region' => '0xf',
                        'dccm_reserved' => '0x2004',
                        'dccm_size' => 64,
                        'dccm_data_cell' => 'ram_2048x39',
                        'dccm_bank_bits' => 3,
                        'dccm_byte_width' => '4',
                        'dccm_sadr' => '0xf0040000',
                        'dccm_rows' => '2048',
                        'dccm_ecc_width' => 7,
                        'dccm_bits' => 16,
                        'dccm_offset' => '0x40000',
                        'lsu_sb_bits' => 16
                      },
            'protection' => {
                              'inst_access_enable6' => '0x0',
                              'inst_access_enable7' => '0x0',
                              'inst_access_mask5' => '0xffffffff',
                              'inst_access_mask4' => '0xffffffff',
                              'data_access_mask7' => '0xffffffff',
                              'inst_access_addr1' => '0xc0000000',
                              'inst_access_addr6' => '0x00000000',
                              'inst_access_enable2' => '1',
                              'inst_access_mask2' => '0x1fffffff',
                              'data_access_addr0' => '0x0',
                              'data_access_mask3' => '0x0fffffff',
                              'data_access_enable2' => '1',
                              'data_access_addr6' => '0x00000000',
                              'inst_access_mask7' => '0xffffffff',
                              'data_access_addr1' => '0xc0000000',
                              'inst_access_addr0' => '0x0',
                              'inst_access_mask3' => '0x0fffffff',
                              'data_access_mask2' => '0x1fffffff',
                              'data_access_mask5' => '0xffffffff',
                              'data_access_mask4' => '0xffffffff',
                              'data_access_enable6' => '0x0',
                              'data_access_enable7' => '0x0',
                              'inst_access_enable3' => '1',
                              'data_access_addr5' => '0x00000000',
                              'data_access_addr4' => '0x00000000',
                              'data_access_mask6' => '0xffffffff',
                              'inst_access_enable1' => '1',
                              'inst_access_enable0' => '1',
                              'inst_access_addr7' => '0x00000000',
                              'inst_access_enable4' => '0x0',
                              'inst_access_enable5' => '0x0',
                              'data_access_mask1' => '0x3fffffff',
                              'inst_access_mask0' => '0x7fffffff',
                              'inst_access_addr3' => '0x80000000',
                              'data_access_addr2' => '0xa0000000',
                              'data_access_addr7' => '0x00000000',
                              'data_access_enable4' => '0x0',
                              'inst_access_mask1' => '0x3fffffff',
                              'data_access_enable5' => '0x0',
                              'inst_access_mask6' => '0xffffffff',
                              'data_access_enable1' => '1',
                              'data_access_enable0' => '1',
                              'inst_access_addr2' => '0xa0000000',
                              'data_access_mask0' => '0x7fffffff',
                              'data_access_addr3' => '0x80000000',
                              'data_access_enable3' => '1',
                              'inst_access_addr5' => '0x00000000',
                              'inst_access_addr4' => '0x00000000'
                            },
            'retstack' => {
                            'ret_stack_size' => '4'
                          },
            'tec_rv_icg' => 'clockhdr',
            'target_default' => '1',
            'max_mmode_perf_event' => '516',
            'nmi_vec' => '0x11110000',
            'reset_vec' => '0x80000000',
            'iccm' => {
                        'iccm_enable' => 1,
                        'iccm_bank_index_lo' => 4,
                        'iccm_region' => '0xe',
                        'iccm_size_64' => '',
                        'iccm_eadr' => '0xee00ffff',
                        'iccm_num_banks' => '4',
                        'iccm_index_bits' => 12,
                        'iccm_num_banks_4' => '',
                        'iccm_bits' => 16,
                        'iccm_bank_hi' => 3,
                        'iccm_rows' => '4096',
                        'iccm_offset' => '0xe000000',
                        'iccm_size' => 64,
                        'iccm_reserved' => '0x1000',
                        'iccm_sadr' => '0xee000000',
                        'iccm_bank_bits' => 2,
                        'iccm_data_cell' => 'ram_4096x39'
                      },
            'icache' => {
                          'icache_tag_index_lo' => '6',
                          'icache_2banks' => '1',
                          'icache_tag_bypass_enable' => '1',
                          'icache_ecc' => '1',
                          'icache_num_lines_bank' => '64',
                          'icache_size' => 32,
                          'icache_bank_hi' => 3,
                          'icache_tag_num_bypass_width' => 2,
                          'icache_num_lines_way' => '128',
                          'icache_data_index_lo' => 4,
                          'icache_bypass_enable' => '1',
                          'icache_num_beats' => 8,
                          'icache_num_bypass' => '4',
                          'icache_ln_sz' => 64,
                          'icache_bank_lo' => 3,
                          'icache_waypack' => '1',
                          'icache_enable' => 1,
                          'icache_data_width' => 64,
                          'icache_num_bypass_width' => 3,
                          'icache_bank_bits' => 1,
                          'icache_data_cell' => 'ram_512x71',
                          'icache_beat_bits' => 3,
                          'icache_index_hi' => 12,
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_num_lines' => 512,
                          'icache_scnd_last' => 6,
                          'icache_bank_width' => 8,
                          'icache_tag_lo' => 13,
                          'icache_banks_way' => 2,
                          'icache_tag_num_bypass' => '2',
                          'icache_beat_addr_hi' => 5,
                          'icache_data_depth' => '512',
                          'icache_tag_depth' => 128,
                          'icache_status_bits' => 3,
                          'icache_num_ways' => 4,
                          'icache_fdata_width' => 71
                        },
            'csr' => {
                       'mscause' => {
                                      'mask' => '0x0000000f',
                                      'reset' => '0x0',
                                      'number' => '0x7ff',
                                      'exists' => 'true'
                                    },
                       'misa' => {
                                   'exists' => 'true',
                                   'mask' => '0x0',
                                   'reset' => '0x40001105'
                                 },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'mitcnt0' => {
                                      'number' => '0x7d2',
                                      'mask' => '0xffffffff',
                                      'reset' => '0x0',
                                      'exists' => 'true'
                                    },
                       'mhpmcounter6' => {
                                           'mask' => '0xffffffff',
                                           'reset' => '0x0',
                                           'exists' => 'true'
                                         },
                       'mip' => {
                                  'poke_mask' => '0x70000888',
                                  'mask' => '0x0',
                                  'reset' => '0x0',
                                  'exists' => 'true'
                                },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'mhpmevent5' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'micect' => {
                                     'mask' => '0xffffffff',
                                     'reset' => '0x0',
                                     'number' => '0x7f0',
                                     'exists' => 'true'
                                   },
                       'mfdhs' => {
                                    'number' => '0x7cf',
                                    'comment' => 'Force Debug Halt Status',
                                    'reset' => '0x0',
                                    'mask' => '0x00000003',
                                    'exists' => 'true'
                                  },
                       'mstatus' => {
                                      'exists' => 'true',
                                      'reset' => '0x1800',
                                      'mask' => '0x88'
                                    },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'mrac' => {
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'number' => '0x7c0',
                                   'shared' => 'true',
                                   'mask' => '0xffffffff',
                                   'comment' => 'Memory region io and cache control.'
                                 },
                       'dicad1' => {
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true',
                                     'mask' => '0x3',
                                     'number' => '0x7ca'
                                   },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'mhartstart' => {
                                         'exists' => 'true',
                                         'reset' => '0x1',
                                         'comment' => 'Hart start mask',
                                         'shared' => 'true',
                                         'mask' => '0x0',
                                         'number' => '0x7fc'
                                       },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'meicidpl' => {
                                       'exists' => 'true',
                                       'number' => '0xbcb',
                                       'reset' => '0x0',
                                       'mask' => '0xf',
                                       'comment' => 'External interrupt claim id priority level.'
                                     },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'tselect' => {
                                      'exists' => 'true',
                                      'reset' => '0x0',
                                      'mask' => '0x3'
                                    },
                       'mcountinhibit' => {
                                            'exists' => 'true',
                                            'reset' => '0x0',
                                            'mask' => '0x7d',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.',
                                            'poke_mask' => '0x7d'
                                          },
                       'mitctl1' => {
                                      'exists' => 'true',
                                      'number' => '0x7d7',
                                      'mask' => '0x0000000f',
                                      'reset' => '0x1'
                                    },
                       'mie' => {
                                  'mask' => '0x70000888',
                                  'reset' => '0x0',
                                  'exists' => 'true'
                                },
                       'meipt' => {
                                    'number' => '0xbc9',
                                    'comment' => 'External interrupt priority threshold.',
                                    'reset' => '0x0',
                                    'mask' => '0xf',
                                    'exists' => 'true'
                                  },
                       'mfdht' => {
                                    'number' => '0x7ce',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'shared' => 'true',
                                    'mask' => '0x0000003f',
                                    'reset' => '0x0',
                                    'exists' => 'true'
                                  },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'marchid' => {
                                      'reset' => '0x00000011',
                                      'mask' => '0x0',
                                      'exists' => 'true'
                                    },
                       'mitbnd0' => {
                                      'number' => '0x7d3',
                                      'mask' => '0xffffffff',
                                      'reset' => '0xffffffff',
                                      'exists' => 'true'
                                    },
                       'meicurpl' => {
                                       'number' => '0xbcc',
                                       'comment' => 'External interrupt current priority level.',
                                       'reset' => '0x0',
                                       'mask' => '0xf',
                                       'exists' => 'true'
                                     },
                       'mhpmcounter6h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'mvendorid' => {
                                        'reset' => '0x45',
                                        'mask' => '0x0',
                                        'exists' => 'true'
                                      },
                       'dcsr' => {
                                   'exists' => 'true',
                                   'poke_mask' => '0x00008dcc',
                                   'debug' => 'true',
                                   'mask' => '0x00008c04',
                                   'reset' => '0x40000003'
                                 },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'mhpmcounter4h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'dicawics' => {
                                       'exists' => 'true',
                                       'reset' => '0x0',
                                       'mask' => '0x0130fffc',
                                       'debug' => 'true',
                                       'comment' => 'Cache diagnostics.',
                                       'number' => '0x7c8'
                                     },
                       'mhpmcounter5' => {
                                           'exists' => 'true',
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff'
                                         },
                       'mdccmect' => {
                                       'exists' => 'true',
                                       'number' => '0x7f2',
                                       'mask' => '0xffffffff',
                                       'reset' => '0x0'
                                     },
                       'mfdc' => {
                                   'exists' => 'true',
                                   'mask' => '0x00071f4d',
                                   'shared' => 'true',
                                   'reset' => '0x00070040',
                                   'number' => '0x7f9'
                                 },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'dicago' => {
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'number' => '0x7cb',
                                     'mask' => '0x0',
                                     'debug' => 'true',
                                     'comment' => 'Cache diagnostics.'
                                   },
                       'mimpid' => {
                                     'exists' => 'true',
                                     'reset' => '0x3',
                                     'mask' => '0x0'
                                   },
                       'mpmc' => {
                                   'exists' => 'true',
                                   'number' => '0x7c6',
                                   'mask' => '0x2',
                                   'reset' => '0x2'
                                 },
                       'dicad0' => {
                                     'exists' => 'true',
                                     'reset' => '0x0',
                                     'number' => '0x7c9',
                                     'debug' => 'true',
                                     'comment' => 'Cache diagnostics.',
                                     'mask' => '0xffffffff'
                                   },
                       'mhartnum' => {
                                       'reset' => '0x1',
                                       'exists' => 'true',
                                       'shared' => 'true',
                                       'mask' => '0x0',
                                       'comment' => 'Hart count',
                                       'number' => '0xfc4'
                                     },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'mask' => '0xffffffff',
                                            'exists' => 'true'
                                          },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'mitcnt1' => {
                                      'number' => '0x7d5',
                                      'mask' => '0xffffffff',
                                      'reset' => '0x0',
                                      'exists' => 'true'
                                    },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'mcpc' => {
                                   'comment' => 'Core pause',
                                   'mask' => '0x0',
                                   'reset' => '0x0',
                                   'number' => '0x7c2',
                                   'exists' => 'true'
                                 },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter5h' => {
                                            'exists' => 'true',
                                            'mask' => '0xffffffff',
                                            'reset' => '0x0'
                                          },
                       'mhpmevent6' => {
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff',
                                         'exists' => 'true'
                                       },
                       'mhpmcounter4' => {
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff',
                                           'exists' => 'true'
                                         },
                       'mitbnd1' => {
                                      'exists' => 'true',
                                      'mask' => '0xffffffff',
                                      'reset' => '0xffffffff',
                                      'number' => '0x7d6'
                                    },
                       'mcgc' => {
                                   'poke_mask' => '0x000003ff',
                                   'number' => '0x7f8',
                                   'shared' => 'true',
                                   'mask' => '0x000003ff',
                                   'reset' => '0x200',
                                   'exists' => 'true'
                                 },
                       'dmst' => {
                                   'exists' => 'true',
                                   'reset' => '0x0',
                                   'mask' => '0x0',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'debug' => 'true',
                                   'number' => '0x7c4'
                                 },
                       'mhpmevent4' => {
                                         'exists' => 'true',
                                         'reset' => '0x0',
                                         'mask' => '0xffffffff'
                                       },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'mhartid' => {
                                      'reset' => '0x0',
                                      'mask' => '0x0',
                                      'poke_mask' => '0xfffffff0',
                                      'exists' => 'true'
                                    },
                       'mnmipdel' => {
                                       'reset' => '0x1',
                                       'exists' => 'true',
                                       'number' => '0x7fe',
                                       'comment' => 'NMI pin delegation',
                                       'shared' => 'true',
                                       'mask' => '0x1'
                                     },
                       'mhpmevent3' => {
                                         'exists' => 'true',
                                         'mask' => '0xffffffff',
                                         'reset' => '0x0'
                                       },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter3' => {
                                           'reset' => '0x0',
                                           'mask' => '0xffffffff',
                                           'exists' => 'true'
                                         },
                       'miccmect' => {
                                       'mask' => '0xffffffff',
                                       'reset' => '0x0',
                                       'number' => '0x7f1',
                                       'exists' => 'true'
                                     },
                       'mitctl0' => {
                                      'exists' => 'true',
                                      'number' => '0x7d4',
                                      'reset' => '0x1',
                                      'mask' => '0x00000007'
                                    }
                     },
            'bht' => {
                       'bht_ghr_range' => '6:0',
                       'bht_ghr_hash_1' => '',
                       'bht_ghr_pad' => 'fghr[2:0],3\'b0',
                       'bht_array_depth' => 128,
                       'bht_ghr_pad2' => 'fghr[3:0],2\'b0',
                       'bht_addr_hi' => 9,
                       'bht_addr_lo' => '3',
                       'bht_hash_string' => 0,
                       'bht_size' => 512,
                       'bht_ghr_size' => 7
                     },
            'num_mmode_perf_regs' => '4',
            'pic' => {
                       'pic_size' => 32,
                       'pic_meipl_offset' => '0x0000',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_total_int' => 127,
                       'pic_meip_mask' => '0x0',
                       'pic_meitp_offset' => '0x1800',
                       'pic_meigwclr_count' => 127,
                       'pic_meidels_count' => 127,
                       'pic_bits' => 15,
                       'pic_meie_mask' => '0x1',
                       'pic_meigwclr_offset' => '0x5000',
                       'pic_meipl_count' => 127,
                       'pic_meigwctrl_count' => 127,
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_total_int_plus1' => 128,
                       'pic_int_words' => 4,
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_meitp_count' => 4,
                       'pic_mpiccfg_count' => 1,
                       'pic_meigwclr_mask' => '0x0',
                       'pic_meipl_mask' => '0xf',
                       'pic_meip_offset' => '0x1000',
                       'pic_meip_count' => 4,
                       'pic_meidels_mask' => '0x1',
                       'pic_meitp_mask' => '0x0',
                       'pic_region' => '0xf',
                       'pic_meie_offset' => '0x2000',
                       'pic_meie_count' => 127,
                       'pic_2cycle' => '1',
                       'pic_base_addr' => '0xf00c0000',
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_offset' => '0xc0000'
                     },
            'target' => 'default',
            'regwidth' => '32',
            'memmap' => {
                          'unused_region7' => '0x00000000',
                          'external_data_1' => '0xb0000000',
                          'unused_region3' => '0x40000000',
                          'unused_region0' => '0x70000000',
                          'consoleio' => '0xd0580000',
                          'unused_region6' => '0x10000000',
                          'unused_region2' => '0x50000000',
                          'unused_region5' => '0x20000000',
                          'external_data' => '0xc0580000',
                          'serialio' => '0xd0580000',
                          'unused_region1' => '0x60000000',
                          'debug_sb_mem' => '0xa0580000',
                          'unused_region4' => '0x30000000',
                          'external_mem_hole' => '0x90000000'
                        },
            'testbench' => {
                             'build_axi4' => 1,
                             'build_axi_native' => 1,
                             'ext_datawidth' => '64',
                             'TOP' => 'tb_top',
                             'sterr_rollback' => '0',
                             'SDVT_AHB' => '1',
                             'assert_on' => '',
                             'RV_TOP' => '`TOP.rvtop',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'datawidth' => '64',
                             'lderr_rollback' => '1',
                             'clock_period' => '100',
                             'ext_addrwidth' => '32'
                           },
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
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
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
            'physical' => '1',
            'config_key' => '32\'hdeadbeef',
            'core' => {
                        'iccm_only' => 'derived',
                        'bitmanip_zbe' => 0,
                        'fpga_optimize' => 1,
                        'bitmanip_zbs' => 1,
                        'bitmanip_zbp' => 0,
                        'lsu_num_nbload' => '8',
                        'iccm_icache' => 1,
                        'dma_buf_depth' => '5',
                        'num_threads' => 1,
                        'timer_legal_en' => '1',
                        'lsu_num_nbload_width' => '3',
                        'div_bit' => '4',
                        'atomic_enable' => '1',
                        'bitmanip_zbb' => 1,
                        'bitmanip_zbf' => 0,
                        'bitmanip_zbr' => 0,
                        'bitmanip_zba' => 1,
                        'icache_only' => 'derived',
                        'lsu_stbuf_depth' => '10',
                        'no_iccm_no_icache' => 'derived',
                        'div_new' => 1,
                        'bitmanip_zbc' => 1,
                        'fast_interrupt_redirect' => '1'
                      }
          );
1;
