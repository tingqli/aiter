	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz
	.p2align	8
	.type	gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz,@function
gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz:
	s_load_dwordx4 s[12:15], s[0:1], 0x20
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[12:13], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s3, 31
	s_lshr_b32 s4, s4, 27
	s_add_i32 s4, s3, s4
	s_ashr_i32 s8, s4, 5
	s_andn2_b32 s4, s4, 31
	s_cmp_lg_u32 s3, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s3, s8, 0
	s_lshl_b32 s12, s3, 5
	s_cmp_ge_i32 s2, s12
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_9
	s_lshr_b32 s12, s12, 3
	s_and_b32 s13, s2, 7
	s_mul_i32 s12, s12, s13
	s_lshr_b32 s2, s2, 3
	s_add_i32 s2, s12, s2
	s_ashr_i32 s12, s2, 31
	s_lshr_b32 s12, s12, 27
	s_add_i32 s12, s2, s12
	s_ashr_i32 s18, s12, 5
	s_and_b32 s19, s12, 0xffffffe0
	s_cmp_lg_u32 s2, s19
	s_cselect_b64 s[12:13], -1, 0
	s_cmp_lt_i32 s2, 0
	s_load_dwordx8 s[4:11], s[0:1], 0x0
	s_cselect_b64 s[16:17], -1, 0
	s_and_b64 s[12:13], s[16:17], s[12:13]
	s_subb_u32 s12, s18, 0
	s_ashr_i32 s13, s12, 31
	s_sub_i32 s2, s2, s19
	s_lshl_b64 s[16:17], s[12:13], 2
	s_waitcnt lgkmcnt(0)
	s_add_u32 s10, s10, s16
	s_addc_u32 s11, s11, s17
	s_load_dword s10, s[10:11], 0x0
	s_lshr_b32 s3, s3, 1
	s_lshl_b32 s24, s12, 5
	s_lshl_b32 s12, s2, 7
	s_and_b32 s13, s3, 0x7fffffe0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s10, 12
	s_add_i32 s3, s12, s13
	v_and_b32_e32 v34, 15, v0
	s_add_i32 s20, s3, s2
	v_and_b32_e32 v3, 48, v0
	v_or_b32_e32 v7, s3, v34
	s_lshl_b32 s3, s20, 1
	s_mov_b32 s19, 0x27000
	v_or3_b32 v8, s3, v3, v34
	s_and_b32 s9, s9, 0xffff
	s_mov_b32 s10, 0x800000
	s_mov_b32 s11, s19
	v_lshlrev_b32_e32 v8, 2, v8
	buffer_load_dword v36, v8, s[8:11], 0 offen
	v_lshlrev_b32_e32 v4, 4, v0
	v_lshrrev_b32_e32 v2, 4, v0
	s_or_b32 s25, s24, 16
	v_xor_b32_e32 v8, v4, v0
	v_or_b32_e32 v5, s24, v2
	v_or_b32_e32 v6, s25, v2
	v_and_b32_e32 v8, 0xf0, v8
	s_and_b32 s17, s7, 0xffff
	s_mov_b32 s16, s6
	s_and_b32 s5, s5, 0xffff
	s_mov_b32 s6, -1
	s_mov_b32 s7, s19
	v_add_u32_e32 v7, s2, v7
	v_lshl_or_b32 v5, v5, 8, v8
	v_lshl_or_b32 v6, v6, 8, v8
	buffer_load_dwordx4 v[24:27], v5, s[4:7], 0 offen nt
	buffer_load_dwordx4 v[28:31], v6, s[4:7], 0 offen nt
	v_ashrrev_i32_e32 v5, 31, v7
	v_lshrrev_b32_e32 v5, 28, v5
	v_add_u32_e32 v6, v7, v5
	v_ashrrev_i32_e32 v8, 4, v6
	v_and_b32_e32 v6, -16, v6
	v_cmp_ne_u32_e32 vcc, v7, v6
	v_cmp_gt_i32_e64 s[2:3], 0, v7
	v_bfe_u32 v1, v0, 4, 2
	s_and_b64 vcc, s[2:3], vcc
	v_subbrev_co_u32_e32 v8, vcc, 0, v8, vcc
	v_lshlrev_b32_e32 v9, 8, v1
	v_sub_u32_e32 v6, v7, v6
	v_lshl_or_b32 v8, v8, 11, v9
	s_brev_b32 s18, 16
	v_lshl_add_u32 v18, v6, 4, v8
	buffer_load_dwordx4 v[14:17], v18, s[16:19], 0 offen nt
	v_and_b32_e32 v4, 0xf0, v4
	s_ashr_i32 s5, s20, 31
	v_lshl_or_b32 v19, v2, 8, v4
	v_or_b32_e32 v2, 16, v7
	s_lshr_b32 s2, s5, 27
	v_add_u32_e32 v4, v2, v5
	s_or_b32 s2, s2, s20
	v_ashrrev_i32_e32 v5, 4, v4
	v_and_b32_e32 v4, -16, v4
	s_add_i32 s7, s2, 16
	v_cmp_gt_i32_e32 vcc, 0, v2
	v_cmp_ne_u32_e64 s[2:3], v2, v4
	s_lshr_b32 s7, s7, 5
	s_and_b64 vcc, vcc, s[2:3]
	s_add_i32 s7, s7, s5
	v_sub_u32_e32 v2, v2, v4
	v_subbrev_co_u32_e32 v4, vcc, 0, v5, vcc
	s_lshl_b32 s2, s7, 6
	v_and_b32_e32 v6, 63, v0
	v_lshl_or_b32 v4, v4, 11, v9
	v_or3_b32 v3, s2, v3, v34
	v_lshlrev_b32_e32 v6, 2, v6
	v_lshl_add_u32 v20, v2, 4, v4
	v_lshlrev_b32_e32 v2, 2, v3
	v_xor_b32_e32 v57, 0x80, v6
	buffer_load_dword v58, v2, s[8:11], 0 offen
	buffer_load_dwordx4 v[10:13], v18, s[16:19], 0 offen offset:1024 nt
	buffer_load_dwordx4 v[6:9], v20, s[16:19], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[2:5], v20, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s4, 0x8080808
	s_mov_b32 s2, 0x80808080
	v_lshlrev_b32_e32 v56, 5, v1
	v_lshlrev_b32_e32 v59, 4, v34
	v_lshlrev_b32_e32 v60, 8, v34
	s_mov_b32 s3, 0x5010400
	s_mov_b32 s16, 0x7030602
	s_load_dwordx4 s[20:23], s[0:1], 0x30
	s_load_dword s17, s[0:1], 0x38
	s_load_dwordx4 s[8:11], s[0:1], 0x40
	s_mov_b32 s7, s19
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s22, s6
	s_and_b32 s21, s21, 0xffff
	s_mov_b32 s23, s19
	s_and_b32 s5, s11, 0xffff
	s_mov_b32 s0, 0x20000
	s_waitcnt vmcnt(7)
	v_max_u32_sdwa v21, v36, v36 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	ds_swizzle_b32 v22, v21 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v18, v22, v21
	ds_bpermute_b32 v20, v57, v18
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v35, v20, v18
	v_sub_u32_sdwa v18, v35, v36 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_sdwa v46, v35, v36 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	s_waitcnt vmcnt(6)
	ds_write_b128 v19, v[24:27]
	s_waitcnt vmcnt(5)
	ds_write_b128 v19, v[28:31] offset:4096
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s4
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cndmask_b32_e64 v40, v20, 0, vcc
	v_cndmask_b32_e64 v41, v19, 0, vcc
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_min_i32_e32 v36, 11, v46
	v_mul_lo_u32 v42, v36, s4
	v_sub_u32_e32 v48, 0x7c787470, v42
	v_cmp_lt_i32_e32 vcc, 11, v46
	s_waitcnt vmcnt(4)
	v_and_b32_e32 v18, 0x7070707, v14
	v_perm_b32 v18, v41, v40, v18
	v_lshlrev_b32_e32 v20, 4, v14
	v_and_or_b32 v20, v20, s2, v18
	v_add_u32_e32 v18, 0x7f7f7f7f, v18
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	v_and_b32_e32 v18, v18, v20
	v_xor_b32_e32 v20, v56, v59
	v_or_b32_e32 v20, v60, v20
	ds_read2st64_b64 v[22:25], v20 offset1:8
	v_lshrrev_b32_e32 v19, 4, v14
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v19, v41, v40, v19
	v_and_or_b32 v14, v14, s2, v19
	v_add_u32_e32 v19, 0x7f7f7f7f, v19
	v_or_b32_e32 v19, 0x7f7f7f7f, v19
	v_and_b32_e32 v14, v19, v14
	v_perm_b32 v26, v14, v18, s3
	v_perm_b32 v27, v14, v18, s16
	v_and_b32_e32 v14, 0x7070707, v15
	v_perm_b32 v14, v41, v40, v14
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[22:23], v[26:27], 0
	v_cndmask_b32_e64 v62, v48, 0, vcc
	s_waitcnt vmcnt(3)
	v_max_u32_sdwa v52, v58, v58 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_3 src1_sel:BYTE_1
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[24:25], v[26:27], 0
	v_lshrrev_b32_e32 v26, 4, v15
	v_and_b32_e32 v26, 0x7070707, v26
	v_perm_b32 v37, v41, v40, v26
	v_lshlrev_b32_e32 v26, 4, v15
	v_and_or_b32 v38, v26, s2, v14
	v_or_b32_e32 v26, 8, v56
	v_xor_b32_e32 v26, v26, v59
	v_or_b32_e32 v26, v60, v26
	ds_read2st64_b64 v[26:29], v26 offset1:8
	v_add_u32_e32 v14, 0x7f7f7f7f, v14
	v_or_b32_e32 v14, 0x7f7f7f7f, v14
	v_and_b32_e32 v38, v14, v38
	v_and_or_b32 v14, v15, s2, v37
	v_add_u32_e32 v15, 0x7f7f7f7f, v37
	v_or_b32_e32 v15, 0x7f7f7f7f, v15
	v_and_b32_e32 v15, v15, v14
	v_perm_b32 v14, v15, v38, s3
	v_perm_b32 v15, v15, v38, s16
	s_waitcnt lgkmcnt(0)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[26:27], v[14:15], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[28:29], v[14:15], v[30:33]
	v_and_b32_e32 v14, 0x7070707, v16
	v_perm_b32 v14, v41, v40, v14
	v_lshrrev_b32_e32 v15, 4, v16
	v_lshlrev_b32_e32 v30, 4, v16
	v_and_or_b32 v43, v30, s2, v14
	v_or_b32_e32 v30, 16, v56
	v_xor_b32_e32 v30, v30, v59
	v_or_b32_e32 v30, v60, v30
	ds_read2st64_b64 v[30:33], v30 offset1:8
	v_and_b32_e32 v15, 0x7070707, v15
	v_add_u32_e32 v14, 0x7f7f7f7f, v14
	v_perm_b32 v15, v41, v40, v15
	v_or_b32_e32 v14, 0x7f7f7f7f, v14
	v_and_b32_e32 v43, v14, v43
	v_and_or_b32 v14, v16, s2, v15
	v_add_u32_e32 v15, 0x7f7f7f7f, v15
	v_or_b32_e32 v15, 0x7f7f7f7f, v15
	v_and_b32_e32 v15, v15, v14
	v_perm_b32 v14, v15, v43, s3
	v_perm_b32 v15, v15, v43, s16
	v_sub_u32_e32 v16, 0x6c686080, v42
	v_and_b32_e32 v47, 0xffffff00, v16
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[30:31], v[14:15], v[18:21]
	v_lshlrev_b32_e32 v16, 4, v17
	v_cndmask_b32_e64 v61, v47, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[32:33], v[14:15], v[36:39]
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v14, 0x7070707, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v14, v41, v40, v14
	v_perm_b32 v15, v41, v40, v15
	v_or_b32_e32 v40, 24, v56
	v_xor_b32_e32 v40, v40, v59
	v_or_b32_e32 v40, v60, v40
	ds_read2st64_b64 v[40:43], v40 offset1:8
	v_and_or_b32 v16, v16, s2, v14
	v_add_u32_e32 v14, 0x7f7f7f7f, v14
	v_or_b32_e32 v14, 0x7f7f7f7f, v14
	v_and_b32_e32 v14, v14, v16
	v_and_or_b32 v16, v17, s2, v15
	v_add_u32_e32 v15, 0x7f7f7f7f, v15
	v_or_b32_e32 v15, 0x7f7f7f7f, v15
	v_and_b32_e32 v15, v15, v16
	v_perm_b32 v44, v15, v14, s3
	v_perm_b32 v45, v15, v14, s16
	s_waitcnt lgkmcnt(0)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[40:41], v[44:45], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[44:45], v[36:39]
	s_waitcnt vmcnt(2)
	s_nop 1
	v_lshrrev_b32_e32 v37, 4, v10
	v_and_b32_e32 v36, 0x7070707, v10
	v_and_b32_e32 v37, 0x7070707, v37
	v_perm_b32 v36, v62, v61, v36
	v_perm_b32 v44, v62, v61, v37
	v_lshlrev_b32_e32 v37, 4, v10
	v_and_or_b32 v45, v37, s2, v36
	v_add_u32_e32 v46, 0x7f7f7f7f, v36
	v_or_b32_e32 v36, 0x80, v56
	v_xor_b32_e32 v36, v36, v59
	v_or_b32_e32 v36, v60, v36
	ds_read2st64_b64 v[36:39], v36 offset1:8
	v_and_or_b32 v10, v10, s2, v44
	v_add_u32_e32 v44, 0x7f7f7f7f, v44
	v_or_b32_e32 v46, 0x7f7f7f7f, v46
	v_or_b32_e32 v44, 0x7f7f7f7f, v44
	v_and_b32_e32 v45, v46, v45
	v_and_b32_e32 v10, v44, v10
	v_perm_b32 v44, v10, v45, s3
	v_perm_b32 v45, v10, v45, s16
	v_and_b32_e32 v10, 0x7070707, v11
	v_perm_b32 v10, v62, v61, v10
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[36:37], v[44:45], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[38:39], v[44:45], v[18:21]
	v_lshrrev_b32_e32 v44, 4, v11
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v48, v62, v61, v44
	v_lshlrev_b32_e32 v44, 4, v11
	v_and_or_b32 v49, v44, s2, v10
	v_or_b32_e32 v44, 0x88, v56
	v_xor_b32_e32 v44, v44, v59
	v_or_b32_e32 v44, v60, v44
	ds_read2st64_b64 v[44:47], v44 offset1:8
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v49, v10, v49
	v_and_or_b32 v10, v11, s2, v48
	v_add_u32_e32 v11, 0x7f7f7f7f, v48
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v10
	v_perm_b32 v10, v11, v49, s3
	v_perm_b32 v11, v11, v49, s16
	v_lshlrev_b32_e32 v48, 4, v12
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[44:45], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[46:47], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v12
	v_perm_b32 v10, v62, v61, v10
	v_and_or_b32 v53, v48, s2, v10
	v_or_b32_e32 v48, 0x90, v56
	v_xor_b32_e32 v48, v48, v59
	v_or_b32_e32 v48, v60, v48
	ds_read2st64_b64 v[48:51], v48 offset1:8
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_perm_b32 v11, v62, v61, v11
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v53, v10, v53
	v_and_or_b32 v10, v12, s2, v11
	ds_swizzle_b32 v12, v52 offset:swizzle(SWAP,16)
	v_add_u32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v10
	v_perm_b32 v10, v11, v53, s3
	v_perm_b32 v11, v11, v53, s16
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v12, v12, v52
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[48:49], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[50:51], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_perm_b32 v10, v62, v61, v10
	v_and_b32_e32 v11, 0x7070707, v11
	v_lshlrev_b32_e32 v18, 4, v13
	v_perm_b32 v11, v62, v61, v11
	v_and_or_b32 v61, v18, s2, v10
	v_or_b32_e32 v18, 0x98, v56
	v_xor_b32_e32 v18, v18, v59
	v_or_b32_e32 v18, v60, v18
	ds_read2st64_b64 v[18:21], v18 offset1:8
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v56, v10, v61
	v_and_or_b32 v10, v13, s2, v11
	ds_bpermute_b32 v13, v57, v12
	v_add_u32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v10
	v_perm_b32 v10, v11, v56, s3
	v_perm_b32 v11, v11, v56, s16
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v59, v13, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[18:19], v[10:11], v[14:17]
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[20:21], v[10:11], v[52:55]
	s_nop 2
	v_sub_u32_sdwa v52, v59, v58 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_1
	v_min_i32_e32 v53, 11, v52
	v_mul_lo_u32 v53, v53, s4
	v_sub_u32_e32 v54, 0x6c686080, v53
	v_sub_u32_e32 v53, 0x7c787470, v53
	v_cmp_lt_i32_e32 vcc, 11, v52
	v_and_b32_e32 v54, 0xffffff00, v54
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v52, 0x7070707, v6
	v_cndmask_b32_e64 v61, v53, 0, vcc
	v_lshrrev_b32_e32 v53, 4, v6
	v_cndmask_b32_e64 v60, v54, 0, vcc
	v_and_b32_e32 v53, 0x7070707, v53
	v_perm_b32 v52, v61, v60, v52
	v_perm_b32 v53, v61, v60, v53
	v_lshlrev_b32_e32 v54, 4, v6
	v_and_or_b32 v54, v54, s2, v52
	v_add_u32_e32 v52, 0x7f7f7f7f, v52
	v_and_or_b32 v6, v6, s2, v53
	v_add_u32_e32 v53, 0x7f7f7f7f, v53
	v_or_b32_e32 v52, 0x7f7f7f7f, v52
	v_or_b32_e32 v53, 0x7f7f7f7f, v53
	v_and_b32_e32 v52, v52, v54
	v_and_b32_e32 v6, v53, v6
	v_perm_b32 v56, v6, v52, s3
	v_perm_b32 v57, v6, v52, s16
	v_and_b32_e32 v6, 0x7070707, v7
	v_perm_b32 v6, v61, v60, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[22:23], v[56:57], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[56:57], 0
	v_lshrrev_b32_e32 v56, 4, v7
	v_lshlrev_b32_e32 v57, 4, v7
	v_and_b32_e32 v56, 0x7070707, v56
	v_and_or_b32 v57, v57, s2, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v56, v61, v60, v56
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v57, v6, v57
	v_and_or_b32 v6, v7, s2, v56
	v_add_u32_e32 v7, 0x7f7f7f7f, v56
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v57, s3
	v_perm_b32 v7, v7, v57, s16
	v_sub_u32_sdwa v56, v59, v58 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_3
	v_cmp_lt_i32_e32 vcc, 11, v56
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[26:27], v[6:7], v[52:55]
	v_min_i32_e32 v26, 11, v56
	v_mul_lo_u32 v57, v26, s4
	v_lshlrev_b32_e32 v26, 4, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[28:29], v[6:7], v[22:25]
	v_and_b32_e32 v6, 0x7070707, v8
	v_perm_b32 v6, v61, v60, v6
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v26, v26, s2, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v7, v61, v60, v7
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v26, v6, v26
	v_and_or_b32 v6, v8, s2, v7
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v26, s3
	v_perm_b32 v7, v7, v26, s16
	v_sub_u32_e32 v8, 0x6c686080, v57
	s_mov_b32 s4, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[30:31], v[6:7], v[52:55]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[32:33], v[6:7], v[22:25]
	v_and_b32_e32 v6, 0x7070707, v9
	s_nop 0
	v_and_b32_e32 v52, 0xffffff00, v8
	v_perm_b32 v6, v61, v60, v6
	v_lshrrev_b32_e32 v7, 4, v9
	v_lshlrev_b32_e32 v8, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v8, v8, s2, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v7, v61, v60, v7
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v8
	v_and_or_b32 v8, v9, s2, v7
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v8
	v_sub_u32_e32 v53, 0x7c787470, v57
	v_perm_b32 v30, v7, v6, s3
	v_perm_b32 v31, v7, v6, s16
	v_cndmask_b32_e64 v32, v52, 0, vcc
	v_cndmask_b32_e64 v33, v53, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[40:41], v[30:31], v[26:29]
	v_cmp_lt_u32_e32 vcc, 5, v35
	s_waitcnt vmcnt(0)
	s_nop 0
	v_and_b32_e32 v26, 0x7070707, v2
	v_perm_b32 v26, v33, v32, v26
	v_lshrrev_b32_e32 v27, 4, v2
	v_lshlrev_b32_e32 v28, 4, v2
	v_and_b32_e32 v27, 0x7070707, v27
	v_and_or_b32 v28, v28, s2, v26
	v_add_u32_e32 v26, 0x7f7f7f7f, v26
	v_perm_b32 v27, v33, v32, v27
	v_or_b32_e32 v26, 0x7f7f7f7f, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[30:31], v[22:25]
	v_and_b32_e32 v28, v26, v28
	v_add_u32_e32 v26, 0x7f7f7f7f, v27
	v_and_or_b32 v2, v2, s2, v27
	v_or_b32_e32 v26, 0x7f7f7f7f, v26
	v_and_b32_e32 v2, v26, v2
	v_perm_b32 v26, v2, v28, s3
	v_perm_b32 v27, v2, v28, s16
	v_and_b32_e32 v2, 0x7070707, v3
	v_perm_b32 v2, v33, v32, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[36:37], v[26:27], v[6:9]
	v_lshlrev_b32_e32 v36, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[38:39], v[26:27], v[22:25]
	v_lshrrev_b32_e32 v26, 4, v3
	v_lshlrev_b32_e32 v27, 4, v3
	v_and_b32_e32 v26, 0x7070707, v26
	v_and_or_b32 v27, v27, s2, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_perm_b32 v26, v33, v32, v26
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v27, v2, v27
	v_and_or_b32 v2, v3, s2, v26
	v_add_u32_e32 v3, 0x7f7f7f7f, v26
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v2
	v_perm_b32 v2, v3, v27, s3
	v_perm_b32 v3, v3, v27, s16
	v_lshlrev_b32_e32 v26, 4, v4
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[44:45], v[2:3], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[46:47], v[2:3], v[22:25]
	v_and_b32_e32 v2, 0x7070707, v4
	v_perm_b32 v2, v33, v32, v2
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_and_or_b32 v26, v26, s2, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_perm_b32 v3, v33, v32, v3
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v26, v2, v26
	v_and_or_b32 v2, v4, s2, v3
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v2
	v_perm_b32 v2, v3, v26, s3
	v_perm_b32 v3, v3, v26, s16
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[48:49], v[2:3], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[50:51], v[2:3], v[22:25]
	v_lshlrev_b32_e32 v3, 2, v1
	v_or_b32_e32 v4, s24, v3
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dwordx4 v[26:29], v4, s[4:7], 0 offen
	v_lshrrev_b32_e32 v4, 4, v5
	v_or_b32_e32 v3, s25, v3
	v_and_b32_e32 v2, 0x7070707, v5
	v_and_b32_e32 v4, 0x7070707, v4
	v_lshlrev_b32_e32 v3, 2, v3
	v_perm_b32 v2, v33, v32, v2
	v_perm_b32 v4, v33, v32, v4
	buffer_load_dwordx4 v[30:33], v3, s[4:7], 0 offen
	v_and_or_b32 v3, v36, s2, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v2, v2, v3
	v_and_or_b32 v3, v5, s2, v4
	v_add_u32_e32 v4, 0x7f7f7f7f, v4
	v_or_b32_e32 v4, 0x7f7f7f7f, v4
	v_and_b32_e32 v3, v4, v3
	v_perm_b32 v40, v3, v2, s3
	v_perm_b32 v41, v3, v2, s16
	v_lshrrev_b32_e32 v3, 5, v0
	v_or_b32_e32 v2, s24, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[18:19], v[40:41], v[6:9]
	s_and_b32 s5, s15, 0xffff
	s_mov_b32 s4, s14
	v_lshlrev_b32_e32 v19, 2, v2
	v_or_b32_e32 v2, s25, v3
	v_lshlrev_b32_e32 v42, 2, v2
	buffer_load_dword v18, v19, s[4:7], 0 offen
	buffer_load_dword v9, v19, s[4:7], 0 offen offset:32
	buffer_load_dword v7, v42, s[4:7], 0 offen
	buffer_load_dword v5, v19, s[4:7], 0 offen offset:96
	buffer_load_dword v8, v19, s[20:23], 0 offen
	buffer_load_dword v6, v19, s[20:23], 0 offen offset:32
	buffer_load_dword v4, v42, s[20:23], 0 offen
	buffer_load_dword v2, v19, s[20:23], 0 offen offset:96
	v_mov_b32_e32 v19, 0xfd800000
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[20:21], v[40:41], v[22:25]
	v_lshlrev_b32_e32 v0, 1, v0
	v_and_b32_e32 v0, 62, v0
	s_nop 0
	v_lshl_add_u32 v24, v35, 23, v19
	v_lshlrev_b32_e64 v25, v35, s0
	v_cndmask_b32_e32 v24, v25, v24, vcc
	v_lshl_add_u32 v19, v59, 23, v19
	v_lshlrev_b32_e64 v25, v59, s0
	v_cmp_lt_u32_e32 vcc, 5, v59
	s_waitcnt vmcnt(9)
	v_pk_mul_f32 v[42:43], v[24:25], v[26:27] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v40, v25, v19, vcc
	v_pk_mul_f32 v[26:27], v[40:41], v[26:27] op_sel_hi:[0,1]
	v_or_b32_e32 v19, s13, v34
	v_pk_mul_f32 v[14:15], v[14:15], v[42:43]
	v_pk_mul_f32 v[42:43], v[24:25], v[28:29] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[36:37], v[26:27]
	v_lshlrev_b32_e32 v19, 2, v19
	s_waitcnt vmcnt(8)
	v_pk_mul_f32 v[36:37], v[24:25], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[24:25], v[24:25], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[40:41], v[28:29] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[24:25]
	v_pk_mul_f32 v[24:25], v[40:41], v[30:31] op_sel_hi:[0,1]
	v_lshl_add_u32 v1, v1, 11, v19
	v_pk_mul_f32 v[16:17], v[16:17], v[42:43]
	v_pk_mul_f32 v[28:29], v[38:39], v[28:29]
	v_pk_mul_f32 v[20:21], v[20:21], v[24:25]
	v_pk_mul_f32 v[24:25], v[40:41], v[32:33] op_sel_hi:[0,1]
	ds_write2_b32 v1, v14, v26 offset1:16
	ds_write2_b32 v1, v15, v27 offset0:128 offset1:144
	v_add_u32_e32 v14, 0x400, v1
	v_pk_mul_f32 v[22:23], v[22:23], v[24:25]
	ds_write2_b32 v14, v16, v28 offset1:16
	ds_write2_b32 v14, v17, v29 offset0:128 offset1:144
	v_add_u32_e32 v14, 0x2000, v1
	v_add_u32_e32 v1, 0x2400, v1
	ds_write2_b32 v1, v12, v22 offset1:16
	ds_write2_b32 v1, v13, v23 offset0:128 offset1:144
	s_waitcnt vmcnt(7)
	v_and_b32_e32 v1, 0xffffff, v18
	v_pk_mul_f32 v[10:11], v[10:11], v[36:37]
	v_cmp_gt_i32_e32 vcc, s17, v1
	v_lshlrev_b32_e32 v1, 2, v0
	ds_write2_b32 v14, v10, v20 offset1:16
	ds_write2_b32 v14, v11, v21 offset0:128 offset1:144
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_3
	v_lshl_or_b32 v12, v3, 9, v1
	ds_read_b64 v[10:11], v12
	s_movk_i32 s2, 0x7fff
	v_lshl_add_u32 v13, v18, 12, s12
	v_or_b32_e32 v13, v13, v0
	s_mov_b32 s3, 0x7060302
	s_waitcnt vmcnt(3) lgkmcnt(0)
	v_pk_mul_f32 v[10:11], v[10:11], v[8:9] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v14, v10, 16, 1
	v_or_b32_e32 v15, 0x400000, v10
	v_add3_u32 v14, v14, v10, s2
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v14, v15, vcc
	v_bfe_u32 v14, v11, 16, 1
	v_add3_u32 v14, v14, v11, s2
	v_or_b32_e32 v15, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v11, v14, v15, vcc
	v_perm_b32 v14, v11, v10, s3
	v_lshlrev_b32_e32 v10, 1, v13
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshl_add_u64 v[10:11], s[8:9], 0, v[10:11]
	global_atomic_pk_add_bf16 v[10:11], v14, off
	ds_read_b64 v[12:13], v12 offset:256
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[12:13], v[12:13], v[8:9] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v8, v12, 16, 1
	v_add3_u32 v8, v8, v12, s2
	v_or_b32_e32 v14, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	v_bfe_u32 v12, v13, 16, 1
	v_add3_u32 v12, v12, v13, s2
	v_cndmask_b32_e32 v8, v8, v14, vcc
	v_or_b32_e32 v14, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v12, v14, vcc
	v_perm_b32 v8, v12, v8, s3
	global_atomic_pk_add_bf16 v[10:11], v8, off offset:128
.LBB0_3:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v8, 0xffffff, v9
	v_cmp_gt_i32_e32 vcc, s17, v8
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_5
	v_lshl_or_b32 v12, v3, 9, v1
	ds_read_b64 v[10:11], v12 offset:4096
	v_lshl_add_u32 v8, v9, 12, s12
	v_or_b32_e32 v13, v8, v0
	s_movk_i32 s2, 0x7fff
	s_mov_b32 s3, 0x7060302
	s_waitcnt vmcnt(2) lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[10:11], v[6:7] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_or_b32_e32 v11, 0x400000, v8
	v_add3_u32 v10, v10, v8, s2
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s2
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v10, v9, v8, s3
	v_lshlrev_b32_e32 v8, 1, v13
	v_ashrrev_i32_e32 v9, 31, v8
	v_lshl_add_u64 v[8:9], s[8:9], 0, v[8:9]
	global_atomic_pk_add_bf16 v[8:9], v10, off
	ds_read_b64 v[10:11], v12 offset:4352
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[10:11], v[10:11], v[6:7] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v6, v10, 16, 1
	v_add3_u32 v6, v6, v10, s2
	v_or_b32_e32 v12, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	v_bfe_u32 v10, v11, 16, 1
	v_add3_u32 v10, v10, v11, s2
	v_cndmask_b32_e32 v6, v6, v12, vcc
	v_or_b32_e32 v12, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v10, v12, vcc
	v_perm_b32 v6, v10, v6, s3
	global_atomic_pk_add_bf16 v[8:9], v6, off offset:128
.LBB0_5:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v6, 0xffffff, v7
	v_cmp_gt_i32_e32 vcc, s17, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_7
	v_lshl_or_b32 v10, v3, 9, v1
	ds_read_b64 v[8:9], v10 offset:8192
	v_lshl_add_u32 v6, v7, 12, s12
	v_or_b32_e32 v11, v6, v0
	s_movk_i32 s2, 0x7fff
	s_mov_b32 s3, 0x7060302
	s_waitcnt vmcnt(1) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[8:9], v[4:5] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v8, v6, 16, 1
	v_or_b32_e32 v9, 0x400000, v6
	v_add3_u32 v8, v8, v6, s2
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	v_bfe_u32 v8, v7, 16, 1
	v_add3_u32 v8, v8, v7, s2
	v_or_b32_e32 v9, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v8, v9, vcc
	v_perm_b32 v8, v7, v6, s3
	v_lshlrev_b32_e32 v6, 1, v11
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v8, off
	ds_read_b64 v[8:9], v10 offset:8448
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v4, v8, 16, 1
	v_add3_u32 v4, v4, v8, s2
	v_or_b32_e32 v10, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	v_bfe_u32 v8, v9, 16, 1
	v_add3_u32 v8, v8, v9, s2
	v_cndmask_b32_e32 v4, v4, v10, vcc
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v8, v10, vcc
	v_perm_b32 v4, v8, v4, s3
	global_atomic_pk_add_bf16 v[6:7], v4, off offset:128
.LBB0_7:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v4, 0xffffff, v5
	v_cmp_gt_i32_e32 vcc, s17, v4
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshl_or_b32 v3, v3, 9, v1
	ds_read_b64 v[6:7], v3 offset:12288
	v_lshl_add_u32 v1, v5, 12, s12
	v_or_b32_e32 v4, v1, v0
	s_movk_i32 s0, 0x7fff
	s_mov_b32 s1, 0x7060302
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_pk_mul_f32 v[0:1], v[6:7], v[2:3] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v5, v0, 16, 1
	v_or_b32_e32 v6, 0x400000, v0
	v_add3_u32 v5, v5, v0, s0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v5, v6, vcc
	v_bfe_u32 v5, v1, 16, 1
	v_add3_u32 v5, v5, v1, s0
	v_or_b32_e32 v6, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v5, v6, vcc
	v_perm_b32 v5, v1, v0, s1
	v_lshlrev_b32_e32 v0, 1, v4
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[8:9], 0, v[0:1]
	global_atomic_pk_add_bf16 v[0:1], v5, off
	ds_read_b64 v[4:5], v3 offset:12544
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[2:3], v[4:5], v[2:3] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s0
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s0
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_perm_b32 v2, v3, v2, s1
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_9:
	s_endpgm
.Lfunc_end0:
	.size	gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz, .Lfunc_end0-gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz
		.amdhsa_group_segment_fixed_size 16384
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 80
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
		.amdhsa_next_free_vgpr 97
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 64
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

	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.num_vgpr, 63
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.num_agpr, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.numbered_sgpr, 26
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.num_named_barrier, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.private_seg_size, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.uses_vcc, 1
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.uses_flat_scratch, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.has_dyn_sized_stack, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.has_recursion, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.has_indirect_call, 0
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
        .size:           4
        .value_kind:     by_value
      - .offset:         60
        .size:           4
        .value_kind:     by_value
      - .offset:         64
        .size:           8
        .value_kind:     by_value
      - .offset:         72
        .size:           8
        .value_kind:     by_value
    .group_segment_fixed_size: 16384
    .kernarg_segment_align: 8
    .kernarg_segment_size: 80
    .max_flat_workgroup_size: 256
    .name:           gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     32
    .sgpr_spill_count: 0
    .symbol:         gemm2_a8w4_port_ne256_h4096_i256_bm32_tn128_ftz.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     63
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
