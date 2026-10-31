	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz
	.p2align	8
	.type	gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz,@function
gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz:
	s_load_dwordx4 s[12:15], s[0:1], 0x20
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[12:13], 0x0
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
	s_lshl_b32 s12, s3, 5
	s_cmp_ge_i32 s2, s12
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_17
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
	s_lshl_b32 s24, s12, 6
	s_lshl_b32 s12, s2, 7
	s_and_b32 s13, s3, 0x7fffffe0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s10, 12
	s_add_i32 s3, s12, s13
	s_add_i32 s20, s3, s2
	v_and_b32_e32 v2, 48, v0
	v_and_b32_e32 v70, 15, v0
	s_and_b32 s17, s7, 0xffff
	s_lshl_b32 s7, s20, 1
	s_mov_b32 s19, 0x27000
	v_or3_b32 v8, s7, v2, v70
	s_and_b32 s9, s9, 0xffff
	s_mov_b32 s10, 0x800000
	s_mov_b32 s11, s19
	v_lshlrev_b32_e32 v8, 2, v8
	buffer_load_dword v68, v8, s[8:11], 0 offen
	v_lshlrev_b32_e32 v3, 4, v0
	v_lshrrev_b32_e32 v1, 4, v0
	v_xor_b32_e32 v8, v3, v0
	v_or_b32_e32 v4, s24, v1
	s_or_b32 s27, s24, 16
	s_or_b32 s26, s24, 32
	v_and_b32_e32 v8, 0xf0, v8
	s_mov_b32 s16, s6
	v_or_b32_e32 v5, s27, v1
	v_or_b32_e32 v6, s26, v1
	s_or_b32 s25, s24, 48
	s_and_b32 s5, s5, 0xffff
	s_mov_b32 s6, -1
	s_mov_b32 s7, s19
	v_lshl_or_b32 v4, v4, 8, v8
	v_or_b32_e32 v7, s25, v1
	v_lshl_or_b32 v5, v5, 8, v8
	buffer_load_dwordx4 v[16:19], v4, s[4:7], 0 offen nt
	buffer_load_dwordx4 v[20:23], v5, s[4:7], 0 offen nt
	v_lshl_or_b32 v4, v6, 8, v8
	v_lshl_or_b32 v5, v7, 8, v8
	buffer_load_dwordx4 v[24:27], v4, s[4:7], 0 offen nt
	buffer_load_dwordx4 v[28:31], v5, s[4:7], 0 offen nt
	v_or_b32_e32 v4, s3, v70
	v_add_u32_e32 v4, s2, v4
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshrrev_b32_e32 v5, 28, v5
	v_add_u32_e32 v6, v4, v5
	v_ashrrev_i32_e32 v7, 4, v6
	v_and_b32_e32 v6, -16, v6
	v_cmp_ne_u32_e32 vcc, v4, v6
	v_cmp_gt_i32_e64 s[2:3], 0, v4
	v_bfe_u32 v71, v0, 4, 2
	s_and_b64 vcc, s[2:3], vcc
	v_subbrev_co_u32_e32 v7, vcc, 0, v7, vcc
	v_lshlrev_b32_e32 v14, 8, v71
	v_sub_u32_e32 v6, v4, v6
	v_lshl_or_b32 v7, v7, 11, v14
	s_brev_b32 s18, 16
	v_lshl_add_u32 v6, v6, 4, v7
	buffer_load_dwordx4 v[10:13], v6, s[16:19], 0 offen nt
	s_ashr_i32 s4, s20, 31
	s_lshr_b32 s2, s4, 27
	s_or_b32 s2, s2, s20
	s_add_i32 s5, s2, 16
	s_lshr_b32 s5, s5, 5
	s_add_i32 s5, s5, s4
	s_lshl_b32 s4, s5, 6
	v_and_b32_e32 v7, 63, v0
	v_or_b32_e32 v4, 16, v4
	v_or3_b32 v2, s4, v2, v70
	v_lshlrev_b32_e32 v7, 2, v7
	v_add_u32_e32 v5, v4, v5
	v_lshlrev_b32_e32 v2, 2, v2
	v_xor_b32_e32 v102, 0x80, v7
	v_ashrrev_i32_e32 v7, 4, v5
	v_and_b32_e32 v5, -16, v5
	buffer_load_dword v104, v2, s[8:11], 0 offen
	v_cmp_gt_i32_e32 vcc, 0, v4
	v_cmp_ne_u32_e64 s[2:3], v4, v5
	v_sub_u32_e32 v4, v4, v5
	s_and_b64 vcc, vcc, s[2:3]
	v_subbrev_co_u32_e32 v15, vcc, 0, v7, vcc
	buffer_load_dwordx4 v[6:9], v6, s[16:19], 0 offen offset:1024 nt
	v_and_b32_e32 v3, 0xf0, v3
	v_lshl_or_b32 v3, v1, 8, v3
	s_mov_b32 s5, 0x8080808
	s_mov_b32 s4, 0x80808080
	v_lshlrev_b32_e32 v73, 5, v71
	s_waitcnt vmcnt(6)
	ds_write_b128 v3, v[16:19]
	s_waitcnt vmcnt(5)
	ds_write_b128 v3, v[20:23] offset:4096
	s_waitcnt vmcnt(4)
	ds_write_b128 v3, v[24:27] offset:8192
	s_waitcnt vmcnt(3)
	ds_write_b128 v3, v[28:31] offset:12288
	v_max_u32_sdwa v2, v68, v68 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	ds_swizzle_b32 v5, v2 offset:swizzle(SWAP,16)
	v_lshlrev_b32_e32 v103, 4, v70
	v_lshlrev_b32_e32 v105, 8, v70
	s_mov_b32 s2, 0x5010400
	s_mov_b32 s3, 0x7030602
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v2, v5, v2
	ds_bpermute_b32 v5, v102, v2
	s_load_dwordx4 s[8:11], s[0:1], 0x40
	v_lshlrev_b32_e32 v1, 11, v1
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v72, v5, v2
	v_lshl_or_b32 v2, v15, 11, v14
	v_lshl_add_u32 v18, v4, 4, v2
	buffer_load_dwordx4 v[14:17], v18, s[16:19], 0 offen nt
	buffer_load_dwordx4 v[2:5], v18, s[16:19], 0 offen offset:1024 nt
	v_sub_u32_sdwa v18, v72, v68 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s5
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_cmp_lt_i32_e32 vcc, 11, v18
	s_waitcnt vmcnt(4)
	v_and_b32_e32 v18, 0x7070707, v10
	v_cndmask_b32_e64 v58, v20, 0, vcc
	v_cndmask_b32_e64 v59, v19, 0, vcc
	v_perm_b32 v18, v59, v58, v18
	v_lshlrev_b32_e32 v20, 4, v10
	v_and_or_b32 v20, v20, s4, v18
	v_add_u32_e32 v18, 0x7f7f7f7f, v18
	v_or_b32_e32 v18, 0x7f7f7f7f, v18
	v_and_b32_e32 v18, v18, v20
	v_xor_b32_e32 v20, v73, v103
	v_or_b32_e32 v26, v105, v20
	s_barrier
	ds_read2st64_b64 v[30:33], v26 offset1:8
	ds_read2st64_b64 v[34:37], v26 offset0:16 offset1:24
	v_lshrrev_b32_e32 v19, 4, v10
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v19, v59, v58, v19
	v_and_or_b32 v10, v10, s4, v19
	v_add_u32_e32 v19, 0x7f7f7f7f, v19
	v_or_b32_e32 v19, 0x7f7f7f7f, v19
	v_and_b32_e32 v10, v19, v10
	v_perm_b32 v38, v10, v18, s2
	v_perm_b32 v39, v10, v18, s3
	v_and_b32_e32 v10, 0x7070707, v11
	v_perm_b32 v10, v59, v58, v10
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[30:31], v[38:39], 0
	v_sub_u32_sdwa v68, v72, v68 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cmp_lt_i32_e32 vcc, 11, v68
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[32:33], v[38:39], 0
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[34:35], v[38:39], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[36:37], v[38:39], 0
	v_lshrrev_b32_e32 v38, 4, v11
	v_and_b32_e32 v38, 0x7070707, v38
	v_perm_b32 v42, v59, v58, v38
	v_lshlrev_b32_e32 v38, 4, v11
	v_and_or_b32 v43, v38, s4, v10
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_or_b32_e32 v38, 8, v73
	v_and_b32_e32 v43, v10, v43
	v_and_or_b32 v10, v11, s4, v42
	v_add_u32_e32 v11, 0x7f7f7f7f, v42
	v_xor_b32_e32 v38, v38, v103
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v44, v105, v38
	v_and_b32_e32 v11, v11, v10
	ds_read2st64_b64 v[38:41], v44 offset1:8
	v_perm_b32 v10, v11, v43, s2
	v_perm_b32 v11, v11, v43, s3
	ds_read2st64_b64 v[42:45], v44 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[38:39], v[10:11], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[40:41], v[10:11], v[22:25]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[42:43], v[10:11], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[44:45], v[10:11], v[46:49]
	v_and_b32_e32 v10, 0x7070707, v12
	v_perm_b32 v10, v59, v58, v10
	v_lshrrev_b32_e32 v11, 4, v12
	v_lshlrev_b32_e32 v46, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_and_or_b32 v54, v46, s4, v10
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	v_perm_b32 v11, v59, v58, v11
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_or_b32_e32 v46, 16, v73
	v_and_b32_e32 v54, v10, v54
	v_and_or_b32 v10, v12, s4, v11
	v_add_u32_e32 v11, 0x7f7f7f7f, v11
	v_xor_b32_e32 v46, v46, v103
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v55, v105, v46
	v_and_b32_e32 v11, v11, v10
	ds_read2st64_b64 v[46:49], v55 offset1:8
	v_perm_b32 v10, v11, v54, s2
	v_perm_b32 v11, v11, v54, s3
	ds_read2st64_b64 v[54:57], v55 offset0:16 offset1:24
	v_lshlrev_b32_e32 v12, 4, v13
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[46:47], v[10:11], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[48:49], v[10:11], v[22:25]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[54:55], v[10:11], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[56:57], v[10:11], v[50:53]
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v10, 0x7070707, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v10, v59, v58, v10
	v_perm_b32 v11, v59, v58, v11
	v_or_b32_e32 v58, 24, v73
	v_xor_b32_e32 v58, v58, v103
	v_or_b32_e32 v62, v105, v58
	ds_read2st64_b64 v[58:61], v62 offset1:8
	v_and_or_b32 v12, v12, s4, v10
	v_add_u32_e32 v10, 0x7f7f7f7f, v10
	ds_read2st64_b64 v[62:65], v62 offset0:16 offset1:24
	v_or_b32_e32 v10, 0x7f7f7f7f, v10
	v_and_b32_e32 v10, v10, v12
	v_and_or_b32 v12, v13, s4, v11
	v_add_u32_e32 v11, 0x7f7f7f7f, v11
	v_or_b32_e32 v11, 0x7f7f7f7f, v11
	v_and_b32_e32 v11, v11, v12
	v_perm_b32 v66, v11, v10, s2
	v_perm_b32 v67, v11, v10, s3
	s_waitcnt lgkmcnt(1)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[58:59], v[66:67], v[18:21]
	s_nop 2
	v_min_i32_e32 v18, 11, v68
	v_mul_lo_u32 v69, v18, s5
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[60:61], v[66:67], v[22:25]
	s_nop 2
	v_sub_u32_e32 v22, 0x6c686080, v69
	v_and_b32_e32 v74, 0xffffff00, v22
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[62:63], v[66:67], v[26:29]
	v_sub_u32_e32 v69, 0x7c787470, v69
	v_cndmask_b32_e64 v106, v74, 0, vcc
	v_cndmask_b32_e64 v107, v69, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[64:65], v[66:67], v[50:53]
	s_nop 2
	v_or_b32_e32 v53, 0x80, v73
	v_xor_b32_e32 v53, v53, v103
	v_or_b32_e32 v53, v105, v53
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v50, 0x7070707, v6
	ds_read2st64_b64 v[66:69], v53 offset1:8
	ds_read2st64_b64 v[74:77], v53 offset0:16 offset1:24
	v_perm_b32 v50, v107, v106, v50
	v_lshrrev_b32_e32 v51, 4, v6
	v_lshlrev_b32_e32 v52, 4, v6
	v_and_b32_e32 v51, 0x7070707, v51
	v_and_or_b32 v52, v52, s4, v50
	v_add_u32_e32 v50, 0x7f7f7f7f, v50
	v_perm_b32 v51, v107, v106, v51
	v_or_b32_e32 v50, 0x7f7f7f7f, v50
	v_and_b32_e32 v52, v50, v52
	v_add_u32_e32 v50, 0x7f7f7f7f, v51
	v_and_or_b32 v6, v6, s4, v51
	v_or_b32_e32 v50, 0x7f7f7f7f, v50
	v_and_b32_e32 v6, v50, v6
	v_perm_b32 v50, v6, v52, s2
	v_perm_b32 v51, v6, v52, s3
	v_or_b32_e32 v52, 0x88, v73
	v_and_b32_e32 v6, 0x7070707, v7
	v_xor_b32_e32 v52, v52, v103
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[66:67], v[50:51], v[10:13]
	v_perm_b32 v6, v107, v106, v6
	v_or_b32_e32 v52, v105, v52
	ds_read2st64_b64 v[78:81], v52 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[68:69], v[50:51], v[18:21]
	ds_read2st64_b64 v[82:85], v52 offset0:16 offset1:24
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[74:75], v[50:51], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[76:77], v[50:51], v[26:29]
	v_lshrrev_b32_e32 v50, 4, v7
	v_lshlrev_b32_e32 v51, 4, v7
	v_and_b32_e32 v50, 0x7070707, v50
	v_and_or_b32 v51, v51, s4, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v50, v107, v106, v50
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v51, v6, v51
	v_and_or_b32 v6, v7, s4, v50
	v_add_u32_e32 v7, 0x7f7f7f7f, v50
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v51, s2
	v_perm_b32 v7, v7, v51, s3
	v_or_b32_e32 v51, 0x90, v73
	v_xor_b32_e32 v51, v51, v103
	v_or_b32_e32 v51, v105, v51
	ds_read2st64_b64 v[86:89], v51 offset1:8
	ds_read2st64_b64 v[90:93], v51 offset0:16 offset1:24
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[78:79], v[6:7], v[10:13]
	v_lshlrev_b32_e32 v50, 4, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[80:81], v[6:7], v[18:21]
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[82:83], v[6:7], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[84:85], v[6:7], v[26:29]
	v_and_b32_e32 v6, 0x7070707, v8
	v_perm_b32 v6, v107, v106, v6
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v50, v50, s4, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v7, v107, v106, v7
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v50, v6, v50
	v_and_or_b32 v6, v8, s4, v7
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v50, s2
	v_perm_b32 v7, v7, v50, s3
	v_lshlrev_b32_e32 v8, 4, v9
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[86:87], v[6:7], v[10:13]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[88:89], v[6:7], v[18:21]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[90:91], v[6:7], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[92:93], v[6:7], v[26:29]
	v_and_b32_e32 v6, 0x7070707, v9
	v_perm_b32 v6, v107, v106, v6
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_and_or_b32 v8, v8, s4, v6
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_perm_b32 v7, v107, v106, v7
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v8, v6, v8
	v_and_or_b32 v6, v9, s4, v7
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v6
	v_perm_b32 v6, v7, v8, s2
	v_perm_b32 v7, v7, v8, s3
	v_max_u32_sdwa v8, v104, v104 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_3 src1_sel:BYTE_1
	v_or_b32_e32 v22, 0x98, v73
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,16)
	v_xor_b32_e32 v22, v22, v103
	v_or_b32_e32 v26, v105, v22
	ds_read2st64_b64 v[50:53], v26 offset1:8
	ds_read2st64_b64 v[26:29], v26 offset0:16 offset1:24
	s_waitcnt lgkmcnt(2)
	v_max_i32_e32 v8, v9, v8
	ds_bpermute_b32 v9, v102, v8
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[50:51], v[6:7], v[10:13]
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v73, v9, v8
	s_barrier
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[26:27], v[6:7], v[94:97]
	s_nop 2
	v_sub_u32_sdwa v94, v73, v104 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_1
	v_min_i32_e32 v95, 11, v94
	v_mul_lo_u32 v95, v95, s5
	v_sub_u32_e32 v96, 0x6c686080, v95
	v_sub_u32_e32 v95, 0x7c787470, v95
	v_cmp_lt_i32_e32 vcc, 11, v94
	v_and_b32_e32 v96, 0xffffff00, v96
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v94, 0x7070707, v14
	v_cndmask_b32_e64 v106, v95, 0, vcc
	v_lshrrev_b32_e32 v95, 4, v14
	v_cndmask_b32_e64 v105, v96, 0, vcc
	v_and_b32_e32 v95, 0x7070707, v95
	v_perm_b32 v94, v106, v105, v94
	v_perm_b32 v95, v106, v105, v95
	v_lshlrev_b32_e32 v96, 4, v14
	v_and_or_b32 v96, v96, s4, v94
	v_add_u32_e32 v94, 0x7f7f7f7f, v94
	v_and_or_b32 v14, v14, s4, v95
	v_add_u32_e32 v95, 0x7f7f7f7f, v95
	v_or_b32_e32 v94, 0x7f7f7f7f, v94
	v_or_b32_e32 v95, 0x7f7f7f7f, v95
	v_and_b32_e32 v94, v94, v96
	v_and_b32_e32 v14, v95, v14
	v_perm_b32 v102, v14, v94, s2
	v_perm_b32 v103, v14, v94, s3
	v_and_b32_e32 v14, 0x7070707, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[52:53], v[6:7], v[18:21]
	v_perm_b32 v14, v106, v105, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[28:29], v[6:7], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[30:31], v[102:103], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[32:33], v[102:103], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[34:35], v[102:103], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[102:103], 0
	v_lshrrev_b32_e32 v102, 4, v15
	v_lshlrev_b32_e32 v103, 4, v15
	v_and_b32_e32 v102, 0x7070707, v102
	v_and_or_b32 v103, v103, s4, v14
	v_add_u32_e32 v14, 0x7f7f7f7f, v14
	v_perm_b32 v102, v106, v105, v102
	v_or_b32_e32 v14, 0x7f7f7f7f, v14
	v_and_b32_e32 v103, v14, v103
	v_and_or_b32 v14, v15, s4, v102
	v_add_u32_e32 v15, 0x7f7f7f7f, v102
	v_or_b32_e32 v15, 0x7f7f7f7f, v15
	v_and_b32_e32 v15, v15, v14
	v_perm_b32 v14, v15, v103, s2
	v_perm_b32 v15, v15, v103, s3
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[38:39], v[14:15], v[94:97]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[40:41], v[14:15], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[42:43], v[14:15], v[98:101]
	v_lshlrev_b32_e32 v42, 4, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[44:45], v[14:15], v[34:37]
	v_and_b32_e32 v14, 0x7070707, v16
	v_perm_b32 v14, v106, v105, v14
	v_lshrrev_b32_e32 v15, 4, v16
	v_and_b32_e32 v15, 0x7070707, v15
	v_and_or_b32 v42, v42, s4, v14
	v_add_u32_e32 v14, 0x7f7f7f7f, v14
	v_perm_b32 v15, v106, v105, v15
	v_or_b32_e32 v14, 0x7f7f7f7f, v14
	v_and_b32_e32 v42, v14, v42
	v_and_or_b32 v14, v16, s4, v15
	v_add_u32_e32 v15, 0x7f7f7f7f, v15
	v_or_b32_e32 v15, 0x7f7f7f7f, v15
	v_and_b32_e32 v15, v15, v14
	v_perm_b32 v14, v15, v42, s2
	v_perm_b32 v15, v15, v42, s3
	v_lshlrev_b32_e32 v16, 4, v17
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[46:47], v[14:15], v[94:97]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[48:49], v[14:15], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[54:55], v[14:15], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[56:57], v[14:15], v[34:37]
	v_and_b32_e32 v14, 0x7070707, v17
	v_perm_b32 v14, v106, v105, v14
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_and_or_b32 v16, v16, s4, v14
	v_add_u32_e32 v14, 0x7f7f7f7f, v14
	v_perm_b32 v15, v106, v105, v15
	v_or_b32_e32 v14, 0x7f7f7f7f, v14
	v_and_b32_e32 v14, v14, v16
	v_and_or_b32 v16, v17, s4, v15
	v_add_u32_e32 v15, 0x7f7f7f7f, v15
	v_or_b32_e32 v15, 0x7f7f7f7f, v15
	v_and_b32_e32 v15, v15, v16
	v_perm_b32 v46, v15, v14, s2
	v_perm_b32 v47, v15, v14, s3
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[58:59], v[46:47], v[42:45]
	s_nop 2
	v_sub_u32_sdwa v42, v73, v104 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_3
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s5
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_sub_u32_e32 v43, 0x7c787470, v43
	v_cmp_lt_i32_e32 vcc, 11, v42
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v42, 0x7070707, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[60:61], v[46:47], v[30:33]
	v_cndmask_b32_e64 v44, v44, 0, vcc
	v_cndmask_b32_e64 v45, v43, 0, vcc
	v_perm_b32 v42, v45, v44, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[62:63], v[46:47], v[38:41]
	v_lshrrev_b32_e32 v43, 4, v2
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v43, v45, v44, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[64:65], v[46:47], v[34:37]
	v_lshlrev_b32_e32 v46, 4, v2
	v_and_or_b32 v46, v46, s4, v42
	v_add_u32_e32 v42, 0x7f7f7f7f, v42
	v_or_b32_e32 v42, 0x7f7f7f7f, v42
	v_and_b32_e32 v46, v42, v46
	v_add_u32_e32 v42, 0x7f7f7f7f, v43
	v_and_or_b32 v2, v2, s4, v43
	v_or_b32_e32 v42, 0x7f7f7f7f, v42
	v_and_b32_e32 v2, v42, v2
	v_perm_b32 v42, v2, v46, s2
	v_perm_b32 v43, v2, v46, s3
	v_and_b32_e32 v2, 0x7070707, v3
	v_perm_b32 v2, v45, v44, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[66:67], v[42:43], v[14:17]
	s_and_b32 s5, s11, 0xffff
	v_cmp_lt_u32_e32 vcc, 5, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[68:69], v[42:43], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[74:75], v[42:43], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[76:77], v[42:43], v[34:37]
	v_lshrrev_b32_e32 v42, 4, v3
	v_lshlrev_b32_e32 v43, 4, v3
	v_and_b32_e32 v42, 0x7070707, v42
	v_and_or_b32 v43, v43, s4, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_perm_b32 v42, v45, v44, v42
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v43, v2, v43
	v_and_or_b32 v2, v3, s4, v42
	v_add_u32_e32 v3, 0x7f7f7f7f, v42
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v2
	v_perm_b32 v2, v3, v43, s2
	v_perm_b32 v3, v3, v43, s3
	v_lshlrev_b32_e32 v42, 4, v4
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[78:79], v[2:3], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[80:81], v[2:3], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[82:83], v[2:3], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[84:85], v[2:3], v[34:37]
	v_and_b32_e32 v2, 0x7070707, v4
	v_perm_b32 v2, v45, v44, v2
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_and_or_b32 v42, v42, s4, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_perm_b32 v3, v45, v44, v3
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v42, v2, v42
	v_and_or_b32 v2, v4, s4, v3
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v2
	v_perm_b32 v2, v3, v42, s2
	v_perm_b32 v3, v3, v42, s3
	v_lshlrev_b32_e32 v4, 4, v5
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[86:87], v[2:3], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[88:89], v[2:3], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[90:91], v[2:3], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[92:93], v[2:3], v[34:37]
	v_and_b32_e32 v2, 0x7070707, v5
	v_perm_b32 v2, v45, v44, v2
	v_lshrrev_b32_e32 v3, 4, v5
	v_and_b32_e32 v3, 0x7070707, v3
	v_and_or_b32 v4, v4, s4, v2
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_perm_b32 v3, v45, v44, v3
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v4, v2, v4
	v_and_or_b32 v2, v5, s4, v3
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_lshlrev_b32_e32 v5, 2, v71
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v42, s24, v5
	v_and_b32_e32 v3, v3, v2
	s_mov_b32 s4, s10
	v_lshlrev_b32_e32 v42, 2, v42
	v_perm_b32 v2, v3, v4, s2
	v_perm_b32 v3, v3, v4, s3
	v_or_b32_e32 v4, s27, v5
	buffer_load_dwordx4 v[42:45], v42, s[4:7], 0 offen
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dwordx4 v[54:57], v4, s[4:7], 0 offen
	v_or_b32_e32 v4, s26, v5
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dwordx4 v[58:61], v4, s[4:7], 0 offen
	v_or_b32_e32 v4, s25, v5
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dwordx4 v[62:65], v4, s[4:7], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[50:51], v[2:3], v[14:17]
	s_load_dwordx4 s[20:23], s[0:1], 0x30
	s_load_dword s2, s[0:1], 0x38
	s_mov_b32 s0, 0x20000
	v_lshlrev_b32_e64 v4, v72, s0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[52:53], v[2:3], v[30:33]
	s_and_b32 s5, s15, 0xffff
	s_mov_b32 s4, s14
	s_waitcnt lgkmcnt(0)
	s_and_b32 s21, s21, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[26:27], v[2:3], v[38:41]
	s_mov_b32 s22, s6
	s_mov_b32 s23, s19
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[28:29], v[2:3], v[34:37]
	v_mov_b32_e32 v2, 0xfd800000
	v_lshl_add_u32 v3, v72, 23, v2
	s_nop 0
	v_cndmask_b32_e32 v36, v4, v3, vcc
	v_lshrrev_b32_e32 v3, 5, v0
	v_or_b32_e32 v4, s27, v3
	v_lshl_add_u32 v35, v73, 23, v2
	v_or_b32_e32 v2, s24, v3
	v_lshlrev_b32_e32 v37, 2, v4
	v_or_b32_e32 v4, s26, v3
	v_lshlrev_b32_e32 v2, 2, v2
	v_lshlrev_b32_e32 v72, 2, v4
	v_or_b32_e32 v4, s25, v3
	v_lshlrev_b32_e32 v74, 2, v4
	buffer_load_dword v34, v2, s[4:7], 0 offen
	buffer_load_dword v33, v2, s[4:7], 0 offen offset:32
	buffer_load_dword v31, v37, s[4:7], 0 offen
	buffer_load_dword v29, v2, s[4:7], 0 offen offset:96
	buffer_load_dword v27, v72, s[4:7], 0 offen
	buffer_load_dword v17, v2, s[4:7], 0 offen offset:160
	buffer_load_dword v15, v74, s[4:7], 0 offen
	buffer_load_dword v5, v2, s[4:7], 0 offen offset:224
	buffer_load_dword v32, v2, s[20:23], 0 offen
	buffer_load_dword v30, v2, s[20:23], 0 offen offset:32
	buffer_load_dword v28, v37, s[20:23], 0 offen
	buffer_load_dword v26, v2, s[20:23], 0 offen offset:96
	buffer_load_dword v16, v72, s[20:23], 0 offen
	buffer_load_dword v14, v2, s[20:23], 0 offen offset:160
	buffer_load_dword v4, v74, s[20:23], 0 offen
	s_nop 0
	buffer_load_dword v2, v2, s[20:23], 0 offen offset:224
	v_lshlrev_b32_e64 v37, v73, s0
	v_cmp_lt_u32_e32 vcc, 5, v73
	v_lshlrev_b32_e32 v0, 1, v0
	v_and_b32_e32 v0, 62, v0
	v_cndmask_b32_e32 v72, v37, v35, vcc
	v_or_b32_e32 v35, s13, v70
	v_lshlrev_b32_e32 v35, 2, v35
	s_waitcnt vmcnt(19)
	v_pk_mul_f32 v[74:75], v[36:37], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[42:43], v[72:73], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[22:23], v[22:23], v[74:75]
	v_pk_mul_f32 v[74:75], v[36:37], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[42:43], v[46:47], v[42:43]
	v_pk_mul_f32 v[44:45], v[72:73], v[44:45] op_sel_hi:[0,1]
	s_waitcnt vmcnt(18)
	v_pk_mul_f32 v[46:47], v[36:37], v[54:55] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[48:49], v[44:45]
	v_pk_mul_f32 v[18:19], v[18:19], v[46:47]
	v_pk_mul_f32 v[46:47], v[36:37], v[56:57] op_sel_hi:[0,1]
	v_pk_mul_f32 v[48:49], v[72:73], v[56:57] op_sel_hi:[0,1]
	v_pk_mul_f32 v[20:21], v[20:21], v[46:47]
	v_pk_mul_f32 v[46:47], v[72:73], v[54:55] op_sel_hi:[0,1]
	v_pk_mul_f32 v[48:49], v[52:53], v[48:49]
	v_lshl_add_u32 v52, v71, 11, v35
	v_pk_mul_f32 v[24:25], v[24:25], v[74:75]
	v_pk_mul_f32 v[46:47], v[50:51], v[46:47]
	s_waitcnt vmcnt(17)
	v_pk_mul_f32 v[50:51], v[36:37], v[58:59] op_sel_hi:[0,1]
	ds_write2_b32 v52, v22, v42 offset1:16
	ds_write2_b32 v52, v23, v43 offset0:128 offset1:144
	v_add_u32_e32 v22, 0x400, v52
	v_pk_mul_f32 v[10:11], v[10:11], v[50:51]
	v_pk_mul_f32 v[50:51], v[36:37], v[60:61] op_sel_hi:[0,1]
	ds_write2_b32 v22, v24, v44 offset1:16
	ds_write2_b32 v22, v25, v45 offset0:128 offset1:144
	v_add_u32_e32 v22, 0x2000, v52
	v_pk_mul_f32 v[12:13], v[12:13], v[50:51]
	v_pk_mul_f32 v[50:51], v[72:73], v[58:59] op_sel_hi:[0,1]
	ds_write2_b32 v22, v18, v46 offset1:16
	ds_write2_b32 v22, v19, v47 offset0:128 offset1:144
	v_add_u32_e32 v18, 0x2400, v52
	v_pk_mul_f32 v[38:39], v[38:39], v[50:51]
	v_pk_mul_f32 v[50:51], v[72:73], v[60:61] op_sel_hi:[0,1]
	ds_write2_b32 v18, v20, v48 offset1:16
	ds_write2_b32 v18, v21, v49 offset0:128 offset1:144
	v_add_u32_e32 v18, 0x4000, v52
	v_pk_mul_f32 v[40:41], v[40:41], v[50:51]
	ds_write2_b32 v18, v10, v38 offset1:16
	ds_write2_b32 v18, v11, v39 offset0:128 offset1:144
	v_add_u32_e32 v10, 0x4400, v52
	s_waitcnt vmcnt(16)
	v_pk_mul_f32 v[50:51], v[36:37], v[62:63] op_sel_hi:[0,1]
	ds_write2_b32 v10, v12, v40 offset1:16
	ds_write2_b32 v10, v13, v41 offset0:128 offset1:144
	v_or_b32_e32 v10, 0x6000, v1
	v_pk_mul_f32 v[6:7], v[6:7], v[50:51]
	v_add_u32_e32 v10, v10, v35
	ds_write_b32 v10, v6
	v_or_b32_e32 v6, 0x6200, v1
	v_pk_mul_f32 v[36:37], v[36:37], v[64:65] op_sel_hi:[0,1]
	v_add_u32_e32 v6, v6, v35
	v_pk_mul_f32 v[8:9], v[8:9], v[36:37]
	v_pk_mul_f32 v[36:37], v[72:73], v[62:63] op_sel_hi:[0,1]
	ds_write_b32 v6, v7
	v_or_b32_e32 v7, 0x6400, v1
	v_or_b32_e32 v1, 0x6600, v1
	v_pk_mul_f32 v[36:37], v[66:67], v[36:37]
	v_pk_mul_f32 v[50:51], v[72:73], v[64:65] op_sel_hi:[0,1]
	v_add_u32_e32 v7, v7, v35
	v_add_u32_e32 v1, v1, v35
	v_pk_mul_f32 v[50:51], v[68:69], v[50:51]
	ds_write_b32 v7, v8
	ds_write_b32 v10, v36 offset:64
	ds_write_b32 v6, v37 offset:64
	ds_write_b32 v7, v50 offset:64
	ds_write2_b32 v1, v9, v51 offset1:16
	s_waitcnt vmcnt(15)
	v_and_b32_e32 v1, 0xffffff, v34
	v_cmp_gt_i32_e32 vcc, s2, v1
	v_lshlrev_b32_e32 v1, 2, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_3
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v34, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(7) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[32:33] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:256
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[32:33] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s3
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s3
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v8, v9, v8, s4
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_3:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(14)
	v_and_b32_e32 v6, 0xffffff, v33
	v_cmp_gt_i32_e32 vcc, s2, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_5
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8 offset:4096
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v33, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(6) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[30:31] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:4352
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[30:31] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s3
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s3
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v8, v9, v8, s4
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_5:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(13)
	v_and_b32_e32 v6, 0xffffff, v31
	v_cmp_gt_i32_e32 vcc, s2, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_7
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8 offset:8192
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v31, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(5) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[28:29] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:8448
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[28:29] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s3
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s3
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v8, v9, v8, s4
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_7:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(12)
	v_and_b32_e32 v6, 0xffffff, v29
	v_cmp_gt_i32_e32 vcc, s2, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8 offset:12288
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v29, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(4) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[26:27] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:12544
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[26:27] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s3
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s3
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v8, v9, v8, s4
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_9:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(11)
	v_and_b32_e32 v6, 0xffffff, v27
	v_cmp_gt_i32_e32 vcc, s2, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_11
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8 offset:16384
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v27, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(3) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[16:17] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:16640
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[16:17] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s3
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s3
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v8, v9, v8, s4
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_11:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(10)
	v_and_b32_e32 v6, 0xffffff, v17
	v_cmp_gt_i32_e32 vcc, s2, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_13
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8 offset:20480
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v17, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(2) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[14:15] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:20736
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[14:15] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v8, 16, 1
	v_add3_u32 v10, v10, v8, s3
	v_or_b32_e32 v11, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v10, v11, vcc
	v_bfe_u32 v10, v9, 16, 1
	v_add3_u32 v10, v10, v9, s3
	v_or_b32_e32 v11, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v10, v11, vcc
	v_perm_b32 v8, v9, v8, s4
	global_atomic_pk_add_bf16 v[6:7], v8, off offset:128
.LBB0_13:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(9)
	v_and_b32_e32 v6, 0xffffff, v15
	v_cmp_gt_i32_e32 vcc, s2, v6
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_15
	v_lshl_or_b32 v8, v3, 9, v1
	ds_read_b64 v[6:7], v8 offset:24576
	s_movk_i32 s3, 0x7fff
	v_lshl_add_u32 v9, v15, 12, s12
	v_or_b32_e32 v9, v9, v0
	s_mov_b32 s4, 0x7060302
	s_waitcnt vmcnt(1) lgkmcnt(0)
	v_pk_mul_f32 v[6:7], v[6:7], v[4:5] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v10, v6, 16, 1
	v_or_b32_e32 v11, 0x400000, v6
	v_add3_u32 v10, v10, v6, s3
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v10, v11, vcc
	v_bfe_u32 v10, v7, 16, 1
	v_add3_u32 v10, v10, v7, s3
	v_or_b32_e32 v11, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v10, v11, vcc
	v_perm_b32 v10, v7, v6, s4
	v_lshlrev_b32_e32 v6, 1, v9
	v_ashrrev_i32_e32 v7, 31, v6
	v_lshl_add_u64 v[6:7], s[8:9], 0, v[6:7]
	global_atomic_pk_add_bf16 v[6:7], v10, off
	ds_read_b64 v[8:9], v8 offset:24832
	s_waitcnt lgkmcnt(0)
	v_pk_mul_f32 v[8:9], v[8:9], v[4:5] op_sel_hi:[1,0]
	s_nop 0
	v_bfe_u32 v4, v8, 16, 1
	v_add3_u32 v4, v4, v8, s3
	v_or_b32_e32 v10, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	v_bfe_u32 v8, v9, 16, 1
	v_add3_u32 v8, v8, v9, s3
	v_cndmask_b32_e32 v4, v4, v10, vcc
	v_or_b32_e32 v10, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v8, v10, vcc
	v_perm_b32 v4, v8, v4, s4
	global_atomic_pk_add_bf16 v[6:7], v4, off offset:128
.LBB0_15:
	s_or_b64 exec, exec, s[0:1]
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v4, 0xffffff, v5
	v_cmp_gt_i32_e32 vcc, s2, v4
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_17
	v_lshl_or_b32 v3, v3, 9, v1
	ds_read_b64 v[6:7], v3 offset:28672
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
	ds_read_b64 v[4:5], v3 offset:28928
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
.LBB0_17:
	s_endpgm
.Lfunc_end0:
	.size	gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz, .Lfunc_end0-gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz
		.amdhsa_group_segment_fixed_size 32768
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
		.amdhsa_next_free_vgpr 169
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 108
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

	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.num_vgpr, 108
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.num_agpr, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.numbered_sgpr, 28
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.num_named_barrier, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.private_seg_size, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.uses_vcc, 1
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.uses_flat_scratch, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.has_dyn_sized_stack, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.has_recursion, 0
	.set .Lgemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.has_indirect_call, 0
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
    .group_segment_fixed_size: 32768
    .kernarg_segment_align: 8
    .kernarg_segment_size: 80
    .max_flat_workgroup_size: 256
    .name:           gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     34
    .sgpr_spill_count: 0
    .symbol:         gemm2_a8w4_port_ne256_h4096_i256_bm64_tn128_ftz.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     108
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
