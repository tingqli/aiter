0000000000028a00 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli>:
	s_load_dwordx2 s[20:21], s[0:1], 0x10                      // 000000028A00: C0060500 00000010
	s_waitcnt lgkmcnt(0)                                       // 000000028A08: BF8CC07F
	s_cmp_ge_i32 s2, s21                                       // 000000028A0C: BF031502
	s_cbranch_scc1 732                                         // 000000028A10: BF8502DC <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xb84>
	s_load_dword s12, s[0:1], 0x1c                             // 000000028A14: C0020300 0000001C
	s_load_dwordx4 s[4:7], s[0:1], 0x0                         // 000000028A1C: C00A0100 00000000
	s_load_dwordx4 s[8:11], s[0:1], 0x20                       // 000000028A24: C00A0200 00000020
	s_load_dword s33, s[0:1], 0x30                             // 000000028A2C: C0020840 00000030
	s_load_dword s36, s[0:1], 0x38                             // 000000028A34: C0020900 00000038
	s_waitcnt lgkmcnt(0)                                       // 000000028A3C: BF8CC07F
	s_ashr_i32 s13, s12, 31                                    // 000000028A40: 900D9F0C
	v_lshrrev_b32_e32 v1, 4, v0                                // 000000028A44: 20020084
	v_and_b32_e32 v1, 0xffc0, v1                               // 000000028A48: 260202FF 0000FFC0
	v_and_b32_e32 v0, 0x3ff, v0                                // 000000028A50: 260000FF 000003FF
	s_lshl_b64 s[0:1], s[12:13], 3                             // 000000028A58: 8E80830C
	v_add_u32_e32 v0, v1, v0                                   // 000000028A5C: 68000101
	s_add_u32 s22, s8, s0                                      // 000000028A60: 80160008
	s_mov_b64 s[18:19], s[6:7]                                 // 000000028A64: BE920106
	s_addc_u32 s23, s9, s1                                     // 000000028A68: 82170109
	s_lshl_b32 s14, s20, 1                                     // 000000028A6C: 8E0E8114
	s_mov_b32 s19, 0x20000                                     // 000000028A70: BE9300FF 00020000
	s_lshl_b32 s24, s21, 15                                    // 000000028A78: 8E188F15
	s_lshl_b32 s26, s12, 12                                    // 000000028A7C: 8E1A8C0C
	v_mov_b32_e32 v29, 0                                       // 000000028A80: 7E3A0280
	v_lshlrev_b32_e32 v28, 3, v0                               // 000000028A84: 24380083
	s_mov_b64 s[16:17], s[4:5]                                 // 000000028A88: BE900104
	s_mov_b32 s18, s14                                         // 000000028A8C: BE92000E
	v_lshlrev_b32_e32 v36, 4, v0                               // 000000028A90: 24480084
	s_ashr_i32 s25, s24, 31                                    // 000000028A94: 90199F18
	s_ashr_i32 s20, s21, 31                                    // 000000028A98: 90149F15
	s_mov_b32 s37, s21                                         // 000000028A9C: BEA50015
	s_ashr_i32 s27, s26, 31                                    // 000000028AA0: 901B9F1A
	v_cmp_gt_u32_e64 s[0:1], 8, v0                             // 000000028AA4: D0CC0000 00020088
	v_lshl_add_u64 v[30:31], s[8:9], 0, v[28:29]               // 000000028AAC: D208001E 04710008
	s_lshl_b64 s[28:29], s[12:13], 2                           // 000000028AB4: 8E9C820C
	v_cmp_eq_u32_e64 s[4:5], 0, v0                             // 000000028AB8: D0CA0004 00020080
	s_mov_b32 s12, s6                                          // 000000028AC0: BE8C0006
	s_mov_b32 s13, s7                                          // 000000028AC4: BE8D0007
	s_mov_b32 s15, s19                                         // 000000028AC8: BE8F0013
	v_lshlrev_b32_e32 v28, 4, v0                               // 000000028ACC: 24380084
	v_mov_b32_e32 v45, s33                                     // 000000028AD0: 7E5A0221
	s_branch 32                                                // 000000028AD4: BF820020 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x158>
	s_or_b64 exec, exec, s[6:7]                                // 000000028AD8: 87FE067E
	v_lshl_add_u64 v[32:33], v[34:35], 0, v[28:29]             // 000000028ADC: D2080020 04710122
	v_add_co_u32_e32 v32, vcc, 0x7000, v32                     // 000000028AE4: 324040FF 00007000
	s_waitcnt lgkmcnt(0)                                       // 000000028AEC: BF8CC07F
	s_nop 0                                                    // 000000028AF0: BF800000
	v_addc_co_u32_e32 v33, vcc, 0, v33, vcc                    // 000000028AF4: 38424280
	s_barrier                                                  // 000000028AF8: BF8A0000
	flat_load_dwordx4 v[32:35], v[32:33] nt                    // 000000028AFC: DC5E0000 20000020
	s_add_i32 s2, s2, s36                                      // 000000028B04: 81022402
	s_cmp_lt_i32 s2, s21                                       // 000000028B08: BF041502
	s_waitcnt vmcnt(0)                                         // 000000028B0C: BF8C0F70
	buffer_store_dwordx4 v[0:3], v37, s[12:15], 0 offen        // 000000028B10: E07C1000 80030025
	buffer_store_dwordx4 v[4:7], v38, s[12:15], 0 offen        // 000000028B18: E07C1000 80030426
	buffer_store_dwordx4 v[8:11], v40, s[12:15], 0 offen       // 000000028B20: E07C1000 80030828
	buffer_store_dwordx4 v[12:15], v41, s[12:15], 0 offen      // 000000028B28: E07C1000 80030C29
	buffer_store_dwordx4 v[16:19], v42, s[12:15], 0 offen      // 000000028B30: E07C1000 8003102A
	buffer_store_dwordx4 v[20:23], v43, s[12:15], 0 offen      // 000000028B38: E07C1000 8003142B
	buffer_store_dwordx4 v[24:27], v44, s[12:15], 0 offen      // 000000028B40: E07C1000 8003182C
	s_waitcnt lgkmcnt(0)                                       // 000000028B48: BF8CC07F
	buffer_store_dwordx4 v[32:35], v39, s[12:15], 0 offen      // 000000028B4C: E07C1000 80032027
	s_cbranch_scc0 651                                         // 000000028B54: BF84028B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xb84>
	global_load_dwordx4 v[2:5], v29, s[8:9]                    // 000000028B58: DC5C8000 0208001D
	s_lshl_b32 s3, s2, 15                                      // 000000028B60: 8E038F02
	v_add_u32_e32 v37, s3, v36                                 // 000000028B64: 684A4803
	buffer_load_dwordx4 v[6:9], v37, s[16:19], 0 offen         // 000000028B68: E05C1000 80040625
	s_ashr_i32 s7, s3, 31                                      // 000000028B70: 90079F03
	s_add_u32 s6, s10, s3                                      // 000000028B74: 8006030A
	v_add_u32_e32 v38, 0x1000, v37                             // 000000028B78: 684C4AFF 00001000
	s_addc_u32 s7, s11, s7                                     // 000000028B80: 8207070B
	global_load_dwordx4 v[10:13], v29, s[8:9] offset:16        // 000000028B84: DC5C8010 0A08001D
	global_load_dwordx4 v[20:23], v29, s[8:9] offset:32        // 000000028B8C: DC5C8020 1408001D
	global_load_dwordx4 v[24:27], v29, s[8:9] offset:48        // 000000028B94: DC5C8030 1808001D
	buffer_load_dwordx4 v[32:35], v38, s[16:19], 0 offen       // 000000028B9C: E05C1000 80042026
	v_add_u32_e32 v40, 0x2000, v37                             // 000000028BA4: 68504AFF 00002000
	v_add_u32_e32 v41, 0x3000, v37                             // 000000028BAC: 68524AFF 00003000
	buffer_load_dwordx4 v[46:49], v40, s[16:19], 0 offen       // 000000028BB4: E05C1000 80042E28
	v_add_u32_e32 v44, 0x6000, v37                             // 000000028BBC: 68584AFF 00006000
	v_add_u32_e32 v42, 0x4000, v37                             // 000000028BC4: 68544AFF 00004000
	v_add_u32_e32 v43, 0x5000, v37                             // 000000028BCC: 68564AFF 00005000
	v_add_u32_e32 v39, 0x7000, v37                             // 000000028BD4: 684E4AFF 00007000
	buffer_load_dwordx4 v[50:53], v41, s[16:19], 0 offen       // 000000028BDC: E05C1000 80043229
	buffer_load_dwordx4 v[54:57], v42, s[16:19], 0 offen       // 000000028BE4: E05C1000 8004362A
	buffer_load_dwordx4 v[58:61], v43, s[16:19], 0 offen       // 000000028BEC: E05C1000 80043A2B
	buffer_load_dwordx4 v[62:65], v44, s[16:19], 0 offen       // 000000028BF4: E05C1000 80043E2C
	buffer_load_dwordx4 v[66:69], v39, s[16:19], 0 offen       // 000000028BFC: E05C1000 80044227
	s_ashr_i32 s3, s2, 31                                      // 000000028C04: 90039F02
	s_lshl_b64 s[30:31], s[2:3], 5                             // 000000028C08: 8E9E8502
	s_waitcnt vmcnt(11)                                        // 000000028C0C: BF8C0F7B
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[6:7]                   // 000000028C10: D2080002 00190102
	v_lshl_add_u64 v[0:1], v[2:3], 0, s[26:27]                 // 000000028C18: D2080000 00690102
	v_lshl_add_u64 v[0:1], v[0:1], 0, v[28:29]                 // 000000028C20: D2080000 04710100
	s_waitcnt vmcnt(10)                                        // 000000028C28: BF8C0F7A
	flat_store_dwordx4 v[0:1], v[6:9] nt                       // 000000028C2C: DC7E0000 00000600
	global_load_dwordx2 v[0:1], v29, s[22:23]                  // 000000028C34: DC548000 0016001D
	v_lshl_add_u64 v[18:19], v[4:5], 0, s[6:7]                 // 000000028C3C: D2080012 00190104
	v_lshl_add_u64 v[4:5], v[18:19], 0, s[26:27]               // 000000028C44: D2080004 00690112
	s_waitcnt vmcnt(0)                                         // 000000028C4C: BF8C0F70
	v_lshl_add_u64 v[16:17], v[10:11], 0, s[6:7]               // 000000028C50: D2080010 0019010A
	v_lshl_add_u64 v[4:5], v[4:5], 0, v[28:29]                 // 000000028C58: D2080004 04710104
	v_lshl_add_u64 v[14:15], v[12:13], 0, s[6:7]               // 000000028C60: D208000E 0019010C
	flat_store_dwordx4 v[4:5], v[32:35] nt                     // 000000028C68: DC7E0000 00002004
	v_lshl_add_u64 v[4:5], v[16:17], 0, s[26:27]               // 000000028C70: D2080004 00690110
	v_lshl_add_u64 v[12:13], v[20:21], 0, s[6:7]               // 000000028C78: D208000C 00190114
	v_lshl_add_u64 v[10:11], v[22:23], 0, s[6:7]               // 000000028C80: D208000A 00190116
	v_lshl_add_u64 v[8:9], v[24:25], 0, s[6:7]                 // 000000028C88: D2080008 00190118
	v_lshl_add_u64 v[6:7], v[26:27], 0, s[6:7]                 // 000000028C90: D2080006 0019011A
	v_lshl_add_u64 v[20:21], v[14:15], 0, s[26:27]             // 000000028C98: D2080014 0069010E
	v_lshl_add_u64 v[4:5], v[4:5], 0, v[28:29]                 // 000000028CA0: D2080004 04710104
	v_lshl_add_u64 v[22:23], v[12:13], 0, s[26:27]             // 000000028CA8: D2080016 0069010C
	flat_store_dwordx4 v[4:5], v[46:49] nt                     // 000000028CB0: DC7E0000 00002E04
	v_lshl_add_u64 v[4:5], v[10:11], 0, s[26:27]               // 000000028CB8: D2080004 0069010A
	v_lshl_add_u64 v[24:25], v[8:9], 0, s[26:27]               // 000000028CC0: D2080018 00690108
	v_lshl_add_u64 v[26:27], v[6:7], 0, s[26:27]               // 000000028CC8: D208001A 00690106
	v_lshl_add_u64 v[20:21], v[20:21], 0, v[28:29]             // 000000028CD0: D2080014 04710114
	v_lshl_add_u64 v[22:23], v[22:23], 0, v[28:29]             // 000000028CD8: D2080016 04710116
	v_lshl_add_u64 v[4:5], v[4:5], 0, v[28:29]                 // 000000028CE0: D2080004 04710104
	v_lshl_add_u64 v[24:25], v[24:25], 0, v[28:29]             // 000000028CE8: D2080018 04710118
	v_lshl_add_u64 v[26:27], v[26:27], 0, v[28:29]             // 000000028CF0: D208001A 0471011A
	flat_store_dwordx4 v[20:21], v[50:53] nt                   // 000000028CF8: DC7E0000 00003214
	flat_store_dwordx4 v[22:23], v[54:57] nt                   // 000000028D00: DC7E0000 00003616
	flat_store_dwordx4 v[4:5], v[58:61] nt                     // 000000028D08: DC7E0000 00003A04
	flat_store_dwordx4 v[24:25], v[62:65] nt                   // 000000028D10: DC7E0000 00003E18
	flat_store_dwordx4 v[26:27], v[66:69] nt                   // 000000028D18: DC7E0000 0000421A
	s_waitcnt lgkmcnt(0)                                       // 000000028D20: BF8CC07F
	s_barrier                                                  // 000000028D24: BF8A0000
	s_and_saveexec_b64 s[34:35], s[0:1]                        // 000000028D28: BEA22000
	s_cbranch_execz 11                                         // 000000028D2C: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x35c>
	global_load_dwordx2 v[4:5], v[30:31], off                  // 000000028D30: DC548000 047F001E
	s_waitcnt vmcnt(0)                                         // 000000028D38: BF8C0F70
	v_lshl_add_u64 v[4:5], v[4:5], 0, s[30:31]                 // 000000028D3C: D2080004 00790104
	v_lshl_add_u64 v[4:5], v[4:5], 0, s[28:29]                 // 000000028D44: D2080004 00710104
	buffer_wbl2 sc0 sc1                                        // 000000028D4C: E0A0C000 00000000
	flat_store_dword v[4:5], v45 sc0 sc1                       // 000000028D54: DE710000 00002D04
	s_or_b64 exec, exec, s[34:35]                              // 000000028D5C: 87FE227E
	v_lshl_add_u64 v[20:21], v[0:1], 0, s[30:31]               // 000000028D60: D2080014 00790100
	s_and_saveexec_b64 s[30:31], s[4:5]                        // 000000028D68: BE9E2004
	s_cbranch_execz 11                                         // 000000028D6C: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x39c>
	s_mov_b64 s[34:35], 0                                      // 000000028D70: BEA20180
	flat_load_dword v4, v[20:21] sc0 sc1                       // 000000028D74: DE510000 04000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028D7C: BF8C0070
	v_readfirstlane_b32 s38, v4                                // 000000028D80: 7E4C0504
	s_cmp_eq_u32 s38, s33                                      // 000000028D84: BF062126
	s_cselect_b64 s[38:39], -1, 0                              // 000000028D88: 85A680C1
	s_and_b64 s[38:39], exec, s[38:39]                         // 000000028D8C: 86A6267E
	s_or_b64 s[34:35], s[38:39], s[34:35]                      // 000000028D90: 87A22226
	s_andn2_b64 exec, exec, s[34:35]                           // 000000028D94: 89FE227E
	s_cbranch_execnz 65526                                     // 000000028D98: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x374>
	s_or_b64 exec, exec, s[30:31]                              // 000000028D9C: 87FE1E7E
	v_lshl_add_u64 v[4:5], v[0:1], 0, s[6:7]                   // 000000028DA0: D2080004 00190100
	v_lshl_add_u64 v[22:23], v[4:5], 0, v[28:29]               // 000000028DA8: D2080016 04710104
	s_waitcnt lgkmcnt(0)                                       // 000000028DB0: BF8CC07F
	s_barrier                                                  // 000000028DB4: BF8A0000
	flat_load_dwordx4 v[22:25], v[22:23] nt                    // 000000028DB8: DC5E0000 16000016
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028DC0: BF8C0070
	v_pk_add_f16 v22, v29, v22                                 // 000000028DC4: D38F4016 18022D1D
	v_pk_add_f16 v23, v29, v23                                 // 000000028DCC: D38F4017 18022F1D
	v_pk_add_f16 v24, v29, v24                                 // 000000028DD4: D38F4018 1802311D
	v_pk_add_f16 v25, v29, v25                                 // 000000028DDC: D38F4019 1802331D
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 000000028DE4: BE862004
	s_cbranch_execz 11                                         // 000000028DE8: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x418>
	s_mov_b64 s[30:31], 0                                      // 000000028DEC: BE9E0180
	flat_load_dword v26, v[20:21] offset:4 sc0 sc1             // 000000028DF0: DE510004 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028DF8: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 000000028DFC: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000028E00: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000028E04: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000028E08: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000028E0C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000028E10: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000028E14: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x3f0>
	s_or_b64 exec, exec, s[6:7]                                // 000000028E18: 87FE067E
	v_lshl_add_u64 v[26:27], v[4:5], 0, v[28:29]               // 000000028E1C: D208001A 04710104
	v_add_co_u32_e32 v26, vcc, 0x1000, v26                     // 000000028E24: 323434FF 00001000
	s_nop 1                                                    // 000000028E2C: BF800001
	v_addc_co_u32_e32 v27, vcc, 0, v27, vcc                    // 000000028E30: 38363680
	s_barrier                                                  // 000000028E34: BF8A0000
	flat_load_dwordx4 v[32:35], v[26:27] nt                    // 000000028E38: DC5E0000 2000001A
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028E40: BF8C0070
	v_pk_add_f16 v22, v22, v32                                 // 000000028E44: D38F4016 18024116
	v_pk_add_f16 v23, v23, v33                                 // 000000028E4C: D38F4017 18024317
	v_pk_add_f16 v24, v24, v34                                 // 000000028E54: D38F4018 18024518
	v_pk_add_f16 v25, v25, v35                                 // 000000028E5C: D38F4019 18024719
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 000000028E64: BE862004
	s_cbranch_execz 11                                         // 000000028E68: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x498>
	s_mov_b64 s[30:31], 0                                      // 000000028E6C: BE9E0180
	flat_load_dword v26, v[20:21] offset:8 sc0 sc1             // 000000028E70: DE510008 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028E78: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 000000028E7C: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000028E80: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000028E84: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000028E88: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000028E8C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000028E90: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000028E94: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x470>
	s_or_b64 exec, exec, s[6:7]                                // 000000028E98: 87FE067E
	v_lshl_add_u64 v[26:27], v[4:5], 0, v[28:29]               // 000000028E9C: D208001A 04710104
	v_add_co_u32_e32 v26, vcc, 0x2000, v26                     // 000000028EA4: 323434FF 00002000
	s_nop 1                                                    // 000000028EAC: BF800001
	v_addc_co_u32_e32 v27, vcc, 0, v27, vcc                    // 000000028EB0: 38363680
	s_barrier                                                  // 000000028EB4: BF8A0000
	flat_load_dwordx4 v[32:35], v[26:27] nt                    // 000000028EB8: DC5E0000 2000001A
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028EC0: BF8C0070
	v_pk_add_f16 v22, v22, v32                                 // 000000028EC4: D38F4016 18024116
	v_pk_add_f16 v23, v23, v33                                 // 000000028ECC: D38F4017 18024317
	v_pk_add_f16 v24, v24, v34                                 // 000000028ED4: D38F4018 18024518
	v_pk_add_f16 v25, v25, v35                                 // 000000028EDC: D38F4019 18024719
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 000000028EE4: BE862004
	s_cbranch_execz 11                                         // 000000028EE8: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x518>
	s_mov_b64 s[30:31], 0                                      // 000000028EEC: BE9E0180
	flat_load_dword v26, v[20:21] offset:12 sc0 sc1            // 000000028EF0: DE51000C 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028EF8: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 000000028EFC: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000028F00: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000028F04: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000028F08: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000028F0C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000028F10: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000028F14: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x4f0>
	s_or_b64 exec, exec, s[6:7]                                // 000000028F18: 87FE067E
	v_lshl_add_u64 v[26:27], v[4:5], 0, v[28:29]               // 000000028F1C: D208001A 04710104
	v_add_co_u32_e32 v26, vcc, 0x3000, v26                     // 000000028F24: 323434FF 00003000
	s_nop 1                                                    // 000000028F2C: BF800001
	v_addc_co_u32_e32 v27, vcc, 0, v27, vcc                    // 000000028F30: 38363680
	s_barrier                                                  // 000000028F34: BF8A0000
	flat_load_dwordx4 v[32:35], v[26:27] nt                    // 000000028F38: DC5E0000 2000001A
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028F40: BF8C0070
	v_pk_add_f16 v22, v22, v32                                 // 000000028F44: D38F4016 18024116
	v_pk_add_f16 v23, v23, v33                                 // 000000028F4C: D38F4017 18024317
	v_pk_add_f16 v24, v24, v34                                 // 000000028F54: D38F4018 18024518
	v_pk_add_f16 v25, v25, v35                                 // 000000028F5C: D38F4019 18024719
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 000000028F64: BE862004
	s_cbranch_execz 11                                         // 000000028F68: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x598>
	s_mov_b64 s[30:31], 0                                      // 000000028F6C: BE9E0180
	flat_load_dword v26, v[20:21] offset:16 sc0 sc1            // 000000028F70: DE510010 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028F78: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 000000028F7C: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000028F80: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000028F84: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000028F88: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000028F8C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000028F90: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000028F94: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x570>
	s_or_b64 exec, exec, s[6:7]                                // 000000028F98: 87FE067E
	v_lshl_add_u64 v[26:27], v[4:5], 0, v[28:29]               // 000000028F9C: D208001A 04710104
	v_add_co_u32_e32 v26, vcc, 0x4000, v26                     // 000000028FA4: 323434FF 00004000
	s_nop 1                                                    // 000000028FAC: BF800001
	v_addc_co_u32_e32 v27, vcc, 0, v27, vcc                    // 000000028FB0: 38363680
	s_barrier                                                  // 000000028FB4: BF8A0000
	flat_load_dwordx4 v[32:35], v[26:27] nt                    // 000000028FB8: DC5E0000 2000001A
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028FC0: BF8C0070
	v_pk_add_f16 v22, v22, v32                                 // 000000028FC4: D38F4016 18024116
	v_pk_add_f16 v23, v23, v33                                 // 000000028FCC: D38F4017 18024317
	v_pk_add_f16 v24, v24, v34                                 // 000000028FD4: D38F4018 18024518
	v_pk_add_f16 v25, v25, v35                                 // 000000028FDC: D38F4019 18024719
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 000000028FE4: BE862004
	s_cbranch_execz 11                                         // 000000028FE8: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x618>
	s_mov_b64 s[30:31], 0                                      // 000000028FEC: BE9E0180
	flat_load_dword v26, v[20:21] offset:20 sc0 sc1            // 000000028FF0: DE510014 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000028FF8: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 000000028FFC: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000029000: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000029004: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029008: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 00000002900C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029010: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000029014: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x5f0>
	s_or_b64 exec, exec, s[6:7]                                // 000000029018: 87FE067E
	v_lshl_add_u64 v[26:27], v[4:5], 0, v[28:29]               // 00000002901C: D208001A 04710104
	v_add_co_u32_e32 v26, vcc, 0x5000, v26                     // 000000029024: 323434FF 00005000
	s_nop 1                                                    // 00000002902C: BF800001
	v_addc_co_u32_e32 v27, vcc, 0, v27, vcc                    // 000000029030: 38363680
	s_barrier                                                  // 000000029034: BF8A0000
	flat_load_dwordx4 v[32:35], v[26:27] nt                    // 000000029038: DC5E0000 2000001A
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029040: BF8C0070
	v_pk_add_f16 v22, v22, v32                                 // 000000029044: D38F4016 18024116
	v_pk_add_f16 v23, v23, v33                                 // 00000002904C: D38F4017 18024317
	v_pk_add_f16 v24, v24, v34                                 // 000000029054: D38F4018 18024518
	v_pk_add_f16 v25, v25, v35                                 // 00000002905C: D38F4019 18024719
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 000000029064: BE862004
	s_cbranch_execz 11                                         // 000000029068: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x698>
	s_mov_b64 s[30:31], 0                                      // 00000002906C: BE9E0180
	flat_load_dword v26, v[20:21] offset:24 sc0 sc1            // 000000029070: DE510018 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029078: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 00000002907C: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000029080: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000029084: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029088: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 00000002908C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029090: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000029094: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x670>
	s_or_b64 exec, exec, s[6:7]                                // 000000029098: 87FE067E
	v_lshl_add_u64 v[26:27], v[4:5], 0, v[28:29]               // 00000002909C: D208001A 04710104
	v_add_co_u32_e32 v26, vcc, 0x6000, v26                     // 0000000290A4: 323434FF 00006000
	s_nop 1                                                    // 0000000290AC: BF800001
	v_addc_co_u32_e32 v27, vcc, 0, v27, vcc                    // 0000000290B0: 38363680
	s_barrier                                                  // 0000000290B4: BF8A0000
	flat_load_dwordx4 v[32:35], v[26:27] nt                    // 0000000290B8: DC5E0000 2000001A
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 0000000290C0: BF8C0070
	v_pk_add_f16 v22, v22, v32                                 // 0000000290C4: D38F4016 18024116
	v_pk_add_f16 v23, v23, v33                                 // 0000000290CC: D38F4017 18024317
	v_pk_add_f16 v24, v24, v34                                 // 0000000290D4: D38F4018 18024518
	v_pk_add_f16 v25, v25, v35                                 // 0000000290DC: D38F4019 18024719
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 0000000290E4: BE862004
	s_cbranch_execz 11                                         // 0000000290E8: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x718>
	s_mov_b64 s[30:31], 0                                      // 0000000290EC: BE9E0180
	flat_load_dword v26, v[20:21] offset:28 sc0 sc1            // 0000000290F0: DE51001C 1A000014
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 0000000290F8: BF8C0070
	v_readfirstlane_b32 s34, v26                               // 0000000290FC: 7E44051A
	s_cmp_eq_u32 s34, s33                                      // 000000029100: BF062122
	s_cselect_b64 s[34:35], -1, 0                              // 000000029104: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029108: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 00000002910C: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029110: 89FE1E7E
	s_cbranch_execnz 65526                                     // 000000029114: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x6f0>
	s_or_b64 exec, exec, s[6:7]                                // 000000029118: 87FE067E
	v_lshl_add_u64 v[20:21], v[4:5], 0, v[28:29]               // 00000002911C: D2080014 04710104
	v_add_co_u32_e32 v20, vcc, 0x7000, v20                     // 000000029124: 322828FF 00007000
	s_add_u32 s6, s2, s37                                      // 00000002912C: 80062502
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[24:25]                 // 000000029130: D2080002 00610102
	v_lshl_add_u64 v[8:9], v[8:9], 0, s[24:25]                 // 000000029138: D2080008 00610108
	v_lshl_add_u64 v[6:7], v[6:7], 0, s[24:25]                 // 000000029140: D2080006 00610106
	v_addc_co_u32_e32 v21, vcc, 0, v21, vcc                    // 000000029148: 382A2A80
	v_lshl_add_u64 v[18:19], v[18:19], 0, s[24:25]             // 00000002914C: D2080012 00610112
	v_lshl_add_u64 v[16:17], v[16:17], 0, s[24:25]             // 000000029154: D2080010 00610110
	v_lshl_add_u64 v[14:15], v[14:15], 0, s[24:25]             // 00000002915C: D208000E 0061010E
	v_lshl_add_u64 v[12:13], v[12:13], 0, s[24:25]             // 000000029164: D208000C 0061010C
	v_lshl_add_u64 v[10:11], v[10:11], 0, s[24:25]             // 00000002916C: D208000A 0061010A
	s_addc_u32 s7, s3, s20                                     // 000000029174: 82071403
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[26:27]                 // 000000029178: D2080002 00690102
	v_lshl_add_u64 v[8:9], v[8:9], 0, s[26:27]                 // 000000029180: D2080008 00690108
	v_lshl_add_u64 v[6:7], v[6:7], 0, s[26:27]                 // 000000029188: D2080006 00690106
	s_barrier                                                  // 000000029190: BF8A0000
	flat_load_dwordx4 v[32:35], v[20:21] nt                    // 000000029194: DC5E0000 20000014
	v_lshl_add_u64 v[18:19], v[18:19], 0, s[26:27]             // 00000002919C: D2080012 00690112
	v_lshl_add_u64 v[16:17], v[16:17], 0, s[26:27]             // 0000000291A4: D2080010 00690110
	v_lshl_add_u64 v[14:15], v[14:15], 0, s[26:27]             // 0000000291AC: D208000E 0069010E
	v_lshl_add_u64 v[12:13], v[12:13], 0, s[26:27]             // 0000000291B4: D208000C 0069010C
	v_lshl_add_u64 v[10:11], v[10:11], 0, s[26:27]             // 0000000291BC: D208000A 0069010A
	s_lshl_b64 s[6:7], s[6:7], 5                               // 0000000291C4: 8E868506
	v_lshl_add_u64 v[2:3], v[2:3], 0, v[28:29]                 // 0000000291C8: D2080002 04710102
	v_lshl_add_u64 v[20:21], v[8:9], 0, v[28:29]               // 0000000291D0: D2080014 04710108
	v_lshl_add_u64 v[26:27], v[6:7], 0, v[28:29]               // 0000000291D8: D208001A 04710106
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 0000000291E0: BF8C0070
	v_pk_add_f16 v6, v22, v32                                  // 0000000291E4: D38F4006 18024116
	v_pk_add_f16 v7, v23, v33                                  // 0000000291EC: D38F4007 18024317
	v_pk_add_f16 v8, v24, v34                                  // 0000000291F4: D38F4008 18024518
	v_pk_add_f16 v9, v25, v35                                  // 0000000291FC: D38F4009 18024719
	v_lshl_add_u64 v[18:19], v[18:19], 0, v[28:29]             // 000000029204: D2080012 04710112
	v_lshl_add_u64 v[16:17], v[16:17], 0, v[28:29]             // 00000002920C: D2080010 04710110
	v_lshl_add_u64 v[14:15], v[14:15], 0, v[28:29]             // 000000029214: D208000E 0471010E
	v_lshl_add_u64 v[12:13], v[12:13], 0, v[28:29]             // 00000002921C: D208000C 0471010C
	v_lshl_add_u64 v[10:11], v[10:11], 0, v[28:29]             // 000000029224: D208000A 0471010A
	flat_store_dwordx4 v[2:3], v[6:9] nt                       // 00000002922C: DC7E0000 00000602
	flat_store_dwordx4 v[18:19], v[6:9] nt                     // 000000029234: DC7E0000 00000612
	flat_store_dwordx4 v[16:17], v[6:9] nt                     // 00000002923C: DC7E0000 00000610
	flat_store_dwordx4 v[14:15], v[6:9] nt                     // 000000029244: DC7E0000 0000060E
	flat_store_dwordx4 v[12:13], v[6:9] nt                     // 00000002924C: DC7E0000 0000060C
	flat_store_dwordx4 v[10:11], v[6:9] nt                     // 000000029254: DC7E0000 0000060A
	flat_store_dwordx4 v[20:21], v[6:9] nt                     // 00000002925C: DC7E0000 00000614
	flat_store_dwordx4 v[26:27], v[6:9] nt                     // 000000029264: DC7E0000 0000061A
	s_waitcnt lgkmcnt(0)                                       // 00000002926C: BF8CC07F
	s_barrier                                                  // 000000029270: BF8A0000
	s_and_saveexec_b64 s[30:31], s[0:1]                        // 000000029274: BE9E2000
	s_cbranch_execz 11                                         // 000000029278: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x8a8>
	global_load_dwordx2 v[2:3], v[30:31], off                  // 00000002927C: DC548000 027F001E
	s_waitcnt vmcnt(0)                                         // 000000029284: BF8C0F70
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[6:7]                   // 000000029288: D2080002 00190102
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[28:29]                 // 000000029290: D2080002 00710102
	buffer_wbl2 sc0 sc1                                        // 000000029298: E0A0C000 00000000
	flat_store_dword v[2:3], v45 sc0 sc1                       // 0000000292A0: DE710000 00002D02
	s_or_b64 exec, exec, s[30:31]                              // 0000000292A8: 87FE1E7E
	v_lshl_add_u64 v[32:33], v[0:1], 0, s[6:7]                 // 0000000292AC: D2080020 00190100
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 0000000292B4: BE862004
	s_cbranch_execz 11                                         // 0000000292B8: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x8e8>
	s_mov_b64 s[30:31], 0                                      // 0000000292BC: BE9E0180
	flat_load_dword v0, v[32:33] sc0 sc1                       // 0000000292C0: DE510000 00000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 0000000292C8: BF8C0070
	v_readfirstlane_b32 s3, v0                                 // 0000000292CC: 7E060500
	s_cmp_eq_u32 s3, s33                                       // 0000000292D0: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 0000000292D4: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 0000000292D8: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 0000000292DC: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 0000000292E0: 89FE1E7E
	s_cbranch_execnz 65526                                     // 0000000292E4: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x8c0>
	s_or_b64 exec, exec, s[6:7]                                // 0000000292E8: 87FE067E
	v_lshl_add_u64 v[34:35], v[4:5], 0, s[24:25]               // 0000000292EC: D2080022 00610104
	v_lshl_add_u64 v[0:1], v[34:35], 0, v[28:29]               // 0000000292F4: D2080000 04710122
	s_waitcnt lgkmcnt(0)                                       // 0000000292FC: BF8CC07F
	s_barrier                                                  // 000000029300: BF8A0000
	flat_load_dwordx4 v[0:3], v[0:1] nt                        // 000000029304: DC5E0000 00000000
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 00000002930C: BE862004
	s_cbranch_execz 11                                         // 000000029310: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x940>
	s_mov_b64 s[30:31], 0                                      // 000000029314: BE9E0180
	flat_load_dword v4, v[32:33] offset:4 sc0 sc1              // 000000029318: DE510004 04000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029320: BF8C0070
	v_readfirstlane_b32 s3, v4                                 // 000000029324: 7E060504
	s_cmp_eq_u32 s3, s33                                       // 000000029328: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 00000002932C: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029330: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000029334: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029338: 89FE1E7E
	s_cbranch_execnz 65526                                     // 00000002933C: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x918>
	s_or_b64 exec, exec, s[6:7]                                // 000000029340: 87FE067E
	v_lshl_add_u64 v[4:5], v[34:35], 0, v[28:29]               // 000000029344: D2080004 04710122
	v_add_co_u32_e32 v4, vcc, 0x1000, v4                       // 00000002934C: 320808FF 00001000
	s_waitcnt lgkmcnt(0)                                       // 000000029354: BF8CC07F
	s_nop 0                                                    // 000000029358: BF800000
	v_addc_co_u32_e32 v5, vcc, 0, v5, vcc                      // 00000002935C: 380A0A80
	s_barrier                                                  // 000000029360: BF8A0000
	flat_load_dwordx4 v[4:7], v[4:5] nt                        // 000000029364: DC5E0000 04000004
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 00000002936C: BE862004
	s_cbranch_execz 11                                         // 000000029370: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x9a0>
	s_mov_b64 s[30:31], 0                                      // 000000029374: BE9E0180
	flat_load_dword v8, v[32:33] offset:8 sc0 sc1              // 000000029378: DE510008 08000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029380: BF8C0070
	v_readfirstlane_b32 s3, v8                                 // 000000029384: 7E060508
	s_cmp_eq_u32 s3, s33                                       // 000000029388: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 00000002938C: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029390: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000029394: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029398: 89FE1E7E
	s_cbranch_execnz 65526                                     // 00000002939C: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x978>
	s_or_b64 exec, exec, s[6:7]                                // 0000000293A0: 87FE067E
	v_lshl_add_u64 v[8:9], v[34:35], 0, v[28:29]               // 0000000293A4: D2080008 04710122
	v_add_co_u32_e32 v8, vcc, 0x2000, v8                       // 0000000293AC: 321010FF 00002000
	s_waitcnt lgkmcnt(0)                                       // 0000000293B4: BF8CC07F
	s_nop 0                                                    // 0000000293B8: BF800000
	v_addc_co_u32_e32 v9, vcc, 0, v9, vcc                      // 0000000293BC: 38121280
	s_barrier                                                  // 0000000293C0: BF8A0000
	flat_load_dwordx4 v[8:11], v[8:9] nt                       // 0000000293C4: DC5E0000 08000008
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 0000000293CC: BE862004
	s_cbranch_execz 11                                         // 0000000293D0: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xa00>
	s_mov_b64 s[30:31], 0                                      // 0000000293D4: BE9E0180
	flat_load_dword v12, v[32:33] offset:12 sc0 sc1            // 0000000293D8: DE51000C 0C000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 0000000293E0: BF8C0070
	v_readfirstlane_b32 s3, v12                                // 0000000293E4: 7E06050C
	s_cmp_eq_u32 s3, s33                                       // 0000000293E8: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 0000000293EC: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 0000000293F0: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 0000000293F4: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 0000000293F8: 89FE1E7E
	s_cbranch_execnz 65526                                     // 0000000293FC: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0x9d8>
	s_or_b64 exec, exec, s[6:7]                                // 000000029400: 87FE067E
	v_lshl_add_u64 v[12:13], v[34:35], 0, v[28:29]             // 000000029404: D208000C 04710122
	v_add_co_u32_e32 v12, vcc, 0x3000, v12                     // 00000002940C: 321818FF 00003000
	s_waitcnt lgkmcnt(0)                                       // 000000029414: BF8CC07F
	s_nop 0                                                    // 000000029418: BF800000
	v_addc_co_u32_e32 v13, vcc, 0, v13, vcc                    // 00000002941C: 381A1A80
	s_barrier                                                  // 000000029420: BF8A0000
	flat_load_dwordx4 v[12:15], v[12:13] nt                    // 000000029424: DC5E0000 0C00000C
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 00000002942C: BE862004
	s_cbranch_execz 11                                         // 000000029430: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xa60>
	s_mov_b64 s[30:31], 0                                      // 000000029434: BE9E0180
	flat_load_dword v16, v[32:33] offset:16 sc0 sc1            // 000000029438: DE510010 10000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029440: BF8C0070
	v_readfirstlane_b32 s3, v16                                // 000000029444: 7E060510
	s_cmp_eq_u32 s3, s33                                       // 000000029448: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 00000002944C: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029450: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000029454: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029458: 89FE1E7E
	s_cbranch_execnz 65526                                     // 00000002945C: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xa38>
	s_or_b64 exec, exec, s[6:7]                                // 000000029460: 87FE067E
	v_lshl_add_u64 v[16:17], v[34:35], 0, v[28:29]             // 000000029464: D2080010 04710122
	v_add_co_u32_e32 v16, vcc, 0x4000, v16                     // 00000002946C: 322020FF 00004000
	s_waitcnt lgkmcnt(0)                                       // 000000029474: BF8CC07F
	s_nop 0                                                    // 000000029478: BF800000
	v_addc_co_u32_e32 v17, vcc, 0, v17, vcc                    // 00000002947C: 38222280
	s_barrier                                                  // 000000029480: BF8A0000
	flat_load_dwordx4 v[16:19], v[16:17] nt                    // 000000029484: DC5E0000 10000010
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 00000002948C: BE862004
	s_cbranch_execz 11                                         // 000000029490: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xac0>
	s_mov_b64 s[30:31], 0                                      // 000000029494: BE9E0180
	flat_load_dword v20, v[32:33] offset:20 sc0 sc1            // 000000029498: DE510014 14000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 0000000294A0: BF8C0070
	v_readfirstlane_b32 s3, v20                                // 0000000294A4: 7E060514
	s_cmp_eq_u32 s3, s33                                       // 0000000294A8: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 0000000294AC: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 0000000294B0: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 0000000294B4: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 0000000294B8: 89FE1E7E
	s_cbranch_execnz 65526                                     // 0000000294BC: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xa98>
	s_or_b64 exec, exec, s[6:7]                                // 0000000294C0: 87FE067E
	v_lshl_add_u64 v[20:21], v[34:35], 0, v[28:29]             // 0000000294C4: D2080014 04710122
	v_add_co_u32_e32 v20, vcc, 0x5000, v20                     // 0000000294CC: 322828FF 00005000
	s_waitcnt lgkmcnt(0)                                       // 0000000294D4: BF8CC07F
	s_nop 0                                                    // 0000000294D8: BF800000
	v_addc_co_u32_e32 v21, vcc, 0, v21, vcc                    // 0000000294DC: 382A2A80
	s_barrier                                                  // 0000000294E0: BF8A0000
	flat_load_dwordx4 v[20:23], v[20:21] nt                    // 0000000294E4: DC5E0000 14000014
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 0000000294EC: BE862004
	s_cbranch_execz 11                                         // 0000000294F0: BF88000B <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xb20>
	s_mov_b64 s[30:31], 0                                      // 0000000294F4: BE9E0180
	flat_load_dword v24, v[32:33] offset:24 sc0 sc1            // 0000000294F8: DE510018 18000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029500: BF8C0070
	v_readfirstlane_b32 s3, v24                                // 000000029504: 7E060518
	s_cmp_eq_u32 s3, s33                                       // 000000029508: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 00000002950C: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029510: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000029514: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029518: 89FE1E7E
	s_cbranch_execnz 65526                                     // 00000002951C: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xaf8>
	s_or_b64 exec, exec, s[6:7]                                // 000000029520: 87FE067E
	v_lshl_add_u64 v[24:25], v[34:35], 0, v[28:29]             // 000000029524: D2080018 04710122
	v_add_co_u32_e32 v24, vcc, 0x6000, v24                     // 00000002952C: 323030FF 00006000
	s_waitcnt lgkmcnt(0)                                       // 000000029534: BF8CC07F
	s_nop 0                                                    // 000000029538: BF800000
	v_addc_co_u32_e32 v25, vcc, 0, v25, vcc                    // 00000002953C: 38323280
	s_barrier                                                  // 000000029540: BF8A0000
	flat_load_dwordx4 v[24:27], v[24:25] nt                    // 000000029544: DC5E0000 18000018
	s_and_saveexec_b64 s[6:7], s[4:5]                          // 00000002954C: BE862004
	s_cbranch_execz 64865                                      // 000000029550: BF88FD61 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xd8>
	s_mov_b64 s[30:31], 0                                      // 000000029554: BE9E0180
	flat_load_dword v46, v[32:33] offset:28 sc0 sc1            // 000000029558: DE51001C 2E000020
	s_waitcnt vmcnt(0) lgkmcnt(0)                              // 000000029560: BF8C0070
	v_readfirstlane_b32 s3, v46                                // 000000029564: 7E06052E
	s_cmp_eq_u32 s3, s33                                       // 000000029568: BF062103
	s_cselect_b64 s[34:35], -1, 0                              // 00000002956C: 85A280C1
	s_and_b64 s[34:35], exec, s[34:35]                         // 000000029570: 86A2227E
	s_or_b64 s[30:31], s[34:35], s[30:31]                      // 000000029574: 879E1E22
	s_andn2_b64 exec, exec, s[30:31]                           // 000000029578: 89FE1E7E
	s_cbranch_execnz 65526                                     // 00000002957C: BF89FFF6 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xb58>
	s_branch 64853                                             // 000000029580: BF82FD55 <_ZN11quickreduceL19allreduce_prototypeINS_16AllReduceTwoshotINS_20TwoshotFP16LineCodecILi8EEEEEEEvPK6__halfPS5_iiiiPPhli+0xd8>
	s_endpgm                                                   // 000000029584: BF810000
