	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt
	.p2align	8
	.type	gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt,@function
gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt:
	s_load_dwordx4 s[16:19], s[0:1], 0x20
	v_readfirstlane_b32 s3, v0
	s_mov_b32 s30, 0
	s_waitcnt lgkmcnt(0)
	s_load_dword s29, s[16:17], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s29, 31
	s_lshr_b32 s4, s4, 26
	s_add_i32 s4, s29, s4
	s_ashr_i32 s8, s4, 6
	s_andn2_b32 s4, s4, 63
	s_cmp_lg_u32 s29, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s29, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s4, s8, 0
	s_lshl_b32 s5, s4, 1
	s_cmp_ge_i32 s2, s5
	s_cbranch_scc1 .LBB0_4
	s_and_b32 s6, s5, 6
	s_and_b32 s7, s2, 7
	s_lshr_b32 s5, s5, 3
	s_min_u32 s6, s7, s6
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s5, s5, s7
	s_add_i32 s2, s6, s2
	s_add_i32 s2, s2, s5
	s_lshr_b32 s5, s2, 31
	s_add_i32 s5, s2, s5
	s_ashr_i32 s10, s5, 1
	s_and_b32 s5, s5, -2
	s_cmp_lg_u32 s2, s5
	s_cselect_b64 s[6:7], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[8:9], -1, 0
	s_and_b64 s[6:7], s[8:9], s[6:7]
	s_subb_u32 s6, s10, 0
	s_sub_i32 s7, s4, s6
	s_min_i32 s4, s7, 1
	s_abs_i32 s16, s4
	v_cvt_f32_u32_e32 v1, s16
	s_sub_i32 s20, 0, s16
	s_sub_i32 s2, s2, s5
	s_abs_i32 s17, s2
	v_rcp_f32_e32 v1, v1
	s_xor_b32 s5, s2, s4
	s_ashr_i32 s5, s5, 31
	s_load_dwordx8 s[8:15], s[0:1], 0x0
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_and_b32_e32 v24, 15, v0
	v_bfe_u32 v122, v0, 4, 2
	v_and_b32_e32 v17, 48, v0
	v_readfirstlane_b32 s21, v1
	s_mul_i32 s20, s20, s21
	s_mul_hi_u32 s20, s21, s20
	s_add_i32 s21, s21, s20
	s_mul_hi_u32 s20, s17, s21
	s_mul_i32 s21, s20, s16
	s_sub_i32 s17, s17, s21
	s_add_i32 s21, s20, 1
	s_sub_i32 s22, s17, s16
	s_cmp_ge_u32 s17, s16
	s_cselect_b32 s20, s21, s20
	s_cselect_b32 s17, s22, s17
	s_add_i32 s21, s20, 1
	s_cmp_ge_u32 s17, s16
	s_cselect_b32 s16, s21, s20
	s_xor_b32 s16, s16, s5
	s_sub_i32 s16, s16, s5
	s_mul_i32 s4, s16, s4
	s_sub_i32 s5, s2, s4
	s_add_i32 s17, s5, s6
	s_cmp_lg_u32 s2, s4
	s_cselect_b64 s[4:5], -1, 0
	s_xor_b32 s2, s7, s2
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_lshl1_add_u32 s2, s17, s16
	s_cmp_lg_u64 s[4:5], 0
	s_subb_u32 s2, s2, 0
	s_lshr_b32 s4, s2, 31
	s_add_i32 s4, s2, s4
	s_ashr_i32 s16, s4, 1
	s_and_b32 s4, s4, -2
	s_sub_i32 s25, s2, s4
	s_cmp_lg_u32 s2, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s4, s16, 0
	s_ashr_i32 s5, s4, 31
	s_lshl_b64 s[6:7], s[4:5], 2
	s_waitcnt lgkmcnt(0)
	s_add_u32 s6, s14, s6
	v_lshrrev_b32_e32 v1, 4, v0
	s_addc_u32 s7, s15, s7
	s_lshl_b32 s31, s4, 6
	v_or_b32_e32 v2, s31, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[18:19]
	global_load_dword v9, v[2:3], off offset:192
	global_load_dword v11, v[2:3], off
	global_load_dword v13, v[2:3], off offset:64
	global_load_dword v15, v[2:3], off offset:128
	s_load_dword s2, s[6:7], 0x0
	s_load_dword s28, s[0:1], 0x30
	s_load_dwordx4 s[20:23], s[0:1], 0x48
	s_load_dwordx2 s[16:17], s[0:1], 0x58
	s_lshr_b32 s1, s3, 1
	s_lshl_b32 s0, s25, 7
	s_and_b32 s1, s1, 0x7fffffe0
	s_add_i32 s0, s0, s1
	v_or_b32_e32 v120, s0, v24
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s1, s2, 9
	v_add_u32_e32 v2, s1, v120
	v_ashrrev_i32_e32 v3, 31, v2
	v_or_b32_e32 v121, 16, v120
	v_lshrrev_b32_e32 v8, 28, v3
	v_add_u32_e32 v4, s1, v121
	v_add_u32_e32 v6, 0x100, v2
	v_add_u32_e32 v8, v2, v8
	v_ashrrev_i32_e32 v5, 31, v4
	v_ashrrev_i32_e32 v7, 31, v6
	v_ashrrev_i32_e32 v14, 4, v8
	v_and_b32_e32 v8, -16, v8
	v_cmp_gt_i32_e32 vcc, 0, v2
	v_lshrrev_b32_e32 v10, 28, v5
	v_lshrrev_b32_e32 v12, 28, v7
	v_cmp_ne_u32_e64 s[4:5], v2, v8
	v_add_u32_e32 v10, v4, v10
	v_add_u32_e32 v12, v6, v12
	s_and_b64 vcc, vcc, s[4:5]
	v_ashrrev_i32_e32 v16, 4, v10
	v_and_b32_e32 v10, -16, v10
	v_sub_u32_e32 v8, v2, v8
	v_ashrrev_i32_e32 v18, 4, v12
	v_and_b32_e32 v20, -16, v12
	v_subbrev_co_u32_e32 v12, vcc, 0, v14, vcc
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[16:17]
	s_add_i32 s33, s0, s1
	v_add_u32_e32 v21, 0x100, v4
	v_cmp_gt_i32_e64 s[0:1], 0, v4
	v_cmp_gt_i32_e64 s[2:3], 0, v6
	v_cmp_ne_u32_e64 s[6:7], v4, v10
	v_sub_u32_e32 v10, v4, v10
	v_cmp_ne_u32_e32 vcc, v6, v20
	v_sub_u32_e32 v14, v6, v20
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[16:17]
	v_lshl_add_u64 v[6:7], v[6:7], 2, s[16:17]
	global_load_dword v125, v[2:3], off
	global_load_dword v123, v[4:5], off
	global_load_dword v126, v[6:7], off
	global_load_dword v124, v[6:7], off offset:64
	s_and_b64 s[0:1], s[0:1], s[6:7]
	s_and_b64 vcc, s[2:3], vcc
	v_subbrev_co_u32_e64 v16, s[0:1], 0, v16, s[0:1]
	v_subbrev_co_u32_e32 v18, vcc, 0, v18, vcc
	v_cmp_gt_i32_e64 s[0:1], 0, v21
	v_lshlrev_b32_e32 v19, 4, v0
	v_lshlrev_b32_e32 v26, 5, v122
	v_xor_b32_e32 v0, v19, v0
	v_lshlrev_b32_e32 v64, 8, v122
	v_mov_b32_e32 v65, 0
	v_and_b32_e32 v25, 0xf0, v19
	v_and_b32_e32 v128, 0xf0, v0
	v_lshlrev_b32_e32 v0, 8, v1
	v_ashrrev_i32_e32 v19, 31, v18
	v_lshlrev_b32_e32 v1, 4, v24
	v_or_b32_e32 v4, 8, v26
	v_or_b32_e32 v5, 16, v26
	v_or_b32_e32 v6, 24, v26
	v_or_b32_e32 v7, 0x80, v26
	s_mov_b32 s27, 0x27000
	v_lshlrev_b64 v[108:109], 15, v[18:19]
	v_xor_b32_e32 v2, v26, v1
	v_lshlrev_b32_e32 v3, 8, v24
	v_xor_b32_e32 v4, v4, v1
	v_xor_b32_e32 v5, v5, v1
	v_xor_b32_e32 v6, v6, v1
	v_xor_b32_e32 v7, v7, v1
	s_brev_b32 s26, 8
	s_mov_b32 s24, s10
	s_waitcnt vmcnt(7)
	v_lshlrev_b32_e32 v127, 12, v9
	v_ashrrev_i32_e32 v9, 31, v21
	v_lshrrev_b32_e32 v9, 28, v9
	v_add_u32_e32 v9, v21, v9
	v_ashrrev_i32_e32 v20, 4, v9
	v_and_b32_e32 v9, -16, v9
	v_cmp_ne_u32_e32 vcc, v21, v9
	s_and_b64 vcc, s[0:1], vcc
	s_ashr_i32 s1, s33, 31
	s_lshr_b32 s2, s1, 27
	s_or_b32 s2, s2, s33
	s_add_i32 s2, s2, 16
	s_add_i32 s0, s33, 0x110
	s_lshr_b32 s2, s2, 5
	s_add_i32 s2, s2, s1
	s_ashr_i32 s1, s0, 31
	s_lshr_b32 s3, s1, 27
	s_add_i32 s0, s0, s3
	s_lshr_b32 s0, s0, 5
	s_add_i32 s0, s0, s1
	s_lshl_b32 s1, s33, 5
	v_subbrev_co_u32_e32 v20, vcc, 0, v20, vcc
	v_sub_u32_e32 v22, v21, v9
	s_waitcnt vmcnt(6)
	v_lshlrev_b32_e32 v129, 12, v11
	v_or3_b32 v132, s1, v17, v24
	s_lshl_b32 s2, s2, 10
	s_addk_i32 s1, 0x2000
	s_lshl_b32 s0, s0, 10
	v_ashrrev_i32_e32 v9, 31, v8
	v_ashrrev_i32_e32 v11, 31, v10
	s_waitcnt vmcnt(5)
	v_lshlrev_b32_e32 v130, 12, v13
	s_waitcnt vmcnt(4)
	v_lshlrev_b32_e32 v131, 12, v15
	v_or3_b32 v133, s2, v17, v24
	v_or3_b32 v134, s1, v17, v24
	v_or3_b32 v135, s0, v17, v24
	v_ashrrev_i32_e32 v13, 31, v12
	v_lshl_add_u64 v[102:103], v[8:9], 4, v[64:65]
	v_ashrrev_i32_e32 v17, 31, v16
	v_lshl_add_u64 v[106:107], v[10:11], 4, v[64:65]
	v_ashrrev_i32_e32 v15, 31, v14
	v_ashrrev_i32_e32 v21, 31, v20
	v_ashrrev_i32_e32 v23, 31, v22
	v_or_b32_e32 v8, 0x88, v26
	v_or_b32_e32 v9, 0x90, v26
	v_or_b32_e32 v10, 0x98, v26
	v_lshlrev_b64 v[100:101], 15, v[12:13]
	v_lshlrev_b64 v[104:105], 15, v[16:17]
	v_lshl_add_u64 v[110:111], v[14:15], 4, v[64:65]
	v_lshlrev_b64 v[112:113], 15, v[20:21]
	v_lshl_add_u64 v[114:115], v[22:23], 4, v[64:65]
	v_xor_b32_e32 v8, v8, v1
	v_xor_b32_e32 v9, v9, v1
	v_xor_b32_e32 v1, v10, v1
	s_mov_b32 s14, 0x1000000
	s_and_b32 s25, s11, 0xffff
	s_mov_b32 s15, s27
	s_and_b32 s13, s13, 0xffff
	s_lshl_b32 s10, s28, 12
	s_mov_b32 s11, s27
	s_and_b32 s9, s9, 0xffff
	v_add_u32_e32 v101, v0, v25
	v_add_u32_e32 v103, v3, v2
	v_add_u32_e32 v105, v3, v4
	v_add_u32_e32 v107, v3, v5
	v_add_u32_e32 v109, v3, v6
	v_add_u32_e32 v111, v3, v7
	v_add_u32_e32 v113, v3, v8
	v_add_u32_e32 v115, v3, v9
	v_add_u32_e32 v136, v3, v1
	s_mov_b32 s6, 0x8080808
	s_mov_b32 s7, 0x80808080
	s_mov_b32 s16, 0x5010400
	s_mov_b32 s17, 0x7030602
	v_mov_b32_e32 v64, v65
	v_mov_b32_e32 v66, v65
	v_mov_b32_e32 v67, v65
	v_mov_b32_e32 v68, v65
	v_mov_b32_e32 v69, v65
	v_mov_b32_e32 v70, v65
	v_mov_b32_e32 v71, v65
	v_mov_b32_e32 v48, v65
	v_mov_b32_e32 v49, v65
	v_mov_b32_e32 v50, v65
	v_mov_b32_e32 v51, v65
	v_mov_b32_e32 v52, v65
	v_mov_b32_e32 v53, v65
	v_mov_b32_e32 v54, v65
	v_mov_b32_e32 v55, v65
	v_mov_b32_e32 v32, v65
	v_mov_b32_e32 v33, v65
	v_mov_b32_e32 v34, v65
	v_mov_b32_e32 v35, v65
	v_mov_b32_e32 v36, v65
	v_mov_b32_e32 v37, v65
	v_mov_b32_e32 v38, v65
	v_mov_b32_e32 v39, v65
	v_mov_b32_e32 v16, v65
	v_mov_b32_e32 v17, v65
	v_mov_b32_e32 v18, v65
	v_mov_b32_e32 v19, v65
	v_mov_b32_e32 v20, v65
	v_mov_b32_e32 v21, v65
	v_mov_b32_e32 v22, v65
	v_mov_b32_e32 v23, v65
	v_mov_b32_e32 v72, v65
	v_mov_b32_e32 v73, v65
	v_mov_b32_e32 v74, v65
	v_mov_b32_e32 v75, v65
	v_mov_b32_e32 v76, v65
	v_mov_b32_e32 v77, v65
	v_mov_b32_e32 v78, v65
	v_mov_b32_e32 v79, v65
	v_mov_b32_e32 v56, v65
	v_mov_b32_e32 v57, v65
	v_mov_b32_e32 v58, v65
	v_mov_b32_e32 v59, v65
	v_mov_b32_e32 v60, v65
	v_mov_b32_e32 v61, v65
	v_mov_b32_e32 v62, v65
	v_mov_b32_e32 v63, v65
	v_mov_b32_e32 v40, v65
	v_mov_b32_e32 v41, v65
	v_mov_b32_e32 v42, v65
	v_mov_b32_e32 v43, v65
	v_mov_b32_e32 v44, v65
	v_mov_b32_e32 v45, v65
	v_mov_b32_e32 v46, v65
	v_mov_b32_e32 v47, v65
	v_mov_b32_e32 v24, v65
	v_mov_b32_e32 v25, v65
	v_mov_b32_e32 v26, v65
	v_mov_b32_e32 v27, v65
	v_mov_b32_e32 v28, v65
	v_mov_b32_e32 v29, v65
	v_mov_b32_e32 v30, v65
	v_mov_b32_e32 v31, v65
.LBB0_2:
	s_lshl_b32 s0, s30, 6
	v_add_lshl_u32 v0, s0, v132, 2
	v_add_lshl_u32 v2, s0, v134, 2
	v_lshl_or_b32 v4, s30, 8, v128
	v_add_lshl_u32 v1, s0, v133, 2
	v_add_lshl_u32 v3, s0, v135, 2
	buffer_load_dword v140, v0, s[12:15], 0 offen
	buffer_load_dword v138, v1, s[12:15], 0 offen
	buffer_load_dword v139, v2, s[12:15], 0 offen
	buffer_load_dword v137, v3, s[12:15], 0 offen
	v_add_u32_e32 v0, v4, v129
	v_add_u32_e32 v2, v4, v131
	s_lshl_b32 s0, s30, 11
	v_add_u32_e32 v1, v4, v130
	v_add_u32_e32 v3, v4, v127
	buffer_load_dwordx4 v[96:99], v0, s[8:11], 0 offen nt
	buffer_load_dwordx4 v[116:119], v1, s[8:11], 0 offen nt
	buffer_load_dwordx4 v[142:145], v2, s[8:11], 0 offen nt
	buffer_load_dwordx4 v[146:149], v3, s[8:11], 0 offen nt
	v_or_b32_e32 v0, s0, v100
	v_or_b32_e32 v4, s0, v104
	v_or_b32_e32 v5, s0, v108
	v_or_b32_e32 v6, s0, v112
	v_add_u32_e32 v1, v102, v0
	v_add_u32_e32 v0, v106, v4
	v_add_u32_e32 v5, v110, v5
	v_add_u32_e32 v4, v114, v6
	buffer_load_dwordx4 v[92:95], v1, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[88:91], v5, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[84:87], v0, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[80:83], v4, s[24:27], 0 offen sc0
	s_bitset1_b32 s0, 10
	v_or_b32_e32 v2, s0, v100
	v_or_b32_e32 v3, s0, v104
	v_or_b32_e32 v6, s0, v108
	v_or_b32_e32 v7, s0, v112
	v_add_u32_e32 v0, v102, v2
	v_add_u32_e32 v1, v106, v3
	v_add_u32_e32 v2, v110, v6
	v_add_u32_e32 v4, v114, v7
	buffer_load_dwordx4 v[8:11], v0, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[12:15], v2, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[0:3], v1, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[4:7], v4, s[24:27], 0 offen sc0
	s_add_i32 s30, s30, 1
	s_cmp_lg_u32 s30, 16
	s_waitcnt vmcnt(11)
	ds_write_b128 v101, v[96:99]
	s_waitcnt vmcnt(10)
	ds_write_b128 v101, v[116:119] offset:4096
	s_waitcnt vmcnt(9)
	ds_write_b128 v101, v[142:145] offset:8192
	s_waitcnt vmcnt(8)
	ds_write_b128 v101, v[146:149] offset:12288
	v_sub_u32_sdwa v96, v125, v140 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v116, 11, v96
	v_mul_lo_u32 v116, v116, s6
	v_cmp_lt_i32_e32 vcc, 11, v96
	v_sub_u32_sdwa v97, v126, v139 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	s_waitcnt vmcnt(7)
	v_lshrrev_b32_e32 v118, 4, v92
	v_and_b32_e32 v118, 0x7070707, v118
	s_waitcnt vmcnt(5)
	v_lshrrev_b32_e32 v143, 4, v84
	v_and_b32_e32 v151, 0x7070707, v143
	v_sub_u32_e32 v143, 0x6c686080, v116
	v_sub_u32_e32 v116, 0x7c787470, v116
	v_and_b32_e32 v143, 0xffffff00, v143
	v_cndmask_b32_e64 v164, v116, 0, vcc
	v_cndmask_b32_e64 v165, v143, 0, vcc
	v_sub_u32_sdwa v98, v123, v138 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_1
	v_sub_u32_sdwa v99, v124, v137 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_1
	v_min_i32_e32 v119, 11, v97
	v_perm_b32 v116, v164, v165, v118
	v_and_b32_e32 v96, 0x7070707, v92
	v_lshlrev_b32_e32 v117, 4, v92
	v_lshrrev_b32_e32 v141, 4, v88
	v_min_i32_e32 v142, 11, v98
	v_min_i32_e32 v144, 11, v99
	v_mul_lo_u32 v119, v119, s6
	v_and_or_b32 v92, v92, s7, v116
	v_add_u32_e32 v116, 0x7f7f7f7f, v116
	v_and_b32_e32 v150, 0x7070707, v141
	v_mul_lo_u32 v141, v142, s6
	v_mul_lo_u32 v142, v144, s6
	v_sub_u32_e32 v144, 0x6c686080, v119
	v_perm_b32 v96, v164, v165, v96
	v_or_b32_e32 v116, 0x7f7f7f7f, v116
	v_cmp_lt_i32_e64 s[0:1], 11, v97
	s_waitcnt vmcnt(4)
	v_lshrrev_b32_e32 v145, 4, v80
	v_sub_u32_e32 v119, 0x7c787470, v119
	v_and_or_b32 v117, v117, s7, v96
	v_add_u32_e32 v96, 0x7f7f7f7f, v96
	v_and_b32_e32 v92, v116, v92
	v_sub_u32_e32 v116, 0x6c686080, v142
	v_and_b32_e32 v118, 0xffffff00, v144
	v_and_b32_e32 v97, 0x7070707, v88
	v_cmp_lt_i32_e64 s[4:5], 11, v99
	v_and_b32_e32 v152, 0x7070707, v145
	v_sub_u32_e32 v145, 0x6c686080, v141
	v_or_b32_e32 v96, 0x7f7f7f7f, v96
	v_cndmask_b32_e64 v144, v119, 0, s[0:1]
	v_and_b32_e32 v116, 0xffffff00, v116
	v_cndmask_b32_e64 v146, v118, 0, s[0:1]
	v_lshlrev_b32_e32 v147, 4, v88
	v_cmp_lt_i32_e64 s[2:3], 11, v98
	v_sub_u32_e32 v141, 0x7c787470, v141
	v_and_b32_e32 v96, v96, v117
	v_sub_u32_e32 v117, 0x7c787470, v142
	v_and_b32_e32 v119, 0xffffff00, v145
	v_cndmask_b32_e64 v143, v116, 0, s[4:5]
	v_perm_b32 v97, v144, v146, v97
	v_perm_b32 v116, v144, v146, v150
	v_and_b32_e32 v98, 0x7070707, v84
	v_and_b32_e32 v99, 0x7070707, v80
	v_cndmask_b32_e64 v142, v141, 0, s[2:3]
	v_cndmask_b32_e64 v141, v117, 0, s[4:5]
	v_cndmask_b32_e64 v145, v119, 0, s[2:3]
	v_and_or_b32 v119, v147, s7, v97
	v_add_u32_e32 v97, 0x7f7f7f7f, v97
	v_and_or_b32 v88, v88, s7, v116
	v_add_u32_e32 v116, 0x7f7f7f7f, v116
	v_lshlrev_b32_e32 v148, 4, v84
	v_lshlrev_b32_e32 v149, 4, v80
	v_perm_b32 v98, v142, v145, v98
	v_perm_b32 v117, v142, v145, v151
	v_perm_b32 v99, v141, v143, v99
	v_perm_b32 v118, v141, v143, v152
	v_or_b32_e32 v97, 0x7f7f7f7f, v97
	v_or_b32_e32 v116, 0x7f7f7f7f, v116
	v_and_b32_e32 v97, v97, v119
	v_and_or_b32 v119, v148, s7, v98
	v_add_u32_e32 v98, 0x7f7f7f7f, v98
	v_and_b32_e32 v88, v116, v88
	v_and_or_b32 v84, v84, s7, v117
	v_add_u32_e32 v116, 0x7f7f7f7f, v117
	v_and_or_b32 v117, v149, s7, v99
	v_add_u32_e32 v99, 0x7f7f7f7f, v99
	v_and_or_b32 v80, v80, s7, v118
	v_add_u32_e32 v118, 0x7f7f7f7f, v118
	v_or_b32_e32 v98, 0x7f7f7f7f, v98
	v_or_b32_e32 v116, 0x7f7f7f7f, v116
	v_or_b32_e32 v99, 0x7f7f7f7f, v99
	v_or_b32_e32 v118, 0x7f7f7f7f, v118
	v_and_b32_e32 v98, v98, v119
	v_and_b32_e32 v84, v116, v84
	v_and_b32_e32 v99, v99, v117
	v_and_b32_e32 v80, v118, v80
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_perm_b32 v148, v92, v96, s16
	v_perm_b32 v149, v92, v96, s17
	v_perm_b32 v152, v88, v97, s16
	v_perm_b32 v153, v88, v97, s17
	v_perm_b32 v156, v84, v98, s16
	v_perm_b32 v157, v84, v98, s17
	v_perm_b32 v160, v80, v99, s16
	v_perm_b32 v161, v80, v99, s17
	ds_read2st64_b64 v[96:99], v103 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[116:119], v[96:97], v[156:157], v[68:71]
	v_lshlrev_b32_e32 v92, 4, v90
	v_sub_u32_sdwa v137, v124, v137 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_3
	v_cmp_lt_i32_e64 s[4:5], 11, v137
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[96:97], v[152:153], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[98:99], v[152:153], v[56:59]
	s_nop 2
	ds_read2st64_b64 v[56:59], v103 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[98:99], v[148:149], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[96:97], v[148:149], v[64:67]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[56:57], v[148:149], v[32:35]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[58:59], v[148:149], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[148:151], v[56:57], v[152:153], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[58:59], v[152:153], v[24:27]
	s_nop 1
	v_lshlrev_b32_e32 v40, 4, v89
	v_and_b32_e32 v41, 0x7070707, v81
	v_lshlrev_b32_e32 v42, 4, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[152:155], v[56:57], v[156:157], v[36:39]
	v_perm_b32 v41, v141, v143, v41
	v_and_or_b32 v42, v42, s7, v41
	v_add_u32_e32 v41, 0x7f7f7f7f, v41
	v_and_b32_e32 v36, 0x7070707, v93
	v_lshlrev_b32_e32 v37, 4, v93
	v_lshrrev_b32_e32 v38, 4, v93
	v_perm_b32 v36, v164, v165, v36
	v_and_b32_e32 v38, 0x7070707, v38
	v_and_or_b32 v37, v37, s7, v36
	v_add_u32_e32 v36, 0x7f7f7f7f, v36
	v_and_b32_e32 v39, 0x7070707, v89
	v_perm_b32 v38, v164, v165, v38
	v_or_b32_e32 v36, 0x7f7f7f7f, v36
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[96:97], v[160:161], v[76:79]
	v_and_b32_e32 v37, v36, v37
	v_and_or_b32 v36, v93, s7, v38
	v_add_u32_e32 v38, 0x7f7f7f7f, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[98:99], v[156:157], v[52:55]
	v_perm_b32 v39, v144, v146, v39
	v_or_b32_e32 v38, 0x7f7f7f7f, v38
	v_and_or_b32 v40, v40, s7, v39
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[98:99], v[160:161], v[60:63]
	v_add_u32_e32 v39, 0x7f7f7f7f, v39
	v_and_b32_e32 v38, v38, v36
	v_lshrrev_b32_e32 v36, 4, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[58:59], v[156:157], v[20:23]
	v_or_b32_e32 v39, 0x7f7f7f7f, v39
	v_and_b32_e32 v36, 0x7070707, v36
	v_and_b32_e32 v39, v39, v40
	v_mfma_f32_16x16x32_fp8_fp8 v[156:159], v[56:57], v[160:161], v[44:47]
	v_perm_b32 v36, v141, v143, v36
	v_or_b32_e32 v41, 0x7f7f7f7f, v41
	v_and_b32_e32 v93, 0x7070707, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[160:163], v[58:59], v[160:161], v[28:31]
	s_nop 2
	v_lshrrev_b32_e32 v28, 4, v89
	v_and_b32_e32 v29, 0x7070707, v85
	v_and_b32_e32 v28, 0x7070707, v28
	v_lshlrev_b32_e32 v30, 4, v85
	v_lshrrev_b32_e32 v31, 4, v85
	v_perm_b32 v28, v144, v146, v28
	v_perm_b32 v29, v142, v145, v29
	v_and_b32_e32 v31, 0x7070707, v31
	v_and_or_b32 v40, v89, s7, v28
	v_add_u32_e32 v28, 0x7f7f7f7f, v28
	v_and_or_b32 v30, v30, s7, v29
	v_add_u32_e32 v29, 0x7f7f7f7f, v29
	v_perm_b32 v31, v142, v145, v31
	v_or_b32_e32 v28, 0x7f7f7f7f, v28
	v_or_b32_e32 v29, 0x7f7f7f7f, v29
	v_and_b32_e32 v28, v28, v40
	v_and_or_b32 v40, v85, s7, v31
	v_add_u32_e32 v31, 0x7f7f7f7f, v31
	v_and_b32_e32 v29, v29, v30
	v_and_or_b32 v30, v81, s7, v36
	v_add_u32_e32 v36, 0x7f7f7f7f, v36
	v_or_b32_e32 v31, 0x7f7f7f7f, v31
	v_or_b32_e32 v36, 0x7f7f7f7f, v36
	v_and_b32_e32 v31, v31, v40
	v_and_b32_e32 v40, v41, v42
	v_and_b32_e32 v30, v36, v30
	v_perm_b32 v80, v28, v39, s16
	v_perm_b32 v81, v28, v39, s17
	v_perm_b32 v84, v31, v29, s16
	v_perm_b32 v85, v31, v29, s17
	v_perm_b32 v88, v30, v40, s16
	v_perm_b32 v89, v30, v40, s17
	ds_read2st64_b64 v[28:31], v105 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[28:29], v[80:81], v[68:71]
	v_perm_b32 v36, v38, v37, s16
	v_perm_b32 v37, v38, v37, s17
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[30:31], v[80:81], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[30:31], v[88:89], v[96:99]
	s_nop 2
	ds_read2st64_b64 v[96:99], v105 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[28:29], v[36:37], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[28:29], v[84:85], v[116:119]
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[30:31], v[36:37], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[28:29], v[88:89], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[30:31], v[84:85], v[52:55]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[96:97], v[36:37], v[32:35]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[98:99], v[36:37], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[96:97], v[80:81], v[148:151]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[98:99], v[80:81], v[24:27]
	v_and_b32_e32 v80, 0x7070707, v94
	v_lshlrev_b32_e32 v81, 4, v94
	v_perm_b32 v80, v164, v165, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[96:97], v[84:85], v[152:155]
	v_and_or_b32 v81, v81, s7, v80
	v_add_u32_e32 v80, 0x7f7f7f7f, v80
	v_or_b32_e32 v80, 0x7f7f7f7f, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[98:99], v[84:85], v[20:23]
	v_lshrrev_b32_e32 v84, 4, v94
	v_and_b32_e32 v84, 0x7070707, v84
	v_perm_b32 v84, v164, v165, v84
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[96:97], v[88:89], v[156:159]
	v_lshrrev_b32_e32 v96, 4, v91
	ds_read2st64_b64 v[150:153], v107 offset1:8
	v_and_b32_e32 v85, 0x7070707, v90
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[98:99], v[88:89], v[160:163]
	v_lshrrev_b32_e32 v89, 4, v95
	v_and_b32_e32 v89, 0x7070707, v89
	v_perm_b32 v154, v164, v165, v89
	v_and_or_b32 v89, v94, s7, v84
	v_and_b32_e32 v94, 0x7070707, v96
	v_lshrrev_b32_e32 v88, 4, v90
	v_lshlrev_b32_e32 v149, 4, v95
	v_and_or_b32 v155, v95, s7, v154
	v_perm_b32 v148, v144, v146, v94
	v_lshrrev_b32_e32 v95, 4, v86
	v_and_b32_e32 v80, v80, v81
	v_lshrrev_b32_e32 v81, 4, v82
	v_and_b32_e32 v156, 0x7070707, v91
	v_lshlrev_b32_e32 v157, 4, v91
	v_and_b32_e32 v88, 0x7070707, v88
	v_and_or_b32 v147, v91, s7, v148
	v_and_b32_e32 v91, 0x7070707, v86
	v_perm_b32 v158, v164, v165, v93
	v_and_b32_e32 v93, 0x7070707, v82
	v_and_b32_e32 v95, 0x7070707, v95
	v_and_b32_e32 v81, 0x7070707, v81
	v_perm_b32 v85, v144, v146, v85
	v_add_u32_e32 v84, 0x7f7f7f7f, v84
	v_perm_b32 v88, v144, v146, v88
	v_lshlrev_b32_e32 v94, 4, v86
	v_lshlrev_b32_e32 v96, 4, v82
	v_perm_b32 v91, v142, v145, v91
	v_perm_b32 v95, v142, v145, v95
	v_perm_b32 v93, v141, v143, v93
	v_perm_b32 v81, v141, v143, v81
	v_and_or_b32 v92, v92, s7, v85
	v_add_u32_e32 v85, 0x7f7f7f7f, v85
	v_or_b32_e32 v84, 0x7f7f7f7f, v84
	v_and_or_b32 v90, v90, s7, v88
	v_add_u32_e32 v88, 0x7f7f7f7f, v88
	v_and_or_b32 v94, v94, s7, v91
	v_add_u32_e32 v91, 0x7f7f7f7f, v91
	v_and_b32_e32 v84, v84, v89
	v_and_or_b32 v86, v86, s7, v95
	v_add_u32_e32 v89, 0x7f7f7f7f, v95
	v_and_or_b32 v95, v96, s7, v93
	v_add_u32_e32 v93, 0x7f7f7f7f, v93
	v_or_b32_e32 v85, 0x7f7f7f7f, v85
	v_and_or_b32 v82, v82, s7, v81
	v_add_u32_e32 v81, 0x7f7f7f7f, v81
	v_and_b32_e32 v85, v85, v92
	v_or_b32_e32 v88, 0x7f7f7f7f, v88
	v_or_b32_e32 v91, 0x7f7f7f7f, v91
	v_or_b32_e32 v89, 0x7f7f7f7f, v89
	v_or_b32_e32 v92, 0x7f7f7f7f, v93
	v_or_b32_e32 v81, 0x7f7f7f7f, v81
	v_and_b32_e32 v88, v88, v90
	v_and_b32_e32 v90, v91, v94
	v_and_b32_e32 v86, v89, v86
	v_and_b32_e32 v89, v92, v95
	v_and_b32_e32 v81, v81, v82
	v_perm_b32 v118, v84, v80, s16
	v_perm_b32 v119, v84, v80, s17
	v_perm_b32 v116, v88, v85, s16
	v_perm_b32 v117, v88, v85, s17
	v_perm_b32 v84, v86, v90, s16
	v_perm_b32 v85, v86, v90, s17
	v_perm_b32 v80, v81, v89, s16
	v_perm_b32 v81, v81, v89, s17
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[152:153], v[116:117], v[68:71]
	v_perm_b32 v82, v144, v146, v156
	v_lshlrev_b32_e32 v86, 4, v87
	v_lshlrev_b32_e32 v146, 4, v83
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[150:151], v[80:81], v[76:79]
	s_waitcnt vmcnt(3)
	v_lshrrev_b32_e32 v156, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[150:151], v[84:85], v[44:47]
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[152:153], v[80:81], v[72:75]
	s_nop 2
	ds_read2st64_b64 v[72:75], v107 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[150:151], v[116:117], v[60:63]
	s_nop 2
	ds_read2st64_b64 v[60:63], v109 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[92:95], v[150:151], v[118:119], v[56:59]
	v_sub_u32_sdwa v151, v125, v140 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cmp_lt_i32_e32 vcc, 11, v151
	s_nop 0
	v_lshrrev_b32_e32 v56, 4, v87
	v_and_b32_e32 v56, 0x7070707, v56
	v_and_b32_e32 v57, 0x7070707, v87
	v_perm_b32 v144, v142, v145, v56
	v_lshrrev_b32_e32 v56, 4, v83
	v_perm_b32 v142, v142, v145, v57
	v_and_b32_e32 v57, 0x7070707, v83
	v_and_b32_e32 v56, 0x7070707, v56
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[152:153], v[84:85], v[40:43]
	v_perm_b32 v145, v141, v143, v56
	v_perm_b32 v143, v141, v143, v57
	v_add_u32_e32 v141, 0x7f7f7f7f, v148
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[152:153], v[118:119], v[64:67]
	v_sub_u32_sdwa v153, v123, v138 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_3
	v_and_or_b32 v138, v157, s7, v82
	v_add_u32_e32 v82, 0x7f7f7f7f, v82
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[72:73], v[118:119], v[48:51]
	v_and_or_b32 v150, v83, s7, v145
	v_and_or_b32 v83, v149, s7, v158
	v_or_b32_e32 v82, 0x7f7f7f7f, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[74:75], v[118:119], v[52:55]
	v_add_u32_e32 v118, 0x7f7f7f7f, v158
	v_or_b32_e32 v118, 0x7f7f7f7f, v118
	v_and_or_b32 v87, v87, s7, v144
	ds_read2st64_b64 v[52:55], v109 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[72:73], v[116:117], v[36:39]
	v_sub_u32_sdwa v152, v126, v139 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_and_b32_e32 v139, v118, v83
	v_add_u32_e32 v83, 0x7f7f7f7f, v154
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[72:73], v[84:85], v[28:31]
	v_and_b32_e32 v138, v82, v138
	v_and_or_b32 v86, v86, s7, v142
	v_add_u32_e32 v142, 0x7f7f7f7f, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[72:73], v[80:81], v[16:19]
	v_or_b32_e32 v72, 0x7f7f7f7f, v141
	v_add_u32_e32 v144, 0x7f7f7f7f, v144
	v_and_b32_e32 v72, v72, v147
	v_or_b32_e32 v83, 0x7f7f7f7f, v83
	v_or_b32_e32 v141, 0x7f7f7f7f, v142
	v_or_b32_e32 v142, 0x7f7f7f7f, v144
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[74:75], v[80:81], v[20:23]
	v_perm_b32 v80, v72, v138, s16
	v_perm_b32 v81, v72, v138, s17
	v_and_b32_e32 v140, v83, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[116:119], v[74:75], v[116:117], v[32:35]
	v_and_b32_e32 v86, v141, v86
	v_and_b32_e32 v87, v142, v87
	v_perm_b32 v138, v140, v139, s16
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[74:75], v[84:85], v[24:27]
	v_perm_b32 v139, v140, v139, s17
	v_perm_b32 v140, v87, v86, s16
	v_perm_b32 v141, v87, v86, s17
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[62:63], v[80:81], v[96:99]
	v_min_i32_e32 v142, 11, v153
	v_cmp_lt_i32_e64 s[0:1], 11, v152
	v_and_b32_e32 v147, 0x7070707, v8
	v_add_u32_e32 v97, 0x7f7f7f7f, v143
	v_add_u32_e32 v98, 0x7f7f7f7f, v145
	v_and_or_b32 v96, v146, s7, v143
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[60:61], v[80:81], v[88:91]
	v_min_i32_e32 v146, 11, v137
	v_cmp_lt_i32_e64 s[2:3], 11, v153
	v_lshlrev_b32_e32 v148, 4, v8
	v_or_b32_e32 v90, 0x7f7f7f7f, v97
	v_or_b32_e32 v91, 0x7f7f7f7f, v98
	v_and_b32_e32 v96, v90, v96
	v_and_b32_e32 v91, v91, v150
	v_perm_b32 v90, v91, v96, s16
	v_perm_b32 v91, v91, v96, s17
	v_mfma_f32_16x16x32_fp8_fp8 v[92:95], v[60:61], v[138:139], v[92:95]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v149, 0x7070707, v12
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v153, 0x7070707, v0
	ds_read2st64_b64 v[32:35], v111 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[60:61], v[140:141], v[76:79]
	v_lshlrev_b32_e32 v150, 4, v12
	v_lshlrev_b32_e32 v154, 4, v0
	ds_read2st64_b64 v[24:27], v111 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[60:61], v[90:91], v[68:71]
	v_min_i32_e32 v60, 11, v151
	v_min_i32_e32 v61, 11, v152
	v_mul_lo_u32 v137, v60, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[62:63], v[138:139], v[64:67]
	v_mul_lo_u32 v152, v142, s6
	v_lshrrev_b32_e32 v151, 4, v12
	v_and_b32_e32 v157, 0x7070707, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[62:63], v[140:141], v[40:43]
	v_lshlrev_b32_e32 v155, 4, v9
	v_lshlrev_b32_e32 v158, 4, v13
	ds_read2st64_b64 v[96:99], v113 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[62:63], v[90:91], v[44:47]
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[52:53], v[138:139], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[54:55], v[138:139], v[56:59]
	v_mul_lo_u32 v139, v61, s6
	v_lshrrev_b32_e32 v138, 4, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[52:53], v[80:81], v[36:39]
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[54:55], v[80:81], v[116:119]
	s_nop 2
	v_lshrrev_b32_e32 v116, 4, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[52:53], v[140:141], v[28:31]
	s_nop 2
	v_mul_lo_u32 v28, v146, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[52:53], v[90:91], v[16:19]
	v_sub_u32_e32 v52, 0x6c686080, v137
	v_sub_u32_e32 v53, 0x7c787470, v137
	v_and_b32_e32 v146, 0x7070707, v116
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[54:55], v[140:141], v[82:85]
	v_sub_u32_e32 v116, 0x6c686080, v28
	v_and_b32_e32 v52, 0xffffff00, v52
	v_sub_u32_e32 v28, 0x7c787470, v28
	v_sub_u32_e32 v84, 0x7c787470, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[54:55], v[90:91], v[20:23]
	v_and_b32_e32 v54, 0x7070707, v138
	v_sub_u32_e32 v55, 0x6c686080, v139
	v_sub_u32_e32 v90, 0x6c686080, v152
	v_cndmask_b32_e64 v137, v53, 0, vcc
	v_cndmask_b32_e64 v138, v84, 0, s[0:1]
	v_and_b32_e32 v84, 0xffffff00, v116
	v_cndmask_b32_e64 v140, v52, 0, vcc
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v29, 0x7070707, v4
	v_sub_u32_e32 v91, 0x7c787470, v152
	v_and_b32_e32 v53, 0xffffff00, v55
	v_and_b32_e32 v55, 0xffffff00, v90
	v_cndmask_b32_e64 v116, v28, 0, s[4:5]
	v_cndmask_b32_e64 v118, v84, 0, s[4:5]
	v_perm_b32 v28, v137, v140, v147
	v_cndmask_b32_e64 v117, v91, 0, s[2:3]
	v_cndmask_b32_e64 v139, v53, 0, s[0:1]
	v_cndmask_b32_e64 v119, v55, 0, s[2:3]
	v_perm_b32 v90, v116, v118, v29
	v_and_or_b32 v29, v148, s7, v28
	v_add_u32_e32 v28, 0x7f7f7f7f, v28
	v_and_b32_e32 v85, 0x7070707, v151
	v_perm_b32 v52, v137, v140, v54
	v_perm_b32 v53, v138, v139, v149
	v_perm_b32 v55, v117, v119, v153
	v_perm_b32 v84, v117, v119, v146
	v_or_b32_e32 v28, 0x7f7f7f7f, v28
	v_perm_b32 v54, v138, v139, v85
	v_and_or_b32 v8, v8, s7, v52
	v_add_u32_e32 v52, 0x7f7f7f7f, v52
	v_and_or_b32 v85, v150, s7, v53
	v_add_u32_e32 v53, 0x7f7f7f7f, v53
	v_and_or_b32 v91, v154, s7, v55
	v_add_u32_e32 v55, 0x7f7f7f7f, v55
	v_and_b32_e32 v29, v28, v29
	v_add_u32_e32 v28, 0x7f7f7f7f, v84
	v_and_or_b32 v12, v12, s7, v54
	v_add_u32_e32 v54, 0x7f7f7f7f, v54
	v_and_or_b32 v0, v0, s7, v84
	v_or_b32_e32 v84, 0x7f7f7f7f, v52
	v_or_b32_e32 v52, 0x7f7f7f7f, v53
	v_or_b32_e32 v53, 0x7f7f7f7f, v55
	v_or_b32_e32 v28, 0x7f7f7f7f, v28
	v_lshrrev_b32_e32 v31, 4, v4
	v_or_b32_e32 v54, 0x7f7f7f7f, v54
	v_and_b32_e32 v53, v53, v91
	v_and_b32_e32 v0, v28, v0
	v_and_b32_e32 v31, 0x7070707, v31
	v_and_b32_e32 v55, v52, v85
	v_perm_b32 v52, v0, v53, s16
	v_perm_b32 v53, v0, v53, s17
	v_and_b32_e32 v0, v54, v12
	v_perm_b32 v31, v116, v118, v31
	v_perm_b32 v54, v0, v55, s16
	v_perm_b32 v55, v0, v55, s17
	v_and_b32_e32 v0, v84, v8
	v_lshlrev_b32_e32 v30, 4, v4
	v_perm_b32 v28, v0, v29, s16
	v_perm_b32 v29, v0, v29, s17
	v_add_u32_e32 v0, 0x7f7f7f7f, v90
	v_add_u32_e32 v8, 0x7f7f7f7f, v31
	v_and_or_b32 v30, v30, s7, v90
	v_and_or_b32 v4, v4, s7, v31
	v_or_b32_e32 v0, 0x7f7f7f7f, v0
	v_or_b32_e32 v8, 0x7f7f7f7f, v8
	v_and_b32_e32 v0, v0, v30
	v_and_b32_e32 v4, v8, v4
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[32:33], v[52:53], v[76:79]
	v_and_b32_e32 v141, 0x7070707, v9
	v_lshrrev_b32_e32 v31, 4, v5
	v_lshrrev_b32_e32 v12, 4, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[32:33], v[54:55], v[86:89]
	v_and_b32_e32 v30, 0x7070707, v5
	v_and_b32_e32 v31, 0x7070707, v31
	v_and_b32_e32 v12, 0x7070707, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[34:35], v[28:29], v[64:67]
	v_lshlrev_b32_e32 v8, 4, v1
	v_perm_b32 v12, v117, v119, v12
	s_nop 0
	v_perm_b32 v64, v4, v0, s16
	v_perm_b32 v65, v4, v0, s17
	v_lshrrev_b32_e32 v0, 4, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[34:35], v[52:53], v[40:43]
	v_and_b32_e32 v0, 0x7070707, v0
	v_perm_b32 v0, v138, v139, v0
	v_and_b32_e32 v4, 0x7070707, v1
	v_and_b32_e32 v40, 0x7070707, v156
	v_perm_b32 v41, v137, v140, v141
	v_perm_b32 v40, v137, v140, v40
	v_perm_b32 v42, v138, v139, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[34:35], v[54:55], v[72:75]
	v_perm_b32 v67, v116, v118, v30
	v_and_or_b32 v9, v9, s7, v40
	v_and_or_b32 v141, v158, s7, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[92:95], v[32:33], v[28:29], v[92:95]
	v_perm_b32 v72, v116, v118, v31
	v_and_or_b32 v73, v155, s7, v41
	v_add_u32_e32 v74, 0x7f7f7f7f, v41
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[32:33], v[64:65], v[68:71]
	v_add_u32_e32 v75, 0x7f7f7f7f, v40
	v_and_or_b32 v13, v13, s7, v0
	v_add_u32_e32 v0, 0x7f7f7f7f, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[34:35], v[64:65], v[44:47]
	v_lshlrev_b32_e32 v66, 4, v5
	v_perm_b32 v4, v117, v119, v4
	v_or_b32_e32 v0, 0x7f7f7f7f, v0
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[154:157], v[24:25], v[28:29], v[48:51]
	v_and_or_b32 v8, v8, s7, v4
	v_and_or_b32 v1, v1, s7, v12
	v_and_b32_e32 v0, v0, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[26:27], v[28:29], v[56:59]
	s_nop 2
	v_add_u32_e32 v56, 0x7f7f7f7f, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[24:25], v[54:55], v[36:39]
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[26:27], v[54:55], v[60:63]
	s_nop 1
	v_add_u32_e32 v36, 0x7f7f7f7f, v4
	v_add_u32_e32 v37, 0x7f7f7f7f, v12
	v_or_b32_e32 v4, 0x7f7f7f7f, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[24:25], v[52:53], v[142:145]
	v_or_b32_e32 v12, 0x7f7f7f7f, v75
	v_add_u32_e32 v39, 0x7f7f7f7f, v67
	v_and_or_b32 v38, v66, s7, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[26:27], v[52:53], v[80:83]
	v_and_or_b32 v142, v5, s7, v72
	v_or_b32_e32 v5, 0x7f7f7f7f, v56
	v_and_b32_e32 v5, v5, v141
	ds_read2st64_b64 v[80:83], v113 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[24:25], v[64:65], v[16:19]
	v_add_u32_e32 v143, 0x7f7f7f7f, v72
	v_lshrrev_b32_e32 v141, 4, v2
	s_nop 0
	v_and_b32_e32 v16, v4, v73
	v_perm_b32 v4, v0, v5, s16
	v_perm_b32 v5, v0, v5, s17
	v_and_b32_e32 v0, v12, v9
	v_perm_b32 v12, v0, v16, s16
	v_perm_b32 v13, v0, v16, s17
	v_or_b32_e32 v0, 0x7f7f7f7f, v36
	v_or_b32_e32 v9, 0x7f7f7f7f, v37
	v_and_b32_e32 v0, v0, v8
	v_and_b32_e32 v1, v9, v1
	v_perm_b32 v8, v1, v0, s16
	v_perm_b32 v9, v1, v0, s17
	v_or_b32_e32 v0, 0x7f7f7f7f, v39
	v_or_b32_e32 v1, 0x7f7f7f7f, v143
	v_and_b32_e32 v16, v0, v38
	v_and_b32_e32 v1, v1, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[26:27], v[64:65], v[20:23]
	v_perm_b32 v0, v1, v16, s16
	v_perm_b32 v1, v1, v16, s17
	v_and_b32_e32 v142, 0x7070707, v6
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[96:97], v[4:5], v[76:79]
	ds_read2st64_b64 v[36:39], v115 offset1:8
	ds_read2st64_b64 v[24:27], v115 offset0:16 offset1:24
	v_lshlrev_b32_e32 v143, 4, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[98:99], v[12:13], v[84:87]
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[98:99], v[4:5], v[88:91]
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[96:97], v[8:9], v[146:149]
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[96:97], v[12:13], v[92:95]
	v_mfma_f32_16x16x32_fp8_fp8 v[92:95], v[96:97], v[0:1], v[68:71]
	v_lshrrev_b32_e32 v96, 4, v10
	v_and_b32_e32 v97, 0x7070707, v14
	v_perm_b32 v97, v138, v139, v97
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[80:81], v[4:5], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[82:83], v[4:5], v[44:47]
	v_lshrrev_b32_e32 v4, 4, v14
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v4, v138, v139, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[98:99], v[8:9], v[150:153]
	v_and_b32_e32 v5, 0x7070707, v2
	v_perm_b32 v5, v117, v119, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[98:99], v[0:1], v[32:35]
	v_lshlrev_b32_e32 v98, 4, v14
	v_lshlrev_b32_e32 v99, 4, v2
	v_and_b32_e32 v151, 0x7070707, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[80:81], v[12:13], v[154:157]
	v_lshlrev_b32_e32 v150, 4, v3
	v_lshlrev_b32_e32 v152, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[82:83], v[12:13], v[28:31]
	v_and_b32_e32 v12, 0x7070707, v10
	v_lshlrev_b32_e32 v13, 4, v10
	v_perm_b32 v12, v137, v140, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[80:81], v[8:9], v[48:51]
	v_and_or_b32 v13, v13, s7, v12
	v_add_u32_e32 v12, 0x7f7f7f7f, v12
	v_or_b32_e32 v12, 0x7f7f7f7f, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[82:83], v[8:9], v[52:55]
	v_and_b32_e32 v9, 0x7070707, v96
	v_perm_b32 v9, v137, v140, v9
	v_lshrrev_b32_e32 v8, 4, v6
	v_and_b32_e32 v96, 0x7070707, v141
	v_and_or_b32 v10, v10, s7, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[80:81], v[0:1], v[56:59]
	v_add_u32_e32 v9, 0x7f7f7f7f, v9
	v_add_u32_e32 v81, 0x7f7f7f7f, v97
	v_and_b32_e32 v8, 0x7070707, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[82:83], v[0:1], v[64:67]
	v_add_u32_e32 v1, 0x7f7f7f7f, v4
	v_perm_b32 v96, v117, v119, v96
	v_and_or_b32 v80, v98, s7, v97
	v_and_or_b32 v0, v14, s7, v4
	v_or_b32_e32 v9, 0x7f7f7f7f, v9
	v_or_b32_e32 v81, 0x7f7f7f7f, v81
	v_or_b32_e32 v1, 0x7f7f7f7f, v1
	v_perm_b32 v141, v116, v118, v142
	v_perm_b32 v8, v116, v118, v8
	v_and_or_b32 v4, v99, s7, v5
	v_add_u32_e32 v5, 0x7f7f7f7f, v5
	v_add_u32_e32 v14, 0x7f7f7f7f, v96
	v_and_b32_e32 v13, v12, v13
	v_and_b32_e32 v12, v81, v80
	v_and_b32_e32 v1, v1, v0
	v_and_b32_e32 v9, v9, v10
	v_and_or_b32 v2, v2, s7, v96
	v_add_u32_e32 v97, 0x7f7f7f7f, v141
	v_and_or_b32 v6, v6, s7, v8
	v_add_u32_e32 v8, 0x7f7f7f7f, v8
	v_perm_b32 v0, v1, v12, s16
	v_perm_b32 v1, v1, v12, s17
	v_perm_b32 v12, v9, v13, s16
	v_perm_b32 v13, v9, v13, s17
	v_or_b32_e32 v5, 0x7f7f7f7f, v5
	v_or_b32_e32 v9, 0x7f7f7f7f, v14
	v_and_or_b32 v96, v143, s7, v141
	v_or_b32_e32 v10, 0x7f7f7f7f, v97
	v_or_b32_e32 v14, 0x7f7f7f7f, v8
	v_and_b32_e32 v4, v5, v4
	v_and_b32_e32 v2, v9, v2
	v_and_b32_e32 v5, v10, v96
	v_perm_b32 v8, v2, v4, s16
	v_perm_b32 v9, v2, v4, s17
	v_and_b32_e32 v2, v14, v6
	v_perm_b32 v4, v2, v5, s16
	v_perm_b32 v5, v2, v5, s17
	v_lshrrev_b32_e32 v2, 4, v11
	ds_read2st64_b64 v[28:31], v136 offset1:8
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[38:39], v[12:13], v[76:79]
	v_and_b32_e32 v6, 0x7070707, v11
	v_lshrrev_b32_e32 v10, 4, v15
	v_and_b32_e32 v2, 0x7070707, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[36:37], v[4:5], v[92:95]
	v_and_b32_e32 v10, 0x7070707, v10
	v_perm_b32 v2, v137, v140, v2
	v_perm_b32 v6, v137, v140, v6
	ds_read2st64_b64 v[92:95], v136 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[38:39], v[8:9], v[68:71]
	v_lshlrev_b32_e32 v14, 4, v11
	v_lshrrev_b32_e32 v141, 4, v7
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v68, 0x7070707, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[36:37], v[0:1], v[72:75]
	v_lshlrev_b32_e32 v69, 4, v15
	v_lshrrev_b32_e32 v71, 4, v3
	v_and_b32_e32 v70, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[84:87], v[38:39], v[0:1], v[84:87]
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[88:91], v[36:37], v[12:13], v[88:91]
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[36:37], v[8:9], v[60:63]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[38:39], v[4:5], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[24:25], v[12:13], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[26:27], v[12:13], v[32:35]
	s_nop 2
	v_perm_b32 v34, v138, v139, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[24:25], v[0:1], v[40:43]
	v_perm_b32 v35, v138, v139, v68
	v_and_or_b32 v68, v11, s7, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[26:27], v[0:1], v[44:47]
	v_add_u32_e32 v1, 0x7f7f7f7f, v6
	v_and_or_b32 v15, v15, s7, v34
	v_and_or_b32 v0, v14, s7, v6
	v_add_u32_e32 v14, 0x7f7f7f7f, v35
	v_add_u32_e32 v34, 0x7f7f7f7f, v34
	v_or_b32_e32 v1, 0x7f7f7f7f, v1
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v33, 0x7070707, v141
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[24:25], v[8:9], v[48:51]
	v_and_or_b32 v6, v69, s7, v35
	v_and_b32_e32 v1, v1, v0
	v_and_b32_e32 v2, v2, v68
	v_mfma_f32_16x16x32_fp8_fp8 v[138:141], v[26:27], v[8:9], v[52:55]
	v_or_b32_e32 v8, 0x7f7f7f7f, v14
	v_or_b32_e32 v9, 0x7f7f7f7f, v34
	v_and_b32_e32 v32, 0x7070707, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[24:25], v[4:5], v[56:59]
	v_perm_b32 v0, v2, v1, s16
	v_perm_b32 v1, v2, v1, s17
	v_and_b32_e32 v2, v9, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[26:27], v[4:5], v[64:67]
	v_and_b32_e32 v5, v8, v6
	v_perm_b32 v4, v2, v5, s16
	v_perm_b32 v5, v2, v5, s17
	v_perm_b32 v2, v117, v119, v70
	v_perm_b32 v6, v117, v119, v32
	v_perm_b32 v8, v116, v118, v33
	v_perm_b32 v9, v116, v118, v151
	v_and_or_b32 v3, v3, s7, v6
	v_and_or_b32 v7, v7, s7, v8
	v_and_or_b32 v14, v150, s7, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_and_or_b32 v15, v152, s7, v9
	v_add_u32_e32 v9, 0x7f7f7f7f, v9
	v_add_u32_e32 v8, 0x7f7f7f7f, v8
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v9, 0x7f7f7f7f, v9
	v_or_b32_e32 v8, 0x7f7f7f7f, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[28:29], v[0:1], v[88:91]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[28:29], v[4:5], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[30:31], v[0:1], v[80:83]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[30:31], v[4:5], v[84:87]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[92:93], v[0:1], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[92:93], v[4:5], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[94:95], v[0:1], v[20:23]
	v_and_b32_e32 v1, v2, v14
	v_and_b32_e32 v2, v6, v3
	v_and_b32_e32 v3, v9, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[94:95], v[4:5], v[10:13]
	v_and_b32_e32 v4, v8, v7
	v_perm_b32 v0, v2, v1, s16
	v_perm_b32 v1, v2, v1, s17
	v_perm_b32 v2, v4, v3, s16
	v_perm_b32 v3, v4, v3, s17
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[28:29], v[0:1], v[60:63]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[28:29], v[2:3], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[30:31], v[0:1], v[96:99]
	v_mfma_f32_16x16x32_fp8_fp8 v[60:63], v[30:31], v[2:3], v[36:39]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[92:93], v[0:1], v[44:47]
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[92:93], v[2:3], v[142:145]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[94:95], v[0:1], v[138:141]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[94:95], v[2:3], v[146:149]
	s_cbranch_scc1 .LBB0_2
	v_lshl_or_b32 v8, v122, 2, s31
	v_ashrrev_i32_e32 v9, 31, v8
	v_lshl_add_u64 v[0:1], v[8:9], 2, s[18:19]
	global_load_dword v2, v[0:1], off
	s_mov_b32 s3, 0x27000
	s_lshl_b32 s6, s28, 2
	s_and_b32 s5, s23, 0xffff
	s_mov_b32 s4, s22
	s_mov_b32 s7, s3
	v_mov_b32_e32 v7, 0xfd800000
	v_add_u32_e32 v3, 17, v126
	v_lshl_add_u32 v11, v125, 23, v7
	v_cmp_lt_i32_e32 vcc, 5, v125
	v_add_u32_e32 v4, 17, v123
	v_mov_b32_e32 v13, v64
	v_lshl_add_u32 v9, v126, 23, v7
	v_lshlrev_b32_e64 v64, v3, 1
	v_add_u32_e32 v5, 17, v124
	v_mov_b32_e32 v15, v68
	v_lshl_add_u32 v68, v124, 23, v7
	v_lshl_add_u32 v7, v123, 23, v7
	v_lshlrev_b32_e64 v4, v4, 1
	v_mov_b32_e32 v12, v72
	v_lshlrev_b32_e64 v72, v5, 1
	v_mov_b32_e32 v14, v76
	s_mov_b32 s8, 0xbfb8aa3b
	s_movk_i32 s9, 0x7fff
	v_bfrev_b32_e32 v6, -2
	s_lshl_b32 s2, s29, 9
	s_and_b32 s1, s21, 0xffff
	s_mov_b32 s0, s20
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v82, 0xffffff, v2
	v_lshlrev_b32_e32 v2, 2, v82
	buffer_load_dword v10, v2, s[4:7], 0 offen
	v_add_u32_e32 v2, 17, v125
	v_lshlrev_b32_e64 v2, v2, 1
	v_cndmask_b32_e32 v3, v2, v11, vcc
	v_cmp_lt_i32_e32 vcc, 5, v126
	s_nop 1
	v_cndmask_b32_e32 v2, v64, v9, vcc
	v_cmp_lt_i32_e32 vcc, 5, v123
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[80:81], v[10:11], v[2:3] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v5, v4, v7, vcc
	v_cmp_lt_i32_e32 vcc, 5, v124
	v_pk_mul_f32 v[12:13], v[12:13], v[80:81]
	v_lshlrev_b32_e32 v7, 8, v8
	v_cndmask_b32_e32 v4, v72, v68, vcc
	v_pk_mul_f32 v[10:11], v[10:11], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[14:15], v[10:11]
	v_mov_b32_e32 v14, v13
	v_mov_b32_e32 v15, v11
	v_pk_mul_f32 v[14:15], v[14:15], s[8:9] op_sel_hi:[1,0]
	v_add_lshl_u32 v64, v7, v120, 1
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_add_lshl_u32 v68, v7, v121, 1
	v_cmp_gt_i32_e32 vcc, s28, v82
	v_pk_add_f32 v[8:9], v[14:15], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v14, v6, v64, vcc
	v_rcp_f32_e32 v8, v8
	v_rcp_f32_e32 v9, v9
	v_cndmask_b32_e32 v15, v6, v68, vcc
	v_mov_b32_e32 v64, v73
	v_mul_f32_e32 v8, v13, v8
	v_mul_f32_e32 v9, v11, v9
	v_mul_f32_e32 v8, v12, v8
	v_mul_f32_e32 v9, v10, v9
	v_bfe_u32 v10, v8, 16, 1
	v_or_b32_e32 v11, 0x400000, v8
	v_bfe_u32 v12, v9, 16, 1
	v_add3_u32 v10, v10, v8, s9
	v_cmp_u_f32_e32 vcc, v8, v8
	v_or_b32_e32 v13, 0x400000, v9
	v_add3_u32 v12, v12, v9, s9
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_cmp_u_f32_e32 vcc, v9, v9
	v_lshrrev_b32_e32 v8, 16, v8
	v_mov_b32_e32 v68, v77
	v_cndmask_b32_e32 v9, v12, v13, vcc
	v_lshrrev_b32_e32 v9, 16, v9
	buffer_store_short v8, v14, s[0:3], 0 offen
	buffer_store_short v9, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:4
	v_or_b32_e32 v15, 0x100, v7
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[64:65], v[10:11]
	v_pk_mul_f32 v[8:9], v[68:69], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_add_lshl_u32 v64, v120, v15, 1
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v121, v15, 1
	v_cndmask_b32_e32 v14, v6, v64, vcc
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v74
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:8
	v_mov_b32_e32 v11, v66
	v_mov_b32_e32 v12, v78
	v_mov_b32_e32 v13, v70
	v_mov_b32_e32 v66, v75
	v_mov_b32_e32 v70, v79
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v64, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v64
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v64
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x200, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:12
	v_or_b32_e32 v15, 0x300, v7
	v_add_lshl_u32 v64, v120, v15, 1
	v_add_lshl_u32 v15, v121, v15, 1
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[66:67], v[10:11]
	v_pk_mul_f32 v[8:9], v[70:71], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v64, vcc
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v56
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:64
	v_mov_b32_e32 v11, v48
	v_mov_b32_e32 v12, v60
	v_mov_b32_e32 v13, v52
	v_mov_b32_e32 v48, v57
	v_mov_b32_e32 v52, v61
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v64, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v64
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v64
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x1000, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:68
	v_or_b32_e32 v15, 0x1100, v7
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[48:49], v[10:11]
	v_pk_mul_f32 v[8:9], v[52:53], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_add_lshl_u32 v48, v120, v15, 1
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v121, v15, 1
	v_cndmask_b32_e32 v14, v6, v48, vcc
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v58
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:72
	v_mov_b32_e32 v11, v50
	v_mov_b32_e32 v12, v62
	v_mov_b32_e32 v13, v54
	v_mov_b32_e32 v50, v59
	v_mov_b32_e32 v54, v63
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v48, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v48
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v48
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x1200, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:76
	v_or_b32_e32 v15, 0x1300, v7
	v_add_lshl_u32 v48, v120, v15, 1
	v_add_lshl_u32 v15, v121, v15, 1
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[50:51], v[10:11]
	v_pk_mul_f32 v[8:9], v[54:55], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v48, vcc
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v40
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:128
	v_mov_b32_e32 v11, v32
	v_mov_b32_e32 v12, v44
	v_mov_b32_e32 v13, v36
	v_mov_b32_e32 v32, v41
	v_mov_b32_e32 v36, v45
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v48, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v48
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v48
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x2000, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:132
	v_or_b32_e32 v15, 0x2100, v7
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[32:33], v[10:11]
	v_pk_mul_f32 v[8:9], v[36:37], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_add_lshl_u32 v32, v120, v15, 1
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v121, v15, 1
	v_cndmask_b32_e32 v14, v6, v32, vcc
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v42
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:136
	v_mov_b32_e32 v11, v34
	v_mov_b32_e32 v12, v46
	v_mov_b32_e32 v13, v38
	v_mov_b32_e32 v34, v43
	v_mov_b32_e32 v38, v47
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v32, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v32
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v32
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x2200, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:140
	v_or_b32_e32 v15, 0x2300, v7
	v_add_lshl_u32 v32, v120, v15, 1
	v_add_lshl_u32 v15, v121, v15, 1
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[34:35], v[10:11]
	v_pk_mul_f32 v[8:9], v[38:39], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v32, vcc
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v24
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:192
	v_mov_b32_e32 v11, v16
	v_mov_b32_e32 v12, v28
	v_mov_b32_e32 v13, v20
	v_mov_b32_e32 v16, v25
	v_mov_b32_e32 v20, v29
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v32, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v32
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v32
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x3000, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:196
	v_or_b32_e32 v15, 0x3100, v7
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v14, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v14
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v14
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[10:11], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[16:17], v[10:11]
	v_pk_mul_f32 v[8:9], v[20:21], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_add_lshl_u32 v16, v120, v15, 1
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v121, v15, 1
	v_cndmask_b32_e32 v14, v6, v16, vcc
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	v_mov_b32_e32 v10, v26
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v14, s[0:3], 0 offen
	buffer_store_short v8, v15, s[0:3], 0 offen
	global_load_dword v8, v[0:1], off offset:200
	v_mov_b32_e32 v11, v18
	v_mov_b32_e32 v12, v30
	v_mov_b32_e32 v13, v22
	v_mov_b32_e32 v18, v27
	v_mov_b32_e32 v22, v31
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v16, 0xffffff, v8
	v_lshlrev_b32_e32 v8, 2, v16
	buffer_load_dword v8, v8, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v16
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[8:9], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_mov_b32_e32 v12, v11
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[8:9] op_sel_hi:[1,0]
	v_or_b32_e32 v14, 0x3200, v7
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_lshl_u32 v15, v120, v14, 1
	v_add_lshl_u32 v14, v121, v14, 1
	v_cndmask_b32_e32 v15, v6, v15, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v14, v6, v14, vcc
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_or_b32_e32 v7, 0x3300, v7
	v_mul_f32_e32 v11, v11, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v10, v10, v11
	v_mul_f32_e32 v8, v8, v9
	v_bfe_u32 v9, v10, 16, 1
	v_or_b32_e32 v11, 0x400000, v10
	v_bfe_u32 v12, v8, 16, 1
	v_add3_u32 v9, v9, v10, s9
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v13, 0x400000, v8
	v_add3_u32 v12, v12, v8, s9
	v_cndmask_b32_e32 v9, v9, v11, vcc
	v_cmp_u_f32_e32 vcc, v8, v8
	v_lshrrev_b32_e32 v9, 16, v9
	s_nop 0
	v_cndmask_b32_e32 v8, v12, v13, vcc
	v_lshrrev_b32_e32 v8, 16, v8
	buffer_store_short v9, v15, s[0:3], 0 offen
	buffer_store_short v8, v14, s[0:3], 0 offen
	global_load_dword v0, v[0:1], off offset:204
	v_add_lshl_u32 v9, v120, v7, 1
	v_add_lshl_u32 v7, v121, v7, 1
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v8, 0xffffff, v0
	v_lshlrev_b32_e32 v0, 2, v8
	buffer_load_dword v0, v0, s[4:7], 0 offen
	v_cmp_gt_i32_e32 vcc, s28, v8
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[2:3], v[0:1], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[0:1], v[0:1], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[18:19], v[2:3]
	v_pk_mul_f32 v[0:1], v[22:23], v[0:1]
	v_mov_b32_e32 v4, v3
	v_mov_b32_e32 v5, v1
	v_pk_mul_f32 v[4:5], v[4:5], s[8:9] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v8, v6, v9, vcc
	v_exp_f32_e32 v4, v4
	v_exp_f32_e32 v5, v5
	v_cndmask_b32_e32 v6, v6, v7, vcc
	v_pk_add_f32 v[4:5], v[4:5], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v4, v4
	v_rcp_f32_e32 v5, v5
	v_mul_f32_e32 v3, v3, v4
	v_mul_f32_e32 v1, v1, v5
	v_mul_f32_e32 v2, v2, v3
	v_mul_f32_e32 v0, v0, v1
	v_bfe_u32 v1, v2, 16, 1
	v_or_b32_e32 v3, 0x400000, v2
	v_bfe_u32 v4, v0, 16, 1
	v_add3_u32 v1, v1, v2, s9
	v_cmp_u_f32_e32 vcc, v2, v2
	v_or_b32_e32 v5, 0x400000, v0
	v_add3_u32 v4, v4, v0, s9
	v_cndmask_b32_e32 v1, v1, v3, vcc
	v_cmp_u_f32_e32 vcc, v0, v0
	v_lshrrev_b32_e32 v1, 16, v1
	s_nop 0
	v_cndmask_b32_e32 v0, v4, v5, vcc
	v_lshrrev_b32_e32 v0, 16, v0
	buffer_store_short v1, v8, s[0:3], 0 offen
	buffer_store_short v0, v6, s[0:3], 0 offen
.LBB0_4:
	s_endpgm
.Lfunc_end0:
	.size	gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt, .Lfunc_end0-gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt
		.amdhsa_group_segment_fixed_size 16384
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 96
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
		.amdhsa_next_free_vgpr 166
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

	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.num_vgpr, 166
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.num_agpr, 0
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.numbered_sgpr, 34
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.num_named_barrier, 0
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.private_seg_size, 0
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.uses_vcc, 1
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.uses_flat_scratch, 0
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.has_dyn_sized_stack, 0
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.has_recursion, 0
	.set .Lgemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.has_indirect_call, 0
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
        .size:           4
        .value_kind:     by_value
      - .offset:         52
        .size:           4
        .value_kind:     by_value
      - .offset:         56
        .size:           4
        .value_kind:     by_value
      - .offset:         60
        .size:           4
        .value_kind:     by_value
      - .offset:         64
        .size:           4
        .value_kind:     by_value
      - .offset:         68
        .size:           4
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
    .group_segment_fixed_size: 16384
    .kernarg_segment_align: 8
    .kernarg_segment_size: 96
    .max_flat_workgroup_size: 256
    .name:           gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     40
    .sgpr_spill_count: 0
    .symbol:         gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_xcd1_asw_ftz_krt.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     166
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
