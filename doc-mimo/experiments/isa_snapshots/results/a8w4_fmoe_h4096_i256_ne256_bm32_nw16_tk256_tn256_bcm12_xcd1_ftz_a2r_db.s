	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db:
	s_load_dwordx8 s[16:23], s[0:1], 0x40
	v_readfirstlane_b32 s3, v0
	s_mov_b32 s35, 0
	s_waitcnt lgkmcnt(0)
	s_load_dword s6, s[18:19], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s6, 31
	s_lshr_b32 s4, s4, 27
	s_add_i32 s4, s6, s4
	s_ashr_i32 s8, s4, 5
	s_andn2_b32 s4, s4, 31
	s_cmp_lg_u32 s6, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s6, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s4, s8, 0
	s_cmp_ge_i32 s2, s4
	s_cbranch_scc1 .LBB0_9
	s_lshr_b32 s48, s3, 6
	s_and_b32 s3, s4, 7
	s_and_b32 s5, s2, 7
	s_lshr_b32 s4, s4, 3
	s_min_u32 s3, s5, s3
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s4, s4, s5
	s_add_i32 s2, s3, s2
	s_add_i32 s4, s2, s4
	s_ashr_i32 s5, s4, 31
	s_lshl_b64 s[2:3], s[4:5], 2
	s_add_u32 s2, s16, s2
	s_addc_u32 s3, s17, s3
	s_lshl_b32 s34, s4, 5
	v_lshrrev_b32_e32 v18, 5, v0
	v_or_b32_e32 v58, s34, v18
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[2:3], v[58:59], 2, s[20:21]
	global_load_dword v6, v[2:3], off
	s_load_dword s49, s[2:3], 0x0
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dword s33, s[0:1], 0x68
	s_lshl_b32 s50, s48, 4
	v_and_b32_e32 v1, 15, v0
	v_lshlrev_b32_e32 v2, 3, v0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s49, 9
	s_and_b32 s29, s11, 0xffff
	s_add_i32 s11, s2, s50
	v_lshrrev_b32_e32 v3, 1, v0
	s_lshl_b32 s42, s33, 12
	s_and_b32 s41, s5, 0xffff
	s_and_b32 s25, s9, 0xffff
	s_ashr_i32 s5, s11, 4
	v_and_b32_e32 v19, 0xf8, v2
	v_and_b32_e32 v2, 0xf0, v3
	v_or_b32_e32 v52, s50, v1
	s_cmp_lt_i32 s11, 0
	v_and_b32_e32 v50, 48, v0
	v_xor_b32_e32 v7, v2, v19
	v_add_u32_e32 v2, s2, v52
	s_cselect_b64 s[2:3], -1, 0
	s_lshl_b32 s9, s11, 7
	s_ashr_i32 s24, s11, 31
	v_or3_b32 v64, s9, v50, v1
	s_lshr_b32 s9, s24, 27
	s_add_i32 s9, s11, s9
	v_add_u32_e32 v4, 0x100, v2
	s_ashr_i32 s24, s9, 5
	s_andn2_b32 s9, s9, 31
	v_ashrrev_i32_e32 v3, 31, v2
	v_ashrrev_i32_e32 v5, 31, v4
	s_cmp_lg_u32 s11, s9
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	s_cselect_b64 s[12:13], -1, 0
	s_and_b64 s[2:3], s[2:3], s[12:13]
	s_subb_u32 s2, s24, 0
	s_lshr_b32 s3, s11, 31
	s_lshl_b32 s2, s2, 10
	s_add_i32 s3, s5, s3
	s_add_i32 s9, s11, 0x100
	v_or3_b32 v66, s2, v50, v1
	s_and_b32 s2, s3, -2
	s_ashr_i32 s51, s9, 4
	s_sub_i32 s52, s5, s2
	s_cmp_lt_i32 s9, 0
	s_cselect_b64 s[2:3], -1, 0
	s_lshl_b32 s5, s9, 7
	s_ashr_i32 s12, s9, 31
	v_or3_b32 v67, s5, v50, v1
	s_lshr_b32 s5, s12, 27
	s_add_i32 s5, s9, s5
	s_ashr_i32 s24, s5, 5
	s_andn2_b32 s5, s5, 31
	s_cmp_lg_u32 s9, s5
	s_cselect_b64 s[12:13], -1, 0
	s_and_b64 s[2:3], s[2:3], s[12:13]
	s_subb_u32 s2, s24, 0
	s_mov_b32 s43, 0x27000
	s_brev_b32 s26, 8
	s_mov_b32 s30, 0x1000000
	s_lshl_b32 s2, s2, 10
	s_mov_b32 s38, s26
	s_mov_b32 s39, s43
	s_mov_b32 s46, s30
	s_mov_b32 s47, s43
	s_mov_b32 s36, s8
	s_mov_b32 s44, s10
	s_mov_b32 s37, s25
	s_mov_b32 s45, s29
	v_lshlrev_b32_e32 v8, 4, v64
	v_lshlrev_b32_e32 v20, 2, v66
	v_or3_b32 v73, s2, v50, v1
	global_load_dword v54, v[2:3], off
	global_load_dword v53, v[4:5], off
	buffer_load_dwordx4 v[10:13], v8, s[36:39], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v8, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v21, 4, v67
	v_lshlrev_b32_e32 v22, 2, v73
	s_mov_b32 s40, s4
	s_load_dwordx2 s[12:13], s[0:1], 0x60
	s_waitcnt vmcnt(4)
	v_lshl_or_b32 v72, v6, 12, v7
	buffer_load_dword v75, v20, s[44:47], 0 offen
	buffer_load_dword v74, v22, s[44:47], 0 offen
	buffer_load_dwordx4 v[14:17], v21, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v21, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx2 v[44:45], v72, s[40:43], 0 offen nt
	s_lshr_b32 s0, s9, 31
	v_bfe_u32 v68, v0, 4, 2
	s_add_i32 s0, s51, s0
	v_lshlrev_b32_e32 v59, 8, v18
	v_lshlrev_b32_e32 v18, 5, v68
	v_lshlrev_b32_e32 v20, 4, v1
	s_and_b32 s0, s0, -2
	v_xor_b32_e32 v70, v18, v20
	v_or_b32_e32 v21, 8, v18
	v_or_b32_e32 v22, 16, v18
	v_or_b32_e32 v23, 24, v18
	v_or_b32_e32 v24, 0x80, v18
	v_or_b32_e32 v25, 0x88, v18
	v_or_b32_e32 v42, 0x90, v18
	v_or_b32_e32 v18, 0x98, v18
	s_sub_i32 s0, s51, s0
	v_mov_b32_e32 v26, 0
	v_lshlrev_b32_e32 v69, 8, v1
	v_or_b32_e32 v19, v59, v19
	v_xor_b32_e32 v18, v18, v20
	s_mov_b32 s36, s4
	s_lshl_b32 s4, s52, 3
	s_lshl_b32 s9, s0, 3
	v_and_b32_e32 v51, 63, v0
	s_mov_b32 s2, 0x8080808
	s_mov_b32 s3, 0x5010400
	s_mov_b32 s5, 0x7030602
	s_mov_b32 s27, s43
	s_mov_b32 s31, s43
	v_mov_b32_e32 v27, v26
	v_mov_b32_e32 v28, v26
	v_mov_b32_e32 v29, v26
	v_mov_b32_e32 v30, v26
	v_mov_b32_e32 v31, v26
	v_mov_b32_e32 v32, v26
	v_mov_b32_e32 v33, v26
	v_mov_b32_e32 v34, v26
	v_mov_b32_e32 v35, v26
	v_mov_b32_e32 v36, v26
	v_mov_b32_e32 v37, v26
	v_mov_b32_e32 v38, v26
	v_mov_b32_e32 v39, v26
	v_mov_b32_e32 v40, v26
	v_mov_b32_e32 v41, v26
	v_or_b32_e32 v63, 0x1000, v69
	v_lshrrev_b32_e32 v76, 2, v19
	v_xor_b32_e32 v62, v21, v20
	v_xor_b32_e32 v61, v22, v20
	v_xor_b32_e32 v60, v23, v20
	v_xor_b32_e32 v57, v24, v20
	v_xor_b32_e32 v56, v25, v20
	v_xor_b32_e32 v55, v42, v20
	v_or_b32_e32 v65, v69, v70
	v_or_b32_e32 v71, v69, v18
	s_mov_b32 s24, s8
	s_mov_b32 s28, s10
	s_mov_b32 s38, s42
	s_mov_b32 s37, s41
	s_add_i32 s8, s4, 16
	s_add_i32 s10, s9, 16
	s_waitcnt vmcnt(0)
	ds_write_b64 v19, v[44:45]
.LBB0_2:
	s_and_b32 s40, s35, 1
	s_add_i32 s35, s35, 1
	s_waitcnt vmcnt(2)
	v_mov_b64_e32 v[24:25], v[4:5]
	v_mov_b64_e32 v[22:23], v[2:3]
	v_lshl_add_u32 v2, s35, 8, v72
	s_lshl_b32 s0, s35, 6
	s_lshl_b32 s1, s35, 7
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[20:21], v[8:9]
	v_mov_b64_e32 v[18:19], v[6:7]
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx2 v[94:95], v2, s[36:39], 0 offen nt
	v_add_lshl_u32 v2, s0, v66, 2
	v_add_lshl_u32 v3, s0, v73, 2
	v_add_lshl_u32 v4, s1, v64, 4
	v_add_lshl_u32 v6, s1, v67, 4
	v_mov_b64_e32 v[44:45], v[16:17]
	v_mov_b64_e32 v[42:43], v[14:15]
	v_mov_b64_e32 v[48:49], v[12:13]
	v_mov_b64_e32 v[46:47], v[10:11]
	v_bfe_u32 v79, v75, s4, 8
	v_bfe_u32 v77, v75, s8, 8
	v_bfe_u32 v80, v74, s9, 8
	v_bfe_u32 v78, v74, s10, 8
	buffer_load_dword v75, v2, s[28:31], 0 offen
	buffer_load_dword v74, v3, s[28:31], 0 offen
	buffer_load_dwordx4 v[10:13], v4, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v4, s[24:27], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[14:17], v6, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[6:9], v6, s[24:27], 0 offen offset:1024 sc0
	v_sub_u32_e32 v79, v54, v79
	v_sub_u32_e32 v80, v53, v80
	v_min_i32_e32 v81, 11, v79
	v_min_i32_e32 v85, 11, v80
	v_mul_lo_u32 v81, v81, s2
	v_mul_lo_u32 v85, v85, s2
	v_sub_u32_e32 v87, 0x6c686080, v81
	v_sub_u32_e32 v81, 0x7c787470, v81
	v_sub_u32_e32 v88, 0x6c686080, v85
	v_sub_u32_e32 v89, 0x7c787470, v85
	v_and_b32_e32 v85, 0xffffff00, v87
	v_cmp_lt_i32_e64 s[0:1], 11, v79
	v_cmp_lt_i32_e32 vcc, 11, v80
	v_and_b32_e32 v88, 0xffffff00, v88
	v_cndmask_b32_e64 v85, v85, 0, s[0:1]
	v_cndmask_b32_e64 v87, v81, 0, s[0:1]
	v_cndmask_b32_e64 v80, v89, 0, vcc
	v_add_u32_e32 v81, 0x7f7f7f00, v85
	v_add_u32_e32 v89, 0x7f7f7f78, v87
	v_and_b32_e32 v82, 0x7070707, v46
	v_lshrrev_b32_e32 v83, 4, v46
	v_cndmask_b32_e64 v79, v88, 0, vcc
	v_and_b32_e32 v88, 0x80808000, v81
	v_and_b32_e32 v89, 0x80808080, v89
	v_lshlrev_b32_e32 v84, 4, v46
	v_and_b32_e32 v83, 0x7070707, v83
	v_perm_b32 v92, v87, v85, v82
	v_perm_b32 v81, v89, v88, v82
	v_add_u32_e32 v90, 0x7f7f7f00, v79
	v_and_or_b32 v81, v81, v84, v92
	v_add_u32_e32 v82, 0x7f7f7f78, v80
	v_perm_b32 v84, v87, v85, v83
	v_perm_b32 v83, v89, v88, v83
	v_and_b32_e32 v86, 0x7070707, v42
	v_and_or_b32 v83, v83, v46, v84
	v_and_b32_e32 v46, 0x80808000, v90
	v_and_b32_e32 v90, 0x80808080, v82
	s_lshl_b32 s41, s40, 13
	v_lshlrev_b32_e32 v91, 4, v42
	v_perm_b32 v84, v80, v79, v86
	v_perm_b32 v82, v90, v46, v86
	v_and_or_b32 v84, v82, v91, v84
	v_perm_b32 v82, v83, v81, s3
	v_perm_b32 v83, v83, v81, s5
	v_or_b32_e32 v81, s41, v65
	ds_read2st64_b64 v[96:99], v81 offset1:8
	v_lshrrev_b32_e32 v81, 4, v42
	v_and_b32_e32 v81, 0x7070707, v81
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[96:97], v[82:83], v[26:29]
	v_and_b32_e32 v91, 0x7070707, v47
	v_and_b32_e32 v92, 0x7070707, v48
	v_and_b32_e32 v93, 0x7070707, v49
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[98:99], v[82:83], v[30:33]
	v_perm_b32 v82, v80, v79, v81
	v_perm_b32 v81, v90, v46, v81
	v_and_or_b32 v42, v81, v42, v82
	v_perm_b32 v82, v42, v84, s3
	v_perm_b32 v83, v42, v84, s5
	v_lshrrev_b32_e32 v42, 4, v47
	v_lshrrev_b32_e32 v81, 4, v48
	v_and_b32_e32 v42, 0x7070707, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[96:97], v[82:83], v[34:37]
	v_and_b32_e32 v81, 0x7070707, v81
	v_and_b32_e32 v97, 0x7070707, v44
	v_perm_b32 v100, v87, v85, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[98:99], v[82:83], v[38:41]
	v_lshrrev_b32_e32 v82, 4, v49
	v_perm_b32 v83, v87, v85, v42
	v_perm_b32 v42, v89, v88, v42
	v_and_b32_e32 v82, 0x7070707, v82
	v_and_or_b32 v86, v42, v47, v83
	v_perm_b32 v42, v87, v85, v81
	v_perm_b32 v81, v89, v88, v81
	v_and_or_b32 v81, v81, v48, v42
	v_perm_b32 v42, v87, v85, v82
	v_perm_b32 v82, v89, v88, v82
	v_and_or_b32 v42, v82, v49, v42
	v_lshrrev_b32_e32 v82, 4, v43
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v83, v80, v79, v82
	v_perm_b32 v82, v90, v46, v82
	v_and_or_b32 v83, v82, v43, v83
	v_lshrrev_b32_e32 v82, 4, v44
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v84, v80, v79, v82
	v_perm_b32 v82, v90, v46, v82
	v_and_or_b32 v84, v82, v44, v84
	v_lshrrev_b32_e32 v82, 4, v45
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v96, v80, v79, v82
	v_perm_b32 v82, v90, v46, v82
	v_and_or_b32 v82, v82, v45, v96
	v_and_b32_e32 v96, 0x7070707, v43
	v_lshlrev_b32_e32 v98, 4, v44
	v_and_b32_e32 v44, 0x7070707, v45
	v_lshlrev_b32_e32 v43, 4, v43
	v_perm_b32 v99, v87, v85, v91
	v_perm_b32 v85, v87, v85, v93
	v_perm_b32 v87, v89, v88, v91
	v_perm_b32 v91, v89, v88, v92
	v_perm_b32 v92, v89, v88, v93
	v_perm_b32 v89, v80, v79, v96
	v_perm_b32 v93, v80, v79, v97
	v_perm_b32 v101, v80, v79, v44
	v_perm_b32 v79, v90, v46, v96
	v_lshlrev_b32_e32 v47, 4, v47
	v_perm_b32 v80, v90, v46, v97
	v_perm_b32 v46, v90, v46, v44
	v_and_or_b32 v44, v79, v43, v89
	v_sub_u32_e32 v43, v54, v77
	v_and_or_b32 v88, v87, v47, v99
	v_sub_u32_e32 v47, v53, v78
	v_min_i32_e32 v77, 11, v43
	v_min_i32_e32 v78, 11, v47
	v_mul_lo_u32 v77, v77, s2
	v_mul_lo_u32 v78, v78, s2
	v_sub_u32_e32 v79, 0x6c686080, v77
	v_and_b32_e32 v79, 0xffffff00, v79
	v_cmp_lt_i32_e32 vcc, 11, v43
	v_sub_u32_e32 v43, 0x6c686080, v78
	v_cmp_lt_i32_e64 s[0:1], 11, v47
	v_sub_u32_e32 v47, 0x7c787470, v77
	v_and_b32_e32 v43, 0xffffff00, v43
	v_cndmask_b32_e64 v77, v79, 0, vcc
	v_cndmask_b32_e64 v79, v47, 0, vcc
	v_lshlrev_b32_e32 v48, 4, v48
	v_lshlrev_b32_e32 v49, 4, v49
	v_lshlrev_b32_e32 v45, 4, v45
	v_and_or_b32 v89, v80, v98, v93
	v_sub_u32_e32 v80, 0x7c787470, v78
	v_cndmask_b32_e64 v78, v43, 0, s[0:1]
	v_add_u32_e32 v43, 0x7f7f7f00, v77
	v_add_u32_e32 v47, 0x7f7f7f78, v79
	v_and_b32_e32 v90, 0x7070707, v22
	v_and_or_b32 v87, v91, v48, v100
	v_and_or_b32 v91, v92, v49, v85
	v_and_or_b32 v92, v46, v45, v101
	v_and_b32_e32 v46, 0x80808000, v43
	v_and_b32_e32 v47, 0x80808080, v47
	v_lshlrev_b32_e32 v48, 4, v22
	v_cndmask_b32_e64 v80, v80, 0, s[0:1]
	v_perm_b32 v49, v79, v77, v90
	v_perm_b32 v43, v47, v46, v90
	v_add_u32_e32 v45, 0x7f7f7f00, v78
	v_and_or_b32 v43, v43, v48, v49
	v_add_u32_e32 v49, 0x7f7f7f78, v80
	v_and_b32_e32 v93, 0x7070707, v18
	v_and_b32_e32 v48, 0x80808000, v45
	v_and_b32_e32 v49, 0x80808080, v49
	v_perm_b32 v85, v80, v78, v93
	v_perm_b32 v45, v49, v48, v93
	v_lshlrev_b32_e32 v90, 4, v18
	v_and_or_b32 v93, v45, v90, v85
	v_and_b32_e32 v45, 0x7070707, v23
	v_perm_b32 v85, v79, v77, v45
	v_perm_b32 v45, v47, v46, v45
	v_lshlrev_b32_e32 v90, 4, v23
	v_and_or_b32 v45, v45, v90, v85
	v_and_b32_e32 v85, 0x7070707, v19
	v_perm_b32 v90, v80, v78, v85
	v_perm_b32 v85, v49, v48, v85
	v_lshlrev_b32_e32 v96, 4, v19
	v_and_or_b32 v90, v85, v96, v90
	v_and_b32_e32 v85, 0x7070707, v24
	v_perm_b32 v96, v79, v77, v85
	v_perm_b32 v85, v47, v46, v85
	v_lshlrev_b32_e32 v97, 4, v24
	v_and_or_b32 v85, v85, v97, v96
	v_perm_b32 v96, v86, v88, s3
	v_perm_b32 v97, v86, v88, s5
	v_or_b32_e32 v86, s41, v62
	v_or_b32_e32 v88, v86, v69
	v_or_b32_e32 v86, v86, v63
	ds_read_b64 v[98:99], v88
	ds_read_b64 v[100:101], v86
	v_or_b32_e32 v86, s41, v61
	v_or_b32_e32 v88, v86, v69
	ds_read_b64 v[102:103], v88
	v_or_b32_e32 v86, v86, v63
	ds_read_b64 v[106:107], v86
	v_and_b32_e32 v86, 0x7070707, v20
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[96:97], v[26:29]
	v_perm_b32 v88, v80, v78, v86
	v_perm_b32 v86, v49, v48, v86
	v_perm_b32 v104, v84, v89, s3
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[100:101], v[96:97], v[30:33]
	v_lshlrev_b32_e32 v96, 4, v20
	v_and_or_b32 v88, v86, v96, v88
	v_perm_b32 v96, v83, v44, s3
	v_perm_b32 v97, v83, v44, s5
	v_perm_b32 v86, v81, v87, s3
	v_perm_b32 v87, v81, v87, s5
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[98:99], v[96:97], v[34:37]
	v_perm_b32 v105, v84, v89, s5
	v_lshrrev_b32_e32 v44, 4, v22
	v_lshrrev_b32_e32 v83, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[100:101], v[96:97], v[38:41]
	v_lshrrev_b32_e32 v89, 4, v25
	v_lshlrev_b32_e32 v84, 4, v21
	s_cmp_lg_u32 s35, 15
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[102:103], v[86:87], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[102:103], v[104:105], v[34:37]
	s_nop 1
	v_perm_b32 v26, v82, v92, s3
	v_perm_b32 v27, v82, v92, s5
	v_lshrrev_b32_e32 v82, 4, v23
	v_or_b32_e32 v34, s41, v60
	v_or_b32_e32 v35, v34, v69
	v_or_b32_e32 v34, v34, v63
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[106:107], v[86:87], v[30:33]
	v_lshrrev_b32_e32 v36, 4, v18
	v_or_b32_e32 v37, s41, v57
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[106:107], v[104:105], v[38:41]
	ds_read_b64 v[104:105], v35
	ds_read_b64 v[106:107], v34
	v_perm_b32 v32, v42, v91, s3
	v_perm_b32 v33, v42, v91, s5
	v_or_b32_e32 v34, v37, v69
	v_and_b32_e32 v42, 0x7070707, v44
	v_and_b32_e32 v44, 0x7070707, v36
	v_or_b32_e32 v36, v37, v63
	ds_read_b64 v[34:35], v34
	ds_read_b64 v[36:37], v36
	v_perm_b32 v81, v79, v77, v42
	v_perm_b32 v42, v47, v46, v42
	v_and_or_b32 v22, v42, v22, v81
	v_perm_b32 v42, v80, v78, v44
	v_perm_b32 v44, v49, v48, v44
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[104:105], v[32:33], v[96:99]
	v_and_or_b32 v18, v44, v18, v42
	v_perm_b32 v86, v22, v43, s3
	v_perm_b32 v87, v22, v43, s5
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[106:107], v[32:33], v[28:31]
	v_perm_b32 v92, v18, v93, s3
	v_perm_b32 v93, v18, v93, s5
	v_and_b32_e32 v18, 0x7070707, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[104:105], v[26:27], v[100:103]
	v_lshrrev_b32_e32 v44, 4, v24
	v_lshrrev_b32_e32 v22, 4, v20
	v_and_b32_e32 v22, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[106:107], v[26:27], v[38:41]
	v_perm_b32 v26, v79, v77, v18
	v_perm_b32 v18, v47, v46, v18
	v_and_or_b32 v23, v18, v23, v26
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[34:35], v[86:87], v[96:99]
	v_and_b32_e32 v38, 0x7070707, v83
	v_perm_b32 v18, v80, v78, v38
	v_perm_b32 v38, v49, v48, v38
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[36:37], v[86:87], v[30:33]
	v_and_or_b32 v39, v38, v19, v18
	v_perm_b32 v18, v23, v45, s3
	v_perm_b32 v19, v23, v45, s5
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[34:35], v[92:93], v[100:103]
	v_lshrrev_b32_e32 v23, 4, v21
	v_and_b32_e32 v86, 0x7070707, v23
	v_perm_b32 v38, v39, v90, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[92:93], v[40:43]
	v_perm_b32 v39, v39, v90, s5
	v_and_b32_e32 v81, 0x7070707, v25
	v_and_b32_e32 v87, 0x7070707, v89
	v_or_b32_e32 v40, s41, v56
	v_or_b32_e32 v41, v40, v69
	ds_read_b64 v[100:101], v41
	v_or_b32_e32 v40, v40, v63
	ds_read_b64 v[102:103], v40
	v_or_b32_e32 v41, s41, v55
	v_or_b32_e32 v23, v41, v63
	ds_read_b64 v[92:93], v23
	v_or_b32_e32 v40, v41, v69
	ds_read_b64 v[90:91], v40
	v_and_b32_e32 v40, 0x7070707, v44
	v_perm_b32 v23, v79, v77, v40
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[100:101], v[18:19], v[26:29]
	v_lshlrev_b32_e32 v82, 4, v25
	v_and_b32_e32 v83, 0x7070707, v21
	s_nop 0
	v_perm_b32 v26, v47, v46, v40
	v_and_or_b32 v23, v26, v24, v23
	v_perm_b32 v24, v80, v78, v22
	v_perm_b32 v22, v49, v48, v22
	v_and_or_b32 v20, v22, v20, v24
	v_or_b32_e32 v24, s41, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[100:101], v[38:39], v[96:99]
	v_perm_b32 v22, v23, v85, s3
	v_perm_b32 v23, v23, v85, s5
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[102:103], v[38:39], v[34:37]
	ds_read2st64_b64 v[38:41], v24 offset1:8
	v_perm_b32 v24, v79, v77, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[102:103], v[18:19], v[30:33]
	v_perm_b32 v18, v20, v88, s3
	v_perm_b32 v19, v20, v88, s5
	v_perm_b32 v20, v79, v77, v81
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[90:91], v[22:23], v[42:45]
	v_perm_b32 v77, v80, v78, v83
	v_perm_b32 v78, v80, v78, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[90:91], v[18:19], v[26:29]
	s_nop 2
	v_perm_b32 v26, v47, v46, v81
	v_perm_b32 v27, v47, v46, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[92:93], v[22:23], v[30:33]
	v_and_or_b32 v20, v26, v82, v20
	v_and_or_b32 v26, v27, v25, v24
	v_perm_b32 v28, v49, v48, v83
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[92:93], v[18:19], v[34:37]
	v_perm_b32 v46, v49, v48, v86
	v_and_or_b32 v21, v46, v21, v78
	v_perm_b32 v18, v26, v20, s3
	v_and_or_b32 v34, v28, v84, v77
	v_perm_b32 v19, v26, v20, s5
	v_perm_b32 v20, v21, v34, s3
	v_perm_b32 v21, v21, v34, s5
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[38:39], v[18:19], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[38:39], v[20:21], v[88:91]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[40:41], v[18:19], v[30:33]
	v_lshl_or_b32 v18, s40, 11, v76
	v_xor_b32_e32 v18, 0x800, v18
	v_lshlrev_b32_e32 v18, 2, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[40:41], v[20:21], v[22:25]
	s_waitcnt vmcnt(6)
	ds_write_b64 v18, v[94:95]
	s_cbranch_scc1 .LBB0_2
	s_waitcnt vmcnt(5)
	v_bfe_u32 v18, v75, s4, 8
	v_sub_u32_e32 v18, v54, v18
	v_min_i32_e32 v20, 11, v18
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v20, v20, s40
	v_sub_u32_e32 v21, 0x6c686080, v20
	v_and_b32_e32 v21, 0xffffff00, v21
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v20, 0x7c787470, v20
	s_waitcnt vmcnt(4)
	v_bfe_u32 v19, v74, s9, 8
	v_cndmask_b32_e64 v64, v21, 0, vcc
	v_cndmask_b32_e64 v66, v20, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v64
	v_and_b32_e32 v67, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v66
	v_and_b32_e32 v72, 0x80808080, v18
	v_sub_u32_e32 v18, v53, v19
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s40
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_bfe_u32 v47, v74, s10, 8
	v_cndmask_b32_e64 v73, v20, 0, vcc
	v_cndmask_b32_e64 v74, v19, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v73
	v_bfe_u32 v46, v75, s8, 8
	v_and_b32_e32 v75, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v74
	v_and_b32_e32 v76, 0x80808080, v18
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v18, 0x7070707, v10
	v_lshrrev_b32_e32 v19, 4, v10
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v72, v67, v18
	v_lshlrev_b32_e32 v21, 4, v10
	v_perm_b32 v18, v66, v64, v18
	v_and_or_b32 v18, v20, v21, v18
	v_perm_b32 v20, v72, v67, v19
	v_perm_b32 v19, v66, v64, v19
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_and_or_b32 v10, v20, v10, v19
	s_mov_b32 s41, 0x5010400
	s_mov_b32 s42, 0x7030602
	ds_read_b64 v[24:25], v65 offset:8192
	v_perm_b32 v42, v10, v18, s41
	v_perm_b32 v43, v10, v18, s42
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v18, 4, v14
	v_and_b32_e32 v18, 0x7070707, v18
	v_perm_b32 v22, v76, v75, v18
	v_perm_b32 v23, v74, v73, v18
	v_or_b32_e32 v18, v70, v63
	ds_read_b64 v[48:49], v18 offset:8192
	v_and_b32_e32 v10, 0x7070707, v14
	v_perm_b32 v19, v76, v75, v10
	v_lshlrev_b32_e32 v20, 4, v14
	v_perm_b32 v10, v74, v73, v10
	v_and_or_b32 v10, v19, v20, v10
	v_and_or_b32 v14, v22, v14, v23
	v_perm_b32 v44, v14, v10, s41
	v_perm_b32 v45, v14, v10, s42
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[24:25], v[42:43], v[26:29]
	s_ashr_i32 s35, s34, 31
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[44:45], v[34:37]
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s6
	s_mov_b32 s4, 0x43700000
	v_sub_u32_e32 v34, v54, v46
	v_min_i32_e32 v10, 11, v34
	v_mul_lo_u32 v10, v10, s40
	v_sub_u32_e32 v14, 0x6c686080, v10
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[48:49], v[42:43], v[30:33]
	v_lshlrev_b32_e32 v36, 4, v15
	v_cmp_lt_i32_e32 vcc, 11, v34
	s_and_b32 s9, s17, 0xffff
	v_and_b32_e32 v30, 0xffffff00, v14
	v_sub_u32_e32 v31, 0x7c787470, v10
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v14, 4, v11
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v32, v72, v67, v10
	v_lshlrev_b32_e32 v33, 4, v11
	v_perm_b32 v10, v66, v64, v10
	v_and_or_b32 v32, v32, v33, v10
	v_perm_b32 v10, v72, v67, v14
	v_perm_b32 v14, v66, v64, v14
	v_and_or_b32 v11, v10, v11, v14
	v_perm_b32 v10, v11, v32, s41
	v_perm_b32 v11, v11, v32, s42
	v_add_u32_e32 v32, v69, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[48:49], v[44:45], v[38:41]
	ds_read2st64_b64 v[42:45], v32 offset0:16 offset1:24
	v_and_b32_e32 v14, 0x7070707, v15
	v_lshrrev_b32_e32 v33, 4, v15
	v_and_b32_e32 v33, 0x7070707, v33
	v_perm_b32 v35, v76, v75, v14
	v_perm_b32 v14, v74, v73, v14
	v_and_or_b32 v35, v35, v36, v14
	v_perm_b32 v14, v76, v75, v33
	v_perm_b32 v33, v74, v73, v33
	v_and_or_b32 v15, v14, v15, v33
	v_perm_b32 v14, v15, v35, s41
	v_perm_b32 v15, v15, v35, s42
	v_cndmask_b32_e64 v35, v31, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[10:11], v[18:21]
	v_add_u32_e32 v33, v69, v61
	v_cndmask_b32_e64 v34, v30, 0, vcc
	v_add_u32_e32 v30, 0x7f7f7f00, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[44:45], v[10:11], v[26:29]
	v_add_u32_e32 v10, 0x7f7f7f78, v35
	v_and_b32_e32 v37, 0x80808080, v10
	v_and_b32_e32 v10, 0x7070707, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[14:15], v[22:25]
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_and_b32_e32 v36, 0x80808000, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[44:45], v[14:15], v[38:41]
	ds_read2st64_b64 v[42:45], v33 offset0:16 offset1:24
	v_perm_b32 v14, v72, v67, v10
	v_lshlrev_b32_e32 v15, 4, v12
	v_perm_b32 v10, v66, v64, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v72, v67, v11
	v_perm_b32 v11, v66, v64, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v12, 0x7070707, v16
	v_lshrrev_b32_e32 v14, 4, v16
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v15, v76, v75, v12
	v_lshlrev_b32_e32 v30, 4, v16
	v_perm_b32 v12, v74, v73, v12
	v_and_or_b32 v12, v15, v30, v12
	v_perm_b32 v15, v76, v75, v14
	v_perm_b32 v14, v74, v73, v14
	v_and_or_b32 v15, v15, v16, v14
	v_perm_b32 v14, v15, v12, s41
	v_perm_b32 v15, v15, v12, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[10:11], v[18:21]
	s_and_b32 s25, s23, 0xffff
	s_and_b32 s5, s19, 0xffff
	s_mov_b32 s26, -1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[14:15], v[22:25]
	v_sub_u32_e32 v42, v53, v47
	v_min_i32_e32 v12, 11, v42
	v_mul_lo_u32 v12, v12, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[44:45], v[10:11], v[26:29]
	v_sub_u32_e32 v10, 0x6c686080, v12
	v_and_b32_e32 v43, 0xffffff00, v10
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_sub_u32_e32 v61, 0x7c787470, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[44:45], v[14:15], v[38:41]
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v72, v67, v10
	v_lshlrev_b32_e32 v14, 4, v13
	v_perm_b32 v10, v66, v64, v10
	v_and_or_b32 v10, v12, v14, v10
	v_perm_b32 v12, v72, v67, v11
	v_perm_b32 v11, v66, v64, v11
	v_and_or_b32 v11, v12, v13, v11
	v_add_u32_e32 v38, v69, v60
	v_perm_b32 v30, v11, v10, s41
	v_perm_b32 v31, v11, v10, s42
	ds_read2st64_b64 v[10:13], v38 offset0:16 offset1:24
	v_and_b32_e32 v14, 0x7070707, v17
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v76, v75, v14
	v_lshlrev_b32_e32 v39, 4, v17
	v_perm_b32 v14, v74, v73, v14
	v_and_or_b32 v14, v16, v39, v14
	v_perm_b32 v16, v76, v75, v15
	v_perm_b32 v15, v74, v73, v15
	v_and_or_b32 v15, v16, v17, v15
	v_perm_b32 v40, v15, v14, s41
	v_perm_b32 v41, v15, v14, s42
	v_add_u32_e32 v39, v69, v57
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[30:31], v[18:21]
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_mov_b32_e32 v73, 0xfd800000
	v_lshl_add_u32 v74, v68, 10, v52
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[10:11], v[40:41], v[22:25]
	v_cndmask_b32_e64 v42, v43, 0, vcc
	v_cndmask_b32_e64 v43, v61, 0, vcc
	v_add_u32_e32 v10, 0x7f7f7f00, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[12:13], v[30:31], v[26:29]
	v_and_b32_e32 v44, 0x80808000, v10
	v_add_u32_e32 v10, 0x7f7f7f78, v43
	v_and_b32_e32 v45, 0x80808080, v10
	v_and_b32_e32 v26, 0x7070707, v2
	v_lshrrev_b32_e32 v27, 4, v2
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v37, v36, v26
	v_lshlrev_b32_e32 v29, 4, v2
	v_perm_b32 v26, v35, v34, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v37, v36, v27
	v_perm_b32 v27, v35, v34, v27
	v_and_or_b32 v2, v28, v2, v27
	v_perm_b32 v30, v2, v26, s41
	v_perm_b32 v31, v2, v26, s42
	ds_read2st64_b64 v[26:29], v39 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[12:13], v[40:41], v[46:49]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v2, 0x7070707, v6
	v_lshrrev_b32_e32 v40, 4, v6
	v_and_b32_e32 v40, 0x7070707, v40
	v_perm_b32 v41, v45, v44, v2
	v_lshlrev_b32_e32 v46, 4, v6
	v_perm_b32 v2, v43, v42, v2
	v_and_or_b32 v2, v41, v46, v2
	v_perm_b32 v41, v45, v44, v40
	v_perm_b32 v40, v43, v42, v40
	v_and_or_b32 v6, v41, v6, v40
	v_perm_b32 v40, v6, v2, s41
	v_perm_b32 v41, v6, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v6, 4, v3
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[26:27], v[30:31], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v6
	v_cmp_lt_i32_e32 vcc, 5, v54
	v_lshlrev_b32_e32 v72, 1, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[26:27], v[40:41], v[14:17]
	v_perm_b32 v26, v37, v36, v2
	v_lshlrev_b32_e32 v27, 4, v3
	v_perm_b32 v2, v35, v34, v2
	v_and_or_b32 v26, v26, v27, v2
	v_perm_b32 v2, v37, v36, v6
	v_perm_b32 v6, v35, v34, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[28:29], v[40:41], v[10:13]
	v_and_or_b32 v3, v2, v3, v6
	v_add_u32_e32 v40, v69, v56
	v_perm_b32 v2, v3, v26, s41
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[28:29], v[30:31], v[22:25]
	v_perm_b32 v3, v3, v26, s42
	ds_read2st64_b64 v[26:29], v40 offset0:16 offset1:24
	v_and_b32_e32 v6, 0x7070707, v7
	v_lshrrev_b32_e32 v30, 4, v7
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v45, v44, v6
	v_lshlrev_b32_e32 v41, 4, v7
	v_perm_b32 v6, v43, v42, v6
	v_and_or_b32 v31, v31, v41, v6
	v_perm_b32 v6, v45, v44, v30
	v_perm_b32 v30, v43, v42, v30
	v_and_or_b32 v7, v6, v7, v30
	v_perm_b32 v6, v7, v31, s41
	v_perm_b32 v7, v7, v31, s42
	v_add_u32_e32 v41, v69, v55
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[26:27], v[2:3], v[18:21]
	v_lshlrev_b32_e32 v30, 2, v68
	v_mov_b32_e32 v31, 0
	s_mov_b32 s24, s22
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[26:27], v[6:7], v[14:17]
	s_mov_b32 s27, s3
	s_mov_b32 s6, 0x400000
	s_mov_b32 s44, s18
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[28:29], v[2:3], v[22:25]
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	ds_read2st64_b64 v[20:23], v41 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[28:29], v[6:7], v[10:13]
	v_perm_b32 v6, v37, v36, v2
	v_lshlrev_b32_e32 v7, 4, v4
	v_perm_b32 v2, v35, v34, v2
	v_and_or_b32 v2, v6, v7, v2
	v_perm_b32 v6, v37, v36, v3
	v_perm_b32 v3, v35, v34, v3
	v_and_or_b32 v3, v6, v4, v3
	v_perm_b32 v56, v3, v2, s41
	v_perm_b32 v57, v3, v2, s42
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v45, v44, v2
	v_lshlrev_b32_e32 v6, 4, v8
	v_perm_b32 v2, v43, v42, v2
	v_or_b32_e32 v28, s34, v30
	v_and_or_b32 v4, v4, v6, v2
	v_perm_b32 v2, v45, v44, v3
	v_perm_b32 v3, v43, v42, v3
	v_ashrrev_i32_e32 v29, 31, v28
	v_and_or_b32 v3, v2, v8, v3
	v_lshl_add_u64 v[6:7], v[28:29], 2, s[20:21]
	v_perm_b32 v2, v3, v4, s41
	v_perm_b32 v3, v3, v4, s42
	global_load_dword v4, v[6:7], off
	v_lshl_add_u64 v[6:7], s[34:35], 0, v[30:31]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[20:21], v[56:57], v[46:49]
	s_movk_i32 s35, 0x7fff
	s_mov_b32 s45, s5
	s_mov_b32 s46, s6
	v_lshl_add_u64 v[46:47], v[6:7], 2, s[20:21]
	global_load_dwordx3 v[6:8], v[46:47], off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[22:23], v[56:57], v[24:27]
	global_load_dwordx4 v[46:49], v[46:47], off offset:64
	s_mov_b32 s47, s3
	s_mov_b32 s10, 0x800000
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[22:23], v[2:3], v[10:13]
	s_mov_b32 s36, s16
	s_mov_b32 s37, s9
	s_mov_b32 s38, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[2:3], v[60:63]
	v_and_b32_e32 v2, 0x7070707, v5
	v_lshrrev_b32_e32 v3, 4, v5
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v29, v37, v36, v2
	v_perm_b32 v2, v35, v34, v2
	s_mov_b32 s39, s3
	s_mov_b32 s28, s14
	s_mov_b32 s31, s3
	s_mov_b32 s8, s16
	s_mov_b32 s19, 0
	s_mov_b32 s7, s3
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v4, 2, v4
	v_and_b32_e32 v4, 0x3fffffc, v4
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v6, 2, v6
	v_and_b32_e32 v6, 0x3fffffc, v6
	buffer_load_dword v22, v4, s[0:3], 0 offen
	buffer_load_dword v23, v6, s[0:3], 0 offen
	v_lshlrev_b32_e32 v4, 4, v5
	v_and_or_b32 v2, v29, v4, v2
	v_perm_b32 v4, v37, v36, v3
	v_perm_b32 v3, v35, v34, v3
	v_and_or_b32 v3, v4, v5, v3
	v_perm_b32 v34, v3, v2, s41
	v_perm_b32 v35, v3, v2, s42
	ds_read2st64_b64 v[2:5], v71 offset0:16 offset1:24
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v29, 4, v9
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v36, v45, v44, v6
	v_lshlrev_b32_e32 v37, 4, v9
	v_perm_b32 v6, v43, v42, v6
	v_and_or_b32 v6, v36, v37, v6
	v_perm_b32 v36, v45, v44, v29
	v_perm_b32 v29, v43, v42, v29
	v_and_or_b32 v9, v36, v9, v29
	v_perm_b32 v36, v9, v6, s41
	v_perm_b32 v37, v9, v6, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[2:3], v[34:35], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[2:3], v[36:37], v[18:21]
	v_lshlrev_b32_e32 v2, 2, v7
	v_and_b32_e32 v2, 0x3fffffc, v2
	v_lshlrev_b32_e32 v3, 2, v8
	v_and_b32_e32 v3, 0x3fffffc, v3
	buffer_load_dword v42, v2, s[0:3], 0 offen
	buffer_load_dword v43, v3, s[0:3], 0 offen
	s_waitcnt vmcnt(4)
	v_lshlrev_b32_e32 v2, 2, v46
	v_and_b32_e32 v2, 0x3fffffc, v2
	v_lshlrev_b32_e32 v3, 2, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[4:5], v[34:35], v[24:27]
	v_and_b32_e32 v3, 0x3fffffc, v3
	s_nop 1
	buffer_load_dword v24, v2, s[0:3], 0 offen
	buffer_load_dword v25, v3, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[4:5], v[36:37], v[10:13]
	s_nop 2
	v_add_u32_e32 v11, 17, v54
	v_lshl_add_u32 v10, v54, 23, v73
	v_lshlrev_b32_e64 v11, v11, 1
	v_cndmask_b32_e32 v12, v11, v10, vcc
	v_lshlrev_b32_e32 v10, 2, v48
	v_and_b32_e32 v10, 0x3fffffc, v10
	v_lshlrev_b32_e32 v11, 2, v49
	v_and_b32_e32 v11, 0x3fffffc, v11
	buffer_load_dword v26, v10, s[0:3], 0 offen
	buffer_load_dword v27, v11, s[0:3], 0 offen
	v_add_u32_e32 v10, 17, v53
	v_lshl_add_u32 v13, v53, 23, v73
	v_lshlrev_b32_e64 v29, v10, 1
	s_mov_b32 s0, 0xbfb8aa3b
	v_cmp_lt_i32_e32 vcc, 5, v53
	s_lshl_b32 s2, s48, 8
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[10:11], v[12:13], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[14:15], v[10:11]
	v_cndmask_b32_e32 v34, v29, v13, vcc
	v_pk_mul_f32 v[10:11], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[22:23], v[34:35], v[22:23] op_sel_hi:[0,1]
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_pk_mul_f32 v[18:19], v[18:19], v[22:23]
	v_pk_add_f32 v[10:11], v[10:11], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v36, v10
	v_rcp_f32_e32 v37, v11
	v_or_b32_e32 v10, 1, v30
	v_pk_mul_f32 v[14:15], v[14:15], v[36:37]
	s_nop 0
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[18:19], v[34:35], v[42:43] op_sel_hi:[0,1]
	v_bfe_u32 v11, v15, 16, 1
	v_add3_u32 v11, v11, v15, s35
	v_or_b32_e32 v13, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	v_or_b32_e32 v15, 0x400000, v14
	v_pk_mul_f32 v[18:19], v[20:21], v[18:19]
	v_cndmask_b32_e32 v11, v11, v13, vcc
	v_bfe_u32 v13, v14, 16, 1
	v_add3_u32 v13, v13, v14, s35
	v_cmp_u_f32_e32 vcc, v14, v14
	s_nop 1
	v_cndmask_b32_e32 v13, v13, v15, vcc
	v_pk_mul_f32 v[14:15], v[12:13], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[16:17], v[14:15]
	ds_write_b16_d16_hi v72, v13 offset:16384
	v_pk_mul_f32 v[16:17], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_lshlrev_b32_e32 v13, 8, v10
	v_exp_f32_e32 v16, v16
	v_exp_f32_e32 v17, v17
	v_add_lshl_u32 v13, v52, v13, 1
	ds_write_b16_d16_hi v13, v11 offset:16384
	v_pk_add_f32 v[16:17], v[16:17], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v16, v16
	v_rcp_f32_e32 v17, v17
	s_nop 0
	v_pk_mul_f32 v[14:15], v[14:15], v[16:17]
	s_nop 0
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	s_nop 0
	v_bfe_u32 v11, v15, 16, 1
	v_add3_u32 v11, v11, v15, s35
	v_or_b32_e32 v16, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	v_bfe_u32 v15, v14, 16, 1
	v_add3_u32 v15, v15, v14, s35
	v_cndmask_b32_e32 v11, v11, v16, vcc
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[16:17], v[12:13], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[16:17]
	v_or_b32_e32 v18, 0x400000, v14
	v_pk_mul_f32 v[16:17], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v14, v14
	v_exp_f32_e32 v16, v16
	v_exp_f32_e32 v17, v17
	v_cndmask_b32_e32 v14, v15, v18, vcc
	ds_write_b16_d16_hi v13, v14 offset:16896
	ds_write_b16_d16_hi v13, v11 offset:17408
	v_pk_add_f32 v[14:15], v[16:17], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[16:17], v[34:35], v[24:25] op_sel_hi:[0,1]
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_pk_mul_f32 v[2:3], v[2:3], v[16:17]
	v_pk_mul_f32 v[6:7], v[6:7], v[14:15]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	s_nop 0
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s35
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_bfe_u32 v3, v2, 16, 1
	v_add3_u32 v3, v3, v2, s35
	v_cndmask_b32_e32 v11, v6, v7, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[12:13], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_or_b32_e32 v14, 0x400000, v2
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v2, v3, v14, vcc
	ds_write_b16_d16_hi v13, v2 offset:24064
	ds_write_b16_d16_hi v13, v11 offset:24576
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[34:35], v[26:27] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_mov_b32_e32 v8, 0x7fc00000
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_lshlrev_b32_e32 v7, 2, v51
	v_pk_mul_f32 v[2:3], v[4:5], v[2:3]
	s_nop 0
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s35
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s35
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
	ds_write_b16_d16_hi v13, v2 offset:25088
	ds_write_b16_d16_hi v13, v3 offset:25600
	v_or_b32_e32 v2, s2, v7
	v_lshlrev_b32_e32 v2, 1, v2
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[2:3], v2 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v5, 0xffff0000, v3
	v_lshlrev_b32_e32 v4, 16, v3
	v_and_b32_e32 v3, 0xffff0000, v2
	v_lshlrev_b32_e32 v2, 16, v2
	v_max_f32_e64 v6, |v2|, 0
	v_cmp_o_f32_e64 vcc, |v2|, |v2|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v6, vcc
	v_max_f32_e64 v9, v6, |v3|
	v_cmp_o_f32_e64 vcc, v6, |v3|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	v_max_f32_e64 v9, v6, |v4|
	v_cmp_o_f32_e64 vcc, v6, |v4|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	v_max_f32_e64 v9, v6, |v5|
	v_cmp_o_f32_e64 vcc, v6, |v5|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	v_xor_b32_e32 v9, 0x80, v7
	s_nop 0
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_bpermute_b32 v11, v9, v6
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v12, vcc
	v_div_scale_f32 v11, s[0:1], s4, s4, v6
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v6, s4, v6
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s4, v6
	v_cmp_neq_f32_e32 vcc, 0, v6
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v6, s[0:1], v11, v11, 1.0
	v_rcp_f32_e32 v12, v6
	s_lshl_b32 s0, s48, 2
	v_fma_f32 v13, -v6, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v6, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v6, -v6, v14, v13
	v_div_fmas_f32 v6, v6, v12, v14
	v_div_fixup_f32 v6, v6, v11, 1.0
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[6:7], v[4:5] op_sel_hi:[0,1]
	v_min_f32_e32 v6, 0x43700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	v_mov_b32_e32 v12, s0
	s_and_b32 s0, s50, 0xf0
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	ds_write_b32 v12, v11 offset:8192
	s_nop 0
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v8, v6, vcc
	v_mov_b32_e32 v6, v31
	v_cvt_pk_fp8_f32 v6, v2, v3
	v_max_f32_e32 v2, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	v_xor_b32_e32 v3, s0, v7
	s_lshl_b32 s0, s48, 9
	v_cndmask_b32_e32 v2, v8, v2, vcc
	v_cvt_pk_fp8_f32 v6, v4, v2 op_sel:[0,0,1]
	v_or_b32_e32 v7, s2, v3
	s_addk_i32 s0, 0x2000
	s_brev_b32 s2, 16
	v_and_b32_e32 v2, 0x7f7f7f7f, v6
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v2, v2, v6
	ds_write_b32 v7, v2
	v_lshl_or_b32 v2, v51, 3, s0
	ds_read_b64 v[2:3], v2 offset:16384
	s_mov_b32 s30, s2
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v5, 0xffff0000, v3
	v_lshlrev_b32_e32 v4, 16, v3
	v_and_b32_e32 v3, 0xffff0000, v2
	v_lshlrev_b32_e32 v2, 16, v2
	v_max_f32_e64 v6, |v2|, 0
	v_cmp_o_f32_e64 vcc, |v2|, |v2|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v6, vcc
	v_max_f32_e64 v11, v6, |v3|
	v_cmp_o_f32_e64 vcc, v6, |v3|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	v_max_f32_e64 v11, v6, |v4|
	v_cmp_o_f32_e64 vcc, v6, |v4|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	v_max_f32_e64 v11, v6, |v5|
	v_cmp_o_f32_e64 vcc, v6, |v5|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_bpermute_b32 v9, v9, v6
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	v_div_scale_f32 v9, s[0:1], s4, s4, v6
	v_rcp_f32_e32 v11, v9
	s_nop 0
	v_fma_f32 v13, -v9, v11, 1.0
	v_fmac_f32_e32 v11, v13, v11
	v_div_scale_f32 v13, vcc, v6, s4, v6
	v_mul_f32_e32 v14, v13, v11
	v_fma_f32 v15, -v9, v14, v13
	v_fmac_f32_e32 v14, v15, v11
	v_fma_f32 v9, -v9, v14, v13
	v_div_fmas_f32 v9, v9, v11, v14
	v_div_fixup_f32 v9, v9, s4, v6
	v_cmp_neq_f32_e32 vcc, 0, v6
	s_nop 1
	v_cndmask_b32_e32 v9, 1.0, v9, vcc
	v_div_scale_f32 v6, s[0:1], v9, v9, 1.0
	v_rcp_f32_e32 v11, v6
	s_mul_i32 s0, s49, 0xe00
	s_add_i32 s17, s11, s0
	s_ashr_i32 s0, s17, 31
	v_fma_f32 v13, -v6, v11, 1.0
	v_fmac_f32_e32 v11, v13, v11
	v_div_scale_f32 v13, vcc, 1.0, v9, 1.0
	v_mul_f32_e32 v14, v13, v11
	v_fma_f32 v15, -v6, v14, v13
	v_fmac_f32_e32 v14, v15, v11
	v_fma_f32 v6, -v6, v14, v13
	v_div_fmas_f32 v6, v6, v11, v14
	v_div_fixup_f32 v6, v6, v9, 1.0
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[6:7], v[4:5] op_sel_hi:[0,1]
	v_min_f32_e32 v6, 0x43700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	s_lshr_b32 s0, s0, 27
	s_add_i32 s0, s17, s0
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	s_and_b32 s1, s15, 0xffff
	s_ashr_i32 s4, s0, 5
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_andn2_b32 s0, s0, 31
	s_cmp_lg_u32 s17, s0
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	ds_write_b32 v12, v9 offset:8256
	s_cselect_b64 s[22:23], -1, 0
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_cvt_pk_fp8_f32 v31, v2, v3
	s_cmp_lt_i32 s17, 0
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_mov_b32 s29, s1
	s_mov_b32 s11, s3
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v8, v6, vcc
	v_max_f32_e32 v2, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v2, v8, v2, vcc
	v_cvt_pk_fp8_f32 v31, v4, v2 op_sel:[0,0,1]
	v_or_b32_e32 v2, s34, v10
	v_lshlrev_b32_e32 v2, 2, v2
	v_and_b32_e32 v3, 0x7f7f7f7f, v31
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v31
	ds_write_b32 v7, v3 offset:4096
	v_lshlrev_b32_e32 v3, 2, v28
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_or_b32_e32 v4, 8, v3
	v_or_b32_e32 v5, 12, v3
	v_or_b32_e32 v6, 64, v3
	v_or_b32_e32 v7, 0x44, v3
	v_or_b32_e32 v8, 0x48, v3
	v_or_b32_e32 v9, 0x4c, v3
	buffer_load_dword v64, v3, s[24:27], 0 offen
	buffer_load_dword v65, v2, s[24:27], 0 offen
	buffer_load_dword v66, v4, s[24:27], 0 offen
	buffer_load_dword v67, v5, s[24:27], 0 offen
	buffer_load_dword v60, v6, s[24:27], 0 offen
	buffer_load_dword v61, v7, s[24:27], 0 offen
	buffer_load_dword v62, v8, s[24:27], 0 offen
	buffer_load_dword v63, v9, s[24:27], 0 offen
	s_cselect_b64 s[24:25], -1, 0
	s_and_b64 s[22:23], s[24:25], s[22:23]
	v_or_b32_e32 v2, s17, v1
	s_subb_u32 s0, s4, 0
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s0, 6
	buffer_load_dword v76, v2, s[44:47], 0 offen
	v_or3_b32 v2, s0, v50, v1
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s17, 3
	buffer_load_dword v75, v2, s[36:39], 0 offen
	v_or3_b32 v2, s0, v50, v1
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[54:57], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[50:53], v3, s[28:31], 0 offen nt
	v_add_u32_e32 v2, v69, v70
	ds_read2st64_b64 v[42:45], v2 offset1:8
	ds_read2st64_b64 v[34:37], v32 offset1:8
	ds_read2st64_b64 v[30:33], v33 offset1:8
	ds_read2st64_b64 v[26:29], v38 offset1:8
	ds_read2st64_b64 v[22:25], v39 offset1:8
	ds_read2st64_b64 v[18:21], v40 offset1:8
	ds_read2st64_b64 v[14:17], v41 offset1:8
	ds_read2st64_b64 v[10:13], v71 offset1:8
	v_lshlrev_b32_e32 v38, 1, v0
	v_lshlrev_b32_e32 v2, 4, v68
	v_and_b32_e32 v68, 62, v38
	v_or_b32_e32 v38, v59, v68
	ds_read_b128 v[6:9], v2 offset:8192
	ds_read_b128 v[2:5], v2 offset:8256
	v_lshlrev_b32_e32 v69, 2, v58
	v_lshlrev_b32_e32 v58, 1, v38
	v_lshlrev_b32_e32 v38, 2, v0
	s_lshl_b32 s16, s49, 12
	s_mov_b32 s0, s14
	v_and_b32_e32 v59, 0xfc, v38
	v_lshlrev_b32_e32 v38, 4, v0
	v_and_b32_e32 v0, 31, v0
	s_add_i32 s16, s16, s50
	s_lshl_b32 s14, s49, 19
	s_lshl_b32 s15, s48, 11
	v_and_b32_e32 v38, 0x3f0, v38
	v_lshlrev_b32_e32 v70, 2, v0
	v_add_u32_e32 v0, s16, v1
	v_mov_b32_e32 v1, 0x400
	s_add_i32 s14, s14, s15
	v_lshl_add_u32 v1, v0, 2, v1
	v_or_b32_e32 v0, s14, v38
	s_mov_b32 s4, s18
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	s_and_b32 s21, s21, 0xffff
	v_add_u32_e32 v71, 0x8400, v0
	s_mov_b32 s18, 0
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[14:15]
	s_add_i32 s18, s18, 1
	s_addk_i32 s19, 0x100
	v_add_u32_e32 v70, 0x200, v70
	v_add_u32_e32 v1, 0x400, v1
	v_add_u32_e32 v71, 0x8000, v71
	s_cmpk_lg_i32 s19, 0xf00
	v_mov_b64_e32 v[56:57], v[48:49]
	v_mov_b64_e32 v[54:55], v[46:47]
	v_mov_b64_e32 v[52:53], v[40:41]
	v_mov_b64_e32 v[50:51], v[38:39]
	v_mov_b32_e32 v76, v0
	s_cbranch_scc0 .LBB0_7
.LBB0_5:
	s_add_i32 s15, s16, s19
	s_ashr_i32 s24, s15, 4
	s_lshr_b32 s25, s15, 31
	s_add_i32 s25, s24, s25
	s_and_b32 s25, s25, -2
	s_sub_i32 s24, s24, s25
	s_lshl_b32 s24, s24, 3
	s_waitcnt vmcnt(2)
	v_bfe_u32 v77, v75, s24, 8
	s_add_i32 s24, s24, 16
	s_addk_i32 s15, 0x100
	v_bfe_u32 v84, v75, s24, 8
	s_ashr_i32 s24, s15, 31
	s_lshr_b32 s24, s24, 27
	s_add_i32 s24, s15, s24
	s_and_b32 s14, s18, 1
	s_ashr_i32 s28, s24, 5
	s_andn2_b32 s24, s24, 31
	s_cmp_lg_u32 s15, s24
	s_cselect_b64 s[24:25], -1, 0
	s_cmp_lt_i32 s15, 0
	s_cselect_b64 s[26:27], -1, 0
	s_and_b64 s[24:25], s[26:27], s[24:25]
	s_subb_u32 s15, s28, 0
	v_lshl_or_b32 v38, s15, 8, v59
	buffer_load_dword v75, v38, s[8:11], 0 offen
	v_add_u32_e32 v38, 0xfffffc00, v71
	buffer_load_dword v0, v1, s[4:7], 0 offen
	buffer_load_dwordx4 v[46:49], v38, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[38:41], v71, s[0:3], 0 offen nt
	v_sub_u32_e32 v77, v76, v77
	v_min_i32_e32 v78, 11, v77
	v_mul_lo_u32 v78, v78, s40
	v_sub_u32_e32 v79, 0x6c686080, v78
	v_and_b32_e32 v79, 0xffffff00, v79
	v_cmp_lt_i32_e32 vcc, 11, v77
	v_sub_u32_e32 v78, 0x7c787470, v78
	s_waitcnt vmcnt(5)
	v_lshlrev_b32_e32 v81, 4, v54
	v_cndmask_b32_e64 v77, v79, 0, vcc
	v_cndmask_b32_e64 v86, v78, 0, vcc
	v_add_u32_e32 v78, 0x7f7f7f00, v77
	v_and_b32_e32 v87, 0x80808000, v78
	v_add_u32_e32 v78, 0x7f7f7f78, v86
	v_and_b32_e32 v88, 0x80808080, v78
	v_and_b32_e32 v78, 0x7070707, v54
	v_lshrrev_b32_e32 v79, 4, v54
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v88, v87, v78
	v_perm_b32 v78, v86, v77, v78
	v_and_or_b32 v78, v80, v81, v78
	v_perm_b32 v80, v88, v87, v79
	v_perm_b32 v79, v86, v77, v79
	v_and_or_b32 v54, v80, v54, v79
	v_sub_u32_e32 v89, v76, v84
	v_perm_b32 v82, v54, v78, s41
	v_perm_b32 v83, v54, v78, s42
	v_min_i32_e32 v54, 11, v89
	v_mul_lo_u32 v90, v54, s40
	v_and_b32_e32 v54, 0x7070707, v55
	v_lshrrev_b32_e32 v91, 4, v55
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[42:43], v[82:83], 0
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v88, v87, v54
	v_lshlrev_b32_e32 v93, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[44:45], v[82:83], 0
	v_perm_b32 v54, v86, v77, v54
	v_and_or_b32 v92, v92, v93, v54
	v_perm_b32 v54, v88, v87, v91
	v_perm_b32 v91, v86, v77, v91
	v_and_or_b32 v55, v54, v55, v91
	v_perm_b32 v54, v55, v92, s41
	v_perm_b32 v55, v55, v92, s42
	v_lshlrev_b32_e32 v93, 4, v56
	v_sub_u32_e32 v91, 0x6c686080, v90
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[34:35], v[54:55], v[78:81]
	v_and_b32_e32 v91, 0xffffff00, v91
	v_sub_u32_e32 v90, 0x7c787470, v90
	v_cmp_lt_i32_e32 vcc, 11, v89
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[36:37], v[54:55], v[82:85]
	v_and_b32_e32 v54, 0x7070707, v56
	v_lshrrev_b32_e32 v55, 4, v56
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v92, v88, v87, v54
	v_perm_b32 v54, v86, v77, v54
	v_and_or_b32 v92, v92, v93, v54
	v_perm_b32 v54, v88, v87, v55
	v_perm_b32 v55, v86, v77, v55
	v_and_or_b32 v55, v54, v56, v55
	v_perm_b32 v54, v55, v92, s41
	v_perm_b32 v55, v55, v92, s42
	v_lshlrev_b32_e32 v92, 4, v57
	v_cndmask_b32_e64 v89, v91, 0, vcc
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[30:31], v[54:55], v[78:81]
	v_cndmask_b32_e64 v90, v90, 0, vcc
	v_add_u32_e32 v91, 0x7f7f7f00, v89
	v_cmp_lt_i32_e32 vcc, 5, v76
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[32:33], v[54:55], v[82:85]
	v_and_b32_e32 v54, 0x7070707, v57
	v_lshrrev_b32_e32 v55, 4, v57
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v56, v88, v87, v54
	v_perm_b32 v54, v86, v77, v54
	v_and_or_b32 v54, v56, v92, v54
	v_perm_b32 v56, v88, v87, v55
	v_perm_b32 v55, v86, v77, v55
	v_and_or_b32 v55, v56, v57, v55
	v_perm_b32 v86, v55, v54, s41
	v_perm_b32 v87, v55, v54, s42
	v_and_b32_e32 v77, 0x80808000, v91
	s_cmp_eq_u32 s14, 0
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[26:27], v[86:87], v[78:81]
	s_cselect_b32 s24, 0x4000, 0
	s_nop 1
	v_add_u32_e32 v78, 0x7f7f7f78, v90
	v_and_b32_e32 v88, 0x80808080, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[28:29], v[86:87], v[82:85]
	s_waitcnt vmcnt(4)
	s_nop 1
	v_and_b32_e32 v82, 0x7070707, v50
	v_lshrrev_b32_e32 v83, 4, v50
	v_and_b32_e32 v83, 0x7070707, v83
	v_perm_b32 v84, v88, v77, v82
	v_lshlrev_b32_e32 v85, 4, v50
	v_perm_b32 v82, v90, v89, v82
	v_and_or_b32 v84, v84, v85, v82
	v_perm_b32 v82, v88, v77, v83
	v_perm_b32 v83, v90, v89, v83
	v_and_or_b32 v50, v82, v50, v83
	v_perm_b32 v82, v50, v84, s41
	v_perm_b32 v83, v50, v84, s42
	v_and_b32_e32 v50, 0x7070707, v51
	v_lshlrev_b32_e32 v84, 4, v51
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[22:23], v[82:83], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[24:25], v[82:83], v[78:81]
	v_lshrrev_b32_e32 v82, 4, v51
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v83, v88, v77, v50
	v_perm_b32 v50, v90, v89, v50
	v_and_or_b32 v83, v83, v84, v50
	v_perm_b32 v50, v88, v77, v82
	v_perm_b32 v82, v90, v89, v82
	v_and_or_b32 v51, v50, v51, v82
	v_perm_b32 v50, v51, v83, s41
	v_perm_b32 v51, v51, v83, s42
	v_lshlrev_b32_e32 v83, 4, v52
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[18:19], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[20:21], v[50:51], v[78:81]
	v_and_b32_e32 v50, 0x7070707, v52
	v_lshrrev_b32_e32 v51, 4, v52
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v82, v88, v77, v50
	v_perm_b32 v50, v90, v89, v50
	v_and_or_b32 v82, v82, v83, v50
	v_perm_b32 v50, v88, v77, v51
	v_perm_b32 v51, v90, v89, v51
	v_and_or_b32 v51, v50, v52, v51
	v_perm_b32 v50, v51, v82, s41
	v_perm_b32 v51, v51, v82, s42
	v_lshlrev_b32_e32 v82, 4, v53
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[14:15], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[16:17], v[50:51], v[78:81]
	v_and_b32_e32 v50, 0x7070707, v53
	v_lshrrev_b32_e32 v51, 4, v53
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v88, v77, v50
	v_perm_b32 v50, v90, v89, v50
	v_and_or_b32 v50, v52, v82, v50
	v_perm_b32 v52, v88, v77, v51
	v_perm_b32 v51, v90, v89, v51
	v_and_or_b32 v51, v52, v53, v51
	v_perm_b32 v82, v51, v50, s41
	v_perm_b32 v83, v51, v50, s42
	v_lshl_add_u32 v77, v76, 23, v73
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[10:11], v[82:83], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[12:13], v[82:83], v[78:81]
	s_nop 2
	v_add_u32_e32 v78, 17, v76
	v_lshlrev_b32_e64 v78, v78, 1
	v_cndmask_b32_e32 v76, v78, v77, vcc
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[80:81], v[8:9], v[76:77] op_sel_hi:[1,0]
	v_pk_mul_f32 v[78:79], v[6:7], v[76:77] op_sel_hi:[1,0]
	v_pk_mul_f32 v[52:53], v[80:81], v[52:53]
	v_pk_mul_f32 v[50:51], v[78:79], v[50:51]
	v_pk_mul_f32 v[52:53], v[52:53], v[66:67]
	v_pk_mul_f32 v[50:51], v[50:51], v[64:65]
	v_bfe_u32 v77, v53, 16, 1
	v_add3_u32 v77, v77, v53, s35
	v_or_b32_e32 v78, 0x400000, v53
	v_cmp_u_f32_e32 vcc, v53, v53
	s_nop 1
	v_cndmask_b32_e32 v53, v77, v78, vcc
	v_bfe_u32 v77, v52, 16, 1
	v_add3_u32 v77, v77, v52, s35
	v_or_b32_e32 v78, 0x400000, v52
	v_cmp_u_f32_e32 vcc, v52, v52
	s_nop 1
	v_cndmask_b32_e32 v52, v77, v78, vcc
	v_bfe_u32 v77, v51, 16, 1
	v_add3_u32 v77, v77, v51, s35
	v_or_b32_e32 v78, 0x400000, v51
	v_cmp_u_f32_e32 vcc, v51, v51
	s_nop 1
	v_cndmask_b32_e32 v51, v77, v78, vcc
	v_bfe_u32 v77, v50, 16, 1
	v_add3_u32 v77, v77, v50, s35
	v_or_b32_e32 v78, 0x400000, v50
	v_cmp_u_f32_e32 vcc, v50, v50
	s_nop 1
	v_cndmask_b32_e32 v50, v77, v78, vcc
	v_lshl_add_u32 v77, v74, 1, s24
	ds_write_b16_d16_hi v77, v50
	ds_write_b16_d16_hi v77, v51 offset:512
	ds_write_b16_d16_hi v77, v52 offset:1024
	ds_write_b16_d16_hi v77, v53 offset:1536
	s_waitcnt lgkmcnt(4)
	v_pk_mul_f32 v[52:53], v[4:5], v[76:77] op_sel_hi:[1,0]
	v_pk_mul_f32 v[50:51], v[2:3], v[76:77] op_sel_hi:[1,0]
	v_pk_mul_f32 v[52:53], v[52:53], v[56:57]
	v_pk_mul_f32 v[50:51], v[50:51], v[54:55]
	v_pk_mul_f32 v[52:53], v[52:53], v[62:63]
	v_pk_mul_f32 v[50:51], v[50:51], v[60:61]
	v_bfe_u32 v54, v53, 16, 1
	v_add3_u32 v54, v54, v53, s35
	v_or_b32_e32 v55, 0x400000, v53
	v_cmp_u_f32_e32 vcc, v53, v53
	s_nop 1
	v_cndmask_b32_e32 v53, v54, v55, vcc
	v_bfe_u32 v54, v52, 16, 1
	v_add3_u32 v54, v54, v52, s35
	v_or_b32_e32 v55, 0x400000, v52
	v_cmp_u_f32_e32 vcc, v52, v52
	s_nop 1
	v_cndmask_b32_e32 v52, v54, v55, vcc
	v_bfe_u32 v54, v51, 16, 1
	v_add3_u32 v54, v54, v51, s35
	v_or_b32_e32 v55, 0x400000, v51
	v_cmp_u_f32_e32 vcc, v51, v51
	s_nop 1
	v_cndmask_b32_e32 v51, v54, v55, vcc
	v_bfe_u32 v54, v50, 16, 1
	v_add3_u32 v54, v54, v50, s35
	v_or_b32_e32 v55, 0x400000, v50
	v_cmp_u_f32_e32 vcc, v50, v50
	s_nop 1
	v_cndmask_b32_e32 v50, v54, v55, vcc
	ds_write_b16_d16_hi v77, v50 offset:8192
	ds_write_b16_d16_hi v77, v51 offset:8704
	ds_write_b16_d16_hi v77, v52 offset:9216
	ds_write_b16_d16_hi v77, v53 offset:9728
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v50, v69, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v51, 0xffffff, v50
	v_cmp_gt_i32_e32 vcc, s33, v51
	s_and_saveexec_b64 s[14:15], vcc
	s_cbranch_execz .LBB0_4
	v_add_u32_e32 v52, s24, v58
	ds_read_b32 v53, v52
	v_lshl_add_u32 v50, v50, 13, v70
	v_ashrrev_i32_e32 v51, 31, v50
	v_lshl_add_u64 v[50:51], s[12:13], 0, v[50:51]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[50:51], v53, off
	ds_read_b32 v53, v52 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[50:51], v53, off offset:128
	ds_read_b32 v53, v52 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[50:51], v53, off offset:256
	ds_read_b32 v52, v52 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[50:51], v52, off offset:384
	s_branch .LBB0_4
.LBB0_7:
	s_addk_i32 s17, 0xf00
	s_ashr_i32 s0, s17, 4
	s_lshr_b32 s1, s17, 31
	s_add_i32 s1, s0, s1
	s_and_b32 s1, s1, -2
	s_sub_i32 s0, s0, s1
	s_lshl_b32 s0, s0, 3
	v_bfe_u32 v1, v75, s0, 8
	s_add_i32 s0, s0, 16
	v_sub_u32_e32 v1, v0, v1
	v_bfe_u32 v56, v75, s0, 8
	v_min_i32_e32 v50, 11, v1
	s_mov_b32 s0, 0x8080808
	v_mul_lo_u32 v50, v50, s0
	v_sub_u32_e32 v51, 0x6c686080, v50
	v_and_b32_e32 v51, 0xffffff00, v51
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v50, 0x7c787470, v50
	v_lshlrev_b32_e32 v53, 4, v46
	v_cndmask_b32_e64 v1, v51, 0, vcc
	v_cndmask_b32_e64 v57, v50, 0, vcc
	v_add_u32_e32 v50, 0x7f7f7f00, v1
	v_and_b32_e32 v59, 0x80808000, v50
	v_add_u32_e32 v50, 0x7f7f7f78, v57
	v_and_b32_e32 v70, 0x80808080, v50
	v_and_b32_e32 v50, 0x7070707, v46
	v_lshrrev_b32_e32 v51, 4, v46
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v70, v59, v50
	v_perm_b32 v50, v57, v1, v50
	v_and_or_b32 v50, v52, v53, v50
	v_perm_b32 v52, v70, v59, v51
	v_perm_b32 v51, v57, v1, v51
	v_and_or_b32 v46, v52, v46, v51
	s_mov_b32 s1, 0x5010400
	s_mov_b32 s2, 0x7030602
	v_perm_b32 v54, v46, v50, s1
	v_perm_b32 v55, v46, v50, s2
	v_sub_u32_e32 v56, v0, v56
	v_and_b32_e32 v46, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[42:43], v[54:55], 0
	v_min_i32_e32 v42, 11, v56
	v_mul_lo_u32 v71, v42, s0
	v_lshlrev_b32_e32 v73, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[44:45], v[54:55], 0
	v_lshrrev_b32_e32 v54, 4, v47
	v_and_b32_e32 v54, 0x7070707, v54
	v_perm_b32 v55, v70, v59, v46
	v_perm_b32 v46, v57, v1, v46
	v_and_or_b32 v55, v55, v73, v46
	v_perm_b32 v46, v70, v59, v54
	v_perm_b32 v54, v57, v1, v54
	v_and_or_b32 v47, v46, v47, v54
	v_perm_b32 v46, v47, v55, s1
	v_perm_b32 v47, v47, v55, s2
	v_sub_u32_e32 v55, 0x7c787470, v71
	v_cmp_lt_i32_e32 vcc, 11, v56
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[34:35], v[46:47], v[50:53]
	v_sub_u32_e32 v34, 0x6c686080, v71
	v_and_b32_e32 v54, 0xffffff00, v34
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[46:47], v[42:45]
	s_nop 2
	v_and_b32_e32 v42, 0x7070707, v48
	v_lshrrev_b32_e32 v43, 4, v48
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v70, v59, v42
	v_lshlrev_b32_e32 v45, 4, v48
	v_perm_b32 v42, v57, v1, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v70, v59, v43
	v_perm_b32 v43, v57, v1, v43
	v_and_or_b32 v43, v44, v48, v43
	v_perm_b32 v46, v43, v42, s1
	v_perm_b32 v47, v43, v42, s2
	v_cndmask_b32_e64 v48, v54, 0, vcc
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[30:31], v[46:47], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[32:33], v[46:47], v[34:37]
	s_nop 1
	v_cndmask_b32_e64 v50, v55, 0, vcc
	v_add_u32_e32 v51, 0x7f7f7f00, v48
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_and_b32_e32 v34, 0x7070707, v49
	v_lshrrev_b32_e32 v35, 4, v49
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v70, v59, v34
	v_lshlrev_b32_e32 v37, 4, v49
	v_perm_b32 v34, v57, v1, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v70, v59, v35
	v_perm_b32 v1, v57, v1, v35
	v_and_or_b32 v1, v36, v49, v1
	v_perm_b32 v46, v1, v34, s1
	v_perm_b32 v47, v1, v34, s2
	v_and_b32_e32 v1, 0x80808000, v51
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[26:27], v[46:47], v[42:45]
	v_add_u32_e32 v26, 0x7f7f7f78, v50
	s_nop 1
	v_and_b32_e32 v44, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[46:47], v[30:33]
	s_nop 2
	v_and_b32_e32 v30, 0x7070707, v38
	v_lshrrev_b32_e32 v31, 4, v38
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v44, v1, v30
	v_lshlrev_b32_e32 v33, 4, v38
	v_perm_b32 v30, v50, v48, v30
	v_and_or_b32 v30, v32, v33, v30
	v_perm_b32 v32, v44, v1, v31
	v_perm_b32 v31, v50, v48, v31
	v_and_or_b32 v31, v32, v38, v31
	v_perm_b32 v42, v31, v30, s1
	v_perm_b32 v43, v31, v30, s2
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[22:23], v[42:43], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[42:43], v[26:29]
	s_nop 2
	v_and_b32_e32 v26, 0x7070707, v39
	v_lshrrev_b32_e32 v27, 4, v39
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v44, v1, v26
	v_lshlrev_b32_e32 v29, 4, v39
	v_perm_b32 v26, v50, v48, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v44, v1, v27
	v_perm_b32 v27, v50, v48, v27
	v_and_or_b32 v27, v28, v39, v27
	v_perm_b32 v34, v27, v26, s1
	v_perm_b32 v35, v27, v26, s2
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[18:19], v[34:35], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[34:35], v[22:25]
	s_nop 2
	v_and_b32_e32 v22, 0x7070707, v40
	v_lshrrev_b32_e32 v23, 4, v40
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v44, v1, v22
	v_lshlrev_b32_e32 v25, 4, v40
	v_perm_b32 v22, v50, v48, v22
	v_and_or_b32 v22, v24, v25, v22
	v_perm_b32 v24, v44, v1, v23
	v_perm_b32 v23, v50, v48, v23
	v_and_or_b32 v23, v24, v40, v23
	v_perm_b32 v30, v23, v22, s1
	v_perm_b32 v31, v23, v22, s2
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[14:15], v[30:31], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[30:31], v[18:21]
	s_nop 2
	v_lshrrev_b32_e32 v19, 4, v41
	v_and_b32_e32 v18, 0x7070707, v41
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v44, v1, v18
	v_lshlrev_b32_e32 v21, 4, v41
	v_perm_b32 v18, v50, v48, v18
	v_perm_b32 v1, v44, v1, v19
	v_perm_b32 v19, v50, v48, v19
	v_and_or_b32 v18, v20, v21, v18
	v_and_or_b32 v1, v1, v41, v19
	v_perm_b32 v26, v1, v18, s1
	v_perm_b32 v27, v1, v18, s2
	v_mov_b32_e32 v1, 0xfd800000
	v_lshl_add_u32 v1, v0, 23, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[26:27], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[12:13], v[26:27], v[14:17]
	s_nop 2
	v_add_u32_e32 v14, 17, v0
	v_lshlrev_b32_e64 v14, v14, 1
	v_cndmask_b32_e32 v0, v14, v1, vcc
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_pk_mul_f32 v[8:9], v[8:9], v[66:67]
	v_pk_mul_f32 v[6:7], v[6:7], v[64:65]
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v14, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v14, vcc
	v_or_b32_e32 v14, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	v_pk_mul_f32 v[2:3], v[2:3], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	s_nop 0
	v_cndmask_b32_e32 v7, v9, v14, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v14, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[2:3], v[2:3], v[60:61]
	s_nop 0
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v72, v6
	ds_write_b16_d16_hi v72, v7 offset:512
	ds_write_b16_d16_hi v72, v8 offset:1024
	ds_write_b16_d16_hi v72, v1 offset:1536
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[12:13]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[62:63]
	s_nop 0
	v_bfe_u32 v4, v1, 16, 1
	v_add3_u32 v4, v4, v1, s0
	v_or_b32_e32 v5, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v4, v5, vcc
	v_bfe_u32 v4, v0, 16, 1
	v_add3_u32 v4, v4, v0, s0
	v_or_b32_e32 v5, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v4, v5, vcc
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s0
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s0
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
	ds_write_b16_d16_hi v72, v2 offset:8192
	ds_write_b16_d16_hi v72, v3 offset:8704
	ds_write_b16_d16_hi v72, v0 offset:9216
	ds_write_b16_d16_hi v72, v1 offset:9728
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v69, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshlrev_b32_e32 v1, 1, v68
	ds_read_b32 v2, v58
	v_lshl_or_b32 v0, v0, 13, v1
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[12:13], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3584
	ds_read_b32 v2, v58 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3712
	ds_read_b32 v2, v58 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3840
	ds_read_b32 v2, v58 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_9:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db
		.amdhsa_group_segment_fixed_size 32768
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 108
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
		.amdhsa_next_free_vgpr 108
		.amdhsa_next_free_sgpr 53
		.amdhsa_accum_offset 108
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.num_vgpr, 108
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.numbered_sgpr, 53
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.has_indirect_call, 0
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
        .size:           8
        .value_kind:     by_value
      - .offset:         80
        .size:           8
        .value_kind:     by_value
      - .offset:         88
        .size:           8
        .value_kind:     by_value
      - .offset:         96
        .size:           8
        .value_kind:     by_value
      - .offset:         104
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 32768
    .kernarg_segment_align: 8
    .kernarg_segment_size: 108
    .max_flat_workgroup_size: 1024
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 1024
      - 1
      - 1
    .sgpr_count:     59
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn256_bcm12_xcd1_ftz_a2r_db.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     108
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
