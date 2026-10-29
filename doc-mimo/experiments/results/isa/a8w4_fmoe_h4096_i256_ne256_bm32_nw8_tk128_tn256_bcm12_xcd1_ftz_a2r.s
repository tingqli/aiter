	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r:
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
	s_cbranch_scc1 .LBB0_14
	s_lshr_b32 s49, s3, 6
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
	v_lshrrev_b32_e32 v31, 4, v0
	v_or_b32_e32 v2, s34, v31
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dword v6, v[2:3], off
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dword s33, s[0:1], 0x68
	v_and_b32_e32 v1, 15, v0
	v_lshlrev_b32_e32 v2, 3, v0
	v_and_b32_e32 v70, 48, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s29, s11, 0xffff
	s_load_dword s11, s[50:51], 0x0
	s_and_b32 s37, s5, 0xffff
	s_lshl_b32 s5, s49, 5
	v_or_b32_e32 v79, s5, v1
	v_and_b32_e32 v34, 0x78, v2
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s11, 9
	s_add_i32 s48, s2, s5
	s_and_b32 s25, s9, 0xffff
	v_add_u32_e32 v2, s2, v79
	s_lshl_b32 s2, s48, 7
	s_lshl_b32 s3, s48, 5
	s_add_i32 s9, s48, 0x100
	s_ashr_i32 s24, s48, 31
	s_add_i32 s51, s48, 0x110
	s_or_b32 s50, s48, 16
	v_or3_b32 v86, s2, v70, v1
	v_or3_b32 v87, s3, v70, v1
	s_lshl_b32 s2, s9, 7
	s_lshl_b32 s3, s9, 5
	s_lshr_b32 s27, s24, 27
	s_ashr_i32 s31, s51, 31
	v_or3_b32 v88, s2, v70, v1
	v_or3_b32 v89, s3, v70, v1
	s_add_i32 s2, s50, s27
	s_lshr_b32 s3, s31, 27
	s_lshr_b32 s2, s2, 5
	s_add_i32 s3, s51, s3
	v_and_b32_e32 v3, 0x70, v0
	s_add_i32 s2, s2, s24
	s_lshr_b32 s3, s3, 5
	v_xor_b32_e32 v7, v34, v3
	v_ashrrev_i32_e32 v3, 31, v2
	v_add_u32_e32 v4, 0x100, v2
	s_lshl_b32 s9, s50, 7
	s_lshl_b32 s2, s2, 10
	s_add_i32 s3, s3, s31
	s_mov_b32 s39, 0x27000
	s_brev_b32 s26, 8
	s_lshl_b32 s28, s51, 7
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	v_ashrrev_i32_e32 v5, 31, v4
	v_or3_b32 v90, s9, v70, v1
	v_or3_b32 v92, s2, v70, v1
	s_lshl_b32 s2, s3, 10
	s_mov_b32 s30, 0x1000000
	s_mov_b32 s42, s26
	s_mov_b32 s43, s39
	s_mov_b32 s40, s8
	s_mov_b32 s41, s25
	v_or3_b32 v91, s28, v70, v1
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	global_load_dword v82, v[2:3], off
	global_load_dword v83, v[2:3], off offset:64
	global_load_dword v80, v[4:5], off
	global_load_dword v81, v[4:5], off offset:64
	v_or3_b32 v93, s2, v70, v1
	v_lshlrev_b32_e32 v2, 4, v86
	v_lshlrev_b32_e32 v3, 4, v90
	v_lshlrev_b32_e32 v22, 4, v88
	s_mov_b32 s46, s30
	s_mov_b32 s47, s39
	s_mov_b32 s44, s10
	s_mov_b32 s45, s29
	v_lshlrev_b32_e32 v18, 2, v87
	v_lshlrev_b32_e32 v19, 2, v89
	v_lshlrev_b32_e32 v20, 2, v92
	v_lshlrev_b32_e32 v21, 2, v93
	v_lshlrev_b32_e32 v23, 4, v91
	s_mov_b32 s36, s4
	s_lshl_b32 s38, s33, 12
	s_load_dwordx2 s[12:13], s[0:1], 0x60
	v_bfe_u32 v72, v0, 4, 2
	s_mov_b32 s0, s4
	s_mov_b32 s24, s8
	s_mov_b32 s28, s10
	s_mov_b32 s1, s37
	s_lshr_b32 s4, s48, 31
	s_waitcnt vmcnt(4)
	v_lshl_or_b32 v94, v6, 12, v7
	buffer_load_dwordx4 v[14:17], v2, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v3, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[10:13], v22, s[40:43], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v23, s[40:43], 0 offen sc0
	buffer_load_dword v96, v18, s[44:47], 0 offen
	buffer_load_dword v84, v20, s[44:47], 0 offen
	buffer_load_dword v95, v19, s[44:47], 0 offen
	buffer_load_dword v85, v21, s[44:47], 0 offen
	buffer_load_dwordx2 v[32:33], v94, s[36:39], 0 offen nt
	s_ashr_i32 s8, s50, 4
	s_ashr_i32 s10, s51, 4
	s_lshr_b32 s37, s51, 31
	v_lshlrev_b32_e32 v71, 4, v0
	v_lshlrev_b32_e32 v73, 5, v72
	s_add_i32 s4, s8, s4
	s_add_i32 s37, s10, s37
	v_and_b32_e32 v35, 0x70, v71
	v_or_b32_e32 v75, 24, v73
	s_and_b32 s4, s4, -2
	s_and_b32 s37, s37, -2
	v_mov_b32_e32 v18, 0
	v_lshlrev_b32_e32 v74, 7, v1
	v_lshl_or_b32 v31, v31, 7, v34
	v_xor_b32_e32 v100, v73, v35
	v_or_b32_e32 v77, 8, v73
	v_or_b32_e32 v76, 16, v73
	v_xor_b32_e32 v97, v75, v35
	s_sub_i32 s4, s8, s4
	s_sub_i32 s10, s10, s37
	v_and_b32_e32 v78, 63, v0
	s_mov_b32 s9, 0x8080808
	s_mov_b32 s36, 0x5010400
	s_mov_b32 s40, 0x7030602
	s_mov_b32 s3, s39
	s_mov_b32 s27, s39
	s_mov_b32 s31, s39
	v_mov_b32_e32 v19, v18
	v_mov_b32_e32 v20, v18
	v_mov_b32_e32 v21, v18
	v_mov_b32_e32 v38, v18
	v_mov_b32_e32 v39, v18
	v_mov_b32_e32 v40, v18
	v_mov_b32_e32 v41, v18
	v_mov_b32_e32 v22, v18
	v_mov_b32_e32 v23, v18
	v_mov_b32_e32 v24, v18
	v_mov_b32_e32 v25, v18
	v_mov_b32_e32 v42, v18
	v_mov_b32_e32 v43, v18
	v_mov_b32_e32 v44, v18
	v_mov_b32_e32 v45, v18
	v_mov_b32_e32 v26, v18
	v_mov_b32_e32 v27, v18
	v_mov_b32_e32 v28, v18
	v_mov_b32_e32 v29, v18
	v_mov_b32_e32 v50, v18
	v_mov_b32_e32 v51, v18
	v_mov_b32_e32 v52, v18
	v_mov_b32_e32 v53, v18
	v_mov_b32_e32 v30, v18
	v_or_b32_e32 v101, 0x800, v74
	v_lshrrev_b32_e32 v102, 2, v31
	v_xor_b32_e32 v99, v77, v35
	v_xor_b32_e32 v98, v76, v35
	v_or_b32_e32 v103, v74, v100
	v_or_b32_e32 v104, v74, v97
	s_mov_b32 s2, s38
	s_lshl_b32 s8, s4, 3
	s_lshl_b32 s4, s10, 3
	v_mov_b32_e32 v54, v18
	v_mov_b32_e32 v55, v18
	v_mov_b32_e32 v56, v18
	v_mov_b32_e32 v57, v18
	s_waitcnt vmcnt(0)
	ds_write_b64 v31, v[32:33]
	v_mov_b32_e32 v31, v18
	v_mov_b32_e32 v32, v18
	v_mov_b32_e32 v33, v18
.LBB0_2:
	s_and_b32 s10, s35, 1
	s_add_i32 s35, s35, 1
	s_lshl_b32 s37, s10, 4
	s_lshl_b32 s38, s35, 5
	s_lshl_b32 s39, s35, 6
	s_waitcnt vmcnt(4)
	v_mov_b64_e32 v[36:37], v[4:5]
	v_mov_b64_e32 v[34:35], v[2:3]
	v_lshl_add_u32 v2, s35, 7, v94
	s_waitcnt vmcnt(3)
	v_bfe_u32 v66, v96, s37, 8
	s_add_i32 s41, s37, s8
	s_waitcnt vmcnt(1)
	v_bfe_u32 v67, v95, s37, 8
	s_add_i32 s37, s37, s4
	s_and_b32 s38, s38, 0x7c0
	v_add_lshl_u32 v68, s39, v86, 4
	v_mov_b64_e32 v[48:49], v[12:13]
	v_mov_b64_e32 v[46:47], v[10:11]
	v_mov_b64_e32 v[60:61], v[8:9]
	v_mov_b64_e32 v[58:59], v[6:7]
	v_mov_b64_e32 v[64:65], v[16:17]
	v_mov_b64_e32 v[62:63], v[14:15]
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx2 v[116:117], v2, s[0:3], 0 offen nt
	v_add_lshl_u32 v69, s39, v90, 4
	v_add_lshl_u32 v107, s39, v88, 4
	v_add_lshl_u32 v108, s39, v91, 4
	v_bfe_u32 v106, v84, s41, 8
	s_waitcnt vmcnt(1)
	v_bfe_u32 v105, v85, s37, 8
	v_add_lshl_u32 v109, s38, v87, 2
	v_add_lshl_u32 v110, s38, v92, 2
	v_add_lshl_u32 v111, s38, v89, 2
	v_add_lshl_u32 v112, s38, v93, 2
	buffer_load_dwordx4 v[14:17], v68, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v69, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[10:13], v107, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v108, s[24:27], 0 offen sc0
	buffer_load_dword v96, v109, s[28:31], 0 offen
	buffer_load_dword v84, v110, s[28:31], 0 offen
	buffer_load_dword v95, v111, s[28:31], 0 offen
	buffer_load_dword v85, v112, s[28:31], 0 offen
	v_sub_u32_e32 v66, v82, v66
	v_min_i32_e32 v68, 11, v66
	v_mul_lo_u32 v68, v68, s9
	v_sub_u32_e32 v69, 0x6c686080, v68
	v_and_b32_e32 v69, 0xffffff00, v69
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_sub_u32_e32 v68, 0x7c787470, v68
	s_lshl_b32 s37, s10, 12
	v_cndmask_b32_e64 v107, v69, 0, vcc
	v_cndmask_b32_e64 v108, v68, 0, vcc
	v_add_u32_e32 v66, 0x7f7f7f00, v107
	v_and_b32_e32 v109, 0x80808000, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v108
	v_and_b32_e32 v110, 0x80808080, v66
	v_sub_u32_e32 v66, v80, v67
	v_min_i32_e32 v67, 11, v66
	v_mul_lo_u32 v67, v67, s9
	v_sub_u32_e32 v68, 0x6c686080, v67
	v_and_b32_e32 v68, 0xffffff00, v68
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_sub_u32_e32 v67, 0x7c787470, v67
	v_lshlrev_b32_e32 v69, 4, v62
	v_cndmask_b32_e64 v111, v68, 0, vcc
	v_cndmask_b32_e64 v112, v67, 0, vcc
	v_add_u32_e32 v66, 0x7f7f7f00, v111
	v_and_b32_e32 v113, 0x80808000, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v112
	v_and_b32_e32 v114, 0x80808080, v66
	v_and_b32_e32 v66, 0x7070707, v62
	v_lshrrev_b32_e32 v67, 4, v62
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v68, v110, v109, v66
	v_perm_b32 v66, v108, v107, v66
	v_and_or_b32 v66, v68, v69, v66
	v_perm_b32 v68, v110, v109, v67
	v_perm_b32 v67, v108, v107, v67
	v_and_or_b32 v62, v68, v62, v67
	v_perm_b32 v118, v62, v66, s36
	v_perm_b32 v119, v62, v66, s40
	v_and_b32_e32 v62, 0x7070707, v46
	v_lshrrev_b32_e32 v66, 4, v46
	v_and_b32_e32 v66, 0x7070707, v66
	v_perm_b32 v67, v114, v113, v62
	v_lshlrev_b32_e32 v68, 4, v46
	v_perm_b32 v62, v112, v111, v62
	v_and_or_b32 v62, v67, v68, v62
	v_perm_b32 v67, v114, v113, v66
	v_perm_b32 v66, v112, v111, v66
	v_and_or_b32 v46, v67, v46, v66
	v_perm_b32 v120, v46, v62, s36
	v_perm_b32 v121, v46, v62, s40
	v_or_b32_e32 v46, s37, v103
	ds_read2st64_b64 v[66:69], v46 offset1:4
	v_and_b32_e32 v46, 0x7070707, v63
	v_lshrrev_b32_e32 v62, 4, v63
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[66:67], v[118:119], v[18:21]
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v115, v110, v109, v46
	v_perm_b32 v46, v108, v107, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[68:69], v[118:119], v[22:25]
	v_lshlrev_b32_e32 v118, 4, v63
	v_and_or_b32 v46, v115, v118, v46
	v_perm_b32 v115, v110, v109, v62
	v_perm_b32 v62, v108, v107, v62
	v_and_or_b32 v63, v115, v63, v62
	v_perm_b32 v62, v63, v46, s36
	v_perm_b32 v63, v63, v46, s40
	v_and_b32_e32 v46, 0x7070707, v47
	v_lshrrev_b32_e32 v115, 4, v47
	v_and_b32_e32 v115, 0x7070707, v115
	v_perm_b32 v118, v114, v113, v46
	v_lshlrev_b32_e32 v119, 4, v47
	v_perm_b32 v46, v112, v111, v46
	v_and_or_b32 v118, v118, v119, v46
	v_perm_b32 v46, v114, v113, v115
	v_perm_b32 v115, v112, v111, v115
	v_and_or_b32 v47, v46, v47, v115
	v_or_b32_e32 v115, s37, v99
	v_perm_b32 v46, v47, v118, s36
	v_perm_b32 v47, v47, v118, s40
	v_or_b32_e32 v118, v115, v74
	v_or_b32_e32 v115, v115, v101
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[66:67], v[120:121], v[26:29]
	ds_read_b64 v[122:123], v115
	v_lshlrev_b32_e32 v115, 4, v48
	s_cmp_lg_u32 s35, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[68:69], v[120:121], v[30:33]
	ds_read_b64 v[120:121], v118
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[120:121], v[46:47], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[122:123], v[46:47], v[30:33]
	v_and_b32_e32 v46, 0x7070707, v64
	v_lshrrev_b32_e32 v47, 4, v64
	v_and_b32_e32 v47, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[120:121], v[62:63], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[122:123], v[62:63], v[22:25]
	v_perm_b32 v62, v110, v109, v46
	v_lshlrev_b32_e32 v63, 4, v64
	v_perm_b32 v46, v108, v107, v46
	v_and_or_b32 v62, v62, v63, v46
	v_perm_b32 v46, v110, v109, v47
	v_perm_b32 v47, v108, v107, v47
	v_and_or_b32 v47, v46, v64, v47
	v_perm_b32 v46, v47, v62, s36
	v_perm_b32 v47, v47, v62, s40
	v_and_b32_e32 v62, 0x7070707, v48
	v_lshrrev_b32_e32 v63, 4, v48
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v114, v113, v62
	v_perm_b32 v62, v112, v111, v62
	v_and_or_b32 v62, v64, v115, v62
	v_perm_b32 v64, v114, v113, v63
	v_perm_b32 v63, v112, v111, v63
	v_and_or_b32 v48, v64, v48, v63
	v_perm_b32 v124, v48, v62, s36
	v_perm_b32 v125, v48, v62, s40
	v_or_b32_e32 v48, s37, v98
	v_or_b32_e32 v62, v48, v74
	v_or_b32_e32 v48, v48, v101
	ds_read_b64 v[62:63], v62
	ds_read_b64 v[118:119], v48
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[62:63], v[46:47], v[18:21]
	v_lshlrev_b32_e32 v64, 4, v65
	v_lshlrev_b32_e32 v115, 4, v34
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[118:119], v[46:47], v[22:25]
	v_and_b32_e32 v46, 0x7070707, v65
	v_lshrrev_b32_e32 v47, 4, v65
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v110, v109, v46
	v_perm_b32 v46, v108, v107, v46
	v_and_or_b32 v46, v48, v64, v46
	v_perm_b32 v48, v110, v109, v47
	v_perm_b32 v47, v108, v107, v47
	v_and_or_b32 v47, v48, v65, v47
	v_perm_b32 v64, v47, v46, s36
	v_perm_b32 v65, v47, v46, s40
	v_and_b32_e32 v46, 0x7070707, v49
	v_lshrrev_b32_e32 v47, 4, v49
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v114, v113, v46
	v_lshlrev_b32_e32 v107, 4, v49
	v_perm_b32 v46, v112, v111, v46
	v_and_or_b32 v46, v48, v107, v46
	v_perm_b32 v48, v114, v113, v47
	v_perm_b32 v47, v112, v111, v47
	v_and_or_b32 v47, v48, v49, v47
	v_perm_b32 v108, v47, v46, s36
	v_perm_b32 v109, v47, v46, s40
	v_or_b32_e32 v46, s37, v104
	ds_read2st64_b64 v[46:49], v46 offset1:4
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[48:49], v[64:65], v[22:25]
	v_lshlrev_b32_e32 v114, 4, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[46:47], v[64:65], v[18:21]
	v_sub_u32_e32 v64, v83, v106
	v_min_i32_e32 v65, 11, v64
	v_mul_lo_u32 v65, v65, s9
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[62:63], v[124:125], v[26:29]
	v_sub_u32_e32 v106, 0x6c686080, v65
	v_and_b32_e32 v106, 0xffffff00, v106
	v_cmp_lt_i32_e32 vcc, 11, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[118:119], v[124:125], v[30:33]
	v_sub_u32_e32 v65, 0x7c787470, v65
	v_cndmask_b32_e64 v110, v65, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[46:47], v[108:109], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[48:49], v[108:109], v[30:33]
	v_cndmask_b32_e64 v109, v106, 0, vcc
	v_add_u32_e32 v64, 0x7f7f7f00, v109
	v_and_b32_e32 v111, 0x80808000, v64
	v_add_u32_e32 v64, 0x7f7f7f78, v110
	v_and_b32_e32 v112, 0x80808080, v64
	v_sub_u32_e32 v64, v81, v105
	v_min_i32_e32 v65, 11, v64
	v_mul_lo_u32 v65, v65, s9
	v_sub_u32_e32 v105, 0x6c686080, v65
	v_and_b32_e32 v105, 0xffffff00, v105
	v_cmp_lt_i32_e32 vcc, 11, v64
	v_sub_u32_e32 v65, 0x7c787470, v65
	s_nop 0
	v_cndmask_b32_e64 v105, v105, 0, vcc
	v_cndmask_b32_e64 v106, v65, 0, vcc
	v_add_u32_e32 v64, 0x7f7f7f00, v105
	v_and_b32_e32 v107, 0x80808000, v64
	v_add_u32_e32 v64, 0x7f7f7f78, v106
	v_and_b32_e32 v108, 0x80808080, v64
	v_and_b32_e32 v64, 0x7070707, v58
	v_lshrrev_b32_e32 v65, 4, v58
	v_and_b32_e32 v65, 0x7070707, v65
	v_perm_b32 v113, v112, v111, v64
	v_perm_b32 v64, v110, v109, v64
	v_and_or_b32 v113, v113, v114, v64
	v_perm_b32 v64, v112, v111, v65
	v_perm_b32 v65, v110, v109, v65
	v_and_or_b32 v58, v64, v58, v65
	v_perm_b32 v64, v58, v113, s36
	v_perm_b32 v65, v58, v113, s40
	v_and_b32_e32 v58, 0x7070707, v34
	v_lshrrev_b32_e32 v113, 4, v34
	v_and_b32_e32 v113, 0x7070707, v113
	v_perm_b32 v114, v108, v107, v58
	v_perm_b32 v58, v106, v105, v58
	v_and_or_b32 v58, v114, v115, v58
	v_perm_b32 v114, v108, v107, v113
	v_perm_b32 v113, v106, v105, v113
	v_and_or_b32 v34, v114, v34, v113
	v_perm_b32 v114, v34, v58, s36
	v_perm_b32 v115, v34, v58, s40
	v_and_b32_e32 v34, 0x7070707, v59
	v_lshrrev_b32_e32 v58, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[66:67], v[64:65], v[38:41]
	v_and_b32_e32 v58, 0x7070707, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[68:69], v[64:65], v[42:45]
	v_perm_b32 v64, v112, v111, v34
	v_lshlrev_b32_e32 v65, 4, v59
	v_perm_b32 v34, v110, v109, v34
	v_and_or_b32 v34, v64, v65, v34
	v_perm_b32 v64, v112, v111, v58
	v_perm_b32 v58, v110, v109, v58
	v_and_or_b32 v59, v64, v59, v58
	v_perm_b32 v58, v59, v34, s36
	v_perm_b32 v59, v59, v34, s40
	v_and_b32_e32 v34, 0x7070707, v35
	v_lshrrev_b32_e32 v64, 4, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[66:67], v[114:115], v[50:53]
	v_and_b32_e32 v64, 0x7070707, v64
	v_perm_b32 v65, v108, v107, v34
	v_lshlrev_b32_e32 v66, 4, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[68:69], v[114:115], v[54:57]
	v_perm_b32 v34, v106, v105, v34
	v_and_or_b32 v65, v65, v66, v34
	v_perm_b32 v34, v108, v107, v64
	v_perm_b32 v64, v106, v105, v64
	v_and_or_b32 v35, v34, v35, v64
	v_perm_b32 v34, v35, v65, s36
	v_perm_b32 v35, v35, v65, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[120:121], v[58:59], v[38:41]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[120:121], v[34:35], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[122:123], v[58:59], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[120:123], v[122:123], v[34:35], v[54:57]
	v_and_b32_e32 v34, 0x7070707, v60
	v_lshrrev_b32_e32 v35, 4, v60
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v42, v112, v111, v34
	v_lshlrev_b32_e32 v43, 4, v60
	v_perm_b32 v34, v110, v109, v34
	v_and_or_b32 v42, v42, v43, v34
	v_perm_b32 v34, v112, v111, v35
	v_perm_b32 v35, v110, v109, v35
	v_and_or_b32 v35, v34, v60, v35
	v_perm_b32 v34, v35, v42, s36
	v_perm_b32 v35, v35, v42, s40
	v_and_b32_e32 v42, 0x7070707, v36
	v_lshrrev_b32_e32 v43, 4, v36
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v108, v107, v42
	v_lshlrev_b32_e32 v45, 4, v36
	v_perm_b32 v42, v106, v105, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v108, v107, v43
	v_perm_b32 v43, v106, v105, v43
	v_and_or_b32 v36, v44, v36, v43
	v_perm_b32 v58, v36, v42, s36
	v_perm_b32 v59, v36, v42, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[62:63], v[34:35], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[118:119], v[34:35], v[64:67]
	v_and_b32_e32 v34, 0x7070707, v61
	v_lshrrev_b32_e32 v35, 4, v61
	v_and_b32_e32 v35, 0x7070707, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[62:63], v[58:59], v[50:53]
	v_perm_b32 v36, v112, v111, v34
	v_perm_b32 v34, v110, v109, v34
	s_nop 0
	v_lshlrev_b32_e32 v50, 4, v61
	v_and_or_b32 v36, v36, v50, v34
	v_perm_b32 v34, v112, v111, v35
	v_perm_b32 v35, v110, v109, v35
	v_and_or_b32 v35, v34, v61, v35
	v_perm_b32 v34, v35, v36, s36
	v_perm_b32 v35, v35, v36, s40
	v_and_b32_e32 v36, 0x7070707, v37
	v_lshrrev_b32_e32 v50, 4, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[118:119], v[58:59], v[120:123]
	v_and_b32_e32 v50, 0x7070707, v50
	v_perm_b32 v51, v108, v107, v36
	v_lshlrev_b32_e32 v52, 4, v37
	v_perm_b32 v36, v106, v105, v36
	v_and_or_b32 v51, v51, v52, v36
	v_perm_b32 v36, v108, v107, v50
	v_perm_b32 v50, v106, v105, v50
	v_and_or_b32 v37, v36, v37, v50
	v_perm_b32 v36, v37, v51, s36
	v_perm_b32 v37, v37, v51, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[46:47], v[34:35], v[38:41]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[46:47], v[36:37], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[48:49], v[34:35], v[54:57]
	v_lshl_or_b32 v34, s10, 10, v102
	v_xor_b32_e32 v34, 0x400, v34
	v_lshlrev_b32_e32 v34, 2, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[48:49], v[36:37], v[62:65]
	s_waitcnt vmcnt(8)
	ds_write_b64 v34, v[116:117]
	s_cbranch_scc1 .LBB0_2
	s_waitcnt vmcnt(3)
	v_sub_u32_sdwa v34, v82, v96 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v35, 11, v34
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_lshlrev_b32_e32 v37, 4, v14
	v_cndmask_b32_e64 v62, v36, 0, vcc
	v_cndmask_b32_e64 v63, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v62
	v_and_b32_e32 v64, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v63
	v_and_b32_e32 v65, 0x80808080, v34
	s_waitcnt vmcnt(1)
	v_sub_u32_sdwa v34, v80, v95 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	s_mov_b32 s41, 0x5010400
	v_cndmask_b32_e64 v66, v36, 0, vcc
	v_cndmask_b32_e64 v67, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v66
	v_and_b32_e32 v68, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v67
	v_and_b32_e32 v69, 0x80808080, v34
	v_and_b32_e32 v34, 0x7070707, v14
	v_lshrrev_b32_e32 v35, 4, v14
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v65, v64, v34
	v_perm_b32 v34, v63, v62, v34
	v_and_or_b32 v36, v36, v37, v34
	v_perm_b32 v34, v65, v64, v35
	v_perm_b32 v35, v63, v62, v35
	v_and_or_b32 v14, v34, v14, v35
	s_mov_b32 s42, 0x7030602
	v_perm_b32 v34, v14, v36, s41
	v_perm_b32 v35, v14, v36, s42
	v_and_b32_e32 v14, 0x7070707, v10
	v_perm_b32 v37, v69, v68, v14
	v_lshlrev_b32_e32 v46, 4, v10
	v_perm_b32 v14, v67, v66, v14
	v_and_or_b32 v14, v37, v46, v14
	v_add_u32_e32 v46, v74, v100
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[86:87], v46 offset:4096
	v_lshrrev_b32_e32 v36, 4, v10
	v_or_b32_e32 v46, 0x800, v74
	v_and_b32_e32 v36, 0x7070707, v36
	v_add_u32_e32 v47, v46, v100
	v_perm_b32 v37, v69, v68, v36
	v_perm_b32 v36, v67, v66, v36
	v_add_u32_e32 v48, v74, v99
	v_add_u32_e32 v49, v46, v99
	ds_read_b64 v[88:89], v47 offset:4096
	ds_read_b64 v[90:91], v48 offset:4096
	ds_read_b64 v[92:93], v49 offset:4096
	v_and_or_b32 v10, v37, v10, v36
	v_perm_b32 v36, v10, v14, s41
	v_perm_b32 v37, v10, v14, s42
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v14, 4, v15
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[86:87], v[34:35], v[18:21]
	v_and_b32_e32 v14, 0x7070707, v14
	s_add_i32 s8, s8, 16
	s_add_i32 s4, s4, 16
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[88:89], v[34:35], v[22:25]
	v_perm_b32 v34, v65, v64, v10
	v_lshlrev_b32_e32 v35, 4, v15
	v_perm_b32 v10, v63, v62, v10
	v_and_or_b32 v10, v34, v35, v10
	v_perm_b32 v34, v65, v64, v14
	v_perm_b32 v14, v63, v62, v14
	v_and_or_b32 v15, v34, v15, v14
	v_perm_b32 v14, v15, v10, s41
	v_perm_b32 v15, v15, v10, s42
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v34, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[86:87], v[36:37], v[26:29]
	v_and_b32_e32 v34, 0x7070707, v34
	v_perm_b32 v35, v69, v68, v10
	v_perm_b32 v10, v67, v66, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[88:89], v[36:37], v[30:33]
	v_lshlrev_b32_e32 v36, 4, v11
	v_and_or_b32 v35, v35, v36, v10
	v_perm_b32 v10, v69, v68, v34
	v_perm_b32 v34, v67, v66, v34
	v_and_or_b32 v11, v10, v11, v34
	v_perm_b32 v10, v11, v35, s41
	v_perm_b32 v11, v11, v35, s42
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[90:91], v[14:15], v[18:21]
	v_lshlrev_b32_e32 v34, 4, v12
	v_add_u32_e32 v36, v74, v97
	v_add_u32_e32 v37, v46, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[90:91], v[10:11], v[26:29]
	s_ashr_i32 s35, s34, 31
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[92:93], v[10:11], v[30:33]
	v_and_b32_e32 v10, 0x7070707, v16
	v_lshrrev_b32_e32 v11, 4, v16
	v_and_b32_e32 v11, 0x7070707, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[92:93], v[14:15], v[22:25]
	v_perm_b32 v14, v65, v64, v10
	v_lshlrev_b32_e32 v15, 4, v16
	v_perm_b32 v10, v63, v62, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v65, v64, v11
	v_perm_b32 v11, v63, v62, v11
	v_and_or_b32 v11, v10, v16, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v14, 0x7070707, v12
	v_perm_b32 v16, v69, v68, v14
	v_perm_b32 v14, v67, v66, v14
	v_and_or_b32 v16, v16, v34, v14
	v_add_u32_e32 v14, v74, v98
	ds_read_b64 v[94:95], v14 offset:4096
	v_lshrrev_b32_e32 v15, 4, v12
	v_add_u32_e32 v34, v46, v98
	v_and_b32_e32 v15, 0x7070707, v15
	ds_read_b64 v[34:35], v34 offset:4096
	ds_read_b64 v[48:49], v36 offset:4096
	ds_read_b64 v[46:47], v37 offset:4096
	v_perm_b32 v14, v69, v68, v15
	v_perm_b32 v15, v67, v66, v15
	v_and_or_b32 v12, v14, v12, v15
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[94:95], v[10:11], v[18:21]
	v_perm_b32 v14, v12, v16, s41
	v_perm_b32 v15, v12, v16, s42
	v_lshlrev_b32_e32 v16, 4, v13
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[34:35], v[10:11], v[22:25]
	v_and_b32_e32 v10, 0x7070707, v17
	v_lshrrev_b32_e32 v11, 4, v17
	v_and_b32_e32 v11, 0x7070707, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[94:95], v[14:15], v[26:29]
	v_perm_b32 v12, v65, v64, v10
	v_perm_b32 v10, v63, v62, v10
	s_mov_b32 s3, 0x27000
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[34:35], v[14:15], v[30:33]
	v_lshlrev_b32_e32 v14, 4, v17
	v_and_or_b32 v12, v12, v14, v10
	v_perm_b32 v10, v65, v64, v11
	v_perm_b32 v11, v63, v62, v11
	v_and_or_b32 v11, v10, v17, v11
	v_perm_b32 v10, v11, v12, s41
	v_perm_b32 v11, v11, v12, s42
	v_and_b32_e32 v12, 0x7070707, v13
	v_lshrrev_b32_e32 v14, 4, v13
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v15, v69, v68, v12
	v_perm_b32 v12, v67, v66, v12
	v_and_or_b32 v15, v15, v16, v12
	v_perm_b32 v12, v69, v68, v14
	v_perm_b32 v14, v67, v66, v14
	v_and_or_b32 v13, v12, v13, v14
	v_perm_b32 v12, v13, v15, s41
	v_perm_b32 v13, v13, v15, s42
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[48:49], v[10:11], v[18:21]
	s_mov_b32 s0, s6
	s_mulk_i32 s11, 0xe00
	s_and_b32 s25, s23, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[48:49], v[12:13], v[26:29]
	s_mov_b32 s26, -1
	s_mov_b32 s24, s22
	s_mov_b32 s27, s3
	v_bfe_u32 v26, v84, s8, 8
	v_sub_u32_e32 v26, v83, v26
	v_min_i32_e32 v28, 11, v26
	v_mul_lo_u32 v28, v28, s40
	v_sub_u32_e32 v29, 0x6c686080, v28
	v_and_b32_e32 v29, 0xffffff00, v29
	v_cmp_lt_i32_e32 vcc, 11, v26
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[46:47], v[10:11], v[58:61]
	v_sub_u32_e32 v28, 0x7c787470, v28
	v_cndmask_b32_e64 v62, v28, 0, vcc
	s_waitcnt vmcnt(0)
	v_bfe_u32 v27, v85, s4, 8
	v_cndmask_b32_e64 v61, v29, 0, vcc
	v_add_u32_e32 v26, 0x7f7f7f00, v61
	v_and_b32_e32 v63, 0x80808000, v26
	v_add_u32_e32 v26, 0x7f7f7f78, v62
	v_and_b32_e32 v64, 0x80808080, v26
	v_sub_u32_e32 v26, v81, v27
	v_min_i32_e32 v27, 11, v26
	v_mul_lo_u32 v27, v27, s40
	v_sub_u32_e32 v28, 0x6c686080, v27
	v_and_b32_e32 v28, 0xffffff00, v28
	v_cmp_lt_i32_e32 vcc, 11, v26
	v_sub_u32_e32 v27, 0x7c787470, v27
	v_lshlrev_b32_e32 v29, 4, v6
	v_cndmask_b32_e64 v65, v28, 0, vcc
	v_cndmask_b32_e64 v66, v27, 0, vcc
	v_add_u32_e32 v26, 0x7f7f7f00, v65
	v_and_b32_e32 v67, 0x80808000, v26
	v_add_u32_e32 v26, 0x7f7f7f78, v66
	v_and_b32_e32 v68, 0x80808080, v26
	v_and_b32_e32 v26, 0x7070707, v6
	v_lshrrev_b32_e32 v27, 4, v6
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v64, v63, v26
	v_perm_b32 v26, v62, v61, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v64, v63, v27
	v_perm_b32 v27, v62, v61, v27
	v_and_or_b32 v6, v28, v6, v27
	v_perm_b32 v36, v6, v26, s41
	v_perm_b32 v37, v6, v26, s42
	v_lshrrev_b32_e32 v26, 4, v2
	v_and_b32_e32 v6, 0x7070707, v2
	v_and_b32_e32 v26, 0x7070707, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[46:47], v[12:13], v[30:33]
	v_perm_b32 v27, v68, v67, v6
	v_lshlrev_b32_e32 v28, 4, v2
	v_perm_b32 v6, v66, v65, v6
	v_perm_b32 v30, v68, v67, v26
	v_perm_b32 v31, v66, v65, v26
	v_and_or_b32 v6, v27, v28, v6
	v_and_or_b32 v2, v30, v2, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[86:87], v[36:37], v[38:41]
	v_cmp_lt_i32_e32 vcc, 5, v83
	s_mov_b32 s6, 0x400000
	s_mov_b32 s28, s14
	v_perm_b32 v40, v2, v6, s41
	v_perm_b32 v41, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[88:89], v[36:37], v[42:45]
	v_and_b32_e32 v6, 0x7070707, v6
	s_mov_b32 s31, s3
	s_mov_b32 s44, s18
	v_perm_b32 v44, v64, v63, v2
	v_lshlrev_b32_e32 v45, 4, v7
	v_perm_b32 v2, v62, v61, v2
	v_and_or_b32 v2, v44, v45, v2
	v_perm_b32 v44, v64, v63, v6
	v_perm_b32 v6, v62, v61, v6
	v_and_or_b32 v7, v44, v7, v6
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v44, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[86:87], v[40:41], v[50:53]
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v68, v67, v2
	v_perm_b32 v2, v66, v65, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[88:89], v[40:41], v[54:57]
	v_lshlrev_b32_e32 v50, 4, v3
	v_and_or_b32 v45, v45, v50, v2
	v_perm_b32 v2, v68, v67, v44
	v_perm_b32 v44, v66, v65, v44
	v_and_or_b32 v3, v2, v3, v44
	v_perm_b32 v2, v3, v45, s41
	v_perm_b32 v3, v3, v45, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[90:91], v[6:7], v[26:29]
	s_mov_b32 s46, s6
	s_mov_b32 s47, s3
	s_mov_b32 s10, 0x800000
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[90:91], v[2:3], v[30:33]
	s_and_b32 s9, s17, 0xffff
	s_mov_b32 s36, s16
	s_mov_b32 s37, s9
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[92:93], v[2:3], v[40:43]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[92:93], v[6:7], v[36:39]
	v_perm_b32 v6, v64, v63, v2
	v_lshlrev_b32_e32 v7, 4, v8
	v_perm_b32 v2, v62, v61, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v64, v63, v3
	v_perm_b32 v3, v62, v61, v3
	v_and_or_b32 v3, v2, v8, v3
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_and_b32_e32 v6, 0x7070707, v4
	v_lshrrev_b32_e32 v7, 4, v4
	v_lshlrev_b32_e32 v40, 2, v72
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v68, v67, v6
	v_lshlrev_b32_e32 v36, 4, v4
	v_perm_b32 v6, v66, v65, v6
	v_or_b32_e32 v38, s34, v40
	v_and_or_b32 v8, v8, v36, v6
	v_perm_b32 v6, v68, v67, v7
	v_perm_b32 v7, v66, v65, v7
	v_ashrrev_i32_e32 v39, 31, v38
	v_and_or_b32 v4, v6, v4, v7
	v_lshl_add_u64 v[36:37], v[38:39], 2, s[20:21]
	v_perm_b32 v6, v4, v8, s41
	v_perm_b32 v7, v4, v8, s42
	global_load_dword v4, v[36:37], off
	v_mov_b32_e32 v41, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[94:95], v[2:3], v[26:29]
	s_mov_b32 s38, s10
	s_mov_b32 s39, s3
	s_mov_b32 s17, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[34:35], v[2:3], v[50:53]
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[40:41]
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dwordx3 v[58:60], v[2:3], off offset:4
	global_load_dwordx4 v[54:57], v[2:3], off offset:64
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[94:95], v[6:7], v[30:33]
	s_movk_i32 s35, 0x7fff
	s_mov_b32 s8, s16
	s_mov_b32 s22, s26
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[34:35], v[6:7], v[42:45]
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v64, v63, v6
	v_lshlrev_b32_e32 v34, 4, v9
	v_perm_b32 v6, v62, v61, v6
	v_and_or_b32 v8, v8, v34, v6
	v_perm_b32 v6, v64, v63, v7
	v_perm_b32 v7, v62, v61, v7
	v_and_or_b32 v7, v6, v9, v7
	v_lshrrev_b32_e32 v9, 4, v5
	v_perm_b32 v6, v7, v8, s41
	v_perm_b32 v7, v7, v8, s42
	v_and_b32_e32 v8, 0x7070707, v5
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v34, v68, v67, v8
	v_lshlrev_b32_e32 v35, 4, v5
	v_perm_b32 v8, v66, v65, v8
	v_perm_b32 v39, v68, v67, v9
	v_perm_b32 v2, v66, v65, v9
	v_and_or_b32 v8, v34, v35, v8
	v_and_or_b32 v3, v39, v5, v2
	v_perm_b32 v2, v3, v8, s41
	v_perm_b32 v3, v3, v8, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[48:49], v[6:7], v[26:29]
	v_add_u32_e32 v39, 17, v80
	v_lshlrev_b32_e64 v39, v39, 1
	v_mov_b32_e32 v64, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[48:49], v[2:3], v[30:33]
	s_mov_b32 s23, s3
	s_and_b32 s21, s21, 0xffff
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v4, 2, v4
	v_and_b32_e32 v4, 0x3fffffc, v4
	buffer_load_dword v32, v4, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[46:47], v[6:7], v[50:53]
	v_add_u32_e32 v30, 17, v83
	v_add_u32_e32 v31, 17, v82
	v_lshlrev_b32_e64 v30, v30, 1
	v_mov_b32_e32 v52, 0xfd800000
	v_add_u32_e32 v33, 17, v81
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v4, 2, v58
	v_and_b32_e32 v4, 0x3fffffc, v4
	buffer_load_dword v40, v4, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[46:47], v[2:3], v[42:45]
	v_mov_b32_e32 v58, v22
	v_mov_b32_e32 v65, v26
	v_mov_b32_e32 v22, 0x2000
	v_lshl_add_u32 v43, v83, 23, v52
	v_lshl_add_u32 v42, v82, 23, v52
	v_lshlrev_b32_e64 v44, v31, 1
	v_cndmask_b32_e32 v31, v30, v43, vcc
	v_cmp_lt_i32_e32 vcc, 5, v82
	v_lshlrev_b32_e32 v43, 2, v60
	v_and_b32_e32 v43, 0x3fffffc, v43
	v_cndmask_b32_e32 v30, v44, v42, vcc
	v_lshlrev_b32_e32 v42, 2, v59
	v_and_b32_e32 v42, 0x3fffffc, v42
	buffer_load_dword v42, v42, s[0:3], 0 offen
	s_waitcnt vmcnt(3)
	v_lshlrev_b32_e32 v44, 2, v54
	v_and_b32_e32 v45, 0x3fffffc, v44
	v_lshlrev_b32_e32 v44, 2, v55
	v_and_b32_e32 v47, 0x3fffffc, v44
	v_lshlrev_b32_e32 v44, 2, v56
	v_and_b32_e32 v49, 0x3fffffc, v44
	v_lshlrev_b32_e32 v44, 2, v57
	v_and_b32_e32 v50, 0x3fffffc, v44
	buffer_load_dword v44, v43, s[0:3], 0 offen
	buffer_load_dword v46, v45, s[0:3], 0 offen
	buffer_load_dword v48, v47, s[0:3], 0 offen
	buffer_load_dword v54, v49, s[0:3], 0 offen
	buffer_load_dword v56, v50, s[0:3], 0 offen
	v_mov_b32_e32 v59, v34
	s_mov_b32 s0, 0xbfb8aa3b
	v_lshl_add_u32 v45, v81, 23, v52
	v_cmp_lt_i32_e32 vcc, 5, v81
	v_lshl_add_u32 v34, v80, 23, v52
	v_lshl_or_b32 v43, v72, 11, v22
	s_lshl_b32 s2, s49, 2
	s_waitcnt vmcnt(7)
	v_pk_mul_f32 v[50:51], v[32:33], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[58:59], v[58:59], v[50:51]
	v_lshlrev_b32_e64 v33, v33, 1
	v_pk_mul_f32 v[50:51], v[58:59], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v63, v33, v45, vcc
	v_exp_f32_e32 v60, v50
	v_exp_f32_e32 v61, v51
	v_cmp_lt_i32_e32 vcc, 5, v80
	v_lshl_add_u32 v51, v79, 1, v43
	v_pk_add_f32 v[60:61], v[60:61], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v62, v39, v34, vcc
	v_rcp_f32_e32 v60, v60
	v_rcp_f32_e32 v61, v61
	v_pk_mul_f32 v[32:33], v[32:33], v[62:63] op_sel_hi:[0,1]
	v_pk_mul_f32 v[32:33], v[64:65], v[32:33]
	v_mov_b32_e32 v34, v23
	v_pk_mul_f32 v[58:59], v[58:59], v[60:61]
	v_add_u32_e32 v23, s5, v1
	v_pk_mul_f32 v[32:33], v[32:33], v[58:59]
	v_lshl_add_u32 v50, v23, 1, v43
	v_bfe_u32 v18, v33, 16, 1
	v_add3_u32 v18, v18, v33, s35
	v_or_b32_e32 v26, 0x400000, v33
	v_cmp_u_f32_e32 vcc, v33, v33
	v_or_b32_e32 v33, 0x400000, v32
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[58:59], v[40:41], v[62:63] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v18, v18, v26, vcc
	v_bfe_u32 v26, v32, 16, 1
	v_add3_u32 v26, v26, v32, s35
	v_cmp_u_f32_e32 vcc, v32, v32
	s_nop 1
	v_cndmask_b32_e32 v26, v26, v33, vcc
	v_pk_mul_f32 v[32:33], v[40:41], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[32:33], v[34:35], v[32:33]
	ds_write_b16_d16_hi v51, v26
	v_pk_mul_f32 v[34:35], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v26, v19
	v_exp_f32_e32 v34, v34
	v_exp_f32_e32 v35, v35
	ds_write_b16_d16_hi v50, v18 offset:32
	v_pk_mul_f32 v[18:19], v[26:27], v[58:59]
	v_pk_add_f32 v[34:35], v[34:35], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v34, v34
	v_rcp_f32_e32 v35, v35
	s_nop 0
	v_pk_mul_f32 v[26:27], v[32:33], v[34:35]
	v_mov_b32_e32 v32, v24
	v_pk_mul_f32 v[18:19], v[18:19], v[26:27]
	v_mov_b32_e32 v33, v36
	v_bfe_u32 v23, v19, 16, 1
	v_add3_u32 v23, v23, v19, s35
	v_or_b32_e32 v26, 0x400000, v19
	v_cmp_u_f32_e32 vcc, v19, v19
	v_or_b32_e32 v34, 0x400000, v18
	v_mov_b32_e32 v35, v28
	v_cndmask_b32_e32 v19, v23, v26, vcc
	s_waitcnt vmcnt(5)
	v_pk_mul_f32 v[26:27], v[42:43], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[32:33], v[26:27]
	v_bfe_u32 v23, v18, 16, 1
	v_pk_mul_f32 v[32:33], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v23, v23, v18, s35
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cmp_u_f32_e32 vcc, v18, v18
	v_mov_b32_e32 v36, v25
	v_mov_b32_e32 v28, v21
	v_cndmask_b32_e32 v18, v23, v34, vcc
	ds_write_b16_d16_hi v50, v18 offset:512
	ds_write_b16_d16_hi v50, v19 offset:544
	v_pk_add_f32 v[18:19], v[32:33], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[32:33], v[42:43], v[62:63] op_sel_hi:[0,1]
	v_rcp_f32_e32 v18, v18
	v_rcp_f32_e32 v19, v19
	v_mov_b32_e32 v34, v20
	v_pk_mul_f32 v[32:33], v[34:35], v[32:33]
	v_pk_mul_f32 v[18:19], v[26:27], v[18:19]
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[26:27], v[44:45], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[18:19], v[32:33], v[18:19]
	v_pk_mul_f32 v[24:25], v[36:37], v[26:27]
	v_bfe_u32 v20, v19, 16, 1
	v_pk_mul_f32 v[26:27], v[24:25], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v20, v20, v19, s35
	v_or_b32_e32 v23, 0x400000, v19
	v_cmp_u_f32_e32 vcc, v19, v19
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v19, v20, v23, vcc
	v_bfe_u32 v20, v18, 16, 1
	v_add3_u32 v20, v20, v18, s35
	v_or_b32_e32 v23, 0x400000, v18
	v_cmp_u_f32_e32 vcc, v18, v18
	s_nop 1
	v_cndmask_b32_e32 v18, v20, v23, vcc
	ds_write_b16_d16_hi v50, v18 offset:1024
	ds_write_b16_d16_hi v50, v19 offset:1056
	v_pk_add_f32 v[18:19], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[44:45], v[62:63] op_sel_hi:[0,1]
	v_rcp_f32_e32 v18, v18
	v_rcp_f32_e32 v19, v19
	v_pk_mul_f32 v[20:21], v[28:29], v[26:27]
	v_mov_b32_e32 v27, v2
	v_pk_mul_f32 v[18:19], v[24:25], v[18:19]
	v_mov_b32_e32 v24, v14
	v_pk_mul_f32 v[18:19], v[20:21], v[18:19]
	v_mov_b32_e32 v25, v6
	v_bfe_u32 v20, v19, 16, 1
	v_add3_u32 v20, v20, v19, s35
	v_or_b32_e32 v21, 0x400000, v19
	v_cmp_u_f32_e32 vcc, v19, v19
	v_or_b32_e32 v26, 0x400000, v18
	s_nop 0
	v_cndmask_b32_e32 v19, v20, v21, vcc
	v_bfe_u32 v20, v18, 16, 1
	v_add3_u32 v23, v20, v18, s35
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[20:21], v[46:47], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[20:21], v[24:25], v[20:21]
	v_cmp_u_f32_e32 vcc, v18, v18
	v_pk_mul_f32 v[24:25], v[20:21], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v24, v24
	v_exp_f32_e32 v25, v25
	v_cndmask_b32_e32 v6, v23, v26, vcc
	ds_write_b16_d16_hi v50, v6 offset:1536
	ds_write_b16_d16_hi v50, v19 offset:1568
	v_mov_b32_e32 v26, v10
	v_pk_add_f32 v[18:19], v[24:25], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[24:25], v[46:47], v[62:63] op_sel_hi:[0,1]
	v_rcp_f32_e32 v18, v18
	v_rcp_f32_e32 v19, v19
	v_pk_mul_f32 v[24:25], v[26:27], v[24:25]
	v_pk_mul_f32 v[18:19], v[20:21], v[18:19]
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[20:21], v[48:49], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[18:19], v[24:25], v[18:19]
	s_nop 0
	v_bfe_u32 v2, v19, 16, 1
	v_add3_u32 v2, v2, v19, s35
	v_or_b32_e32 v6, 0x400000, v19
	v_cmp_u_f32_e32 vcc, v19, v19
	v_or_b32_e32 v19, 0x400000, v18
	s_nop 0
	v_cndmask_b32_e32 v2, v2, v6, vcc
	v_bfe_u32 v6, v18, 16, 1
	v_add3_u32 v10, v6, v18, s35
	v_mov_b32_e32 v6, v15
	v_pk_mul_f32 v[6:7], v[6:7], v[20:21]
	v_cmp_u_f32_e32 vcc, v18, v18
	v_pk_mul_f32 v[14:15], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v10, v10, v19, vcc
	ds_write_b16_d16_hi v50, v10 offset:8192
	ds_write_b16_d16_hi v50, v2 offset:8224
	v_pk_mul_f32 v[18:19], v[48:49], v[62:63] op_sel_hi:[0,1]
	v_pk_add_f32 v[14:15], v[14:15], 1.0 op_sel_hi:[1,0]
	v_mov_b32_e32 v2, v11
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_pk_mul_f32 v[2:3], v[2:3], v[18:19]
	v_mov_b32_e32 v10, v16
	v_mov_b32_e32 v11, v8
	v_pk_mul_f32 v[6:7], v[6:7], v[14:15]
	v_mov_b32_e32 v8, v17
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	s_nop 0
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s35
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v15, 0x400000, v2
	s_nop 0
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v14, v6, v2, s35
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[6:7], v[54:55], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_pk_mul_f32 v[10:11], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_cndmask_b32_e32 v2, v14, v15, vcc
	ds_write_b16_d16_hi v50, v2 offset:8704
	ds_write_b16_d16_hi v50, v3 offset:8736
	v_mov_b32_e32 v14, v12
	v_pk_add_f32 v[2:3], v[10:11], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[10:11], v[54:55], v[62:63] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v15, v4
	v_pk_mul_f32 v[10:11], v[14:15], v[10:11]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[10:11], v[2:3]
	s_nop 0
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s35
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v10, 0x400000, v2
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v6, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[56:57], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_bfe_u32 v4, v2, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v4, v4, v2, s35
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v2, v2
	s_lshl_b32 s0, s49, 8
	s_mov_b32 s1, 0x43700000
	v_cndmask_b32_e32 v2, v4, v10, vcc
	ds_write_b16_d16_hi v50, v2 offset:9216
	ds_write_b16_d16_hi v50, v3 offset:9248
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[56:57], v[62:63] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v4, v13
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_mov_b32_e32 v9, 0x7fc00000
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_and_b32_e32 v62, 0x3f0, v71
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
	ds_write_b16_d16_hi v50, v2 offset:9728
	ds_write_b16_d16_hi v50, v3 offset:9760
	v_lshlrev_b32_e32 v2, 2, v78
	v_or_b32_e32 v3, s0, v2
	v_lshlrev_b32_e32 v3, 1, v3
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[4:5], v3 offset:8192
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v3, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v3, vcc
	v_max_f32_e64 v8, v3, |v5|
	v_cmp_o_f32_e64 vcc, v3, |v5|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v6|
	v_cmp_o_f32_e64 vcc, v3, |v6|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v7|
	v_cmp_o_f32_e64 vcc, v3, |v7|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	v_xor_b32_e32 v10, 0x80, v2
	ds_bpermute_b32 v8, v10, v3
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v11, vcc
	v_div_scale_f32 v8, s[4:5], s1, s1, v3
	v_rcp_f32_e32 v11, v8
	s_nop 0
	v_fma_f32 v12, -v8, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, v3, s1, v3
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v11, v13
	v_div_fixup_f32 v8, v8, s1, v3
	v_cmp_neq_f32_e32 vcc, 0, v3
	s_nop 1
	v_cndmask_b32_e32 v3, 1.0, v8, vcc
	v_div_scale_f32 v8, s[4:5], v3, v3, 1.0
	v_rcp_f32_e32 v11, v8
	s_nop 0
	v_fma_f32 v12, -v8, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, 1.0, v3, 1.0
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v11, v13
	v_div_fixup_f32 v8, v8, v3, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_mov_b32_e32 v11, s2
	ds_write_b32 v11, v3 offset:24576
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_lshl_b32 s2, s49, 4
	s_and_b32 s2, s2, 0xf0
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_mov_b32_e32 v8, v41
	v_cvt_pk_fp8_f32 v8, v4, v5
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v8, v6, v4 op_sel:[0,0,1]
	v_xor_b32_e32 v4, s2, v2
	v_or_b32_e32 v12, s0, v4
	s_add_i32 s2, s49, 8
	v_and_b32_e32 v3, 0x7f7f7f7f, v8
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v8
	ds_write_b32 v12, v3
	v_lshlrev_b32_e32 v3, 3, v78
	v_lshl_or_b32 v4, s2, 9, v3
	ds_read_b64 v[4:5], v4 offset:8192
	s_lshl_b32 s2, s2, 4
	s_and_b32 s2, s2, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v8, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v8, vcc
	v_max_f32_e64 v13, v8, |v5|
	v_cmp_o_f32_e64 vcc, v8, |v5|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v6|
	v_cmp_o_f32_e64 vcc, v8, |v6|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v7|
	v_cmp_o_f32_e64 vcc, v8, |v7|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_bpermute_b32 v13, v10, v8
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_div_scale_f32 v13, s[4:5], s1, s1, v8
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v8, s1, v8
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s1, v8
	v_cmp_neq_f32_e32 vcc, 0, v8
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v8, s[4:5], v13, v13, 1.0
	v_rcp_f32_e32 v14, v8
	ds_write_b32 v11, v13 offset:24608
	v_fma_f32 v15, -v8, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v8, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v8, -v8, v16, v15
	v_div_fmas_f32 v8, v8, v14, v16
	v_div_fixup_f32 v8, v8, v13, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_mov_b32_e32 v8, v41
	v_cvt_pk_fp8_f32 v8, v4, v5
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	v_xor_b32_e32 v5, s2, v2
	s_lshl_b32 s2, s49, 9
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v8, v6, v4 op_sel:[0,0,1]
	v_or_b32_e32 v5, s0, v5
	s_addk_i32 s2, 0x2000
	s_add_i32 s49, s49, 24
	v_and_b32_e32 v4, 0x7f7f7f7f, v8
	v_add_u32_e32 v4, 0x7f7f7f7f, v4
	v_or_b32_e32 v4, 0x7f7f7f7f, v4
	v_and_b32_e32 v4, v4, v8
	ds_write_b32 v5, v4 offset:2048
	v_or_b32_e32 v4, s2, v3
	ds_read_b64 v[4:5], v4 offset:8192
	v_lshl_or_b32 v3, s49, 9, v3
	s_brev_b32 s2, 16
	s_mov_b32 s30, s2
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v8, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v8, vcc
	v_max_f32_e64 v13, v8, |v5|
	v_cmp_o_f32_e64 vcc, v8, |v5|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v6|
	v_cmp_o_f32_e64 vcc, v8, |v6|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v7|
	v_cmp_o_f32_e64 vcc, v8, |v7|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_bpermute_b32 v13, v10, v8
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_div_scale_f32 v13, s[4:5], s1, s1, v8
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v8, s1, v8
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s1, v8
	v_cmp_neq_f32_e32 vcc, 0, v8
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v8, s[4:5], v13, v13, 1.0
	v_rcp_f32_e32 v14, v8
	ds_write_b32 v11, v13 offset:24640
	v_fma_f32 v15, -v8, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v8, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v8, -v8, v16, v15
	v_div_fmas_f32 v8, v8, v14, v16
	v_div_fixup_f32 v8, v8, v13, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_mov_b32_e32 v8, v41
	v_cvt_pk_fp8_f32 v8, v4, v5
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v8, v6, v4 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v4, 0x7f7f7f7f, v8
	v_add_u32_e32 v4, 0x7f7f7f7f, v4
	v_or_b32_e32 v4, 0x7f7f7f7f, v4
	v_and_b32_e32 v4, v4, v8
	ds_write_b32 v12, v4 offset:4096
	ds_read_b64 v[4:5], v3 offset:8192
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v3, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v3, vcc
	v_max_f32_e64 v8, v3, |v5|
	v_cmp_o_f32_e64 vcc, v3, |v5|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v6|
	v_cmp_o_f32_e64 vcc, v3, |v6|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v7|
	v_cmp_o_f32_e64 vcc, v3, |v7|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_bpermute_b32 v8, v10, v3
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	v_div_scale_f32 v8, s[4:5], s1, s1, v3
	v_rcp_f32_e32 v10, v8
	s_nop 0
	v_fma_f32 v12, -v8, v10, 1.0
	v_fmac_f32_e32 v10, v12, v10
	v_div_scale_f32 v12, vcc, v3, s1, v3
	v_mul_f32_e32 v13, v12, v10
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v10
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v10, v13
	v_div_fixup_f32 v8, v8, s1, v3
	v_cmp_neq_f32_e32 vcc, 0, v3
	s_lshl_b32 s1, s49, 4
	s_and_b32 s1, s1, 0xf0
	v_cndmask_b32_e32 v3, 1.0, v8, vcc
	v_div_scale_f32 v8, s[4:5], v3, v3, 1.0
	v_rcp_f32_e32 v10, v8
	ds_write_b32 v11, v3 offset:24672
	v_xor_b32_e32 v2, s1, v2
	v_or_b32_e32 v2, s0, v2
	v_fma_f32 v12, -v8, v10, 1.0
	v_fmac_f32_e32 v10, v12, v10
	v_div_scale_f32 v12, vcc, 1.0, v3, 1.0
	v_mul_f32_e32 v13, v12, v10
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v10
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v10, v13
	v_div_fixup_f32 v8, v8, v3, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_and_b32 s1, s15, 0xffff
	s_add_i32 s15, s48, s11
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_lshl_b32 s0, s15, 1
	s_ashr_i32 s4, s15, 31
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_lshr_b32 s7, s4, 27
	s_mov_b32 s29, s1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_and_b32 s5, s19, 0xffff
	s_mov_b32 s45, s5
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	v_cvt_pk_fp8_f32 v41, v4, v5
	v_or_b32_e32 v12, 0x90, v73
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	v_or_b32_e32 v14, 0x98, v73
	s_mov_b32 s11, s3
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_add_i32 s16, s15, 0x100
	s_nop 0
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v41, v6, v4 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v3, 0x7f7f7f7f, v41
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v41
	ds_write_b32 v2, v3 offset:6144
	v_lshlrev_b32_e32 v2, 2, v38
	v_or_b32_e32 v3, 4, v2
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_or_b32_e32 v4, 8, v2
	v_or_b32_e32 v5, 12, v2
	v_or_b32_e32 v6, 64, v2
	v_or_b32_e32 v7, 0x44, v2
	v_or_b32_e32 v8, 0x48, v2
	v_or_b32_e32 v9, 0x4c, v2
	buffer_load_dword v46, v2, s[24:27], 0 offen
	buffer_load_dword v47, v3, s[24:27], 0 offen
	buffer_load_dword v48, v4, s[24:27], 0 offen
	buffer_load_dword v49, v5, s[24:27], 0 offen
	buffer_load_dword v42, v6, s[24:27], 0 offen
	buffer_load_dword v43, v7, s[24:27], 0 offen
	buffer_load_dword v44, v8, s[24:27], 0 offen
	buffer_load_dword v45, v9, s[24:27], 0 offen
	v_or3_b32 v3, s0, v70, v1
	s_lshl_b32 s0, s15, 3
	v_or3_b32 v4, s0, v70, v1
	s_or_b32 s0, s15, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_or_b32_e32 v2, s15, v1
	v_lshlrev_b32_e32 v4, 4, v4
	s_add_i32 s7, s7, s4
	v_lshlrev_b32_e32 v2, 2, v2
	v_or_b32_e32 v5, 0x400, v4
	buffer_load_dwordx4 v[38:41], v4, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[34:37], v5, s[28:31], 0 offen nt
	v_or_b32_e32 v4, s0, v1
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dword v65, v2, s[44:47], 0 offen
	buffer_load_dword v64, v4, s[44:47], 0 offen
	v_or3_b32 v2, s4, v70, v1
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s0, 3
	buffer_load_dword v66, v3, s[36:39], 0 offen
	buffer_load_dword v59, v2, s[36:39], 0 offen
	v_or3_b32 v2, s0, v70, v1
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[30:33], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[26:29], v3, s[28:31], 0 offen nt
	v_lshlrev_b32_e32 v2, 4, v1
	v_xor_b32_e32 v3, v73, v2
	v_add_u32_e32 v4, v74, v74
	v_xor_b32_e32 v8, v76, v2
	v_add_u32_e32 v5, v4, v3
	v_xor_b32_e32 v6, v77, v2
	v_add_u32_e32 v9, v4, v8
	v_xor_b32_e32 v10, v75, v2
	v_add_u32_e32 v7, v4, v6
	v_add_u32_e32 v11, v4, v10
	ds_read_b64 v[98:99], v5
	ds_read_b64 v[94:95], v7
	ds_read_b64 v[90:91], v9
	ds_read_b64 v[86:87], v11
	v_or_b32_e32 v5, 0x80, v73
	v_or_b32_e32 v9, 0x88, v73
	v_xor_b32_e32 v5, v5, v2
	v_xor_b32_e32 v9, v9, v2
	v_xor_b32_e32 v12, v12, v2
	v_xor_b32_e32 v2, v14, v2
	v_add_u32_e32 v7, v4, v5
	v_add_u32_e32 v11, v4, v9
	v_add_u32_e32 v13, v4, v12
	v_add_u32_e32 v14, v4, v2
	v_or_b32_e32 v4, 0x1000, v4
	v_add_u32_e32 v3, v4, v3
	ds_read_b64 v[82:83], v7
	ds_read_b64 v[78:79], v11
	ds_read_b64 v[74:75], v13
	ds_read_b64 v[68:69], v14
	v_add_u32_e32 v6, v4, v6
	v_add_u32_e32 v7, v4, v8
	v_add_u32_e32 v8, v4, v10
	ds_read_b64 v[102:103], v3
	ds_read_b64 v[100:101], v6
	ds_read_b64 v[96:97], v7
	ds_read_b64 v[92:93], v8
	v_add_u32_e32 v3, v4, v5
	v_add_u32_e32 v5, v4, v9
	v_add_u32_e32 v6, v4, v12
	v_add_u32_e32 v2, v4, v2
	ds_read_b64 v[88:89], v3
	ds_read_b64 v[84:85], v5
	ds_read_b64 v[80:81], v6
	ds_read_b64 v[76:77], v2
	v_lshlrev_b32_e32 v2, 4, v72
	ds_read_b128 v[6:9], v2 offset:24576
	ds_read_b128 v[2:5], v2 offset:24640
	v_lshrrev_b32_e32 v10, 5, v0
	v_lshlrev_b32_e32 v11, 1, v0
	v_and_b32_e32 v60, 62, v11
	v_or_b32_e32 v11, s34, v10
	v_lshlrev_b32_e32 v57, 2, v11
	v_or_b32_e32 v11, 16, v10
	v_or_b32_e32 v12, s34, v11
	v_lshlrev_b32_e32 v0, 2, v0
	s_mov_b32 s0, s14
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_add_i32 s18, s15, 1
	v_lshlrev_b32_e32 v55, 2, v12
	v_lshlrev_b32_e32 v53, 1, v60
	v_lshl_or_b32 v56, v10, 9, v22
	v_lshl_add_u32 v54, v11, 9, v22
	v_and_b32_e32 v61, 0xfc, v0
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[14:15]
	s_add_i32 s17, s17, 1
	s_cmp_lg_u32 s17, 15
	v_mov_b64_e32 v[40:41], v[24:25]
	v_mov_b64_e32 v[38:39], v[22:23]
	v_mov_b64_e32 v[36:37], v[20:21]
	v_mov_b64_e32 v[34:35], v[18:19]
	v_mov_b64_e32 v[32:33], v[16:17]
	v_mov_b64_e32 v[30:31], v[14:15]
	v_mov_b64_e32 v[28:29], v[12:13]
	v_mov_b64_e32 v[26:27], v[10:11]
	v_mov_b32_e32 v64, v0
	v_mov_b32_e32 v65, v58
	v_mov_b32_e32 v66, v63
	s_barrier
	s_cbranch_scc0 .LBB0_9
.LBB0_5:
	s_lshl_b32 s19, s17, 8
	s_add_i32 s14, s18, s19
	s_lshr_b32 s15, s14, 31
	s_add_i32 s15, s14, s15
	s_and_b32 s15, s15, 0x1ffffffe
	s_sub_i32 s14, s14, s15
	s_lshl_b32 s14, s14, 3
	s_waitcnt vmcnt(2)
	v_bfe_u32 v108, v59, s14, 8
	s_add_i32 s14, s14, 16
	v_bfe_u32 v109, v59, s14, 8
	s_add_i32 s14, s16, s19
	v_or_b32_e32 v0, s14, v1
	v_lshlrev_b32_e32 v10, 2, v0
	v_lshl_or_b32 v11, s14, 3, v61
	v_lshl_or_b32 v0, s14, 7, v62
	s_or_b32 s15, s14, 16
	s_ashr_i32 s14, s14, 31
	s_lshr_b32 s24, s14, 27
	s_add_i32 s24, s15, s24
	s_lshr_b32 s24, s24, 5
	buffer_load_dwordx4 v[22:25], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[18:21], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s15, v1
	s_add_i32 s24, s24, s14
	v_lshlrev_b32_e32 v12, 2, v0
	buffer_load_dword v58, v10, s[4:7], 0 offen
	buffer_load_dword v0, v12, s[4:7], 0 offen
	v_lshl_or_b32 v10, s24, 8, v61
	v_lshl_or_b32 v67, s15, 7, v62
	buffer_load_dword v63, v11, s[8:11], 0 offen
	buffer_load_dword v59, v10, s[8:11], 0 offen
	buffer_load_dwordx4 v[14:17], v67, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[10:13], v67, s[0:3], 0 offen offset:1024 nt
	v_sub_u32_sdwa v67, v65, v66 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v70, 11, v67
	v_mul_lo_u32 v70, v70, s40
	v_sub_u32_e32 v71, 0x6c686080, v70
	v_and_b32_e32 v71, 0xffffff00, v71
	v_cmp_lt_i32_e32 vcc, 11, v67
	v_sub_u32_e32 v70, 0x7c787470, v70
	v_lshlrev_b32_e32 v73, 4, v38
	v_cndmask_b32_e64 v67, v71, 0, vcc
	v_cndmask_b32_e64 v110, v70, 0, vcc
	v_add_u32_e32 v70, 0x7f7f7f00, v67
	v_and_b32_e32 v111, 0x80808000, v70
	v_add_u32_e32 v70, 0x7f7f7f78, v110
	v_and_b32_e32 v112, 0x80808080, v70
	v_and_b32_e32 v70, 0x7070707, v38
	v_lshrrev_b32_e32 v71, 4, v38
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v112, v111, v70
	v_perm_b32 v70, v110, v67, v70
	v_and_or_b32 v70, v72, v73, v70
	v_perm_b32 v72, v112, v111, v71
	v_perm_b32 v71, v110, v67, v71
	v_and_or_b32 v38, v72, v38, v71
	v_sub_u32_sdwa v66, v65, v66 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v104, v38, v70, s41
	v_perm_b32 v105, v38, v70, s42
	v_min_i32_e32 v38, 11, v66
	v_mul_lo_u32 v113, v38, s40
	v_and_b32_e32 v38, 0x7070707, v39
	v_lshrrev_b32_e32 v114, 4, v39
	s_waitcnt lgkmcnt(14)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[98:99], v[104:105], 0
	v_and_b32_e32 v114, 0x7070707, v114
	v_perm_b32 v115, v112, v111, v38
	v_lshlrev_b32_e32 v116, 4, v39
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[102:103], v[104:105], 0
	v_perm_b32 v38, v110, v67, v38
	v_and_or_b32 v115, v115, v116, v38
	v_perm_b32 v38, v112, v111, v114
	v_perm_b32 v114, v110, v67, v114
	v_and_or_b32 v39, v38, v39, v114
	v_perm_b32 v38, v39, v115, s41
	v_perm_b32 v39, v39, v115, s42
	v_lshlrev_b32_e32 v116, 4, v40
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[94:95], v[38:39], v[70:73]
	v_lshlrev_b32_e32 v66, 4, v41
	v_sub_u32_e32 v114, 0x6c686080, v113
	v_and_b32_e32 v114, 0xffffff00, v114
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[100:101], v[38:39], v[104:107]
	v_and_b32_e32 v38, 0x7070707, v40
	v_lshrrev_b32_e32 v39, 4, v40
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v115, v112, v111, v38
	v_perm_b32 v38, v110, v67, v38
	v_and_or_b32 v115, v115, v116, v38
	v_perm_b32 v38, v112, v111, v39
	v_perm_b32 v39, v110, v67, v39
	v_and_or_b32 v39, v38, v40, v39
	v_perm_b32 v38, v39, v115, s41
	v_perm_b32 v39, v39, v115, s42
	v_sub_u32_e32 v113, 0x7c787470, v113
	v_cndmask_b32_e64 v114, v114, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[90:91], v[38:39], v[70:73]
	v_cndmask_b32_e64 v113, v113, 0, vcc
	v_add_u32_e32 v115, 0x7f7f7f00, v114
	v_sub_u32_e32 v109, v64, v109
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[96:97], v[38:39], v[104:107]
	v_and_b32_e32 v38, 0x7070707, v41
	v_lshrrev_b32_e32 v39, 4, v41
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v40, v112, v111, v38
	v_perm_b32 v38, v110, v67, v38
	v_and_or_b32 v38, v40, v66, v38
	v_perm_b32 v40, v112, v111, v39
	v_perm_b32 v39, v110, v67, v39
	v_and_or_b32 v39, v40, v41, v39
	v_perm_b32 v66, v39, v38, s41
	v_perm_b32 v67, v39, v38, s42
	v_and_b32_e32 v110, 0x80808000, v115
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[86:87], v[66:67], v[70:73]
	s_nop 2
	v_add_u32_e32 v70, 0x7f7f7f78, v113
	v_and_b32_e32 v111, 0x80808080, v70
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[92:93], v[66:67], v[104:107]
	v_and_b32_e32 v66, 0x7070707, v34
	v_lshrrev_b32_e32 v67, 4, v34
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v104, v111, v110, v66
	v_lshlrev_b32_e32 v105, 4, v34
	v_perm_b32 v66, v113, v114, v66
	v_and_or_b32 v104, v104, v105, v66
	v_perm_b32 v66, v111, v110, v67
	v_perm_b32 v67, v113, v114, v67
	v_and_or_b32 v34, v66, v34, v67
	v_perm_b32 v66, v34, v104, s41
	v_perm_b32 v67, v34, v104, s42
	v_and_b32_e32 v34, 0x7070707, v35
	v_lshlrev_b32_e32 v104, 4, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[82:83], v[66:67], v[38:41]
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[88:89], v[66:67], v[70:73]
	v_lshrrev_b32_e32 v66, 4, v35
	v_and_b32_e32 v66, 0x7070707, v66
	v_perm_b32 v67, v111, v110, v34
	v_perm_b32 v34, v113, v114, v34
	v_and_or_b32 v67, v67, v104, v34
	v_perm_b32 v34, v111, v110, v66
	v_perm_b32 v66, v113, v114, v66
	v_and_or_b32 v35, v34, v35, v66
	v_perm_b32 v34, v35, v67, s41
	v_perm_b32 v35, v35, v67, s42
	v_lshlrev_b32_e32 v67, 4, v36
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[78:79], v[34:35], v[38:41]
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[84:85], v[34:35], v[70:73]
	v_and_b32_e32 v34, 0x7070707, v36
	v_lshrrev_b32_e32 v35, 4, v36
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v66, v111, v110, v34
	v_perm_b32 v34, v113, v114, v34
	v_and_or_b32 v66, v66, v67, v34
	v_perm_b32 v34, v111, v110, v35
	v_perm_b32 v35, v113, v114, v35
	v_and_or_b32 v35, v34, v36, v35
	v_perm_b32 v34, v35, v66, s41
	v_perm_b32 v35, v35, v66, s42
	v_lshlrev_b32_e32 v66, 4, v37
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[74:75], v[34:35], v[38:41]
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[80:81], v[34:35], v[70:73]
	v_and_b32_e32 v34, 0x7070707, v37
	v_lshrrev_b32_e32 v35, 4, v37
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v111, v110, v34
	v_perm_b32 v34, v113, v114, v34
	v_and_or_b32 v36, v36, v66, v34
	v_perm_b32 v34, v111, v110, v35
	v_perm_b32 v35, v113, v114, v35
	v_sub_u32_e32 v66, v64, v108
	v_and_or_b32 v35, v34, v37, v35
	v_min_i32_e32 v67, 11, v66
	v_perm_b32 v34, v35, v36, s41
	v_perm_b32 v35, v35, v36, s42
	v_mul_lo_u32 v67, v67, s40
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[68:69], v[34:35], v[38:41]
	s_waitcnt vmcnt(9)
	v_lshlrev_b32_e32 v114, 4, v31
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[76:77], v[34:35], v[70:73]
	s_nop 2
	v_sub_u32_e32 v70, 0x6c686080, v67
	v_and_b32_e32 v70, 0xffffff00, v70
	v_sub_u32_e32 v67, 0x7c787470, v67
	v_cndmask_b32_e64 v108, v70, 0, vcc
	v_cndmask_b32_e64 v110, v67, 0, vcc
	v_add_u32_e32 v66, 0x7f7f7f00, v108
	v_and_b32_e32 v111, 0x80808000, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v110
	v_and_b32_e32 v112, 0x80808080, v66
	v_and_b32_e32 v66, 0x7070707, v30
	v_lshrrev_b32_e32 v67, 4, v30
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v70, v112, v111, v66
	v_lshlrev_b32_e32 v71, 4, v30
	v_perm_b32 v66, v110, v108, v66
	v_and_or_b32 v70, v70, v71, v66
	v_perm_b32 v66, v112, v111, v67
	v_perm_b32 v67, v110, v108, v67
	v_and_or_b32 v30, v66, v30, v67
	v_perm_b32 v66, v30, v70, s41
	v_perm_b32 v67, v30, v70, s42
	v_min_i32_e32 v30, 11, v109
	v_mul_lo_u32 v113, v30, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[98:99], v[66:67], 0
	v_and_b32_e32 v30, 0x7070707, v31
	v_cmp_lt_i32_e32 vcc, 11, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[102:103], v[66:67], 0
	v_lshrrev_b32_e32 v66, 4, v31
	v_and_b32_e32 v66, 0x7070707, v66
	v_perm_b32 v67, v112, v111, v30
	v_perm_b32 v30, v110, v108, v30
	v_and_or_b32 v67, v67, v114, v30
	v_perm_b32 v30, v112, v111, v66
	v_perm_b32 v66, v110, v108, v66
	v_and_or_b32 v31, v30, v31, v66
	v_perm_b32 v30, v31, v67, s41
	v_perm_b32 v31, v31, v67, s42
	v_sub_u32_e32 v66, 0x6c686080, v113
	v_sub_u32_e32 v67, 0x7c787470, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[94:95], v[30:31], v[70:73]
	v_lshlrev_b32_e32 v114, 4, v32
	v_and_b32_e32 v66, 0xffffff00, v66
	v_cndmask_b32_e64 v109, v66, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[100:101], v[30:31], v[104:107]
	v_and_b32_e32 v30, 0x7070707, v32
	v_lshrrev_b32_e32 v31, 4, v32
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v113, v112, v111, v30
	v_perm_b32 v30, v110, v108, v30
	v_and_or_b32 v113, v113, v114, v30
	v_perm_b32 v30, v112, v111, v31
	v_perm_b32 v31, v110, v108, v31
	v_and_or_b32 v31, v30, v32, v31
	v_perm_b32 v30, v31, v113, s41
	v_perm_b32 v31, v31, v113, s42
	v_lshlrev_b32_e32 v66, 4, v33
	v_cndmask_b32_e64 v113, v67, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[90:91], v[30:31], v[70:73]
	v_add_u32_e32 v114, 0x7f7f7f00, v109
	v_cmp_lt_i32_e32 vcc, 5, v65
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[96:97], v[30:31], v[104:107]
	v_and_b32_e32 v30, 0x7070707, v33
	v_lshrrev_b32_e32 v31, 4, v33
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v112, v111, v30
	v_perm_b32 v30, v110, v108, v30
	v_and_or_b32 v30, v32, v66, v30
	v_perm_b32 v32, v112, v111, v31
	v_perm_b32 v31, v110, v108, v31
	v_and_or_b32 v31, v32, v33, v31
	v_perm_b32 v66, v31, v30, s41
	v_perm_b32 v67, v31, v30, s42
	v_and_b32_e32 v108, 0x80808000, v114
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[86:87], v[66:67], v[70:73]
	s_nop 2
	v_add_u32_e32 v70, 0x7f7f7f78, v113
	v_and_b32_e32 v110, 0x80808080, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[92:93], v[66:67], v[104:107]
	s_waitcnt vmcnt(8)
	v_and_b32_e32 v66, 0x7070707, v26
	v_lshrrev_b32_e32 v67, 4, v26
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v104, v110, v108, v66
	v_lshlrev_b32_e32 v105, 4, v26
	v_perm_b32 v66, v113, v109, v66
	v_and_or_b32 v104, v104, v105, v66
	v_perm_b32 v66, v110, v108, v67
	v_perm_b32 v67, v113, v109, v67
	v_and_or_b32 v26, v66, v26, v67
	v_perm_b32 v66, v26, v104, s41
	v_perm_b32 v67, v26, v104, s42
	v_and_b32_e32 v26, 0x7070707, v27
	v_lshlrev_b32_e32 v104, 4, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[82:83], v[66:67], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[88:89], v[66:67], v[70:73]
	v_lshrrev_b32_e32 v66, 4, v27
	v_and_b32_e32 v66, 0x7070707, v66
	v_perm_b32 v67, v110, v108, v26
	v_perm_b32 v26, v113, v109, v26
	v_and_or_b32 v67, v67, v104, v26
	v_perm_b32 v26, v110, v108, v66
	v_perm_b32 v66, v113, v109, v66
	v_and_or_b32 v27, v26, v27, v66
	v_perm_b32 v26, v27, v67, s41
	v_perm_b32 v27, v27, v67, s42
	v_lshlrev_b32_e32 v67, 4, v28
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[78:79], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[84:85], v[26:27], v[70:73]
	v_and_b32_e32 v26, 0x7070707, v28
	v_lshrrev_b32_e32 v27, 4, v28
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v66, v110, v108, v26
	v_perm_b32 v26, v113, v109, v26
	v_and_or_b32 v66, v66, v67, v26
	v_perm_b32 v26, v110, v108, v27
	v_perm_b32 v27, v113, v109, v27
	v_and_or_b32 v27, v26, v28, v27
	v_perm_b32 v26, v27, v66, s41
	v_perm_b32 v27, v27, v66, s42
	v_lshlrev_b32_e32 v66, 4, v29
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[74:75], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[80:81], v[26:27], v[70:73]
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v110, v108, v26
	v_perm_b32 v26, v113, v109, v26
	v_and_or_b32 v26, v28, v66, v26
	v_perm_b32 v28, v110, v108, v27
	v_perm_b32 v27, v113, v109, v27
	v_and_or_b32 v27, v28, v29, v27
	v_perm_b32 v66, v27, v26, s41
	v_perm_b32 v67, v27, v26, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[68:69], v[66:67], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[76:77], v[66:67], v[70:73]
	v_add_u32_e32 v67, 17, v65
	v_lshl_add_u32 v66, v65, 23, v52
	v_lshlrev_b32_e64 v67, v67, 1
	v_cndmask_b32_e32 v66, v67, v66, vcc
	v_add_u32_e32 v67, 17, v64
	v_lshlrev_b32_e64 v67, v67, 1
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[72:73], v[8:9], v[66:67] op_sel_hi:[1,0]
	v_lshl_add_u32 v65, v64, 23, v52
	v_pk_mul_f32 v[40:41], v[72:73], v[40:41]
	v_cmp_lt_i32_e32 vcc, 5, v64
	v_pk_mul_f32 v[40:41], v[40:41], v[48:49]
	v_pk_mul_f32 v[70:71], v[6:7], v[66:67] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v64, v67, v65, vcc
	v_bfe_u32 v65, v41, 16, 1
	v_add3_u32 v65, v65, v41, s35
	v_or_b32_e32 v67, 0x400000, v41
	v_cmp_u_f32_e32 vcc, v41, v41
	v_pk_mul_f32 v[38:39], v[70:71], v[38:39]
	s_nop 0
	v_cndmask_b32_e32 v41, v65, v67, vcc
	v_bfe_u32 v65, v40, 16, 1
	v_pk_mul_f32 v[38:39], v[38:39], v[46:47]
	v_add3_u32 v65, v65, v40, s35
	v_or_b32_e32 v67, 0x400000, v40
	v_cmp_u_f32_e32 vcc, v40, v40
	s_nop 1
	v_cndmask_b32_e32 v40, v65, v67, vcc
	v_bfe_u32 v65, v39, 16, 1
	v_add3_u32 v65, v65, v39, s35
	v_or_b32_e32 v67, 0x400000, v39
	v_cmp_u_f32_e32 vcc, v39, v39
	s_nop 1
	v_cndmask_b32_e32 v39, v65, v67, vcc
	v_bfe_u32 v65, v38, 16, 1
	v_add3_u32 v65, v65, v38, s35
	v_or_b32_e32 v67, 0x400000, v38
	v_cmp_u_f32_e32 vcc, v38, v38
	s_nop 1
	v_cndmask_b32_e32 v38, v65, v67, vcc
	ds_write_b16_d16_hi v51, v38
	ds_write_b16_d16_hi v50, v39 offset:512
	ds_write_b16_d16_hi v50, v40 offset:1024
	ds_write_b16_d16_hi v50, v41 offset:1536
	v_pk_mul_f32 v[40:41], v[8:9], v[64:65] op_sel_hi:[1,0]
	v_pk_mul_f32 v[38:39], v[6:7], v[64:65] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[40:41], v[28:29]
	v_pk_mul_f32 v[26:27], v[38:39], v[26:27]
	v_pk_mul_f32 v[28:29], v[28:29], v[48:49]
	v_pk_mul_f32 v[26:27], v[26:27], v[46:47]
	v_bfe_u32 v38, v29, 16, 1
	v_add3_u32 v38, v38, v29, s35
	v_or_b32_e32 v39, 0x400000, v29
	v_cmp_u_f32_e32 vcc, v29, v29
	s_nop 1
	v_cndmask_b32_e32 v29, v38, v39, vcc
	v_bfe_u32 v38, v28, 16, 1
	v_add3_u32 v38, v38, v28, s35
	v_or_b32_e32 v39, 0x400000, v28
	v_cmp_u_f32_e32 vcc, v28, v28
	s_nop 1
	v_cndmask_b32_e32 v28, v38, v39, vcc
	v_bfe_u32 v38, v27, 16, 1
	v_add3_u32 v38, v38, v27, s35
	v_or_b32_e32 v39, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	s_nop 1
	v_cndmask_b32_e32 v27, v38, v39, vcc
	v_bfe_u32 v38, v26, 16, 1
	v_add3_u32 v38, v38, v26, s35
	v_or_b32_e32 v39, 0x400000, v26
	v_cmp_u_f32_e32 vcc, v26, v26
	s_nop 1
	v_cndmask_b32_e32 v26, v38, v39, vcc
	ds_write_b16_d16_hi v50, v26 offset:32
	ds_write_b16_d16_hi v50, v27 offset:544
	ds_write_b16_d16_hi v50, v28 offset:1056
	ds_write_b16_d16_hi v50, v29 offset:1568
	s_waitcnt lgkmcnt(8)
	v_pk_mul_f32 v[28:29], v[4:5], v[66:67] op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[2:3], v[66:67] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[28:29], v[36:37]
	v_pk_mul_f32 v[26:27], v[26:27], v[34:35]
	v_pk_mul_f32 v[28:29], v[28:29], v[44:45]
	v_pk_mul_f32 v[26:27], v[26:27], v[42:43]
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
	ds_write_b16_d16_hi v50, v26 offset:8192
	ds_write_b16_d16_hi v50, v27 offset:8704
	ds_write_b16_d16_hi v50, v28 offset:9216
	ds_write_b16_d16_hi v50, v29 offset:9728
	v_pk_mul_f32 v[28:29], v[4:5], v[64:65] op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[2:3], v[64:65] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31]
	v_pk_mul_f32 v[28:29], v[28:29], v[44:45]
	v_pk_mul_f32 v[26:27], v[26:27], v[42:43]
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
	ds_write_b16_d16_hi v50, v26 offset:8224
	ds_write_b16_d16_hi v50, v27 offset:8736
	ds_write_b16_d16_hi v50, v28 offset:9248
	ds_write_b16_d16_hi v50, v29 offset:9760
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v26, v57, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v27, 0xffffff, v26
	v_cmp_gt_i32_e32 vcc, s33, v27
	s_and_saveexec_b64 s[14:15], vcc
	s_cbranch_execz .LBB0_7
	v_add_u32_e32 v28, v56, v53
	v_lshl_add_u32 v26, v26, 12, s19
	ds_read_b32 v29, v28
	v_or_b32_e32 v26, v26, v60
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
	ds_read_b32 v28, v28 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v28, off offset:384
.LBB0_7:
	s_or_b64 exec, exec, s[14:15]
	buffer_load_dword v26, v55, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v27, 0xffffff, v26
	v_cmp_gt_i32_e32 vcc, s33, v27
	s_and_saveexec_b64 s[14:15], vcc
	s_cbranch_execz .LBB0_4
	v_add_u32_e32 v28, v54, v53
	v_lshl_add_u32 v26, v26, 12, s19
	ds_read_b32 v29, v28
	v_or_b32_e32 v26, v26, v60
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
	ds_read_b32 v28, v28 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[26:27], v28, off offset:384
	s_branch .LBB0_4
.LBB0_9:
	v_sub_u32_sdwa v1, v58, v63 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v26, 11, v1
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v26, v26, s2
	v_sub_u32_e32 v27, 0x6c686080, v26
	v_and_b32_e32 v27, 0xffffff00, v27
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v26, 0x7c787470, v26
	v_lshlrev_b32_e32 v29, 4, v22
	v_cndmask_b32_e64 v1, v27, 0, vcc
	v_cndmask_b32_e64 v34, v26, 0, vcc
	v_add_u32_e32 v26, 0x7f7f7f00, v1
	v_and_b32_e32 v35, 0x80808000, v26
	v_add_u32_e32 v26, 0x7f7f7f78, v34
	v_and_b32_e32 v36, 0x80808080, v26
	v_and_b32_e32 v26, 0x7070707, v22
	v_lshrrev_b32_e32 v27, 4, v22
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v36, v35, v26
	v_perm_b32 v26, v34, v1, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v36, v35, v27
	v_perm_b32 v27, v34, v1, v27
	v_and_or_b32 v22, v28, v22, v27
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_sub_u32_sdwa v37, v58, v63 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v30, v22, v26, s0
	v_perm_b32 v31, v22, v26, s1
	v_min_i32_e32 v22, 11, v37
	v_mul_lo_u32 v38, v22, s2
	v_and_b32_e32 v22, 0x7070707, v23
	v_lshrrev_b32_e32 v39, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[30:31], 0
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v40, v36, v35, v22
	v_lshlrev_b32_e32 v41, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[102:103], v[30:31], 0
	v_perm_b32 v22, v34, v1, v22
	v_and_or_b32 v40, v40, v41, v22
	v_perm_b32 v22, v36, v35, v39
	v_perm_b32 v39, v34, v1, v39
	v_and_or_b32 v23, v22, v23, v39
	v_perm_b32 v22, v23, v40, s0
	v_perm_b32 v23, v23, v40, s1
	v_lshlrev_b32_e32 v41, 4, v24
	v_sub_u32_e32 v39, 0x6c686080, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[94:95], v[22:23], v[26:29]
	v_and_b32_e32 v39, 0xffffff00, v39
	v_sub_u32_e32 v38, 0x7c787470, v38
	v_cmp_lt_i32_e32 vcc, 11, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[100:101], v[22:23], v[30:33]
	v_and_b32_e32 v22, 0x7070707, v24
	v_lshrrev_b32_e32 v23, 4, v24
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v40, v36, v35, v22
	v_perm_b32 v22, v34, v1, v22
	v_and_or_b32 v40, v40, v41, v22
	v_perm_b32 v22, v36, v35, v23
	v_perm_b32 v23, v34, v1, v23
	v_and_or_b32 v23, v22, v24, v23
	v_perm_b32 v22, v23, v40, s0
	v_perm_b32 v23, v23, v40, s1
	v_lshlrev_b32_e32 v40, 4, v25
	v_cndmask_b32_e64 v37, v39, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[90:91], v[22:23], v[26:29]
	v_cndmask_b32_e64 v38, v38, 0, vcc
	v_add_u32_e32 v39, 0x7f7f7f00, v37
	s_add_i32 s3, s16, 0xe01
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[96:97], v[22:23], v[30:33]
	v_and_b32_e32 v22, 0x7070707, v25
	v_lshrrev_b32_e32 v23, 4, v25
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v36, v35, v22
	v_perm_b32 v22, v34, v1, v22
	v_and_or_b32 v22, v24, v40, v22
	v_perm_b32 v24, v36, v35, v23
	v_perm_b32 v1, v34, v1, v23
	v_and_or_b32 v1, v24, v25, v1
	v_perm_b32 v34, v1, v22, s0
	v_perm_b32 v35, v1, v22, s1
	v_and_b32_e32 v1, 0x80808000, v39
	s_lshr_b32 s4, s3, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[86:87], v[34:35], v[26:29]
	s_add_i32 s4, s3, s4
	s_and_b32 s4, s4, 0x1ffffffe
	s_sub_i32 s3, s3, s4
	v_add_u32_e32 v26, 0x7f7f7f78, v38
	v_and_b32_e32 v36, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[92:93], v[34:35], v[30:33]
	s_lshl_b32 s3, s3, 3
	v_lshrrev_b32_e32 v39, 4, v15
	v_and_b32_e32 v39, 0x7070707, v39
	v_and_b32_e32 v30, 0x7070707, v18
	v_lshrrev_b32_e32 v31, 4, v18
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v36, v1, v30
	v_lshlrev_b32_e32 v33, 4, v18
	v_perm_b32 v30, v38, v37, v30
	v_and_or_b32 v32, v32, v33, v30
	v_perm_b32 v30, v36, v1, v31
	v_perm_b32 v31, v38, v37, v31
	v_and_or_b32 v18, v30, v18, v31
	v_perm_b32 v30, v18, v32, s0
	v_perm_b32 v31, v18, v32, s1
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshlrev_b32_e32 v32, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[82:83], v[30:31], v[22:25]
	v_lshlrev_b32_e32 v41, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[88:89], v[30:31], v[26:29]
	v_lshrrev_b32_e32 v30, 4, v19
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v36, v1, v18
	v_perm_b32 v18, v38, v37, v18
	v_and_or_b32 v31, v31, v32, v18
	v_perm_b32 v18, v36, v1, v30
	v_perm_b32 v30, v38, v37, v30
	v_and_or_b32 v19, v18, v19, v30
	v_perm_b32 v18, v19, v31, s0
	v_perm_b32 v19, v19, v31, s1
	v_lshlrev_b32_e32 v31, 4, v20
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[78:79], v[18:19], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[84:85], v[18:19], v[26:29]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v30, v36, v1, v18
	v_perm_b32 v18, v38, v37, v18
	v_and_or_b32 v30, v30, v31, v18
	v_perm_b32 v18, v36, v1, v19
	v_perm_b32 v19, v38, v37, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v30, s0
	v_perm_b32 v19, v19, v30, s1
	v_lshlrev_b32_e32 v30, 4, v21
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[74:75], v[18:19], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[80:81], v[18:19], v[26:29]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v36, v1, v18
	v_perm_b32 v18, v38, v37, v18
	v_and_or_b32 v20, v20, v30, v18
	v_perm_b32 v1, v36, v1, v19
	v_perm_b32 v18, v38, v37, v19
	v_and_or_b32 v1, v1, v21, v18
	v_perm_b32 v18, v1, v20, s0
	v_perm_b32 v19, v1, v20, s1
	v_bfe_u32 v1, v59, s3, 8
	v_sub_u32_e32 v1, v0, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[68:69], v[18:19], v[22:25]
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_add_i32 s3, s3, 16
	v_bfe_u32 v32, v59, s3, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[76:77], v[18:19], v[26:29]
	v_sub_u32_e32 v37, v0, v32
	s_nop 1
	v_min_i32_e32 v26, 11, v1
	v_mul_lo_u32 v26, v26, s2
	v_sub_u32_e32 v27, 0x6c686080, v26
	v_and_b32_e32 v27, 0xffffff00, v27
	v_sub_u32_e32 v26, 0x7c787470, v26
	v_cndmask_b32_e64 v1, v27, 0, vcc
	v_cndmask_b32_e64 v34, v26, 0, vcc
	v_add_u32_e32 v26, 0x7f7f7f00, v1
	v_and_b32_e32 v35, 0x80808000, v26
	v_add_u32_e32 v26, 0x7f7f7f78, v34
	v_and_b32_e32 v36, 0x80808080, v26
	v_and_b32_e32 v26, 0x7070707, v14
	v_lshrrev_b32_e32 v27, 4, v14
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v36, v35, v26
	v_lshlrev_b32_e32 v29, 4, v14
	v_perm_b32 v26, v34, v1, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v36, v35, v27
	v_perm_b32 v27, v34, v1, v27
	v_and_or_b32 v14, v28, v14, v27
	v_perm_b32 v30, v14, v26, s0
	v_perm_b32 v31, v14, v26, s1
	v_min_i32_e32 v14, 11, v37
	v_mul_lo_u32 v38, v14, s2
	v_and_b32_e32 v14, 0x7070707, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[30:31], 0
	v_perm_b32 v40, v36, v35, v14
	v_perm_b32 v14, v34, v1, v14
	v_and_or_b32 v40, v40, v41, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[102:103], v[30:31], 0
	v_perm_b32 v14, v36, v35, v39
	v_perm_b32 v39, v34, v1, v39
	v_and_or_b32 v15, v14, v15, v39
	v_perm_b32 v14, v15, v40, s0
	v_perm_b32 v15, v15, v40, s1
	v_lshlrev_b32_e32 v41, 4, v16
	v_sub_u32_e32 v39, 0x6c686080, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[94:95], v[14:15], v[26:29]
	v_and_b32_e32 v39, 0xffffff00, v39
	v_sub_u32_e32 v38, 0x7c787470, v38
	v_cmp_lt_i32_e32 vcc, 11, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[100:101], v[14:15], v[30:33]
	v_and_b32_e32 v14, 0x7070707, v16
	v_lshrrev_b32_e32 v15, 4, v16
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v40, v36, v35, v14
	v_perm_b32 v14, v34, v1, v14
	v_and_or_b32 v40, v40, v41, v14
	v_perm_b32 v14, v36, v35, v15
	v_perm_b32 v15, v34, v1, v15
	v_and_or_b32 v15, v14, v16, v15
	v_perm_b32 v14, v15, v40, s0
	v_perm_b32 v15, v15, v40, s1
	v_lshlrev_b32_e32 v40, 4, v17
	v_cndmask_b32_e64 v37, v39, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[90:91], v[14:15], v[26:29]
	v_cndmask_b32_e64 v38, v38, 0, vcc
	v_add_u32_e32 v39, 0x7f7f7f00, v37
	v_cmp_lt_i32_e32 vcc, 5, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[96:97], v[14:15], v[30:33]
	v_and_b32_e32 v14, 0x7070707, v17
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v36, v35, v14
	v_perm_b32 v14, v34, v1, v14
	v_and_or_b32 v14, v16, v40, v14
	v_perm_b32 v16, v36, v35, v15
	v_perm_b32 v1, v34, v1, v15
	v_and_or_b32 v1, v16, v17, v1
	v_perm_b32 v34, v1, v14, s0
	v_perm_b32 v35, v1, v14, s1
	v_and_b32_e32 v1, 0x80808000, v39
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[86:87], v[34:35], v[26:29]
	s_nop 2
	v_add_u32_e32 v26, 0x7f7f7f78, v38
	v_and_b32_e32 v36, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[92:93], v[34:35], v[30:33]
	s_nop 2
	v_and_b32_e32 v30, 0x7070707, v10
	v_lshrrev_b32_e32 v31, 4, v10
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v36, v1, v30
	v_lshlrev_b32_e32 v33, 4, v10
	v_perm_b32 v30, v38, v37, v30
	v_and_or_b32 v32, v32, v33, v30
	v_perm_b32 v30, v36, v1, v31
	v_perm_b32 v31, v38, v37, v31
	v_and_or_b32 v10, v30, v10, v31
	v_perm_b32 v30, v10, v32, s0
	v_perm_b32 v31, v10, v32, s1
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshlrev_b32_e32 v32, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[82:83], v[30:31], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[88:89], v[30:31], v[26:29]
	v_lshrrev_b32_e32 v30, 4, v11
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v36, v1, v10
	v_perm_b32 v10, v38, v37, v10
	v_and_or_b32 v31, v31, v32, v10
	v_perm_b32 v10, v36, v1, v30
	v_perm_b32 v30, v38, v37, v30
	v_and_or_b32 v11, v10, v11, v30
	v_perm_b32 v10, v11, v31, s0
	v_perm_b32 v11, v11, v31, s1
	v_lshlrev_b32_e32 v31, 4, v12
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[78:79], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[84:85], v[10:11], v[26:29]
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v30, v36, v1, v10
	v_perm_b32 v10, v38, v37, v10
	v_and_or_b32 v30, v30, v31, v10
	v_perm_b32 v10, v36, v1, v11
	v_perm_b32 v11, v38, v37, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v30, s0
	v_perm_b32 v11, v11, v30, s1
	v_lshlrev_b32_e32 v30, 4, v13
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[74:75], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[80:81], v[10:11], v[26:29]
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v10, 0x7070707, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v36, v1, v10
	v_perm_b32 v10, v38, v37, v10
	v_perm_b32 v1, v36, v1, v11
	v_perm_b32 v11, v38, v37, v11
	v_and_or_b32 v10, v12, v30, v10
	v_and_or_b32 v1, v1, v13, v11
	v_perm_b32 v30, v1, v10, s0
	v_perm_b32 v31, v1, v10, s1
	v_mov_b32_e32 v1, 0xfd800000
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[68:69], v[30:31], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[76:77], v[30:31], v[26:29]
	s_nop 2
	v_add_u32_e32 v27, 17, v58
	v_lshl_add_u32 v26, v58, 23, v1
	v_lshlrev_b32_e64 v27, v27, 1
	v_cndmask_b32_e32 v26, v27, v26, vcc
	v_add_u32_e32 v27, 17, v0
	v_lshlrev_b32_e64 v27, v27, 1
	v_pk_mul_f32 v[30:31], v[8:9], v[26:27] op_sel_hi:[1,0]
	v_lshl_add_u32 v1, v0, 23, v1
	v_pk_mul_f32 v[24:25], v[30:31], v[24:25]
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[24:25], v[24:25], v[48:49]
	v_pk_mul_f32 v[28:29], v[6:7], v[26:27] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v0, v27, v1, vcc
	v_bfe_u32 v1, v25, 16, 1
	v_pk_mul_f32 v[22:23], v[28:29], v[22:23]
	v_add3_u32 v1, v1, v25, s0
	v_or_b32_e32 v27, 0x400000, v25
	v_cmp_u_f32_e32 vcc, v25, v25
	v_bfe_u32 v25, v24, 16, 1
	v_pk_mul_f32 v[22:23], v[22:23], v[46:47]
	v_cndmask_b32_e32 v1, v1, v27, vcc
	v_add3_u32 v25, v25, v24, s0
	v_or_b32_e32 v27, 0x400000, v24
	v_cmp_u_f32_e32 vcc, v24, v24
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v24, v25, v27, vcc
	v_bfe_u32 v25, v23, 16, 1
	v_add3_u32 v25, v25, v23, s0
	v_or_b32_e32 v27, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	v_pk_mul_f32 v[8:9], v[8:9], v[12:13]
	v_pk_mul_f32 v[6:7], v[6:7], v[10:11]
	v_cndmask_b32_e32 v23, v25, v27, vcc
	v_bfe_u32 v25, v22, 16, 1
	v_add3_u32 v25, v25, v22, s0
	v_or_b32_e32 v27, 0x400000, v22
	v_cmp_u_f32_e32 vcc, v22, v22
	v_pk_mul_f32 v[8:9], v[8:9], v[48:49]
	v_pk_mul_f32 v[6:7], v[6:7], v[46:47]
	v_cndmask_b32_e32 v22, v25, v27, vcc
	ds_write_b16_d16_hi v51, v22
	ds_write_b16_d16_hi v50, v23 offset:512
	ds_write_b16_d16_hi v50, v24 offset:1024
	ds_write_b16_d16_hi v50, v1 offset:1536
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v10, vcc
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
	ds_write_b16_d16_hi v50, v6 offset:32
	ds_write_b16_d16_hi v50, v7 offset:544
	ds_write_b16_d16_hi v50, v8 offset:1056
	ds_write_b16_d16_hi v50, v1 offset:1568
	v_pk_mul_f32 v[8:9], v[4:5], v[26:27] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[26:27] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_pk_mul_f32 v[8:9], v[8:9], v[44:45]
	v_pk_mul_f32 v[6:7], v[6:7], v[42:43]
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
	v_pk_mul_f32 v[2:3], v[2:3], v[42:43]
	s_nop 0
	v_cndmask_b32_e32 v6, v9, v10, vcc
	ds_write_b16_d16_hi v50, v6 offset:8192
	ds_write_b16_d16_hi v50, v7 offset:8704
	ds_write_b16_d16_hi v50, v8 offset:9216
	ds_write_b16_d16_hi v50, v1 offset:9728
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[16:17]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[44:45]
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
	ds_write_b16_d16_hi v50, v2 offset:8224
	ds_write_b16_d16_hi v50, v3 offset:8736
	ds_write_b16_d16_hi v50, v0 offset:9248
	ds_write_b16_d16_hi v50, v1 offset:9760
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v57, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_11
	v_add_u32_e32 v2, v56, v53
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v53
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[12:13], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3584
	ds_read_b32 v3, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3712
	ds_read_b32 v3, v2 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_11:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v55, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_13
	v_add_u32_e32 v2, v54, v53
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v53
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[12:13], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3584
	ds_read_b32 v3, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3712
	ds_read_b32 v3, v2 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_13:
	s_or_b64 exec, exec, s[0:1]
	s_barrier
.LBB0_14:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r
		.amdhsa_group_segment_fixed_size 24704
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.num_vgpr, 126
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.numbered_sgpr, 52
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.has_indirect_call, 0
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
    .group_segment_fixed_size: 24704
    .kernarg_segment_align: 8
    .kernarg_segment_size: 108
    .max_flat_workgroup_size: 512
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 512
      - 1
      - 1
    .sgpr_count:     58
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk128_tn256_bcm12_xcd1_ftz_a2r.kd
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
