	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds
	.p2align	8
	.type	a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds,@function
a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds:
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[14:15], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s14, s3, 31
	s_lshr_b32 s14, s14, 28
	s_add_i32 s14, s3, s14
	s_ashr_i32 s22, s14, 4
	s_and_b32 s14, s14, -16
	s_cmp_lg_u32 s3, s14
	s_cselect_b64 s[14:15], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[14:15], s[20:21], s[14:15]
	s_subb_u32 s3, s22, 0
	s_lshl_b32 s14, s3, 5
	s_cmp_ge_i32 s2, s14
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_5
	s_lshr_b32 s14, s14, 3
	s_and_b32 s15, s2, 7
	s_mul_i32 s14, s14, s15
	s_lshr_b32 s2, s2, 3
	s_add_i32 s2, s14, s2
	s_ashr_i32 s14, s2, 31
	s_lshr_b32 s14, s14, 27
	s_add_i32 s14, s2, s14
	s_ashr_i32 s22, s14, 5
	s_and_b32 s23, s14, 0xffffffe0
	s_cmp_lg_u32 s2, s23
	s_cselect_b64 s[14:15], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[14:15], s[20:21], s[14:15]
	s_subb_u32 s28, s22, 0
	s_ashr_i32 s29, s28, 31
	s_sub_i32 s2, s2, s23
	s_lshl_b64 s[14:15], s[28:29], 2
	s_add_u32 s12, s12, s14
	s_addc_u32 s13, s13, s15
	s_load_dword s12, s[12:13], 0x0
	s_lshr_b32 s3, s3, 1
	s_lshl_b32 s29, s2, 7
	s_and_b32 s21, s5, 0xffff
	s_and_b32 s5, s3, 0x7fffffe0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s12, 12
	s_add_i32 s3, s29, s5
	s_mov_b32 s24, s10
	s_add_i32 s10, s3, s2
	v_lshlrev_b32_e32 v5, 4, v0
	v_lshrrev_b32_e32 v2, 4, v0
	v_and_b32_e32 v3, 48, v0
	v_and_b32_e32 v1, 15, v0
	s_lshl_b32 s30, s28, 4
	s_lshl_b32 s2, s10, 1
	v_xor_b32_e32 v7, v5, v0
	s_mov_b32 s15, 0x27000
	v_or3_b32 v4, s2, v3, v1
	v_or_b32_e32 v6, s30, v2
	v_and_b32_e32 v7, 0xf0, v7
	s_and_b32 s25, s11, 0xffff
	s_mov_b32 s26, 0x800000
	s_mov_b32 s27, s15
	s_mov_b32 s22, -1
	s_mov_b32 s20, s4
	s_mov_b32 s23, s15
	v_lshl_or_b32 v6, v6, 8, v7
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dwordx4 v[24:27], v6, s[20:23], 0 offen nt
	buffer_load_dword v17, v4, s[24:27], 0 offen
	s_lshl_b32 s2, s10, 3
	v_or3_b32 v4, s2, v3, v1
	s_and_b32 s13, s9, 0xffff
	s_brev_b32 s14, 16
	s_mov_b32 s12, s8
	v_lshlrev_b32_e32 v4, 4, v4
	buffer_load_dwordx4 v[18:21], v4, s[12:15], 0 offen nt
	s_load_dwordx2 s[2:3], s[0:1], 0x40
	s_load_dword s4, s[0:1], 0x48
	s_ashr_i32 s0, s10, 4
	s_or_b32 s0, s0, 1
	v_and_b32_e32 v5, 0xf0, v5
	s_lshl_b32 s9, s0, 7
	v_lshl_or_b32 v16, v2, 8, v5
	v_or3_b32 v2, s9, v3, v1
	v_or_b32_e32 v3, 0x400, v4
	buffer_load_dwordx4 v[10:13], v3, s[12:15], 0 offen nt
	s_lshr_b32 s1, s10, 31
	s_add_i32 s1, s0, s1
	s_and_b32 s1, s1, -2
	s_sub_i32 s0, s0, s1
	v_and_b32_e32 v6, 63, v0
	s_lshl_b32 s0, s0, 3
	v_lshlrev_b32_e32 v6, 2, v6
	v_lshlrev_b32_e32 v22, 4, v2
	s_add_i32 s1, s0, 16
	v_xor_b32_e32 v15, 0x80, v6
	buffer_load_dwordx4 v[6:9], v22, s[12:15], 0 offen nt
	buffer_load_dwordx4 v[2:5], v22, s[12:15], 0 offen offset:1024 nt
	s_mov_b32 s8, 0x8080808
	v_bfe_u32 v14, v0, 4, 2
	v_lshlrev_b32_e32 v35, 5, v14
	v_lshlrev_b32_e32 v37, 4, v1
	v_lshlrev_b32_e32 v36, 8, v1
	s_and_b32 s21, s7, 0xffff
	s_mov_b32 s20, s6
	s_and_b32 s13, s19, 0xffff
	s_mov_b32 s12, s18
	s_mov_b32 s14, s22
	v_or_b32_e32 v1, s5, v1
	v_lshlrev_b32_e32 v1, 1, v1
	v_lshl_add_u32 v1, v14, 10, v1
	s_waitcnt vmcnt(5)
	ds_write_b128 v16, v[24:27]
	s_waitcnt vmcnt(4)
	v_max_u32_sdwa v16, v17, v17 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	v_bfe_u32 v26, v17, s0, 8
	v_bfe_u32 v27, v17, s1, 8
	ds_swizzle_b32 v22, v16 offset:swizzle(SWAP,16)
	v_max_u32_e32 v23, v27, v26
	ds_swizzle_b32 v24, v23 offset:swizzle(SWAP,16)
	s_mov_b32 s0, 0x5010400
	s_waitcnt vmcnt(3)
	v_lshrrev_b32_e32 v25, 4, v18
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v16, v22, v16
	ds_bpermute_b32 v22, v15, v16
	v_max_i32_e32 v23, v24, v23
	ds_bpermute_b32 v15, v15, v23
	v_and_b32_e32 v24, 0x7070707, v18
	s_mov_b32 s1, 0x7030602
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v16, v22, v16
	v_sub_u32_sdwa v22, v16, v17 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v15, v15, v23
	v_min_i32_e32 v23, 11, v22
	v_mul_lo_u32 v23, v23, s8
	v_sub_u32_e32 v29, 0x6c686080, v23
	v_sub_u32_e32 v23, 0x7c787470, v23
	v_and_b32_e32 v29, 0xffffff00, v29
	v_cmp_lt_i32_e32 vcc, 11, v22
	s_waitcnt lgkmcnt(0)
	s_nop 0
	v_cndmask_b32_e64 v29, v29, 0, vcc
	v_cndmask_b32_e64 v31, v23, 0, vcc
	v_add_u32_e32 v22, 0x7f7f7f00, v29
	v_add_u32_e32 v23, 0x7f7f7f78, v31
	v_and_b32_e32 v33, 0x80808000, v22
	v_and_b32_e32 v34, 0x80808080, v23
	v_and_b32_e32 v22, 0x7070707, v25
	v_perm_b32 v23, v34, v33, v24
	v_lshlrev_b32_e32 v25, 4, v18
	v_perm_b32 v24, v31, v29, v24
	v_and_or_b32 v23, v23, v25, v24
	v_perm_b32 v24, v34, v33, v22
	v_perm_b32 v22, v31, v29, v22
	v_and_or_b32 v18, v24, v18, v22
	v_perm_b32 v22, v18, v23, s0
	v_perm_b32 v23, v18, v23, s1
	v_xor_b32_e32 v18, v35, v37
	v_or_b32_e32 v18, v36, v18
	s_barrier
	ds_read_b64 v[42:43], v18
	v_or_b32_e32 v18, 8, v35
	v_xor_b32_e32 v18, v18, v37
	v_or_b32_e32 v24, 16, v35
	v_or_b32_e32 v25, 24, v35
	v_or_b32_e32 v18, v36, v18
	v_xor_b32_e32 v24, v24, v37
	v_xor_b32_e32 v25, v25, v37
	v_or_b32_e32 v24, v36, v24
	v_or_b32_e32 v25, v36, v25
	ds_read_b64 v[44:45], v18
	ds_read_b64 v[46:47], v24
	ds_read_b64 v[48:49], v25
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v38, 4, v19
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[22:23], 0
	v_and_b32_e32 v38, 0x7070707, v38
	v_perm_b32 v39, v34, v33, v18
	v_lshlrev_b32_e32 v40, 4, v19
	v_perm_b32 v18, v31, v29, v18
	v_and_or_b32 v39, v39, v40, v18
	v_perm_b32 v18, v34, v33, v38
	v_perm_b32 v38, v31, v29, v38
	v_and_or_b32 v19, v18, v19, v38
	v_perm_b32 v18, v19, v39, s0
	v_perm_b32 v19, v19, v39, s1
	v_lshlrev_b32_e32 v39, 4, v20
	v_sub_u32_sdwa v17, v16, v17 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[44:45], v[18:19], v[22:25]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v38, v34, v33, v18
	v_perm_b32 v18, v31, v29, v18
	v_and_or_b32 v38, v38, v39, v18
	v_perm_b32 v18, v34, v33, v19
	v_perm_b32 v19, v31, v29, v19
	v_and_or_b32 v19, v18, v20, v19
	v_min_i32_e32 v28, 11, v17
	v_perm_b32 v18, v19, v38, s0
	v_perm_b32 v19, v19, v38, s1
	v_mul_lo_u32 v28, v28, s8
	v_sub_u32_e32 v30, 0x6c686080, v28
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[46:47], v[18:19], v[22:25]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v34, v33, v18
	v_lshlrev_b32_e32 v38, 4, v21
	v_perm_b32 v18, v31, v29, v18
	v_sub_u32_e32 v28, 0x7c787470, v28
	v_and_b32_e32 v30, 0xffffff00, v30
	v_cmp_lt_i32_e32 vcc, 11, v17
	v_and_or_b32 v20, v20, v38, v18
	v_perm_b32 v18, v34, v33, v19
	v_perm_b32 v19, v31, v29, v19
	v_cndmask_b32_e64 v17, v30, 0, vcc
	v_cndmask_b32_e64 v28, v28, 0, vcc
	v_and_or_b32 v19, v18, v21, v19
	v_add_u32_e32 v30, 0x7f7f7f00, v17
	v_add_u32_e32 v32, 0x7f7f7f78, v28
	v_perm_b32 v18, v19, v20, s0
	v_perm_b32 v19, v19, v20, s1
	v_and_b32_e32 v30, 0x80808000, v30
	v_and_b32_e32 v32, 0x80808080, v32
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[48:49], v[18:19], v[22:25]
	s_waitcnt vmcnt(2)
	s_nop 1
	v_and_b32_e32 v22, 0x7070707, v10
	v_lshrrev_b32_e32 v23, 4, v10
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v32, v30, v22
	v_lshlrev_b32_e32 v25, 4, v10
	v_perm_b32 v22, v28, v17, v22
	v_and_or_b32 v24, v24, v25, v22
	v_perm_b32 v22, v32, v30, v23
	v_perm_b32 v23, v28, v17, v23
	v_and_or_b32 v10, v22, v10, v23
	v_perm_b32 v22, v10, v24, s0
	v_perm_b32 v23, v10, v24, s1
	v_or_b32_e32 v10, 0x80, v35
	v_xor_b32_e32 v10, v10, v37
	v_or_b32_e32 v10, v36, v10
	ds_read_b64 v[38:39], v10
	v_or_b32_e32 v10, 0x88, v35
	v_xor_b32_e32 v10, v10, v37
	v_or_b32_e32 v24, 0x90, v35
	v_or_b32_e32 v25, 0x98, v35
	v_or_b32_e32 v10, v36, v10
	v_xor_b32_e32 v24, v24, v37
	v_xor_b32_e32 v25, v25, v37
	v_or_b32_e32 v24, v36, v24
	v_or_b32_e32 v25, v36, v25
	ds_read_b64 v[34:35], v10
	ds_read_b64 v[36:37], v24
	ds_read_b64 v[40:41], v25
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[38:39], v[22:23], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v22, 4, v11
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v32, v30, v10
	v_lshlrev_b32_e32 v24, 4, v11
	v_perm_b32 v10, v28, v17, v10
	v_and_or_b32 v23, v23, v24, v10
	v_perm_b32 v10, v32, v30, v22
	v_perm_b32 v22, v28, v17, v22
	v_and_or_b32 v11, v10, v11, v22
	v_perm_b32 v10, v11, v23, s0
	v_perm_b32 v11, v11, v23, s1
	v_lshlrev_b32_e32 v23, 4, v12
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v25, 4, v7
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[34:35], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v22, v32, v30, v10
	v_perm_b32 v10, v28, v17, v10
	v_and_or_b32 v22, v22, v23, v10
	v_perm_b32 v10, v32, v30, v11
	v_perm_b32 v11, v28, v17, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v22, s0
	v_perm_b32 v11, v11, v22, s1
	v_lshlrev_b32_e32 v22, 4, v13
	v_and_b32_e32 v25, 0x7070707, v25
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v32, v30, v10
	v_perm_b32 v10, v28, v17, v10
	v_and_or_b32 v12, v12, v22, v10
	v_perm_b32 v10, v32, v30, v11
	v_perm_b32 v11, v28, v17, v11
	v_and_or_b32 v11, v10, v13, v11
	v_perm_b32 v10, v11, v12, s0
	v_perm_b32 v11, v11, v12, s1
	v_sub_u32_e32 v17, v15, v26
	v_cmp_lt_i32_e32 vcc, 11, v17
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[40:41], v[10:11], v[18:21]
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v32, 4, v2
	s_barrier
	v_min_i32_e32 v18, 11, v17
	v_mul_lo_u32 v18, v18, s8
	v_sub_u32_e32 v19, 0x6c686080, v18
	v_and_b32_e32 v19, 0xffffff00, v19
	v_sub_u32_e32 v18, 0x7c787470, v18
	v_cndmask_b32_e64 v17, v19, 0, vcc
	v_cndmask_b32_e64 v22, v18, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v17
	v_and_b32_e32 v23, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v22
	v_and_b32_e32 v24, 0x80808080, v18
	v_sub_u32_e32 v18, v15, v27
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s8
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_lshlrev_b32_e32 v21, 4, v6
	v_cndmask_b32_e64 v28, v20, 0, vcc
	v_cndmask_b32_e64 v29, v19, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v28
	v_and_b32_e32 v30, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v29
	v_and_b32_e32 v31, 0x80808080, v18
	v_and_b32_e32 v18, 0x7070707, v6
	v_lshrrev_b32_e32 v19, 4, v6
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v24, v23, v18
	v_perm_b32 v18, v22, v17, v18
	v_and_or_b32 v20, v20, v21, v18
	v_perm_b32 v18, v24, v23, v19
	v_perm_b32 v19, v22, v17, v19
	v_and_or_b32 v6, v18, v6, v19
	v_perm_b32 v18, v6, v20, s0
	v_perm_b32 v19, v6, v20, s1
	v_and_b32_e32 v6, 0x7070707, v7
	v_perm_b32 v26, v24, v23, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[18:19], 0
	v_lshlrev_b32_e32 v27, 4, v7
	v_perm_b32 v6, v22, v17, v6
	v_and_or_b32 v26, v26, v27, v6
	v_perm_b32 v6, v24, v23, v25
	v_perm_b32 v25, v22, v17, v25
	v_and_or_b32 v7, v6, v7, v25
	v_perm_b32 v6, v7, v26, s0
	v_perm_b32 v7, v7, v26, s1
	v_lshlrev_b32_e32 v26, 4, v8
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[44:45], v[6:7], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v8
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v25, v24, v23, v6
	v_perm_b32 v6, v22, v17, v6
	v_and_or_b32 v25, v25, v26, v6
	v_perm_b32 v6, v24, v23, v7
	v_perm_b32 v7, v22, v17, v7
	v_and_or_b32 v7, v6, v8, v7
	v_perm_b32 v6, v7, v25, s0
	v_perm_b32 v7, v7, v25, s1
	v_lshlrev_b32_e32 v25, 4, v9
	v_cmp_lt_u32_e32 vcc, 5, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[46:47], v[6:7], v[18:21]
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v24, v23, v6
	v_perm_b32 v6, v22, v17, v6
	v_and_or_b32 v27, v8, v25, v6
	v_perm_b32 v6, v24, v23, v7
	v_perm_b32 v7, v22, v17, v7
	v_and_or_b32 v17, v6, v9, v7
	v_perm_b32 v26, v17, v27, s0
	v_perm_b32 v27, v17, v27, s1
	v_and_b32_e32 v17, 0x7070707, v2
	v_lshlrev_b32_e32 v6, 4, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[48:49], v[26:27], v[18:21]
	v_lshrrev_b32_e32 v26, 4, v2
	v_and_b32_e32 v26, 0x7070707, v26
	v_perm_b32 v27, v31, v30, v17
	v_perm_b32 v17, v29, v28, v17
	v_lshl_or_b32 v22, s28, 6, v6
	v_and_or_b32 v17, v27, v32, v17
	v_perm_b32 v27, v31, v30, v26
	v_perm_b32 v26, v29, v28, v26
	buffer_load_dwordx4 v[6:9], v22, s[20:23], 0 offen
	v_and_or_b32 v2, v27, v2, v26
	v_perm_b32 v26, v2, v17, s0
	v_perm_b32 v27, v2, v17, s1
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v17, 4, v3
	buffer_load_dwordx4 v[22:25], v22, s[12:15], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[38:39], v[26:27], v[18:21]
	v_and_b32_e32 v17, 0x7070707, v17
	v_perm_b32 v26, v31, v30, v2
	v_lshlrev_b32_e32 v27, 4, v3
	v_perm_b32 v2, v29, v28, v2
	v_and_or_b32 v26, v26, v27, v2
	v_perm_b32 v2, v31, v30, v17
	v_perm_b32 v17, v29, v28, v17
	v_and_or_b32 v3, v2, v3, v17
	v_perm_b32 v2, v3, v26, s0
	v_perm_b32 v3, v3, v26, s1
	v_lshlrev_b32_e32 v26, 4, v4
	s_and_b32 s21, s17, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[34:35], v[2:3], v[18:21]
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v17, v31, v30, v2
	v_perm_b32 v2, v29, v28, v2
	v_and_or_b32 v17, v17, v26, v2
	v_perm_b32 v2, v31, v30, v3
	v_perm_b32 v3, v29, v28, v3
	v_and_or_b32 v3, v2, v4, v3
	v_perm_b32 v2, v3, v17, s0
	v_perm_b32 v3, v3, v17, s1
	v_lshlrev_b32_e32 v17, 4, v5
	s_mov_b32 s20, s16
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[2:3], v[18:21]
	v_and_b32_e32 v2, 0x7070707, v5
	v_lshrrev_b32_e32 v3, 4, v5
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v31, v30, v2
	v_perm_b32 v2, v29, v28, v2
	v_and_or_b32 v4, v4, v17, v2
	v_perm_b32 v2, v31, v30, v3
	v_perm_b32 v3, v29, v28, v3
	v_and_or_b32 v3, v2, v5, v3
	v_perm_b32 v2, v3, v4, s0
	v_perm_b32 v3, v3, v4, s1
	v_mov_b32_e32 v5, 0xfd800000
	s_mov_b32 s0, 0x20000
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[2:3], v[18:21]
	v_lshrrev_b32_e32 v2, 5, v0
	v_or_b32_e32 v3, s30, v2
	v_lshlrev_b32_e32 v3, 2, v3
	buffer_load_dword v4, v3, s[20:23], 0 offen
	v_lshl_add_u32 v17, v16, 23, v5
	buffer_load_dword v3, v3, s[20:23], 0 offen offset:32
	v_lshlrev_b32_e64 v26, v16, s0
	v_cndmask_b32_e32 v16, v26, v17, vcc
	v_lshl_add_u32 v5, v15, 23, v5
	v_lshlrev_b32_e64 v17, v15, s0
	v_cmp_lt_u32_e32 vcc, 5, v15
	s_movk_i32 s0, 0x7fff
	v_lshlrev_b32_e32 v0, 1, v0
	v_cndmask_b32_e32 v26, v17, v5, vcc
	v_and_b32_e32 v0, 62, v0
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[28:29], v[16:17], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[16:17], v[8:9] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[16:17]
	v_pk_mul_f32 v[10:11], v[10:11], v[28:29]
	v_pk_mul_f32 v[8:9], v[26:27], v[8:9] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[20:21], v[8:9]
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[12:13], v[12:13], v[24:25]
	v_pk_mul_f32 v[10:11], v[10:11], v[22:23]
	v_bfe_u32 v5, v13, 16, 1
	v_add3_u32 v5, v5, v13, s0
	v_or_b32_e32 v15, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	v_bfe_u32 v13, v12, 16, 1
	v_add3_u32 v13, v13, v12, s0
	v_cndmask_b32_e32 v5, v5, v15, vcc
	v_or_b32_e32 v15, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	v_pk_mul_f32 v[8:9], v[8:9], v[24:25]
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v12, v13, v15, vcc
	v_bfe_u32 v13, v11, 16, 1
	v_add3_u32 v13, v13, v11, s0
	v_or_b32_e32 v15, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_pk_mul_f32 v[6:7], v[18:19], v[6:7]
	s_nop 0
	v_cndmask_b32_e32 v11, v13, v15, vcc
	v_bfe_u32 v13, v10, 16, 1
	v_add3_u32 v13, v13, v10, s0
	v_or_b32_e32 v15, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	v_pk_mul_f32 v[6:7], v[6:7], v[22:23]
	s_nop 0
	v_cndmask_b32_e32 v10, v13, v15, vcc
	ds_write_b16_d16_hi v1, v10
	ds_write_b16_d16_hi v1, v11 offset:256
	ds_write_b16_d16_hi v1, v12 offset:512
	ds_write_b16_d16_hi v1, v5 offset:768
	v_bfe_u32 v5, v9, 16, 1
	v_add3_u32 v5, v5, v9, s0
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v5, v5, v10, vcc
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
	ds_write_b16_d16_hi v1, v6 offset:32
	ds_write_b16_d16_hi v1, v7 offset:288
	ds_write_b16_d16_hi v1, v8 offset:544
	ds_write_b16_d16_hi v1, v5 offset:800
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v1, 0xffffff, v4
	v_cmp_gt_i32_e32 vcc, s4, v1
	v_lshlrev_b32_e32 v1, 1, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_3
	v_lshl_or_b32 v6, v2, 8, v1
	v_lshl_add_u32 v4, v4, 12, s29
	ds_read_b32 v7, v6
	v_or_b32_e32 v4, v4, v0
	v_lshlrev_b32_e32 v4, 1, v4
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshl_add_u64 v[4:5], s[2:3], 0, v[4:5]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v7, off
	ds_read_b32 v6, v6 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v6, off offset:128
.LBB0_3:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v4, 0xffffff, v3
	v_cmp_gt_i32_e32 vcc, s4, v4
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_5
	v_lshl_or_b32 v2, v2, 8, v1
	v_lshl_add_u32 v3, v3, 12, s29
	ds_read_b32 v4, v2 offset:2048
	v_or_b32_e32 v0, v3, v0
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[2:3], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v4, off
	ds_read_b32 v2, v2 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_5:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds, .Lfunc_end0-a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds
		.amdhsa_group_segment_fixed_size 4096
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
		.amdhsa_next_free_vgpr 50
		.amdhsa_next_free_sgpr 31
		.amdhsa_accum_offset 52
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

	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.num_vgpr, 50
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.num_agpr, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.numbered_sgpr, 31
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.num_named_barrier, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.private_seg_size, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.uses_vcc, 1
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.uses_flat_scratch, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.has_dyn_sized_stack, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.has_recursion, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.has_indirect_call, 0
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
    .group_segment_fixed_size: 4096
    .kernarg_segment_align: 8
    .kernarg_segment_size: 76
    .max_flat_workgroup_size: 256
    .name:           a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     37
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm2_h4096_i256_ne256_bm16_tn128_tk256_bcm2_xcd0_ftz_lds.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     50
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
