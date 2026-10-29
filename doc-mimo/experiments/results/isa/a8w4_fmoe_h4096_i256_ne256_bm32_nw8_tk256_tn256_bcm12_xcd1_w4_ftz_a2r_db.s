	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db:
	s_load_dwordx8 s[16:23], s[0:1], 0x40
	v_readfirstlane_b32 s3, v0
	s_mov_b32 s45, 0
	s_waitcnt lgkmcnt(0)
	s_load_dword s6, s[18:19], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s6, 31
	s_lshr_b32 s4, s4, 27
	s_add_i32 s4, s6, s4
	s_ashr_i32 s8, s4, 5
	s_andn2_b32 s4, s4, 31
	s_cmp_lg_u32 s6, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s6, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s4, s8, 0
	s_cmp_ge_i32 s2, s4
	s_cbranch_scc1 .LBB0_13
	s_lshr_b32 s48, s3, 6
	s_and_b32 s3, s4, 7
	s_and_b32 s5, s2, 7
	s_lshr_b32 s4, s4, 3
	s_min_u32 s3, s5, s3
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s4, s4, s5
	s_add_i32 s2, s3, s2
	s_add_i32 s2, s2, s4
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[4:5], s[2:3], 2
	s_add_u32 s46, s16, s4
	s_addc_u32 s47, s17, s5
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dwordx2 s[34:35], s[0:1], 0x60
	s_load_dword s33, s[0:1], 0x68
	s_lshl_b32 s44, s2, 5
	v_lshrrev_b32_e32 v14, 4, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s25, s11, 0xffff
	s_load_dword s11, s[46:47], 0x0
	v_or_b32_e32 v2, s44, v14
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dword v1, v[2:3], off
	v_and_b32_e32 v2, 63, v0
	v_and_b32_e32 v9, 15, v0
	v_lshlrev_b32_e32 v15, 4, v0
	s_and_b32 s37, s5, 0xffff
	s_lshl_b32 s5, s48, 5
	scratch_store_dword off, v2, off offset:192
	v_bfe_u32 v16, v0, 4, 2
	v_and_b32_e32 v17, 48, v0
	scratch_store_dword off, v0, off offset:172
	v_xor_b32_e32 v2, v15, v0
	v_or_b32_e32 v0, s5, v9
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s0, s11, 9
	v_and_b32_e32 v6, 0xf0, v2
	s_add_i32 s46, s0, s5
	v_add_u32_e32 v2, s0, v0
	s_lshl_b32 s0, s46, 7
	v_ashrrev_i32_e32 v3, 31, v2
	scratch_store_dword off, v0, off offset:196
	v_add_u32_e32 v4, 0x100, v2
	v_or3_b32 v0, s0, v17, v9
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	scratch_store_dword off, v0, off offset:132
	v_lshlrev_b32_e32 v8, 4, v0
	global_load_dword v0, v[2:3], off
	v_ashrrev_i32_e32 v5, 31, v4
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	s_and_b32 s1, s9, 0xffff
	s_lshl_b32 s3, s46, 5
	s_add_i32 s9, s46, 0x100
	s_ashr_i32 s24, s46, 31
	s_add_i32 s51, s46, 0x110
	s_or_b32 s47, s46, 16
	v_or3_b32 v7, s3, v17, v9
	s_lshl_b32 s0, s9, 7
	s_lshl_b32 s3, s9, 5
	s_lshr_b32 s27, s24, 27
	s_ashr_i32 s53, s51, 31
	v_or3_b32 v22, s0, v17, v9
	v_or3_b32 v10, s3, v17, v9
	s_add_i32 s0, s47, s27
	s_lshr_b32 s3, s53, 27
	s_lshr_b32 s0, s0, 5
	s_add_i32 s3, s51, s3
	s_lshl_b32 s9, s47, 7
	s_add_i32 s0, s0, s24
	s_lshr_b32 s3, s3, 5
	s_mov_b32 s39, 0x27000
	s_brev_b32 s2, 8
	s_mov_b32 s36, s4
	s_lshl_b32 s38, s33, 12
	s_lshl_b32 s52, s51, 7
	v_or3_b32 v11, s9, v17, v9
	s_lshl_b32 s0, s0, 10
	s_add_i32 s3, s3, s53
	s_mov_b32 s26, 0x1000000
	s_mov_b32 s42, s2
	s_mov_b32 s43, s39
	s_mov_b32 s40, s8
	s_mov_b32 s41, s1
	v_or3_b32 v23, s52, v17, v9
	scratch_store_dword off, v11, off offset:148
	s_mov_b32 s30, s26
	s_mov_b32 s31, s39
	s_mov_b32 s28, s10
	s_mov_b32 s29, s25
	scratch_store_dword off, v7, off offset:136
	v_lshlrev_b32_e32 v7, 2, v7
	scratch_store_dword off, v22, off offset:140
	scratch_store_dword off, v23, off offset:152
	buffer_load_dwordx4 v[26:29], v8, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v8, s[40:43], 0 offen offset:1024 sc0
	s_mov_b32 s24, s10
	s_ashr_i32 s9, s51, 4
	s_lshr_b32 s10, s51, 31
	s_add_i32 s10, s9, s10
	s_and_b32 s10, s10, -2
	scratch_store_dword off, v15, off offset:176
	v_mov_b32_e32 v34, 0
	s_mov_b32 s49, 0x8080808
	s_mov_b32 s50, 0x5010400
	s_mov_b32 s12, 0x7030602
	s_mov_b32 s27, s39
	v_mov_b32_e32 v35, v34
	v_mov_b32_e32 v36, v34
	v_mov_b32_e32 v37, v34
	v_mov_b32_e32 v62, v34
	v_mov_b32_e32 v63, v34
	v_mov_b32_e32 v64, v34
	v_mov_b32_e32 v65, v34
	v_mov_b32_e32 v38, v34
	v_mov_b32_e32 v39, v34
	v_mov_b32_e32 v40, v34
	v_mov_b32_e32 v41, v34
	v_mov_b32_e32 v66, v34
	v_mov_b32_e32 v67, v34
	v_mov_b32_e32 v68, v34
	v_mov_b32_e32 v69, v34
	v_mov_b32_e32 v46, v34
	v_mov_b32_e32 v47, v34
	v_mov_b32_e32 v48, v34
	v_mov_b32_e32 v49, v34
	v_mov_b32_e32 v74, v34
	v_mov_b32_e32 v75, v34
	v_mov_b32_e32 v76, v34
	s_waitcnt vmcnt(7)
	scratch_store_dword off, v0, off offset:96
	global_load_dword v0, v[2:3], off offset:64
	v_mov_b32_e32 v77, v34
	v_mov_b32_e32 v42, v34
	v_mov_b32_e32 v43, v34
	v_mov_b32_e32 v44, v34
	v_mov_b32_e32 v45, v34
	v_mov_b32_e32 v70, v34
	v_mov_b32_e32 v71, v34
	v_mov_b32_e32 v72, v34
	v_mov_b32_e32 v73, v34
	scratch_store_dword off, v17, off offset:184
	scratch_store_dword off, v16, off offset:180
	s_waitcnt vmcnt(2)
	scratch_store_dword off, v0, off offset:100
	global_load_dword v0, v[4:5], off
	s_waitcnt vmcnt(0)
	scratch_store_dword off, v0, off offset:88
	global_load_dword v0, v[4:5], off offset:64
	s_waitcnt vmcnt(0)
	scratch_store_dword off, v0, off offset:92
	scratch_store_dword off, v10, off offset:144
	v_lshl_or_b32 v0, v1, 12, v6
	v_lshlrev_b32_e32 v2, 2, v10
	v_lshlrev_b32_e32 v3, 4, v11
	scratch_store_dword off, v0, off offset:156
	buffer_load_dwordx4 v[10:13], v0, s[36:39], 0 offen nt
	v_or3_b32 v0, s0, v17, v9
	s_lshl_b32 s0, s3, 10
	v_lshlrev_b32_e32 v1, 4, v22
	v_lshlrev_b32_e32 v4, 4, v23
	buffer_load_dwordx4 v[116:119], v3, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[108:111], v3, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[30:33], v1, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v1, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[124:127], v4, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[104:107], v4, s[40:43], 0 offen offset:1024 sc0
	v_or3_b32 v3, s0, v17, v9
	v_lshlrev_b32_e32 v1, 2, v0
	scratch_store_dword off, v3, off offset:164
	v_lshlrev_b32_e32 v3, 2, v3
	buffer_load_dword v87, v7, s[28:31], 0 offen
	buffer_load_dword v114, v1, s[28:31], 0 offen
	buffer_load_dword v86, v2, s[28:31], 0 offen
	buffer_load_dword v115, v3, s[28:31], 0 offen
	v_and_b32_e32 v1, 0xf0, v15
	v_lshlrev_b32_e32 v2, 5, v16
	scratch_store_dword off, v0, off offset:160
	v_lshlrev_b32_e32 v3, 4, v9
	v_lshl_or_b32 v0, v14, 8, v1
	v_or_b32_e32 v1, 8, v2
	v_or_b32_e32 v4, 16, v2
	v_xor_b32_e32 v1, v1, v3
	v_or_b32_e32 v5, 24, v2
	scratch_store_dword off, v1, off offset:124
	v_xor_b32_e32 v1, v4, v3
	v_or_b32_e32 v6, 0x80, v2
	scratch_store_dword off, v1, off offset:120
	v_xor_b32_e32 v1, v5, v3
	s_mov_b32 s28, s4
	s_mov_b32 s0, s8
	s_lshr_b32 s4, s46, 31
	s_ashr_i32 s8, s47, 4
	v_or_b32_e32 v7, 0x88, v2
	scratch_store_dword off, v1, off offset:116
	v_xor_b32_e32 v1, v6, v3
	s_add_i32 s4, s8, s4
	v_or_b32_e32 v8, 0x90, v2
	scratch_store_dword off, v1, off offset:112
	v_xor_b32_e32 v1, v7, v3
	s_and_b32 s4, s4, -2
	v_lshlrev_b32_e32 v15, 8, v9
	v_xor_b32_e32 v9, v2, v3
	v_or_b32_e32 v2, 0x98, v2
	scratch_store_dword off, v1, off offset:108
	v_xor_b32_e32 v1, v8, v3
	s_sub_i32 s4, s8, s4
	s_sub_i32 s8, s9, s10
	scratch_store_dword off, v1, off offset:104
	v_xor_b32_e32 v1, v2, v3
	s_lshl_b32 s9, s4, 3
	s_lshl_b32 s4, s8, 3
	s_mov_b32 s3, s39
	v_or_b32_e32 v122, 0x1000, v15
	v_lshrrev_b32_e32 v14, 2, v0
	v_or_b32_e32 v2, v15, v9
	v_or_b32_e32 v1, v15, v1
	s_mov_b32 s30, s38
	s_mov_b32 s29, s37
	s_add_i32 s10, s9, 16
	s_add_i32 s8, s4, 16
	scratch_store_dword off, v14, off offset:168
	scratch_store_dword off, v9, off offset:188
	scratch_store_dword off, v2, off offset:128
	scratch_store_dword off, v15, off offset:80
	scratch_store_dword off, v1, off offset:84
	s_waitcnt vmcnt(23)
	ds_write_b128 v0, v[10:13]
.LBB0_2:
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v0, off, off offset:156
	s_and_b32 s13, s45, 1
	s_add_i32 s45, s45, 1
	s_lshl_b32 s36, s45, 6
	s_waitcnt vmcnt(23)
	v_mov_b64_e32 v[82:83], v[116:117]
	v_mov_b64_e32 v[84:85], v[118:119]
	s_waitcnt vmcnt(15)
	v_bfe_u32 v118, v114, s9, 8
	v_bfe_u32 v117, v114, s10, 8
	v_mov_b64_e32 v[50:51], v[104:105]
	v_mov_b64_e32 v[52:53], v[106:107]
	s_waitcnt vmcnt(13)
	v_bfe_u32 v116, v115, s4, 8
	v_bfe_u32 v107, v115, s8, 8
	v_mov_b64_e32 v[100:101], v[28:29]
	v_mov_b64_e32 v[98:99], v[26:27]
	v_mov_b64_e32 v[60:61], v[24:25]
	v_mov_b64_e32 v[58:59], v[22:23]
	v_mov_b64_e32 v[96:97], v[32:33]
	v_mov_b64_e32 v[94:95], v[30:31]
	v_mov_b64_e32 v[92:93], v[20:21]
	v_mov_b64_e32 v[90:91], v[18:19]
	v_mov_b64_e32 v[78:79], v[124:125]
	v_mov_b64_e32 v[80:81], v[126:127]
	v_mov_b64_e32 v[54:55], v[108:109]
	v_mov_b64_e32 v[56:57], v[110:111]
	s_waitcnt vmcnt(0)
	v_lshl_add_u32 v0, s45, 8, v0
	buffer_load_dwordx4 v[0:3], v0, s[28:31], 0 offen nt
	s_waitcnt vmcnt(0)
	scratch_store_dwordx4 off, v[0:3], off
	scratch_load_dword v1, off, off offset:160
	s_nop 0
	scratch_load_dword v0, off, off offset:136
	s_waitcnt vmcnt(1)
	v_add_lshl_u32 v1, s36, v1, 2
	buffer_load_dword v114, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:144
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s36, v1, 2
	buffer_load_dword v102, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:164
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s36, v1, 2
	buffer_load_dword v115, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:132
	v_add_lshl_u32 v0, s36, v0, 2
	s_lshl_b32 s36, s45, 7
	buffer_load_dword v0, v0, s[24:27], 0 offen
	s_waitcnt vmcnt(1)
	v_or_b32_e32 v1, s36, v1
	v_lshlrev_b32_e32 v1, 4, v1
	buffer_load_dwordx4 v[26:29], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:148
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s36, v1, 4
	scratch_store_dwordx4 off, v[2:5], off offset:16
	buffer_load_dwordx4 v[2:5], v1, s[0:3], 0 offen sc0
	s_waitcnt vmcnt(0)
	scratch_store_dwordx4 off, v[2:5], off offset:64
	buffer_load_dwordx4 v[2:5], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:140
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s36, v1
	v_lshlrev_b32_e32 v1, 4, v1
	buffer_load_dwordx4 v[30:33], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:152
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s36, v1, 4
	scratch_store_dwordx4 off, v[2:5], off offset:32
	buffer_load_dwordx4 v[18:21], v1, s[0:3], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v1, s[0:3], 0 offen offset:1024 sc0
	s_waitcnt vmcnt(0)
	scratch_store_dwordx4 off, v[2:5], off offset:48
	scratch_load_dword v4, off, off offset:96
	s_nop 0
	v_lshlrev_b32_e32 v5, 4, v98
	s_lshl_b32 s36, s13, 13
	v_lshlrev_b32_e32 v17, 4, v99
	s_cmp_lg_u32 s45, 15
	s_waitcnt vmcnt(0)
	v_sub_u32_sdwa v1, v4, v87 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v2, 11, v1
	v_mul_lo_u32 v2, v2, s49
	v_sub_u32_e32 v3, 0x6c686080, v2
	v_and_b32_e32 v3, 0xffffff00, v3
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v2, 0x7c787470, v2
	s_nop 0
	v_cndmask_b32_e64 v127, v3, 0, vcc
	v_cndmask_b32_e64 v108, v2, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v127
	v_and_b32_e32 v109, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v108
	v_and_b32_e32 v106, 0x80808080, v1
	v_sub_u32_sdwa v1, v4, v87 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	scratch_load_dword v4, off, off offset:88
	v_min_i32_e32 v2, 11, v1
	v_mul_lo_u32 v2, v2, s49
	v_sub_u32_e32 v3, 0x6c686080, v2
	v_and_b32_e32 v3, 0xffffff00, v3
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v2, 0x7c787470, v2
	s_nop 0
	v_cndmask_b32_e64 v119, v3, 0, vcc
	v_cndmask_b32_e64 v120, v2, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v119
	v_and_b32_e32 v121, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v120
	v_and_b32_e32 v103, 0x80808080, v1
	s_waitcnt vmcnt(0)
	v_sub_u32_sdwa v1, v4, v86 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v2, 11, v1
	v_mul_lo_u32 v2, v2, s49
	v_sub_u32_e32 v3, 0x6c686080, v2
	v_and_b32_e32 v3, 0xffffff00, v3
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v2, 0x7c787470, v2
	s_nop 0
	v_cndmask_b32_e64 v104, v3, 0, vcc
	v_cndmask_b32_e64 v1, v2, 0, vcc
	v_add_u32_e32 v2, 0x7f7f7f00, v104
	v_and_b32_e32 v110, 0x80808000, v2
	v_add_u32_e32 v2, 0x7f7f7f78, v1
	v_and_b32_e32 v111, 0x80808080, v2
	v_sub_u32_sdwa v2, v4, v86 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v3, 11, v2
	v_mul_lo_u32 v3, v3, s49
	v_sub_u32_e32 v4, 0x6c686080, v3
	v_and_b32_e32 v4, 0xffffff00, v4
	v_cmp_lt_i32_e32 vcc, 11, v2
	v_sub_u32_e32 v3, 0x7c787470, v3
	s_nop 0
	v_cndmask_b32_e64 v123, v4, 0, vcc
	v_cndmask_b32_e64 v124, v3, 0, vcc
	v_add_u32_e32 v2, 0x7f7f7f00, v123
	v_and_b32_e32 v125, 0x80808000, v2
	v_add_u32_e32 v2, 0x7f7f7f78, v124
	v_and_b32_e32 v126, 0x80808080, v2
	v_and_b32_e32 v2, 0x7070707, v98
	v_lshrrev_b32_e32 v3, 4, v98
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v106, v109, v2
	v_perm_b32 v2, v108, v127, v2
	v_and_or_b32 v2, v4, v5, v2
	v_perm_b32 v4, v106, v109, v3
	v_perm_b32 v3, v108, v127, v3
	v_and_or_b32 v3, v4, v98, v3
	v_perm_b32 v10, v3, v2, s50
	v_perm_b32 v11, v3, v2, s12
	v_and_b32_e32 v2, 0x7070707, v94
	v_lshrrev_b32_e32 v3, 4, v94
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v111, v110, v2
	v_lshlrev_b32_e32 v5, 4, v94
	v_perm_b32 v2, v1, v104, v2
	v_and_or_b32 v2, v4, v5, v2
	v_perm_b32 v4, v111, v110, v3
	v_perm_b32 v3, v1, v104, v3
	v_and_or_b32 v3, v4, v94, v3
	v_perm_b32 v14, v3, v2, s50
	v_perm_b32 v15, v3, v2, s12
	scratch_load_dword v2, off, off offset:128
	scratch_load_dword v98, off, off offset:80
	s_waitcnt vmcnt(1)
	v_or_b32_e32 v2, s36, v2
	ds_read2st64_b64 v[86:89], v2 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[86:87], v[10:11], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[86:87], v[14:15], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[88:89], v[14:15], v[42:45]
	v_and_b32_e32 v14, 0x7070707, v99
	v_lshrrev_b32_e32 v15, 4, v99
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v106, v109, v14
	v_perm_b32 v14, v108, v127, v14
	v_and_or_b32 v14, v16, v17, v14
	v_perm_b32 v16, v106, v109, v15
	v_perm_b32 v15, v108, v127, v15
	v_and_or_b32 v15, v16, v99, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[88:89], v[10:11], v[38:41]
	v_lshlrev_b32_e32 v17, 4, v95
	s_nop 1
	v_perm_b32 v38, v15, v14, s50
	v_perm_b32 v39, v15, v14, s12
	v_and_b32_e32 v14, 0x7070707, v95
	v_lshrrev_b32_e32 v15, 4, v95
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v111, v110, v14
	v_perm_b32 v14, v1, v104, v14
	v_and_or_b32 v14, v16, v17, v14
	v_perm_b32 v16, v111, v110, v15
	v_perm_b32 v15, v1, v104, v15
	v_and_or_b32 v15, v16, v95, v15
	v_perm_b32 v42, v15, v14, s50
	v_perm_b32 v43, v15, v14, s12
	scratch_load_dword v14, off, off offset:124
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v16, s36, v14
	v_or_b32_e32 v14, v16, v98
	v_or_b32_e32 v16, v16, v122
	ds_read_b64 v[14:15], v14
	ds_read_b64 v[16:17], v16
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[14:15], v[38:39], v[2:5]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[16:17], v[38:39], v[10:13]
	s_nop 2
	v_and_b32_e32 v10, 0x7070707, v100
	v_lshrrev_b32_e32 v11, 4, v100
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v106, v109, v10
	v_lshlrev_b32_e32 v13, 4, v100
	v_perm_b32 v10, v108, v127, v10
	v_and_or_b32 v10, v12, v13, v10
	v_perm_b32 v12, v106, v109, v11
	v_perm_b32 v11, v108, v127, v11
	v_and_or_b32 v11, v12, v100, v11
	v_perm_b32 v46, v11, v10, s50
	v_perm_b32 v47, v11, v10, s12
	v_and_b32_e32 v10, 0x7070707, v96
	v_lshrrev_b32_e32 v11, 4, v96
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v111, v110, v10
	v_lshlrev_b32_e32 v13, 4, v96
	v_perm_b32 v10, v1, v104, v10
	v_and_or_b32 v10, v12, v13, v10
	v_perm_b32 v12, v111, v110, v11
	v_perm_b32 v11, v1, v104, v11
	v_and_or_b32 v11, v12, v96, v11
	v_perm_b32 v48, v11, v10, s50
	v_perm_b32 v49, v11, v10, s12
	scratch_load_dword v10, off, off offset:120
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[14:15], v[42:43], v[6:9]
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v12, s36, v10
	v_or_b32_e32 v10, v12, v98
	ds_read_b64 v[10:11], v10
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[16:17], v[42:43], v[34:37]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[10:11], v[48:49], v[6:9]
	s_nop 2
	v_or_b32_e32 v6, v12, v122
	ds_read_b64 v[12:13], v6
	v_and_b32_e32 v6, 0x7070707, v101
	v_lshrrev_b32_e32 v7, 4, v101
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v106, v109, v6
	v_lshlrev_b32_e32 v9, 4, v101
	v_perm_b32 v6, v108, v127, v6
	v_and_or_b32 v6, v8, v9, v6
	v_perm_b32 v8, v106, v109, v7
	v_perm_b32 v7, v108, v127, v7
	v_and_or_b32 v7, v8, v101, v7
	v_perm_b32 v94, v7, v6, s50
	v_perm_b32 v95, v7, v6, s12
	v_and_b32_e32 v6, 0x7070707, v97
	v_lshrrev_b32_e32 v7, 4, v97
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v111, v110, v6
	v_lshlrev_b32_e32 v9, 4, v97
	v_perm_b32 v6, v1, v104, v6
	v_and_or_b32 v6, v8, v9, v6
	v_perm_b32 v8, v111, v110, v7
	v_perm_b32 v1, v1, v104, v7
	v_and_or_b32 v1, v8, v97, v1
	v_perm_b32 v96, v1, v6, s50
	v_perm_b32 v97, v1, v6, s12
	scratch_load_dword v1, off, off offset:116
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[10:11], v[46:47], v[2:5]
	v_lshlrev_b32_e32 v106, 4, v78
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s36, v1
	v_or_b32_e32 v6, v1, v98
	ds_read_b64 v[6:7], v6
	v_or_b32_e32 v1, v1, v122
	ds_read_b64 v[8:9], v1
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[12:13], v[46:47], v[38:41]
	v_and_b32_e32 v1, 0x7070707, v90
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[12:13], v[48:49], v[34:37]
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[6:7], v[94:95], v[2:5]
	s_nop 2
	v_lshrrev_b32_e32 v2, 4, v90
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v103, v121, v1
	v_lshlrev_b32_e32 v4, 4, v90
	v_perm_b32 v1, v120, v119, v1
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v103, v121, v2
	v_perm_b32 v2, v120, v119, v2
	v_and_or_b32 v2, v3, v90, v2
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[8:9], v[94:95], v[38:41]
	v_perm_b32 v94, v2, v1, s50
	v_perm_b32 v95, v2, v1, s12
	v_and_b32_e32 v1, 0x7070707, v58
	v_lshrrev_b32_e32 v2, 4, v58
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v126, v125, v1
	v_lshlrev_b32_e32 v4, 4, v58
	v_perm_b32 v1, v124, v123, v1
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v126, v125, v2
	v_perm_b32 v2, v124, v123, v2
	v_and_or_b32 v2, v3, v58, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[6:7], v[96:97], v[42:45]
	v_lshrrev_b32_e32 v58, 4, v91
	v_and_b32_e32 v58, 0x7070707, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[8:9], v[96:97], v[34:37]
	v_perm_b32 v96, v2, v1, s50
	v_perm_b32 v97, v2, v1, s12
	scratch_load_dword v1, off, off offset:112
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s36, v1
	v_or_b32_e32 v2, v1, v98
	v_or_b32_e32 v1, v1, v122
	ds_read_b64 v[2:3], v2
	ds_read_b64 v[4:5], v1
	v_and_b32_e32 v1, 0x7070707, v91
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[2:3], v[94:95], v[46:49]
	v_perm_b32 v90, v103, v121, v1
	v_perm_b32 v1, v120, v119, v1
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[4:5], v[94:95], v[38:41]
	v_lshlrev_b32_e32 v94, 4, v91
	v_and_or_b32 v1, v90, v94, v1
	v_perm_b32 v90, v103, v121, v58
	v_perm_b32 v58, v120, v119, v58
	v_and_or_b32 v58, v90, v91, v58
	v_perm_b32 v90, v58, v1, s50
	v_perm_b32 v91, v58, v1, s12
	v_and_b32_e32 v1, 0x7070707, v59
	v_lshrrev_b32_e32 v58, 4, v59
	v_and_b32_e32 v58, 0x7070707, v58
	v_perm_b32 v94, v126, v125, v1
	v_lshlrev_b32_e32 v95, 4, v59
	v_perm_b32 v1, v124, v123, v1
	v_and_or_b32 v1, v94, v95, v1
	v_perm_b32 v94, v126, v125, v58
	v_perm_b32 v58, v124, v123, v58
	v_and_or_b32 v59, v94, v59, v58
	v_perm_b32 v58, v59, v1, s50
	v_perm_b32 v59, v59, v1, s12
	scratch_load_dword v1, off, off offset:108
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[2:3], v[96:97], v[42:45]
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s36, v1
	v_or_b32_e32 v94, v1, v98
	v_or_b32_e32 v1, v1, v122
	ds_read_b64 v[112:113], v94
	ds_read_b64 v[104:105], v1
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[4:5], v[96:97], v[34:37]
	v_and_b32_e32 v1, 0x7070707, v92
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[112:113], v[58:59], v[42:45]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[104:105], v[58:59], v[34:37]
	v_lshrrev_b32_e32 v58, 4, v92
	v_and_b32_e32 v58, 0x7070707, v58
	v_perm_b32 v59, v103, v121, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[112:113], v[90:91], v[46:49]
	v_perm_b32 v1, v120, v119, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[104:105], v[90:91], v[38:41]
	v_lshlrev_b32_e32 v90, 4, v92
	v_and_or_b32 v1, v59, v90, v1
	v_perm_b32 v59, v103, v121, v58
	v_perm_b32 v58, v120, v119, v58
	v_and_or_b32 v59, v59, v92, v58
	v_perm_b32 v58, v59, v1, s50
	v_perm_b32 v59, v59, v1, s12
	v_and_b32_e32 v1, 0x7070707, v60
	v_lshrrev_b32_e32 v90, 4, v60
	v_and_b32_e32 v90, 0x7070707, v90
	v_perm_b32 v91, v126, v125, v1
	v_lshlrev_b32_e32 v92, 4, v60
	v_perm_b32 v1, v124, v123, v1
	v_and_or_b32 v1, v91, v92, v1
	v_perm_b32 v91, v126, v125, v90
	v_perm_b32 v90, v124, v123, v90
	v_and_or_b32 v60, v91, v60, v90
	v_perm_b32 v90, v60, v1, s50
	v_perm_b32 v91, v60, v1, s12
	scratch_load_dword v1, off, off offset:104
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s36, v1
	v_or_b32_e32 v60, v1, v98
	v_or_b32_e32 v1, v1, v122
	ds_read_b64 v[108:109], v60
	ds_read_b64 v[110:111], v1
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[110:111], v[90:91], v[34:37]
	v_and_b32_e32 v1, 0x7070707, v93
	s_nop 1
	v_lshrrev_b32_e32 v34, 4, v93
	v_and_b32_e32 v34, 0x7070707, v34
	v_perm_b32 v35, v103, v121, v1
	v_lshlrev_b32_e32 v36, 4, v93
	v_perm_b32 v1, v120, v119, v1
	v_and_or_b32 v1, v35, v36, v1
	v_perm_b32 v35, v103, v121, v34
	v_perm_b32 v34, v120, v119, v34
	v_and_or_b32 v34, v35, v93, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[108:109], v[90:91], v[42:45]
	v_perm_b32 v90, v34, v1, s50
	v_perm_b32 v91, v34, v1, s12
	v_and_b32_e32 v1, 0x7070707, v61
	v_lshrrev_b32_e32 v34, 4, v61
	v_and_b32_e32 v34, 0x7070707, v34
	v_perm_b32 v35, v126, v125, v1
	v_lshlrev_b32_e32 v36, 4, v61
	v_perm_b32 v1, v124, v123, v1
	v_and_or_b32 v1, v35, v36, v1
	v_perm_b32 v35, v126, v125, v34
	v_perm_b32 v34, v124, v123, v34
	v_and_or_b32 v34, v35, v61, v34
	v_perm_b32 v92, v34, v1, s50
	v_perm_b32 v93, v34, v1, s12
	scratch_load_dword v1, off, off offset:84
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[108:109], v[58:59], v[46:49]
	v_lshlrev_b32_e32 v103, 4, v82
	v_mov_b64_e32 v[126:127], v[20:21]
	v_mov_b64_e32 v[124:125], v[18:19]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[110:111], v[58:59], v[38:41]
	scratch_load_dwordx4 v[18:21], off, off offset:16
	s_waitcnt vmcnt(1)
	v_or_b32_e32 v1, s36, v1
	ds_read2st64_b64 v[58:61], v1 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[58:59], v[90:91], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[58:59], v[92:93], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[60:61], v[92:93], v[94:97]
	scratch_load_dword v92, off, off offset:100
	s_waitcnt vmcnt(0)
	v_sub_u32_e32 v1, v92, v118
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[60:61], v[90:91], v[38:41]
	v_min_i32_e32 v90, 11, v1
	v_mul_lo_u32 v90, v90, s49
	v_sub_u32_e32 v91, 0x6c686080, v90
	v_and_b32_e32 v91, 0xffffff00, v91
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v90, 0x7c787470, v90
	s_nop 0
	v_cndmask_b32_e64 v100, v91, 0, vcc
	v_cndmask_b32_e64 v101, v90, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v100
	v_and_b32_e32 v118, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v101
	v_and_b32_e32 v119, 0x80808080, v1
	v_sub_u32_e32 v1, v92, v117
	scratch_load_dword v92, off, off offset:92
	v_min_i32_e32 v90, 11, v1
	v_mul_lo_u32 v90, v90, s49
	v_sub_u32_e32 v91, 0x6c686080, v90
	v_and_b32_e32 v91, 0xffffff00, v91
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v90, 0x7c787470, v90
	s_nop 0
	v_cndmask_b32_e64 v96, v91, 0, vcc
	v_cndmask_b32_e64 v97, v90, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v96
	v_and_b32_e32 v98, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v97
	v_and_b32_e32 v99, 0x80808080, v1
	s_waitcnt vmcnt(0)
	v_sub_u32_e32 v1, v92, v116
	v_min_i32_e32 v90, 11, v1
	v_mul_lo_u32 v90, v90, s49
	v_sub_u32_e32 v91, 0x6c686080, v90
	v_and_b32_e32 v91, 0xffffff00, v91
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v90, 0x7c787470, v90
	s_nop 0
	v_cndmask_b32_e64 v116, v91, 0, vcc
	v_cndmask_b32_e64 v117, v90, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v116
	v_and_b32_e32 v120, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v117
	v_and_b32_e32 v121, 0x80808080, v1
	v_sub_u32_e32 v1, v92, v107
	v_min_i32_e32 v90, 11, v1
	v_mul_lo_u32 v90, v90, s49
	v_sub_u32_e32 v91, 0x6c686080, v90
	v_and_b32_e32 v91, 0xffffff00, v91
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v90, 0x7c787470, v90
	s_nop 0
	v_cndmask_b32_e64 v92, v91, 0, vcc
	v_cndmask_b32_e64 v93, v90, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v92
	v_and_b32_e32 v94, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v93
	v_and_b32_e32 v95, 0x80808080, v1
	v_and_b32_e32 v1, 0x7070707, v82
	v_lshrrev_b32_e32 v90, 4, v82
	v_and_b32_e32 v90, 0x7070707, v90
	v_perm_b32 v91, v119, v118, v1
	v_perm_b32 v1, v101, v100, v1
	v_and_or_b32 v1, v91, v103, v1
	v_perm_b32 v91, v119, v118, v90
	v_perm_b32 v90, v101, v100, v90
	v_and_or_b32 v82, v91, v82, v90
	v_perm_b32 v90, v82, v1, s50
	v_perm_b32 v91, v82, v1, s12
	v_and_b32_e32 v1, 0x7070707, v78
	v_lshrrev_b32_e32 v82, 4, v78
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v103, v121, v120, v1
	v_perm_b32 v1, v117, v116, v1
	v_and_or_b32 v1, v103, v106, v1
	v_perm_b32 v103, v121, v120, v82
	v_perm_b32 v82, v117, v116, v82
	v_and_or_b32 v78, v103, v78, v82
	v_perm_b32 v106, v78, v1, s50
	v_perm_b32 v107, v78, v1, s12
	v_and_b32_e32 v1, 0x7070707, v83
	v_lshrrev_b32_e32 v78, 4, v83
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[86:87], v[90:91], v[62:65]
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v82, v119, v118, v1
	v_perm_b32 v1, v101, v100, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[86:87], v[106:107], v[74:77]
	v_lshlrev_b32_e32 v86, 4, v83
	v_and_or_b32 v1, v82, v86, v1
	v_perm_b32 v82, v119, v118, v78
	v_perm_b32 v78, v101, v100, v78
	v_and_or_b32 v78, v82, v83, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[88:89], v[90:91], v[66:69]
	v_perm_b32 v82, v78, v1, s50
	v_perm_b32 v83, v78, v1, s12
	v_and_b32_e32 v1, 0x7070707, v79
	v_lshrrev_b32_e32 v78, 4, v79
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v86, v121, v120, v1
	v_lshlrev_b32_e32 v87, 4, v79
	v_perm_b32 v1, v117, v116, v1
	v_and_or_b32 v1, v86, v87, v1
	v_perm_b32 v86, v121, v120, v78
	v_perm_b32 v78, v117, v116, v78
	v_and_or_b32 v79, v86, v79, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[88:89], v[106:107], v[70:73]
	v_perm_b32 v78, v79, v1, s50
	v_perm_b32 v79, v79, v1, s12
	v_and_b32_e32 v1, 0x7070707, v84
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[16:17], v[82:83], v[66:69]
	s_nop 2
	v_lshrrev_b32_e32 v66, 4, v84
	v_and_b32_e32 v66, 0x7070707, v66
	v_perm_b32 v67, v119, v118, v1
	v_lshlrev_b32_e32 v68, 4, v84
	v_perm_b32 v1, v101, v100, v1
	v_and_or_b32 v1, v67, v68, v1
	v_perm_b32 v67, v119, v118, v66
	v_perm_b32 v66, v101, v100, v66
	v_and_or_b32 v66, v67, v84, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[82:83], v[62:65]
	v_lshlrev_b32_e32 v68, 4, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[14:15], v[78:79], v[74:77]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[78:79], v[70:73]
	s_nop 2
	v_perm_b32 v70, v66, v1, s50
	v_perm_b32 v71, v66, v1, s12
	v_and_b32_e32 v1, 0x7070707, v80
	v_lshrrev_b32_e32 v66, 4, v80
	v_and_b32_e32 v66, 0x7070707, v66
	v_perm_b32 v67, v121, v120, v1
	v_perm_b32 v1, v117, v116, v1
	v_and_or_b32 v1, v67, v68, v1
	v_perm_b32 v67, v121, v120, v66
	v_perm_b32 v66, v117, v116, v66
	v_and_or_b32 v66, v67, v80, v66
	v_perm_b32 v78, v66, v1, s50
	v_perm_b32 v79, v66, v1, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[10:11], v[70:71], v[62:65]
	v_and_b32_e32 v1, 0x7070707, v85
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[10:11], v[78:79], v[74:77]
	v_lshrrev_b32_e32 v10, 4, v85
	v_and_b32_e32 v10, 0x7070707, v10
	v_perm_b32 v11, v119, v118, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[12:13], v[70:71], v[86:89]
	v_perm_b32 v1, v101, v100, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[12:13], v[78:79], v[14:17]
	v_lshlrev_b32_e32 v12, 4, v85
	v_and_or_b32 v1, v11, v12, v1
	v_perm_b32 v11, v119, v118, v10
	v_perm_b32 v10, v101, v100, v10
	v_and_or_b32 v11, v11, v85, v10
	v_perm_b32 v10, v11, v1, s50
	v_perm_b32 v11, v11, v1, s12
	v_and_b32_e32 v1, 0x7070707, v81
	v_lshrrev_b32_e32 v12, 4, v81
	v_and_b32_e32 v12, 0x7070707, v12
	v_perm_b32 v13, v121, v120, v1
	v_lshlrev_b32_e32 v14, 4, v81
	v_perm_b32 v1, v117, v116, v1
	v_and_or_b32 v1, v13, v14, v1
	v_perm_b32 v13, v121, v120, v12
	v_perm_b32 v12, v117, v116, v12
	v_and_or_b32 v13, v13, v81, v12
	v_perm_b32 v12, v13, v1, s50
	v_perm_b32 v13, v13, v1, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[6:7], v[10:11], v[62:65]
	v_and_b32_e32 v1, 0x7070707, v54
	scratch_load_dwordx4 v[116:119], off, off offset:64
	v_mov_b32_e32 v86, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[6:7], v[12:13], v[66:69]
	v_lshrrev_b32_e32 v6, 4, v54
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v99, v98, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[8:9], v[10:11], v[70:73]
	v_perm_b32 v1, v97, v96, v1
	v_mov_b32_e32 v87, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[8:9], v[12:13], v[74:77]
	v_lshlrev_b32_e32 v8, 4, v54
	v_and_or_b32 v1, v7, v8, v1
	v_perm_b32 v7, v99, v98, v6
	v_perm_b32 v6, v97, v96, v6
	v_and_or_b32 v6, v7, v54, v6
	v_perm_b32 v78, v6, v1, s50
	v_perm_b32 v79, v6, v1, s12
	v_and_b32_e32 v1, 0x7070707, v50
	v_lshrrev_b32_e32 v6, 4, v50
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v95, v94, v1
	v_lshlrev_b32_e32 v8, 4, v50
	v_perm_b32 v1, v93, v92, v1
	v_and_or_b32 v1, v7, v8, v1
	v_perm_b32 v7, v95, v94, v6
	v_perm_b32 v6, v93, v92, v6
	v_and_or_b32 v7, v7, v50, v6
	v_perm_b32 v6, v7, v1, s50
	v_perm_b32 v7, v7, v1, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[2:3], v[78:79], v[62:65]
	v_and_b32_e32 v1, 0x7070707, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[2:3], v[6:7], v[66:69]
	v_lshrrev_b32_e32 v2, 4, v55
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v99, v98, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[4:5], v[78:79], v[70:73]
	v_perm_b32 v1, v97, v96, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[4:5], v[6:7], v[74:77]
	v_lshlrev_b32_e32 v4, 4, v55
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v99, v98, v2
	v_perm_b32 v2, v97, v96, v2
	v_and_or_b32 v3, v3, v55, v2
	v_perm_b32 v2, v3, v1, s50
	v_perm_b32 v3, v3, v1, s12
	v_and_b32_e32 v1, 0x7070707, v51
	v_lshrrev_b32_e32 v4, 4, v51
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v5, v95, v94, v1
	v_lshlrev_b32_e32 v6, 4, v51
	v_perm_b32 v1, v93, v92, v1
	v_and_or_b32 v1, v5, v6, v1
	v_perm_b32 v5, v95, v94, v4
	v_perm_b32 v4, v93, v92, v4
	v_and_or_b32 v5, v5, v51, v4
	v_perm_b32 v4, v5, v1, s50
	v_perm_b32 v5, v5, v1, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[112:113], v[2:3], v[62:65]
	v_and_b32_e32 v1, 0x7070707, v56
	v_lshlrev_b32_e32 v6, 4, v52
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[104:105], v[2:3], v[70:73]
	v_lshrrev_b32_e32 v2, 4, v56
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v99, v98, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[112:113], v[4:5], v[66:69]
	v_perm_b32 v1, v97, v96, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[104:105], v[4:5], v[74:77]
	v_lshlrev_b32_e32 v4, 4, v56
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v99, v98, v2
	v_perm_b32 v2, v97, v96, v2
	v_and_or_b32 v3, v3, v56, v2
	v_perm_b32 v2, v3, v1, s50
	v_perm_b32 v3, v3, v1, s12
	v_and_b32_e32 v1, 0x7070707, v52
	v_lshrrev_b32_e32 v4, 4, v52
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v5, v95, v94, v1
	v_perm_b32 v1, v93, v92, v1
	v_and_or_b32 v1, v5, v6, v1
	v_perm_b32 v5, v95, v94, v4
	v_perm_b32 v4, v93, v92, v4
	v_and_or_b32 v5, v5, v52, v4
	v_perm_b32 v4, v5, v1, s50
	v_perm_b32 v5, v5, v1, s12
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[108:109], v[2:3], v[62:65]
	v_and_b32_e32 v1, 0x7070707, v57
	scratch_load_dwordx4 v[104:107], off, off offset:48
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[110:111], v[2:3], v[70:73]
	v_lshrrev_b32_e32 v2, 4, v57
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v99, v98, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[108:109], v[4:5], v[66:69]
	v_perm_b32 v1, v97, v96, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[110:111], v[4:5], v[74:77]
	v_lshlrev_b32_e32 v4, 4, v57
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v99, v98, v2
	v_perm_b32 v2, v97, v96, v2
	v_and_or_b32 v2, v3, v57, v2
	v_perm_b32 v50, v2, v1, s50
	v_perm_b32 v51, v2, v1, s12
	v_and_b32_e32 v1, 0x7070707, v53
	v_lshrrev_b32_e32 v2, 4, v53
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v95, v94, v1
	v_lshlrev_b32_e32 v4, 4, v53
	v_perm_b32 v1, v93, v92, v1
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v95, v94, v2
	v_perm_b32 v2, v93, v92, v2
	v_and_or_b32 v2, v3, v53, v2
	v_perm_b32 v52, v2, v1, s50
	v_perm_b32 v53, v2, v1, s12
	scratch_load_dword v1, off, off offset:168
	scratch_load_dwordx4 v[108:111], off, off offset:32
	scratch_load_dwordx4 v[2:5], off, off
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[58:59], v[50:51], v[62:65]
	s_waitcnt vmcnt(2)
	v_lshl_or_b32 v1, s13, 11, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[58:59], v[52:53], v[66:69]
	v_xor_b32_e32 v1, 0x800, v1
	v_lshlrev_b32_e32 v1, 2, v1
	s_waitcnt vmcnt(0)
	ds_write_b128 v1, v[2:5]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[60:61], v[50:51], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[60:61], v[52:53], v[78:81]
	s_cbranch_scc1 .LBB0_2
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v97, off, off offset:96
	scratch_load_dword v95, off, off offset:188
	scratch_load_dword v96, off, off offset:88
	scratch_load_dword v98, off, off offset:84
	s_mov_b32 s40, 0x8080808
	v_lshlrev_b32_e32 v4, 4, v26
	s_mov_b32 s41, 0x5010400
	s_mov_b32 s42, 0x7030602
	v_lshlrev_b32_e32 v6, 4, v30
	s_ashr_i32 s45, s44, 31
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s6
	s_movk_i32 s43, 0x7fff
	s_and_b32 s25, s23, 0xffff
	s_mov_b32 s26, -1
	s_mov_b32 s24, s22
	s_mov_b32 s27, s3
	s_mulk_i32 s11, 0xe00
	s_add_i32 s12, s46, s11
	s_mov_b32 s6, 0x400000
	s_mov_b32 s28, s14
	s_mov_b32 s31, s3
	s_mov_b32 s50, s6
	s_mov_b32 s51, s3
	s_mov_b32 s36, s16
	s_mov_b32 s39, s3
	s_mov_b32 s11, s3
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	scratch_load_dword v99, off, off offset:100
	s_waitcnt vmcnt(4)
	v_sub_u32_sdwa v1, v97, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v2, 11, v1
	v_mul_lo_u32 v2, v2, s40
	v_sub_u32_e32 v3, 0x6c686080, v2
	v_and_b32_e32 v3, 0xffffff00, v3
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v2, 0x7c787470, v2
	s_nop 0
	v_cndmask_b32_e64 v50, v3, 0, vcc
	v_cndmask_b32_e64 v51, v2, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v50
	v_and_b32_e32 v52, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v51
	v_and_b32_e32 v53, 0x80808080, v1
	s_waitcnt vmcnt(2)
	v_sub_u32_sdwa v1, v96, v102 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v2, 11, v1
	v_mul_lo_u32 v2, v2, s40
	v_sub_u32_e32 v3, 0x6c686080, v2
	v_and_b32_e32 v3, 0xffffff00, v3
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v2, 0x7c787470, v2
	s_nop 0
	v_cndmask_b32_e64 v54, v3, 0, vcc
	v_cndmask_b32_e64 v55, v2, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v54
	v_and_b32_e32 v56, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v55
	v_and_b32_e32 v57, 0x80808080, v1
	v_and_b32_e32 v1, 0x7070707, v26
	v_lshrrev_b32_e32 v2, 4, v26
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v53, v52, v1
	v_perm_b32 v1, v51, v50, v1
	v_and_or_b32 v1, v3, v4, v1
	v_perm_b32 v3, v53, v52, v2
	v_perm_b32 v2, v51, v50, v2
	v_and_or_b32 v2, v3, v26, v2
	v_perm_b32 v14, v2, v1, s41
	v_perm_b32 v15, v2, v1, s42
	v_lshrrev_b32_e32 v2, 4, v30
	v_and_b32_e32 v4, 0x7070707, v2
	scratch_load_dword v2, off, off offset:128
	v_and_b32_e32 v1, 0x7070707, v30
	v_perm_b32 v5, v57, v56, v1
	v_perm_b32 v1, v55, v54, v1
	v_perm_b32 v10, v57, v56, v4
	v_perm_b32 v11, v55, v54, v4
	v_or_b32_e32 v4, v95, v122
	v_and_or_b32 v1, v5, v6, v1
	ds_read_b64 v[4:5], v4 offset:8192
	v_and_or_b32 v10, v10, v30, v11
	v_sub_u32_sdwa v30, v97, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v0, 11, v30
	v_mul_lo_u32 v0, v0, s40
	v_cmp_lt_i32_e32 vcc, 11, v30
	s_waitcnt vmcnt(0)
	ds_read_b64 v[2:3], v2 offset:8192
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[2:3], v[14:15], v[34:37]
	s_nop 2
	v_perm_b32 v34, v10, v1, s41
	v_perm_b32 v35, v10, v1, s42
	v_sub_u32_e32 v1, 0x6c686080, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[4:5], v[14:15], v[38:41]
	s_nop 2
	v_and_b32_e32 v38, 0xffffff00, v1
	v_sub_u32_e32 v39, 0x7c787470, v0
	v_and_b32_e32 v0, 0x7070707, v27
	v_lshrrev_b32_e32 v1, 4, v27
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v26, v53, v52, v0
	v_lshlrev_b32_e32 v40, 4, v27
	v_perm_b32 v0, v51, v50, v0
	v_and_or_b32 v26, v26, v40, v0
	v_perm_b32 v0, v53, v52, v1
	v_perm_b32 v1, v51, v50, v1
	v_and_or_b32 v1, v0, v27, v1
	scratch_load_dword v94, off, off offset:80
	scratch_load_dword v27, off, off offset:124
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[2:3], v[34:35], v[46:49]
	v_perm_b32 v0, v1, v26, s41
	v_perm_b32 v1, v1, v26, s42
	v_and_b32_e32 v26, 0x7070707, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[4:5], v[34:35], v[42:45]
	v_perm_b32 v40, v57, v56, v26
	v_lshlrev_b32_e32 v41, 4, v31
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v40, v40, v41, v26
	v_cndmask_b32_e64 v89, v39, 0, vcc
	v_cndmask_b32_e64 v87, v38, 0, vcc
	v_add_u32_e32 v30, 0x7f7f7f00, v87
	v_and_b32_e32 v90, 0x80808000, v30
	v_lshlrev_b32_e32 v30, 4, v32
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v82, v94, v27
	ds_read2st64_b64 v[42:45], v82 offset0:16 offset1:24
	v_lshrrev_b32_e32 v27, 4, v31
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v26, v57, v56, v27
	v_perm_b32 v27, v55, v54, v27
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[42:43], v[0:1], v[6:9]
	v_and_or_b32 v27, v26, v31, v27
	v_perm_b32 v26, v27, v40, s41
	v_perm_b32 v27, v27, v40, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[44:45], v[0:1], v[14:17]
	v_add_u32_e32 v0, 0x7f7f7f78, v89
	v_and_b32_e32 v91, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[42:43], v[26:27], v[10:13]
	v_lshrrev_b32_e32 v1, 4, v28
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[44:45], v[26:27], v[34:37]
	v_perm_b32 v26, v53, v52, v0
	v_lshlrev_b32_e32 v27, 4, v28
	v_perm_b32 v0, v51, v50, v0
	v_and_or_b32 v26, v26, v27, v0
	scratch_load_dword v27, off, off offset:120
	v_perm_b32 v0, v53, v52, v1
	v_perm_b32 v1, v51, v50, v1
	v_and_or_b32 v1, v0, v28, v1
	v_perm_b32 v0, v1, v26, s41
	v_perm_b32 v1, v1, v26, s42
	v_and_b32_e32 v26, 0x7070707, v32
	v_perm_b32 v28, v57, v56, v26
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v28, v28, v30, v26
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v83, v94, v27
	ds_read2st64_b64 v[46:49], v83 offset0:16 offset1:24
	v_lshrrev_b32_e32 v27, 4, v32
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v26, v57, v56, v27
	v_perm_b32 v27, v55, v54, v27
	v_and_or_b32 v27, v26, v32, v27
	v_perm_b32 v26, v27, v28, s41
	v_perm_b32 v27, v27, v28, s42
	v_sub_u32_sdwa v28, v96, v102 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v30, 11, v28
	v_mul_lo_u32 v30, v30, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[46:47], v[0:1], v[6:9]
	v_lshlrev_b32_e32 v32, 4, v33
	v_cmp_lt_i32_e32 vcc, 11, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[48:49], v[0:1], v[14:17]
	v_sub_u32_e32 v0, 0x6c686080, v30
	v_and_b32_e32 v31, 0xffffff00, v0
	v_and_b32_e32 v0, 0x7070707, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[46:47], v[26:27], v[10:13]
	v_lshrrev_b32_e32 v1, 4, v29
	v_and_b32_e32 v1, 0x7070707, v1
	v_sub_u32_e32 v30, 0x7c787470, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[48:49], v[26:27], v[34:37]
	v_perm_b32 v26, v53, v52, v0
	v_lshlrev_b32_e32 v27, 4, v29
	v_perm_b32 v0, v51, v50, v0
	v_and_or_b32 v26, v26, v27, v0
	scratch_load_dword v27, off, off offset:116
	v_perm_b32 v0, v53, v52, v1
	v_perm_b32 v1, v51, v50, v1
	v_and_or_b32 v1, v0, v29, v1
	v_perm_b32 v0, v1, v26, s41
	v_perm_b32 v1, v1, v26, s42
	v_and_b32_e32 v26, 0x7070707, v33
	v_perm_b32 v29, v57, v56, v26
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v29, v29, v32, v26
	v_cndmask_b32_e64 v32, v31, 0, vcc
	v_lshlrev_b32_e32 v31, 4, v18
	v_add_u32_e32 v28, 0x7f7f7f00, v32
	v_and_b32_e32 v92, 0x80808000, v28
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v84, v94, v27
	ds_read2st64_b64 v[50:53], v84 offset0:16 offset1:24
	v_lshrrev_b32_e32 v27, 4, v33
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v26, v57, v56, v27
	v_perm_b32 v27, v55, v54, v27
	v_and_or_b32 v27, v26, v33, v27
	v_cndmask_b32_e64 v33, v30, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[50:51], v[0:1], v[6:9]
	v_perm_b32 v26, v27, v29, s41
	v_perm_b32 v27, v27, v29, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[52:53], v[0:1], v[14:17]
	v_add_u32_e32 v0, 0x7f7f7f78, v33
	v_and_b32_e32 v93, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v18
	v_lshrrev_b32_e32 v1, 4, v18
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v30, v91, v90, v0
	v_perm_b32 v0, v89, v87, v0
	v_and_or_b32 v30, v30, v31, v0
	v_perm_b32 v0, v91, v90, v1
	v_perm_b32 v1, v89, v87, v1
	v_and_or_b32 v1, v0, v18, v1
	v_perm_b32 v0, v1, v30, s41
	v_perm_b32 v1, v1, v30, s42
	scratch_load_dword v30, off, off offset:112
	v_and_b32_e32 v18, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[50:51], v[26:27], v[10:13]
	v_perm_b32 v31, v93, v92, v18
	v_perm_b32 v18, v33, v32, v18
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v85, v94, v30
	ds_read2st64_b64 v[54:57], v85 offset0:16 offset1:24
	v_lshrrev_b32_e32 v30, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[52:53], v[26:27], v[34:37]
	v_and_b32_e32 v30, 0x7070707, v30
	s_nop 1
	v_lshlrev_b32_e32 v34, 4, v22
	v_and_or_b32 v18, v31, v34, v18
	v_perm_b32 v31, v93, v92, v30
	v_perm_b32 v30, v33, v32, v30
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[54:55], v[0:1], v[6:9]
	v_and_or_b32 v22, v31, v22, v30
	v_perm_b32 v30, v22, v18, s41
	v_perm_b32 v31, v22, v18, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[56:57], v[0:1], v[14:17]
	v_and_b32_e32 v0, 0x7070707, v19
	v_lshrrev_b32_e32 v1, 4, v19
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v18, v91, v90, v0
	v_lshlrev_b32_e32 v22, 4, v19
	v_perm_b32 v0, v89, v87, v0
	v_and_or_b32 v18, v18, v22, v0
	v_perm_b32 v0, v91, v90, v1
	v_perm_b32 v1, v89, v87, v1
	v_and_or_b32 v1, v0, v19, v1
	scratch_load_dword v19, off, off offset:108
	v_perm_b32 v0, v1, v18, s41
	v_perm_b32 v1, v1, v18, s42
	v_and_b32_e32 v18, 0x7070707, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[54:55], v[30:31], v[10:13]
	v_perm_b32 v22, v93, v92, v18
	v_perm_b32 v18, v33, v32, v18
	ds_read2st64_b64 v[34:37], v98 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[56:57], v[30:31], v[26:29]
	v_lshlrev_b32_e32 v30, 4, v23
	v_and_or_b32 v22, v22, v30, v18
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v86, v94, v19
	ds_read2st64_b64 v[58:61], v86 offset0:16 offset1:24
	v_lshrrev_b32_e32 v19, 4, v23
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v18, v93, v92, v19
	v_perm_b32 v19, v33, v32, v19
	v_and_or_b32 v19, v18, v23, v19
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[58:59], v[0:1], v[6:9]
	v_perm_b32 v18, v19, v22, s41
	v_perm_b32 v19, v19, v22, s42
	v_lshlrev_b32_e32 v22, 4, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[60:61], v[0:1], v[14:17]
	v_and_b32_e32 v0, 0x7070707, v20
	v_lshrrev_b32_e32 v1, 4, v20
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[58:59], v[18:19], v[10:13]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[60:61], v[18:19], v[26:29]
	v_perm_b32 v18, v91, v90, v0
	v_lshlrev_b32_e32 v19, 4, v20
	v_perm_b32 v0, v89, v87, v0
	v_and_or_b32 v18, v18, v19, v0
	scratch_load_dword v19, off, off offset:104
	v_perm_b32 v0, v91, v90, v1
	v_perm_b32 v1, v89, v87, v1
	v_and_or_b32 v1, v0, v20, v1
	v_perm_b32 v0, v1, v18, s41
	v_perm_b32 v1, v1, v18, s42
	v_and_b32_e32 v18, 0x7070707, v24
	v_perm_b32 v20, v93, v92, v18
	v_perm_b32 v18, v33, v32, v18
	v_and_or_b32 v20, v20, v22, v18
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v88, v94, v19
	ds_read2st64_b64 v[38:41], v88 offset0:16 offset1:24
	v_lshrrev_b32_e32 v19, 4, v24
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v18, v93, v92, v19
	v_perm_b32 v19, v33, v32, v19
	v_and_or_b32 v19, v18, v24, v19
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[38:39], v[0:1], v[6:9]
	v_perm_b32 v18, v19, v20, s41
	v_perm_b32 v19, v19, v20, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[40:41], v[0:1], v[14:17]
	v_and_b32_e32 v0, 0x7070707, v21
	v_lshrrev_b32_e32 v1, 4, v21
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[38:39], v[18:19], v[10:13]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[40:41], v[18:19], v[26:29]
	v_perm_b32 v18, v91, v90, v0
	v_lshlrev_b32_e32 v19, 4, v21
	v_perm_b32 v0, v89, v87, v0
	v_and_or_b32 v18, v18, v19, v0
	v_perm_b32 v0, v91, v90, v1
	v_perm_b32 v1, v89, v87, v1
	v_and_or_b32 v1, v0, v21, v1
	v_perm_b32 v0, v1, v18, s41
	v_perm_b32 v1, v1, v18, s42
	v_and_b32_e32 v18, 0x7070707, v25
	v_lshrrev_b32_e32 v19, 4, v25
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v93, v92, v18
	v_lshlrev_b32_e32 v21, 4, v25
	v_perm_b32 v18, v33, v32, v18
	v_and_or_b32 v18, v20, v21, v18
	v_perm_b32 v20, v93, v92, v19
	scratch_load_dword v93, off, off offset:92
	v_perm_b32 v19, v33, v32, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[34:35], v[0:1], v[6:9]
	v_bfe_u32 v87, v115, s8, 8
	s_mov_b32 s8, s16
	s_add_i32 s16, s12, 1
	v_and_or_b32 v7, v20, v25, v19
	v_bfe_u32 v8, v114, s9, 8
	v_perm_b32 v6, v7, v18, s41
	v_perm_b32 v7, v7, v18, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[36:37], v[0:1], v[14:17]
	v_sub_u32_e32 v1, v99, v8
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_bfe_u32 v0, v115, s4, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[34:35], v[6:7], v[10:13]
	s_and_b32 s9, s17, 0xffff
	s_mov_b32 s37, s9
	s_waitcnt vmcnt(0)
	v_sub_u32_e32 v0, v93, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[6:7], v[78:81]
	v_min_i32_e32 v6, 11, v1
	v_mul_lo_u32 v6, v6, s40
	v_sub_u32_e32 v7, 0x6c686080, v6
	v_and_b32_e32 v7, 0xffffff00, v7
	v_sub_u32_e32 v6, 0x7c787470, v6
	v_cndmask_b32_e64 v78, v7, 0, vcc
	v_cndmask_b32_e64 v79, v6, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v78
	v_and_b32_e32 v80, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v79
	v_and_b32_e32 v81, 0x80808080, v1
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s40
	v_sub_u32_e32 v6, 0x6c686080, v1
	v_and_b32_e32 v6, 0xffffff00, v6
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_lshlrev_b32_e32 v7, 4, v116
	v_cndmask_b32_e64 v89, v6, 0, vcc
	v_cndmask_b32_e64 v90, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v89
	v_and_b32_e32 v91, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v90
	v_and_b32_e32 v92, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v116
	v_lshrrev_b32_e32 v1, 4, v116
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v6, v81, v80, v0
	v_perm_b32 v0, v79, v78, v0
	v_and_or_b32 v0, v6, v7, v0
	v_perm_b32 v6, v81, v80, v1
	v_perm_b32 v1, v79, v78, v1
	v_and_or_b32 v1, v6, v116, v1
	v_perm_b32 v10, v1, v0, s41
	v_perm_b32 v11, v1, v0, s42
	v_and_b32_e32 v0, 0x7070707, v124
	v_bfe_u32 v12, v114, s10, 8
	v_lshrrev_b32_e32 v1, 4, v124
	v_perm_b32 v6, v92, v91, v0
	v_lshlrev_b32_e32 v7, 4, v124
	v_perm_b32 v0, v90, v89, v0
	v_and_b32_e32 v1, 0x7070707, v1
	v_and_or_b32 v0, v6, v7, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[2:3], v[10:11], v[62:65]
	v_perm_b32 v13, v92, v91, v1
	v_perm_b32 v1, v90, v89, v1
	v_and_or_b32 v1, v13, v124, v1
	v_sub_u32_e32 v62, v99, v12
	v_min_i32_e32 v12, 11, v62
	v_mul_lo_u32 v16, v12, s40
	v_perm_b32 v14, v1, v0, s41
	v_perm_b32 v15, v1, v0, s42
	v_sub_u32_e32 v17, 0x6c686080, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[4:5], v[10:11], v[66:69]
	v_and_b32_e32 v63, 0xffffff00, v17
	v_lshlrev_b32_e32 v65, 4, v117
	v_cmp_lt_i32_e32 vcc, 11, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[2:3], v[14:15], v[74:77]
	v_lshlrev_b32_e32 v67, 4, v125
	s_mov_b32 s10, 0x800000
	s_mov_b32 s38, s10
	v_sub_u32_e32 v74, 0x7c787470, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[4:5], v[14:15], v[70:73]
	v_and_b32_e32 v4, 0x7070707, v117
	v_lshrrev_b32_e32 v5, 4, v117
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v64, v81, v80, v4
	v_perm_b32 v4, v79, v78, v4
	v_and_or_b32 v4, v64, v65, v4
	v_perm_b32 v64, v81, v80, v5
	v_perm_b32 v5, v79, v78, v5
	v_and_or_b32 v5, v64, v117, v5
	v_perm_b32 v64, v5, v4, s41
	v_perm_b32 v65, v5, v4, s42
	v_and_b32_e32 v4, 0x7070707, v125
	v_lshrrev_b32_e32 v5, 4, v125
	v_and_b32_e32 v5, 0x7070707, v5
	v_perm_b32 v66, v92, v91, v4
	v_perm_b32 v4, v90, v89, v4
	v_and_or_b32 v66, v66, v67, v4
	v_perm_b32 v67, v92, v91, v5
	v_perm_b32 v68, v90, v89, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[4:7], v[42:43], v[64:65], v[6:9]
	s_nop 2
	v_and_or_b32 v8, v67, v125, v68
	v_perm_b32 v70, v8, v66, s41
	v_perm_b32 v71, v8, v66, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[8:11], v[44:45], v[64:65], v[10:13]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[42:43], v[70:71], v[0:3]
	v_lshlrev_b32_e32 v42, 4, v126
	s_nop 1
	v_cndmask_b32_e64 v1, v63, 0, vcc
	v_cndmask_b32_e64 v63, v74, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v1
	v_and_b32_e32 v64, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v63
	v_and_b32_e32 v65, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v118
	v_lshrrev_b32_e32 v2, 4, v118
	v_mfma_f32_16x16x32_fp8_fp8 v[12:15], v[44:45], v[70:71], v[14:17]
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v81, v80, v0
	v_perm_b32 v0, v79, v78, v0
	v_lshlrev_b32_e32 v16, 4, v118
	v_and_or_b32 v0, v3, v16, v0
	v_perm_b32 v3, v81, v80, v2
	v_perm_b32 v2, v79, v78, v2
	v_and_or_b32 v2, v3, v118, v2
	v_perm_b32 v16, v2, v0, s41
	v_perm_b32 v17, v2, v0, s42
	v_and_b32_e32 v0, 0x7070707, v126
	v_lshrrev_b32_e32 v2, 4, v126
	v_and_b32_e32 v2, 0x7070707, v2
	v_perm_b32 v3, v92, v91, v0
	v_perm_b32 v0, v90, v89, v0
	v_and_or_b32 v0, v3, v42, v0
	v_perm_b32 v42, v92, v91, v2
	v_perm_b32 v43, v90, v89, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[46:47], v[16:17], v[4:7]
	s_nop 2
	v_and_or_b32 v6, v42, v126, v43
	v_perm_b32 v70, v6, v0, s41
	v_perm_b32 v71, v6, v0, s42
	v_sub_u32_e32 v0, v93, v87
	v_min_i32_e32 v6, 11, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[46:47], v[70:71], v[66:69]
	v_mul_lo_u32 v46, v6, s40
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_mov_b32_e32 v87, 0xfd800000
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[48:49], v[16:17], v[8:11]
	v_lshlrev_b32_e32 v17, 4, v119
	v_sub_u32_e32 v66, 0x7c787470, v46
	s_nop 0
	v_sub_u32_e32 v10, 0x6c686080, v46
	v_and_b32_e32 v62, 0xffffff00, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[48:49], v[70:71], v[12:15]
	v_cndmask_b32_e64 v0, v62, 0, vcc
	v_cndmask_b32_e64 v62, v66, 0, vcc
	v_cmp_lt_i32_e32 vcc, 5, v99
	v_and_b32_e32 v14, 0x7070707, v119
	v_lshrrev_b32_e32 v15, 4, v119
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v81, v80, v14
	v_perm_b32 v14, v79, v78, v14
	v_and_or_b32 v14, v16, v17, v14
	v_perm_b32 v16, v81, v80, v15
	v_perm_b32 v15, v79, v78, v15
	v_and_or_b32 v15, v16, v119, v15
	v_perm_b32 v46, v15, v14, s41
	v_perm_b32 v47, v15, v14, s42
	v_and_b32_e32 v14, 0x7070707, v127
	v_lshrrev_b32_e32 v15, 4, v127
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v92, v91, v14
	v_lshlrev_b32_e32 v17, 4, v127
	v_perm_b32 v14, v90, v89, v14
	v_and_or_b32 v14, v16, v17, v14
	v_perm_b32 v16, v92, v91, v15
	v_perm_b32 v15, v90, v89, v15
	scratch_load_dword v90, off, off offset:180
	v_and_or_b32 v15, v16, v127, v15
	v_perm_b32 v48, v15, v14, s41
	v_perm_b32 v49, v15, v14, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[50:51], v[46:47], v[2:5]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[50:51], v[48:49], v[42:45]
	s_nop 2
	v_add_u32_e32 v42, 0x7f7f7f00, v0
	v_and_b32_e32 v50, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v62
	v_and_b32_e32 v51, 0x80808080, v42
	v_and_b32_e32 v42, 0x7070707, v108
	v_lshrrev_b32_e32 v43, 4, v108
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v65, v64, v42
	v_lshlrev_b32_e32 v45, 4, v108
	v_perm_b32 v42, v63, v1, v42
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v65, v64, v43
	v_perm_b32 v43, v63, v1, v43
	v_and_or_b32 v43, v42, v108, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[52:53], v[46:47], v[6:9]
	v_perm_b32 v42, v43, v44, s41
	v_perm_b32 v43, v43, v44, s42
	v_and_b32_e32 v44, 0x7070707, v104
	v_lshrrev_b32_e32 v45, 4, v104
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[52:53], v[48:49], v[10:13]
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v46, v51, v50, v44
	v_lshlrev_b32_e32 v47, 4, v104
	v_perm_b32 v44, v62, v0, v44
	v_and_or_b32 v46, v46, v47, v44
	v_perm_b32 v44, v51, v50, v45
	v_perm_b32 v45, v62, v0, v45
	v_and_or_b32 v45, v44, v104, v45
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[54:55], v[42:43], v[2:5]
	v_perm_b32 v44, v45, v46, s41
	v_perm_b32 v45, v45, v46, s42
	v_lshlrev_b32_e32 v47, 4, v105
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[56:57], v[42:43], v[6:9]
	v_and_b32_e32 v42, 0x7070707, v109
	v_lshrrev_b32_e32 v43, 4, v109
	v_and_b32_e32 v43, 0x7070707, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[54:55], v[44:45], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[56:57], v[44:45], v[10:13]
	v_perm_b32 v44, v65, v64, v42
	v_lshlrev_b32_e32 v45, 4, v109
	v_perm_b32 v42, v63, v1, v42
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v65, v64, v43
	v_perm_b32 v43, v63, v1, v43
	v_and_or_b32 v43, v42, v109, v43
	v_perm_b32 v42, v43, v44, s41
	v_perm_b32 v43, v43, v44, s42
	v_and_b32_e32 v44, 0x7070707, v105
	v_lshrrev_b32_e32 v45, 4, v105
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v46, v51, v50, v44
	v_perm_b32 v44, v62, v0, v44
	v_and_or_b32 v46, v46, v47, v44
	v_perm_b32 v44, v51, v50, v45
	v_perm_b32 v45, v62, v0, v45
	v_and_or_b32 v45, v44, v105, v45
	v_perm_b32 v44, v45, v46, s41
	v_perm_b32 v45, v45, v46, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[58:59], v[42:43], v[2:5]
	v_mov_b32_e32 v57, 0
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v56, 2, v90
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[60:61], v[44:45], v[10:13]
	s_nop 2
	v_and_b32_e32 v10, 0x7070707, v110
	v_lshrrev_b32_e32 v11, 4, v110
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v65, v64, v10
	v_lshlrev_b32_e32 v13, 4, v110
	v_perm_b32 v10, v63, v1, v10
	v_and_or_b32 v10, v12, v13, v10
	v_perm_b32 v12, v65, v64, v11
	v_perm_b32 v11, v63, v1, v11
	v_and_or_b32 v11, v12, v110, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[58:59], v[44:45], v[14:17]
	v_or_b32_e32 v58, s44, v56
	v_lshlrev_b32_e32 v13, 4, v106
	v_ashrrev_i32_e32 v59, 31, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[60:61], v[42:43], v[6:9]
	v_perm_b32 v42, v11, v10, s41
	v_perm_b32 v43, v11, v10, s42
	v_and_b32_e32 v10, 0x7070707, v106
	v_lshrrev_b32_e32 v11, 4, v106
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v51, v50, v10
	v_perm_b32 v10, v62, v0, v10
	v_and_or_b32 v44, v12, v13, v10
	v_perm_b32 v45, v51, v50, v11
	v_perm_b32 v52, v62, v0, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[38:39], v[42:43], v[2:5]
	s_nop 2
	v_lshl_add_u64 v[4:5], v[58:59], 2, s[20:21]
	global_load_dword v59, v[4:5], off
	v_and_or_b32 v3, v45, v106, v52
	v_perm_b32 v2, v3, v44, s41
	v_perm_b32 v3, v3, v44, s42
	v_lshl_add_u64 v[4:5], s[44:45], 0, v[56:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[40:41], v[42:43], v[6:9]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[38:39], v[2:3], v[14:17]
	s_nop 1
	v_lshl_add_u64 v[6:7], v[4:5], 2, s[20:21]
	v_lshlrev_b32_e32 v5, 4, v111
	global_load_dwordx3 v[54:56], v[6:7], off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[40:41], v[2:3], v[46:49]
	v_and_b32_e32 v2, 0x7070707, v111
	v_lshrrev_b32_e32 v3, 4, v111
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v65, v64, v2
	v_perm_b32 v2, v63, v1, v2
	v_and_or_b32 v4, v4, v5, v2
	v_perm_b32 v2, v65, v64, v3
	v_perm_b32 v1, v63, v1, v3
	v_and_or_b32 v1, v2, v111, v1
	v_perm_b32 v2, v1, v4, s41
	v_perm_b32 v3, v1, v4, s42
	v_and_b32_e32 v1, 0x7070707, v107
	v_lshrrev_b32_e32 v4, 4, v107
	v_and_b32_e32 v4, 0x7070707, v4
	v_perm_b32 v5, v51, v50, v1
	v_lshlrev_b32_e32 v8, 4, v107
	v_perm_b32 v1, v62, v0, v1
	v_and_or_b32 v1, v5, v8, v1
	v_perm_b32 v5, v51, v50, v4
	v_perm_b32 v0, v62, v0, v4
	v_and_or_b32 v4, v5, v107, v0
	global_load_dwordx4 v[50:53], v[6:7], off offset:64
	v_perm_b32 v0, v4, v1, s41
	v_perm_b32 v1, v4, v1, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[34:35], v[2:3], v[10:13]
	v_mov_b32_e32 v62, v26
	s_and_b32 s21, s21, 0xffff
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v4, 2, v59
	v_and_b32_e32 v4, 0x3fffffc, v4
	buffer_load_dword v60, v4, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[36:37], v[2:3], v[42:45]
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v2, 2, v54
	v_and_b32_e32 v2, 0x3fffffc, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[34:35], v[0:1], v[14:17]
	buffer_load_dword v42, v2, s[0:3], 0 offen
	v_add_u32_e32 v35, 17, v96
	v_lshlrev_b32_e64 v35, v35, 1
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[36:37], v[0:1], v[46:49]
	v_add_u32_e32 v0, 17, v99
	v_lshl_add_u32 v15, v99, 23, v87
	v_lshlrev_b32_e64 v0, v0, 1
	v_add_u32_e32 v1, 17, v97
	v_cndmask_b32_e32 v15, v0, v15, vcc
	v_lshlrev_b32_e32 v0, 2, v55
	v_lshl_add_u32 v14, v97, 23, v87
	v_lshlrev_b32_e64 v1, v1, 1
	v_cmp_lt_i32_e32 vcc, 5, v97
	v_and_b32_e32 v0, 0x3fffffc, v0
	buffer_load_dword v34, v0, s[0:3], 0 offen
	v_cndmask_b32_e32 v14, v1, v14, vcc
	v_lshlrev_b32_e32 v0, 2, v56
	v_and_b32_e32 v0, 0x3fffffc, v0
	scratch_load_dword v47, off, off offset:172
	v_add_u32_e32 v17, 17, v93
	s_waitcnt vmcnt(4)
	v_lshlrev_b32_e32 v1, 2, v50
	v_lshlrev_b32_e32 v16, 2, v51
	v_lshlrev_b32_e32 v36, 2, v52
	v_lshlrev_b32_e32 v37, 2, v53
	v_and_b32_e32 v1, 0x3fffffc, v1
	v_and_b32_e32 v16, 0x3fffffc, v16
	v_and_b32_e32 v36, 0x3fffffc, v36
	v_and_b32_e32 v37, 0x3fffffc, v37
	buffer_load_dword v50, v0, s[0:3], 0 offen
	buffer_load_dword v48, v1, s[0:3], 0 offen
	buffer_load_dword v46, v16, s[0:3], 0 offen
	buffer_load_dword v44, v36, s[0:3], 0 offen
	s_nop 0
	buffer_load_dword v16, v37, s[0:3], 0 offen
	v_mov_b32_e32 v36, v30
	v_mov_b32_e32 v37, v38
	s_mov_b32 s0, 0xbfb8aa3b
	v_lshlrev_b32_e64 v17, v17, 1
	v_cmp_lt_i32_e32 vcc, 5, v93
	v_lshl_add_u32 v30, v96, 23, v87
	v_mov_b32_e32 v63, v10
	v_mov_b32_e32 v38, v31
	s_lshl_b32 s2, s48, 2
	s_waitcnt vmcnt(8)
	v_pk_mul_f32 v[0:1], v[60:61], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[52:53], v[36:37], v[0:1]
	s_waitcnt vmcnt(5)
	v_and_b32_e32 v116, 15, v47
	v_pk_mul_f32 v[0:1], v[52:53], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v36, v0
	scratch_load_dword v0, off, off offset:196
	v_exp_f32_e32 v37, v1
	v_lshlrev_b32_e32 v1, 10, v90
	v_pk_add_f32 v[36:37], v[36:37], 1.0 op_sel_hi:[1,0]
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v89, v0, v1
	v_rcp_f32_e32 v54, v36
	v_rcp_f32_e32 v55, v37
	v_lshl_add_u32 v36, v93, 23, v87
	v_cndmask_b32_e32 v37, v17, v36, vcc
	v_cmp_lt_i32_e32 vcc, 5, v96
	v_pk_mul_f32 v[52:53], v[52:53], v[54:55]
	v_lshlrev_b32_e32 v0, 1, v89
	v_cndmask_b32_e32 v36, v35, v30, vcc
	v_pk_mul_f32 v[60:61], v[60:61], v[36:37] op_sel_hi:[0,1]
	v_pk_mul_f32 v[60:61], v[62:63], v[60:61]
	s_nop 0
	v_pk_mul_f32 v[52:53], v[60:61], v[52:53]
	s_nop 0
	v_bfe_u32 v10, v53, 16, 1
	v_add3_u32 v10, v10, v53, s43
	v_or_b32_e32 v17, 0x400000, v53
	v_cmp_u_f32_e32 vcc, v53, v53
	v_or_b32_e32 v26, 0x400000, v52
	s_nop 0
	v_cndmask_b32_e32 v10, v10, v17, vcc
	v_bfe_u32 v17, v52, 16, 1
	v_add3_u32 v17, v17, v52, s43
	v_cmp_u_f32_e32 vcc, v52, v52
	v_pk_mul_f32 v[52:53], v[42:43], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[30:31], v[38:39], v[52:53]
	v_cndmask_b32_e32 v17, v17, v26, vcc
	v_pk_mul_f32 v[38:39], v[30:31], s[0:1] op_sel_hi:[1,0]
	ds_write_b16_d16_hi v0, v17 offset:16384
	v_exp_f32_e32 v38, v38
	v_exp_f32_e32 v39, v39
	v_add_u32_e32 v17, s5, v116
	v_add_lshl_u32 v1, v17, v1, 1
	ds_write_b16_d16_hi v1, v10 offset:16416
	v_pk_add_f32 v[38:39], v[38:39], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[42:43], v[42:43], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v38, v38
	v_rcp_f32_e32 v39, v39
	v_mov_b32_e32 v10, v27
	v_pk_mul_f32 v[10:11], v[10:11], v[42:43]
	v_pk_mul_f32 v[26:27], v[30:31], v[38:39]
	v_mov_b32_e32 v30, v32
	v_pk_mul_f32 v[10:11], v[10:11], v[26:27]
	v_mov_b32_e32 v31, v40
	v_bfe_u32 v17, v11, 16, 1
	v_add3_u32 v17, v17, v11, s43
	v_or_b32_e32 v26, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v35, 0x400000, v10
	v_mov_b32_e32 v40, v33
	v_cndmask_b32_e32 v11, v17, v26, vcc
	v_pk_mul_f32 v[26:27], v[34:35], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_bfe_u32 v17, v10, 16, 1
	v_pk_mul_f32 v[30:31], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v17, v17, v10, s43
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cmp_u_f32_e32 vcc, v10, v10
	v_lshrrev_b32_e32 v38, 5, v47
	v_lshlrev_b32_e32 v39, 1, v47
	v_cndmask_b32_e32 v10, v17, v35, vcc
	ds_write_b16_d16_hi v1, v10 offset:16896
	ds_write_b16_d16_hi v1, v11 offset:16928
	v_pk_add_f32 v[10:11], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[34:35], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mov_b32_e32 v34, v28
	v_mov_b32_e32 v35, v12
	v_pk_mul_f32 v[30:31], v[34:35], v[30:31]
	v_pk_mul_f32 v[10:11], v[26:27], v[10:11]
	v_pk_mul_f32 v[26:27], v[50:51], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[30:31], v[10:11]
	v_pk_mul_f32 v[26:27], v[40:41], v[26:27]
	v_bfe_u32 v12, v11, 16, 1
	v_pk_mul_f32 v[30:31], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v12, v12, v11, s43
	v_or_b32_e32 v17, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v11, v12, v17, vcc
	v_bfe_u32 v12, v10, 16, 1
	v_add3_u32 v12, v12, v10, s43
	v_or_b32_e32 v17, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	v_and_b32_e32 v92, 62, v39
	v_or_b32_e32 v39, s44, v38
	v_cndmask_b32_e32 v10, v12, v17, vcc
	ds_write_b16_d16_hi v1, v10 offset:17408
	ds_write_b16_d16_hi v1, v11 offset:17440
	v_pk_add_f32 v[10:11], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[50:51], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mov_b32_e32 v12, v29
	v_pk_mul_f32 v[12:13], v[12:13], v[30:31]
	v_mov_b32_e32 v29, v2
	v_pk_mul_f32 v[10:11], v[26:27], v[10:11]
	v_mov_b32_e32 v26, v22
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11]
	v_mov_b32_e32 v27, v6
	v_bfe_u32 v12, v11, 16, 1
	v_add3_u32 v12, v12, v11, s43
	v_or_b32_e32 v13, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v28, 0x400000, v10
	s_nop 0
	v_cndmask_b32_e32 v11, v12, v13, vcc
	v_bfe_u32 v12, v10, 16, 1
	v_add3_u32 v17, v12, v10, s43
	v_pk_mul_f32 v[12:13], v[48:49], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[26:27], v[12:13]
	v_cmp_u_f32_e32 vcc, v10, v10
	v_pk_mul_f32 v[26:27], v[12:13], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v6, v17, v28, vcc
	ds_write_b16_d16_hi v1, v6 offset:17920
	ds_write_b16_d16_hi v1, v11 offset:17952
	v_mov_b32_e32 v28, v18
	v_pk_add_f32 v[10:11], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[48:49], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_pk_mul_f32 v[26:27], v[28:29], v[26:27]
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11]
	v_pk_mul_f32 v[12:13], v[46:47], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[26:27], v[10:11]
	s_nop 0
	v_bfe_u32 v2, v11, 16, 1
	v_add3_u32 v2, v2, v11, s43
	v_or_b32_e32 v6, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v17, 0x400000, v10
	s_nop 0
	v_cndmask_b32_e32 v2, v2, v6, vcc
	v_bfe_u32 v6, v10, 16, 1
	v_add3_u32 v11, v6, v10, s43
	v_mov_b32_e32 v6, v23
	v_pk_mul_f32 v[6:7], v[6:7], v[12:13]
	v_cmp_u_f32_e32 vcc, v10, v10
	v_pk_mul_f32 v[12:13], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v12, v12
	v_exp_f32_e32 v13, v13
	v_cndmask_b32_e32 v10, v11, v17, vcc
	ds_write_b16_d16_hi v1, v10 offset:24576
	ds_write_b16_d16_hi v1, v2 offset:24608
	v_mov_b32_e32 v2, v19
	v_pk_add_f32 v[10:11], v[12:13], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[12:13], v[46:47], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_pk_mul_f32 v[2:3], v[2:3], v[12:13]
	v_pk_mul_f32 v[6:7], v[6:7], v[10:11]
	v_mov_b32_e32 v10, v24
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	v_mov_b32_e32 v11, v8
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s43
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v13, 0x400000, v2
	v_mov_b32_e32 v8, v25
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v12, v6, v2, s43
	v_pk_mul_f32 v[6:7], v[44:45], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_pk_mul_f32 v[10:11], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_cndmask_b32_e32 v2, v12, v13, vcc
	ds_write_b16_d16_hi v1, v2 offset:25088
	ds_write_b16_d16_hi v1, v3 offset:25120
	v_mov_b32_e32 v12, v20
	v_pk_add_f32 v[2:3], v[10:11], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[10:11], v[44:45], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v13, v4
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[10:11], v[2:3]
	s_nop 0
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s43
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v10, 0x400000, v2
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v6, vcc
	v_pk_mul_f32 v[6:7], v[16:17], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_bfe_u32 v4, v2, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v4, v4, v2, s43
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v2, v2
	s_lshl_b32 s0, s48, 8
	s_mov_b32 s1, 0x43700000
	v_cndmask_b32_e32 v2, v4, v10, vcc
	ds_write_b16_d16_hi v1, v2 offset:25600
	ds_write_b16_d16_hi v1, v3 offset:25632
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[16:17], v[36:37] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v4, v21
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[4:5], v[2:3]
	s_nop 0
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s43
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s43
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
	ds_write_b16_d16_hi v1, v2 offset:26112
	ds_write_b16_d16_hi v1, v3 offset:26144
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v14, off, off offset:192
	v_mov_b32_e32 v3, 0x7fc00000
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v2, 2, v14
	v_or_b32_e32 v1, s0, v2
	v_lshlrev_b32_e32 v1, 1, v1
	ds_read_b64 v[4:5], v1 offset:16384
	s_waitcnt lgkmcnt(0)
	v_lshlrev_b32_e32 v8, 16, v4
	v_max_f32_e64 v1, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	v_and_b32_e32 v9, 0xffff0000, v4
	v_lshlrev_b32_e32 v6, 16, v5
	v_cndmask_b32_e32 v1, v3, v1, vcc
	v_max_f32_e64 v4, v1, |v9|
	v_cmp_o_f32_e64 vcc, v1, |v9|
	v_and_b32_e32 v7, 0xffff0000, v5
	s_nop 0
	v_cndmask_b32_e32 v1, v3, v4, vcc
	v_max_f32_e64 v4, v1, |v6|
	v_cmp_o_f32_e64 vcc, v1, |v6|
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v4, vcc
	v_max_f32_e64 v4, v1, |v7|
	v_cmp_o_f32_e64 vcc, v1, |v7|
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v4, vcc
	ds_swizzle_b32 v4, v1 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v1, v4
	v_cmp_o_f32_e32 vcc, v1, v4
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v5, vcc
	ds_swizzle_b32 v4, v1 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v1, v4
	v_cmp_o_f32_e32 vcc, v1, v4
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v5, vcc
	ds_swizzle_b32 v4, v1 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v1, v4
	v_cmp_o_f32_e32 vcc, v1, v4
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v5, vcc
	ds_swizzle_b32 v4, v1 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v1, v4
	v_cmp_o_f32_e32 vcc, v1, v4
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v5, vcc
	ds_swizzle_b32 v4, v1 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v1, v4
	v_cmp_o_f32_e32 vcc, v1, v4
	v_xor_b32_e32 v4, 0x80, v2
	s_nop 0
	v_cndmask_b32_e32 v1, v3, v5, vcc
	ds_bpermute_b32 v5, v4, v1
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v1, v5
	v_cmp_o_f32_e32 vcc, v1, v5
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v10, vcc
	v_div_scale_f32 v5, s[4:5], s1, s1, v1
	v_rcp_f32_e32 v10, v5
	s_nop 0
	v_fma_f32 v11, -v5, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, v1, s1, v1
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v5, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v5, -v5, v12, v11
	v_div_fmas_f32 v5, v5, v10, v12
	v_div_fixup_f32 v5, v5, s1, v1
	v_cmp_neq_f32_e32 vcc, 0, v1
	s_nop 1
	v_cndmask_b32_e32 v1, 1.0, v5, vcc
	v_div_scale_f32 v5, s[4:5], v1, v1, 1.0
	v_rcp_f32_e32 v10, v5
	s_nop 0
	v_fma_f32 v11, -v5, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, 1.0, v1, 1.0
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v5, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v5, -v5, v12, v11
	v_div_fmas_f32 v5, v5, v10, v12
	v_div_fixup_f32 v10, v5, v1, 1.0
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v5, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	s_nop 0
	v_cndmask_b32_e32 v5, v3, v5, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_max_f32_e32 v9, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v9, vcc
	v_min_f32_e32 v9, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v9, vcc
	v_max_f32_e32 v9, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v9, vcc
	v_min_f32_e32 v9, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v9, vcc
	v_mov_b32_e32 v9, v57
	v_cvt_pk_fp8_f32 v9, v5, v8
	v_max_f32_e32 v5, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v5, vcc
	v_cvt_pk_fp8_f32 v9, v6, v5 op_sel:[0,0,1]
	v_mov_b32_e32 v5, s2
	ds_write_b32 v5, v1 offset:8192
	s_lshl_b32 s2, s48, 4
	v_and_b32_e32 v1, 0x7f7f7f7f, v9
	v_add_u32_e32 v1, 0x7f7f7f7f, v1
	v_or_b32_e32 v1, 0x7f7f7f7f, v1
	s_and_b32 s2, s2, 0xf0
	v_and_b32_e32 v6, v1, v9
	v_xor_b32_e32 v1, s2, v2
	v_or_b32_e32 v1, s0, v1
	ds_write_b32 v1, v6
	s_add_i32 s2, s48, 8
	v_lshlrev_b32_e32 v6, 3, v14
	v_lshl_or_b32 v7, s2, 9, v6
	ds_read_b64 v[8:9], v7 offset:16384
	s_lshl_b32 s2, s2, 4
	s_and_b32 s2, s2, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v11, 0xffff0000, v9
	v_lshlrev_b32_e32 v10, 16, v9
	v_and_b32_e32 v9, 0xffff0000, v8
	v_lshlrev_b32_e32 v8, 16, v8
	v_max_f32_e64 v7, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v7, vcc
	v_max_f32_e64 v12, v7, |v9|
	v_cmp_o_f32_e64 vcc, v7, |v9|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v12, vcc
	v_max_f32_e64 v12, v7, |v10|
	v_cmp_o_f32_e64 vcc, v7, |v10|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v12, vcc
	v_max_f32_e64 v12, v7, |v11|
	v_cmp_o_f32_e64 vcc, v7, |v11|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v12, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_bpermute_b32 v12, v4, v7
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	v_div_scale_f32 v12, s[4:5], s1, s1, v7
	v_rcp_f32_e32 v13, v12
	s_nop 0
	v_fma_f32 v14, -v12, v13, 1.0
	v_fmac_f32_e32 v13, v14, v13
	v_div_scale_f32 v14, vcc, v7, s1, v7
	v_mul_f32_e32 v15, v14, v13
	v_fma_f32 v16, -v12, v15, v14
	v_fmac_f32_e32 v15, v16, v13
	v_fma_f32 v12, -v12, v15, v14
	v_div_fmas_f32 v12, v12, v13, v15
	v_div_fixup_f32 v12, v12, s1, v7
	v_cmp_neq_f32_e32 vcc, 0, v7
	s_nop 1
	v_cndmask_b32_e32 v7, 1.0, v12, vcc
	v_div_scale_f32 v12, s[4:5], v7, v7, 1.0
	v_rcp_f32_e32 v13, v12
	ds_write_b32 v5, v7 offset:8224
	v_fma_f32 v14, -v12, v13, 1.0
	v_fmac_f32_e32 v13, v14, v13
	v_div_scale_f32 v14, vcc, 1.0, v7, 1.0
	v_mul_f32_e32 v15, v14, v13
	v_fma_f32 v16, -v12, v15, v14
	v_fmac_f32_e32 v15, v16, v13
	v_fma_f32 v12, -v12, v15, v14
	v_div_fmas_f32 v12, v12, v13, v15
	v_div_fixup_f32 v12, v12, v7, 1.0
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11] op_sel_hi:[0,1]
	v_min_f32_e32 v12, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v12, vcc
	v_max_f32_e32 v12, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v12, vcc
	v_min_f32_e32 v12, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v12, vcc
	v_max_f32_e32 v12, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v12, vcc
	v_min_f32_e32 v12, 0x43700000, v10
	v_cmp_o_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_max_f32_e32 v12, 0xc3700000, v10
	v_cmp_o_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_min_f32_e32 v12, 0x43700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v11, v3, v12, vcc
	v_mov_b32_e32 v12, v57
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	v_xor_b32_e32 v8, s2, v2
	s_lshl_b32 s2, s48, 9
	v_or_b32_e32 v8, s0, v8
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	s_addk_i32 s2, 0x2000
	ds_write_b32 v8, v7 offset:2048
	v_or_b32_e32 v7, s2, v6
	ds_read_b64 v[8:9], v7 offset:16384
	s_add_i32 s48, s48, 24
	s_brev_b32 s2, 16
	s_mov_b32 s30, s2
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v11, 0xffff0000, v9
	v_lshlrev_b32_e32 v10, 16, v9
	v_and_b32_e32 v9, 0xffff0000, v8
	v_lshlrev_b32_e32 v8, 16, v8
	v_max_f32_e64 v7, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v7, vcc
	v_max_f32_e64 v12, v7, |v9|
	v_cmp_o_f32_e64 vcc, v7, |v9|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v12, vcc
	v_max_f32_e64 v12, v7, |v10|
	v_cmp_o_f32_e64 vcc, v7, |v10|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v12, vcc
	v_max_f32_e64 v12, v7, |v11|
	v_cmp_o_f32_e64 vcc, v7, |v11|
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v12, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_swizzle_b32 v12, v7 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	ds_bpermute_b32 v12, v4, v7
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v13, v7, v12
	v_cmp_o_f32_e32 vcc, v7, v12
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v13, vcc
	v_div_scale_f32 v12, s[4:5], s1, s1, v7
	v_rcp_f32_e32 v13, v12
	s_nop 0
	v_fma_f32 v14, -v12, v13, 1.0
	v_fmac_f32_e32 v13, v14, v13
	v_div_scale_f32 v14, vcc, v7, s1, v7
	v_mul_f32_e32 v15, v14, v13
	v_fma_f32 v16, -v12, v15, v14
	v_fmac_f32_e32 v15, v16, v13
	v_fma_f32 v12, -v12, v15, v14
	v_div_fmas_f32 v12, v12, v13, v15
	v_div_fixup_f32 v12, v12, s1, v7
	v_cmp_neq_f32_e32 vcc, 0, v7
	s_nop 1
	v_cndmask_b32_e32 v7, 1.0, v12, vcc
	v_div_scale_f32 v12, s[4:5], v7, v7, 1.0
	v_rcp_f32_e32 v13, v12
	ds_write_b32 v5, v7 offset:8256
	v_fma_f32 v14, -v12, v13, 1.0
	v_fmac_f32_e32 v13, v14, v13
	v_div_scale_f32 v14, vcc, 1.0, v7, 1.0
	v_mul_f32_e32 v15, v14, v13
	v_fma_f32 v16, -v12, v15, v14
	v_fmac_f32_e32 v15, v16, v13
	v_fma_f32 v12, -v12, v15, v14
	v_div_fmas_f32 v12, v12, v13, v15
	v_div_fixup_f32 v12, v12, v7, 1.0
	v_pk_mul_f32 v[8:9], v[12:13], v[8:9] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11] op_sel_hi:[0,1]
	v_min_f32_e32 v12, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v12, vcc
	v_max_f32_e32 v12, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v12, vcc
	v_min_f32_e32 v12, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v12, vcc
	v_max_f32_e32 v12, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v12, vcc
	v_min_f32_e32 v12, 0x43700000, v10
	v_cmp_o_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_max_f32_e32 v12, 0xc3700000, v10
	v_cmp_o_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_min_f32_e32 v12, 0x43700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v11, v3, v12, vcc
	v_mov_b32_e32 v12, v57
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	ds_write_b32 v1, v7 offset:4096
	v_lshl_or_b32 v1, s48, 9, v6
	ds_read_b64 v[6:7], v1 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v9, 0xffff0000, v7
	v_lshlrev_b32_e32 v8, 16, v7
	v_and_b32_e32 v7, 0xffff0000, v6
	v_lshlrev_b32_e32 v6, 16, v6
	v_max_f32_e64 v1, |v6|, 0
	v_cmp_o_f32_e64 vcc, |v6|, |v6|
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v1, vcc
	v_max_f32_e64 v10, v1, |v7|
	v_cmp_o_f32_e64 vcc, v1, |v7|
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v10, vcc
	v_max_f32_e64 v10, v1, |v8|
	v_cmp_o_f32_e64 vcc, v1, |v8|
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v10, vcc
	v_max_f32_e64 v10, v1, |v9|
	v_cmp_o_f32_e64 vcc, v1, |v9|
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v10, vcc
	ds_swizzle_b32 v10, v1 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	ds_swizzle_b32 v10, v1 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	ds_swizzle_b32 v10, v1 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	ds_swizzle_b32 v10, v1 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	ds_swizzle_b32 v10, v1 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	ds_bpermute_b32 v4, v4, v1
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v1, v4
	v_cmp_o_f32_e32 vcc, v1, v4
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v10, vcc
	v_div_scale_f32 v4, s[4:5], s1, s1, v1
	v_rcp_f32_e32 v10, v4
	s_nop 0
	v_fma_f32 v11, -v4, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, v1, s1, v1
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v4, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v4, -v4, v12, v11
	v_div_fmas_f32 v4, v4, v10, v12
	v_div_fixup_f32 v4, v4, s1, v1
	v_cmp_neq_f32_e32 vcc, 0, v1
	s_lshl_b32 s1, s48, 4
	s_and_b32 s1, s1, 0xf0
	v_cndmask_b32_e32 v1, 1.0, v4, vcc
	v_div_scale_f32 v4, s[4:5], v1, v1, 1.0
	v_rcp_f32_e32 v10, v4
	ds_write_b32 v5, v1 offset:8288
	v_xor_b32_e32 v2, s1, v2
	v_or_b32_e32 v2, s0, v2
	v_fma_f32 v11, -v4, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, 1.0, v1, 1.0
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v4, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v4, -v4, v12, v11
	v_div_fmas_f32 v4, v4, v10, v12
	v_div_fixup_f32 v4, v4, v1, 1.0
	v_pk_mul_f32 v[6:7], v[4:5], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[4:5], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v4, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_lshl_b32 s0, s12, 1
	s_ashr_i32 s4, s12, 31
	v_cndmask_b32_e32 v4, v3, v4, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_lshr_b32 s7, s4, 27
	s_and_b32 s1, s15, 0xffff
	v_cndmask_b32_e32 v4, v3, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_mov_b32 s29, s1
	s_and_b32 s5, s19, 0xffff
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_max_f32_e32 v7, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_mov_b32 s48, s18
	s_mov_b32 s49, s5
	v_cndmask_b32_e32 v6, v3, v7, vcc
	v_min_f32_e32 v7, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	v_cvt_pk_fp8_f32 v57, v4, v6
	s_mov_b32 s15, 0
	v_cndmask_b32_e32 v7, v3, v7, vcc
	v_max_f32_e32 v8, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_max_f32_e32 v4, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v3, v4, vcc
	v_cvt_pk_fp8_f32 v57, v7, v3 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v1, 0x7f7f7f7f, v57
	v_add_u32_e32 v1, 0x7f7f7f7f, v1
	v_or_b32_e32 v1, 0x7f7f7f7f, v1
	v_and_b32_e32 v1, v1, v57
	ds_write_b32 v2, v1 offset:6144
	v_lshlrev_b32_e32 v1, 2, v58
	v_or_b32_e32 v5, 64, v1
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_or_b32_e32 v2, 4, v1
	v_or_b32_e32 v3, 8, v1
	v_or_b32_e32 v4, 12, v1
	v_or_b32_e32 v6, 0x44, v1
	v_or_b32_e32 v7, 0x48, v1
	v_or_b32_e32 v8, 0x4c, v1
	buffer_load_dword v78, v1, s[24:27], 0 offen
	buffer_load_dword v79, v2, s[24:27], 0 offen
	buffer_load_dword v80, v3, s[24:27], 0 offen
	buffer_load_dword v81, v4, s[24:27], 0 offen
	buffer_load_dword v74, v5, s[24:27], 0 offen
	buffer_load_dword v75, v6, s[24:27], 0 offen
	buffer_load_dword v76, v7, s[24:27], 0 offen
	buffer_load_dword v77, v8, s[24:27], 0 offen
	v_or_b32_e32 v1, s12, v116
	scratch_load_dword v5, off, off offset:184
	v_lshlrev_b32_e32 v1, 2, v1
	s_waitcnt vmcnt(0)
	v_or3_b32 v2, s0, v5, v116
	s_lshl_b32 s0, s12, 3
	v_or3_b32 v3, s0, v5, v116
	s_or_b32 s0, s12, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_lshlrev_b32_e32 v3, 4, v3
	s_add_i32 s7, s7, s4
	v_or_b32_e32 v4, 0x400, v3
	buffer_load_dwordx4 v[70:73], v3, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[66:69], v4, s[28:31], 0 offen nt
	v_or_b32_e32 v3, s0, v116
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v2, 2, v2
	v_lshlrev_b32_e32 v3, 2, v3
	buffer_load_dword v97, v1, s[48:51], 0 offen
	buffer_load_dword v96, v3, s[48:51], 0 offen
	v_or3_b32 v1, s4, v5, v116
	s_lshl_b32 s0, s0, 3
	v_lshlrev_b32_e32 v3, 2, v1
	buffer_load_dword v1, v2, s[36:39], 0 offen
	buffer_load_dword v91, v3, s[36:39], 0 offen
	v_or3_b32 v2, s0, v5, v116
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[62:65], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[58:61], v3, s[28:31], 0 offen nt
	v_add_u32_e32 v2, v94, v95
	ds_read2st64_b64 v[42:45], v2 offset1:8
	ds_read2st64_b64 v[34:37], v82 offset1:8
	ds_read2st64_b64 v[30:33], v83 offset1:8
	ds_read2st64_b64 v[26:29], v84 offset1:8
	ds_read2st64_b64 v[22:25], v85 offset1:8
	ds_read2st64_b64 v[18:21], v86 offset1:8
	ds_read2st64_b64 v[14:17], v88 offset1:8
	ds_read2st64_b64 v[10:13], v98 offset1:8
	v_lshlrev_b32_e32 v86, 2, v39
	v_or_b32_e32 v39, 16, v38
	v_lshlrev_b32_e32 v85, 9, v38
	v_lshlrev_b32_e32 v38, 2, v47
	v_and_b32_e32 v93, 0xfc, v38
	scratch_load_dword v38, off, off offset:176
	v_lshlrev_b32_e32 v2, 4, v90
	ds_read_b128 v[6:9], v2 offset:8192
	ds_read_b128 v[2:5], v2 offset:8256
	v_or_b32_e32 v40, s44, v39
	s_mov_b32 s0, s14
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_add_i32 s14, s12, 0x100
	v_lshlrev_b32_e32 v84, 2, v40
	v_lshlrev_b32_e32 v82, 1, v92
	v_lshlrev_b32_e32 v83, 9, v39
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v94, 0x3f0, v38
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[12:13]
	s_add_i32 s15, s15, 1
	s_cmp_lg_u32 s15, 15
	v_mov_b64_e32 v[72:73], v[56:57]
	v_mov_b64_e32 v[70:71], v[54:55]
	v_mov_b64_e32 v[68:69], v[52:53]
	v_mov_b64_e32 v[66:67], v[50:51]
	v_mov_b64_e32 v[64:65], v[48:49]
	v_mov_b64_e32 v[62:63], v[46:47]
	v_mov_b64_e32 v[60:61], v[40:41]
	v_mov_b64_e32 v[58:59], v[38:39]
	v_mov_b32_e32 v96, v88
	v_mov_b32_e32 v97, v90
	v_mov_b32_e32 v1, v95
	s_cbranch_scc0 .LBB0_9
.LBB0_5:
	s_lshl_b32 s17, s15, 8
	s_add_i32 s12, s16, s17
	s_lshr_b32 s13, s12, 31
	s_add_i32 s13, s12, s13
	s_and_b32 s13, s13, 0x1ffffffe
	s_sub_i32 s12, s12, s13
	s_lshl_b32 s12, s12, 3
	v_bfe_u32 v108, v91, s12, 8
	s_add_i32 s12, s12, 16
	v_bfe_u32 v109, v91, s12, 8
	s_add_i32 s12, s14, s17
	v_or_b32_e32 v38, s12, v116
	v_lshl_or_b32 v39, s12, 3, v93
	v_lshl_or_b32 v40, s12, 7, v94
	s_or_b32 s13, s12, 16
	s_ashr_i32 s12, s12, 31
	s_lshr_b32 s18, s12, 27
	s_add_i32 s18, s13, s18
	s_lshr_b32 s18, s18, 5
	v_lshlrev_b32_e32 v38, 2, v38
	buffer_load_dwordx4 v[54:57], v40, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[50:53], v40, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v40, s13, v116
	s_add_i32 s18, s18, s12
	v_lshlrev_b32_e32 v40, 2, v40
	buffer_load_dword v90, v38, s[4:7], 0 offen
	buffer_load_dword v88, v40, s[4:7], 0 offen
	v_lshl_or_b32 v38, s18, 8, v93
	buffer_load_dword v95, v39, s[8:11], 0 offen
	buffer_load_dword v91, v38, s[8:11], 0 offen
	v_lshl_or_b32 v38, s13, 7, v94
	buffer_load_dwordx4 v[46:49], v38, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[38:41], v38, s[0:3], 0 offen offset:1024 nt
	s_and_b32 s12, s15, 1
	v_sub_u32_sdwa v98, v97, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v99, 11, v98
	v_mul_lo_u32 v99, v99, s40
	v_sub_u32_e32 v100, 0x6c686080, v99
	v_and_b32_e32 v100, 0xffffff00, v100
	v_cmp_lt_i32_e32 vcc, 11, v98
	v_sub_u32_e32 v99, 0x7c787470, v99
	v_lshlrev_b32_e32 v101, 4, v70
	v_cndmask_b32_e64 v106, v100, 0, vcc
	v_cndmask_b32_e64 v107, v99, 0, vcc
	v_add_u32_e32 v98, 0x7f7f7f00, v106
	v_and_b32_e32 v110, 0x80808000, v98
	v_add_u32_e32 v98, 0x7f7f7f78, v107
	v_and_b32_e32 v111, 0x80808080, v98
	v_and_b32_e32 v98, 0x7070707, v70
	v_lshrrev_b32_e32 v99, 4, v70
	v_and_b32_e32 v99, 0x7070707, v99
	v_perm_b32 v100, v111, v110, v98
	v_perm_b32 v98, v107, v106, v98
	v_and_or_b32 v98, v100, v101, v98
	v_perm_b32 v100, v111, v110, v99
	v_perm_b32 v99, v107, v106, v99
	v_and_or_b32 v70, v100, v70, v99
	v_sub_u32_sdwa v1, v97, v1 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v102, v70, v98, s41
	v_perm_b32 v103, v70, v98, s42
	v_min_i32_e32 v70, 11, v1
	v_mul_lo_u32 v112, v70, s40
	v_and_b32_e32 v70, 0x7070707, v71
	v_lshrrev_b32_e32 v113, 4, v71
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[42:43], v[102:103], 0
	v_and_b32_e32 v113, 0x7070707, v113
	v_perm_b32 v114, v111, v110, v70
	v_lshlrev_b32_e32 v115, 4, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[44:45], v[102:103], 0
	v_perm_b32 v70, v107, v106, v70
	v_and_or_b32 v114, v114, v115, v70
	v_perm_b32 v70, v111, v110, v113
	v_perm_b32 v113, v107, v106, v113
	v_and_or_b32 v71, v70, v71, v113
	v_perm_b32 v70, v71, v114, s41
	v_perm_b32 v71, v71, v114, s42
	v_lshlrev_b32_e32 v115, 4, v72
	v_sub_u32_e32 v113, 0x6c686080, v112
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[34:35], v[70:71], v[98:101]
	v_and_b32_e32 v113, 0xffffff00, v113
	v_sub_u32_e32 v112, 0x7c787470, v112
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[36:37], v[70:71], v[102:105]
	v_and_b32_e32 v70, 0x7070707, v72
	v_lshrrev_b32_e32 v71, 4, v72
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v114, v111, v110, v70
	v_perm_b32 v70, v107, v106, v70
	v_and_or_b32 v114, v114, v115, v70
	v_perm_b32 v70, v111, v110, v71
	v_perm_b32 v71, v107, v106, v71
	v_and_or_b32 v71, v70, v72, v71
	v_perm_b32 v70, v71, v114, s41
	v_perm_b32 v71, v71, v114, s42
	v_lshlrev_b32_e32 v114, 4, v73
	v_cndmask_b32_e64 v1, v113, 0, vcc
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[30:31], v[70:71], v[98:101]
	v_cndmask_b32_e64 v112, v112, 0, vcc
	v_add_u32_e32 v113, 0x7f7f7f00, v1
	v_sub_u32_e32 v109, v96, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[32:33], v[70:71], v[102:105]
	v_and_b32_e32 v70, 0x7070707, v73
	v_lshrrev_b32_e32 v71, 4, v73
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v111, v110, v70
	v_perm_b32 v70, v107, v106, v70
	v_and_or_b32 v70, v72, v114, v70
	v_perm_b32 v72, v111, v110, v71
	v_perm_b32 v71, v107, v106, v71
	v_and_or_b32 v71, v72, v73, v71
	v_perm_b32 v106, v71, v70, s41
	v_perm_b32 v107, v71, v70, s42
	v_and_b32_e32 v110, 0x80808000, v113
	v_lshlrev_b32_e32 v113, 4, v63
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[26:27], v[106:107], v[98:101]
	s_cmp_eq_u32 s12, 0
	s_cselect_b32 s18, 0x4000, 0
	s_nop 0
	v_add_u32_e32 v98, 0x7f7f7f78, v112
	v_and_b32_e32 v111, 0x80808080, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[28:29], v[106:107], v[102:105]
	s_nop 2
	v_and_b32_e32 v102, 0x7070707, v66
	v_lshrrev_b32_e32 v103, 4, v66
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v111, v110, v102
	v_lshlrev_b32_e32 v105, 4, v66
	v_perm_b32 v102, v112, v1, v102
	v_and_or_b32 v104, v104, v105, v102
	v_perm_b32 v102, v111, v110, v103
	v_perm_b32 v103, v112, v1, v103
	v_and_or_b32 v66, v102, v66, v103
	v_perm_b32 v102, v66, v104, s41
	v_perm_b32 v103, v66, v104, s42
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshlrev_b32_e32 v104, 4, v67
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[22:23], v[102:103], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[24:25], v[102:103], v[98:101]
	v_lshrrev_b32_e32 v102, 4, v67
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v103, v111, v110, v66
	v_perm_b32 v66, v112, v1, v66
	v_and_or_b32 v103, v103, v104, v66
	v_perm_b32 v66, v111, v110, v102
	v_perm_b32 v102, v112, v1, v102
	v_and_or_b32 v67, v66, v67, v102
	v_perm_b32 v66, v67, v103, s41
	v_perm_b32 v67, v67, v103, s42
	v_lshlrev_b32_e32 v103, 4, v68
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[18:19], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[20:21], v[66:67], v[98:101]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v102, v111, v110, v66
	v_perm_b32 v66, v112, v1, v66
	v_and_or_b32 v102, v102, v103, v66
	v_perm_b32 v66, v111, v110, v67
	v_perm_b32 v67, v112, v1, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v102, s41
	v_perm_b32 v67, v67, v102, s42
	v_lshlrev_b32_e32 v102, 4, v69
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[14:15], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[16:17], v[66:67], v[98:101]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v68, v111, v110, v66
	v_perm_b32 v66, v112, v1, v66
	v_and_or_b32 v68, v68, v102, v66
	v_perm_b32 v66, v111, v110, v67
	v_perm_b32 v1, v112, v1, v67
	v_and_or_b32 v1, v66, v69, v1
	v_perm_b32 v66, v1, v68, s41
	v_perm_b32 v67, v1, v68, s42
	v_sub_u32_e32 v1, v96, v108
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[10:11], v[66:67], v[70:73]
	v_lshrrev_b32_e32 v111, 4, v63
	v_and_b32_e32 v111, 0x7070707, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[12:13], v[66:67], v[98:101]
	s_nop 2
	v_min_i32_e32 v98, 11, v1
	v_mul_lo_u32 v98, v98, s40
	v_sub_u32_e32 v99, 0x6c686080, v98
	v_and_b32_e32 v99, 0xffffff00, v99
	v_sub_u32_e32 v98, 0x7c787470, v98
	v_cndmask_b32_e64 v1, v99, 0, vcc
	v_cndmask_b32_e64 v106, v98, 0, vcc
	v_add_u32_e32 v98, 0x7f7f7f00, v1
	v_and_b32_e32 v107, 0x80808000, v98
	v_add_u32_e32 v98, 0x7f7f7f78, v106
	v_and_b32_e32 v108, 0x80808080, v98
	v_and_b32_e32 v98, 0x7070707, v62
	v_lshrrev_b32_e32 v99, 4, v62
	v_and_b32_e32 v99, 0x7070707, v99
	v_perm_b32 v100, v108, v107, v98
	v_lshlrev_b32_e32 v101, 4, v62
	v_perm_b32 v98, v106, v1, v98
	v_and_or_b32 v98, v100, v101, v98
	v_perm_b32 v100, v108, v107, v99
	v_perm_b32 v99, v106, v1, v99
	v_and_or_b32 v62, v100, v62, v99
	v_perm_b32 v102, v62, v98, s41
	v_perm_b32 v103, v62, v98, s42
	v_min_i32_e32 v62, 11, v109
	v_mul_lo_u32 v110, v62, s40
	v_and_b32_e32 v62, 0x7070707, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[42:43], v[102:103], 0
	v_perm_b32 v112, v108, v107, v62
	v_perm_b32 v62, v106, v1, v62
	v_and_or_b32 v112, v112, v113, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[44:45], v[102:103], 0
	v_perm_b32 v62, v108, v107, v111
	v_perm_b32 v111, v106, v1, v111
	v_and_or_b32 v63, v62, v63, v111
	v_perm_b32 v62, v63, v112, s41
	v_perm_b32 v63, v63, v112, s42
	v_lshlrev_b32_e32 v113, 4, v64
	v_sub_u32_e32 v111, 0x6c686080, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[34:35], v[62:63], v[98:101]
	v_and_b32_e32 v111, 0xffffff00, v111
	v_sub_u32_e32 v110, 0x7c787470, v110
	v_cmp_lt_i32_e32 vcc, 11, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[36:37], v[62:63], v[102:105]
	v_and_b32_e32 v62, 0x7070707, v64
	v_lshrrev_b32_e32 v63, 4, v64
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v112, v108, v107, v62
	v_perm_b32 v62, v106, v1, v62
	v_and_or_b32 v112, v112, v113, v62
	v_perm_b32 v62, v108, v107, v63
	v_perm_b32 v63, v106, v1, v63
	v_and_or_b32 v63, v62, v64, v63
	v_perm_b32 v62, v63, v112, s41
	v_perm_b32 v63, v63, v112, s42
	v_lshlrev_b32_e32 v112, 4, v65
	v_cndmask_b32_e64 v109, v111, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[30:31], v[62:63], v[98:101]
	v_cndmask_b32_e64 v110, v110, 0, vcc
	v_add_u32_e32 v111, 0x7f7f7f00, v109
	v_cmp_lt_i32_e32 vcc, 5, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[32:33], v[62:63], v[102:105]
	v_and_b32_e32 v62, 0x7070707, v65
	v_lshrrev_b32_e32 v63, 4, v65
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v108, v107, v62
	v_perm_b32 v62, v106, v1, v62
	v_and_or_b32 v62, v64, v112, v62
	v_perm_b32 v64, v108, v107, v63
	v_perm_b32 v1, v106, v1, v63
	v_and_or_b32 v1, v64, v65, v1
	v_perm_b32 v106, v1, v62, s41
	v_perm_b32 v107, v1, v62, s42
	v_and_b32_e32 v1, 0x80808000, v111
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[106:107], v[98:101]
	s_nop 2
	v_add_u32_e32 v98, 0x7f7f7f78, v110
	v_and_b32_e32 v108, 0x80808080, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[28:29], v[106:107], v[102:105]
	s_nop 2
	v_and_b32_e32 v102, 0x7070707, v58
	v_lshrrev_b32_e32 v103, 4, v58
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v108, v1, v102
	v_lshlrev_b32_e32 v105, 4, v58
	v_perm_b32 v102, v110, v109, v102
	v_and_or_b32 v104, v104, v105, v102
	v_perm_b32 v102, v108, v1, v103
	v_perm_b32 v103, v110, v109, v103
	v_and_or_b32 v58, v102, v58, v103
	v_perm_b32 v102, v58, v104, s41
	v_perm_b32 v103, v58, v104, s42
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshlrev_b32_e32 v104, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[22:23], v[102:103], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[24:25], v[102:103], v[98:101]
	v_lshrrev_b32_e32 v102, 4, v59
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v103, v108, v1, v58
	v_perm_b32 v58, v110, v109, v58
	v_and_or_b32 v103, v103, v104, v58
	v_perm_b32 v58, v108, v1, v102
	v_perm_b32 v102, v110, v109, v102
	v_and_or_b32 v59, v58, v59, v102
	v_perm_b32 v58, v59, v103, s41
	v_perm_b32 v59, v59, v103, s42
	v_lshlrev_b32_e32 v103, 4, v60
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[20:21], v[58:59], v[98:101]
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v102, v108, v1, v58
	v_perm_b32 v58, v110, v109, v58
	v_and_or_b32 v102, v102, v103, v58
	v_perm_b32 v58, v108, v1, v59
	v_perm_b32 v59, v110, v109, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v102, s41
	v_perm_b32 v59, v59, v102, s42
	v_lshlrev_b32_e32 v102, 4, v61
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[16:17], v[58:59], v[98:101]
	v_lshrrev_b32_e32 v59, 4, v61
	v_and_b32_e32 v58, 0x7070707, v61
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v108, v1, v58
	v_perm_b32 v58, v110, v109, v58
	v_perm_b32 v1, v108, v1, v59
	v_perm_b32 v59, v110, v109, v59
	v_and_or_b32 v58, v60, v102, v58
	v_and_or_b32 v1, v1, v61, v59
	v_perm_b32 v102, v1, v58, s41
	v_perm_b32 v103, v1, v58, s42
	v_lshl_add_u32 v1, v97, 23, v87
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[10:11], v[102:103], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[12:13], v[102:103], v[98:101]
	s_nop 2
	v_add_u32_e32 v98, 17, v97
	v_lshlrev_b32_e64 v98, v98, 1
	v_cndmask_b32_e32 v98, v98, v1, vcc
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[102:103], v[8:9], v[98:99] op_sel_hi:[1,0]
	v_add_u32_e32 v97, 17, v96
	v_pk_mul_f32 v[72:73], v[102:103], v[72:73]
	v_lshl_add_u32 v1, v96, 23, v87
	v_lshlrev_b32_e64 v97, v97, 1
	v_cmp_lt_i32_e32 vcc, 5, v96
	v_pk_mul_f32 v[72:73], v[72:73], v[80:81]
	v_pk_mul_f32 v[100:101], v[6:7], v[98:99] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v96, v97, v1, vcc
	v_bfe_u32 v1, v73, 16, 1
	v_pk_mul_f32 v[70:71], v[100:101], v[70:71]
	v_add3_u32 v1, v1, v73, s43
	v_or_b32_e32 v97, 0x400000, v73
	v_cmp_u_f32_e32 vcc, v73, v73
	v_bfe_u32 v73, v72, 16, 1
	v_pk_mul_f32 v[70:71], v[70:71], v[78:79]
	v_cndmask_b32_e32 v1, v1, v97, vcc
	v_add3_u32 v73, v73, v72, s43
	v_or_b32_e32 v97, 0x400000, v72
	v_cmp_u_f32_e32 vcc, v72, v72
	s_nop 1
	v_cndmask_b32_e32 v72, v73, v97, vcc
	v_bfe_u32 v73, v71, 16, 1
	v_add3_u32 v73, v73, v71, s43
	v_or_b32_e32 v97, 0x400000, v71
	v_cmp_u_f32_e32 vcc, v71, v71
	s_nop 1
	v_cndmask_b32_e32 v71, v73, v97, vcc
	v_bfe_u32 v73, v70, 16, 1
	v_add3_u32 v73, v73, v70, s43
	v_or_b32_e32 v97, 0x400000, v70
	v_cmp_u_f32_e32 vcc, v70, v70
	s_nop 1
	v_cndmask_b32_e32 v70, v73, v97, vcc
	v_lshl_add_u32 v97, v89, 1, s18
	ds_write_b16_d16_hi v97, v70
	ds_write_b16_d16_hi v97, v71 offset:512
	ds_write_b16_d16_hi v97, v72 offset:1024
	ds_write_b16_d16_hi v97, v1 offset:1536
	v_pk_mul_f32 v[72:73], v[8:9], v[96:97] op_sel_hi:[1,0]
	v_pk_mul_f32 v[70:71], v[6:7], v[96:97] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[72:73], v[60:61]
	v_pk_mul_f32 v[58:59], v[70:71], v[58:59]
	v_pk_mul_f32 v[60:61], v[60:61], v[80:81]
	v_pk_mul_f32 v[58:59], v[58:59], v[78:79]
	v_bfe_u32 v1, v61, 16, 1
	v_add3_u32 v1, v1, v61, s43
	v_or_b32_e32 v70, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	v_bfe_u32 v61, v60, 16, 1
	v_add3_u32 v61, v61, v60, s43
	v_cndmask_b32_e32 v1, v1, v70, vcc
	v_or_b32_e32 v70, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v61, v70, vcc
	v_bfe_u32 v61, v59, 16, 1
	v_add3_u32 v61, v61, v59, s43
	v_or_b32_e32 v70, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v61, v70, vcc
	v_bfe_u32 v61, v58, 16, 1
	v_add3_u32 v61, v61, v58, s43
	v_or_b32_e32 v70, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v61, v70, vcc
	ds_write_b16_d16_hi v97, v58 offset:32
	ds_write_b16_d16_hi v97, v59 offset:544
	ds_write_b16_d16_hi v97, v60 offset:1056
	ds_write_b16_d16_hi v97, v1 offset:1568
	s_waitcnt lgkmcnt(8)
	v_pk_mul_f32 v[60:61], v[4:5], v[98:99] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[98:99] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[60:61], v[68:69]
	v_pk_mul_f32 v[58:59], v[58:59], v[66:67]
	v_pk_mul_f32 v[60:61], v[60:61], v[76:77]
	v_pk_mul_f32 v[58:59], v[58:59], v[74:75]
	v_bfe_u32 v1, v61, 16, 1
	v_add3_u32 v1, v1, v61, s43
	v_or_b32_e32 v66, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	v_bfe_u32 v61, v60, 16, 1
	v_add3_u32 v61, v61, v60, s43
	v_cndmask_b32_e32 v1, v1, v66, vcc
	v_or_b32_e32 v66, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v61, v66, vcc
	v_bfe_u32 v61, v59, 16, 1
	v_add3_u32 v61, v61, v59, s43
	v_or_b32_e32 v66, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v61, v66, vcc
	v_bfe_u32 v61, v58, 16, 1
	v_add3_u32 v61, v61, v58, s43
	v_or_b32_e32 v66, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v61, v66, vcc
	ds_write_b16_d16_hi v97, v58 offset:8192
	ds_write_b16_d16_hi v97, v59 offset:8704
	ds_write_b16_d16_hi v97, v60 offset:9216
	ds_write_b16_d16_hi v97, v1 offset:9728
	v_pk_mul_f32 v[60:61], v[4:5], v[96:97] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[96:97] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[60:61], v[64:65]
	v_pk_mul_f32 v[58:59], v[58:59], v[62:63]
	v_pk_mul_f32 v[60:61], v[60:61], v[76:77]
	v_pk_mul_f32 v[58:59], v[58:59], v[74:75]
	v_bfe_u32 v1, v61, 16, 1
	v_add3_u32 v1, v1, v61, s43
	v_or_b32_e32 v62, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	v_bfe_u32 v61, v60, 16, 1
	v_add3_u32 v61, v61, v60, s43
	v_cndmask_b32_e32 v1, v1, v62, vcc
	v_or_b32_e32 v62, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v61, v62, vcc
	v_bfe_u32 v61, v59, 16, 1
	v_add3_u32 v61, v61, v59, s43
	v_or_b32_e32 v62, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v61, v62, vcc
	v_bfe_u32 v61, v58, 16, 1
	v_add3_u32 v61, v61, v58, s43
	v_or_b32_e32 v62, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v61, v62, vcc
	ds_write_b16_d16_hi v97, v58 offset:8224
	ds_write_b16_d16_hi v97, v59 offset:8736
	ds_write_b16_d16_hi v97, v60 offset:9248
	ds_write_b16_d16_hi v97, v1 offset:9760
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v1, v86, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v58, 0xffffff, v1
	v_cmp_gt_i32_e32 vcc, s33, v58
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_7
	v_add3_u32 v60, s18, v85, v82
	v_lshl_add_u32 v1, v1, 12, s17
	ds_read_b32 v61, v60
	v_or_b32_e32 v1, v1, v92
	v_lshlrev_b32_e32 v58, 1, v1
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v1, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v1, off offset:128
	ds_read_b32 v1, v60 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v1, off offset:256
	ds_read_b32 v1, v60 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v1, off offset:384
.LBB0_7:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v1, v84, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v58, 0xffffff, v1
	v_cmp_gt_i32_e32 vcc, s33, v58
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_4
	v_add3_u32 v60, s18, v83, v82
	v_lshl_add_u32 v1, v1, 12, s17
	ds_read_b32 v61, v60
	v_or_b32_e32 v1, v1, v92
	v_lshlrev_b32_e32 v58, 1, v1
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v1, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v1, off offset:128
	ds_read_b32 v1, v60 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v1, off offset:256
	ds_read_b32 v1, v60 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v1, off offset:384
	s_branch .LBB0_4
.LBB0_9:
	v_sub_u32_sdwa v1, v90, v95 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v58, 11, v1
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v58, v58, s2
	v_sub_u32_e32 v59, 0x6c686080, v58
	v_and_b32_e32 v59, 0xffffff00, v59
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v58, 0x7c787470, v58
	v_lshlrev_b32_e32 v61, 4, v54
	v_cndmask_b32_e64 v1, v59, 0, vcc
	v_cndmask_b32_e64 v66, v58, 0, vcc
	v_add_u32_e32 v58, 0x7f7f7f00, v1
	v_and_b32_e32 v67, 0x80808000, v58
	v_add_u32_e32 v58, 0x7f7f7f78, v66
	v_and_b32_e32 v68, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v54
	v_lshrrev_b32_e32 v59, 4, v54
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v68, v67, v58
	v_perm_b32 v58, v66, v1, v58
	v_and_or_b32 v58, v60, v61, v58
	v_perm_b32 v60, v68, v67, v59
	v_perm_b32 v59, v66, v1, v59
	v_and_or_b32 v54, v60, v54, v59
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_sub_u32_sdwa v69, v90, v95 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v62, v54, v58, s0
	v_perm_b32 v63, v54, v58, s1
	v_min_i32_e32 v54, 11, v69
	v_mul_lo_u32 v70, v54, s2
	v_and_b32_e32 v54, 0x7070707, v55
	v_lshrrev_b32_e32 v71, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[42:43], v[62:63], 0
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v68, v67, v54
	v_lshlrev_b32_e32 v73, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[44:45], v[62:63], 0
	v_perm_b32 v54, v66, v1, v54
	v_and_or_b32 v72, v72, v73, v54
	v_perm_b32 v54, v68, v67, v71
	v_perm_b32 v71, v66, v1, v71
	v_and_or_b32 v55, v54, v55, v71
	v_perm_b32 v54, v55, v72, s0
	v_perm_b32 v55, v55, v72, s1
	v_lshlrev_b32_e32 v73, 4, v56
	v_sub_u32_e32 v71, 0x6c686080, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[34:35], v[54:55], v[58:61]
	v_and_b32_e32 v71, 0xffffff00, v71
	v_sub_u32_e32 v70, 0x7c787470, v70
	v_cmp_lt_i32_e32 vcc, 11, v69
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[36:37], v[54:55], v[62:65]
	v_and_b32_e32 v54, 0x7070707, v56
	v_lshrrev_b32_e32 v55, 4, v56
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v72, v68, v67, v54
	v_perm_b32 v54, v66, v1, v54
	v_and_or_b32 v72, v72, v73, v54
	v_perm_b32 v54, v68, v67, v55
	v_perm_b32 v55, v66, v1, v55
	v_and_or_b32 v55, v54, v56, v55
	v_perm_b32 v54, v55, v72, s0
	v_perm_b32 v55, v55, v72, s1
	v_lshlrev_b32_e32 v72, 4, v57
	v_cndmask_b32_e64 v69, v71, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[30:31], v[54:55], v[58:61]
	v_cndmask_b32_e64 v70, v70, 0, vcc
	v_add_u32_e32 v71, 0x7f7f7f00, v69
	s_add_i32 s3, s14, 0xe01
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[32:33], v[54:55], v[62:65]
	v_and_b32_e32 v54, 0x7070707, v57
	v_lshrrev_b32_e32 v55, 4, v57
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v56, v68, v67, v54
	v_perm_b32 v54, v66, v1, v54
	v_and_or_b32 v54, v56, v72, v54
	v_perm_b32 v56, v68, v67, v55
	v_perm_b32 v1, v66, v1, v55
	v_and_or_b32 v1, v56, v57, v1
	v_perm_b32 v66, v1, v54, s0
	v_perm_b32 v67, v1, v54, s1
	v_and_b32_e32 v1, 0x80808000, v71
	s_lshr_b32 s4, s3, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[26:27], v[66:67], v[58:61]
	s_add_i32 s4, s3, s4
	s_and_b32 s4, s4, 0x1ffffffe
	s_sub_i32 s3, s3, s4
	v_add_u32_e32 v58, 0x7f7f7f78, v70
	v_and_b32_e32 v68, 0x80808080, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[28:29], v[66:67], v[62:65]
	s_lshl_b32 s3, s3, 3
	s_nop 1
	v_and_b32_e32 v62, 0x7070707, v50
	v_lshrrev_b32_e32 v63, 4, v50
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v68, v1, v62
	v_lshlrev_b32_e32 v65, 4, v50
	v_perm_b32 v62, v70, v69, v62
	v_and_or_b32 v64, v64, v65, v62
	v_perm_b32 v62, v68, v1, v63
	v_perm_b32 v63, v70, v69, v63
	v_and_or_b32 v50, v62, v50, v63
	v_perm_b32 v62, v50, v64, s0
	v_perm_b32 v63, v50, v64, s1
	v_and_b32_e32 v50, 0x7070707, v51
	v_lshlrev_b32_e32 v64, 4, v51
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[22:23], v[62:63], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[24:25], v[62:63], v[58:61]
	v_lshrrev_b32_e32 v62, 4, v51
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v68, v1, v50
	v_perm_b32 v50, v70, v69, v50
	v_and_or_b32 v63, v63, v64, v50
	v_perm_b32 v50, v68, v1, v62
	v_perm_b32 v62, v70, v69, v62
	v_and_or_b32 v51, v50, v51, v62
	v_perm_b32 v50, v51, v63, s0
	v_perm_b32 v51, v51, v63, s1
	v_lshlrev_b32_e32 v63, 4, v52
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[18:19], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[20:21], v[50:51], v[58:61]
	v_and_b32_e32 v50, 0x7070707, v52
	v_lshrrev_b32_e32 v51, 4, v52
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v62, v68, v1, v50
	v_perm_b32 v50, v70, v69, v50
	v_and_or_b32 v62, v62, v63, v50
	v_perm_b32 v50, v68, v1, v51
	v_perm_b32 v51, v70, v69, v51
	v_and_or_b32 v51, v50, v52, v51
	v_perm_b32 v50, v51, v62, s0
	v_perm_b32 v51, v51, v62, s1
	v_lshlrev_b32_e32 v62, 4, v53
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[14:15], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[16:17], v[50:51], v[58:61]
	v_and_b32_e32 v50, 0x7070707, v53
	v_lshrrev_b32_e32 v51, 4, v53
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v68, v1, v50
	v_perm_b32 v50, v70, v69, v50
	v_and_or_b32 v52, v52, v62, v50
	v_perm_b32 v1, v68, v1, v51
	v_perm_b32 v50, v70, v69, v51
	v_and_or_b32 v1, v1, v53, v50
	v_perm_b32 v50, v1, v52, s0
	v_perm_b32 v51, v1, v52, s1
	v_bfe_u32 v1, v91, s3, 8
	v_sub_u32_e32 v1, v88, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[10:11], v[50:51], v[54:57]
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_add_i32 s3, s3, 16
	v_bfe_u32 v64, v91, s3, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[12:13], v[50:51], v[58:61]
	v_sub_u32_e32 v64, v88, v64
	v_lshlrev_b32_e32 v69, 4, v47
	s_nop 0
	v_min_i32_e32 v58, 11, v1
	v_mul_lo_u32 v58, v58, s2
	v_sub_u32_e32 v59, 0x6c686080, v58
	v_and_b32_e32 v59, 0xffffff00, v59
	v_sub_u32_e32 v58, 0x7c787470, v58
	v_cndmask_b32_e64 v1, v59, 0, vcc
	v_cndmask_b32_e64 v65, v58, 0, vcc
	v_add_u32_e32 v58, 0x7f7f7f00, v1
	v_and_b32_e32 v66, 0x80808000, v58
	v_add_u32_e32 v58, 0x7f7f7f78, v65
	v_and_b32_e32 v67, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v46
	v_lshrrev_b32_e32 v59, 4, v46
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v67, v66, v58
	v_lshlrev_b32_e32 v61, 4, v46
	v_perm_b32 v58, v65, v1, v58
	v_and_or_b32 v58, v60, v61, v58
	v_perm_b32 v60, v67, v66, v59
	v_perm_b32 v59, v65, v1, v59
	v_and_or_b32 v46, v60, v46, v59
	v_perm_b32 v62, v46, v58, s0
	v_perm_b32 v63, v46, v58, s1
	v_and_b32_e32 v46, 0x7070707, v47
	v_cmp_lt_i32_e32 vcc, 11, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[42:43], v[62:63], 0
	v_min_i32_e32 v42, 11, v64
	v_mul_lo_u32 v68, v42, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[44:45], v[62:63], 0
	v_lshrrev_b32_e32 v62, 4, v47
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v67, v66, v46
	v_perm_b32 v46, v65, v1, v46
	v_and_or_b32 v63, v63, v69, v46
	v_perm_b32 v46, v67, v66, v62
	v_perm_b32 v62, v65, v1, v62
	v_and_or_b32 v47, v46, v47, v62
	v_perm_b32 v46, v47, v63, s0
	v_perm_b32 v47, v47, v63, s1
	v_sub_u32_e32 v63, 0x7c787470, v68
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[34:35], v[46:47], v[58:61]
	v_sub_u32_e32 v34, 0x6c686080, v68
	v_and_b32_e32 v62, 0xffffff00, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[46:47], v[42:45]
	s_nop 2
	v_and_b32_e32 v42, 0x7070707, v48
	v_lshrrev_b32_e32 v43, 4, v48
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v67, v66, v42
	v_lshlrev_b32_e32 v45, 4, v48
	v_perm_b32 v42, v65, v1, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v67, v66, v43
	v_perm_b32 v43, v65, v1, v43
	v_and_or_b32 v43, v44, v48, v43
	v_perm_b32 v46, v43, v42, s0
	v_perm_b32 v47, v43, v42, s1
	v_cndmask_b32_e64 v48, v62, 0, vcc
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[30:31], v[46:47], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[32:33], v[46:47], v[34:37]
	s_nop 1
	v_cndmask_b32_e64 v58, v63, 0, vcc
	v_add_u32_e32 v59, 0x7f7f7f00, v48
	v_cmp_lt_i32_e32 vcc, 5, v90
	v_and_b32_e32 v34, 0x7070707, v49
	v_lshrrev_b32_e32 v35, 4, v49
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v67, v66, v34
	v_lshlrev_b32_e32 v37, 4, v49
	v_perm_b32 v34, v65, v1, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v67, v66, v35
	v_perm_b32 v1, v65, v1, v35
	v_and_or_b32 v1, v36, v49, v1
	v_perm_b32 v46, v1, v34, s0
	v_perm_b32 v47, v1, v34, s1
	v_and_b32_e32 v1, 0x80808000, v59
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[26:27], v[46:47], v[42:45]
	v_add_u32_e32 v26, 0x7f7f7f78, v58
	s_nop 1
	v_and_b32_e32 v44, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[46:47], v[30:33]
	s_nop 2
	v_and_b32_e32 v30, 0x7070707, v38
	v_lshrrev_b32_e32 v31, 4, v38
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v44, v1, v30
	v_lshlrev_b32_e32 v33, 4, v38
	v_perm_b32 v30, v58, v48, v30
	v_and_or_b32 v30, v32, v33, v30
	v_perm_b32 v32, v44, v1, v31
	v_perm_b32 v31, v58, v48, v31
	v_and_or_b32 v31, v32, v38, v31
	v_perm_b32 v42, v31, v30, s0
	v_perm_b32 v43, v31, v30, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[22:23], v[42:43], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[42:43], v[26:29]
	s_nop 2
	v_and_b32_e32 v26, 0x7070707, v39
	v_lshrrev_b32_e32 v27, 4, v39
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v44, v1, v26
	v_lshlrev_b32_e32 v29, 4, v39
	v_perm_b32 v26, v58, v48, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v44, v1, v27
	v_perm_b32 v27, v58, v48, v27
	v_and_or_b32 v27, v28, v39, v27
	v_perm_b32 v34, v27, v26, s0
	v_perm_b32 v35, v27, v26, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[18:19], v[34:35], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[34:35], v[22:25]
	s_nop 2
	v_and_b32_e32 v22, 0x7070707, v40
	v_lshrrev_b32_e32 v23, 4, v40
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v44, v1, v22
	v_lshlrev_b32_e32 v25, 4, v40
	v_perm_b32 v22, v58, v48, v22
	v_and_or_b32 v22, v24, v25, v22
	v_perm_b32 v24, v44, v1, v23
	v_perm_b32 v23, v58, v48, v23
	v_and_or_b32 v23, v24, v40, v23
	v_perm_b32 v30, v23, v22, s0
	v_perm_b32 v31, v23, v22, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[14:15], v[30:31], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[30:31], v[18:21]
	s_nop 2
	v_lshrrev_b32_e32 v19, 4, v41
	v_and_b32_e32 v18, 0x7070707, v41
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v44, v1, v18
	v_lshlrev_b32_e32 v21, 4, v41
	v_perm_b32 v18, v58, v48, v18
	v_perm_b32 v1, v44, v1, v19
	v_perm_b32 v19, v58, v48, v19
	v_and_or_b32 v18, v20, v21, v18
	v_and_or_b32 v1, v1, v41, v19
	v_perm_b32 v26, v1, v18, s0
	v_perm_b32 v27, v1, v18, s1
	v_mov_b32_e32 v1, 0xfd800000
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[26:27], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[12:13], v[26:27], v[14:17]
	s_nop 2
	v_add_u32_e32 v15, 17, v90
	v_lshl_add_u32 v14, v90, 23, v1
	v_lshlrev_b32_e64 v15, v15, 1
	v_cndmask_b32_e32 v14, v15, v14, vcc
	v_add_u32_e32 v15, 17, v88
	v_lshlrev_b32_e64 v15, v15, 1
	v_pk_mul_f32 v[24:25], v[8:9], v[14:15] op_sel_hi:[1,0]
	v_lshl_add_u32 v1, v88, 23, v1
	v_pk_mul_f32 v[24:25], v[24:25], v[56:57]
	v_cmp_lt_i32_e32 vcc, 5, v88
	v_pk_mul_f32 v[24:25], v[24:25], v[80:81]
	v_pk_mul_f32 v[22:23], v[6:7], v[14:15] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v16, v15, v1, vcc
	v_bfe_u32 v1, v25, 16, 1
	v_add3_u32 v1, v1, v25, s0
	v_or_b32_e32 v15, 0x400000, v25
	v_cmp_u_f32_e32 vcc, v25, v25
	v_pk_mul_f32 v[22:23], v[22:23], v[54:55]
	v_or_b32_e32 v17, 0x400000, v24
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_bfe_u32 v15, v24, 16, 1
	v_pk_mul_f32 v[22:23], v[22:23], v[78:79]
	v_add3_u32 v15, v15, v24, s0
	v_cmp_u_f32_e32 vcc, v24, v24
	v_or_b32_e32 v24, 0x400000, v23
	s_nop 0
	v_cndmask_b32_e32 v15, v15, v17, vcc
	v_bfe_u32 v17, v23, 16, 1
	v_add3_u32 v17, v17, v23, s0
	v_cmp_u_f32_e32 vcc, v23, v23
	v_bfe_u32 v23, v22, 16, 1
	v_add3_u32 v23, v23, v22, s0
	v_cndmask_b32_e32 v17, v17, v24, vcc
	v_pk_mul_f32 v[8:9], v[8:9], v[16:17] op_sel_hi:[1,0]
	v_or_b32_e32 v24, 0x400000, v22
	v_cmp_u_f32_e32 vcc, v22, v22
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[16:17] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v22, v23, v24, vcc
	v_pk_mul_f32 v[8:9], v[8:9], v[80:81]
	ds_write_b16_d16_hi v0, v22
	ds_write_b16_d16_hi v0, v17 offset:512
	ds_write_b16_d16_hi v0, v15 offset:1024
	ds_write_b16_d16_hi v0, v1 offset:1536
	v_bfe_u32 v1, v9, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v15, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[78:79]
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_add3_u32 v9, v9, v8, s0
	v_or_b32_e32 v15, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v15, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v15, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v15, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v15, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v15, vcc
	ds_write_b16_d16_hi v0, v6 offset:32
	ds_write_b16_d16_hi v0, v7 offset:544
	ds_write_b16_d16_hi v0, v8 offset:1056
	ds_write_b16_d16_hi v0, v1 offset:1568
	v_pk_mul_f32 v[8:9], v[4:5], v[14:15] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[14:15] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[52:53]
	v_pk_mul_f32 v[6:7], v[6:7], v[50:51]
	v_pk_mul_f32 v[8:9], v[8:9], v[76:77]
	v_pk_mul_f32 v[6:7], v[6:7], v[74:75]
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v14, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v14, vcc
	v_or_b32_e32 v14, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	v_pk_mul_f32 v[4:5], v[4:5], v[16:17] op_sel_hi:[1,0]
	v_pk_mul_f32 v[2:3], v[2:3], v[16:17] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[4:5], v[4:5], v[12:13]
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	v_cndmask_b32_e32 v7, v9, v14, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v14, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[4:5], v[4:5], v[76:77]
	v_pk_mul_f32 v[2:3], v[2:3], v[74:75]
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v0, v6 offset:8192
	ds_write_b16_d16_hi v0, v7 offset:8704
	ds_write_b16_d16_hi v0, v8 offset:9216
	ds_write_b16_d16_hi v0, v1 offset:9728
	v_bfe_u32 v1, v5, 16, 1
	v_add3_u32 v1, v1, v5, s0
	v_or_b32_e32 v6, 0x400000, v5
	v_cmp_u_f32_e32 vcc, v5, v5
	v_bfe_u32 v5, v4, 16, 1
	v_add3_u32 v5, v5, v4, s0
	v_cndmask_b32_e32 v1, v1, v6, vcc
	v_or_b32_e32 v6, 0x400000, v4
	v_cmp_u_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v5, v6, vcc
	v_bfe_u32 v5, v3, 16, 1
	v_add3_u32 v5, v5, v3, s0
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v5, v6, vcc
	v_bfe_u32 v5, v2, 16, 1
	v_add3_u32 v5, v5, v2, s0
	v_or_b32_e32 v6, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v5, v6, vcc
	ds_write_b16_d16_hi v0, v2 offset:8224
	ds_write_b16_d16_hi v0, v3 offset:8736
	ds_write_b16_d16_hi v0, v4 offset:9248
	ds_write_b16_d16_hi v0, v1 offset:9760
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v86, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_11
	v_add_u32_e32 v2, v85, v82
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v82
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3584
	ds_read_b32 v3, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3712
	ds_read_b32 v3, v2 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_11:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v84, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_13
	v_add_u32_e32 v2, v83, v82
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v82
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3584
	ds_read_b32 v3, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3712
	ds_read_b32 v3, v2 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_13:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db
		.amdhsa_group_segment_fixed_size 32768
		.amdhsa_private_segment_fixed_size 204
		.amdhsa_kernarg_size 108
		.amdhsa_user_sgpr_count 2
		.amdhsa_user_sgpr_dispatch_ptr 0
		.amdhsa_user_sgpr_queue_ptr 0
		.amdhsa_user_sgpr_kernarg_segment_ptr 1
		.amdhsa_user_sgpr_dispatch_id 0
		.amdhsa_user_sgpr_kernarg_preload_length 0
		.amdhsa_user_sgpr_kernarg_preload_offset 0
		.amdhsa_user_sgpr_private_segment_size 0
		.amdhsa_uses_dynamic_stack 0
		.amdhsa_enable_private_segment 1
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 128
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 128
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.num_vgpr, 128
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.numbered_sgpr, 54
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.private_seg_size, 204
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.has_indirect_call, 0
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
        .size:           8
        .value_kind:     by_value
      - .offset:         80
        .size:           8
        .value_kind:     by_value
      - .offset:         88
        .size:           8
        .value_kind:     by_value
      - .offset:         96
        .size:           8
        .value_kind:     by_value
      - .offset:         104
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 32768
    .kernarg_segment_align: 8
    .kernarg_segment_size: 108
    .max_flat_workgroup_size: 512
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db
    .private_segment_fixed_size: 204
    .reqd_workgroup_size:
      - 512
      - 1
      - 1
    .sgpr_count:     60
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_w4_ftz_a2r_db.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     128
    .vgpr_spill_count: 50
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
