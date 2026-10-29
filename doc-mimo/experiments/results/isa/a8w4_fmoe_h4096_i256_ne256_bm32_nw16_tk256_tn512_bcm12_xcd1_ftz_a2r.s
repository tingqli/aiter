	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r:
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
	s_cbranch_scc1 .LBB0_10
	s_lshr_b32 s48, s3, 6
	s_and_b32 s3, s4, 7
	s_and_b32 s5, s2, 7
	s_lshr_b32 s4, s4, 3
	s_min_u32 s3, s5, s3
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s4, s4, s5
	s_add_i32 s2, s3, s2
	s_add_i32 s2, s2, s4
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[4:5], s[2:3], 2
	s_add_u32 s50, s16, s4
	s_addc_u32 s51, s17, s5
	s_lshl_b32 s34, s2, 5
	v_lshrrev_b32_e32 v52, 5, v0
	v_or_b32_e32 v50, s34, v52
	v_ashrrev_i32_e32 v51, 31, v50
	v_lshl_add_u64 v[2:3], v[50:51], 2, s[20:21]
	global_load_dword v6, v[2:3], off
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dword s33, s[0:1], 0x68
	v_and_b32_e32 v1, 15, v0
	v_lshlrev_b32_e32 v2, 3, v0
	v_lshrrev_b32_e32 v3, 1, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s37, s5, 0xffff
	s_load_dword s5, s[50:51], 0x0
	s_and_b32 s25, s9, 0xffff
	s_lshl_b32 s9, s48, 4
	s_and_b32 s29, s11, 0xffff
	s_lshl_b32 s38, s33, 12
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s5, 9
	s_add_i32 s11, s2, s9
	s_ashr_i32 s24, s11, 4
	v_and_b32_e32 v18, 0xf8, v2
	v_and_b32_e32 v2, 0xf0, v3
	v_or_b32_e32 v58, s9, v1
	s_cmp_lt_i32 s11, 0
	v_and_b32_e32 v51, 48, v0
	v_xor_b32_e32 v7, v2, v18
	v_add_u32_e32 v2, s2, v58
	s_cselect_b64 s[2:3], -1, 0
	s_lshl_b32 s27, s11, 7
	s_ashr_i32 s28, s11, 31
	v_or3_b32 v67, s27, v51, v1
	s_lshr_b32 s27, s28, 27
	s_add_i32 s27, s11, s27
	s_ashr_i32 s28, s27, 5
	s_andn2_b32 s27, s27, 31
	s_cmp_lg_u32 s11, s27
	s_cselect_b64 s[50:51], -1, 0
	s_and_b64 s[2:3], s[2:3], s[50:51]
	s_subb_u32 s2, s28, 0
	s_lshr_b32 s3, s11, 31
	s_lshl_b32 s2, s2, 10
	s_add_i32 s3, s24, s3
	s_add_i32 s49, s11, 0x100
	v_or3_b32 v68, s2, v51, v1
	s_and_b32 s2, s3, -2
	s_ashr_i32 s52, s49, 4
	s_sub_i32 s53, s24, s2
	s_cmp_lt_i32 s49, 0
	s_cselect_b64 s[2:3], -1, 0
	s_lshl_b32 s11, s49, 7
	s_ashr_i32 s24, s49, 31
	v_or3_b32 v70, s11, v51, v1
	s_lshr_b32 s11, s24, 27
	s_add_i32 s11, s49, s11
	s_ashr_i32 s24, s11, 5
	s_andn2_b32 s11, s11, 31
	s_cmp_lg_u32 s49, s11
	s_cselect_b64 s[50:51], -1, 0
	s_and_b64 s[2:3], s[2:3], s[50:51]
	v_ashrrev_i32_e32 v3, 31, v2
	v_add_u32_e32 v4, 0x100, v2
	s_subb_u32 s2, s24, 0
	s_mov_b32 s39, 0x27000
	s_brev_b32 s26, 8
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	v_ashrrev_i32_e32 v5, 31, v4
	s_lshl_b32 s2, s2, 10
	s_mov_b32 s30, 0x1000000
	s_mov_b32 s42, s26
	s_mov_b32 s43, s39
	s_mov_b32 s40, s8
	s_mov_b32 s41, s25
	v_or3_b32 v71, s2, v51, v1
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	global_load_dword v60, v[2:3], off
	global_load_dword v59, v[4:5], off
	v_lshlrev_b32_e32 v2, 4, v67
	v_lshlrev_b32_e32 v21, 4, v70
	s_mov_b32 s46, s30
	s_mov_b32 s47, s39
	s_mov_b32 s44, s10
	s_mov_b32 s45, s29
	v_lshlrev_b32_e32 v19, 2, v68
	v_lshlrev_b32_e32 v20, 2, v71
	s_mov_b32 s36, s4
	s_mov_b32 s24, s8
	s_lshr_b32 s8, s49, 31
	s_waitcnt vmcnt(2)
	v_lshl_or_b32 v72, v6, 12, v7
	buffer_load_dwordx4 v[14:17], v2, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v2, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[10:13], v21, s[40:43], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v21, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dword v75, v19, s[44:47], 0 offen
	buffer_load_dword v74, v20, s[44:47], 0 offen
	buffer_load_dwordx2 v[34:35], v72, s[36:39], 0 offen nt
	s_load_dwordx2 s[12:13], s[0:1], 0x60
	v_bfe_u32 v53, v0, 4, 2
	s_mov_b32 s28, s10
	s_add_i32 s10, s52, s8
	v_lshlrev_b32_e32 v19, 5, v53
	v_lshlrev_b32_e32 v20, 4, v1
	s_and_b32 s10, s10, -2
	v_xor_b32_e32 v55, v19, v20
	v_or_b32_e32 v21, 8, v19
	v_or_b32_e32 v22, 16, v19
	v_or_b32_e32 v23, 24, v19
	v_or_b32_e32 v24, 0x80, v19
	v_or_b32_e32 v25, 0x88, v19
	v_or_b32_e32 v33, 0x90, v19
	v_or_b32_e32 v19, 0x98, v19
	s_sub_i32 s10, s52, s10
	v_mov_b32_e32 v38, 0
	v_lshlrev_b32_e32 v54, 8, v1
	v_lshl_or_b32 v18, v52, 8, v18
	v_xor_b32_e32 v19, v19, v20
	s_mov_b32 s0, s4
	s_lshl_b32 s4, s53, 3
	s_lshl_b32 s10, s10, 3
	v_and_b32_e32 v57, 63, v0
	s_mov_b32 s11, 0x8080808
	s_mov_b32 s36, 0x5010400
	s_mov_b32 s40, 0x7030602
	s_mov_b32 s3, s39
	s_mov_b32 s27, s39
	s_mov_b32 s31, s39
	v_mov_b32_e32 v39, v38
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v38
	v_mov_b32_e32 v26, v38
	v_mov_b32_e32 v27, v38
	v_mov_b32_e32 v28, v38
	v_mov_b32_e32 v29, v38
	v_mov_b32_e32 v42, v38
	v_mov_b32_e32 v43, v38
	v_mov_b32_e32 v44, v38
	v_mov_b32_e32 v45, v38
	v_mov_b32_e32 v30, v38
	v_mov_b32_e32 v31, v38
	v_mov_b32_e32 v32, v38
	v_or_b32_e32 v69, 0x1000, v54
	v_lshrrev_b32_e32 v76, 2, v18
	v_xor_b32_e32 v66, v21, v20
	v_xor_b32_e32 v65, v22, v20
	v_xor_b32_e32 v64, v23, v20
	v_xor_b32_e32 v63, v24, v20
	v_xor_b32_e32 v62, v25, v20
	v_xor_b32_e32 v61, v33, v20
	v_or_b32_e32 v73, v54, v55
	v_or_b32_e32 v56, v54, v19
	s_mov_b32 s2, s38
	s_mov_b32 s1, s37
	s_add_i32 s8, s4, 16
	s_add_i32 s37, s10, 16
	v_mov_b32_e32 v33, v38
	s_waitcnt vmcnt(0)
	ds_write_b64 v18, v[34:35]
.LBB0_2:
	s_and_b32 s38, s35, 1
	s_add_i32 s35, s35, 1
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[20:21], v[4:5]
	v_mov_b64_e32 v[18:19], v[2:3]
	v_lshl_add_u32 v2, s35, 8, v72
	s_lshl_b32 s39, s35, 6
	s_lshl_b32 s41, s35, 7
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx2 v[94:95], v2, s[0:3], 0 offen nt
	v_add_lshl_u32 v2, s39, v68, 2
	v_add_lshl_u32 v3, s39, v71, 2
	v_add_lshl_u32 v4, s41, v67, 4
	v_add_lshl_u32 v5, s41, v70, 4
	v_mov_b64_e32 v[36:37], v[12:13]
	v_mov_b64_e32 v[34:35], v[10:11]
	v_mov_b64_e32 v[24:25], v[8:9]
	v_mov_b64_e32 v[22:23], v[6:7]
	v_mov_b64_e32 v[48:49], v[16:17]
	v_mov_b64_e32 v[46:47], v[14:15]
	v_bfe_u32 v77, v75, s4, 8
	v_bfe_u32 v78, v75, s8, 8
	v_bfe_u32 v81, v74, s10, 8
	v_bfe_u32 v82, v74, s37, 8
	buffer_load_dword v75, v2, s[28:31], 0 offen
	buffer_load_dword v74, v3, s[28:31], 0 offen
	buffer_load_dwordx4 v[14:17], v4, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v4, s[24:27], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[10:13], v5, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v5, s[24:27], 0 offen offset:1024 sc0
	v_sub_u32_e32 v77, v60, v77
	v_min_i32_e32 v79, 11, v77
	v_mul_lo_u32 v79, v79, s11
	v_sub_u32_e32 v80, 0x6c686080, v79
	v_and_b32_e32 v80, 0xffffff00, v80
	v_cmp_lt_i32_e32 vcc, 11, v77
	v_sub_u32_e32 v79, 0x7c787470, v79
	v_sub_u32_e32 v81, v59, v81
	v_cndmask_b32_e64 v85, v80, 0, vcc
	v_cndmask_b32_e64 v86, v79, 0, vcc
	v_add_u32_e32 v77, 0x7f7f7f00, v85
	v_and_b32_e32 v87, 0x80808000, v77
	v_add_u32_e32 v77, 0x7f7f7f78, v86
	v_and_b32_e32 v88, 0x80808080, v77
	v_sub_u32_e32 v77, v60, v78
	v_min_i32_e32 v78, 11, v77
	v_mul_lo_u32 v78, v78, s11
	v_min_i32_e32 v83, 11, v81
	v_sub_u32_e32 v79, 0x6c686080, v78
	v_mul_lo_u32 v83, v83, s11
	v_and_b32_e32 v79, 0xffffff00, v79
	v_sub_u32_e32 v78, 0x7c787470, v78
	v_cmp_lt_i32_e32 vcc, 11, v77
	v_sub_u32_e32 v84, 0x6c686080, v83
	v_and_b32_e32 v84, 0xffffff00, v84
	v_cndmask_b32_e64 v77, v79, 0, vcc
	v_cndmask_b32_e64 v78, v78, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v81
	v_and_b32_e32 v93, 0x7070707, v46
	v_lshrrev_b32_e32 v96, 4, v46
	v_sub_u32_e32 v83, 0x7c787470, v83
	v_cndmask_b32_e64 v89, v84, 0, vcc
	v_and_b32_e32 v96, 0x7070707, v96
	v_perm_b32 v97, v88, v87, v93
	v_lshlrev_b32_e32 v98, 4, v46
	v_perm_b32 v93, v86, v85, v93
	v_cndmask_b32_e64 v90, v83, 0, vcc
	v_add_u32_e32 v81, 0x7f7f7f00, v89
	v_and_or_b32 v93, v97, v98, v93
	v_perm_b32 v97, v88, v87, v96
	v_perm_b32 v96, v86, v85, v96
	v_and_b32_e32 v91, 0x80808000, v81
	v_add_u32_e32 v81, 0x7f7f7f78, v90
	v_and_or_b32 v46, v97, v46, v96
	v_and_b32_e32 v92, 0x80808080, v81
	v_perm_b32 v100, v46, v93, s36
	v_perm_b32 v101, v46, v93, s40
	v_and_b32_e32 v46, 0x7070707, v34
	v_lshrrev_b32_e32 v93, 4, v34
	v_and_b32_e32 v93, 0x7070707, v93
	v_perm_b32 v96, v92, v91, v46
	v_lshlrev_b32_e32 v97, 4, v34
	v_perm_b32 v46, v90, v89, v46
	v_and_or_b32 v46, v96, v97, v46
	v_perm_b32 v96, v92, v91, v93
	v_perm_b32 v93, v90, v89, v93
	v_and_or_b32 v34, v96, v34, v93
	s_lshl_b32 s39, s38, 13
	v_perm_b32 v102, v34, v46, s36
	v_perm_b32 v103, v34, v46, s40
	v_or_b32_e32 v34, s39, v73
	ds_read2st64_b64 v[96:99], v34 offset1:8
	v_and_b32_e32 v34, 0x7070707, v47
	v_lshrrev_b32_e32 v46, 4, v47
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[96:97], v[100:101], v[38:41]
	v_and_b32_e32 v46, 0x7070707, v46
	v_perm_b32 v93, v88, v87, v34
	v_perm_b32 v34, v86, v85, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[96:97], v[102:103], v[42:45]
	v_lshlrev_b32_e32 v96, 4, v47
	v_and_or_b32 v34, v93, v96, v34
	v_perm_b32 v93, v88, v87, v46
	v_perm_b32 v46, v86, v85, v46
	v_and_or_b32 v47, v93, v47, v46
	v_perm_b32 v46, v47, v34, s36
	v_perm_b32 v47, v47, v34, s40
	v_and_b32_e32 v34, 0x7070707, v35
	v_lshrrev_b32_e32 v93, 4, v35
	v_and_b32_e32 v93, 0x7070707, v93
	v_perm_b32 v96, v92, v91, v34
	v_lshlrev_b32_e32 v97, 4, v35
	v_perm_b32 v34, v90, v89, v34
	v_and_or_b32 v96, v96, v97, v34
	v_perm_b32 v34, v92, v91, v93
	v_perm_b32 v93, v90, v89, v93
	v_and_or_b32 v35, v34, v35, v93
	v_or_b32_e32 v93, s39, v66
	v_perm_b32 v34, v35, v96, s36
	v_perm_b32 v35, v35, v96, s40
	v_or_b32_e32 v96, v93, v54
	ds_read_b64 v[96:97], v96
	v_or_b32_e32 v93, v93, v69
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[96:97], v[46:47], v[38:41]
	v_sub_u32_e32 v81, v59, v82
	v_min_i32_e32 v82, 11, v81
	v_add_u32_e32 v79, 0x7f7f7f00, v77
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[96:97], v[34:35], v[42:45]
	ds_read_b64 v[96:97], v93
	v_lshlrev_b32_e32 v93, 4, v36
	v_add_u32_e32 v80, 0x7f7f7f78, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[98:99], v[102:103], v[30:33]
	v_mul_lo_u32 v82, v82, s11
	v_and_b32_e32 v79, 0x80808000, v79
	v_and_b32_e32 v80, 0x80808080, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[100:101], v[26:29]
	v_sub_u32_e32 v83, 0x6c686080, v82
	v_and_b32_e32 v83, 0xffffff00, v83
	v_sub_u32_e32 v82, 0x7c787470, v82
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[96:97], v[34:35], v[30:33]
	v_and_b32_e32 v34, 0x7070707, v48
	v_lshrrev_b32_e32 v35, 4, v48
	v_and_b32_e32 v35, 0x7070707, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[96:97], v[46:47], v[26:29]
	v_perm_b32 v46, v88, v87, v34
	v_lshlrev_b32_e32 v47, 4, v48
	v_perm_b32 v34, v86, v85, v34
	v_and_or_b32 v46, v46, v47, v34
	v_perm_b32 v34, v88, v87, v35
	v_perm_b32 v35, v86, v85, v35
	v_and_or_b32 v35, v34, v48, v35
	v_perm_b32 v34, v35, v46, s36
	v_perm_b32 v35, v35, v46, s40
	v_and_b32_e32 v46, 0x7070707, v36
	v_lshrrev_b32_e32 v47, 4, v36
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v92, v91, v46
	v_perm_b32 v46, v90, v89, v46
	v_and_or_b32 v48, v48, v93, v46
	v_perm_b32 v46, v92, v91, v47
	v_perm_b32 v47, v90, v89, v47
	v_and_or_b32 v36, v46, v36, v47
	v_perm_b32 v46, v36, v48, s36
	v_perm_b32 v47, v36, v48, s40
	v_or_b32_e32 v36, s39, v65
	v_or_b32_e32 v48, v36, v54
	ds_read_b64 v[96:97], v48
	v_or_b32_e32 v36, v36, v69
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[96:97], v[34:35], v[38:41]
	v_lshlrev_b32_e32 v48, 4, v37
	v_cmp_lt_i32_e32 vcc, 11, v81
	s_cmp_lg_u32 s35, 15
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[96:97], v[46:47], v[42:45]
	ds_read_b64 v[96:97], v36
	v_cndmask_b32_e64 v81, v83, 0, vcc
	v_cndmask_b32_e64 v82, v82, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[96:97], v[34:35], v[26:29]
	v_and_b32_e32 v34, 0x7070707, v49
	v_lshrrev_b32_e32 v35, 4, v49
	v_and_b32_e32 v35, 0x7070707, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[96:97], v[46:47], v[30:33]
	v_perm_b32 v36, v88, v87, v34
	v_lshlrev_b32_e32 v46, 4, v49
	v_perm_b32 v34, v86, v85, v34
	v_and_or_b32 v34, v36, v46, v34
	v_perm_b32 v36, v88, v87, v35
	v_perm_b32 v35, v86, v85, v35
	v_and_or_b32 v35, v36, v49, v35
	v_perm_b32 v46, v35, v34, s36
	v_perm_b32 v47, v35, v34, s40
	v_and_b32_e32 v34, 0x7070707, v37
	v_lshrrev_b32_e32 v35, 4, v37
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v92, v91, v34
	v_perm_b32 v34, v90, v89, v34
	v_and_or_b32 v34, v36, v48, v34
	v_perm_b32 v36, v92, v91, v35
	v_perm_b32 v35, v90, v89, v35
	v_and_or_b32 v35, v36, v37, v35
	v_or_b32_e32 v85, s39, v64
	v_perm_b32 v48, v35, v34, s36
	v_perm_b32 v49, v35, v34, s40
	v_or_b32_e32 v34, v85, v54
	ds_read_b64 v[86:87], v34
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[86:87], v[46:47], v[38:41]
	v_add_u32_e32 v83, 0x7f7f7f00, v81
	v_add_u32_e32 v84, 0x7f7f7f78, v82
	v_and_b32_e32 v83, 0x80808000, v83
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[86:87], v[48:49], v[42:45]
	v_and_b32_e32 v84, 0x80808080, v84
	s_nop 1
	v_or_b32_e32 v42, v85, v69
	ds_read_b64 v[42:43], v42
	v_lshlrev_b32_e32 v45, 4, v22
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[42:43], v[46:47], v[26:29]
	v_lshlrev_b32_e32 v46, 4, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[42:43], v[48:49], v[30:33]
	v_and_b32_e32 v42, 0x7070707, v22
	v_lshrrev_b32_e32 v43, 4, v22
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v80, v79, v42
	v_perm_b32 v42, v78, v77, v42
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v80, v79, v43
	v_perm_b32 v43, v78, v77, v43
	v_and_or_b32 v22, v42, v22, v43
	v_perm_b32 v42, v22, v44, s36
	v_perm_b32 v43, v22, v44, s40
	v_and_b32_e32 v22, 0x7070707, v18
	v_lshrrev_b32_e32 v44, 4, v18
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v84, v83, v22
	v_perm_b32 v22, v82, v81, v22
	v_and_or_b32 v22, v45, v46, v22
	v_perm_b32 v45, v84, v83, v44
	v_perm_b32 v44, v82, v81, v44
	v_and_or_b32 v18, v45, v18, v44
	v_perm_b32 v44, v18, v22, s36
	v_perm_b32 v45, v18, v22, s40
	v_or_b32_e32 v18, s39, v63
	v_or_b32_e32 v22, v18, v54
	ds_read_b64 v[46:47], v22
	v_or_b32_e32 v18, v18, v69
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[46:47], v[42:43], v[34:37]
	v_lshrrev_b32_e32 v22, 4, v23
	v_and_b32_e32 v22, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[46:47], v[44:45], v[38:41]
	ds_read_b64 v[46:47], v18
	v_and_b32_e32 v18, 0x7070707, v23
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[46:47], v[42:43], v[26:29]
	v_perm_b32 v42, v80, v79, v18
	v_lshlrev_b32_e32 v43, 4, v23
	v_perm_b32 v18, v78, v77, v18
	v_and_or_b32 v18, v42, v43, v18
	v_perm_b32 v42, v80, v79, v22
	v_perm_b32 v22, v78, v77, v22
	v_and_or_b32 v23, v42, v23, v22
	v_perm_b32 v22, v23, v18, s36
	v_perm_b32 v23, v23, v18, s40
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v42, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[46:47], v[44:45], v[30:33]
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v84, v83, v18
	v_lshlrev_b32_e32 v44, 4, v19
	v_perm_b32 v18, v82, v81, v18
	v_and_or_b32 v43, v43, v44, v18
	v_perm_b32 v18, v84, v83, v42
	v_perm_b32 v42, v82, v81, v42
	v_or_b32_e32 v46, s39, v62
	v_and_or_b32 v19, v18, v19, v42
	v_or_b32_e32 v42, v46, v54
	v_perm_b32 v18, v19, v43, s36
	v_perm_b32 v19, v19, v43, s40
	ds_read_b64 v[42:43], v42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[42:43], v[22:23], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[42:43], v[18:19], v[38:41]
	s_nop 2
	v_or_b32_e32 v38, v46, v69
	ds_read_b64 v[38:39], v38
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[38:39], v[18:19], v[30:33]
	v_and_b32_e32 v18, 0x7070707, v24
	v_lshrrev_b32_e32 v19, 4, v24
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[38:39], v[22:23], v[26:29]
	v_perm_b32 v22, v80, v79, v18
	v_lshlrev_b32_e32 v23, 4, v24
	v_perm_b32 v18, v78, v77, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v80, v79, v19
	v_perm_b32 v19, v78, v77, v19
	v_and_or_b32 v19, v18, v24, v19
	v_perm_b32 v18, v19, v22, s36
	v_perm_b32 v19, v19, v22, s40
	v_and_b32_e32 v22, 0x7070707, v20
	v_lshrrev_b32_e32 v23, 4, v20
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v84, v83, v22
	v_lshlrev_b32_e32 v26, 4, v20
	v_perm_b32 v22, v82, v81, v22
	v_and_or_b32 v24, v24, v26, v22
	v_perm_b32 v22, v84, v83, v23
	v_perm_b32 v23, v82, v81, v23
	v_and_or_b32 v20, v22, v20, v23
	v_perm_b32 v22, v20, v24, s36
	v_perm_b32 v23, v20, v24, s40
	v_or_b32_e32 v20, s39, v61
	v_or_b32_e32 v24, v20, v54
	ds_read_b64 v[26:27], v24
	v_or_b32_e32 v20, v20, v69
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[26:27], v[18:19], v[34:37]
	v_lshlrev_b32_e32 v24, 4, v21
	s_nop 1
	ds_read_b64 v[34:35], v20
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[34:35], v[18:19], v[46:49]
	v_and_b32_e32 v18, 0x7070707, v25
	v_lshrrev_b32_e32 v19, 4, v25
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[26:27], v[22:23], v[42:45]
	v_perm_b32 v20, v80, v79, v18
	v_perm_b32 v18, v78, v77, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[34:35], v[22:23], v[86:89]
	v_lshlrev_b32_e32 v22, 4, v25
	v_and_or_b32 v18, v20, v22, v18
	v_perm_b32 v20, v80, v79, v19
	v_perm_b32 v19, v78, v77, v19
	v_and_or_b32 v19, v20, v25, v19
	v_perm_b32 v22, v19, v18, s36
	v_perm_b32 v23, v19, v18, s40
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v84, v83, v18
	v_perm_b32 v18, v82, v81, v18
	v_and_or_b32 v18, v20, v24, v18
	v_perm_b32 v20, v84, v83, v19
	v_perm_b32 v19, v82, v81, v19
	v_and_or_b32 v19, v20, v21, v19
	v_perm_b32 v24, v19, v18, s36
	v_perm_b32 v25, v19, v18, s40
	v_or_b32_e32 v18, s39, v56
	ds_read2st64_b64 v[18:21], v18 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[18:19], v[22:23], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[18:19], v[24:25], v[26:29]
	v_lshl_or_b32 v18, s38, 11, v76
	v_xor_b32_e32 v18, 0x800, v18
	v_lshlrev_b32_e32 v18, 2, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[20:21], v[22:23], v[30:33]
	s_waitcnt vmcnt(6)
	ds_write_b64 v18, v[94:95]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[20:21], v[24:25], v[34:37]
	s_cbranch_scc1 .LBB0_2
	s_waitcnt vmcnt(5)
	v_bfe_u32 v18, v75, s4, 8
	v_sub_u32_e32 v18, v60, v18
	v_min_i32_e32 v20, 11, v18
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v20, v20, s40
	v_sub_u32_e32 v21, 0x6c686080, v20
	v_and_b32_e32 v21, 0xffffff00, v21
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v20, 0x7c787470, v20
	s_waitcnt vmcnt(4)
	v_bfe_u32 v19, v74, s10, 8
	v_cndmask_b32_e64 v48, v21, 0, vcc
	v_cndmask_b32_e64 v49, v20, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v48
	v_and_b32_e32 v67, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v49
	v_and_b32_e32 v68, 0x80808080, v18
	v_sub_u32_e32 v18, v59, v19
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s40
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_bfe_u32 v47, v74, s37, 8
	v_cndmask_b32_e64 v70, v20, 0, vcc
	v_cndmask_b32_e64 v71, v19, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v70
	v_and_b32_e32 v72, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v71
	v_and_b32_e32 v74, 0x80808080, v18
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v18, 0x7070707, v14
	v_lshrrev_b32_e32 v19, 4, v14
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v68, v67, v18
	v_lshlrev_b32_e32 v21, 4, v14
	v_perm_b32 v18, v49, v48, v18
	v_and_or_b32 v18, v20, v21, v18
	v_perm_b32 v20, v68, v67, v19
	v_perm_b32 v19, v49, v48, v19
	v_and_or_b32 v14, v20, v14, v19
	s_mov_b32 s41, 0x5010400
	s_mov_b32 s42, 0x7030602
	v_perm_b32 v34, v14, v18, s41
	v_perm_b32 v35, v14, v18, s42
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v18, 4, v10
	v_and_b32_e32 v18, 0x7070707, v18
	v_perm_b32 v22, v74, v72, v18
	v_perm_b32 v23, v71, v70, v18
	v_or_b32_e32 v18, v55, v69
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[24:25], v73 offset:8192
	ds_read_b64 v[76:77], v18 offset:8192
	v_and_b32_e32 v14, 0x7070707, v10
	v_bfe_u32 v46, v75, s8, 8
	v_perm_b32 v19, v74, v72, v14
	v_lshlrev_b32_e32 v20, 4, v10
	v_perm_b32 v14, v71, v70, v14
	v_and_or_b32 v14, v19, v20, v14
	v_and_or_b32 v10, v22, v10, v23
	v_sub_u32_e32 v46, v60, v46
	v_perm_b32 v36, v10, v14, s41
	v_perm_b32 v37, v10, v14, s42
	v_min_i32_e32 v10, 11, v46
	v_mul_lo_u32 v10, v10, s40
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[24:25], v[34:35], v[38:41]
	v_sub_u32_e32 v14, 0x6c686080, v10
	v_cmp_lt_i32_e32 vcc, 11, v46
	s_ashr_i32 s35, s34, 31
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[76:77], v[36:37], v[30:33]
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	s_mov_b32 s3, 0x27000
	v_add_u32_e32 v32, v54, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[36:37], v[42:45]
	v_lshlrev_b32_e32 v31, 4, v15
	v_lshlrev_b32_e32 v33, 4, v11
	s_mov_b32 s0, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[76:77], v[34:35], v[26:29]
	v_and_b32_e32 v34, 0xffffff00, v14
	v_sub_u32_e32 v35, 0x7c787470, v10
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v14, 4, v15
	ds_read2st64_b64 v[42:45], v32 offset0:16 offset1:24
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v30, v68, v67, v10
	v_perm_b32 v10, v49, v48, v10
	v_and_or_b32 v10, v30, v31, v10
	v_perm_b32 v30, v68, v67, v14
	v_perm_b32 v14, v49, v48, v14
	v_and_or_b32 v15, v30, v15, v14
	v_perm_b32 v14, v15, v10, s41
	v_perm_b32 v15, v15, v10, s42
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v30, 4, v11
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v74, v72, v10
	v_perm_b32 v10, v71, v70, v10
	v_and_or_b32 v31, v31, v33, v10
	v_perm_b32 v10, v74, v72, v30
	v_perm_b32 v30, v71, v70, v30
	v_and_or_b32 v11, v10, v11, v30
	v_perm_b32 v10, v11, v31, s41
	v_perm_b32 v11, v11, v31, s42
	v_cndmask_b32_e64 v35, v35, 0, vcc
	v_add_u32_e32 v33, v54, v65
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[14:15], v[18:21]
	v_cndmask_b32_e64 v34, v34, 0, vcc
	v_add_u32_e32 v30, 0x7f7f7f00, v34
	v_and_b32_e32 v36, 0x80808000, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[10:11], v[22:25]
	v_lshlrev_b32_e32 v30, 4, v12
	v_mov_b32_e32 v82, 0xfd800000
	s_mov_b32 s4, 0x43700000
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[44:45], v[14:15], v[26:29]
	v_add_u32_e32 v14, 0x7f7f7f78, v35
	v_and_b32_e32 v37, 0x80808080, v14
	v_lshlrev_b32_e32 v15, 4, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[44:45], v[10:11], v[38:41]
	v_and_b32_e32 v10, 0x7070707, v16
	v_lshrrev_b32_e32 v11, 4, v16
	ds_read2st64_b64 v[42:45], v33 offset0:16 offset1:24
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v14, v68, v67, v10
	v_perm_b32 v10, v49, v48, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v68, v67, v11
	v_perm_b32 v11, v49, v48, v11
	v_and_or_b32 v11, v10, v16, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v14, 0x7070707, v12
	v_lshrrev_b32_e32 v15, 4, v12
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v74, v72, v14
	v_perm_b32 v14, v71, v70, v14
	v_and_or_b32 v16, v16, v30, v14
	v_perm_b32 v14, v74, v72, v15
	v_perm_b32 v15, v71, v70, v15
	v_and_or_b32 v12, v14, v12, v15
	v_perm_b32 v14, v12, v16, s41
	v_perm_b32 v15, v12, v16, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[10:11], v[18:21]
	s_and_b32 s25, s23, 0xffff
	s_mov_b32 s26, -1
	s_mov_b32 s24, s22
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[14:15], v[22:25]
	v_sub_u32_e32 v43, v59, v47
	v_min_i32_e32 v12, 11, v43
	v_mul_lo_u32 v12, v12, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[44:45], v[10:11], v[26:29]
	v_sub_u32_e32 v10, 0x6c686080, v12
	v_and_b32_e32 v65, 0xffffff00, v10
	v_and_b32_e32 v10, 0x7070707, v17
	v_lshrrev_b32_e32 v11, 4, v17
	v_sub_u32_e32 v66, 0x7c787470, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[44:45], v[14:15], v[38:41]
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v68, v67, v10
	v_lshlrev_b32_e32 v14, 4, v17
	v_perm_b32 v10, v49, v48, v10
	v_and_or_b32 v10, v12, v14, v10
	v_perm_b32 v12, v68, v67, v11
	v_perm_b32 v11, v49, v48, v11
	v_add_u32_e32 v42, v54, v64
	v_and_or_b32 v11, v12, v17, v11
	ds_read2st64_b64 v[14:17], v42 offset0:16 offset1:24
	v_perm_b32 v30, v11, v10, s41
	v_perm_b32 v31, v11, v10, s42
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v74, v72, v10
	v_lshlrev_b32_e32 v38, 4, v13
	v_perm_b32 v10, v71, v70, v10
	v_and_or_b32 v10, v12, v38, v10
	v_perm_b32 v12, v74, v72, v11
	v_perm_b32 v11, v71, v70, v11
	v_and_or_b32 v11, v12, v13, v11
	v_perm_b32 v48, v11, v10, s41
	v_perm_b32 v49, v11, v10, s42
	v_cmp_lt_i32_e32 vcc, 11, v43
	v_add_u32_e32 v43, v54, v63
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[14:15], v[48:49], v[22:25]
	v_cndmask_b32_e64 v38, v65, 0, vcc
	v_cndmask_b32_e64 v39, v66, 0, vcc
	v_cmp_lt_i32_e32 vcc, 5, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[16:17], v[30:31], v[26:29]
	s_mov_b32 s27, s3
	s_mov_b32 s6, 0x400000
	s_mov_b32 s28, s14
	v_and_b32_e32 v26, 0x7070707, v6
	v_lshrrev_b32_e32 v27, 4, v6
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v37, v36, v26
	v_lshlrev_b32_e32 v29, 4, v6
	v_perm_b32 v26, v35, v34, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v37, v36, v27
	v_perm_b32 v27, v35, v34, v27
	v_and_or_b32 v6, v28, v6, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[14:15], v[30:31], v[18:21]
	v_perm_b32 v30, v6, v26, s41
	v_perm_b32 v31, v6, v26, s42
	ds_read2st64_b64 v[26:29], v43 offset0:16 offset1:24
	v_add_u32_e32 v14, 0x7f7f7f00, v38
	v_and_b32_e32 v40, 0x80808000, v14
	v_add_u32_e32 v14, 0x7f7f7f78, v39
	v_and_b32_e32 v41, 0x80808080, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[48:49], v[44:47]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v6, 0x7070707, v2
	s_mov_b32 s31, s3
	s_mov_b32 s44, s18
	v_lshrrev_b32_e32 v44, 4, v2
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v41, v40, v6
	v_lshlrev_b32_e32 v46, 4, v2
	v_perm_b32 v6, v39, v38, v6
	v_and_or_b32 v6, v45, v46, v6
	v_perm_b32 v45, v41, v40, v44
	v_perm_b32 v44, v39, v38, v44
	v_and_or_b32 v2, v45, v2, v44
	v_perm_b32 v44, v2, v6, s41
	v_perm_b32 v45, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[26:27], v[30:31], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v6
	s_mov_b32 s46, s6
	s_mov_b32 s47, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[26:27], v[44:45], v[10:13]
	v_perm_b32 v26, v37, v36, v2
	v_lshlrev_b32_e32 v27, 4, v7
	v_perm_b32 v2, v35, v34, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[28:29], v[44:45], v[14:17]
	v_and_or_b32 v2, v26, v27, v2
	v_perm_b32 v26, v37, v36, v6
	v_perm_b32 v6, v35, v34, v6
	v_add_u32_e32 v44, v54, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[28:29], v[30:31], v[22:25]
	v_and_or_b32 v7, v26, v7, v6
	ds_read2st64_b64 v[26:29], v44 offset0:16 offset1:24
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v30, 4, v3
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v41, v40, v2
	v_lshlrev_b32_e32 v45, 4, v3
	v_perm_b32 v2, v39, v38, v2
	v_and_or_b32 v31, v31, v45, v2
	v_perm_b32 v2, v41, v40, v30
	v_perm_b32 v30, v39, v38, v30
	v_and_or_b32 v3, v2, v3, v30
	v_perm_b32 v2, v3, v31, s41
	v_perm_b32 v3, v3, v31, s42
	v_add_u32_e32 v45, v54, v61
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[26:27], v[6:7], v[18:21]
	v_lshlrev_b32_e32 v30, 2, v53
	v_mov_b32_e32 v31, 0
	s_mov_b32 s10, 0x800000
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[2:3], v[10:13]
	s_mov_b32 s36, s16
	s_mov_b32 s38, s10
	s_mov_b32 s39, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[28:29], v[2:3], v[14:17]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[28:29], v[6:7], v[22:25]
	v_perm_b32 v6, v37, v36, v2
	v_lshlrev_b32_e32 v7, 4, v8
	v_perm_b32 v2, v35, v34, v2
	ds_read2st64_b64 v[20:23], v45 offset0:16 offset1:24
	v_and_or_b32 v2, v6, v7, v2
	v_perm_b32 v6, v37, v36, v3
	v_perm_b32 v3, v35, v34, v3
	v_and_or_b32 v3, v6, v8, v3
	v_perm_b32 v66, v3, v2, s41
	v_perm_b32 v67, v3, v2, s42
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v6, v41, v40, v2
	v_lshlrev_b32_e32 v7, 4, v4
	v_perm_b32 v2, v39, v38, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v41, v40, v3
	v_perm_b32 v3, v39, v38, v3
	v_or_b32_e32 v28, s34, v30
	v_and_or_b32 v3, v2, v4, v3
	v_ashrrev_i32_e32 v29, 31, v28
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_lshl_add_u64 v[6:7], v[28:29], 2, s[20:21]
	global_load_dword v4, v[6:7], off
	v_lshl_add_u64 v[6:7], s[34:35], 0, v[30:31]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[20:21], v[66:67], v[46:49]
	s_movk_i32 s35, 0x7fff
	s_mov_b32 s11, s3
	s_mov_b32 s8, s16
	v_lshl_add_u64 v[46:47], v[6:7], 2, s[20:21]
	global_load_dwordx3 v[6:8], v[46:47], off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[2:3], v[62:65]
	global_load_dwordx4 v[46:49], v[46:47], off offset:64
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[22:23], v[2:3], v[10:13]
	v_and_b32_e32 v2, 0x7070707, v9
	v_lshrrev_b32_e32 v3, 4, v9
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[22:23], v[66:67], v[24:27]
	v_perm_b32 v22, v37, v36, v2
	v_lshlrev_b32_e32 v23, 4, v9
	v_perm_b32 v2, v35, v34, v2
	v_and_or_b32 v29, v22, v23, v2
	s_and_b32 s21, s21, 0xffff
	v_lshlrev_b32_e32 v85, 2, v50
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v2, 2, v4
	v_and_b32_e32 v2, 0x3fffffc, v2
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v4, 2, v6
	v_and_b32_e32 v4, 0x3fffffc, v4
	buffer_load_dword v22, v2, s[0:3], 0 offen
	buffer_load_dword v23, v4, s[0:3], 0 offen
	v_perm_b32 v2, v37, v36, v3
	v_perm_b32 v3, v35, v34, v3
	ds_read2st64_b64 v[34:37], v56 offset0:16 offset1:24
	v_and_or_b32 v3, v2, v9, v3
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshrrev_b32_e32 v6, 4, v5
	v_perm_b32 v2, v3, v29, s41
	v_perm_b32 v3, v3, v29, s42
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v9, v41, v40, v4
	v_lshlrev_b32_e32 v29, 4, v5
	v_perm_b32 v4, v39, v38, v4
	v_and_or_b32 v9, v9, v29, v4
	v_perm_b32 v4, v41, v40, v6
	v_perm_b32 v6, v39, v38, v6
	v_and_or_b32 v5, v4, v5, v6
	v_lshlrev_b32_e32 v6, 2, v7
	v_perm_b32 v4, v5, v9, s41
	v_perm_b32 v5, v5, v9, s42
	v_and_b32_e32 v6, 0x3fffffc, v6
	v_lshlrev_b32_e32 v7, 2, v8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[34:35], v[2:3], v[14:17]
	v_and_b32_e32 v7, 0x3fffffc, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[34:35], v[4:5], v[18:21]
	buffer_load_dword v34, v6, s[0:3], 0 offen
	buffer_load_dword v35, v7, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[36:37], v[2:3], v[24:27]
	s_waitcnt vmcnt(4)
	v_lshlrev_b32_e32 v2, 2, v46
	v_and_b32_e32 v2, 0x3fffffc, v2
	v_lshlrev_b32_e32 v3, 2, v47
	v_and_b32_e32 v3, 0x3fffffc, v3
	buffer_load_dword v24, v2, s[0:3], 0 offen
	buffer_load_dword v25, v3, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[36:37], v[4:5], v[10:13]
	v_lshlrev_b32_e32 v26, 2, v49
	v_and_b32_e32 v29, 0x3fffffc, v26
	v_lshlrev_b32_e32 v46, 11, v53
	v_lshlrev_b32_e32 v13, 2, v48
	v_and_b32_e32 v13, 0x3fffffc, v13
	buffer_load_dword v26, v13, s[0:3], 0 offen
	buffer_load_dword v27, v29, s[0:3], 0 offen
	v_add_u32_e32 v11, 17, v60
	v_lshl_add_u32 v10, v60, 23, v82
	v_lshlrev_b32_e64 v11, v11, 1
	v_cndmask_b32_e32 v12, v11, v10, vcc
	v_add_u32_e32 v11, 17, v59
	v_lshl_add_u32 v10, v59, 23, v82
	v_lshlrev_b32_e64 v11, v11, 1
	v_cmp_lt_i32_e32 vcc, 5, v59
	s_mov_b32 s0, 0xbfb8aa3b
	v_or_b32_e32 v47, 0x4000, v46
	v_cndmask_b32_e32 v36, v11, v10, vcc
	s_lshl_b32 s2, s48, 8
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[10:11], v[12:13], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[14:15], v[10:11]
	v_pk_mul_f32 v[22:23], v[36:37], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[18:19], v[18:19], v[22:23]
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_lshlrev_b32_e32 v13, 1, v58
	v_add_u32_e32 v29, v47, v13
	v_pk_add_f32 v[10:11], v[10:11], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v38, v10
	v_rcp_f32_e32 v39, v11
	v_or_b32_e32 v10, 1, v30
	v_pk_mul_f32 v[14:15], v[14:15], v[38:39]
	s_nop 0
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	s_nop 0
	v_bfe_u32 v11, v15, 16, 1
	v_add3_u32 v11, v11, v15, s35
	v_or_b32_e32 v18, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	v_bfe_u32 v15, v14, 16, 1
	v_add3_u32 v15, v15, v14, s35
	v_cndmask_b32_e32 v11, v11, v18, vcc
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[18:19], v[12:13], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[16:17], v[18:19]
	v_or_b32_e32 v22, 0x400000, v14
	v_pk_mul_f32 v[18:19], v[16:17], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v14, v14
	v_exp_f32_e32 v18, v18
	v_exp_f32_e32 v19, v19
	v_cndmask_b32_e32 v14, v15, v22, vcc
	ds_write_b16_d16_hi v29, v14
	v_lshl_add_u32 v13, v10, 9, v13
	v_pk_add_f32 v[14:15], v[18:19], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[18:19], v[36:37], v[34:35] op_sel_hi:[0,1]
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_pk_mul_f32 v[18:19], v[20:21], v[18:19]
	ds_write_b16_d16_hi v13, v11 offset:16384
	v_pk_mul_f32 v[14:15], v[16:17], v[14:15]
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
	v_pk_mul_f32 v[16:17], v[36:37], v[24:25] op_sel_hi:[0,1]
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
	v_pk_mul_f32 v[8:9], v[36:37], v[26:27] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_mov_b32_e32 v8, 0x7fc00000
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_lshlrev_b32_e32 v7, 2, v57
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
	s_and_b32 s0, s9, 0xf0
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	ds_write_b32 v12, v11 offset:8192
	s_and_b32 s9, s17, 0xffff
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_lshl_b32 s17, s5, 12
	s_and_b32 s5, s19, 0xffff
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_mov_b32 s45, s5
	s_mov_b32 s37, s9
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_mov_b32 s19, 0
	s_nop 0
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
	v_lshl_or_b32 v2, v57, 3, s0
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
	s_and_b32 s1, s15, 0xffff
	s_lshl_b32 s15, s48, 5
	s_add_i32 s17, s17, s15
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
	ds_write_b32 v12, v9 offset:8256
	s_lshl_b32 s0, s17, 1
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	s_ashr_i32 s4, s17, 31
	s_lshr_b32 s7, s4, 27
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_mov_b32 s29, s1
	s_or_b32 s16, s17, 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_cvt_pk_fp8_f32 v31, v2, v3
	s_nop 0
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
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
	buffer_load_dword v78, v3, s[24:27], 0 offen
	buffer_load_dword v79, v2, s[24:27], 0 offen
	buffer_load_dword v80, v4, s[24:27], 0 offen
	buffer_load_dword v81, v5, s[24:27], 0 offen
	buffer_load_dword v74, v6, s[24:27], 0 offen
	buffer_load_dword v75, v7, s[24:27], 0 offen
	buffer_load_dword v76, v8, s[24:27], 0 offen
	buffer_load_dword v77, v9, s[24:27], 0 offen
	v_or3_b32 v3, s0, v51, v1
	s_lshl_b32 s0, s17, 3
	v_or3_b32 v4, s0, v51, v1
	s_or_b32 s0, s17, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_or_b32_e32 v2, s17, v1
	v_lshlrev_b32_e32 v4, 4, v4
	s_add_i32 s7, s7, s4
	v_lshlrev_b32_e32 v2, 2, v2
	buffer_load_dwordx4 v[70:73], v4, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[66:69], v4, s[28:31], 0 offen offset:1024 nt
	v_or_b32_e32 v4, s0, v1
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dword v101, v2, s[44:47], 0 offen
	buffer_load_dword v100, v4, s[44:47], 0 offen
	v_or3_b32 v2, s4, v51, v1
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s0, 3
	buffer_load_dword v102, v3, s[36:39], 0 offen
	buffer_load_dword v95, v2, s[36:39], 0 offen
	v_or3_b32 v2, s0, v51, v1
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[62:65], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[58:61], v3, s[28:31], 0 offen nt
	v_add_u32_e32 v2, v54, v55
	ds_read2st64_b64 v[38:41], v2 offset1:8
	ds_read2st64_b64 v[34:37], v32 offset1:8
	ds_read2st64_b64 v[30:33], v33 offset1:8
	ds_read2st64_b64 v[26:29], v42 offset1:8
	ds_read2st64_b64 v[22:25], v43 offset1:8
	ds_read2st64_b64 v[18:21], v44 offset1:8
	ds_read2st64_b64 v[14:17], v45 offset1:8
	ds_read2st64_b64 v[10:13], v56 offset1:8
	v_lshlrev_b32_e32 v2, 4, v53
	v_or_b32_e32 v42, s15, v1
	ds_read_b128 v[6:9], v2 offset:8192
	ds_read_b128 v[2:5], v2 offset:8256
	v_lshlrev_b32_e32 v42, 1, v42
	v_add3_u32 v90, v47, v46, v42
	v_lshlrev_b32_e32 v42, 1, v0
	v_and_b32_e32 v96, 62, v42
	v_mov_b32_e32 v42, 0x4000
	v_lshl_add_u32 v84, v52, 10, v42
	v_lshlrev_b32_e32 v42, 2, v0
	v_lshlrev_b32_e32 v0, 4, v0
	s_mov_b32 s0, s14
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_add_i32 s18, s17, 0x200
	v_add_u32_e32 v91, 0x400, v90
	v_add_u32_e32 v92, 0x800, v90
	v_add_u32_e32 v93, 0xc00, v90
	v_add_u32_e32 v86, 0x4000, v90
	v_add_u32_e32 v87, 0x4400, v90
	v_add_u32_e32 v88, 0x4800, v90
	v_add_u32_e32 v89, 0x4c00, v90
	v_lshlrev_b32_e32 v83, 1, v96
	v_and_b32_e32 v97, 0xfc, v42
	v_and_b32_e32 v98, 0x3f0, v0
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[14:15]
	s_add_i32 s19, s19, 1
	s_cmp_lg_u32 s19, 7
	v_mov_b64_e32 v[72:73], v[56:57]
	v_mov_b64_e32 v[70:71], v[54:55]
	v_mov_b64_e32 v[68:69], v[52:53]
	v_mov_b64_e32 v[66:67], v[50:51]
	v_mov_b64_e32 v[64:65], v[48:49]
	v_mov_b64_e32 v[62:63], v[46:47]
	v_mov_b64_e32 v[60:61], v[44:45]
	v_mov_b64_e32 v[58:59], v[42:43]
	v_mov_b32_e32 v100, v0
	v_mov_b32_e32 v101, v94
	v_mov_b32_e32 v102, v99
	s_barrier
	s_cbranch_scc0 .LBB0_7
.LBB0_5:
	s_lshl_b32 s24, s19, 9
	s_add_i32 s14, s16, s24
	s_lshr_b32 s15, s14, 31
	s_add_i32 s15, s14, s15
	s_and_b32 s15, s15, 0x1ffffffe
	s_sub_i32 s14, s14, s15
	s_lshl_b32 s14, s14, 3
	s_waitcnt vmcnt(2)
	v_bfe_u32 v112, v95, s14, 8
	s_add_i32 s14, s14, 16
	v_bfe_u32 v113, v95, s14, 8
	s_add_i32 s14, s18, s24
	v_or_b32_e32 v0, s14, v1
	v_lshl_or_b32 v42, s14, 3, v97
	v_lshl_or_b32 v43, s14, 7, v98
	s_or_b32 s15, s14, 16
	s_ashr_i32 s14, s14, 31
	s_lshr_b32 s25, s14, 27
	s_add_i32 s25, s15, s25
	buffer_load_dwordx4 v[54:57], v43, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[50:53], v43, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v43, s15, v1
	s_lshr_b32 s25, s25, 5
	v_lshlrev_b32_e32 v0, 2, v0
	v_lshlrev_b32_e32 v43, 2, v43
	s_add_i32 s25, s25, s14
	buffer_load_dword v94, v0, s[4:7], 0 offen
	s_nop 0
	buffer_load_dword v0, v43, s[4:7], 0 offen
	v_lshl_or_b32 v43, s25, 8, v97
	buffer_load_dword v99, v42, s[8:11], 0 offen
	buffer_load_dword v95, v43, s[8:11], 0 offen
	v_lshl_or_b32 v42, s15, 7, v98
	buffer_load_dwordx4 v[46:49], v42, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[42:45], v42, s[0:3], 0 offen offset:1024 nt
	v_sub_u32_sdwa v103, v101, v102 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v104, 11, v103
	v_mul_lo_u32 v104, v104, s40
	v_sub_u32_e32 v105, 0x6c686080, v104
	v_and_b32_e32 v105, 0xffffff00, v105
	v_cmp_lt_i32_e32 vcc, 11, v103
	v_sub_u32_e32 v104, 0x7c787470, v104
	v_lshlrev_b32_e32 v106, 4, v70
	v_cndmask_b32_e64 v114, v105, 0, vcc
	v_cndmask_b32_e64 v115, v104, 0, vcc
	v_add_u32_e32 v103, 0x7f7f7f00, v114
	v_and_b32_e32 v116, 0x80808000, v103
	v_add_u32_e32 v103, 0x7f7f7f78, v115
	v_and_b32_e32 v117, 0x80808080, v103
	v_and_b32_e32 v103, 0x7070707, v70
	v_lshrrev_b32_e32 v104, 4, v70
	v_and_b32_e32 v104, 0x7070707, v104
	v_perm_b32 v105, v117, v116, v103
	v_perm_b32 v103, v115, v114, v103
	v_and_or_b32 v103, v105, v106, v103
	v_perm_b32 v105, v117, v116, v104
	v_perm_b32 v104, v115, v114, v104
	v_and_or_b32 v70, v105, v70, v104
	v_sub_u32_sdwa v118, v101, v102 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v108, v70, v103, s41
	v_perm_b32 v109, v70, v103, s42
	v_min_i32_e32 v70, 11, v118
	v_mul_lo_u32 v119, v70, s40
	v_and_b32_e32 v70, 0x7070707, v71
	v_lshrrev_b32_e32 v102, 4, v71
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[38:39], v[108:109], 0
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v103, v117, v116, v70
	v_lshlrev_b32_e32 v120, 4, v71
	v_perm_b32 v70, v115, v114, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[108:111], v[40:41], v[108:109], 0
	v_and_or_b32 v103, v103, v120, v70
	v_perm_b32 v70, v117, v116, v102
	v_perm_b32 v102, v115, v114, v102
	v_and_or_b32 v71, v70, v71, v102
	v_perm_b32 v70, v71, v103, s41
	v_perm_b32 v71, v71, v103, s42
	v_cmp_lt_i32_e32 vcc, 11, v118
	v_sub_u32_e32 v113, v100, v113
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[34:35], v[70:71], v[104:107]
	s_nop 2
	v_sub_u32_e32 v106, 0x6c686080, v119
	v_and_b32_e32 v120, 0xffffff00, v106
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[36:37], v[70:71], v[108:111]
	v_and_b32_e32 v70, 0x7070707, v72
	v_lshrrev_b32_e32 v71, 4, v72
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v110, v117, v116, v70
	v_lshlrev_b32_e32 v111, 4, v72
	v_perm_b32 v70, v115, v114, v70
	v_and_or_b32 v110, v110, v111, v70
	v_perm_b32 v70, v117, v116, v71
	v_perm_b32 v71, v115, v114, v71
	v_and_or_b32 v71, v70, v72, v71
	v_perm_b32 v70, v71, v110, s41
	v_perm_b32 v71, v71, v110, s42
	v_lshlrev_b32_e32 v110, 4, v73
	v_sub_u32_e32 v119, 0x7c787470, v119
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[30:31], v[70:71], v[102:105]
	v_cndmask_b32_e64 v118, v120, 0, vcc
	v_cndmask_b32_e64 v119, v119, 0, vcc
	v_add_u32_e32 v120, 0x7f7f7f00, v118
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[32:33], v[70:71], v[106:109]
	v_and_b32_e32 v70, 0x7070707, v73
	v_lshrrev_b32_e32 v71, 4, v73
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v117, v116, v70
	v_perm_b32 v70, v115, v114, v70
	v_and_or_b32 v70, v72, v110, v70
	v_perm_b32 v72, v117, v116, v71
	v_perm_b32 v71, v115, v114, v71
	v_and_or_b32 v71, v72, v73, v71
	v_perm_b32 v110, v71, v70, s41
	v_perm_b32 v111, v71, v70, s42
	v_and_b32_e32 v114, 0x80808000, v120
	s_waitcnt vmcnt(9)
	v_lshrrev_b32_e32 v116, 4, v63
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[26:27], v[110:111], v[102:105]
	v_and_b32_e32 v116, 0x7070707, v116
	s_nop 1
	v_add_u32_e32 v102, 0x7f7f7f78, v119
	v_and_b32_e32 v115, 0x80808080, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[28:29], v[110:111], v[106:109]
	s_nop 2
	v_and_b32_e32 v106, 0x7070707, v66
	v_lshrrev_b32_e32 v107, 4, v66
	v_and_b32_e32 v107, 0x7070707, v107
	v_perm_b32 v108, v115, v114, v106
	v_lshlrev_b32_e32 v109, 4, v66
	v_perm_b32 v106, v119, v118, v106
	v_and_or_b32 v108, v108, v109, v106
	v_perm_b32 v106, v115, v114, v107
	v_perm_b32 v107, v119, v118, v107
	v_and_or_b32 v66, v106, v66, v107
	v_perm_b32 v106, v66, v108, s41
	v_perm_b32 v107, v66, v108, s42
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshlrev_b32_e32 v108, 4, v67
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[22:23], v[106:107], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[24:25], v[106:107], v[102:105]
	v_lshrrev_b32_e32 v106, 4, v67
	v_and_b32_e32 v106, 0x7070707, v106
	v_perm_b32 v107, v115, v114, v66
	v_perm_b32 v66, v119, v118, v66
	v_and_or_b32 v107, v107, v108, v66
	v_perm_b32 v66, v115, v114, v106
	v_perm_b32 v106, v119, v118, v106
	v_and_or_b32 v67, v66, v67, v106
	v_perm_b32 v66, v67, v107, s41
	v_perm_b32 v67, v67, v107, s42
	v_lshlrev_b32_e32 v107, 4, v68
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[18:19], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[20:21], v[66:67], v[102:105]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v106, v115, v114, v66
	v_perm_b32 v66, v119, v118, v66
	v_and_or_b32 v106, v106, v107, v66
	v_perm_b32 v66, v115, v114, v67
	v_perm_b32 v67, v119, v118, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v106, s41
	v_perm_b32 v67, v67, v106, s42
	v_lshlrev_b32_e32 v106, 4, v69
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[14:15], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[16:17], v[66:67], v[102:105]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v68, v115, v114, v66
	v_perm_b32 v66, v119, v118, v66
	v_and_or_b32 v68, v68, v106, v66
	v_perm_b32 v66, v115, v114, v67
	v_perm_b32 v67, v119, v118, v67
	v_and_or_b32 v67, v66, v69, v67
	v_perm_b32 v66, v67, v68, s41
	v_perm_b32 v67, v67, v68, s42
	v_lshlrev_b32_e32 v118, 4, v63
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[10:11], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[12:13], v[66:67], v[102:105]
	s_nop 2
	v_sub_u32_e32 v102, v100, v112
	v_min_i32_e32 v103, 11, v102
	v_mul_lo_u32 v103, v103, s40
	v_sub_u32_e32 v104, 0x6c686080, v103
	v_and_b32_e32 v104, 0xffffff00, v104
	v_cmp_lt_i32_e32 vcc, 11, v102
	v_sub_u32_e32 v103, 0x7c787470, v103
	v_lshlrev_b32_e32 v105, 4, v62
	v_cndmask_b32_e64 v110, v104, 0, vcc
	v_cndmask_b32_e64 v111, v103, 0, vcc
	v_add_u32_e32 v102, 0x7f7f7f00, v110
	v_and_b32_e32 v112, 0x80808000, v102
	v_add_u32_e32 v102, 0x7f7f7f78, v111
	v_and_b32_e32 v114, 0x80808080, v102
	v_and_b32_e32 v102, 0x7070707, v62
	v_lshrrev_b32_e32 v103, 4, v62
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v114, v112, v102
	v_perm_b32 v102, v111, v110, v102
	v_and_or_b32 v102, v104, v105, v102
	v_perm_b32 v104, v114, v112, v103
	v_perm_b32 v103, v111, v110, v103
	v_and_or_b32 v62, v104, v62, v103
	v_perm_b32 v106, v62, v102, s41
	v_perm_b32 v107, v62, v102, s42
	v_min_i32_e32 v62, 11, v113
	v_mul_lo_u32 v115, v62, s40
	v_and_b32_e32 v62, 0x7070707, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[38:39], v[106:107], 0
	v_perm_b32 v117, v114, v112, v62
	v_perm_b32 v62, v111, v110, v62
	v_and_or_b32 v117, v117, v118, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[40:41], v[106:107], 0
	v_perm_b32 v62, v114, v112, v116
	v_perm_b32 v116, v111, v110, v116
	v_and_or_b32 v63, v62, v63, v116
	v_perm_b32 v62, v63, v117, s41
	v_perm_b32 v63, v63, v117, s42
	v_lshlrev_b32_e32 v118, 4, v64
	v_sub_u32_e32 v116, 0x6c686080, v115
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[34:35], v[62:63], v[102:105]
	v_and_b32_e32 v116, 0xffffff00, v116
	v_sub_u32_e32 v115, 0x7c787470, v115
	v_cmp_lt_i32_e32 vcc, 11, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[36:37], v[62:63], v[106:109]
	v_and_b32_e32 v62, 0x7070707, v64
	v_lshrrev_b32_e32 v63, 4, v64
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v117, v114, v112, v62
	v_perm_b32 v62, v111, v110, v62
	v_and_or_b32 v117, v117, v118, v62
	v_perm_b32 v62, v114, v112, v63
	v_perm_b32 v63, v111, v110, v63
	v_and_or_b32 v63, v62, v64, v63
	v_perm_b32 v62, v63, v117, s41
	v_perm_b32 v63, v63, v117, s42
	v_lshlrev_b32_e32 v117, 4, v65
	v_cndmask_b32_e64 v113, v116, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[30:31], v[62:63], v[102:105]
	v_cndmask_b32_e64 v115, v115, 0, vcc
	v_add_u32_e32 v116, 0x7f7f7f00, v113
	v_cmp_lt_i32_e32 vcc, 5, v101
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[32:33], v[62:63], v[106:109]
	v_and_b32_e32 v62, 0x7070707, v65
	v_lshrrev_b32_e32 v63, 4, v65
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v114, v112, v62
	v_perm_b32 v62, v111, v110, v62
	v_and_or_b32 v62, v64, v117, v62
	v_perm_b32 v64, v114, v112, v63
	v_perm_b32 v63, v111, v110, v63
	v_and_or_b32 v63, v64, v65, v63
	v_perm_b32 v110, v63, v62, s41
	v_perm_b32 v111, v63, v62, s42
	v_and_b32_e32 v112, 0x80808000, v116
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[110:111], v[102:105]
	s_nop 2
	v_add_u32_e32 v102, 0x7f7f7f78, v115
	v_and_b32_e32 v114, 0x80808080, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[28:29], v[110:111], v[106:109]
	s_waitcnt vmcnt(8)
	s_nop 1
	v_and_b32_e32 v106, 0x7070707, v58
	v_lshrrev_b32_e32 v107, 4, v58
	v_and_b32_e32 v107, 0x7070707, v107
	v_perm_b32 v108, v114, v112, v106
	v_lshlrev_b32_e32 v109, 4, v58
	v_perm_b32 v106, v115, v113, v106
	v_and_or_b32 v108, v108, v109, v106
	v_perm_b32 v106, v114, v112, v107
	v_perm_b32 v107, v115, v113, v107
	v_and_or_b32 v58, v106, v58, v107
	v_perm_b32 v106, v58, v108, s41
	v_perm_b32 v107, v58, v108, s42
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshlrev_b32_e32 v108, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[22:23], v[106:107], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[24:25], v[106:107], v[102:105]
	v_lshrrev_b32_e32 v106, 4, v59
	v_and_b32_e32 v106, 0x7070707, v106
	v_perm_b32 v107, v114, v112, v58
	v_perm_b32 v58, v115, v113, v58
	v_and_or_b32 v107, v107, v108, v58
	v_perm_b32 v58, v114, v112, v106
	v_perm_b32 v106, v115, v113, v106
	v_and_or_b32 v59, v58, v59, v106
	v_perm_b32 v58, v59, v107, s41
	v_perm_b32 v59, v59, v107, s42
	v_lshlrev_b32_e32 v107, 4, v60
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[20:21], v[58:59], v[102:105]
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v106, v114, v112, v58
	v_perm_b32 v58, v115, v113, v58
	v_and_or_b32 v106, v106, v107, v58
	v_perm_b32 v58, v114, v112, v59
	v_perm_b32 v59, v115, v113, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v106, s41
	v_perm_b32 v59, v59, v106, s42
	v_lshlrev_b32_e32 v106, 4, v61
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[16:17], v[58:59], v[102:105]
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v114, v112, v58
	v_perm_b32 v58, v115, v113, v58
	v_and_or_b32 v58, v60, v106, v58
	v_perm_b32 v60, v114, v112, v59
	v_perm_b32 v59, v115, v113, v59
	v_and_or_b32 v59, v60, v61, v59
	v_perm_b32 v106, v59, v58, s41
	v_perm_b32 v107, v59, v58, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[10:11], v[106:107], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[12:13], v[106:107], v[102:105]
	s_nop 2
	v_add_u32_e32 v103, 17, v101
	v_lshl_add_u32 v102, v101, 23, v82
	v_lshlrev_b32_e64 v103, v103, 1
	v_cndmask_b32_e32 v102, v103, v102, vcc
	v_add_u32_e32 v103, 17, v100
	v_lshlrev_b32_e64 v103, v103, 1
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[106:107], v[8:9], v[102:103] op_sel_hi:[1,0]
	v_lshl_add_u32 v101, v100, 23, v82
	v_pk_mul_f32 v[72:73], v[106:107], v[72:73]
	v_cmp_lt_i32_e32 vcc, 5, v100
	v_pk_mul_f32 v[72:73], v[72:73], v[80:81]
	v_pk_mul_f32 v[104:105], v[6:7], v[102:103] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v100, v103, v101, vcc
	v_bfe_u32 v101, v73, 16, 1
	v_add3_u32 v101, v101, v73, s35
	v_or_b32_e32 v103, 0x400000, v73
	v_cmp_u_f32_e32 vcc, v73, v73
	v_pk_mul_f32 v[70:71], v[104:105], v[70:71]
	s_nop 0
	v_cndmask_b32_e32 v73, v101, v103, vcc
	v_bfe_u32 v101, v72, 16, 1
	v_pk_mul_f32 v[70:71], v[70:71], v[78:79]
	v_add3_u32 v101, v101, v72, s35
	v_or_b32_e32 v103, 0x400000, v72
	v_cmp_u_f32_e32 vcc, v72, v72
	s_nop 1
	v_cndmask_b32_e32 v72, v101, v103, vcc
	v_bfe_u32 v101, v71, 16, 1
	v_add3_u32 v101, v101, v71, s35
	v_or_b32_e32 v103, 0x400000, v71
	v_cmp_u_f32_e32 vcc, v71, v71
	s_nop 1
	v_cndmask_b32_e32 v71, v101, v103, vcc
	v_bfe_u32 v101, v70, 16, 1
	v_add3_u32 v101, v101, v70, s35
	v_or_b32_e32 v103, 0x400000, v70
	v_cmp_u_f32_e32 vcc, v70, v70
	s_nop 1
	v_cndmask_b32_e32 v70, v101, v103, vcc
	ds_write_b16_d16_hi v90, v70
	ds_write_b16_d16_hi v91, v71
	ds_write_b16_d16_hi v92, v72
	ds_write_b16_d16_hi v93, v73
	v_pk_mul_f32 v[72:73], v[8:9], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[70:71], v[6:7], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[72:73], v[60:61]
	v_pk_mul_f32 v[58:59], v[70:71], v[58:59]
	v_pk_mul_f32 v[60:61], v[60:61], v[80:81]
	v_pk_mul_f32 v[58:59], v[58:59], v[78:79]
	v_bfe_u32 v70, v61, 16, 1
	v_add3_u32 v70, v70, v61, s35
	v_or_b32_e32 v71, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	s_nop 1
	v_cndmask_b32_e32 v61, v70, v71, vcc
	v_bfe_u32 v70, v60, 16, 1
	v_add3_u32 v70, v70, v60, s35
	v_or_b32_e32 v71, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v70, v71, vcc
	v_bfe_u32 v70, v59, 16, 1
	v_add3_u32 v70, v70, v59, s35
	v_or_b32_e32 v71, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v70, v71, vcc
	v_bfe_u32 v70, v58, 16, 1
	v_add3_u32 v70, v70, v58, s35
	v_or_b32_e32 v71, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v70, v71, vcc
	ds_write_b16_d16_hi v90, v58 offset:32
	ds_write_b16_d16_hi v91, v59 offset:32
	ds_write_b16_d16_hi v92, v60 offset:32
	ds_write_b16_d16_hi v93, v61 offset:32
	s_waitcnt lgkmcnt(8)
	v_pk_mul_f32 v[60:61], v[4:5], v[102:103] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[102:103] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[60:61], v[68:69]
	v_pk_mul_f32 v[58:59], v[58:59], v[66:67]
	v_pk_mul_f32 v[60:61], v[60:61], v[76:77]
	v_pk_mul_f32 v[58:59], v[58:59], v[74:75]
	v_bfe_u32 v66, v61, 16, 1
	v_add3_u32 v66, v66, v61, s35
	v_or_b32_e32 v67, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	s_nop 1
	v_cndmask_b32_e32 v61, v66, v67, vcc
	v_bfe_u32 v66, v60, 16, 1
	v_add3_u32 v66, v66, v60, s35
	v_or_b32_e32 v67, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v66, v67, vcc
	v_bfe_u32 v66, v59, 16, 1
	v_add3_u32 v66, v66, v59, s35
	v_or_b32_e32 v67, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v66, v67, vcc
	v_bfe_u32 v66, v58, 16, 1
	v_add3_u32 v66, v66, v58, s35
	v_or_b32_e32 v67, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v66, v67, vcc
	ds_write_b16_d16_hi v86, v58
	ds_write_b16_d16_hi v87, v59
	ds_write_b16_d16_hi v88, v60
	ds_write_b16_d16_hi v89, v61
	v_pk_mul_f32 v[60:61], v[4:5], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[60:61], v[64:65]
	v_pk_mul_f32 v[58:59], v[58:59], v[62:63]
	v_pk_mul_f32 v[60:61], v[60:61], v[76:77]
	v_pk_mul_f32 v[58:59], v[58:59], v[74:75]
	v_bfe_u32 v62, v61, 16, 1
	v_add3_u32 v62, v62, v61, s35
	v_or_b32_e32 v63, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	s_nop 1
	v_cndmask_b32_e32 v61, v62, v63, vcc
	v_bfe_u32 v62, v60, 16, 1
	v_add3_u32 v62, v62, v60, s35
	v_or_b32_e32 v63, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v62, v63, vcc
	v_bfe_u32 v62, v59, 16, 1
	v_add3_u32 v62, v62, v59, s35
	v_or_b32_e32 v63, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v62, v63, vcc
	v_bfe_u32 v62, v58, 16, 1
	v_add3_u32 v62, v62, v58, s35
	v_or_b32_e32 v63, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v62, v63, vcc
	ds_write_b16_d16_hi v86, v58 offset:32
	ds_write_b16_d16_hi v87, v59 offset:32
	ds_write_b16_d16_hi v88, v60 offset:32
	ds_write_b16_d16_hi v89, v61 offset:32
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v58, v85, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[14:15], vcc
	s_cbranch_execz .LBB0_4
	v_add_u32_e32 v60, v84, v83
	v_lshl_add_u32 v58, v58, 12, s24
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v96
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[12:13], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v61, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:128
	ds_read_b32 v61, v60 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:256
	ds_read_b32 v61, v60 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:384
	ds_read_b32 v61, v60 offset:512
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:512
	ds_read_b32 v61, v60 offset:640
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:640
	ds_read_b32 v61, v60 offset:768
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:768
	ds_read_b32 v60, v60 offset:896
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:896
	s_branch .LBB0_4
.LBB0_7:
	v_sub_u32_sdwa v1, v94, v99 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v58, 11, v1
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v58, v58, s2
	v_sub_u32_e32 v59, 0x6c686080, v58
	v_and_b32_e32 v59, 0xffffff00, v59
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v58, 0x7c787470, v58
	v_lshlrev_b32_e32 v61, 4, v54
	v_cndmask_b32_e64 v1, v59, 0, vcc
	v_cndmask_b32_e64 v66, v58, 0, vcc
	v_add_u32_e32 v58, 0x7f7f7f00, v1
	v_and_b32_e32 v67, 0x80808000, v58
	v_add_u32_e32 v58, 0x7f7f7f78, v66
	v_and_b32_e32 v68, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v54
	v_lshrrev_b32_e32 v59, 4, v54
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v68, v67, v58
	v_perm_b32 v58, v66, v1, v58
	v_and_or_b32 v58, v60, v61, v58
	v_perm_b32 v60, v68, v67, v59
	v_perm_b32 v59, v66, v1, v59
	v_and_or_b32 v54, v60, v54, v59
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_sub_u32_sdwa v69, v94, v99 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v62, v54, v58, s0
	v_perm_b32 v63, v54, v58, s1
	v_min_i32_e32 v54, 11, v69
	v_mul_lo_u32 v70, v54, s2
	v_and_b32_e32 v54, 0x7070707, v55
	v_lshrrev_b32_e32 v71, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[38:39], v[62:63], 0
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v68, v67, v54
	v_lshlrev_b32_e32 v73, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[40:41], v[62:63], 0
	v_perm_b32 v54, v66, v1, v54
	v_and_or_b32 v72, v72, v73, v54
	v_perm_b32 v54, v68, v67, v71
	v_perm_b32 v71, v66, v1, v71
	v_and_or_b32 v55, v54, v55, v71
	v_perm_b32 v54, v55, v72, s0
	v_perm_b32 v55, v55, v72, s1
	v_lshlrev_b32_e32 v73, 4, v56
	v_sub_u32_e32 v71, 0x6c686080, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[34:35], v[54:55], v[58:61]
	v_and_b32_e32 v71, 0xffffff00, v71
	v_sub_u32_e32 v70, 0x7c787470, v70
	v_cmp_lt_i32_e32 vcc, 11, v69
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[36:37], v[54:55], v[62:65]
	v_and_b32_e32 v54, 0x7070707, v56
	v_lshrrev_b32_e32 v55, 4, v56
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v72, v68, v67, v54
	v_perm_b32 v54, v66, v1, v54
	v_and_or_b32 v72, v72, v73, v54
	v_perm_b32 v54, v68, v67, v55
	v_perm_b32 v55, v66, v1, v55
	v_and_or_b32 v55, v54, v56, v55
	v_perm_b32 v54, v55, v72, s0
	v_perm_b32 v55, v55, v72, s1
	v_lshlrev_b32_e32 v72, 4, v57
	v_cndmask_b32_e64 v69, v71, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[30:31], v[54:55], v[58:61]
	v_cndmask_b32_e64 v70, v70, 0, vcc
	v_add_u32_e32 v71, 0x7f7f7f00, v69
	s_add_i32 s3, s17, 0xe01
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[32:33], v[54:55], v[62:65]
	v_and_b32_e32 v54, 0x7070707, v57
	v_lshrrev_b32_e32 v55, 4, v57
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v56, v68, v67, v54
	v_perm_b32 v54, v66, v1, v54
	v_and_or_b32 v54, v56, v72, v54
	v_perm_b32 v56, v68, v67, v55
	v_perm_b32 v1, v66, v1, v55
	v_and_or_b32 v1, v56, v57, v1
	v_perm_b32 v66, v1, v54, s0
	v_perm_b32 v67, v1, v54, s1
	v_and_b32_e32 v1, 0x80808000, v71
	s_lshr_b32 s4, s3, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[26:27], v[66:67], v[58:61]
	s_add_i32 s4, s3, s4
	s_and_b32 s4, s4, 0x1ffffffe
	s_sub_i32 s3, s3, s4
	v_add_u32_e32 v58, 0x7f7f7f78, v70
	v_and_b32_e32 v68, 0x80808080, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[28:29], v[66:67], v[62:65]
	s_lshl_b32 s3, s3, 3
	s_nop 1
	v_and_b32_e32 v62, 0x7070707, v50
	v_lshrrev_b32_e32 v63, 4, v50
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v68, v1, v62
	v_lshlrev_b32_e32 v65, 4, v50
	v_perm_b32 v62, v70, v69, v62
	v_and_or_b32 v64, v64, v65, v62
	v_perm_b32 v62, v68, v1, v63
	v_perm_b32 v63, v70, v69, v63
	v_and_or_b32 v50, v62, v50, v63
	v_perm_b32 v62, v50, v64, s0
	v_perm_b32 v63, v50, v64, s1
	v_and_b32_e32 v50, 0x7070707, v51
	v_lshlrev_b32_e32 v64, 4, v51
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[22:23], v[62:63], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[24:25], v[62:63], v[58:61]
	v_lshrrev_b32_e32 v62, 4, v51
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v68, v1, v50
	v_perm_b32 v50, v70, v69, v50
	v_and_or_b32 v63, v63, v64, v50
	v_perm_b32 v50, v68, v1, v62
	v_perm_b32 v62, v70, v69, v62
	v_and_or_b32 v51, v50, v51, v62
	v_perm_b32 v50, v51, v63, s0
	v_perm_b32 v51, v51, v63, s1
	v_lshlrev_b32_e32 v63, 4, v52
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[18:19], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[20:21], v[50:51], v[58:61]
	v_and_b32_e32 v50, 0x7070707, v52
	v_lshrrev_b32_e32 v51, 4, v52
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v62, v68, v1, v50
	v_perm_b32 v50, v70, v69, v50
	v_and_or_b32 v62, v62, v63, v50
	v_perm_b32 v50, v68, v1, v51
	v_perm_b32 v51, v70, v69, v51
	v_and_or_b32 v51, v50, v52, v51
	v_perm_b32 v50, v51, v62, s0
	v_perm_b32 v51, v51, v62, s1
	v_lshlrev_b32_e32 v62, 4, v53
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[14:15], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[16:17], v[50:51], v[58:61]
	v_and_b32_e32 v50, 0x7070707, v53
	v_lshrrev_b32_e32 v51, 4, v53
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v68, v1, v50
	v_perm_b32 v50, v70, v69, v50
	v_and_or_b32 v52, v52, v62, v50
	v_perm_b32 v1, v68, v1, v51
	v_perm_b32 v50, v70, v69, v51
	v_and_or_b32 v1, v1, v53, v50
	v_perm_b32 v50, v1, v52, s0
	v_perm_b32 v51, v1, v52, s1
	v_bfe_u32 v1, v95, s3, 8
	v_sub_u32_e32 v1, v0, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[10:11], v[50:51], v[54:57]
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_add_i32 s3, s3, 16
	v_bfe_u32 v64, v95, s3, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[12:13], v[50:51], v[58:61]
	v_sub_u32_e32 v64, v0, v64
	v_lshlrev_b32_e32 v69, 4, v47
	s_nop 0
	v_min_i32_e32 v58, 11, v1
	v_mul_lo_u32 v58, v58, s2
	v_sub_u32_e32 v59, 0x6c686080, v58
	v_and_b32_e32 v59, 0xffffff00, v59
	v_sub_u32_e32 v58, 0x7c787470, v58
	v_cndmask_b32_e64 v1, v59, 0, vcc
	v_cndmask_b32_e64 v65, v58, 0, vcc
	v_add_u32_e32 v58, 0x7f7f7f00, v1
	v_and_b32_e32 v66, 0x80808000, v58
	v_add_u32_e32 v58, 0x7f7f7f78, v65
	v_and_b32_e32 v67, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v46
	v_lshrrev_b32_e32 v59, 4, v46
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v67, v66, v58
	v_lshlrev_b32_e32 v61, 4, v46
	v_perm_b32 v58, v65, v1, v58
	v_and_or_b32 v58, v60, v61, v58
	v_perm_b32 v60, v67, v66, v59
	v_perm_b32 v59, v65, v1, v59
	v_and_or_b32 v46, v60, v46, v59
	v_perm_b32 v62, v46, v58, s0
	v_perm_b32 v63, v46, v58, s1
	v_and_b32_e32 v46, 0x7070707, v47
	v_cmp_lt_i32_e32 vcc, 11, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[38:39], v[62:63], 0
	v_min_i32_e32 v38, 11, v64
	v_mul_lo_u32 v68, v38, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[40:41], v[62:63], 0
	v_lshrrev_b32_e32 v62, 4, v47
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v67, v66, v46
	v_perm_b32 v46, v65, v1, v46
	v_and_or_b32 v63, v63, v69, v46
	v_perm_b32 v46, v67, v66, v62
	v_perm_b32 v62, v65, v1, v62
	v_and_or_b32 v47, v46, v47, v62
	v_perm_b32 v46, v47, v63, s0
	v_perm_b32 v47, v47, v63, s1
	v_sub_u32_e32 v63, 0x7c787470, v68
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[34:35], v[46:47], v[58:61]
	v_sub_u32_e32 v34, 0x6c686080, v68
	v_and_b32_e32 v62, 0xffffff00, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[46:47], v[38:41]
	s_nop 2
	v_and_b32_e32 v38, 0x7070707, v48
	v_lshrrev_b32_e32 v39, 4, v48
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v40, v67, v66, v38
	v_lshlrev_b32_e32 v41, 4, v48
	v_perm_b32 v38, v65, v1, v38
	v_and_or_b32 v38, v40, v41, v38
	v_perm_b32 v40, v67, v66, v39
	v_perm_b32 v39, v65, v1, v39
	v_and_or_b32 v39, v40, v48, v39
	v_perm_b32 v46, v39, v38, s0
	v_perm_b32 v47, v39, v38, s1
	v_cndmask_b32_e64 v48, v62, 0, vcc
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[30:31], v[46:47], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[32:33], v[46:47], v[34:37]
	s_nop 1
	v_cndmask_b32_e64 v58, v63, 0, vcc
	v_add_u32_e32 v59, 0x7f7f7f00, v48
	v_cmp_lt_i32_e32 vcc, 5, v94
	v_and_b32_e32 v34, 0x7070707, v49
	v_lshrrev_b32_e32 v35, 4, v49
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v67, v66, v34
	v_lshlrev_b32_e32 v37, 4, v49
	v_perm_b32 v34, v65, v1, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v67, v66, v35
	v_perm_b32 v1, v65, v1, v35
	v_and_or_b32 v1, v36, v49, v1
	v_perm_b32 v46, v1, v34, s0
	v_perm_b32 v47, v1, v34, s1
	v_and_b32_e32 v1, 0x80808000, v59
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[26:27], v[46:47], v[38:41]
	v_add_u32_e32 v26, 0x7f7f7f78, v58
	s_nop 1
	v_and_b32_e32 v40, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[46:47], v[30:33]
	s_nop 2
	v_and_b32_e32 v30, 0x7070707, v42
	v_lshrrev_b32_e32 v31, 4, v42
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v40, v1, v30
	v_lshlrev_b32_e32 v33, 4, v42
	v_perm_b32 v30, v58, v48, v30
	v_and_or_b32 v30, v32, v33, v30
	v_perm_b32 v32, v40, v1, v31
	v_perm_b32 v31, v58, v48, v31
	v_and_or_b32 v31, v32, v42, v31
	v_perm_b32 v38, v31, v30, s0
	v_perm_b32 v39, v31, v30, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[22:23], v[38:39], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[38:39], v[26:29]
	s_nop 2
	v_and_b32_e32 v26, 0x7070707, v43
	v_lshrrev_b32_e32 v27, 4, v43
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v40, v1, v26
	v_lshlrev_b32_e32 v29, 4, v43
	v_perm_b32 v26, v58, v48, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v40, v1, v27
	v_perm_b32 v27, v58, v48, v27
	v_and_or_b32 v27, v28, v43, v27
	v_perm_b32 v34, v27, v26, s0
	v_perm_b32 v35, v27, v26, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[18:19], v[34:35], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[34:35], v[22:25]
	s_nop 2
	v_and_b32_e32 v22, 0x7070707, v44
	v_lshrrev_b32_e32 v23, 4, v44
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v40, v1, v22
	v_lshlrev_b32_e32 v25, 4, v44
	v_perm_b32 v22, v58, v48, v22
	v_and_or_b32 v22, v24, v25, v22
	v_perm_b32 v24, v40, v1, v23
	v_perm_b32 v23, v58, v48, v23
	v_and_or_b32 v23, v24, v44, v23
	v_perm_b32 v30, v23, v22, s0
	v_perm_b32 v31, v23, v22, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[14:15], v[30:31], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[30:31], v[18:21]
	s_nop 2
	v_lshrrev_b32_e32 v19, 4, v45
	v_and_b32_e32 v18, 0x7070707, v45
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v40, v1, v18
	v_lshlrev_b32_e32 v21, 4, v45
	v_perm_b32 v18, v58, v48, v18
	v_perm_b32 v1, v40, v1, v19
	v_perm_b32 v19, v58, v48, v19
	v_and_or_b32 v18, v20, v21, v18
	v_and_or_b32 v1, v1, v45, v19
	v_perm_b32 v26, v1, v18, s0
	v_perm_b32 v27, v1, v18, s1
	v_mov_b32_e32 v1, 0xfd800000
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[26:27], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[12:13], v[26:27], v[14:17]
	s_nop 2
	v_add_u32_e32 v15, 17, v94
	v_lshl_add_u32 v14, v94, 23, v1
	v_lshlrev_b32_e64 v15, v15, 1
	v_cndmask_b32_e32 v14, v15, v14, vcc
	v_add_u32_e32 v15, 17, v0
	v_lshlrev_b32_e64 v15, v15, 1
	v_pk_mul_f32 v[22:23], v[8:9], v[14:15] op_sel_hi:[1,0]
	v_lshl_add_u32 v1, v0, 23, v1
	v_pk_mul_f32 v[22:23], v[22:23], v[56:57]
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[22:23], v[22:23], v[80:81]
	v_pk_mul_f32 v[16:17], v[6:7], v[14:15] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v0, v15, v1, vcc
	v_bfe_u32 v1, v23, 16, 1
	v_pk_mul_f32 v[16:17], v[16:17], v[54:55]
	v_add3_u32 v1, v1, v23, s0
	v_or_b32_e32 v15, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	v_pk_mul_f32 v[16:17], v[16:17], v[78:79]
	v_or_b32_e32 v23, 0x400000, v22
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_bfe_u32 v15, v22, 16, 1
	v_add3_u32 v15, v15, v22, s0
	v_cmp_u_f32_e32 vcc, v22, v22
	v_bfe_u32 v22, v17, 16, 1
	v_add3_u32 v22, v22, v17, s0
	v_cndmask_b32_e32 v15, v15, v23, vcc
	v_or_b32_e32 v23, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v17, v22, v23, vcc
	v_bfe_u32 v22, v16, 16, 1
	v_add3_u32 v22, v22, v16, s0
	v_or_b32_e32 v23, 0x400000, v16
	v_cmp_u_f32_e32 vcc, v16, v16
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_cndmask_b32_e32 v16, v22, v23, vcc
	v_pk_mul_f32 v[8:9], v[8:9], v[80:81]
	ds_write_b16_d16_hi v90, v16
	ds_write_b16_d16_hi v91, v17
	ds_write_b16_d16_hi v92, v15
	ds_write_b16_d16_hi v93, v1
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v15, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[78:79]
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_add3_u32 v9, v9, v8, s0
	v_or_b32_e32 v15, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v15, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v15, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v15, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v15, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v15, vcc
	ds_write_b16_d16_hi v90, v6 offset:32
	ds_write_b16_d16_hi v91, v7 offset:32
	ds_write_b16_d16_hi v92, v8 offset:32
	ds_write_b16_d16_hi v93, v1 offset:32
	v_pk_mul_f32 v[8:9], v[4:5], v[14:15] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[14:15] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[52:53]
	v_pk_mul_f32 v[6:7], v[6:7], v[50:51]
	v_pk_mul_f32 v[8:9], v[8:9], v[76:77]
	v_pk_mul_f32 v[6:7], v[6:7], v[74:75]
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
	v_pk_mul_f32 v[2:3], v[2:3], v[74:75]
	s_nop 0
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v86, v6
	ds_write_b16_d16_hi v87, v7
	ds_write_b16_d16_hi v88, v8
	ds_write_b16_d16_hi v89, v1
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[12:13]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[76:77]
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
	ds_write_b16_d16_hi v86, v2 offset:32
	ds_write_b16_d16_hi v87, v3 offset:32
	ds_write_b16_d16_hi v88, v0 offset:32
	ds_write_b16_d16_hi v89, v1 offset:32
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v85, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_add_u32_e32 v2, v84, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[12:13], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3072
	ds_read_b32 v3, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3200
	ds_read_b32 v3, v2 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3328
	ds_read_b32 v3, v2 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3456
	ds_read_b32 v3, v2 offset:512
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3584
	ds_read_b32 v3, v2 offset:640
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3712
	ds_read_b32 v3, v2 offset:768
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:896
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_9:
	s_or_b64 exec, exec, s[0:1]
	s_barrier
.LBB0_10:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r
		.amdhsa_group_segment_fixed_size 49152
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
		.amdhsa_next_free_vgpr 121
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 124
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.num_vgpr, 121
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.numbered_sgpr, 54
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.has_indirect_call, 0
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
    .group_segment_fixed_size: 49152
    .kernarg_segment_align: 8
    .kernarg_segment_size: 108
    .max_flat_workgroup_size: 1024
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 1024
      - 1
      - 1
    .sgpr_count:     60
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz_a2r.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     121
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
