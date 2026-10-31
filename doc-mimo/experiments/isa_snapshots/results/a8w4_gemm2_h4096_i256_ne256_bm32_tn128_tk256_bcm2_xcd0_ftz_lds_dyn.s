	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
	.p2align	8
	.type	a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn,@function
a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn:
	s_load_dwordx16 s[12:27], s[0:1], 0x0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[22:23], 0x0
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
	s_lshl_b32 s4, s3, 5
	s_cmp_ge_i32 s2, s4
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_14
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
	s_subb_u32 s34, s8, 0
	s_ashr_i32 s35, s34, 31
	s_sub_i32 s2, s2, s9
	s_lshl_b64 s[4:5], s[34:35], 2
	s_add_u32 s4, s20, s4
	s_addc_u32 s5, s21, s5
	s_load_dword s4, s[4:5], 0x0
	s_lshr_b32 s3, s3, 1
	s_lshl_b32 s33, s2, 7
	s_and_b32 s3, s3, 0x7fffffe0
	v_and_b32_e32 v1, 48, v0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s4, 12
	s_add_i32 s4, s33, s3
	s_add_i32 s4, s4, s2
	v_and_b32_e32 v2, 15, v0
	s_lshl_b32 s2, s4, 1
	v_or3_b32 v3, s2, v1, v2
	s_mov_b32 s11, 0x27000
	s_and_b32 s9, s19, 0xffff
	s_mov_b32 s10, 0x800000
	s_mov_b32 s8, s18
	v_lshlrev_b32_e32 v3, 2, v3
	buffer_load_dword v3, v3, s[8:11], 0 offen
	v_lshlrev_b32_e32 v5, 4, v0
	v_lshrrev_b32_e32 v12, 4, v0
	v_bfe_u32 v17, v0, 4, 2
	v_and_b32_e32 v4, 63, v0
	v_lshrrev_b32_e32 v16, 5, v0
	v_lshlrev_b32_e32 v18, 1, v0
	v_xor_b32_e32 v0, v5, v0
	s_lshl_b32 s30, s34, 5
	v_and_b32_e32 v13, 0xf0, v0
	v_or_b32_e32 v0, s30, v12
	v_and_b32_e32 v6, 0xf0, v5
	v_lshlrev_b32_e32 v5, 8, v12
	v_lshl_or_b32 v15, v0, 8, v13
	v_or_b32_e32 v0, s3, v2
	s_lshl_b32 s2, s4, 3
	s_ashr_i32 s3, s4, 4
	v_add_u32_e32 v29, v5, v6
	s_lshr_b32 s4, s4, 31
	v_or3_b32 v5, s2, v1, v2
	s_or_b32 s2, s3, 1
	s_lshl_b32 s3, s2, 7
	s_add_i32 s4, s2, s4
	v_or3_b32 v1, s3, v1, v2
	s_and_b32 s3, s4, -2
	s_sub_i32 s2, s2, s3
	s_lshl_b32 s2, s2, 3
	s_add_i32 s3, s2, 16
	v_lshlrev_b32_e32 v23, 8, v2
	v_lshlrev_b32_e32 v25, 4, v2
	v_lshlrev_b32_e32 v14, 4, v5
	s_ashr_i32 s31, s30, 31
	s_load_dwordx2 s[28:29], s[0:1], 0x40
	s_load_dword s35, s[0:1], 0x48
	v_lshlrev_b32_e32 v4, 2, v4
	s_and_b32 s17, s17, 0xffff
	s_and_b32 s21, s13, 0xffff
	s_lshl_b64 s[0:1], s[30:31], 2
	v_xor_b32_e32 v4, 0x80, v4
	s_add_u32 s0, s24, s0
	s_addc_u32 s1, s25, s1
	s_load_dword s0, s[0:1], 0x40
	s_brev_b32 s37, 16
	s_mov_b32 s22, -1
	s_mov_b32 s36, 8
	v_lshlrev_b32_e32 v24, 5, v17
	s_waitcnt lgkmcnt(0)
	s_and_b32 s0, s0, 0xffffff
	v_lshlrev_b32_e32 v32, 4, v1
	s_cmp_lt_i32 s0, s35
	v_lshlrev_b32_e32 v19, 1, v0
	s_waitcnt vmcnt(0)
	v_bfe_u32 v2, v3, s2, 8
	v_bfe_u32 v5, v3, s3, 8
	v_max_u32_sdwa v6, v3, v3 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	v_max_u32_e32 v8, v5, v2
	ds_swizzle_b32 v7, v6 offset:swizzle(SWAP,16)
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v6, v7, v6
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v8, v9, v8
	ds_bpermute_b32 v7, v4, v6
	ds_bpermute_b32 v4, v4, v8
	s_waitcnt lgkmcnt(1)
	v_max_i32_e32 v21, v7, v6
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v20, v4, v8
	v_sub_u32_sdwa v31, v21, v3 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_sub_u32_sdwa v30, v21, v3 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_sub_u32_e32 v27, v20, v2
	v_sub_u32_e32 v22, v20, v5
	v_cmp_lt_u32_e32 vcc, 5, v21
	v_min_i32_e32 v33, 11, v31
	v_cmp_lt_i32_e64 s[6:7], 11, v31
	v_min_i32_e32 v34, 11, v30
	v_cmp_lt_i32_e64 s[8:9], 11, v30
	v_cmp_lt_u32_e64 s[0:1], 5, v20
	v_min_i32_e32 v28, 11, v27
	v_cmp_lt_i32_e64 s[4:5], 11, v27
	v_min_i32_e32 v26, 11, v22
	v_cmp_lt_i32_e64 s[2:3], 11, v22
	s_cbranch_scc1 .LBB0_3
	s_mov_b32 s20, s12
	s_mov_b32 s23, s11
	s_mov_b32 s18, s37
	s_mov_b32 s19, s11
	buffer_load_dwordx4 v[52:55], v15, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[8:11], v14, s[16:19], 0 offen nt
	v_or_b32_e32 v35, 0x400, v14
	buffer_load_dwordx4 v[36:39], v35, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[4:7], v32, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[0:3], v32, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s10, 0x8080808
	v_mul_lo_u32 v35, v33, s10
	v_sub_u32_e32 v45, 0x6c686080, v35
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_and_b32_e32 v45, 0xffffff00, v45
	v_or_b32_e32 v41, 8, v24
	v_or_b32_e32 v42, 16, v24
	v_cndmask_b32_e64 v35, v35, 0, s[6:7]
	v_cndmask_b32_e64 v45, v45, 0, s[6:7]
	v_xor_b32_e32 v40, v24, v25
	v_or_b32_e32 v43, 24, v24
	v_xor_b32_e32 v41, v41, v25
	v_xor_b32_e32 v42, v42, v25
	v_add_u32_e32 v47, 0x7f7f7f78, v35
	v_add_u32_e32 v49, 0x7f7f7f00, v45
	v_or_b32_e32 v40, v23, v40
	v_xor_b32_e32 v43, v43, v25
	v_or_b32_e32 v41, v23, v41
	v_or_b32_e32 v42, v23, v42
	v_and_b32_e32 v47, 0x80808080, v47
	v_and_b32_e32 v49, 0x80808000, v49
	v_or_b32_e32 v43, v23, v43
	s_mov_b32 s13, 0x5010400
	s_mov_b32 s20, 0x7030602
	v_mul_lo_u32 v44, v34, s10
	v_sub_u32_e32 v46, 0x6c686080, v44
	v_sub_u32_e32 v44, 0x7c787470, v44
	v_and_b32_e32 v46, 0xffffff00, v46
	v_cndmask_b32_e64 v44, v44, 0, s[8:9]
	v_cndmask_b32_e64 v46, v46, 0, s[8:9]
	v_add_u32_e32 v48, 0x7f7f7f78, v44
	v_add_u32_e32 v50, 0x7f7f7f00, v46
	v_and_b32_e32 v48, 0x80808080, v48
	v_and_b32_e32 v50, 0x80808000, v50
	s_and_b32 s9, s15, 0xffff
	s_mov_b32 s8, s14
	s_mov_b32 s6, s22
	s_mov_b32 s7, s11
	s_waitcnt vmcnt(4)
	ds_write_b128 v29, v[52:55]
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v51, 0x7070707, v8
	v_lshrrev_b32_e32 v52, 4, v8
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_lshlrev_b32_e32 v53, 4, v8
	ds_read_b64 v[64:65], v40
	ds_read_b64 v[66:67], v41
	ds_read_b64 v[68:69], v42
	ds_read_b64 v[70:71], v43
	v_and_b32_e32 v40, 0x7070707, v52
	v_perm_b32 v41, v47, v49, v51
	v_perm_b32 v42, v35, v45, v51
	v_and_or_b32 v41, v41, v53, v42
	v_perm_b32 v42, v47, v49, v40
	v_perm_b32 v40, v35, v45, v40
	v_and_b32_e32 v54, 0x7070707, v9
	v_lshrrev_b32_e32 v55, 4, v9
	v_and_or_b32 v8, v42, v8, v40
	v_lshlrev_b32_e32 v56, 4, v9
	v_and_b32_e32 v43, 0x7070707, v55
	v_perm_b32 v51, v47, v49, v54
	v_perm_b32 v52, v35, v45, v54
	v_perm_b32 v40, v8, v41, s13
	v_perm_b32 v41, v8, v41, s20
	v_and_or_b32 v51, v51, v56, v52
	v_perm_b32 v52, v47, v49, v43
	v_perm_b32 v53, v35, v45, v43
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[64:65], v[40:41], 0
	v_and_or_b32 v9, v52, v9, v53
	v_lshrrev_b32_e32 v58, 4, v10
	v_perm_b32 v8, v9, v51, s13
	v_perm_b32 v9, v9, v51, s20
	v_and_b32_e32 v57, 0x7070707, v10
	v_and_b32_e32 v54, 0x7070707, v58
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[66:67], v[8:9], v[40:43]
	v_lshlrev_b32_e32 v59, 4, v10
	v_perm_b32 v55, v47, v49, v57
	v_perm_b32 v57, v35, v45, v57
	v_perm_b32 v56, v47, v49, v54
	v_perm_b32 v54, v35, v45, v54
	v_and_or_b32 v55, v55, v59, v57
	v_and_or_b32 v9, v56, v10, v54
	v_lshrrev_b32_e32 v61, 4, v11
	v_perm_b32 v8, v9, v55, s13
	v_perm_b32 v9, v9, v55, s20
	v_and_b32_e32 v60, 0x7070707, v11
	v_and_b32_e32 v58, 0x7070707, v61
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[40:43], v[68:69], v[8:9], v[40:43]
	v_lshlrev_b32_e32 v62, 4, v11
	v_perm_b32 v61, v47, v49, v60
	v_perm_b32 v60, v35, v45, v60
	v_perm_b32 v8, v47, v49, v58
	v_perm_b32 v9, v35, v45, v58
	v_and_or_b32 v57, v61, v62, v60
	v_and_or_b32 v9, v8, v11, v9
	v_perm_b32 v8, v9, v57, s13
	v_perm_b32 v9, v9, v57, s20
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v35, 0x7070707, v36
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v55, 4, v7
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[70:71], v[8:9], v[40:43]
	s_nop 2
	v_lshrrev_b32_e32 v40, 4, v36
	v_and_b32_e32 v40, 0x7070707, v40
	v_perm_b32 v41, v48, v50, v35
	v_lshlrev_b32_e32 v42, 4, v36
	v_perm_b32 v35, v44, v46, v35
	v_and_or_b32 v35, v41, v42, v35
	v_perm_b32 v41, v48, v50, v40
	v_perm_b32 v40, v44, v46, v40
	v_and_or_b32 v36, v41, v36, v40
	v_perm_b32 v40, v36, v35, s13
	v_perm_b32 v41, v36, v35, s20
	v_or_b32_e32 v35, 0x80, v24
	v_xor_b32_e32 v35, v35, v25
	v_or_b32_e32 v35, v23, v35
	ds_read_b64 v[56:57], v35
	v_or_b32_e32 v35, 0x88, v24
	v_or_b32_e32 v36, 0x90, v24
	v_xor_b32_e32 v35, v35, v25
	v_xor_b32_e32 v36, v36, v25
	v_or_b32_e32 v42, 0x98, v24
	v_or_b32_e32 v35, v23, v35
	v_or_b32_e32 v36, v23, v36
	v_xor_b32_e32 v42, v42, v25
	v_or_b32_e32 v42, v23, v42
	ds_read_b64 v[58:59], v35
	ds_read_b64 v[60:61], v36
	ds_read_b64 v[62:63], v42
	v_and_b32_e32 v35, 0x7070707, v37
	v_lshrrev_b32_e32 v36, 4, v37
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[56:57], v[40:41], v[8:11]
	v_and_b32_e32 v36, 0x7070707, v36
	v_perm_b32 v40, v48, v50, v35
	v_lshlrev_b32_e32 v41, 4, v37
	v_perm_b32 v35, v44, v46, v35
	v_and_or_b32 v35, v40, v41, v35
	v_perm_b32 v40, v48, v50, v36
	v_perm_b32 v36, v44, v46, v36
	v_and_or_b32 v37, v40, v37, v36
	v_perm_b32 v36, v37, v35, s13
	v_perm_b32 v37, v37, v35, s20
	v_and_b32_e32 v35, 0x7070707, v38
	v_lshlrev_b32_e32 v40, 4, v38
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[58:59], v[36:37], v[8:11]
	v_lshrrev_b32_e32 v36, 4, v38
	v_and_b32_e32 v36, 0x7070707, v36
	v_perm_b32 v37, v48, v50, v35
	v_perm_b32 v35, v44, v46, v35
	v_and_or_b32 v35, v37, v40, v35
	v_perm_b32 v37, v48, v50, v36
	v_perm_b32 v36, v44, v46, v36
	v_and_or_b32 v37, v37, v38, v36
	v_perm_b32 v36, v37, v35, s13
	v_perm_b32 v37, v37, v35, s20
	v_and_b32_e32 v35, 0x7070707, v39
	v_lshlrev_b32_e32 v38, 4, v39
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[60:61], v[36:37], v[8:11]
	v_lshrrev_b32_e32 v36, 4, v39
	v_and_b32_e32 v36, 0x7070707, v36
	v_perm_b32 v37, v48, v50, v35
	v_perm_b32 v35, v44, v46, v35
	v_and_or_b32 v35, v37, v38, v35
	v_perm_b32 v37, v48, v50, v36
	v_perm_b32 v36, v44, v46, v36
	v_and_or_b32 v37, v37, v39, v36
	v_perm_b32 v36, v37, v35, s13
	v_perm_b32 v37, v37, v35, s20
	v_mul_lo_u32 v35, v28, s10
	v_lshlrev_b32_e32 v39, 4, v4
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[62:63], v[36:37], v[8:11]
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_cndmask_b32_e64 v48, v36, 0, s[4:5]
	v_cndmask_b32_e64 v35, v35, 0, s[4:5]
	v_add_u32_e32 v36, 0x7f7f7f00, v48
	v_and_b32_e32 v49, 0x80808000, v36
	v_add_u32_e32 v36, 0x7f7f7f78, v35
	v_and_b32_e32 v50, 0x80808080, v36
	v_mul_lo_u32 v36, v26, s10
	v_sub_u32_e32 v37, 0x6c686080, v36
	v_and_b32_e32 v37, 0xffffff00, v37
	v_sub_u32_e32 v36, 0x7c787470, v36
	v_cndmask_b32_e64 v51, v37, 0, s[2:3]
	v_cndmask_b32_e64 v52, v36, 0, s[2:3]
	v_add_u32_e32 v36, 0x7f7f7f00, v51
	v_and_b32_e32 v53, 0x80808000, v36
	v_add_u32_e32 v36, 0x7f7f7f78, v52
	v_and_b32_e32 v54, 0x80808080, v36
	v_and_b32_e32 v36, 0x7070707, v4
	v_lshrrev_b32_e32 v37, 4, v4
	v_and_b32_e32 v37, 0x7070707, v37
	v_perm_b32 v38, v50, v49, v36
	v_perm_b32 v36, v35, v48, v36
	v_and_or_b32 v38, v38, v39, v36
	v_perm_b32 v36, v50, v49, v37
	v_perm_b32 v37, v35, v48, v37
	v_and_or_b32 v4, v36, v4, v37
	v_perm_b32 v36, v4, v38, s13
	v_perm_b32 v37, v4, v38, s20
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshrrev_b32_e32 v40, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[64:65], v[36:37], 0
	v_and_b32_e32 v40, 0x7070707, v40
	v_perm_b32 v41, v50, v49, v4
	v_lshlrev_b32_e32 v42, 4, v5
	v_perm_b32 v4, v35, v48, v4
	v_and_or_b32 v41, v41, v42, v4
	v_perm_b32 v4, v50, v49, v40
	v_perm_b32 v40, v35, v48, v40
	v_and_or_b32 v5, v4, v5, v40
	v_perm_b32 v4, v5, v41, s13
	v_perm_b32 v5, v5, v41, s20
	v_lshlrev_b32_e32 v41, 4, v6
	s_mov_b32 s10, s22
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[66:67], v[4:5], v[36:39]
	v_and_b32_e32 v4, 0x7070707, v6
	v_lshrrev_b32_e32 v5, 4, v6
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v40, v50, v49, v4
	v_perm_b32 v4, v35, v48, v4
	v_and_or_b32 v40, v40, v41, v4
	v_perm_b32 v4, v50, v49, v5
	v_perm_b32 v5, v35, v48, v5
	v_and_or_b32 v5, v4, v6, v5
	v_perm_b32 v4, v5, v40, s13
	v_perm_b32 v5, v5, v40, s20
	v_lshlrev_b32_e32 v40, 4, v17
	v_lshl_or_b32 v44, s34, 7, v40
	s_barrier
	buffer_load_dwordx4 v[40:43], v44, s[8:11], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[68:69], v[4:5], v[36:39]
	v_and_b32_e32 v4, 0x7070707, v7
	v_lshrrev_b32_e32 v5, 4, v7
	s_and_b32 s5, s27, 0xffff
	s_mov_b32 s4, s26
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v6, v50, v49, v4
	v_perm_b32 v4, v35, v48, v4
	buffer_load_dwordx4 v[44:47], v44, s[4:7], 0 offen
	v_and_or_b32 v6, v6, v55, v4
	v_perm_b32 v4, v50, v49, v5
	v_perm_b32 v5, v35, v48, v5
	v_and_or_b32 v5, v4, v7, v5
	v_perm_b32 v4, v5, v6, s13
	v_perm_b32 v5, v5, v6, s20
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v35, 0x7070707, v0
	s_and_b32 s9, s25, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[70:71], v[4:5], v[36:39]
	s_mov_b32 s8, s24
	s_mov_b32 s2, 0x20000
	s_nop 0
	v_lshrrev_b32_e32 v36, 4, v0
	v_and_b32_e32 v36, 0x7070707, v36
	v_perm_b32 v37, v54, v53, v35
	v_lshlrev_b32_e32 v38, 4, v0
	v_perm_b32 v35, v52, v51, v35
	v_and_or_b32 v35, v37, v38, v35
	v_perm_b32 v37, v54, v53, v36
	v_perm_b32 v36, v52, v51, v36
	v_and_or_b32 v0, v37, v0, v36
	v_perm_b32 v36, v0, v35, s13
	v_perm_b32 v37, v0, v35, s20
	v_and_b32_e32 v0, 0x7070707, v1
	v_lshrrev_b32_e32 v35, 4, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[56:57], v[36:37], v[4:7]
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v54, v53, v0
	v_lshlrev_b32_e32 v37, 4, v1
	v_perm_b32 v0, v52, v51, v0
	v_and_or_b32 v36, v36, v37, v0
	v_perm_b32 v0, v54, v53, v35
	v_perm_b32 v35, v52, v51, v35
	v_and_or_b32 v1, v0, v1, v35
	v_perm_b32 v0, v1, v36, s13
	v_perm_b32 v1, v1, v36, s20
	v_lshlrev_b32_e32 v36, 4, v2
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[58:59], v[0:1], v[4:7]
	v_and_b32_e32 v0, 0x7070707, v2
	v_lshrrev_b32_e32 v1, 4, v2
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v35, v54, v53, v0
	v_perm_b32 v0, v52, v51, v0
	v_and_or_b32 v35, v35, v36, v0
	v_perm_b32 v0, v54, v53, v1
	v_perm_b32 v1, v52, v51, v1
	v_and_or_b32 v1, v0, v2, v1
	v_perm_b32 v0, v1, v35, s13
	v_perm_b32 v1, v1, v35, s20
	v_lshlrev_b32_e32 v35, 4, v3
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[60:61], v[0:1], v[4:7]
	v_and_b32_e32 v0, 0x7070707, v3
	v_perm_b32 v2, v54, v53, v0
	v_perm_b32 v0, v52, v51, v0
	v_lshrrev_b32_e32 v1, 4, v3
	v_and_or_b32 v2, v2, v35, v0
	v_or_b32_e32 v35, s30, v16
	v_and_b32_e32 v1, 0x7070707, v1
	v_lshlrev_b32_e32 v35, 2, v35
	v_perm_b32 v0, v54, v53, v1
	v_perm_b32 v1, v52, v51, v1
	buffer_load_dword v37, v35, s[8:11], 0 offen
	v_and_or_b32 v1, v0, v3, v1
	v_perm_b32 v0, v1, v2, s13
	v_perm_b32 v1, v1, v2, s20
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[62:63], v[0:1], v[4:7]
	s_nop 2
	buffer_load_dword v5, v35, s[8:11], 0 offen offset:32
	v_mov_b32_e32 v4, 0xfd800000
	v_lshl_add_u32 v6, v21, 23, v4
	v_lshlrev_b32_e64 v7, v21, s2
	v_cndmask_b32_e32 v6, v7, v6, vcc
	v_lshl_add_u32 v4, v20, 23, v4
	v_lshlrev_b32_e64 v7, v20, s2
	v_cndmask_b32_e64 v36, v7, v4, s[0:1]
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[38:39], v[6:7], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[6:7], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	s_movk_i32 s0, 0x7fff
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[6:7], v[6:7], v[46:47]
	v_pk_mul_f32 v[8:9], v[8:9], v[38:39]
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s0
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[8:9], v[8:9], v[44:45]
	v_and_b32_e32 v4, 62, v18
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_bfe_u32 v10, v6, 16, 1
	v_add3_u32 v10, v10, v6, s0
	v_or_b32_e32 v11, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_mov_b64 s[2:3], 0
	s_nop 0
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s0
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s0
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_lshl_add_u32 v10, v17, 10, v19
	ds_write_b16_d16_hi v10, v8
	ds_write_b16_d16_hi v10, v9 offset:256
	ds_write_b16_d16_hi v10, v6 offset:512
	ds_write_b16_d16_hi v10, v7 offset:768
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[8:9], v[36:37], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[8:9]
	v_pk_mul_f32 v[6:7], v[36:37], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[46:47]
	v_pk_mul_f32 v[0:1], v[0:1], v[6:7]
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s0
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[44:45]
	s_nop 0
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v6, v6, v2, s0
	v_or_b32_e32 v7, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v6, v7, vcc
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s0
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v6, v6, v0, s0
	v_or_b32_e32 v7, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v6, v7, vcc
	ds_write_b16_d16_hi v10, v0 offset:32
	ds_write_b16_d16_hi v10, v1 offset:288
	ds_write_b16_d16_hi v10, v2 offset:544
	ds_write_b16_d16_hi v10, v3 offset:800
	v_and_b32_e32 v0, 0xffffff, v37
	v_cmp_gt_i32_e32 vcc, s35, v0
	s_and_b64 s[0:1], vcc, exec
	v_mov_b32_e32 v1, v16
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_branch .LBB0_4
.LBB0_3:
	s_mov_b64 s[2:3], -1
	s_mov_b64 s[0:1], 0
.LBB0_4:
	s_and_b64 s[2:3], s[2:3], exec
	s_cselect_b32 s2, 1, 0
	s_cmp_lg_u32 s2, 1
	v_mov_b32_e32 v2, v1
	s_cbranch_scc1 .LBB0_10
	s_or_b32 s8, s30, 16
	s_mov_b32 s18, s37
	s_mov_b32 s19, s11
	v_or_b32_e32 v4, s8, v12
	s_mov_b32 s20, s12
	s_mov_b32 s23, s11
	buffer_load_dwordx4 v[0:3], v14, s[16:19], 0 offen nt
	v_lshl_or_b32 v4, v4, 8, v13
	buffer_load_dwordx4 v[44:47], v15, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[62:65], v4, s[20:23], 0 offen nt
	v_or_b32_e32 v35, 0x400, v14
	buffer_load_dwordx4 v[8:11], v35, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[12:15], v32, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[4:7], v32, s[16:19], 0 offen offset:1024 nt
	s_mov_b32 s2, 0x8080808
	v_xor_b32_e32 v36, v24, v25
	v_or_b32_e32 v37, 8, v24
	v_or_b32_e32 v38, 16, v24
	v_mul_lo_u32 v32, v33, s2
	v_mul_lo_u32 v33, v34, s2
	v_or_b32_e32 v34, v23, v36
	v_xor_b32_e32 v35, v37, v25
	v_xor_b32_e32 v36, v38, v25
	v_sub_u32_e32 v37, 0x6c686080, v32
	v_sub_u32_e32 v32, 0x7c787470, v32
	v_or_b32_e32 v42, v23, v36
	v_and_b32_e32 v36, 0xffffff00, v37
	v_cmp_lt_i32_e32 vcc, 11, v31
	v_sub_u32_e32 v38, 0x6c686080, v33
	v_sub_u32_e32 v33, 0x7c787470, v33
	v_cndmask_b32_e64 v54, v36, 0, vcc
	v_cndmask_b32_e64 v55, v32, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v30
	v_add_u32_e32 v30, 0x7f7f7f00, v54
	v_add_u32_e32 v31, 0x7f7f7f78, v55
	v_cndmask_b32_e64 v67, v33, 0, vcc
	v_and_b32_e32 v57, 0x80808000, v30
	v_and_b32_e32 v58, 0x80808080, v31
	v_and_b32_e32 v37, 0xffffff00, v38
	v_or_b32_e32 v35, v23, v35
	v_cndmask_b32_e64 v66, v37, 0, vcc
	v_or_b32_e32 v39, 24, v24
	v_xor_b32_e32 v50, v39, v25
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_add_u32_e32 v56, 0x7f7f7f00, v66
	v_cmp_lt_i32_e32 vcc, 11, v27
	s_mov_b32 s3, 0x27000
	s_and_b32 s5, s27, 0xffff
	s_mov_b32 s4, s26
	s_mov_b32 s7, s3
	s_mov_b32 s9, 0x20000
	s_waitcnt vmcnt(5)
	v_and_b32_e32 v30, 0x7070707, v0
	v_lshrrev_b32_e32 v31, 4, v0
	v_and_b32_e32 v32, 0x7070707, v1
	v_lshrrev_b32_e32 v33, 4, v1
	s_waitcnt vmcnt(4)
	ds_write_b128 v29, v[44:47]
	v_and_b32_e32 v40, 0x7070707, v31
	v_perm_b32 v41, v58, v57, v30
	v_perm_b32 v43, v55, v54, v30
	v_and_b32_e32 v44, 0x7070707, v33
	v_perm_b32 v45, v58, v57, v32
	v_perm_b32 v46, v55, v54, v32
	s_waitcnt vmcnt(3)
	ds_write_b128 v29, v[62:65] offset:4096
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read2st64_b64 v[30:33], v34 offset1:8
	v_lshlrev_b32_e32 v36, 4, v0
	v_lshlrev_b32_e32 v37, 4, v1
	v_and_or_b32 v29, v41, v36, v43
	v_and_or_b32 v61, v45, v37, v46
	ds_read2st64_b64 v[34:37], v35 offset1:8
	v_and_b32_e32 v38, 0x7070707, v2
	v_lshrrev_b32_e32 v39, 4, v2
	v_and_b32_e32 v52, 0x7070707, v39
	v_perm_b32 v53, v58, v57, v38
	v_perm_b32 v60, v55, v54, v38
	v_perm_b32 v38, v58, v57, v40
	v_perm_b32 v39, v55, v54, v40
	v_and_or_b32 v0, v38, v0, v39
	v_perm_b32 v46, v0, v29, s0
	v_perm_b32 v47, v0, v29, s1
	v_perm_b32 v0, v58, v57, v44
	v_perm_b32 v29, v55, v54, v44
	ds_read2st64_b64 v[42:45], v42 offset1:8
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[30:31], v[46:47], 0
	v_and_or_b32 v1, v0, v1, v29
	v_perm_b32 v0, v1, v61, s0
	v_perm_b32 v1, v1, v61, s1
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[32:33], v[46:47], 0
	v_lshlrev_b32_e32 v51, 4, v2
	v_and_or_b32 v29, v53, v51, v60
	v_perm_b32 v51, v58, v57, v52
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[34:35], v[0:1], v[38:41]
	v_perm_b32 v52, v55, v54, v52
	v_and_b32_e32 v59, 0x7070707, v3
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v60, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[36:37], v[0:1], v[46:49]
	v_and_or_b32 v1, v51, v2, v52
	v_perm_b32 v0, v1, v29, s0
	v_perm_b32 v1, v1, v29, s1
	v_lshrrev_b32_e32 v2, 4, v3
	v_and_b32_e32 v2, 0x7070707, v2
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[42:43], v[0:1], v[38:41]
	v_perm_b32 v29, v58, v57, v59
	v_lshlrev_b32_e32 v63, 4, v10
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v27, 4, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[44:45], v[0:1], v[46:49]
	v_or_b32_e32 v0, v23, v50
	ds_read2st64_b64 v[50:53], v0 offset1:8
	v_lshlrev_b32_e32 v0, 4, v3
	v_perm_b32 v1, v55, v54, v59
	v_and_or_b32 v0, v29, v0, v1
	v_perm_b32 v1, v58, v57, v2
	v_perm_b32 v2, v55, v54, v2
	v_and_or_b32 v1, v1, v3, v2
	v_perm_b32 v54, v1, v0, s0
	v_perm_b32 v55, v1, v0, s1
	v_and_b32_e32 v29, 0x80808000, v56
	v_lshlrev_b32_e32 v57, 4, v8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[50:51], v[54:55], v[38:41]
	s_nop 2
	v_add_u32_e32 v38, 0x7f7f7f78, v67
	v_and_b32_e32 v68, 0x80808080, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[52:53], v[54:55], v[46:49]
	v_and_b32_e32 v54, 0x7070707, v8
	v_perm_b32 v56, v68, v29, v54
	v_perm_b32 v54, v67, v66, v54
	v_lshrrev_b32_e32 v46, 4, v8
	v_and_b32_e32 v55, 0x7070707, v46
	v_or_b32_e32 v46, 0x80, v24
	v_xor_b32_e32 v46, v46, v25
	v_or_b32_e32 v46, v23, v46
	ds_read2st64_b64 v[46:49], v46 offset1:8
	v_and_or_b32 v56, v56, v57, v54
	v_perm_b32 v54, v68, v29, v55
	v_perm_b32 v55, v67, v66, v55
	v_and_or_b32 v8, v54, v8, v55
	v_perm_b32 v54, v8, v56, s0
	v_perm_b32 v55, v8, v56, s1
	v_and_b32_e32 v8, 0x7070707, v9
	v_perm_b32 v59, v68, v29, v8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[46:47], v[54:55], v[0:3]
	v_perm_b32 v8, v67, v66, v8
	v_and_or_b32 v59, v59, v60, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[48:49], v[54:55], v[38:41]
	v_lshrrev_b32_e32 v54, 4, v9
	v_and_b32_e32 v58, 0x7070707, v54
	v_or_b32_e32 v54, 0x88, v24
	v_xor_b32_e32 v54, v54, v25
	v_or_b32_e32 v54, v23, v54
	ds_read2st64_b64 v[54:57], v54 offset1:8
	v_perm_b32 v8, v68, v29, v58
	v_perm_b32 v58, v67, v66, v58
	v_and_or_b32 v9, v8, v9, v58
	v_or_b32_e32 v58, 0x90, v24
	v_xor_b32_e32 v58, v58, v25
	v_or_b32_e32 v58, v23, v58
	v_perm_b32 v8, v9, v59, s0
	v_perm_b32 v9, v9, v59, s1
	ds_read2st64_b64 v[58:61], v58 offset1:8
	v_or_b32_e32 v24, 0x98, v24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[54:55], v[8:9], v[0:3]
	v_xor_b32_e32 v24, v24, v25
	v_or_b32_e32 v23, v23, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[56:57], v[8:9], v[38:41]
	v_and_b32_e32 v8, 0x7070707, v10
	v_lshrrev_b32_e32 v9, 4, v10
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v62, v68, v29, v8
	v_perm_b32 v8, v67, v66, v8
	v_and_or_b32 v62, v62, v63, v8
	v_perm_b32 v8, v68, v29, v9
	v_perm_b32 v9, v67, v66, v9
	v_and_or_b32 v9, v8, v10, v9
	v_perm_b32 v8, v9, v62, s0
	v_perm_b32 v9, v9, v62, s1
	ds_read2st64_b64 v[62:65], v23 offset1:8
	v_lshlrev_b32_e32 v23, 4, v11
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[58:59], v[8:9], v[0:3]
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[60:61], v[8:9], v[38:41]
	v_and_b32_e32 v8, 0x7070707, v11
	v_lshrrev_b32_e32 v9, 4, v11
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v10, v68, v29, v8
	v_perm_b32 v8, v67, v66, v8
	v_and_or_b32 v8, v10, v23, v8
	v_perm_b32 v10, v68, v29, v9
	v_perm_b32 v9, v67, v66, v9
	v_and_or_b32 v9, v10, v11, v9
	v_perm_b32 v24, v9, v8, s0
	v_perm_b32 v25, v9, v8, s1
	v_mul_lo_u32 v23, v28, s2
	v_lshlrev_b32_e32 v66, 4, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[62:63], v[24:25], v[0:3]
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[64:65], v[24:25], v[38:41]
	v_sub_u32_e32 v24, 0x6c686080, v23
	v_and_b32_e32 v24, 0xffffff00, v24
	v_sub_u32_e32 v23, 0x7c787470, v23
	v_cndmask_b32_e64 v38, v24, 0, vcc
	v_cndmask_b32_e64 v39, v23, 0, vcc
	v_add_u32_e32 v23, 0x7f7f7f00, v38
	v_and_b32_e32 v40, 0x80808000, v23
	v_add_u32_e32 v23, 0x7f7f7f78, v39
	v_and_b32_e32 v41, 0x80808080, v23
	v_and_b32_e32 v23, 0x7070707, v12
	v_lshrrev_b32_e32 v24, 4, v12
	v_and_b32_e32 v24, 0x7070707, v24
	v_perm_b32 v25, v41, v40, v23
	v_perm_b32 v23, v39, v38, v23
	v_and_or_b32 v23, v25, v27, v23
	v_perm_b32 v25, v41, v40, v24
	v_perm_b32 v24, v39, v38, v24
	v_and_or_b32 v12, v25, v12, v24
	v_perm_b32 v24, v12, v23, s0
	v_perm_b32 v25, v12, v23, s1
	v_mul_lo_u32 v23, v26, s2
	v_and_b32_e32 v12, 0x7070707, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[30:31], v[24:25], 0
	v_cmp_lt_i32_e32 vcc, 11, v22
	s_mov_b32 s2, -1
	s_mov_b32 s6, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[32:33], v[24:25], 0
	v_lshrrev_b32_e32 v32, 4, v13
	v_and_b32_e32 v32, 0x7070707, v32
	v_perm_b32 v33, v41, v40, v12
	v_perm_b32 v12, v39, v38, v12
	v_and_or_b32 v33, v33, v66, v12
	v_perm_b32 v12, v41, v40, v32
	v_perm_b32 v32, v39, v38, v32
	v_and_or_b32 v13, v12, v13, v32
	v_perm_b32 v12, v13, v33, s0
	v_perm_b32 v13, v13, v33, s1
	v_sub_u32_e32 v32, 0x6c686080, v23
	v_sub_u32_e32 v23, 0x7c787470, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[34:35], v[12:13], v[28:31]
	v_lshlrev_b32_e32 v34, 4, v14
	v_and_b32_e32 v32, 0xffffff00, v32
	v_cndmask_b32_e64 v32, v32, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[24:27], v[36:37], v[12:13], v[24:27]
	v_and_b32_e32 v12, 0x7070707, v14
	v_lshrrev_b32_e32 v13, 4, v14
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v33, v41, v40, v12
	v_perm_b32 v12, v39, v38, v12
	v_and_or_b32 v33, v33, v34, v12
	v_perm_b32 v12, v41, v40, v13
	v_perm_b32 v13, v39, v38, v13
	v_and_or_b32 v13, v12, v14, v13
	v_perm_b32 v12, v13, v33, s0
	v_perm_b32 v13, v13, v33, s1
	v_cndmask_b32_e64 v33, v23, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[42:43], v[12:13], v[28:31]
	v_cmp_lt_u32_e32 vcc, 5, v21
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[44:45], v[12:13], v[24:27]
	v_and_b32_e32 v12, 0x7070707, v15
	v_lshrrev_b32_e32 v13, 4, v15
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v14, v41, v40, v12
	v_lshlrev_b32_e32 v26, 4, v15
	v_perm_b32 v12, v39, v38, v12
	v_and_or_b32 v12, v14, v26, v12
	v_perm_b32 v14, v41, v40, v13
	v_perm_b32 v13, v39, v38, v13
	v_and_or_b32 v13, v14, v15, v13
	v_perm_b32 v26, v13, v12, s0
	v_perm_b32 v27, v13, v12, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[50:51], v[26:27], v[28:31]
	s_nop 2
	v_add_u32_e32 v29, 0x7f7f7f78, v33
	v_and_b32_e32 v28, 0x80808000, v34
	v_and_b32_e32 v29, 0x80808080, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[52:53], v[26:27], v[22:25]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v26, 0x7070707, v4
	v_lshrrev_b32_e32 v27, 4, v4
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v30, v29, v28, v26
	v_lshlrev_b32_e32 v31, 4, v4
	v_perm_b32 v26, v33, v32, v26
	v_and_or_b32 v30, v30, v31, v26
	v_perm_b32 v26, v29, v28, v27
	v_perm_b32 v27, v33, v32, v27
	v_and_or_b32 v4, v26, v4, v27
	v_perm_b32 v26, v4, v30, s0
	v_perm_b32 v27, v4, v30, s1
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshlrev_b32_e32 v30, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[46:47], v[26:27], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[48:49], v[26:27], v[22:25]
	v_lshrrev_b32_e32 v26, 4, v5
	v_and_b32_e32 v26, 0x7070707, v26
	v_perm_b32 v27, v29, v28, v4
	v_perm_b32 v4, v33, v32, v4
	v_and_or_b32 v27, v27, v30, v4
	v_perm_b32 v4, v29, v28, v26
	v_perm_b32 v26, v33, v32, v26
	v_and_or_b32 v5, v4, v5, v26
	v_perm_b32 v4, v5, v27, s0
	v_perm_b32 v5, v5, v27, s1
	v_lshlrev_b32_e32 v27, 4, v6
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[54:55], v[4:5], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[56:57], v[4:5], v[22:25]
	v_and_b32_e32 v4, 0x7070707, v6
	v_lshrrev_b32_e32 v5, 4, v6
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v26, v29, v28, v4
	v_perm_b32 v4, v33, v32, v4
	v_and_or_b32 v26, v26, v27, v4
	v_perm_b32 v4, v29, v28, v5
	v_perm_b32 v5, v33, v32, v5
	v_and_or_b32 v5, v4, v6, v5
	v_perm_b32 v4, v5, v26, s0
	v_perm_b32 v5, v5, v26, s1
	v_lshlrev_b32_e32 v26, 4, v7
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[58:59], v[4:5], v[12:15]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[60:61], v[4:5], v[22:25]
	v_and_b32_e32 v4, 0x7070707, v7
	v_lshrrev_b32_e32 v5, 4, v7
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v6, v29, v28, v4
	v_perm_b32 v4, v33, v32, v4
	v_and_or_b32 v6, v6, v26, v4
	v_perm_b32 v4, v29, v28, v5
	v_perm_b32 v5, v33, v32, v5
	v_and_or_b32 v5, v4, v7, v5
	v_perm_b32 v4, v5, v6, s0
	v_perm_b32 v5, v5, v6, s1
	v_lshlrev_b32_e32 v6, 2, v17
	v_or_b32_e32 v7, s30, v6
	s_and_b32 s1, s15, 0xffff
	s_mov_b32 s0, s14
	v_lshlrev_b32_e32 v7, 2, v7
	buffer_load_dwordx4 v[30:33], v7, s[0:3], 0 offen
	buffer_load_dwordx4 v[34:37], v7, s[4:7], 0 offen
	v_or_b32_e32 v6, s8, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[62:63], v[4:5], v[12:15]
	v_lshlrev_b32_e32 v6, 2, v6
	buffer_load_dwordx4 v[38:41], v6, s[0:3], 0 offen
	v_or_b32_e32 v6, 64, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[64:65], v[4:5], v[22:25]
	v_mov_b32_e32 v4, 0xfd800000
	v_lshl_add_u32 v5, v21, 23, v4
	v_lshlrev_b32_e64 v12, v21, s9
	v_cndmask_b32_e32 v14, v12, v5, vcc
	v_or_b32_e32 v12, 0x44, v7
	v_or_b32_e32 v13, 0x48, v7
	buffer_load_dword v42, v6, s[4:7], 0 offen
	buffer_load_dword v43, v12, s[4:7], 0 offen
	buffer_load_dword v44, v13, s[4:7], 0 offen
	v_or_b32_e32 v6, 0x4c, v7
	buffer_load_dword v45, v6, s[4:7], 0 offen
	v_lshl_add_u32 v4, v20, 23, v4
	v_lshlrev_b32_e64 v5, v20, s9
	v_cmp_lt_u32_e32 vcc, 5, v20
	s_and_b32 s1, s25, 0xffff
	s_mov_b32 s0, s24
	v_cndmask_b32_e32 v20, v5, v4, vcc
	v_or_b32_e32 v5, s30, v16
	v_lshlrev_b32_e32 v13, 2, v5
	v_or_b32_e32 v5, s8, v16
	v_lshlrev_b32_e32 v15, 2, v5
	buffer_load_dword v12, v13, s[0:3], 0 offen
	buffer_load_dword v7, v13, s[0:3], 0 offen offset:32
	buffer_load_dword v6, v15, s[0:3], 0 offen
	buffer_load_dword v5, v13, s[0:3], 0 offen offset:96
	s_movk_i32 s0, 0x7fff
	v_and_b32_e32 v4, 62, v18
	s_waitcnt vmcnt(10)
	v_pk_mul_f32 v[48:49], v[14:15], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[48:49]
	v_pk_mul_f32 v[46:47], v[14:15], v[30:31] op_sel_hi:[0,1]
	s_waitcnt vmcnt(9)
	v_pk_mul_f32 v[10:11], v[10:11], v[36:37]
	v_pk_mul_f32 v[8:9], v[8:9], v[46:47]
	v_bfe_u32 v13, v11, 16, 1
	v_add3_u32 v13, v13, v11, s0
	v_or_b32_e32 v15, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_pk_mul_f32 v[8:9], v[8:9], v[34:35]
	s_nop 0
	v_cndmask_b32_e32 v11, v13, v15, vcc
	v_bfe_u32 v13, v10, 16, 1
	v_add3_u32 v13, v13, v10, s0
	v_or_b32_e32 v15, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v13, v15, vcc
	v_bfe_u32 v13, v9, 16, 1
	v_add3_u32 v13, v13, v9, s0
	v_or_b32_e32 v15, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v13, v15, vcc
	v_bfe_u32 v13, v8, 16, 1
	v_add3_u32 v13, v13, v8, s0
	v_or_b32_e32 v15, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v13, v15, vcc
	v_lshl_add_u32 v13, v17, 10, v19
	ds_write_b16_d16_hi v13, v8
	ds_write_b16_d16_hi v13, v9 offset:256
	ds_write_b16_d16_hi v13, v10 offset:512
	ds_write_b16_d16_hi v13, v11 offset:768
	v_pk_mul_f32 v[10:11], v[20:21], v[32:33] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[28:29], v[10:11]
	v_pk_mul_f32 v[8:9], v[20:21], v[30:31] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[10:11], v[36:37]
	v_pk_mul_f32 v[8:9], v[26:27], v[8:9]
	v_bfe_u32 v15, v11, 16, 1
	v_add3_u32 v15, v15, v11, s0
	v_or_b32_e32 v17, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_pk_mul_f32 v[8:9], v[8:9], v[34:35]
	s_nop 0
	v_cndmask_b32_e32 v11, v15, v17, vcc
	v_bfe_u32 v15, v10, 16, 1
	v_add3_u32 v15, v15, v10, s0
	v_or_b32_e32 v17, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v15, v17, vcc
	v_bfe_u32 v15, v9, 16, 1
	v_add3_u32 v15, v15, v9, s0
	v_or_b32_e32 v17, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v15, v17, vcc
	v_bfe_u32 v15, v8, 16, 1
	v_add3_u32 v15, v15, v8, s0
	v_or_b32_e32 v17, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v15, v17, vcc
	ds_write_b16_d16_hi v13, v8 offset:32
	ds_write_b16_d16_hi v13, v9 offset:288
	ds_write_b16_d16_hi v13, v10 offset:544
	ds_write_b16_d16_hi v13, v11 offset:800
	s_waitcnt vmcnt(8)
	v_pk_mul_f32 v[10:11], v[14:15], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	v_pk_mul_f32 v[8:9], v[14:15], v[38:39] op_sel_hi:[0,1]
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[2:3], v[2:3], v[44:45]
	v_pk_mul_f32 v[0:1], v[0:1], v[8:9]
	v_bfe_u32 v8, v3, 16, 1
	v_add3_u32 v8, v8, v3, s0
	v_or_b32_e32 v9, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[42:43]
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
	v_pk_mul_f32 v[2:3], v[20:21], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[24:25], v[2:3]
	v_pk_mul_f32 v[0:1], v[20:21], v[38:39] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[2:3], v[44:45]
	v_pk_mul_f32 v[0:1], v[22:23], v[0:1]
	v_bfe_u32 v8, v3, 16, 1
	v_add3_u32 v8, v8, v3, s0
	v_or_b32_e32 v9, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_pk_mul_f32 v[0:1], v[0:1], v[42:43]
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
	v_cmp_gt_u32_e32 vcc, s35, v0
	v_lshlrev_b32_e32 v0, 1, v4
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_7
	v_lshl_or_b32 v8, v16, 8, v0
	v_lshl_add_u32 v1, v12, 12, s33
	ds_read_b32 v9, v8
	v_or_b32_e32 v1, v1, v4
	v_lshlrev_b32_e32 v2, 1, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[28:29], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v9, off
	ds_read_b32 v1, v8 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v1, off offset:128
.LBB0_7:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v1, 0xffffff, v7
	v_cmp_gt_u32_e32 vcc, s35, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshl_or_b32 v2, v16, 8, v0
	v_lshl_add_u32 v1, v7, 12, s33
	ds_read_b32 v3, v2 offset:2048
	v_or_b32_e32 v0, v1, v4
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[28:29], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off
	ds_read_b32 v2, v2 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_9:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v0, 0xffffff, v6
	v_or_b32_e32 v1, 16, v16
	v_cmp_gt_u32_e64 s[0:1], s35, v0
	s_mov_b32 s36, 24
	v_mov_b32_e32 v2, v16
.LBB0_10:
	v_lshlrev_b32_e32 v3, 1, v4
	s_and_saveexec_b64 s[2:3], s[0:1]
	s_xor_b64 s[0:1], exec, s[2:3]
	s_cbranch_execz .LBB0_12
	v_lshl_add_u32 v6, v1, 8, v3
	v_lshl_add_u32 v0, v0, 12, s33
	ds_read_b32 v7, v6
	v_or_b32_e32 v0, v0, v4
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[28:29], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v7, off
	ds_read_b32 v6, v6 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v6, off offset:128
.LBB0_12:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v0, 0xffffff, v5
	v_cmp_gt_i32_e32 vcc, s35, v0
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_14
	v_add_u32_e32 v0, s36, v2
	v_lshl_add_u32 v6, v0, 8, v3
	ds_read_b32 v7, v6
	v_lshl_add_u32 v0, v5, 12, s33
	v_add_lshl_u32 v0, v0, v4, 1
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[2:3], s[28:29], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v7, off
	ds_read_b32 v2, v6 offset:128
	v_add_u32_e32 v0, 0x80, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[28:29], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off
.LBB0_14:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn, .Lfunc_end0-a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
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
		.amdhsa_next_free_vgpr 72
		.amdhsa_next_free_sgpr 38
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

	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.num_vgpr, 72
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.num_agpr, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.numbered_sgpr, 38
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.num_named_barrier, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.private_seg_size, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.uses_vcc, 1
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.uses_flat_scratch, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.has_dyn_sized_stack, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.has_recursion, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.has_indirect_call, 0
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
    .name:           a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     44
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dyn.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     72
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
