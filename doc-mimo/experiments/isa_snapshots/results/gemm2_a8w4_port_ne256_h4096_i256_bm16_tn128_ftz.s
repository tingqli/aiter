	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz
	.p2align	8
	.type	gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz,@function
gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz:
	s_load_dwordx4 s[12:15], s[0:1], 0x20
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[12:13], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s3, 31
	s_lshr_b32 s4, s4, 28
	s_add_i32 s4, s3, s4
	s_ashr_i32 s8, s4, 4
	s_and_b32 s4, s4, -16
	s_cmp_lg_u32 s3, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s3, s8, 0
	s_lshl_b32 s12, s3, 5
	s_cmp_ge_i32 s2, s12
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_5
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
	s_lshl_b32 s13, s2, 7
	s_and_b32 s24, s3, 0x7fffffe0
	s_add_i32 s3, s13, s24
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s10, 12
	s_add_i32 s18, s3, s2
	s_ashr_i32 s20, s18, 31
	s_lshr_b32 s21, s20, 27
	s_or_b32 s21, s21, s18
	s_add_i32 s21, s21, 16
	v_and_b32_e32 v3, 48, v0
	v_and_b32_e32 v1, 15, v0
	s_lshr_b32 s21, s21, 5
	s_lshl_b32 s18, s18, 1
	s_mov_b32 s19, 0x27000
	s_add_i32 s21, s21, s20
	v_or3_b32 v6, s18, v3, v1
	s_and_b32 s9, s9, 0xffff
	s_mov_b32 s10, 0x800000
	s_mov_b32 s11, s19
	v_lshlrev_b32_e32 v6, 2, v6
	s_lshl_b32 s18, s21, 6
	buffer_load_dword v17, v6, s[8:11], 0 offen
	v_or3_b32 v3, s18, v3, v1
	v_lshlrev_b32_e32 v4, 4, v0
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshrrev_b32_e32 v2, 4, v0
	s_lshl_b32 s25, s12, 4
	buffer_load_dword v26, v3, s[8:11], 0 offen
	v_xor_b32_e32 v6, v4, v0
	v_or_b32_e32 v5, s25, v2
	v_and_b32_e32 v6, 0xf0, v6
	s_and_b32 s17, s7, 0xffff
	s_mov_b32 s16, s6
	s_and_b32 s5, s5, 0xffff
	s_mov_b32 s6, -1
	s_mov_b32 s7, s19
	v_lshl_or_b32 v5, v5, 8, v6
	buffer_load_dwordx4 v[28:31], v5, s[4:7], 0 offen nt
	v_or_b32_e32 v3, s3, v1
	v_add_u32_e32 v3, s2, v3
	v_ashrrev_i32_e32 v5, 31, v3
	v_lshrrev_b32_e32 v5, 28, v5
	v_add_u32_e32 v6, v3, v5
	v_ashrrev_i32_e32 v7, 4, v6
	v_and_b32_e32 v6, -16, v6
	v_cmp_ne_u32_e32 vcc, v3, v6
	v_cmp_gt_i32_e64 s[2:3], 0, v3
	v_bfe_u32 v14, v0, 4, 2
	s_and_b64 vcc, s[2:3], vcc
	v_subbrev_co_u32_e32 v7, vcc, 0, v7, vcc
	v_lshlrev_b32_e32 v8, 8, v14
	v_sub_u32_e32 v6, v3, v6
	v_lshl_or_b32 v7, v7, 11, v8
	s_brev_b32 s18, 16
	v_lshl_add_u32 v15, v6, 4, v7
	buffer_load_dwordx4 v[18:21], v15, s[16:19], 0 offen nt
	v_and_b32_e32 v4, 0xf0, v4
	v_lshl_or_b32 v22, v2, 8, v4
	v_or_b32_e32 v2, 16, v3
	v_add_u32_e32 v3, v2, v5
	v_ashrrev_i32_e32 v4, 4, v3
	v_and_b32_e32 v3, -16, v3
	s_load_dwordx4 s[20:23], s[0:1], 0x30
	s_load_dword s2, s[0:1], 0x38
	s_load_dwordx4 s[8:11], s[0:1], 0x40
	v_cmp_gt_i32_e32 vcc, 0, v2
	v_cmp_ne_u32_e64 s[0:1], v2, v3
	s_and_b64 vcc, vcc, s[0:1]
	v_and_b32_e32 v6, 63, v0
	v_sub_u32_e32 v2, v2, v3
	v_subbrev_co_u32_e32 v3, vcc, 0, v4, vcc
	v_lshlrev_b32_e32 v6, 2, v6
	v_lshl_or_b32 v3, v3, 11, v8
	v_xor_b32_e32 v16, 0x80, v6
	v_lshl_add_u32 v23, v2, 4, v3
	buffer_load_dwordx4 v[10:13], v15, s[16:19], 0 offen offset:1024 nt
	buffer_load_dwordx4 v[6:9], v23, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[2:5], v23, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s4, 0x8080808
	s_mov_b32 s0, 0x80808080
	v_lshlrev_b32_e32 v27, 5, v14
	s_mov_b32 s1, 0x5010400
	s_mov_b32 s3, 0x7030602
	v_lshlrev_b32_e32 v32, 8, v1
	s_waitcnt lgkmcnt(0)
	s_and_b32 s5, s11, 0xffff
	s_and_b32 s21, s21, 0xffff
	s_mov_b32 s22, s6
	s_mov_b32 s23, s19
	s_waitcnt vmcnt(6)
	v_max_u32_sdwa v24, v17, v17 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	ds_swizzle_b32 v25, v24 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v15, v25, v24
	ds_bpermute_b32 v23, v16, v15
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v15, v23, v15
	v_sub_u32_sdwa v23, v15, v17 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_cmp_lt_i32_e32 vcc, 11, v23
	v_sub_u32_sdwa v17, v15, v17 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	s_waitcnt vmcnt(4)
	ds_write_b128 v22, v[28:31]
	v_max_u32_sdwa v22, v26, v26 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_3 src1_sel:BYTE_1
	ds_swizzle_b32 v24, v22 offset:swizzle(SWAP,16)
	v_lshlrev_b32_e32 v31, 4, v1
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_max_i32_e32 v22, v24, v22
	ds_bpermute_b32 v16, v16, v22
	v_min_i32_e32 v24, 11, v23
	v_mul_lo_u32 v24, v24, s4
	v_sub_u32_e32 v25, 0x6c686080, v24
	v_and_b32_e32 v25, 0xffffff00, v25
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v16, v16, v22
	v_sub_u32_e32 v22, 0x7c787470, v24
	v_cndmask_b32_e64 v29, v22, 0, vcc
	v_min_i32_e32 v22, 11, v17
	v_mul_lo_u32 v22, v22, s4
	v_cndmask_b32_e64 v28, v25, 0, vcc
	v_sub_u32_e32 v23, 0x6c686080, v22
	v_sub_u32_e32 v22, 0x7c787470, v22
	v_cmp_lt_i32_e32 vcc, 11, v17
	v_and_b32_e32 v23, 0xffffff00, v23
	s_waitcnt vmcnt(3)
	v_lshlrev_b32_e32 v24, 4, v18
	v_cndmask_b32_e64 v30, v22, 0, vcc
	v_and_b32_e32 v22, 0x7070707, v18
	v_cndmask_b32_e64 v17, v23, 0, vcc
	v_perm_b32 v22, v29, v28, v22
	v_lshrrev_b32_e32 v23, 4, v18
	v_and_b32_e32 v23, 0x7070707, v23
	v_and_or_b32 v24, v24, s0, v22
	v_add_u32_e32 v22, 0x7f7f7f7f, v22
	v_perm_b32 v23, v29, v28, v23
	v_or_b32_e32 v22, 0x7f7f7f7f, v22
	v_and_b32_e32 v24, v22, v24
	v_add_u32_e32 v22, 0x7f7f7f7f, v23
	v_and_or_b32 v18, v18, s0, v23
	v_or_b32_e32 v22, 0x7f7f7f7f, v22
	v_and_b32_e32 v18, v22, v18
	v_perm_b32 v22, v18, v24, s1
	v_perm_b32 v23, v18, v24, s3
	v_xor_b32_e32 v18, v27, v31
	v_or_b32_e32 v18, v32, v18
	ds_read_b64 v[36:37], v18
	v_or_b32_e32 v18, 8, v27
	v_xor_b32_e32 v18, v18, v31
	v_or_b32_e32 v24, 16, v27
	v_or_b32_e32 v25, 24, v27
	v_or_b32_e32 v18, v32, v18
	v_xor_b32_e32 v24, v24, v31
	v_xor_b32_e32 v25, v25, v31
	v_or_b32_e32 v24, v32, v24
	v_or_b32_e32 v25, v32, v25
	ds_read_b64 v[38:39], v18
	ds_read_b64 v[40:41], v24
	ds_read_b64 v[42:43], v25
	v_and_b32_e32 v18, 0x7070707, v19
	v_perm_b32 v18, v29, v28, v18
	v_lshrrev_b32_e32 v33, 4, v19
	v_lshlrev_b32_e32 v34, 4, v19
	v_and_b32_e32 v33, 0x7070707, v33
	v_and_or_b32 v34, v34, s0, v18
	v_add_u32_e32 v18, 0x7f7f7f7f, v18
	v_perm_b32 v33, v29, v28, v33
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[36:37], v[22:23], 0
	v_and_b32_e32 v34, v18, v34
	v_and_or_b32 v18, v19, s0, v33
	v_add_u32_e32 v19, 0x7f7f7f7f, v33
	v_or_b32_e32 v19, 0x7f7f7f7f, v19
	v_and_b32_e32 v19, v19, v18
	v_perm_b32 v18, v19, v34, s1
	v_perm_b32 v19, v19, v34, s3
	v_lshlrev_b32_e32 v33, 4, v20
	v_or_b32_e32 v1, s24, v1
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[38:39], v[18:19], v[22:25]
	v_and_b32_e32 v18, 0x7070707, v20
	v_perm_b32 v18, v29, v28, v18
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_and_or_b32 v33, v33, s0, v18
	v_add_u32_e32 v18, 0x7f7f7f7f, v18
	v_perm_b32 v19, v29, v28, v19
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	v_and_b32_e32 v33, v18, v33
	v_and_or_b32 v18, v20, s0, v19
	v_add_u32_e32 v19, 0x7f7f7f7f, v19
	v_or_b32_e32 v19, 0x7f7f7f7f, v19
	v_and_b32_e32 v19, v19, v18
	v_perm_b32 v18, v19, v33, s1
	v_perm_b32 v19, v19, v33, s3
	v_lshlrev_b32_e32 v20, 4, v21
	v_lshlrev_b32_e32 v1, 2, v1
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[40:41], v[18:19], v[22:25]
	v_and_b32_e32 v18, 0x7070707, v21
	v_perm_b32 v18, v29, v28, v18
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_and_or_b32 v20, v20, s0, v18
	v_add_u32_e32 v18, 0x7f7f7f7f, v18
	v_perm_b32 v19, v29, v28, v19
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	v_and_b32_e32 v20, v18, v20
	v_and_or_b32 v18, v21, s0, v19
	v_add_u32_e32 v19, 0x7f7f7f7f, v19
	v_or_b32_e32 v19, 0x7f7f7f7f, v19
	v_and_b32_e32 v19, v19, v18
	v_perm_b32 v18, v19, v20, s1
	v_perm_b32 v19, v19, v20, s3
	v_lshl_add_u32 v1, v14, 11, v1
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[18:19], v[22:25]
	s_waitcnt vmcnt(2)
	s_nop 1
	v_and_b32_e32 v22, 0x7070707, v10
	v_perm_b32 v22, v30, v17, v22
	v_lshrrev_b32_e32 v23, 4, v10
	v_lshlrev_b32_e32 v24, 4, v10
	v_and_b32_e32 v23, 0x7070707, v23
	v_and_or_b32 v24, v24, s0, v22
	v_add_u32_e32 v22, 0x7f7f7f7f, v22
	v_perm_b32 v23, v30, v17, v23
	v_or_b32_e32 v22, 0x7f7f7f7f, v22
	v_and_b32_e32 v24, v22, v24
	v_add_u32_e32 v22, 0x7f7f7f7f, v23
	v_and_or_b32 v10, v10, s0, v23
	v_or_b32_e32 v22, 0x7f7f7f7f, v22
	v_and_b32_e32 v10, v22, v10
	v_perm_b32 v22, v10, v24, s1
	v_perm_b32 v23, v10, v24, s3
	v_or_b32_e32 v10, 0x80, v27
	v_xor_b32_e32 v10, v10, v31
	v_or_b32_e32 v10, v32, v10
	ds_read_b64 v[34:35], v10
	v_or_b32_e32 v10, 0x88, v27
	v_xor_b32_e32 v10, v10, v31
	v_or_b32_e32 v24, 0x90, v27
	v_or_b32_e32 v25, 0x98, v27
	v_or_b32_e32 v10, v32, v10
	v_xor_b32_e32 v24, v24, v31
	v_xor_b32_e32 v25, v25, v31
	v_or_b32_e32 v24, v32, v24
	v_or_b32_e32 v25, v32, v25
	ds_read_b64 v[32:33], v10
	ds_read_b64 v[44:45], v24
	ds_read_b64 v[46:47], v25
	v_and_b32_e32 v10, 0x7070707, v11
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[34:35], v[22:23], v[18:21]
	v_perm_b32 v10, v30, v17, v10
	v_lshrrev_b32_e32 v22, 4, v11
	v_lshlrev_b32_e32 v23, 4, v11
	v_and_b32_e32 v22, 0x7070707, v22
	v_and_or_b32 v23, v23, s0, v10
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_perm_b32 v22, v30, v17, v22
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v23, v10, v23
	v_and_or_b32 v10, v11, s0, v22
	v_add_u32_e32 v11, 0x7f7f7f7f, v22
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v10
	v_perm_b32 v10, v11, v23, s1
	v_perm_b32 v11, v11, v23, s3
	v_lshlrev_b32_e32 v22, 4, v12
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v23, 4, v7
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[32:33], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v12
	v_perm_b32 v10, v30, v17, v10
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_and_or_b32 v22, v22, s0, v10
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_perm_b32 v11, v30, v17, v11
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v22, v10, v22
	v_and_or_b32 v10, v12, s0, v11
	v_add_u32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v10
	v_perm_b32 v10, v11, v22, s1
	v_perm_b32 v11, v11, v22, s3
	v_lshlrev_b32_e32 v12, 4, v13
	v_lshlrev_b32_e32 v24, 4, v7
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[44:45], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v13
	v_perm_b32 v10, v30, v17, v10
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_and_or_b32 v12, v12, s0, v10
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_perm_b32 v11, v30, v17, v11
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v12, v10, v12
	v_and_or_b32 v10, v13, s0, v11
	v_add_u32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v10
	v_perm_b32 v10, v11, v12, s1
	v_perm_b32 v11, v11, v12, s3
	v_sub_u32_sdwa v17, v16, v26 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_1
	v_cmp_lt_i32_e32 vcc, 11, v17
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[46:47], v[10:11], v[18:21]
	v_and_b32_e32 v23, 0x7070707, v23
	s_barrier
	s_nop 0
	v_min_i32_e32 v18, 11, v17
	v_mul_lo_u32 v18, v18, s4
	v_sub_u32_e32 v19, 0x6c686080, v18
	v_sub_u32_e32 v18, 0x7c787470, v18
	v_and_b32_e32 v19, 0xffffff00, v19
	v_cndmask_b32_e64 v22, v18, 0, vcc
	v_sub_u32_sdwa v18, v16, v26 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_3
	v_cndmask_b32_e64 v17, v19, 0, vcc
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s4
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_and_b32_e32 v18, 0x7070707, v6
	v_perm_b32 v18, v22, v17, v18
	v_cndmask_b32_e64 v28, v20, 0, vcc
	v_cndmask_b32_e64 v29, v19, 0, vcc
	v_lshrrev_b32_e32 v19, 4, v6
	v_lshlrev_b32_e32 v20, 4, v6
	v_and_b32_e32 v19, 0x7070707, v19
	v_and_or_b32 v20, v20, s0, v18
	v_add_u32_e32 v18, 0x7f7f7f7f, v18
	v_perm_b32 v19, v22, v17, v19
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	v_and_b32_e32 v20, v18, v20
	v_add_u32_e32 v18, 0x7f7f7f7f, v19
	v_and_or_b32 v6, v6, s0, v19
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	v_and_b32_e32 v6, v18, v6
	v_perm_b32 v18, v6, v20, s1
	v_perm_b32 v19, v6, v20, s3
	v_and_b32_e32 v6, 0x7070707, v7
	v_perm_b32 v6, v22, v17, v6
	v_and_or_b32 v24, v24, s0, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v23, v22, v17, v23
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[18:19], 0
	v_and_b32_e32 v24, v6, v24
	v_and_or_b32 v6, v7, s0, v23
	v_add_u32_e32 v7, 0x7f7f7f7f, v23
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v24, s1
	v_perm_b32 v7, v7, v24, s3
	v_lshlrev_b32_e32 v23, 4, v8
	s_mov_b32 s4, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[38:39], v[6:7], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v8
	v_perm_b32 v6, v22, v17, v6
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v23, v23, s0, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v7, v22, v17, v7
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v23, v6, v23
	v_and_or_b32 v6, v8, s0, v7
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v23, s1
	v_perm_b32 v7, v7, v23, s3
	v_lshlrev_b32_e32 v8, 4, v9
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[6:7], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v9
	v_perm_b32 v6, v22, v17, v6
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v8, v8, s0, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v7, v22, v17, v7
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v8, v6, v8
	v_and_or_b32 v6, v9, s0, v7
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v8, s1
	v_perm_b32 v7, v7, v8, s3
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v17, 0x7070707, v2
	v_perm_b32 v17, v29, v28, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[42:43], v[6:7], v[18:21]
	v_lshlrev_b32_e32 v27, 4, v3
	v_cmp_lt_u32_e32 vcc, 5, v15
	s_nop 0
	v_lshrrev_b32_e32 v18, 4, v2
	v_and_b32_e32 v18, 0x7070707, v18
	v_perm_b32 v18, v29, v28, v18
	v_lshlrev_b32_e32 v19, 4, v2
	v_and_or_b32 v19, v19, s0, v17
	v_add_u32_e32 v17, 0x7f7f7f7f, v17
	v_and_or_b32 v2, v2, s0, v18
	v_add_u32_e32 v22, 0x7f7f7f7f, v18
	v_lshlrev_b32_e32 v18, 4, v14
	v_or_b32_e32 v17, 0x7f7f7f7f, v17
	v_lshl_or_b32 v18, s12, 6, v18
	v_and_b32_e32 v17, v17, v19
	buffer_load_dwordx4 v[18:21], v18, s[4:7], 0 offen
	v_or_b32_e32 v22, 0x7f7f7f7f, v22
	v_and_b32_e32 v2, v22, v2
	v_perm_b32 v22, v2, v17, s1
	v_perm_b32 v23, v2, v17, s3
	v_and_b32_e32 v2, 0x7070707, v3
	v_perm_b32 v17, v29, v28, v2
	v_lshrrev_b32_e32 v2, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[34:35], v[22:23], v[6:9]
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v26, v29, v28, v2
	s_and_b32 s5, s15, 0xffff
	v_lshrrev_b32_e32 v7, 5, v0
	v_or_b32_e32 v2, s25, v7
	s_mov_b32 s4, s14
	v_lshlrev_b32_e32 v30, 2, v2
	buffer_load_dword v9, v30, s[4:7], 0 offen
	buffer_load_dword v8, v30, s[4:7], 0 offen offset:32
	buffer_load_dword v6, v30, s[20:23], 0 offen
	buffer_load_dword v2, v30, s[20:23], 0 offen offset:32
	v_and_or_b32 v27, v27, s0, v17
	v_add_u32_e32 v17, 0x7f7f7f7f, v17
	v_and_or_b32 v3, v3, s0, v26
	v_add_u32_e32 v26, 0x7f7f7f7f, v26
	v_or_b32_e32 v17, 0x7f7f7f7f, v17
	v_or_b32_e32 v26, 0x7f7f7f7f, v26
	v_and_b32_e32 v17, v17, v27
	v_and_b32_e32 v3, v26, v3
	v_perm_b32 v26, v3, v17, s1
	v_perm_b32 v27, v3, v17, s3
	v_lshrrev_b32_e32 v17, 4, v4
	v_and_b32_e32 v3, 0x7070707, v4
	v_and_b32_e32 v17, 0x7070707, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[32:33], v[26:27], v[22:25]
	v_perm_b32 v3, v29, v28, v3
	v_perm_b32 v17, v29, v28, v17
	v_lshlrev_b32_e32 v26, 4, v4
	v_and_or_b32 v26, v26, s0, v3
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_and_or_b32 v4, v4, s0, v17
	v_add_u32_e32 v17, 0x7f7f7f7f, v17
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v17, 0x7f7f7f7f, v17
	v_and_b32_e32 v3, v3, v26
	v_and_b32_e32 v4, v17, v4
	v_perm_b32 v26, v4, v3, s1
	v_perm_b32 v27, v4, v3, s3
	v_lshrrev_b32_e32 v4, 4, v5
	v_and_b32_e32 v3, 0x7070707, v5
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v3, v29, v28, v3
	v_perm_b32 v4, v29, v28, v4
	v_lshlrev_b32_e32 v17, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[44:45], v[26:27], v[22:25]
	v_and_or_b32 v17, v17, s0, v3
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_and_or_b32 v5, v5, s0, v4
	v_add_u32_e32 v4, 0x7f7f7f7f, v4
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v4, 0x7f7f7f7f, v4
	v_and_b32_e32 v3, v3, v17
	v_and_b32_e32 v5, v4, v5
	v_perm_b32 v4, v5, v3, s1
	v_perm_b32 v5, v5, v3, s3
	v_mov_b32_e32 v3, 0xfd800000
	s_mov_b32 s0, 0x20000
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[46:47], v[4:5], v[22:25]
	v_lshl_add_u32 v4, v15, 23, v3
	v_lshlrev_b32_e64 v5, v15, s0
	v_cndmask_b32_e32 v4, v5, v4, vcc
	v_lshl_add_u32 v3, v16, 23, v3
	v_lshlrev_b32_e64 v5, v16, s0
	v_cmp_lt_u32_e32 vcc, 5, v16
	v_lshlrev_b32_e32 v0, 1, v0
	v_and_b32_e32 v0, 62, v0
	v_cndmask_b32_e32 v16, v5, v3, vcc
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[26:27], v[4:5], v[18:19] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[20:21] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[12:13], v[4:5]
	v_pk_mul_f32 v[12:13], v[16:17], v[18:19] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[26:27]
	v_pk_mul_f32 v[12:13], v[22:23], v[12:13]
	v_pk_mul_f32 v[16:17], v[16:17], v[20:21] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[24:25], v[16:17]
	ds_write2_b32 v1, v10, v12 offset1:16
	ds_write2_b32 v1, v11, v13 offset0:128 offset1:144
	v_add_u32_e32 v1, 0x400, v1
	ds_write2_b32 v1, v4, v16 offset1:16
	ds_write2_b32 v1, v5, v17 offset0:128 offset1:144
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v1, 0xffffff, v9
	v_cmp_gt_i32_e32 vcc, s2, v1
	v_lshlrev_b32_e32 v1, 2, v0
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_3
	v_lshl_or_b32 v3, v7, 9, v1
	ds_read_b64 v[4:5], v3
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v9, 12, s13
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(1) lgkmcnt(0)
	v_pk_mul_f32 v[4:5], v[4:5], v[6:7] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v4, 16, 1
	v_or_b32_e32 v11, 0x400000, v4
	v_add3_u32 v10, v10, v4, s3
	v_cmp_u_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v10, v11, vcc
	v_bfe_u32 v10, v5, 16, 1
	v_add3_u32 v10, v10, v5, s3
	v_or_b32_e32 v11, 0x400000, v5
	v_cmp_u_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v10, v11, vcc
	v_perm_b32 v10, v5, v4, s4
	v_lshlrev_b32_e32 v4, 1, v9
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshl_add_u64 v[4:5], s[8:9], 0, v[4:5]
	global_atomic_pk_add_bf16 v[4:5], v10, off
	ds_read_b64 v[10:11], v3 offset:256
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[10:11], v[10:11], v[6:7] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v3, v10, 16, 1
	v_add3_u32 v3, v3, v10, s3
	v_or_b32_e32 v6, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	v_or_b32_e32 v9, 0x400000, v11
	s_nop 0
	v_cndmask_b32_e32 v3, v3, v6, vcc
	v_bfe_u32 v6, v11, 16, 1
	v_add3_u32 v6, v6, v11, s3
	v_cmp_u_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v6, v9, vcc
	v_perm_b32 v3, v6, v3, s4
	global_atomic_pk_add_bf16 v[4:5], v3, off offset:128
.LBB0_3:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v3, 0xffffff, v8
	v_cmp_gt_i32_e32 vcc, s2, v3
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_5
	v_lshl_or_b32 v3, v7, 9, v1
	ds_read_b64 v[4:5], v3 offset:4096
	v_lshl_add_u32 v1, v8, 12, s13
	s_waitcnt vmcnt(1)
	v_or_b32_e32 v6, v1, v0
	s_movk_i32 s0, 0x7fff
	s_mov_b32 s1, 0x7060302
	s_waitcnt vmcnt(0) lgkmcnt(0)
	v_pk_mul_f32 v[0:1], v[4:5], v[2:3] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v4, v0, 16, 1
	v_or_b32_e32 v5, 0x400000, v0
	v_add3_u32 v4, v4, v0, s0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v4, v5, vcc
	v_bfe_u32 v4, v1, 16, 1
	v_add3_u32 v4, v4, v1, s0
	v_or_b32_e32 v5, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v4, v5, vcc
	v_perm_b32 v4, v1, v0, s1
	v_lshlrev_b32_e32 v0, 1, v6
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[8:9], 0, v[0:1]
	global_atomic_pk_add_bf16 v[0:1], v4, off
	ds_read_b64 v[4:5], v3 offset:4352
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
.LBB0_5:
	s_endpgm
.Lfunc_end0:
	.size	gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz, .Lfunc_end0-gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz
		.amdhsa_group_segment_fixed_size 8192
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
		.amdhsa_next_free_vgpr 48
		.amdhsa_next_free_sgpr 26
		.amdhsa_accum_offset 48
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

	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.num_vgpr, 48
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.num_agpr, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.numbered_sgpr, 26
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.num_named_barrier, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.private_seg_size, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.uses_vcc, 1
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.uses_flat_scratch, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.has_dyn_sized_stack, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.has_recursion, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.has_indirect_call, 0
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
    .group_segment_fixed_size: 8192
    .kernarg_segment_align: 8
    .kernarg_segment_size: 80
    .max_flat_workgroup_size: 256
    .name:           gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     32
    .sgpr_spill_count: 0
    .symbol:         gemm2_a8w4_port_ne256_h4096_i256_bm16_tn128_ftz.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     48
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
