	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
	.p2align	8
	.type	a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn,@function
a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn:
	s_load_dwordx16 s[12:27], s[0:1], 0x0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[22:23], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s3, 31
	s_lshr_b32 s4, s4, 26
	s_add_i32 s4, s3, s4
	s_ashr_i32 s8, s4, 6
	s_andn2_b32 s4, s4, 63
	s_cmp_lg_u32 s3, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s3, s8, 0
	s_lshl_b32 s4, s3, 5
	s_cmp_ge_i32 s2, s4
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_41
	s_lshr_b32 s4, s4, 3
	s_and_b32 s5, s2, 7
	s_mul_i32 s4, s4, s5
	s_lshr_b32 s2, s2, 3
	s_add_i32 s2, s4, s2
	s_ashr_i32 s4, s2, 31
	s_lshr_b32 s4, s4, 27
	s_add_i32 s4, s2, s4
	s_ashr_i32 s8, s4, 5
	s_and_b32 s9, s4, 0xffffffe0
	s_cmp_lg_u32 s2, s9
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s2, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s28, s8, 0
	s_ashr_i32 s29, s28, 31
	s_sub_i32 s2, s2, s9
	s_lshl_b64 s[4:5], s[28:29], 2
	s_add_u32 s4, s20, s4
	s_addc_u32 s5, s21, s5
	s_load_dword s4, s[4:5], 0x0
	s_lshr_b32 s3, s3, 1
	s_lshl_b32 s38, s2, 7
	s_and_b32 s20, s3, 0x7fffffe0
	s_add_i32 s3, s38, s20
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s4, 12
	s_add_i32 s3, s3, s2
	v_and_b32_e32 v2, 48, v0
	v_and_b32_e32 v3, 15, v0
	s_lshl_b32 s2, s3, 1
	v_or3_b32 v1, s2, v2, v3
	s_mov_b32 s11, 0x27000
	s_and_b32 s9, s19, 0xffff
	s_mov_b32 s10, 0x800000
	s_mov_b32 s8, s18
	v_lshlrev_b32_e32 v1, 2, v1
	buffer_load_dword v4, v1, s[8:11], 0 offen
	s_lshl_b32 s2, s3, 3
	s_ashr_i32 s4, s3, 4
	s_lshr_b32 s3, s3, 31
	v_or3_b32 v6, s2, v2, v3
	s_or_b32 s2, s4, 1
	s_add_i32 s3, s2, s3
	s_and_b32 s3, s3, -2
	s_lshl_b32 s4, s2, 7
	s_sub_i32 s2, s2, s3
	s_lshl_b32 s2, s2, 3
	v_or3_b32 v2, s4, v2, v3
	s_add_i32 s3, s2, 16
	v_lshlrev_b32_e32 v41, 4, v6
	v_lshlrev_b32_e32 v40, 4, v2
	s_lshl_b32 s36, s28, 6
	v_and_b32_e32 v5, 63, v0
	s_ashr_i32 s37, s36, 31
	s_load_dwordx2 s[34:35], s[0:1], 0x40
	s_load_dword s33, s[0:1], 0x48
	v_lshlrev_b32_e32 v5, 2, v5
	s_and_b32 s17, s17, 0xffff
	s_and_b32 s21, s13, 0xffff
	s_lshl_b64 s[0:1], s[36:37], 2
	v_xor_b32_e32 v5, 0x80, v5
	s_add_u32 s0, s24, s0
	s_addc_u32 s1, s25, s1
	s_load_dword s13, s[0:1], 0x80
	s_load_dword s37, s[0:1], 0xc0
	v_lshrrev_b32_e32 v61, 4, v0
	v_bfe_u32 v62, v0, 4, 2
	s_brev_b32 s39, 16
	s_mov_b32 s22, -1
	s_mov_b64 s[18:19], -1
	v_lshlrev_b32_e32 v1, 4, v0
	v_lshrrev_b32_e32 v60, 5, v0
	v_lshlrev_b32_e32 v64, 1, v0
	v_lshlrev_b32_e32 v37, 5, v62
	v_lshlrev_b32_e32 v36, 8, v3
	v_lshlrev_b32_e32 v38, 4, v3
	v_or_b32_e32 v14, s36, v61
	v_or_b32_e32 v63, s20, v3
	s_waitcnt vmcnt(0)
	v_bfe_u32 v2, v4, s2, 8
	v_bfe_u32 v6, v4, s3, 8
	v_max_u32_sdwa v7, v4, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	v_max_u32_e32 v9, v6, v2
	ds_swizzle_b32 v8, v7 offset:swizzle(SWAP,16)
	ds_swizzle_b32 v10, v9 offset:swizzle(SWAP,16)
	s_load_dword s2, s[0:1], 0x40
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v7, v8, v7
	v_max_i32_e32 v9, v10, v9
	ds_bpermute_b32 v8, v5, v7
	ds_bpermute_b32 v5, v5, v9
	s_and_b32 s0, s2, 0xffffff
	s_cmp_lt_i32 s0, s33
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v66, v8, v7
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v65, v5, v9
	v_sub_u32_sdwa v42, v66, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_sub_u32_sdwa v39, v66, v4 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_sub_u32_e32 v68, v65, v2
	v_sub_u32_e32 v67, v65, v6
	v_cmp_lt_u32_e32 vcc, 5, v66
	v_min_i32_e32 v44, 11, v42
	v_cmp_lt_i32_e64 s[6:7], 11, v42
	v_min_i32_e32 v43, 11, v39
	v_cmp_lt_i32_e64 s[8:9], 11, v39
	v_cmp_lt_u32_e64 s[0:1], 5, v65
	v_min_i32_e32 v70, 11, v68
	v_cmp_lt_i32_e64 s[4:5], 11, v68
	v_min_i32_e32 v69, 11, v67
	v_cmp_lt_i32_e64 s[2:3], 11, v67
	s_cbranch_scc1 .LBB0_7
	v_xor_b32_e32 v2, v1, v0
	v_and_b32_e32 v2, 0xf0, v2
	s_mov_b32 s20, s12
	s_mov_b32 s23, s11
	v_lshl_or_b32 v2, v14, 8, v2
	buffer_load_dwordx4 v[56:59], v2, s[20:23], 0 offen nt
	s_mov_b32 s18, s39
	s_mov_b32 s19, s11
	buffer_load_dwordx4 v[10:13], v41, s[16:19], 0 offen nt
	v_and_b32_e32 v2, 0xf0, v1
	v_or_b32_e32 v15, 0x400, v41
	v_lshl_or_b32 v24, v61, 8, v2
	buffer_load_dwordx4 v[16:19], v15, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[6:9], v40, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[2:5], v40, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s10, 0x8080808
	v_xor_b32_e32 v20, v37, v38
	v_mul_lo_u32 v15, v44, s10
	v_or_b32_e32 v20, v36, v20
	v_sub_u32_e32 v26, 0x6c686080, v15
	v_sub_u32_e32 v15, 0x7c787470, v15
	v_and_b32_e32 v26, 0xffffff00, v26
	v_cndmask_b32_e64 v15, v15, 0, s[6:7]
	v_cndmask_b32_e64 v26, v26, 0, s[6:7]
	v_add_u32_e32 v28, 0x7f7f7f78, v15
	v_add_u32_e32 v30, 0x7f7f7f00, v26
	v_and_b32_e32 v28, 0x80808080, v28
	v_and_b32_e32 v30, 0x80808000, v30
	v_or_b32_e32 v21, 8, v37
	v_or_b32_e32 v22, 16, v37
	v_or_b32_e32 v23, 24, v37
	v_xor_b32_e32 v21, v21, v38
	s_mov_b32 s20, 0x5010400
	s_mov_b32 s23, 0x7030602
	v_xor_b32_e32 v22, v22, v38
	v_xor_b32_e32 v23, v23, v38
	v_or_b32_e32 v21, v36, v21
	v_or_b32_e32 v22, v36, v22
	v_or_b32_e32 v23, v36, v23
	v_mul_lo_u32 v25, v43, s10
	v_sub_u32_e32 v27, 0x6c686080, v25
	v_sub_u32_e32 v25, 0x7c787470, v25
	v_and_b32_e32 v27, 0xffffff00, v27
	v_cndmask_b32_e64 v25, v25, 0, s[8:9]
	v_cndmask_b32_e64 v27, v27, 0, s[8:9]
	v_add_u32_e32 v29, 0x7f7f7f78, v25
	v_add_u32_e32 v31, 0x7f7f7f00, v27
	v_and_b32_e32 v29, 0x80808080, v29
	v_and_b32_e32 v31, 0x80808000, v31
	s_and_b32 s9, s15, 0xffff
	s_mov_b32 s8, s14
	s_mov_b32 s6, s22
	s_mov_b32 s7, s11
	s_waitcnt vmcnt(4)
	ds_write_b128 v24, v[56:59]
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[56:57], v20
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v32, 0x7070707, v10
	v_lshrrev_b32_e32 v33, 4, v10
	v_lshlrev_b32_e32 v34, 4, v10
	v_and_b32_e32 v33, 0x7070707, v33
	v_perm_b32 v52, v28, v30, v32
	v_perm_b32 v32, v15, v26, v32
	v_and_b32_e32 v35, 0x7070707, v11
	v_and_or_b32 v24, v52, v34, v32
	v_perm_b32 v32, v28, v30, v33
	v_perm_b32 v33, v15, v26, v33
	v_lshlrev_b32_e32 v46, 4, v11
	v_perm_b32 v53, v28, v30, v35
	v_perm_b32 v35, v15, v26, v35
	v_and_or_b32 v10, v32, v10, v33
	v_lshrrev_b32_e32 v45, 4, v11
	v_and_or_b32 v34, v53, v46, v35
	ds_read_b64 v[52:53], v21
	ds_read_b64 v[58:59], v22
	ds_read_b64 v[72:73], v23
	v_perm_b32 v20, v10, v24, s20
	v_perm_b32 v21, v10, v24, s23
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v35, v28, v30, v45
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[56:57], v[20:21], 0
	v_perm_b32 v45, v15, v26, v45
	v_and_or_b32 v11, v35, v11, v45
	v_and_b32_e32 v47, 0x7070707, v12
	v_lshrrev_b32_e32 v48, 4, v12
	v_perm_b32 v10, v11, v34, s20
	v_perm_b32 v11, v11, v34, s23
	v_lshlrev_b32_e32 v49, 4, v12
	v_and_b32_e32 v48, 0x7070707, v48
	v_perm_b32 v54, v28, v30, v47
	v_perm_b32 v47, v15, v26, v47
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[52:53], v[10:11], v[20:23]
	v_and_or_b32 v46, v54, v49, v47
	v_perm_b32 v47, v28, v30, v48
	v_perm_b32 v48, v15, v26, v48
	v_and_or_b32 v11, v47, v12, v48
	v_and_b32_e32 v50, 0x7070707, v13
	v_lshrrev_b32_e32 v51, 4, v13
	v_perm_b32 v10, v11, v46, s20
	v_perm_b32 v11, v11, v46, s23
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v55, v28, v30, v50
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[58:59], v[10:11], v[20:23]
	v_lshlrev_b32_e32 v10, 4, v13
	v_perm_b32 v11, v15, v26, v50
	v_and_or_b32 v11, v55, v10, v11
	v_perm_b32 v10, v28, v30, v51
	v_perm_b32 v12, v15, v26, v51
	v_and_or_b32 v12, v10, v13, v12
	v_perm_b32 v10, v12, v11, s20
	v_perm_b32 v11, v12, v11, s23
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v15, 0x7070707, v16
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v35, 4, v9
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[72:73], v[10:11], v[20:23]
	s_nop 2
	v_lshrrev_b32_e32 v20, 4, v16
	v_and_b32_e32 v20, 0x7070707, v20
	v_perm_b32 v21, v29, v31, v15
	v_lshlrev_b32_e32 v22, 4, v16
	v_perm_b32 v15, v25, v27, v15
	v_and_or_b32 v15, v21, v22, v15
	v_perm_b32 v21, v29, v31, v20
	v_perm_b32 v20, v25, v27, v20
	v_and_or_b32 v16, v21, v16, v20
	v_perm_b32 v20, v16, v15, s20
	v_perm_b32 v21, v16, v15, s23
	v_or_b32_e32 v15, 0x80, v37
	v_xor_b32_e32 v15, v15, v38
	v_or_b32_e32 v15, v36, v15
	ds_read_b64 v[46:47], v15
	v_or_b32_e32 v15, 0x88, v37
	v_or_b32_e32 v16, 0x90, v37
	v_xor_b32_e32 v15, v15, v38
	v_xor_b32_e32 v16, v16, v38
	v_or_b32_e32 v22, 0x98, v37
	v_or_b32_e32 v15, v36, v15
	v_or_b32_e32 v16, v36, v16
	v_xor_b32_e32 v22, v22, v38
	v_or_b32_e32 v22, v36, v22
	ds_read_b64 v[48:49], v15
	ds_read_b64 v[50:51], v16
	ds_read_b64 v[54:55], v22
	v_and_b32_e32 v15, 0x7070707, v17
	v_lshrrev_b32_e32 v16, 4, v17
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[46:47], v[20:21], v[10:13]
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v20, v29, v31, v15
	v_lshlrev_b32_e32 v21, 4, v17
	v_perm_b32 v15, v25, v27, v15
	v_and_or_b32 v15, v20, v21, v15
	v_perm_b32 v20, v29, v31, v16
	v_perm_b32 v16, v25, v27, v16
	v_and_or_b32 v17, v20, v17, v16
	v_perm_b32 v16, v17, v15, s20
	v_perm_b32 v17, v17, v15, s23
	v_and_b32_e32 v15, 0x7070707, v18
	v_lshlrev_b32_e32 v20, 4, v18
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[48:49], v[16:17], v[10:13]
	v_lshrrev_b32_e32 v16, 4, v18
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v17, v29, v31, v15
	v_perm_b32 v15, v25, v27, v15
	v_and_or_b32 v15, v17, v20, v15
	v_perm_b32 v17, v29, v31, v16
	v_perm_b32 v16, v25, v27, v16
	v_and_or_b32 v17, v17, v18, v16
	v_perm_b32 v16, v17, v15, s20
	v_perm_b32 v17, v17, v15, s23
	v_and_b32_e32 v15, 0x7070707, v19
	v_lshlrev_b32_e32 v18, 4, v19
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[50:51], v[16:17], v[10:13]
	v_lshrrev_b32_e32 v16, 4, v19
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v17, v29, v31, v15
	v_perm_b32 v15, v25, v27, v15
	v_and_or_b32 v15, v17, v18, v15
	v_perm_b32 v17, v29, v31, v16
	v_perm_b32 v16, v25, v27, v16
	v_and_or_b32 v17, v17, v19, v16
	v_perm_b32 v16, v17, v15, s20
	v_perm_b32 v17, v17, v15, s23
	v_mul_lo_u32 v15, v70, s10
	v_lshlrev_b32_e32 v19, 4, v6
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[54:55], v[16:17], v[10:13]
	v_sub_u32_e32 v16, 0x6c686080, v15
	v_and_b32_e32 v16, 0xffffff00, v16
	v_sub_u32_e32 v15, 0x7c787470, v15
	v_cndmask_b32_e64 v28, v16, 0, s[4:5]
	v_cndmask_b32_e64 v15, v15, 0, s[4:5]
	v_add_u32_e32 v16, 0x7f7f7f00, v28
	v_and_b32_e32 v29, 0x80808000, v16
	v_add_u32_e32 v16, 0x7f7f7f78, v15
	v_and_b32_e32 v30, 0x80808080, v16
	v_mul_lo_u32 v16, v69, s10
	v_sub_u32_e32 v17, 0x6c686080, v16
	v_and_b32_e32 v17, 0xffffff00, v17
	v_sub_u32_e32 v16, 0x7c787470, v16
	v_cndmask_b32_e64 v31, v17, 0, s[2:3]
	v_cndmask_b32_e64 v32, v16, 0, s[2:3]
	v_add_u32_e32 v16, 0x7f7f7f00, v31
	v_and_b32_e32 v33, 0x80808000, v16
	v_add_u32_e32 v16, 0x7f7f7f78, v32
	v_and_b32_e32 v34, 0x80808080, v16
	v_and_b32_e32 v16, 0x7070707, v6
	v_lshrrev_b32_e32 v17, 4, v6
	v_and_b32_e32 v17, 0x7070707, v17
	v_perm_b32 v18, v30, v29, v16
	v_perm_b32 v16, v15, v28, v16
	v_and_or_b32 v18, v18, v19, v16
	v_perm_b32 v16, v30, v29, v17
	v_perm_b32 v17, v15, v28, v17
	v_and_or_b32 v6, v16, v6, v17
	v_perm_b32 v16, v6, v18, s20
	v_perm_b32 v17, v6, v18, s23
	v_and_b32_e32 v6, 0x7070707, v7
	v_lshrrev_b32_e32 v20, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[56:57], v[16:17], 0
	v_and_b32_e32 v20, 0x7070707, v20
	v_perm_b32 v21, v30, v29, v6
	v_lshlrev_b32_e32 v22, 4, v7
	v_perm_b32 v6, v15, v28, v6
	v_and_or_b32 v21, v21, v22, v6
	v_perm_b32 v6, v30, v29, v20
	v_perm_b32 v20, v15, v28, v20
	v_and_or_b32 v7, v6, v7, v20
	v_perm_b32 v6, v7, v21, s20
	v_perm_b32 v7, v7, v21, s23
	v_lshlrev_b32_e32 v21, 4, v8
	s_mov_b32 s10, s22
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[52:53], v[6:7], v[16:19]
	v_and_b32_e32 v6, 0x7070707, v8
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v20, v30, v29, v6
	v_perm_b32 v6, v15, v28, v6
	v_and_or_b32 v20, v20, v21, v6
	v_perm_b32 v6, v30, v29, v7
	v_perm_b32 v7, v15, v28, v7
	v_and_or_b32 v7, v6, v8, v7
	v_perm_b32 v6, v7, v20, s20
	v_perm_b32 v7, v7, v20, s23
	v_lshlrev_b32_e32 v20, 4, v62
	v_lshl_or_b32 v24, s28, 8, v20
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[58:59], v[6:7], v[16:19]
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v30, v29, v6
	v_perm_b32 v6, v15, v28, v6
	s_barrier
	buffer_load_dwordx4 v[20:23], v24, s[8:11], 0 offen
	s_and_b32 s5, s27, 0xffff
	s_mov_b32 s4, s26
	v_and_or_b32 v8, v8, v35, v6
	v_perm_b32 v6, v30, v29, v7
	v_perm_b32 v7, v15, v28, v7
	buffer_load_dwordx4 v[24:27], v24, s[4:7], 0 offen
	v_and_or_b32 v7, v6, v9, v7
	v_perm_b32 v6, v7, v8, s20
	v_perm_b32 v7, v7, v8, s23
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v15, 0x7070707, v2
	s_and_b32 s9, s25, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[72:73], v[6:7], v[16:19]
	s_mov_b32 s8, s24
	s_mov_b32 s2, 0x20000
	s_nop 0
	v_lshrrev_b32_e32 v16, 4, v2
	v_and_b32_e32 v16, 0x7070707, v16
	v_perm_b32 v17, v34, v33, v15
	v_lshlrev_b32_e32 v18, 4, v2
	v_perm_b32 v15, v32, v31, v15
	v_and_or_b32 v15, v17, v18, v15
	v_perm_b32 v17, v34, v33, v16
	v_perm_b32 v16, v32, v31, v16
	v_and_or_b32 v2, v17, v2, v16
	v_perm_b32 v16, v2, v15, s20
	v_perm_b32 v17, v2, v15, s23
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v15, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[46:47], v[16:17], v[6:9]
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v34, v33, v2
	v_lshlrev_b32_e32 v17, 4, v3
	v_perm_b32 v2, v32, v31, v2
	v_and_or_b32 v16, v16, v17, v2
	v_perm_b32 v2, v34, v33, v15
	v_perm_b32 v15, v32, v31, v15
	v_and_or_b32 v3, v2, v3, v15
	v_perm_b32 v2, v3, v16, s20
	v_perm_b32 v3, v3, v16, s23
	v_lshlrev_b32_e32 v16, 4, v4
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[48:49], v[2:3], v[6:9]
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v15, v34, v33, v2
	v_perm_b32 v2, v32, v31, v2
	v_and_or_b32 v15, v15, v16, v2
	v_perm_b32 v2, v34, v33, v3
	v_perm_b32 v3, v32, v31, v3
	v_and_or_b32 v3, v2, v4, v3
	v_perm_b32 v2, v3, v15, s20
	v_perm_b32 v3, v3, v15, s23
	v_lshlrev_b32_e32 v15, 4, v5
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[50:51], v[2:3], v[6:9]
	v_and_b32_e32 v2, 0x7070707, v5
	v_lshrrev_b32_e32 v3, 4, v5
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v34, v33, v2
	v_perm_b32 v2, v32, v31, v2
	v_and_or_b32 v2, v4, v15, v2
	v_perm_b32 v4, v34, v33, v3
	v_perm_b32 v3, v32, v31, v3
	v_and_or_b32 v3, v4, v5, v3
	v_or_b32_e32 v4, s36, v60
	v_lshlrev_b32_e32 v5, 2, v4
	buffer_load_dword v4, v5, s[8:11], 0 offen
	v_perm_b32 v16, v3, v2, s20
	v_perm_b32 v17, v3, v2, s23
	buffer_load_dword v2, v5, s[8:11], 0 offen offset:32
	v_mov_b32_e32 v3, 0xfd800000
	v_lshl_add_u32 v5, v66, 23, v3
	v_lshlrev_b32_e64 v15, v66, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[54:55], v[16:17], v[6:9]
	v_cndmask_b32_e32 v16, v15, v5, vcc
	v_lshl_add_u32 v3, v65, 23, v3
	v_lshlrev_b32_e64 v5, v65, s2
	v_cndmask_b32_e64 v18, v5, v3, s[0:1]
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[28:29], v[16:17], v[20:21] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[16:17], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[16:17]
	s_movk_i32 s0, 0x7fff
	v_pk_mul_f32 v[10:11], v[10:11], v[28:29]
	v_and_b32_e32 v3, 62, v64
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[12:13], v[12:13], v[26:27]
	v_pk_mul_f32 v[10:11], v[10:11], v[24:25]
	v_bfe_u32 v5, v13, 16, 1
	v_add3_u32 v5, v5, v13, s0
	v_or_b32_e32 v15, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	v_bfe_u32 v13, v12, 16, 1
	v_add3_u32 v13, v13, v12, s0
	v_cndmask_b32_e32 v5, v5, v15, vcc
	v_or_b32_e32 v15, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	s_nop 1
	v_cndmask_b32_e32 v12, v13, v15, vcc
	v_bfe_u32 v13, v11, 16, 1
	v_add3_u32 v13, v13, v11, s0
	v_or_b32_e32 v15, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v11, v13, v15, vcc
	v_bfe_u32 v13, v10, 16, 1
	v_add3_u32 v13, v13, v10, s0
	v_or_b32_e32 v15, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v13, v15, vcc
	v_lshlrev_b32_e32 v13, 1, v63
	v_lshl_add_u32 v15, v62, 10, v13
	ds_write_b16_d16_hi v15, v10
	ds_write_b16_d16_hi v15, v11 offset:256
	ds_write_b16_d16_hi v15, v12 offset:512
	ds_write_b16_d16_hi v15, v5 offset:768
	v_pk_mul_f32 v[12:13], v[18:19], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[12:13]
	v_pk_mul_f32 v[10:11], v[18:19], v[20:21] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[26:27]
	v_pk_mul_f32 v[6:7], v[6:7], v[10:11]
	v_bfe_u32 v5, v9, 16, 1
	v_add3_u32 v5, v5, v9, s0
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[24:25]
	v_cndmask_b32_e32 v5, v5, v10, vcc
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
	ds_write_b16_d16_hi v15, v6 offset:32
	ds_write_b16_d16_hi v15, v7 offset:288
	ds_write_b16_d16_hi v15, v8 offset:544
	ds_write_b16_d16_hi v15, v5 offset:800
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v5, 0xffffff, v4
	v_cmp_gt_i32_e32 vcc, s33, v5
	v_lshlrev_b32_e32 v5, 1, v3
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_4
	v_lshl_or_b32 v8, v60, 8, v5
	v_lshl_add_u32 v4, v4, 12, s38
	ds_read_b32 v9, v8
	v_or_b32_e32 v4, v4, v3
	v_lshlrev_b32_e32 v6, 1, v4
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[34:35], 0, v[6:7]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[6:7], v9, off
	ds_read_b32 v4, v8 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[6:7], v4, off offset:128
.LBB0_4:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v4, 0xffffff, v2
	v_cmp_gt_i32_e32 vcc, s33, v4
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_6
	v_lshl_or_b32 v4, v60, 8, v5
	v_lshl_add_u32 v2, v2, 12, s38
	ds_read_b32 v5, v4 offset:2048
	v_or_b32_e32 v2, v2, v3
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_6:
	s_or_b64 exec, exec, s[0:1]
	s_mov_b64 s[18:19], 0
.LBB0_7:
	s_and_b64 vcc, exec, s[18:19]
	s_cbranch_vccz .LBB0_41
	s_or_b32 s10, s36, 16
	v_xor_b32_e32 v0, v1, v0
	s_and_b32 s0, s13, 0xffffff
	v_and_b32_e32 v2, 0xf0, v1
	v_and_b32_e32 v48, 0xf0, v0
	v_lshlrev_b32_e32 v0, 8, v61
	v_or_b32_e32 v1, s10, v61
	s_cmp_lt_u32 s0, s33
	v_lshl_or_b32 v46, v14, 8, v48
	v_lshl_or_b32 v47, v1, 8, v48
	s_mov_b64 s[18:19], -1
	v_add_u32_e32 v45, v0, v2
	v_cmp_lt_i32_e64 s[8:9], 11, v42
	v_cmp_lt_i32_e64 s[6:7], 11, v39
	v_cmp_lt_i32_e64 s[4:5], 11, v68
	v_cmp_lt_i32_e64 s[2:3], 11, v67
	v_cmp_lt_u32_e64 s[0:1], 5, v66
	v_cmp_lt_u32_e32 vcc, 5, v65
	v_lshlrev_b32_e32 v71, 2, v62
	s_cbranch_scc1 .LBB0_18
	s_mov_b32 s20, s12
	s_mov_b32 s23, s11
	buffer_load_dwordx4 v[26:29], v46, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[30:33], v47, s[20:23], 0 offen nt
	s_mov_b32 s18, s39
	s_mov_b32 s19, s11
	buffer_load_dwordx4 v[0:3], v41, s[16:19], 0 offen nt
	v_or_b32_e32 v16, 0x400, v41
	buffer_load_dwordx4 v[8:11], v16, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[12:15], v40, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[4:7], v40, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s23, 0x8080808
	v_or_b32_e32 v18, 8, v37
	v_mul_lo_u32 v16, v44, s23
	v_mul_lo_u32 v21, v43, s23
	v_xor_b32_e32 v18, v18, v38
	v_sub_u32_e32 v22, 0x6c686080, v16
	v_sub_u32_e32 v16, 0x7c787470, v16
	v_sub_u32_e32 v23, 0x6c686080, v21
	v_or_b32_e32 v24, v36, v18
	v_and_b32_e32 v18, 0xffffff00, v22
	v_xor_b32_e32 v17, v37, v38
	v_or_b32_e32 v19, 16, v37
	v_cndmask_b32_e64 v54, v16, 0, s[8:9]
	v_and_b32_e32 v16, 0xffffff00, v23
	v_cndmask_b32_e64 v55, v18, 0, s[8:9]
	v_or_b32_e32 v17, v36, v17
	v_xor_b32_e32 v19, v19, v38
	v_add_u32_e32 v18, 0x7f7f7f78, v54
	v_cndmask_b32_e64 v59, v16, 0, s[6:7]
	v_add_u32_e32 v16, 0x7f7f7f00, v55
	v_or_b32_e32 v25, v36, v19
	v_and_b32_e32 v56, 0x80808080, v18
	v_and_b32_e32 v72, 0x80808000, v16
	v_or_b32_e32 v20, 24, v37
	v_xor_b32_e32 v20, v20, v38
	v_sub_u32_e32 v21, 0x7c787470, v21
	v_or_b32_e32 v49, v36, v20
	v_cndmask_b32_e64 v58, v21, 0, s[6:7]
	s_mov_b32 s13, 0x5010400
	s_mov_b32 s20, 0x7030602
	v_add_u32_e32 v57, 0x7f7f7f00, v59
	v_mul_lo_u32 v83, v69, s23
	s_mov_b32 s7, 0x27000
	s_mov_b32 s6, -1
	s_and_b32 s29, s27, 0xffff
	s_mov_b32 s28, s26
	s_mov_b32 s30, s6
	s_mov_b32 s31, s7
	s_waitcnt vmcnt(5)
	ds_write_b128 v45, v[26:29]
	s_waitcnt vmcnt(4)
	ds_write_b128 v45, v[30:33] offset:4096
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[16:19], v17 offset1:8
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v28, 0x7070707, v0
	v_lshrrev_b32_e32 v29, 4, v0
	ds_read2st64_b64 v[20:23], v24 offset1:8
	v_lshlrev_b32_e32 v30, 4, v0
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v51, v56, v72, v28
	v_perm_b32 v28, v54, v55, v28
	v_and_or_b32 v28, v51, v30, v28
	v_perm_b32 v30, v56, v72, v29
	v_perm_b32 v29, v54, v55, v29
	v_and_b32_e32 v31, 0x7070707, v1
	v_lshrrev_b32_e32 v32, 4, v1
	v_and_b32_e32 v33, 0x7070707, v2
	v_and_or_b32 v0, v30, v0, v29
	v_lshlrev_b32_e32 v34, 4, v1
	v_lshrrev_b32_e32 v35, 4, v2
	v_and_b32_e32 v52, 0x7070707, v32
	v_perm_b32 v53, v56, v72, v31
	v_perm_b32 v76, v54, v55, v31
	v_perm_b32 v78, v56, v72, v33
	v_perm_b32 v79, v54, v55, v33
	v_perm_b32 v32, v0, v28, s13
	v_perm_b32 v33, v0, v28, s20
	v_and_b32_e32 v77, 0x7070707, v35
	v_and_or_b32 v51, v53, v34, v76
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[16:17], v[32:33], 0
	ds_read2st64_b64 v[24:27], v25 offset1:8
	v_perm_b32 v0, v56, v72, v52
	v_perm_b32 v52, v54, v55, v52
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[18:19], v[32:33], 0
	v_and_or_b32 v1, v0, v1, v52
	v_lshlrev_b32_e32 v50, 4, v2
	v_perm_b32 v0, v1, v51, s13
	v_perm_b32 v1, v1, v51, s20
	v_perm_b32 v51, v56, v72, v77
	v_perm_b32 v52, v54, v55, v77
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[20:21], v[0:1], v[28:31]
	v_and_or_b32 v50, v78, v50, v79
	v_lshrrev_b32_e32 v74, 4, v3
	v_and_b32_e32 v73, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[22:23], v[0:1], v[32:35]
	v_and_or_b32 v1, v51, v2, v52
	v_perm_b32 v0, v1, v50, s13
	v_perm_b32 v1, v1, v50, s20
	ds_read2st64_b64 v[50:53], v49 offset1:8
	v_and_b32_e32 v2, 0x7070707, v74
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[24:25], v[0:1], v[28:31]
	v_lshlrev_b32_e32 v75, 4, v3
	v_perm_b32 v49, v56, v72, v73
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v74, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[26:27], v[0:1], v[32:35]
	v_perm_b32 v0, v54, v55, v73
	v_perm_b32 v1, v56, v72, v2
	v_perm_b32 v2, v54, v55, v2
	v_and_or_b32 v0, v49, v75, v0
	v_and_or_b32 v1, v1, v3, v2
	v_perm_b32 v54, v1, v0, s13
	v_perm_b32 v55, v1, v0, s20
	v_and_b32_e32 v49, 0x80808000, v57
	v_lshlrev_b32_e32 v57, 4, v8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[50:51], v[54:55], v[28:31]
	v_lshlrev_b32_e32 v77, 4, v10
	v_lshlrev_b32_e32 v81, 4, v11
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v84, 4, v13
	v_add_u32_e32 v28, 0x7f7f7f78, v58
	v_and_b32_e32 v80, 0x80808080, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[52:53], v[54:55], v[32:35]
	v_and_b32_e32 v54, 0x7070707, v8
	v_perm_b32 v56, v80, v49, v54
	v_perm_b32 v54, v58, v59, v54
	v_lshrrev_b32_e32 v32, 4, v8
	v_and_b32_e32 v55, 0x7070707, v32
	v_or_b32_e32 v32, 0x80, v37
	v_xor_b32_e32 v32, v32, v38
	v_or_b32_e32 v32, v36, v32
	ds_read2st64_b64 v[32:35], v32 offset1:8
	v_and_or_b32 v56, v56, v57, v54
	v_perm_b32 v54, v80, v49, v55
	v_perm_b32 v55, v58, v59, v55
	v_and_or_b32 v8, v54, v8, v55
	v_perm_b32 v54, v8, v56, s13
	v_perm_b32 v55, v8, v56, s20
	v_and_b32_e32 v8, 0x7070707, v9
	v_perm_b32 v73, v80, v49, v8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[32:33], v[54:55], v[0:3]
	v_perm_b32 v8, v58, v59, v8
	v_and_or_b32 v73, v73, v74, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[34:35], v[54:55], v[28:31]
	v_lshrrev_b32_e32 v54, 4, v9
	v_and_b32_e32 v72, 0x7070707, v54
	v_or_b32_e32 v54, 0x88, v37
	v_xor_b32_e32 v54, v54, v38
	v_or_b32_e32 v54, v36, v54
	ds_read2st64_b64 v[54:57], v54 offset1:8
	v_perm_b32 v8, v80, v49, v72
	v_perm_b32 v72, v58, v59, v72
	v_and_or_b32 v9, v8, v9, v72
	v_perm_b32 v8, v9, v73, s13
	v_perm_b32 v9, v9, v73, s20
	v_or_b32_e32 v72, 0x90, v37
	v_xor_b32_e32 v72, v72, v38
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[54:55], v[8:9], v[0:3]
	v_or_b32_e32 v72, v36, v72
	ds_read2st64_b64 v[72:75], v72 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[56:57], v[8:9], v[28:31]
	v_and_b32_e32 v8, 0x7070707, v10
	v_lshrrev_b32_e32 v9, 4, v10
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v76, v80, v49, v8
	v_perm_b32 v8, v58, v59, v8
	v_and_or_b32 v76, v76, v77, v8
	v_perm_b32 v8, v80, v49, v9
	v_perm_b32 v9, v58, v59, v9
	v_and_or_b32 v9, v8, v10, v9
	v_perm_b32 v8, v9, v76, s13
	v_perm_b32 v9, v9, v76, s20
	v_or_b32_e32 v76, 0x98, v37
	v_xor_b32_e32 v76, v76, v38
	v_or_b32_e32 v76, v36, v76
	ds_read2st64_b64 v[76:79], v76 offset1:8
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[72:73], v[8:9], v[0:3]
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[74:75], v[8:9], v[28:31]
	v_and_b32_e32 v8, 0x7070707, v11
	v_lshrrev_b32_e32 v9, 4, v11
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v10, v80, v49, v8
	v_perm_b32 v8, v58, v59, v8
	v_and_or_b32 v8, v10, v81, v8
	v_perm_b32 v10, v80, v49, v9
	v_perm_b32 v9, v58, v59, v9
	v_and_or_b32 v9, v10, v11, v9
	v_perm_b32 v58, v9, v8, s13
	v_perm_b32 v59, v9, v8, s20
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[76:77], v[58:59], v[0:3]
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[78:79], v[58:59], v[28:31]
	s_nop 2
	v_mul_lo_u32 v28, v70, s23
	v_sub_u32_e32 v29, 0x6c686080, v28
	v_and_b32_e32 v29, 0xffffff00, v29
	v_sub_u32_e32 v28, 0x7c787470, v28
	v_cndmask_b32_e64 v49, v29, 0, s[4:5]
	v_cndmask_b32_e64 v80, v28, 0, s[4:5]
	v_add_u32_e32 v28, 0x7f7f7f00, v49
	v_and_b32_e32 v81, 0x80808000, v28
	v_add_u32_e32 v28, 0x7f7f7f78, v80
	v_and_b32_e32 v82, 0x80808080, v28
	v_and_b32_e32 v28, 0x7070707, v12
	v_lshrrev_b32_e32 v29, 4, v12
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v30, v82, v81, v28
	v_lshlrev_b32_e32 v31, 4, v12
	v_perm_b32 v28, v80, v49, v28
	v_and_or_b32 v28, v30, v31, v28
	v_perm_b32 v30, v82, v81, v29
	v_perm_b32 v29, v80, v49, v29
	v_and_or_b32 v12, v30, v12, v29
	v_perm_b32 v58, v12, v28, s13
	v_perm_b32 v59, v12, v28, s20
	v_and_b32_e32 v12, 0x7070707, v13
	s_and_b32 s5, s15, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[16:17], v[58:59], 0
	s_mov_b32 s4, s14
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[18:19], v[58:59], 0
	v_lshrrev_b32_e32 v58, 4, v13
	v_and_b32_e32 v58, 0x7070707, v58
	v_perm_b32 v59, v82, v81, v12
	v_perm_b32 v12, v80, v49, v12
	v_and_or_b32 v59, v59, v84, v12
	v_perm_b32 v12, v82, v81, v58
	v_perm_b32 v58, v80, v49, v58
	v_and_or_b32 v13, v12, v13, v58
	v_perm_b32 v12, v13, v59, s13
	v_perm_b32 v13, v13, v59, s20
	v_sub_u32_e32 v59, 0x7c787470, v83
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[20:21], v[12:13], v[28:31]
	v_sub_u32_e32 v20, 0x6c686080, v83
	v_and_b32_e32 v58, 0xffffff00, v20
	v_lshlrev_b32_e32 v21, 4, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[22:23], v[12:13], v[16:19]
	v_and_b32_e32 v12, 0x7070707, v14
	v_lshrrev_b32_e32 v13, 4, v14
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v20, v82, v81, v12
	v_perm_b32 v12, v80, v49, v12
	v_and_or_b32 v20, v20, v21, v12
	v_perm_b32 v12, v82, v81, v13
	v_perm_b32 v13, v80, v49, v13
	v_and_or_b32 v13, v12, v14, v13
	v_perm_b32 v12, v13, v20, s13
	v_perm_b32 v13, v13, v20, s20
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[24:25], v[12:13], v[28:31]
	v_lshlrev_b32_e32 v24, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[26:27], v[12:13], v[16:19]
	v_and_b32_e32 v12, 0x7070707, v15
	v_lshrrev_b32_e32 v13, 4, v15
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v14, v82, v81, v12
	v_perm_b32 v12, v80, v49, v12
	v_and_or_b32 v12, v14, v24, v12
	v_perm_b32 v14, v82, v81, v13
	v_perm_b32 v13, v80, v49, v13
	v_and_or_b32 v13, v14, v15, v13
	v_cndmask_b32_e64 v28, v58, 0, s[2:3]
	v_cndmask_b32_e64 v29, v59, 0, s[2:3]
	v_perm_b32 v24, v13, v12, s13
	v_perm_b32 v25, v13, v12, s20
	v_add_u32_e32 v30, 0x7f7f7f00, v28
	s_mov_b32 s2, 0x20000
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[50:51], v[24:25], v[20:23]
	s_nop 2
	v_add_u32_e32 v20, 0x7f7f7f78, v29
	v_and_b32_e32 v22, 0x80808000, v30
	v_and_b32_e32 v23, 0x80808080, v20
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v20, 0x7070707, v4
	v_lshrrev_b32_e32 v21, 4, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[52:53], v[24:25], v[16:19]
	v_and_b32_e32 v21, 0x7070707, v21
	v_perm_b32 v24, v23, v22, v20
	v_lshlrev_b32_e32 v25, 4, v4
	v_perm_b32 v20, v29, v28, v20
	v_and_or_b32 v24, v24, v25, v20
	v_perm_b32 v20, v23, v22, v21
	v_perm_b32 v21, v29, v28, v21
	v_and_or_b32 v4, v20, v4, v21
	v_perm_b32 v20, v4, v24, s13
	v_perm_b32 v21, v4, v24, s20
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshlrev_b32_e32 v24, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[32:33], v[20:21], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[34:35], v[20:21], v[16:19]
	v_lshrrev_b32_e32 v20, 4, v5
	v_and_b32_e32 v20, 0x7070707, v20
	v_perm_b32 v21, v23, v22, v4
	v_perm_b32 v4, v29, v28, v4
	v_and_or_b32 v21, v21, v24, v4
	v_perm_b32 v4, v23, v22, v20
	v_perm_b32 v20, v29, v28, v20
	v_and_or_b32 v5, v4, v5, v20
	v_perm_b32 v4, v5, v21, s13
	v_perm_b32 v5, v5, v21, s20
	v_lshlrev_b32_e32 v21, 4, v6
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[54:55], v[4:5], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[56:57], v[4:5], v[16:19]
	v_and_b32_e32 v4, 0x7070707, v6
	v_lshrrev_b32_e32 v5, 4, v6
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v20, v23, v22, v4
	v_perm_b32 v4, v29, v28, v4
	v_and_or_b32 v20, v20, v21, v4
	v_perm_b32 v4, v23, v22, v5
	v_perm_b32 v5, v29, v28, v5
	v_and_or_b32 v5, v4, v6, v5
	v_perm_b32 v4, v5, v20, s13
	v_perm_b32 v5, v5, v20, s20
	v_lshlrev_b32_e32 v20, 4, v7
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[72:73], v[4:5], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[74:75], v[4:5], v[16:19]
	v_and_b32_e32 v4, 0x7070707, v7
	v_lshrrev_b32_e32 v5, 4, v7
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v6, v23, v22, v4
	v_perm_b32 v4, v29, v28, v4
	v_and_or_b32 v6, v6, v20, v4
	v_perm_b32 v4, v23, v22, v5
	v_perm_b32 v5, v29, v28, v5
	v_and_or_b32 v5, v4, v7, v5
	v_perm_b32 v4, v5, v6, s13
	v_perm_b32 v5, v5, v6, s20
	v_or_b32_e32 v6, s36, v71
	v_lshlrev_b32_e32 v6, 2, v6
	buffer_load_dwordx4 v[24:27], v6, s[4:7], 0 offen
	buffer_load_dwordx4 v[28:31], v6, s[28:31], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[76:77], v[4:5], v[12:15]
	v_lshlrev_b32_e64 v7, v66, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[78:79], v[4:5], v[16:19]
	v_mov_b32_e32 v4, 0xfd800000
	v_lshl_add_u32 v5, v66, 23, v4
	v_or_b32_e32 v12, 0x44, v6
	v_cndmask_b32_e64 v18, v7, v5, s[0:1]
	v_or_b32_e32 v7, s10, v71
	v_lshlrev_b32_e32 v7, 2, v7
	buffer_load_dwordx4 v[32:35], v7, s[4:7], 0 offen
	v_or_b32_e32 v7, 64, v6
	v_or_b32_e32 v13, 0x48, v6
	v_or_b32_e32 v6, 0x4c, v6
	buffer_load_dword v50, v7, s[28:31], 0 offen
	buffer_load_dword v51, v12, s[28:31], 0 offen
	buffer_load_dword v52, v13, s[28:31], 0 offen
	buffer_load_dword v53, v6, s[28:31], 0 offen
	v_lshl_add_u32 v4, v65, 23, v4
	v_lshlrev_b32_e64 v5, v65, s2
	v_cndmask_b32_e32 v54, v5, v4, vcc
	v_or_b32_e32 v5, s36, v60
	s_and_b32 s5, s25, 0xffff
	s_mov_b32 s4, s24
	v_lshlrev_b32_e32 v13, 2, v5
	v_or_b32_e32 v5, s10, v60
	v_lshlrev_b32_e32 v19, 2, v5
	buffer_load_dword v12, v13, s[4:7], 0 offen
	buffer_load_dword v7, v13, s[4:7], 0 offen offset:32
	buffer_load_dword v6, v19, s[4:7], 0 offen
	buffer_load_dword v5, v13, s[4:7], 0 offen offset:96
	s_movk_i32 s0, 0x7fff
	v_and_b32_e32 v4, 62, v64
	s_waitcnt vmcnt(10)
	v_pk_mul_f32 v[58:59], v[18:19], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[58:59]
	v_pk_mul_f32 v[56:57], v[18:19], v[24:25] op_sel_hi:[0,1]
	s_waitcnt vmcnt(9)
	v_pk_mul_f32 v[10:11], v[10:11], v[30:31]
	v_pk_mul_f32 v[8:9], v[8:9], v[56:57]
	v_bfe_u32 v13, v11, 16, 1
	v_add3_u32 v13, v13, v11, s0
	v_or_b32_e32 v19, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_pk_mul_f32 v[8:9], v[8:9], v[28:29]
	s_nop 0
	v_cndmask_b32_e32 v11, v13, v19, vcc
	v_bfe_u32 v13, v10, 16, 1
	v_add3_u32 v13, v13, v10, s0
	v_or_b32_e32 v19, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v13, v19, vcc
	v_bfe_u32 v13, v9, 16, 1
	v_add3_u32 v13, v13, v9, s0
	v_or_b32_e32 v19, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v13, v19, vcc
	v_bfe_u32 v13, v8, 16, 1
	v_add3_u32 v13, v13, v8, s0
	v_or_b32_e32 v19, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v13, v19, vcc
	v_lshlrev_b32_e32 v13, 1, v63
	v_lshl_add_u32 v13, v62, 10, v13
	ds_write_b16_d16_hi v13, v8
	ds_write_b16_d16_hi v13, v9 offset:256
	ds_write_b16_d16_hi v13, v10 offset:512
	ds_write_b16_d16_hi v13, v11 offset:768
	v_pk_mul_f32 v[10:11], v[54:55], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[22:23], v[10:11]
	v_pk_mul_f32 v[8:9], v[54:55], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[30:31]
	v_pk_mul_f32 v[8:9], v[20:21], v[8:9]
	v_bfe_u32 v19, v11, 16, 1
	v_add3_u32 v19, v19, v11, s0
	v_or_b32_e32 v20, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_pk_mul_f32 v[8:9], v[8:9], v[28:29]
	s_nop 0
	v_cndmask_b32_e32 v11, v19, v20, vcc
	v_bfe_u32 v19, v10, 16, 1
	v_add3_u32 v19, v19, v10, s0
	v_or_b32_e32 v20, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v19, v20, vcc
	v_bfe_u32 v19, v9, 16, 1
	v_add3_u32 v19, v19, v9, s0
	v_or_b32_e32 v20, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v19, v20, vcc
	v_bfe_u32 v19, v8, 16, 1
	v_add3_u32 v19, v19, v8, s0
	v_or_b32_e32 v20, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v19, v20, vcc
	ds_write_b16_d16_hi v13, v8 offset:32
	ds_write_b16_d16_hi v13, v9 offset:288
	ds_write_b16_d16_hi v13, v10 offset:544
	ds_write_b16_d16_hi v13, v11 offset:800
	s_waitcnt vmcnt(8)
	v_pk_mul_f32 v[10:11], v[18:19], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	v_pk_mul_f32 v[8:9], v[18:19], v[32:33] op_sel_hi:[0,1]
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[2:3], v[2:3], v[52:53]
	v_pk_mul_f32 v[0:1], v[0:1], v[8:9]
	v_bfe_u32 v8, v3, 16, 1
	v_add3_u32 v8, v8, v3, s0
	v_or_b32_e32 v9, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[50:51]
	s_nop 0
	v_cndmask_b32_e32 v3, v8, v9, vcc
	v_bfe_u32 v8, v2, 16, 1
	v_add3_u32 v8, v8, v2, s0
	v_or_b32_e32 v9, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v8, v9, vcc
	v_bfe_u32 v8, v1, 16, 1
	v_add3_u32 v8, v8, v1, s0
	v_or_b32_e32 v9, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v8, v9, vcc
	v_bfe_u32 v8, v0, 16, 1
	v_add3_u32 v8, v8, v0, s0
	v_or_b32_e32 v9, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v8, v9, vcc
	ds_write_b16_d16_hi v13, v0 offset:4096
	ds_write_b16_d16_hi v13, v1 offset:4352
	ds_write_b16_d16_hi v13, v2 offset:4608
	ds_write_b16_d16_hi v13, v3 offset:4864
	v_pk_mul_f32 v[2:3], v[54:55], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[16:17], v[2:3]
	v_pk_mul_f32 v[0:1], v[54:55], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[52:53]
	v_pk_mul_f32 v[0:1], v[14:15], v[0:1]
	v_bfe_u32 v8, v3, 16, 1
	v_add3_u32 v8, v8, v3, s0
	v_or_b32_e32 v9, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[50:51]
	s_nop 0
	v_cndmask_b32_e32 v3, v8, v9, vcc
	v_bfe_u32 v8, v2, 16, 1
	v_add3_u32 v8, v8, v2, s0
	v_or_b32_e32 v9, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v8, v9, vcc
	v_bfe_u32 v8, v1, 16, 1
	v_add3_u32 v8, v8, v1, s0
	v_or_b32_e32 v9, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v8, v9, vcc
	v_bfe_u32 v8, v0, 16, 1
	v_add3_u32 v8, v8, v0, s0
	v_or_b32_e32 v9, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v8, v9, vcc
	ds_write_b16_d16_hi v13, v0 offset:4128
	ds_write_b16_d16_hi v13, v1 offset:4384
	ds_write_b16_d16_hi v13, v2 offset:4640
	ds_write_b16_d16_hi v13, v3 offset:4896
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v0, 0xffffff, v12
	v_cmp_gt_u32_e32 vcc, s33, v0
	v_lshlrev_b32_e32 v0, 1, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_11
	v_lshl_or_b32 v8, v60, 8, v0
	v_lshl_add_u32 v1, v12, 12, s38
	ds_read_b32 v9, v8
	v_or_b32_e32 v1, v1, v4
	v_lshlrev_b32_e32 v2, 1, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v9, off
	ds_read_b32 v1, v8 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off offset:128
.LBB0_11:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v1, 0xffffff, v7
	v_cmp_gt_u32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_13
	v_lshl_add_u32 v1, v7, 12, s38
	v_lshl_or_b32 v7, v60, 8, v0
	ds_read_b32 v8, v7 offset:2048
	v_or_b32_e32 v1, v1, v4
	v_lshlrev_b32_e32 v2, 1, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v8, off
	ds_read_b32 v1, v7 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off offset:128
.LBB0_13:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v1, 0xffffff, v6
	v_cmp_gt_u32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_15
	v_lshl_add_u32 v1, v6, 12, s38
	v_lshl_or_b32 v6, v60, 8, v0
	ds_read_b32 v7, v6 offset:4096
	v_or_b32_e32 v1, v1, v4
	v_lshlrev_b32_e32 v2, 1, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v7, off
	ds_read_b32 v1, v6 offset:4224
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off offset:128
.LBB0_15:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v5
	v_cmp_gt_u32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_17
	v_lshl_or_b32 v2, v60, 8, v0
	v_lshl_add_u32 v1, v5, 12, s38
	ds_read_b32 v3, v2 offset:6144
	v_or_b32_e32 v0, v1, v4
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off
	ds_read_b32 v2, v2 offset:6272
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_17:
	s_or_b64 exec, exec, s[0:1]
	s_mov_b64 s[18:19], 0
.LBB0_18:
	s_and_b64 vcc, exec, s[18:19]
	s_cbranch_vccz .LBB0_41
	s_or_b32 s13, s36, 32
	s_and_b32 s0, s37, 0xffffff
	v_or_b32_e32 v0, s13, v61
	s_mov_b32 s40, 32
	s_cmp_lt_i32 s0, s33
	s_mov_b32 s37, 8
	v_lshl_or_b32 v55, v0, 8, v48
	v_cmp_lt_i32_e64 s[8:9], 11, v42
	v_cmp_lt_i32_e64 s[6:7], 11, v39
	v_cmp_lt_i32_e64 s[4:5], 11, v68
	v_cmp_lt_i32_e64 s[2:3], 11, v67
	v_cmp_lt_u32_e64 s[0:1], 5, v66
	v_cmp_lt_u32_e32 vcc, 5, v65
	s_cbranch_scc1 .LBB0_21
	s_mov_b32 s20, s12
	s_mov_b32 s23, s11
	buffer_load_dwordx4 v[22:25], v46, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[26:29], v47, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[30:33], v55, s[20:23], 0 offen nt
	s_mov_b32 s18, s39
	s_mov_b32 s19, s11
	buffer_load_dwordx4 v[0:3], v41, s[16:19], 0 offen nt
	v_or_b32_e32 v16, 0x400, v41
	buffer_load_dwordx4 v[4:7], v16, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[12:15], v40, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[8:11], v40, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s28, 0x8080808
	v_xor_b32_e32 v17, v37, v38
	v_or_b32_e32 v20, 24, v37
	v_mul_lo_u32 v16, v44, s28
	v_or_b32_e32 v17, v36, v17
	v_xor_b32_e32 v20, v20, v38
	v_sub_u32_e32 v21, 0x6c686080, v16
	v_or_b32_e32 v18, 8, v37
	v_sub_u32_e32 v16, 0x7c787470, v16
	v_or_b32_e32 v49, v36, v20
	v_and_b32_e32 v20, 0xffffff00, v21
	v_or_b32_e32 v19, 16, v37
	v_xor_b32_e32 v18, v18, v38
	v_cndmask_b32_e64 v54, v16, 0, s[8:9]
	v_cndmask_b32_e64 v72, v20, 0, s[8:9]
	v_xor_b32_e32 v19, v19, v38
	v_or_b32_e32 v18, v36, v18
	v_add_u32_e32 v16, 0x7f7f7f78, v54
	v_add_u32_e32 v20, 0x7f7f7f00, v72
	v_or_b32_e32 v19, v36, v19
	v_and_b32_e32 v73, 0x80808080, v16
	v_and_b32_e32 v74, 0x80808000, v20
	s_mov_b32 s20, 0x5010400
	s_mov_b32 s23, 0x7030602
	s_and_b32 s29, s15, 0xffff
	s_mov_b32 s31, 0x27000
	s_mov_b32 s30, -1
	s_waitcnt vmcnt(6)
	ds_write_b128 v45, v[22:25]
	s_waitcnt vmcnt(5)
	ds_write_b128 v45, v[26:29] offset:4096
	s_waitcnt vmcnt(4)
	ds_write_b128 v45, v[30:33] offset:8192
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[28:31], v17 offset1:8
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v16, 0x7070707, v0
	v_lshrrev_b32_e32 v32, 4, v0
	ds_read2st64_b64 v[24:27], v18 offset1:8
	v_lshlrev_b32_e32 v33, 4, v0
	ds_read2st64_b64 v[20:23], v19 offset1:8
	ds_read_b64 v[90:91], v17 offset:8192
	ds_read_b64 v[94:95], v18 offset:8192
	ds_read_b64 v[96:97], v19 offset:8192
	ds_read_b64 v[98:99], v49 offset:8192
	v_and_b32_e32 v17, 0x7070707, v32
	v_perm_b32 v18, v73, v74, v16
	v_perm_b32 v16, v54, v72, v16
	v_and_or_b32 v16, v18, v33, v16
	v_perm_b32 v18, v73, v74, v17
	v_perm_b32 v17, v54, v72, v17
	v_and_or_b32 v0, v18, v0, v17
	v_and_b32_e32 v34, 0x7070707, v1
	v_lshrrev_b32_e32 v35, 4, v1
	v_perm_b32 v50, v0, v16, s20
	v_perm_b32 v51, v0, v16, s23
	v_and_b32_e32 v0, 0x7070707, v35
	v_perm_b32 v53, v73, v74, v34
	v_perm_b32 v59, v54, v72, v34
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[30:31], v[50:51], 0
	v_lshlrev_b32_e32 v52, 4, v1
	v_perm_b32 v75, v73, v74, v0
	v_perm_b32 v0, v54, v72, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[28:29], v[50:51], 0
	v_and_or_b32 v59, v53, v52, v59
	v_and_or_b32 v1, v75, v1, v0
	v_and_b32_e32 v56, 0x7070707, v2
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[90:91], v[50:51], 0
	v_lshrrev_b32_e32 v57, 4, v2
	v_perm_b32 v0, v1, v59, s20
	v_perm_b32 v1, v1, v59, s23
	v_lshlrev_b32_e32 v58, 4, v2
	v_and_b32_e32 v57, 0x7070707, v57
	v_perm_b32 v59, v73, v74, v56
	v_perm_b32 v56, v54, v72, v56
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[26:27], v[0:1], v[32:35]
	v_and_or_b32 v56, v59, v58, v56
	v_perm_b32 v58, v73, v74, v57
	v_perm_b32 v57, v54, v72, v57
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[24:25], v[0:1], v[16:19]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v77, 0x7070707, v5
	v_lshlrev_b32_e32 v81, 4, v6
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v92, 4, v13
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[94:95], v[0:1], v[50:53]
	v_and_or_b32 v1, v58, v2, v57
	v_perm_b32 v0, v1, v56, s20
	v_perm_b32 v1, v1, v56, s23
	v_mul_lo_u32 v2, v43, s28
	v_sub_u32_e32 v75, 0x7c787470, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[22:23], v[0:1], v[32:35]
	s_nop 2
	v_sub_u32_e32 v32, 0x6c686080, v2
	v_and_b32_e32 v76, 0xffffff00, v32
	ds_read2st64_b64 v[32:35], v49 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[20:21], v[0:1], v[16:19]
	v_lshlrev_b32_e32 v49, 4, v3
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[96:97], v[0:1], v[50:53]
	v_and_b32_e32 v0, 0x7070707, v3
	v_lshrrev_b32_e32 v1, 4, v3
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v73, v74, v0
	v_perm_b32 v0, v54, v72, v0
	v_and_or_b32 v0, v2, v49, v0
	v_perm_b32 v2, v73, v74, v1
	v_perm_b32 v1, v54, v72, v1
	v_and_or_b32 v1, v2, v3, v1
	v_perm_b32 v72, v1, v0, s20
	v_perm_b32 v73, v1, v0, s23
	v_cndmask_b32_e64 v54, v75, 0, s[6:7]
	v_cndmask_b32_e64 v49, v76, 0, s[6:7]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[32:33], v[72:73], v[16:19]
	v_add_u32_e32 v74, 0x7f7f7f00, v49
	v_and_b32_e32 v88, 0x80808000, v74
	v_lshlrev_b32_e32 v76, 4, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[34:35], v[72:73], v[56:59]
	s_mov_b32 s6, s30
	s_mov_b32 s7, s31
	s_nop 0
	v_add_u32_e32 v56, 0x7f7f7f78, v54
	v_and_b32_e32 v89, 0x80808080, v56
	v_lshrrev_b32_e32 v56, 4, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[98:99], v[72:73], v[50:53]
	v_and_b32_e32 v73, 0x7070707, v56
	v_or_b32_e32 v56, 0x80, v37
	v_xor_b32_e32 v56, v56, v38
	v_or_b32_e32 v75, v36, v56
	ds_read2st64_b64 v[56:59], v75 offset1:8
	ds_read_b64 v[100:101], v75 offset:8192
	v_and_b32_e32 v72, 0x7070707, v4
	v_perm_b32 v74, v89, v88, v72
	v_perm_b32 v72, v54, v49, v72
	v_and_or_b32 v74, v74, v76, v72
	v_perm_b32 v72, v89, v88, v73
	v_perm_b32 v73, v54, v49, v73
	v_and_or_b32 v4, v72, v4, v73
	v_perm_b32 v72, v4, v74, s20
	v_perm_b32 v73, v4, v74, s23
	v_or_b32_e32 v74, 0x90, v37
	v_or_b32_e32 v4, 0x88, v37
	v_xor_b32_e32 v74, v74, v38
	v_xor_b32_e32 v4, v4, v38
	v_or_b32_e32 v76, v36, v74
	v_or_b32_e32 v74, 0x98, v37
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[56:57], v[72:73], v[0:3]
	v_or_b32_e32 v4, v36, v4
	v_xor_b32_e32 v74, v74, v38
	v_or_b32_e32 v84, v36, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[58:59], v[72:73], v[16:19]
	ds_read_b64 v[102:103], v4 offset:8192
	ds_read_b64 v[104:105], v76 offset:8192
	ds_read_b64 v[106:107], v84 offset:8192
	v_perm_b32 v79, v89, v88, v77
	v_perm_b32 v77, v54, v49, v77
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[100:101], v[72:73], v[50:53]
	v_lshrrev_b32_e32 v72, 4, v5
	v_and_b32_e32 v78, 0x7070707, v72
	ds_read2st64_b64 v[72:75], v4 offset1:8
	v_lshlrev_b32_e32 v4, 4, v5
	v_and_or_b32 v77, v79, v4, v77
	v_perm_b32 v4, v89, v88, v78
	v_perm_b32 v78, v54, v49, v78
	v_and_or_b32 v5, v4, v5, v78
	v_perm_b32 v4, v5, v77, s20
	v_perm_b32 v5, v5, v77, s23
	ds_read2st64_b64 v[76:79], v76 offset1:8
	ds_read2st64_b64 v[84:87], v84 offset1:8
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[72:73], v[4:5], v[0:3]
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[74:75], v[4:5], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[4:5], v[50:53]
	v_and_b32_e32 v4, 0x7070707, v6
	v_lshrrev_b32_e32 v5, 4, v6
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v80, v89, v88, v4
	v_perm_b32 v4, v54, v49, v4
	v_and_or_b32 v80, v80, v81, v4
	v_perm_b32 v4, v89, v88, v5
	v_perm_b32 v5, v54, v49, v5
	v_and_or_b32 v5, v4, v6, v5
	v_perm_b32 v4, v5, v80, s20
	v_perm_b32 v5, v5, v80, s23
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[76:77], v[4:5], v[0:3]
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[78:79], v[4:5], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[104:105], v[4:5], v[50:53]
	v_and_b32_e32 v4, 0x7070707, v7
	v_lshrrev_b32_e32 v5, 4, v7
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v6, v89, v88, v4
	v_lshlrev_b32_e32 v16, 4, v7
	v_perm_b32 v4, v54, v49, v4
	v_and_or_b32 v4, v6, v16, v4
	v_perm_b32 v6, v89, v88, v5
	v_perm_b32 v5, v54, v49, v5
	v_and_or_b32 v5, v6, v7, v5
	v_perm_b32 v88, v5, v4, s20
	v_perm_b32 v89, v5, v4, s23
	v_mul_lo_u32 v49, v70, s28
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[84:85], v[88:89], v[0:3]
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[106:107], v[88:89], v[50:53]
	s_nop 2
	v_sub_u32_e32 v50, 0x6c686080, v49
	v_and_b32_e32 v50, 0xffffff00, v50
	v_sub_u32_e32 v49, 0x7c787470, v49
	v_cndmask_b32_e64 v54, v50, 0, s[4:5]
	v_cndmask_b32_e64 v49, v49, 0, s[4:5]
	v_add_u32_e32 v50, 0x7f7f7f00, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[86:87], v[88:89], v[80:83]
	v_and_b32_e32 v88, 0x80808000, v50
	v_add_u32_e32 v50, 0x7f7f7f78, v49
	v_and_b32_e32 v89, 0x80808080, v50
	v_and_b32_e32 v50, 0x7070707, v12
	v_lshrrev_b32_e32 v51, 4, v12
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v89, v88, v50
	v_lshlrev_b32_e32 v53, 4, v12
	v_perm_b32 v50, v49, v54, v50
	v_and_or_b32 v50, v52, v53, v50
	v_perm_b32 v52, v89, v88, v51
	v_perm_b32 v51, v49, v54, v51
	v_and_or_b32 v12, v52, v12, v51
	v_perm_b32 v80, v12, v50, s20
	v_perm_b32 v81, v12, v50, s23
	v_and_b32_e32 v12, 0x7070707, v13
	s_and_b32 s5, s27, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[28:29], v[80:81], 0
	s_mov_b32 s4, s26
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[30:31], v[80:81], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[80:83], v[90:91], v[80:81], 0
	v_lshrrev_b32_e32 v90, 4, v13
	v_and_b32_e32 v90, 0x7070707, v90
	v_perm_b32 v91, v89, v88, v12
	v_perm_b32 v12, v49, v54, v12
	v_and_or_b32 v91, v91, v92, v12
	v_perm_b32 v12, v89, v88, v90
	v_perm_b32 v90, v49, v54, v90
	v_and_or_b32 v13, v12, v13, v90
	v_perm_b32 v12, v13, v91, s20
	v_perm_b32 v13, v13, v91, s23
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[24:25], v[12:13], v[50:53]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[26:27], v[12:13], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[94:95], v[12:13], v[80:83]
	v_and_b32_e32 v12, 0x7070707, v14
	v_lshrrev_b32_e32 v13, 4, v14
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v80, v89, v88, v12
	v_lshlrev_b32_e32 v81, 4, v14
	v_perm_b32 v12, v49, v54, v12
	v_and_or_b32 v80, v80, v81, v12
	v_perm_b32 v12, v89, v88, v13
	v_perm_b32 v13, v49, v54, v13
	v_and_or_b32 v13, v12, v14, v13
	v_perm_b32 v12, v13, v80, s20
	v_perm_b32 v13, v13, v80, s23
	v_mul_lo_u32 v14, v69, s28
	v_sub_u32_e32 v81, 0x7c787470, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[20:21], v[12:13], v[50:53]
	s_mov_b32 s28, s14
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[22:23], v[12:13], v[24:27]
	s_nop 2
	v_sub_u32_e32 v24, 0x6c686080, v14
	v_and_b32_e32 v80, 0xffffff00, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[96:97], v[12:13], v[28:31]
	v_and_b32_e32 v12, 0x7070707, v15
	v_lshrrev_b32_e32 v13, 4, v15
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v14, v89, v88, v12
	v_lshlrev_b32_e32 v28, 4, v15
	v_perm_b32 v12, v49, v54, v12
	v_and_or_b32 v12, v14, v28, v12
	v_perm_b32 v14, v89, v88, v13
	v_perm_b32 v13, v49, v54, v13
	v_and_or_b32 v13, v14, v15, v13
	v_perm_b32 v28, v13, v12, s20
	v_perm_b32 v29, v13, v12, s23
	v_cndmask_b32_e64 v30, v80, 0, s[2:3]
	v_cndmask_b32_e64 v31, v81, 0, s[2:3]
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[32:33], v[28:29], v[50:53]
	v_add_u32_e32 v32, 0x7f7f7f00, v30
	v_add_u32_e32 v33, 0x7f7f7f78, v31
	v_and_b32_e32 v32, 0x80808000, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[34:35], v[28:29], v[20:23]
	v_and_b32_e32 v33, 0x80808080, v33
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v35, 4, v8
	s_mov_b32 s2, 0x20000
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[98:99], v[28:29], v[24:27]
	v_and_b32_e32 v28, 0x7070707, v8
	v_lshrrev_b32_e32 v29, 4, v8
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v34, v33, v32, v28
	v_perm_b32 v28, v31, v30, v28
	v_and_or_b32 v34, v34, v35, v28
	v_perm_b32 v28, v33, v32, v29
	v_perm_b32 v29, v31, v30, v29
	v_and_or_b32 v8, v28, v8, v29
	v_perm_b32 v28, v8, v34, s20
	v_perm_b32 v29, v8, v34, s23
	v_and_b32_e32 v8, 0x7070707, v9
	v_lshlrev_b32_e32 v34, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[56:57], v[28:29], v[12:15]
	v_or_b32_e32 v50, s10, v60
	v_lshlrev_b32_e32 v80, 2, v50
	v_or_b32_e32 v50, s13, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[58:59], v[28:29], v[20:23]
	v_lshlrev_b32_e32 v81, 2, v50
	v_and_b32_e32 v49, 62, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[100:101], v[28:29], v[24:27]
	v_lshrrev_b32_e32 v28, 4, v9
	v_and_b32_e32 v28, 0x7070707, v28
	v_perm_b32 v29, v33, v32, v8
	v_perm_b32 v8, v31, v30, v8
	v_and_or_b32 v29, v29, v34, v8
	v_perm_b32 v8, v33, v32, v28
	v_perm_b32 v28, v31, v30, v28
	v_and_or_b32 v9, v8, v9, v28
	v_perm_b32 v8, v9, v29, s20
	v_perm_b32 v9, v9, v29, s23
	v_lshlrev_b32_e32 v29, 4, v10
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[72:73], v[8:9], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[74:75], v[8:9], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[102:103], v[8:9], v[24:27]
	v_and_b32_e32 v8, 0x7070707, v10
	v_lshrrev_b32_e32 v9, 4, v10
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v28, v33, v32, v8
	v_perm_b32 v8, v31, v30, v8
	v_and_or_b32 v28, v28, v29, v8
	v_perm_b32 v8, v33, v32, v9
	v_perm_b32 v9, v31, v30, v9
	v_and_or_b32 v9, v8, v10, v9
	v_perm_b32 v8, v9, v28, s20
	v_perm_b32 v9, v9, v28, s23
	v_lshlrev_b32_e32 v28, 4, v11
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[76:77], v[8:9], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[78:79], v[8:9], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[104:105], v[8:9], v[24:27]
	v_and_b32_e32 v8, 0x7070707, v11
	v_lshrrev_b32_e32 v9, 4, v11
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v10, v33, v32, v8
	v_perm_b32 v8, v31, v30, v8
	v_and_or_b32 v8, v10, v28, v8
	v_perm_b32 v10, v33, v32, v9
	v_perm_b32 v9, v31, v30, v9
	v_and_or_b32 v9, v10, v11, v9
	v_perm_b32 v28, v9, v8, s20
	v_perm_b32 v29, v9, v8, s23
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[84:85], v[28:29], v[12:15]
	s_nop 2
	v_or_b32_e32 v12, s36, v71
	v_lshlrev_b32_e32 v31, 2, v12
	buffer_load_dwordx4 v[56:59], v31, s[28:31], 0 offen
	buffer_load_dwordx4 v[72:75], v31, s[4:7], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[86:87], v[28:29], v[20:23]
	v_or_b32_e32 v50, 64, v31
	v_or_b32_e32 v51, 0x44, v31
	v_or_b32_e32 v52, 0x48, v31
	v_mov_b32_e32 v20, 0xfd800000
	v_lshl_add_u32 v21, v66, 23, v20
	v_lshlrev_b32_e64 v22, v66, s2
	v_cndmask_b32_e64 v30, v22, v21, s[0:1]
	v_lshl_add_u32 v20, v65, 23, v20
	v_lshlrev_b32_e64 v21, v65, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[106:107], v[28:29], v[24:27]
	v_cndmask_b32_e32 v28, v21, v20, vcc
	v_or_b32_e32 v20, s10, v71
	v_lshlrev_b32_e32 v20, 2, v20
	buffer_load_dwordx4 v[24:27], v20, s[28:31], 0 offen
	buffer_load_dword v76, v50, s[4:7], 0 offen
	buffer_load_dword v77, v51, s[4:7], 0 offen
	buffer_load_dword v78, v52, s[4:7], 0 offen
	v_or_b32_e32 v20, s13, v71
	v_lshlrev_b32_e32 v20, 2, v20
	v_or_b32_e32 v29, s36, v60
	v_or_b32_e32 v82, 0x4c, v31
	buffer_load_dwordx4 v[20:23], v20, s[28:31], 0 offen
	s_and_b32 s29, s25, 0xffff
	s_mov_b32 s28, s24
	v_lshlrev_b32_e32 v29, 2, v29
	buffer_load_dword v79, v82, s[4:7], 0 offen
	buffer_load_dword v84, v29, s[28:31], 0 offen
	buffer_load_dword v54, v29, s[28:31], 0 offen offset:32
	buffer_load_dword v53, v80, s[28:31], 0 offen
	buffer_load_dword v52, v29, s[28:31], 0 offen offset:96
	buffer_load_dword v51, v81, s[28:31], 0 offen
	buffer_load_dword v50, v29, s[28:31], 0 offen offset:160
	s_movk_i32 s0, 0x7fff
	s_mov_b64 s[2:3], 0
	s_waitcnt vmcnt(13)
	v_pk_mul_f32 v[82:83], v[30:31], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[18:19], v[18:19], v[82:83]
	v_pk_mul_f32 v[80:81], v[30:31], v[56:57] op_sel_hi:[0,1]
	s_waitcnt vmcnt(12)
	v_pk_mul_f32 v[18:19], v[18:19], v[74:75]
	v_pk_mul_f32 v[16:17], v[16:17], v[80:81]
	v_bfe_u32 v29, v19, 16, 1
	v_add3_u32 v29, v29, v19, s0
	v_or_b32_e32 v80, 0x400000, v19
	v_cmp_u_f32_e32 vcc, v19, v19
	v_pk_mul_f32 v[16:17], v[16:17], v[72:73]
	s_nop 0
	v_cndmask_b32_e32 v19, v29, v80, vcc
	v_bfe_u32 v29, v18, 16, 1
	v_add3_u32 v29, v29, v18, s0
	v_or_b32_e32 v80, 0x400000, v18
	v_cmp_u_f32_e32 vcc, v18, v18
	s_nop 1
	v_cndmask_b32_e32 v18, v29, v80, vcc
	v_bfe_u32 v29, v17, 16, 1
	v_add3_u32 v29, v29, v17, s0
	v_or_b32_e32 v80, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	s_nop 1
	v_cndmask_b32_e32 v17, v29, v80, vcc
	v_bfe_u32 v29, v16, 16, 1
	v_add3_u32 v29, v29, v16, s0
	v_or_b32_e32 v80, 0x400000, v16
	v_cmp_u_f32_e32 vcc, v16, v16
	s_nop 1
	v_cndmask_b32_e32 v16, v29, v80, vcc
	v_lshlrev_b32_e32 v29, 1, v63
	v_lshl_add_u32 v29, v62, 10, v29
	ds_write_b16_d16_hi v29, v16
	ds_write_b16_d16_hi v29, v17 offset:256
	ds_write_b16_d16_hi v29, v18 offset:512
	ds_write_b16_d16_hi v29, v19 offset:768
	v_pk_mul_f32 v[18:19], v[28:29], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[18:19], v[34:35], v[18:19]
	v_pk_mul_f32 v[16:17], v[28:29], v[56:57] op_sel_hi:[0,1]
	v_pk_mul_f32 v[18:19], v[18:19], v[74:75]
	v_pk_mul_f32 v[16:17], v[32:33], v[16:17]
	v_bfe_u32 v32, v19, 16, 1
	v_add3_u32 v32, v32, v19, s0
	v_or_b32_e32 v33, 0x400000, v19
	v_cmp_u_f32_e32 vcc, v19, v19
	v_or_b32_e32 v58, 0x80, v31
	v_pk_mul_f32 v[16:17], v[16:17], v[72:73]
	v_cndmask_b32_e32 v19, v32, v33, vcc
	v_bfe_u32 v32, v18, 16, 1
	v_add3_u32 v56, v32, v18, s0
	v_or_b32_e32 v59, 0x84, v31
	v_or_b32_e32 v72, 0x88, v31
	v_or_b32_e32 v31, 0x8c, v31
	buffer_load_dword v32, v58, s[4:7], 0 offen
	buffer_load_dword v33, v59, s[4:7], 0 offen
	buffer_load_dword v34, v72, s[4:7], 0 offen
	buffer_load_dword v35, v31, s[4:7], 0 offen
	v_or_b32_e32 v57, 0x400000, v18
	v_cmp_u_f32_e32 vcc, v18, v18
	v_bfe_u32 v31, v17, 16, 1
	v_add3_u32 v31, v31, v17, s0
	v_cndmask_b32_e32 v18, v56, v57, vcc
	v_or_b32_e32 v56, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	s_nop 1
	v_cndmask_b32_e32 v17, v31, v56, vcc
	v_bfe_u32 v31, v16, 16, 1
	v_add3_u32 v31, v31, v16, s0
	v_or_b32_e32 v56, 0x400000, v16
	v_cmp_u_f32_e32 vcc, v16, v16
	s_nop 1
	v_cndmask_b32_e32 v16, v31, v56, vcc
	ds_write_b16_d16_hi v29, v16 offset:32
	ds_write_b16_d16_hi v29, v17 offset:288
	ds_write_b16_d16_hi v29, v18 offset:544
	ds_write_b16_d16_hi v29, v19 offset:800
	s_waitcnt vmcnt(15)
	v_pk_mul_f32 v[18:19], v[30:31], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_pk_mul_f32 v[16:17], v[30:31], v[24:25] op_sel_hi:[0,1]
	s_waitcnt vmcnt(10)
	v_pk_mul_f32 v[6:7], v[6:7], v[78:79]
	v_pk_mul_f32 v[4:5], v[4:5], v[16:17]
	v_bfe_u32 v16, v7, 16, 1
	v_add3_u32 v16, v16, v7, s0
	v_or_b32_e32 v17, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[4:5], v[4:5], v[76:77]
	s_nop 0
	v_cndmask_b32_e32 v7, v16, v17, vcc
	v_bfe_u32 v16, v6, 16, 1
	v_add3_u32 v16, v16, v6, s0
	v_or_b32_e32 v17, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v16, v17, vcc
	v_bfe_u32 v16, v5, 16, 1
	v_add3_u32 v16, v16, v5, s0
	v_or_b32_e32 v17, 0x400000, v5
	v_cmp_u_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v16, v17, vcc
	v_bfe_u32 v16, v4, 16, 1
	v_add3_u32 v16, v16, v4, s0
	v_or_b32_e32 v17, 0x400000, v4
	v_cmp_u_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v16, v17, vcc
	ds_write_b16_d16_hi v29, v4 offset:4096
	ds_write_b16_d16_hi v29, v5 offset:4352
	ds_write_b16_d16_hi v29, v6 offset:4608
	ds_write_b16_d16_hi v29, v7 offset:4864
	v_pk_mul_f32 v[6:7], v[28:29], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_pk_mul_f32 v[4:5], v[28:29], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[78:79]
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5]
	v_bfe_u32 v8, v7, 16, 1
	v_add3_u32 v8, v8, v7, s0
	v_or_b32_e32 v9, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[4:5], v[4:5], v[76:77]
	s_nop 0
	v_cndmask_b32_e32 v7, v8, v9, vcc
	v_bfe_u32 v8, v6, 16, 1
	v_add3_u32 v8, v8, v6, s0
	v_or_b32_e32 v9, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	v_bfe_u32 v8, v5, 16, 1
	v_add3_u32 v8, v8, v5, s0
	v_or_b32_e32 v9, 0x400000, v5
	v_cmp_u_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v8, v9, vcc
	v_bfe_u32 v8, v4, 16, 1
	v_add3_u32 v8, v8, v4, s0
	v_or_b32_e32 v9, 0x400000, v4
	v_cmp_u_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v8, v9, vcc
	ds_write_b16_d16_hi v29, v4 offset:4128
	ds_write_b16_d16_hi v29, v5 offset:4384
	ds_write_b16_d16_hi v29, v6 offset:4640
	ds_write_b16_d16_hi v29, v7 offset:4896
	v_pk_mul_f32 v[6:7], v[30:31], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	v_pk_mul_f32 v[4:5], v[30:31], v[20:21] op_sel_hi:[0,1]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[2:3], v[2:3], v[34:35]
	v_pk_mul_f32 v[0:1], v[0:1], v[4:5]
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s0
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[32:33]
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s0
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
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
	ds_write_b16_d16_hi v29, v0 offset:8192
	ds_write_b16_d16_hi v29, v1 offset:8448
	ds_write_b16_d16_hi v29, v2 offset:8704
	ds_write_b16_d16_hi v29, v3 offset:8960
	v_pk_mul_f32 v[2:3], v[28:29], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[14:15], v[2:3]
	v_pk_mul_f32 v[0:1], v[28:29], v[20:21] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[34:35]
	v_pk_mul_f32 v[0:1], v[12:13], v[0:1]
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s0
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[32:33]
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s0
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
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
	ds_write_b16_d16_hi v29, v0 offset:8224
	ds_write_b16_d16_hi v29, v1 offset:8480
	ds_write_b16_d16_hi v29, v2 offset:8736
	ds_write_b16_d16_hi v29, v3 offset:8992
	v_and_b32_e32 v1, 0xffffff, v84
	v_cmp_gt_u32_e32 vcc, s33, v1
	s_and_b64 s[0:1], vcc, exec
	v_mov_b32_e32 v2, v60
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_branch .LBB0_22
.LBB0_21:
	s_mov_b64 s[2:3], -1
	s_mov_b64 s[0:1], 0
.LBB0_22:
	s_and_b64 s[2:3], s[2:3], exec
	s_cselect_b32 s2, 1, 0
	s_cmp_lg_u32 s2, 1
	s_cbranch_scc1 .LBB0_28
	s_mov_b32 s20, s12
	s_mov_b32 s23, s11
	buffer_load_dwordx4 v[2:5], v46, s[20:23], 0 offen nt
	s_or_b32 s8, s36, 48
	v_or_b32_e32 v0, s8, v61
	v_lshl_or_b32 v0, v0, 8, v48
	s_mov_b32 s18, s39
	s_mov_b32 s19, s11
	buffer_load_dwordx4 v[12:15], v41, s[16:19], 0 offen nt
	v_or_b32_e32 v16, 0x400, v41
	s_mov_b32 s2, 0x8080808
	v_cmp_lt_i32_e32 vcc, 11, v42
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_mul_lo_u32 v70, v70, s2
	s_and_b32 s5, s15, 0xffff
	s_mov_b32 s7, 0x27000
	s_mov_b32 s6, -1
	s_mov_b32 s4, s14
	s_mov_b32 s3, s7
	s_waitcnt vmcnt(1)
	ds_write_b128 v45, v[2:5]
	buffer_load_dwordx4 v[2:5], v47, s[20:23], 0 offen nt
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v19, 4, v12
	v_lshlrev_b32_e32 v30, 4, v13
	s_waitcnt vmcnt(0)
	ds_write_b128 v45, v[2:5] offset:4096
	buffer_load_dwordx4 v[2:5], v55, s[20:23], 0 offen nt
	s_waitcnt vmcnt(0)
	ds_write_b128 v45, v[2:5] offset:8192
	buffer_load_dwordx4 v[0:3], v0, s[20:23], 0 offen nt
	s_waitcnt vmcnt(0)
	ds_write_b128 v45, v[0:3] offset:12288
	buffer_load_dwordx4 v[0:3], v16, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[8:11], v40, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[4:7], v40, s[16:19], 0 offen offset:1024 nt
	v_mul_lo_u32 v16, v44, s2
	v_sub_u32_e32 v17, 0x6c686080, v16
	v_and_b32_e32 v17, 0xffffff00, v17
	v_sub_u32_e32 v16, 0x7c787470, v16
	v_cndmask_b32_e64 v80, v17, 0, vcc
	v_cndmask_b32_e64 v81, v16, 0, vcc
	v_add_u32_e32 v16, 0x7f7f7f00, v80
	v_and_b32_e32 v82, 0x80808000, v16
	v_add_u32_e32 v16, 0x7f7f7f78, v81
	v_and_b32_e32 v83, 0x80808080, v16
	v_mul_lo_u32 v16, v43, s2
	v_sub_u32_e32 v17, 0x6c686080, v16
	v_and_b32_e32 v17, 0xffffff00, v17
	v_cmp_lt_i32_e32 vcc, 11, v39
	v_sub_u32_e32 v16, 0x7c787470, v16
	s_waitcnt lgkmcnt(0)
	v_cndmask_b32_e64 v39, v17, 0, vcc
	v_cndmask_b32_e64 v100, v16, 0, vcc
	v_add_u32_e32 v16, 0x7f7f7f00, v39
	v_and_b32_e32 v101, 0x80808000, v16
	v_add_u32_e32 v16, 0x7f7f7f78, v100
	v_and_b32_e32 v102, 0x80808080, v16
	v_and_b32_e32 v16, 0x7070707, v12
	v_lshrrev_b32_e32 v17, 4, v12
	v_and_b32_e32 v17, 0x7070707, v17
	v_perm_b32 v18, v83, v82, v16
	v_perm_b32 v16, v81, v80, v16
	v_and_or_b32 v16, v18, v19, v16
	v_perm_b32 v18, v83, v82, v17
	v_perm_b32 v17, v81, v80, v17
	v_and_or_b32 v12, v18, v12, v17
	v_perm_b32 v28, v12, v16, s0
	v_perm_b32 v29, v12, v16, s1
	v_xor_b32_e32 v12, v37, v38
	v_or_b32_e32 v12, v36, v12
	s_barrier
	ds_read2st64_b64 v[16:19], v12 offset1:8
	ds_read2st64_b64 v[24:27], v12 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[16:17], v[28:29], 0
	v_and_b32_e32 v12, 0x7070707, v13
	v_cmp_lt_i32_e32 vcc, 11, v68
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v86, 4, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[18:19], v[28:29], 0
	v_lshlrev_b32_e32 v93, 4, v2
	v_lshlrev_b32_e32 v103, 4, v3
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v114, 4, v9
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[24:25], v[28:29], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[44:47], v[26:27], v[28:29], 0
	v_lshrrev_b32_e32 v28, 4, v13
	v_and_b32_e32 v28, 0x7070707, v28
	v_perm_b32 v29, v83, v82, v12
	v_perm_b32 v12, v81, v80, v12
	v_and_or_b32 v29, v29, v30, v12
	v_perm_b32 v12, v83, v82, v28
	v_perm_b32 v28, v81, v80, v28
	v_and_or_b32 v13, v12, v13, v28
	v_or_b32_e32 v28, 8, v37
	v_xor_b32_e32 v28, v28, v38
	v_or_b32_e32 v52, v36, v28
	v_perm_b32 v12, v13, v29, s0
	v_perm_b32 v13, v13, v29, s1
	ds_read2st64_b64 v[28:31], v52 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[48:51], v[30:31], v[12:13], v[32:35]
	s_nop 2
	ds_read2st64_b64 v[32:35], v52 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[28:29], v[12:13], v[20:23]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[52:55], v[32:33], v[12:13], v[40:43]
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[34:35], v[12:13], v[44:47]
	v_and_b32_e32 v12, 0x7070707, v14
	v_lshrrev_b32_e32 v13, 4, v14
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v40, v83, v82, v12
	v_lshlrev_b32_e32 v41, 4, v14
	v_perm_b32 v12, v81, v80, v12
	v_and_or_b32 v40, v40, v41, v12
	v_perm_b32 v12, v83, v82, v13
	v_perm_b32 v13, v81, v80, v13
	v_and_or_b32 v13, v12, v14, v13
	v_or_b32_e32 v14, 16, v37
	v_xor_b32_e32 v14, v14, v38
	v_or_b32_e32 v14, v36, v14
	v_perm_b32 v12, v13, v40, s0
	v_perm_b32 v13, v13, v40, s1
	ds_read2st64_b64 v[40:43], v14 offset1:8
	ds_read2st64_b64 v[44:47], v14 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[40:41], v[12:13], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[42:43], v[12:13], v[48:51]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[44:45], v[12:13], v[52:55]
	s_nop 0
	v_lshlrev_b32_e32 v48, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[46:47], v[12:13], v[56:59]
	v_and_b32_e32 v12, 0x7070707, v15
	v_lshrrev_b32_e32 v13, 4, v15
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v14, v83, v82, v12
	v_perm_b32 v12, v81, v80, v12
	v_and_or_b32 v12, v14, v48, v12
	v_perm_b32 v14, v83, v82, v13
	v_perm_b32 v13, v81, v80, v13
	v_and_or_b32 v13, v14, v15, v13
	v_perm_b32 v80, v13, v12, s0
	v_perm_b32 v81, v13, v12, s1
	v_or_b32_e32 v12, 24, v37
	v_xor_b32_e32 v12, v12, v38
	v_or_b32_e32 v52, v36, v12
	ds_read2st64_b64 v[48:51], v52 offset1:8
	ds_read2st64_b64 v[52:55], v52 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[48:49], v[80:81], v[20:23]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[50:51], v[80:81], v[72:75]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[52:53], v[80:81], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[54:55], v[80:81], v[56:59]
	s_nop 2
	v_and_b32_e32 v56, 0x7070707, v0
	v_lshrrev_b32_e32 v57, 4, v0
	v_and_b32_e32 v57, 0x7070707, v57
	v_perm_b32 v58, v102, v101, v56
	v_lshlrev_b32_e32 v59, 4, v0
	v_perm_b32 v56, v100, v39, v56
	v_and_or_b32 v56, v58, v59, v56
	v_perm_b32 v58, v102, v101, v57
	v_perm_b32 v57, v100, v39, v57
	v_and_or_b32 v0, v58, v0, v57
	v_perm_b32 v84, v0, v56, s0
	v_perm_b32 v85, v0, v56, s1
	v_or_b32_e32 v0, 0x80, v37
	v_xor_b32_e32 v0, v0, v38
	v_or_b32_e32 v0, v36, v0
	ds_read2st64_b64 v[56:59], v0 offset1:8
	ds_read2st64_b64 v[80:83], v0 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[56:57], v[84:85], v[12:15]
	v_and_b32_e32 v0, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[58:59], v[84:85], v[20:23]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[80:81], v[84:85], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[82:83], v[84:85], v[76:79]
	v_lshrrev_b32_e32 v84, 4, v1
	v_and_b32_e32 v84, 0x7070707, v84
	v_perm_b32 v85, v102, v101, v0
	v_perm_b32 v0, v100, v39, v0
	v_and_or_b32 v85, v85, v86, v0
	v_perm_b32 v0, v102, v101, v84
	v_perm_b32 v84, v100, v39, v84
	v_and_or_b32 v1, v0, v1, v84
	v_or_b32_e32 v84, 0x88, v37
	v_xor_b32_e32 v84, v84, v38
	v_or_b32_e32 v88, v36, v84
	v_perm_b32 v0, v1, v85, s0
	v_perm_b32 v1, v1, v85, s1
	ds_read2st64_b64 v[84:87], v88 offset1:8
	ds_read2st64_b64 v[88:91], v88 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[84:85], v[0:1], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[86:87], v[0:1], v[20:23]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[88:89], v[0:1], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[90:91], v[0:1], v[76:79]
	v_and_b32_e32 v0, 0x7070707, v2
	v_lshrrev_b32_e32 v1, 4, v2
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v92, v102, v101, v0
	v_perm_b32 v0, v100, v39, v0
	v_and_or_b32 v92, v92, v93, v0
	v_perm_b32 v0, v102, v101, v1
	v_perm_b32 v1, v100, v39, v1
	v_and_or_b32 v1, v0, v2, v1
	v_or_b32_e32 v2, 0x90, v37
	v_xor_b32_e32 v2, v2, v38
	v_or_b32_e32 v2, v36, v2
	v_perm_b32 v0, v1, v92, s0
	v_perm_b32 v1, v1, v92, s1
	ds_read2st64_b64 v[92:95], v2 offset1:8
	ds_read2st64_b64 v[96:99], v2 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[92:93], v[0:1], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[94:95], v[0:1], v[20:23]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[96:97], v[0:1], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[98:99], v[0:1], v[76:79]
	v_and_b32_e32 v0, 0x7070707, v3
	v_lshrrev_b32_e32 v1, 4, v3
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v102, v101, v0
	v_perm_b32 v0, v100, v39, v0
	v_and_or_b32 v2, v2, v103, v0
	v_perm_b32 v0, v102, v101, v1
	v_perm_b32 v1, v100, v39, v1
	v_and_or_b32 v1, v0, v3, v1
	v_perm_b32 v0, v1, v2, s0
	v_perm_b32 v1, v1, v2, s1
	v_or_b32_e32 v2, 0x98, v37
	v_xor_b32_e32 v2, v2, v38
	v_or_b32_e32 v2, v36, v2
	ds_read2st64_b64 v[100:103], v2 offset1:8
	ds_read2st64_b64 v[104:107], v2 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[100:101], v[0:1], v[12:15]
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[104:105], v[0:1], v[72:75]
	s_nop 2
	v_sub_u32_e32 v72, 0x6c686080, v70
	v_and_b32_e32 v72, 0xffffff00, v72
	v_sub_u32_e32 v70, 0x7c787470, v70
	v_cndmask_b32_e64 v108, v72, 0, vcc
	v_cndmask_b32_e64 v70, v70, 0, vcc
	v_add_u32_e32 v68, 0x7f7f7f00, v108
	v_and_b32_e32 v109, 0x80808000, v68
	v_add_u32_e32 v68, 0x7f7f7f78, v70
	v_and_b32_e32 v110, 0x80808080, v68
	v_mul_lo_u32 v68, v69, s2
	v_sub_u32_e32 v69, 0x6c686080, v68
	v_and_b32_e32 v69, 0xffffff00, v69
	v_cmp_lt_i32_e32 vcc, 11, v67
	v_sub_u32_e32 v68, 0x7c787470, v68
	v_lshlrev_b32_e32 v73, 4, v8
	v_cndmask_b32_e64 v67, v69, 0, vcc
	v_cndmask_b32_e64 v111, v68, 0, vcc
	v_add_u32_e32 v68, 0x7f7f7f00, v67
	v_and_b32_e32 v112, 0x80808000, v68
	v_add_u32_e32 v68, 0x7f7f7f78, v111
	v_and_b32_e32 v113, 0x80808080, v68
	v_and_b32_e32 v68, 0x7070707, v8
	v_lshrrev_b32_e32 v69, 4, v8
	v_and_b32_e32 v69, 0x7070707, v69
	v_perm_b32 v72, v110, v109, v68
	v_perm_b32 v68, v70, v108, v68
	v_and_or_b32 v72, v72, v73, v68
	v_perm_b32 v68, v110, v109, v69
	v_perm_b32 v69, v70, v108, v69
	v_and_or_b32 v8, v68, v8, v69
	v_perm_b32 v68, v8, v72, s0
	v_perm_b32 v69, v8, v72, s1
	v_mfma_f32_16x16x32_fp8_fp8 v[20:23], v[102:103], v[0:1], v[20:23]
	v_and_b32_e32 v8, 0x7070707, v9
	v_cmp_lt_u32_e32 vcc, 5, v66
	s_mov_b32 s2, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[106:107], v[0:1], v[76:79]
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[16:17], v[68:69], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[18:19], v[68:69], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[76:79], v[24:25], v[68:69], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[26:27], v[68:69], 0
	v_lshrrev_b32_e32 v68, 4, v9
	v_and_b32_e32 v68, 0x7070707, v68
	v_perm_b32 v69, v110, v109, v8
	v_perm_b32 v8, v70, v108, v8
	v_and_or_b32 v69, v69, v114, v8
	v_perm_b32 v8, v110, v109, v68
	v_perm_b32 v68, v70, v108, v68
	v_and_or_b32 v9, v8, v9, v68
	v_perm_b32 v8, v9, v69, s0
	v_perm_b32 v9, v9, v69, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[72:75], v[28:29], v[8:9], v[72:75]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[30:31], v[8:9], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[32:33], v[8:9], v[76:79]
	v_lshlrev_b32_e32 v33, 4, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[34:35], v[8:9], v[24:27]
	v_and_b32_e32 v8, 0x7070707, v10
	v_lshrrev_b32_e32 v9, 4, v10
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v32, v110, v109, v8
	v_perm_b32 v8, v70, v108, v8
	v_and_or_b32 v32, v32, v33, v8
	v_perm_b32 v8, v110, v109, v9
	v_perm_b32 v9, v70, v108, v9
	v_and_or_b32 v9, v8, v10, v9
	v_perm_b32 v8, v9, v32, s0
	v_perm_b32 v9, v9, v32, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[40:41], v[8:9], v[72:75]
	v_lshlrev_b32_e32 v40, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[42:43], v[8:9], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[44:45], v[8:9], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[46:47], v[8:9], v[24:27]
	v_and_b32_e32 v8, 0x7070707, v11
	v_lshrrev_b32_e32 v9, 4, v11
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v10, v110, v109, v8
	v_perm_b32 v8, v70, v108, v8
	v_and_or_b32 v8, v10, v40, v8
	v_perm_b32 v10, v110, v109, v9
	v_perm_b32 v9, v70, v108, v9
	v_and_or_b32 v9, v10, v11, v9
	v_perm_b32 v40, v9, v8, s0
	v_perm_b32 v41, v9, v8, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[48:49], v[40:41], v[32:35]
	v_and_b32_e32 v49, 62, v64
	s_waitcnt vmcnt(0)
	s_nop 0
	v_and_b32_e32 v32, 0x7070707, v4
	v_lshrrev_b32_e32 v33, 4, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[50:51], v[40:41], v[16:19]
	v_and_b32_e32 v33, 0x7070707, v33
	v_perm_b32 v34, v113, v112, v32
	v_lshlrev_b32_e32 v35, 4, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[52:53], v[40:41], v[28:31]
	v_perm_b32 v32, v111, v67, v32
	v_and_or_b32 v34, v34, v35, v32
	v_perm_b32 v32, v113, v112, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[54:55], v[40:41], v[24:27]
	v_perm_b32 v33, v111, v67, v33
	v_and_or_b32 v4, v32, v4, v33
	v_perm_b32 v32, v4, v34, s0
	v_perm_b32 v33, v4, v34, s1
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshlrev_b32_e32 v34, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[56:57], v[32:33], v[8:11]
	v_or_b32_e32 v41, s36, v60
	v_lshlrev_b32_e32 v46, 2, v41
	v_or_b32_e32 v41, s10, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[58:59], v[32:33], v[16:19]
	v_lshlrev_b32_e32 v47, 2, v41
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[80:81], v[32:33], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[82:83], v[32:33], v[24:27]
	v_lshrrev_b32_e32 v32, 4, v5
	v_and_b32_e32 v32, 0x7070707, v32
	v_perm_b32 v33, v113, v112, v4
	v_perm_b32 v4, v111, v67, v4
	v_and_or_b32 v33, v33, v34, v4
	v_perm_b32 v4, v113, v112, v32
	v_perm_b32 v32, v111, v67, v32
	v_and_or_b32 v5, v4, v5, v32
	v_perm_b32 v4, v5, v33, s0
	v_perm_b32 v5, v5, v33, s1
	v_lshlrev_b32_e32 v33, 4, v6
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[84:85], v[4:5], v[8:11]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[86:87], v[4:5], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[88:89], v[4:5], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[90:91], v[4:5], v[24:27]
	v_and_b32_e32 v4, 0x7070707, v6
	v_lshrrev_b32_e32 v5, 4, v6
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v32, v113, v112, v4
	v_perm_b32 v4, v111, v67, v4
	v_and_or_b32 v32, v32, v33, v4
	v_perm_b32 v4, v113, v112, v5
	v_perm_b32 v5, v111, v67, v5
	v_and_or_b32 v5, v4, v6, v5
	v_perm_b32 v4, v5, v32, s0
	v_perm_b32 v5, v5, v32, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[92:93], v[4:5], v[8:11]
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[94:95], v[4:5], v[16:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[96:97], v[4:5], v[28:31]
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[98:99], v[4:5], v[24:27]
	v_and_b32_e32 v4, 0x7070707, v7
	v_lshrrev_b32_e32 v5, 4, v7
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v6, v113, v112, v4
	v_lshlrev_b32_e32 v28, 4, v7
	v_perm_b32 v4, v111, v67, v4
	v_and_or_b32 v6, v6, v28, v4
	v_perm_b32 v4, v113, v112, v5
	v_perm_b32 v5, v111, v67, v5
	v_and_or_b32 v5, v4, v7, v5
	v_perm_b32 v4, v5, v6, s0
	v_perm_b32 v5, v5, v6, s1
	s_mov_b32 s0, 0x20000
	s_and_b32 s1, s27, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[56:59], v[100:101], v[4:5], v[8:11]
	s_nop 2
	v_mov_b32_e32 v8, 0xfd800000
	v_lshl_add_u32 v9, v66, 23, v8
	v_lshlrev_b32_e64 v10, v66, s0
	v_cndmask_b32_e32 v42, v10, v9, vcc
	v_lshl_add_u32 v8, v65, 23, v8
	v_lshlrev_b32_e64 v9, v65, s0
	v_cmp_lt_u32_e32 vcc, 5, v65
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[102:103], v[4:5], v[16:19]
	s_mov_b32 s0, s26
	v_cndmask_b32_e32 v40, v9, v8, vcc
	v_or_b32_e32 v8, s36, v71
	v_lshlrev_b32_e32 v45, 2, v8
	v_or_b32_e32 v8, s10, v71
	v_lshlrev_b32_e32 v8, 2, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[16:19], v[104:105], v[4:5], v[32:35]
	buffer_load_dwordx4 v[66:69], v45, s[4:7], 0 offen
	s_nop 1
	buffer_load_dwordx4 v[32:35], v8, s[4:7], 0 offen
	v_or_b32_e32 v8, s13, v71
	v_lshlrev_b32_e32 v8, 2, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[106:107], v[4:5], v[24:27]
	s_nop 2
	buffer_load_dwordx4 v[24:27], v8, s[4:7], 0 offen
	v_or_b32_e32 v8, s8, v71
	v_lshlrev_b32_e32 v8, 2, v8
	buffer_load_dwordx4 v[8:11], v8, s[4:7], 0 offen
	s_and_b32 s5, s25, 0xffff
	s_mov_b32 s4, s24
	buffer_load_dword v41, v47, s[4:7], 0 offen
	buffer_load_dword v54, v46, s[4:7], 0 offen offset:96
	v_or_b32_e32 v47, s13, v60
	v_lshlrev_b32_e32 v47, 2, v47
	buffer_load_dword v53, v47, s[4:7], 0 offen
	buffer_load_dword v52, v46, s[4:7], 0 offen offset:160
	v_or_b32_e32 v47, s8, v60
	v_lshlrev_b32_e32 v47, 2, v47
	buffer_load_dword v51, v47, s[4:7], 0 offen
	buffer_load_dword v50, v46, s[4:7], 0 offen offset:224
	buffer_load_dwordx4 v[70:73], v45, s[0:3], 0 offen
	buffer_load_dword v44, v46, s[4:7], 0 offen
	buffer_load_dword v43, v46, s[4:7], 0 offen offset:32
	s_movk_i32 s4, 0x7fff
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[64:65], v[42:43], v[68:69] op_sel_hi:[0,1]
	v_pk_mul_f32 v[38:39], v[38:39], v[64:65]
	v_pk_mul_f32 v[46:47], v[42:43], v[66:67] op_sel_hi:[0,1]
	v_pk_mul_f32 v[36:37], v[36:37], v[46:47]
	v_pk_mul_f32 v[38:39], v[38:39], v[72:73]
	v_pk_mul_f32 v[36:37], v[36:37], v[70:71]
	v_bfe_u32 v46, v39, 16, 1
	v_add3_u32 v46, v46, v39, s4
	v_or_b32_e32 v47, 0x400000, v39
	v_cmp_u_f32_e32 vcc, v39, v39
	s_nop 1
	v_cndmask_b32_e32 v39, v46, v47, vcc
	v_bfe_u32 v46, v38, 16, 1
	v_add3_u32 v46, v46, v38, s4
	v_or_b32_e32 v47, 0x400000, v38
	v_cmp_u_f32_e32 vcc, v38, v38
	s_nop 1
	v_cndmask_b32_e32 v38, v46, v47, vcc
	v_bfe_u32 v46, v37, 16, 1
	v_add3_u32 v46, v46, v37, s4
	v_or_b32_e32 v47, 0x400000, v37
	v_cmp_u_f32_e32 vcc, v37, v37
	v_bfe_u32 v37, v36, 16, 1
	v_add3_u32 v37, v37, v36, s4
	v_cndmask_b32_e32 v46, v46, v47, vcc
	v_or_b32_e32 v47, 0x400000, v36
	v_cmp_u_f32_e32 vcc, v36, v36
	s_nop 1
	v_cndmask_b32_e32 v47, v37, v47, vcc
	v_lshlrev_b32_e32 v37, 1, v63
	v_lshl_add_u32 v36, v62, 10, v37
	ds_write_b16_d16_hi v36, v47
	ds_write_b16_d16_hi v36, v46 offset:256
	ds_write_b16_d16_hi v36, v38 offset:512
	ds_write_b16_d16_hi v36, v39 offset:768
	v_pk_mul_f32 v[46:47], v[40:41], v[68:69] op_sel_hi:[0,1]
	v_pk_mul_f32 v[46:47], v[58:59], v[46:47]
	v_pk_mul_f32 v[38:39], v[40:41], v[66:67] op_sel_hi:[0,1]
	v_pk_mul_f32 v[46:47], v[46:47], v[72:73]
	v_pk_mul_f32 v[38:39], v[56:57], v[38:39]
	v_bfe_u32 v48, v47, 16, 1
	v_add3_u32 v48, v48, v47, s4
	v_or_b32_e32 v55, 0x400000, v47
	v_cmp_u_f32_e32 vcc, v47, v47
	v_pk_mul_f32 v[38:39], v[38:39], v[70:71]
	v_pk_mul_f32 v[58:59], v[42:43], v[34:35] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v47, v48, v55, vcc
	v_bfe_u32 v48, v46, 16, 1
	v_add3_u32 v48, v48, v46, s4
	v_or_b32_e32 v55, 0x400000, v46
	v_cmp_u_f32_e32 vcc, v46, v46
	v_pk_mul_f32 v[22:23], v[22:23], v[58:59]
	v_pk_mul_f32 v[56:57], v[42:43], v[32:33] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v46, v48, v55, vcc
	v_bfe_u32 v48, v39, 16, 1
	v_add3_u32 v48, v48, v39, s4
	v_or_b32_e32 v55, 0x400000, v39
	v_cmp_u_f32_e32 vcc, v39, v39
	v_pk_mul_f32 v[20:21], v[20:21], v[56:57]
	s_nop 0
	v_cndmask_b32_e32 v39, v48, v55, vcc
	v_bfe_u32 v48, v38, 16, 1
	v_add3_u32 v48, v48, v38, s4
	v_or_b32_e32 v55, 0x400000, v38
	v_cmp_u_f32_e32 vcc, v38, v38
	s_nop 1
	v_cndmask_b32_e32 v38, v48, v55, vcc
	ds_write_b16_d16_hi v36, v38 offset:32
	ds_write_b16_d16_hi v36, v39 offset:288
	ds_write_b16_d16_hi v36, v46 offset:544
	ds_write_b16_d16_hi v36, v47 offset:800
	v_or_b32_e32 v38, 64, v45
	v_or_b32_e32 v39, 0x44, v45
	v_or_b32_e32 v46, 0x48, v45
	v_or_b32_e32 v47, 0x4c, v45
	buffer_load_dword v38, v38, s[0:3], 0 offen
	s_nop 0
	buffer_load_dword v39, v39, s[0:3], 0 offen
	s_nop 0
	buffer_load_dword v46, v46, s[0:3], 0 offen
	s_nop 0
	buffer_load_dword v47, v47, s[0:3], 0 offen
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[20:21], v[20:21], v[38:39]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[22:23], v[22:23], v[46:47]
	s_nop 0
	v_bfe_u32 v48, v23, 16, 1
	v_add3_u32 v48, v48, v23, s4
	v_or_b32_e32 v55, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	s_nop 1
	v_cndmask_b32_e32 v23, v48, v55, vcc
	v_bfe_u32 v48, v22, 16, 1
	v_add3_u32 v48, v48, v22, s4
	v_or_b32_e32 v55, 0x400000, v22
	v_cmp_u_f32_e32 vcc, v22, v22
	s_nop 1
	v_cndmask_b32_e32 v22, v48, v55, vcc
	v_bfe_u32 v48, v21, 16, 1
	v_add3_u32 v48, v48, v21, s4
	v_or_b32_e32 v55, 0x400000, v21
	v_cmp_u_f32_e32 vcc, v21, v21
	s_nop 1
	v_cndmask_b32_e32 v21, v48, v55, vcc
	v_bfe_u32 v48, v20, 16, 1
	v_add3_u32 v48, v48, v20, s4
	v_or_b32_e32 v55, 0x400000, v20
	v_cmp_u_f32_e32 vcc, v20, v20
	s_nop 1
	v_cndmask_b32_e32 v20, v48, v55, vcc
	ds_write_b16_d16_hi v36, v20 offset:4096
	ds_write_b16_d16_hi v36, v21 offset:4352
	ds_write_b16_d16_hi v36, v22 offset:4608
	ds_write_b16_d16_hi v36, v23 offset:4864
	v_pk_mul_f32 v[22:23], v[40:41], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[22:23], v[30:31], v[22:23]
	v_pk_mul_f32 v[20:21], v[40:41], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[22:23], v[22:23], v[46:47]
	v_pk_mul_f32 v[20:21], v[28:29], v[20:21]
	v_bfe_u32 v28, v23, 16, 1
	v_add3_u32 v28, v28, v23, s4
	v_or_b32_e32 v29, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	v_pk_mul_f32 v[20:21], v[20:21], v[38:39]
	v_pk_mul_f32 v[30:31], v[42:43], v[26:27] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v23, v28, v29, vcc
	v_bfe_u32 v28, v22, 16, 1
	v_add3_u32 v28, v28, v22, s4
	v_or_b32_e32 v29, 0x400000, v22
	v_cmp_u_f32_e32 vcc, v22, v22
	v_pk_mul_f32 v[14:15], v[14:15], v[30:31]
	s_nop 0
	v_cndmask_b32_e32 v22, v28, v29, vcc
	v_bfe_u32 v28, v21, 16, 1
	v_add3_u32 v28, v28, v21, s4
	v_or_b32_e32 v29, 0x400000, v21
	v_cmp_u_f32_e32 vcc, v21, v21
	s_nop 1
	v_cndmask_b32_e32 v21, v28, v29, vcc
	v_bfe_u32 v28, v20, 16, 1
	v_add3_u32 v28, v28, v20, s4
	v_or_b32_e32 v29, 0x400000, v20
	v_cmp_u_f32_e32 vcc, v20, v20
	s_nop 1
	v_cndmask_b32_e32 v20, v28, v29, vcc
	ds_write_b16_d16_hi v36, v20 offset:4128
	ds_write_b16_d16_hi v36, v21 offset:4384
	ds_write_b16_d16_hi v36, v22 offset:4640
	ds_write_b16_d16_hi v36, v23 offset:4896
	v_or_b32_e32 v20, 0x80, v45
	v_or_b32_e32 v21, 0x84, v45
	v_or_b32_e32 v22, 0x88, v45
	v_or_b32_e32 v23, 0x8c, v45
	buffer_load_dword v20, v20, s[0:3], 0 offen
	v_pk_mul_f32 v[28:29], v[42:43], v[24:25] op_sel_hi:[0,1]
	buffer_load_dword v21, v21, s[0:3], 0 offen
	v_pk_mul_f32 v[12:13], v[12:13], v[28:29]
	buffer_load_dword v22, v22, s[0:3], 0 offen
	s_nop 0
	buffer_load_dword v23, v23, s[0:3], 0 offen
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[12:13], v[12:13], v[20:21]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[14:15], v[14:15], v[22:23]
	s_nop 0
	v_bfe_u32 v28, v15, 16, 1
	v_add3_u32 v28, v28, v15, s4
	v_or_b32_e32 v29, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	s_nop 1
	v_cndmask_b32_e32 v15, v28, v29, vcc
	v_bfe_u32 v28, v14, 16, 1
	v_add3_u32 v28, v28, v14, s4
	v_or_b32_e32 v29, 0x400000, v14
	v_cmp_u_f32_e32 vcc, v14, v14
	s_nop 1
	v_cndmask_b32_e32 v14, v28, v29, vcc
	v_bfe_u32 v28, v13, 16, 1
	v_add3_u32 v28, v28, v13, s4
	v_or_b32_e32 v29, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	s_nop 1
	v_cndmask_b32_e32 v13, v28, v29, vcc
	v_bfe_u32 v28, v12, 16, 1
	v_add3_u32 v28, v28, v12, s4
	v_or_b32_e32 v29, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	s_nop 1
	v_cndmask_b32_e32 v12, v28, v29, vcc
	ds_write_b16_d16_hi v36, v12 offset:8192
	ds_write_b16_d16_hi v36, v13 offset:8448
	ds_write_b16_d16_hi v36, v14 offset:8704
	ds_write_b16_d16_hi v36, v15 offset:8960
	v_pk_mul_f32 v[14:15], v[40:41], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	v_pk_mul_f32 v[12:13], v[40:41], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[14:15], v[22:23]
	v_pk_mul_f32 v[12:13], v[16:17], v[12:13]
	v_bfe_u32 v16, v15, 16, 1
	v_add3_u32 v16, v16, v15, s4
	v_or_b32_e32 v17, 0x400000, v15
	v_cmp_u_f32_e32 vcc, v15, v15
	v_pk_mul_f32 v[12:13], v[12:13], v[20:21]
	v_pk_mul_f32 v[18:19], v[42:43], v[10:11] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v15, v16, v17, vcc
	v_bfe_u32 v16, v14, 16, 1
	v_add3_u32 v16, v16, v14, s4
	v_or_b32_e32 v17, 0x400000, v14
	v_cmp_u_f32_e32 vcc, v14, v14
	v_pk_mul_f32 v[2:3], v[2:3], v[18:19]
	s_nop 0
	v_cndmask_b32_e32 v14, v16, v17, vcc
	v_bfe_u32 v16, v13, 16, 1
	v_add3_u32 v16, v16, v13, s4
	v_or_b32_e32 v17, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	s_nop 1
	v_cndmask_b32_e32 v13, v16, v17, vcc
	v_bfe_u32 v16, v12, 16, 1
	v_add3_u32 v16, v16, v12, s4
	v_or_b32_e32 v17, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	s_nop 1
	v_cndmask_b32_e32 v12, v16, v17, vcc
	ds_write_b16_d16_hi v36, v12 offset:8224
	ds_write_b16_d16_hi v36, v13 offset:8480
	ds_write_b16_d16_hi v36, v14 offset:8736
	ds_write_b16_d16_hi v36, v15 offset:8992
	v_or_b32_e32 v12, 0xc0, v45
	v_or_b32_e32 v13, 0xc4, v45
	v_or_b32_e32 v14, 0xc8, v45
	v_or_b32_e32 v15, 0xcc, v45
	buffer_load_dword v12, v12, s[0:3], 0 offen
	v_pk_mul_f32 v[16:17], v[42:43], v[8:9] op_sel_hi:[0,1]
	buffer_load_dword v13, v13, s[0:3], 0 offen
	v_pk_mul_f32 v[0:1], v[0:1], v[16:17]
	buffer_load_dword v14, v14, s[0:3], 0 offen
	s_nop 0
	buffer_load_dword v15, v15, s[0:3], 0 offen
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[0:1], v[0:1], v[12:13]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[2:3], v[2:3], v[14:15]
	s_nop 0
	v_bfe_u32 v16, v3, 16, 1
	v_add3_u32 v16, v16, v3, s4
	v_or_b32_e32 v17, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v16, v17, vcc
	v_bfe_u32 v16, v2, 16, 1
	v_add3_u32 v16, v16, v2, s4
	v_or_b32_e32 v17, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v16, v17, vcc
	v_bfe_u32 v16, v1, 16, 1
	v_add3_u32 v16, v16, v1, s4
	v_or_b32_e32 v17, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v16, v17, vcc
	v_bfe_u32 v16, v0, 16, 1
	v_add3_u32 v16, v16, v0, s4
	v_or_b32_e32 v17, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v16, v17, vcc
	ds_write_b16_d16_hi v36, v0 offset:12288
	v_lshlrev_b32_e32 v0, 10, v61
	v_or_b32_e32 v16, 0x3100, v0
	v_add_u32_e32 v16, v16, v37
	ds_write_b16_d16_hi v16, v1
	v_or_b32_e32 v1, 0x3200, v0
	v_or_b32_e32 v0, 0x3300, v0
	v_add_u32_e32 v17, v1, v37
	v_add_u32_e32 v18, v0, v37
	ds_write_b16_d16_hi v17, v2
	ds_write_b16_d16_hi v18, v3
	v_pk_mul_f32 v[2:3], v[40:41], v[10:11] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_pk_mul_f32 v[0:1], v[40:41], v[8:9] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[14:15]
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1]
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s4
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[12:13]
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s4
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
	v_bfe_u32 v4, v1, 16, 1
	v_add3_u32 v4, v4, v1, s4
	v_or_b32_e32 v5, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v4, v5, vcc
	v_bfe_u32 v4, v0, 16, 1
	v_add3_u32 v4, v4, v0, s4
	v_or_b32_e32 v5, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v4, v5, vcc
	ds_write_b16_d16_hi v36, v0 offset:12320
	ds_write_b16_d16_hi v16, v1 offset:32
	ds_write_b16_d16_hi v17, v2 offset:32
	ds_write_b16_d16_hi v18, v3 offset:32
	v_and_b32_e32 v0, 0xffffff, v44
	v_cmp_gt_u32_e32 vcc, s33, v0
	v_lshlrev_b32_e32 v0, 1, v49
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_25
	v_lshl_or_b32 v4, v60, 8, v0
	v_lshl_add_u32 v1, v44, 12, s38
	ds_read_b32 v5, v4
	v_or_b32_e32 v1, v1, v49
	v_lshlrev_b32_e32 v2, 1, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v1, v4 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off offset:128
.LBB0_25:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v1, 0xffffff, v43
	v_cmp_gt_u32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_27
	v_lshl_or_b32 v2, v60, 8, v0
	v_lshl_add_u32 v1, v43, 12, s38
	ds_read_b32 v3, v2 offset:2048
	v_or_b32_e32 v0, v1, v49
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off
	ds_read_b32 v2, v2 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_27:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v1, 0xffffff, v41
	v_or_b32_e32 v2, 16, v60
	v_cmp_gt_u32_e64 s[0:1], s33, v1
	s_mov_b32 s37, 24
	s_mov_b32 s4, 32
	s_mov_b32 s3, 40
	s_mov_b32 s40, 48
	s_mov_b32 s2, 56
	s_branch .LBB0_29
.LBB0_28:
	s_mov_b32 s4, 16
	s_mov_b32 s3, 24
	s_mov_b32 s2, 40
	v_mov_b32_e32 v60, v2
.LBB0_29:
	v_lshlrev_b32_e32 v0, 1, v49
	s_and_saveexec_b64 s[6:7], s[0:1]
	s_xor_b64 s[0:1], exec, s[6:7]
	s_cbranch_execz .LBB0_31
	v_lshl_add_u32 v4, v2, 8, v0
	v_lshl_add_u32 v1, v1, 12, s38
	ds_read_b32 v5, v4
	v_or_b32_e32 v1, v1, v49
	v_lshlrev_b32_e32 v2, 1, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v1, v4 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off offset:128
.LBB0_31:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v1, 0xffffff, v54
	v_cmp_gt_u32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_33
	v_add_u32_e32 v1, s37, v60
	v_lshl_add_u32 v1, v1, 8, v0
	ds_read_b32 v6, v1
	v_lshl_add_u32 v2, v54, 12, s38
	v_add_lshl_u32 v2, v2, v49, 1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[4:5], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v6, off
	ds_read_b32 v1, v1 offset:128
	v_add_u32_e32 v2, 0x80, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off
.LBB0_33:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v1, 0xffffff, v53
	v_cmp_gt_u32_e32 vcc, s33, v1
	v_add_lshl_u32 v1, v49, s38, 1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_35
	v_add_u32_e32 v2, s4, v60
	v_lshl_add_u32 v6, v2, 8, v0
	ds_read_b32 v7, v6
	v_lshl_add_u32 v2, v53, 13, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[4:5], s[34:35], 0, v[2:3]
	v_add_u32_e32 v2, 0x80, v2
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v7, off
	ds_read_b32 v4, v6 offset:128
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off
.LBB0_35:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v52
	v_cmp_gt_u32_e32 vcc, s33, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_37
	v_add_u32_e32 v2, s3, v60
	v_lshl_add_u32 v6, v2, 8, v0
	ds_read_b32 v7, v6
	v_lshl_add_u32 v2, v52, 13, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[4:5], s[34:35], 0, v[2:3]
	v_add_u32_e32 v2, 0x80, v2
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v7, off
	ds_read_b32 v4, v6 offset:128
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off
.LBB0_37:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v51
	v_cmp_gt_u32_e32 vcc, s33, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_39
	v_add_u32_e32 v2, s40, v60
	v_lshl_add_u32 v6, v2, 8, v0
	ds_read_b32 v7, v6
	v_lshl_add_u32 v2, v51, 13, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[4:5], s[34:35], 0, v[2:3]
	v_add_u32_e32 v2, 0x80, v2
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[4:5], v7, off
	ds_read_b32 v4, v6 offset:128
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off
.LBB0_39:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v50
	v_cmp_gt_u32_e32 vcc, s33, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_41
	v_add_u32_e32 v2, s2, v60
	v_lshl_add_u32 v4, v2, 8, v0
	ds_read_b32 v5, v4
	v_lshl_add_u32 v0, v50, 13, v1
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[2:3], s[34:35], 0, v[0:1]
	v_add_u32_e32 v0, 0x80, v0
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v2, v4 offset:128
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off
.LBB0_41:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn, .Lfunc_end0-a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
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
		.amdhsa_next_free_vgpr 115
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 116
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

	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.num_vgpr, 115
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.num_agpr, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.numbered_sgpr, 41
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.num_named_barrier, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.private_seg_size, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.uses_vcc, 1
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.uses_flat_scratch, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.has_dyn_sized_stack, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.has_recursion, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.has_indirect_call, 0
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
    .name:           a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     47
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     115
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
