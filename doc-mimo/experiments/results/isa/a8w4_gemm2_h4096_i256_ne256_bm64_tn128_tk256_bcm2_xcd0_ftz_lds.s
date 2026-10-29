	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds
	.p2align	8
	.type	a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds,@function
a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds:
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[14:15], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s14, s3, 31
	s_lshr_b32 s14, s14, 26
	s_add_i32 s14, s3, s14
	s_ashr_i32 s22, s14, 6
	s_andn2_b32 s14, s14, 63
	s_cmp_lg_u32 s3, s14
	s_cselect_b64 s[14:15], -1, 0
	s_cmp_lt_i32 s3, 0
	s_cselect_b64 s[20:21], -1, 0
	s_and_b64 s[14:15], s[20:21], s[14:15]
	s_subb_u32 s3, s22, 0
	s_lshl_b32 s14, s3, 5
	s_cmp_ge_i32 s2, s14
	v_readfirstlane_b32 s3, v0
	s_cbranch_scc1 .LBB0_17
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
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s12, 12
	s_add_i32 s30, s28, s4
	s_add_i32 s30, s30, s2
	v_lshlrev_b32_e32 v4, 4, v0
	v_lshrrev_b32_e32 v1, 4, v0
	v_and_b32_e32 v2, 48, v0
	v_and_b32_e32 v62, 15, v0
	s_lshl_b32 s29, s14, 6
	s_lshl_b32 s2, s30, 1
	v_xor_b32_e32 v6, v4, v0
	s_mov_b32 s15, 0x27000
	s_and_b32 s25, s11, 0xffff
	s_mov_b32 s24, s10
	s_and_b32 s21, s5, 0xffff
	v_or3_b32 v3, s2, v2, v62
	v_or_b32_e32 v5, s29, v1
	v_and_b32_e32 v6, 0xf0, v6
	s_or_b32 s10, s29, 16
	s_or_b32 s11, s29, 32
	s_or_b32 s5, s29, 48
	s_mov_b32 s26, 0x800000
	s_mov_b32 s27, s15
	s_mov_b32 s22, -1
	s_mov_b32 s23, s15
	v_lshl_or_b32 v5, v5, 8, v6
	v_or_b32_e32 v7, s10, v1
	v_or_b32_e32 v8, s11, v1
	v_or_b32_e32 v9, s5, v1
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshl_or_b32 v7, v7, 8, v6
	v_lshl_or_b32 v8, v8, 8, v6
	v_lshl_or_b32 v6, v9, 8, v6
	buffer_load_dwordx4 v[22:25], v5, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[28:31], v7, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[32:35], v8, s[20:23], 0 offen nt
	buffer_load_dwordx4 v[36:39], v6, s[20:23], 0 offen nt
	buffer_load_dword v65, v3, s[24:27], 0 offen
	s_lshl_b32 s2, s30, 3
	v_or3_b32 v3, s2, v2, v62
	s_and_b32 s13, s9, 0xffff
	s_brev_b32 s14, 16
	s_mov_b32 s12, s8
	v_lshlrev_b32_e32 v3, 4, v3
	buffer_load_dwordx4 v[6:9], v3, s[12:15], 0 offen nt
	s_ashr_i32 s9, s30, 4
	v_bfe_u32 v63, v0, 4, 2
	s_or_b32 s9, s9, 1
	v_and_b32_e32 v5, 63, v0
	v_and_b32_e32 v4, 0xf0, v4
	v_lshlrev_b32_e32 v98, 5, v63
	v_lshlrev_b32_e32 v100, 4, v62
	s_lshl_b32 s8, s9, 7
	v_lshlrev_b32_e32 v5, 2, v5
	v_lshlrev_b32_e32 v99, 8, v62
	v_lshl_or_b32 v10, v1, 8, v4
	v_xor_b32_e32 v4, v98, v100
	v_or3_b32 v11, s8, v2, v62
	v_or_b32_e32 v2, 0x400, v3
	v_xor_b32_e32 v102, 0x80, v5
	v_or_b32_e32 v26, v99, v4
	buffer_load_dwordx4 v[2:5], v2, s[12:15], 0 offen nt
	v_lshlrev_b32_e32 v11, 4, v11
	buffer_load_dwordx4 v[18:21], v11, s[12:15], 0 offen nt
	buffer_load_dwordx4 v[14:17], v11, s[12:15], 0 offen offset:1024 nt
	s_mov_b32 s3, 0x8080808
	s_mov_b32 s2, 0x5010400
	s_mov_b32 s8, 0x7030602
	v_or_b32_e32 v82, 0x90, v98
	v_xor_b32_e32 v82, v82, v100
	v_or_b32_e32 v87, v99, v82
	s_lshr_b32 s12, s30, 31
	s_add_i32 s12, s9, s12
	s_and_b32 s12, s12, -2
	s_sub_i32 s9, s9, s12
	s_lshl_b32 s9, s9, 3
	s_and_b32 s21, s7, 0xffff
	s_waitcnt vmcnt(8)
	ds_write_b128 v10, v[22:25]
	s_waitcnt vmcnt(7)
	ds_write_b128 v10, v[28:31] offset:4096
	s_waitcnt vmcnt(6)
	ds_write_b128 v10, v[32:35] offset:8192
	s_waitcnt vmcnt(5)
	ds_write_b128 v10, v[36:39] offset:12288
	s_waitcnt vmcnt(4)
	v_max_u32_sdwa v10, v65, v65 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:BYTE_2 src1_sel:BYTE_0
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_max_i32_e32 v10, v11, v10
	ds_bpermute_b32 v11, v102, v10
	s_waitcnt vmcnt(3)
	v_lshrrev_b32_e32 v13, 4, v6
	v_and_b32_e32 v12, 0x7070707, v6
	v_and_b32_e32 v13, 0x7070707, v13
	v_lshlrev_b32_e32 v27, 4, v6
	s_waitcnt lgkmcnt(0)
	v_max_i32_e32 v64, v11, v10
	v_sub_u32_sdwa v10, v64, v65 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v11, 11, v10
	v_mul_lo_u32 v11, v11, s3
	v_sub_u32_e32 v28, 0x6c686080, v11
	v_sub_u32_e32 v11, 0x7c787470, v11
	v_and_b32_e32 v28, 0xffffff00, v28
	v_cmp_lt_i32_e32 vcc, 11, v10
	ds_read2st64_b64 v[22:25], v26 offset1:8
	v_lshlrev_b32_e32 v45, 4, v7
	v_cndmask_b32_e64 v58, v28, 0, vcc
	v_cndmask_b32_e64 v59, v11, 0, vcc
	v_add_u32_e32 v10, 0x7f7f7f00, v58
	v_add_u32_e32 v11, 0x7f7f7f78, v59
	v_and_b32_e32 v60, 0x80808000, v10
	v_and_b32_e32 v61, 0x80808080, v11
	v_perm_b32 v28, v59, v58, v12
	v_perm_b32 v29, v59, v58, v13
	v_perm_b32 v10, v61, v60, v12
	v_perm_b32 v11, v61, v60, v13
	v_and_or_b32 v10, v10, v27, v28
	v_and_or_b32 v6, v11, v6, v29
	ds_read2st64_b64 v[26:29], v26 offset0:16 offset1:24
	v_perm_b32 v34, v6, v10, s2
	v_perm_b32 v35, v6, v10, s8
	v_and_b32_e32 v6, 0x7070707, v7
	v_perm_b32 v43, v61, v60, v6
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[22:23], v[34:35], 0
	v_perm_b32 v6, v59, v58, v6
	v_and_or_b32 v43, v43, v45, v6
	v_lshlrev_b32_e32 v52, 4, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[24:25], v[34:35], 0
	v_sub_u32_sdwa v72, v64, v65 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshlrev_b32_e32 v70, 4, v9
	v_cmp_lt_i32_e32 vcc, 11, v72
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[26:27], v[34:35], 0
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v81, 4, v3
	v_lshlrev_b32_e32 v88, 4, v4
	ds_read2st64_b64 v[82:85], v87 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[28:29], v[34:35], 0
	v_lshrrev_b32_e32 v34, 4, v7
	v_and_b32_e32 v42, 0x7070707, v34
	v_or_b32_e32 v34, 8, v98
	v_xor_b32_e32 v34, v34, v100
	v_perm_b32 v6, v61, v60, v42
	v_perm_b32 v42, v59, v58, v42
	v_or_b32_e32 v44, v99, v34
	v_and_or_b32 v7, v6, v7, v42
	ds_read2st64_b64 v[34:37], v44 offset1:8
	v_perm_b32 v6, v7, v43, s2
	v_perm_b32 v7, v7, v43, s8
	ds_read2st64_b64 v[42:45], v44 offset0:16 offset1:24
	v_bfe_u32 v107, v65, s9, 8
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[34:35], v[6:7], v[10:13]
	s_add_i32 s9, s9, 16
	v_bfe_u32 v65, v65, s9, 8
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v109, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[36:37], v[6:7], v[30:33]
	s_mov_b32 s20, s6
	s_and_b32 s13, s19, 0xffff
	s_mov_b32 s12, s18
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[42:43], v[6:7], v[38:41]
	s_mov_b32 s14, s22
	v_or_b32_e32 v62, s4, v62
	v_lshlrev_b32_e32 v62, 1, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[44:45], v[6:7], v[46:49]
	v_and_b32_e32 v6, 0x7070707, v8
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v50, v61, v60, v6
	v_or_b32_e32 v46, 16, v98
	v_perm_b32 v6, v59, v58, v6
	v_xor_b32_e32 v46, v46, v100
	v_and_or_b32 v50, v50, v52, v6
	v_perm_b32 v6, v61, v60, v7
	v_perm_b32 v7, v59, v58, v7
	v_or_b32_e32 v51, v99, v46
	v_and_or_b32 v7, v6, v8, v7
	ds_read2st64_b64 v[46:49], v51 offset1:8
	v_perm_b32 v6, v7, v50, s2
	v_perm_b32 v7, v7, v50, s8
	ds_read2st64_b64 v[50:53], v51 offset0:16 offset1:24
	v_min_i32_e32 v8, 11, v72
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[52:53], v[6:7], v[54:57]
	v_mul_lo_u32 v73, v8, s3
	v_lshlrev_b32_e32 v1, 10, v1
	s_nop 0
	v_or_b32_e32 v54, 24, v98
	v_xor_b32_e32 v54, v54, v100
	v_or_b32_e32 v74, v99, v54
	ds_read2st64_b64 v[54:57], v74 offset1:8
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[46:47], v[6:7], v[10:13]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[48:49], v[6:7], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[50:51], v[6:7], v[38:41]
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v61, v60, v6
	v_perm_b32 v6, v59, v58, v6
	v_and_or_b32 v6, v8, v70, v6
	v_perm_b32 v8, v61, v60, v7
	v_perm_b32 v7, v59, v58, v7
	ds_read2st64_b64 v[58:61], v74 offset0:16 offset1:24
	v_and_or_b32 v7, v8, v9, v7
	v_perm_b32 v70, v7, v6, s2
	v_perm_b32 v71, v7, v6, s8
	s_waitcnt lgkmcnt(1)
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[54:55], v[70:71], v[10:13]
	s_nop 2
	v_sub_u32_e32 v10, 0x6c686080, v73
	v_and_b32_e32 v74, 0xffffff00, v10
	v_sub_u32_e32 v73, 0x7c787470, v73
	v_cndmask_b32_e64 v103, v74, 0, vcc
	v_cndmask_b32_e64 v104, v73, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[56:57], v[70:71], v[30:33]
	v_add_u32_e32 v72, 0x7f7f7f00, v103
	v_and_b32_e32 v105, 0x80808000, v72
	v_lshlrev_b32_e32 v74, 4, v2
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[58:59], v[70:71], v[38:41]
	s_nop 2
	v_add_u32_e32 v38, 0x7f7f7f78, v104
	v_and_b32_e32 v106, 0x80808080, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[60:61], v[70:71], v[66:69]
	v_and_b32_e32 v70, 0x7070707, v2
	v_perm_b32 v72, v106, v105, v70
	v_perm_b32 v70, v104, v103, v70
	v_lshrrev_b32_e32 v66, 4, v2
	v_and_b32_e32 v71, 0x7070707, v66
	v_or_b32_e32 v66, 0x80, v98
	v_xor_b32_e32 v66, v66, v100
	v_and_or_b32 v70, v72, v74, v70
	v_perm_b32 v72, v106, v105, v71
	v_perm_b32 v71, v104, v103, v71
	v_or_b32_e32 v73, v99, v66
	v_and_or_b32 v2, v72, v2, v71
	ds_read2st64_b64 v[66:69], v73 offset1:8
	v_perm_b32 v74, v2, v70, s2
	v_perm_b32 v75, v2, v70, s8
	ds_read2st64_b64 v[70:73], v73 offset0:16 offset1:24
	v_and_b32_e32 v2, 0x7070707, v3
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[66:67], v[74:75], v[6:9]
	v_perm_b32 v79, v106, v105, v2
	v_perm_b32 v2, v104, v103, v2
	v_and_or_b32 v79, v79, v81, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[68:69], v[74:75], v[10:13]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[70:71], v[74:75], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[72:73], v[74:75], v[38:41]
	v_lshrrev_b32_e32 v74, 4, v3
	v_and_b32_e32 v78, 0x7070707, v74
	v_or_b32_e32 v74, 0x88, v98
	v_xor_b32_e32 v74, v74, v100
	v_perm_b32 v2, v106, v105, v78
	v_perm_b32 v78, v104, v103, v78
	v_or_b32_e32 v80, v99, v74
	v_and_or_b32 v3, v2, v3, v78
	ds_read2st64_b64 v[74:77], v80 offset1:8
	v_perm_b32 v2, v3, v79, s2
	v_perm_b32 v3, v3, v79, s8
	ds_read2st64_b64 v[78:81], v80 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[74:75], v[2:3], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[76:77], v[2:3], v[10:13]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[78:79], v[2:3], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[80:81], v[2:3], v[38:41]
	v_and_b32_e32 v2, 0x7070707, v4
	v_lshrrev_b32_e32 v3, 4, v4
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v86, v106, v105, v2
	v_perm_b32 v2, v104, v103, v2
	v_and_or_b32 v86, v86, v88, v2
	v_perm_b32 v2, v106, v105, v3
	v_perm_b32 v3, v104, v103, v3
	v_and_or_b32 v3, v2, v4, v3
	v_perm_b32 v2, v3, v86, s2
	v_perm_b32 v3, v3, v86, s8
	ds_read2st64_b64 v[86:89], v87 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[86:87], v[2:3], v[30:33]
	s_nop 2
	v_or_b32_e32 v30, 0x98, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[82:83], v[2:3], v[6:9]
	v_xor_b32_e32 v30, v30, v100
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[84:85], v[2:3], v[10:13]
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[88:89], v[2:3], v[38:41]
	v_and_b32_e32 v2, 0x7070707, v5
	v_lshrrev_b32_e32 v3, 4, v5
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v106, v105, v2
	v_or_b32_e32 v38, v99, v30
	v_lshlrev_b32_e32 v30, 4, v5
	v_perm_b32 v2, v104, v103, v2
	v_and_or_b32 v4, v4, v30, v2
	v_perm_b32 v2, v106, v105, v3
	v_perm_b32 v3, v104, v103, v3
	v_and_or_b32 v3, v2, v5, v3
	v_perm_b32 v2, v3, v4, s2
	v_perm_b32 v3, v3, v4, s8
	v_max_u32_e32 v4, v65, v107
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,16)
	ds_read2st64_b64 v[98:101], v38 offset1:8
	ds_read2st64_b64 v[38:41], v38 offset0:16 offset1:24
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[98:99], v[2:3], v[6:9]
	v_max_i32_e32 v4, v5, v4
	ds_bpermute_b32 v5, v102, v4
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[38:39], v[2:3], v[90:93]
	s_barrier
	v_max_i32_e32 v104, v5, v4
	s_nop 0
	v_sub_u32_e32 v90, v104, v107
	v_min_i32_e32 v91, 11, v90
	v_mul_lo_u32 v91, v91, s3
	v_sub_u32_e32 v92, 0x6c686080, v91
	v_and_b32_e32 v92, 0xffffff00, v92
	v_cmp_lt_i32_e32 vcc, 11, v90
	v_sub_u32_e32 v91, 0x7c787470, v91
	v_lshlrev_b32_e32 v93, 4, v18
	v_cndmask_b32_e64 v105, v92, 0, vcc
	v_cndmask_b32_e64 v106, v91, 0, vcc
	v_add_u32_e32 v90, 0x7f7f7f00, v105
	v_and_b32_e32 v107, 0x80808000, v90
	v_add_u32_e32 v90, 0x7f7f7f78, v106
	v_and_b32_e32 v108, 0x80808080, v90
	v_and_b32_e32 v90, 0x7070707, v18
	v_lshrrev_b32_e32 v91, 4, v18
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v108, v107, v90
	v_perm_b32 v90, v106, v105, v90
	v_and_or_b32 v90, v92, v93, v90
	v_perm_b32 v92, v108, v107, v91
	v_perm_b32 v91, v106, v105, v91
	v_and_or_b32 v18, v92, v18, v91
	v_perm_b32 v102, v18, v90, s2
	v_perm_b32 v103, v18, v90, s8
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[100:101], v[2:3], v[10:13]
	v_and_b32_e32 v18, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[40:41], v[2:3], v[94:97]
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[22:23], v[102:103], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[102:103], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[26:27], v[102:103], 0
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[102:103], 0
	v_lshrrev_b32_e32 v102, 4, v19
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v103, v108, v107, v18
	v_perm_b32 v18, v106, v105, v18
	v_and_or_b32 v103, v103, v109, v18
	v_perm_b32 v18, v108, v107, v102
	v_perm_b32 v102, v106, v105, v102
	v_and_or_b32 v19, v18, v19, v102
	v_perm_b32 v18, v19, v103, s2
	v_perm_b32 v19, v19, v103, s8
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[34:35], v[18:19], v[90:93]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[36:37], v[18:19], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[42:43], v[18:19], v[94:97]
	v_lshlrev_b32_e32 v43, 4, v20
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[44:45], v[18:19], v[26:29]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v42, v108, v107, v18
	v_perm_b32 v18, v106, v105, v18
	v_and_or_b32 v42, v42, v43, v18
	v_perm_b32 v18, v108, v107, v19
	v_perm_b32 v19, v106, v105, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v42, s2
	v_perm_b32 v19, v19, v42, s8
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[48:49], v[18:19], v[22:25]
	v_sub_u32_e32 v48, v104, v65
	v_min_i32_e32 v20, 11, v48
	v_mul_lo_u32 v49, v20, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[46:47], v[18:19], v[90:93]
	v_lshlrev_b32_e32 v46, 4, v21
	v_cmp_lt_i32_e32 vcc, 11, v48
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[50:51], v[18:19], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[52:53], v[18:19], v[26:29]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v108, v107, v18
	v_perm_b32 v18, v106, v105, v18
	v_and_or_b32 v18, v20, v46, v18
	v_perm_b32 v20, v108, v107, v19
	v_perm_b32 v19, v106, v105, v19
	v_and_or_b32 v19, v20, v21, v19
	v_perm_b32 v46, v19, v18, s2
	v_perm_b32 v47, v19, v18, s8
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[54:55], v[46:47], v[42:45]
	s_nop 2
	v_sub_u32_e32 v42, 0x6c686080, v49
	v_and_b32_e32 v42, 0xffffff00, v42
	v_sub_u32_e32 v43, 0x7c787470, v49
	v_cndmask_b32_e64 v44, v42, 0, vcc
	v_cndmask_b32_e64 v45, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v44
	v_and_b32_e32 v50, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v45
	v_and_b32_e32 v51, 0x80808080, v42
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v42, 0x7070707, v14
	v_lshrrev_b32_e32 v43, 4, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[56:57], v[46:47], v[22:25]
	v_and_b32_e32 v43, 0x7070707, v43
	v_cmp_lt_u32_e32 vcc, 5, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[58:59], v[46:47], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[60:61], v[46:47], v[26:29]
	v_perm_b32 v46, v51, v50, v42
	v_lshlrev_b32_e32 v47, 4, v14
	v_perm_b32 v42, v45, v44, v42
	v_and_or_b32 v46, v46, v47, v42
	v_perm_b32 v42, v51, v50, v43
	v_perm_b32 v43, v45, v44, v43
	v_and_or_b32 v14, v42, v14, v43
	v_perm_b32 v42, v14, v46, s2
	v_perm_b32 v43, v14, v46, s8
	v_and_b32_e32 v14, 0x7070707, v15
	v_lshlrev_b32_e32 v46, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[66:67], v[42:43], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[68:69], v[42:43], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[70:71], v[42:43], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[72:73], v[42:43], v[26:29]
	v_lshrrev_b32_e32 v42, 4, v15
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v51, v50, v14
	v_perm_b32 v14, v45, v44, v14
	v_and_or_b32 v43, v43, v46, v14
	v_perm_b32 v14, v51, v50, v42
	v_perm_b32 v42, v45, v44, v42
	v_and_or_b32 v15, v14, v15, v42
	v_perm_b32 v14, v15, v43, s2
	v_perm_b32 v15, v15, v43, s8
	v_lshlrev_b32_e32 v43, 4, v16
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[74:75], v[14:15], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[76:77], v[14:15], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[78:79], v[14:15], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[80:81], v[14:15], v[26:29]
	v_and_b32_e32 v14, 0x7070707, v16
	v_lshrrev_b32_e32 v15, 4, v16
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v42, v51, v50, v14
	v_perm_b32 v14, v45, v44, v14
	v_and_or_b32 v42, v42, v43, v14
	v_perm_b32 v14, v51, v50, v15
	v_perm_b32 v15, v45, v44, v15
	v_and_or_b32 v15, v14, v16, v15
	v_perm_b32 v14, v15, v42, s2
	v_perm_b32 v15, v15, v42, s8
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[82:83], v[14:15], v[18:21]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[84:85], v[14:15], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[86:87], v[14:15], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[88:89], v[14:15], v[26:29]
	v_and_b32_e32 v14, 0x7070707, v17
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v51, v50, v14
	v_lshlrev_b32_e32 v34, 4, v17
	v_perm_b32 v14, v45, v44, v14
	v_and_or_b32 v14, v16, v34, v14
	v_perm_b32 v16, v51, v50, v15
	v_perm_b32 v15, v45, v44, v15
	v_and_or_b32 v15, v16, v17, v15
	v_perm_b32 v50, v15, v14, s2
	v_perm_b32 v51, v15, v14, s8
	s_load_dwordx2 s[2:3], s[0:1], 0x40
	s_load_dword s6, s[0:1], 0x48
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[100:101], v[50:51], v[22:25]
	s_mov_b32 s0, 0x20000
	s_nop 1
	v_lshlrev_b32_e32 v22, 2, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[98:99], v[50:51], v[18:21]
	v_mov_b32_e32 v23, 0xfd800000
	v_lshl_add_u32 v24, v64, 23, v23
	v_lshlrev_b32_e64 v25, v64, s0
	v_or_b32_e32 v18, s29, v22
	v_lshlrev_b32_e32 v57, 2, v18
	buffer_load_dwordx4 v[58:61], v57, s[20:23], 0 offen
	buffer_load_dwordx4 v[66:69], v57, s[12:15], 0 offen
	buffer_load_dwordx4 v[70:73], v57, s[12:15], 0 offen offset:64
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[38:39], v[50:51], v[46:49]
	v_lshl_add_u32 v23, v104, 23, v23
	v_lshl_add_u32 v63, v63, 10, v62
	s_nop 0
	v_cndmask_b32_e32 v48, v25, v24, vcc
	v_lshlrev_b32_e64 v24, v104, s0
	v_cmp_lt_u32_e32 vcc, 5, v104
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[40:41], v[50:51], v[26:29]
	s_movk_i32 s0, 0x7fff
	v_cndmask_b32_e32 v46, v24, v23, vcc
	v_or_b32_e32 v23, s10, v22
	v_lshlrev_b32_e32 v23, 2, v23
	buffer_load_dwordx4 v[38:41], v23, s[20:23], 0 offen
	v_or_b32_e32 v23, s11, v22
	v_lshlrev_b32_e32 v47, 2, v23
	v_or_b32_e32 v22, s5, v22
	v_lshlrev_b32_e32 v49, 2, v22
	buffer_load_dwordx4 v[26:29], v47, s[20:23], 0 offen
	buffer_load_dwordx4 v[22:25], v49, s[20:23], 0 offen
	v_lshrrev_b32_e32 v47, 5, v0
	v_or_b32_e32 v49, s29, v47
	v_lshlrev_b32_e32 v64, 2, v49
	v_or_b32_e32 v49, s10, v47
	v_lshlrev_b32_e32 v65, 2, v49
	v_or_b32_e32 v49, s11, v47
	v_lshlrev_b32_e32 v74, 2, v49
	v_or_b32_e32 v49, s5, v47
	s_and_b32 s21, s17, 0xffff
	s_mov_b32 s20, s16
	v_lshlrev_b32_e32 v75, 2, v49
	buffer_load_dword v56, v64, s[20:23], 0 offen
	buffer_load_dword v55, v64, s[20:23], 0 offen offset:32
	buffer_load_dword v54, v65, s[20:23], 0 offen
	buffer_load_dword v53, v64, s[20:23], 0 offen offset:96
	buffer_load_dword v52, v74, s[20:23], 0 offen
	buffer_load_dword v51, v64, s[20:23], 0 offen offset:160
	buffer_load_dword v50, v75, s[20:23], 0 offen
	buffer_load_dword v49, v64, s[20:23], 0 offen offset:224
	v_lshlrev_b32_e32 v0, 1, v0
	v_and_b32_e32 v0, 62, v0
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[74:75], v[48:49], v[60:61] op_sel_hi:[0,1]
	v_pk_mul_f32 v[32:33], v[32:33], v[74:75]
	v_pk_mul_f32 v[64:65], v[48:49], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[32:33], v[32:33], v[68:69]
	v_pk_mul_f32 v[30:31], v[30:31], v[64:65]
	v_bfe_u32 v64, v33, 16, 1
	v_add3_u32 v64, v64, v33, s0
	v_or_b32_e32 v65, 0x400000, v33
	v_cmp_u_f32_e32 vcc, v33, v33
	v_pk_mul_f32 v[30:31], v[30:31], v[66:67]
	s_nop 0
	v_cndmask_b32_e32 v33, v64, v65, vcc
	v_bfe_u32 v64, v32, 16, 1
	v_add3_u32 v64, v64, v32, s0
	v_or_b32_e32 v65, 0x400000, v32
	v_cmp_u_f32_e32 vcc, v32, v32
	s_nop 1
	v_cndmask_b32_e32 v32, v64, v65, vcc
	v_bfe_u32 v64, v31, 16, 1
	v_add3_u32 v64, v64, v31, s0
	v_or_b32_e32 v65, 0x400000, v31
	v_cmp_u_f32_e32 vcc, v31, v31
	s_nop 1
	v_cndmask_b32_e32 v31, v64, v65, vcc
	v_bfe_u32 v64, v30, 16, 1
	v_add3_u32 v64, v64, v30, s0
	v_or_b32_e32 v65, 0x400000, v30
	v_cmp_u_f32_e32 vcc, v30, v30
	s_nop 1
	v_cndmask_b32_e32 v30, v64, v65, vcc
	ds_write_b16_d16_hi v63, v30
	ds_write_b16_d16_hi v63, v31 offset:256
	ds_write_b16_d16_hi v63, v32 offset:512
	ds_write_b16_d16_hi v63, v33 offset:768
	v_pk_mul_f32 v[32:33], v[46:47], v[60:61] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[46:47], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[32:33], v[44:45], v[32:33]
	v_pk_mul_f32 v[30:31], v[42:43], v[30:31]
	v_pk_mul_f32 v[32:33], v[32:33], v[68:69]
	v_pk_mul_f32 v[42:43], v[30:31], v[66:67]
	v_bfe_u32 v30, v33, 16, 1
	v_add3_u32 v30, v30, v33, s0
	v_or_b32_e32 v31, 0x400000, v33
	v_cmp_u_f32_e32 vcc, v33, v33
	v_bfe_u32 v58, v43, 16, 1
	v_add3_u32 v58, v58, v43, s0
	v_cndmask_b32_e32 v44, v30, v31, vcc
	v_bfe_u32 v30, v32, 16, 1
	v_add3_u32 v30, v30, v32, s0
	v_or_b32_e32 v31, 0x400000, v32
	v_cmp_u_f32_e32 vcc, v32, v32
	v_or_b32_e32 v59, 0x400000, v43
	s_nop 0
	v_cndmask_b32_e32 v45, v30, v31, vcc
	buffer_load_dwordx4 v[30:33], v57, s[12:15], 0 offen offset:128
	v_cmp_u_f32_e32 vcc, v43, v43
	s_nop 1
	v_cndmask_b32_e32 v43, v58, v59, vcc
	v_bfe_u32 v58, v42, 16, 1
	v_add3_u32 v58, v58, v42, s0
	v_or_b32_e32 v59, 0x400000, v42
	v_cmp_u_f32_e32 vcc, v42, v42
	s_nop 1
	v_cndmask_b32_e32 v42, v58, v59, vcc
	ds_write_b16_d16_hi v63, v42 offset:32
	ds_write_b16_d16_hi v63, v43 offset:288
	ds_write_b16_d16_hi v63, v45 offset:544
	ds_write_b16_d16_hi v63, v44 offset:800
	v_pk_mul_f32 v[44:45], v[48:49], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[44:45]
	v_pk_mul_f32 v[42:43], v[48:49], v[38:39] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[12:13], v[72:73]
	v_pk_mul_f32 v[10:11], v[10:11], v[42:43]
	v_bfe_u32 v42, v13, 16, 1
	v_add3_u32 v42, v42, v13, s0
	v_or_b32_e32 v43, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	v_pk_mul_f32 v[10:11], v[10:11], v[70:71]
	s_nop 0
	v_cndmask_b32_e32 v13, v42, v43, vcc
	v_bfe_u32 v42, v12, 16, 1
	v_add3_u32 v42, v42, v12, s0
	v_or_b32_e32 v43, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	s_nop 1
	v_cndmask_b32_e32 v12, v42, v43, vcc
	v_bfe_u32 v42, v11, 16, 1
	v_add3_u32 v42, v42, v11, s0
	v_or_b32_e32 v43, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v11, v42, v43, vcc
	v_bfe_u32 v42, v10, 16, 1
	v_add3_u32 v42, v42, v10, s0
	v_or_b32_e32 v43, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v42, v43, vcc
	ds_write_b16_d16_hi v63, v10 offset:4096
	ds_write_b16_d16_hi v63, v11 offset:4352
	ds_write_b16_d16_hi v63, v12 offset:4608
	ds_write_b16_d16_hi v63, v13 offset:4864
	v_pk_mul_f32 v[12:13], v[46:47], v[40:41] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[46:47], v[38:39] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[36:37], v[12:13]
	v_pk_mul_f32 v[10:11], v[34:35], v[10:11]
	v_pk_mul_f32 v[34:35], v[12:13], v[72:73]
	v_pk_mul_f32 v[36:37], v[10:11], v[70:71]
	v_bfe_u32 v10, v35, 16, 1
	v_add3_u32 v10, v10, v35, s0
	v_or_b32_e32 v11, 0x400000, v35
	v_cmp_u_f32_e32 vcc, v35, v35
	v_or_b32_e32 v39, 0x400000, v34
	s_nop 0
	v_cndmask_b32_e32 v35, v10, v11, vcc
	v_bfe_u32 v10, v34, 16, 1
	v_add3_u32 v38, v10, v34, s0
	buffer_load_dwordx4 v[10:13], v57, s[12:15], 0 offen offset:192
	v_cmp_u_f32_e32 vcc, v34, v34
	s_nop 1
	v_cndmask_b32_e32 v34, v38, v39, vcc
	v_bfe_u32 v38, v37, 16, 1
	v_add3_u32 v38, v38, v37, s0
	v_or_b32_e32 v39, 0x400000, v37
	v_cmp_u_f32_e32 vcc, v37, v37
	s_nop 1
	v_cndmask_b32_e32 v37, v38, v39, vcc
	v_bfe_u32 v38, v36, 16, 1
	v_add3_u32 v38, v38, v36, s0
	v_or_b32_e32 v39, 0x400000, v36
	v_cmp_u_f32_e32 vcc, v36, v36
	s_nop 1
	v_cndmask_b32_e32 v36, v38, v39, vcc
	ds_write_b16_d16_hi v63, v36 offset:4128
	ds_write_b16_d16_hi v63, v37 offset:4384
	ds_write_b16_d16_hi v63, v34 offset:4640
	ds_write_b16_d16_hi v63, v35 offset:4896
	v_pk_mul_f32 v[36:37], v[48:49], v[28:29] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[36:37]
	v_pk_mul_f32 v[34:35], v[48:49], v[26:27] op_sel_hi:[0,1]
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[8:9], v[8:9], v[32:33]
	v_pk_mul_f32 v[6:7], v[6:7], v[34:35]
	v_bfe_u32 v34, v9, 16, 1
	v_add3_u32 v34, v34, v9, s0
	v_or_b32_e32 v35, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_pk_mul_f32 v[6:7], v[6:7], v[30:31]
	s_nop 0
	v_cndmask_b32_e32 v9, v34, v35, vcc
	v_bfe_u32 v34, v8, 16, 1
	v_add3_u32 v34, v34, v8, s0
	v_or_b32_e32 v35, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v34, v35, vcc
	v_bfe_u32 v34, v7, 16, 1
	v_add3_u32 v34, v34, v7, s0
	v_or_b32_e32 v35, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v34, v35, vcc
	v_bfe_u32 v34, v6, 16, 1
	v_add3_u32 v34, v34, v6, s0
	v_or_b32_e32 v35, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v34, v35, vcc
	ds_write_b16_d16_hi v63, v6 offset:8192
	ds_write_b16_d16_hi v63, v7 offset:8448
	ds_write_b16_d16_hi v63, v8 offset:8704
	ds_write_b16_d16_hi v63, v9 offset:8960
	v_pk_mul_f32 v[8:9], v[46:47], v[28:29] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[16:17], v[8:9]
	v_pk_mul_f32 v[6:7], v[46:47], v[26:27] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[8:9], v[32:33]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_bfe_u32 v14, v9, 16, 1
	v_add3_u32 v14, v14, v9, s0
	v_or_b32_e32 v15, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_pk_mul_f32 v[6:7], v[6:7], v[30:31]
	s_nop 0
	v_cndmask_b32_e32 v9, v14, v15, vcc
	v_bfe_u32 v14, v8, 16, 1
	v_add3_u32 v14, v14, v8, s0
	v_or_b32_e32 v15, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v14, v15, vcc
	v_bfe_u32 v14, v7, 16, 1
	v_add3_u32 v14, v14, v7, s0
	v_or_b32_e32 v15, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v14, v15, vcc
	v_bfe_u32 v14, v6, 16, 1
	v_add3_u32 v14, v14, v6, s0
	v_or_b32_e32 v15, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v14, v15, vcc
	ds_write_b16_d16_hi v63, v6 offset:8224
	ds_write_b16_d16_hi v63, v7 offset:8480
	ds_write_b16_d16_hi v63, v8 offset:8736
	ds_write_b16_d16_hi v63, v9 offset:8992
	v_pk_mul_f32 v[8:9], v[48:49], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_pk_mul_f32 v[6:7], v[48:49], v[22:23] op_sel_hi:[0,1]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[4:5], v[4:5], v[12:13]
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	v_bfe_u32 v6, v5, 16, 1
	v_add3_u32 v6, v6, v5, s0
	v_or_b32_e32 v7, 0x400000, v5
	v_cmp_u_f32_e32 vcc, v5, v5
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	s_nop 0
	v_cndmask_b32_e32 v5, v6, v7, vcc
	v_bfe_u32 v6, v4, 16, 1
	v_add3_u32 v6, v6, v4, s0
	v_or_b32_e32 v7, 0x400000, v4
	v_cmp_u_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v6, v7, vcc
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s0
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v6, v6, v2, s0
	v_or_b32_e32 v7, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v6, v7, vcc
	ds_write_b16_d16_hi v63, v2 offset:12288
	v_or_b32_e32 v2, 0x3100, v1
	v_add_u32_e32 v6, v2, v62
	v_or_b32_e32 v2, 0x3200, v1
	v_or_b32_e32 v1, 0x3300, v1
	v_add_u32_e32 v7, v2, v62
	v_add_u32_e32 v1, v1, v62
	ds_write_b16_d16_hi v6, v3
	ds_write_b16_d16_hi v7, v4
	ds_write_b16_d16_hi v1, v5
	v_pk_mul_f32 v[4:5], v[46:47], v[24:25] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[20:21], v[4:5]
	v_pk_mul_f32 v[2:3], v[46:47], v[22:23] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[4:5], v[12:13]
	v_pk_mul_f32 v[2:3], v[18:19], v[2:3]
	v_bfe_u32 v8, v5, 16, 1
	v_add3_u32 v8, v8, v5, s0
	v_or_b32_e32 v9, 0x400000, v5
	v_cmp_u_f32_e32 vcc, v5, v5
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	s_nop 0
	v_cndmask_b32_e32 v5, v8, v9, vcc
	v_bfe_u32 v8, v4, 16, 1
	v_add3_u32 v8, v8, v4, s0
	v_or_b32_e32 v9, 0x400000, v4
	v_cmp_u_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v8, v9, vcc
	v_bfe_u32 v8, v3, 16, 1
	v_add3_u32 v8, v8, v3, s0
	v_or_b32_e32 v9, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v9, vcc
	v_bfe_u32 v8, v2, 16, 1
	v_add3_u32 v8, v8, v2, s0
	v_or_b32_e32 v9, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v8, v9, vcc
	ds_write_b16_d16_hi v63, v2 offset:12320
	ds_write_b16_d16_hi v6, v3 offset:32
	ds_write_b16_d16_hi v7, v4 offset:32
	ds_write_b16_d16_hi v1, v5 offset:32
	v_and_b32_e32 v1, 0xffffff, v56
	s_waitcnt lgkmcnt(0)
	v_cmp_gt_i32_e32 vcc, s6, v1
	v_lshlrev_b32_e32 v1, 1, v0
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_3
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v56, 12, s28
	ds_read_b32 v5, v4
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_3:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v55
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_5
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v55, 12, s28
	ds_read_b32 v5, v4 offset:2048
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:2176
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_5:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v54
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_7
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v54, 12, s28
	ds_read_b32 v5, v4 offset:4096
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:4224
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_7:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v53
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v53, 12, s28
	ds_read_b32 v5, v4 offset:6144
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:6272
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_9:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v52
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_11
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v52, 12, s28
	ds_read_b32 v5, v4 offset:8192
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:8320
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_11:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v51
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_13
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v51, 12, s28
	ds_read_b32 v5, v4 offset:10240
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:10368
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_13:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v50
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_15
	v_lshl_or_b32 v4, v47, 8, v1
	v_lshl_add_u32 v2, v50, 12, s28
	ds_read_b32 v5, v4 offset:12288
	v_or_b32_e32 v2, v2, v0
	v_lshlrev_b32_e32 v2, 1, v2
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], s[2:3], 0, v[2:3]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v5, off
	ds_read_b32 v4, v4 offset:12416
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[2:3], v4, off offset:128
.LBB0_15:
	s_or_b64 exec, exec, s[0:1]
	v_and_b32_e32 v2, 0xffffff, v49
	v_cmp_gt_i32_e32 vcc, s6, v2
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_17
	v_lshl_or_b32 v3, v47, 8, v1
	v_lshl_add_u32 v2, v49, 12, s28
	ds_read_b32 v4, v3 offset:14336
	v_or_b32_e32 v0, v2, v0
	v_lshlrev_b32_e32 v0, 1, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[2:3], 0, v[0:1]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v4, off
	ds_read_b32 v2, v3 offset:14464
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:128
.LBB0_17:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds, .Lfunc_end0-a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds
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
		.amdhsa_next_free_vgpr 110
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 112
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

	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.num_vgpr, 110
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.num_agpr, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.numbered_sgpr, 31
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.num_named_barrier, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.private_seg_size, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.uses_vcc, 1
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.uses_flat_scratch, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.has_dyn_sized_stack, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.has_recursion, 0
	.set .La8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.has_indirect_call, 0
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
    .name:           a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     37
    .sgpr_spill_count: 0
    .symbol:         a8w4_gemm2_h4096_i256_ne256_bm64_tn128_tk256_bcm2_xcd0_ftz_lds.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     110
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
