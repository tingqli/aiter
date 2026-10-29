	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss
	.p2align	8
	.type	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss,@function
a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss:
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
	v_bfe_u32 v124, v0, 4, 2
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
	v_or_b32_e32 v118, s0, v10
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
	v_add_u32_e32 v2, s1, v118
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
	global_load_dword v121, v[4:5], off
	global_load_dword v120, v[4:5], off offset:64
	global_load_dword v123, v[6:7], off
	global_load_dword v122, v[6:7], off offset:64
	s_load_dword s0, s[2:3], 0x80
	v_lshlrev_b32_e32 v5, 4, v0
	v_and_b32_e32 v4, 48, v0
	v_xor_b32_e32 v0, v5, v0
	v_and_b32_e32 v6, 0xf0, v5
	v_lshlrev_b32_e32 v1, 8, v1
	v_and_b32_e32 v90, 0xf0, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0xffffff
	s_mov_b32 s27, 0x27000
	s_mov_b32 s30, 0x1000000
	v_lshlrev_b32_e32 v79, 5, v124
	v_lshlrev_b32_e32 v91, 8, v10
	v_lshlrev_b32_e32 v78, 4, v10
	v_or_b32_e32 v119, 16, v118
	v_or3_b32 v125, s11, v4, v10
	v_or3_b32 v126, s15, v4, v10
	v_or3_b32 v127, s23, v4, v10
	v_or3_b32 v128, s24, v4, v10
	v_or3_b32 v129, s28, v4, v10
	v_or3_b32 v130, s31, v4, v10
	s_cmp_lt_i32 s0, s33
	v_add_u32_e32 v133, v1, v6
	s_waitcnt vmcnt(5)
	v_lshl_or_b32 v131, v3, 12, v90
	s_waitcnt vmcnt(4)
	v_lshl_or_b32 v132, v11, 12, v90
	s_cbranch_scc1 .LBB0_5
	v_or_b32_e32 v1, 8, v79
	v_or_b32_e32 v3, 16, v79
	v_or_b32_e32 v4, 24, v79
	v_or_b32_e32 v5, 0x80, v79
	v_or_b32_e32 v6, 0x88, v79
	v_or_b32_e32 v7, 0x90, v79
	v_or_b32_e32 v8, 0x98, v79
	s_lshl_b32 s7, s5, 3
	s_lshl_b32 s12, s9, 3
	v_xor_b32_e32 v0, v79, v78
	v_xor_b32_e32 v1, v1, v78
	v_xor_b32_e32 v3, v3, v78
	v_xor_b32_e32 v4, v4, v78
	v_xor_b32_e32 v5, v5, v78
	v_xor_b32_e32 v6, v6, v78
	v_xor_b32_e32 v7, v7, v78
	v_xor_b32_e32 v8, v8, v78
	v_mov_b32_e32 v38, 0
	s_add_i32 s11, s7, 16
	s_add_i32 s15, s12, 16
	s_mov_b32 s17, 0
	s_mov_b32 s23, 0x8080808
	s_mov_b32 s34, 0x5010400
	s_mov_b32 s35, 0x7030602
	v_add_u32_e32 v0, v91, v0
	v_add_u32_e32 v1, v91, v1
	v_add_u32_e32 v3, v91, v3
	v_add_u32_e32 v80, v91, v4
	v_add_u32_e32 v81, v91, v5
	v_add_u32_e32 v82, v91, v6
	v_add_u32_e32 v83, v91, v7
	v_add_u32_e32 v84, v91, v8
	s_mov_b32 s28, s10
	v_mov_b32_e32 v39, v38
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v38
	v_mov_b32_e32 v42, v38
	v_mov_b32_e32 v43, v38
	v_mov_b32_e32 v44, v38
	v_mov_b32_e32 v45, v38
	v_mov_b32_e32 v14, v38
	v_mov_b32_e32 v15, v38
	v_mov_b32_e32 v16, v38
	v_mov_b32_e32 v17, v38
	v_mov_b32_e32 v6, v38
	v_mov_b32_e32 v7, v38
	v_mov_b32_e32 v8, v38
	v_mov_b32_e32 v9, v38
	v_mov_b32_e32 v46, v38
	v_mov_b32_e32 v47, v38
	v_mov_b32_e32 v48, v38
	v_mov_b32_e32 v49, v38
	v_mov_b32_e32 v50, v38
	v_mov_b32_e32 v51, v38
	v_mov_b32_e32 v52, v38
	v_mov_b32_e32 v53, v38
	v_mov_b32_e32 v18, v38
	v_mov_b32_e32 v19, v38
	v_mov_b32_e32 v20, v38
	v_mov_b32_e32 v21, v38
	v_mov_b32_e32 v10, v38
	v_mov_b32_e32 v11, v38
	v_mov_b32_e32 v12, v38
	v_mov_b32_e32 v13, v38
.LBB0_3:
	s_lshl_b32 s0, s17, 8
	s_mov_b32 s24, s4
	s_lshl_b32 s1, s17, 6
	s_lshl_b32 s40, s17, 7
	v_add_u32_e32 v4, s0, v131
	s_mov_b32 s31, s27
	s_mov_b32 s36, s8
	s_mov_b32 s39, s27
	v_add_u32_e32 v5, s0, v132
	v_add_lshl_u32 v22, s1, v126, 2
	v_add_lshl_u32 v23, s1, v128, 2
	v_add_lshl_u32 v70, s40, v129, 4
	v_add_lshl_u32 v71, s40, v127, 4
	v_add_lshl_u32 v72, s40, v130, 4
	buffer_load_dwordx4 v[86:89], v4, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[92:95], v5, s[24:27], 0 offen nt
	buffer_load_dword v73, v22, s[28:31], 0 offen
	buffer_load_dword v74, v23, s[28:31], 0 offen
	buffer_load_dwordx4 v[66:69], v71, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[58:61], v70, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[54:57], v72, s[36:39], 0 offen sc0
	v_or_b32_e32 v24, s40, v125
	v_lshlrev_b32_e32 v4, 4, v24
	buffer_load_dwordx4 v[26:29], v70, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[30:33], v71, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[22:25], v72, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[62:65], v4, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[34:37], v4, s[36:39], 0 offen offset:1024 sc0
	s_add_i32 s17, s17, 1
	s_cmp_lg_u32 s17, 16
	s_waitcnt vmcnt(11)
	ds_write_b128 v133, v[86:89]
	s_waitcnt vmcnt(10)
	ds_write_b128 v133, v[92:95] offset:4096
	s_waitcnt vmcnt(9)
	v_sub_u32_sdwa v94, v121, v73 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_bfe_u32 v92, v73, s7, 8
	v_min_i32_e32 v105, 11, v94
	s_waitcnt vmcnt(8)
	v_bfe_u32 v93, v74, s12, 8
	v_sub_u32_sdwa v95, v123, v74 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_sub_u32_e32 v92, v120, v92
	v_mul_lo_u32 v105, v105, s23
	v_min_i32_e32 v106, 11, v95
	v_sub_u32_e32 v93, v122, v93
	v_min_i32_e32 v110, 11, v92
	v_sub_u32_e32 v112, 0x6c686080, v105
	v_mul_lo_u32 v106, v106, s23
	v_min_i32_e32 v111, 11, v93
	v_sub_u32_e32 v105, 0x7c787470, v105
	v_mul_lo_u32 v110, v110, s23
	v_and_b32_e32 v112, 0xffffff00, v112
	v_cmp_lt_i32_e64 s[0:1], 11, v94
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_bfe_u32 v87, v74, s15, 8
	v_sub_u32_sdwa v88, v123, v74 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	ds_read2st64_b64 v[74:77], v0 offset1:8
	v_sub_u32_e32 v113, 0x6c686080, v106
	v_mul_lo_u32 v111, v111, s23
	v_cmp_lt_i32_e32 vcc, 11, v95
	v_sub_u32_e32 v95, 0x6c686080, v110
	v_cndmask_b32_e64 v112, v112, 0, s[0:1]
	v_cndmask_b32_e64 v115, v105, 0, s[0:1]
	v_sub_u32_e32 v106, 0x7c787470, v106
	v_and_b32_e32 v113, 0xffffff00, v113
	v_sub_u32_e32 v114, 0x6c686080, v111
	v_and_b32_e32 v94, 0xffffff00, v95
	v_cmp_lt_i32_e64 s[0:1], 11, v93
	v_add_u32_e32 v93, 0x7f7f7f00, v112
	v_add_u32_e32 v95, 0x7f7f7f78, v115
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v107, 0x7070707, v62
	v_cndmask_b32_e64 v113, v113, 0, vcc
	v_cndmask_b32_e64 v116, v106, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v92
	v_and_b32_e32 v92, 0xffffff00, v114
	v_and_b32_e32 v114, 0x80808000, v93
	v_and_b32_e32 v117, 0x80808080, v95
	v_lshlrev_b32_e32 v109, 4, v62
	v_add_u32_e32 v105, 0x7f7f7f00, v113
	v_perm_b32 v106, v115, v112, v107
	v_perm_b32 v93, v117, v114, v107
	v_add_u32_e32 v95, 0x7f7f7f78, v116
	v_and_b32_e32 v96, 0x7070707, v66
	v_lshrrev_b32_e32 v97, 4, v66
	v_lshrrev_b32_e32 v108, 4, v62
	v_and_or_b32 v93, v93, v109, v106
	v_and_b32_e32 v109, 0x80808000, v105
	v_and_b32_e32 v134, 0x80808080, v95
	v_lshlrev_b32_e32 v98, 4, v66
	v_and_b32_e32 v97, 0x7070707, v97
	v_and_b32_e32 v108, 0x7070707, v108
	v_perm_b32 v106, v116, v113, v96
	v_perm_b32 v95, v134, v109, v96
	v_sub_u32_e32 v110, 0x7c787470, v110
	v_and_or_b32 v95, v95, v98, v106
	v_perm_b32 v96, v115, v112, v108
	v_perm_b32 v98, v116, v113, v97
	v_cndmask_b32_e64 v135, v94, 0, vcc
	v_cndmask_b32_e64 v136, v92, 0, s[0:1]
	v_perm_b32 v92, v117, v114, v108
	v_perm_b32 v94, v134, v109, v97
	v_sub_u32_e32 v111, 0x7c787470, v111
	v_cndmask_b32_e64 v110, v110, 0, vcc
	v_and_or_b32 v62, v92, v62, v96
	v_and_or_b32 v66, v94, v66, v98
	v_cndmask_b32_e64 v111, v111, 0, s[0:1]
	v_perm_b32 v92, v62, v93, s34
	v_perm_b32 v93, v62, v93, s35
	v_perm_b32 v94, v66, v95, s34
	v_perm_b32 v95, v66, v95, s35
	v_add_u32_e32 v62, 0x7f7f7f00, v135
	v_add_u32_e32 v66, 0x7f7f7f78, v110
	v_and_b32_e32 v99, 0x7070707, v58
	v_lshrrev_b32_e32 v100, 4, v58
	v_lshrrev_b32_e32 v103, 4, v54
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[74:75], v[92:93], v[38:41]
	v_and_b32_e32 v108, 0x80808000, v62
	v_and_b32_e32 v137, 0x80808080, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[76:77], v[92:93], v[14:17]
	v_add_u32_e32 v92, 0x7f7f7f00, v136
	v_lshlrev_b32_e32 v101, 4, v58
	v_and_b32_e32 v102, 0x7070707, v54
	v_and_b32_e32 v100, 0x7070707, v100
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v93, v110, v135, v99
	v_perm_b32 v62, v137, v108, v99
	v_and_b32_e32 v138, 0x80808000, v92
	v_and_b32_e32 v139, 0x80808080, v66
	v_bfe_u32 v86, v73, s11, 8
	v_sub_u32_sdwa v85, v121, v73 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	ds_read2st64_b64 v[70:73], v1 offset1:8
	v_lshlrev_b32_e32 v104, 4, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[74:75], v[94:95], v[46:49]
	v_and_or_b32 v62, v62, v101, v93
	v_perm_b32 v93, v110, v135, v100
	v_perm_b32 v66, v137, v108, v100
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[76:77], v[94:95], v[18:21]
	v_perm_b32 v94, v111, v136, v102
	v_perm_b32 v95, v111, v136, v103
	v_perm_b32 v92, v139, v138, v102
	v_perm_b32 v96, v139, v138, v103
	v_and_or_b32 v58, v66, v58, v93
	v_and_or_b32 v66, v92, v104, v94
	v_and_or_b32 v54, v96, v54, v95
	v_perm_b32 v92, v58, v62, s34
	v_perm_b32 v93, v58, v62, s35
	v_perm_b32 v94, v54, v66, s34
	v_perm_b32 v95, v54, v66, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[74:75], v[92:93], v[42:45]
	v_and_b32_e32 v4, 0x7070707, v67
	v_lshrrev_b32_e32 v62, 4, v59
	v_lshrrev_b32_e32 v89, 4, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[74:75], v[94:95], v[50:53]
	v_lshrrev_b32_e32 v74, 4, v55
	v_and_b32_e32 v75, 0x7070707, v63
	v_lshlrev_b32_e32 v5, 4, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[76:77], v[92:93], v[6:9]
	v_and_b32_e32 v89, 0x7070707, v89
	v_and_b32_e32 v58, 0x7070707, v59
	v_and_b32_e32 v92, 0x7070707, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[76:77], v[94:95], v[10:13]
	v_lshrrev_b32_e32 v76, 4, v63
	v_lshlrev_b32_e32 v77, 4, v63
	v_and_b32_e32 v95, 0x7070707, v74
	v_perm_b32 v74, v115, v112, v75
	v_perm_b32 v75, v117, v114, v75
	v_and_b32_e32 v94, 0x7070707, v62
	v_and_b32_e32 v62, 0x7070707, v76
	v_and_or_b32 v74, v75, v77, v74
	v_perm_b32 v75, v116, v113, v4
	v_perm_b32 v4, v134, v109, v4
	v_perm_b32 v76, v115, v112, v62
	v_and_or_b32 v96, v4, v5, v75
	v_perm_b32 v4, v117, v114, v62
	v_perm_b32 v77, v116, v113, v89
	v_perm_b32 v5, v134, v109, v89
	v_and_or_b32 v62, v4, v63, v76
	v_and_or_b32 v63, v5, v67, v77
	v_perm_b32 v4, v62, v74, s34
	v_perm_b32 v5, v62, v74, s35
	v_lshlrev_b32_e32 v66, 4, v59
	v_lshlrev_b32_e32 v93, 4, v55
	v_perm_b32 v97, v110, v135, v58
	v_perm_b32 v98, v110, v135, v94
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[70:71], v[4:5], v[38:41]
	v_perm_b32 v67, v139, v138, v95
	v_perm_b32 v62, v63, v96, s34
	v_perm_b32 v63, v63, v96, s35
	v_perm_b32 v38, v111, v136, v92
	v_perm_b32 v39, v111, v136, v95
	v_perm_b32 v40, v137, v108, v58
	v_perm_b32 v41, v137, v108, v94
	v_perm_b32 v58, v139, v138, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[72:73], v[4:5], v[14:17]
	v_and_or_b32 v5, v40, v66, v97
	v_and_or_b32 v40, v41, v59, v98
	v_and_or_b32 v41, v58, v93, v38
	v_and_or_b32 v39, v67, v55, v39
	v_perm_b32 v4, v40, v5, s34
	v_perm_b32 v5, v40, v5, s35
	v_perm_b32 v38, v39, v41, s34
	v_perm_b32 v39, v39, v41, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[70:71], v[4:5], v[42:45]
	ds_read2st64_b64 v[92:95], v3 offset1:8
	v_and_b32_e32 v54, 0x7070707, v68
	v_lshrrev_b32_e32 v55, 4, v68
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[72:73], v[4:5], v[6:9]
	v_lshlrev_b32_e32 v58, 4, v68
	v_and_b32_e32 v55, 0x7070707, v55
	v_lshlrev_b32_e32 v66, 4, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[72:73], v[38:39], v[10:13]
	v_and_b32_e32 v59, 0x7070707, v69
	v_lshlrev_b32_e32 v67, 4, v69
	v_lshrrev_b32_e32 v89, 4, v30
	v_and_b32_e32 v12, 0x7070707, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[70:71], v[62:63], v[46:49]
	v_lshlrev_b32_e32 v13, 4, v64
	v_cmp_lt_i32_e64 s[0:1], 11, v85
	v_cmp_lt_i32_e32 vcc, 11, v88
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[70:71], v[38:39], v[50:53]
	v_perm_b32 v70, v115, v112, v12
	v_perm_b32 v12, v117, v114, v12
	v_and_or_b32 v13, v12, v13, v70
	v_lshrrev_b32_e32 v12, 4, v64
	v_and_b32_e32 v12, 0x7070707, v12
	v_perm_b32 v70, v116, v113, v54
	v_perm_b32 v54, v134, v109, v54
	v_and_or_b32 v58, v54, v58, v70
	v_perm_b32 v54, v115, v112, v12
	v_perm_b32 v70, v116, v113, v55
	v_perm_b32 v12, v117, v114, v12
	v_perm_b32 v55, v134, v109, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[72:73], v[62:63], v[18:21]
	v_and_b32_e32 v63, 0x7070707, v60
	v_and_or_b32 v54, v12, v64, v54
	v_and_or_b32 v55, v55, v68, v70
	v_perm_b32 v12, v54, v13, s34
	v_perm_b32 v13, v54, v13, s35
	v_perm_b32 v54, v55, v58, s34
	v_perm_b32 v55, v55, v58, s35
	v_and_b32_e32 v58, 0x7070707, v56
	v_perm_b32 v64, v110, v135, v63
	v_perm_b32 v63, v137, v108, v63
	v_and_or_b32 v63, v63, v66, v64
	v_lshlrev_b32_e32 v64, 4, v56
	v_perm_b32 v66, v111, v136, v58
	v_perm_b32 v58, v139, v138, v58
	v_and_or_b32 v58, v58, v64, v66
	v_lshrrev_b32_e32 v64, 4, v60
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[92:93], v[12:13], v[74:77]
	ds_read2st64_b64 v[38:41], v80 offset1:8
	v_lshrrev_b32_e32 v62, 4, v69
	v_and_b32_e32 v140, 0x7070707, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[94:95], v[12:13], v[14:17]
	v_lshrrev_b32_e32 v12, 4, v56
	v_and_b32_e32 v13, 0x7070707, v64
	v_and_b32_e32 v12, 0x7070707, v12
	v_perm_b32 v14, v110, v135, v13
	v_perm_b32 v13, v137, v108, v13
	v_and_or_b32 v13, v13, v60, v14
	v_perm_b32 v14, v111, v136, v12
	v_perm_b32 v12, v139, v138, v12
	v_and_or_b32 v15, v12, v56, v14
	v_perm_b32 v12, v13, v63, s34
	v_perm_b32 v13, v13, v63, s35
	v_perm_b32 v14, v15, v58, s34
	v_perm_b32 v15, v15, v58, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[94:95], v[12:13], v[4:7]
	v_and_b32_e32 v16, 0x7070707, v62
	v_perm_b32 v56, v134, v109, v59
	v_perm_b32 v17, v116, v113, v16
	v_lshrrev_b32_e32 v4, 4, v61
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v5, v110, v135, v4
	v_perm_b32 v4, v137, v108, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[92:93], v[54:55], v[46:49]
	v_perm_b32 v16, v134, v109, v16
	v_and_b32_e32 v58, 0x7070707, v57
	v_and_or_b32 v60, v16, v69, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[92:93], v[12:13], v[42:45]
	v_and_b32_e32 v141, 0x7070707, v31
	v_lshrrev_b32_e32 v142, 4, v31
	v_lshlrev_b32_e32 v143, 4, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[92:93], v[14:15], v[50:53]
	v_and_or_b32 v92, v4, v61, v5
	v_lshrrev_b32_e32 v4, 4, v65
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v5, v115, v112, v4
	v_perm_b32 v4, v117, v114, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[94:95], v[54:55], v[18:21]
	v_and_or_b32 v55, v4, v65, v5
	v_and_b32_e32 v4, 0x7070707, v65
	v_and_b32_e32 v54, 0x7070707, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[94:95], v[14:15], v[8:11]
	v_lshlrev_b32_e32 v93, 4, v61
	v_perm_b32 v109, v110, v135, v54
	v_perm_b32 v108, v137, v108, v54
	v_lshlrev_b32_e32 v8, 4, v65
	v_perm_b32 v9, v115, v112, v4
	v_perm_b32 v10, v117, v114, v4
	v_perm_b32 v11, v116, v113, v59
	v_and_or_b32 v59, v10, v8, v9
	v_lshrrev_b32_e32 v8, 4, v57
	v_and_b32_e32 v8, 0x7070707, v8
	v_and_or_b32 v61, v56, v67, v11
	v_lshlrev_b32_e32 v65, 4, v57
	v_perm_b32 v9, v111, v136, v8
	v_perm_b32 v8, v139, v138, v8
	v_perm_b32 v110, v111, v136, v58
	v_perm_b32 v111, v139, v138, v58
	v_perm_b32 v58, v55, v59, s34
	v_perm_b32 v59, v55, v59, s35
	v_and_or_b32 v67, v8, v57, v9
	v_perm_b32 v68, v60, v61, s34
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[38:39], v[58:59], v[70:73]
	v_perm_b32 v69, v60, v61, s35
	v_and_or_b32 v65, v111, v65, v110
	v_lshrrev_b32_e32 v112, 4, v26
	v_and_or_b32 v70, v108, v93, v109
	v_lshrrev_b32_e32 v113, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[38:39], v[68:69], v[46:49]
	v_min_i32_e32 v72, 11, v85
	v_perm_b32 v71, v67, v65, s35
	ds_read2st64_b64 v[16:19], v81 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[40:41], v[68:69], v[96:99]
	v_perm_b32 v68, v92, v70, s34
	v_perm_b32 v69, v92, v70, s35
	v_perm_b32 v70, v67, v65, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[40:41], v[58:59], v[74:77]
	v_sub_u32_e32 v65, v120, v86
	v_and_b32_e32 v86, 0x7070707, v113
	v_sub_u32_e32 v67, v122, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[108:111], v[38:39], v[68:69], v[42:45]
	v_and_b32_e32 v77, 0x7070707, v112
	v_and_b32_e32 v76, 0x7070707, v89
	v_lshlrev_b32_e32 v21, 4, v30
	v_min_i32_e32 v42, 11, v88
	s_waitcnt vmcnt(0)
	v_lshrrev_b32_e32 v44, 4, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[112:115], v[38:39], v[70:71], v[50:53]
	v_mul_lo_u32 v38, v72, s23
	v_mul_lo_u32 v39, v42, s23
	v_and_b32_e32 v42, 0x7070707, v44
	v_sub_u32_e32 v44, 0x6c686080, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[40:41], v[68:69], v[100:103]
	v_sub_u32_e32 v38, 0x7c787470, v38
	v_sub_u32_e32 v50, 0x6c686080, v39
	v_and_b32_e32 v44, 0xffffff00, v44
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[40:41], v[70:71], v[104:107]
	v_min_i32_e32 v40, 11, v65
	v_min_i32_e32 v41, 11, v67
	v_sub_u32_e32 v39, 0x7c787470, v39
	v_mul_lo_u32 v40, v40, s23
	v_and_b32_e32 v50, 0xffffff00, v50
	v_cndmask_b32_e64 v89, v44, 0, s[0:1]
	v_cndmask_b32_e64 v93, v38, 0, s[0:1]
	v_mul_lo_u32 v41, v41, s23
	v_sub_u32_e32 v51, 0x6c686080, v40
	v_cndmask_b32_e64 v88, v50, 0, vcc
	v_cndmask_b32_e64 v92, v39, 0, vcc
	v_add_u32_e32 v44, 0x7f7f7f00, v89
	v_add_u32_e32 v50, 0x7f7f7f78, v93
	v_and_b32_e32 v43, 0x7070707, v34
	v_sub_u32_e32 v52, 0x6c686080, v41
	v_and_b32_e32 v38, 0xffffff00, v51
	v_cmp_lt_i32_e32 vcc, 11, v65
	v_cmp_lt_i32_e64 s[0:1], 11, v67
	v_add_u32_e32 v51, 0x7f7f7f00, v88
	v_and_b32_e32 v65, 0x80808000, v44
	v_and_b32_e32 v67, 0x80808080, v50
	v_add_u32_e32 v44, 0x7f7f7f78, v92
	v_lshlrev_b32_e32 v45, 4, v34
	v_and_b32_e32 v39, 0xffffff00, v52
	v_perm_b32 v52, v93, v89, v43
	v_perm_b32 v43, v67, v65, v43
	v_and_b32_e32 v68, 0x80808000, v51
	v_and_b32_e32 v69, 0x80808080, v44
	v_and_or_b32 v43, v43, v45, v52
	v_perm_b32 v45, v92, v88, v140
	v_perm_b32 v44, v69, v68, v140
	v_sub_u32_e32 v40, 0x7c787470, v40
	v_and_or_b32 v21, v44, v21, v45
	v_perm_b32 v44, v93, v89, v42
	v_perm_b32 v45, v92, v88, v76
	v_cndmask_b32_e64 v74, v38, 0, vcc
	v_cndmask_b32_e64 v72, v39, 0, s[0:1]
	v_perm_b32 v38, v67, v65, v42
	v_perm_b32 v39, v69, v68, v76
	v_cndmask_b32_e64 v75, v40, 0, vcc
	v_and_or_b32 v34, v38, v34, v44
	v_and_or_b32 v30, v39, v30, v45
	v_perm_b32 v38, v34, v43, s34
	v_perm_b32 v39, v34, v43, s35
	v_perm_b32 v50, v30, v21, s34
	v_perm_b32 v51, v30, v21, s35
	v_add_u32_e32 v21, 0x7f7f7f00, v74
	v_add_u32_e32 v34, 0x7f7f7f78, v75
	v_and_b32_e32 v95, 0x7070707, v26
	v_sub_u32_e32 v41, 0x7c787470, v41
	v_and_b32_e32 v30, 0x80808000, v21
	v_and_b32_e32 v34, 0x80808080, v34
	v_lshlrev_b32_e32 v116, 4, v26
	v_cndmask_b32_e64 v73, v41, 0, s[0:1]
	v_perm_b32 v53, v75, v74, v95
	v_perm_b32 v21, v34, v30, v95
	v_add_u32_e32 v52, 0x7f7f7f00, v72
	v_and_or_b32 v21, v21, v116, v53
	v_add_u32_e32 v53, 0x7f7f7f78, v73
	v_and_b32_e32 v117, 0x7070707, v22
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[16:17], v[38:39], v[54:57]
	v_and_b32_e32 v70, 0x80808000, v52
	v_and_b32_e32 v71, 0x80808080, v53
	v_lshlrev_b32_e32 v138, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[16:17], v[50:51], v[46:49]
	v_perm_b32 v54, v75, v74, v77
	v_perm_b32 v55, v73, v72, v86
	v_perm_b32 v52, v71, v70, v117
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[18:19], v[50:51], v[96:99]
	v_perm_b32 v51, v34, v30, v77
	v_perm_b32 v50, v73, v72, v117
	v_perm_b32 v56, v71, v70, v86
	v_and_or_b32 v26, v51, v26, v54
	ds_read2st64_b64 v[12:15], v82 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[18:19], v[38:39], v[58:61]
	v_and_or_b32 v54, v52, v138, v50
	v_and_b32_e32 v146, 0x7070707, v23
	v_and_b32_e32 v139, 0x7070707, v27
	v_perm_b32 v58, v26, v21, s34
	v_perm_b32 v59, v26, v21, s35
	v_and_or_b32 v21, v56, v22, v55
	v_perm_b32 v60, v21, v54, s34
	v_perm_b32 v61, v21, v54, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[16:17], v[58:59], v[108:111]
	v_perm_b32 v21, v69, v68, v141
	v_lshrrev_b32_e32 v144, 4, v27
	v_lshlrev_b32_e32 v148, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[16:17], v[60:61], v[112:115]
	v_and_b32_e32 v16, 0x7070707, v35
	v_lshlrev_b32_e32 v17, 4, v35
	ds_read2st64_b64 v[4:7], v83 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[18:19], v[58:59], v[100:103]
	v_lshlrev_b32_e32 v145, 4, v27
	v_lshrrev_b32_e32 v147, 4, v23
	v_lshrrev_b32_e32 v20, 4, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[18:19], v[60:61], v[104:107]
	v_perm_b32 v18, v93, v89, v16
	v_perm_b32 v16, v67, v65, v16
	v_and_or_b32 v16, v16, v17, v18
	v_lshrrev_b32_e32 v17, 4, v35
	v_and_b32_e32 v18, 0x7070707, v142
	v_and_b32_e32 v17, 0x7070707, v17
	v_perm_b32 v19, v92, v88, v141
	v_and_or_b32 v19, v21, v143, v19
	v_perm_b32 v21, v93, v89, v17
	v_perm_b32 v22, v92, v88, v18
	v_perm_b32 v17, v67, v65, v17
	v_perm_b32 v18, v69, v68, v18
	v_and_or_b32 v17, v17, v35, v21
	v_and_or_b32 v18, v18, v31, v22
	v_perm_b32 v21, v73, v72, v146
	v_perm_b32 v22, v71, v70, v146
	v_perm_b32 v100, v17, v16, s34
	v_perm_b32 v101, v17, v16, s35
	v_perm_b32 v16, v75, v74, v139
	v_perm_b32 v17, v34, v30, v139
	v_and_or_b32 v106, v22, v148, v21
	v_and_b32_e32 v21, 0x7070707, v144
	v_perm_b32 v102, v18, v19, s34
	v_perm_b32 v103, v18, v19, s35
	v_and_or_b32 v35, v17, v145, v16
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[12:13], v[100:101], v[134:137]
	v_and_b32_e32 v22, 0x7070707, v147
	v_and_b32_e32 v109, 0x7070707, v36
	v_lshrrev_b32_e32 v110, 4, v36
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[14:15], v[100:101], v[38:41]
	v_perm_b32 v100, v75, v74, v21
	v_perm_b32 v21, v34, v30, v21
	v_and_or_b32 v27, v21, v27, v100
	v_perm_b32 v21, v73, v72, v22
	v_perm_b32 v22, v71, v70, v22
	v_and_or_b32 v111, v22, v23, v21
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[12:13], v[102:103], v[42:45]
	v_and_b32_e32 v113, 0x7070707, v20
	v_perm_b32 v100, v27, v35, s34
	v_perm_b32 v101, v27, v35, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[14:15], v[102:103], v[46:49]
	v_perm_b32 v102, v111, v106, s34
	v_perm_b32 v103, v111, v106, s35
	v_lshrrev_b32_e32 v27, 4, v37
	v_lshrrev_b32_e32 v108, 4, v24
	v_lshrrev_b32_e32 v105, 4, v25
	v_lshlrev_b32_e32 v112, 4, v36
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[12:13], v[100:101], v[50:53]
	v_and_b32_e32 v66, 0x7070707, v32
	ds_read2st64_b64 v[8:11], v84 offset1:8
	v_and_b32_e32 v87, 0x7070707, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[14:15], v[100:101], v[96:99]
	v_and_b32_e32 v100, 0x7070707, v110
	v_and_b32_e32 v101, 0x7070707, v27
	v_perm_b32 v27, v93, v89, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[12:13], v[102:103], v[54:57]
	v_lshrrev_b32_e32 v104, 4, v29
	v_and_b32_e32 v31, 0x7070707, v25
	v_and_b32_e32 v97, 0x7070707, v108
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[14:15], v[102:103], v[58:61]
	v_and_b32_e32 v99, 0x7070707, v105
	v_lshlrev_b32_e32 v64, 4, v32
	v_lshrrev_b32_e32 v94, 4, v33
	v_perm_b32 v61, v67, v65, v109
	v_perm_b32 v58, v93, v89, v100
	v_and_or_b32 v27, v61, v112, v27
	v_perm_b32 v61, v67, v65, v100
	v_lshrrev_b32_e32 v95, 4, v28
	v_and_b32_e32 v98, 0x7070707, v104
	v_perm_b32 v59, v92, v88, v66
	v_perm_b32 v60, v92, v88, v113
	v_perm_b32 v104, v73, v72, v87
	v_perm_b32 v105, v73, v72, v97
	v_perm_b32 v109, v73, v72, v31
	v_perm_b32 v110, v73, v72, v99
	v_perm_b32 v66, v69, v68, v66
	v_perm_b32 v72, v69, v68, v113
	v_and_or_b32 v36, v61, v36, v58
	v_and_b32_e32 v63, 0x7070707, v33
	v_and_b32_e32 v76, 0x7070707, v28
	v_and_b32_e32 v35, 0x7070707, v37
	v_and_b32_e32 v94, 0x7070707, v94
	v_and_b32_e32 v95, 0x7070707, v95
	v_and_or_b32 v61, v66, v64, v59
	v_perm_b32 v58, v36, v27, s34
	v_perm_b32 v59, v36, v27, s35
	v_and_or_b32 v27, v72, v32, v60
	v_lshlrev_b32_e32 v26, 4, v28
	v_lshlrev_b32_e32 v86, 4, v24
	v_perm_b32 v102, v93, v89, v35
	v_perm_b32 v89, v93, v89, v101
	v_perm_b32 v93, v92, v88, v63
	v_perm_b32 v92, v92, v88, v94
	v_perm_b32 v88, v75, v74, v76
	v_perm_b32 v103, v75, v74, v95
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[4:5], v[58:59], v[16:19]
	v_perm_b32 v72, v27, v61, s34
	v_perm_b32 v73, v27, v61, s35
	v_perm_b32 v27, v34, v30, v76
	v_perm_b32 v32, v34, v30, v95
	v_perm_b32 v36, v71, v70, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[6:7], v[58:59], v[38:41]
	v_and_or_b32 v27, v27, v26, v88
	v_and_or_b32 v28, v32, v28, v103
	v_and_or_b32 v32, v36, v86, v104
	v_perm_b32 v38, v71, v70, v97
	v_and_or_b32 v24, v38, v24, v105
	v_and_b32_e32 v85, 0x7070707, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[4:5], v[72:73], v[42:45]
	v_perm_b32 v26, v28, v27, s34
	v_perm_b32 v27, v28, v27, s35
	v_perm_b32 v38, v24, v32, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[6:7], v[72:73], v[20:23]
	v_perm_b32 v39, v24, v32, s35
	v_lshlrev_b32_e32 v62, 4, v33
	v_lshlrev_b32_e32 v96, 4, v37
	v_perm_b32 v106, v75, v74, v85
	v_perm_b32 v108, v75, v74, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[4:5], v[26:27], v[46:49]
	v_perm_b32 v24, v69, v68, v63
	v_lshlrev_b32_e32 v77, 4, v29
	v_lshlrev_b32_e32 v107, 4, v25
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[4:5], v[38:39], v[54:57]
	v_perm_b32 v4, v67, v65, v35
	v_perm_b32 v5, v67, v65, v101
	v_and_or_b32 v5, v5, v37, v89
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[6:7], v[26:27], v[50:53]
	v_perm_b32 v26, v69, v68, v94
	v_and_or_b32 v27, v4, v96, v102
	v_perm_b32 v4, v5, v27, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[6:7], v[38:39], v[12:15]
	v_and_or_b32 v7, v24, v62, v93
	v_perm_b32 v5, v5, v27, s35
	v_perm_b32 v24, v71, v70, v31
	v_and_or_b32 v12, v26, v33, v92
	v_perm_b32 v6, v12, v7, s34
	v_perm_b32 v7, v12, v7, s35
	v_perm_b32 v12, v34, v30, v85
	v_perm_b32 v13, v34, v30, v98
	v_perm_b32 v26, v71, v70, v99
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[8:9], v[4:5], v[16:19]
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[8:9], v[6:7], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[10:11], v[4:5], v[58:61]
	v_and_or_b32 v5, v12, v77, v106
	v_and_or_b32 v12, v13, v29, v108
	v_perm_b32 v4, v12, v5, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[6:7], v[20:23]
	v_and_or_b32 v6, v24, v107, v109
	v_and_or_b32 v7, v26, v25, v110
	v_perm_b32 v5, v12, v5, s35
	v_perm_b32 v12, v7, v6, s34
	v_perm_b32 v13, v7, v6, s35
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[8:9], v[4:5], v[72:75]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[8:9], v[12:13], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[10:11], v[4:5], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[10:11], v[12:13], v[86:89]
	s_cbranch_scc1 .LBB0_3
	v_lshl_or_b32 v4, v124, 2, s16
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshl_add_u64 v[24:25], v[4:5], 2, s[18:19]
	global_load_dword v0, v[24:25], off
	s_mov_b32 s12, s6
	s_mov_b32 s15, s27
	v_mov_b32_e32 v27, 0xfd800000
	v_add_u32_e32 v1, 17, v121
	v_lshl_add_u32 v33, v123, 23, v27
	v_cmp_lt_i32_e32 vcc, 5, v123
	v_add_u32_e32 v22, 17, v122
	v_lshl_add_u32 v32, v121, 23, v27
	v_lshlrev_b32_e64 v34, v1, 1
	v_add_u32_e32 v23, 17, v120
	v_lshl_add_u32 v35, v120, 23, v27
	v_lshl_add_u32 v27, v122, 23, v27
	v_lshlrev_b32_e64 v22, v22, 1
	v_lshlrev_b32_e64 v36, v23, 1
	v_mov_b32_e32 v28, v38
	v_mov_b32_e32 v29, v46
	v_mov_b32_e32 v30, v42
	v_mov_b32_e32 v31, v50
	s_mov_b32 s0, 0xbfb8aa3b
	s_movk_i32 s1, 0x7fff
	v_bfrev_b32_e32 v3, -2
	s_mov_b32 s23, s27
	v_mov_b32_e32 v46, v39
	v_mov_b32_e32 v50, v43
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v0
	v_lshlrev_b32_e32 v0, 2, v5
	buffer_load_dword v26, v0, s[12:15], 0 offen
	v_add_u32_e32 v0, 17, v123
	v_lshlrev_b32_e64 v0, v0, 1
	v_cndmask_b32_e32 v1, v0, v33, vcc
	v_cmp_lt_i32_e32 vcc, 5, v121
	s_nop 1
	v_cndmask_b32_e32 v0, v34, v32, vcc
	v_cmp_lt_i32_e32 vcc, 5, v122
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[32:33], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v23, v22, v27, vcc
	v_cmp_lt_i32_e32 vcc, 5, v120
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	v_lshlrev_b32_e32 v32, 8, v4
	v_cndmask_b32_e32 v22, v36, v35, vcc
	v_pk_mul_f32 v[26:27], v[26:27], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v26
	v_pk_mul_f32 v[30:31], v[30:31], s[0:1] op_sel_hi:[1,0]
	v_add_lshl_u32 v34, v32, v118, 1
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_add_lshl_u32 v35, v32, v119, 1
	v_cmp_gt_i32_e32 vcc, s33, v5
	v_add_u32_e32 v33, 0x200, v35
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v5, v3, v34, vcc
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	v_cndmask_b32_e32 v32, v3, v35, vcc
	v_mul_f32_e32 v28, v28, v30
	v_mul_f32_e32 v26, v26, v31
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v30, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v31, 0x400000, v26
	v_add3_u32 v30, v30, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	s_nop 0
	v_cndmask_b32_e32 v26, v30, v31, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v5, s[20:23], 0 offen
	buffer_store_short v26, v32, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:4
	v_add_u32_e32 v32, 0x200, v34
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v5
	v_lshlrev_b32_e32 v26, 2, v5
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v5
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[46:47], v[28:29]
	v_pk_mul_f32 v[26:27], v[50:51], v[26:27]
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v26
	v_pk_mul_f32 v[30:31], v[30:31], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v5, v3, v32, vcc
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v32, v3, v33, vcc
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	v_mul_f32_e32 v28, v28, v30
	v_mul_f32_e32 v26, v26, v31
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v30, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v31, 0x400000, v26
	v_add3_u32 v30, v30, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	v_mov_b32_e32 v28, v40
	v_cndmask_b32_e32 v26, v30, v31, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v5, s[20:23], 0 offen
	buffer_store_short v26, v32, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:8
	v_mov_b32_e32 v29, v48
	v_mov_b32_e32 v30, v44
	v_mov_b32_e32 v31, v52
	v_mov_b32_e32 v48, v41
	v_mov_b32_e32 v52, v45
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v5
	v_lshlrev_b32_e32 v26, 2, v5
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v5
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[32:33], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v26
	v_pk_mul_f32 v[30:31], v[30:31], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v32, 0x400, v34
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_add_u32_e32 v33, 0x400, v35
	v_cndmask_b32_e32 v5, v3, v32, vcc
	v_cndmask_b32_e32 v32, v3, v33, vcc
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	v_add_u32_e32 v33, 0x600, v35
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	v_mul_f32_e32 v28, v28, v30
	v_mul_f32_e32 v26, v26, v31
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v30, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v31, 0x400000, v26
	v_add3_u32 v30, v30, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	s_nop 0
	v_cndmask_b32_e32 v26, v30, v31, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v5, s[20:23], 0 offen
	buffer_store_short v26, v32, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:12
	v_add_u32_e32 v32, 0x600, v34
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v5
	v_lshlrev_b32_e32 v26, 2, v5
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v5
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[48:49], v[28:29]
	v_pk_mul_f32 v[26:27], v[52:53], v[26:27]
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v26
	v_pk_mul_f32 v[30:31], v[30:31], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v5, v3, v32, vcc
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v32, v3, v33, vcc
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	v_mul_f32_e32 v28, v28, v30
	v_mul_f32_e32 v26, v26, v31
	v_mul_f32_e32 v28, v29, v28
	v_mul_f32_e32 v26, v27, v26
	v_bfe_u32 v27, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v30, v26, 16, 1
	v_add3_u32 v27, v27, v28, s1
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v31, 0x400000, v26
	v_add3_u32 v30, v30, v26, s1
	v_cndmask_b32_e32 v27, v27, v29, vcc
	v_cmp_u_f32_e32 vcc, v26, v26
	v_lshrrev_b32_e32 v27, 16, v27
	v_mov_b32_e32 v28, v14
	v_cndmask_b32_e32 v26, v30, v31, vcc
	v_lshrrev_b32_e32 v26, 16, v26
	buffer_store_short v27, v5, s[20:23], 0 offen
	buffer_store_short v26, v32, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:64
	v_mov_b32_e32 v29, v18
	v_mov_b32_e32 v30, v6
	v_mov_b32_e32 v31, v10
	v_add_u32_e32 v6, 0x2000, v34
	v_add_u32_e32 v10, 0x2000, v35
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v5
	v_lshlrev_b32_e32 v26, 2, v5
	buffer_load_dword v26, v26, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v5
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[32:33], v[26:27], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_mov_b32_e32 v30, v28
	v_mov_b32_e32 v31, v26
	v_pk_mul_f32 v[30:31], v[30:31], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v5, v3, v6, vcc
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v14, v30
	v_rcp_f32_e32 v18, v31
	v_mul_f32_e32 v10, v28, v14
	v_mul_f32_e32 v14, v26, v18
	v_mul_f32_e32 v10, v29, v10
	v_mul_f32_e32 v14, v27, v14
	v_bfe_u32 v18, v10, 16, 1
	v_or_b32_e32 v26, 0x400000, v10
	v_bfe_u32 v27, v14, 16, 1
	v_add3_u32 v18, v18, v10, s1
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v28, 0x400000, v14
	v_add3_u32 v27, v27, v14, s1
	v_cndmask_b32_e32 v10, v18, v26, vcc
	v_cmp_u_f32_e32 vcc, v14, v14
	v_lshrrev_b32_e32 v10, 16, v10
	v_mov_b32_e32 v18, v15
	v_cndmask_b32_e32 v14, v27, v28, vcc
	v_lshrrev_b32_e32 v14, 16, v14
	buffer_store_short v10, v5, s[20:23], 0 offen
	buffer_store_short v14, v6, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:68
	v_mov_b32_e32 v10, v7
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v5
	v_lshlrev_b32_e32 v6, 2, v5
	buffer_load_dword v6, v6, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v5
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[6:7], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_mov_b32_e32 v10, v14
	v_mov_b32_e32 v11, v6
	v_pk_mul_f32 v[10:11], v[10:11], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v18, 0x2200, v34
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_add_u32_e32 v19, 0x2200, v35
	v_cndmask_b32_e32 v5, v3, v18, vcc
	v_cndmask_b32_e32 v18, v3, v19, vcc
	v_pk_add_f32 v[10:11], v[10:11], 1.0 op_sel_hi:[1,0]
	s_nop 0
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
	buffer_store_short v7, v5, s[20:23], 0 offen
	buffer_store_short v6, v18, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:72
	v_mov_b32_e32 v11, v20
	v_mov_b32_e32 v14, v8
	v_mov_b32_e32 v15, v12
	v_add_u32_e32 v8, 0x2400, v34
	v_add_u32_e32 v12, 0x2400, v35
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v5, 0xffffff, v5
	v_lshlrev_b32_e32 v6, 2, v5
	buffer_load_dword v6, v6, s[12:15], 0 offen
	v_cmp_gt_i32_e32 vcc, s33, v5
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[18:19], v[6:7], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[18:19]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_mov_b32_e32 v14, v10
	v_mov_b32_e32 v15, v6
	v_pk_mul_f32 v[14:15], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v5, v3, v8, vcc
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v3, v3, v12, vcc
	v_pk_add_f32 v[14:15], v[14:15], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v14, v14
	v_rcp_f32_e32 v15, v15
	v_mul_f32_e32 v8, v10, v14
	v_mul_f32_e32 v6, v6, v15
	v_mul_f32_e32 v8, v11, v8
	v_mul_f32_e32 v6, v7, v6
	v_bfe_u32 v7, v8, 16, 1
	v_or_b32_e32 v10, 0x400000, v8
	v_bfe_u32 v11, v6, 16, 1
	v_add3_u32 v7, v7, v8, s1
	v_cmp_u_f32_e32 vcc, v8, v8
	v_or_b32_e32 v12, 0x400000, v6
	v_add3_u32 v11, v11, v6, s1
	v_cndmask_b32_e32 v7, v7, v10, vcc
	v_cmp_u_f32_e32 vcc, v6, v6
	v_lshrrev_b32_e32 v7, 16, v7
	s_nop 0
	v_cndmask_b32_e32 v6, v11, v12, vcc
	v_lshrrev_b32_e32 v6, 16, v6
	buffer_store_short v7, v5, s[20:23], 0 offen
	buffer_store_short v6, v3, s[20:23], 0 offen
	global_load_dword v5, v[24:25], off offset:76
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
	v_or_b32_e32 v1, 8, v79
	v_or_b32_e32 v2, 16, v79
	v_or_b32_e32 v4, 24, v79
	v_or_b32_e32 v5, 0x80, v79
	v_or_b32_e32 v6, 0x88, v79
	v_or_b32_e32 v7, 0x90, v79
	v_or_b32_e32 v8, 0x98, v79
	s_lshl_b32 s7, s5, 3
	s_lshl_b32 s12, s9, 3
	v_xor_b32_e32 v0, v79, v78
	v_xor_b32_e32 v1, v1, v78
	v_xor_b32_e32 v12, v2, v78
	v_xor_b32_e32 v13, v4, v78
	v_xor_b32_e32 v18, v5, v78
	v_xor_b32_e32 v19, v6, v78
	v_xor_b32_e32 v20, v7, v78
	v_xor_b32_e32 v21, v8, v78
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
	v_add_u32_e32 v134, v91, v0
	v_mov_b32_e32 v2, v3
	v_mov_b32_e32 v4, v3
	v_mov_b32_e32 v5, v3
	v_mov_b32_e32 v82, v3
	v_mov_b32_e32 v83, v3
	v_mov_b32_e32 v84, v3
	v_mov_b32_e32 v85, v3
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
	v_mov_b32_e32 v30, v3
	v_mov_b32_e32 v31, v3
	v_mov_b32_e32 v32, v3
	v_mov_b32_e32 v33, v3
	v_mov_b32_e32 v14, v3
	v_mov_b32_e32 v15, v3
	v_mov_b32_e32 v16, v3
	v_mov_b32_e32 v17, v3
	v_mov_b32_e32 v6, v3
	v_mov_b32_e32 v7, v3
	v_mov_b32_e32 v8, v3
	v_mov_b32_e32 v9, v3
	v_mov_b32_e32 v78, v3
	v_mov_b32_e32 v79, v3
	v_mov_b32_e32 v80, v3
	v_mov_b32_e32 v81, v3
	v_mov_b32_e32 v86, v3
	v_mov_b32_e32 v87, v3
	v_mov_b32_e32 v88, v3
	v_mov_b32_e32 v89, v3
	v_mov_b32_e32 v62, v3
	v_add_u32_e32 v135, v91, v1
	v_add_u32_e32 v136, v91, v12
	v_add_u32_e32 v137, v91, v13
	v_add_u32_e32 v138, v91, v18
	v_add_u32_e32 v139, v91, v19
	v_add_u32_e32 v140, v91, v20
	v_add_u32_e32 v141, v91, v21
	v_mov_b32_e32 v63, v3
	s_waitcnt vmcnt(1)
	v_lshl_or_b32 v142, v10, 12, v90
	s_waitcnt vmcnt(0)
	v_lshl_or_b32 v143, v11, 12, v90
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
	v_mov_b32_e32 v34, v3
	v_mov_b32_e32 v35, v3
	v_mov_b32_e32 v36, v3
	v_mov_b32_e32 v37, v3
	v_mov_b32_e32 v18, v3
	v_mov_b32_e32 v19, v3
	v_mov_b32_e32 v20, v3
	v_mov_b32_e32 v21, v3
	v_mov_b32_e32 v10, v3
	v_mov_b32_e32 v11, v3
	v_mov_b32_e32 v12, v3
	v_mov_b32_e32 v13, v3
.LBB0_7:
	s_lshl_b32 s0, s15, 8
	s_lshl_b32 s1, s15, 6
	s_lshl_b32 s2, s15, 7
	v_add_u32_e32 v0, s0, v131
	v_add_u32_e32 v1, s0, v132
	v_add_u32_e32 v22, s0, v142
	v_add_u32_e32 v23, s0, v143
	v_add_lshl_u32 v24, s1, v126, 2
	v_add_lshl_u32 v25, s1, v128, 2
	v_add_lshl_u32 v27, s2, v129, 4
	v_add_lshl_u32 v38, s2, v127, 4
	v_add_lshl_u32 v42, s2, v130, 4
	buffer_load_dwordx4 v[98:101], v0, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[102:105], v1, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[106:109], v22, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[110:113], v23, s[24:27], 0 offen nt
	buffer_load_dword v144, v24, s[28:31], 0 offen
	buffer_load_dword v145, v25, s[28:31], 0 offen
	buffer_load_dwordx4 v[94:97], v38, s[8:11], 0 offen sc0
	buffer_load_dwordx4 v[90:93], v27, s[8:11], 0 offen sc0
	buffer_load_dwordx4 v[74:77], v42, s[8:11], 0 offen sc0
	v_or_b32_e32 v26, s2, v125
	v_lshlrev_b32_e32 v0, 4, v26
	buffer_load_dwordx4 v[26:29], v27, s[8:11], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[38:41], v38, s[8:11], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[22:25], v42, s[8:11], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[70:73], v0, s[8:11], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[42:45], v0, s[8:11], 0 offen offset:1024 sc0
	s_add_i32 s15, s15, 1
	s_cmp_lg_u32 s15, 16
	s_waitcnt vmcnt(13)
	ds_write_b128 v133, v[98:101]
	s_waitcnt vmcnt(12)
	ds_write_b128 v133, v[102:105] offset:4096
	s_waitcnt vmcnt(11)
	ds_write_b128 v133, v[106:109] offset:8192
	s_waitcnt vmcnt(10)
	ds_write_b128 v133, v[110:113] offset:12288
	s_waitcnt vmcnt(9)
	v_sub_u32_sdwa v106, v121, v144 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_bfe_u32 v0, v144, s7, 8
	s_waitcnt vmcnt(8)
	v_sub_u32_sdwa v107, v123, v145 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v112, 11, v106
	v_bfe_u32 v1, v145, s12, 8
	s_waitcnt vmcnt(6)
	v_lshrrev_b32_e32 v110, 4, v90
	v_min_i32_e32 v113, 11, v107
	v_sub_u32_e32 v0, v120, v0
	v_cmp_lt_i32_e64 s[0:1], 11, v106
	v_mul_lo_u32 v106, v112, s17
	s_waitcnt vmcnt(5)
	v_lshrrev_b32_e32 v111, 4, v74
	v_sub_u32_e32 v1, v122, v1
	v_and_b32_e32 v163, 0x7070707, v110
	v_cmp_lt_i32_e32 vcc, 11, v107
	v_mul_lo_u32 v107, v113, s17
	v_min_i32_e32 v110, 11, v0
	v_cmp_lt_i32_e64 s[2:3], 11, v0
	v_sub_u32_e32 v0, 0x6c686080, v106
	v_and_b32_e32 v164, 0x7070707, v111
	v_min_i32_e32 v111, 11, v1
	v_cmp_lt_i32_e64 s[4:5], 11, v1
	v_sub_u32_e32 v1, 0x7c787470, v106
	v_sub_u32_e32 v106, 0x6c686080, v107
	v_mul_lo_u32 v110, v110, s17
	v_and_b32_e32 v0, 0xffffff00, v0
	v_mul_lo_u32 v111, v111, s17
	v_and_b32_e32 v106, 0xffffff00, v106
	v_sub_u32_e32 v112, 0x6c686080, v110
	v_sub_u32_e32 v110, 0x7c787470, v110
	v_cndmask_b32_e64 v149, v1, 0, s[0:1]
	v_cndmask_b32_e64 v152, v0, 0, s[0:1]
	v_lshrrev_b32_e32 v109, 4, v94
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v115, 4, v70
	v_sub_u32_e32 v107, 0x7c787470, v107
	v_sub_u32_e32 v113, 0x6c686080, v111
	v_cndmask_b32_e64 v153, v106, 0, vcc
	v_add_u32_e32 v106, 0x7f7f7f78, v149
	v_cndmask_b32_e64 v148, v110, 0, s[2:3]
	v_add_u32_e32 v110, 0x7f7f7f00, v152
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[102:105], v134 offset1:8
	ds_read2st64_b64 v[98:101], v134 offset0:16 offset1:24
	v_and_b32_e32 v114, 0x7070707, v70
	v_and_b32_e32 v159, 0x7070707, v109
	v_and_b32_e32 v109, 0x7070707, v115
	v_sub_u32_e32 v111, 0x7c787470, v111
	v_cndmask_b32_e64 v150, v107, 0, vcc
	v_and_b32_e32 v0, 0xffffff00, v112
	v_and_b32_e32 v1, 0xffffff00, v113
	v_and_b32_e32 v155, 0x80808080, v106
	v_and_b32_e32 v157, 0x80808000, v110
	v_lshlrev_b32_e32 v156, 4, v70
	v_add_u32_e32 v107, 0x7f7f7f78, v150
	v_cndmask_b32_e64 v146, v111, 0, s[4:5]
	v_add_u32_e32 v111, 0x7f7f7f00, v153
	v_perm_b32 v112, v149, v152, v114
	v_perm_b32 v113, v149, v152, v109
	v_cndmask_b32_e64 v151, v0, 0, s[2:3]
	v_cndmask_b32_e64 v147, v1, 0, s[4:5]
	v_perm_b32 v0, v155, v157, v114
	v_perm_b32 v1, v155, v157, v109
	v_and_b32_e32 v108, 0x7070707, v94
	v_and_b32_e32 v154, 0x80808080, v107
	v_and_or_b32 v0, v0, v156, v112
	v_and_or_b32 v1, v1, v70, v113
	v_and_b32_e32 v158, 0x80808000, v111
	v_lshlrev_b32_e32 v116, 4, v94
	v_perm_b32 v165, v150, v153, v108
	v_perm_b32 v114, v1, v0, s23
	v_perm_b32 v115, v1, v0, s34
	v_perm_b32 v0, v154, v158, v108
	v_perm_b32 v166, v150, v153, v159
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[102:103], v[114:115], v[2:5]
	v_add_u32_e32 v156, 0x7f7f7f78, v148
	v_add_u32_e32 v70, 0x7f7f7f78, v146
	v_add_u32_e32 v167, 0x7f7f7f00, v151
	v_and_or_b32 v5, v0, v116, v165
	v_perm_b32 v0, v154, v158, v159
	v_add_u32_e32 v116, 0x7f7f7f00, v147
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[104:105], v[114:115], v[54:57]
	v_and_b32_e32 v117, 0x7070707, v90
	v_and_b32_e32 v161, 0x7070707, v74
	v_and_b32_e32 v70, 0x80808080, v70
	v_and_or_b32 v54, v0, v94, v166
	v_perm_b32 v4, v54, v5, s23
	v_perm_b32 v5, v54, v5, s34
	v_and_b32_e32 v94, 0x80808080, v156
	v_and_b32_e32 v159, 0x80808000, v167
	v_and_b32_e32 v156, 0x80808000, v116
	v_lshlrev_b32_e32 v160, 4, v90
	v_lshlrev_b32_e32 v162, 4, v74
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[98:99], v[114:115], v[46:49]
	v_perm_b32 v54, v148, v151, v117
	v_perm_b32 v55, v148, v151, v163
	v_perm_b32 v56, v146, v147, v161
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[100:101], v[114:115], v[14:17]
	v_perm_b32 v114, v146, v147, v164
	v_perm_b32 v57, v94, v159, v117
	v_and_or_b32 v54, v57, v160, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[104:105], v[4:5], v[62:65]
	v_and_b32_e32 v170, 0x7070707, v77
	v_lshlrev_b32_e32 v172, 4, v77
	v_bfe_u32 v168, v144, s35, 8
	v_perm_b32 v62, v94, v159, v163
	v_perm_b32 v63, v70, v156, v161
	v_perm_b32 v64, v70, v156, v164
	v_and_or_b32 v55, v62, v90, v55
	v_and_or_b32 v62, v63, v162, v56
	v_and_or_b32 v63, v64, v74, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[102:103], v[4:5], v[78:81]
	v_perm_b32 v160, v63, v62, s23
	v_perm_b32 v161, v63, v62, s34
	v_and_b32_e32 v74, 0x7070707, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[98:99], v[4:5], v[50:53]
	v_lshrrev_b32_e32 v169, 4, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[100:101], v[4:5], v[18:21]
	v_perm_b32 v4, v55, v54, s23
	v_perm_b32 v5, v55, v54, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[102:103], v[160:161], v[86:89]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[102:103], v[4:5], v[82:85]
	s_nop 0
	v_perm_b32 v87, v150, v153, v74
	v_perm_b32 v74, v154, v158, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[104:105], v[4:5], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[104:105], v[160:161], v[66:69]
	ds_read2st64_b64 v[102:105], v135 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[100:101], v[4:5], v[6:9]
	s_nop 2
	ds_read2st64_b64 v[6:9], v135 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[98:99], v[4:5], v[30:33]
	v_lshrrev_b32_e32 v5, 4, v71
	v_and_b32_e32 v4, 0x7070707, v71
	v_and_b32_e32 v5, 0x7070707, v5
	v_lshrrev_b32_e32 v30, 4, v95
	v_and_b32_e32 v30, 0x7070707, v30
	v_lshlrev_b32_e32 v31, 4, v95
	v_lshlrev_b32_e32 v32, 4, v71
	v_perm_b32 v33, v149, v152, v4
	v_perm_b32 v86, v149, v152, v5
	v_perm_b32 v88, v150, v153, v30
	v_perm_b32 v4, v155, v157, v4
	v_perm_b32 v5, v155, v157, v5
	v_perm_b32 v30, v154, v158, v30
	v_and_or_b32 v32, v4, v32, v33
	v_and_or_b32 v5, v5, v71, v86
	v_and_or_b32 v31, v74, v31, v87
	v_and_or_b32 v30, v30, v95, v88
	v_perm_b32 v4, v5, v32, s23
	v_perm_b32 v5, v5, v32, s34
	v_perm_b32 v86, v30, v31, s23
	v_perm_b32 v87, v30, v31, s34
	v_lshrrev_b32_e32 v74, 4, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[98:99], v[160:161], v[34:37]
	v_and_b32_e32 v71, 0x7070707, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[100:101], v[160:161], v[10:13]
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[102:103], v[86:87], v[78:81]
	s_nop 2
	v_lshrrev_b32_e32 v80, 4, v75
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[160:163], v[6:7], v[4:5], v[0:3]
	v_lshlrev_b32_e32 v78, 4, v91
	v_and_b32_e32 v79, 0x7070707, v75
	v_lshlrev_b32_e32 v81, 4, v75
	v_and_b32_e32 v0, 0x7070707, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[102:103], v[4:5], v[110:113]
	v_and_b32_e32 v74, 0x7070707, v80
	v_perm_b32 v80, v148, v151, v71
	v_perm_b32 v90, v146, v147, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[104:105], v[4:5], v[106:109]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[8:9], v[4:5], v[14:17]
	v_perm_b32 v4, v148, v151, v0
	v_perm_b32 v5, v146, v147, v79
	v_mfma_f32_16x16x32_fp8_fp8 v[164:167], v[104:105], v[86:87], v[46:49]
	s_nop 2
	v_perm_b32 v46, v94, v159, v71
	v_perm_b32 v47, v94, v159, v0
	v_perm_b32 v48, v70, v156, v79
	v_perm_b32 v49, v70, v156, v74
	v_and_or_b32 v46, v46, v78, v80
	v_and_or_b32 v4, v47, v91, v4
	v_and_or_b32 v5, v48, v81, v5
	v_perm_b32 v78, v4, v46, s23
	v_perm_b32 v79, v4, v46, s34
	v_and_or_b32 v4, v49, v75, v90
	v_perm_b32 v74, v4, v5, s23
	v_perm_b32 v75, v4, v5, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[6:7], v[86:87], v[50:53]
	v_and_b32_e32 v71, 0x7070707, v96
	v_lshrrev_b32_e32 v80, 4, v96
	v_lshlrev_b32_e32 v81, 4, v96
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[8:9], v[86:87], v[18:21]
	v_and_b32_e32 v90, 0x7070707, v76
	v_lshlrev_b32_e32 v91, 4, v76
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[102:103], v[78:79], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[104:105], v[78:79], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[104:105], v[74:75], v[66:69]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[8:9], v[78:79], v[114:117]
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[8:9], v[74:75], v[10:13]
	s_nop 2
	v_and_b32_e32 v12, 0x7070707, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[74:75], v[62:65]
	v_lshlrev_b32_e32 v13, 4, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[6:7], v[74:75], v[34:37]
	v_perm_b32 v74, v149, v152, v12
	v_perm_b32 v12, v155, v157, v12
	v_and_or_b32 v13, v12, v13, v74
	v_lshrrev_b32_e32 v12, 4, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[6:7], v[78:79], v[82:85]
	ds_read2st64_b64 v[34:37], v136 offset1:8
	ds_read2st64_b64 v[4:7], v136 offset0:16 offset1:24
	v_and_b32_e32 v74, 0x7070707, v80
	v_and_b32_e32 v12, 0x7070707, v12
	v_perm_b32 v75, v150, v153, v71
	v_perm_b32 v71, v154, v158, v71
	v_and_or_b32 v71, v71, v81, v75
	v_perm_b32 v75, v149, v152, v12
	v_perm_b32 v78, v150, v153, v74
	v_perm_b32 v12, v155, v157, v12
	v_perm_b32 v74, v154, v158, v74
	v_and_or_b32 v72, v12, v72, v75
	v_and_or_b32 v75, v74, v96, v78
	v_and_b32_e32 v82, 0x7070707, v92
	v_lshrrev_b32_e32 v83, 4, v92
	v_perm_b32 v74, v75, v71, s23
	v_perm_b32 v75, v75, v71, s34
	v_lshlrev_b32_e32 v84, 4, v92
	v_perm_b32 v12, v72, v13, s23
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[34:35], v[74:75], v[30:33]
	v_perm_b32 v13, v72, v13, s34
	v_perm_b32 v71, v146, v147, v90
	v_perm_b32 v72, v70, v156, v90
	v_and_b32_e32 v30, 0x7070707, v83
	v_perm_b32 v32, v148, v151, v82
	v_perm_b32 v33, v94, v159, v82
	v_and_or_b32 v32, v33, v84, v32
	v_perm_b32 v33, v148, v151, v30
	v_perm_b32 v30, v94, v159, v30
	v_and_or_b32 v30, v30, v92, v33
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[6:7], v[12:13], v[14:17]
	v_perm_b32 v90, v30, v32, s23
	v_lshrrev_b32_e32 v85, 4, v76
	v_and_b32_e32 v31, 0x7070707, v85
	v_and_or_b32 v16, v72, v91, v71
	v_perm_b32 v91, v30, v32, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[34:35], v[12:13], v[98:101]
	v_perm_b32 v33, v146, v147, v31
	v_perm_b32 v31, v70, v156, v31
	v_and_or_b32 v17, v31, v76, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[36:37], v[12:13], v[110:113]
	v_and_b32_e32 v71, 0x7070707, v97
	v_and_b32_e32 v92, 0x7070707, v93
	v_lshlrev_b32_e32 v72, 4, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[4:5], v[12:13], v[160:163]
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[34:35], v[90:91], v[18:21]
	s_nop 1
	v_perm_b32 v160, v17, v16, s23
	v_perm_b32 v161, v17, v16, s34
	v_sub_u32_sdwa v163, v121, v144 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshrrev_b32_e32 v20, 4, v97
	v_and_b32_e32 v20, 0x7070707, v20
	v_perm_b32 v21, v150, v153, v20
	v_perm_b32 v20, v154, v158, v20
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[36:37], v[74:75], v[164:167]
	v_bfe_u32 v162, v145, s36, 8
	v_cmp_lt_i32_e64 s[2:3], 11, v163
	v_and_b32_e32 v144, 0x7070707, v40
	v_and_or_b32 v165, v20, v97, v21
	v_lshrrev_b32_e32 v21, 4, v93
	v_and_b32_e32 v21, 0x7070707, v21
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[34:35], v[160:161], v[50:53]
	v_sub_u32_sdwa v164, v123, v145 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshlrev_b32_e32 v167, 4, v93
	v_cmp_lt_i32_e64 s[4:5], 11, v164
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[36:37], v[90:91], v[54:57]
	v_and_b32_e32 v20, 0x7070707, v38
	v_lshlrev_b32_e32 v145, 4, v39
	s_nop 0
	v_perm_b32 v54, v148, v151, v21
	v_perm_b32 v21, v94, v159, v21
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[36:37], v[160:161], v[58:61]
	ds_read2st64_b64 v[34:37], v137 offset1:8
	v_and_or_b32 v166, v21, v93, v54
	v_perm_b32 v151, v148, v151, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[4:5], v[90:91], v[46:49]
	v_lshlrev_b32_e32 v21, 4, v38
	s_nop 1
	v_lshrrev_b32_e32 v46, 4, v77
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[4:5], v[74:75], v[0:3]
	v_and_b32_e32 v46, 0x7070707, v46
	s_nop 1
	ds_read2st64_b64 v[0:3], v137 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[6:7], v[90:91], v[66:69]
	s_nop 2
	v_perm_b32 v66, v146, v147, v46
	v_perm_b32 v67, v70, v156, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[4:5], v[160:161], v[62:65]
	v_lshrrev_b32_e32 v4, 4, v73
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v5, v149, v152, v4
	v_perm_b32 v4, v155, v157, v4
	v_and_or_b32 v90, v4, v73, v5
	v_and_b32_e32 v4, 0x7070707, v73
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[6:7], v[74:75], v[86:89]
	v_and_or_b32 v171, v67, v77, v66
	v_lshlrev_b32_e32 v5, 4, v73
	v_perm_b32 v73, v150, v153, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[6:7], v[160:161], v[8:11]
	v_perm_b32 v6, v149, v152, v4
	v_perm_b32 v4, v155, v157, v4
	v_and_or_b32 v91, v4, v5, v6
	v_perm_b32 v71, v154, v158, v71
	v_perm_b32 v148, v90, v91, s23
	v_perm_b32 v149, v90, v91, s34
	v_and_or_b32 v150, v71, v72, v73
	v_perm_b32 v154, v94, v159, v92
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[34:35], v[148:149], v[106:109]
	ds_read2st64_b64 v[66:69], v138 offset1:8
	v_lshrrev_b32_e32 v153, 4, v26
	ds_read2st64_b64 v[62:65], v138 offset0:16 offset1:24
	v_min_i32_e32 v109, 11, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[36:37], v[148:149], v[110:113]
	v_perm_b32 v106, v165, v150, s23
	v_perm_b32 v107, v165, v150, s34
	v_mul_lo_u32 v150, v109, s17
	v_perm_b32 v110, v70, v156, v170
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[0:1], v[148:149], v[114:117]
	v_min_i32_e32 v112, 11, v164
	v_mul_lo_u32 v112, v112, s17
	v_and_or_b32 v109, v154, v167, v151
	v_sub_u32_e32 v115, v120, v168
	v_sub_u32_e32 v116, v122, v162
	v_cmp_lt_i32_e32 vcc, 11, v115
	v_min_i32_e32 v115, 11, v115
	v_sub_u32_e32 v151, 0x6c686080, v150
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[2:3], v[148:149], v[102:105]
	v_and_b32_e32 v148, 0x7070707, v153
	v_cmp_lt_i32_e64 s[0:1], 11, v116
	v_min_i32_e32 v116, 11, v116
	v_sub_u32_e32 v153, 0x6c686080, v112
	v_mul_lo_u32 v115, v115, s17
	v_sub_u32_e32 v150, 0x7c787470, v150
	v_and_b32_e32 v151, 0xffffff00, v151
	v_perm_b32 v146, v146, v147, v170
	v_mul_lo_u32 v116, v116, s17
	v_sub_u32_e32 v112, 0x7c787470, v112
	v_and_b32_e32 v153, 0xffffff00, v153
	v_sub_u32_e32 v154, 0x6c686080, v115
	v_cndmask_b32_e64 v150, v150, 0, s[2:3]
	v_cndmask_b32_e64 v151, v151, 0, s[2:3]
	v_lshrrev_b32_e32 v108, 4, v22
	s_waitcnt vmcnt(0)
	v_lshrrev_b32_e32 v114, 4, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[34:35], v[106:107], v[78:81]
	v_sub_u32_e32 v156, 0x6c686080, v116
	v_cndmask_b32_e64 v112, v112, 0, s[4:5]
	v_cndmask_b32_e64 v153, v153, 0, s[4:5]
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[36:37], v[106:107], v[82:85]
	v_add_u32_e32 v158, 0x7f7f7f00, v151
	v_and_b32_e32 v113, 0x7070707, v42
	v_and_b32_e32 v149, 0x7070707, v108
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[0:1], v[106:107], v[98:101]
	v_and_b32_e32 v114, 0x7070707, v114
	v_perm_b32 v108, v166, v109, s23
	v_perm_b32 v109, v166, v109, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[2:3], v[106:107], v[86:89]
	v_and_or_b32 v107, v110, v172, v146
	v_and_b32_e32 v110, 0xffffff00, v154
	v_add_u32_e32 v154, 0x7f7f7f78, v150
	v_perm_b32 v106, v171, v107, s23
	v_perm_b32 v107, v171, v107, s34
	v_and_b32_e32 v146, 0xffffff00, v156
	v_add_u32_e32 v156, 0x7f7f7f78, v112
	v_add_u32_e32 v159, 0x7f7f7f00, v153
	v_and_b32_e32 v154, 0x80808080, v154
	v_and_b32_e32 v158, 0x80808000, v158
	v_lshlrev_b32_e32 v117, 4, v42
	v_and_b32_e32 v147, 0x7070707, v169
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[34:35], v[108:109], v[12:15]
	v_perm_b32 v162, v150, v151, v113
	v_perm_b32 v163, v150, v151, v114
	v_and_b32_e32 v156, 0x80808080, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[34:35], v[106:107], v[16:19]
	v_and_b32_e32 v159, 0x80808000, v159
	v_sub_u32_e32 v115, 0x7c787470, v115
	v_sub_u32_e32 v116, 0x7c787470, v116
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[36:37], v[108:109], v[50:53]
	v_cndmask_b32_e64 v115, v115, 0, vcc
	v_cndmask_b32_e64 v110, v110, 0, vcc
	ds_read2st64_b64 v[8:11], v139 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[36:37], v[106:107], v[30:33]
	v_cndmask_b32_e64 v116, v116, 0, s[0:1]
	v_cndmask_b32_e64 v146, v146, 0, s[0:1]
	v_and_b32_e32 v152, 0x7070707, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[0:1], v[108:109], v[54:57]
	ds_read2st64_b64 v[4:7], v139 offset0:16 offset1:24
	v_lshlrev_b32_e32 v155, 4, v26
	v_and_b32_e32 v157, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[2:3], v[108:109], v[58:61]
	v_perm_b32 v108, v112, v153, v147
	v_perm_b32 v109, v156, v159, v147
	v_and_or_b32 v38, v109, v38, v108
	v_perm_b32 v59, v154, v158, v113
	v_perm_b32 v60, v154, v158, v114
	v_perm_b32 v58, v112, v153, v20
	v_perm_b32 v20, v156, v159, v20
	v_and_or_b32 v59, v59, v117, v162
	v_and_or_b32 v42, v60, v42, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[0:1], v[106:107], v[46:49]
	v_perm_b32 v108, v115, v110, v152
	v_perm_b32 v109, v115, v110, v148
	v_lshlrev_b32_e32 v111, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[2:3], v[106:107], v[74:77]
	v_perm_b32 v113, v116, v146, v157
	v_perm_b32 v114, v116, v146, v149
	v_lshrrev_b32_e32 v161, 4, v39
	v_and_or_b32 v74, v20, v21, v58
	v_perm_b32 v20, v42, v59, s23
	v_perm_b32 v21, v42, v59, s34
	v_perm_b32 v106, v38, v74, s23
	v_perm_b32 v107, v38, v74, s34
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[66:67], v[20:21], v[94:97]
	v_add_u32_e32 v38, 0x7f7f7f78, v115
	v_add_u32_e32 v42, 0x7f7f7f78, v116
	v_and_b32_e32 v117, 0x80808080, v38
	v_add_u32_e32 v94, 0x7f7f7f00, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[66:67], v[106:107], v[78:81]
	v_and_b32_e32 v162, 0x80808000, v94
	v_and_b32_e32 v147, 0x80808080, v42
	v_perm_b32 v38, v117, v162, v152
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[68:69], v[20:21], v[90:93]
	v_perm_b32 v42, v117, v162, v148
	v_and_or_b32 v26, v42, v26, v109
	v_and_b32_e32 v160, 0x7070707, v39
	v_add_u32_e32 v90, 0x7f7f7f00, v146
	v_and_b32_e32 v163, 0x80808000, v90
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[62:63], v[20:21], v[70:73]
	v_lshrrev_b32_e32 v42, 4, v40
	v_and_b32_e32 v42, 0x7070707, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[62:63], v[106:107], v[98:101]
	s_nop 2
	v_perm_b32 v98, v147, v163, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[64:65], v[20:21], v[102:105]
	v_perm_b32 v99, v147, v163, v149
	v_and_or_b32 v21, v38, v155, v108
	v_and_or_b32 v38, v98, v111, v113
	v_perm_b32 v20, v26, v21, s23
	v_perm_b32 v21, v26, v21, s34
	v_and_or_b32 v22, v99, v22, v114
	v_lshrrev_b32_e32 v26, 4, v43
	v_perm_b32 v102, v22, v38, s23
	v_perm_b32 v103, v22, v38, s34
	v_and_b32_e32 v22, 0x7070707, v43
	v_and_b32_e32 v26, 0x7070707, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[68:69], v[106:107], v[82:85]
	v_lshlrev_b32_e32 v38, 4, v43
	ds_read2st64_b64 v[98:101], v140 offset1:8
	v_lshlrev_b32_e32 v104, 4, v40
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[66:67], v[20:21], v[12:15]
	v_lshrrev_b32_e32 v111, 4, v41
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[66:67], v[102:103], v[16:19]
	v_and_b32_e32 v66, 0x7070707, v161
	v_perm_b32 v67, v150, v151, v22
	v_perm_b32 v22, v154, v158, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[68:69], v[20:21], v[50:53]
	v_perm_b32 v105, v112, v153, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[68:69], v[102:103], v[30:33]
	v_perm_b32 v68, v150, v151, v26
	v_perm_b32 v26, v154, v158, v26
	v_perm_b32 v69, v112, v153, v160
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[62:63], v[20:21], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[62:63], v[102:103], v[46:49]
	v_perm_b32 v62, v156, v159, v160
	v_perm_b32 v63, v156, v159, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[64:65], v[20:21], v[54:57]
	v_and_or_b32 v21, v22, v38, v67
	v_and_or_b32 v22, v26, v43, v68
	v_and_or_b32 v26, v62, v145, v69
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[64:65], v[106:107], v[86:89]
	v_perm_b32 v20, v22, v21, s23
	v_perm_b32 v21, v22, v21, s34
	v_and_or_b32 v22, v63, v39, v105
	v_perm_b32 v38, v22, v26, s23
	v_perm_b32 v39, v22, v26, s34
	v_lshrrev_b32_e32 v26, 4, v27
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[10:11], v[20:21], v[78:81]
	v_and_b32_e32 v22, 0x7070707, v27
	v_and_b32_e32 v26, 0x7070707, v26
	v_lshlrev_b32_e32 v43, 4, v27
	v_lshrrev_b32_e32 v78, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[64:65], v[102:103], v[0:3]
	v_and_b32_e32 v102, 0x7070707, v23
	v_and_b32_e32 v105, 0x7070707, v78
	v_lshlrev_b32_e32 v103, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[8:9], v[20:21], v[58:61]
	v_perm_b32 v106, v115, v110, v22
	v_perm_b32 v107, v115, v110, v26
	v_perm_b32 v108, v116, v146, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[8:9], v[38:39], v[74:77]
	v_perm_b32 v109, v116, v146, v105
	v_perm_b32 v22, v117, v162, v22
	v_perm_b32 v26, v117, v162, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[10:11], v[38:39], v[82:85]
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[4:5], v[20:21], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[4:5], v[38:39], v[90:93]
	s_nop 2
	v_perm_b32 v90, v147, v163, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[6:7], v[20:21], v[94:97]
	v_perm_b32 v20, v147, v163, v105
	v_and_or_b32 v21, v22, v43, v106
	v_and_or_b32 v22, v26, v27, v107
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[6:7], v[38:39], v[86:89]
	v_and_or_b32 v39, v90, v103, v108
	v_and_or_b32 v20, v20, v23, v109
	v_perm_b32 v26, v22, v21, s23
	v_perm_b32 v27, v22, v21, s34
	v_perm_b32 v38, v20, v39, s23
	v_perm_b32 v39, v20, v39, s34
	ds_read2st64_b64 v[20:23], v140 offset0:16 offset1:24
	v_lshrrev_b32_e32 v91, 4, v44
	v_and_b32_e32 v90, 0x7070707, v44
	v_and_b32_e32 v91, 0x7070707, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[8:9], v[26:27], v[12:15]
	v_lshlrev_b32_e32 v92, 4, v44
	v_perm_b32 v93, v150, v151, v90
	v_perm_b32 v94, v150, v151, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[8:9], v[38:39], v[16:19]
	v_perm_b32 v95, v112, v153, v144
	v_perm_b32 v96, v112, v153, v42
	v_perm_b32 v42, v156, v159, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[10:11], v[26:27], v[50:53]
	v_and_or_b32 v40, v42, v40, v96
	v_lshrrev_b32_e32 v42, 4, v28
	v_and_b32_e32 v42, 0x7070707, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[10:11], v[38:39], v[30:33]
	v_and_b32_e32 v43, 0x7070707, v41
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[4:5], v[26:27], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[4:5], v[38:39], v[46:49]
	v_perm_b32 v4, v154, v158, v90
	v_perm_b32 v5, v154, v158, v91
	v_perm_b32 v90, v156, v159, v144
	v_and_or_b32 v4, v4, v92, v93
	v_and_or_b32 v5, v5, v44, v94
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[6:7], v[38:39], v[0:3]
	v_and_or_b32 v39, v90, v104, v95
	v_perm_b32 v38, v40, v39, s23
	v_perm_b32 v39, v40, v39, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[6:7], v[26:27], v[54:57]
	v_perm_b32 v26, v5, v4, s23
	v_perm_b32 v27, v5, v4, s34
	v_and_b32_e32 v40, 0x7070707, v28
	v_lshlrev_b32_e32 v44, 4, v28
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[98:99], v[26:27], v[58:61]
	v_perm_b32 v93, v115, v110, v40
	v_perm_b32 v94, v115, v110, v42
	v_perm_b32 v40, v117, v162, v40
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[100:101], v[26:27], v[66:69]
	v_perm_b32 v42, v117, v162, v42
	v_and_b32_e32 v90, 0x7070707, v24
	v_and_or_b32 v28, v42, v28, v94
	v_lshrrev_b32_e32 v66, 4, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[98:99], v[38:39], v[62:65]
	v_and_b32_e32 v92, 0x7070707, v66
	v_lshlrev_b32_e32 v91, 4, v24
	v_perm_b32 v95, v116, v146, v90
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[100:101], v[38:39], v[74:77]
	v_perm_b32 v96, v116, v146, v92
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[20:21], v[26:27], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[22:23], v[26:27], v[82:85]
	v_and_or_b32 v27, v40, v44, v93
	v_perm_b32 v26, v28, v27, s23
	v_perm_b32 v27, v28, v27, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[20:21], v[38:39], v[78:81]
	v_perm_b32 v28, v112, v153, v43
	s_nop 1
	v_perm_b32 v78, v147, v163, v90
	v_perm_b32 v79, v147, v163, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[22:23], v[38:39], v[86:89]
	v_and_or_b32 v38, v78, v91, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[98:99], v[26:27], v[12:15]
	s_nop 2
	v_and_or_b32 v13, v79, v24, v96
	v_perm_b32 v12, v13, v38, s23
	v_perm_b32 v13, v13, v38, s34
	ds_read2st64_b64 v[94:97], v141 offset1:8
	ds_read2st64_b64 v[102:105], v141 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[98:99], v[12:13], v[16:19]
	v_and_b32_e32 v15, 0x7070707, v45
	v_lshlrev_b32_e32 v14, 4, v41
	s_waitcnt lgkmcnt(0)
	v_lshrrev_b32_e32 v16, 4, v45
	v_and_b32_e32 v16, 0x7070707, v16
	v_lshlrev_b32_e32 v17, 4, v45
	v_perm_b32 v19, v150, v151, v15
	v_perm_b32 v24, v150, v151, v16
	v_perm_b32 v15, v154, v158, v15
	v_perm_b32 v16, v154, v158, v16
	v_and_b32_e32 v18, 0x7070707, v111
	v_and_or_b32 v15, v15, v17, v19
	v_and_or_b32 v16, v16, v45, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[20:21], v[26:27], v[30:33]
	v_perm_b32 v38, v112, v153, v18
	v_perm_b32 v18, v156, v159, v18
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[20:21], v[12:13], v[34:37]
	v_perm_b32 v20, v156, v159, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[22:23], v[12:13], v[0:3]
	s_nop 2
	v_perm_b32 v0, v16, v15, s23
	v_perm_b32 v1, v16, v15, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[100:101], v[12:13], v[8:11]
	v_and_or_b32 v12, v20, v14, v28
	v_lshrrev_b32_e32 v13, 4, v29
	v_lshrrev_b32_e32 v15, 4, v25
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[94:95], v[0:1], v[4:7]
	v_and_b32_e32 v14, 0x7070707, v25
	v_and_b32_e32 v13, 0x7070707, v13
	v_and_b32_e32 v19, 0x7070707, v15
	v_and_or_b32 v7, v18, v41, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[100:101], v[26:27], v[50:53]
	v_perm_b32 v6, v7, v12, s23
	v_perm_b32 v7, v7, v12, s34
	v_and_b32_e32 v12, 0x7070707, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[22:23], v[26:27], v[46:49]
	v_lshlrev_b32_e32 v18, 4, v29
	v_lshlrev_b32_e32 v22, 4, v25
	v_perm_b32 v20, v115, v110, v12
	v_perm_b32 v21, v115, v110, v13
	v_perm_b32 v23, v116, v146, v14
	v_perm_b32 v24, v116, v146, v19
	v_perm_b32 v12, v117, v162, v12
	v_perm_b32 v13, v117, v162, v13
	v_perm_b32 v26, v147, v163, v14
	v_perm_b32 v27, v147, v163, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[94:95], v[6:7], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[96:97], v[0:1], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[96:97], v[6:7], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[102:103], v[0:1], v[66:69]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[6:7], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[104:105], v[0:1], v[74:77]
	v_and_or_b32 v1, v12, v18, v20
	v_and_or_b32 v12, v13, v29, v21
	v_perm_b32 v0, v12, v1, s23
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[104:105], v[6:7], v[82:85]
	v_and_or_b32 v6, v26, v22, v23
	v_and_or_b32 v7, v27, v25, v24
	v_perm_b32 v1, v12, v1, s34
	v_perm_b32 v12, v7, v6, s23
	v_perm_b32 v13, v7, v6, s34
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[94:95], v[0:1], v[86:89]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[94:95], v[12:13], v[90:93]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[96:97], v[0:1], v[106:109]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[96:97], v[12:13], v[8:11]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[102:103], v[0:1], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[102:103], v[12:13], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[104:105], v[0:1], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[104:105], v[12:13], v[42:45]
	s_cbranch_scc1 .LBB0_7
	v_lshl_or_b32 v24, v124, 2, s16
	v_ashrrev_i32_e32 v25, 31, v24
	v_lshl_add_u64 v[26:27], v[24:25], 2, s[18:19]
	global_load_dword v0, v[26:27], off
	s_mov_b32 s12, s6
	s_mov_b32 s15, s27
	v_mov_b32_e32 v25, 0xfd800000
	v_add_u32_e32 v1, 17, v121
	v_lshl_add_u32 v42, v123, 23, v25
	v_cmp_lt_i32_e32 vcc, 5, v123
	v_add_u32_e32 v22, 17, v122
	v_lshl_add_u32 v29, v121, 23, v25
	v_lshlrev_b32_e64 v43, v1, 1
	v_add_u32_e32 v23, 17, v120
	v_lshl_add_u32 v45, v120, 23, v25
	v_lshl_add_u32 v25, v122, 23, v25
	v_lshlrev_b32_e64 v22, v22, 1
	v_lshlrev_b32_e64 v70, v23, 1
	v_mov_b32_e32 v38, v2
	v_mov_b32_e32 v39, v78
	v_mov_b32_e32 v40, v82
	v_mov_b32_e32 v41, v86
	s_mov_b32 s0, 0xbfb8aa3b
	s_movk_i32 s1, 0x7fff
	v_bfrev_b32_e32 v2, -2
	s_mov_b32 s23, s27
	v_mov_b32_e32 v78, v3
	v_mov_b32_e32 v86, v83
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v44, 0xffffff, v0
	v_lshlrev_b32_e32 v0, 2, v44
	buffer_load_dword v28, v0, s[12:15], 0 offen
	v_add_u32_e32 v0, 17, v123
	v_lshlrev_b32_e64 v0, v0, 1
	v_cndmask_b32_e32 v1, v0, v42, vcc
	v_cmp_lt_i32_e32 vcc, 5, v121
	s_nop 1
	v_cndmask_b32_e32 v0, v43, v29, vcc
	v_cmp_lt_i32_e32 vcc, 5, v122
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[28:29], v[0:1] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v23, v22, v25, vcc
	v_cmp_lt_i32_e32 vcc, 5, v120
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_lshlrev_b32_e32 v25, 8, v24
	v_cndmask_b32_e32 v22, v70, v45, vcc
	v_pk_mul_f32 v[28:29], v[28:29], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[28:29]
	v_mov_b32_e32 v28, v38
	v_mov_b32_e32 v29, v40
	v_pk_mul_f32 v[28:29], v[28:29], s[0:1] op_sel_hi:[1,0]
	v_cmp_gt_u32_e32 vcc, s33, v44
	v_exp_f32_e32 v42, v28
	v_exp_f32_e32 v43, v29
	v_add_lshl_u32 v28, v25, v118, 1
	v_add_lshl_u32 v25, v25, v119, 1
	v_cndmask_b32_e32 v44, v2, v25, vcc
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	v_add_u32_e32 v3, 0x200, v28
	v_rcp_f32_e32 v29, v42
	v_rcp_f32_e32 v42, v43
	v_cndmask_b32_e32 v43, v2, v28, vcc
	v_mul_f32_e32 v29, v38, v29
	v_mul_f32_e32 v38, v40, v42
	v_mul_f32_e32 v29, v39, v29
	v_mul_f32_e32 v38, v41, v38
	v_bfe_u32 v39, v29, 16, 1
	v_or_b32_e32 v40, 0x400000, v29
	v_bfe_u32 v41, v38, 16, 1
	v_add3_u32 v39, v39, v29, s1
	v_cmp_u_f32_e32 vcc, v29, v29
	v_or_b32_e32 v42, 0x400000, v38
	v_add3_u32 v41, v41, v38, s1
	v_cndmask_b32_e32 v29, v39, v40, vcc
	v_cmp_u_f32_e32 vcc, v38, v38
	v_lshrrev_b32_e32 v29, 16, v29
	s_nop 0
	v_cndmask_b32_e32 v38, v41, v42, vcc
	v_lshrrev_b32_e32 v38, 16, v38
	buffer_store_short v29, v43, s[20:23], 0 offen
	buffer_store_short v38, v44, s[20:23], 0 offen
	global_load_dword v29, v[26:27], off offset:4
	v_add_u32_e32 v44, 0x200, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v29, 0xffffff, v29
	v_lshlrev_b32_e32 v38, 2, v29
	buffer_load_dword v38, v38, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v29
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[40:41], v[38:39], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[78:79], v[40:41]
	v_pk_mul_f32 v[38:39], v[86:87], v[38:39]
	v_mov_b32_e32 v42, v40
	v_mov_b32_e32 v43, v38
	v_pk_mul_f32 v[42:43], v[42:43], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v3, vcc
	v_exp_f32_e32 v42, v42
	v_exp_f32_e32 v43, v43
	v_cndmask_b32_e32 v29, v2, v44, vcc
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
	buffer_store_short v38, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:8
	v_mov_b32_e32 v41, v80
	v_mov_b32_e32 v42, v84
	v_mov_b32_e32 v43, v88
	v_add_u32_e32 v4, 0x400, v28
	v_mov_b32_e32 v80, v5
	v_mov_b32_e32 v88, v85
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v29, 2, v3
	buffer_load_dword v38, v29, s[12:15], 0 offen
	v_add_u32_e32 v29, 0x400, v25
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[44:45], v[38:39], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[44:45]
	v_pk_mul_f32 v[38:39], v[42:43], v[38:39]
	v_mov_b32_e32 v42, v40
	v_mov_b32_e32 v43, v38
	v_pk_mul_f32 v[42:43], v[42:43], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v4, vcc
	v_exp_f32_e32 v42, v42
	v_exp_f32_e32 v43, v43
	v_cndmask_b32_e32 v4, v2, v29, vcc
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v42, v42
	v_rcp_f32_e32 v43, v43
	v_mul_f32_e32 v29, v40, v42
	v_mul_f32_e32 v38, v38, v43
	v_mul_f32_e32 v29, v41, v29
	v_mul_f32_e32 v38, v39, v38
	v_bfe_u32 v39, v29, 16, 1
	v_or_b32_e32 v40, 0x400000, v29
	v_bfe_u32 v41, v38, 16, 1
	v_add3_u32 v39, v39, v29, s1
	v_cmp_u_f32_e32 vcc, v29, v29
	v_or_b32_e32 v42, 0x400000, v38
	v_add3_u32 v41, v41, v38, s1
	v_cndmask_b32_e32 v29, v39, v40, vcc
	v_cmp_u_f32_e32 vcc, v38, v38
	v_lshrrev_b32_e32 v29, 16, v29
	s_nop 0
	v_cndmask_b32_e32 v38, v41, v42, vcc
	v_lshrrev_b32_e32 v38, 16, v38
	buffer_store_short v29, v3, s[20:23], 0 offen
	buffer_store_short v38, v4, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:12
	v_add_u32_e32 v29, 0x600, v28
	v_add_u32_e32 v42, 0x600, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[80:81], v[38:39]
	v_pk_mul_f32 v[4:5], v[88:89], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v29, v2, v42, vcc
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
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:64
	v_mov_b32_e32 v39, v62
	v_mov_b32_e32 v40, v58
	v_mov_b32_e32 v41, v66
	v_add_u32_e32 v29, 0x2000, v28
	v_mov_b32_e32 v62, v55
	v_mov_b32_e32 v66, v59
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_pk_mul_f32 v[4:5], v[40:41], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v42, 0x2000, v25
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_cndmask_b32_e32 v29, v2, v42, vcc
	v_add_u32_e32 v42, 0x2200, v25
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
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:68
	v_add_u32_e32 v29, 0x2200, v28
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[62:63], v[38:39]
	v_pk_mul_f32 v[4:5], v[66:67], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v29, v2, v42, vcc
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
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:72
	v_mov_b32_e32 v39, v64
	v_mov_b32_e32 v40, v60
	v_mov_b32_e32 v41, v68
	v_add_u32_e32 v29, 0x2400, v28
	v_mov_b32_e32 v64, v57
	v_mov_b32_e32 v68, v61
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_pk_mul_f32 v[4:5], v[40:41], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_add_u32_e32 v42, 0x2400, v25
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_cndmask_b32_e32 v29, v2, v42, vcc
	v_add_u32_e32 v42, 0x2600, v25
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
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:76
	v_add_u32_e32 v29, 0x2600, v28
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[64:65], v[38:39]
	v_pk_mul_f32 v[4:5], v[68:69], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v29, v2, v42, vcc
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
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:128
	v_mov_b32_e32 v39, v50
	v_mov_b32_e32 v40, v30
	v_mov_b32_e32 v41, v34
	v_add_u32_e32 v29, 0x4000, v28
	v_add_u32_e32 v30, 0x4000, v25
	v_mov_b32_e32 v50, v47
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[42:43], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[42:43]
	v_pk_mul_f32 v[4:5], v[40:41], v[4:5]
	v_mov_b32_e32 v40, v38
	v_mov_b32_e32 v41, v4
	v_pk_mul_f32 v[40:41], v[40:41], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v40, v40
	v_exp_f32_e32 v41, v41
	v_cndmask_b32_e32 v29, v2, v30, vcc
	v_pk_add_f32 v[40:41], v[40:41], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v34, v40
	v_rcp_f32_e32 v40, v41
	v_mul_f32_e32 v30, v38, v34
	v_mul_f32_e32 v4, v4, v40
	v_mul_f32_e32 v30, v39, v30
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v30, 16, 1
	v_or_b32_e32 v34, 0x400000, v30
	v_bfe_u32 v38, v4, 16, 1
	v_add3_u32 v5, v5, v30, s1
	v_cmp_u_f32_e32 vcc, v30, v30
	v_or_b32_e32 v39, 0x400000, v4
	v_add3_u32 v38, v38, v4, s1
	v_cndmask_b32_e32 v5, v5, v34, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v34, v31
	v_cndmask_b32_e32 v4, v38, v39, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:132
	v_add_u32_e32 v29, 0x4200, v28
	v_add_u32_e32 v38, 0x4200, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[30:31], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[50:51], v[30:31]
	v_pk_mul_f32 v[4:5], v[34:35], v[4:5]
	v_mov_b32_e32 v34, v30
	v_mov_b32_e32 v35, v4
	v_pk_mul_f32 v[34:35], v[34:35], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v34, v34
	v_exp_f32_e32 v35, v35
	v_cndmask_b32_e32 v29, v2, v38, vcc
	v_pk_add_f32 v[34:35], v[34:35], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v34, v34
	v_rcp_f32_e32 v35, v35
	v_mul_f32_e32 v30, v30, v34
	v_mul_f32_e32 v4, v4, v35
	v_mul_f32_e32 v30, v31, v30
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v30, 16, 1
	v_or_b32_e32 v31, 0x400000, v30
	v_bfe_u32 v34, v4, 16, 1
	v_add3_u32 v5, v5, v30, s1
	v_cmp_u_f32_e32 vcc, v30, v30
	v_or_b32_e32 v35, 0x400000, v4
	v_add3_u32 v34, v34, v4, s1
	v_cndmask_b32_e32 v5, v5, v31, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v30, v48
	v_cndmask_b32_e32 v4, v34, v35, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:136
	v_mov_b32_e32 v31, v52
	v_mov_b32_e32 v34, v32
	v_mov_b32_e32 v35, v36
	v_add_u32_e32 v29, 0x4400, v28
	v_add_u32_e32 v32, 0x4400, v25
	v_mov_b32_e32 v52, v49
	v_mov_b32_e32 v36, v33
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[38:39], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[30:31], v[38:39]
	v_pk_mul_f32 v[4:5], v[34:35], v[4:5]
	v_mov_b32_e32 v34, v30
	v_mov_b32_e32 v35, v4
	v_pk_mul_f32 v[34:35], v[34:35], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v34, v34
	v_exp_f32_e32 v35, v35
	v_cndmask_b32_e32 v29, v2, v32, vcc
	v_pk_add_f32 v[34:35], v[34:35], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v34, v34
	v_rcp_f32_e32 v35, v35
	v_mul_f32_e32 v30, v30, v34
	v_mul_f32_e32 v4, v4, v35
	v_mul_f32_e32 v30, v31, v30
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v30, 16, 1
	v_or_b32_e32 v31, 0x400000, v30
	v_bfe_u32 v32, v4, 16, 1
	v_add3_u32 v5, v5, v30, s1
	v_cmp_u_f32_e32 vcc, v30, v30
	v_or_b32_e32 v34, 0x400000, v4
	v_add3_u32 v32, v32, v4, s1
	v_cndmask_b32_e32 v5, v5, v31, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v32, v34, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:140
	v_add_u32_e32 v29, 0x4600, v28
	v_add_u32_e32 v34, 0x4600, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[30:31], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[52:53], v[30:31]
	v_pk_mul_f32 v[4:5], v[36:37], v[4:5]
	v_mov_b32_e32 v32, v30
	v_mov_b32_e32 v33, v4
	v_pk_mul_f32 v[32:33], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v29, vcc
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cndmask_b32_e32 v29, v2, v34, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_mul_f32_e32 v30, v30, v32
	v_mul_f32_e32 v4, v4, v33
	v_mul_f32_e32 v30, v31, v30
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v30, 16, 1
	v_or_b32_e32 v31, 0x400000, v30
	v_bfe_u32 v32, v4, 16, 1
	v_add3_u32 v5, v5, v30, s1
	v_cmp_u_f32_e32 vcc, v30, v30
	v_or_b32_e32 v33, 0x400000, v4
	v_add3_u32 v32, v32, v4, s1
	v_cndmask_b32_e32 v5, v5, v31, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v30, v14
	v_cndmask_b32_e32 v4, v32, v33, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v29, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:192
	v_mov_b32_e32 v31, v18
	v_mov_b32_e32 v32, v6
	v_mov_b32_e32 v33, v10
	v_add_u32_e32 v6, 0x6000, v28
	v_add_u32_e32 v10, 0x6000, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[34:35], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[30:31], v[34:35]
	v_pk_mul_f32 v[4:5], v[32:33], v[4:5]
	v_mov_b32_e32 v32, v30
	v_mov_b32_e32 v33, v4
	v_pk_mul_f32 v[32:33], v[32:33], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v3, v2, v6, vcc
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cndmask_b32_e32 v6, v2, v10, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v14, v32
	v_rcp_f32_e32 v18, v33
	v_mul_f32_e32 v10, v30, v14
	v_mul_f32_e32 v4, v4, v18
	v_mul_f32_e32 v10, v31, v10
	v_mul_f32_e32 v4, v5, v4
	v_bfe_u32 v5, v10, 16, 1
	v_or_b32_e32 v14, 0x400000, v10
	v_bfe_u32 v18, v4, 16, 1
	v_add3_u32 v5, v5, v10, s1
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v29, 0x400000, v4
	v_add3_u32 v18, v18, v4, s1
	v_cndmask_b32_e32 v5, v5, v14, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	v_mov_b32_e32 v10, v7
	v_cndmask_b32_e32 v4, v18, v29, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v3, s[20:23], 0 offen
	buffer_store_short v4, v6, s[20:23], 0 offen
	global_load_dword v3, v[26:27], off offset:196
	v_mov_b32_e32 v18, v15
	v_add_u32_e32 v14, 0x6200, v28
	v_add_u32_e32 v15, 0x6200, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
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
	global_load_dword v3, v[26:27], off offset:200
	v_mov_b32_e32 v7, v20
	v_mov_b32_e32 v10, v8
	v_mov_b32_e32 v11, v12
	v_add_u32_e32 v8, 0x6400, v28
	v_add_u32_e32 v12, 0x6400, v25
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v3, 0xffffff, v3
	v_lshlrev_b32_e32 v4, 2, v3
	buffer_load_dword v4, v4, s[12:15], 0 offen
	v_cmp_gt_u32_e32 vcc, s33, v3
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[22:23] op_sel_hi:[0,1]
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
	global_load_dword v2, v[26:27], off offset:204
	v_or_b32_e32 v3, 51, v24
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
	v_add_lshl_u32 v8, v118, v6, 1
	s_mov_b32 s23, s27
	v_add_lshl_u32 v6, v119, v6, 1
	v_cndmask_b32_e64 v8, v7, v8, s[0:1]
	v_cndmask_b32_e64 v6, v7, v6, s[0:1]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[0:1], v[0:1], v[2:3] op_sel_hi:[1,0]
	v_pk_mul_f32 v[2:3], v[22:23], v[2:3] op_sel_hi:[1,0]
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
	.size	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss, .Lfunc_end0-a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss
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
		.amdhsa_next_free_vgpr 173
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 176
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

	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.num_vgpr, 173
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.num_agpr, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.numbered_sgpr, 41
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.num_named_barrier, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.private_seg_size, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.uses_vcc, 1
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.uses_flat_scratch, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.has_dyn_sized_stack, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.has_recursion, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.has_indirect_call, 0
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
    .name:           a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     47
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_dynm_ss.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     173
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
