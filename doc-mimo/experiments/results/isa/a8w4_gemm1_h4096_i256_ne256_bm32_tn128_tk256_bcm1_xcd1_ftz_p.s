	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p
	.p2align	8
	.type	a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p,@function
a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p:
	s_load_dwordx16 s[8:23], s[0:1], 0x0
	s_mov_b32 s44, 0
	s_waitcnt lgkmcnt(0)
	s_load_dword s20, s[20:21], 0x0
	v_readfirstlane_b32 s21, v0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s3, s20, 31
	s_lshr_b32 s3, s3, 27
	s_add_i32 s3, s20, s3
	s_ashr_i32 s24, s3, 5
	s_andn2_b32 s3, s3, 31
	s_cmp_lg_u32 s20, s3
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s20, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s3, s24, 0
	s_lshl_b32 s4, s3, 1
	s_cmp_ge_i32 s2, s4
	s_cbranch_scc1 .LBB0_4
	s_and_b32 s5, s4, 6
	s_and_b32 s6, s2, 7
	s_lshr_b32 s4, s4, 3
	s_min_u32 s5, s6, s5
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s4, s4, s6
	s_add_i32 s2, s5, s2
	s_add_i32 s2, s2, s4
	s_lshr_b32 s4, s2, 31
	s_add_i32 s4, s2, s4
	s_ashr_i32 s24, s4, 1
	s_and_b32 s25, s4, -2
	s_cmp_lg_u32 s2, s25
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s4, s24, 0
	s_sub_i32 s5, s3, s4
	s_min_i32 s3, s5, 1
	s_abs_i32 s6, s3
	v_cvt_f32_u32_e32 v1, s6
	s_sub_i32 s7, s2, s25
	s_sub_i32 s25, 0, s6
	s_abs_i32 s24, s7
	v_rcp_f32_e32 v1, v1
	s_xor_b32 s2, s7, s3
	s_ashr_i32 s2, s2, 31
	v_lshrrev_b32_e32 v36, 4, v0
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	s_mov_b32 s36, s12
	v_and_b32_e32 v114, 15, v0
	v_lshlrev_b32_e32 v32, 4, v0
	v_readfirstlane_b32 s26, v1
	s_mul_i32 s25, s25, s26
	s_mul_hi_u32 s25, s26, s25
	s_add_i32 s26, s26, s25
	s_mul_hi_u32 s25, s24, s26
	s_mul_i32 s26, s25, s6
	s_sub_i32 s24, s24, s26
	s_add_i32 s26, s25, 1
	s_sub_i32 s27, s24, s6
	s_cmp_ge_u32 s24, s6
	s_cselect_b32 s25, s26, s25
	s_cselect_b32 s24, s27, s24
	s_add_i32 s26, s25, 1
	s_cmp_ge_u32 s24, s6
	s_cselect_b32 s6, s26, s25
	s_xor_b32 s6, s6, s2
	s_sub_i32 s6, s6, s2
	s_mul_i32 s2, s6, s3
	s_sub_i32 s3, s7, s2
	s_add_i32 s24, s3, s4
	s_cmp_lg_u32 s7, s2
	s_cselect_b64 s[2:3], -1, 0
	s_xor_b32 s4, s5, s7
	s_cmp_lt_i32 s4, 0
	s_cselect_b64 s[4:5], -1, 0
	s_and_b64 s[2:3], s[4:5], s[2:3]
	s_lshl1_add_u32 s4, s24, s6
	s_cmp_lg_u64 s[2:3], 0
	s_subb_u32 s4, s4, 0
	s_lshr_b32 s2, s4, 31
	s_add_i32 s2, s4, s2
	s_ashr_i32 s24, s2, 1
	s_and_b32 s2, s2, -2
	s_sub_i32 s5, s4, s2
	s_cmp_lg_u32 s4, s2
	s_cselect_b64 s[2:3], -1, 0
	s_cmp_lt_i32 s4, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[2:3], s[6:7], s[2:3]
	s_subb_u32 s6, s24, 0
	s_ashr_i32 s7, s6, 31
	s_lshl_b64 s[2:3], s[6:7], 2
	s_add_u32 s2, s18, s2
	s_addc_u32 s3, s19, s3
	s_lshl_b32 s19, s6, 5
	v_or_b32_e32 v2, s19, v36
	v_ashrrev_i32_e32 v3, 31, v2
	s_ashr_i32 s4, s19, 31
	v_lshl_add_u64 v[4:5], v[2:3], 2, s[22:23]
	v_mov_b32_e32 v3, s4
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[22:23]
	global_load_dword v6, v[4:5], off
	global_load_dword v7, v[2:3], off offset:64
	s_load_dword s2, s[2:3], 0x0
	s_mov_b32 s24, s12
	s_mov_b32 s4, s8
	s_mov_b32 s12, s8
	s_lshl_b32 s8, s5, 7
	s_and_b32 s5, s9, 0xffff
	s_lshr_b32 s9, s21, 1
	s_and_b32 s3, s9, 0x7fffffe0
	s_add_i32 s8, s8, s3
	v_bfe_u32 v113, v0, 4, 2
	v_and_b32_e32 v4, 48, v0
	v_xor_b32_e32 v0, v32, v0
	v_or_b32_e32 v108, s8, v114
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s2, 9
	v_and_b32_e32 v5, 0xf0, v0
	s_add_i32 s3, s8, s2
	v_add_u32_e32 v0, s2, v108
	s_and_b32 s25, s13, 0xffff
	s_lshl_b32 s2, s3, 7
	s_lshl_b32 s9, s3, 5
	s_add_i32 s13, s3, 0x100
	s_or_b32 s21, s3, 16
	s_add_i32 s45, s3, 0x110
	v_add_u32_e32 v2, 0x100, v0
	s_mov_b32 s27, 0x27000
	s_brev_b32 s26, 8
	s_mov_b32 s30, 0x1000000
	s_mov_b32 s28, s14
	s_mov_b32 s40, s14
	s_and_b32 s29, s15, 0xffff
	v_ashrrev_i32_e32 v1, 31, v0
	v_or3_b32 v126, s2, v4, v114
	v_or3_b32 v127, s9, v4, v114
	s_lshl_b32 s2, s13, 7
	s_lshl_b32 s9, s13, 5
	s_lshl_b32 s13, s21, 7
	s_lshl_b32 s14, s45, 7
	v_ashrrev_i32_e32 v3, 31, v2
	s_mov_b32 s38, s26
	s_mov_b32 s39, s27
	s_mov_b32 s42, s30
	s_mov_b32 s43, s27
	s_mov_b32 s37, s25
	s_mov_b32 s41, s29
	v_lshl_add_u64 v[0:1], v[0:1], 2, s[16:17]
	v_or3_b32 v128, s2, v4, v114
	v_or3_b32 v129, s9, v4, v114
	v_or3_b32 v130, s13, v4, v114
	v_or3_b32 v131, s14, v4, v114
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[16:17]
	v_lshlrev_b32_e32 v33, 2, v127
	v_lshlrev_b32_e32 v4, 4, v126
	s_load_dword s18, s[0:1], 0x48
	global_load_dword v111, v[0:1], off
	global_load_dword v109, v[0:1], off offset:64
	global_load_dword v112, v[2:3], off
	global_load_dword v110, v[2:3], off offset:64
	v_lshlrev_b32_e32 v34, 2, v129
	buffer_load_dwordx4 v[28:31], v4, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[20:23], v4, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v35, 4, v130
	v_lshlrev_b32_e32 v37, 4, v128
	v_lshlrev_b32_e32 v38, 4, v131
	s_mov_b32 s7, s27
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s6, s18, 12
	s_mov_b32 s13, s5
	s_lshr_b32 s2, s3, 31
	s_ashr_i32 s3, s21, 4
	s_add_i32 s2, s3, s2
	v_lshlrev_b32_e32 v39, 4, v114
	s_and_b32 s2, s2, -2
	s_sub_i32 s2, s3, s2
	v_mov_b32_e32 v40, 0
	v_lshlrev_b32_e32 v116, 8, v114
	s_lshl_b32 s17, s2, 3
	s_mov_b32 s33, 0x8080808
	s_mov_b32 s34, 0x5010400
	s_mov_b32 s35, 0x7030602
	s_mov_b32 s31, s27
	s_mov_b32 s15, s27
	v_mov_b32_e32 v41, v40
	v_mov_b32_e32 v42, v40
	s_waitcnt vmcnt(7)
	v_lshl_or_b32 v132, v6, 12, v5
	s_waitcnt vmcnt(6)
	v_lshl_or_b32 v133, v7, 12, v5
	buffer_load_dword v98, v33, s[40:43], 0 offen
	buffer_load_dword v96, v34, s[40:43], 0 offen
	buffer_load_dwordx4 v[8:11], v35, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[0:3], v35, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[24:27], v37, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[16:19], v37, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[12:15], v38, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[4:7], v38, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[48:51], v132, s[4:7], 0 offen nt
	buffer_load_dwordx4 v[52:55], v133, s[4:7], 0 offen nt
	s_ashr_i32 s4, s45, 4
	s_lshr_b32 s5, s45, 31
	s_add_i32 s5, s4, s5
	v_and_b32_e32 v37, 0xf0, v32
	v_lshlrev_b32_e32 v38, 5, v113
	s_and_b32 s5, s5, -2
	v_lshl_or_b32 v134, v36, 8, v37
	v_xor_b32_e32 v125, v38, v39
	v_or_b32_e32 v36, 8, v38
	v_or_b32_e32 v37, 16, v38
	v_or_b32_e32 v44, 24, v38
	v_or_b32_e32 v45, 0x80, v38
	v_or_b32_e32 v46, 0x88, v38
	v_or_b32_e32 v47, 0x90, v38
	v_or_b32_e32 v38, 0x98, v38
	s_sub_i32 s3, s4, s5
	v_xor_b32_e32 v124, v36, v39
	v_xor_b32_e32 v123, v37, v39
	v_xor_b32_e32 v120, v44, v39
	v_xor_b32_e32 v119, v45, v39
	v_xor_b32_e32 v118, v46, v39
	v_xor_b32_e32 v117, v47, v39
	v_xor_b32_e32 v36, v38, v39
	s_lshl_b32 s9, s3, 3
	v_mov_b32_e32 v43, v40
	v_mov_b32_e32 v32, v40
	v_mov_b32_e32 v33, v40
	v_mov_b32_e32 v34, v40
	v_mov_b32_e32 v35, v40
	v_mov_b32_e32 v60, v40
	v_mov_b32_e32 v61, v40
	v_mov_b32_e32 v62, v40
	v_mov_b32_e32 v63, v40
	v_mov_b32_e32 v84, v40
	v_mov_b32_e32 v85, v40
	v_mov_b32_e32 v86, v40
	v_mov_b32_e32 v87, v40
	v_or_b32_e32 v135, 0x1000, v134
	v_or_b32_e32 v136, v116, v125
	v_or_b32_e32 v115, v116, v36
	v_or_b32_e32 v137, v116, v124
	v_or_b32_e32 v138, v116, v123
	v_or_b32_e32 v139, v116, v120
	v_or_b32_e32 v140, v116, v119
	v_or_b32_e32 v141, v116, v118
	v_or_b32_e32 v142, v116, v117
	s_mov_b32 s14, s6
	s_add_i32 s21, s17, 16
	s_add_i32 s16, s9, 16
	v_mov_b32_e32 v64, v40
	v_mov_b32_e32 v65, v40
	v_mov_b32_e32 v66, v40
	v_mov_b32_e32 v67, v40
	v_mov_b32_e32 v36, v40
	v_mov_b32_e32 v37, v40
	v_mov_b32_e32 v38, v40
	v_mov_b32_e32 v39, v40
	v_mov_b32_e32 v72, v40
	v_mov_b32_e32 v73, v40
	v_mov_b32_e32 v74, v40
	v_mov_b32_e32 v75, v40
	v_mov_b32_e32 v88, v40
	v_mov_b32_e32 v89, v40
	v_mov_b32_e32 v90, v40
	v_mov_b32_e32 v91, v40
	s_waitcnt vmcnt(1)
	ds_write_b128 v134, v[48:51]
	s_waitcnt vmcnt(0)
	ds_write_b128 v134, v[52:55] offset:4096
.LBB0_2:
	s_add_i32 s36, s44, 1
	s_lshl_b32 s4, s36, 7
	s_waitcnt vmcnt(2)
	v_mov_b64_e32 v[46:47], v[6:7]
	v_mov_b64_e32 v[44:45], v[4:5]
	s_lshl_b32 s2, s36, 8
	s_lshl_b32 s3, s36, 6
	v_or_b32_e32 v4, s4, v126
	v_mov_b64_e32 v[50:51], v[2:3]
	v_mov_b64_e32 v[48:49], v[0:1]
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[58:59], v[22:23]
	v_mov_b64_e32 v[56:57], v[20:21]
	v_add_u32_e32 v0, s2, v132
	v_add_u32_e32 v1, s2, v133
	v_add_lshl_u32 v2, s3, v127, 2
	v_add_lshl_u32 v3, s3, v129, 2
	v_add_lshl_u32 v5, s4, v130, 4
	v_add_lshl_u32 v6, s4, v128, 4
	v_add_lshl_u32 v7, s4, v131, 4
	v_lshlrev_b32_e32 v20, 4, v4
	v_mov_b64_e32 v[70:71], v[14:15]
	v_mov_b64_e32 v[68:69], v[12:13]
	v_mov_b64_e32 v[54:55], v[18:19]
	v_mov_b64_e32 v[52:53], v[16:17]
	v_mov_b64_e32 v[82:83], v[26:27]
	v_mov_b64_e32 v[80:81], v[24:25]
	v_mov_b64_e32 v[78:79], v[10:11]
	v_mov_b64_e32 v[76:77], v[8:9]
	v_mov_b64_e32 v[94:95], v[30:31]
	v_mov_b64_e32 v[92:93], v[28:29]
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx4 v[210:213], v0, s[12:15], 0 offen nt
	buffer_load_dwordx4 v[214:217], v1, s[12:15], 0 offen nt
	buffer_load_dword v122, v2, s[28:31], 0 offen
	buffer_load_dword v121, v3, s[28:31], 0 offen
	buffer_load_dwordx4 v[8:11], v5, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[0:3], v5, s[24:27], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[24:27], v6, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[16:19], v6, s[24:27], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[12:15], v7, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[4:7], v7, s[24:27], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[28:31], v20, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[20:23], v20, s[24:27], 0 offen offset:1024 sc0
	v_bfe_u32 v104, v98, s17, 8
	v_bfe_u32 v184, v98, s21, 8
	v_bfe_u32 v105, v96, s9, 8
	v_bfe_u32 v185, v96, s16, 8
	v_sub_u32_sdwa v97, v111, v98 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_sub_u32_sdwa v101, v112, v96 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_sub_u32_e32 v104, v109, v104
	v_sub_u32_e32 v105, v110, v105
	v_min_i32_e32 v165, 11, v97
	v_min_i32_e32 v167, 11, v101
	v_min_i32_e32 v168, 11, v104
	v_min_i32_e32 v169, 11, v105
	v_cmp_lt_i32_e64 s[6:7], 11, v97
	v_mul_lo_u32 v97, v165, s33
	s_lshl_b32 s2, s44, 13
	v_cmp_lt_i32_e32 vcc, 11, v101
	v_mul_lo_u32 v101, v167, s33
	v_mul_lo_u32 v165, v168, s33
	v_mul_lo_u32 v167, v169, s33
	v_sub_u32_e32 v168, 0x6c686080, v97
	s_and_b32 s37, s2, 0x2000
	v_cmp_lt_i32_e64 s[2:3], 11, v104
	v_cmp_lt_i32_e64 s[4:5], 11, v105
	v_sub_u32_e32 v97, 0x7c787470, v97
	v_sub_u32_e32 v170, 0x6c686080, v165
	v_sub_u32_e32 v165, 0x7c787470, v165
	v_sub_u32_e32 v171, 0x6c686080, v167
	v_sub_u32_e32 v172, 0x7c787470, v167
	v_and_b32_e32 v173, 0xffffff00, v168
	v_lshrrev_b32_e32 v106, 4, v76
	v_lshrrev_b32_e32 v107, 4, v68
	v_or_b32_e32 v104, s37, v136
	v_sub_u32_e32 v169, 0x6c686080, v101
	v_and_b32_e32 v170, 0xffffff00, v170
	v_and_b32_e32 v175, 0xffffff00, v171
	v_cndmask_b32_e64 v168, v97, 0, s[6:7]
	v_cndmask_b32_e64 v167, v165, 0, s[2:3]
	v_cndmask_b32_e64 v165, v172, 0, s[4:5]
	v_cndmask_b32_e64 v172, v173, 0, s[6:7]
	v_and_b32_e32 v218, 0x7070707, v106
	v_and_b32_e32 v219, 0x7070707, v107
	ds_read2st64_b64 v[104:107], v104 offset1:8
	v_and_b32_e32 v174, 0xffffff00, v169
	v_cndmask_b32_e64 v171, v170, 0, s[2:3]
	v_cndmask_b32_e64 v170, v175, 0, s[4:5]
	v_add_u32_e32 v97, 0x7f7f7f78, v168
	v_add_u32_e32 v175, 0x7f7f7f00, v172
	v_sub_u32_sdwa v144, v112, v96 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_and_b32_e32 v96, 0x7070707, v92
	v_sub_u32_e32 v101, 0x7c787470, v101
	v_cndmask_b32_e64 v173, v174, 0, vcc
	v_and_b32_e32 v174, 0x80808080, v97
	v_and_b32_e32 v175, 0x80808000, v175
	v_sub_u32_sdwa v143, v111, v98 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshlrev_b32_e32 v98, 4, v92
	v_cndmask_b32_e64 v169, v101, 0, vcc
	v_perm_b32 v176, v168, v172, v96
	v_perm_b32 v96, v174, v175, v96
	v_add_u32_e32 v101, 0x7f7f7f78, v169
	v_and_or_b32 v97, v96, v98, v176
	v_add_u32_e32 v96, 0x7f7f7f00, v173
	v_lshrrev_b32_e32 v102, 4, v92
	v_and_b32_e32 v99, 0x7070707, v80
	v_and_b32_e32 v176, 0x80808080, v101
	v_and_b32_e32 v177, 0x80808000, v96
	v_lshlrev_b32_e32 v100, 4, v80
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v98, v169, v173, v99
	v_perm_b32 v96, v176, v177, v99
	v_lshrrev_b32_e32 v103, 4, v80
	v_and_or_b32 v98, v96, v100, v98
	v_perm_b32 v96, v168, v172, v102
	v_perm_b32 v100, v174, v175, v102
	v_and_b32_e32 v103, 0x7070707, v103
	v_and_or_b32 v92, v100, v92, v96
	v_perm_b32 v99, v169, v173, v103
	v_perm_b32 v101, v176, v177, v103
	v_perm_b32 v96, v92, v97, s34
	v_perm_b32 v97, v92, v97, s35
	v_and_or_b32 v80, v101, v80, v99
	v_and_b32_e32 v179, 0x7070707, v76
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[104:105], v[96:97], v[40:43]
	v_perm_b32 v202, v80, v98, s34
	v_perm_b32 v203, v80, v98, s35
	v_lshlrev_b32_e32 v180, 4, v76
	v_add_u32_e32 v40, 0x7f7f7f78, v167
	v_add_u32_e32 v41, 0x7f7f7f00, v171
	v_and_b32_e32 v80, 0x80808080, v40
	v_and_b32_e32 v92, 0x80808000, v41
	v_add_u32_e32 v220, 0x7f7f7f78, v165
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[106:107], v[96:97], v[60:63]
	v_and_b32_e32 v188, 0x7070707, v68
	v_lshlrev_b32_e32 v199, 4, v68
	v_and_b32_e32 v189, 0x7070707, v93
	v_perm_b32 v60, v167, v171, v179
	v_perm_b32 v61, v80, v92, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[104:105], v[202:203], v[64:67]
	v_and_b32_e32 v179, 0x80808080, v220
	v_lshrrev_b32_e32 v192, 4, v93
	v_lshlrev_b32_e32 v190, 4, v93
	v_add_u32_e32 v64, 0x7f7f7f00, v170
	v_and_or_b32 v65, v61, v180, v60
	v_perm_b32 v66, v167, v171, v218
	v_and_b32_e32 v180, 0x80808000, v64
	v_perm_b32 v64, v80, v92, v218
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[106:107], v[202:203], v[72:75]
	v_perm_b32 v67, v165, v170, v188
	v_and_or_b32 v66, v64, v76, v66
	v_perm_b32 v64, v66, v65, s34
	v_perm_b32 v72, v165, v170, v219
	v_perm_b32 v73, v179, v180, v188
	v_perm_b32 v74, v179, v180, v219
	v_and_or_b32 v67, v73, v199, v67
	v_perm_b32 v65, v66, v65, s35
	v_and_or_b32 v66, v74, v68, v72
	v_perm_b32 v72, v66, v67, s34
	v_perm_b32 v73, v66, v67, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[104:105], v[64:65], v[32:35]
	v_perm_b32 v74, v168, v172, v189
	v_perm_b32 v75, v174, v175, v189
	v_and_b32_e32 v191, 0x7070707, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[104:105], v[72:73], v[36:39]
	v_and_b32_e32 v208, 0x7070707, v77
	v_and_or_b32 v74, v75, v190, v74
	v_lshrrev_b32_e32 v194, 4, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[106:107], v[64:65], v[84:87]
	v_lshlrev_b32_e32 v193, 4, v81
	v_lshlrev_b32_e32 v209, 4, v77
	v_lshrrev_b32_e32 v204, 4, v77
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[106:107], v[72:73], v[88:91]
	v_and_b32_e32 v72, 0x7070707, v192
	v_perm_b32 v75, v168, v172, v72
	v_perm_b32 v72, v174, v175, v72
	v_or_b32_e32 v73, s37, v137
	v_perm_b32 v88, v169, v173, v191
	v_and_or_b32 v72, v72, v93, v75
	v_perm_b32 v75, v167, v171, v208
	v_perm_b32 v89, v176, v177, v191
	v_perm_b32 v90, v80, v92, v208
	v_and_b32_e32 v192, 0x7070707, v194
	v_and_or_b32 v189, v89, v193, v88
	v_and_or_b32 v194, v90, v209, v75
	ds_read2st64_b64 v[88:91], v73 offset1:8
	v_perm_b32 v190, v72, v74, s34
	v_perm_b32 v191, v72, v74, s35
	v_perm_b32 v93, v169, v173, v192
	v_lshrrev_b32_e32 v207, 4, v69
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[88:89], v[190:191], v[100:103]
	v_and_b32_e32 v205, 0x7070707, v69
	v_lshlrev_b32_e32 v206, 4, v69
	v_and_b32_e32 v159, 0x7070707, v94
	v_perm_b32 v100, v176, v177, v192
	v_mfma_f32_16x16x32_fp8_fp8 v[190:193], v[90:91], v[190:191], v[96:99]
	v_and_or_b32 v81, v100, v81, v93
	v_perm_b32 v101, v179, v180, v205
	v_lshrrev_b32_e32 v163, 4, v94
	v_and_b32_e32 v98, 0x7070707, v204
	v_perm_b32 v100, v167, v171, v98
	v_perm_b32 v98, v80, v92, v98
	v_perm_b32 v96, v81, v189, s34
	v_perm_b32 v97, v81, v189, s35
	v_and_b32_e32 v99, 0x7070707, v207
	v_and_or_b32 v77, v98, v77, v100
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[88:89], v[96:97], v[40:43]
	v_perm_b32 v102, v179, v180, v99
	v_perm_b32 v98, v77, v194, s34
	v_lshlrev_b32_e32 v161, 4, v94
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[90:91], v[96:97], v[60:63]
	v_perm_b32 v96, v165, v170, v205
	v_perm_b32 v97, v165, v170, v99
	v_perm_b32 v99, v77, v194, s35
	v_and_or_b32 v96, v101, v206, v96
	v_lshrrev_b32_e32 v166, 4, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[204:207], v[88:89], v[98:99], v[32:35]
	v_and_b32_e32 v200, 0x7070707, v78
	v_and_b32_e32 v162, 0x7070707, v82
	v_lshlrev_b32_e32 v201, 4, v78
	v_and_or_b32 v33, v102, v69, v97
	v_perm_b32 v32, v33, v96, s34
	v_perm_b32 v33, v33, v96, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[222:225], v[90:91], v[98:99], v[64:67]
	v_perm_b32 v34, v168, v172, v159
	v_perm_b32 v35, v174, v175, v159
	v_and_or_b32 v34, v35, v161, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[218:221], v[88:89], v[32:33], v[36:39]
	v_lshlrev_b32_e32 v164, 4, v82
	v_lshrrev_b32_e32 v195, 4, v78
	v_lshrrev_b32_e32 v198, 4, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[90:91], v[32:33], v[84:87]
	v_or_b32_e32 v33, s37, v138
	ds_read2st64_b64 v[226:229], v33 offset1:8
	v_and_b32_e32 v32, 0x7070707, v163
	v_perm_b32 v35, v168, v172, v32
	v_perm_b32 v32, v174, v175, v32
	v_and_b32_e32 v38, 0x7070707, v166
	v_and_or_b32 v32, v32, v94, v35
	v_perm_b32 v35, v167, v171, v200
	v_perm_b32 v39, v80, v92, v200
	v_perm_b32 v36, v169, v173, v162
	v_perm_b32 v37, v176, v177, v162
	v_and_or_b32 v66, v39, v201, v35
	v_perm_b32 v39, v169, v173, v38
	v_perm_b32 v38, v176, v177, v38
	v_and_or_b32 v65, v37, v164, v36
	v_and_or_b32 v67, v38, v82, v39
	v_perm_b32 v36, v32, v34, s34
	v_perm_b32 v37, v32, v34, s35
	v_perm_b32 v64, v67, v65, s34
	v_perm_b32 v65, v67, v65, s35
	v_and_b32_e32 v67, 0x7070707, v195
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[226:227], v[36:37], v[72:75]
	v_lshrrev_b32_e32 v160, 4, v83
	v_and_b32_e32 v196, 0x7070707, v70
	v_lshrrev_b32_e32 v182, 4, v52
	v_and_b32_e32 v72, 0x7070707, v198
	v_perm_b32 v73, v167, v171, v67
	v_perm_b32 v67, v80, v92, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[226:227], v[64:65], v[40:43]
	v_perm_b32 v86, v179, v180, v72
	v_and_or_b32 v67, v67, v78, v73
	v_lshlrev_b32_e32 v197, 4, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[228:229], v[64:65], v[60:63]
	v_perm_b32 v65, v165, v170, v72
	v_lshrrev_b32_e32 v68, 4, v54
	v_sub_u32_e32 v203, v109, v184
	v_sub_u32_e32 v184, v110, v185
	v_lshrrev_b32_e32 v185, 4, v79
	v_perm_b32 v64, v165, v170, v196
	v_perm_b32 v74, v179, v180, v196
	v_perm_b32 v84, v67, v66, s34
	v_perm_b32 v85, v67, v66, s35
	v_and_or_b32 v65, v86, v70, v65
	v_lshrrev_b32_e32 v70, 4, v45
	v_and_b32_e32 v160, 0x7070707, v160
	v_and_or_b32 v64, v74, v197, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[226:227], v[84:85], v[204:207]
	v_lshrrev_b32_e32 v166, 4, v50
	v_and_b32_e32 v185, 0x7070707, v185
	v_and_b32_e32 v197, 0x7070707, v182
	v_min_i32_e32 v182, 11, v184
	v_and_b32_e32 v201, 0x7070707, v68
	v_and_b32_e32 v204, 0x7070707, v70
	v_perm_b32 v68, v169, v173, v160
	v_perm_b32 v70, v176, v177, v160
	v_and_b32_e32 v148, 0x7070707, v83
	v_lshlrev_b32_e32 v146, 4, v83
	v_lshrrev_b32_e32 v183, 4, v57
	v_and_b32_e32 v205, 0x7070707, v166
	v_and_or_b32 v83, v70, v83, v68
	v_or_b32_e32 v68, s37, v139
	v_mul_lo_u32 v160, v182, s33
	v_perm_b32 v166, v167, v171, v185
	v_perm_b32 v182, v80, v92, v185
	v_and_b32_e32 v93, 0x7070707, v79
	v_lshlrev_b32_e32 v81, 4, v79
	v_cmp_lt_i32_e64 s[6:7], 11, v184
	v_and_b32_e32 v200, 0x7070707, v183
	v_and_or_b32 v79, v182, v79, v166
	ds_read2st64_b64 v[182:185], v68 offset1:8
	v_lshrrev_b32_e32 v178, 4, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[228:229], v[36:37], v[190:193]
	v_cmp_lt_i32_e32 vcc, 11, v143
	v_perm_b32 v162, v65, v64, s34
	v_perm_b32 v163, v65, v64, s35
	v_min_i32_e32 v191, 11, v143
	v_min_i32_e32 v143, 11, v144
	v_and_b32_e32 v178, 0x7070707, v178
	v_mul_lo_u32 v70, v191, s33
	v_mul_lo_u32 v143, v143, s33
	v_and_b32_e32 v147, 0x7070707, v95
	v_lshrrev_b32_e32 v189, 4, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[226:227], v[162:163], v[218:221]
	v_perm_b32 v190, v168, v172, v178
	v_perm_b32 v178, v174, v175, v178
	v_perm_b32 v173, v169, v173, v148
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[228:229], v[162:163], v[88:91]
	v_lshrrev_b32_e32 v162, 4, v46
	v_sub_u32_e32 v218, 0x6c686080, v70
	v_sub_u32_e32 v219, 0x6c686080, v143
	v_perm_b32 v148, v176, v177, v148
	v_lshlrev_b32_e32 v145, 4, v95
	v_and_b32_e32 v69, 0x7070707, v71
	v_lshrrev_b32_e32 v208, 4, v44
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[228:229], v[84:85], v[222:225]
	v_and_or_b32 v95, v178, v95, v190
	v_lshrrev_b32_e32 v190, 4, v47
	v_and_b32_e32 v189, 0x7070707, v189
	v_cmp_lt_i32_e64 s[2:3], 11, v144
	v_and_b32_e32 v206, 0x7070707, v162
	v_or_b32_e32 v162, s37, v140
	v_sub_u32_e32 v222, 0x7c787470, v70
	v_perm_b32 v172, v168, v172, v147
	v_perm_b32 v171, v167, v171, v93
	v_perm_b32 v147, v174, v175, v147
	v_perm_b32 v80, v80, v92, v93
	v_and_b32_e32 v92, 0xffffff00, v218
	v_and_b32_e32 v93, 0xffffff00, v219
	v_and_or_b32 v146, v148, v146, v173
	v_lshlrev_b32_e32 v96, 4, v71
	v_and_b32_e32 v198, 0x7070707, v208
	v_and_b32_e32 v208, 0x7070707, v190
	v_or_b32_e32 v209, s37, v115
	v_perm_b32 v68, v165, v170, v189
	v_perm_b32 v166, v179, v180, v189
	v_sub_u32_e32 v143, 0x7c787470, v143
	ds_read2st64_b64 v[190:193], v162 offset1:8
	v_perm_b32 v170, v165, v170, v69
	v_perm_b32 v174, v179, v180, v69
	v_cndmask_b32_e64 v177, v222, 0, vcc
	v_cndmask_b32_e64 v179, v92, 0, vcc
	v_cndmask_b32_e64 v180, v93, 0, s[2:3]
	v_and_or_b32 v93, v147, v145, v172
	v_and_or_b32 v171, v80, v81, v171
	v_perm_b32 v80, v83, v146, s34
	v_perm_b32 v81, v83, v146, s35
	v_min_i32_e32 v144, 11, v203
	v_and_or_b32 v189, v166, v71, v68
	ds_read2st64_b64 v[68:71], v209 offset1:8
	v_cndmask_b32_e64 v143, v143, 0, s[2:3]
	v_add_u32_e32 v209, 0x7f7f7f78, v177
	v_perm_b32 v92, v95, v93, s34
	v_perm_b32 v93, v95, v93, s35
	v_add_u32_e32 v148, 0x7f7f7f00, v179
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[182:183], v[80:81], v[40:43]
	v_and_b32_e32 v151, 0x7070707, v56
	v_lshrrev_b32_e32 v163, 4, v51
	v_mul_lo_u32 v144, v144, s33
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[184:185], v[80:81], v[60:63]
	v_and_or_b32 v81, v174, v96, v170
	v_sub_u32_e32 v221, 0x6c686080, v160
	v_add_u32_e32 v145, 0x7f7f7f78, v143
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[182:183], v[92:93], v[32:35]
	v_add_u32_e32 v172, 0x7f7f7f00, v180
	v_perm_b32 v80, v189, v81, s34
	v_perm_b32 v81, v189, v81, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[184:185], v[92:93], v[36:39]
	v_perm_b32 v92, v79, v171, s34
	v_perm_b32 v93, v79, v171, s35
	v_and_b32_e32 v171, 0x80808080, v209
	v_and_b32_e32 v148, 0x80808000, v148
	v_lshrrev_b32_e32 v181, 4, v56
	v_lshlrev_b32_e32 v153, 4, v56
	v_and_b32_e32 v149, 0x7070707, v52
	v_and_b32_e32 v207, 0x7070707, v163
	v_or_b32_e32 v163, s37, v141
	v_sub_u32_e32 v220, 0x6c686080, v144
	v_sub_u32_e32 v160, 0x7c787470, v160
	v_and_b32_e32 v176, 0xffffff00, v221
	v_perm_b32 v173, v177, v179, v151
	v_and_b32_e32 v218, 0x80808080, v145
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[182:183], v[80:81], v[64:67]
	v_and_b32_e32 v172, 0x80808000, v172
	v_lshlrev_b32_e32 v152, 4, v52
	v_and_b32_e32 v181, 0x7070707, v181
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[184:185], v[80:81], v[88:91]
	v_perm_b32 v80, v171, v148, v151
	v_cmp_lt_i32_e64 s[4:5], 11, v203
	v_sub_u32_e32 v144, 0x7c787470, v144
	ds_read2st64_b64 v[166:169], v163 offset1:8
	v_and_b32_e32 v175, 0xffffff00, v220
	v_cndmask_b32_e64 v160, v160, 0, s[6:7]
	v_cndmask_b32_e64 v176, v176, 0, s[6:7]
	v_perm_b32 v83, v143, v180, v149
	v_and_or_b32 v81, v80, v153, v173
	v_perm_b32 v80, v218, v172, v149
	v_lshrrev_b32_e32 v186, 4, v53
	v_lshrrev_b32_e32 v187, 4, v58
	v_lshrrev_b32_e32 v199, 4, v59
	v_lshrrev_b32_e32 v202, 4, v55
	v_cndmask_b32_e64 v144, v144, 0, s[4:5]
	v_cndmask_b32_e64 v175, v175, 0, s[4:5]
	v_add_u32_e32 v95, 0x7f7f7f78, v160
	v_perm_b32 v79, v177, v179, v181
	v_add_u32_e32 v96, 0x7f7f7f00, v176
	v_and_or_b32 v83, v80, v152, v83
	v_perm_b32 v80, v171, v148, v181
	v_and_b32_e32 v156, 0x7070707, v57
	v_and_b32_e32 v157, 0x7070707, v53
	v_and_b32_e32 v158, 0x7070707, v58
	v_and_b32_e32 v105, 0x7070707, v54
	v_and_b32_e32 v76, 0x7070707, v59
	v_and_b32_e32 v106, 0x7070707, v55
	v_lshrrev_b32_e32 v194, 4, v48
	v_and_b32_e32 v98, 0x7070707, v44
	v_and_b32_e32 v186, 0x7070707, v186
	v_and_b32_e32 v187, 0x7070707, v187
	v_and_b32_e32 v199, 0x7070707, v199
	v_and_b32_e32 v202, 0x7070707, v202
	v_add_u32_e32 v147, 0x7f7f7f78, v144
	v_perm_b32 v146, v143, v180, v197
	v_add_u32_e32 v209, 0x7f7f7f00, v175
	v_and_b32_e32 v95, 0x80808080, v95
	v_and_or_b32 v56, v80, v56, v79
	v_perm_b32 v80, v218, v172, v197
	v_and_b32_e32 v181, 0x80808000, v96
	v_and_b32_e32 v77, 0x7070707, v48
	v_lshlrev_b32_e32 v100, 4, v44
	v_lshrrev_b32_e32 v164, 4, v49
	v_and_b32_e32 v194, 0x7070707, v194
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[182:183], v[92:93], v[72:75]
	v_and_b32_e32 v170, 0x80808080, v147
	v_perm_b32 v182, v177, v179, v156
	v_perm_b32 v183, v177, v179, v200
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[184:185], v[92:93], v[84:87]
	v_perm_b32 v92, v160, v176, v98
	v_perm_b32 v184, v143, v180, v157
	v_perm_b32 v185, v143, v180, v186
	v_perm_b32 v189, v177, v179, v158
	v_perm_b32 v151, v177, v179, v187
	v_perm_b32 v153, v143, v180, v105
	v_perm_b32 v149, v143, v180, v201
	v_perm_b32 v152, v177, v179, v76
	v_perm_b32 v173, v177, v179, v199
	v_perm_b32 v177, v143, v180, v106
	v_perm_b32 v143, v143, v180, v202
	v_and_b32_e32 v180, 0x80808000, v209
	v_and_or_b32 v52, v80, v52, v146
	v_perm_b32 v80, v95, v181, v98
	v_lshlrev_b32_e32 v97, 4, v48
	v_and_b32_e32 v203, 0x7070707, v164
	v_or_b32_e32 v164, s37, v142
	v_perm_b32 v145, v144, v175, v77
	v_perm_b32 v147, v144, v175, v194
	v_perm_b32 v174, v160, v176, v198
	v_perm_b32 v77, v170, v180, v77
	v_and_or_b32 v96, v80, v100, v92
	v_perm_b32 v80, v56, v81, s34
	v_perm_b32 v81, v56, v81, s35
	v_perm_b32 v92, v52, v83, s34
	v_perm_b32 v93, v52, v83, s35
	v_perm_b32 v52, v170, v180, v194
	v_perm_b32 v56, v95, v181, v198
	ds_read2st64_b64 v[162:165], v164 offset1:8
	v_and_or_b32 v77, v77, v97, v145
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[190:191], v[80:81], v[32:35]
	v_and_or_b32 v48, v52, v48, v147
	v_and_or_b32 v44, v56, v44, v174
	v_lshlrev_b32_e32 v155, 4, v57
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[192:193], v[80:81], v[36:39]
	v_perm_b32 v80, v48, v77, s34
	v_perm_b32 v81, v48, v77, s35
	v_perm_b32 v48, v171, v148, v200
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[190:191], v[92:93], v[40:43]
	v_lshlrev_b32_e32 v154, 4, v53
	v_and_b32_e32 v99, 0x7070707, v49
	v_perm_b32 v52, v218, v172, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[192:193], v[92:93], v[60:63]
	v_perm_b32 v92, v44, v96, s34
	v_perm_b32 v93, v44, v96, s35
	v_perm_b32 v44, v171, v148, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[190:191], v[80:81], v[72:75]
	v_perm_b32 v77, v218, v172, v186
	v_and_or_b32 v44, v44, v155, v182
	v_and_or_b32 v48, v48, v57, v183
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[192:193], v[80:81], v[84:87]
	v_lshlrev_b32_e32 v82, 4, v49
	v_and_b32_e32 v161, 0x7070707, v45
	v_perm_b32 v179, v144, v175, v99
	v_perm_b32 v97, v144, v175, v203
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[190:191], v[92:93], v[64:67]
	v_perm_b32 v56, v48, v44, s34
	v_perm_b32 v57, v48, v44, s35
	v_perm_b32 v44, v170, v180, v99
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[192:193], v[92:93], v[88:91]
	v_perm_b32 v48, v170, v180, v203
	v_and_or_b32 v80, v52, v154, v184
	v_and_or_b32 v53, v77, v53, v185
	v_lshlrev_b32_e32 v103, 4, v45
	v_perm_b32 v145, v160, v176, v161
	v_perm_b32 v79, v160, v176, v204
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[166:167], v[56:57], v[32:35]
	v_perm_b32 v52, v53, v80, s34
	v_perm_b32 v53, v53, v80, s35
	v_and_or_b32 v44, v44, v82, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[168:169], v[56:57], v[36:39]
	v_perm_b32 v56, v95, v181, v161
	v_perm_b32 v57, v95, v181, v204
	v_and_or_b32 v49, v48, v49, v97
	v_lshlrev_b32_e32 v150, 4, v58
	v_perm_b32 v96, v171, v148, v158
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[166:167], v[52:53], v[40:43]
	v_perm_b32 v48, v49, v44, s34
	v_perm_b32 v49, v49, v44, s35
	v_and_or_b32 v56, v56, v103, v145
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[168:169], v[52:53], v[60:63]
	v_perm_b32 v52, v171, v148, v187
	v_and_or_b32 v45, v57, v45, v79
	v_lshlrev_b32_e32 v104, 4, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[166:167], v[48:49], v[72:75]
	v_perm_b32 v53, v218, v172, v105
	v_perm_b32 v44, v45, v56, s34
	v_perm_b32 v45, v45, v56, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[168:169], v[48:49], v[84:87]
	v_perm_b32 v48, v218, v172, v201
	v_and_or_b32 v49, v96, v150, v189
	v_and_or_b32 v52, v52, v58, v151
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[166:167], v[44:45], v[64:67]
	v_and_or_b32 v53, v53, v104, v153
	v_and_b32_e32 v102, 0x7070707, v50
	v_and_b32_e32 v159, 0x7070707, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[168:169], v[44:45], v[88:91]
	v_perm_b32 v44, v52, v49, s34
	v_perm_b32 v45, v52, v49, s35
	v_and_or_b32 v49, v48, v54, v149
	v_perm_b32 v48, v49, v53, s34
	v_perm_b32 v49, v49, v53, s35
	v_lshlrev_b32_e32 v78, 4, v50
	v_lshlrev_b32_e32 v101, 4, v46
	v_perm_b32 v146, v144, v175, v102
	v_perm_b32 v98, v144, v175, v205
	v_perm_b32 v100, v160, v176, v159
	v_perm_b32 v197, v160, v176, v206
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[162:163], v[48:49], v[40:43]
	v_lshlrev_b32_e32 v188, 4, v59
	v_lshlrev_b32_e32 v107, 4, v55
	v_and_b32_e32 v94, 0x7070707, v51
	v_perm_b32 v40, v170, v180, v102
	v_perm_b32 v41, v170, v180, v205
	v_perm_b32 v42, v95, v181, v159
	v_perm_b32 v43, v95, v181, v206
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[162:163], v[44:45], v[32:35]
	v_and_or_b32 v41, v41, v50, v98
	v_and_or_b32 v43, v43, v46, v197
	v_perm_b32 v46, v218, v172, v106
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[164:165], v[44:45], v[36:39]
	v_and_or_b32 v44, v40, v78, v146
	v_and_or_b32 v45, v42, v101, v100
	v_perm_b32 v40, v41, v44, s34
	v_perm_b32 v41, v41, v44, s35
	v_perm_b32 v42, v43, v45, s34
	v_perm_b32 v43, v43, v45, s35
	v_perm_b32 v44, v171, v148, v76
	v_perm_b32 v45, v171, v148, v199
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[162:163], v[40:41], v[72:75]
	v_and_b32_e32 v195, 0x7070707, v47
	v_perm_b32 v209, v144, v175, v94
	v_perm_b32 v175, v144, v175, v207
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[164:165], v[40:41], v[80:83]
	v_and_or_b32 v40, v44, v188, v152
	v_and_or_b32 v41, v45, v59, v173
	v_perm_b32 v44, v41, v40, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[164:165], v[48:49], v[60:63]
	v_perm_b32 v48, v218, v172, v202
	v_perm_b32 v45, v41, v40, s35
	v_and_or_b32 v46, v46, v107, v177
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[162:163], v[42:43], v[64:67]
	v_lshlrev_b32_e32 v178, 4, v51
	v_lshlrev_b32_e32 v196, 4, v47
	v_perm_b32 v219, v160, v176, v195
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[164:165], v[42:43], v[84:87]
	v_perm_b32 v160, v160, v176, v208
	s_xor_b32 s2, s37, 0x2000
	s_mov_b32 s44, s36
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[68:69], v[44:45], v[32:35]
	s_cmp_lg_u32 s36, 15
	s_nop 1
	v_and_or_b32 v33, v48, v55, v143
	v_perm_b32 v32, v33, v46, s34
	v_perm_b32 v33, v33, v46, s35
	v_perm_b32 v34, v170, v180, v94
	v_perm_b32 v35, v170, v180, v207
	v_perm_b32 v46, v95, v181, v195
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[70:71], v[44:45], v[36:39]
	v_and_or_b32 v34, v34, v178, v209
	v_and_or_b32 v35, v35, v51, v175
	v_perm_b32 v48, v35, v34, s34
	v_perm_b32 v36, v95, v181, v208
	v_and_or_b32 v37, v46, v196, v219
	v_and_or_b32 v36, v36, v47, v160
	v_perm_b32 v49, v35, v34, s35
	v_perm_b32 v44, v36, v37, s34
	v_perm_b32 v45, v36, v37, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[68:69], v[32:33], v[88:91]
	v_or_b32_e32 v46, s2, v134
	v_or_b32_e32 v47, s2, v135
	s_waitcnt vmcnt(11)
	ds_write_b128 v46, v[210:213]
	s_waitcnt vmcnt(10)
	ds_write_b128 v47, v[214:217]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[70:71], v[32:33], v[96:99]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[68:69], v[48:49], v[100:103]
	s_waitcnt vmcnt(8)
	s_nop 0
	v_mov_b32_e32 v96, v121
	v_mov_b32_e32 v98, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[68:69], v[44:45], v[144:147]
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[70:71], v[48:49], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[70:71], v[44:45], v[56:59]
	s_cbranch_scc1 .LBB0_2
	v_sub_u32_sdwa v44, v111, v122 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v45, 11, v44
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v45, v45, s2
	v_sub_u32_e32 v46, 0x6c686080, v45
	v_and_b32_e32 v46, 0xffffff00, v46
	v_cmp_lt_i32_e32 vcc, 11, v44
	v_sub_u32_e32 v45, 0x7c787470, v45
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v47, 4, v28
	v_cndmask_b32_e64 v76, v46, 0, vcc
	v_cndmask_b32_e64 v77, v45, 0, vcc
	v_add_u32_e32 v44, 0x7f7f7f00, v76
	v_and_b32_e32 v78, 0x80808000, v44
	v_add_u32_e32 v44, 0x7f7f7f78, v77
	v_and_b32_e32 v79, 0x80808080, v44
	v_sub_u32_sdwa v44, v112, v121 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v45, 11, v44
	v_mul_lo_u32 v45, v45, s2
	v_sub_u32_e32 v46, 0x6c686080, v45
	v_and_b32_e32 v46, 0xffffff00, v46
	v_cmp_lt_i32_e32 vcc, 11, v44
	v_sub_u32_e32 v45, 0x7c787470, v45
	s_load_dwordx2 s[4:5], s[0:1], 0x40
	v_cndmask_b32_e64 v80, v46, 0, vcc
	v_cndmask_b32_e64 v81, v45, 0, vcc
	v_add_u32_e32 v44, 0x7f7f7f00, v80
	v_and_b32_e32 v82, 0x80808000, v44
	v_add_u32_e32 v44, 0x7f7f7f78, v81
	v_and_b32_e32 v83, 0x80808080, v44
	v_and_b32_e32 v44, 0x7070707, v28
	v_lshrrev_b32_e32 v45, 4, v28
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v46, v79, v78, v44
	v_perm_b32 v44, v77, v76, v44
	v_and_or_b32 v44, v46, v47, v44
	v_perm_b32 v46, v79, v78, v45
	v_perm_b32 v45, v77, v76, v45
	v_and_or_b32 v28, v46, v28, v45
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_perm_b32 v48, v28, v44, s0
	v_perm_b32 v49, v28, v44, s1
	v_add_u32_e32 v44, v116, v125
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[68:71], v44 offset0:16 offset1:24
	v_and_b32_e32 v28, 0x7070707, v24
	v_lshrrev_b32_e32 v44, 4, v24
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v83, v82, v28
	v_lshlrev_b32_e32 v46, 4, v24
	v_perm_b32 v28, v81, v80, v28
	v_and_or_b32 v28, v45, v46, v28
	v_perm_b32 v45, v83, v82, v44
	v_perm_b32 v44, v81, v80, v44
	v_and_or_b32 v24, v45, v24, v44
	v_sub_u32_sdwa v92, v111, v122 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v52, v24, v28, s0
	v_perm_b32 v53, v24, v28, s1
	v_min_i32_e32 v24, 11, v92
	v_mul_lo_u32 v24, v24, s2
	v_sub_u32_e32 v28, 0x6c686080, v24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[68:69], v[48:49], v[40:43]
	v_lshlrev_b32_e32 v57, 4, v29
	v_lshlrev_b32_e32 v58, 4, v25
	v_cmp_lt_i32_e32 vcc, 11, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[70:71], v[48:49], v[60:63]
	s_mov_b32 s7, 0x27000
	s_lshl_b32 s14, s18, 2
	s_and_b32 s13, s11, 0xffff
	v_and_b32_e32 v60, 0xffffff00, v28
	v_sub_u32_e32 v61, 0x7c787470, v24
	v_and_b32_e32 v24, 0x7070707, v29
	v_lshrrev_b32_e32 v28, 4, v29
	v_and_b32_e32 v28, 0x7070707, v28
	v_perm_b32 v56, v79, v78, v24
	v_perm_b32 v24, v77, v76, v24
	v_and_or_b32 v24, v56, v57, v24
	v_perm_b32 v56, v79, v78, v28
	v_perm_b32 v28, v77, v76, v28
	v_and_or_b32 v29, v56, v29, v28
	v_add_u32_e32 v56, v116, v124
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[68:69], v[52:53], v[64:67]
	v_perm_b32 v28, v29, v24, s0
	v_perm_b32 v29, v29, v24, s1
	v_and_b32_e32 v24, 0x7070707, v25
	ds_read2st64_b64 v[64:67], v56 offset0:16 offset1:24
	v_lshrrev_b32_e32 v56, 4, v25
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[70:71], v[52:53], v[72:75]
	v_and_b32_e32 v56, 0x7070707, v56
	v_perm_b32 v57, v83, v82, v24
	v_perm_b32 v24, v81, v80, v24
	v_and_or_b32 v62, v57, v58, v24
	v_perm_b32 v24, v83, v82, v56
	v_perm_b32 v63, v81, v80, v56
	v_and_or_b32 v25, v24, v25, v63
	v_perm_b32 v24, v25, v62, s0
	v_perm_b32 v25, v25, v62, s1
	v_cndmask_b32_e64 v93, v61, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[64:65], v[28:29], v[40:43]
	v_cndmask_b32_e64 v92, v60, 0, vcc
	v_lshlrev_b32_e32 v60, 4, v26
	v_sub_u32_sdwa v72, v112, v121 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[64:65], v[24:25], v[44:47]
	v_add_u32_e32 v40, 0x7f7f7f00, v92
	v_and_b32_e32 v94, 0x80808000, v40
	v_lshlrev_b32_e32 v62, 4, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[66:67], v[28:29], v[48:51]
	v_add_u32_e32 v28, 0x7f7f7f78, v93
	v_and_b32_e32 v95, 0x80808080, v28
	v_lshlrev_b32_e32 v29, 4, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[66:67], v[24:25], v[52:55]
	v_and_b32_e32 v24, 0x7070707, v30
	v_perm_b32 v28, v79, v78, v24
	v_perm_b32 v24, v77, v76, v24
	v_lshrrev_b32_e32 v25, 4, v30
	v_and_or_b32 v28, v28, v29, v24
	v_add_u32_e32 v29, v116, v123
	v_and_b32_e32 v25, 0x7070707, v25
	ds_read2st64_b64 v[40:43], v29 offset0:16 offset1:24
	v_perm_b32 v24, v79, v78, v25
	v_perm_b32 v25, v77, v76, v25
	v_and_or_b32 v25, v24, v30, v25
	v_perm_b32 v24, v25, v28, s0
	v_perm_b32 v25, v25, v28, s1
	v_and_b32_e32 v28, 0x7070707, v26
	v_lshrrev_b32_e32 v29, 4, v26
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v30, v83, v82, v28
	v_perm_b32 v28, v81, v80, v28
	v_and_or_b32 v30, v30, v60, v28
	v_perm_b32 v28, v83, v82, v29
	v_perm_b32 v29, v81, v80, v29
	v_and_or_b32 v26, v28, v26, v29
	v_perm_b32 v28, v26, v30, s0
	v_perm_b32 v29, v26, v30, s1
	v_min_i32_e32 v26, 11, v72
	v_mul_lo_u32 v26, v26, s2
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[40:41], v[24:25], v[56:59]
	v_sub_u32_e32 v74, 0x7c787470, v26
	v_cmp_lt_i32_e32 vcc, 11, v72
	s_mov_b32 s12, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[42:43], v[24:25], v[48:51]
	v_sub_u32_e32 v24, 0x6c686080, v26
	v_and_b32_e32 v73, 0xffffff00, v24
	v_and_b32_e32 v24, 0x7070707, v31
	v_lshrrev_b32_e32 v25, 4, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[40:41], v[28:29], v[44:47]
	v_and_b32_e32 v25, 0x7070707, v25
	v_perm_b32 v26, v79, v78, v24
	v_perm_b32 v24, v77, v76, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[42:43], v[28:29], v[52:55]
	v_lshlrev_b32_e32 v28, 4, v31
	v_and_or_b32 v24, v26, v28, v24
	v_perm_b32 v26, v79, v78, v25
	v_perm_b32 v25, v77, v76, v25
	v_and_or_b32 v25, v26, v31, v25
	v_perm_b32 v60, v25, v24, s0
	v_perm_b32 v61, v25, v24, s1
	v_add_u32_e32 v25, v116, v120
	ds_read2st64_b64 v[28:31], v25 offset0:16 offset1:24
	v_and_b32_e32 v24, 0x7070707, v27
	v_lshrrev_b32_e32 v25, 4, v27
	v_and_b32_e32 v25, 0x7070707, v25
	v_perm_b32 v26, v83, v82, v24
	v_perm_b32 v24, v81, v80, v24
	v_and_or_b32 v24, v26, v62, v24
	v_perm_b32 v26, v83, v82, v25
	v_perm_b32 v25, v81, v80, v25
	v_and_or_b32 v25, v26, v27, v25
	v_perm_b32 v62, v25, v24, s0
	v_perm_b32 v63, v25, v24, s1
	v_cndmask_b32_e64 v82, v73, 0, vcc
	v_cndmask_b32_e64 v83, v74, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[28:29], v[62:63], v[44:47]
	s_mov_b32 s15, s7
	s_lshl_b32 s6, s20, 9
	s_and_b32 s5, s5, 0xffff
	v_add_u32_e32 v44, 0x7f7f7f00, v82
	v_and_b32_e32 v96, 0x80808000, v44
	v_add_u32_e32 v44, 0x7f7f7f78, v83
	v_and_b32_e32 v97, 0x80808080, v44
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v44, 0x7070707, v20
	v_lshrrev_b32_e32 v45, 4, v20
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v46, v95, v94, v44
	v_lshlrev_b32_e32 v47, 4, v20
	v_perm_b32 v44, v93, v92, v44
	v_and_or_b32 v44, v46, v47, v44
	v_perm_b32 v46, v95, v94, v45
	v_perm_b32 v45, v93, v92, v45
	v_and_or_b32 v20, v46, v20, v45
	v_perm_b32 v72, v20, v44, s0
	v_perm_b32 v73, v20, v44, s1
	v_add_u32_e32 v44, v116, v119
	ds_read2st64_b64 v[44:47], v44 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[28:29], v[60:61], v[56:59]
	v_and_b32_e32 v20, 0x7070707, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[30:31], v[60:61], v[48:51]
	v_lshrrev_b32_e32 v60, 4, v16
	v_and_b32_e32 v60, 0x7070707, v60
	v_perm_b32 v61, v97, v96, v20
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[30:31], v[62:63], v[52:55]
	v_lshlrev_b32_e32 v62, 4, v16
	v_perm_b32 v20, v83, v82, v20
	v_and_or_b32 v20, v61, v62, v20
	v_perm_b32 v61, v97, v96, v60
	v_perm_b32 v60, v83, v82, v60
	v_and_or_b32 v16, v61, v16, v60
	v_perm_b32 v74, v16, v20, s0
	v_perm_b32 v75, v16, v20, s1
	v_and_b32_e32 v16, 0x7070707, v21
	v_lshrrev_b32_e32 v20, 4, v21
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[44:45], v[74:75], v[24:27]
	v_and_b32_e32 v20, 0x7070707, v20
	s_nop 1
	v_perm_b32 v24, v95, v94, v16
	v_lshlrev_b32_e32 v25, 4, v21
	v_perm_b32 v16, v93, v92, v16
	v_and_or_b32 v16, v24, v25, v16
	v_perm_b32 v24, v95, v94, v20
	v_perm_b32 v20, v93, v92, v20
	v_and_or_b32 v21, v24, v21, v20
	v_add_u32_e32 v24, v116, v118
	ds_read2st64_b64 v[24:27], v24 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[44:45], v[72:73], v[56:59]
	v_perm_b32 v20, v21, v16, s0
	v_perm_b32 v21, v21, v16, s1
	v_and_b32_e32 v16, 0x7070707, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[46:47], v[72:73], v[48:51]
	v_lshrrev_b32_e32 v72, 4, v17
	v_and_b32_e32 v72, 0x7070707, v72
	v_perm_b32 v73, v97, v96, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[46:47], v[74:75], v[52:55]
	v_lshlrev_b32_e32 v74, 4, v17
	v_perm_b32 v16, v83, v82, v16
	v_and_or_b32 v73, v73, v74, v16
	v_perm_b32 v16, v97, v96, v72
	v_perm_b32 v72, v83, v82, v72
	v_and_or_b32 v17, v16, v17, v72
	v_perm_b32 v16, v17, v73, s0
	v_perm_b32 v17, v17, v73, s1
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[24:25], v[20:21], v[56:59]
	v_lshlrev_b32_e32 v72, 4, v18
	v_bfe_u32 v73, v122, s17, 8
	v_sub_u32_e32 v73, v109, v73
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[24:25], v[16:17], v[60:63]
	v_cmp_lt_i32_e32 vcc, 11, v73
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[26:27], v[16:17], v[52:55]
	v_and_b32_e32 v16, 0x7070707, v22
	v_lshrrev_b32_e32 v17, 4, v22
	v_and_b32_e32 v17, 0x7070707, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[26:27], v[20:21], v[48:51]
	v_perm_b32 v20, v95, v94, v16
	v_lshlrev_b32_e32 v21, 4, v22
	v_perm_b32 v16, v93, v92, v16
	v_and_or_b32 v20, v20, v21, v16
	v_add_u32_e32 v21, v116, v117
	ds_read2st64_b64 v[48:51], v21 offset0:16 offset1:24
	v_perm_b32 v16, v95, v94, v17
	v_perm_b32 v17, v93, v92, v17
	v_and_or_b32 v17, v16, v22, v17
	v_perm_b32 v16, v17, v20, s0
	v_perm_b32 v17, v17, v20, s1
	v_and_b32_e32 v20, 0x7070707, v18
	v_lshrrev_b32_e32 v21, 4, v18
	v_and_b32_e32 v21, 0x7070707, v21
	v_perm_b32 v22, v97, v96, v20
	v_perm_b32 v20, v83, v82, v20
	v_and_or_b32 v22, v22, v72, v20
	v_perm_b32 v20, v97, v96, v21
	v_perm_b32 v21, v83, v82, v21
	v_and_or_b32 v18, v20, v18, v21
	v_perm_b32 v20, v18, v22, s0
	v_perm_b32 v21, v18, v22, s1
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[48:49], v[16:17], v[56:59]
	v_lshlrev_b32_e32 v22, 4, v19
	v_add_u32_e32 v72, s8, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[50:51], v[20:21], v[52:55]
	s_nop 2
	ds_read2st64_b64 v[52:55], v115 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[50:51], v[16:17], v[74:77]
	v_and_b32_e32 v16, 0x7070707, v23
	v_lshrrev_b32_e32 v17, 4, v23
	v_and_b32_e32 v17, 0x7070707, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[48:49], v[20:21], v[60:63]
	v_perm_b32 v18, v95, v94, v16
	v_lshlrev_b32_e32 v20, 4, v23
	v_perm_b32 v16, v93, v92, v16
	v_and_or_b32 v18, v18, v20, v16
	v_perm_b32 v16, v95, v94, v17
	v_perm_b32 v17, v93, v92, v17
	v_and_or_b32 v17, v16, v23, v17
	v_perm_b32 v16, v17, v18, s0
	v_perm_b32 v17, v17, v18, s1
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v20, 4, v19
	v_and_b32_e32 v20, 0x7070707, v20
	v_perm_b32 v21, v97, v96, v18
	v_perm_b32 v18, v83, v82, v18
	v_and_or_b32 v18, v21, v22, v18
	v_perm_b32 v21, v97, v96, v20
	v_perm_b32 v20, v83, v82, v20
	v_and_or_b32 v19, v21, v19, v20
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[52:53], v[16:17], v[56:59]
	v_perm_b32 v20, v19, v18, s0
	v_perm_b32 v21, v19, v18, s1
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[54:55], v[16:17], v[74:77]
	s_nop 2
	v_min_i32_e32 v77, 11, v73
	v_mul_lo_u32 v77, v77, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[52:53], v[20:21], v[60:63]
	v_bfe_u32 v74, v122, s21, 8
	v_sub_u32_e32 v74, v109, v74
	v_bfe_u32 v75, v121, s9, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[54:55], v[20:21], v[78:81]
	v_bfe_u32 v76, v121, s16, 8
	v_sub_u32_e32 v103, v110, v76
	s_nop 0
	v_sub_u32_e32 v78, 0x6c686080, v77
	v_and_b32_e32 v78, 0xffffff00, v78
	v_sub_u32_e32 v77, 0x7c787470, v77
	v_cndmask_b32_e64 v73, v78, 0, vcc
	v_cndmask_b32_e64 v92, v77, 0, vcc
	v_add_u32_e32 v77, 0x7f7f7f00, v73
	v_and_b32_e32 v93, 0x80808000, v77
	v_add_u32_e32 v77, 0x7f7f7f78, v92
	v_and_b32_e32 v94, 0x80808080, v77
	v_min_i32_e32 v77, 11, v74
	v_mul_lo_u32 v77, v77, s2
	v_sub_u32_e32 v78, 0x6c686080, v77
	v_and_b32_e32 v78, 0xffffff00, v78
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v77, 0x7c787470, v77
	v_lshlrev_b32_e32 v79, 4, v12
	v_cndmask_b32_e64 v95, v78, 0, vcc
	v_cndmask_b32_e64 v96, v77, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v95
	v_and_b32_e32 v97, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v96
	v_and_b32_e32 v98, 0x80808080, v74
	v_sub_u32_e32 v74, v110, v75
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s2
	v_sub_u32_e32 v77, 0x6c686080, v75
	v_and_b32_e32 v77, 0xffffff00, v77
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_lshlrev_b32_e32 v78, 4, v8
	v_cndmask_b32_e64 v99, v77, 0, vcc
	v_cndmask_b32_e64 v100, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v99
	v_and_b32_e32 v101, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v100
	v_and_b32_e32 v102, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v8
	v_lshrrev_b32_e32 v75, 4, v8
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v77, v94, v93, v74
	v_perm_b32 v74, v92, v73, v74
	v_and_or_b32 v77, v77, v78, v74
	v_perm_b32 v74, v94, v93, v75
	v_perm_b32 v75, v92, v73, v75
	v_and_or_b32 v8, v74, v8, v75
	v_perm_b32 v74, v8, v77, s0
	v_perm_b32 v75, v8, v77, s1
	v_and_b32_e32 v8, 0x7070707, v12
	v_lshrrev_b32_e32 v77, 4, v12
	v_and_b32_e32 v77, 0x7070707, v77
	v_perm_b32 v78, v102, v101, v8
	v_perm_b32 v8, v100, v99, v8
	v_and_or_b32 v8, v78, v79, v8
	v_perm_b32 v78, v102, v101, v77
	v_perm_b32 v77, v100, v99, v77
	v_and_or_b32 v12, v78, v12, v77
	v_perm_b32 v78, v12, v8, s0
	v_perm_b32 v79, v12, v8, s1
	v_min_i32_e32 v8, 11, v103
	v_mul_lo_u32 v8, v8, s2
	v_sub_u32_e32 v12, 0x6c686080, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[68:69], v[74:75], v[32:35]
	v_lshlrev_b32_e32 v80, 4, v13
	v_cmp_lt_i32_e32 vcc, 11, v103
	s_mov_b32 s2, 0xbfb8aa3b
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[70:71], v[74:75], v[84:87]
	s_nop 2
	v_and_b32_e32 v86, 0xffffff00, v12
	v_sub_u32_e32 v87, 0x7c787470, v8
	v_and_b32_e32 v8, 0x7070707, v9
	v_lshrrev_b32_e32 v12, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[68:69], v[78:79], v[36:39]
	v_and_b32_e32 v12, 0x7070707, v12
	v_cndmask_b32_e64 v87, v87, 0, vcc
	v_cndmask_b32_e64 v86, v86, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[70:71], v[78:79], v[88:91]
	v_perm_b32 v78, v94, v93, v8
	v_lshlrev_b32_e32 v79, 4, v9
	v_perm_b32 v8, v92, v73, v8
	v_and_or_b32 v78, v78, v79, v8
	v_perm_b32 v8, v94, v93, v12
	v_perm_b32 v12, v92, v73, v12
	v_and_or_b32 v9, v8, v9, v12
	v_perm_b32 v8, v9, v78, s0
	v_perm_b32 v9, v9, v78, s1
	v_and_b32_e32 v12, 0x7070707, v13
	v_lshrrev_b32_e32 v78, 4, v13
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v102, v101, v12
	v_perm_b32 v12, v100, v99, v12
	v_and_or_b32 v82, v79, v80, v12
	v_perm_b32 v12, v102, v101, v78
	v_perm_b32 v83, v100, v99, v78
	v_and_or_b32 v13, v12, v13, v83
	v_perm_b32 v12, v13, v82, s0
	v_perm_b32 v13, v13, v82, s1
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[64:65], v[8:9], v[32:35]
	v_cmp_lt_i32_e32 vcc, 5, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[64:65], v[12:13], v[36:39]
	s_nop 0
	v_add_u32_e32 v32, 0x7f7f7f00, v86
	v_and_b32_e32 v88, 0x80808000, v32
	v_lshrrev_b32_e32 v64, 4, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[66:67], v[8:9], v[74:77]
	v_add_u32_e32 v8, 0x7f7f7f78, v87
	v_and_b32_e32 v89, 0x80808080, v8
	v_and_b32_e32 v8, 0x7070707, v10
	v_lshrrev_b32_e32 v9, 4, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[66:67], v[12:13], v[68:71]
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v12, v94, v93, v8
	v_lshlrev_b32_e32 v13, 4, v10
	v_perm_b32 v8, v92, v73, v8
	v_lshl_or_b32 v74, v113, 2, s19
	v_and_or_b32 v13, v12, v13, v8
	v_perm_b32 v8, v94, v93, v9
	v_perm_b32 v9, v92, v73, v9
	v_ashrrev_i32_e32 v75, 31, v74
	v_and_or_b32 v10, v8, v10, v9
	v_lshl_add_u64 v[8:9], v[74:75], 2, s[22:23]
	global_load_dword v75, v[8:9], off
	v_perm_b32 v12, v10, v13, s0
	v_perm_b32 v13, v10, v13, s1
	v_and_b32_e32 v10, 0x7070707, v14
	v_and_b32_e32 v64, 0x7070707, v64
	v_perm_b32 v65, v102, v101, v10
	v_lshlrev_b32_e32 v66, 4, v14
	v_perm_b32 v10, v100, v99, v10
	v_perm_b32 v68, v102, v101, v64
	v_perm_b32 v69, v100, v99, v64
	v_and_or_b32 v10, v65, v66, v10
	v_and_or_b32 v14, v68, v14, v69
	v_perm_b32 v76, v14, v10, s0
	v_perm_b32 v77, v14, v10, s1
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v14, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[40:41], v[12:13], v[78:81]
	v_and_b32_e32 v14, 0x7070707, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[40:41], v[76:77], v[82:85]
	v_perm_b32 v40, v94, v93, v10
	v_lshlrev_b32_e32 v41, 4, v11
	v_perm_b32 v10, v92, v73, v10
	v_and_or_b32 v10, v40, v41, v10
	v_perm_b32 v40, v94, v93, v14
	v_perm_b32 v14, v92, v73, v14
	v_and_or_b32 v11, v40, v11, v14
	v_perm_b32 v40, v11, v10, s0
	v_perm_b32 v41, v11, v10, s1
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v11, 4, v15
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v14, v102, v101, v10
	v_lshlrev_b32_e32 v73, 4, v15
	v_perm_b32 v10, v100, v99, v10
	v_and_or_b32 v10, v14, v73, v10
	v_perm_b32 v14, v102, v101, v11
	v_perm_b32 v11, v100, v99, v11
	v_and_or_b32 v11, v14, v15, v11
	v_perm_b32 v78, v11, v10, s0
	v_perm_b32 v79, v11, v10, s1
	v_and_b32_e32 v10, 0x7070707, v0
	v_lshrrev_b32_e32 v11, 4, v0
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v14, v98, v97, v10
	v_lshlrev_b32_e32 v15, 4, v0
	v_perm_b32 v10, v96, v95, v10
	v_and_or_b32 v10, v14, v15, v10
	v_perm_b32 v14, v98, v97, v11
	v_perm_b32 v11, v96, v95, v11
	v_and_or_b32 v0, v14, v0, v11
	v_perm_b32 v80, v0, v10, s0
	v_perm_b32 v81, v0, v10, s1
	v_and_b32_e32 v0, 0x7070707, v4
	v_lshrrev_b32_e32 v10, 4, v4
	v_and_b32_e32 v10, 0x7070707, v10
	v_perm_b32 v11, v89, v88, v0
	v_lshlrev_b32_e32 v14, 4, v4
	v_perm_b32 v0, v87, v86, v0
	v_and_or_b32 v0, v11, v14, v0
	v_perm_b32 v11, v89, v88, v10
	v_perm_b32 v10, v87, v86, v10
	v_and_or_b32 v4, v11, v4, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[28:29], v[40:41], v[64:67]
	v_perm_b32 v82, v4, v0, s0
	v_perm_b32 v83, v4, v0, s1
	v_and_b32_e32 v0, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[28:29], v[78:79], v[68:71]
	v_lshrrev_b32_e32 v4, 4, v1
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v10, v98, v97, v0
	v_lshlrev_b32_e32 v11, 4, v1
	v_perm_b32 v0, v96, v95, v0
	v_and_or_b32 v0, v10, v11, v0
	v_perm_b32 v10, v98, v97, v4
	v_perm_b32 v4, v96, v95, v4
	v_and_or_b32 v1, v10, v1, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[44:45], v[80:81], v[64:67]
	v_lshlrev_b32_e32 v10, 4, v5
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v73, 0xffffff, v75
	v_add_u32_e32 v29, 17, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[44:45], v[82:83], v[68:71]
	v_perm_b32 v44, v1, v0, s0
	v_perm_b32 v45, v1, v0, s1
	v_lshlrev_b32_e32 v0, 2, v73
	buffer_load_dword v28, v0, s[12:15], 0 offen
	v_and_b32_e32 v0, 0x7070707, v5
	v_lshrrev_b32_e32 v1, 4, v5
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v4, v89, v88, v0
	v_perm_b32 v0, v87, v86, v0
	v_and_or_b32 v0, v4, v10, v0
	v_perm_b32 v4, v89, v88, v1
	v_perm_b32 v1, v87, v86, v1
	v_and_or_b32 v1, v4, v5, v1
	v_perm_b32 v10, v1, v0, s0
	v_perm_b32 v11, v1, v0, s1
	v_and_b32_e32 v0, 0x7070707, v2
	v_lshrrev_b32_e32 v1, 4, v2
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v4, v98, v97, v0
	v_lshlrev_b32_e32 v5, 4, v2
	v_perm_b32 v0, v96, v95, v0
	v_and_or_b32 v0, v4, v5, v0
	v_perm_b32 v4, v98, v97, v1
	v_perm_b32 v1, v96, v95, v1
	v_and_or_b32 v1, v4, v2, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[24:25], v[44:45], v[64:67]
	v_lshlrev_b32_e32 v4, 4, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[24:25], v[10:11], v[68:71]
	v_perm_b32 v24, v1, v0, s0
	v_perm_b32 v25, v1, v0, s1
	v_and_b32_e32 v0, 0x7070707, v6
	v_lshrrev_b32_e32 v1, 4, v6
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v89, v88, v0
	v_perm_b32 v0, v87, v86, v0
	v_and_or_b32 v0, v2, v4, v0
	v_perm_b32 v2, v89, v88, v1
	v_perm_b32 v1, v87, v86, v1
	v_and_or_b32 v1, v2, v6, v1
	v_perm_b32 v14, v1, v0, s0
	v_perm_b32 v15, v1, v0, s1
	v_and_b32_e32 v0, 0x7070707, v3
	v_lshrrev_b32_e32 v1, 4, v3
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v98, v97, v0
	v_lshlrev_b32_e32 v4, 4, v3
	v_perm_b32 v0, v96, v95, v0
	v_and_or_b32 v0, v2, v4, v0
	v_perm_b32 v2, v98, v97, v1
	v_perm_b32 v1, v96, v95, v1
	v_and_or_b32 v1, v2, v3, v1
	v_perm_b32 v4, v1, v0, s0
	v_perm_b32 v5, v1, v0, s1
	v_and_b32_e32 v0, 0x7070707, v7
	v_lshrrev_b32_e32 v1, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[48:49], v[24:25], v[64:67]
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v89, v88, v0
	v_lshlrev_b32_e32 v3, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[48:49], v[14:15], v[68:71]
	v_perm_b32 v0, v87, v86, v0
	v_and_or_b32 v0, v2, v3, v0
	v_perm_b32 v2, v89, v88, v1
	v_perm_b32 v1, v87, v86, v1
	v_and_or_b32 v1, v2, v7, v1
	v_perm_b32 v6, v1, v0, s0
	v_perm_b32 v7, v1, v0, s1
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[52:53], v[4:5], v[64:67]
	v_add_u32_e32 v0, 17, v111
	v_add_u32_e32 v1, 17, v112
	v_lshlrev_b32_e64 v0, v0, 1
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[52:53], v[6:7], v[68:71]
	v_mov_b32_e32 v53, 0xfd800000
	v_lshl_add_u32 v3, v111, 23, v53
	v_lshl_add_u32 v2, v112, 23, v53
	v_lshlrev_b32_e64 v48, v1, 1
	v_cndmask_b32_e32 v1, v0, v3, vcc
	v_cmp_lt_i32_e32 vcc, 5, v112
	v_mov_b32_e32 v49, v56
	v_add_u32_e32 v52, 17, v110
	v_cndmask_b32_e32 v0, v48, v2, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[2:3], v[28:29], v[0:1] op_sel_hi:[0,1]
	v_mov_b32_e32 v48, v60
	v_pk_mul_f32 v[48:49], v[48:49], v[2:3]
	v_lshl_add_u32 v3, v109, 23, v53
	v_lshlrev_b32_e64 v29, v29, 1
	v_cmp_lt_i32_e32 vcc, 5, v109
	v_lshl_add_u32 v2, v110, 23, v53
	v_lshlrev_b32_e64 v52, v52, 1
	v_cndmask_b32_e32 v3, v29, v3, vcc
	v_cmp_lt_i32_e32 vcc, 5, v110
	v_mov_b32_e32 v53, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[42:43], v[12:13], v[36:39]
	v_cndmask_b32_e32 v2, v52, v2, vcc
	v_pk_mul_f32 v[28:29], v[28:29], v[2:3] op_sel_hi:[0,1]
	v_mov_b32_e32 v52, v68
	v_pk_mul_f32 v[28:29], v[52:53], v[28:29]
	v_mov_b32_e32 v52, v49
	v_mov_b32_e32 v53, v29
	v_pk_mul_f32 v[52:53], v[52:53], s[2:3] op_sel_hi:[1,0]
	s_movk_i32 s3, 0x7fff
	v_exp_f32_e32 v52, v52
	v_exp_f32_e32 v53, v53
	v_lshlrev_b32_e32 v56, 8, v74
	v_add_lshl_u32 v60, v56, v108, 1
	v_cmp_gt_i32_e32 vcc, s18, v73
	v_pk_add_f32 v[12:13], v[52:53], 1.0 op_sel_hi:[1,0]
	v_bfrev_b32_e32 v52, -2
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_cndmask_b32_e32 v53, v52, v60, vcc
	v_mov_b32_e32 v64, v69
	v_mul_f32_e32 v12, v49, v12
	v_mul_f32_e32 v12, v48, v12
	v_bfe_u32 v48, v12, 16, 1
	v_add3_u32 v48, v48, v12, s3
	v_or_b32_e32 v49, 0x400000, v12
	v_cmp_u_f32_e64 s[0:1], v12, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[30:31], v[40:41], v[36:39]
	s_nop 0
	v_cndmask_b32_e64 v12, v48, v49, s[0:1]
	v_lshrrev_b32_e32 v12, 16, v12
	buffer_store_short v12, v53, s[4:7], 0 offen
	v_mul_f32_e32 v12, v29, v13
	v_mul_f32_e32 v12, v28, v12
	v_bfe_u32 v13, v12, 16, 1
	v_add_lshl_u32 v48, v72, v56, 1
	v_add3_u32 v13, v13, v12, s3
	v_or_b32_e32 v28, 0x400000, v12
	v_cmp_u_f32_e64 s[0:1], v12, v12
	v_mov_b32_e32 v56, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[42:43], v[76:77], v[32:35]
	v_cndmask_b32_e64 v12, v13, v28, s[0:1]
	v_add_u32_e32 v13, 32, v48
	v_lshrrev_b32_e32 v12, 16, v12
	v_cndmask_b32_e32 v13, v52, v13, vcc
	buffer_store_short v12, v13, s[4:7], 0 offen
	global_load_dword v12, v[8:9], off offset:4
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v49, 0xffffff, v12
	v_lshlrev_b32_e32 v12, 2, v49
	buffer_load_dword v12, v12, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s18, v49
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[12:13], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[56:57], v[28:29]
	v_pk_mul_f32 v[12:13], v[64:65], v[12:13]
	v_mov_b32_e32 v28, v41
	v_mov_b32_e32 v29, v13
	v_pk_mul_f32 v[28:29], v[28:29], s[2:3] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v42, v28
	v_exp_f32_e32 v43, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[30:31], v[78:79], v[32:35]
	s_nop 2
	v_add_f32_e64 v32, v42, 1.0
	v_add_f32_e64 v33, v43, 1.0
	v_add_u32_e32 v34, 0x200, v60
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_cndmask_b32_e32 v34, v52, v34, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[46:47], v[82:83], v[28:31]
	v_mul_f32_e32 v32, v41, v32
	v_mul_f32_e32 v32, v40, v32
	v_bfe_u32 v35, v32, 16, 1
	v_add3_u32 v35, v35, v32, s3
	v_or_b32_e32 v40, 0x400000, v32
	v_cmp_u_f32_e64 s[0:1], v32, v32
	v_mul_f32_e32 v13, v13, v33
	v_mul_f32_e32 v12, v12, v13
	v_cndmask_b32_e64 v32, v35, v40, s[0:1]
	v_lshrrev_b32_e32 v32, 16, v32
	v_bfe_u32 v13, v12, 16, 1
	buffer_store_short v32, v34, s[4:7], 0 offen
	v_add3_u32 v13, v13, v12, s3
	v_or_b32_e32 v32, 0x400000, v12
	v_cmp_u_f32_e64 s[0:1], v12, v12
	v_add_u32_e32 v41, 0x400, v60
	s_nop 0
	v_cndmask_b32_e64 v12, v13, v32, s[0:1]
	v_add_u32_e32 v13, 0x220, v48
	v_lshrrev_b32_e32 v12, 16, v12
	v_cndmask_b32_e32 v13, v52, v13, vcc
	buffer_store_short v12, v13, s[4:7], 0 offen
	global_load_dword v12, v[8:9], off offset:8
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[46:47], v[80:81], v[36:39]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v40, 0xffffff, v12
	v_lshlrev_b32_e32 v12, 2, v40
	buffer_load_dword v12, v12, s[12:15], 0 offen
	v_mov_b32_e32 v38, v62
	v_mov_b32_e32 v39, v58
	v_cmp_gt_i32_e32 vcc, s18, v40
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[26:27], v[44:45], v[32:35]
	v_mov_b32_e32 v58, v63
	v_cndmask_b32_e32 v40, v52, v41, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[36:37], v[12:13], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[36:37], v[38:39], v[36:37]
	v_pk_mul_f32 v[12:13], v[12:13], v[2:3] op_sel_hi:[0,1]
	v_mov_b32_e32 v38, v70
	v_mov_b32_e32 v39, v66
	v_pk_mul_f32 v[12:13], v[38:39], v[12:13]
	v_mov_b32_e32 v38, v37
	v_mov_b32_e32 v39, v13
	v_pk_mul_f32 v[38:39], v[38:39], s[2:3] op_sel_hi:[1,0]
	v_mov_b32_e32 v66, v71
	v_exp_f32_e32 v38, v38
	v_exp_f32_e32 v39, v39
	s_nop 0
	v_pk_add_f32 v[38:39], v[38:39], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v38, v38
	v_rcp_f32_e32 v39, v39
	v_mul_f32_e32 v37, v37, v38
	v_mul_f32_e32 v36, v36, v37
	v_bfe_u32 v37, v36, 16, 1
	v_add3_u32 v37, v37, v36, s3
	v_or_b32_e32 v38, 0x400000, v36
	v_cmp_u_f32_e64 s[0:1], v36, v36
	v_mul_f32_e32 v13, v13, v39
	v_mul_f32_e32 v12, v12, v13
	v_cndmask_b32_e64 v36, v37, v38, s[0:1]
	v_lshrrev_b32_e32 v36, 16, v36
	v_bfe_u32 v13, v12, 16, 1
	buffer_store_short v36, v40, s[4:7], 0 offen
	v_add3_u32 v13, v13, v12, s3
	v_or_b32_e32 v36, 0x400000, v12
	v_cmp_u_f32_e64 s[0:1], v12, v12
	s_nop 1
	v_cndmask_b32_e64 v12, v13, v36, s[0:1]
	v_add_u32_e32 v13, 0x420, v48
	v_lshrrev_b32_e32 v12, 16, v12
	v_cndmask_b32_e32 v13, v52, v13, vcc
	buffer_store_short v12, v13, s[4:7], 0 offen
	global_load_dword v36, v[8:9], off offset:12
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[26:27], v[10:11], v[28:31]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v36, 0xffffff, v36
	v_lshlrev_b32_e32 v26, 2, v36
	buffer_load_dword v28, v26, s[12:15], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[50:51], v[24:25], v[32:35]
	v_cmp_gt_i32_e32 vcc, s18, v36
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[30:31], v[28:29], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[58:59], v[30:31]
	v_pk_mul_f32 v[28:29], v[66:67], v[28:29]
	v_mov_b32_e32 v32, v31
	v_mov_b32_e32 v33, v29
	v_pk_mul_f32 v[32:33], v[32:33], s[2:3] op_sel_hi:[1,0]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[50:51], v[14:15], v[10:13]
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[54:55], v[4:5], v[24:27]
	v_add_f32_e64 v14, v32, 1.0
	v_add_f32_e64 v15, v33, 1.0
	v_add_u32_e32 v32, 0x600, v60
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_cndmask_b32_e32 v32, v52, v32, vcc
	v_mul_f32_e32 v14, v31, v14
	v_mul_f32_e32 v14, v30, v14
	v_bfe_u32 v30, v14, 16, 1
	v_add3_u32 v30, v30, v14, s3
	v_or_b32_e32 v31, 0x400000, v14
	v_cmp_u_f32_e64 s[0:1], v14, v14
	s_nop 1
	v_cndmask_b32_e64 v14, v30, v31, s[0:1]
	v_lshrrev_b32_e32 v14, 16, v14
	buffer_store_short v14, v32, s[4:7], 0 offen
	v_mul_f32_e32 v14, v29, v15
	v_mul_f32_e32 v14, v28, v14
	v_bfe_u32 v15, v14, 16, 1
	v_add3_u32 v15, v15, v14, s3
	v_or_b32_e32 v28, 0x400000, v14
	v_cmp_u_f32_e64 s[0:1], v14, v14
	s_nop 1
	v_cndmask_b32_e64 v14, v15, v28, s[0:1]
	v_add_u32_e32 v15, 0x620, v48
	v_lshrrev_b32_e32 v14, 16, v14
	v_cndmask_b32_e32 v15, v52, v15, vcc
	buffer_store_short v14, v15, s[4:7], 0 offen
	global_load_dword v14, v[8:9], off offset:64
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v30, 0xffffff, v14
	v_lshlrev_b32_e32 v4, 2, v30
	buffer_load_dword v14, v4, s[12:15], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[54:55], v[6:7], v[10:13]
	v_cmp_gt_i32_e32 vcc, s18, v30
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[14:15], v[0:1] op_sel_hi:[0,1]
	v_mov_b32_e32 v10, v20
	v_mov_b32_e32 v11, v16
	s_nop 1
	v_mov_b32_e32 v12, v4
	v_mov_b32_e32 v13, v24
	v_pk_mul_f32 v[14:15], v[14:15], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[28:29]
	v_pk_mul_f32 v[12:13], v[12:13], v[14:15]
	v_mov_b32_e32 v14, v11
	v_mov_b32_e32 v15, v13
	v_pk_mul_f32 v[14:15], v[14:15], s[2:3] op_sel_hi:[1,0]
	v_add_u32_e32 v4, 0x2000, v60
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_add_u32_e32 v16, 0x2020, v48
	v_cndmask_b32_e32 v4, v52, v4, vcc
	v_cndmask_b32_e32 v16, v52, v16, vcc
	v_pk_add_f32 v[14:15], v[14:15], 1.0 op_sel_hi:[1,0]
	v_mov_b32_e32 v24, v5
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_mul_f32_e32 v11, v11, v14
	v_mul_f32_e32 v13, v13, v15
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v11, v12, v13
	v_bfe_u32 v12, v10, 16, 1
	v_or_b32_e32 v13, 0x400000, v10
	v_bfe_u32 v14, v11, 16, 1
	v_add3_u32 v12, v12, v10, s3
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v15, 0x400000, v11
	v_add3_u32 v14, v14, v11, s3
	v_cndmask_b32_e32 v10, v12, v13, vcc
	v_cmp_u_f32_e32 vcc, v11, v11
	v_lshrrev_b32_e32 v10, 16, v10
	s_nop 0
	v_cndmask_b32_e32 v11, v14, v15, vcc
	v_lshrrev_b32_e32 v11, 16, v11
	buffer_store_short v10, v4, s[4:7], 0 offen
	buffer_store_short v11, v16, s[4:7], 0 offen
	global_load_dword v4, v[8:9], off offset:68
	v_mov_b32_e32 v16, v21
	v_add_u32_e32 v15, 0x2200, v60
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v4
	v_lshlrev_b32_e32 v4, 2, v14
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s18, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[16:17], v[10:11]
	v_pk_mul_f32 v[4:5], v[24:25], v[4:5]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v5
	v_pk_mul_f32 v[12:13], v[12:13], s[2:3] op_sel_hi:[1,0]
	v_add_u32_e32 v16, 0x2220, v48
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v14, v52, v15, vcc
	v_cndmask_b32_e32 v15, v52, v16, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v5, v5, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v4, v4, v5
	v_bfe_u32 v5, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v4, 16, 1
	v_add3_u32 v5, v5, v10, s3
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v4
	v_add3_u32 v12, v12, v4, s3
	v_cndmask_b32_e32 v5, v5, v11, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v10, v22
	v_cndmask_b32_e32 v4, v12, v13, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v14, s[4:7], 0 offen
	buffer_store_short v4, v15, s[4:7], 0 offen
	global_load_dword v4, v[8:9], off offset:72
	v_mov_b32_e32 v11, v18
	v_mov_b32_e32 v12, v6
	v_mov_b32_e32 v13, v26
	v_add_u32_e32 v6, 0x2400, v60
	v_mov_b32_e32 v18, v23
	v_mov_b32_e32 v26, v7
	v_add_u32_e32 v7, 0x2600, v60
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v16, 0xffffff, v4
	v_lshlrev_b32_e32 v4, 2, v16
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s18, v16
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[4:5], v[12:13], v[4:5]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v5
	v_pk_mul_f32 v[12:13], v[12:13], s[2:3] op_sel_hi:[1,0]
	v_add_u32_e32 v14, 0x2420, v48
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v6, v52, v6, vcc
	v_cndmask_b32_e32 v14, v52, v14, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v5, v5, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v4, v4, v5
	v_bfe_u32 v5, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v4, 16, 1
	v_add3_u32 v5, v5, v10, s3
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v4
	v_add3_u32 v12, v12, v4, s3
	v_cndmask_b32_e32 v5, v5, v11, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v12, v13, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v6, s[4:7], 0 offen
	buffer_store_short v4, v14, s[4:7], 0 offen
	global_load_dword v4, v[8:9], off offset:76
	v_add_u32_e32 v8, 0x2620, v48
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v6, 0xffffff, v4
	v_lshlrev_b32_e32 v4, 2, v6
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s18, v6
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[4:5], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[0:1], v[18:19], v[0:1]
	v_pk_mul_f32 v[2:3], v[26:27], v[2:3]
	v_mov_b32_e32 v4, v1
	v_mov_b32_e32 v5, v3
	v_pk_mul_f32 v[4:5], v[4:5], s[2:3] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v6, v52, v7, vcc
	v_exp_f32_e32 v4, v4
	v_exp_f32_e32 v5, v5
	v_cndmask_b32_e32 v7, v52, v8, vcc
	v_pk_add_f32 v[4:5], v[4:5], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v4, v4
	v_rcp_f32_e32 v5, v5
	v_mul_f32_e32 v1, v1, v4
	v_mul_f32_e32 v3, v3, v5
	v_mul_f32_e32 v0, v0, v1
	v_mul_f32_e32 v1, v2, v3
	v_bfe_u32 v2, v0, 16, 1
	v_or_b32_e32 v3, 0x400000, v0
	v_bfe_u32 v4, v1, 16, 1
	v_add3_u32 v2, v2, v0, s3
	v_cmp_u_f32_e32 vcc, v0, v0
	v_or_b32_e32 v5, 0x400000, v1
	v_add3_u32 v4, v4, v1, s3
	v_cndmask_b32_e32 v0, v2, v3, vcc
	v_cmp_u_f32_e32 vcc, v1, v1
	v_lshrrev_b32_e32 v0, 16, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v4, v5, vcc
	v_lshrrev_b32_e32 v1, 16, v1
	buffer_store_short v0, v6, s[4:7], 0 offen
	buffer_store_short v1, v7, s[4:7], 0 offen
.LBB0_4:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p, .Lfunc_end0-a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p
		.amdhsa_group_segment_fixed_size 16384
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 76
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_kernarg_preload_length 0
		.amdhsa_user_sgpr_kernarg_preload_offset 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 230
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 232
		.amdhsa_reserve_vcc 1
		.amdhsa_float_round_mode_32 0
		.amdhsa_float_round_mode_16_64 0
		.amdhsa_float_denorm_mode_32 3
		.amdhsa_float_denorm_mode_16_64 3
		.amdhsa_dx10_clamp 1
		.amdhsa_ieee_mode 1
		.amdhsa_fp16_overflow 0
		.amdhsa_tg_split 0
		.amdhsa_exception_fp_ieee_invalid_op 0
		.amdhsa_exception_fp_denorm_src 0
		.amdhsa_exception_fp_ieee_div_zero 0
		.amdhsa_exception_fp_ieee_overflow 0
		.amdhsa_exception_fp_ieee_underflow 0
		.amdhsa_exception_fp_ieee_inexact 0
		.amdhsa_exception_int_div_zero 0
	.end_amdhsa_kernel
	.text

	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.num_vgpr, 230
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.num_agpr, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.numbered_sgpr, 46
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.num_named_barrier, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.private_seg_size, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.uses_vcc, 1
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.uses_flat_scratch, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.has_dyn_sized_stack, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.has_recursion, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.has_indirect_call, 0
	.p2alignl 6, 3212836864
	.fill 256, 4, 3212836864
	.section	.AMDGPU.gpr_maximums,"",@progbits
	.set amdgpu.max_num_vgpr, 0
	.set amdgpu.max_num_agpr, 0
	.set amdgpu.max_num_sgpr, 0
	.set amdgpu.max_num_named_barrier, 0
	.text
	.section	".note.GNU-stack","",@progbits
	.amdgpu_metadata
---
amdhsa.kernels:
  - .agpr_count:     0
    .args:
      - .offset:         0
        .size:           8
        .value_kind:     by_value
      - .offset:         8
        .size:           8
        .value_kind:     by_value
      - .offset:         16
        .size:           8
        .value_kind:     by_value
      - .offset:         24
        .size:           8
        .value_kind:     by_value
      - .offset:         32
        .size:           8
        .value_kind:     by_value
      - .offset:         40
        .size:           8
        .value_kind:     by_value
      - .offset:         48
        .size:           8
        .value_kind:     by_value
      - .offset:         56
        .size:           8
        .value_kind:     by_value
      - .offset:         64
        .size:           8
        .value_kind:     by_value
      - .offset:         72
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 16384
    .kernarg_segment_align: 8
    .kernarg_segment_size: 76
    .max_flat_workgroup_size: 256
    .name:           a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     52
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm1_h4096_i256_ne256_bm32_tn128_tk256_bcm1_xcd1_ftz_p.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     230
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
