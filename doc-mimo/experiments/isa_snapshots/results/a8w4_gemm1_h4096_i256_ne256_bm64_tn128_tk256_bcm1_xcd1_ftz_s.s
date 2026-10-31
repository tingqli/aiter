	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s
	.p2align	8
	.type	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s,@function
a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s:
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	v_readfirstlane_b32 s33, v0
	s_waitcnt lgkmcnt(0)
	s_load_dword s16, s[16:17], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s3, s16, 31
	s_lshr_b32 s3, s3, 26
	s_add_i32 s3, s16, s3
	s_ashr_i32 s17, s3, 6
	s_andn2_b32 s3, s3, 63
	s_cmp_lg_u32 s16, s3
	s_cselect_b64 s[20:21], -1, 0
	s_cmp_lt_i32 s16, 0
	s_cselect_b64 s[22:23], -1, 0
	s_and_b64 s[20:21], s[22:23], s[20:21]
	s_subb_u32 s3, s17, 0
	s_lshl_b32 s20, s3, 1
	s_cmp_ge_i32 s2, s20
	s_mov_b32 s17, 0
	s_cbranch_scc1 .LBB0_4
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
	s_subb_u32 s20, s24, 0
	s_sub_i32 s21, s3, s20
	s_min_i32 s3, s21, 1
	s_abs_i32 s22, s3
	v_cvt_f32_u32_e32 v1, s22
	s_sub_i32 s23, s2, s25
	s_sub_i32 s25, 0, s22
	s_abs_i32 s24, s23
	v_rcp_f32_e32 v1, v1
	s_xor_b32 s2, s23, s3
	s_ashr_i32 s2, s2, 31
	s_mov_b32 s28, s4
	v_mul_f32_e32 v1, 0x4f7ffffe, v1
	v_cvt_u32_f32_e32 v1, v1
	v_bfe_u32 v109, v0, 4, 2
	v_mov_b32_e32 v64, 0
	v_mov_b32_e32 v65, v64
	v_readfirstlane_b32 s26, v1
	s_mul_i32 s25, s25, s26
	s_mul_hi_u32 s25, s26, s25
	s_add_i32 s26, s26, s25
	s_mul_hi_u32 s25, s24, s26
	s_mul_i32 s26, s25, s22
	s_sub_i32 s24, s24, s26
	s_add_i32 s26, s25, 1
	s_sub_i32 s27, s24, s22
	s_cmp_ge_u32 s24, s22
	s_cselect_b32 s25, s26, s25
	s_cselect_b32 s24, s27, s24
	s_add_i32 s26, s25, 1
	s_cmp_ge_u32 s24, s22
	s_cselect_b32 s22, s26, s25
	s_xor_b32 s22, s22, s2
	s_sub_i32 s22, s22, s2
	s_mul_i32 s2, s22, s3
	s_sub_i32 s3, s23, s2
	s_add_i32 s24, s3, s20
	s_cmp_lg_u32 s23, s2
	s_cselect_b64 s[2:3], -1, 0
	s_xor_b32 s20, s21, s23
	s_cmp_lt_i32 s20, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[2:3], s[20:21], s[2:3]
	s_lshl1_add_u32 s20, s24, s22
	s_cmp_lg_u64 s[2:3], 0
	s_subb_u32 s20, s20, 0
	s_lshr_b32 s2, s20, 31
	s_add_i32 s2, s20, s2
	s_ashr_i32 s22, s2, 1
	s_and_b32 s2, s2, -2
	s_sub_i32 s25, s20, s2
	s_cmp_lg_u32 s20, s2
	s_cselect_b64 s[2:3], -1, 0
	s_cmp_lt_i32 s20, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[2:3], s[20:21], s[2:3]
	s_subb_u32 s20, s22, 0
	s_ashr_i32 s21, s20, 31
	s_lshl_b64 s[2:3], s[20:21], 2
	s_add_u32 s2, s14, s2
	v_lshrrev_b32_e32 v1, 4, v0
	s_addc_u32 s3, s15, s3
	s_lshl_b32 s15, s20, 6
	v_or_b32_e32 v2, s15, v1
	s_load_dword s2, s[2:3], 0x0
	v_ashrrev_i32_e32 v3, 31, v2
	s_ashr_i32 s14, s15, 31
	v_lshl_add_u64 v[4:5], v[2:3], 2, s[18:19]
	v_mov_b32_e32 v3, s14
	s_lshr_b32 s3, s33, 1
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[18:19]
	s_lshl_b32 s4, s25, 7
	s_and_b32 s3, s3, 0x7fffffe0
	global_load_dword v6, v[4:5], off
	global_load_dword v7, v[2:3], off offset:64
	global_load_dword v8, v[2:3], off offset:128
	global_load_dword v9, v[2:3], off offset:192
	v_and_b32_e32 v5, 15, v0
	v_lshlrev_b32_e32 v2, 4, v0
	s_add_i32 s3, s4, s3
	v_and_b32_e32 v4, 48, v0
	v_xor_b32_e32 v0, v2, v0
	v_or_b32_e32 v104, s3, v5
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s2, 9
	v_and_b32_e32 v12, 0xf0, v0
	v_add_u32_e32 v0, s2, v104
	v_and_b32_e32 v10, 0xf0, v2
	v_lshlrev_b32_e32 v11, 8, v1
	v_ashrrev_i32_e32 v1, 31, v0
	v_add_u32_e32 v2, 0x100, v0
	v_lshl_add_u64 v[0:1], v[0:1], 2, s[12:13]
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	global_load_dword v107, v[0:1], off
	global_load_dword v105, v[0:1], off offset:64
	global_load_dword v108, v[2:3], off
	global_load_dword v106, v[2:3], off offset:64
	s_add_i32 s3, s3, s2
	s_mov_b32 s20, s8
	s_and_b32 s21, s9, 0xffff
	s_and_b32 s29, s5, 0xffff
	s_lshl_b32 s2, s3, 7
	s_lshl_b32 s4, s3, 5
	s_add_i32 s5, s3, 0x100
	s_or_b32 s8, s3, 16
	s_lshr_b32 s9, s3, 31
	s_addk_i32 s3, 0x110
	s_load_dword s14, s[0:1], 0x48
	s_mov_b32 s24, s10
	s_and_b32 s25, s11, 0xffff
	v_or3_b32 v110, s2, v4, v5
	v_or3_b32 v111, s4, v4, v5
	s_lshl_b32 s2, s5, 7
	s_lshl_b32 s4, s5, 5
	s_ashr_i32 s5, s8, 4
	s_ashr_i32 s10, s3, 4
	s_lshl_b32 s11, s3, 7
	s_lshr_b32 s3, s3, 31
	s_add_i32 s9, s5, s9
	s_add_i32 s3, s10, s3
	s_lshl_b32 s8, s8, 7
	v_or3_b32 v112, s4, v4, v5
	s_and_b32 s4, s9, -2
	s_and_b32 s3, s3, -2
	v_lshlrev_b32_e32 v0, 5, v109
	v_lshlrev_b32_e32 v2, 4, v5
	s_sub_i32 s4, s5, s4
	s_sub_i32 s3, s10, s3
	v_or3_b32 v117, s8, v4, v5
	v_or3_b32 v118, s2, v4, v5
	v_or3_b32 v119, s11, v4, v5
	v_lshlrev_b32_e32 v1, 8, v5
	v_xor_b32_e32 v3, v0, v2
	v_or_b32_e32 v4, 8, v0
	v_or_b32_e32 v5, 16, v0
	s_mov_b32 s23, 0x27000
	s_lshl_b32 s4, s4, 3
	s_lshl_b32 s8, s3, 3
	v_xor_b32_e32 v4, v4, v2
	v_xor_b32_e32 v5, v5, v2
	s_brev_b32 s22, 8
	s_mov_b32 s26, 0x1000000
	s_mov_b32 s27, s23
	s_mov_b32 s31, s23
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s30, s14, 12
	s_add_i32 s5, s4, 16
	s_add_i32 s9, s8, 16
	v_add_u32_e32 v120, v11, v10
	s_mov_b32 s10, 0x8080808
	s_mov_b32 s11, 0x5010400
	s_mov_b32 s12, 0x7030602
	v_add_u32_e32 v121, v1, v3
	v_add_u32_e32 v122, v1, v4
	v_add_u32_e32 v123, v1, v5
	v_mov_b32_e32 v66, v64
	v_mov_b32_e32 v67, v64
	s_waitcnt vmcnt(7)
	v_lshl_or_b32 v113, v6, 12, v12
	s_waitcnt vmcnt(6)
	v_lshl_or_b32 v114, v7, 12, v12
	s_waitcnt vmcnt(5)
	v_lshl_or_b32 v115, v8, 12, v12
	s_waitcnt vmcnt(4)
	v_lshl_or_b32 v116, v9, 12, v12
	v_or_b32_e32 v6, 24, v0
	v_or_b32_e32 v7, 0x80, v0
	v_or_b32_e32 v8, 0x88, v0
	v_or_b32_e32 v9, 0x90, v0
	v_or_b32_e32 v0, 0x98, v0
	v_xor_b32_e32 v6, v6, v2
	v_xor_b32_e32 v7, v7, v2
	v_xor_b32_e32 v8, v8, v2
	v_xor_b32_e32 v9, v9, v2
	v_xor_b32_e32 v0, v0, v2
	v_add_u32_e32 v124, v1, v6
	v_add_u32_e32 v125, v1, v7
	v_add_u32_e32 v126, v1, v8
	v_add_u32_e32 v127, v1, v9
	v_add_u32_e32 v128, v1, v0
	v_mov_b32_e32 v72, v64
	v_mov_b32_e32 v73, v64
	v_mov_b32_e32 v74, v64
	v_mov_b32_e32 v75, v64
	v_mov_b32_e32 v40, v64
	v_mov_b32_e32 v41, v64
	v_mov_b32_e32 v42, v64
	v_mov_b32_e32 v43, v64
	v_mov_b32_e32 v48, v64
	v_mov_b32_e32 v49, v64
	v_mov_b32_e32 v50, v64
	v_mov_b32_e32 v51, v64
	v_mov_b32_e32 v24, v64
	v_mov_b32_e32 v25, v64
	v_mov_b32_e32 v26, v64
	v_mov_b32_e32 v27, v64
	v_mov_b32_e32 v28, v64
	v_mov_b32_e32 v29, v64
	v_mov_b32_e32 v30, v64
	v_mov_b32_e32 v31, v64
	v_mov_b32_e32 v4, v64
	v_mov_b32_e32 v5, v64
	v_mov_b32_e32 v6, v64
	v_mov_b32_e32 v7, v64
	v_mov_b32_e32 v8, v64
	v_mov_b32_e32 v9, v64
	v_mov_b32_e32 v10, v64
	v_mov_b32_e32 v11, v64
	v_mov_b32_e32 v68, v64
	v_mov_b32_e32 v69, v64
	v_mov_b32_e32 v70, v64
	v_mov_b32_e32 v71, v64
	v_mov_b32_e32 v76, v64
	v_mov_b32_e32 v77, v64
	v_mov_b32_e32 v78, v64
	v_mov_b32_e32 v79, v64
	v_mov_b32_e32 v52, v64
	v_mov_b32_e32 v53, v64
	v_mov_b32_e32 v54, v64
	v_mov_b32_e32 v55, v64
	v_mov_b32_e32 v56, v64
	v_mov_b32_e32 v57, v64
	v_mov_b32_e32 v58, v64
	v_mov_b32_e32 v59, v64
	v_mov_b32_e32 v32, v64
	v_mov_b32_e32 v33, v64
	v_mov_b32_e32 v34, v64
	v_mov_b32_e32 v35, v64
	v_mov_b32_e32 v36, v64
	v_mov_b32_e32 v37, v64
	v_mov_b32_e32 v38, v64
	v_mov_b32_e32 v39, v64
	v_mov_b32_e32 v12, v64
	v_mov_b32_e32 v13, v64
	v_mov_b32_e32 v14, v64
	v_mov_b32_e32 v15, v64
	v_mov_b32_e32 v20, v64
	v_mov_b32_e32 v21, v64
	v_mov_b32_e32 v22, v64
	v_mov_b32_e32 v23, v64
.LBB0_2:
	s_lshl_b32 s2, s17, 6
	v_add_lshl_u32 v0, s2, v111, 2
	v_add_lshl_u32 v1, s2, v112, 2
	buffer_load_dword v130, v0, s[24:27], 0 offen
	buffer_load_dword v129, v1, s[24:27], 0 offen
	s_lshl_b32 s2, s17, 8
	v_add_u32_e32 v0, s2, v113
	v_add_u32_e32 v1, s2, v114
	v_add_u32_e32 v2, s2, v115
	v_add_u32_e32 v3, s2, v116
	buffer_load_dwordx4 v[96:99], v0, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[100:103], v1, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[132:135], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[136:139], v3, s[28:31], 0 offen nt
	s_lshl_b32 s2, s17, 7
	v_add_lshl_u32 v16, s2, v110, 4
	v_add_lshl_u32 v0, s2, v119, 4
	v_add_lshl_u32 v44, s2, v117, 4
	v_add_lshl_u32 v60, s2, v118, 4
	buffer_load_dwordx4 v[92:95], v16, s[20:23], 0 offen sc0
	buffer_load_dwordx4 v[84:87], v44, s[20:23], 0 offen sc0
	buffer_load_dwordx4 v[88:91], v60, s[20:23], 0 offen sc0
	buffer_load_dwordx4 v[80:83], v0, s[20:23], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[0:3], v0, s[20:23], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[16:19], v16, s[20:23], 0 offen offset:1024 sc0
	s_add_i32 s17, s17, 1
	s_cmp_lg_u32 s17, 16
	s_waitcnt vmcnt(9)
	ds_write_b128 v120, v[96:99]
	s_waitcnt vmcnt(8)
	ds_write_b128 v120, v[100:103] offset:4096
	s_waitcnt vmcnt(7)
	ds_write_b128 v120, v[132:135] offset:8192
	s_waitcnt vmcnt(6)
	ds_write_b128 v120, v[136:139] offset:12288
	v_sub_u32_sdwa v47, v107, v130 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_cmp_lt_i32_e64 s[2:3], 11, v47
	v_min_i32_e32 v47, 11, v47
	v_mul_lo_u32 v47, v47, s10
	v_sub_u32_e32 v61, 0x6c686080, v47
	v_sub_u32_e32 v47, 0x7c787470, v47
	v_and_b32_e32 v61, 0xffffff00, v61
	v_cndmask_b32_e64 v131, v47, 0, s[2:3]
	v_cndmask_b32_e64 v132, v61, 0, s[2:3]
	v_add_u32_e32 v47, 0x7f7f7f78, v131
	v_and_b32_e32 v133, 0x80808080, v47
	v_add_u32_e32 v47, 0x7f7f7f00, v132
	v_and_b32_e32 v134, 0x80808000, v47
	s_waitcnt vmcnt(5)
	v_and_b32_e32 v47, 0x7070707, v92
	v_perm_b32 v61, v131, v132, v47
	v_perm_b32 v47, v133, v134, v47
	v_lshlrev_b32_e32 v62, 4, v92
	v_and_or_b32 v47, v47, v62, v61
	v_sub_u32_sdwa v61, v108, v129 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_cmp_lt_i32_e64 s[2:3], 11, v61
	v_min_i32_e32 v61, 11, v61
	v_mul_lo_u32 v61, v61, s10
	v_sub_u32_e32 v62, 0x6c686080, v61
	v_sub_u32_e32 v61, 0x7c787470, v61
	v_and_b32_e32 v62, 0xffffff00, v62
	v_cndmask_b32_e64 v135, v61, 0, s[2:3]
	v_cndmask_b32_e64 v136, v62, 0, s[2:3]
	v_add_u32_e32 v61, 0x7f7f7f78, v135
	v_and_b32_e32 v137, 0x80808080, v61
	v_add_u32_e32 v61, 0x7f7f7f00, v136
	v_and_b32_e32 v138, 0x80808000, v61
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v61, 0x7070707, v88
	v_perm_b32 v62, v135, v136, v61
	v_perm_b32 v61, v137, v138, v61
	v_lshlrev_b32_e32 v63, 4, v88
	v_and_or_b32 v61, v61, v63, v62
	v_lshrrev_b32_e32 v62, 4, v92
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v131, v132, v62
	v_perm_b32 v62, v133, v134, v62
	v_and_or_b32 v62, v62, v92, v63
	v_bfe_u32 v45, v130, s4, 8
	v_perm_b32 v96, v62, v47, s11
	v_perm_b32 v97, v62, v47, s12
	v_lshrrev_b32_e32 v47, 4, v88
	v_sub_u32_e32 v45, v105, v45
	v_and_b32_e32 v47, 0x7070707, v47
	v_cmp_lt_i32_e32 vcc, 11, v45
	v_min_i32_e32 v45, 11, v45
	v_perm_b32 v62, v135, v136, v47
	v_perm_b32 v47, v137, v138, v47
	v_mul_lo_u32 v45, v45, s10
	v_and_or_b32 v47, v47, v88, v62
	v_perm_b32 v98, v47, v61, s11
	v_perm_b32 v99, v47, v61, s12
	v_sub_u32_e32 v47, 0x6c686080, v45
	v_sub_u32_e32 v45, 0x7c787470, v45
	v_and_b32_e32 v47, 0xffffff00, v47
	v_cndmask_b32_e64 v88, v45, 0, vcc
	v_bfe_u32 v46, v129, s8, 8
	v_cndmask_b32_e64 v92, v47, 0, vcc
	v_add_u32_e32 v45, 0x7f7f7f78, v88
	v_sub_u32_e32 v46, v106, v46
	v_and_b32_e32 v139, 0x80808080, v45
	v_add_u32_e32 v45, 0x7f7f7f00, v92
	v_and_b32_e32 v140, 0x80808000, v45
	v_and_b32_e32 v45, 0x7070707, v84
	v_cmp_lt_i32_e32 vcc, 11, v46
	v_min_i32_e32 v46, 11, v46
	v_perm_b32 v47, v88, v92, v45
	v_perm_b32 v45, v139, v140, v45
	v_lshlrev_b32_e32 v61, 4, v84
	v_mul_lo_u32 v46, v46, s10
	v_and_or_b32 v45, v45, v61, v47
	v_sub_u32_e32 v47, 0x6c686080, v46
	v_sub_u32_e32 v46, 0x7c787470, v46
	v_and_b32_e32 v47, 0xffffff00, v47
	v_cndmask_b32_e64 v141, v46, 0, vcc
	v_cndmask_b32_e64 v142, v47, 0, vcc
	v_add_u32_e32 v46, 0x7f7f7f78, v141
	v_and_b32_e32 v143, 0x80808080, v46
	v_add_u32_e32 v46, 0x7f7f7f00, v142
	v_and_b32_e32 v144, 0x80808000, v46
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v46, 0x7070707, v80
	v_perm_b32 v47, v141, v142, v46
	v_perm_b32 v46, v143, v144, v46
	v_lshlrev_b32_e32 v61, 4, v80
	v_and_or_b32 v46, v46, v61, v47
	v_lshrrev_b32_e32 v47, 4, v84
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v61, v88, v92, v47
	v_perm_b32 v47, v139, v140, v47
	v_and_or_b32 v47, v47, v84, v61
	v_perm_b32 v100, v47, v45, s11
	v_perm_b32 v101, v47, v45, s12
	v_lshrrev_b32_e32 v45, 4, v80
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v47, v141, v142, v45
	v_perm_b32 v45, v143, v144, v45
	v_and_or_b32 v45, v45, v80, v47
	v_perm_b32 v102, v45, v46, s11
	v_perm_b32 v103, v45, v46, s12
	buffer_load_dwordx4 v[44:47], v44, s[20:23], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[60:63], v60, s[20:23], 0 offen offset:1024 sc0
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[146:149], v121 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[148:149], v[96:97], v[40:43]
	v_and_b32_e32 v80, 0x7070707, v93
	v_perm_b32 v84, v131, v132, v80
	v_perm_b32 v80, v133, v134, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[146:147], v[96:97], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[146:147], v[100:101], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[146:147], v[98:99], v[68:71]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[148:149], v[98:99], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[146:147], v[102:103], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[148:149], v[100:101], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[148:149], v[102:103], v[56:59]
	ds_read2st64_b64 v[146:149], v121 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[146:147], v[96:97], v[24:27]
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[148:149], v[96:97], v[4:7]
	v_lshlrev_b32_e32 v96, 4, v93
	v_and_or_b32 v80, v80, v96, v84
	v_and_b32_e32 v84, 0x7070707, v89
	v_perm_b32 v96, v135, v136, v84
	v_perm_b32 v84, v137, v138, v84
	v_lshlrev_b32_e32 v97, 4, v89
	v_and_or_b32 v84, v84, v97, v96
	v_lshrrev_b32_e32 v96, 4, v93
	v_and_b32_e32 v96, 0x7070707, v96
	v_perm_b32 v97, v131, v132, v96
	v_perm_b32 v96, v133, v134, v96
	v_and_or_b32 v93, v96, v93, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[146:147], v[100:101], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[148:149], v[100:101], v[8:11]
	v_perm_b32 v100, v93, v80, s11
	v_perm_b32 v101, v93, v80, s12
	v_lshrrev_b32_e32 v80, 4, v89
	v_and_b32_e32 v80, 0x7070707, v80
	v_perm_b32 v93, v135, v136, v80
	v_perm_b32 v80, v137, v138, v80
	v_and_or_b32 v80, v80, v89, v93
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[146:147], v[102:103], v[36:39]
	v_lshlrev_b32_e32 v89, 4, v85
	v_lshlrev_b32_e32 v93, 4, v81
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[148:149], v[102:103], v[20:23]
	v_perm_b32 v102, v80, v84, s11
	v_perm_b32 v103, v80, v84, s12
	v_and_b32_e32 v80, 0x7070707, v85
	v_perm_b32 v84, v88, v92, v80
	v_perm_b32 v80, v139, v140, v80
	v_and_or_b32 v80, v80, v89, v84
	v_and_b32_e32 v84, 0x7070707, v81
	v_perm_b32 v89, v141, v142, v84
	v_perm_b32 v84, v143, v144, v84
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[146:147], v[98:99], v[32:35]
	v_and_or_b32 v89, v84, v93, v89
	v_lshrrev_b32_e32 v84, 4, v85
	v_and_b32_e32 v84, 0x7070707, v84
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[148:149], v[98:99], v[12:15]
	ds_read2st64_b64 v[96:99], v122 offset1:8
	v_perm_b32 v93, v88, v92, v84
	v_perm_b32 v84, v139, v140, v84
	v_and_or_b32 v85, v84, v85, v93
	v_perm_b32 v84, v85, v80, s11
	v_perm_b32 v85, v85, v80, s12
	v_lshrrev_b32_e32 v80, 4, v81
	v_and_b32_e32 v80, 0x7070707, v80
	v_perm_b32 v93, v141, v142, v80
	v_perm_b32 v80, v143, v144, v80
	v_and_or_b32 v81, v80, v81, v93
	v_perm_b32 v80, v81, v89, s11
	v_perm_b32 v81, v81, v89, s12
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[96:97], v[102:103], v[68:71]
	v_lshlrev_b32_e32 v93, 4, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[96:97], v[84:85], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[98:99], v[102:103], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[98:99], v[100:101], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[96:97], v[100:101], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[96:97], v[80:81], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[98:99], v[84:85], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[98:99], v[80:81], v[56:59]
	ds_read2st64_b64 v[96:99], v122 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[96:97], v[80:81], v[36:39]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[98:99], v[80:81], v[20:23]
	v_and_b32_e32 v80, 0x7070707, v94
	v_perm_b32 v81, v131, v132, v80
	v_perm_b32 v80, v133, v134, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[96:97], v[84:85], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[98:99], v[84:85], v[8:11]
	v_lshlrev_b32_e32 v84, 4, v94
	v_and_or_b32 v81, v80, v84, v81
	v_and_b32_e32 v80, 0x7070707, v90
	v_perm_b32 v84, v135, v136, v80
	v_perm_b32 v80, v137, v138, v80
	v_lshlrev_b32_e32 v85, 4, v90
	v_and_or_b32 v85, v80, v85, v84
	v_lshrrev_b32_e32 v80, 4, v94
	v_and_b32_e32 v80, 0x7070707, v80
	v_perm_b32 v84, v131, v132, v80
	v_perm_b32 v80, v133, v134, v80
	v_and_or_b32 v84, v80, v94, v84
	v_perm_b32 v80, v84, v81, s11
	v_perm_b32 v81, v84, v81, s12
	v_lshrrev_b32_e32 v84, 4, v90
	v_and_b32_e32 v84, 0x7070707, v84
	v_perm_b32 v89, v135, v136, v84
	v_perm_b32 v84, v137, v138, v84
	v_and_or_b32 v89, v84, v90, v89
	v_perm_b32 v84, v89, v85, s11
	v_perm_b32 v85, v89, v85, s12
	v_and_b32_e32 v89, 0x7070707, v86
	v_perm_b32 v90, v88, v92, v89
	v_perm_b32 v89, v139, v140, v89
	v_and_or_b32 v89, v89, v93, v90
	v_and_b32_e32 v90, 0x7070707, v82
	v_perm_b32 v93, v141, v142, v90
	v_perm_b32 v90, v143, v144, v90
	v_lshlrev_b32_e32 v94, 4, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[96:97], v[100:101], v[24:27]
	v_and_or_b32 v90, v90, v94, v93
	v_lshrrev_b32_e32 v93, 4, v86
	v_and_b32_e32 v93, 0x7070707, v93
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[98:99], v[100:101], v[4:7]
	v_perm_b32 v94, v88, v92, v93
	v_perm_b32 v93, v139, v140, v93
	v_and_or_b32 v86, v93, v86, v94
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[96:97], v[102:103], v[32:35]
	v_perm_b32 v158, v86, v89, s11
	v_perm_b32 v159, v86, v89, s12
	v_lshrrev_b32_e32 v86, 4, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[98:99], v[102:103], v[12:15]
	ds_read2st64_b64 v[96:99], v123 offset1:8
	v_and_b32_e32 v86, 0x7070707, v86
	v_perm_b32 v89, v141, v142, v86
	v_perm_b32 v86, v143, v144, v86
	v_and_or_b32 v82, v86, v82, v89
	v_perm_b32 v166, v82, v90, s11
	v_perm_b32 v167, v82, v90, s12
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[96:97], v[84:85], v[68:71]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[96:97], v[158:159], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[98:99], v[84:85], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[98:99], v[80:81], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[96:97], v[80:81], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[96:97], v[166:167], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[98:99], v[158:159], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[98:99], v[166:167], v[56:59]
	ds_read2st64_b64 v[96:99], v123 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[154:157], v[96:97], v[158:159], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[158:161], v[98:99], v[158:159], v[8:11]
	s_nop 2
	v_lshrrev_b32_e32 v9, 4, v87
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v10, v88, v92, v9
	v_perm_b32 v9, v139, v140, v9
	v_and_or_b32 v89, v9, v87, v10
	v_lshrrev_b32_e32 v10, 4, v83
	v_and_b32_e32 v10, 0x7070707, v10
	v_perm_b32 v11, v141, v142, v10
	v_perm_b32 v10, v143, v144, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[96:97], v[80:81], v[24:27]
	v_and_or_b32 v90, v10, v83, v11
	v_and_b32_e32 v10, 0x7070707, v83
	v_and_b32_e32 v9, 0x7070707, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[98:99], v[80:81], v[4:7]
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[98:99], v[84:85], v[12:15]
	s_nop 1
	v_lshrrev_b32_e32 v4, 4, v95
	v_and_b32_e32 v4, 0x7070707, v4
	v_lshrrev_b32_e32 v7, 4, v91
	v_lshlrev_b32_e32 v14, 4, v83
	ds_read2st64_b64 v[80:83], v124 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[96:97], v[84:85], v[32:35]
	v_lshlrev_b32_e32 v13, 4, v87
	ds_read2st64_b64 v[84:87], v124 offset0:16 offset1:24
	v_perm_b32 v5, v131, v132, v4
	v_perm_b32 v4, v133, v134, v4
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v4, v4, v95, v5
	v_and_b32_e32 v5, 0x7070707, v95
	v_perm_b32 v8, v135, v136, v7
	v_perm_b32 v7, v137, v138, v7
	v_lshlrev_b32_e32 v6, 4, v95
	v_and_or_b32 v12, v7, v91, v8
	v_and_b32_e32 v7, 0x7070707, v91
	v_perm_b32 v11, v131, v132, v5
	v_perm_b32 v5, v133, v134, v5
	v_lshlrev_b32_e32 v8, 4, v91
	v_perm_b32 v15, v135, v136, v7
	v_perm_b32 v7, v137, v138, v7
	v_and_or_b32 v5, v5, v6, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[162:165], v[96:97], v[166:167], v[36:39]
	v_and_or_b32 v15, v7, v8, v15
	v_perm_b32 v8, v4, v5, s11
	v_mfma_f32_16x16x32_fp8_fp8 v[96:99], v[98:99], v[166:167], v[20:23]
	v_perm_b32 v36, v141, v142, v10
	v_perm_b32 v37, v143, v144, v10
	s_nop 0
	v_perm_b32 v22, v88, v92, v9
	v_perm_b32 v23, v139, v140, v9
	v_perm_b32 v9, v4, v5, s12
	v_perm_b32 v20, v12, v15, s11
	v_perm_b32 v21, v12, v15, s12
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[82:83], v[8:9], v[40:43]
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v92, 4, v60
	s_nop 0
	v_and_or_b32 v40, v23, v13, v22
	v_and_or_b32 v41, v37, v14, v36
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[84:85], v[20:21], v[32:35]
	v_perm_b32 v88, v90, v41, s11
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[80:81], v[20:21], v[68:71]
	s_nop 2
	v_perm_b32 v68, v89, v40, s11
	v_perm_b32 v69, v89, v40, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[82:83], v[20:21], v[52:55]
	v_perm_b32 v89, v90, v41, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[80:81], v[68:69], v[72:75]
	s_nop 2
	v_sub_u32_sdwa v72, v107, v130 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[80:81], v[8:9], v[64:67]
	v_cmp_lt_i32_e32 vcc, 11, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[80:81], v[88:89], v[76:79]
	v_min_i32_e32 v80, 11, v72
	s_nop 1
	v_sub_u32_sdwa v76, v108, v129 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[84:85], v[8:9], v[100:103]
	v_cmp_lt_i32_e64 s[2:3], 11, v76
	v_min_i32_e32 v76, 11, v76
	v_mul_lo_u32 v76, v76, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[84:85], v[68:69], v[154:157]
	v_and_b32_e32 v77, 0x7070707, v16
	v_lshlrev_b32_e32 v78, 4, v16
	v_and_b32_e32 v79, 0x7070707, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[84:85], v[88:89], v[162:165]
	v_mul_lo_u32 v84, v80, s10
	v_sub_u32_e32 v85, 0x6c686080, v84
	v_sub_u32_e32 v84, 0x7c787470, v84
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[86:87], v[8:9], v[146:149]
	v_cndmask_b32_e64 v84, v84, 0, vcc
	ds_read2st64_b64 v[100:103], v125 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[86:87], v[20:21], v[150:153]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[82:83], v[68:69], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[82:83], v[88:89], v[56:59]
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[86:87], v[68:69], v[158:161]
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[86:87], v[88:89], v[96:99]
	v_sub_u32_e32 v86, 0x6c686080, v76
	v_and_b32_e32 v87, 0xffffff00, v85
	v_sub_u32_e32 v76, 0x7c787470, v76
	v_and_b32_e32 v88, 0xffffff00, v86
	v_cndmask_b32_e64 v86, v87, 0, vcc
	v_cndmask_b32_e64 v85, v76, 0, s[2:3]
	v_add_u32_e32 v76, 0x7f7f7f78, v84
	v_add_u32_e32 v89, 0x7f7f7f00, v86
	v_cndmask_b32_e64 v87, v88, 0, s[2:3]
	v_and_b32_e32 v88, 0x80808080, v76
	v_and_b32_e32 v89, 0x80808000, v89
	v_add_u32_e32 v90, 0x7f7f7f78, v85
	v_perm_b32 v91, v84, v86, v77
	v_perm_b32 v76, v88, v89, v77
	v_add_u32_e32 v77, 0x7f7f7f00, v87
	v_and_or_b32 v76, v76, v78, v91
	v_and_b32_e32 v90, 0x80808080, v90
	v_and_b32_e32 v91, 0x80808000, v77
	v_perm_b32 v78, v85, v87, v79
	v_perm_b32 v77, v90, v91, v79
	v_and_or_b32 v77, v77, v92, v78
	v_lshrrev_b32_e32 v78, 4, v16
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v84, v86, v78
	v_perm_b32 v78, v88, v89, v78
	v_and_or_b32 v16, v78, v16, v79
	v_perm_b32 v132, v16, v76, s11
	v_perm_b32 v133, v16, v76, s12
	v_lshrrev_b32_e32 v16, 4, v60
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v76, v85, v87, v16
	v_perm_b32 v16, v90, v91, v16
	v_and_or_b32 v16, v16, v60, v76
	v_perm_b32 v134, v16, v77, s11
	v_perm_b32 v135, v16, v77, s12
	v_bfe_u32 v16, v130, s5, 8
	v_sub_u32_e32 v16, v105, v16
	v_cmp_lt_i32_e32 vcc, 11, v16
	v_min_i32_e32 v16, 11, v16
	v_mul_lo_u32 v16, v16, s10
	v_sub_u32_e32 v60, 0x6c686080, v16
	v_sub_u32_e32 v16, 0x7c787470, v16
	v_and_b32_e32 v60, 0xffffff00, v60
	v_cndmask_b32_e64 v97, v16, 0, vcc
	v_cndmask_b32_e64 v98, v60, 0, vcc
	v_add_u32_e32 v16, 0x7f7f7f78, v97
	v_and_b32_e32 v95, 0x80808080, v16
	v_add_u32_e32 v16, 0x7f7f7f00, v98
	v_and_b32_e32 v96, 0x80808000, v16
	v_and_b32_e32 v16, 0x7070707, v44
	v_perm_b32 v60, v97, v98, v16
	v_perm_b32 v16, v95, v96, v16
	v_lshlrev_b32_e32 v76, 4, v44
	v_and_or_b32 v16, v16, v76, v60
	v_bfe_u32 v60, v129, s9, 8
	v_sub_u32_e32 v60, v106, v60
	v_cmp_lt_i32_e32 vcc, 11, v60
	v_min_i32_e32 v60, 11, v60
	v_mul_lo_u32 v60, v60, s10
	v_sub_u32_e32 v76, 0x6c686080, v60
	v_sub_u32_e32 v60, 0x7c787470, v60
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cndmask_b32_e64 v93, v60, 0, vcc
	v_cndmask_b32_e64 v94, v76, 0, vcc
	v_add_u32_e32 v60, 0x7f7f7f78, v93
	v_add_u32_e32 v76, 0x7f7f7f00, v94
	v_and_b32_e32 v60, 0x80808080, v60
	v_and_b32_e32 v92, 0x80808000, v76
	v_and_b32_e32 v76, 0x7070707, v0
	v_perm_b32 v77, v93, v94, v76
	v_perm_b32 v76, v60, v92, v76
	v_lshlrev_b32_e32 v78, 4, v0
	v_and_or_b32 v76, v76, v78, v77
	v_lshrrev_b32_e32 v77, 4, v44
	v_and_b32_e32 v77, 0x7070707, v77
	v_perm_b32 v78, v97, v98, v77
	v_perm_b32 v77, v95, v96, v77
	v_and_or_b32 v44, v77, v44, v78
	v_perm_b32 v130, v44, v16, s11
	v_perm_b32 v131, v44, v16, s12
	v_lshrrev_b32_e32 v16, 4, v0
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v44, v93, v94, v16
	v_perm_b32 v16, v60, v92, v16
	v_and_or_b32 v0, v16, v0, v44
	v_perm_b32 v136, v0, v76, s11
	v_perm_b32 v137, v0, v76, s12
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[100:101], v[130:131], v[52:55]
	v_and_b32_e32 v0, 0x7070707, v17
	v_perm_b32 v16, v84, v86, v0
	v_perm_b32 v0, v88, v89, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[102:103], v[134:135], v[36:39]
	v_lshlrev_b32_e32 v44, 4, v17
	v_and_or_b32 v0, v0, v44, v16
	v_and_b32_e32 v16, 0x7070707, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[102:103], v[132:133], v[28:31]
	v_perm_b32 v44, v85, v87, v16
	v_perm_b32 v16, v90, v91, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[100:101], v[132:133], v[24:27]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[100:101], v[134:135], v[32:35]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[100:101], v[136:137], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[102:103], v[130:131], v[48:51]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[102:103], v[136:137], v[56:59]
	ds_read2st64_b64 v[100:103], v125 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[102:103], v[132:133], v[8:11]
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[100:101], v[134:135], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[102:103], v[134:135], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[100:101], v[130:131], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[100:101], v[136:137], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[102:103], v[136:137], v[80:83]
	s_nop 2
	v_lshlrev_b32_e32 v80, 4, v61
	v_and_or_b32 v44, v16, v80, v44
	v_lshrrev_b32_e32 v16, 4, v17
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v80, v84, v86, v16
	v_perm_b32 v16, v88, v89, v16
	v_and_or_b32 v17, v16, v17, v80
	v_perm_b32 v16, v17, v0, s11
	v_perm_b32 v17, v17, v0, s12
	v_lshrrev_b32_e32 v0, 4, v61
	v_and_b32_e32 v0, 0x7070707, v0
	v_perm_b32 v80, v85, v87, v0
	v_perm_b32 v0, v90, v91, v0
	v_and_or_b32 v0, v0, v61, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[102:103], v[130:131], v[68:71]
	v_perm_b32 v130, v0, v44, s11
	v_perm_b32 v131, v0, v44, s12
	v_and_b32_e32 v0, 0x7070707, v45
	v_perm_b32 v44, v97, v98, v0
	v_perm_b32 v0, v95, v96, v0
	v_lshlrev_b32_e32 v61, 4, v45
	v_and_or_b32 v0, v0, v61, v44
	v_and_b32_e32 v44, 0x7070707, v1
	v_perm_b32 v61, v93, v94, v44
	v_perm_b32 v44, v60, v92, v44
	v_lshlrev_b32_e32 v80, 4, v1
	v_and_or_b32 v61, v44, v80, v61
	v_lshrrev_b32_e32 v44, 4, v45
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v80, v97, v98, v44
	v_perm_b32 v44, v95, v96, v44
	v_and_or_b32 v45, v44, v45, v80
	v_perm_b32 v44, v45, v0, s11
	v_perm_b32 v45, v45, v0, s12
	v_lshrrev_b32_e32 v0, 4, v1
	v_and_b32_e32 v0, 0x7070707, v0
	v_perm_b32 v80, v93, v94, v0
	v_perm_b32 v0, v60, v92, v0
	v_and_or_b32 v1, v0, v1, v80
	ds_read2st64_b64 v[80:83], v126 offset1:8
	v_perm_b32 v0, v1, v61, s11
	v_perm_b32 v1, v1, v61, s12
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[80:81], v[44:45], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[82:83], v[130:131], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[82:83], v[16:17], v[36:39]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[80:81], v[16:17], v[24:27]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[80:81], v[130:131], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[80:81], v[0:1], v[32:35]
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[82:83], v[44:45], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[82:83], v[0:1], v[48:51]
	s_nop 2
	ds_read2st64_b64 v[48:51], v126 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[48:49], v[0:1], v[64:67]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[50:51], v[0:1], v[72:75]
	v_and_b32_e32 v0, 0x7070707, v18
	v_perm_b32 v1, v84, v86, v0
	v_perm_b32 v0, v88, v89, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[100:101], v[132:133], v[4:7]
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[48:49], v[130:131], v[8:11]
	s_nop 2
	v_lshlrev_b32_e32 v8, 4, v18
	v_and_or_b32 v1, v0, v8, v1
	v_and_b32_e32 v0, 0x7070707, v62
	v_perm_b32 v8, v85, v87, v0
	v_perm_b32 v0, v90, v91, v0
	v_lshlrev_b32_e32 v9, 4, v62
	v_and_or_b32 v8, v0, v9, v8
	v_lshrrev_b32_e32 v0, 4, v18
	v_and_b32_e32 v0, 0x7070707, v0
	v_perm_b32 v9, v84, v86, v0
	v_perm_b32 v0, v88, v89, v0
	v_and_or_b32 v9, v0, v18, v9
	v_perm_b32 v0, v9, v1, s11
	v_perm_b32 v1, v9, v1, s12
	v_lshrrev_b32_e32 v9, 4, v62
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v10, v85, v87, v9
	v_perm_b32 v9, v90, v91, v9
	v_and_or_b32 v9, v9, v62, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[48:49], v[16:17], v[4:7]
	v_lshlrev_b32_e32 v10, 4, v46
	v_lshlrev_b32_e32 v11, 4, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[50:51], v[16:17], v[56:59]
	v_perm_b32 v16, v9, v8, s11
	v_perm_b32 v17, v9, v8, s12
	v_and_b32_e32 v8, 0x7070707, v46
	v_perm_b32 v9, v97, v98, v8
	v_perm_b32 v8, v95, v96, v8
	v_and_or_b32 v8, v8, v10, v9
	v_and_b32_e32 v9, 0x7070707, v2
	v_perm_b32 v10, v93, v94, v9
	v_perm_b32 v9, v60, v92, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[50:51], v[130:131], v[12:15]
	v_and_or_b32 v9, v9, v11, v10
	v_lshrrev_b32_e32 v10, 4, v46
	ds_read2st64_b64 v[130:133], v127 offset1:8
	v_and_b32_e32 v10, 0x7070707, v10
	v_perm_b32 v11, v97, v98, v10
	v_perm_b32 v10, v95, v96, v10
	v_and_or_b32 v10, v10, v46, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[48:49], v[44:45], v[20:23]
	v_and_b32_e32 v46, 0x7070707, v47
	v_perm_b32 v61, v97, v98, v46
	v_perm_b32 v46, v95, v96, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[50:51], v[44:45], v[68:71]
	v_perm_b32 v44, v10, v8, s11
	v_perm_b32 v45, v10, v8, s12
	v_lshrrev_b32_e32 v8, 4, v2
	v_and_b32_e32 v8, 0x7070707, v8
	v_perm_b32 v10, v93, v94, v8
	v_perm_b32 v8, v60, v92, v8
	v_and_or_b32 v2, v8, v2, v10
	v_perm_b32 v142, v2, v9, s11
	v_perm_b32 v143, v2, v9, s12
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[132:133], v[0:1], v[36:39]
	v_lshlrev_b32_e32 v2, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[130:131], v[142:143], v[32:35]
	s_nop 2
	ds_read2st64_b64 v[32:35], v127 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[130:131], v[0:1], v[24:27]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[32:33], v[0:1], v[4:7]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[34:35], v[0:1], v[56:59]
	v_lshrrev_b32_e32 v0, 4, v19
	v_and_b32_e32 v0, 0x7070707, v0
	v_perm_b32 v1, v84, v86, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[130:131], v[44:45], v[76:79]
	v_perm_b32 v0, v88, v89, v0
	v_and_or_b32 v1, v0, v19, v1
	v_and_b32_e32 v0, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[132:133], v[16:17], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[130:131], v[16:17], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[132:133], v[142:143], v[80:83]
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[32:33], v[16:17], v[100:103]
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[34:35], v[16:17], v[12:15]
	v_lshrrev_b32_e32 v16, 4, v63
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v17, v85, v87, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[32:33], v[44:45], v[20:23]
	v_perm_b32 v16, v90, v91, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[138:141], v[32:33], v[142:143], v[64:67]
	v_and_b32_e32 v33, 0x7070707, v63
	v_and_or_b32 v32, v16, v63, v17
	ds_read2st64_b64 v[16:19], v128 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[132:133], v[44:45], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[130:133], v[34:35], v[44:45], v[68:71]
	s_nop 1
	v_perm_b32 v40, v85, v87, v33
	v_perm_b32 v33, v90, v91, v33
	v_lshrrev_b32_e32 v41, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[34:35], v[142:143], v[72:75]
	v_perm_b32 v35, v84, v86, v0
	ds_read2st64_b64 v[84:87], v128 offset0:16 offset1:24
	v_perm_b32 v0, v88, v89, v0
	v_lshlrev_b32_e32 v34, 4, v63
	v_and_or_b32 v2, v0, v2, v35
	v_perm_b32 v0, v1, v2, s11
	v_perm_b32 v1, v1, v2, s12
	v_and_or_b32 v2, v33, v34, v40
	v_perm_b32 v44, v32, v2, s11
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[64:67], v[16:17], v[0:1], v[24:27]
	v_perm_b32 v45, v32, v2, s12
	v_and_b32_e32 v2, 0x7070707, v41
	v_and_b32_e32 v32, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[18:19], v[0:1], v[134:137]
	v_perm_b32 v62, v97, v98, v2
	v_perm_b32 v2, v95, v96, v2
	v_lshlrev_b32_e32 v63, 4, v47
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[84:85], v[0:1], v[4:7]
	v_and_or_b32 v46, v46, v63, v61
	v_and_or_b32 v2, v2, v47, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[86:87], v[0:1], v[56:59]
	v_lshrrev_b32_e32 v0, 4, v3
	v_and_b32_e32 v0, 0x7070707, v0
	v_perm_b32 v1, v93, v94, v32
	v_perm_b32 v56, v93, v94, v0
	v_lshlrev_b32_e32 v57, 4, v3
	v_perm_b32 v58, v60, v92, v32
	v_perm_b32 v59, v60, v92, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[16:17], v[44:45], v[76:79]
	v_and_or_b32 v3, v59, v3, v56
	v_perm_b32 v0, v2, v46, s11
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[18:19], v[44:45], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[84:85], v[44:45], v[80:83]
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[86:87], v[44:45], v[12:15]
	v_and_or_b32 v44, v58, v57, v1
	v_perm_b32 v1, v2, v46, s12
	v_perm_b32 v2, v3, v44, s11
	v_perm_b32 v3, v3, v44, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[16:17], v[0:1], v[48:51]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[16:17], v[2:3], v[8:11]
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[18:19], v[0:1], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[18:19], v[2:3], v[36:39]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[84:85], v[0:1], v[100:103]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[84:85], v[2:3], v[138:141]
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[86:87], v[0:1], v[130:133]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[86:87], v[2:3], v[20:23]
	s_cbranch_scc1 .LBB0_2
	v_lshl_or_b32 v2, v109, 2, s15
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[0:1], v[2:3], 2, s[18:19]
	global_load_dword v3, v[0:1], off
	s_mov_b32 s3, 0x27000
	s_lshl_b32 s10, s14, 2
	s_and_b32 s9, s7, 0xffff
	s_mov_b32 s8, s6
	s_mov_b32 s11, s3
	v_mov_b32_e32 v45, 0xfd800000
	v_add_u32_e32 v16, 17, v108
	v_lshl_add_u32 v63, v107, 23, v45
	v_cmp_lt_i32_e32 vcc, 5, v107
	v_add_u32_e32 v17, 17, v105
	v_lshl_add_u32 v62, v108, 23, v45
	v_lshlrev_b32_e64 v16, v16, 1
	v_add_u32_e32 v19, 17, v106
	v_mov_b32_e32 v46, v68
	v_mov_b32_e32 v47, v64
	v_lshlrev_b32_e32 v64, 8, v2
	v_lshl_add_u32 v68, v106, 23, v45
	v_lshl_add_u32 v45, v105, 23, v45
	v_lshlrev_b32_e64 v17, v17, 1
	v_lshlrev_b32_e64 v19, v19, 1
	v_mov_b32_e32 v60, v76
	v_mov_b32_e32 v61, v72
	s_mov_b32 s4, 0xbfb8aa3b
	s_movk_i32 s5, 0x7fff
	s_load_dwordx2 s[0:1], s[0:1], 0x40
	v_bfrev_b32_e32 v18, -2
	s_lshl_b32 s2, s16, 9
	v_mov_b32_e32 v72, v77
	s_waitcnt lgkmcnt(0)
	s_and_b32 s1, s1, 0xffff
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v80, 0xffffff, v3
	v_lshlrev_b32_e32 v3, 2, v80
	buffer_load_dword v44, v3, s[8:11], 0 offen
	v_add_u32_e32 v3, 17, v107
	v_lshlrev_b32_e64 v3, v3, 1
	v_cndmask_b32_e32 v3, v3, v63, vcc
	v_cmp_lt_i32_e32 vcc, 5, v108
	s_nop 1
	v_cndmask_b32_e32 v2, v16, v62, vcc
	v_cmp_lt_i32_e32 vcc, 5, v105
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[62:63], v[44:45], v[2:3] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v17, v17, v45, vcc
	v_cmp_lt_i32_e32 vcc, 5, v106
	v_pk_mul_f32 v[46:47], v[46:47], v[62:63]
	s_nop 0
	v_cndmask_b32_e32 v16, v19, v68, vcc
	v_pk_mul_f32 v[44:45], v[44:45], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[60:61], v[44:45]
	v_mov_b32_e32 v60, v47
	v_mov_b32_e32 v61, v45
	v_pk_mul_f32 v[60:61], v[60:61], s[4:5] op_sel_hi:[1,0]
	v_add_lshl_u32 v19, v64, v104, 1
	v_exp_f32_e32 v60, v60
	v_exp_f32_e32 v61, v61
	v_add_u32_e32 v62, 32, v19
	v_cmp_gt_i32_e32 vcc, s14, v80
	v_mov_b32_e32 v64, v69
	v_pk_add_f32 v[60:61], v[60:61], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v63, v18, v19, vcc
	v_rcp_f32_e32 v60, v60
	v_rcp_f32_e32 v61, v61
	v_cndmask_b32_e32 v62, v18, v62, vcc
	v_mul_f32_e32 v47, v47, v60
	v_mul_f32_e32 v45, v45, v61
	v_mul_f32_e32 v46, v46, v47
	v_mul_f32_e32 v44, v44, v45
	v_bfe_u32 v45, v46, 16, 1
	v_or_b32_e32 v47, 0x400000, v46
	v_bfe_u32 v60, v44, 16, 1
	v_add3_u32 v45, v45, v46, s5
	v_cmp_u_f32_e32 vcc, v46, v46
	v_or_b32_e32 v61, 0x400000, v44
	v_add3_u32 v60, v60, v44, s5
	v_cndmask_b32_e32 v45, v45, v47, vcc
	v_cmp_u_f32_e32 vcc, v44, v44
	v_lshrrev_b32_e32 v45, 16, v45
	s_nop 0
	v_cndmask_b32_e32 v44, v60, v61, vcc
	v_lshrrev_b32_e32 v44, 16, v44
	buffer_store_short v45, v63, s[0:3], 0 offen
	buffer_store_short v44, v62, s[0:3], 0 offen
	global_load_dword v44, v[0:1], off offset:4
	v_add_u32_e32 v63, 0x200, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v62, 0xffffff, v44
	v_lshlrev_b32_e32 v44, 2, v62
	buffer_load_dword v44, v44, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v62
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[46:47], v[44:45], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[46:47], v[64:65], v[46:47]
	v_pk_mul_f32 v[44:45], v[72:73], v[44:45]
	v_mov_b32_e32 v60, v47
	v_mov_b32_e32 v61, v45
	v_pk_mul_f32 v[60:61], v[60:61], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v64, 0x220, v19
	v_exp_f32_e32 v60, v60
	v_exp_f32_e32 v61, v61
	v_cndmask_b32_e32 v62, v18, v63, vcc
	v_cndmask_b32_e32 v63, v18, v64, vcc
	v_pk_add_f32 v[60:61], v[60:61], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v60, v60
	v_rcp_f32_e32 v61, v61
	v_mul_f32_e32 v47, v47, v60
	v_mul_f32_e32 v45, v45, v61
	v_mul_f32_e32 v46, v46, v47
	v_mul_f32_e32 v44, v44, v45
	v_bfe_u32 v45, v46, 16, 1
	v_or_b32_e32 v47, 0x400000, v46
	v_bfe_u32 v60, v44, 16, 1
	v_add3_u32 v45, v45, v46, s5
	v_cmp_u_f32_e32 vcc, v46, v46
	v_or_b32_e32 v61, 0x400000, v44
	v_add3_u32 v60, v60, v44, s5
	v_cndmask_b32_e32 v45, v45, v47, vcc
	v_cmp_u_f32_e32 vcc, v44, v44
	v_lshrrev_b32_e32 v45, 16, v45
	v_mov_b32_e32 v46, v70
	v_cndmask_b32_e32 v44, v60, v61, vcc
	v_lshrrev_b32_e32 v44, 16, v44
	buffer_store_short v45, v62, s[0:3], 0 offen
	buffer_store_short v44, v63, s[0:3], 0 offen
	global_load_dword v44, v[0:1], off offset:8
	v_mov_b32_e32 v47, v66
	v_mov_b32_e32 v60, v78
	v_mov_b32_e32 v61, v74
	v_mov_b32_e32 v66, v71
	v_mov_b32_e32 v74, v79
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v64, 0xffffff, v44
	v_lshlrev_b32_e32 v44, 2, v64
	buffer_load_dword v44, v44, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v64
	v_add_u32_e32 v64, 0x620, v19
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[62:63], v[44:45], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[46:47], v[46:47], v[62:63]
	v_pk_mul_f32 v[44:45], v[60:61], v[44:45]
	v_mov_b32_e32 v60, v47
	v_mov_b32_e32 v61, v45
	v_pk_mul_f32 v[60:61], v[60:61], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v62, 0x400, v19
	v_exp_f32_e32 v60, v60
	v_exp_f32_e32 v61, v61
	v_add_u32_e32 v63, 0x420, v19
	v_cndmask_b32_e32 v62, v18, v62, vcc
	v_cndmask_b32_e32 v63, v18, v63, vcc
	v_pk_add_f32 v[60:61], v[60:61], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v60, v60
	v_rcp_f32_e32 v61, v61
	v_mul_f32_e32 v47, v47, v60
	v_mul_f32_e32 v45, v45, v61
	v_mul_f32_e32 v46, v46, v47
	v_mul_f32_e32 v44, v44, v45
	v_bfe_u32 v45, v46, 16, 1
	v_or_b32_e32 v47, 0x400000, v46
	v_bfe_u32 v60, v44, 16, 1
	v_add3_u32 v45, v45, v46, s5
	v_cmp_u_f32_e32 vcc, v46, v46
	v_or_b32_e32 v61, 0x400000, v44
	v_add3_u32 v60, v60, v44, s5
	v_cndmask_b32_e32 v45, v45, v47, vcc
	v_cmp_u_f32_e32 vcc, v44, v44
	v_lshrrev_b32_e32 v45, 16, v45
	s_nop 0
	v_cndmask_b32_e32 v44, v60, v61, vcc
	v_lshrrev_b32_e32 v44, 16, v44
	buffer_store_short v45, v62, s[0:3], 0 offen
	buffer_store_short v44, v63, s[0:3], 0 offen
	global_load_dword v44, v[0:1], off offset:12
	v_add_u32_e32 v63, 0x600, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v62, 0xffffff, v44
	v_lshlrev_b32_e32 v44, 2, v62
	buffer_load_dword v44, v44, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v62
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[46:47], v[44:45], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[46:47], v[66:67], v[46:47]
	v_pk_mul_f32 v[44:45], v[74:75], v[44:45]
	v_mov_b32_e32 v60, v47
	v_mov_b32_e32 v61, v45
	v_pk_mul_f32 v[60:61], v[60:61], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v62, v18, v63, vcc
	v_exp_f32_e32 v60, v60
	v_exp_f32_e32 v61, v61
	v_cndmask_b32_e32 v63, v18, v64, vcc
	v_pk_add_f32 v[60:61], v[60:61], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v60, v60
	v_rcp_f32_e32 v61, v61
	v_mul_f32_e32 v47, v47, v60
	v_mul_f32_e32 v45, v45, v61
	v_mul_f32_e32 v46, v46, v47
	v_mul_f32_e32 v44, v44, v45
	v_bfe_u32 v45, v46, 16, 1
	v_or_b32_e32 v47, 0x400000, v46
	v_bfe_u32 v60, v44, 16, 1
	v_add3_u32 v45, v45, v46, s5
	v_cmp_u_f32_e32 vcc, v46, v46
	v_or_b32_e32 v61, 0x400000, v44
	v_add3_u32 v60, v60, v44, s5
	v_cndmask_b32_e32 v45, v45, v47, vcc
	v_cmp_u_f32_e32 vcc, v44, v44
	v_lshrrev_b32_e32 v45, 16, v45
	v_mov_b32_e32 v46, v52
	v_cndmask_b32_e32 v44, v60, v61, vcc
	v_lshrrev_b32_e32 v44, 16, v44
	buffer_store_short v45, v62, s[0:3], 0 offen
	buffer_store_short v44, v63, s[0:3], 0 offen
	global_load_dword v44, v[0:1], off offset:64
	v_mov_b32_e32 v47, v40
	v_mov_b32_e32 v60, v56
	v_mov_b32_e32 v61, v48
	v_add_u32_e32 v40, 0x2000, v19
	v_add_u32_e32 v48, 0x2020, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v64, 0xffffff, v44
	v_lshlrev_b32_e32 v44, 2, v64
	buffer_load_dword v44, v44, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v64
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[62:63], v[44:45], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[46:47], v[46:47], v[62:63]
	v_pk_mul_f32 v[44:45], v[60:61], v[44:45]
	v_mov_b32_e32 v60, v47
	v_mov_b32_e32 v61, v45
	v_pk_mul_f32 v[60:61], v[60:61], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v40, v18, v40, vcc
	v_exp_f32_e32 v60, v60
	v_exp_f32_e32 v61, v61
	v_cndmask_b32_e32 v48, v18, v48, vcc
	v_pk_add_f32 v[60:61], v[60:61], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v52, v60
	v_rcp_f32_e32 v56, v61
	v_mul_f32_e32 v47, v47, v52
	v_mul_f32_e32 v45, v45, v56
	v_mul_f32_e32 v46, v46, v47
	v_mul_f32_e32 v44, v44, v45
	v_bfe_u32 v45, v46, 16, 1
	v_or_b32_e32 v47, 0x400000, v46
	v_bfe_u32 v52, v44, 16, 1
	v_add3_u32 v45, v45, v46, s5
	v_cmp_u_f32_e32 vcc, v46, v46
	v_or_b32_e32 v56, 0x400000, v44
	v_add3_u32 v52, v52, v44, s5
	v_cndmask_b32_e32 v45, v45, v47, vcc
	v_cmp_u_f32_e32 vcc, v44, v44
	v_lshrrev_b32_e32 v45, 16, v45
	s_nop 0
	v_cndmask_b32_e32 v44, v52, v56, vcc
	v_lshrrev_b32_e32 v44, 16, v44
	buffer_store_short v45, v40, s[0:3], 0 offen
	buffer_store_short v44, v48, s[0:3], 0 offen
	global_load_dword v40, v[0:1], off offset:68
	v_mov_b32_e32 v48, v57
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v52, 0xffffff, v40
	v_lshlrev_b32_e32 v40, 2, v52
	buffer_load_dword v44, v40, s[8:11], 0 offen
	v_mov_b32_e32 v40, v53
	v_cmp_gt_i32_e32 vcc, s14, v52
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[46:47], v[44:45], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[46:47]
	v_pk_mul_f32 v[44:45], v[48:49], v[44:45]
	v_mov_b32_e32 v46, v41
	v_mov_b32_e32 v47, v45
	v_pk_mul_f32 v[46:47], v[46:47], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v48, 0x2200, v19
	v_exp_f32_e32 v46, v46
	v_exp_f32_e32 v47, v47
	v_add_u32_e32 v49, 0x2220, v19
	v_cndmask_b32_e32 v48, v18, v48, vcc
	v_cndmask_b32_e32 v49, v18, v49, vcc
	v_pk_add_f32 v[46:47], v[46:47], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v46, v46
	v_rcp_f32_e32 v47, v47
	v_mul_f32_e32 v41, v41, v46
	v_mul_f32_e32 v45, v45, v47
	v_mul_f32_e32 v40, v40, v41
	v_mul_f32_e32 v41, v44, v45
	v_bfe_u32 v44, v40, 16, 1
	v_or_b32_e32 v45, 0x400000, v40
	v_bfe_u32 v46, v41, 16, 1
	v_add3_u32 v44, v44, v40, s5
	v_cmp_u_f32_e32 vcc, v40, v40
	v_or_b32_e32 v47, 0x400000, v41
	v_add3_u32 v46, v46, v41, s5
	v_cndmask_b32_e32 v40, v44, v45, vcc
	v_cmp_u_f32_e32 vcc, v41, v41
	v_lshrrev_b32_e32 v40, 16, v40
	v_mov_b32_e32 v44, v54
	v_cndmask_b32_e32 v41, v46, v47, vcc
	v_lshrrev_b32_e32 v41, 16, v41
	buffer_store_short v40, v48, s[0:3], 0 offen
	buffer_store_short v41, v49, s[0:3], 0 offen
	global_load_dword v40, v[0:1], off offset:72
	v_mov_b32_e32 v45, v42
	v_mov_b32_e32 v46, v58
	v_mov_b32_e32 v47, v50
	v_add_u32_e32 v42, 0x2400, v19
	v_mov_b32_e32 v50, v59
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v52, 0xffffff, v40
	v_lshlrev_b32_e32 v40, 2, v52
	buffer_load_dword v40, v40, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v52
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[48:49], v[40:41], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[48:49]
	v_pk_mul_f32 v[40:41], v[46:47], v[40:41]
	v_mov_b32_e32 v46, v45
	v_mov_b32_e32 v47, v41
	v_pk_mul_f32 v[46:47], v[46:47], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v48, 0x2420, v19
	v_exp_f32_e32 v46, v46
	v_exp_f32_e32 v47, v47
	v_cndmask_b32_e32 v42, v18, v42, vcc
	v_cndmask_b32_e32 v48, v18, v48, vcc
	v_pk_add_f32 v[46:47], v[46:47], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v46, v46
	v_rcp_f32_e32 v47, v47
	v_mul_f32_e32 v45, v45, v46
	v_mul_f32_e32 v41, v41, v47
	v_mul_f32_e32 v44, v44, v45
	v_mul_f32_e32 v40, v40, v41
	v_bfe_u32 v41, v44, 16, 1
	v_or_b32_e32 v45, 0x400000, v44
	v_bfe_u32 v46, v40, 16, 1
	v_add3_u32 v41, v41, v44, s5
	v_cmp_u_f32_e32 vcc, v44, v44
	v_or_b32_e32 v47, 0x400000, v40
	v_add3_u32 v46, v46, v40, s5
	v_cndmask_b32_e32 v41, v41, v45, vcc
	v_cmp_u_f32_e32 vcc, v40, v40
	v_lshrrev_b32_e32 v41, 16, v41
	s_nop 0
	v_cndmask_b32_e32 v40, v46, v47, vcc
	v_lshrrev_b32_e32 v40, 16, v40
	buffer_store_short v41, v42, s[0:3], 0 offen
	buffer_store_short v40, v48, s[0:3], 0 offen
	global_load_dword v40, v[0:1], off offset:76
	v_mov_b32_e32 v42, v55
	v_add_u32_e32 v47, 0x2600, v19
	v_add_u32_e32 v48, 0x2620, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v46, 0xffffff, v40
	v_lshlrev_b32_e32 v40, 2, v46
	buffer_load_dword v40, v40, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v46
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[44:45], v[40:41], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[42:43], v[42:43], v[44:45]
	v_pk_mul_f32 v[40:41], v[50:51], v[40:41]
	v_mov_b32_e32 v44, v43
	v_mov_b32_e32 v45, v41
	v_pk_mul_f32 v[44:45], v[44:45], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v46, v18, v47, vcc
	v_exp_f32_e32 v44, v44
	v_exp_f32_e32 v45, v45
	v_cndmask_b32_e32 v47, v18, v48, vcc
	v_pk_add_f32 v[44:45], v[44:45], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v44, v44
	v_rcp_f32_e32 v45, v45
	v_mul_f32_e32 v43, v43, v44
	v_mul_f32_e32 v41, v41, v45
	v_mul_f32_e32 v42, v42, v43
	v_mul_f32_e32 v40, v40, v41
	v_bfe_u32 v41, v42, 16, 1
	v_or_b32_e32 v43, 0x400000, v42
	v_bfe_u32 v44, v40, 16, 1
	v_add3_u32 v41, v41, v42, s5
	v_cmp_u_f32_e32 vcc, v42, v42
	v_or_b32_e32 v45, 0x400000, v40
	v_add3_u32 v44, v44, v40, s5
	v_cndmask_b32_e32 v41, v41, v43, vcc
	v_cmp_u_f32_e32 vcc, v40, v40
	v_lshrrev_b32_e32 v41, 16, v41
	v_mov_b32_e32 v42, v32
	v_cndmask_b32_e32 v40, v44, v45, vcc
	v_lshrrev_b32_e32 v40, 16, v40
	buffer_store_short v41, v46, s[0:3], 0 offen
	buffer_store_short v40, v47, s[0:3], 0 offen
	global_load_dword v40, v[0:1], off offset:128
	v_mov_b32_e32 v43, v24
	v_mov_b32_e32 v44, v36
	v_mov_b32_e32 v45, v28
	v_add_u32_e32 v24, 0x4000, v19
	v_add_u32_e32 v28, 0x4020, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v48, 0xffffff, v40
	v_lshlrev_b32_e32 v40, 2, v48
	buffer_load_dword v40, v40, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v48
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[46:47], v[40:41], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[40:41], v[40:41], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[42:43], v[42:43], v[46:47]
	v_pk_mul_f32 v[40:41], v[44:45], v[40:41]
	v_mov_b32_e32 v44, v43
	v_mov_b32_e32 v45, v41
	v_pk_mul_f32 v[44:45], v[44:45], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v24, v18, v24, vcc
	v_exp_f32_e32 v44, v44
	v_exp_f32_e32 v45, v45
	v_cndmask_b32_e32 v28, v18, v28, vcc
	v_pk_add_f32 v[44:45], v[44:45], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v32, v44
	v_rcp_f32_e32 v36, v45
	v_mul_f32_e32 v32, v43, v32
	v_mul_f32_e32 v36, v41, v36
	v_mul_f32_e32 v32, v42, v32
	v_mul_f32_e32 v36, v40, v36
	v_bfe_u32 v40, v32, 16, 1
	v_or_b32_e32 v41, 0x400000, v32
	v_bfe_u32 v42, v36, 16, 1
	v_add3_u32 v40, v40, v32, s5
	v_cmp_u_f32_e32 vcc, v32, v32
	v_or_b32_e32 v43, 0x400000, v36
	v_add3_u32 v42, v42, v36, s5
	v_cndmask_b32_e32 v32, v40, v41, vcc
	v_cmp_u_f32_e32 vcc, v36, v36
	v_lshrrev_b32_e32 v32, 16, v32
	s_nop 0
	v_cndmask_b32_e32 v36, v42, v43, vcc
	v_lshrrev_b32_e32 v36, 16, v36
	buffer_store_short v32, v24, s[0:3], 0 offen
	buffer_store_short v36, v28, s[0:3], 0 offen
	global_load_dword v24, v[0:1], off offset:132
	v_mov_b32_e32 v28, v37
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v40, 0xffffff, v24
	v_lshlrev_b32_e32 v24, 2, v40
	buffer_load_dword v32, v24, s[8:11], 0 offen
	v_mov_b32_e32 v24, v33
	v_cmp_gt_i32_e32 vcc, s14, v40
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[36:37], v[32:33], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[32:33], v[32:33], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[24:25], v[24:25], v[36:37]
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	v_mov_b32_e32 v32, v25
	v_mov_b32_e32 v33, v29
	v_pk_mul_f32 v[32:33], v[32:33], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v36, 0x4200, v19
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_add_u32_e32 v37, 0x4220, v19
	v_cndmask_b32_e32 v36, v18, v36, vcc
	v_cndmask_b32_e32 v37, v18, v37, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_mul_f32_e32 v25, v25, v32
	v_mul_f32_e32 v29, v29, v33
	v_mul_f32_e32 v24, v24, v25
	v_mul_f32_e32 v25, v28, v29
	v_bfe_u32 v28, v24, 16, 1
	v_or_b32_e32 v29, 0x400000, v24
	v_bfe_u32 v32, v25, 16, 1
	v_add3_u32 v28, v28, v24, s5
	v_cmp_u_f32_e32 vcc, v24, v24
	v_or_b32_e32 v33, 0x400000, v25
	v_add3_u32 v32, v32, v25, s5
	v_cndmask_b32_e32 v24, v28, v29, vcc
	v_cmp_u_f32_e32 vcc, v25, v25
	v_lshrrev_b32_e32 v24, 16, v24
	v_mov_b32_e32 v28, v34
	v_cndmask_b32_e32 v25, v32, v33, vcc
	v_lshrrev_b32_e32 v25, 16, v25
	buffer_store_short v24, v36, s[0:3], 0 offen
	buffer_store_short v25, v37, s[0:3], 0 offen
	global_load_dword v24, v[0:1], off offset:136
	v_mov_b32_e32 v29, v26
	v_mov_b32_e32 v32, v38
	v_mov_b32_e32 v33, v30
	v_add_u32_e32 v26, 0x4400, v19
	v_add_u32_e32 v30, 0x4420, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v40, 0xffffff, v24
	v_lshlrev_b32_e32 v24, 2, v40
	buffer_load_dword v24, v24, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v40
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[36:37], v[24:25], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[24:25], v[24:25], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[28:29], v[36:37]
	v_pk_mul_f32 v[24:25], v[32:33], v[24:25]
	v_mov_b32_e32 v32, v29
	v_mov_b32_e32 v33, v25
	v_pk_mul_f32 v[32:33], v[32:33], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v26, v18, v26, vcc
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_cndmask_b32_e32 v30, v18, v30, vcc
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_mul_f32_e32 v29, v29, v32
	v_mul_f32_e32 v25, v25, v33
	v_mul_f32_e32 v28, v28, v29
	v_mul_f32_e32 v24, v24, v25
	v_bfe_u32 v25, v28, 16, 1
	v_or_b32_e32 v29, 0x400000, v28
	v_bfe_u32 v32, v24, 16, 1
	v_add3_u32 v25, v25, v28, s5
	v_cmp_u_f32_e32 vcc, v28, v28
	v_or_b32_e32 v33, 0x400000, v24
	v_add3_u32 v32, v32, v24, s5
	v_cndmask_b32_e32 v25, v25, v29, vcc
	v_cmp_u_f32_e32 vcc, v24, v24
	v_lshrrev_b32_e32 v25, 16, v25
	s_nop 0
	v_cndmask_b32_e32 v24, v32, v33, vcc
	v_lshrrev_b32_e32 v24, 16, v24
	buffer_store_short v25, v26, s[0:3], 0 offen
	buffer_store_short v24, v30, s[0:3], 0 offen
	global_load_dword v24, v[0:1], off offset:140
	v_mov_b32_e32 v26, v35
	v_mov_b32_e32 v30, v39
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v32, 0xffffff, v24
	v_lshlrev_b32_e32 v24, 2, v32
	buffer_load_dword v24, v24, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v32
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[28:29], v[24:25], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[24:25], v[24:25], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[28:29]
	v_pk_mul_f32 v[24:25], v[30:31], v[24:25]
	v_mov_b32_e32 v28, v27
	v_mov_b32_e32 v29, v25
	v_pk_mul_f32 v[28:29], v[28:29], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v30, 0x4600, v19
	v_exp_f32_e32 v28, v28
	v_exp_f32_e32 v29, v29
	v_add_u32_e32 v31, 0x4620, v19
	v_cndmask_b32_e32 v30, v18, v30, vcc
	v_cndmask_b32_e32 v31, v18, v31, vcc
	v_pk_add_f32 v[28:29], v[28:29], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v28, v28
	v_rcp_f32_e32 v29, v29
	v_mul_f32_e32 v27, v27, v28
	v_mul_f32_e32 v25, v25, v29
	v_mul_f32_e32 v26, v26, v27
	v_mul_f32_e32 v24, v24, v25
	v_bfe_u32 v25, v26, 16, 1
	v_or_b32_e32 v27, 0x400000, v26
	v_bfe_u32 v28, v24, 16, 1
	v_add3_u32 v25, v25, v26, s5
	v_cmp_u_f32_e32 vcc, v26, v26
	v_or_b32_e32 v29, 0x400000, v24
	v_add3_u32 v28, v28, v24, s5
	v_cndmask_b32_e32 v25, v25, v27, vcc
	v_cmp_u_f32_e32 vcc, v24, v24
	v_lshrrev_b32_e32 v25, 16, v25
	v_mov_b32_e32 v26, v12
	v_cndmask_b32_e32 v24, v28, v29, vcc
	v_lshrrev_b32_e32 v24, 16, v24
	buffer_store_short v25, v30, s[0:3], 0 offen
	buffer_store_short v24, v31, s[0:3], 0 offen
	global_load_dword v24, v[0:1], off offset:192
	v_mov_b32_e32 v27, v4
	v_mov_b32_e32 v28, v20
	v_mov_b32_e32 v29, v8
	v_add_u32_e32 v4, 0x6000, v19
	v_add_u32_e32 v8, 0x6020, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v32, 0xffffff, v24
	v_lshlrev_b32_e32 v24, 2, v32
	buffer_load_dword v24, v24, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v32
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[30:31], v[24:25], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[24:25], v[24:25], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[26:27], v[30:31]
	v_pk_mul_f32 v[24:25], v[28:29], v[24:25]
	v_mov_b32_e32 v28, v27
	v_mov_b32_e32 v29, v25
	v_pk_mul_f32 v[28:29], v[28:29], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v4, v18, v4, vcc
	v_exp_f32_e32 v28, v28
	v_exp_f32_e32 v29, v29
	v_cndmask_b32_e32 v8, v18, v8, vcc
	v_pk_add_f32 v[28:29], v[28:29], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v28
	v_rcp_f32_e32 v20, v29
	v_mul_f32_e32 v12, v27, v12
	v_mul_f32_e32 v20, v25, v20
	v_mul_f32_e32 v12, v26, v12
	v_mul_f32_e32 v20, v24, v20
	v_bfe_u32 v24, v12, 16, 1
	v_or_b32_e32 v25, 0x400000, v12
	v_bfe_u32 v26, v20, 16, 1
	v_add3_u32 v24, v24, v12, s5
	v_cmp_u_f32_e32 vcc, v12, v12
	v_or_b32_e32 v27, 0x400000, v20
	v_add3_u32 v26, v26, v20, s5
	v_cndmask_b32_e32 v12, v24, v25, vcc
	v_cmp_u_f32_e32 vcc, v20, v20
	v_lshrrev_b32_e32 v12, 16, v12
	s_nop 0
	v_cndmask_b32_e32 v20, v26, v27, vcc
	v_lshrrev_b32_e32 v20, 16, v20
	buffer_store_short v12, v4, s[0:3], 0 offen
	buffer_store_short v20, v8, s[0:3], 0 offen
	global_load_dword v4, v[0:1], off offset:196
	v_mov_b32_e32 v8, v21
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v24, 0xffffff, v4
	v_lshlrev_b32_e32 v4, 2, v24
	buffer_load_dword v12, v4, s[8:11], 0 offen
	v_mov_b32_e32 v4, v13
	v_cmp_gt_i32_e32 vcc, s14, v24
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[20:21], v[12:13], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[20:21]
	v_pk_mul_f32 v[8:9], v[8:9], v[12:13]
	v_mov_b32_e32 v12, v5
	v_mov_b32_e32 v13, v9
	v_pk_mul_f32 v[12:13], v[12:13], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v20, 0x6200, v19
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_add_u32_e32 v21, 0x6220, v19
	v_cndmask_b32_e32 v20, v18, v20, vcc
	v_cndmask_b32_e32 v21, v18, v21, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v5, v5, v12
	v_mul_f32_e32 v9, v9, v13
	v_mul_f32_e32 v4, v4, v5
	v_mul_f32_e32 v5, v8, v9
	v_bfe_u32 v8, v4, 16, 1
	v_or_b32_e32 v9, 0x400000, v4
	v_bfe_u32 v12, v5, 16, 1
	v_add3_u32 v8, v8, v4, s5
	v_cmp_u_f32_e32 vcc, v4, v4
	v_or_b32_e32 v13, 0x400000, v5
	v_add3_u32 v12, v12, v5, s5
	v_cndmask_b32_e32 v4, v8, v9, vcc
	v_cmp_u_f32_e32 vcc, v5, v5
	v_lshrrev_b32_e32 v4, 16, v4
	v_mov_b32_e32 v8, v14
	v_cndmask_b32_e32 v5, v12, v13, vcc
	v_lshrrev_b32_e32 v5, 16, v5
	buffer_store_short v4, v20, s[0:3], 0 offen
	buffer_store_short v5, v21, s[0:3], 0 offen
	global_load_dword v4, v[0:1], off offset:200
	v_mov_b32_e32 v9, v6
	v_mov_b32_e32 v12, v22
	v_mov_b32_e32 v13, v10
	v_add_u32_e32 v6, 0x6400, v19
	v_add_u32_e32 v10, 0x6420, v19
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v24, 0xffffff, v4
	v_lshlrev_b32_e32 v4, 2, v24
	buffer_load_dword v4, v4, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v24
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[20:21], v[4:5], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[4:5], v[12:13], v[4:5]
	v_mov_b32_e32 v12, v9
	v_mov_b32_e32 v13, v5
	v_pk_mul_f32 v[12:13], v[12:13], s[4:5] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v6, v18, v6, vcc
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v10, v18, v10, vcc
	v_pk_add_f32 v[12:13], v[12:13], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v12, v12
	v_rcp_f32_e32 v13, v13
	v_mul_f32_e32 v9, v9, v12
	v_mul_f32_e32 v5, v5, v13
	v_mul_f32_e32 v8, v8, v9
	v_mul_f32_e32 v4, v4, v5
	v_bfe_u32 v5, v8, 16, 1
	v_or_b32_e32 v9, 0x400000, v8
	v_bfe_u32 v12, v4, 16, 1
	v_add3_u32 v5, v5, v8, s5
	v_cmp_u_f32_e32 vcc, v8, v8
	v_or_b32_e32 v13, 0x400000, v4
	v_add3_u32 v12, v12, v4, s5
	v_cndmask_b32_e32 v5, v5, v9, vcc
	v_cmp_u_f32_e32 vcc, v4, v4
	v_lshrrev_b32_e32 v5, 16, v5
	s_nop 0
	v_cndmask_b32_e32 v4, v12, v13, vcc
	v_lshrrev_b32_e32 v4, 16, v4
	buffer_store_short v5, v6, s[0:3], 0 offen
	buffer_store_short v4, v10, s[0:3], 0 offen
	global_load_dword v0, v[0:1], off offset:204
	v_mov_b32_e32 v6, v15
	v_mov_b32_e32 v10, v23
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v8, 0xffffff, v0
	v_lshlrev_b32_e32 v0, 2, v8
	buffer_load_dword v0, v0, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, s14, v8
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[2:3], v[0:1], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[0:1], v[0:1], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_pk_mul_f32 v[0:1], v[10:11], v[0:1]
	v_mov_b32_e32 v4, v3
	v_mov_b32_e32 v5, v1
	v_pk_mul_f32 v[4:5], v[4:5], s[4:5] op_sel_hi:[1,0]
	v_add_u32_e32 v6, 0x6600, v19
	v_exp_f32_e32 v4, v4
	v_exp_f32_e32 v5, v5
	v_add_u32_e32 v7, 0x6620, v19
	v_cndmask_b32_e32 v6, v18, v6, vcc
	v_cndmask_b32_e32 v7, v18, v7, vcc
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
	v_add3_u32 v1, v1, v2, s5
	v_cmp_u_f32_e32 vcc, v2, v2
	v_or_b32_e32 v5, 0x400000, v0
	v_add3_u32 v4, v4, v0, s5
	v_cndmask_b32_e32 v1, v1, v3, vcc
	v_cmp_u_f32_e32 vcc, v0, v0
	v_lshrrev_b32_e32 v1, 16, v1
	s_nop 0
	v_cndmask_b32_e32 v0, v4, v5, vcc
	v_lshrrev_b32_e32 v0, 16, v0
	buffer_store_short v1, v6, s[0:3], 0 offen
	buffer_store_short v0, v7, s[0:3], 0 offen
.LBB0_4:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s, .Lfunc_end0-a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s
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

	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.num_vgpr, 168
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.num_agpr, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.numbered_sgpr, 34
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.num_named_barrier, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.private_seg_size, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.uses_vcc, 1
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.uses_flat_scratch, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.has_dyn_sized_stack, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.has_recursion, 0
	.set .La8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.has_indirect_call, 0
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
    .name:           a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     40
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd1_ftz_s.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     168
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
