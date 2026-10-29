	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss
	.p2align	8
	.type	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss,@function
a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss:
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[16:17], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s16, s3, 31
	s_lshr_b32 s16, s16, 26
	s_add_i32 s16, s3, s16
	s_ashr_i32 s22, s16, 6
	s_andn2_b32 s16, s16, 63
	s_cmp_lg_u32 s3, s16
	s_cselect_b64 s[16:17], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[16:17], s[20:21], s[16:17]
	s_subb_u32 s16, s22, 0
	s_lshl_b32 s20, s16, 1
	s_cmp_ge_i32 s2, s20
	v_readfirstlane_b32 s17, v0
	s_cbranch_scc1 .LBB0_10
	s_and_b32 s21, s20, 6
	s_and_b32 s22, s2, 7
	s_lshr_b32 s20, s20, 3
	s_min_u32 s21, s22, s21
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s20, s20, s22
	s_add_i32 s2, s21, s2
	s_add_i32 s2, s2, s20
	s_lshr_b32 s20, s2, 31
	s_add_i32 s20, s2, s20
	s_ashr_i32 s24, s20, 1
	s_and_b32 s25, s20, -2
	s_cmp_lg_u32 s2, s25
	s_cselect_b64 s[20:21], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[22:23], -1, 0
	s_and_b64 s[20:21], s[22:23], s[20:21]
	s_subb_u32 s22, s24, 0
	s_sub_i32 s16, s16, s22
	s_min_i32 s23, s16, 1
	s_abs_i32 s24, s23
	v_cvt_f32_u32_e32 v1, s24
	s_sub_i32 s2, s2, s25
	s_sub_i32 s25, 0, s24
	s_load_dwordx2 s[20:21], s[0:1], 0x40
	s_load_dword s33, s[0:1], 0x48
	v_rcp_f32_e32 v1, v1
	s_abs_i32 s1, s2
	s_xor_b32 s0, s2, s23
	s_ashr_i32 s0, s0, 31
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_and_b32_e32 v10, 15, v0
	v_bfe_u32 v131, v0, 4, 2
	s_brev_b32 s38, 8
	v_readfirstlane_b32 s26, v1
	s_mul_i32 s25, s25, s26
	s_mul_hi_u32 s25, s26, s25
	s_add_i32 s26, s26, s25
	s_mul_hi_u32 s25, s1, s26
	s_mul_i32 s26, s25, s24
	s_sub_i32 s1, s1, s26
	s_add_i32 s26, s25, 1
	s_sub_i32 s27, s1, s24
	s_cmp_ge_u32 s1, s24
	s_cselect_b32 s25, s26, s25
	s_cselect_b32 s1, s27, s1
	s_add_i32 s26, s25, 1
	s_cmp_ge_u32 s1, s24
	s_cselect_b32 s1, s26, s25
	s_xor_b32 s1, s1, s0
	s_sub_i32 s24, s1, s0
	s_mul_i32 s0, s24, s23
	s_sub_i32 s1, s2, s0
	s_add_i32 s25, s1, s22
	s_cmp_lg_u32 s2, s0
	s_cselect_b64 s[0:1], -1, 0
	s_xor_b32 s2, s16, s2
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[22:23], -1, 0
	s_and_b64 s[0:1], s[22:23], s[0:1]
	s_lshl1_add_u32 s2, s25, s24
	s_cmp_lg_u64 s[0:1], 0
	s_subb_u32 s2, s2, 0
	s_lshr_b32 s0, s2, 31
	s_add_i32 s0, s2, s0
	s_ashr_i32 s16, s0, 1
	s_and_b32 s0, s0, -2
	s_sub_i32 s24, s2, s0
	s_cmp_lg_u32 s2, s0
	s_cselect_b64 s[0:1], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[22:23], -1, 0
	s_and_b64 s[0:1], s[22:23], s[0:1]
	s_subb_u32 s0, s16, 0
	s_ashr_i32 s1, s0, 31
	s_lshl_b64 s[22:23], s[0:1], 2
	s_add_u32 s14, s14, s22
	s_addc_u32 s15, s15, s23
	s_load_dword s1, s[14:15], 0x0
	s_lshr_b32 s2, s17, 1
	s_lshl_b32 s16, s0, 6
	s_lshl_b32 s0, s24, 7
	s_and_b32 s2, s2, 0x7fffffe0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s1, s1, 9
	s_add_i32 s0, s0, s2
	v_or_b32_e32 v129, s0, v10
	s_add_i32 s0, s0, s1
	s_add_i32 s2, s0, 0x100
	s_lshl_b32 s23, s2, 7
	s_lshl_b32 s24, s2, 5
	s_or_b32 s2, s0, 16
	s_lshl_b32 s22, s3, 9
	s_ashr_i32 s3, s2, 4
	s_lshl_b32 s28, s2, 7
	s_lshr_b32 s2, s0, 31
	s_add_i32 s2, s3, s2
	v_add_u32_e32 v2, s1, v129
	s_and_b32 s29, s11, 0xffff
	s_lshl_b32 s11, s0, 7
	s_lshl_b32 s15, s0, 5
	s_and_b32 s2, s2, -2
	s_addk_i32 s0, 0x110
	v_ashrrev_i32_e32 v3, 31, v2
	s_and_b32 s25, s5, 0xffff
	s_sub_i32 s5, s3, s2
	s_ashr_i32 s2, s0, 4
	s_lshl_b32 s31, s0, 7
	s_lshr_b32 s0, s0, 31
	v_lshl_add_u64 v[4:5], v[2:3], 2, s[12:13]
	v_add_u32_e32 v2, 0x100, v2
	v_lshrrev_b32_e32 v1, 4, v0
	s_add_i32 s0, s2, s0
	v_ashrrev_i32_e32 v3, 31, v2
	s_and_b32 s0, s0, -2
	v_lshl_add_u64 v[6:7], v[2:3], 2, s[12:13]
	s_ashr_i32 s17, s16, 31
	v_or_b32_e32 v2, s16, v1
	s_and_b32 s37, s9, 0xffff
	s_and_b32 s21, s21, 0xffff
	s_lshl_b32 s26, s33, 12
	s_sub_i32 s9, s2, s0
	s_lshl_b32 s14, s33, 2
	s_and_b32 s13, s7, 0xffff
	s_lshl_b64 s[0:1], s[16:17], 2
	v_ashrrev_i32_e32 v3, 31, v2
	s_add_u32 s2, s18, s0
	v_lshl_add_u64 v[8:9], v[2:3], 2, s[18:19]
	s_addc_u32 s3, s19, s1
	v_lshlrev_b32_e32 v2, 2, v1
	global_load_dword v3, v[8:9], off
	global_load_dword v11, v2, s[2:3] offset:64
	global_load_dword v139, v[4:5], off
	global_load_dword v158, v[4:5], off offset:64
	global_load_dword v136, v[6:7], off
	global_load_dword v138, v[6:7], off offset:64
	s_load_dword s0, s[2:3], 0x80
	v_lshlrev_b32_e32 v5, 4, v0
	v_and_b32_e32 v4, 48, v0
	v_xor_b32_e32 v0, v5, v0
	v_and_b32_e32 v6, 0xf0, v5
	v_lshlrev_b32_e32 v1, 8, v1
	v_and_b32_e32 v94, 0xf0, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0xffffff
	s_mov_b32 s27, 0x27000
	s_mov_b32 s30, 0x1000000
	v_lshlrev_b32_e32 v87, 5, v131
	v_lshlrev_b32_e32 v95, 8, v10
	v_lshlrev_b32_e32 v86, 4, v10
	v_or_b32_e32 v130, 16, v129
	v_or3_b32 v132, s11, v4, v10
	v_or3_b32 v134, s15, v4, v10
	v_or3_b32 v135, s23, v4, v10
	v_or3_b32 v137, s24, v4, v10
	v_or3_b32 v140, s28, v4, v10
	v_or3_b32 v150, s31, v4, v10
	s_cmp_lt_i32 s0, s33
	v_add_u32_e32 v141, v1, v6
	s_waitcnt vmcnt(5)
	v_lshl_or_b32 v151, v3, 12, v94
	s_waitcnt vmcnt(4)
	v_lshl_or_b32 v152, v11, 12, v94
	s_cbranch_scc1 .LBB0_5
	v_or_b32_e32 v1, 8, v87
	v_or_b32_e32 v3, 16, v87
	v_or_b32_e32 v4, 24, v87
	v_or_b32_e32 v5, 0x80, v87
	v_or_b32_e32 v6, 0x88, v87
	v_or_b32_e32 v7, 0x90, v87
	v_or_b32_e32 v8, 0x98, v87
	s_lshl_b32 s7, s5, 3
	s_lshl_b32 s12, s9, 3
	v_xor_b32_e32 v0, v87, v86
	v_xor_b32_e32 v1, v1, v86
	v_xor_b32_e32 v3, v3, v86
	v_xor_b32_e32 v4, v4, v86
	v_xor_b32_e32 v5, v5, v86
	v_xor_b32_e32 v6, v6, v86
	v_xor_b32_e32 v7, v7, v86
	v_xor_b32_e32 v8, v8, v86
	v_mov_b32_e32 v42, 0
	s_add_i32 s11, s7, 16
	s_add_i32 s15, s12, 16
	s_mov_b32 s17, 0
	s_mov_b32 s23, 0x8080808
	s_mov_b32 s34, 0x5010400
	s_mov_b32 s35, 0x7030602
	v_add_u32_e32 v0, v95, v0
	v_add_u32_e32 v1, v95, v1
	v_add_u32_e32 v3, v95, v3
	v_add_u32_e32 v88, v95, v4
	v_add_u32_e32 v89, v95, v5
	v_add_u32_e32 v90, v95, v6
	v_add_u32_e32 v91, v95, v7
	v_add_u32_e32 v92, v95, v8
	s_mov_b32 s28, s10
	v_mov_b32_e32 v43, v42
	v_mov_b32_e32 v44, v42
	v_mov_b32_e32 v45, v42
	v_mov_b32_e32 v46, v42
	v_mov_b32_e32 v47, v42
	v_mov_b32_e32 v48, v42
	v_mov_b32_e32 v49, v42
	v_mov_b32_e32 v14, v42
	v_mov_b32_e32 v15, v42
	v_mov_b32_e32 v16, v42
	v_mov_b32_e32 v17, v42
	v_mov_b32_e32 v6, v42
	v_mov_b32_e32 v7, v42
	v_mov_b32_e32 v8, v42
	v_mov_b32_e32 v9, v42
	v_mov_b32_e32 v50, v42
	v_mov_b32_e32 v51, v42
	v_mov_b32_e32 v52, v42
	v_mov_b32_e32 v53, v42
	v_mov_b32_e32 v54, v42
	v_mov_b32_e32 v55, v42
	v_mov_b32_e32 v56, v42
	v_mov_b32_e32 v57, v42
	v_mov_b32_e32 v18, v42
	v_mov_b32_e32 v19, v42
	v_mov_b32_e32 v20, v42
	v_mov_b32_e32 v21, v42
	v_mov_b32_e32 v10, v42
	v_mov_b32_e32 v11, v42
	v_mov_b32_e32 v12, v42
	v_mov_b32_e32 v13, v42
.LBB0_3:
	s_lshl_b32 s0, s17, 8
	s_mov_b32 s24, s4
	s_lshl_b32 s1, s17, 6
	s_lshl_b32 s40, s17, 7
	v_add_u32_e32 v4, s0, v151
	s_mov_b32 s31, s27
	s_mov_b32 s36, s8
	s_mov_b32 s39, s27
	v_add_u32_e32 v5, s0, v152
	v_add_lshl_u32 v22, s1, v134, 2
	v_add_lshl_u32 v23, s1, v137, 2
	v_add_lshl_u32 v25, s40, v140, 4
	v_add_lshl_u32 v30, s40, v135, 4
	v_add_lshl_u32 v34, s40, v150, 4
	buffer_load_dwordx4 v[72:75], v4, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[76:79], v5, s[24:27], 0 offen nt
	buffer_load_dword v70, v22, s[28:31], 0 offen
	buffer_load_dword v71, v23, s[28:31], 0 offen
	buffer_load_dwordx4 v[66:69], v30, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[58:61], v25, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[38:41], v34, s[36:39], 0 offen sc0
	v_or_b32_e32 v24, s40, v132
	v_lshlrev_b32_e32 v4, 4, v24
	buffer_load_dwordx4 v[26:29], v25, s[36:39], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[30:33], v30, s[36:39], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[22:25], v34, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[62:65], v4, s[36:39], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[34:37], v4, s[36:39], 0 offen offset:1024 sc0
	s_add_i32 s17, s17, 1
	s_cmp_lg_u32 s17, 16
	s_waitcnt vmcnt(11)
	ds_write_b128 v141, v[72:75]
	s_waitcnt vmcnt(10)
	ds_write_b128 v141, v[76:79] offset:4096
	s_waitcnt vmcnt(9)
	v_sub_u32_sdwa v79, v139, v70 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_bfe_u32 v80, v70, s7, 8
	s_waitcnt vmcnt(8)
	v_bfe_u32 v81, v71, s12, 8
	v_sub_u32_sdwa v82, v136, v71 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	s_waitcnt vmcnt(5)
	v_lshrrev_b32_e32 v101, 4, v38
	v_min_i32_e32 v102, 11, v79
	v_min_i32_e32 v103, 11, v82
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v106, 4, v62
	v_sub_u32_e32 v80, v158, v80
	v_sub_u32_e32 v81, v138, v81
	v_and_b32_e32 v118, 0x7070707, v101
	v_mul_lo_u32 v101, v102, s23
	v_mul_lo_u32 v102, v103, s23
	v_and_b32_e32 v109, 0x7070707, v106
	v_min_i32_e32 v103, 11, v80
	v_min_i32_e32 v106, 11, v81
	v_sub_u32_e32 v110, 0x6c686080, v101
	v_sub_u32_e32 v101, 0x7c787470, v101
	v_sub_u32_e32 v112, 0x6c686080, v102
	v_sub_u32_e32 v113, 0x7c787470, v102
	v_mul_lo_u32 v102, v103, s23
	v_mul_lo_u32 v103, v106, s23
	v_and_b32_e32 v106, 0xffffff00, v110
	v_cmp_lt_i32_e64 s[0:1], 11, v79
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[74:77], v0 offset1:8
	v_and_b32_e32 v110, 0xffffff00, v112
	v_cmp_lt_i32_e32 vcc, 11, v82
	v_sub_u32_e32 v82, 0x6c686080, v102
	v_cndmask_b32_e64 v114, v106, 0, s[0:1]
	v_cndmask_b32_e64 v115, v101, 0, s[0:1]
	v_sub_u32_e32 v119, 0x7c787470, v102
	v_cndmask_b32_e64 v102, v110, 0, vcc
	v_cndmask_b32_e64 v113, v113, 0, vcc
	v_and_b32_e32 v79, 0xffffff00, v82
	v_cmp_lt_i32_e64 s[0:1], 11, v81
	v_add_u32_e32 v81, 0x7f7f7f00, v114
	v_add_u32_e32 v82, 0x7f7f7f78, v115
	v_and_b32_e32 v104, 0x7070707, v62
	v_sub_u32_e32 v112, 0x6c686080, v103
	v_add_u32_e32 v101, 0x7f7f7f00, v102
	v_and_b32_e32 v116, 0x80808000, v81
	v_and_b32_e32 v117, 0x80808080, v82
	v_add_u32_e32 v82, 0x7f7f7f78, v113
	v_and_b32_e32 v83, 0x7070707, v66
	v_lshrrev_b32_e32 v85, 4, v66
	v_lshlrev_b32_e32 v107, 4, v62
	v_sub_u32_e32 v120, 0x7c787470, v103
	v_cmp_lt_i32_e32 vcc, 11, v80
	v_and_b32_e32 v80, 0xffffff00, v112
	v_perm_b32 v103, v115, v114, v104
	v_perm_b32 v81, v117, v116, v104
	v_and_b32_e32 v101, 0x80808000, v101
	v_and_b32_e32 v112, 0x80808080, v82
	v_lshlrev_b32_e32 v84, 4, v66
	v_and_b32_e32 v85, 0x7070707, v85
	v_and_or_b32 v81, v81, v107, v103
	v_perm_b32 v103, v113, v102, v83
	v_perm_b32 v82, v112, v101, v83
	v_and_or_b32 v83, v82, v84, v103
	v_perm_b32 v82, v115, v114, v109
	v_perm_b32 v84, v113, v102, v85
	v_cndmask_b32_e64 v106, v79, 0, vcc
	v_cndmask_b32_e64 v103, v80, 0, s[0:1]
	v_perm_b32 v79, v117, v116, v109
	v_perm_b32 v80, v112, v101, v85
	v_cndmask_b32_e64 v107, v119, 0, vcc
	v_and_or_b32 v62, v79, v62, v82
	v_and_or_b32 v66, v80, v66, v84
	v_perm_b32 v80, v62, v81, s34
	v_perm_b32 v81, v62, v81, s35
	v_perm_b32 v82, v66, v83, s34
	v_perm_b32 v83, v66, v83, s35
	v_add_u32_e32 v62, 0x7f7f7f00, v106
	v_add_u32_e32 v66, 0x7f7f7f78, v107
	v_and_b32_e32 v99, 0x7070707, v58
	v_and_b32_e32 v109, 0x80808000, v62
	v_and_b32_e32 v110, 0x80808080, v66
	v_lshlrev_b32_e32 v105, 4, v58
	v_cndmask_b32_e64 v104, v120, 0, s[0:1]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[74:75], v[80:81], v[42:45]
	v_perm_b32 v62, v110, v109, v99
	v_lshrrev_b32_e32 v100, 4, v58
	v_add_u32_e32 v79, 0x7f7f7f00, v103
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[76:77], v[80:81], v[14:17]
	v_perm_b32 v80, v107, v106, v99
	v_and_or_b32 v66, v62, v105, v80
	v_add_u32_e32 v80, 0x7f7f7f78, v104
	v_and_b32_e32 v108, 0x7070707, v38
	v_and_b32_e32 v100, 0x7070707, v100
	v_and_b32_e32 v62, 0x80808000, v79
	v_and_b32_e32 v105, 0x80808080, v80
	v_bfe_u32 v96, v70, s11, 8
	v_bfe_u32 v97, v71, s15, 8
	v_sub_u32_sdwa v93, v139, v70 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_sub_u32_sdwa v98, v136, v71 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	ds_read2st64_b64 v[70:73], v1 offset1:8
	v_lshlrev_b32_e32 v111, 4, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[74:75], v[82:83], v[50:53]
	v_perm_b32 v81, v107, v106, v100
	v_perm_b32 v79, v110, v109, v100
	v_perm_b32 v80, v105, v62, v108
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[76:77], v[82:83], v[18:21]
	v_perm_b32 v82, v104, v103, v108
	v_perm_b32 v83, v104, v103, v118
	v_perm_b32 v84, v105, v62, v118
	v_and_or_b32 v58, v79, v58, v81
	v_and_or_b32 v79, v80, v111, v82
	v_and_or_b32 v38, v84, v38, v83
	v_perm_b32 v80, v58, v66, s34
	v_perm_b32 v81, v58, v66, s35
	v_perm_b32 v84, v38, v79, s34
	v_perm_b32 v85, v38, v79, s35
	v_lshrrev_b32_e32 v78, 4, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[74:75], v[80:81], v[46:49]
	v_and_b32_e32 v4, 0x7070707, v67
	v_lshlrev_b32_e32 v5, 4, v67
	v_lshrrev_b32_e32 v66, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[74:75], v[84:85], v[54:57]
	v_and_b32_e32 v58, 0x7070707, v59
	v_and_b32_e32 v66, 0x7070707, v66
	ds_read2st64_b64 v[142:145], v3 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[76:77], v[80:81], v[6:9]
	v_and_b32_e32 v38, 0x7070707, v68
	v_cmp_lt_i32_e64 s[0:1], 11, v93
	v_cmp_lt_i32_e32 vcc, 11, v98
	v_lshrrev_b32_e32 v6, 4, v39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[76:77], v[84:85], v[10:13]
	v_and_b32_e32 v7, 0x7070707, v63
	v_lshlrev_b32_e32 v8, 4, v59
	v_and_b32_e32 v9, 0x7070707, v39
	v_lshrrev_b32_e32 v11, 4, v63
	v_lshlrev_b32_e32 v12, 4, v63
	v_and_b32_e32 v13, 0x7070707, v78
	v_and_b32_e32 v78, 0x7070707, v6
	v_and_b32_e32 v6, 0x7070707, v11
	v_perm_b32 v11, v115, v114, v7
	v_perm_b32 v7, v117, v116, v7
	v_and_or_b32 v7, v7, v12, v11
	v_perm_b32 v11, v113, v102, v4
	v_perm_b32 v4, v112, v101, v4
	v_perm_b32 v79, v115, v114, v6
	v_perm_b32 v12, v113, v102, v13
	v_and_or_b32 v11, v4, v5, v11
	v_perm_b32 v4, v117, v116, v6
	v_perm_b32 v5, v112, v101, v13
	v_and_or_b32 v6, v4, v63, v79
	v_and_or_b32 v12, v5, v67, v12
	v_perm_b32 v84, v107, v106, v58
	v_perm_b32 v85, v107, v106, v66
	v_perm_b32 v4, v6, v7, s34
	v_perm_b32 v5, v6, v7, s35
	v_perm_b32 v6, v12, v11, s34
	v_perm_b32 v7, v12, v11, s35
	v_perm_b32 v12, v110, v109, v58
	v_perm_b32 v13, v110, v109, v66
	v_lshlrev_b32_e32 v10, 4, v39
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[70:71], v[4:5], v[42:45]
	v_perm_b32 v11, v104, v103, v9
	v_perm_b32 v9, v105, v62, v9
	v_and_b32_e32 v58, 0x7070707, v69
	v_perm_b32 v42, v104, v103, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[72:73], v[4:5], v[14:17]
	v_perm_b32 v4, v105, v62, v78
	v_and_or_b32 v5, v12, v8, v84
	v_and_or_b32 v8, v13, v59, v85
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[70:71], v[6:7], v[50:53]
	v_perm_b32 v16, v8, v5, s34
	v_perm_b32 v17, v8, v5, s35
	v_and_or_b32 v4, v4, v39, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[72:73], v[6:7], v[18:21]
	v_and_or_b32 v6, v9, v10, v11
	v_and_b32_e32 v39, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v69
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[70:71], v[16:17], v[46:49]
	v_perm_b32 v18, v4, v6, s34
	v_perm_b32 v19, v4, v6, s35
	v_lshrrev_b32_e32 v20, 4, v68
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[72:73], v[16:17], v[80:83]
	v_and_b32_e32 v16, 0x7070707, v64
	v_lshlrev_b32_e32 v17, 4, v64
	v_lshlrev_b32_e32 v21, 4, v68
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[70:71], v[18:19], v[54:57]
	v_lshlrev_b32_e32 v46, 4, v60
	ds_read2st64_b64 v[42:45], v88 offset1:8
	v_lshlrev_b32_e32 v63, 4, v69
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[72:73], v[18:19], v[74:77]
	v_perm_b32 v18, v115, v114, v16
	v_perm_b32 v16, v117, v116, v16
	v_and_or_b32 v17, v16, v17, v18
	v_lshrrev_b32_e32 v16, 4, v64
	v_and_b32_e32 v18, 0x7070707, v20
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v19, v113, v102, v38
	v_perm_b32 v20, v112, v101, v38
	v_and_or_b32 v19, v20, v21, v19
	v_perm_b32 v20, v115, v114, v16
	v_perm_b32 v21, v113, v102, v18
	v_perm_b32 v16, v117, v116, v16
	v_perm_b32 v18, v112, v101, v18
	v_and_or_b32 v20, v16, v64, v20
	v_and_or_b32 v21, v18, v68, v21
	v_perm_b32 v16, v20, v17, s34
	v_perm_b32 v17, v20, v17, s35
	v_perm_b32 v18, v21, v19, s34
	v_perm_b32 v19, v21, v19, s35
	v_and_b32_e32 v20, 0x7070707, v40
	v_perm_b32 v21, v107, v106, v39
	v_perm_b32 v38, v110, v109, v39
	v_and_or_b32 v21, v38, v46, v21
	v_lshlrev_b32_e32 v38, 4, v40
	v_perm_b32 v39, v104, v103, v20
	v_perm_b32 v20, v105, v62, v20
	v_and_or_b32 v20, v20, v38, v39
	v_lshrrev_b32_e32 v39, 4, v60
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[142:143], v[16:17], v[118:121]
	v_and_b32_e32 v64, 0x7070707, v41
	v_and_b32_e32 v38, 0x7070707, v30
	v_and_b32_e32 v126, 0x7070707, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[144:145], v[16:17], v[122:125]
	v_lshrrev_b32_e32 v16, 4, v40
	v_and_b32_e32 v17, 0x7070707, v39
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v39, v107, v106, v17
	v_perm_b32 v17, v110, v109, v17
	v_and_or_b32 v17, v17, v60, v39
	v_perm_b32 v39, v104, v103, v16
	v_perm_b32 v16, v105, v62, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[142:143], v[18:19], v[50:53]
	v_and_or_b32 v16, v16, v40, v39
	v_lshlrev_b32_e32 v120, 4, v61
	v_perm_b32 v121, v104, v103, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[144:145], v[18:19], v[12:15]
	v_perm_b32 v124, v105, v62, v64
	v_lshrrev_b32_e32 v122, 4, v26
	v_lshrrev_b32_e32 v123, 4, v22
	v_perm_b32 v12, v17, v21, s34
	v_perm_b32 v13, v17, v21, s35
	v_perm_b32 v14, v16, v20, s34
	v_perm_b32 v15, v16, v20, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[142:143], v[12:13], v[8:11]
	ds_read2st64_b64 v[16:19], v89 offset1:8
	v_lshrrev_b32_e32 v40, 4, v30
	v_lshlrev_b32_e32 v39, 4, v30
	v_and_b32_e32 v8, 0x7070707, v59
	v_perm_b32 v9, v113, v102, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[142:143], v[14:15], v[4:7]
	v_and_b32_e32 v59, 0x7070707, v61
	v_perm_b32 v11, v113, v102, v58
	v_perm_b32 v58, v112, v101, v58
	v_perm_b32 v4, v112, v101, v8
	v_lshrrev_b32_e32 v8, 4, v61
	v_and_b32_e32 v8, 0x7070707, v8
	v_and_or_b32 v118, v4, v69, v9
	v_perm_b32 v9, v107, v106, v8
	v_perm_b32 v8, v110, v109, v8
	v_and_or_b32 v119, v8, v61, v9
	v_lshrrev_b32_e32 v8, 4, v65
	v_and_b32_e32 v8, 0x7070707, v8
	v_perm_b32 v9, v115, v114, v8
	v_perm_b32 v8, v117, v116, v8
	v_and_or_b32 v60, v8, v65, v9
	v_and_b32_e32 v8, 0x7070707, v65
	v_lshlrev_b32_e32 v9, 4, v65
	v_perm_b32 v10, v115, v114, v8
	v_perm_b32 v8, v117, v116, v8
	v_and_or_b32 v61, v8, v9, v10
	v_lshrrev_b32_e32 v8, 4, v41
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[144:145], v[12:13], v[78:81]
	v_and_b32_e32 v8, 0x7070707, v8
	v_and_or_b32 v65, v58, v63, v11
	v_lshlrev_b32_e32 v113, 4, v41
	v_perm_b32 v9, v104, v103, v8
	v_perm_b32 v8, v105, v62, v8
	v_perm_b32 v107, v107, v106, v59
	v_perm_b32 v109, v110, v109, v59
	v_perm_b32 v62, v60, v61, s34
	v_perm_b32 v63, v60, v61, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[144:145], v[14:15], v[146:149]
	v_and_or_b32 v41, v8, v41, v9
	v_perm_b32 v64, v118, v65, s34
	v_perm_b32 v65, v118, v65, s35
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[42:43], v[62:63], v[82:85]
	v_and_b32_e32 v40, 0x7070707, v40
	v_lshlrev_b32_e32 v110, 4, v26
	v_and_b32_e32 v127, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[44:45], v[62:63], v[74:77]
	v_and_or_b32 v63, v109, v120, v107
	v_min_i32_e32 v82, 11, v93
	v_perm_b32 v62, v119, v63, s34
	v_and_or_b32 v74, v124, v113, v121
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[42:43], v[64:65], v[46:49]
	v_perm_b32 v63, v119, v63, s35
	v_and_b32_e32 v109, 0x7070707, v123
	v_lshlrev_b32_e32 v128, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[44:45], v[64:65], v[50:53]
	v_perm_b32 v64, v41, v74, s34
	v_perm_b32 v65, v41, v74, s35
	v_min_i32_e32 v41, 11, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[42:43], v[62:63], v[54:57]
	v_mul_lo_u32 v41, v41, s23
	ds_read2st64_b64 v[4:7], v90 offset1:8
	v_and_b32_e32 v20, 0x7070707, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[44:45], v[62:63], v[78:81]
	s_waitcnt vmcnt(0)
	v_lshrrev_b32_e32 v55, 4, v34
	v_sub_u32_e32 v57, v158, v96
	v_and_b32_e32 v54, 0x7070707, v34
	v_sub_u32_e32 v78, v138, v97
	v_and_b32_e32 v97, 0x7070707, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[42:43], v[64:65], v[70:73]
	v_mul_lo_u32 v42, v82, s23
	v_and_b32_e32 v43, 0x7070707, v55
	v_sub_u32_e32 v55, 0x6c686080, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[44:45], v[64:65], v[66:69]
	v_sub_u32_e32 v42, 0x7c787470, v42
	v_and_b32_e32 v55, 0xffffff00, v55
	v_min_i32_e32 v44, 11, v57
	v_sub_u32_e32 v66, 0x6c686080, v41
	v_sub_u32_e32 v41, 0x7c787470, v41
	v_and_b32_e32 v66, 0xffffff00, v66
	v_cndmask_b32_e64 v84, v55, 0, s[0:1]
	v_cndmask_b32_e64 v93, v42, 0, s[0:1]
	v_mul_lo_u32 v44, v44, s23
	v_cndmask_b32_e64 v85, v66, 0, vcc
	v_cndmask_b32_e64 v96, v41, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v57
	v_add_u32_e32 v55, 0x7f7f7f00, v84
	v_add_u32_e32 v57, 0x7f7f7f78, v93
	v_sub_u32_e32 v67, 0x6c686080, v44
	v_add_u32_e32 v66, 0x7f7f7f00, v85
	v_and_b32_e32 v70, 0x80808000, v55
	v_and_b32_e32 v71, 0x80808080, v57
	v_add_u32_e32 v55, 0x7f7f7f78, v96
	v_lshlrev_b32_e32 v56, 4, v34
	v_min_i32_e32 v45, 11, v78
	v_and_b32_e32 v41, 0xffffff00, v67
	v_perm_b32 v67, v93, v84, v54
	v_perm_b32 v54, v71, v70, v54
	v_and_b32_e32 v72, 0x80808000, v66
	v_and_b32_e32 v73, 0x80808080, v55
	v_mul_lo_u32 v45, v45, s23
	v_and_or_b32 v54, v54, v56, v67
	v_perm_b32 v56, v96, v85, v38
	v_perm_b32 v38, v73, v72, v38
	v_sub_u32_e32 v44, 0x7c787470, v44
	v_sub_u32_e32 v68, 0x6c686080, v45
	v_and_or_b32 v55, v38, v39, v56
	v_perm_b32 v38, v93, v84, v43
	v_perm_b32 v39, v96, v85, v40
	v_cndmask_b32_e64 v82, v41, 0, vcc
	v_perm_b32 v41, v71, v70, v43
	v_perm_b32 v40, v73, v72, v40
	v_sub_u32_e32 v45, 0x7c787470, v45
	v_and_b32_e32 v42, 0xffffff00, v68
	v_cmp_lt_i32_e64 s[0:1], 11, v78
	v_cndmask_b32_e64 v83, v44, 0, vcc
	v_and_or_b32 v34, v41, v34, v38
	v_and_or_b32 v30, v40, v30, v39
	v_cndmask_b32_e64 v80, v42, 0, s[0:1]
	v_cndmask_b32_e64 v81, v45, 0, s[0:1]
	v_perm_b32 v38, v34, v54, s34
	v_perm_b32 v39, v34, v54, s35
	v_perm_b32 v40, v30, v55, s34
	v_perm_b32 v41, v30, v55, s35
	v_add_u32_e32 v30, 0x7f7f7f00, v82
	v_add_u32_e32 v34, 0x7f7f7f78, v83
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[16:17], v[38:39], v[58:61]
	v_and_b32_e32 v30, 0x80808000, v30
	v_and_b32_e32 v34, 0x80808080, v34
	v_add_u32_e32 v66, 0x7f7f7f78, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[18:19], v[38:39], v[114:117]
	v_add_u32_e32 v38, 0x7f7f7f00, v80
	v_perm_b32 v39, v83, v82, v126
	v_perm_b32 v42, v34, v30, v126
	v_and_b32_e32 v78, 0x80808000, v38
	v_and_b32_e32 v79, 0x80808080, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[16:17], v[40:41], v[46:49]
	v_and_or_b32 v39, v42, v110, v39
	v_perm_b32 v67, v83, v82, v97
	v_perm_b32 v38, v34, v30, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[18:19], v[40:41], v[50:53]
	v_perm_b32 v40, v81, v80, v127
	v_perm_b32 v41, v81, v80, v109
	v_perm_b32 v68, v79, v78, v109
	v_perm_b32 v50, v79, v78, v127
	v_and_or_b32 v26, v38, v26, v67
	v_and_or_b32 v38, v50, v128, v40
	v_and_or_b32 v22, v68, v22, v41
	v_perm_b32 v66, v26, v39, s34
	v_perm_b32 v67, v26, v39, s35
	v_perm_b32 v114, v22, v38, s34
	v_perm_b32 v115, v22, v38, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[16:17], v[66:67], v[118:121]
	v_lshrrev_b32_e32 v108, 4, v31
	v_lshlrev_b32_e32 v21, 4, v31
	v_and_b32_e32 v105, 0x7070707, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[16:17], v[114:115], v[122:125]
	v_and_b32_e32 v16, 0x7070707, v35
	v_lshlrev_b32_e32 v17, 4, v35
	v_lshrrev_b32_e32 v103, 4, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[18:19], v[66:67], v[74:77]
	v_lshlrev_b32_e32 v106, 4, v27
	v_and_b32_e32 v107, 0x7070707, v23
	v_lshrrev_b32_e32 v104, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[114:115], v[62:65]
	v_perm_b32 v18, v93, v84, v16
	v_perm_b32 v16, v71, v70, v16
	v_and_or_b32 v16, v16, v17, v18
	v_lshrrev_b32_e32 v17, 4, v35
	v_and_b32_e32 v17, 0x7070707, v17
	v_perm_b32 v19, v96, v85, v20
	v_perm_b32 v20, v73, v72, v20
	v_and_b32_e32 v18, 0x7070707, v108
	v_and_or_b32 v19, v20, v21, v19
	v_perm_b32 v20, v93, v84, v17
	v_perm_b32 v17, v71, v70, v17
	v_perm_b32 v21, v96, v85, v18
	v_perm_b32 v18, v73, v72, v18
	v_and_or_b32 v17, v17, v35, v20
	v_and_or_b32 v18, v18, v31, v21
	v_perm_b32 v20, v17, v16, s34
	v_perm_b32 v21, v17, v16, s35
	v_perm_b32 v16, v83, v82, v105
	v_perm_b32 v17, v34, v30, v105
	v_lshlrev_b32_e32 v113, 4, v23
	v_perm_b32 v108, v18, v19, s34
	v_perm_b32 v109, v18, v19, s35
	v_and_or_b32 v35, v17, v106, v16
	v_perm_b32 v22, v81, v80, v107
	v_perm_b32 v106, v79, v78, v107
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[4:5], v[20:21], v[58:61]
	ds_read2st64_b64 v[12:15], v91 offset1:8
	v_lshrrev_b32_e32 v111, 4, v32
	v_lshrrev_b32_e32 v112, 4, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[6:7], v[20:21], v[54:57]
	v_and_b32_e32 v20, 0x7070707, v103
	v_and_or_b32 v61, v106, v113, v22
	v_and_b32_e32 v21, 0x7070707, v104
	v_perm_b32 v22, v83, v82, v20
	v_perm_b32 v20, v34, v30, v20
	v_and_or_b32 v27, v20, v27, v22
	v_perm_b32 v20, v81, v80, v21
	v_perm_b32 v21, v79, v78, v21
	v_lshrrev_b32_e32 v113, 4, v36
	v_and_or_b32 v103, v21, v23, v20
	v_perm_b32 v58, v27, v35, s34
	v_perm_b32 v59, v27, v35, s35
	v_lshrrev_b32_e32 v98, 4, v28
	v_lshrrev_b32_e32 v110, 4, v24
	v_lshrrev_b32_e32 v114, 4, v29
	v_lshrrev_b32_e32 v105, 4, v25
	v_and_b32_e32 v107, 0x7070707, v36
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[6:7], v[108:109], v[42:45]
	v_perm_b32 v60, v103, v61, s34
	v_perm_b32 v61, v103, v61, s35
	v_lshrrev_b32_e32 v27, 4, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[4:5], v[58:59], v[50:53]
	v_and_b32_e32 v100, 0x7070707, v32
	v_and_b32_e32 v102, 0x7070707, v33
	v_and_b32_e32 v97, 0x7070707, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[6:7], v[58:59], v[66:69]
	v_and_b32_e32 v58, 0x7070707, v113
	v_and_b32_e32 v76, 0x7070707, v24
	v_and_b32_e32 v75, 0x7070707, v29
	v_and_b32_e32 v31, 0x7070707, v25
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[4:5], v[108:109], v[46:49]
	v_lshlrev_b32_e32 v104, 4, v36
	v_and_b32_e32 v111, 0x7070707, v111
	v_and_b32_e32 v35, 0x7070707, v37
	v_and_b32_e32 v67, 0x7070707, v112
	v_and_b32_e32 v68, 0x7070707, v98
	v_and_b32_e32 v69, 0x7070707, v110
	v_and_b32_e32 v98, 0x7070707, v114
	v_and_b32_e32 v103, 0x7070707, v105
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[4:5], v[60:61], v[38:41]
	v_and_b32_e32 v105, 0x7070707, v27
	v_perm_b32 v27, v93, v84, v107
	v_perm_b32 v59, v93, v84, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[6:7], v[60:61], v[62:65]
	v_perm_b32 v58, v71, v70, v58
	v_lshlrev_b32_e32 v99, 4, v32
	v_perm_b32 v60, v96, v85, v100
	v_perm_b32 v65, v71, v70, v107
	v_perm_b32 v61, v96, v85, v111
	v_perm_b32 v108, v93, v84, v35
	v_perm_b32 v84, v93, v84, v105
	v_perm_b32 v93, v96, v85, v102
	v_perm_b32 v85, v96, v85, v67
	v_perm_b32 v62, v83, v82, v97
	v_perm_b32 v63, v83, v82, v68
	v_perm_b32 v64, v81, v80, v76
	v_and_or_b32 v27, v65, v104, v27
	v_perm_b32 v65, v81, v80, v69
	v_perm_b32 v96, v83, v82, v75
	v_perm_b32 v82, v83, v82, v98
	v_perm_b32 v83, v81, v80, v31
	v_perm_b32 v80, v81, v80, v103
	v_perm_b32 v81, v73, v72, v100
	v_perm_b32 v100, v73, v72, v111
	v_and_or_b32 v36, v58, v36, v59
	ds_read2st64_b64 v[8:11], v92 offset1:8
	v_and_or_b32 v81, v81, v99, v60
	v_perm_b32 v58, v36, v27, s34
	v_perm_b32 v59, v36, v27, s35
	v_and_or_b32 v27, v100, v32, v61
	v_lshlrev_b32_e32 v26, 4, v28
	v_perm_b32 v60, v27, v81, s34
	v_perm_b32 v61, v27, v81, s35
	v_perm_b32 v27, v34, v30, v97
	v_perm_b32 v32, v34, v30, v68
	v_lshlrev_b32_e32 v77, 4, v24
	v_perm_b32 v36, v79, v78, v76
	v_perm_b32 v68, v79, v78, v69
	v_and_or_b32 v27, v27, v26, v62
	v_and_or_b32 v28, v32, v28, v63
	v_and_or_b32 v32, v36, v77, v64
	v_perm_b32 v26, v28, v27, s34
	v_perm_b32 v27, v28, v27, s35
	v_and_or_b32 v24, v68, v24, v65
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[12:13], v[58:59], v[16:19]
	v_lshlrev_b32_e32 v66, 4, v37
	v_lshlrev_b32_e32 v101, 4, v33
	v_lshlrev_b32_e32 v74, 4, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[12:13], v[60:61], v[46:49]
	v_lshlrev_b32_e32 v106, 4, v25
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[14:15], v[58:59], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[14:15], v[60:61], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[12:13], v[26:27], v[42:45]
	s_nop 2
	v_perm_b32 v42, v24, v32, s34
	v_perm_b32 v43, v24, v32, s35
	v_perm_b32 v24, v73, v72, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[26:27], v[50:53]
	v_perm_b32 v26, v73, v72, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[12:13], v[42:43], v[38:41]
	v_perm_b32 v12, v71, v70, v35
	v_perm_b32 v13, v71, v70, v105
	v_and_or_b32 v12, v12, v66, v108
	v_and_or_b32 v13, v13, v37, v84
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[14:15], v[42:43], v[4:7]
	s_nop 2
	v_and_or_b32 v7, v24, v101, v93
	v_perm_b32 v4, v13, v12, s34
	v_perm_b32 v5, v13, v12, s35
	v_and_or_b32 v12, v26, v33, v85
	v_perm_b32 v6, v12, v7, s34
	v_perm_b32 v7, v12, v7, s35
	v_perm_b32 v12, v34, v30, v75
	v_perm_b32 v13, v34, v30, v98
	v_perm_b32 v24, v79, v78, v31
	v_perm_b32 v26, v79, v78, v103
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[8:9], v[4:5], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[8:9], v[6:7], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[10:11], v[4:5], v[54:57]
	v_and_or_b32 v5, v12, v74, v96
	v_and_or_b32 v12, v13, v29, v82
	v_perm_b32 v4, v12, v5, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[6:7], v[20:23]
	v_and_or_b32 v6, v24, v106, v83
	v_and_or_b32 v7, v26, v25, v80
	v_perm_b32 v5, v12, v5, s35
	v_perm_b32 v12, v7, v6, s34
	v_perm_b32 v13, v7, v6, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[8:9], v[4:5], v[58:61]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[8:9], v[12:13], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[10:11], v[4:5], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[10:11], v[12:13], v[66:69]
	s_cbranch_scc1 .LBB0_3
	v_lshl_or_b32 v4, v131, 2, s16
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshl_add_u64 v[22:23], v[4:5], 2, s[18:19]
	global_load_dword v0, v[22:23], off
	s_mov_b32 s12, s6
	s_mov_b32 s15, s27
	v_mov_b32_e32 v30, 0xfd800000
	v_add_u32_e32 v1, 17, v139
	v_lshl_add_u32 v32, v136, 23, v30
	v_cmp_lt_i32_e32 vcc, 5, v136
	v_add_u32_e32 v5, 17, v138
	v_lshl_add_u32 v31, v139, 23, v30
	v_lshlrev_b32_e64 v33, v1, 1
	v_add_u32_e32 v25, 17, v158
	v_lshl_add_u32 v35, v158, 23, v30
	v_lshl_add_u32 v30, v138, 23, v30
	v_lshlrev_b32_e64 v5, v5, 1
	v_lshlrev_b32_e64 v25, v25, 1
	v_mov_b32_e32 v26, v42
	v_mov_b32_e32 v27, v50
	v_mov_b32_e32 v28, v46
	v_mov_b32_e32 v29, v54
	s_mov_b32 s0, 0xbfb8aa3b
	s_movk_i32 s1, 0x7fff
	v_bfrev_b32_e32 v3, -2
	s_mov_b32 s23, s27
	v_mov_b32_e32 v50, v43
	v_mov_b32_e32 v54, v47
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v34, 0xffffff, v0
	v_lshlrev_b32_e32 v0, 2, v34
	buffer_load_dword v24, v0, s[12:15], 0 offen
	v_add_u32_e32 v0, 17, v136
	v_lshlrev_b32_e64 v0, v0, 1
	v_cndmask_b32_e32 v1, v0, v32, vcc
	v_cmp_lt_i32_e32 vcc, 5, v139
	s_nop 1
	v_cndmask_b32_e32 v0, v33, v31, vcc
	v_cmp_lt_i32_e32 vcc, 5, v138
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[32:33], v[24:25], v[0:1] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v31, v5, v30, vcc
	v_cmp_lt_i32_e32 vcc, 5, v158
	v_pk_mul_f32 v[26:27], v[26:27], v[32:33]
	v_lshlrev_b32_e32 v5, 8, v4
	v_cndmask_b32_e32 v30, v25, v35, vcc
	v_pk_mul_f32 v[24:25], v[24:25], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[24:25]
	v_mov_b32_e32 v24, v26
	v_mov_b32_e32 v25, v28
	v_pk_mul_f32 v[24:25], v[24:25], s[0:1] op_sel_hi:[1,0]
	v_cmp_gt_i32_e32 vcc, s33, v34
	v_exp_f32_e32 v32, v24
	v_exp_f32_e32 v33, v25
	v_add_lshl_u32 v24, v5, v129, 1
	v_add_lshl_u32 v5, v5, v130, 1
	v_cndmask_b32_e32 v34, v3, v5, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	v_add_u32_e32 v35, 0x200, v5
	v_rcp_f32_e32 v25, v32
	v_rcp_f32_e32 v32, v33
	v_cndmask_b32_e32 v33, v3, v24, vcc
	v_mul_f32_e32 v25, v26, v25
	v_mul_f32_e32 v26, v28, v32
	v_mul_f32_e32 v25, v27, v25
	v_mul_f32_e32 v26, v29, v26
	v_bfe_u32 v27, v25, 16, 1
	v_or_b32_e32 v28, 0x400000, v25
	v_bfe_u32 v29, v26, 16, 1
	v_add3_u32 v27, v27, v25, s1
	v_cmp_u_f32_e32 vcc, v25, v25
	v_or_b32_e32 v32, 0x400000, v26
	v_add3_u32 v29, v29, v26, s1
	v_cndmask_b32_e32 v25, v27, v28, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v25, 16, v25
	s_nop 0
	v_cndmask_b32_e32 v26, v29, v32, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v25, v33, s[20:23], 0 offen
	buffer_store_short v26, v34, s[20:23], 0 offen
	global_load_dword v25, v[22:23], off offset:4
	v_add_u32_e32 v34, 0x200, v24
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v25, 0xffffff, v25
	v_lshlrev_b32_e32 v26, 2, v25
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v25
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[50:51], v[28:29]
	v_pk_mul_f32 v[26:27], v[54:55], v[26:27]
	v_mov_b32_e32 v32, v28
	v_mov_b32_e32 v33, v26
	v_pk_mul_f32 v[32:33], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v25, v3, v34, vcc
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cndmask_b32_e32 v34, v3, v35, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_mul_f32_e32 v28, v28, v32
	v_mul_f32_e32 v26, v26, v33
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v32, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v33, 0x400000, v26
	v_add3_u32 v32, v32, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	v_mov_b32_e32 v28, v44
	v_cndmask_b32_e32 v26, v32, v33, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v25, s[20:23], 0 offen
	buffer_store_short v26, v34, s[20:23], 0 offen
	global_load_dword v25, v[22:23], off offset:8
	v_mov_b32_e32 v29, v52
	v_mov_b32_e32 v32, v48
	v_mov_b32_e32 v33, v56
	v_mov_b32_e32 v52, v45
	v_mov_b32_e32 v56, v49
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v25, 0xffffff, v25
	v_lshlrev_b32_e32 v26, 2, v25
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v25
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[34:35], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[34:35]
	v_pk_mul_f32 v[26:27], v[32:33], v[26:27]
	v_mov_b32_e32 v32, v28
	v_mov_b32_e32 v33, v26
	v_pk_mul_f32 v[32:33], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v34, 0x400, v24
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_add_u32_e32 v35, 0x400, v5
	v_cndmask_b32_e32 v25, v3, v34, vcc
	v_cndmask_b32_e32 v34, v3, v35, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	v_add_u32_e32 v35, 0x600, v5
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_mul_f32_e32 v28, v28, v32
	v_mul_f32_e32 v26, v26, v33
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v32, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v33, 0x400000, v26
	v_add3_u32 v32, v32, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	s_nop 0
	v_cndmask_b32_e32 v26, v32, v33, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v25, s[20:23], 0 offen
	buffer_store_short v26, v34, s[20:23], 0 offen
	global_load_dword v25, v[22:23], off offset:12
	v_add_u32_e32 v34, 0x600, v24
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v25, 0xffffff, v25
	v_lshlrev_b32_e32 v26, 2, v25
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v25
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[52:53], v[28:29]
	v_pk_mul_f32 v[26:27], v[56:57], v[26:27]
	v_mov_b32_e32 v32, v28
	v_mov_b32_e32 v33, v26
	v_pk_mul_f32 v[32:33], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v25, v3, v34, vcc
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cndmask_b32_e32 v34, v3, v35, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_mul_f32_e32 v28, v28, v32
	v_mul_f32_e32 v26, v26, v33
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v32, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v33, 0x400000, v26
	v_add3_u32 v32, v32, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	v_mov_b32_e32 v28, v14
	v_cndmask_b32_e32 v26, v32, v33, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v25, s[20:23], 0 offen
	buffer_store_short v26, v34, s[20:23], 0 offen
	global_load_dword v25, v[22:23], off offset:64
	v_mov_b32_e32 v29, v18
	v_mov_b32_e32 v32, v6
	v_mov_b32_e32 v33, v10
	v_add_u32_e32 v6, 0x2000, v24
	v_add_u32_e32 v10, 0x2000, v5
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v25, 0xffffff, v25
	v_lshlrev_b32_e32 v26, 2, v25
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v25
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[34:35], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[34:35]
	v_pk_mul_f32 v[26:27], v[32:33], v[26:27]
	v_mov_b32_e32 v32, v28
	v_mov_b32_e32 v33, v26
	v_pk_mul_f32 v[32:33], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cndmask_b32_e32 v10, v3, v10, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v14, v32
	v_rcp_f32_e32 v18, v33
	v_mul_f32_e32 v14, v28, v14
	v_mul_f32_e32 v18, v26, v18
	v_mul_f32_e32 v14, v29, v14
	v_mul_f32_e32 v18, v27, v18
	v_bfe_u32 v25, v14, 16, 1
	v_or_b32_e32 v26, 0x400000, v14
	v_bfe_u32 v27, v18, 16, 1
	v_add3_u32 v25, v25, v14, s1
	v_cmp_u_f32_e32 vcc, v14, v14
	v_or_b32_e32 v28, 0x400000, v18
	v_add3_u32 v27, v27, v18, s1
	v_cndmask_b32_e32 v14, v25, v26, vcc
	v_cmp_u_f32_e32 vcc, v18, v18
	v_lshrrev_b32_e32 v14, 16, v14
	s_nop 0
	v_cndmask_b32_e32 v18, v27, v28, vcc
	v_lshrrev_b32_e32 v18, 16, v18
	buffer_store_short v14, v6, s[20:23], 0 offen
	buffer_store_short v18, v10, s[20:23], 0 offen
	global_load_dword v6, v[22:23], off offset:68
	v_mov_b32_e32 v18, v15
	v_mov_b32_e32 v10, v7
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v25, 0xffffff, v6
	v_lshlrev_b32_e32 v6, 2, v25
	buffer_load_dword v6, v6, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v25
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[6:7], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_mov_b32_e32 v10, v14
	v_mov_b32_e32 v11, v6
	v_pk_mul_f32 v[10:11], v[10:11], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v18, 0x2200, v24
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_add_u32_e32 v19, 0x2200, v5
	v_cndmask_b32_e32 v18, v3, v18, vcc
	v_cndmask_b32_e32 v19, v3, v19, vcc
	v_pk_add_f32 v[10:11], v[10:11], 1.0 op_sel_hi:[1,0]
	v_add_u32_e32 v5, 0x2400, v5
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mul_f32_e32 v10, v14, v10
	v_mul_f32_e32 v6, v6, v11
	v_mul_f32_e32 v10, v15, v10
	v_mul_f32_e32 v6, v7, v6
	v_bfe_u32 v7, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v14, v6, 16, 1
	v_add3_u32 v7, v7, v10, s1
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v15, 0x400000, v6
	v_add3_u32 v14, v14, v6, s1
	v_cndmask_b32_e32 v7, v7, v11, vcc
	v_cmp_u_f32_e32 vcc, v6, v6
	v_lshrrev_b32_e32 v7, 16, v7
	v_mov_b32_e32 v10, v16
	v_cndmask_b32_e32 v6, v14, v15, vcc
	v_lshrrev_b32_e32 v6, 16, v6
	buffer_store_short v7, v18, s[20:23], 0 offen
	buffer_store_short v6, v19, s[20:23], 0 offen
	global_load_dword v6, v[22:23], off offset:72
	v_mov_b32_e32 v11, v20
	v_mov_b32_e32 v14, v8
	v_mov_b32_e32 v15, v12
	v_add_u32_e32 v8, 0x2400, v24
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v25, 0xffffff, v6
	v_lshlrev_b32_e32 v6, 2, v25
	buffer_load_dword v6, v6, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v25
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[18:19], v[6:7], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[18:19]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_mov_b32_e32 v14, v10
	v_mov_b32_e32 v15, v6
	v_pk_mul_f32 v[14:15], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v3, v3, v5, vcc
	v_pk_add_f32 v[14:15], v[14:15], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v14
	v_rcp_f32_e32 v14, v15
	v_mul_f32_e32 v5, v10, v12
	v_mul_f32_e32 v6, v6, v14
	v_mul_f32_e32 v5, v11, v5
	v_mul_f32_e32 v6, v7, v6
	v_bfe_u32 v7, v5, 16, 1
	v_or_b32_e32 v10, 0x400000, v5
	v_bfe_u32 v11, v6, 16, 1
	v_add3_u32 v7, v7, v5, s1
	v_cmp_u_f32_e32 vcc, v5, v5
	v_or_b32_e32 v12, 0x400000, v6
	v_add3_u32 v11, v11, v6, s1
	v_cndmask_b32_e32 v5, v7, v10, vcc
	v_cmp_u_f32_e32 vcc, v6, v6
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v6, v11, v12, vcc
	v_lshrrev_b32_e32 v6, 16, v6
	buffer_store_short v5, v8, s[20:23], 0 offen
	buffer_store_short v6, v3, s[20:23], 0 offen
	global_load_dword v5, v[22:23], off offset:76
	v_or_b32_e32 v3, 19, v4
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v4, 0xffffff, v5
	v_cmp_gt_i32_e64 s[0:1], s33, v4
	s_branch .LBB0_9
.LBB0_5:
	s_cbranch_execz .LBB0_9
	v_mov_b32_e32 v3, 0
	v_lshl_add_u64 v[0:1], s[2:3], 0, v[2:3]
	global_load_dword v10, v[0:1], off offset:128
	global_load_dword v11, v[0:1], off offset:192
	v_xor_b32_e32 v0, v87, v86
	v_or_b32_e32 v1, 8, v87
	v_or_b32_e32 v2, 16, v87
	v_xor_b32_e32 v1, v1, v86
	v_add_u32_e32 v0, v95, v0
	v_or_b32_e32 v4, 24, v87
	v_xor_b32_e32 v12, v2, v86
	scratch_store_dword off, v0, off
	v_add_u32_e32 v0, v95, v1
	v_or_b32_e32 v5, 0x80, v87
	v_xor_b32_e32 v13, v4, v86
	scratch_store_dword off, v0, off offset:4
	v_add_u32_e32 v0, v95, v12
	v_or_b32_e32 v6, 0x88, v87
	v_xor_b32_e32 v18, v5, v86
	scratch_store_dword off, v0, off offset:8
	v_add_u32_e32 v0, v95, v13
	v_xor_b32_e32 v19, v6, v86
	scratch_store_dword off, v0, off offset:12
	v_add_u32_e32 v0, v95, v18
	v_or_b32_e32 v7, 0x90, v87
	v_or_b32_e32 v8, 0x98, v87
	scratch_store_dword off, v0, off offset:16
	v_add_u32_e32 v0, v95, v19
	s_lshl_b32 s7, s5, 3
	s_lshl_b32 s12, s9, 3
	v_xor_b32_e32 v20, v7, v86
	v_xor_b32_e32 v21, v8, v86
	scratch_store_dword off, v0, off offset:20
	s_mov_b32 s15, 0
	s_mov_b32 s24, s4
	s_mov_b32 s28, s10
	s_mov_b32 s31, s27
	s_mov_b32 s9, s37
	s_mov_b32 s10, s38
	s_mov_b32 s11, s27
	s_mov_b32 s17, 0x8080808
	s_mov_b32 s23, 0x5010400
	s_mov_b32 s34, 0x7030602
	s_add_i32 s35, s7, 16
	s_add_i32 s36, s12, 16
	v_mov_b32_e32 v2, v3
	v_mov_b32_e32 v4, v3
	v_mov_b32_e32 v5, v3
	v_mov_b32_e32 v86, v3
	v_mov_b32_e32 v87, v3
	v_mov_b32_e32 v88, v3
	v_mov_b32_e32 v89, v3
	v_mov_b32_e32 v54, v3
	v_mov_b32_e32 v55, v3
	v_mov_b32_e32 v56, v3
	v_mov_b32_e32 v57, v3
	v_mov_b32_e32 v58, v3
	v_mov_b32_e32 v59, v3
	v_mov_b32_e32 v60, v3
	v_mov_b32_e32 v61, v3
	v_mov_b32_e32 v46, v3
	v_mov_b32_e32 v47, v3
	v_mov_b32_e32 v48, v3
	v_mov_b32_e32 v49, v3
	v_mov_b32_e32 v26, v3
	v_mov_b32_e32 v27, v3
	v_mov_b32_e32 v28, v3
	v_mov_b32_e32 v29, v3
	v_mov_b32_e32 v14, v3
	v_mov_b32_e32 v15, v3
	v_mov_b32_e32 v16, v3
	v_mov_b32_e32 v17, v3
	v_mov_b32_e32 v6, v3
	v_mov_b32_e32 v7, v3
	v_mov_b32_e32 v8, v3
	v_mov_b32_e32 v9, v3
	v_mov_b32_e32 v82, v3
	v_mov_b32_e32 v83, v3
	v_mov_b32_e32 v84, v3
	v_mov_b32_e32 v85, v3
	v_mov_b32_e32 v90, v3
	v_mov_b32_e32 v91, v3
	s_waitcnt vmcnt(7)
	v_lshl_or_b32 v0, v10, 12, v94
	v_mov_b32_e32 v92, v3
	v_mov_b32_e32 v93, v3
	v_mov_b32_e32 v62, v3
	v_add_u32_e32 v148, v95, v20
	v_add_u32_e32 v149, v95, v21
	scratch_store_dword off, v0, off offset:24
	s_waitcnt vmcnt(7)
	v_lshl_or_b32 v0, v11, 12, v94
	v_mov_b32_e32 v63, v3
	v_mov_b32_e32 v64, v3
	v_mov_b32_e32 v65, v3
	v_mov_b32_e32 v66, v3
	v_mov_b32_e32 v67, v3
	v_mov_b32_e32 v68, v3
	v_mov_b32_e32 v69, v3
	v_mov_b32_e32 v50, v3
	v_mov_b32_e32 v51, v3
	v_mov_b32_e32 v52, v3
	v_mov_b32_e32 v53, v3
	v_mov_b32_e32 v22, v3
	v_mov_b32_e32 v23, v3
	v_mov_b32_e32 v24, v3
	v_mov_b32_e32 v25, v3
	v_mov_b32_e32 v18, v3
	v_mov_b32_e32 v19, v3
	v_mov_b32_e32 v20, v3
	v_mov_b32_e32 v21, v3
	v_mov_b32_e32 v10, v3
	v_mov_b32_e32 v11, v3
	v_mov_b32_e32 v12, v3
	v_mov_b32_e32 v13, v3
	v_mov_b32_e32 v142, v136
	scratch_store_dword off, v131, off offset:40
	scratch_store_dword off, v130, off offset:36
	scratch_store_dword off, v129, off offset:32
	scratch_store_dword off, v0, off offset:28
.LBB0_7:
	scratch_load_dword v30, off, off offset:24
	scratch_load_dword v31, off, off offset:28
	s_lshl_b32 s0, s15, 8
	v_add_u32_e32 v0, s0, v151
	v_add_u32_e32 v1, s0, v152
	s_lshl_b32 s1, s15, 6
	s_lshl_b32 s2, s15, 7
	v_add_lshl_u32 v32, s1, v134, 2
	v_add_lshl_u32 v33, s1, v137, 2
	v_add_lshl_u32 v35, s2, v140, 4
	v_add_lshl_u32 v38, s2, v135, 4
	v_add_lshl_u32 v42, s2, v150, 4
	v_mov_b32_e32 v147, v152
	buffer_load_dword v152, v32, s[28:31], 0 offen
	buffer_load_dword v153, v33, s[28:31], 0 offen
	buffer_load_dwordx4 v[94:97], v38, s[8:11], 0 offen sc0
	buffer_load_dwordx4 v[78:81], v35, s[8:11], 0 offen sc0
	buffer_load_dwordx4 v[74:77], v42, s[8:11], 0 offen sc0
	v_or_b32_e32 v34, s2, v132
	v_mov_b32_e32 v144, v140
	v_mov_b32_e32 v140, v138
	v_mov_b32_e32 v145, v150
	v_mov_b32_e32 v150, v132
	v_mov_b32_e32 v146, v151
	v_mov_b32_e32 v151, v134
	v_mov_b32_e32 v133, v135
	v_mov_b32_e32 v143, v137
	s_add_i32 s15, s15, 1
	s_cmp_lg_u32 s15, 16
	s_waitcnt vmcnt(6)
	v_add_u32_e32 v30, s0, v30
	s_waitcnt vmcnt(5)
	v_add_u32_e32 v31, s0, v31
	buffer_load_dwordx4 v[98:101], v0, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[102:105], v1, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[106:109], v30, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[110:113], v31, s[24:27], 0 offen nt
	v_lshlrev_b32_e32 v0, 4, v34
	buffer_load_dwordx4 v[34:37], v35, s[8:11], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[38:41], v38, s[8:11], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[30:33], v42, s[8:11], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[70:73], v0, s[8:11], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[42:45], v0, s[8:11], 0 offen offset:1024 sc0
	s_waitcnt vmcnt(8)
	ds_write_b128 v141, v[98:101]
	s_waitcnt vmcnt(7)
	ds_write_b128 v141, v[102:105] offset:4096
	s_waitcnt vmcnt(6)
	ds_write_b128 v141, v[106:109] offset:8192
	s_waitcnt vmcnt(5)
	ds_write_b128 v141, v[110:113] offset:12288
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v98, off, off
	v_sub_u32_sdwa v0, v139, v152 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_bfe_u32 v1, v152, s7, 8
	v_sub_u32_sdwa v109, v142, v153 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v113, 11, v0
	v_bfe_u32 v106, v153, s12, 8
	v_lshrrev_b32_e32 v111, 4, v78
	v_min_i32_e32 v114, 11, v109
	v_sub_u32_e32 v1, v158, v1
	v_cmp_lt_i32_e64 s[0:1], 11, v0
	v_mul_lo_u32 v0, v113, s17
	v_lshrrev_b32_e32 v112, 4, v74
	v_sub_u32_e32 v106, v138, v106
	v_and_b32_e32 v126, 0x7070707, v111
	v_cmp_lt_i32_e32 vcc, 11, v109
	v_mul_lo_u32 v109, v114, s17
	v_min_i32_e32 v111, 11, v1
	v_cmp_lt_i32_e64 s[2:3], 11, v1
	v_sub_u32_e32 v1, 0x6c686080, v0
	v_and_b32_e32 v128, 0x7070707, v112
	v_min_i32_e32 v112, 11, v106
	v_cmp_lt_i32_e64 s[4:5], 11, v106
	v_sub_u32_e32 v0, 0x7c787470, v0
	v_sub_u32_e32 v106, 0x6c686080, v109
	v_mul_lo_u32 v111, v111, s17
	v_and_b32_e32 v1, 0xffffff00, v1
	v_and_b32_e32 v106, 0xffffff00, v106
	v_sub_u32_e32 v113, 0x6c686080, v111
	v_sub_u32_e32 v111, 0x7c787470, v111
	v_mov_b32_e32 v138, v158
	v_cndmask_b32_e64 v158, v0, 0, s[0:1]
	v_cndmask_b32_e64 v161, v1, 0, s[0:1]
	v_mul_lo_u32 v112, v112, s17
	v_cndmask_b32_e64 v162, v106, 0, vcc
	v_add_u32_e32 v106, 0x7f7f7f78, v158
	v_cndmask_b32_e64 v156, v111, 0, s[2:3]
	v_add_u32_e32 v111, 0x7f7f7f00, v161
	v_lshrrev_b32_e32 v110, 4, v94
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v115, 0x7070707, v70
	v_lshrrev_b32_e32 v116, 4, v70
	v_sub_u32_e32 v114, 0x6c686080, v112
	v_and_b32_e32 v0, 0xffffff00, v113
	v_and_b32_e32 v165, 0x80808080, v106
	v_and_b32_e32 v167, 0x80808000, v111
	v_lshlrev_b32_e32 v117, 4, v70
	v_and_b32_e32 v118, 0x7070707, v110
	v_and_b32_e32 v110, 0x7070707, v116
	v_sub_u32_e32 v109, 0x7c787470, v109
	v_and_b32_e32 v1, 0xffffff00, v114
	v_perm_b32 v113, v158, v161, v115
	v_cndmask_b32_e64 v157, v0, 0, s[2:3]
	v_perm_b32 v0, v165, v167, v115
	v_sub_u32_e32 v112, 0x7c787470, v112
	v_cndmask_b32_e64 v159, v109, 0, vcc
	v_perm_b32 v114, v158, v161, v110
	v_cndmask_b32_e64 v155, v1, 0, s[4:5]
	v_and_or_b32 v1, v0, v117, v113
	v_perm_b32 v0, v165, v167, v110
	v_add_u32_e32 v109, 0x7f7f7f78, v159
	v_cndmask_b32_e64 v154, v112, 0, s[4:5]
	v_add_u32_e32 v112, 0x7f7f7f00, v162
	v_and_or_b32 v70, v0, v70, v114
	v_and_b32_e32 v107, 0x7070707, v94
	v_and_b32_e32 v164, 0x80808080, v109
	v_perm_b32 v0, v70, v1, s23
	v_perm_b32 v1, v70, v1, s34
	v_and_b32_e32 v132, 0x80808000, v112
	v_lshlrev_b32_e32 v108, 4, v94
	v_perm_b32 v119, v159, v162, v107
	v_perm_b32 v120, v159, v162, v118
	v_add_u32_e32 v121, 0x7f7f7f78, v156
	v_add_u32_e32 v127, 0x7f7f7f00, v157
	v_and_b32_e32 v122, 0x7070707, v78
	s_waitcnt vmcnt(0)
	ds_read2st64_b64 v[102:105], v98 offset1:8
	ds_read2st64_b64 v[98:101], v98 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[102:103], v[0:1], v[2:5]
	v_add_u32_e32 v70, 0x7f7f7f78, v154
	v_and_b32_e32 v166, 0x80808080, v121
	v_and_b32_e32 v127, 0x80808000, v127
	v_perm_b32 v2, v164, v132, v107
	v_and_or_b32 v3, v2, v108, v119
	v_perm_b32 v2, v164, v132, v118
	v_add_u32_e32 v4, 0x7f7f7f00, v155
	v_and_or_b32 v5, v2, v94, v120
	v_lshlrev_b32_e32 v123, 4, v78
	v_and_b32_e32 v124, 0x7070707, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[104:105], v[0:1], v[54:57]
	v_perm_b32 v2, v5, v3, s23
	v_perm_b32 v3, v5, v3, s34
	v_perm_b32 v5, v156, v157, v122
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[98:99], v[0:1], v[46:49]
	v_and_b32_e32 v160, 0x80808080, v70
	v_and_b32_e32 v163, 0x80808000, v4
	v_perm_b32 v4, v166, v127, v122
	v_perm_b32 v46, v156, v157, v126
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[100:101], v[0:1], v[14:17]
	v_lshlrev_b32_e32 v125, 4, v74
	v_perm_b32 v0, v154, v155, v124
	v_perm_b32 v1, v154, v155, v128
	v_perm_b32 v14, v166, v127, v126
	v_perm_b32 v15, v160, v163, v124
	v_perm_b32 v16, v160, v163, v128
	v_and_or_b32 v4, v4, v123, v5
	v_and_or_b32 v5, v14, v78, v46
	v_and_or_b32 v0, v15, v125, v0
	v_perm_b32 v122, v5, v4, s23
	v_perm_b32 v123, v5, v4, s34
	v_and_or_b32 v1, v16, v74, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[102:103], v[2:3], v[82:85]
	v_perm_b32 v4, v1, v0, s23
	v_perm_b32 v5, v1, v0, s34
	v_bfe_u32 v126, v152, s35, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[104:105], v[2:3], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[98:99], v[2:3], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[100:101], v[2:3], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[104:105], v[122:123], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[98:99], v[122:123], v[26:29]
	s_nop 2
	scratch_load_dword v28, off, off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[102:103], v[122:123], v[86:89]
	v_lshrrev_b32_e32 v26, 4, v95
	v_lshlrev_b32_e32 v27, 4, v95
	v_lshlrev_b32_e32 v29, 4, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[102:103], v[4:5], v[90:93]
	s_waitcnt vmcnt(0)
	ds_read2st64_b64 v[86:89], v28 offset1:8
	ds_read2st64_b64 v[134:137], v28 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[100:101], v[122:123], v[6:9]
	v_lshlrev_b32_e32 v28, 4, v79
	s_nop 1
	v_lshrrev_b32_e32 v7, 4, v71
	v_and_b32_e32 v6, 0x7070707, v71
	v_and_b32_e32 v7, 0x7070707, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[104:105], v[4:5], v[66:69]
	s_nop 2
	v_and_b32_e32 v66, 0x7070707, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[98:99], v[4:5], v[22:25]
	s_nop 2
	v_lshlrev_b32_e32 v22, 4, v71
	v_and_b32_e32 v23, 0x7070707, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[100:101], v[4:5], v[10:13]
	v_perm_b32 v4, v158, v161, v6
	v_perm_b32 v5, v158, v161, v7
	v_perm_b32 v6, v165, v167, v6
	v_perm_b32 v7, v165, v167, v7
	v_perm_b32 v12, v159, v162, v66
	v_perm_b32 v24, v159, v162, v23
	v_perm_b32 v13, v164, v132, v66
	v_perm_b32 v23, v164, v132, v23
	v_and_or_b32 v4, v6, v22, v4
	v_and_or_b32 v5, v7, v71, v5
	v_lshrrev_b32_e32 v25, 4, v79
	v_and_or_b32 v6, v13, v27, v12
	v_perm_b32 v12, v5, v4, s23
	v_perm_b32 v13, v5, v4, s34
	v_and_or_b32 v4, v23, v95, v24
	v_and_b32_e32 v24, 0x7070707, v79
	v_and_b32_e32 v25, 0x7070707, v25
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[128:131], v[86:87], v[12:13], v[114:117]
	v_perm_b32 v22, v4, v6, s23
	v_perm_b32 v23, v4, v6, s34
	v_and_b32_e32 v26, 0x7070707, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[88:89], v[12:13], v[110:113]
	v_lshrrev_b32_e32 v27, 4, v75
	v_perm_b32 v71, v156, v157, v24
	v_and_b32_e32 v70, 0x7070707, v27
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[134:135], v[12:13], v[106:109]
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[136:137], v[12:13], v[54:57]
	v_perm_b32 v12, v156, v157, v25
	v_perm_b32 v13, v154, v155, v26
	s_nop 0
	v_perm_b32 v55, v166, v127, v24
	v_perm_b32 v56, v166, v127, v25
	v_perm_b32 v57, v160, v163, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[134:135], v[22:23], v[50:53]
	v_and_or_b32 v28, v55, v28, v71
	v_perm_b32 v54, v154, v155, v70
	s_nop 0
	v_and_or_b32 v51, v56, v79, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[86:87], v[22:23], v[118:121]
	v_perm_b32 v50, v160, v163, v70
	v_perm_b32 v12, v51, v28, s23
	scratch_load_dword v79, off, off offset:12
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[88:89], v[22:23], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[136:137], v[22:23], v[82:85]
	v_and_or_b32 v22, v57, v29, v13
	v_perm_b32 v13, v51, v28, s34
	v_and_b32_e32 v28, 0x7070707, v76
	v_lshlrev_b32_e32 v29, 4, v76
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[86:87], v[12:13], v[18:21]
	s_nop 2
	v_and_or_b32 v18, v50, v75, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[88:89], v[12:13], v[0:3]
	v_perm_b32 v20, v18, v22, s23
	v_perm_b32 v21, v18, v22, s34
	s_nop 0
	scratch_load_dword v3, off, off offset:8
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[86:87], v[20:21], v[46:49]
	v_and_b32_e32 v0, 0x7070707, v96
	v_lshrrev_b32_e32 v1, 4, v96
	v_lshlrev_b32_e32 v2, 4, v96
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[136:137], v[20:21], v[8:11]
	v_and_b32_e32 v1, 0x7070707, v1
	s_nop 1
	v_and_b32_e32 v8, 0x7070707, v72
	v_lshlrev_b32_e32 v9, 4, v72
	v_perm_b32 v10, v158, v161, v8
	v_perm_b32 v8, v165, v167, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[88:89], v[20:21], v[14:17]
	s_waitcnt vmcnt(0)
	ds_read2st64_b64 v[98:101], v3 offset1:8
	s_nop 0
	ds_read2st64_b64 v[16:19], v3 offset0:16 offset1:24
	v_and_or_b32 v8, v8, v9, v10
	v_lshrrev_b32_e32 v9, 4, v72
	v_perm_b32 v10, v159, v162, v0
	v_perm_b32 v0, v164, v132, v0
	v_and_b32_e32 v9, 0x7070707, v9
	v_and_or_b32 v2, v0, v2, v10
	v_perm_b32 v10, v159, v162, v1
	v_perm_b32 v1, v164, v132, v1
	v_perm_b32 v0, v158, v161, v9
	v_perm_b32 v9, v165, v167, v9
	v_and_or_b32 v10, v1, v96, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[134:135], v[12:13], v[58:61]
	v_and_b32_e32 v3, 0x7070707, v80
	v_and_or_b32 v9, v9, v72, v0
	v_perm_b32 v70, v10, v2, s23
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[136:137], v[12:13], v[90:93]
	v_lshrrev_b32_e32 v12, 4, v80
	v_perm_b32 v71, v10, v2, s34
	v_lshlrev_b32_e32 v13, 4, v80
	v_lshrrev_b32_e32 v14, 4, v76
	v_perm_b32 v0, v9, v8, s23
	v_perm_b32 v1, v9, v8, s34
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[98:99], v[70:71], v[4:7]
	v_and_b32_e32 v2, 0x7070707, v12
	v_and_b32_e32 v72, 0x7070707, v97
	v_lshrrev_b32_e32 v136, 4, v30
	v_perm_b32 v5, v156, v157, v3
	v_perm_b32 v3, v166, v127, v3
	v_and_b32_e32 v4, 0x7070707, v14
	v_and_or_b32 v3, v3, v13, v5
	v_perm_b32 v5, v156, v157, v2
	v_perm_b32 v2, v166, v127, v2
	v_perm_b32 v6, v154, v155, v28
	v_and_or_b32 v2, v2, v80, v5
	v_perm_b32 v5, v154, v155, v4
	v_perm_b32 v7, v160, v163, v28
	v_perm_b32 v4, v160, v163, v4
	v_and_or_b32 v6, v7, v29, v6
	v_and_or_b32 v4, v4, v76, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[134:135], v[20:21], v[102:105]
	v_perm_b32 v74, v2, v3, s23
	v_perm_b32 v75, v2, v3, s34
	v_perm_b32 v28, v4, v6, s23
	v_perm_b32 v29, v4, v6, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[98:99], v[0:1], v[128:131]
	v_lshrrev_b32_e32 v76, 4, v97
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v78, v159, v162, v76
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[100:101], v[0:1], v[66:69]
	v_perm_b32 v76, v164, v132, v76
	v_and_b32_e32 v130, 0x7070707, v34
	v_and_b32_e32 v134, 0x7070707, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[100:101], v[70:71], v[62:65]
	v_lshlrev_b32_e32 v128, 4, v39
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[16:17], v[0:1], v[110:113]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[0:1], v[114:117]
	s_nop 1
	v_sub_u32_sdwa v113, v139, v152 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_bfe_u32 v112, v153, s36, 8
	v_cmp_lt_i32_e64 s[2:3], 11, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[98:99], v[74:75], v[118:121]
	v_and_or_b32 v117, v76, v97, v78
	v_lshlrev_b32_e32 v114, 4, v97
	v_and_b32_e32 v116, 0x7070707, v77
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[98:99], v[28:29], v[122:125]
	v_lshlrev_b32_e32 v120, 4, v81
	v_sub_u32_sdwa v118, v142, v153 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshrrev_b32_e32 v121, 4, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[100:101], v[74:75], v[54:57]
	v_lshlrev_b32_e32 v123, 4, v77
	v_cmp_lt_i32_e64 s[4:5], 11, v118
	v_perm_b32 v135, v154, v155, v116
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[100:101], v[28:29], v[50:53]
	ds_read2st64_b64 v[54:57], v79 offset1:8
	v_perm_b32 v137, v160, v163, v116
	v_and_b32_e32 v110, 0x7070707, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[16:17], v[70:71], v[24:27]
	v_lshlrev_b32_e32 v111, 4, v38
	v_lshrrev_b32_e32 v125, 4, v39
	v_and_b32_e32 v124, 0x7070707, v39
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[18:19], v[70:71], v[106:109]
	v_lshrrev_b32_e32 v70, 4, v81
	v_and_b32_e32 v70, 0x7070707, v70
	v_perm_b32 v71, v156, v157, v70
	v_perm_b32 v70, v166, v127, v70
	ds_read2st64_b64 v[24:27], v79 offset0:16 offset1:24
	v_and_or_b32 v119, v70, v81, v71
	v_and_b32_e32 v70, 0x7070707, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[16:17], v[74:75], v[86:89]
	v_lshrrev_b32_e32 v71, 4, v77
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v131, v156, v157, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[16:17], v[28:29], v[102:105]
	scratch_load_dword v16, off, off offset:16
	v_perm_b32 v127, v166, v127, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[18:19], v[74:75], v[90:93]
	v_perm_b32 v74, v154, v155, v71
	v_perm_b32 v71, v160, v163, v71
	v_and_or_b32 v122, v71, v77, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[18:19], v[28:29], v[46:49]
	scratch_load_dword v19, off, off offset:20
	v_perm_b32 v28, v159, v162, v72
	v_perm_b32 v71, v164, v132, v72
	v_and_or_b32 v129, v71, v114, v28
	v_lshrrev_b32_e32 v132, 4, v34
	v_perm_b32 v116, v117, v129, s23
	v_perm_b32 v117, v117, v129, s34
	v_lshlrev_b32_e32 v129, 4, v30
	v_and_b32_e32 v28, 0x7070707, v40
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[54:55], v[116:117], v[8:11]
	s_waitcnt vmcnt(1)
	ds_read2st64_b64 v[94:97], v16 offset1:8
	ds_read2st64_b64 v[74:77], v16 offset0:16 offset1:24
	v_lshrrev_b32_e32 v16, 4, v73
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v17, v158, v161, v16
	v_perm_b32 v16, v165, v167, v16
	v_and_or_b32 v29, v16, v73, v17
	v_and_b32_e32 v16, 0x7070707, v73
	v_lshlrev_b32_e32 v17, 4, v73
	v_perm_b32 v18, v158, v161, v16
	v_perm_b32 v16, v165, v167, v16
	v_and_or_b32 v72, v16, v17, v18
	v_perm_b32 v114, v29, v72, s23
	v_perm_b32 v115, v29, v72, s34
	v_mov_b32_e32 v158, v138
	v_mov_b32_e32 v138, v140
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[54:55], v[114:115], v[20:23]
	v_sub_u32_e32 v112, v138, v112
	v_cmp_lt_i32_e64 s[0:1], 11, v112
	v_lshlrev_b32_e32 v29, 4, v34
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[24:25], v[114:115], v[82:85]
	s_waitcnt vmcnt(0)
	ds_read2st64_b64 v[46:49], v19 offset1:8
	ds_read2st64_b64 v[16:19], v19 offset0:16 offset1:24
	v_mov_b32_e32 v140, v144
	v_min_i32_e32 v82, 11, v113
	v_min_i32_e32 v83, 11, v118
	v_lshrrev_b32_e32 v84, 4, v42
	v_sub_u32_e32 v85, v158, v126
	v_and_b32_e32 v118, 0x7070707, v121
	v_and_b32_e32 v121, 0x7070707, v132
	v_and_b32_e32 v126, 0x7070707, v136
	v_mul_lo_u32 v82, v82, s17
	v_mul_lo_u32 v132, v83, s17
	v_and_b32_e32 v136, 0x7070707, v84
	v_and_or_b32 v84, v127, v120, v131
	v_cmp_lt_i32_e32 vcc, 11, v85
	v_min_i32_e32 v83, 11, v85
	v_min_i32_e32 v85, 11, v112
	v_perm_b32 v112, v119, v84, s23
	v_perm_b32 v113, v119, v84, s34
	v_sub_u32_e32 v119, 0x6c686080, v82
	v_sub_u32_e32 v120, 0x6c686080, v132
	v_mul_lo_u32 v127, v83, s17
	v_mul_lo_u32 v131, v85, s17
	v_sub_u32_e32 v152, 0x7c787470, v82
	v_sub_u32_e32 v132, 0x7c787470, v132
	v_and_b32_e32 v119, 0xffffff00, v119
	v_and_b32_e32 v120, 0xffffff00, v120
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[56:57], v[116:117], v[12:15]
	v_cndmask_b32_e64 v119, v119, 0, s[2:3]
	v_cndmask_b32_e64 v120, v120, 0, s[4:5]
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[24:25], v[116:117], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[26:27], v[116:117], v[106:109]
	v_sub_u32_e32 v116, 0x7c787470, v127
	v_sub_u32_e32 v117, 0x7c787470, v131
	s_nop 0
	v_sub_u32_e32 v108, 0x6c686080, v127
	v_sub_u32_e32 v109, 0x6c686080, v131
	v_cndmask_b32_e64 v127, v152, 0, s[2:3]
	v_cndmask_b32_e64 v131, v132, 0, s[4:5]
	v_and_or_b32 v107, v137, v123, v135
	v_perm_b32 v106, v122, v107, s23
	v_perm_b32 v107, v122, v107, s34
	v_add_u32_e32 v122, 0x7f7f7f78, v127
	v_add_u32_e32 v123, 0x7f7f7f78, v131
	v_cndmask_b32_e64 v132, v116, 0, vcc
	v_cndmask_b32_e64 v135, v117, 0, s[0:1]
	v_add_u32_e32 v116, 0x7f7f7f00, v119
	v_add_u32_e32 v117, 0x7f7f7f00, v120
	v_and_b32_e32 v108, 0xffffff00, v108
	v_and_b32_e32 v109, 0xffffff00, v109
	v_and_b32_e32 v122, 0x80808080, v122
	v_and_b32_e32 v123, 0x80808080, v123
	v_and_b32_e32 v155, 0x80808000, v116
	v_and_b32_e32 v156, 0x80808000, v117
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[56:57], v[114:115], v[66:69]
	v_perm_b32 v152, v127, v119, v136
	v_cndmask_b32_e64 v153, v108, 0, vcc
	v_cndmask_b32_e64 v154, v109, 0, s[0:1]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[114:115], v[62:65]
	v_and_b32_e32 v114, 0x7070707, v42
	v_perm_b32 v108, v123, v156, v110
	v_perm_b32 v109, v123, v156, v118
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[54:55], v[112:113], v[0:3]
	v_lshlrev_b32_e32 v115, 4, v42
	v_perm_b32 v137, v127, v119, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[54:55], v[106:107], v[4:7]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[56:57], v[112:113], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[56:57], v[106:107], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[24:25], v[112:113], v[86:89]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[26:27], v[112:113], v[90:93]
	s_nop 2
	v_perm_b32 v90, v131, v120, v110
	v_perm_b32 v92, v131, v120, v118
	v_perm_b32 v93, v122, v155, v136
	v_perm_b32 v91, v122, v155, v114
	v_and_or_b32 v42, v93, v42, v152
	v_and_or_b32 v93, v108, v111, v90
	v_and_or_b32 v38, v109, v38, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[24:25], v[106:107], v[78:81]
	v_and_or_b32 v91, v91, v115, v137
	v_perm_b32 v92, v38, v93, s23
	v_perm_b32 v93, v38, v93, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[26:27], v[106:107], v[102:105]
	v_add_u32_e32 v38, 0x7f7f7f78, v132
	v_perm_b32 v90, v42, v91, s23
	v_perm_b32 v91, v42, v91, s34
	v_add_u32_e32 v102, 0x7f7f7f00, v153
	v_add_u32_e32 v42, 0x7f7f7f78, v135
	v_add_u32_e32 v103, 0x7f7f7f00, v154
	v_and_b32_e32 v136, 0x80808080, v38
	v_and_b32_e32 v152, 0x80808000, v102
	v_perm_b32 v104, v132, v153, v130
	v_perm_b32 v105, v132, v153, v121
	v_and_b32_e32 v137, 0x80808080, v42
	v_and_b32_e32 v157, 0x80808000, v103
	v_perm_b32 v38, v136, v152, v130
	v_perm_b32 v42, v136, v152, v121
	v_perm_b32 v106, v135, v154, v134
	v_perm_b32 v102, v137, v157, v134
	v_and_or_b32 v29, v38, v29, v104
	v_and_or_b32 v34, v42, v34, v105
	v_perm_b32 v107, v135, v154, v126
	v_perm_b32 v108, v137, v157, v126
	v_and_or_b32 v38, v102, v129, v106
	v_perm_b32 v102, v34, v29, s23
	v_perm_b32 v103, v34, v29, s34
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[94:95], v[90:91], v[70:73]
	v_lshrrev_b32_e32 v34, 4, v43
	v_and_b32_e32 v34, 0x7070707, v34
	v_and_b32_e32 v42, 0x7070707, v125
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[94:95], v[92:93], v[8:11]
	v_lshrrev_b32_e32 v29, 4, v40
	v_lshlrev_b32_e32 v106, 4, v40
	v_mov_b32_e32 v134, v151
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[96:97], v[90:91], v[66:69]
	v_mov_b32_e32 v151, v146
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[96:97], v[92:93], v[12:15]
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[74:75], v[90:91], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[74:75], v[92:93], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[76:77], v[90:91], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[76:77], v[92:93], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[94:95], v[102:103], v[0:3]
	s_nop 2
	v_and_or_b32 v0, v108, v30, v107
	v_perm_b32 v104, v0, v38, s23
	v_perm_b32 v105, v0, v38, s34
	v_and_b32_e32 v30, 0x7070707, v43
	v_lshlrev_b32_e32 v38, 4, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[94:95], v[104:105], v[4:7]
	v_perm_b32 v94, v127, v119, v30
	v_perm_b32 v95, v127, v119, v34
	v_perm_b32 v30, v122, v155, v30
	v_perm_b32 v34, v122, v155, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[96:97], v[102:103], v[58:61]
	v_and_or_b32 v30, v30, v38, v94
	v_and_or_b32 v34, v34, v43, v95
	v_perm_b32 v43, v34, v30, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[96:97], v[104:105], v[50:53]
	v_perm_b32 v96, v131, v120, v124
	v_perm_b32 v97, v131, v120, v42
	ds_read2st64_b64 v[0:3], v148 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[74:75], v[102:103], v[54:57]
	v_and_b32_e32 v95, 0x7070707, v31
	v_lshlrev_b32_e32 v94, 4, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[74:75], v[104:105], v[78:81]
	v_perm_b32 v74, v123, v156, v124
	v_perm_b32 v75, v123, v156, v42
	v_and_or_b32 v74, v74, v128, v96
	v_perm_b32 v42, v34, v30, s23
	v_and_or_b32 v30, v75, v39, v97
	v_perm_b32 v38, v30, v74, s23
	v_perm_b32 v39, v30, v74, s34
	v_and_b32_e32 v30, 0x7070707, v35
	v_lshrrev_b32_e32 v34, 4, v35
	v_lshrrev_b32_e32 v74, 4, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[76:77], v[102:103], v[86:89]
	v_lshlrev_b32_e32 v96, 4, v31
	v_and_b32_e32 v34, 0x7070707, v34
	v_and_b32_e32 v97, 0x7070707, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[76:77], v[104:105], v[24:27]
	v_perm_b32 v102, v132, v153, v30
	v_perm_b32 v104, v135, v154, v95
	v_perm_b32 v30, v136, v152, v30
	v_perm_b32 v95, v137, v157, v95
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[46:47], v[42:43], v[70:73]
	v_perm_b32 v103, v132, v153, v34
	v_perm_b32 v105, v135, v154, v97
	v_perm_b32 v34, v136, v152, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[46:47], v[38:39], v[8:11]
	v_and_or_b32 v30, v30, v94, v102
	v_and_or_b32 v35, v34, v35, v103
	v_perm_b32 v34, v35, v30, s23
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[48:49], v[42:43], v[66:69]
	v_perm_b32 v35, v35, v30, s34
	v_perm_b32 v102, v131, v120, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[48:49], v[38:39], v[12:15]
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[16:17], v[42:43], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[16:17], v[38:39], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[42:43], v[62:65]
	v_perm_b32 v42, v137, v157, v97
	v_and_or_b32 v30, v42, v31, v105
	v_lshrrev_b32_e32 v31, 4, v44
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[18:19], v[38:39], v[90:93]
	v_and_or_b32 v39, v95, v96, v104
	ds_read2st64_b64 v[94:97], v148 offset0:16 offset1:24
	v_perm_b32 v38, v30, v39, s23
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[46:47], v[34:35], v[98:101]
	v_perm_b32 v39, v30, v39, s34
	v_and_b32_e32 v30, 0x7070707, v44
	v_lshrrev_b32_e32 v43, 4, v41
	v_and_b32_e32 v99, 0x7070707, v29
	v_and_b32_e32 v29, 0x7070707, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[46:47], v[38:39], v[4:7]
	v_lshlrev_b32_e32 v98, 4, v44
	v_perm_b32 v100, v127, v119, v30
	v_perm_b32 v101, v127, v119, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[48:49], v[34:35], v[58:61]
	v_perm_b32 v103, v131, v120, v99
	v_and_b32_e32 v42, 0x7070707, v41
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[48:49], v[38:39], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[16:17], v[34:35], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[16:17], v[38:39], v[78:81]
	v_perm_b32 v16, v122, v155, v30
	v_perm_b32 v17, v122, v155, v29
	v_and_or_b32 v44, v17, v44, v101
	v_perm_b32 v78, v123, v156, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[18:19], v[34:35], v[86:89]
	v_and_or_b32 v35, v16, v98, v100
	v_perm_b32 v79, v123, v156, v99
	v_perm_b32 v34, v44, v35, s23
	v_perm_b32 v35, v44, v35, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[18:19], v[38:39], v[24:27]
	v_and_or_b32 v39, v78, v106, v102
	v_and_or_b32 v40, v79, v40, v103
	v_lshrrev_b32_e32 v44, 4, v36
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[0:1], v[34:35], v[70:73]
	v_perm_b32 v38, v40, v39, s23
	v_perm_b32 v39, v40, v39, s34
	v_and_b32_e32 v40, 0x7070707, v36
	v_lshrrev_b32_e32 v70, 4, v32
	v_and_b32_e32 v79, 0x7070707, v32
	v_and_b32_e32 v44, 0x7070707, v44
	v_and_b32_e32 v80, 0x7070707, v70
	v_lshlrev_b32_e32 v78, 4, v36
	v_lshlrev_b32_e32 v86, 4, v32
	v_perm_b32 v81, v132, v153, v40
	v_perm_b32 v87, v132, v153, v44
	v_perm_b32 v88, v135, v154, v79
	v_perm_b32 v98, v135, v154, v80
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[94:95], v[38:39], v[74:77]
	v_perm_b32 v40, v136, v152, v40
	v_perm_b32 v44, v136, v152, v44
	v_perm_b32 v89, v137, v157, v79
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[96:97], v[34:35], v[62:65]
	v_and_or_b32 v36, v44, v36, v87
	s_nop 1
	v_perm_b32 v62, v137, v157, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[0:1], v[38:39], v[8:11]
	v_and_or_b32 v32, v62, v32, v98
	ds_read2st64_b64 v[98:101], v149 offset1:8
	ds_read2st64_b64 v[102:105], v149 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[2:3], v[34:35], v[66:69]
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[2:3], v[38:39], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[94:95], v[34:35], v[20:23]
	v_and_or_b32 v35, v40, v78, v81
	v_perm_b32 v34, v36, v35, s23
	v_perm_b32 v35, v36, v35, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[96:97], v[38:39], v[82:85]
	v_and_or_b32 v39, v89, v86, v88
	v_perm_b32 v38, v32, v39, s23
	v_perm_b32 v39, v32, v39, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[0:1], v[34:35], v[90:93]
	v_perm_b32 v36, v123, v156, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[0:1], v[38:39], v[4:7]
	v_and_b32_e32 v1, 0x7070707, v45
	v_lshlrev_b32_e32 v0, 4, v41
	s_nop 0
	v_lshrrev_b32_e32 v4, 4, v45
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[2:3], v[34:35], v[58:61]
	v_perm_b32 v7, v131, v120, v42
	v_lshlrev_b32_e32 v5, 4, v45
	v_and_or_b32 v7, v36, v0, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[2:3], v[38:39], v[46:49]
	v_and_b32_e32 v2, 0x7070707, v43
	v_and_b32_e32 v3, 0x7070707, v4
	v_perm_b32 v4, v127, v119, v1
	v_perm_b32 v6, v127, v119, v3
	v_perm_b32 v32, v131, v120, v2
	v_perm_b32 v3, v122, v155, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[96:97], v[34:35], v[28:31]
	v_perm_b32 v1, v122, v155, v1
	v_and_or_b32 v1, v1, v5, v4
	s_nop 0
	v_perm_b32 v28, v123, v156, v2
	v_and_or_b32 v2, v3, v45, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[96:97], v[38:39], v[16:19]
	v_perm_b32 v0, v2, v1, s23
	v_perm_b32 v1, v2, v1, s34
	s_nop 0
	v_and_or_b32 v16, v28, v41, v32
	v_perm_b32 v6, v16, v7, s23
	v_perm_b32 v7, v16, v7, s34
	v_lshrrev_b32_e32 v16, 4, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[94:95], v[34:35], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[98:99], v[6:7], v[8:11]
	s_nop 2
	v_lshrrev_b32_e32 v9, 4, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[94:95], v[38:39], v[54:57]
	v_and_b32_e32 v8, 0x7070707, v37
	v_and_b32_e32 v11, 0x7070707, v33
	v_and_b32_e32 v9, 0x7070707, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[100:101], v[6:7], v[12:15]
	v_lshlrev_b32_e32 v10, 4, v37
	v_perm_b32 v18, v132, v153, v9
	v_perm_b32 v9, v136, v152, v9
	v_and_b32_e32 v12, 0x7070707, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[98:99], v[0:1], v[24:27]
	v_perm_b32 v13, v132, v153, v8
	v_perm_b32 v8, v136, v152, v8
	v_mov_b32_e32 v132, v150
	v_lshlrev_b32_e32 v24, 4, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[102:103], v[0:1], v[20:23]
	v_mov_b32_e32 v150, v145
	v_mov_b32_e32 v152, v147
	s_nop 0
	v_perm_b32 v22, v135, v154, v11
	v_perm_b32 v23, v135, v154, v12
	v_perm_b32 v11, v137, v157, v11
	v_perm_b32 v12, v137, v157, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[100:101], v[0:1], v[66:69]
	v_mov_b32_e32 v135, v133
	v_mov_b32_e32 v137, v143
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[6:7], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[104:105], v[0:1], v[74:77]
	v_and_or_b32 v1, v8, v10, v13
	v_and_or_b32 v8, v9, v37, v18
	v_perm_b32 v0, v8, v1, s23
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[104:105], v[6:7], v[78:81]
	v_and_or_b32 v6, v11, v24, v22
	v_and_or_b32 v7, v12, v33, v23
	v_perm_b32 v1, v8, v1, s34
	v_perm_b32 v10, v7, v6, s23
	v_perm_b32 v11, v7, v6, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[98:99], v[0:1], v[86:89]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[98:99], v[10:11], v[90:93]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[100:101], v[0:1], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[100:101], v[10:11], v[106:109]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[102:103], v[0:1], v[110:113]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[102:103], v[10:11], v[114:117]
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[104:105], v[0:1], v[118:121]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[104:105], v[10:11], v[42:45]
	s_cbranch_scc1 .LBB0_7
	scratch_load_dword v0, off, off offset:40
	scratch_load_dword v129, off, off offset:32
	scratch_load_dword v130, off, off offset:36
	s_mov_b32 s12, s6
	s_mov_b32 s15, s27
	v_add_u32_e32 v1, 17, v139
	v_cmp_lt_i32_e32 vcc, 5, v142
	v_add_u32_e32 v30, 17, v138
	v_lshlrev_b32_e64 v43, v1, 1
	v_add_u32_e32 v31, 17, v158
	v_lshlrev_b32_e64 v30, v30, 1
	v_lshlrev_b32_e64 v70, v31, 1
	v_mov_b32_e32 v38, v2
	v_mov_b32_e32 v39, v82
	v_mov_b32_e32 v40, v86
	v_mov_b32_e32 v41, v90
	s_mov_b32 s0, 0xbfb8aa3b
	s_movk_i32 s1, 0x7fff
	v_bfrev_b32_e32 v2, -2
	s_mov_b32 s23, s27
	v_mov_b32_e32 v82, v3
	v_mov_b32_e32 v90, v87
	s_waitcnt vmcnt(2)
	v_lshl_or_b32 v32, v0, 2, s16
	v_ashrrev_i32_e32 v33, 31, v32
	v_lshl_add_u64 v[34:35], v[32:33], 2, s[18:19]
	global_load_dword v0, v[34:35], off
	v_mov_b32_e32 v33, 0xfd800000
	v_lshl_add_u32 v42, v142, 23, v33
	v_lshl_add_u32 v37, v139, 23, v33
	v_lshl_add_u32 v45, v158, 23, v33
	v_lshl_add_u32 v33, v138, 23, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v44, 0xffffff, v0
	v_lshlrev_b32_e32 v0, 2, v44
	buffer_load_dword v36, v0, s[12:15], 0 offen
	v_add_u32_e32 v0, 17, v142
	v_lshlrev_b32_e64 v0, v0, 1
	v_cndmask_b32_e32 v1, v0, v42, vcc
	v_cmp_lt_i32_e32 vcc, 5, v139
	s_nop 1
	v_cndmask_b32_e32 v0, v43, v37, vcc
	v_cmp_lt_i32_e32 vcc, 5, v138
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[36:37], v[0:1] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v31, v30, v33, vcc
	v_cmp_lt_i32_e32 vcc, 5, v158
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_lshlrev_b32_e32 v33, 8, v32
	v_cndmask_b32_e32 v30, v70, v45, vcc
	v_pk_mul_f32 v[36:37], v[36:37], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[36:37]
	v_mov_b32_e32 v36, v38
	v_mov_b32_e32 v37, v40
	v_pk_mul_f32 v[36:37], v[36:37], s[0:1] op_sel_hi:[1,0]
	v_cmp_gt_u32_e32 vcc, s33, v44
	v_exp_f32_e32 v42, v36
	v_exp_f32_e32 v43, v37
	v_add_lshl_u32 v36, v33, v129, 1
	v_add_lshl_u32 v33, v33, v130, 1
	v_cndmask_b32_e32 v44, v2, v33, vcc
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	v_add_u32_e32 v3, 0x200, v36
	v_rcp_f32_e32 v37, v42
	v_rcp_f32_e32 v42, v43
	v_cndmask_b32_e32 v43, v2, v36, vcc
	v_mul_f32_e32 v37, v38, v37
	v_mul_f32_e32 v38, v40, v42
	v_mul_f32_e32 v37, v39, v37
	v_mul_f32_e32 v38, v41, v38
	v_bfe_u32 v39, v37, 16, 1
	v_or_b32_e32 v40, 0x400000, v37
	v_bfe_u32 v41, v38, 16, 1
	v_add3_u32 v39, v39, v37, s1
	v_cmp_u_f32_e32 vcc, v37, v37
	v_or_b32_e32 v42, 0x400000, v38
	v_add3_u32 v41, v41, v38, s1
	v_cndmask_b32_e32 v37, v39, v40, vcc
	v_cmp_u_f32_e32 vcc, v38, v38
	v_lshrrev_b32_e32 v37, 16, v37
	s_nop 0
	v_cndmask_b32_e32 v38, v41, v42, vcc
	v_lshrrev_b32_e32 v38, 16, v38
	buffer_store_short v37, v43, s[20:23], 0 offen
	buffer_store_short v38, v44, s[20:23], 0 offen
	global_load_dword v37, v[34:35], off offset:4
	v_add_u32_e32 v44, 0x200, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v37, 0xffffff, v37
	v_lshlrev_b32_e32 v38, 2, v37
	buffer_load_dword v38, v38, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v37
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[40:41], v[38:39], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[82:83], v[40:41]
	v_pk_mul_f32 v[38:39], v[90:91], v[38:39]
	v_mov_b32_e32 v42, v40
	v_mov_b32_e32 v43, v38
	v_pk_mul_f32 v[42:43], v[42:43], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v3, vcc
	v_exp_f32_e32 v42, v42
	v_exp_f32_e32 v43, v43
	v_cndmask_b32_e32 v37, v2, v44, vcc
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v42, v42
	v_rcp_f32_e32 v43, v43
	v_mul_f32_e32 v40, v40, v42
	v_mul_f32_e32 v38, v38, v43
	v_mul_f32_e32 v40, v41, v40
	v_mul_f32_e32 v38, v39, v38
	v_bfe_u32 v39, v40, 16, 1
	v_or_b32_e32 v41, 0x400000, v40
	v_bfe_u32 v42, v38, 16, 1
	v_add3_u32 v39, v39, v40, s1
	v_cmp_u_f32_e32 vcc, v40, v40
	v_or_b32_e32 v43, 0x400000, v38
	v_add3_u32 v42, v42, v38, s1
	v_cndmask_b32_e32 v39, v39, v41, vcc
	v_cmp_u_f32_e32 vcc, v38, v38
	v_lshrrev_b32_e32 v39, 16, v39
	v_mov_b32_e32 v40, v4
	v_cndmask_b32_e32 v38, v42, v43, vcc
	v_lshrrev_b32_e32 v38, 16, v38
	buffer_store_short v39, v3, s[20:23], 0 offen
	buffer_store_short v38, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:8
	v_mov_b32_e32 v41, v84
	v_mov_b32_e32 v42, v88
	v_mov_b32_e32 v43, v92
	v_add_u32_e32 v4, 0x400, v36
	v_mov_b32_e32 v84, v5
	v_mov_b32_e32 v92, v89
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v37, 2, v3
	buffer_load_dword v38, v37, s[12:15], 0 offen
	v_add_u32_e32 v37, 0x400, v33
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[44:45], v[38:39], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[44:45]
	v_pk_mul_f32 v[38:39], v[42:43], v[38:39]
	v_mov_b32_e32 v42, v40
	v_mov_b32_e32 v43, v38
	v_pk_mul_f32 v[42:43], v[42:43], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v4, vcc
	v_exp_f32_e32 v42, v42
	v_exp_f32_e32 v43, v43
	v_cndmask_b32_e32 v4, v2, v37, vcc
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v42, v42
	v_rcp_f32_e32 v43, v43
	v_mul_f32_e32 v37, v40, v42
	v_mul_f32_e32 v38, v38, v43
	v_mul_f32_e32 v37, v41, v37
	v_mul_f32_e32 v38, v39, v38
	v_bfe_u32 v39, v37, 16, 1
	v_or_b32_e32 v40, 0x400000, v37
	v_bfe_u32 v41, v38, 16, 1
	v_add3_u32 v39, v39, v37, s1
	v_cmp_u_f32_e32 vcc, v37, v37
	v_or_b32_e32 v42, 0x400000, v38
	v_add3_u32 v41, v41, v38, s1
	v_cndmask_b32_e32 v37, v39, v40, vcc
	v_cmp_u_f32_e32 vcc, v38, v38
	v_lshrrev_b32_e32 v37, 16, v37
	s_nop 0
	v_cndmask_b32_e32 v38, v41, v42, vcc
	v_lshrrev_b32_e32 v38, 16, v38
	buffer_store_short v37, v3, s[20:23], 0 offen
	buffer_store_short v38, v4, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:12
	v_add_u32_e32 v37, 0x600, v36
	v_add_u32_e32 v42, 0x600, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[84:85], v[38:39]
	v_pk_mul_f32 v[4:5], v[92:93], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v37, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v37, v2, v42, vcc
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v40, v40
	v_rcp_f32_e32 v41, v41
	v_mul_f32_e32 v38, v38, v40
	v_mul_f32_e32 v4, v4, v41
	v_mul_f32_e32 v38, v39, v38
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v38, 16, 1
	v_or_b32_e32 v39, 0x400000, v38
	v_bfe_u32 v40, v4, 16, 1
	v_add3_u32 v5, v5, v38, s1
	v_cmp_u_f32_e32 vcc, v38, v38
	v_or_b32_e32 v41, 0x400000, v4
	v_add3_u32 v40, v40, v4, s1
	v_cndmask_b32_e32 v5, v5, v39, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v38, v54
	v_cndmask_b32_e32 v4, v40, v41, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:64
	v_mov_b32_e32 v39, v62
	v_mov_b32_e32 v40, v58
	v_mov_b32_e32 v41, v66
	v_add_u32_e32 v37, 0x2000, v36
	v_mov_b32_e32 v62, v55
	v_mov_b32_e32 v66, v59
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_pk_mul_f32 v[4:5], v[40:41], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v42, 0x2000, v33
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v3, v2, v37, vcc
	v_cndmask_b32_e32 v37, v2, v42, vcc
	v_add_u32_e32 v42, 0x2200, v33
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v40, v40
	v_rcp_f32_e32 v41, v41
	v_mul_f32_e32 v38, v38, v40
	v_mul_f32_e32 v4, v4, v41
	v_mul_f32_e32 v38, v39, v38
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v38, 16, 1
	v_or_b32_e32 v39, 0x400000, v38
	v_bfe_u32 v40, v4, 16, 1
	v_add3_u32 v5, v5, v38, s1
	v_cmp_u_f32_e32 vcc, v38, v38
	v_or_b32_e32 v41, 0x400000, v4
	v_add3_u32 v40, v40, v4, s1
	v_cndmask_b32_e32 v5, v5, v39, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v40, v41, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:68
	v_add_u32_e32 v37, 0x2200, v36
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[62:63], v[38:39]
	v_pk_mul_f32 v[4:5], v[66:67], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v37, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v37, v2, v42, vcc
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v40, v40
	v_rcp_f32_e32 v41, v41
	v_mul_f32_e32 v38, v38, v40
	v_mul_f32_e32 v4, v4, v41
	v_mul_f32_e32 v38, v39, v38
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v38, 16, 1
	v_or_b32_e32 v39, 0x400000, v38
	v_bfe_u32 v40, v4, 16, 1
	v_add3_u32 v5, v5, v38, s1
	v_cmp_u_f32_e32 vcc, v38, v38
	v_or_b32_e32 v41, 0x400000, v4
	v_add3_u32 v40, v40, v4, s1
	v_cndmask_b32_e32 v5, v5, v39, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v38, v56
	v_cndmask_b32_e32 v4, v40, v41, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:72
	v_mov_b32_e32 v39, v64
	v_mov_b32_e32 v40, v60
	v_mov_b32_e32 v41, v68
	v_add_u32_e32 v37, 0x2400, v36
	v_mov_b32_e32 v64, v57
	v_mov_b32_e32 v68, v61
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_pk_mul_f32 v[4:5], v[40:41], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v42, 0x2400, v33
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v3, v2, v37, vcc
	v_cndmask_b32_e32 v37, v2, v42, vcc
	v_add_u32_e32 v42, 0x2600, v33
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v40, v40
	v_rcp_f32_e32 v41, v41
	v_mul_f32_e32 v38, v38, v40
	v_mul_f32_e32 v4, v4, v41
	v_mul_f32_e32 v38, v39, v38
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v38, 16, 1
	v_or_b32_e32 v39, 0x400000, v38
	v_bfe_u32 v40, v4, 16, 1
	v_add3_u32 v5, v5, v38, s1
	v_cmp_u_f32_e32 vcc, v38, v38
	v_or_b32_e32 v41, 0x400000, v4
	v_add3_u32 v40, v40, v4, s1
	v_cndmask_b32_e32 v5, v5, v39, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v40, v41, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:76
	v_add_u32_e32 v37, 0x2600, v36
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[64:65], v[38:39]
	v_pk_mul_f32 v[4:5], v[68:69], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v37, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v37, v2, v42, vcc
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v40, v40
	v_rcp_f32_e32 v41, v41
	v_mul_f32_e32 v38, v38, v40
	v_mul_f32_e32 v4, v4, v41
	v_mul_f32_e32 v38, v39, v38
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v38, 16, 1
	v_or_b32_e32 v39, 0x400000, v38
	v_bfe_u32 v40, v4, 16, 1
	v_add3_u32 v5, v5, v38, s1
	v_cmp_u_f32_e32 vcc, v38, v38
	v_or_b32_e32 v41, 0x400000, v4
	v_add3_u32 v40, v40, v4, s1
	v_cndmask_b32_e32 v5, v5, v39, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v38, v46
	v_cndmask_b32_e32 v4, v40, v41, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:128
	v_mov_b32_e32 v39, v50
	v_mov_b32_e32 v40, v26
	v_mov_b32_e32 v41, v22
	v_add_u32_e32 v22, 0x4000, v36
	v_add_u32_e32 v26, 0x4000, v33
	v_mov_b32_e32 v50, v47
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_pk_mul_f32 v[4:5], v[40:41], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v22, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v22, v2, v26, vcc
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v37, v40
	v_rcp_f32_e32 v40, v41
	v_mul_f32_e32 v26, v38, v37
	v_mul_f32_e32 v4, v4, v40
	v_mul_f32_e32 v26, v39, v26
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v26, 16, 1
	v_or_b32_e32 v37, 0x400000, v26
	v_bfe_u32 v38, v4, 16, 1
	v_add3_u32 v5, v5, v26, s1
	v_cmp_u_f32_e32 vcc, v26, v26
	v_or_b32_e32 v39, 0x400000, v4
	v_add3_u32 v38, v38, v4, s1
	v_cndmask_b32_e32 v5, v5, v37, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_add_u32_e32 v37, 0x4200, v36
	v_cndmask_b32_e32 v4, v38, v39, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v22, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:132
	v_mov_b32_e32 v22, v27
	v_add_u32_e32 v38, 0x4200, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[26:27], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[50:51], v[26:27]
	v_pk_mul_f32 v[4:5], v[22:23], v[4:5]
	v_mov_b32_e32 v22, v26
	v_mov_b32_e32 v23, v4
	v_pk_mul_f32 v[22:23], v[22:23], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v37, vcc
	v_exp_f32_e32 v22, v22
	v_exp_f32_e32 v23, v23
	v_cndmask_b32_e32 v37, v2, v38, vcc
	v_pk_add_f32 v[22:23], v[22:23], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v22, v22
	v_rcp_f32_e32 v23, v23
	v_mul_f32_e32 v22, v26, v22
	v_mul_f32_e32 v4, v4, v23
	v_mul_f32_e32 v22, v27, v22
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v22, 16, 1
	v_or_b32_e32 v23, 0x400000, v22
	v_bfe_u32 v26, v4, 16, 1
	v_add3_u32 v5, v5, v22, s1
	v_cmp_u_f32_e32 vcc, v22, v22
	v_or_b32_e32 v27, 0x400000, v4
	v_add3_u32 v26, v26, v4, s1
	v_cndmask_b32_e32 v5, v5, v23, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v22, v48
	v_cndmask_b32_e32 v4, v26, v27, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v37, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:136
	v_mov_b32_e32 v23, v52
	v_mov_b32_e32 v26, v28
	v_mov_b32_e32 v27, v24
	v_add_u32_e32 v24, 0x4400, v36
	v_add_u32_e32 v28, 0x4400, v33
	v_mov_b32_e32 v52, v49
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[22:23], v[22:23], v[38:39]
	v_pk_mul_f32 v[4:5], v[26:27], v[4:5]
	v_mov_b32_e32 v26, v22
	v_mov_b32_e32 v27, v4
	v_pk_mul_f32 v[26:27], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v24, vcc
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v24, v2, v28, vcc
	v_pk_add_f32 v[26:27], v[26:27], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v26, v26
	v_rcp_f32_e32 v27, v27
	v_mul_f32_e32 v22, v22, v26
	v_mul_f32_e32 v4, v4, v27
	v_mul_f32_e32 v22, v23, v22
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v22, 16, 1
	v_or_b32_e32 v23, 0x400000, v22
	v_bfe_u32 v26, v4, 16, 1
	v_add3_u32 v5, v5, v22, s1
	v_cmp_u_f32_e32 vcc, v22, v22
	v_or_b32_e32 v27, 0x400000, v4
	v_add3_u32 v26, v26, v4, s1
	v_cndmask_b32_e32 v5, v5, v23, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v26, v27, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v24, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:140
	v_mov_b32_e32 v24, v29
	v_add_u32_e32 v26, 0x4600, v36
	v_add_u32_e32 v27, 0x4600, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[22:23], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[22:23], v[52:53], v[22:23]
	v_pk_mul_f32 v[4:5], v[24:25], v[4:5]
	v_mov_b32_e32 v24, v22
	v_mov_b32_e32 v25, v4
	v_pk_mul_f32 v[24:25], v[24:25], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v26, vcc
	v_exp_f32_e32 v24, v24
	v_exp_f32_e32 v25, v25
	v_cndmask_b32_e32 v26, v2, v27, vcc
	v_pk_add_f32 v[24:25], v[24:25], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v24, v24
	v_rcp_f32_e32 v25, v25
	v_mul_f32_e32 v22, v22, v24
	v_mul_f32_e32 v4, v4, v25
	v_mul_f32_e32 v22, v23, v22
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v22, 16, 1
	v_or_b32_e32 v23, 0x400000, v22
	v_bfe_u32 v24, v4, 16, 1
	v_add3_u32 v5, v5, v22, s1
	v_cmp_u_f32_e32 vcc, v22, v22
	v_or_b32_e32 v25, 0x400000, v4
	v_add3_u32 v24, v24, v4, s1
	v_cndmask_b32_e32 v5, v5, v23, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v22, v14
	v_cndmask_b32_e32 v4, v24, v25, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v26, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:192
	v_mov_b32_e32 v23, v18
	v_mov_b32_e32 v24, v6
	v_mov_b32_e32 v25, v10
	v_add_u32_e32 v6, 0x6000, v36
	v_add_u32_e32 v10, 0x6000, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[26:27], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[22:23], v[22:23], v[26:27]
	v_pk_mul_f32 v[4:5], v[24:25], v[4:5]
	v_mov_b32_e32 v24, v22
	v_mov_b32_e32 v25, v4
	v_pk_mul_f32 v[24:25], v[24:25], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v6, vcc
	v_exp_f32_e32 v24, v24
	v_exp_f32_e32 v25, v25
	v_cndmask_b32_e32 v6, v2, v10, vcc
	v_pk_add_f32 v[24:25], v[24:25], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v14, v24
	v_rcp_f32_e32 v18, v25
	v_mul_f32_e32 v10, v22, v14
	v_mul_f32_e32 v4, v4, v18
	v_mul_f32_e32 v10, v23, v10
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v10, 16, 1
	v_or_b32_e32 v14, 0x400000, v10
	v_bfe_u32 v18, v4, 16, 1
	v_add3_u32 v5, v5, v10, s1
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v22, 0x400000, v4
	v_add3_u32 v18, v18, v4, s1
	v_cndmask_b32_e32 v5, v5, v14, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v10, v7
	v_cndmask_b32_e32 v4, v18, v22, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v6, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:196
	v_mov_b32_e32 v18, v15
	v_add_u32_e32 v14, 0x6200, v36
	v_add_u32_e32 v15, 0x6200, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[18:19], v[6:7]
	v_pk_mul_f32 v[4:5], v[10:11], v[4:5]
	v_mov_b32_e32 v10, v6
	v_mov_b32_e32 v11, v4
	v_pk_mul_f32 v[10:11], v[10:11], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v14, vcc
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_cndmask_b32_e32 v14, v2, v15, vcc
	v_pk_add_f32 v[10:11], v[10:11], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mul_f32_e32 v6, v6, v10
	v_mul_f32_e32 v4, v4, v11
	v_mul_f32_e32 v6, v7, v6
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v6, 16, 1
	v_or_b32_e32 v7, 0x400000, v6
	v_bfe_u32 v10, v4, 16, 1
	v_add3_u32 v5, v5, v6, s1
	v_cmp_u_f32_e32 vcc, v6, v6
	v_or_b32_e32 v11, 0x400000, v4
	v_add3_u32 v10, v10, v4, s1
	v_cndmask_b32_e32 v5, v5, v7, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v6, v16
	v_cndmask_b32_e32 v4, v10, v11, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v14, s[20:23], 0 offen
	global_load_dword v3, v[34:35], off offset:200
	v_mov_b32_e32 v7, v20
	v_mov_b32_e32 v10, v8
	v_mov_b32_e32 v11, v12
	v_add_u32_e32 v8, 0x6400, v36
	v_add_u32_e32 v12, 0x6400, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[14:15]
	v_pk_mul_f32 v[4:5], v[10:11], v[4:5]
	v_mov_b32_e32 v10, v6
	v_mov_b32_e32 v11, v4
	v_pk_mul_f32 v[10:11], v[10:11], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v8, vcc
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_cndmask_b32_e32 v2, v2, v12, vcc
	v_pk_add_f32 v[10:11], v[10:11], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mul_f32_e32 v6, v6, v10
	v_mul_f32_e32 v4, v4, v11
	v_mul_f32_e32 v6, v7, v6
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v6, 16, 1
	v_or_b32_e32 v7, 0x400000, v6
	v_bfe_u32 v8, v4, 16, 1
	v_add3_u32 v5, v5, v6, s1
	v_cmp_u_f32_e32 vcc, v6, v6
	v_or_b32_e32 v10, 0x400000, v4
	v_add3_u32 v8, v8, v4, s1
	v_cndmask_b32_e32 v5, v5, v7, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v8, v10, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v2, s[20:23], 0 offen
	global_load_dword v2, v[34:35], off offset:204
	v_or_b32_e32 v3, 51, v32
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v4, 0xffffff, v2
	v_cmp_gt_u32_e64 s[0:1], s33, v4
.LBB0_9:
	v_lshlrev_b32_e32 v2, 2, v4
	s_mov_b32 s12, s6
	s_mov_b32 s15, s27
	buffer_load_dword v2, v2, s[12:15], 0 offen
	v_mov_b32_e32 v20, v17
	v_lshlrev_b32_e32 v6, 8, v3
	v_mov_b32_e32 v12, v9
	s_mov_b32 s2, 0xbfb8aa3b
	s_movk_i32 s3, 0x7fff
	v_bfrev_b32_e32 v7, -2
	v_add_lshl_u32 v8, v129, v6, 1
	s_mov_b32 s23, s27
	v_add_lshl_u32 v6, v130, v6, 1
	v_cndmask_b32_e64 v8, v7, v8, s[0:1]
	v_cndmask_b32_e64 v6, v7, v6, s[0:1]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[0:1], v[0:1], v[2:3] op_sel_hi:[1,0]
	v_pk_mul_f32 v[2:3], v[30:31], v[2:3] op_sel_hi:[1,0]
	v_pk_mul_f32 v[0:1], v[20:21], v[0:1]
	v_pk_mul_f32 v[2:3], v[12:13], v[2:3]
	v_mov_b32_e32 v4, v0
	v_mov_b32_e32 v5, v2
	v_pk_mul_f32 v[4:5], v[4:5], s[2:3] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v4, v4
	v_exp_f32_e32 v5, v5
	s_nop 0
	v_pk_add_f32 v[4:5], v[4:5], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v4, v4
	v_rcp_f32_e32 v5, v5
	v_mul_f32_e32 v0, v0, v4
	v_mul_f32_e32 v2, v2, v5
	v_mul_f32_e32 v0, v1, v0
	v_mul_f32_e32 v1, v3, v2
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
	buffer_store_short v0, v8, s[20:23], 0 offen
	buffer_store_short v1, v6, s[20:23], 0 offen
.LBB0_10:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss, .Lfunc_end0-a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss
		.amdhsa_group_segment_fixed_size 16384
		.amdhsa_private_segment_fixed_size 48
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
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 168
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 168
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

	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.num_vgpr, 168
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.num_agpr, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.numbered_sgpr, 41
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.num_named_barrier, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.private_seg_size, 48
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.uses_vcc, 1
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.uses_flat_scratch, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.has_dyn_sized_stack, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.has_recursion, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.has_indirect_call, 0
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
    .name:           a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss
    .private_segment_fixed_size: 48
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     47
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_w3_ftz_dynm_ss.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     168
    .vgpr_spill_count: 11
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
