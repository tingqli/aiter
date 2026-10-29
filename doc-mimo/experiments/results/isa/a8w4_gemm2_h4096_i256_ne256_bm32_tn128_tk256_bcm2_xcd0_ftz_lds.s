	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds
	.p2align	8
	.type	a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds,@function
a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds:
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[14:15], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s14, s3, 31
	s_lshr_b32 s14, s14, 27
	s_add_i32 s14, s3, s14
	s_ashr_i32 s22, s14, 5
	s_andn2_b32 s14, s14, 31
	s_cmp_lg_u32 s3, s14
	s_cselect_b64 s[14:15], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[14:15], s[20:21], s[14:15]
	s_subb_u32 s3, s22, 0
	s_lshl_b32 s14, s3, 5
	s_cmp_ge_i32 s2, s14
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_9
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
	s_subb_u32 s14, s22, 0
	s_ashr_i32 s15, s14, 31
	s_sub_i32 s2, s2, s23
	s_lshl_b64 s[20:21], s[14:15], 2
	s_add_u32 s12, s12, s20
	s_addc_u32 s13, s13, s21
	s_load_dword s12, s[12:13], 0x0
	s_lshr_b32 s3, s3, 1
	s_lshl_b32 s28, s2, 7
	s_mov_b32 s20, s4
	s_and_b32 s4, s3, 0x7fffffe0
	v_lshlrev_b32_e32 v4, 4, v0
	v_lshrrev_b32_e32 v2, 4, v0
	s_lshl_b32 s29, s14, 5
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s12, 12
	s_add_i32 s3, s28, s4
	v_xor_b32_e32 v6, v4, v0
	s_mov_b32 s15, 0x27000
	s_and_b32 s21, s5, 0xffff
	s_add_i32 s3, s3, s2
	v_or_b32_e32 v5, s29, v2
	v_and_b32_e32 v6, 0xf0, v6
	s_or_b32 s5, s29, 16
	v_and_b32_e32 v3, 48, v0
	v_and_b32_e32 v1, 15, v0
	s_mov_b32 s22, -1
	s_mov_b32 s23, s15
	v_lshl_or_b32 v5, v5, 8, v6
	v_or_b32_e32 v7, s5, v2
	s_lshl_b32 s2, s3, 1
	v_lshl_or_b32 v6, v7, 8, v6
	buffer_load_dwordx4 v[26:29], v5, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[30:33], v6, s[20:23], 0 offen nt
	v_or3_b32 v5, s2, v3, v1
	s_and_b32 s25, s11, 0xffff
	s_mov_b32 s26, 0x800000
	s_mov_b32 s24, s10
	s_mov_b32 s27, s15
	v_lshlrev_b32_e32 v5, 2, v5
	buffer_load_dword v18, v5, s[24:27], 0 offen
	s_lshl_b32 s2, s3, 3
	v_or3_b32 v5, s2, v3, v1
	s_and_b32 s13, s9, 0xffff
	s_brev_b32 s14, 16
	s_mov_b32 s12, s8
	v_lshlrev_b32_e32 v5, 4, v5
	buffer_load_dwordx4 v[14:17], v5, s[12:15], 0 offen nt
	v_bfe_u32 v22, v0, 4, 2
	s_ashr_i32 s2, s3, 4
	v_and_b32_e32 v4, 0xf0, v4
	v_lshlrev_b32_e32 v25, 5, v22
	v_lshlrev_b32_e32 v55, 4, v1
	s_or_b32 s2, s2, 1
	v_lshlrev_b32_e32 v54, 8, v1
	v_lshl_or_b32 v20, v2, 8, v4
	v_xor_b32_e32 v2, v25, v55
	s_lshl_b32 s9, s2, 7
	v_and_b32_e32 v6, 63, v0
	v_or_b32_e32 v21, v54, v2
	v_or3_b32 v2, s9, v3, v1
	v_lshlrev_b32_e32 v6, 2, v6
	v_or_b32_e32 v3, 0x400, v5
	v_lshlrev_b32_e32 v23, 4, v2
	v_xor_b32_e32 v19, 0x80, v6
	buffer_load_dwordx4 v[10:13], v3, s[12:15], 0 offen nt
	buffer_load_dwordx4 v[6:9], v23, s[12:15], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[2:5], v23, s[12:15], 0 offen offset:1024 nt
	s_lshr_b32 s3, s3, 31
	s_add_i32 s3, s2, s3
	s_and_b32 s3, s3, -2
	s_sub_i32 s2, s2, s3
	s_lshl_b32 s2, s2, 3
	s_add_i32 s3, s2, 16
	s_mov_b32 s8, 0x8080808
	s_mov_b32 s9, 0x5010400
	s_mov_b32 s10, 0x7030602
	s_and_b32 s21, s7, 0xffff
	s_mov_b32 s20, s6
	s_and_b32 s13, s19, 0xffff
	s_mov_b32 s12, s18
	s_mov_b32 s14, s22
	v_or_b32_e32 v1, s4, v1
	v_lshlrev_b32_e32 v1, 1, v1
	v_lshl_add_u32 v1, v22, 10, v1
	s_waitcnt vmcnt(6)
	ds_write_b128 v20, v[26:29]
	s_waitcnt vmcnt(5)
	ds_write_b128 v20, v[30:33] offset:4096
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_waitcnt vmcnt(4)
	v_bfe_u32 v42, v18, s2, 8
	v_bfe_u32 v58, v18, s3, 8
	v_max_u32_sdwa v20, v18, v18 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	ds_swizzle_b32 v23, v20 offset:swizzle(SWAP,16)
	v_max_u32_e32 v24, v58, v42
	ds_swizzle_b32 v26, v24 offset:swizzle(SWAP,16)
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v27, 0x7070707, v14
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v20, v23, v20
	ds_bpermute_b32 v23, v19, v20
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v26, v26, v24
	ds_bpermute_b32 v19, v19, v26
	v_lshrrev_b32_e32 v24, 4, v14
	v_and_b32_e32 v31, 0x7070707, v24
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v24, v23, v20
	v_sub_u32_sdwa v43, v24, v18 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v23, v19, v26
	v_sub_u32_sdwa v19, v24, v18 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v18, 11, v19
	v_mul_lo_u32 v18, v18, s8
	v_sub_u32_e32 v20, 0x6c686080, v18
	v_sub_u32_e32 v18, 0x7c787470, v18
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cmp_lt_i32_e32 vcc, 11, v19
	v_lshrrev_b32_e32 v34, 4, v15
	v_and_b32_e32 v38, 0x7070707, v34
	v_cndmask_b32_e64 v44, v18, 0, vcc
	v_cndmask_b32_e64 v45, v20, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f78, v44
	v_add_u32_e32 v19, 0x7f7f7f00, v45
	v_and_b32_e32 v46, 0x80808080, v18
	v_and_b32_e32 v47, 0x80808000, v19
	v_perm_b32 v20, v44, v45, v27
	v_perm_b32 v18, v46, v47, v27
	ds_read2st64_b64 v[26:29], v21 offset1:8
	v_or_b32_e32 v34, 8, v25
	v_xor_b32_e32 v34, v34, v55
	v_or_b32_e32 v34, v54, v34
	v_lshlrev_b32_e32 v30, 4, v14
	ds_read2st64_b64 v[34:37], v34 offset1:8
	v_min_i32_e32 v32, 11, v43
	v_and_or_b32 v18, v18, v30, v20
	v_perm_b32 v19, v46, v47, v31
	v_perm_b32 v20, v44, v45, v31
	v_and_or_b32 v14, v19, v14, v20
	v_mul_lo_u32 v48, v32, s8
	v_perm_b32 v30, v14, v18, s9
	v_perm_b32 v31, v14, v18, s10
	v_sub_u32_e32 v14, 0x6c686080, v48
	v_and_b32_e32 v49, 0xffffff00, v14
	v_and_b32_e32 v14, 0x7070707, v15
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[26:27], v[30:31], 0
	v_perm_b32 v39, v46, v47, v14
	v_lshlrev_b32_e32 v40, 4, v15
	v_perm_b32 v14, v44, v45, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[28:29], v[30:31], 0
	v_and_or_b32 v39, v39, v40, v14
	v_perm_b32 v14, v46, v47, v38
	v_perm_b32 v38, v44, v45, v38
	v_and_or_b32 v15, v14, v15, v38
	v_perm_b32 v14, v15, v39, s9
	v_perm_b32 v15, v15, v39, s10
	v_cmp_lt_i32_e32 vcc, 11, v43
	v_sub_u32_e32 v48, 0x7c787470, v48
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[34:35], v[14:15], v[18:21]
	v_cndmask_b32_e64 v59, v49, 0, vcc
	v_cndmask_b32_e64 v64, v48, 0, vcc
	v_lshlrev_b32_e32 v43, 4, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[14:15], v[30:33]
	v_sub_u32_e32 v14, v23, v42
	v_min_i32_e32 v15, 11, v14
	v_mul_lo_u32 v15, v15, s8
	v_sub_u32_e32 v30, 0x6c686080, v15
	v_and_b32_e32 v30, 0xffffff00, v30
	v_cmp_lt_i32_e64 s[2:3], 11, v14
	v_sub_u32_e32 v15, 0x7c787470, v15
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v31, 4, v6
	v_cndmask_b32_e64 v60, v30, 0, s[2:3]
	v_cndmask_b32_e64 v61, v15, 0, s[2:3]
	v_add_u32_e32 v14, 0x7f7f7f00, v60
	v_and_b32_e32 v62, 0x80808000, v14
	v_add_u32_e32 v14, 0x7f7f7f78, v61
	v_and_b32_e32 v63, 0x80808080, v14
	v_and_b32_e32 v14, 0x7070707, v6
	v_lshrrev_b32_e32 v15, 4, v6
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v30, v63, v62, v14
	v_perm_b32 v14, v61, v60, v14
	v_and_or_b32 v30, v30, v31, v14
	v_perm_b32 v14, v63, v62, v15
	v_perm_b32 v15, v61, v60, v15
	v_and_or_b32 v6, v14, v6, v15
	v_perm_b32 v14, v6, v30, s9
	v_perm_b32 v15, v6, v30, s10
	v_add_u32_e32 v6, 0x7f7f7f00, v59
	v_and_b32_e32 v65, 0x80808000, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[26:27], v[14:15], 0
	v_and_b32_e32 v6, 0x7070707, v7
	v_lshlrev_b32_e32 v42, 4, v7
	v_lshlrev_b32_e32 v68, 4, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[14:15], 0
	v_lshrrev_b32_e32 v14, 4, v7
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v15, v63, v62, v6
	v_perm_b32 v6, v61, v60, v6
	v_and_or_b32 v15, v15, v42, v6
	v_perm_b32 v6, v63, v62, v14
	v_perm_b32 v14, v61, v60, v14
	v_and_or_b32 v7, v6, v7, v14
	v_perm_b32 v6, v7, v15, s9
	v_perm_b32 v7, v7, v15, s10
	v_add_u32_e32 v14, 0x7f7f7f78, v64
	v_and_b32_e32 v66, 0x80808080, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[34:35], v[6:7], v[30:33]
	v_and_b32_e32 v14, 0x7070707, v16
	v_and_b32_e32 v42, 0x7070707, v17
	s_load_dwordx2 s[2:3], s[0:1], 0x40
	s_load_dword s6, s[0:1], 0x48
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[36:37], v[6:7], v[26:29]
	v_lshrrev_b32_e32 v6, 4, v16
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v15, v46, v47, v6
	v_perm_b32 v6, v44, v45, v6
	v_and_or_b32 v15, v15, v16, v6
	v_lshrrev_b32_e32 v6, 4, v17
	v_and_b32_e32 v6, 0x7070707, v6
	v_lshlrev_b32_e32 v7, 4, v16
	v_perm_b32 v16, v46, v47, v6
	v_perm_b32 v6, v44, v45, v6
	v_and_or_b32 v48, v16, v17, v6
	v_lshrrev_b32_e32 v6, 4, v10
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v16, v66, v65, v6
	v_perm_b32 v6, v64, v59, v6
	v_and_or_b32 v49, v16, v10, v6
	v_lshrrev_b32_e32 v6, 4, v11
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v16, v66, v65, v6
	v_perm_b32 v6, v64, v59, v6
	v_and_or_b32 v50, v16, v11, v6
	v_lshrrev_b32_e32 v6, 4, v12
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v16, v66, v65, v6
	v_perm_b32 v6, v64, v59, v6
	v_and_or_b32 v56, v16, v12, v6
	v_or_b32_e32 v6, 16, v25
	v_xor_b32_e32 v6, v6, v55
	v_or_b32_e32 v6, v54, v6
	ds_read2st64_b64 v[34:37], v6 offset1:8
	v_lshrrev_b32_e32 v6, 4, v13
	v_and_b32_e32 v51, 0x7070707, v6
	v_perm_b32 v6, v46, v47, v14
	v_perm_b32 v14, v44, v45, v14
	v_and_or_b32 v7, v6, v7, v14
	v_perm_b32 v6, v15, v7, s9
	v_perm_b32 v7, v15, v7, s10
	v_perm_b32 v52, v66, v65, v51
	v_perm_b32 v51, v64, v59, v51
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[34:35], v[6:7], v[38:41]
	v_and_or_b32 v67, v52, v13, v51
	s_mov_b32 s0, 0x20000
	s_nop 0
	v_or_b32_e32 v38, 24, v25
	v_xor_b32_e32 v38, v38, v55
	v_or_b32_e32 v38, v54, v38
	ds_read2st64_b64 v[38:41], v38 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[6:7], v[18:21]
	v_perm_b32 v6, v46, v47, v42
	v_perm_b32 v7, v44, v45, v42
	v_or_b32_e32 v42, 0x80, v25
	v_and_or_b32 v7, v6, v43, v7
	v_xor_b32_e32 v42, v42, v55
	v_perm_b32 v6, v48, v7, s9
	v_perm_b32 v7, v48, v7, s10
	v_or_b32_e32 v42, v54, v42
	v_and_b32_e32 v46, 0x7070707, v10
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[38:39], v[6:7], v[14:17]
	ds_read2st64_b64 v[42:45], v42 offset1:8
	v_lshlrev_b32_e32 v10, 4, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[6:7], v[18:21]
	v_perm_b32 v6, v66, v65, v46
	v_perm_b32 v7, v64, v59, v46
	v_and_or_b32 v7, v6, v10, v7
	v_or_b32_e32 v10, 0x88, v25
	v_xor_b32_e32 v10, v10, v55
	v_or_b32_e32 v10, v54, v10
	v_perm_b32 v6, v49, v7, s9
	v_perm_b32 v7, v49, v7, s10
	ds_read2st64_b64 v[46:49], v10 offset1:8
	v_and_b32_e32 v10, 0x7070707, v11
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[42:43], v[6:7], v[14:17]
	v_lshlrev_b32_e32 v11, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[44:45], v[6:7], v[18:21]
	v_perm_b32 v6, v66, v65, v10
	v_perm_b32 v7, v64, v59, v10
	v_or_b32_e32 v10, 0x90, v25
	v_xor_b32_e32 v10, v10, v55
	v_and_or_b32 v7, v6, v11, v7
	v_or_b32_e32 v10, v54, v10
	v_perm_b32 v6, v50, v7, s9
	v_perm_b32 v7, v50, v7, s10
	ds_read2st64_b64 v[50:53], v10 offset1:8
	v_and_b32_e32 v10, 0x7070707, v12
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[46:47], v[6:7], v[14:17]
	v_lshlrev_b32_e32 v11, 4, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[48:49], v[6:7], v[18:21]
	v_perm_b32 v6, v66, v65, v10
	v_perm_b32 v7, v64, v59, v10
	v_or_b32_e32 v10, 0x98, v25
	v_xor_b32_e32 v10, v10, v55
	v_and_or_b32 v7, v6, v11, v7
	v_or_b32_e32 v10, v54, v10
	v_perm_b32 v6, v56, v7, s9
	v_perm_b32 v7, v56, v7, s10
	ds_read2st64_b64 v[54:57], v10 offset1:8
	v_and_b32_e32 v25, 0x7070707, v13
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[50:51], v[6:7], v[14:17]
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[52:53], v[6:7], v[18:21]
	v_perm_b32 v6, v66, v65, v25
	v_perm_b32 v7, v64, v59, v25
	v_and_or_b32 v7, v6, v68, v7
	v_perm_b32 v6, v67, v7, s9
	v_perm_b32 v7, v67, v7, s10
	v_lshlrev_b32_e32 v18, 4, v8
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[54:55], v[6:7], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[56:57], v[6:7], v[10:13]
	v_and_b32_e32 v6, 0x7070707, v8
	v_perm_b32 v7, v63, v62, v6
	v_perm_b32 v6, v61, v60, v6
	v_and_or_b32 v7, v7, v18, v6
	v_lshrrev_b32_e32 v6, 4, v8
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v18, v63, v62, v6
	v_perm_b32 v6, v61, v60, v6
	v_and_or_b32 v8, v18, v8, v6
	v_perm_b32 v6, v8, v7, s9
	v_perm_b32 v7, v8, v7, s10
	v_sub_u32_e32 v8, v23, v58
	v_cmp_lt_i32_e32 vcc, 11, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[34:35], v[6:7], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[36:37], v[6:7], v[26:29]
	v_min_i32_e32 v6, 11, v8
	v_mul_lo_u32 v6, v6, s8
	v_sub_u32_e32 v7, 0x6c686080, v6
	v_and_b32_e32 v7, 0xffffff00, v7
	v_sub_u32_e32 v6, 0x7c787470, v6
	v_cndmask_b32_e64 v25, v7, 0, vcc
	v_cndmask_b32_e64 v32, v6, 0, vcc
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v63, v62, v6
	v_lshlrev_b32_e32 v30, 4, v9
	v_perm_b32 v6, v61, v60, v6
	v_and_or_b32 v6, v8, v30, v6
	v_perm_b32 v8, v63, v62, v7
	v_perm_b32 v7, v61, v60, v7
	v_and_or_b32 v7, v8, v9, v7
	v_perm_b32 v30, v7, v6, s9
	v_perm_b32 v31, v7, v6, s10
	v_add_u32_e32 v33, 0x7f7f7f00, v25
	v_and_b32_e32 v33, 0x80808000, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[38:39], v[30:31], v[18:21]
	v_cmp_lt_u32_e32 vcc, 5, v24
	s_nop 1
	v_add_u32_e32 v18, 0x7f7f7f78, v32
	v_and_b32_e32 v34, 0x80808080, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[30:31], v[26:29]
	s_waitcnt vmcnt(0)
	s_nop 1
	v_and_b32_e32 v26, 0x7070707, v2
	v_lshrrev_b32_e32 v27, 4, v2
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v34, v33, v26
	v_lshlrev_b32_e32 v29, 4, v2
	v_perm_b32 v26, v32, v25, v26
	v_and_or_b32 v28, v28, v29, v26
	v_perm_b32 v26, v34, v33, v27
	v_perm_b32 v27, v32, v25, v27
	v_and_or_b32 v2, v26, v2, v27
	v_perm_b32 v26, v2, v28, s9
	v_perm_b32 v27, v2, v28, s10
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshlrev_b32_e32 v28, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[42:43], v[26:27], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[44:45], v[26:27], v[18:21]
	v_lshrrev_b32_e32 v26, 4, v3
	v_and_b32_e32 v26, 0x7070707, v26
	v_perm_b32 v27, v34, v33, v2
	v_perm_b32 v2, v32, v25, v2
	v_and_or_b32 v27, v27, v28, v2
	v_perm_b32 v2, v34, v33, v26
	v_perm_b32 v26, v32, v25, v26
	v_and_or_b32 v3, v2, v3, v26
	v_perm_b32 v2, v3, v27, s9
	v_perm_b32 v3, v3, v27, s10
	v_lshlrev_b32_e32 v27, 4, v4
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[46:47], v[2:3], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[48:49], v[2:3], v[18:21]
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v26, v34, v33, v2
	v_perm_b32 v2, v32, v25, v2
	v_and_or_b32 v26, v26, v27, v2
	v_perm_b32 v2, v34, v33, v3
	v_perm_b32 v3, v32, v25, v3
	v_and_or_b32 v3, v2, v4, v3
	v_perm_b32 v2, v3, v26, s9
	v_perm_b32 v3, v3, v26, s10
	v_lshlrev_b32_e32 v26, 4, v5
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[50:51], v[2:3], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[52:53], v[2:3], v[18:21]
	v_and_b32_e32 v2, 0x7070707, v5
	v_lshrrev_b32_e32 v3, 4, v5
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v34, v33, v2
	v_perm_b32 v2, v32, v25, v2
	v_and_or_b32 v4, v4, v26, v2
	v_perm_b32 v2, v34, v33, v3
	v_perm_b32 v3, v32, v25, v3
	v_and_or_b32 v3, v2, v5, v3
	v_perm_b32 v2, v3, v4, s9
	v_perm_b32 v3, v3, v4, s10
	v_lshlrev_b32_e32 v4, 2, v22
	v_or_b32_e32 v5, s29, v4
	v_lshlrev_b32_e32 v5, 2, v5
	buffer_load_dwordx4 v[30:33], v5, s[20:23], 0 offen
	buffer_load_dwordx4 v[34:37], v5, s[12:15], 0 offen
	buffer_load_dwordx4 v[42:45], v5, s[12:15], 0 offen offset:64
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[54:55], v[2:3], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[56:57], v[2:3], v[18:21]
	v_mov_b32_e32 v2, 0xfd800000
	v_lshl_add_u32 v3, v24, 23, v2
	v_lshlrev_b32_e64 v6, v24, s0
	v_cndmask_b32_e32 v8, v6, v3, vcc
	v_lshl_add_u32 v2, v23, 23, v2
	v_lshlrev_b32_e64 v3, v23, s0
	v_cmp_lt_u32_e32 vcc, 5, v23
	s_movk_i32 s0, 0x7fff
	s_nop 0
	v_cndmask_b32_e32 v24, v3, v2, vcc
	v_or_b32_e32 v2, s5, v4
	v_lshlrev_b32_e32 v2, 2, v2
	buffer_load_dwordx4 v[38:41], v2, s[20:23], 0 offen
	v_lshrrev_b32_e32 v2, 5, v0
	v_or_b32_e32 v3, s29, v2
	s_and_b32 s21, s17, 0xffff
	s_mov_b32 s20, s16
	v_lshlrev_b32_e32 v7, 2, v3
	v_or_b32_e32 v3, s5, v2
	v_lshlrev_b32_e32 v9, 2, v3
	buffer_load_dword v6, v7, s[20:23], 0 offen
	buffer_load_dword v5, v7, s[20:23], 0 offen offset:32
	buffer_load_dword v4, v9, s[20:23], 0 offen
	buffer_load_dword v3, v7, s[20:23], 0 offen offset:96
	v_lshlrev_b32_e32 v0, 1, v0
	v_and_b32_e32 v0, 62, v0
	s_waitcnt vmcnt(7)
	v_pk_mul_f32 v[48:49], v[8:9], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[16:17], v[48:49]
	v_pk_mul_f32 v[46:47], v[8:9], v[30:31] op_sel_hi:[0,1]
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[16:17], v[16:17], v[36:37]
	v_pk_mul_f32 v[14:15], v[14:15], v[46:47]
	v_bfe_u32 v7, v17, 16, 1
	v_add3_u32 v7, v7, v17, s0
	v_or_b32_e32 v9, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	v_pk_mul_f32 v[14:15], v[14:15], v[34:35]
	v_or_b32_e32 v17, 0x400000, v16
	v_cndmask_b32_e32 v7, v7, v9, vcc
	v_bfe_u32 v9, v16, 16, 1
	v_add3_u32 v9, v9, v16, s0
	v_cmp_u_f32_e32 vcc, v16, v16
	v_bfe_u32 v16, v15, 16, 1
	v_add3_u32 v16, v16, v15, s0
	v_cndmask_b32_e32 v9, v9, v17, vcc
	v_or_b32_e32 v17, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	s_nop 1
	v_cndmask_b32_e32 v15, v16, v17, vcc
	v_bfe_u32 v16, v14, 16, 1
	v_add3_u32 v16, v16, v14, s0
	v_or_b32_e32 v17, 0x400000, v14
	v_cmp_u_f32_e32 vcc, v14, v14
	s_nop 1
	v_cndmask_b32_e32 v14, v16, v17, vcc
	v_pk_mul_f32 v[16:17], v[24:25], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[28:29], v[16:17]
	ds_write_b16_d16_hi v1, v14
	ds_write_b16_d16_hi v1, v15 offset:256
	ds_write_b16_d16_hi v1, v9 offset:512
	ds_write_b16_d16_hi v1, v7 offset:768
	v_pk_mul_f32 v[16:17], v[16:17], v[36:37]
	v_pk_mul_f32 v[14:15], v[24:25], v[30:31] op_sel_hi:[0,1]
	v_bfe_u32 v7, v17, 16, 1
	v_pk_mul_f32 v[14:15], v[26:27], v[14:15]
	v_add3_u32 v7, v7, v17, s0
	v_or_b32_e32 v9, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	v_pk_mul_f32 v[14:15], v[14:15], v[34:35]
	v_or_b32_e32 v17, 0x400000, v16
	v_cndmask_b32_e32 v7, v7, v9, vcc
	v_bfe_u32 v9, v16, 16, 1
	v_add3_u32 v9, v9, v16, s0
	v_cmp_u_f32_e32 vcc, v16, v16
	v_bfe_u32 v16, v15, 16, 1
	v_add3_u32 v16, v16, v15, s0
	v_cndmask_b32_e32 v9, v9, v17, vcc
	v_or_b32_e32 v17, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	s_nop 1
	v_cndmask_b32_e32 v15, v16, v17, vcc
	v_bfe_u32 v16, v14, 16, 1
	v_add3_u32 v16, v16, v14, s0
	v_or_b32_e32 v17, 0x400000, v14
	v_cmp_u_f32_e32 vcc, v14, v14
	s_nop 1
	v_cndmask_b32_e32 v14, v16, v17, vcc
	ds_write_b16_d16_hi v1, v14 offset:32
	ds_write_b16_d16_hi v1, v15 offset:288
	ds_write_b16_d16_hi v1, v9 offset:544
	ds_write_b16_d16_hi v1, v7 offset:800
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[14:15], v[8:9], v[38:39] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9]
	v_pk_mul_f32 v[10:11], v[10:11], v[14:15]
	v_pk_mul_f32 v[8:9], v[8:9], v[44:45]
	v_pk_mul_f32 v[10:11], v[10:11], v[42:43]
	v_bfe_u32 v7, v9, 16, 1
	v_add3_u32 v7, v7, v9, s0
	v_or_b32_e32 v12, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v7, v7, v12, vcc
	v_or_b32_e32 v12, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v12, vcc
	v_bfe_u32 v9, v11, 16, 1
	v_add3_u32 v9, v9, v11, s0
	v_or_b32_e32 v12, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_bfe_u32 v11, v10, 16, 1
	v_add3_u32 v11, v11, v10, s0
	v_cndmask_b32_e32 v9, v9, v12, vcc
	v_or_b32_e32 v12, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v11, v12, vcc
	ds_write_b16_d16_hi v1, v10 offset:4096
	ds_write_b16_d16_hi v1, v9 offset:4352
	ds_write_b16_d16_hi v1, v8 offset:4608
	ds_write_b16_d16_hi v1, v7 offset:4864
	v_pk_mul_f32 v[10:11], v[24:25], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[20:21], v[10:11]
	v_pk_mul_f32 v[8:9], v[24:25], v[38:39] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[44:45]
	v_pk_mul_f32 v[8:9], v[18:19], v[8:9]
	v_bfe_u32 v7, v11, 16, 1
	v_add3_u32 v7, v7, v11, s0
	v_or_b32_e32 v12, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_bfe_u32 v11, v10, 16, 1
	v_pk_mul_f32 v[8:9], v[8:9], v[42:43]
	v_cndmask_b32_e32 v7, v7, v12, vcc
	v_add3_u32 v11, v11, v10, s0
	v_or_b32_e32 v12, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v11, v12, vcc
	v_bfe_u32 v11, v9, 16, 1
	v_add3_u32 v11, v11, v9, s0
	v_or_b32_e32 v12, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v11, v12, vcc
	v_bfe_u32 v11, v8, 16, 1
	v_add3_u32 v11, v11, v8, s0
	v_or_b32_e32 v12, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v11, v12, vcc
	ds_write_b16_d16_hi v1, v8 offset:4128
	ds_write_b16_d16_hi v1, v9 offset:4384
	ds_write_b16_d16_hi v1, v10 offset:4640
	ds_write_b16_d16_hi v1, v7 offset:4896
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v1, 0xffffff, v6
	v_cmp_gt_i32_e32 vcc, s6, v1
	v_lshlrev_b32_e32 v1, 1, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_3
	v_lshl_or_b32 v8, v2, 8, v1
	v_lshl_add_u32 v6, v6, 12, s28
	ds_read_b32 v9, v8
	v_or_b32_e32 v6, v6, v0
	v_lshlrev_b32_e32 v6, 1, v6
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[2:3], 0, v[6:7]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[6:7], v9, off
	ds_read_b32 v8, v8 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_3:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v6, 0xffffff, v5
	v_cmp_gt_i32_e32 vcc, s6, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_5
	v_lshl_or_b32 v8, v2, 8, v1
	v_lshl_add_u32 v5, v5, 12, s28
	ds_read_b32 v9, v8 offset:2048
	v_or_b32_e32 v5, v5, v0
	v_lshlrev_b32_e32 v6, 1, v5
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[2:3], 0, v[6:7]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[6:7], v9, off
	ds_read_b32 v5, v8 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[6:7], v5, off offset:128
.LBB0_5:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v5, 0xffffff, v4
	v_cmp_gt_i32_e32 vcc, s6, v5
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_7
	v_lshl_or_b32 v6, v2, 8, v1
	v_lshl_add_u32 v4, v4, 12, s28
	ds_read_b32 v7, v6 offset:4096
	v_or_b32_e32 v4, v4, v0
	v_lshlrev_b32_e32 v4, 1, v4
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshl_add_u64 v[4:5], s[2:3], 0, v[4:5]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v7, off
	ds_read_b32 v6, v6 offset:4224
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v6, off offset:128
.LBB0_7:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v4, 0xffffff, v3
	v_cmp_gt_i32_e32 vcc, s6, v4
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshl_or_b32 v2, v2, 8, v1
	v_lshl_add_u32 v3, v3, 12, s28
	ds_read_b32 v4, v2 offset:6144
	v_or_b32_e32 v0, v3, v0
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[2:3], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v4, off
	ds_read_b32 v2, v2 offset:6272
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_9:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds, .Lfunc_end0-a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds
		.amdhsa_group_segment_fixed_size 8192
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
		.amdhsa_next_free_vgpr 69
		.amdhsa_next_free_sgpr 30
		.amdhsa_accum_offset 72
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

	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.num_vgpr, 69
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.num_agpr, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.numbered_sgpr, 30
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.num_named_barrier, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.private_seg_size, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.uses_vcc, 1
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.uses_flat_scratch, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.has_dyn_sized_stack, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.has_recursion, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.has_indirect_call, 0
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
    .group_segment_fixed_size: 8192
    .kernarg_segment_align: 8
    .kernarg_segment_size: 76
    .max_flat_workgroup_size: 256
    .name:           a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     36
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     69
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
