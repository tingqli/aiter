	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz:
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
	global_load_dword v1, v[2:3], off
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dword s33, s[0:1], 0x68
	v_and_b32_e32 v82, 15, v0
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
	v_or_b32_e32 v55, s9, v82
	s_cmp_lt_i32 s11, 0
	v_and_b32_e32 v51, 48, v0
	v_xor_b32_e32 v6, v2, v18
	v_add_u32_e32 v2, s2, v55
	s_cselect_b64 s[2:3], -1, 0
	s_lshl_b32 s27, s11, 7
	s_ashr_i32 s28, s11, 31
	v_or3_b32 v64, s27, v51, v82
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
	v_or3_b32 v65, s2, v51, v82
	s_and_b32 s2, s3, -2
	s_ashr_i32 s52, s49, 4
	s_sub_i32 s53, s24, s2
	s_cmp_lt_i32 s49, 0
	s_cselect_b64 s[2:3], -1, 0
	s_lshl_b32 s11, s49, 7
	s_ashr_i32 s24, s49, 31
	v_or3_b32 v67, s11, v51, v82
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
	v_or3_b32 v68, s2, v51, v82
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	global_load_dword v57, v[2:3], off
	global_load_dword v56, v[4:5], off
	v_lshlrev_b32_e32 v2, 4, v64
	v_lshlrev_b32_e32 v20, 4, v67
	s_mov_b32 s46, s30
	s_mov_b32 s47, s39
	s_mov_b32 s44, s10
	s_mov_b32 s45, s29
	v_lshlrev_b32_e32 v19, 2, v68
	s_mov_b32 s36, s4
	s_mov_b32 s24, s8
	s_lshr_b32 s8, s49, 31
	s_load_dwordx2 s[12:13], s[0:1], 0x60
	s_waitcnt vmcnt(2)
	v_lshl_or_b32 v69, v1, 12, v6
	v_lshlrev_b32_e32 v1, 2, v65
	buffer_load_dwordx4 v[14:17], v2, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v2, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[10:13], v20, s[40:43], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v20, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dword v72, v1, s[44:47], 0 offen
	buffer_load_dword v71, v19, s[44:47], 0 offen
	buffer_load_dwordx2 v[34:35], v69, s[36:39], 0 offen nt
	v_bfe_u32 v53, v0, 4, 2
	s_mov_b32 s28, s10
	s_add_i32 s10, s52, s8
	v_lshlrev_b32_e32 v1, 5, v53
	v_lshlrev_b32_e32 v19, 4, v82
	s_and_b32 s10, s10, -2
	v_xor_b32_e32 v84, v1, v19
	v_or_b32_e32 v20, 8, v1
	v_or_b32_e32 v21, 16, v1
	v_or_b32_e32 v22, 24, v1
	v_or_b32_e32 v23, 0x80, v1
	v_or_b32_e32 v24, 0x88, v1
	v_or_b32_e32 v25, 0x90, v1
	v_or_b32_e32 v1, 0x98, v1
	s_sub_i32 s10, s52, s10
	v_mov_b32_e32 v38, 0
	v_lshlrev_b32_e32 v83, 8, v82
	v_lshl_or_b32 v18, v52, 8, v18
	v_xor_b32_e32 v1, v1, v19
	s_mov_b32 s0, s4
	s_lshl_b32 s4, s53, 3
	s_lshl_b32 s10, s10, 3
	v_and_b32_e32 v54, 63, v0
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
	v_or_b32_e32 v66, 0x1000, v83
	v_lshrrev_b32_e32 v73, 2, v18
	v_xor_b32_e32 v63, v20, v19
	v_xor_b32_e32 v62, v21, v19
	v_xor_b32_e32 v61, v22, v19
	v_xor_b32_e32 v60, v23, v19
	v_xor_b32_e32 v59, v24, v19
	v_xor_b32_e32 v58, v25, v19
	v_or_b32_e32 v70, v83, v84
	v_or_b32_e32 v1, v83, v1
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
	v_lshl_add_u32 v2, s35, 8, v69
	s_lshl_b32 s39, s35, 6
	s_lshl_b32 s41, s35, 7
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx2 v[94:95], v2, s[0:3], 0 offen nt
	v_add_lshl_u32 v2, s39, v65, 2
	v_add_lshl_u32 v3, s39, v68, 2
	v_add_lshl_u32 v4, s41, v64, 4
	v_add_lshl_u32 v5, s41, v67, 4
	v_mov_b64_e32 v[36:37], v[12:13]
	v_mov_b64_e32 v[34:35], v[10:11]
	v_mov_b64_e32 v[24:25], v[8:9]
	v_mov_b64_e32 v[22:23], v[6:7]
	v_mov_b64_e32 v[48:49], v[16:17]
	v_mov_b64_e32 v[46:47], v[14:15]
	v_bfe_u32 v74, v72, s4, 8
	v_bfe_u32 v75, v72, s8, 8
	v_bfe_u32 v78, v71, s10, 8
	v_bfe_u32 v79, v71, s37, 8
	buffer_load_dword v72, v2, s[28:31], 0 offen
	buffer_load_dword v71, v3, s[28:31], 0 offen
	buffer_load_dwordx4 v[14:17], v4, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v4, s[24:27], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[10:13], v5, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v5, s[24:27], 0 offen offset:1024 sc0
	v_sub_u32_e32 v74, v57, v74
	v_min_i32_e32 v76, 11, v74
	v_mul_lo_u32 v76, v76, s11
	v_sub_u32_e32 v77, 0x6c686080, v76
	v_and_b32_e32 v77, 0xffffff00, v77
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v76, 0x7c787470, v76
	v_sub_u32_e32 v78, v56, v78
	v_cndmask_b32_e64 v85, v77, 0, vcc
	v_cndmask_b32_e64 v86, v76, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v85
	v_and_b32_e32 v87, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v86
	v_and_b32_e32 v88, 0x80808080, v74
	v_sub_u32_e32 v74, v57, v75
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s11
	v_min_i32_e32 v80, 11, v78
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_mul_lo_u32 v80, v80, s11
	v_and_b32_e32 v76, 0xffffff00, v76
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v81, 0x6c686080, v80
	v_and_b32_e32 v81, 0xffffff00, v81
	v_cndmask_b32_e64 v74, v76, 0, vcc
	v_cndmask_b32_e64 v75, v75, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v78
	v_and_b32_e32 v93, 0x7070707, v46
	v_lshrrev_b32_e32 v96, 4, v46
	v_sub_u32_e32 v80, 0x7c787470, v80
	v_cndmask_b32_e64 v89, v81, 0, vcc
	v_and_b32_e32 v96, 0x7070707, v96
	v_perm_b32 v97, v88, v87, v93
	v_lshlrev_b32_e32 v98, 4, v46
	v_perm_b32 v93, v86, v85, v93
	v_cndmask_b32_e64 v90, v80, 0, vcc
	v_add_u32_e32 v78, 0x7f7f7f00, v89
	v_and_or_b32 v93, v97, v98, v93
	v_perm_b32 v97, v88, v87, v96
	v_perm_b32 v96, v86, v85, v96
	v_and_b32_e32 v91, 0x80808000, v78
	v_add_u32_e32 v78, 0x7f7f7f78, v90
	v_and_or_b32 v46, v97, v46, v96
	v_and_b32_e32 v92, 0x80808080, v78
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
	v_or_b32_e32 v34, s39, v70
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
	v_or_b32_e32 v93, s39, v63
	v_perm_b32 v34, v35, v96, s36
	v_perm_b32 v35, v35, v96, s40
	v_or_b32_e32 v96, v93, v83
	ds_read_b64 v[96:97], v96
	v_or_b32_e32 v93, v93, v66
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[96:97], v[46:47], v[38:41]
	v_sub_u32_e32 v78, v56, v79
	v_min_i32_e32 v79, 11, v78
	v_add_u32_e32 v76, 0x7f7f7f00, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[96:97], v[34:35], v[42:45]
	ds_read_b64 v[96:97], v93
	v_lshlrev_b32_e32 v93, 4, v36
	v_add_u32_e32 v77, 0x7f7f7f78, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[98:99], v[102:103], v[30:33]
	v_mul_lo_u32 v79, v79, s11
	v_and_b32_e32 v76, 0x80808000, v76
	v_and_b32_e32 v77, 0x80808080, v77
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[100:101], v[26:29]
	v_sub_u32_e32 v80, 0x6c686080, v79
	v_and_b32_e32 v80, 0xffffff00, v80
	v_sub_u32_e32 v79, 0x7c787470, v79
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
	v_or_b32_e32 v36, s39, v62
	v_or_b32_e32 v48, v36, v83
	ds_read_b64 v[96:97], v48
	v_or_b32_e32 v36, v36, v66
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[96:97], v[34:35], v[38:41]
	v_lshlrev_b32_e32 v48, 4, v37
	v_cmp_lt_i32_e32 vcc, 11, v78
	s_cmp_lg_u32 s35, 15
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[96:97], v[46:47], v[42:45]
	ds_read_b64 v[96:97], v36
	v_cndmask_b32_e64 v78, v80, 0, vcc
	v_cndmask_b32_e64 v79, v79, 0, vcc
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
	v_or_b32_e32 v85, s39, v61
	v_perm_b32 v48, v35, v34, s36
	v_perm_b32 v49, v35, v34, s40
	v_or_b32_e32 v34, v85, v83
	ds_read_b64 v[86:87], v34
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[86:87], v[46:47], v[38:41]
	v_add_u32_e32 v80, 0x7f7f7f00, v78
	v_add_u32_e32 v81, 0x7f7f7f78, v79
	v_and_b32_e32 v80, 0x80808000, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[86:87], v[48:49], v[42:45]
	v_and_b32_e32 v81, 0x80808080, v81
	s_nop 1
	v_or_b32_e32 v42, v85, v66
	ds_read_b64 v[42:43], v42
	v_lshlrev_b32_e32 v45, 4, v22
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[42:43], v[46:47], v[26:29]
	v_lshlrev_b32_e32 v46, 4, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[42:43], v[48:49], v[30:33]
	v_and_b32_e32 v42, 0x7070707, v22
	v_lshrrev_b32_e32 v43, 4, v22
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v77, v76, v42
	v_perm_b32 v42, v75, v74, v42
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v77, v76, v43
	v_perm_b32 v43, v75, v74, v43
	v_and_or_b32 v22, v42, v22, v43
	v_perm_b32 v42, v22, v44, s36
	v_perm_b32 v43, v22, v44, s40
	v_and_b32_e32 v22, 0x7070707, v18
	v_lshrrev_b32_e32 v44, 4, v18
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v81, v80, v22
	v_perm_b32 v22, v79, v78, v22
	v_and_or_b32 v22, v45, v46, v22
	v_perm_b32 v45, v81, v80, v44
	v_perm_b32 v44, v79, v78, v44
	v_and_or_b32 v18, v45, v18, v44
	v_perm_b32 v44, v18, v22, s36
	v_perm_b32 v45, v18, v22, s40
	v_or_b32_e32 v18, s39, v60
	v_or_b32_e32 v22, v18, v83
	ds_read_b64 v[46:47], v22
	v_or_b32_e32 v18, v18, v66
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[46:47], v[42:43], v[34:37]
	v_lshrrev_b32_e32 v22, 4, v23
	v_and_b32_e32 v22, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[46:47], v[44:45], v[38:41]
	ds_read_b64 v[46:47], v18
	v_and_b32_e32 v18, 0x7070707, v23
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[46:47], v[42:43], v[26:29]
	v_perm_b32 v42, v77, v76, v18
	v_lshlrev_b32_e32 v43, 4, v23
	v_perm_b32 v18, v75, v74, v18
	v_and_or_b32 v18, v42, v43, v18
	v_perm_b32 v42, v77, v76, v22
	v_perm_b32 v22, v75, v74, v22
	v_and_or_b32 v23, v42, v23, v22
	v_perm_b32 v22, v23, v18, s36
	v_perm_b32 v23, v23, v18, s40
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v42, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[46:47], v[44:45], v[30:33]
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v81, v80, v18
	v_lshlrev_b32_e32 v44, 4, v19
	v_perm_b32 v18, v79, v78, v18
	v_and_or_b32 v43, v43, v44, v18
	v_perm_b32 v18, v81, v80, v42
	v_perm_b32 v42, v79, v78, v42
	v_or_b32_e32 v46, s39, v59
	v_and_or_b32 v19, v18, v19, v42
	v_or_b32_e32 v42, v46, v83
	v_perm_b32 v18, v19, v43, s36
	v_perm_b32 v19, v19, v43, s40
	ds_read_b64 v[42:43], v42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[42:43], v[22:23], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[42:43], v[18:19], v[38:41]
	s_nop 2
	v_or_b32_e32 v38, v46, v66
	ds_read_b64 v[38:39], v38
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[38:39], v[18:19], v[30:33]
	v_and_b32_e32 v18, 0x7070707, v24
	v_lshrrev_b32_e32 v19, 4, v24
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[38:39], v[22:23], v[26:29]
	v_perm_b32 v22, v77, v76, v18
	v_lshlrev_b32_e32 v23, 4, v24
	v_perm_b32 v18, v75, v74, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v77, v76, v19
	v_perm_b32 v19, v75, v74, v19
	v_and_or_b32 v19, v18, v24, v19
	v_perm_b32 v18, v19, v22, s36
	v_perm_b32 v19, v19, v22, s40
	v_and_b32_e32 v22, 0x7070707, v20
	v_lshrrev_b32_e32 v23, 4, v20
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v81, v80, v22
	v_lshlrev_b32_e32 v26, 4, v20
	v_perm_b32 v22, v79, v78, v22
	v_and_or_b32 v24, v24, v26, v22
	v_perm_b32 v22, v81, v80, v23
	v_perm_b32 v23, v79, v78, v23
	v_and_or_b32 v20, v22, v20, v23
	v_perm_b32 v22, v20, v24, s36
	v_perm_b32 v23, v20, v24, s40
	v_or_b32_e32 v20, s39, v58
	v_or_b32_e32 v24, v20, v83
	ds_read_b64 v[26:27], v24
	v_or_b32_e32 v20, v20, v66
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
	v_perm_b32 v20, v77, v76, v18
	v_perm_b32 v18, v75, v74, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[34:35], v[22:23], v[86:89]
	v_lshlrev_b32_e32 v22, 4, v25
	v_and_or_b32 v18, v20, v22, v18
	v_perm_b32 v20, v77, v76, v19
	v_perm_b32 v19, v75, v74, v19
	v_and_or_b32 v19, v20, v25, v19
	v_perm_b32 v22, v19, v18, s36
	v_perm_b32 v23, v19, v18, s40
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v81, v80, v18
	v_perm_b32 v18, v79, v78, v18
	v_and_or_b32 v18, v20, v24, v18
	v_perm_b32 v20, v81, v80, v19
	v_perm_b32 v19, v79, v78, v19
	v_and_or_b32 v19, v20, v21, v19
	v_perm_b32 v24, v19, v18, s36
	v_perm_b32 v25, v19, v18, s40
	v_or_b32_e32 v18, s39, v1
	ds_read2st64_b64 v[18:21], v18 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[18:19], v[22:23], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[18:19], v[24:25], v[26:29]
	v_lshl_or_b32 v18, s38, 11, v73
	v_xor_b32_e32 v18, 0x800, v18
	v_lshlrev_b32_e32 v18, 2, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[20:21], v[22:23], v[30:33]
	s_waitcnt vmcnt(6)
	ds_write_b64 v18, v[94:95]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[20:21], v[24:25], v[34:37]
	s_cbranch_scc1 .LBB0_2
	s_waitcnt vmcnt(5)
	v_bfe_u32 v18, v72, s4, 8
	v_sub_u32_e32 v18, v57, v18
	v_min_i32_e32 v20, 11, v18
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v20, v20, s40
	v_sub_u32_e32 v21, 0x6c686080, v20
	v_and_b32_e32 v21, 0xffffff00, v21
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v20, 0x7c787470, v20
	s_waitcnt vmcnt(4)
	v_bfe_u32 v19, v71, s10, 8
	v_cndmask_b32_e64 v48, v21, 0, vcc
	v_cndmask_b32_e64 v49, v20, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v48
	v_and_b32_e32 v64, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v49
	v_and_b32_e32 v65, 0x80808080, v18
	v_sub_u32_e32 v18, v56, v19
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s40
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_bfe_u32 v47, v71, s37, 8
	v_cndmask_b32_e64 v67, v20, 0, vcc
	v_cndmask_b32_e64 v68, v19, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v67
	v_and_b32_e32 v69, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v68
	v_and_b32_e32 v71, 0x80808080, v18
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v18, 0x7070707, v14
	v_lshrrev_b32_e32 v19, 4, v14
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v65, v64, v18
	v_lshlrev_b32_e32 v21, 4, v14
	v_perm_b32 v18, v49, v48, v18
	v_and_or_b32 v18, v20, v21, v18
	v_perm_b32 v20, v65, v64, v19
	v_perm_b32 v19, v49, v48, v19
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_and_or_b32 v14, v20, v14, v19
	s_mov_b32 s41, 0x5010400
	s_mov_b32 s42, 0x7030602
	ds_read_b64 v[24:25], v70 offset:8192
	v_perm_b32 v34, v14, v18, s41
	v_perm_b32 v35, v14, v18, s42
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v18, 4, v10
	v_and_b32_e32 v18, 0x7070707, v18
	v_perm_b32 v22, v71, v69, v18
	v_perm_b32 v23, v68, v67, v18
	v_or_b32_e32 v18, v84, v66
	v_bfe_u32 v46, v72, s8, 8
	ds_read_b64 v[72:73], v18 offset:8192
	v_and_b32_e32 v14, 0x7070707, v10
	v_perm_b32 v19, v71, v69, v14
	v_lshlrev_b32_e32 v20, 4, v10
	v_perm_b32 v14, v68, v67, v14
	v_and_or_b32 v14, v19, v20, v14
	v_and_or_b32 v10, v22, v10, v23
	v_perm_b32 v36, v10, v14, s41
	v_perm_b32 v37, v10, v14, s42
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[24:25], v[34:35], v[38:41]
	v_add_u32_e32 v85, v83, v63
	v_add_u32_e32 v86, v83, v62
	v_add_u32_e32 v87, v83, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[36:37], v[42:45]
	v_add_u32_e32 v88, v83, v60
	v_add_u32_e32 v89, v83, v59
	v_add_u32_e32 v90, v83, v58
	v_sub_u32_e32 v44, v57, v46
	v_min_i32_e32 v10, 11, v44
	v_mul_lo_u32 v10, v10, s40
	v_sub_u32_e32 v14, 0x6c686080, v10
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[72:73], v[34:35], v[26:29]
	v_and_b32_e32 v34, 0xffffff00, v14
	v_sub_u32_e32 v35, 0x7c787470, v10
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v14, 4, v15
	ds_read2st64_b64 v[40:43], v85 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[72:73], v[36:37], v[30:33]
	v_and_b32_e32 v14, 0x7070707, v14
	v_cmp_lt_i32_e32 vcc, 11, v44
	v_sub_u32_e32 v46, v56, v47
	v_perm_b32 v30, v65, v64, v10
	v_lshlrev_b32_e32 v31, 4, v15
	v_perm_b32 v10, v49, v48, v10
	v_and_or_b32 v10, v30, v31, v10
	v_perm_b32 v30, v65, v64, v14
	v_perm_b32 v14, v49, v48, v14
	v_and_or_b32 v15, v30, v15, v14
	v_perm_b32 v14, v15, v10, s41
	v_perm_b32 v15, v15, v10, s42
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v30, 4, v11
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v71, v69, v10
	v_lshlrev_b32_e32 v32, 4, v11
	v_perm_b32 v10, v68, v67, v10
	v_and_or_b32 v31, v31, v32, v10
	v_perm_b32 v10, v71, v69, v30
	v_perm_b32 v30, v68, v67, v30
	v_and_or_b32 v11, v10, v11, v30
	v_perm_b32 v10, v11, v31, s41
	v_perm_b32 v11, v11, v31, s42
	v_cndmask_b32_e64 v33, v35, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[14:15], v[18:21]
	v_cndmask_b32_e64 v32, v34, 0, vcc
	v_add_u32_e32 v30, 0x7f7f7f00, v32
	v_and_b32_e32 v34, 0x80808000, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[40:41], v[10:11], v[22:25]
	v_lshlrev_b32_e32 v30, 4, v12
	v_cmp_lt_i32_e32 vcc, 11, v46
	s_ashr_i32 s35, s34, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[42:43], v[14:15], v[26:29]
	v_add_u32_e32 v14, 0x7f7f7f78, v33
	v_and_b32_e32 v35, 0x80808080, v14
	v_lshlrev_b32_e32 v15, 4, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[42:43], v[10:11], v[36:39]
	v_and_b32_e32 v10, 0x7070707, v16
	v_lshrrev_b32_e32 v11, 4, v16
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v14, v65, v64, v10
	v_perm_b32 v10, v49, v48, v10
	ds_read2st64_b64 v[40:43], v86 offset0:16 offset1:24
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v65, v64, v11
	v_perm_b32 v11, v49, v48, v11
	v_and_or_b32 v11, v10, v16, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v14, 0x7070707, v12
	v_lshrrev_b32_e32 v15, 4, v12
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v71, v69, v14
	v_perm_b32 v14, v68, v67, v14
	v_and_or_b32 v16, v16, v30, v14
	v_perm_b32 v14, v71, v69, v15
	v_perm_b32 v15, v68, v67, v15
	v_and_or_b32 v12, v14, v12, v15
	v_perm_b32 v14, v12, v16, s41
	v_perm_b32 v15, v12, v16, s42
	v_min_i32_e32 v12, 11, v46
	v_mul_lo_u32 v12, v12, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[10:11], v[18:21]
	v_sub_u32_e32 v62, 0x7c787470, v12
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[42:43], v[10:11], v[26:29]
	v_sub_u32_e32 v10, 0x6c686080, v12
	v_and_b32_e32 v47, 0xffffff00, v10
	v_and_b32_e32 v10, 0x7070707, v17
	v_lshrrev_b32_e32 v11, 4, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[40:41], v[14:15], v[22:25]
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v65, v64, v10
	v_perm_b32 v10, v49, v48, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[42:43], v[14:15], v[36:39]
	v_lshlrev_b32_e32 v14, 4, v17
	v_and_or_b32 v10, v12, v14, v10
	v_perm_b32 v12, v65, v64, v11
	v_perm_b32 v11, v49, v48, v11
	v_and_or_b32 v11, v12, v17, v11
	ds_read2st64_b64 v[14:17], v87 offset0:16 offset1:24
	v_perm_b32 v30, v11, v10, s41
	v_perm_b32 v31, v11, v10, s42
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v71, v69, v10
	v_lshlrev_b32_e32 v36, 4, v13
	v_perm_b32 v10, v68, v67, v10
	v_and_or_b32 v10, v12, v36, v10
	v_perm_b32 v12, v71, v69, v11
	v_perm_b32 v11, v68, v67, v11
	v_and_or_b32 v11, v12, v13, v11
	v_perm_b32 v44, v11, v10, s41
	v_perm_b32 v45, v11, v10, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[14:15], v[30:31], v[18:21]
	v_cndmask_b32_e64 v36, v47, 0, vcc
	v_cndmask_b32_e64 v37, v62, 0, vcc
	s_mov_b32 s3, 0x27000
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[14:15], v[44:45], v[22:25]
	v_add_u32_e32 v14, 0x7f7f7f00, v36
	v_and_b32_e32 v38, 0x80808000, v14
	v_add_u32_e32 v14, 0x7f7f7f78, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[16:17], v[30:31], v[26:29]
	v_and_b32_e32 v39, 0x80808080, v14
	s_mov_b32 s0, s6
	v_mov_b32_e32 v94, 0xfd800000
	v_and_b32_e32 v26, 0x7070707, v6
	v_lshrrev_b32_e32 v27, 4, v6
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v35, v34, v26
	v_lshlrev_b32_e32 v29, 4, v6
	v_perm_b32 v26, v33, v32, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v35, v34, v27
	v_perm_b32 v27, v33, v32, v27
	v_and_or_b32 v6, v28, v6, v27
	v_perm_b32 v30, v6, v26, s41
	v_perm_b32 v31, v6, v26, s42
	ds_read2st64_b64 v[26:29], v88 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[44:45], v[40:43]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v6, 0x7070707, v2
	v_cmp_lt_i32_e32 vcc, 5, v57
	s_mov_b32 s4, 0x43700000
	v_lshrrev_b32_e32 v40, 4, v2
	v_and_b32_e32 v40, 0x7070707, v40
	v_perm_b32 v41, v39, v38, v6
	v_lshlrev_b32_e32 v42, 4, v2
	v_perm_b32 v6, v37, v36, v6
	v_and_or_b32 v6, v41, v42, v6
	v_perm_b32 v41, v39, v38, v40
	v_perm_b32 v40, v37, v36, v40
	v_and_or_b32 v2, v41, v2, v40
	v_perm_b32 v40, v2, v6, s41
	v_perm_b32 v41, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[26:27], v[30:31], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v6
	s_and_b32 s25, s23, 0xffff
	s_mov_b32 s26, -1
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[26:27], v[40:41], v[10:13]
	v_perm_b32 v26, v35, v34, v2
	v_lshlrev_b32_e32 v27, 4, v7
	v_perm_b32 v2, v33, v32, v2
	v_and_or_b32 v2, v26, v27, v2
	v_perm_b32 v26, v35, v34, v6
	v_perm_b32 v6, v33, v32, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[28:29], v[30:31], v[22:25]
	v_and_or_b32 v7, v26, v7, v6
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[28:29], v[40:41], v[14:17]
	ds_read2st64_b64 v[26:29], v89 offset0:16 offset1:24
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v30, 4, v3
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v39, v38, v2
	v_lshlrev_b32_e32 v40, 4, v3
	v_perm_b32 v2, v37, v36, v2
	v_and_or_b32 v31, v31, v40, v2
	v_perm_b32 v2, v39, v38, v30
	v_perm_b32 v30, v37, v36, v30
	v_and_or_b32 v3, v2, v3, v30
	v_perm_b32 v2, v3, v31, s41
	v_perm_b32 v3, v3, v31, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[26:27], v[6:7], v[18:21]
	v_lshlrev_b32_e32 v30, 2, v53
	v_mov_b32_e32 v31, 0
	s_mov_b32 s24, s22
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[26:27], v[2:3], v[10:13]
	s_mov_b32 s27, s3
	s_mov_b32 s6, 0x400000
	s_mov_b32 s28, s14
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[28:29], v[2:3], v[14:17]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[28:29], v[6:7], v[22:25]
	v_perm_b32 v6, v35, v34, v2
	v_lshlrev_b32_e32 v7, 4, v8
	v_perm_b32 v2, v33, v32, v2
	ds_read2st64_b64 v[20:23], v90 offset0:16 offset1:24
	v_and_or_b32 v2, v6, v7, v2
	v_perm_b32 v6, v35, v34, v3
	v_perm_b32 v3, v33, v32, v3
	v_and_or_b32 v3, v6, v8, v3
	v_perm_b32 v48, v3, v2, s41
	v_perm_b32 v49, v3, v2, s42
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v6, v39, v38, v2
	v_lshlrev_b32_e32 v7, 4, v4
	v_perm_b32 v2, v37, v36, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v39, v38, v3
	v_perm_b32 v3, v37, v36, v3
	v_or_b32_e32 v28, s34, v30
	v_and_or_b32 v3, v2, v4, v3
	v_ashrrev_i32_e32 v29, 31, v28
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_lshl_add_u64 v[6:7], v[28:29], 2, s[20:21]
	global_load_dword v4, v[6:7], off
	v_lshl_add_u64 v[6:7], s[34:35], 0, v[30:31]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[20:21], v[48:49], v[40:43]
	s_movk_i32 s35, 0x7fff
	s_mov_b32 s31, s3
	s_mov_b32 s44, s18
	v_lshl_add_u64 v[40:41], v[6:7], 2, s[20:21]
	global_load_dwordx3 v[6:8], v[40:41], off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[2:3], v[44:47]
	global_load_dwordx4 v[40:43], v[40:41], off offset:64
	s_mov_b32 s46, s6
	s_mov_b32 s47, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[22:23], v[2:3], v[10:13]
	v_and_b32_e32 v2, 0x7070707, v9
	v_lshrrev_b32_e32 v3, 4, v9
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[22:23], v[48:49], v[24:27]
	v_perm_b32 v22, v35, v34, v2
	v_lshlrev_b32_e32 v23, 4, v9
	v_perm_b32 v2, v33, v32, v2
	v_and_or_b32 v29, v22, v23, v2
	s_mov_b32 s10, 0x800000
	s_mov_b32 s36, s16
	s_mov_b32 s38, s10
	s_mov_b32 s39, s3
	s_mov_b32 s11, s3
	s_mov_b32 s8, s16
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	s_and_b32 s21, s21, 0xffff
	v_lshlrev_b32_e32 v93, 2, v50
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v2, 2, v4
	v_and_b32_e32 v2, 0x3fffffc, v2
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v4, 2, v6
	v_and_b32_e32 v4, 0x3fffffc, v4
	buffer_load_dword v22, v2, s[0:3], 0 offen
	buffer_load_dword v23, v4, s[0:3], 0 offen
	v_perm_b32 v2, v35, v34, v3
	v_perm_b32 v3, v33, v32, v3
	ds_read2st64_b64 v[32:35], v1 offset0:16 offset1:24
	v_and_or_b32 v3, v2, v9, v3
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshrrev_b32_e32 v6, 4, v5
	v_perm_b32 v2, v3, v29, s41
	v_perm_b32 v3, v3, v29, s42
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v9, v39, v38, v4
	v_lshlrev_b32_e32 v29, 4, v5
	v_perm_b32 v4, v37, v36, v4
	v_and_or_b32 v9, v9, v29, v4
	v_perm_b32 v4, v39, v38, v6
	v_perm_b32 v6, v37, v36, v6
	v_and_or_b32 v5, v4, v5, v6
	v_lshlrev_b32_e32 v6, 2, v7
	v_perm_b32 v4, v5, v9, s41
	v_perm_b32 v5, v5, v9, s42
	v_and_b32_e32 v6, 0x3fffffc, v6
	v_lshlrev_b32_e32 v7, 2, v8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[32:33], v[2:3], v[14:17]
	v_and_b32_e32 v7, 0x3fffffc, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[32:33], v[4:5], v[18:21]
	buffer_load_dword v32, v6, s[0:3], 0 offen
	buffer_load_dword v33, v7, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[34:35], v[2:3], v[24:27]
	s_waitcnt vmcnt(4)
	v_lshlrev_b32_e32 v2, 2, v40
	v_and_b32_e32 v2, 0x3fffffc, v2
	v_lshlrev_b32_e32 v3, 2, v41
	v_and_b32_e32 v3, 0x3fffffc, v3
	buffer_load_dword v24, v2, s[0:3], 0 offen
	buffer_load_dword v25, v3, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[34:35], v[4:5], v[10:13]
	s_nop 2
	v_lshlrev_b32_e32 v12, 2, v42
	v_and_b32_e32 v12, 0x3fffffc, v12
	v_lshlrev_b32_e32 v13, 2, v43
	v_and_b32_e32 v13, 0x3fffffc, v13
	buffer_load_dword v34, v12, s[0:3], 0 offen
	buffer_load_dword v35, v13, s[0:3], 0 offen
	v_add_u32_e32 v11, 17, v57
	v_lshl_add_u32 v10, v57, 23, v94
	v_lshlrev_b32_e64 v11, v11, 1
	v_cndmask_b32_e32 v26, v11, v10, vcc
	s_mov_b32 s0, 0xbfb8aa3b
	v_add_u32_e32 v11, 17, v56
	v_lshl_add_u32 v10, v56, 23, v94
	v_lshlrev_b32_e64 v11, v11, 1
	v_cmp_lt_i32_e32 vcc, 5, v56
	s_lshl_b32 s2, s48, 8
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[12:13], v[26:27], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[14:15], v[12:13]
	v_cndmask_b32_e32 v36, v11, v10, vcc
	v_pk_mul_f32 v[12:13], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[22:23], v[36:37], v[22:23] op_sel_hi:[0,1]
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_pk_mul_f32 v[18:19], v[18:19], v[22:23]
	v_lshlrev_b32_e32 v27, 1, v55
	v_lshlrev_b32_e32 v10, 11, v53
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_or_b32_e32 v11, 0x4000, v10
	v_rcp_f32_e32 v38, v12
	v_rcp_f32_e32 v39, v13
	v_add_u32_e32 v29, v11, v27
	v_or_b32_e32 v12, 1, v30
	v_pk_mul_f32 v[14:15], v[14:15], v[38:39]
	s_nop 0
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	s_nop 0
	v_bfe_u32 v13, v15, 16, 1
	v_add3_u32 v13, v13, v15, s35
	v_or_b32_e32 v18, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	v_bfe_u32 v15, v14, 16, 1
	v_add3_u32 v15, v15, v14, s35
	v_cndmask_b32_e32 v13, v13, v18, vcc
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[18:19], v[26:27], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[16:17], v[18:19]
	v_or_b32_e32 v22, 0x400000, v14
	v_pk_mul_f32 v[18:19], v[16:17], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v14, v14
	v_exp_f32_e32 v18, v18
	v_exp_f32_e32 v19, v19
	v_cndmask_b32_e32 v14, v15, v22, vcc
	ds_write_b16_d16_hi v29, v14
	v_lshl_add_u32 v22, v12, 9, v27
	v_pk_add_f32 v[14:15], v[18:19], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[18:19], v[36:37], v[32:33] op_sel_hi:[0,1]
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_pk_mul_f32 v[18:19], v[20:21], v[18:19]
	ds_write_b16_d16_hi v22, v13 offset:16384
	v_pk_mul_f32 v[14:15], v[16:17], v[14:15]
	s_nop 0
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	s_nop 0
	v_bfe_u32 v13, v15, 16, 1
	v_add3_u32 v13, v13, v15, s35
	v_or_b32_e32 v16, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	v_bfe_u32 v15, v14, 16, 1
	v_add3_u32 v15, v15, v14, s35
	v_cndmask_b32_e32 v13, v13, v16, vcc
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[16:17], v[26:27], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[16:17]
	v_or_b32_e32 v18, 0x400000, v14
	v_pk_mul_f32 v[16:17], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v14, v14
	v_exp_f32_e32 v16, v16
	v_exp_f32_e32 v17, v17
	v_cndmask_b32_e32 v14, v15, v18, vcc
	ds_write_b16_d16_hi v22, v14 offset:16896
	ds_write_b16_d16_hi v22, v13 offset:17408
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
	v_cndmask_b32_e32 v13, v6, v7, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[26:27], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_or_b32_e32 v14, 0x400000, v2
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v2, v3, v14, vcc
	ds_write_b16_d16_hi v22, v2 offset:24064
	ds_write_b16_d16_hi v22, v13 offset:24576
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[36:37], v[34:35] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_mov_b32_e32 v8, 0x7fc00000
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_lshlrev_b32_e32 v7, 2, v54
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
	ds_write_b16_d16_hi v22, v2 offset:25088
	ds_write_b16_d16_hi v22, v3 offset:25600
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
	v_max_f32_e32 v13, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	v_xor_b32_e32 v9, 0x80, v7
	s_nop 0
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_bpermute_b32 v13, v9, v6
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v6, v13
	v_cmp_o_f32_e32 vcc, v6, v13
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v14, vcc
	v_div_scale_f32 v13, s[0:1], s4, s4, v6
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v6, s4, v6
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s4, v6
	v_cmp_neq_f32_e32 vcc, 0, v6
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v6, s[0:1], v13, v13, 1.0
	v_rcp_f32_e32 v14, v6
	s_lshl_b32 s0, s48, 2
	v_fma_f32 v15, -v6, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v6, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v6, -v6, v16, v15
	v_div_fmas_f32 v6, v6, v14, v16
	v_div_fixup_f32 v6, v6, v13, 1.0
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[6:7], v[4:5] op_sel_hi:[0,1]
	v_min_f32_e32 v6, 0x43700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	v_mov_b32_e32 v14, s0
	s_and_b32 s0, s9, 0xf0
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	ds_write_b32 v14, v13 offset:8192
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
	v_lshl_or_b32 v2, v54, 3, s0
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
	v_max_f32_e64 v13, v6, |v3|
	v_cmp_o_f32_e64 vcc, v6, |v3|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	v_max_f32_e64 v13, v6, |v4|
	v_cmp_o_f32_e64 vcc, v6, |v4|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	v_max_f32_e64 v13, v6, |v5|
	v_cmp_o_f32_e64 vcc, v6, |v5|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	ds_swizzle_b32 v13, v6 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v15, v6, v13
	v_cmp_o_f32_e32 vcc, v6, v13
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v15, vcc
	ds_swizzle_b32 v13, v6 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v15, v6, v13
	v_cmp_o_f32_e32 vcc, v6, v13
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v15, vcc
	ds_swizzle_b32 v13, v6 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v15, v6, v13
	v_cmp_o_f32_e32 vcc, v6, v13
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v15, vcc
	ds_swizzle_b32 v13, v6 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v15, v6, v13
	v_cmp_o_f32_e32 vcc, v6, v13
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v15, vcc
	ds_swizzle_b32 v13, v6 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v15, v6, v13
	v_cmp_o_f32_e32 vcc, v6, v13
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v15, vcc
	ds_bpermute_b32 v9, v9, v6
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v13, vcc
	v_div_scale_f32 v9, s[0:1], s4, s4, v6
	v_rcp_f32_e32 v13, v9
	s_nop 0
	v_fma_f32 v15, -v9, v13, 1.0
	v_fmac_f32_e32 v13, v15, v13
	v_div_scale_f32 v15, vcc, v6, s4, v6
	v_mul_f32_e32 v16, v15, v13
	v_fma_f32 v17, -v9, v16, v15
	v_fmac_f32_e32 v16, v17, v13
	v_fma_f32 v9, -v9, v16, v15
	v_div_fmas_f32 v9, v9, v13, v16
	v_div_fixup_f32 v9, v9, s4, v6
	v_cmp_neq_f32_e32 vcc, 0, v6
	s_nop 1
	v_cndmask_b32_e32 v9, 1.0, v9, vcc
	v_div_scale_f32 v6, s[0:1], v9, v9, 1.0
	v_rcp_f32_e32 v13, v6
	s_and_b32 s1, s15, 0xffff
	s_lshl_b32 s15, s48, 5
	s_add_i32 s17, s17, s15
	v_fma_f32 v15, -v6, v13, 1.0
	v_fmac_f32_e32 v13, v15, v13
	v_div_scale_f32 v15, vcc, 1.0, v9, 1.0
	v_mul_f32_e32 v16, v15, v13
	v_fma_f32 v17, -v6, v16, v15
	v_fmac_f32_e32 v16, v17, v13
	v_fma_f32 v6, -v6, v16, v15
	v_div_fmas_f32 v6, v6, v13, v16
	v_div_fixup_f32 v6, v6, v9, 1.0
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[6:7], v[4:5] op_sel_hi:[0,1]
	v_min_f32_e32 v6, 0x43700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	ds_write_b32 v14, v9 offset:8256
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
	v_or_b32_e32 v2, s34, v12
	v_lshlrev_b32_e32 v2, 2, v2
	v_or_b32_e32 v12, s15, v82
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
	v_or3_b32 v3, s0, v51, v82
	s_lshl_b32 s0, s17, 3
	v_or3_b32 v4, s0, v51, v82
	s_or_b32 s0, s17, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_or_b32_e32 v2, s17, v82
	v_lshlrev_b32_e32 v4, 4, v4
	s_add_i32 s7, s7, s4
	v_lshlrev_b32_e32 v2, 2, v2
	buffer_load_dwordx4 v[38:41], v4, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[34:37], v4, s[28:31], 0 offen offset:1024 nt
	v_or_b32_e32 v4, s0, v82
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dword v111, v2, s[44:47], 0 offen
	buffer_load_dword v110, v4, s[44:47], 0 offen
	v_or3_b32 v2, s4, v51, v82
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s0, 3
	buffer_load_dword v46, v3, s[36:39], 0 offen
	buffer_load_dword v104, v2, s[36:39], 0 offen
	v_or3_b32 v2, s0, v51, v82
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[30:33], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[26:29], v3, s[28:31], 0 offen nt
	v_lshlrev_b32_e32 v2, 4, v53
	ds_read_b128 v[6:9], v2 offset:8192
	ds_read_b128 v[2:5], v2 offset:8256
	v_lshlrev_b32_e32 v12, 1, v12
	v_add3_u32 v99, v11, v10, v12
	v_lshlrev_b32_e32 v10, 1, v0
	v_and_b32_e32 v105, 62, v10
	v_mov_b32_e32 v10, 0x4000
	v_lshl_add_u32 v92, v52, 10, v10
	v_lshlrev_b32_e32 v10, 2, v0
	v_lshlrev_b32_e32 v0, 4, v0
	s_mov_b32 s0, s14
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_add_i32 s18, s17, 0x200
	v_add_u32_e32 v100, 0x400, v99
	v_add_u32_e32 v101, 0x800, v99
	v_add_u32_e32 v102, 0xc00, v99
	v_add_u32_e32 v95, 0x4000, v99
	v_add_u32_e32 v96, 0x4400, v99
	v_add_u32_e32 v97, 0x4800, v99
	v_add_u32_e32 v98, 0x4c00, v99
	v_lshlrev_b32_e32 v91, 1, v105
	v_and_b32_e32 v106, 0xfc, v10
	v_and_b32_e32 v107, 0x3f0, v0
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[14:15]
	s_add_i32 s19, s19, 1
	s_cmp_lg_u32 s19, 7
	v_mov_b64_e32 v[40:41], v[24:25]
	v_mov_b64_e32 v[38:39], v[22:23]
	v_mov_b64_e32 v[36:37], v[20:21]
	v_mov_b64_e32 v[34:35], v[18:19]
	v_mov_b64_e32 v[32:33], v[16:17]
	v_mov_b64_e32 v[30:31], v[14:15]
	v_mov_b64_e32 v[28:29], v[12:13]
	v_mov_b64_e32 v[26:27], v[10:11]
	v_mov_b32_e32 v110, v0
	v_mov_b32_e32 v111, v103
	v_mov_b32_e32 v46, v108
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
	v_bfe_u32 v113, v104, s14, 8
	s_add_i32 s14, s14, 16
	v_bfe_u32 v112, v104, s14, 8
	s_add_i32 s14, s18, s24
	v_or_b32_e32 v0, s14, v82
	v_lshl_or_b32 v10, s14, 3, v106
	v_lshl_or_b32 v11, s14, 7, v107
	s_or_b32 s15, s14, 16
	s_ashr_i32 s14, s14, 31
	s_lshr_b32 s25, s14, 27
	s_add_i32 s25, s15, s25
	buffer_load_dwordx4 v[22:25], v11, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[18:21], v11, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v11, s15, v82
	s_lshr_b32 s25, s25, 5
	v_lshlrev_b32_e32 v0, 2, v0
	v_lshlrev_b32_e32 v11, 2, v11
	s_add_i32 s25, s25, s14
	buffer_load_dword v103, v0, s[4:7], 0 offen
	s_nop 0
	buffer_load_dword v0, v11, s[4:7], 0 offen
	v_lshl_or_b32 v11, s25, 8, v106
	buffer_load_dword v108, v10, s[8:11], 0 offen
	buffer_load_dword v104, v11, s[8:11], 0 offen
	v_lshl_or_b32 v10, s15, 7, v107
	buffer_load_dwordx4 v[14:17], v10, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[10:13], v10, s[0:3], 0 offen offset:1024 nt
	v_sub_u32_sdwa v42, v111, v46 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s40
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	v_add_u32_e32 v109, v83, v84
	v_cndmask_b32_e64 v66, v44, 0, vcc
	v_cndmask_b32_e64 v67, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v66
	v_and_b32_e32 v68, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v67
	v_and_b32_e32 v69, 0x80808080, v42
	v_lshrrev_b32_e32 v42, 4, v38
	v_and_b32_e32 v48, 0x7070707, v42
	ds_read2st64_b64 v[42:45], v109 offset1:8
	v_and_b32_e32 v47, 0x7070707, v38
	v_perm_b32 v49, v69, v68, v47
	v_lshlrev_b32_e32 v50, 4, v38
	v_perm_b32 v47, v67, v66, v47
	v_and_or_b32 v47, v49, v50, v47
	v_perm_b32 v49, v69, v68, v48
	v_perm_b32 v48, v67, v66, v48
	v_and_or_b32 v38, v49, v38, v48
	v_perm_b32 v48, v38, v47, s41
	v_perm_b32 v49, v38, v47, s42
	v_sub_u32_sdwa v62, v111, v46 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshrrev_b32_e32 v46, 4, v39
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[42:43], v[48:49], 0
	v_and_b32_e32 v58, 0x7070707, v46
	v_min_i32_e32 v38, 11, v62
	v_mul_lo_u32 v63, v38, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[44:45], v[48:49], 0
	ds_read2st64_b64 v[46:49], v85 offset1:8
	v_and_b32_e32 v38, 0x7070707, v39
	v_perm_b32 v59, v69, v68, v38
	v_lshlrev_b32_e32 v60, 4, v39
	v_perm_b32 v38, v67, v66, v38
	v_and_or_b32 v59, v59, v60, v38
	v_perm_b32 v38, v69, v68, v58
	v_perm_b32 v58, v67, v66, v58
	v_and_or_b32 v39, v38, v39, v58
	v_perm_b32 v38, v39, v59, s41
	v_perm_b32 v39, v39, v59, s42
	v_lshlrev_b32_e32 v70, 4, v40
	v_cmp_lt_i32_e32 vcc, 11, v62
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[46:47], v[38:39], v[50:53]
	v_lshlrev_b32_e32 v71, 4, v41
	v_lshlrev_b32_e32 v72, 4, v35
	v_lshlrev_b32_e32 v115, 4, v36
	v_sub_u32_e32 v50, 0x6c686080, v63
	v_and_b32_e32 v64, 0xffffff00, v50
	ds_read2st64_b64 v[50:53], v86 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[48:49], v[38:39], v[54:57]
	v_and_b32_e32 v38, 0x7070707, v40
	v_lshrrev_b32_e32 v39, 4, v40
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v65, v69, v68, v38
	v_perm_b32 v38, v67, v66, v38
	v_and_or_b32 v65, v65, v70, v38
	v_perm_b32 v38, v69, v68, v39
	v_perm_b32 v39, v67, v66, v39
	v_and_or_b32 v39, v38, v40, v39
	v_sub_u32_e32 v63, 0x7c787470, v63
	v_perm_b32 v38, v39, v65, s41
	v_perm_b32 v39, v39, v65, s42
	v_cndmask_b32_e64 v122, v64, 0, vcc
	v_cndmask_b32_e64 v123, v63, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[52:53], v[38:39], v[54:57]
	v_add_u32_e32 v40, 0x7f7f7f00, v122
	v_and_b32_e32 v124, 0x80808000, v40
	v_add_u32_e32 v40, 0x7f7f7f78, v123
	ds_read2st64_b64 v[54:57], v87 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[50:51], v[38:39], v[58:61]
	v_and_b32_e32 v38, 0x7070707, v41
	v_lshrrev_b32_e32 v39, 4, v41
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v70, v69, v68, v38
	v_perm_b32 v38, v67, v66, v38
	v_and_or_b32 v70, v70, v71, v38
	v_perm_b32 v38, v69, v68, v39
	v_perm_b32 v39, v67, v66, v39
	v_and_or_b32 v39, v38, v41, v39
	v_perm_b32 v38, v39, v70, s41
	v_perm_b32 v39, v39, v70, s42
	v_and_b32_e32 v125, 0x80808080, v40
	v_and_b32_e32 v66, 0x7070707, v34
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[54:55], v[38:39], v[58:61]
	v_perm_b32 v68, v125, v124, v66
	v_lshlrev_b32_e32 v69, 4, v34
	v_perm_b32 v66, v123, v122, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[56:57], v[38:39], v[62:65]
	v_lshrrev_b32_e32 v38, 4, v34
	v_and_b32_e32 v67, 0x7070707, v38
	ds_read2st64_b64 v[38:41], v88 offset1:8
	v_and_or_b32 v66, v68, v69, v66
	v_perm_b32 v68, v125, v124, v67
	v_perm_b32 v67, v123, v122, v67
	v_and_or_b32 v34, v68, v34, v67
	v_perm_b32 v70, v34, v66, s41
	v_perm_b32 v71, v34, v66, s42
	v_and_b32_e32 v34, 0x7070707, v35
	v_sub_u32_e32 v113, v110, v113
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[38:39], v[70:71], v[58:61]
	v_cmp_lt_i32_e32 vcc, 11, v113
	s_nop 1
	v_lshrrev_b32_e32 v58, 4, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[40:41], v[70:71], v[62:65]
	v_and_b32_e32 v70, 0x7070707, v58
	ds_read2st64_b64 v[58:61], v89 offset1:8
	v_perm_b32 v71, v125, v124, v34
	v_perm_b32 v34, v123, v122, v34
	v_and_or_b32 v71, v71, v72, v34
	v_perm_b32 v34, v125, v124, v70
	v_perm_b32 v70, v123, v122, v70
	v_and_or_b32 v35, v34, v35, v70
	v_perm_b32 v34, v35, v71, s41
	v_perm_b32 v35, v35, v71, s42
	s_waitcnt lgkmcnt(0)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[58:59], v[34:35], v[66:69]
	s_nop 2
	ds_read2st64_b64 v[66:69], v90 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[60:61], v[34:35], v[62:65]
	v_and_b32_e32 v34, 0x7070707, v36
	v_lshrrev_b32_e32 v35, 4, v36
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v114, v125, v124, v34
	v_perm_b32 v34, v123, v122, v34
	v_and_or_b32 v114, v114, v115, v34
	v_perm_b32 v34, v125, v124, v35
	v_perm_b32 v35, v123, v122, v35
	v_and_or_b32 v35, v34, v36, v35
	v_perm_b32 v34, v35, v114, s41
	v_perm_b32 v35, v35, v114, s42
	s_waitcnt lgkmcnt(0)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[66:67], v[34:35], v[70:73]
	s_nop 2
	ds_read2st64_b64 v[70:73], v1 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[68:69], v[34:35], v[62:65]
	v_and_b32_e32 v34, 0x7070707, v37
	v_lshrrev_b32_e32 v35, 4, v37
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v125, v124, v34
	v_lshlrev_b32_e32 v62, 4, v37
	v_perm_b32 v34, v123, v122, v34
	v_and_or_b32 v36, v36, v62, v34
	v_perm_b32 v34, v125, v124, v35
	v_perm_b32 v35, v123, v122, v35
	v_and_or_b32 v35, v34, v37, v35
	v_perm_b32 v34, v35, v36, s41
	v_perm_b32 v35, v35, v36, s42
	v_sub_u32_e32 v124, v110, v112
	s_waitcnt vmcnt(9)
	v_lshrrev_b32_e32 v112, 4, v31
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[70:71], v[34:35], v[114:117]
	v_and_b32_e32 v112, 0x7070707, v112
	s_nop 1
	v_min_i32_e32 v114, 11, v113
	v_mul_lo_u32 v114, v114, s40
	v_sub_u32_e32 v115, 0x6c686080, v114
	v_and_b32_e32 v115, 0xffffff00, v115
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[72:73], v[34:35], v[118:121]
	v_sub_u32_e32 v114, 0x7c787470, v114
	v_lshlrev_b32_e32 v116, 4, v30
	s_nop 0
	v_cndmask_b32_e64 v120, v115, 0, vcc
	v_cndmask_b32_e64 v121, v114, 0, vcc
	v_add_u32_e32 v113, 0x7f7f7f00, v120
	v_and_b32_e32 v122, 0x80808000, v113
	v_add_u32_e32 v113, 0x7f7f7f78, v121
	v_and_b32_e32 v123, 0x80808080, v113
	v_and_b32_e32 v113, 0x7070707, v30
	v_lshrrev_b32_e32 v114, 4, v30
	v_and_b32_e32 v114, 0x7070707, v114
	v_perm_b32 v115, v123, v122, v113
	v_perm_b32 v113, v121, v120, v113
	v_and_or_b32 v113, v115, v116, v113
	v_perm_b32 v115, v123, v122, v114
	v_perm_b32 v114, v121, v120, v114
	v_and_or_b32 v30, v115, v30, v114
	v_perm_b32 v118, v30, v113, s41
	v_perm_b32 v119, v30, v113, s42
	v_min_i32_e32 v30, 11, v124
	v_mul_lo_u32 v125, v30, s40
	v_and_b32_e32 v30, 0x7070707, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[42:43], v[118:119], 0
	v_perm_b32 v113, v123, v122, v30
	v_perm_b32 v30, v121, v120, v30
	v_cmp_lt_i32_e32 vcc, 11, v124
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[44:45], v[118:119], 0
	v_lshlrev_b32_e32 v118, 4, v31
	v_and_or_b32 v113, v113, v118, v30
	v_perm_b32 v30, v123, v122, v112
	v_perm_b32 v112, v121, v120, v112
	v_and_or_b32 v31, v30, v31, v112
	v_perm_b32 v30, v31, v113, s41
	v_perm_b32 v31, v31, v113, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[112:115], v[46:47], v[30:31], v[114:117]
	v_sub_u32_e32 v46, 0x6c686080, v125
	v_lshlrev_b32_e32 v47, 4, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[48:49], v[30:31], v[42:45]
	v_and_b32_e32 v30, 0x7070707, v32
	v_lshrrev_b32_e32 v31, 4, v32
	v_and_b32_e32 v116, 0xffffff00, v46
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v46, v123, v122, v30
	v_perm_b32 v30, v121, v120, v30
	v_and_or_b32 v46, v46, v47, v30
	v_perm_b32 v30, v123, v122, v31
	v_perm_b32 v31, v121, v120, v31
	v_and_or_b32 v31, v30, v32, v31
	v_perm_b32 v30, v31, v46, s41
	v_perm_b32 v31, v31, v46, s42
	v_sub_u32_e32 v117, 0x7c787470, v125
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[50:51], v[30:31], v[112:115]
	v_lshlrev_b32_e32 v50, 4, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[52:53], v[30:31], v[42:45]
	v_and_b32_e32 v30, 0x7070707, v33
	v_lshrrev_b32_e32 v31, 4, v33
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v123, v122, v30
	v_perm_b32 v30, v121, v120, v30
	v_and_or_b32 v30, v32, v50, v30
	v_perm_b32 v32, v123, v122, v31
	v_perm_b32 v31, v121, v120, v31
	v_and_or_b32 v31, v32, v33, v31
	v_cndmask_b32_e64 v112, v116, 0, vcc
	v_cndmask_b32_e64 v113, v117, 0, vcc
	v_perm_b32 v50, v31, v30, s41
	v_perm_b32 v51, v31, v30, s42
	v_add_u32_e32 v114, 0x7f7f7f00, v112
	v_cmp_lt_i32_e32 vcc, 5, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[54:55], v[50:51], v[46:49]
	s_nop 2
	v_add_u32_e32 v46, 0x7f7f7f78, v113
	v_and_b32_e32 v48, 0x80808000, v114
	v_and_b32_e32 v49, 0x80808080, v46
	s_waitcnt vmcnt(8)
	v_and_b32_e32 v46, 0x7070707, v26
	v_lshrrev_b32_e32 v47, 4, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[56:57], v[50:51], v[42:45]
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v50, v49, v48, v46
	v_lshlrev_b32_e32 v51, 4, v26
	v_perm_b32 v46, v113, v112, v46
	v_and_or_b32 v50, v50, v51, v46
	v_perm_b32 v46, v49, v48, v47
	v_perm_b32 v47, v113, v112, v47
	v_and_or_b32 v26, v46, v26, v47
	v_perm_b32 v46, v26, v50, s41
	v_perm_b32 v47, v26, v50, s42
	v_and_b32_e32 v26, 0x7070707, v27
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[38:39], v[46:47], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[40:41], v[46:47], v[42:45]
	s_nop 2
	v_lshrrev_b32_e32 v42, 4, v27
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v49, v48, v26
	v_lshlrev_b32_e32 v44, 4, v27
	v_perm_b32 v26, v113, v112, v26
	v_and_or_b32 v43, v43, v44, v26
	v_perm_b32 v26, v49, v48, v42
	v_perm_b32 v42, v113, v112, v42
	v_and_or_b32 v27, v26, v27, v42
	v_perm_b32 v26, v27, v43, s41
	v_perm_b32 v27, v27, v43, s42
	v_lshlrev_b32_e32 v43, 4, v28
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[58:59], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[60:61], v[26:27], v[38:41]
	v_and_b32_e32 v26, 0x7070707, v28
	v_lshrrev_b32_e32 v27, 4, v28
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v42, v49, v48, v26
	v_perm_b32 v26, v113, v112, v26
	v_and_or_b32 v42, v42, v43, v26
	v_perm_b32 v26, v49, v48, v27
	v_perm_b32 v27, v113, v112, v27
	v_and_or_b32 v27, v26, v28, v27
	v_perm_b32 v26, v27, v42, s41
	v_perm_b32 v27, v27, v42, s42
	v_lshlrev_b32_e32 v42, 4, v29
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[66:67], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[68:69], v[26:27], v[38:41]
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v49, v48, v26
	v_perm_b32 v26, v113, v112, v26
	v_and_or_b32 v26, v28, v42, v26
	v_perm_b32 v28, v49, v48, v27
	v_perm_b32 v27, v113, v112, v27
	v_and_or_b32 v27, v28, v29, v27
	v_perm_b32 v42, v27, v26, s41
	v_perm_b32 v43, v27, v26, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[70:71], v[42:43], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[72:73], v[42:43], v[38:41]
	s_nop 2
	v_add_u32_e32 v39, 17, v111
	v_lshl_add_u32 v38, v111, 23, v94
	v_lshlrev_b32_e64 v39, v39, 1
	v_cndmask_b32_e32 v38, v39, v38, vcc
	v_lshl_add_u32 v39, v110, 23, v94
	v_pk_mul_f32 v[44:45], v[8:9], v[38:39] op_sel_hi:[1,0]
	v_add_u32_e32 v40, 17, v110
	v_pk_mul_f32 v[44:45], v[44:45], v[64:65]
	v_lshlrev_b32_e64 v40, v40, 1
	v_cmp_lt_i32_e32 vcc, 5, v110
	v_pk_mul_f32 v[44:45], v[44:45], v[80:81]
	v_pk_mul_f32 v[42:43], v[6:7], v[38:39] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v40, v40, v39, vcc
	v_bfe_u32 v39, v45, 16, 1
	v_pk_mul_f32 v[42:43], v[42:43], v[62:63]
	v_add3_u32 v39, v39, v45, s35
	v_or_b32_e32 v41, 0x400000, v45
	v_cmp_u_f32_e32 vcc, v45, v45
	v_pk_mul_f32 v[42:43], v[42:43], v[78:79]
	v_or_b32_e32 v45, 0x400000, v44
	v_cndmask_b32_e32 v39, v39, v41, vcc
	v_bfe_u32 v41, v44, 16, 1
	v_add3_u32 v41, v41, v44, s35
	v_cmp_u_f32_e32 vcc, v44, v44
	v_bfe_u32 v44, v43, 16, 1
	v_add3_u32 v44, v44, v43, s35
	v_cndmask_b32_e32 v41, v41, v45, vcc
	v_or_b32_e32 v45, 0x400000, v43
	v_cmp_u_f32_e32 vcc, v43, v43
	s_nop 1
	v_cndmask_b32_e32 v43, v44, v45, vcc
	v_bfe_u32 v44, v42, 16, 1
	v_add3_u32 v44, v44, v42, s35
	v_or_b32_e32 v45, 0x400000, v42
	v_cmp_u_f32_e32 vcc, v42, v42
	s_nop 1
	v_cndmask_b32_e32 v42, v44, v45, vcc
	v_pk_mul_f32 v[44:45], v[8:9], v[40:41] op_sel_hi:[1,0]
	ds_write_b16_d16_hi v99, v42
	ds_write_b16_d16_hi v100, v43
	ds_write_b16_d16_hi v101, v41
	ds_write_b16_d16_hi v102, v39
	v_pk_mul_f32 v[28:29], v[44:45], v[28:29]
	v_pk_mul_f32 v[42:43], v[6:7], v[40:41] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[28:29], v[80:81]
	v_pk_mul_f32 v[26:27], v[42:43], v[26:27]
	v_bfe_u32 v39, v29, 16, 1
	v_add3_u32 v39, v39, v29, s35
	v_or_b32_e32 v41, 0x400000, v29
	v_cmp_u_f32_e32 vcc, v29, v29
	v_pk_mul_f32 v[26:27], v[26:27], v[78:79]
	s_nop 0
	v_cndmask_b32_e32 v29, v39, v41, vcc
	v_bfe_u32 v39, v28, 16, 1
	v_add3_u32 v39, v39, v28, s35
	v_or_b32_e32 v41, 0x400000, v28
	v_cmp_u_f32_e32 vcc, v28, v28
	s_nop 1
	v_cndmask_b32_e32 v28, v39, v41, vcc
	v_bfe_u32 v39, v27, 16, 1
	v_add3_u32 v39, v39, v27, s35
	v_or_b32_e32 v41, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	s_nop 1
	v_cndmask_b32_e32 v27, v39, v41, vcc
	v_bfe_u32 v39, v26, 16, 1
	v_add3_u32 v39, v39, v26, s35
	v_or_b32_e32 v41, 0x400000, v26
	v_cmp_u_f32_e32 vcc, v26, v26
	s_nop 1
	v_cndmask_b32_e32 v26, v39, v41, vcc
	ds_write_b16_d16_hi v99, v26 offset:32
	ds_write_b16_d16_hi v100, v27 offset:32
	ds_write_b16_d16_hi v101, v28 offset:32
	ds_write_b16_d16_hi v102, v29 offset:32
	v_pk_mul_f32 v[28:29], v[4:5], v[38:39] op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[2:3], v[38:39] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[28:29], v[36:37]
	v_pk_mul_f32 v[26:27], v[26:27], v[34:35]
	v_pk_mul_f32 v[28:29], v[28:29], v[76:77]
	v_pk_mul_f32 v[26:27], v[26:27], v[74:75]
	v_bfe_u32 v34, v29, 16, 1
	v_add3_u32 v34, v34, v29, s35
	v_or_b32_e32 v35, 0x400000, v29
	v_cmp_u_f32_e32 vcc, v29, v29
	s_nop 1
	v_cndmask_b32_e32 v29, v34, v35, vcc
	v_bfe_u32 v34, v28, 16, 1
	v_add3_u32 v34, v34, v28, s35
	v_or_b32_e32 v35, 0x400000, v28
	v_cmp_u_f32_e32 vcc, v28, v28
	s_nop 1
	v_cndmask_b32_e32 v28, v34, v35, vcc
	v_bfe_u32 v34, v27, 16, 1
	v_add3_u32 v34, v34, v27, s35
	v_or_b32_e32 v35, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	s_nop 1
	v_cndmask_b32_e32 v27, v34, v35, vcc
	v_bfe_u32 v34, v26, 16, 1
	v_add3_u32 v34, v34, v26, s35
	v_or_b32_e32 v35, 0x400000, v26
	v_cmp_u_f32_e32 vcc, v26, v26
	s_nop 1
	v_cndmask_b32_e32 v26, v34, v35, vcc
	ds_write_b16_d16_hi v95, v26
	ds_write_b16_d16_hi v96, v27
	ds_write_b16_d16_hi v97, v28
	ds_write_b16_d16_hi v98, v29
	v_pk_mul_f32 v[28:29], v[4:5], v[40:41] op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[2:3], v[40:41] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31]
	v_pk_mul_f32 v[28:29], v[28:29], v[76:77]
	v_pk_mul_f32 v[26:27], v[26:27], v[74:75]
	v_bfe_u32 v30, v29, 16, 1
	v_add3_u32 v30, v30, v29, s35
	v_or_b32_e32 v31, 0x400000, v29
	v_cmp_u_f32_e32 vcc, v29, v29
	s_nop 1
	v_cndmask_b32_e32 v29, v30, v31, vcc
	v_bfe_u32 v30, v28, 16, 1
	v_add3_u32 v30, v30, v28, s35
	v_or_b32_e32 v31, 0x400000, v28
	v_cmp_u_f32_e32 vcc, v28, v28
	s_nop 1
	v_cndmask_b32_e32 v28, v30, v31, vcc
	v_bfe_u32 v30, v27, 16, 1
	v_add3_u32 v30, v30, v27, s35
	v_or_b32_e32 v31, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	s_nop 1
	v_cndmask_b32_e32 v27, v30, v31, vcc
	v_bfe_u32 v30, v26, 16, 1
	v_add3_u32 v30, v30, v26, s35
	v_or_b32_e32 v31, 0x400000, v26
	v_cmp_u_f32_e32 vcc, v26, v26
	s_nop 1
	v_cndmask_b32_e32 v26, v30, v31, vcc
	ds_write_b16_d16_hi v95, v26 offset:32
	ds_write_b16_d16_hi v96, v27 offset:32
	ds_write_b16_d16_hi v97, v28 offset:32
	ds_write_b16_d16_hi v98, v29 offset:32
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v26, v93, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v27, 0xffffff, v26
	v_cmp_gt_i32_e32 vcc, s33, v27
	s_and_saveexec_b64 s[14:15], vcc
	s_cbranch_execz .LBB0_4
	v_add_u32_e32 v28, v92, v91
	v_lshl_add_u32 v26, v26, 12, s24
	ds_read_b32 v29, v28
	v_or_b32_e32 v26, v26, v105
	v_lshlrev_b32_e32 v26, 1, v26
	v_ashrrev_i32_e32 v27, 31, v26
	v_lshl_add_u64 v[26:27], s[12:13], 0, v[26:27]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off
	ds_read_b32 v29, v28 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off offset:128
	ds_read_b32 v29, v28 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off offset:256
	ds_read_b32 v29, v28 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off offset:384
	ds_read_b32 v29, v28 offset:512
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off offset:512
	ds_read_b32 v29, v28 offset:640
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off offset:640
	ds_read_b32 v29, v28 offset:768
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v29, off offset:768
	ds_read_b32 v28, v28 offset:896
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v28, off offset:896
	s_branch .LBB0_4
.LBB0_7:
	v_sub_u32_sdwa v26, v103, v108 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v27, 11, v26
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v27, v27, s2
	v_sub_u32_e32 v28, 0x6c686080, v27
	v_and_b32_e32 v28, 0xffffff00, v28
	v_cmp_lt_i32_e32 vcc, 11, v26
	v_sub_u32_e32 v27, 0x7c787470, v27
	v_lshlrev_b32_e32 v32, 4, v22
	v_cndmask_b32_e64 v50, v28, 0, vcc
	v_cndmask_b32_e64 v51, v27, 0, vcc
	v_add_u32_e32 v26, 0x7f7f7f00, v50
	v_and_b32_e32 v52, 0x80808000, v26
	v_add_u32_e32 v26, 0x7f7f7f78, v51
	v_and_b32_e32 v53, 0x80808080, v26
	v_and_b32_e32 v26, 0x7070707, v22
	v_lshrrev_b32_e32 v27, 4, v22
	v_and_b32_e32 v30, 0x7070707, v27
	v_perm_b32 v31, v53, v52, v26
	v_perm_b32 v33, v51, v50, v26
	ds_read2st64_b64 v[26:29], v109 offset1:8
	v_and_or_b32 v31, v31, v32, v33
	v_perm_b32 v32, v53, v52, v30
	v_perm_b32 v30, v51, v50, v30
	v_and_or_b32 v22, v32, v22, v30
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_perm_b32 v30, v22, v31, s0
	v_perm_b32 v31, v22, v31, s1
	v_sub_u32_sdwa v46, v103, v108 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v22, 11, v46
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[26:27], v[30:31], 0
	v_mul_lo_u32 v47, v22, s2
	v_and_b32_e32 v22, 0x7070707, v23
	v_perm_b32 v43, v53, v52, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[28:29], v[30:31], 0
	v_lshrrev_b32_e32 v30, 4, v23
	v_and_b32_e32 v42, 0x7070707, v30
	ds_read2st64_b64 v[30:33], v85 offset1:8
	v_lshlrev_b32_e32 v44, 4, v23
	v_perm_b32 v22, v51, v50, v22
	v_and_or_b32 v43, v43, v44, v22
	v_perm_b32 v22, v53, v52, v42
	v_perm_b32 v42, v51, v50, v42
	v_and_or_b32 v23, v22, v23, v42
	v_perm_b32 v22, v23, v43, s0
	v_perm_b32 v23, v23, v43, s1
	v_lshlrev_b32_e32 v54, 4, v24
	v_cmp_lt_i32_e32 vcc, 11, v46
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[30:31], v[22:23], v[34:37]
	v_lshlrev_b32_e32 v55, 4, v25
	v_lshlrev_b32_e32 v56, 4, v19
	v_lshlrev_b32_e32 v59, 4, v20
	v_sub_u32_e32 v34, 0x6c686080, v47
	v_and_b32_e32 v48, 0xffffff00, v34
	ds_read2st64_b64 v[34:37], v86 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[32:33], v[22:23], v[38:41]
	v_and_b32_e32 v22, 0x7070707, v24
	v_lshrrev_b32_e32 v23, 4, v24
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v49, v53, v52, v22
	v_perm_b32 v22, v51, v50, v22
	v_and_or_b32 v49, v49, v54, v22
	v_perm_b32 v22, v53, v52, v23
	v_perm_b32 v23, v51, v50, v23
	v_and_or_b32 v23, v22, v24, v23
	v_sub_u32_e32 v47, 0x7c787470, v47
	v_perm_b32 v22, v23, v49, s0
	v_perm_b32 v23, v23, v49, s1
	v_cndmask_b32_e64 v62, v48, 0, vcc
	v_cndmask_b32_e64 v63, v47, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[36:37], v[22:23], v[38:41]
	v_add_u32_e32 v24, 0x7f7f7f00, v62
	v_and_b32_e32 v64, 0x80808000, v24
	v_add_u32_e32 v24, 0x7f7f7f78, v63
	ds_read2st64_b64 v[38:41], v87 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[34:35], v[22:23], v[42:45]
	v_and_b32_e32 v22, 0x7070707, v25
	v_lshrrev_b32_e32 v23, 4, v25
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v54, v53, v52, v22
	v_perm_b32 v22, v51, v50, v22
	v_and_or_b32 v54, v54, v55, v22
	v_perm_b32 v22, v53, v52, v23
	v_perm_b32 v23, v51, v50, v23
	v_and_or_b32 v23, v22, v25, v23
	v_perm_b32 v22, v23, v54, s0
	v_perm_b32 v23, v23, v54, s1
	v_and_b32_e32 v65, 0x80808080, v24
	v_and_b32_e32 v50, 0x7070707, v18
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[38:39], v[22:23], v[42:45]
	v_perm_b32 v52, v65, v64, v50
	v_lshlrev_b32_e32 v53, 4, v18
	v_perm_b32 v50, v63, v62, v50
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[40:41], v[22:23], v[46:49]
	v_lshrrev_b32_e32 v22, 4, v18
	v_and_b32_e32 v51, 0x7070707, v22
	ds_read2st64_b64 v[22:25], v88 offset1:8
	v_and_or_b32 v50, v52, v53, v50
	v_perm_b32 v52, v65, v64, v51
	v_perm_b32 v51, v63, v62, v51
	v_and_or_b32 v18, v52, v18, v51
	v_perm_b32 v54, v18, v50, s0
	v_perm_b32 v55, v18, v50, s1
	v_and_b32_e32 v18, 0x7070707, v19
	s_add_i32 s3, s17, 0xe01
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[22:23], v[54:55], v[42:45]
	s_lshr_b32 s4, s3, 31
	s_add_i32 s4, s3, s4
	s_and_b32 s4, s4, 0x1ffffffe
	v_lshrrev_b32_e32 v42, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[24:25], v[54:55], v[46:49]
	v_and_b32_e32 v54, 0x7070707, v42
	ds_read2st64_b64 v[42:45], v89 offset1:8
	v_perm_b32 v55, v65, v64, v18
	v_perm_b32 v18, v63, v62, v18
	v_and_or_b32 v55, v55, v56, v18
	v_perm_b32 v18, v65, v64, v54
	v_perm_b32 v54, v63, v62, v54
	v_and_or_b32 v19, v18, v19, v54
	v_perm_b32 v18, v19, v55, s0
	v_perm_b32 v19, v19, v55, s1
	s_sub_i32 s3, s3, s4
	s_lshl_b32 s3, s3, 3
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[44:45], v[18:19], v[46:49]
	v_lshlrev_b32_e32 v69, 4, v15
	s_nop 1
	ds_read2st64_b64 v[46:49], v90 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[42:43], v[18:19], v[50:53]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v58, v65, v64, v18
	v_perm_b32 v18, v63, v62, v18
	v_and_or_b32 v58, v58, v59, v18
	v_perm_b32 v18, v65, v64, v19
	v_perm_b32 v19, v63, v62, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v58, s0
	v_perm_b32 v19, v19, v58, s1
	s_waitcnt lgkmcnt(0)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[48:49], v[18:19], v[54:57]
	s_nop 2
	ds_read2st64_b64 v[54:57], v1 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[46:47], v[18:19], v[50:53]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v65, v64, v18
	v_lshlrev_b32_e32 v1, 4, v21
	v_perm_b32 v18, v63, v62, v18
	v_and_or_b32 v1, v20, v1, v18
	v_perm_b32 v18, v65, v64, v19
	v_perm_b32 v19, v63, v62, v19
	v_and_or_b32 v19, v18, v21, v19
	v_perm_b32 v18, v19, v1, s0
	v_perm_b32 v19, v19, v1, s1
	v_bfe_u32 v1, v104, s3, 8
	v_sub_u32_e32 v1, v0, v1
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[54:55], v[18:19], v[50:53]
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_add_i32 s3, s3, 16
	v_bfe_u32 v64, v104, s3, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[56:57], v[18:19], v[58:61]
	v_sub_u32_e32 v64, v0, v64
	s_nop 1
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
	v_and_b32_e32 v58, 0x7070707, v14
	v_lshrrev_b32_e32 v59, 4, v14
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v67, v66, v58
	v_lshlrev_b32_e32 v61, 4, v14
	v_perm_b32 v58, v65, v1, v58
	v_and_or_b32 v58, v60, v61, v58
	v_perm_b32 v60, v67, v66, v59
	v_perm_b32 v59, v65, v1, v59
	v_and_or_b32 v14, v60, v14, v59
	v_perm_b32 v62, v14, v58, s0
	v_perm_b32 v63, v14, v58, s1
	v_min_i32_e32 v14, 11, v64
	v_mul_lo_u32 v68, v14, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[26:27], v[62:63], 0
	v_and_b32_e32 v14, 0x7070707, v15
	v_cmp_lt_i32_e32 vcc, 11, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[62:63], 0
	v_lshrrev_b32_e32 v62, 4, v15
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v67, v66, v14
	v_perm_b32 v14, v65, v1, v14
	v_and_or_b32 v63, v63, v69, v14
	v_perm_b32 v14, v67, v66, v62
	v_perm_b32 v62, v65, v1, v62
	v_and_or_b32 v15, v14, v15, v62
	v_perm_b32 v14, v15, v63, s0
	v_perm_b32 v15, v15, v63, s1
	v_sub_u32_e32 v63, 0x7c787470, v68
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[30:31], v[14:15], v[58:61]
	v_sub_u32_e32 v30, 0x6c686080, v68
	v_and_b32_e32 v62, 0xffffff00, v30
	v_lshlrev_b32_e32 v31, 4, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[32:33], v[14:15], v[26:29]
	v_and_b32_e32 v14, 0x7070707, v16
	v_lshrrev_b32_e32 v15, 4, v16
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v30, v67, v66, v14
	v_perm_b32 v14, v65, v1, v14
	v_and_or_b32 v30, v30, v31, v14
	v_perm_b32 v14, v67, v66, v15
	v_perm_b32 v15, v65, v1, v15
	v_and_or_b32 v15, v14, v16, v15
	v_perm_b32 v14, v15, v30, s0
	v_perm_b32 v15, v15, v30, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[34:35], v[14:15], v[58:61]
	v_lshlrev_b32_e32 v34, 4, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[36:37], v[14:15], v[26:29]
	v_and_b32_e32 v14, 0x7070707, v17
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v67, v66, v14
	v_perm_b32 v14, v65, v1, v14
	v_and_or_b32 v14, v16, v34, v14
	v_perm_b32 v16, v67, v66, v15
	v_perm_b32 v1, v65, v1, v15
	v_and_or_b32 v1, v16, v17, v1
	v_cndmask_b32_e64 v58, v62, 0, vcc
	v_cndmask_b32_e64 v59, v63, 0, vcc
	v_perm_b32 v34, v1, v14, s0
	v_perm_b32 v35, v1, v14, s1
	v_add_u32_e32 v60, 0x7f7f7f00, v58
	v_and_b32_e32 v1, 0x80808000, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[38:39], v[34:35], v[30:33]
	v_cmp_lt_i32_e32 vcc, 5, v103
	s_nop 1
	v_add_u32_e32 v30, 0x7f7f7f78, v59
	v_and_b32_e32 v32, 0x80808080, v30
	v_and_b32_e32 v30, 0x7070707, v10
	v_lshrrev_b32_e32 v31, 4, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[40:41], v[34:35], v[26:29]
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v33, v32, v1, v30
	v_lshlrev_b32_e32 v34, 4, v10
	v_perm_b32 v30, v59, v58, v30
	v_and_or_b32 v33, v33, v34, v30
	v_perm_b32 v30, v32, v1, v31
	v_perm_b32 v31, v59, v58, v31
	v_and_or_b32 v10, v30, v10, v31
	v_perm_b32 v30, v10, v33, s0
	v_perm_b32 v31, v10, v33, s1
	v_and_b32_e32 v10, 0x7070707, v11
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[22:23], v[30:31], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[30:31], v[26:29]
	s_nop 2
	v_lshrrev_b32_e32 v26, 4, v11
	v_and_b32_e32 v26, 0x7070707, v26
	v_perm_b32 v27, v32, v1, v10
	v_lshlrev_b32_e32 v28, 4, v11
	v_perm_b32 v10, v59, v58, v10
	v_and_or_b32 v27, v27, v28, v10
	v_perm_b32 v10, v32, v1, v26
	v_perm_b32 v26, v59, v58, v26
	v_and_or_b32 v11, v10, v11, v26
	v_perm_b32 v10, v11, v27, s0
	v_perm_b32 v11, v11, v27, s1
	v_lshlrev_b32_e32 v27, 4, v12
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[42:43], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[44:45], v[10:11], v[22:25]
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v26, v32, v1, v10
	v_perm_b32 v10, v59, v58, v10
	v_and_or_b32 v26, v26, v27, v10
	v_perm_b32 v10, v32, v1, v11
	v_perm_b32 v11, v59, v58, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v26, s0
	v_perm_b32 v11, v11, v26, s1
	v_lshlrev_b32_e32 v26, 4, v13
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[46:47], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[48:49], v[10:11], v[22:25]
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v10, 0x7070707, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v32, v1, v10
	v_perm_b32 v10, v59, v58, v10
	v_perm_b32 v1, v32, v1, v11
	v_perm_b32 v11, v59, v58, v11
	v_and_or_b32 v10, v12, v26, v10
	v_and_or_b32 v1, v1, v13, v11
	v_perm_b32 v26, v1, v10, s0
	v_perm_b32 v27, v1, v10, s1
	v_mov_b32_e32 v1, 0xfd800000
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[54:55], v[26:27], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[56:57], v[26:27], v[22:25]
	s_nop 2
	v_add_u32_e32 v23, 17, v103
	v_lshl_add_u32 v22, v103, 23, v1
	v_lshlrev_b32_e64 v23, v23, 1
	v_cndmask_b32_e32 v22, v23, v22, vcc
	v_add_u32_e32 v23, 17, v0
	v_lshlrev_b32_e64 v23, v23, 1
	v_pk_mul_f32 v[26:27], v[8:9], v[22:23] op_sel_hi:[1,0]
	v_lshl_add_u32 v1, v0, 23, v1
	v_pk_mul_f32 v[26:27], v[26:27], v[52:53]
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[26:27], v[26:27], v[80:81]
	v_pk_mul_f32 v[24:25], v[6:7], v[22:23] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v0, v23, v1, vcc
	v_bfe_u32 v1, v27, 16, 1
	v_pk_mul_f32 v[24:25], v[24:25], v[50:51]
	v_add3_u32 v1, v1, v27, s0
	v_or_b32_e32 v23, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	v_pk_mul_f32 v[24:25], v[24:25], v[78:79]
	v_or_b32_e32 v27, 0x400000, v26
	v_cndmask_b32_e32 v1, v1, v23, vcc
	v_bfe_u32 v23, v26, 16, 1
	v_add3_u32 v23, v23, v26, s0
	v_cmp_u_f32_e32 vcc, v26, v26
	v_bfe_u32 v26, v25, 16, 1
	v_add3_u32 v26, v26, v25, s0
	v_cndmask_b32_e32 v23, v23, v27, vcc
	v_or_b32_e32 v27, 0x400000, v25
	v_cmp_u_f32_e32 vcc, v25, v25
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v25, v26, v27, vcc
	v_bfe_u32 v26, v24, 16, 1
	v_add3_u32 v26, v26, v24, s0
	v_or_b32_e32 v27, 0x400000, v24
	v_cmp_u_f32_e32 vcc, v24, v24
	v_pk_mul_f32 v[8:9], v[8:9], v[12:13]
	v_pk_mul_f32 v[6:7], v[6:7], v[10:11]
	v_cndmask_b32_e32 v24, v26, v27, vcc
	v_pk_mul_f32 v[8:9], v[8:9], v[80:81]
	ds_write_b16_d16_hi v99, v24
	ds_write_b16_d16_hi v100, v25
	ds_write_b16_d16_hi v101, v23
	ds_write_b16_d16_hi v102, v1
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[78:79]
	v_cndmask_b32_e32 v1, v1, v10, vcc
	v_add3_u32 v9, v9, v8, s0
	v_or_b32_e32 v10, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v10, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v10, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v10, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v10, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v10, vcc
	ds_write_b16_d16_hi v99, v6 offset:32
	ds_write_b16_d16_hi v100, v7 offset:32
	ds_write_b16_d16_hi v101, v8 offset:32
	ds_write_b16_d16_hi v102, v1 offset:32
	v_pk_mul_f32 v[8:9], v[4:5], v[22:23] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[22:23] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_pk_mul_f32 v[8:9], v[8:9], v[76:77]
	v_pk_mul_f32 v[6:7], v[6:7], v[74:75]
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v10, vcc
	v_or_b32_e32 v10, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	v_pk_mul_f32 v[2:3], v[2:3], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v8, v9, v10, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v10, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[2:3], v[2:3], v[14:15]
	s_nop 0
	v_cndmask_b32_e32 v7, v9, v10, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v10, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[2:3], v[2:3], v[74:75]
	s_nop 0
	v_cndmask_b32_e32 v6, v9, v10, vcc
	ds_write_b16_d16_hi v95, v6
	ds_write_b16_d16_hi v96, v7
	ds_write_b16_d16_hi v97, v8
	ds_write_b16_d16_hi v98, v1
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[16:17]
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
	ds_write_b16_d16_hi v95, v2 offset:32
	ds_write_b16_d16_hi v96, v3 offset:32
	ds_write_b16_d16_hi v97, v0 offset:32
	ds_write_b16_d16_hi v98, v1 offset:32
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v93, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_add_u32_e32 v2, v92, v91
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v91
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
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz
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
		.amdhsa_next_free_vgpr 126
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 128
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.num_vgpr, 126
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.numbered_sgpr, 54
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.has_indirect_call, 0
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
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 1024
      - 1
      - 1
    .sgpr_count:     60
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw16_tk256_tn512_bcm12_xcd1_ftz.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     126
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
