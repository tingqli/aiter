	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db:
	s_load_dwordx8 s[16:23], s[0:1], 0x40
	v_readfirstlane_b32 s52, v0
	s_mov_b32 s49, 0
	s_waitcnt lgkmcnt(0)
	s_load_dword s3, s[18:19], 0x0
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
	s_cmp_ge_i32 s2, s3
	s_cbranch_scc1 .LBB0_21
	s_and_b32 s4, s3, 7
	s_and_b32 s5, s2, 7
	s_lshr_b32 s3, s3, 3
	s_min_u32 s4, s5, s4
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s3, s3, s5
	s_add_i32 s2, s4, s2
	s_add_i32 s2, s2, s3
	s_ashr_i32 s3, s2, 31
	s_lshl_b64 s[4:5], s[2:3], 2
	s_add_u32 s54, s16, s4
	s_addc_u32 s55, s17, s5
	s_lshl_b32 s48, s2, 5
	v_lshrrev_b32_e32 v34, 4, v0
	v_or_b32_e32 v2, s48, v34
	v_ashrrev_i32_e32 v3, 31, v2
	v_bfe_u32 v4, v0, 4, 24
	v_lshl_add_u64 v[8:9], v[2:3], 2, s[20:21]
	v_or3_b32 v2, v4, s48, 16
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dword v5, v[8:9], off
	global_load_dword v6, v[2:3], off
	s_load_dword s50, s[54:55], 0x0
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dwordx2 s[34:35], s[0:1], 0x60
	s_load_dword s33, s[0:1], 0x68
	s_and_b32 s51, s52, 0xffffffc0
	v_and_b32_e32 v3, 48, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s45, s5, 0xffff
	s_lshl_b32 s5, s50, 9
	s_mov_b32 s44, s4
	s_mov_b32 s28, s4
	s_add_i32 s4, s5, s51
	s_ashr_i32 s53, s4, 31
	v_and_b32_e32 v44, 15, v0
	s_mov_b32 s0, s8
	s_mov_b32 s36, s8
	s_mov_b32 s24, s10
	s_mov_b32 s40, s10
	s_and_b32 s1, s9, 0xffff
	s_and_b32 s25, s11, 0xffff
	s_lshl_b32 s8, s4, 7
	s_lshl_b32 s9, s4, 5
	s_add_i32 s10, s4, 0x100
	s_or_b32 s11, s4, 16
	s_lshr_b32 s56, s53, 27
	v_or3_b32 v9, s8, v3, v44
	v_or3_b32 v7, s9, v3, v44
	s_lshl_b32 s8, s10, 7
	s_lshl_b32 s9, s10, 5
	s_ashr_i32 s10, s11, 4
	s_lshl_b32 s55, s11, 7
	s_add_i32 s11, s11, s56
	v_or3_b32 v8, s9, v3, v44
	s_lshr_b32 s9, s11, 5
	s_add_i32 s9, s9, s53
	s_lshl_b32 s9, s9, 10
	v_or3_b32 v11, s9, v3, v44
	s_add_i32 s9, s4, 0x110
	s_lshr_b32 s54, s4, 31
	s_lshl_b32 s11, s9, 7
	v_or3_b32 v14, s8, v3, v44
	s_add_i32 s8, s10, s54
	v_or3_b32 v15, s11, v3, v44
	s_ashr_i32 s11, s9, 31
	v_or3_b32 v10, s55, v3, v44
	s_and_b32 s8, s8, -2
	s_lshr_b32 s55, s11, 27
	v_and_b32_e32 v1, 63, v0
	s_sub_i32 s8, s10, s8
	s_ashr_i32 s10, s9, 4
	s_add_i32 s55, s9, s55
	s_lshr_b32 s9, s9, 31
	scratch_store_dword off, v1, off offset:152
	v_xor_b32_e32 v1, v4, v0
	s_lshr_b32 s55, s55, 5
	s_add_i32 s9, s10, s9
	v_lshlrev_b32_e32 v45, 4, v0
	v_lshlrev_b32_e32 v1, 4, v1
	s_add_i32 s55, s55, s11
	s_and_b32 s9, s9, -2
	v_xor_b32_e32 v2, v45, v0
	v_and_b32_e32 v1, 0xf0, v1
	s_lshl_b32 s11, s55, 10
	s_sub_i32 s9, s10, s9
	s_or_b32 s10, s4, 32
	v_bfe_u32 v50, v0, 4, 2
	scratch_store_dword off, v0, off offset:132
	v_and_b32_e32 v0, 0xf0, v2
	s_mov_b32 s47, 0x27000
	s_lshl_b32 s46, s33, 12
	s_mov_b32 s29, s45
	s_mov_b32 s30, s46
	v_or_b32_e32 v2, s51, v44
	scratch_store_dword off, v3, off offset:144
	scratch_store_dword off, v2, off offset:156
	s_mov_b32 s26, 0x1000000
	s_brev_b32 s2, 8
	s_mov_b32 s42, s26
	s_mov_b32 s43, s47
	s_mov_b32 s41, s25
	s_mov_b32 s38, s2
	s_waitcnt vmcnt(5)
	v_lshl_or_b32 v0, v5, 12, v0
	s_waitcnt vmcnt(4)
	v_lshl_or_b32 v1, v6, 12, v1
	v_or3_b32 v6, s11, v3, v44
	s_lshl_b32 s11, s10, 7
	s_lshl_b32 s10, s10, 5
	v_or3_b32 v5, s10, v3, v44
	s_add_i32 s10, s4, 0x120
	v_or3_b32 v12, s11, v3, v44
	s_lshl_b32 s11, s10, 7
	s_lshl_b32 s10, s10, 5
	v_or3_b32 v13, s10, v3, v44
	s_or_b32 s10, s4, 48
	v_or3_b32 v16, s11, v3, v44
	s_ashr_i32 s11, s10, 4
	s_lshl_b32 s55, s10, 7
	s_add_i32 s10, s10, s56
	s_lshr_b32 s10, s10, 5
	s_add_i32 s10, s10, s53
	s_lshl_b32 s10, s10, 10
	v_or3_b32 v18, s10, v3, v44
	s_add_i32 s10, s11, s54
	s_and_b32 s10, s10, -2
	s_sub_i32 s10, s11, s10
	s_add_i32 s11, s4, 0x130
	buffer_load_dwordx4 v[36:39], v0, s[44:47], 0 offen nt
	buffer_load_dwordx4 v[40:43], v1, s[44:47], 0 offen nt
	s_lshl_b32 s45, s11, 7
	v_or3_b32 v51, s45, v3, v44
	s_ashr_i32 s45, s11, 31
	s_lshr_b32 s46, s45, 27
	s_add_i32 s46, s11, s46
	s_lshr_b32 s46, s46, 5
	scratch_store_dword off, v0, off offset:80
	s_add_i32 s46, s46, s45
	v_add_u32_e32 v0, s5, v2
	scratch_store_dword off, v1, off offset:84
	s_lshl_b32 s45, s46, 10
	v_ashrrev_i32_e32 v1, 31, v0
	v_or3_b32 v17, s55, v3, v44
	v_or3_b32 v19, s45, v3, v44
	v_lshl_add_u64 v[2:3], v[0:1], 2, s[12:13]
	global_load_dword v212, v[2:3], off
	global_load_dword v213, v[2:3], off offset:64
	global_load_dword v4, v[2:3], off offset:128
	v_add_u32_e32 v0, 0x100, v0
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], v[0:1], 2, s[12:13]
	s_mov_b32 s39, s47
	s_mov_b32 s37, s1
	scratch_store_dword off, v5, off offset:100
	scratch_store_dword off, v8, off offset:68
	scratch_store_dword off, v6, off offset:92
	v_lshlrev_b32_e32 v6, 2, v6
	scratch_store_dword off, v18, off offset:116
	scratch_store_dword off, v19, off offset:124
	scratch_store_dword off, v11, off offset:76
	scratch_store_dword off, v13, off offset:108
	scratch_store_dword off, v9, off offset:56
	scratch_store_dword off, v10, off offset:72
	scratch_store_dword off, v12, off offset:96
	scratch_store_dword off, v17, off offset:112
	scratch_store_dword off, v14, off offset:64
	scratch_store_dword off, v15, off offset:88
	scratch_store_dword off, v16, off offset:104
	v_and_b32_e32 v35, 0xf0, v45
	s_ashr_i32 s44, s11, 4
	s_lshr_b32 s11, s11, 31
	s_add_i32 s11, s44, s11
	s_and_b32 s11, s11, -2
	s_sub_i32 s44, s44, s11
	v_lshlrev_b32_e32 v201, 8, v44
	s_lshl_b32 s12, s8, 3
	s_lshl_b32 s8, s10, 3
	s_lshl_b32 s13, s9, 3
	s_lshl_b32 s9, s44, 3
	v_mov_b32_e32 v98, 0
	s_mov_b32 s31, s47
	s_mov_b32 s3, s47
	s_mov_b32 s27, s47
	scratch_store_dword off, v51, off offset:120
	scratch_store_dword off, v45, off
	s_add_i32 s11, s12, 16
	s_add_i32 s5, s8, 16
	s_add_i32 s10, s9, 16
	scratch_store_dword off, v50, off offset:140
	scratch_store_dword off, v44, off offset:136
	v_or_b32_e32 v242, 0x1000, v201
	v_mov_b32_e32 v99, v98
	v_mov_b32_e32 v100, v98
	v_mov_b32_e32 v101, v98
	v_mov_b32_e32 v74, v98
	v_mov_b32_e32 v75, v98
	v_mov_b32_e32 v76, v98
	v_mov_b32_e32 v77, v98
	v_mov_b32_e32 v118, v98
	v_mov_b32_e32 v119, v98
	v_mov_b32_e32 v120, v98
	v_mov_b32_e32 v121, v98
	v_mov_b32_e32 v102, v98
	v_mov_b32_e32 v103, v98
	v_mov_b32_e32 v104, v98
	v_mov_b32_e32 v105, v98
	v_mov_b32_e32 v78, v98
	v_mov_b32_e32 v79, v98
	v_mov_b32_e32 v80, v98
	v_mov_b32_e32 v81, v98
	v_mov_b32_e32 v114, v98
	s_waitcnt vmcnt(23)
	ds_write_b128 v45, v[40:43] offset:4096
	v_mov_b32_e32 v40, v98
	v_mov_b32_e32 v41, v98
	v_mov_b32_e32 v115, v98
	v_mov_b32_e32 v116, v98
	v_mov_b32_e32 v117, v98
	v_mov_b32_e32 v106, v98
	v_mov_b32_e32 v107, v98
	v_mov_b32_e32 v108, v98
	v_mov_b32_e32 v109, v98
	v_mov_b32_e32 v82, v98
	v_mov_b32_e32 v83, v98
	v_mov_b32_e32 v84, v98
	v_mov_b32_e32 v85, v98
	v_mov_b32_e32 v42, v98
	v_mov_b32_e32 v43, v98
	s_waitcnt vmcnt(18)
	scratch_store_dword off, v4, off offset:16
	global_load_dword v4, v[2:3], off offset:192
	v_mov_b32_e32 v45, v98
	v_mov_b32_e32 v126, v98
	v_mov_b32_e32 v127, v98
	v_mov_b32_e32 v128, v98
	v_mov_b32_e32 v129, v98
	v_mov_b32_e32 v110, v98
	v_mov_b32_e32 v111, v98
	v_mov_b32_e32 v112, v98
	v_mov_b32_e32 v113, v98
	v_mov_b32_e32 v86, v98
	v_mov_b32_e32 v87, v98
	v_mov_b32_e32 v88, v98
	v_mov_b32_e32 v89, v98
	v_mov_b32_e32 v52, v98
	v_mov_b32_e32 v53, v98
	v_mov_b32_e32 v122, v98
	v_mov_b32_e32 v123, v98
	v_mov_b32_e32 v124, v98
	v_mov_b32_e32 v125, v98
	s_waitcnt vmcnt(0)
	scratch_store_dword off, v4, off offset:20
	global_load_dword v4, v[0:1], off
	s_waitcnt vmcnt(0)
	scratch_store_dword off, v4, off offset:24
	global_load_dword v211, v[0:1], off offset:64
	s_nop 0
	global_load_dword v4, v[0:1], off offset:128
	s_waitcnt vmcnt(0)
	scratch_store_dword off, v4, off offset:8
	global_load_dword v4, v[0:1], off offset:192
	s_waitcnt vmcnt(0)
	scratch_store_dword off, v4, off offset:12
	scratch_store_dword off, v7, off offset:60
	v_lshlrev_b32_e32 v1, 2, v7
	v_lshlrev_b32_e32 v2, 2, v11
	v_lshlrev_b32_e32 v3, 2, v5
	v_lshlrev_b32_e32 v4, 2, v18
	v_lshlrev_b32_e32 v5, 2, v8
	v_lshlrev_b32_e32 v7, 2, v13
	v_lshlrev_b32_e32 v8, 2, v19
	buffer_load_dword v0, v1, s[40:43], 0 offen
	buffer_load_dword v218, v2, s[40:43], 0 offen
	buffer_load_dword v254, v3, s[40:43], 0 offen
	buffer_load_dword v214, v4, s[40:43], 0 offen
	buffer_load_dword v150, v5, s[40:43], 0 offen
	buffer_load_dword v219, v6, s[40:43], 0 offen
	buffer_load_dword v249, v7, s[40:43], 0 offen
	buffer_load_dword v215, v8, s[40:43], 0 offen
	v_lshlrev_b32_e32 v1, 4, v9
	buffer_load_dwordx4 v[90:93], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[66:69], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v10
	buffer_load_dwordx4 v[58:61], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[46:49], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v12
	buffer_load_dwordx4 v[26:29], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v17
	buffer_load_dwordx4 v[10:13], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v14
	buffer_load_dwordx4 v[94:97], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[70:73], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v15
	buffer_load_dwordx4 v[62:65], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[54:57], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v16
	buffer_load_dwordx4 v[30:33], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v1, 4, v51
	buffer_load_dwordx4 v[14:17], v1, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v1, s[36:39], 0 offen offset:1024 sc0
	v_lshl_or_b32 v1, v34, 8, v35
	scratch_store_dword off, v1, off offset:128
	ds_write_b128 v1, v[36:39]
	v_lshlrev_b32_e32 v1, 5, v50
	v_lshlrev_b32_e32 v34, 4, v44
	v_or_b32_e32 v35, 8, v1
	v_xor_b32_e32 v35, v35, v34
	scratch_store_dword off, v35, off offset:48
	v_or_b32_e32 v35, 16, v1
	v_xor_b32_e32 v35, v35, v34
	scratch_store_dword off, v35, off offset:44
	v_or_b32_e32 v35, 24, v1
	v_xor_b32_e32 v35, v35, v34
	scratch_store_dword off, v35, off offset:40
	v_or_b32_e32 v35, 0x80, v1
	v_xor_b32_e32 v35, v35, v34
	scratch_store_dword off, v35, off offset:36
	v_or_b32_e32 v35, 0x88, v1
	v_xor_b32_e32 v35, v35, v34
	v_xor_b32_e32 v36, v1, v34
	scratch_store_dword off, v35, off offset:32
	v_or_b32_e32 v35, 0x90, v1
	v_or_b32_e32 v1, 0x98, v1
	v_xor_b32_e32 v1, v1, v34
	v_xor_b32_e32 v35, v35, v34
	v_or_b32_e32 v1, v201, v1
	s_add_i32 s36, s13, 16
	scratch_store_dword off, v35, off offset:28
	scratch_store_dword off, v1, off offset:4
	scratch_store_dword off, v36, off offset:148
	v_or_b32_e32 v1, v201, v36
	s_mov_b32 s37, 0x8080808
	s_mov_b32 s38, 0x5010400
	s_mov_b32 s39, 0x7030602
	v_mov_b32_e32 v34, v98
	v_mov_b32_e32 v35, v98
	v_mov_b32_e32 v36, v98
	v_mov_b32_e32 v37, v98
	v_mov_b32_e32 v38, v98
	v_mov_b32_e32 v39, v98
	v_mov_b32_e32 v44, v98
	v_mov_b32_e32 v50, v98
	v_mov_b32_e32 v51, v98
	scratch_store_dword off, v1, off offset:52
.LBB0_2:
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v1, off, off offset:80
	s_add_i32 s40, s49, 1
	s_lshl_b32 s41, s40, 8
	s_waitcnt vmcnt(33)
	v_bfe_u32 v205, v218, s12, 8
	v_bfe_u32 v199, v218, s11, 8
	s_waitcnt vmcnt(31)
	v_bfe_u32 v253, v214, s8, 8
	v_bfe_u32 v252, v214, s5, 8
	s_waitcnt vmcnt(29)
	v_bfe_u32 v204, v219, s13, 8
	v_bfe_u32 v255, v219, s36, 8
	s_waitcnt vmcnt(27)
	v_bfe_u32 v251, v215, s9, 8
	v_bfe_u32 v250, v215, s10, 8
	s_waitcnt vmcnt(25)
	v_mov_b64_e32 v[188:189], v[68:69]
	v_mov_b64_e32 v[186:187], v[66:67]
	v_mov_b64_e32 v[196:197], v[92:93]
	v_mov_b64_e32 v[194:195], v[90:91]
	s_waitcnt vmcnt(23)
	v_mov_b64_e32 v[176:177], v[48:49]
	v_mov_b64_e32 v[174:175], v[46:47]
	v_mov_b64_e32 v[184:185], v[60:61]
	v_mov_b64_e32 v[182:183], v[58:59]
	s_waitcnt vmcnt(21)
	v_mov_b64_e32 v[160:161], v[20:21]
	v_mov_b64_e32 v[158:159], v[18:19]
	v_mov_b64_e32 v[168:169], v[28:29]
	v_mov_b64_e32 v[166:167], v[26:27]
	s_waitcnt vmcnt(19)
	v_mov_b64_e32 v[136:137], v[8:9]
	v_mov_b64_e32 v[134:135], v[6:7]
	v_mov_b64_e32 v[148:149], v[12:13]
	v_mov_b64_e32 v[146:147], v[10:11]
	s_waitcnt vmcnt(17)
	v_mov_b64_e32 v[140:141], v[72:73]
	v_mov_b64_e32 v[138:139], v[70:71]
	v_mov_b64_e32 v[192:193], v[96:97]
	v_mov_b64_e32 v[190:191], v[94:95]
	s_waitcnt vmcnt(15)
	v_mov_b64_e32 v[172:173], v[56:57]
	v_mov_b64_e32 v[170:171], v[54:55]
	v_mov_b64_e32 v[180:181], v[64:65]
	v_mov_b64_e32 v[178:179], v[62:63]
	s_waitcnt vmcnt(13)
	v_mov_b64_e32 v[156:157], v[24:25]
	v_mov_b64_e32 v[154:155], v[22:23]
	v_mov_b64_e32 v[164:165], v[32:33]
	v_mov_b64_e32 v[162:163], v[30:31]
	s_waitcnt vmcnt(11)
	v_mov_b64_e32 v[132:133], v[4:5]
	v_mov_b64_e32 v[130:131], v[2:3]
	v_mov_b64_e32 v[144:145], v[16:17]
	v_mov_b64_e32 v[142:143], v[14:15]
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v1, s41, v1
	buffer_load_dwordx4 v[226:229], v1, s[28:31], 0 offen nt
	s_nop 0
	scratch_load_dword v1, off, off offset:84
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v1, s41, v1
	buffer_load_dwordx4 v[230:233], v1, s[28:31], 0 offen nt
	s_lshl_b32 s41, s40, 6
	scratch_load_dword v1, off, off offset:60
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v248, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:76
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v218, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:100
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v217, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:116
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v214, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:68
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v247, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:92
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v219, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:108
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v216, v1, s[24:27], 0 offen
	s_nop 0
	scratch_load_dword v1, off, off offset:124
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 2
	buffer_load_dword v215, v1, s[24:27], 0 offen
	s_lshl_b32 s41, s40, 7
	scratch_load_dword v1, off, off offset:56
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s41, v1
	v_lshlrev_b32_e32 v1, 4, v1
	buffer_load_dwordx4 v[90:93], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[66:69], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:72
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 4
	buffer_load_dwordx4 v[58:61], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[46:49], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:96
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s41, v1
	v_lshlrev_b32_e32 v1, 4, v1
	buffer_load_dwordx4 v[26:29], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:112
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 4
	buffer_load_dwordx4 v[10:13], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:64
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v1, s41, v1
	v_lshlrev_b32_e32 v1, 4, v1
	buffer_load_dwordx4 v[94:97], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[70:73], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:88
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 4
	buffer_load_dwordx4 v[62:65], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[54:57], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:104
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 4
	buffer_load_dwordx4 v[30:33], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v1, s[0:3], 0 offen offset:1024 sc0
	s_nop 0
	scratch_load_dword v1, off, off offset:120
	s_waitcnt vmcnt(0)
	v_add_lshl_u32 v1, s41, v1, 4
	buffer_load_dwordx4 v[14:17], v1, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v1, s[0:3], 0 offen offset:1024 sc0
	scratch_load_dword v153, off, off offset:24
	v_sub_u32_sdwa v1, v212, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v151, 11, v1
	v_mul_lo_u32 v151, v151, s37
	v_sub_u32_e32 v152, 0x6c686080, v151
	v_and_b32_e32 v152, 0xffffff00, v152
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v151, 0x7c787470, v151
	v_sub_u32_sdwa v0, v212, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cndmask_b32_e64 v221, v152, 0, vcc
	v_cndmask_b32_e64 v222, v151, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v221
	v_and_b32_e32 v223, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v222
	v_and_b32_e32 v224, 0x80808080, v1
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v151, 0x6c686080, v1
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_and_b32_e32 v151, 0xffffff00, v151
	s_lshl_b32 s41, s49, 13
	v_cndmask_b32_e64 v200, v1, 0, vcc
	v_cndmask_b32_e64 v202, v151, 0, vcc
	s_and_b32 s41, s41, 0x2000
	v_lshlrev_b32_e32 v237, 4, v192
	v_add_u32_e32 v0, 0x7f7f7f00, v202
	v_and_b32_e32 v198, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v200
	v_and_b32_e32 v0, 0x80808080, v0
	v_lshlrev_b32_e32 v210, 4, v178
	s_mov_b32 s49, s40
	s_waitcnt vmcnt(0)
	v_sub_u32_sdwa v1, v153, v150 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v151, 11, v1
	v_mul_lo_u32 v151, v151, s37
	v_sub_u32_e32 v152, 0x6c686080, v151
	v_and_b32_e32 v152, 0xffffff00, v152
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v151, 0x7c787470, v151
	s_nop 0
	v_cndmask_b32_e64 v225, v152, 0, vcc
	v_cndmask_b32_e64 v234, v151, 0, vcc
	v_add_u32_e32 v1, 0x7f7f7f00, v225
	v_and_b32_e32 v235, 0x80808000, v1
	v_add_u32_e32 v1, 0x7f7f7f78, v234
	v_and_b32_e32 v236, 0x80808080, v1
	v_sub_u32_sdwa v1, v153, v150 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v150, 11, v1
	v_mul_lo_u32 v150, v150, s37
	v_sub_u32_e32 v151, 0x6c686080, v150
	v_and_b32_e32 v151, 0xffffff00, v151
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_sub_u32_e32 v150, 0x7c787470, v150
	v_lshlrev_b32_e32 v153, 4, v194
	v_cndmask_b32_e64 v245, v151, 0, vcc
	v_cndmask_b32_e64 v1, v150, 0, vcc
	v_add_u32_e32 v150, 0x7f7f7f00, v245
	v_and_b32_e32 v203, 0x80808000, v150
	v_add_u32_e32 v150, 0x7f7f7f78, v1
	v_and_b32_e32 v220, 0x80808080, v150
	v_and_b32_e32 v150, 0x7070707, v194
	v_lshrrev_b32_e32 v151, 4, v194
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v224, v223, v150
	v_perm_b32 v150, v222, v221, v150
	v_and_or_b32 v150, v152, v153, v150
	v_perm_b32 v152, v224, v223, v151
	v_perm_b32 v151, v222, v221, v151
	v_and_or_b32 v151, v152, v194, v151
	v_perm_b32 v206, v151, v150, s38
	v_perm_b32 v207, v151, v150, s39
	v_and_b32_e32 v150, 0x7070707, v190
	v_lshrrev_b32_e32 v151, 4, v190
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v236, v235, v150
	v_lshlrev_b32_e32 v153, 4, v190
	v_perm_b32 v150, v234, v225, v150
	v_and_or_b32 v150, v152, v153, v150
	v_perm_b32 v152, v236, v235, v151
	v_perm_b32 v151, v234, v225, v151
	v_and_or_b32 v151, v152, v190, v151
	v_perm_b32 v208, v151, v150, s38
	v_perm_b32 v209, v151, v150, s39
	scratch_load_dword v150, off, off offset:52
	v_and_b32_e32 v190, 0x7070707, v195
	v_lshrrev_b32_e32 v194, 4, v195
	v_and_b32_e32 v194, 0x7070707, v194
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v150, s41, v150
	ds_read2st64_b64 v[150:153], v150 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[152:153], v[206:207], v[102:105]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[150:151], v[206:207], v[98:101]
	v_perm_b32 v206, v224, v223, v190
	v_lshlrev_b32_e32 v207, 4, v195
	v_perm_b32 v190, v222, v221, v190
	v_and_or_b32 v190, v206, v207, v190
	v_perm_b32 v206, v224, v223, v194
	v_perm_b32 v194, v222, v221, v194
	v_and_or_b32 v195, v206, v195, v194
	v_perm_b32 v194, v195, v190, s38
	v_perm_b32 v195, v195, v190, s39
	v_and_b32_e32 v190, 0x7070707, v191
	v_lshrrev_b32_e32 v206, 4, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[150:151], v[208:209], v[106:109]
	v_and_b32_e32 v206, 0x7070707, v206
	v_perm_b32 v207, v236, v235, v190
	v_perm_b32 v190, v234, v225, v190
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[152:153], v[208:209], v[110:113]
	v_lshlrev_b32_e32 v208, 4, v191
	v_and_or_b32 v207, v207, v208, v190
	v_perm_b32 v190, v236, v235, v206
	v_perm_b32 v206, v234, v225, v206
	v_and_or_b32 v191, v190, v191, v206
	scratch_load_dword v206, off, off offset:48
	v_perm_b32 v190, v191, v207, s38
	v_perm_b32 v191, v191, v207, s39
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v208, s41, v206
	v_or_b32_e32 v206, v208, v201
	v_or_b32_e32 v208, v208, v242
	ds_read_b64 v[206:207], v206
	ds_read_b64 v[208:209], v208
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[206:207], v[190:191], v[106:109]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[208:209], v[190:191], v[110:113]
	v_and_b32_e32 v190, 0x7070707, v196
	v_lshrrev_b32_e32 v191, 4, v196
	v_and_b32_e32 v191, 0x7070707, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[206:207], v[194:195], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[208:209], v[194:195], v[102:105]
	v_perm_b32 v194, v224, v223, v190
	v_lshlrev_b32_e32 v195, 4, v196
	v_perm_b32 v190, v222, v221, v190
	v_and_or_b32 v194, v194, v195, v190
	v_perm_b32 v190, v224, v223, v191
	v_perm_b32 v191, v222, v221, v191
	v_and_or_b32 v191, v190, v196, v191
	v_perm_b32 v190, v191, v194, s38
	v_perm_b32 v191, v191, v194, s39
	v_and_b32_e32 v194, 0x7070707, v192
	v_lshrrev_b32_e32 v195, 4, v192
	v_and_b32_e32 v195, 0x7070707, v195
	v_perm_b32 v196, v236, v235, v194
	v_perm_b32 v194, v234, v225, v194
	v_and_or_b32 v196, v196, v237, v194
	v_perm_b32 v194, v236, v235, v195
	v_perm_b32 v195, v234, v225, v195
	v_and_or_b32 v192, v194, v192, v195
	v_perm_b32 v194, v192, v196, s38
	v_perm_b32 v195, v192, v196, s39
	scratch_load_dword v192, off, off offset:44
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v192, s41, v192
	v_or_b32_e32 v196, v192, v201
	v_or_b32_e32 v192, v192, v242
	ds_read_b64 v[238:239], v196
	ds_read_b64 v[240:241], v192
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[238:239], v[190:191], v[98:101]
	v_lshlrev_b32_e32 v196, 4, v193
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[240:241], v[190:191], v[102:105]
	v_and_b32_e32 v190, 0x7070707, v197
	v_lshrrev_b32_e32 v191, 4, v197
	v_and_b32_e32 v191, 0x7070707, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[238:239], v[194:195], v[106:109]
	v_perm_b32 v192, v224, v223, v190
	v_perm_b32 v190, v222, v221, v190
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[240:241], v[194:195], v[110:113]
	v_lshlrev_b32_e32 v194, 4, v197
	v_and_or_b32 v192, v192, v194, v190
	v_perm_b32 v190, v224, v223, v191
	v_perm_b32 v191, v222, v221, v191
	v_and_or_b32 v191, v190, v197, v191
	v_perm_b32 v190, v191, v192, s38
	v_perm_b32 v191, v191, v192, s39
	v_and_b32_e32 v192, 0x7070707, v193
	v_lshrrev_b32_e32 v194, 4, v193
	v_and_b32_e32 v194, 0x7070707, v194
	v_perm_b32 v195, v236, v235, v192
	v_perm_b32 v192, v234, v225, v192
	v_and_or_b32 v195, v195, v196, v192
	v_perm_b32 v192, v236, v235, v194
	v_perm_b32 v194, v234, v225, v194
	v_and_or_b32 v193, v192, v193, v194
	scratch_load_dword v194, off, off offset:40
	v_perm_b32 v192, v193, v195, s38
	v_perm_b32 v193, v193, v195, s39
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v194, s41, v194
	v_or_b32_e32 v195, v194, v201
	v_or_b32_e32 v194, v194, v242
	ds_read_b64 v[234:235], v195
	ds_read_b64 v[236:237], v194
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[234:235], v[190:191], v[98:101]
	v_lshlrev_b32_e32 v194, 4, v138
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[236:237], v[190:191], v[102:105]
	v_and_b32_e32 v190, 0x7070707, v186
	v_lshrrev_b32_e32 v191, 4, v186
	v_and_b32_e32 v191, 0x7070707, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[234:235], v[192:193], v[106:109]
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[236:237], v[192:193], v[110:113]
	v_perm_b32 v192, v0, v198, v190
	v_lshlrev_b32_e32 v193, 4, v186
	v_perm_b32 v190, v200, v202, v190
	v_and_or_b32 v192, v192, v193, v190
	v_perm_b32 v190, v0, v198, v191
	v_perm_b32 v191, v200, v202, v191
	v_and_or_b32 v186, v190, v186, v191
	v_perm_b32 v190, v186, v192, s38
	v_perm_b32 v191, v186, v192, s39
	v_and_b32_e32 v186, 0x7070707, v138
	v_lshrrev_b32_e32 v192, 4, v138
	v_and_b32_e32 v192, 0x7070707, v192
	v_perm_b32 v193, v220, v203, v186
	v_perm_b32 v186, v1, v245, v186
	v_and_or_b32 v186, v193, v194, v186
	v_perm_b32 v193, v220, v203, v192
	v_perm_b32 v192, v1, v245, v192
	v_and_or_b32 v138, v193, v138, v192
	v_perm_b32 v192, v138, v186, s38
	v_perm_b32 v193, v138, v186, s39
	scratch_load_dword v138, off, off offset:36
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v138, s41, v138
	v_or_b32_e32 v186, v138, v201
	v_or_b32_e32 v138, v138, v242
	ds_read_b64 v[222:223], v186
	ds_read_b64 v[224:225], v138
	v_and_b32_e32 v138, 0x7070707, v187
	v_lshrrev_b32_e32 v186, 4, v187
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[222:223], v[190:191], v[98:101]
	v_and_b32_e32 v186, 0x7070707, v186
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[224:225], v[190:191], v[102:105]
	v_perm_b32 v190, v0, v198, v138
	v_lshlrev_b32_e32 v191, 4, v187
	v_perm_b32 v138, v200, v202, v138
	v_and_or_b32 v138, v190, v191, v138
	v_perm_b32 v190, v0, v198, v186
	v_perm_b32 v186, v200, v202, v186
	v_and_or_b32 v187, v190, v187, v186
	v_perm_b32 v186, v187, v138, s38
	v_perm_b32 v187, v187, v138, s39
	v_and_b32_e32 v138, 0x7070707, v139
	v_lshrrev_b32_e32 v190, 4, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[222:223], v[192:193], v[106:109]
	v_and_b32_e32 v190, 0x7070707, v190
	v_perm_b32 v191, v220, v203, v138
	v_perm_b32 v138, v1, v245, v138
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[224:225], v[192:193], v[110:113]
	v_lshlrev_b32_e32 v192, 4, v139
	v_and_or_b32 v191, v191, v192, v138
	v_perm_b32 v138, v220, v203, v190
	v_perm_b32 v190, v1, v245, v190
	v_and_or_b32 v139, v138, v139, v190
	scratch_load_dword v190, off, off offset:32
	v_perm_b32 v138, v139, v191, s38
	v_perm_b32 v139, v139, v191, s39
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v190, s41, v190
	v_or_b32_e32 v191, v190, v201
	v_or_b32_e32 v190, v190, v242
	ds_read_b64 v[194:195], v191
	ds_read_b64 v[196:197], v190
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[194:195], v[138:139], v[106:109]
	v_lshlrev_b32_e32 v190, 4, v140
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[196:197], v[138:139], v[110:113]
	v_and_b32_e32 v138, 0x7070707, v188
	v_lshrrev_b32_e32 v139, 4, v188
	v_and_b32_e32 v139, 0x7070707, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[194:195], v[186:187], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[196:197], v[186:187], v[102:105]
	v_perm_b32 v186, v0, v198, v138
	v_lshlrev_b32_e32 v187, 4, v188
	v_perm_b32 v138, v200, v202, v138
	v_and_or_b32 v186, v186, v187, v138
	v_perm_b32 v138, v0, v198, v139
	v_perm_b32 v139, v200, v202, v139
	v_and_or_b32 v139, v138, v188, v139
	v_perm_b32 v138, v139, v186, s38
	v_perm_b32 v139, v139, v186, s39
	v_and_b32_e32 v186, 0x7070707, v140
	v_lshrrev_b32_e32 v187, 4, v140
	v_and_b32_e32 v187, 0x7070707, v187
	v_perm_b32 v188, v220, v203, v186
	v_perm_b32 v186, v1, v245, v186
	v_and_or_b32 v188, v188, v190, v186
	v_perm_b32 v186, v220, v203, v187
	v_perm_b32 v187, v1, v245, v187
	v_and_or_b32 v140, v186, v140, v187
	v_perm_b32 v186, v140, v188, s38
	v_perm_b32 v187, v140, v188, s39
	scratch_load_dword v140, off, off offset:28
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v140, s41, v140
	v_or_b32_e32 v188, v140, v201
	v_or_b32_e32 v140, v140, v242
	ds_read_b64 v[190:191], v188
	ds_read_b64 v[192:193], v140
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[190:191], v[138:139], v[98:101]
	v_sub_u32_e32 v188, v211, v204
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[192:193], v[138:139], v[102:105]
	v_lshrrev_b32_e32 v139, 4, v189
	v_and_b32_e32 v138, 0x7070707, v189
	v_and_b32_e32 v139, 0x7070707, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[190:191], v[186:187], v[106:109]
	v_perm_b32 v140, v0, v198, v138
	v_perm_b32 v138, v200, v202, v138
	v_perm_b32 v0, v0, v198, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[192:193], v[186:187], v[110:113]
	v_lshlrev_b32_e32 v186, 4, v189
	v_perm_b32 v139, v200, v202, v139
	v_and_or_b32 v138, v140, v186, v138
	v_and_or_b32 v0, v0, v189, v139
	v_perm_b32 v186, v0, v138, s38
	v_perm_b32 v187, v0, v138, s39
	v_and_b32_e32 v0, 0x7070707, v141
	v_lshrrev_b32_e32 v138, 4, v141
	v_and_b32_e32 v138, 0x7070707, v138
	v_perm_b32 v139, v220, v203, v0
	v_lshlrev_b32_e32 v140, 4, v141
	v_perm_b32 v0, v1, v245, v0
	v_and_or_b32 v139, v139, v140, v0
	v_perm_b32 v0, v220, v203, v138
	v_perm_b32 v1, v1, v245, v138
	scratch_load_dword v138, off, off offset:4
	v_and_or_b32 v1, v0, v141, v1
	v_perm_b32 v0, v1, v139, s38
	v_perm_b32 v1, v1, v139, s39
	v_min_i32_e32 v189, 11, v188
	v_mul_lo_u32 v189, v189, s37
	v_sub_u32_e32 v198, 0x6c686080, v189
	v_and_b32_e32 v198, 0xffffff00, v198
	v_sub_u32_e32 v189, 0x7c787470, v189
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v138, s41, v138
	ds_read2st64_b64 v[138:141], v138 offset1:8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[140:141], v[0:1], v[110:113]
	s_xor_b32 s41, s41, 0x2000
	s_cmp_lg_u32 s40, 15
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[138:139], v[0:1], v[106:109]
	v_sub_u32_e32 v0, v213, v205
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[138:139], v[186:187], v[98:101]
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[140:141], v[186:187], v[102:105]
	v_sub_u32_e32 v186, 0x6c686080, v1
	v_and_b32_e32 v186, 0xffffff00, v186
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_cndmask_b32_e64 v200, v186, 0, vcc
	v_cndmask_b32_e64 v202, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v200
	v_and_b32_e32 v203, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v202
	v_and_b32_e32 v205, 0x80808080, v0
	v_sub_u32_e32 v0, v213, v199
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v186, 0x6c686080, v1
	v_and_b32_e32 v186, 0xffffff00, v186
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_lshlrev_b32_e32 v199, 4, v182
	s_nop 0
	v_cndmask_b32_e64 v0, v186, 0, vcc
	v_cndmask_b32_e64 v1, v1, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v188
	v_add_u32_e32 v186, 0x7f7f7f00, v0
	v_add_u32_e32 v187, 0x7f7f7f78, v1
	v_cndmask_b32_e64 v204, v198, 0, vcc
	v_cndmask_b32_e64 v220, v189, 0, vcc
	v_add_u32_e32 v188, 0x7f7f7f00, v204
	v_and_b32_e32 v221, 0x80808000, v188
	v_add_u32_e32 v188, 0x7f7f7f78, v220
	v_and_b32_e32 v245, 0x80808080, v188
	v_sub_u32_e32 v188, v211, v255
	v_min_i32_e32 v189, 11, v188
	v_mul_lo_u32 v189, v189, s37
	v_sub_u32_e32 v198, 0x6c686080, v189
	v_and_b32_e32 v198, 0xffffff00, v198
	v_cmp_lt_i32_e32 vcc, 11, v188
	v_sub_u32_e32 v189, 0x7c787470, v189
	v_and_b32_e32 v186, 0x80808000, v186
	v_cndmask_b32_e64 v255, v198, 0, vcc
	v_cndmask_b32_e64 v244, v189, 0, vcc
	v_add_u32_e32 v188, 0x7f7f7f00, v255
	v_and_b32_e32 v246, 0x80808000, v188
	v_add_u32_e32 v188, 0x7f7f7f78, v244
	v_and_b32_e32 v243, 0x80808080, v188
	v_and_b32_e32 v188, 0x7070707, v182
	v_lshrrev_b32_e32 v189, 4, v182
	v_and_b32_e32 v189, 0x7070707, v189
	v_perm_b32 v198, v205, v203, v188
	v_perm_b32 v188, v202, v200, v188
	v_and_or_b32 v198, v198, v199, v188
	v_perm_b32 v188, v205, v203, v189
	v_perm_b32 v189, v202, v200, v189
	v_and_or_b32 v182, v188, v182, v189
	v_perm_b32 v188, v182, v198, s38
	v_perm_b32 v189, v182, v198, s39
	v_and_b32_e32 v182, 0x7070707, v178
	v_lshrrev_b32_e32 v198, 4, v178
	v_and_b32_e32 v198, 0x7070707, v198
	v_perm_b32 v199, v245, v221, v182
	v_perm_b32 v182, v220, v204, v182
	v_and_or_b32 v182, v199, v210, v182
	v_perm_b32 v199, v245, v221, v198
	v_perm_b32 v198, v220, v204, v198
	v_and_or_b32 v178, v199, v178, v198
	v_perm_b32 v198, v178, v182, s38
	v_perm_b32 v199, v178, v182, s39
	v_and_b32_e32 v178, 0x7070707, v183
	v_lshrrev_b32_e32 v182, 4, v183
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[150:151], v[188:189], v[74:77]
	v_and_b32_e32 v182, 0x7070707, v182
	v_and_b32_e32 v187, 0x80808080, v187
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[152:153], v[188:189], v[78:81]
	v_perm_b32 v188, v205, v203, v178
	v_lshlrev_b32_e32 v189, 4, v183
	v_perm_b32 v178, v202, v200, v178
	v_and_or_b32 v178, v188, v189, v178
	v_perm_b32 v188, v205, v203, v182
	v_perm_b32 v182, v202, v200, v182
	v_and_or_b32 v183, v188, v183, v182
	v_perm_b32 v182, v183, v178, s38
	v_perm_b32 v183, v183, v178, s39
	v_and_b32_e32 v178, 0x7070707, v179
	v_lshrrev_b32_e32 v188, 4, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[150:151], v[198:199], v[82:85]
	v_and_b32_e32 v188, 0x7070707, v188
	v_perm_b32 v189, v245, v221, v178
	v_perm_b32 v178, v220, v204, v178
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[152:153], v[198:199], v[86:89]
	v_lshlrev_b32_e32 v198, 4, v179
	v_and_or_b32 v189, v189, v198, v178
	v_perm_b32 v178, v245, v221, v188
	v_perm_b32 v188, v220, v204, v188
	v_and_or_b32 v179, v178, v179, v188
	v_perm_b32 v178, v179, v189, s38
	v_perm_b32 v179, v179, v189, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[206:207], v[182:183], v[74:77]
	v_lshlrev_b32_e32 v188, 4, v180
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[206:207], v[178:179], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[208:209], v[178:179], v[86:89]
	v_and_b32_e32 v178, 0x7070707, v184
	v_lshrrev_b32_e32 v179, 4, v184
	v_and_b32_e32 v179, 0x7070707, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[208:209], v[182:183], v[78:81]
	v_perm_b32 v182, v205, v203, v178
	v_lshlrev_b32_e32 v183, 4, v184
	v_perm_b32 v178, v202, v200, v178
	v_and_or_b32 v182, v182, v183, v178
	v_perm_b32 v178, v205, v203, v179
	v_perm_b32 v179, v202, v200, v179
	v_and_or_b32 v179, v178, v184, v179
	v_perm_b32 v178, v179, v182, s38
	v_perm_b32 v179, v179, v182, s39
	v_and_b32_e32 v182, 0x7070707, v180
	v_lshrrev_b32_e32 v183, 4, v180
	v_and_b32_e32 v183, 0x7070707, v183
	v_perm_b32 v184, v245, v221, v182
	v_perm_b32 v182, v220, v204, v182
	v_and_or_b32 v184, v184, v188, v182
	v_perm_b32 v182, v245, v221, v183
	v_perm_b32 v183, v220, v204, v183
	v_and_or_b32 v180, v182, v180, v183
	v_perm_b32 v182, v180, v184, s38
	v_perm_b32 v183, v180, v184, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[238:239], v[178:179], v[74:77]
	v_lshlrev_b32_e32 v184, 4, v181
	v_lshlrev_b32_e32 v188, 4, v162
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[240:241], v[178:179], v[78:81]
	v_and_b32_e32 v178, 0x7070707, v185
	v_lshrrev_b32_e32 v179, 4, v185
	v_and_b32_e32 v179, 0x7070707, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[238:239], v[182:183], v[82:85]
	v_perm_b32 v180, v205, v203, v178
	v_perm_b32 v178, v202, v200, v178
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[240:241], v[182:183], v[86:89]
	v_lshlrev_b32_e32 v182, 4, v185
	v_and_or_b32 v180, v180, v182, v178
	v_perm_b32 v178, v205, v203, v179
	v_perm_b32 v179, v202, v200, v179
	v_and_or_b32 v179, v178, v185, v179
	v_perm_b32 v178, v179, v180, s38
	v_perm_b32 v179, v179, v180, s39
	v_and_b32_e32 v180, 0x7070707, v181
	v_lshrrev_b32_e32 v182, 4, v181
	v_and_b32_e32 v182, 0x7070707, v182
	v_perm_b32 v183, v245, v221, v180
	v_perm_b32 v180, v220, v204, v180
	v_and_or_b32 v183, v183, v184, v180
	v_perm_b32 v180, v245, v221, v182
	v_perm_b32 v182, v220, v204, v182
	v_and_or_b32 v181, v180, v181, v182
	v_perm_b32 v180, v181, v183, s38
	v_perm_b32 v181, v181, v183, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[234:235], v[178:179], v[74:77]
	v_lshlrev_b32_e32 v182, 4, v170
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[236:237], v[178:179], v[78:81]
	v_and_b32_e32 v178, 0x7070707, v174
	v_lshrrev_b32_e32 v179, 4, v174
	v_and_b32_e32 v179, 0x7070707, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[234:235], v[180:181], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[236:237], v[180:181], v[86:89]
	v_perm_b32 v180, v187, v186, v178
	v_lshlrev_b32_e32 v181, 4, v174
	v_perm_b32 v178, v1, v0, v178
	v_and_or_b32 v180, v180, v181, v178
	v_perm_b32 v178, v187, v186, v179
	v_perm_b32 v179, v1, v0, v179
	v_and_or_b32 v174, v178, v174, v179
	v_perm_b32 v178, v174, v180, s38
	v_perm_b32 v179, v174, v180, s39
	v_and_b32_e32 v174, 0x7070707, v170
	v_lshrrev_b32_e32 v180, 4, v170
	v_and_b32_e32 v180, 0x7070707, v180
	v_perm_b32 v181, v243, v246, v174
	v_perm_b32 v174, v244, v255, v174
	v_and_or_b32 v174, v181, v182, v174
	v_perm_b32 v181, v243, v246, v180
	v_perm_b32 v180, v244, v255, v180
	v_and_or_b32 v170, v181, v170, v180
	v_perm_b32 v180, v170, v174, s38
	v_perm_b32 v181, v170, v174, s39
	v_and_b32_e32 v170, 0x7070707, v175
	v_lshrrev_b32_e32 v174, 4, v175
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[222:223], v[178:179], v[74:77]
	v_and_b32_e32 v174, 0x7070707, v174
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[224:225], v[178:179], v[78:81]
	v_perm_b32 v178, v187, v186, v170
	v_lshlrev_b32_e32 v179, 4, v175
	v_perm_b32 v170, v1, v0, v170
	v_and_or_b32 v170, v178, v179, v170
	v_perm_b32 v178, v187, v186, v174
	v_perm_b32 v174, v1, v0, v174
	v_and_or_b32 v175, v178, v175, v174
	v_perm_b32 v174, v175, v170, s38
	v_perm_b32 v175, v175, v170, s39
	v_and_b32_e32 v170, 0x7070707, v171
	v_lshrrev_b32_e32 v178, 4, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[222:223], v[180:181], v[82:85]
	v_and_b32_e32 v178, 0x7070707, v178
	v_perm_b32 v179, v243, v246, v170
	v_perm_b32 v170, v244, v255, v170
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[224:225], v[180:181], v[86:89]
	v_lshlrev_b32_e32 v180, 4, v171
	v_and_or_b32 v179, v179, v180, v170
	v_perm_b32 v170, v243, v246, v178
	v_perm_b32 v178, v244, v255, v178
	v_and_or_b32 v171, v170, v171, v178
	v_perm_b32 v170, v171, v179, s38
	v_perm_b32 v171, v171, v179, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[194:195], v[174:175], v[74:77]
	v_lshlrev_b32_e32 v178, 4, v172
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[194:195], v[170:171], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[196:197], v[170:171], v[86:89]
	v_and_b32_e32 v170, 0x7070707, v176
	v_lshrrev_b32_e32 v171, 4, v176
	v_and_b32_e32 v171, 0x7070707, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[196:197], v[174:175], v[78:81]
	v_perm_b32 v174, v187, v186, v170
	v_lshlrev_b32_e32 v175, 4, v176
	v_perm_b32 v170, v1, v0, v170
	v_and_or_b32 v174, v174, v175, v170
	v_perm_b32 v170, v187, v186, v171
	v_perm_b32 v171, v1, v0, v171
	v_and_or_b32 v171, v170, v176, v171
	v_perm_b32 v170, v171, v174, s38
	v_perm_b32 v171, v171, v174, s39
	v_and_b32_e32 v174, 0x7070707, v172
	v_lshrrev_b32_e32 v175, 4, v172
	v_and_b32_e32 v175, 0x7070707, v175
	v_perm_b32 v176, v243, v246, v174
	v_perm_b32 v174, v244, v255, v174
	v_and_or_b32 v176, v176, v178, v174
	v_perm_b32 v174, v243, v246, v175
	v_perm_b32 v175, v244, v255, v175
	v_and_or_b32 v172, v174, v172, v175
	v_perm_b32 v174, v172, v176, s38
	v_perm_b32 v175, v172, v176, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[190:191], v[170:171], v[74:77]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[192:193], v[170:171], v[78:81]
	v_and_b32_e32 v170, 0x7070707, v177
	v_lshrrev_b32_e32 v171, 4, v177
	v_and_b32_e32 v171, 0x7070707, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[190:191], v[174:175], v[82:85]
	v_perm_b32 v172, v187, v186, v170
	v_perm_b32 v170, v1, v0, v170
	v_perm_b32 v0, v1, v0, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[192:193], v[174:175], v[86:89]
	v_lshlrev_b32_e32 v174, 4, v177
	v_and_or_b32 v170, v172, v174, v170
	v_perm_b32 v172, v187, v186, v171
	v_and_or_b32 v1, v172, v177, v0
	v_perm_b32 v0, v1, v170, s38
	v_perm_b32 v1, v1, v170, s39
	v_and_b32_e32 v170, 0x7070707, v173
	v_lshrrev_b32_e32 v171, 4, v173
	v_and_b32_e32 v171, 0x7070707, v171
	v_perm_b32 v172, v243, v246, v170
	v_lshlrev_b32_e32 v174, 4, v173
	v_perm_b32 v170, v244, v255, v170
	v_and_or_b32 v172, v172, v174, v170
	v_perm_b32 v170, v243, v246, v171
	v_perm_b32 v171, v244, v255, v171
	v_and_or_b32 v171, v170, v173, v171
	v_perm_b32 v170, v171, v172, s38
	v_perm_b32 v171, v171, v172, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[138:139], v[0:1], v[74:77]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[138:139], v[170:171], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[140:141], v[170:171], v[86:89]
	scratch_load_dword v171, off, off offset:16
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[140:141], v[0:1], v[78:81]
	s_waitcnt vmcnt(0)
	v_sub_u32_sdwa v0, v171, v254 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v170, 0x6c686080, v1
	v_and_b32_e32 v170, 0xffffff00, v170
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	s_nop 0
	v_cndmask_b32_e64 v172, v170, 0, vcc
	v_cndmask_b32_e64 v173, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v172
	v_and_b32_e32 v174, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v173
	v_and_b32_e32 v175, 0x80808080, v0
	v_sub_u32_sdwa v0, v171, v254 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	scratch_load_dword v171, off, off offset:8
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v170, 0x6c686080, v1
	v_and_b32_e32 v170, 0xffffff00, v170
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_mov_b32_e32 v254, v217
	v_cndmask_b32_e64 v176, v170, 0, vcc
	v_cndmask_b32_e64 v177, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v176
	v_and_b32_e32 v178, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v177
	v_and_b32_e32 v179, 0x80808080, v0
	s_waitcnt vmcnt(0)
	v_sub_u32_sdwa v0, v171, v249 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v170, 0x6c686080, v1
	v_and_b32_e32 v170, 0xffffff00, v170
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	s_nop 0
	v_cndmask_b32_e64 v180, v170, 0, vcc
	v_cndmask_b32_e64 v181, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v180
	v_and_b32_e32 v182, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v181
	v_and_b32_e32 v183, 0x80808080, v0
	v_sub_u32_sdwa v0, v171, v249 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v170, 0x6c686080, v1
	v_and_b32_e32 v170, 0xffffff00, v170
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_lshlrev_b32_e32 v171, 4, v166
	v_cndmask_b32_e64 v184, v170, 0, vcc
	v_cndmask_b32_e64 v185, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v184
	v_and_b32_e32 v186, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v185
	v_and_b32_e32 v187, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v166
	v_lshrrev_b32_e32 v1, 4, v166
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v170, v175, v174, v0
	v_perm_b32 v0, v173, v172, v0
	v_and_or_b32 v170, v170, v171, v0
	v_perm_b32 v0, v175, v174, v1
	v_perm_b32 v1, v173, v172, v1
	v_and_or_b32 v1, v0, v166, v1
	v_perm_b32 v0, v1, v170, s38
	v_perm_b32 v1, v1, v170, s39
	v_and_b32_e32 v166, 0x7070707, v162
	v_lshrrev_b32_e32 v170, 4, v162
	v_and_b32_e32 v170, 0x7070707, v170
	v_perm_b32 v171, v183, v182, v166
	v_perm_b32 v166, v181, v180, v166
	v_and_or_b32 v166, v171, v188, v166
	v_perm_b32 v171, v183, v182, v170
	v_perm_b32 v170, v181, v180, v170
	v_and_or_b32 v162, v171, v162, v170
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[150:151], v[0:1], v[34:37]
	v_perm_b32 v170, v162, v166, s38
	v_perm_b32 v171, v162, v166, s39
	v_lshlrev_b32_e32 v166, 4, v167
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[152:153], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v167
	v_lshrrev_b32_e32 v1, 4, v167
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v162, v175, v174, v0
	v_perm_b32 v0, v173, v172, v0
	v_and_or_b32 v162, v162, v166, v0
	v_perm_b32 v0, v175, v174, v1
	v_perm_b32 v1, v173, v172, v1
	v_and_or_b32 v1, v0, v167, v1
	v_perm_b32 v0, v1, v162, s38
	v_perm_b32 v1, v1, v162, s39
	v_and_b32_e32 v162, 0x7070707, v163
	v_lshrrev_b32_e32 v166, 4, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[150:151], v[170:171], v[42:45]
	v_and_b32_e32 v166, 0x7070707, v166
	v_perm_b32 v167, v183, v182, v162
	v_perm_b32 v162, v181, v180, v162
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[152:153], v[170:171], v[50:53]
	v_lshlrev_b32_e32 v170, 4, v163
	v_and_or_b32 v167, v167, v170, v162
	v_perm_b32 v162, v183, v182, v166
	v_perm_b32 v166, v181, v180, v166
	v_and_or_b32 v163, v162, v163, v166
	v_perm_b32 v162, v163, v167, s38
	v_perm_b32 v163, v163, v167, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[206:207], v[0:1], v[34:37]
	v_lshlrev_b32_e32 v167, 4, v164
	v_mov_b32_e32 v249, v216
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[208:209], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v168
	v_lshrrev_b32_e32 v1, 4, v168
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[206:207], v[162:163], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[208:209], v[162:163], v[50:53]
	v_perm_b32 v162, v175, v174, v0
	v_lshlrev_b32_e32 v163, 4, v168
	v_perm_b32 v0, v173, v172, v0
	v_and_or_b32 v162, v162, v163, v0
	v_perm_b32 v0, v175, v174, v1
	v_perm_b32 v1, v173, v172, v1
	v_and_or_b32 v1, v0, v168, v1
	v_perm_b32 v0, v1, v162, s38
	v_perm_b32 v1, v1, v162, s39
	v_and_b32_e32 v162, 0x7070707, v164
	v_lshrrev_b32_e32 v163, 4, v164
	v_and_b32_e32 v163, 0x7070707, v163
	v_perm_b32 v166, v183, v182, v162
	v_perm_b32 v162, v181, v180, v162
	v_and_or_b32 v166, v166, v167, v162
	v_perm_b32 v162, v183, v182, v163
	v_perm_b32 v163, v181, v180, v163
	v_and_or_b32 v163, v162, v164, v163
	v_perm_b32 v162, v163, v166, s38
	v_perm_b32 v163, v163, v166, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[238:239], v[0:1], v[34:37]
	v_lshlrev_b32_e32 v166, 4, v165
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[240:241], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v169
	v_lshrrev_b32_e32 v1, 4, v169
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[238:239], v[162:163], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[240:241], v[162:163], v[50:53]
	v_perm_b32 v162, v175, v174, v0
	v_lshlrev_b32_e32 v163, 4, v169
	v_perm_b32 v0, v173, v172, v0
	v_and_or_b32 v162, v162, v163, v0
	v_perm_b32 v0, v175, v174, v1
	v_perm_b32 v1, v173, v172, v1
	v_and_or_b32 v1, v0, v169, v1
	v_perm_b32 v0, v1, v162, s38
	v_perm_b32 v1, v1, v162, s39
	v_and_b32_e32 v162, 0x7070707, v165
	v_lshrrev_b32_e32 v163, 4, v165
	v_and_b32_e32 v163, 0x7070707, v163
	v_perm_b32 v164, v183, v182, v162
	v_perm_b32 v162, v181, v180, v162
	v_and_or_b32 v164, v164, v166, v162
	v_perm_b32 v162, v183, v182, v163
	v_perm_b32 v163, v181, v180, v163
	v_and_or_b32 v163, v162, v165, v163
	v_perm_b32 v162, v163, v164, s38
	v_perm_b32 v163, v163, v164, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[234:235], v[0:1], v[34:37]
	v_lshlrev_b32_e32 v164, 4, v154
	v_lshlrev_b32_e32 v172, 4, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[236:237], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v158
	v_lshrrev_b32_e32 v1, 4, v158
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[234:235], v[162:163], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[236:237], v[162:163], v[50:53]
	v_perm_b32 v162, v179, v178, v0
	v_lshlrev_b32_e32 v163, 4, v158
	v_perm_b32 v0, v177, v176, v0
	v_and_or_b32 v162, v162, v163, v0
	v_perm_b32 v0, v179, v178, v1
	v_perm_b32 v1, v177, v176, v1
	v_and_or_b32 v1, v0, v158, v1
	v_perm_b32 v0, v1, v162, s38
	v_perm_b32 v1, v1, v162, s39
	v_and_b32_e32 v158, 0x7070707, v154
	v_lshrrev_b32_e32 v162, 4, v154
	v_and_b32_e32 v162, 0x7070707, v162
	v_perm_b32 v163, v187, v186, v158
	v_perm_b32 v158, v185, v184, v158
	v_and_or_b32 v158, v163, v164, v158
	v_perm_b32 v163, v187, v186, v162
	v_perm_b32 v162, v185, v184, v162
	v_and_or_b32 v154, v163, v154, v162
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[222:223], v[0:1], v[34:37]
	v_perm_b32 v162, v154, v158, s38
	v_perm_b32 v163, v154, v158, s39
	v_lshlrev_b32_e32 v158, 4, v159
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[224:225], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v159
	v_lshrrev_b32_e32 v1, 4, v159
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v154, v179, v178, v0
	v_perm_b32 v0, v177, v176, v0
	v_and_or_b32 v154, v154, v158, v0
	v_perm_b32 v0, v179, v178, v1
	v_perm_b32 v1, v177, v176, v1
	v_and_or_b32 v1, v0, v159, v1
	v_perm_b32 v0, v1, v154, s38
	v_perm_b32 v1, v1, v154, s39
	v_and_b32_e32 v154, 0x7070707, v155
	v_lshrrev_b32_e32 v158, 4, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[222:223], v[162:163], v[42:45]
	v_and_b32_e32 v158, 0x7070707, v158
	v_perm_b32 v159, v187, v186, v154
	v_perm_b32 v154, v185, v184, v154
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[224:225], v[162:163], v[50:53]
	v_lshlrev_b32_e32 v162, 4, v155
	v_and_or_b32 v159, v159, v162, v154
	v_perm_b32 v154, v187, v186, v158
	v_perm_b32 v158, v185, v184, v158
	v_and_or_b32 v155, v154, v155, v158
	v_perm_b32 v154, v155, v159, s38
	v_perm_b32 v155, v155, v159, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[194:195], v[0:1], v[34:37]
	v_lshlrev_b32_e32 v159, 4, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[196:197], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v160
	v_lshrrev_b32_e32 v1, 4, v160
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[194:195], v[154:155], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[196:197], v[154:155], v[50:53]
	v_perm_b32 v154, v179, v178, v0
	v_lshlrev_b32_e32 v155, 4, v160
	v_perm_b32 v0, v177, v176, v0
	v_and_or_b32 v154, v154, v155, v0
	v_perm_b32 v0, v179, v178, v1
	v_perm_b32 v1, v177, v176, v1
	v_and_or_b32 v1, v0, v160, v1
	v_perm_b32 v0, v1, v154, s38
	v_perm_b32 v1, v1, v154, s39
	v_and_b32_e32 v154, 0x7070707, v156
	v_lshrrev_b32_e32 v155, 4, v156
	v_and_b32_e32 v155, 0x7070707, v155
	v_perm_b32 v158, v187, v186, v154
	v_perm_b32 v154, v185, v184, v154
	v_and_or_b32 v158, v158, v159, v154
	v_perm_b32 v154, v187, v186, v155
	v_perm_b32 v155, v185, v184, v155
	v_and_or_b32 v155, v154, v156, v155
	v_perm_b32 v154, v155, v158, s38
	v_perm_b32 v155, v155, v158, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[190:191], v[0:1], v[34:37]
	v_lshlrev_b32_e32 v158, 4, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[192:193], v[0:1], v[38:41]
	v_and_b32_e32 v0, 0x7070707, v161
	v_lshrrev_b32_e32 v1, 4, v161
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[190:191], v[154:155], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[192:193], v[154:155], v[50:53]
	v_perm_b32 v154, v179, v178, v0
	v_lshlrev_b32_e32 v155, 4, v161
	v_perm_b32 v0, v177, v176, v0
	v_and_or_b32 v154, v154, v155, v0
	v_perm_b32 v0, v179, v178, v1
	v_perm_b32 v1, v177, v176, v1
	v_and_or_b32 v1, v0, v161, v1
	v_perm_b32 v0, v1, v154, s38
	v_perm_b32 v1, v1, v154, s39
	v_and_b32_e32 v154, 0x7070707, v157
	v_lshrrev_b32_e32 v155, 4, v157
	v_and_b32_e32 v155, 0x7070707, v155
	v_perm_b32 v156, v187, v186, v154
	v_perm_b32 v154, v185, v184, v154
	v_and_or_b32 v156, v156, v158, v154
	v_perm_b32 v154, v187, v186, v155
	v_perm_b32 v155, v185, v184, v155
	v_and_or_b32 v155, v154, v157, v155
	v_perm_b32 v154, v155, v156, s38
	v_perm_b32 v155, v155, v156, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[138:139], v[0:1], v[34:37]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[138:139], v[154:155], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[140:141], v[154:155], v[50:53]
	scratch_load_dword v155, off, off offset:20
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[140:141], v[0:1], v[38:41]
	s_waitcnt vmcnt(0)
	v_sub_u32_e32 v0, v155, v253
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v154, 0x6c686080, v1
	v_and_b32_e32 v154, 0xffffff00, v154
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	s_nop 0
	v_cndmask_b32_e64 v166, v154, 0, vcc
	v_cndmask_b32_e64 v167, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v166
	v_and_b32_e32 v170, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v167
	v_and_b32_e32 v171, 0x80808080, v0
	v_sub_u32_e32 v0, v155, v252
	scratch_load_dword v155, off, off offset:12
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v154, 0x6c686080, v1
	v_and_b32_e32 v154, 0xffffff00, v154
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	s_nop 0
	v_cndmask_b32_e64 v160, v154, 0, vcc
	v_cndmask_b32_e64 v161, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v160
	v_and_b32_e32 v162, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v161
	v_and_b32_e32 v163, 0x80808080, v0
	s_waitcnt vmcnt(0)
	v_sub_u32_e32 v0, v155, v251
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v154, 0x6c686080, v1
	v_and_b32_e32 v154, 0xffffff00, v154
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	s_nop 0
	v_cndmask_b32_e64 v164, v154, 0, vcc
	v_cndmask_b32_e64 v165, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v164
	v_and_b32_e32 v168, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v165
	v_and_b32_e32 v169, 0x80808080, v0
	v_sub_u32_e32 v0, v155, v250
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s37
	v_sub_u32_e32 v154, 0x6c686080, v1
	v_and_b32_e32 v154, 0xffffff00, v154
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_lshlrev_b32_e32 v155, 4, v146
	v_cndmask_b32_e64 v156, v154, 0, vcc
	v_cndmask_b32_e64 v157, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v156
	v_and_b32_e32 v158, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v157
	v_and_b32_e32 v159, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v146
	v_lshrrev_b32_e32 v1, 4, v146
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v154, v171, v170, v0
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v0, v154, v155, v0
	v_perm_b32 v154, v171, v170, v1
	v_perm_b32 v1, v167, v166, v1
	v_and_or_b32 v1, v154, v146, v1
	v_perm_b32 v154, v1, v0, s38
	v_perm_b32 v155, v1, v0, s39
	v_and_b32_e32 v0, 0x7070707, v142
	v_lshrrev_b32_e32 v1, 4, v142
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v146, v169, v168, v0
	v_perm_b32 v0, v165, v164, v0
	v_and_or_b32 v146, v146, v172, v0
	v_perm_b32 v0, v169, v168, v1
	v_perm_b32 v1, v165, v164, v1
	v_and_or_b32 v1, v0, v142, v1
	v_perm_b32 v0, v1, v146, s38
	v_perm_b32 v1, v1, v146, s39
	v_lshlrev_b32_e32 v146, 4, v147
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[150:151], v[154:155], v[118:121]
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[150:151], v[0:1], v[126:129]
	v_lshlrev_b32_e32 v150, 4, v143
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[152:153], v[0:1], v[122:125]
	v_and_b32_e32 v0, 0x7070707, v147
	v_lshrrev_b32_e32 v1, 4, v147
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v142, v171, v170, v0
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v142, v142, v146, v0
	v_perm_b32 v0, v171, v170, v1
	v_perm_b32 v1, v167, v166, v1
	v_and_or_b32 v1, v0, v147, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[152:153], v[154:155], v[114:117]
	v_perm_b32 v0, v1, v142, s38
	v_perm_b32 v1, v1, v142, s39
	v_and_b32_e32 v142, 0x7070707, v143
	v_lshrrev_b32_e32 v146, 4, v143
	v_and_b32_e32 v146, 0x7070707, v146
	v_perm_b32 v147, v169, v168, v142
	v_perm_b32 v142, v165, v164, v142
	v_and_or_b32 v147, v147, v150, v142
	v_perm_b32 v142, v169, v168, v146
	v_perm_b32 v146, v165, v164, v146
	v_and_or_b32 v143, v142, v143, v146
	v_perm_b32 v142, v143, v147, s38
	v_perm_b32 v143, v143, v147, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[206:207], v[0:1], v[118:121]
	v_lshlrev_b32_e32 v147, 4, v144
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[208:209], v[0:1], v[114:117]
	v_and_b32_e32 v0, 0x7070707, v148
	v_lshrrev_b32_e32 v1, 4, v148
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[206:207], v[142:143], v[126:129]
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[208:209], v[142:143], v[122:125]
	v_perm_b32 v142, v171, v170, v0
	v_lshlrev_b32_e32 v143, 4, v148
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v142, v142, v143, v0
	v_perm_b32 v0, v171, v170, v1
	v_perm_b32 v1, v167, v166, v1
	v_and_or_b32 v1, v0, v148, v1
	v_perm_b32 v0, v1, v142, s38
	v_perm_b32 v1, v1, v142, s39
	v_and_b32_e32 v142, 0x7070707, v144
	v_lshrrev_b32_e32 v143, 4, v144
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[238:239], v[0:1], v[118:121]
	v_and_b32_e32 v143, 0x7070707, v143
	v_perm_b32 v146, v169, v168, v142
	v_perm_b32 v142, v165, v164, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[240:241], v[0:1], v[114:117]
	v_and_b32_e32 v0, 0x7070707, v149
	v_lshrrev_b32_e32 v1, 4, v149
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v114, v171, v170, v0
	v_lshlrev_b32_e32 v115, 4, v149
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v146, v146, v147, v142
	v_perm_b32 v142, v169, v168, v143
	v_perm_b32 v143, v165, v164, v143
	v_and_or_b32 v114, v114, v115, v0
	v_perm_b32 v0, v171, v170, v1
	v_perm_b32 v1, v167, v166, v1
	v_and_or_b32 v143, v142, v144, v143
	v_and_or_b32 v1, v0, v149, v1
	v_perm_b32 v142, v143, v146, s38
	v_perm_b32 v143, v143, v146, s39
	v_perm_b32 v0, v1, v114, s38
	v_perm_b32 v1, v1, v114, s39
	v_and_b32_e32 v114, 0x7070707, v145
	v_lshrrev_b32_e32 v115, 4, v145
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[238:239], v[142:143], v[126:129]
	v_and_b32_e32 v115, 0x7070707, v115
	v_perm_b32 v116, v169, v168, v114
	v_lshlrev_b32_e32 v117, 4, v145
	v_mfma_f32_16x16x32_fp8_fp8 v[172:175], v[240:241], v[142:143], v[122:125]
	v_perm_b32 v114, v165, v164, v114
	v_and_or_b32 v114, v116, v117, v114
	v_perm_b32 v116, v169, v168, v115
	v_perm_b32 v115, v165, v164, v115
	v_and_or_b32 v115, v116, v145, v115
	v_perm_b32 v142, v115, v114, s38
	v_perm_b32 v143, v115, v114, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[234:235], v[0:1], v[118:121]
	v_lshlrev_b32_e32 v144, 4, v130
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[236:237], v[0:1], v[150:153]
	v_and_b32_e32 v0, 0x7070707, v134
	v_lshrrev_b32_e32 v1, 4, v134
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[234:235], v[142:143], v[126:129]
	v_mov_b32_e32 v150, v247
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[236:237], v[142:143], v[172:175]
	v_perm_b32 v142, v163, v162, v0
	v_lshlrev_b32_e32 v143, 4, v134
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v142, v142, v143, v0
	v_perm_b32 v0, v163, v162, v1
	v_perm_b32 v1, v161, v160, v1
	v_and_or_b32 v1, v0, v134, v1
	v_perm_b32 v0, v1, v142, s38
	v_perm_b32 v1, v1, v142, s39
	v_and_b32_e32 v134, 0x7070707, v130
	v_lshrrev_b32_e32 v142, 4, v130
	v_and_b32_e32 v142, 0x7070707, v142
	v_perm_b32 v143, v159, v158, v134
	v_perm_b32 v134, v157, v156, v134
	v_and_or_b32 v134, v143, v144, v134
	v_perm_b32 v143, v159, v158, v142
	v_perm_b32 v142, v157, v156, v142
	v_and_or_b32 v130, v143, v130, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[222:223], v[0:1], v[114:117]
	v_perm_b32 v142, v130, v134, s38
	v_perm_b32 v143, v130, v134, s39
	v_lshlrev_b32_e32 v134, 4, v135
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[224:225], v[0:1], v[122:125]
	v_and_b32_e32 v0, 0x7070707, v135
	v_lshrrev_b32_e32 v1, 4, v135
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v130, v163, v162, v0
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v130, v130, v134, v0
	v_perm_b32 v0, v163, v162, v1
	v_perm_b32 v1, v161, v160, v1
	v_and_or_b32 v1, v0, v135, v1
	v_perm_b32 v0, v1, v130, s38
	v_perm_b32 v1, v1, v130, s39
	v_and_b32_e32 v130, 0x7070707, v131
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[222:223], v[142:143], v[118:121]
	v_perm_b32 v135, v159, v158, v130
	v_perm_b32 v130, v157, v156, v130
	v_lshrrev_b32_e32 v134, 4, v131
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[224:225], v[142:143], v[126:129]
	v_lshlrev_b32_e32 v142, 4, v131
	v_and_or_b32 v135, v135, v142, v130
	v_and_b32_e32 v134, 0x7070707, v134
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[194:195], v[0:1], v[114:117]
	v_perm_b32 v130, v159, v158, v134
	v_perm_b32 v134, v157, v156, v134
	v_and_or_b32 v131, v130, v131, v134
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[196:197], v[0:1], v[122:125]
	v_and_b32_e32 v0, 0x7070707, v136
	v_lshrrev_b32_e32 v1, 4, v136
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v122, v163, v162, v0
	v_lshlrev_b32_e32 v123, 4, v136
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v122, v122, v123, v0
	v_perm_b32 v0, v163, v162, v1
	v_perm_b32 v1, v161, v160, v1
	v_and_or_b32 v1, v0, v136, v1
	v_perm_b32 v130, v131, v135, s38
	v_perm_b32 v131, v131, v135, s39
	v_perm_b32 v0, v1, v122, s38
	v_perm_b32 v1, v1, v122, s39
	v_and_b32_e32 v122, 0x7070707, v132
	v_lshrrev_b32_e32 v123, 4, v132
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[194:195], v[130:131], v[118:121]
	v_and_b32_e32 v123, 0x7070707, v123
	v_perm_b32 v124, v159, v158, v122
	v_lshlrev_b32_e32 v125, 4, v132
	v_perm_b32 v122, v157, v156, v122
	v_and_or_b32 v122, v124, v125, v122
	v_perm_b32 v124, v159, v158, v123
	v_perm_b32 v123, v157, v156, v123
	v_and_or_b32 v123, v124, v132, v123
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[196:197], v[130:131], v[126:129]
	v_perm_b32 v130, v123, v122, s38
	v_perm_b32 v131, v123, v122, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[190:191], v[0:1], v[114:117]
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[192:193], v[0:1], v[142:145]
	v_and_b32_e32 v0, 0x7070707, v137
	v_lshrrev_b32_e32 v1, 4, v137
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[190:191], v[130:131], v[118:121]
	s_nop 2
	v_perm_b32 v118, v163, v162, v0
	v_lshlrev_b32_e32 v119, 4, v137
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v0, v118, v119, v0
	v_perm_b32 v118, v163, v162, v1
	v_perm_b32 v1, v161, v160, v1
	v_and_or_b32 v1, v118, v137, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[192:193], v[130:131], v[126:129]
	v_perm_b32 v130, v1, v0, s38
	v_perm_b32 v131, v1, v0, s39
	v_and_b32_e32 v0, 0x7070707, v133
	v_lshrrev_b32_e32 v1, 4, v133
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v118, v159, v158, v0
	v_lshlrev_b32_e32 v119, 4, v133
	v_perm_b32 v0, v157, v156, v0
	v_and_or_b32 v118, v118, v119, v0
	v_perm_b32 v0, v159, v158, v1
	v_perm_b32 v1, v157, v156, v1
	v_and_or_b32 v1, v0, v133, v1
	v_perm_b32 v0, v1, v118, s38
	v_perm_b32 v1, v1, v118, s39
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[138:139], v[130:131], v[114:117]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[138:139], v[0:1], v[122:125]
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[140:141], v[0:1], v[146:149]
	scratch_load_dword v0, off, off offset:128
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v0, s41, v0
	ds_write_b128 v0, v[226:229]
	scratch_load_dword v0, off, off
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[140:141], v[130:131], v[142:145]
	s_waitcnt vmcnt(0)
	v_or_b32_e32 v0, s41, v0
	ds_write_b128 v0, v[230:233] offset:4096
	v_mov_b32_e32 v0, v248
	s_cbranch_scc1 .LBB0_2
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v172, off, off offset:24
	scratch_load_dword v170, off, off offset:148
	scratch_load_dword v171, off, off offset:4
	v_sub_u32_sdwa v0, v212, v248 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v1, 11, v0
	s_mov_b32 s44, 0x8080808
	v_mul_lo_u32 v1, v1, s44
	v_sub_u32_e32 v130, 0x6c686080, v1
	v_and_b32_e32 v130, 0xffffff00, v130
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_lshlrev_b32_e32 v131, 4, v90
	v_cndmask_b32_e64 v144, v130, 0, vcc
	v_cndmask_b32_e64 v145, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v144
	v_and_b32_e32 v146, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v145
	v_and_b32_e32 v147, 0x80808080, v0
	s_mov_b32 s45, 0x5010400
	s_mov_b32 s46, 0x7030602
	v_lshlrev_b32_e32 v132, 4, v94
	v_sub_u32_sdwa v138, v212, v248 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshlrev_b32_e32 v139, 4, v95
	s_ashr_i32 s49, s48, 31
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s6
	s_movk_i32 s47, 0x7fff
	s_and_b32 s25, s23, 0xffff
	s_mov_b32 s26, -1
	s_mov_b32 s24, s22
	s_mov_b32 s27, s3
	s_mov_b32 s28, s14
	s_mov_b32 s31, s3
	s_mov_b32 s40, s18
	s_mov_b32 s43, s3
	s_mov_b32 s39, s3
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	s_waitcnt vmcnt(2)
	v_sub_u32_sdwa v0, v172, v247 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v1, 11, v0
	v_mul_lo_u32 v1, v1, s44
	v_sub_u32_e32 v130, 0x6c686080, v1
	v_and_b32_e32 v130, 0xffffff00, v130
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v1, 0x7c787470, v1
	v_sub_u32_sdwa v154, v172, v247 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cndmask_b32_e64 v150, v130, 0, vcc
	v_cndmask_b32_e64 v151, v1, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v150
	v_and_b32_e32 v152, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v151
	v_and_b32_e32 v153, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v90
	v_lshrrev_b32_e32 v1, 4, v90
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v130, v147, v146, v0
	v_perm_b32 v0, v145, v144, v0
	v_and_or_b32 v0, v130, v131, v0
	v_perm_b32 v130, v147, v146, v1
	v_perm_b32 v1, v145, v144, v1
	v_and_or_b32 v1, v130, v90, v1
	v_perm_b32 v134, v1, v0, s45
	v_perm_b32 v135, v1, v0, s46
	v_lshrrev_b32_e32 v0, 4, v94
	v_and_b32_e32 v130, 0x7070707, v0
	scratch_load_dword v0, off, off offset:52
	v_and_b32_e32 v90, 0x7070707, v94
	v_perm_b32 v131, v153, v152, v90
	v_perm_b32 v90, v151, v150, v90
	v_and_or_b32 v90, v131, v132, v90
	s_waitcnt vmcnt(2)
	v_or_b32_e32 v132, v170, v242
	v_perm_b32 v131, v153, v152, v130
	v_perm_b32 v130, v151, v150, v130
	v_and_or_b32 v94, v131, v94, v130
	v_perm_b32 v136, v94, v90, s45
	v_perm_b32 v137, v94, v90, s46
	v_min_i32_e32 v90, 11, v138
	v_mul_lo_u32 v90, v90, s44
	v_sub_u32_e32 v94, 0x6c686080, v90
	v_cmp_lt_i32_e32 vcc, 11, v138
	v_lshlrev_b32_e32 v138, 4, v96
	ds_read_b64 v[148:149], v132 offset:8192
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[148:149], v[134:135], v[102:105]
	s_waitcnt vmcnt(0)
	ds_read_b64 v[0:1], v0 offset:8192
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[0:1], v[134:135], v[98:101]
	v_and_b32_e32 v134, 0xffffff00, v94
	v_sub_u32_e32 v135, 0x7c787470, v90
	v_and_b32_e32 v90, 0x7070707, v91
	v_lshrrev_b32_e32 v94, 4, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[130:133], v[0:1], v[136:137], v[106:109]
	v_and_b32_e32 v94, 0x7070707, v94
	v_cndmask_b32_e64 v163, v135, 0, vcc
	v_cndmask_b32_e64 v162, v134, 0, vcc
	v_perm_b32 v106, v147, v146, v90
	v_lshlrev_b32_e32 v107, 4, v91
	v_perm_b32 v90, v145, v144, v90
	v_and_or_b32 v106, v106, v107, v90
	v_perm_b32 v90, v147, v146, v94
	v_perm_b32 v94, v145, v144, v94
	v_and_or_b32 v91, v90, v91, v94
	v_perm_b32 v90, v91, v106, s45
	v_perm_b32 v91, v91, v106, s46
	scratch_load_dword v106, off, off offset:48
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[148:149], v[136:137], v[110:113]
	v_and_b32_e32 v94, 0x7070707, v95
	v_lshrrev_b32_e32 v136, 4, v95
	v_and_b32_e32 v136, 0x7070707, v136
	v_perm_b32 v137, v153, v152, v94
	v_perm_b32 v94, v151, v150, v94
	v_and_or_b32 v137, v137, v139, v94
	v_perm_b32 v94, v153, v152, v136
	v_perm_b32 v136, v151, v150, v136
	v_and_or_b32 v95, v94, v95, v136
	v_perm_b32 v94, v95, v137, s45
	v_perm_b32 v95, v95, v137, s46
	v_add_u32_e32 v134, 0x7f7f7f00, v162
	v_and_b32_e32 v164, 0x80808000, v134
	v_cmp_lt_i32_e32 vcc, 11, v154
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v142, v201, v106
	ds_read2st64_b64 v[106:109], v142 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[106:107], v[90:91], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[108:109], v[90:91], v[102:105]
	v_add_u32_e32 v90, 0x7f7f7f78, v163
	v_and_b32_e32 v165, 0x80808080, v90
	v_and_b32_e32 v90, 0x7070707, v92
	v_lshrrev_b32_e32 v91, 4, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[130:133], v[106:107], v[94:95], v[130:133]
	v_and_b32_e32 v91, 0x7070707, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[108:109], v[94:95], v[110:113]
	v_perm_b32 v94, v147, v146, v90
	v_lshlrev_b32_e32 v95, 4, v92
	v_perm_b32 v90, v145, v144, v90
	v_and_or_b32 v94, v94, v95, v90
	v_perm_b32 v90, v147, v146, v91
	v_perm_b32 v91, v145, v144, v91
	v_and_or_b32 v91, v90, v92, v91
	v_perm_b32 v90, v91, v94, s45
	v_perm_b32 v91, v91, v94, s46
	scratch_load_dword v94, off, off offset:44
	v_and_b32_e32 v92, 0x7070707, v96
	v_perm_b32 v95, v153, v152, v92
	v_perm_b32 v92, v151, v150, v92
	v_and_or_b32 v92, v95, v138, v92
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v143, v201, v94
	ds_read2st64_b64 v[110:113], v143 offset0:16 offset1:24
	v_lshrrev_b32_e32 v94, 4, v96
	v_and_b32_e32 v94, 0x7070707, v94
	v_perm_b32 v95, v153, v152, v94
	v_perm_b32 v94, v151, v150, v94
	v_and_or_b32 v95, v95, v96, v94
	v_perm_b32 v94, v95, v92, s45
	v_perm_b32 v95, v95, v92, s46
	v_min_i32_e32 v92, 11, v154
	v_mul_lo_u32 v92, v92, s44
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[110:111], v[90:91], v[98:101]
	v_sub_u32_e32 v156, 0x7c787470, v92
	v_cndmask_b32_e64 v167, v156, 0, vcc
	v_lshlrev_b32_e32 v154, 4, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[112:113], v[90:91], v[102:105]
	v_sub_u32_e32 v90, 0x6c686080, v92
	v_and_b32_e32 v155, 0xffffff00, v90
	v_and_b32_e32 v90, 0x7070707, v93
	v_lshrrev_b32_e32 v91, 4, v93
	v_mfma_f32_16x16x32_fp8_fp8 v[138:141], v[110:111], v[94:95], v[130:133]
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v147, v146, v90
	v_perm_b32 v90, v145, v144, v90
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[112:113], v[94:95], v[134:137]
	v_lshlrev_b32_e32 v94, 4, v93
	v_and_or_b32 v90, v92, v94, v90
	v_perm_b32 v92, v147, v146, v91
	v_perm_b32 v91, v145, v144, v91
	v_and_or_b32 v91, v92, v93, v91
	v_perm_b32 v146, v91, v90, s45
	v_perm_b32 v147, v91, v90, s46
	scratch_load_dword v91, off, off offset:40
	v_and_b32_e32 v90, 0x7070707, v97
	v_perm_b32 v92, v153, v152, v90
	v_lshlrev_b32_e32 v93, 4, v97
	v_perm_b32 v90, v151, v150, v90
	v_and_or_b32 v94, v92, v93, v90
	v_cndmask_b32_e64 v166, v155, 0, vcc
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v144, v201, v91
	ds_read2st64_b64 v[130:133], v144 offset0:16 offset1:24
	v_lshrrev_b32_e32 v91, 4, v97
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v95, v153, v152, v91
	v_perm_b32 v96, v151, v150, v91
	v_and_or_b32 v95, v95, v97, v96
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[130:131], v[146:147], v[98:101]
	v_perm_b32 v150, v95, v94, s45
	v_perm_b32 v151, v95, v94, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[132:133], v[146:147], v[102:105]
	v_lshlrev_b32_e32 v146, 4, v70
	v_lshrrev_b32_e32 v147, 4, v71
	v_and_b32_e32 v147, 0x7070707, v147
	v_add_u32_e32 v102, 0x7f7f7f78, v167
	v_and_b32_e32 v169, 0x80808080, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[132:133], v[150:151], v[134:137]
	s_nop 2
	v_and_b32_e32 v134, 0x7070707, v66
	v_lshrrev_b32_e32 v135, 4, v66
	v_and_b32_e32 v135, 0x7070707, v135
	v_perm_b32 v136, v165, v164, v134
	v_lshlrev_b32_e32 v137, 4, v66
	v_perm_b32 v134, v163, v162, v134
	v_and_or_b32 v134, v136, v137, v134
	v_perm_b32 v136, v165, v164, v135
	v_perm_b32 v135, v163, v162, v135
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[130:131], v[150:151], v[138:141]
	v_and_or_b32 v66, v136, v66, v135
	v_lshlrev_b32_e32 v151, 4, v71
	s_nop 0
	v_add_u32_e32 v138, 0x7f7f7f00, v166
	v_and_b32_e32 v168, 0x80808000, v138
	v_perm_b32 v138, v66, v134, s45
	v_perm_b32 v139, v66, v134, s46
	scratch_load_dword v134, off, off offset:36
	v_and_b32_e32 v66, 0x7070707, v70
	v_lshrrev_b32_e32 v140, 4, v70
	v_and_b32_e32 v140, 0x7070707, v140
	v_perm_b32 v141, v169, v168, v66
	v_perm_b32 v66, v167, v166, v66
	v_and_or_b32 v66, v141, v146, v66
	v_perm_b32 v141, v169, v168, v140
	v_perm_b32 v140, v167, v166, v140
	v_and_or_b32 v70, v141, v70, v140
	v_perm_b32 v140, v70, v66, s45
	v_perm_b32 v141, v70, v66, s46
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshrrev_b32_e32 v70, 4, v67
	v_and_b32_e32 v70, 0x7070707, v70
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v145, v201, v134
	ds_read2st64_b64 v[134:137], v145 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[134:135], v[138:139], v[90:93]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[136:137], v[138:139], v[98:101]
	v_perm_b32 v138, v165, v164, v66
	v_lshlrev_b32_e32 v139, 4, v67
	v_perm_b32 v66, v163, v162, v66
	v_and_or_b32 v138, v138, v139, v66
	v_perm_b32 v66, v165, v164, v70
	v_perm_b32 v70, v163, v162, v70
	v_and_or_b32 v67, v66, v67, v70
	v_perm_b32 v66, v67, v138, s45
	v_perm_b32 v67, v67, v138, s46
	scratch_load_dword v138, off, off offset:32
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[134:135], v[140:141], v[94:97]
	v_and_b32_e32 v70, 0x7070707, v71
	v_perm_b32 v150, v169, v168, v70
	v_perm_b32 v70, v167, v166, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[136:137], v[140:141], v[102:105]
	v_and_or_b32 v150, v150, v151, v70
	v_perm_b32 v70, v169, v168, v147
	v_perm_b32 v147, v167, v166, v147
	v_and_or_b32 v71, v70, v71, v147
	v_perm_b32 v70, v71, v150, s45
	v_perm_b32 v71, v71, v150, s46
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v146, v201, v138
	ds_read2st64_b64 v[138:141], v146 offset0:16 offset1:24
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[138:139], v[66:67], v[90:93]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[140:141], v[66:67], v[98:101]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[138:139], v[70:71], v[94:97]
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[140:141], v[70:71], v[102:105]
	v_perm_b32 v70, v165, v164, v66
	v_lshlrev_b32_e32 v71, 4, v68
	v_perm_b32 v66, v163, v162, v66
	v_and_or_b32 v70, v70, v71, v66
	v_perm_b32 v66, v165, v164, v67
	v_perm_b32 v67, v163, v162, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v70, s45
	v_perm_b32 v67, v67, v70, s46
	scratch_load_dword v70, off, off offset:28
	v_and_b32_e32 v68, 0x7070707, v72
	v_perm_b32 v71, v169, v168, v68
	v_perm_b32 v68, v167, v166, v68
	v_and_or_b32 v68, v71, v154, v68
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v147, v201, v70
	ds_read2st64_b64 v[102:105], v147 offset0:16 offset1:24
	v_lshrrev_b32_e32 v70, 4, v72
	v_and_b32_e32 v70, 0x7070707, v70
	v_perm_b32 v71, v169, v168, v70
	v_perm_b32 v70, v167, v166, v70
	v_and_or_b32 v71, v71, v72, v70
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[102:103], v[66:67], v[90:93]
	v_perm_b32 v70, v71, v68, s45
	v_perm_b32 v71, v71, v68, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[158:161], v[104:105], v[66:67], v[98:101]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	ds_read2st64_b64 v[98:101], v171 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[154:157], v[102:103], v[70:71], v[94:97]
	v_perm_b32 v68, v165, v164, v66
	v_perm_b32 v66, v163, v162, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[104:105], v[70:71], v[150:153]
	v_lshlrev_b32_e32 v70, 4, v69
	v_and_or_b32 v68, v68, v70, v66
	v_perm_b32 v66, v165, v164, v67
	v_perm_b32 v67, v163, v162, v67
	v_and_or_b32 v67, v66, v69, v67
	v_perm_b32 v66, v67, v68, s45
	v_perm_b32 v67, v67, v68, s46
	v_and_b32_e32 v68, 0x7070707, v73
	v_lshrrev_b32_e32 v69, 4, v73
	v_and_b32_e32 v69, 0x7070707, v69
	v_perm_b32 v70, v169, v168, v68
	v_lshlrev_b32_e32 v71, 4, v73
	v_perm_b32 v68, v167, v166, v68
	v_and_or_b32 v70, v70, v71, v68
	v_perm_b32 v68, v169, v168, v69
	v_perm_b32 v69, v167, v166, v69
	v_and_or_b32 v69, v68, v73, v69
	v_perm_b32 v68, v69, v70, s45
	v_perm_b32 v69, v69, v70, s46
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[98:99], v[66:67], v[90:93]
	v_lshlrev_b32_e32 v164, 4, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[98:99], v[68:69], v[154:157]
	s_nop 2
	v_bfe_u32 v154, v218, s12, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[100:101], v[66:67], v[158:161]
	v_bfe_u32 v156, v219, s13, 8
	v_bfe_u32 v155, v218, s11, 8
	v_sub_u32_e32 v155, v213, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[100:101], v[68:69], v[150:153]
	v_bfe_u32 v157, v219, s36, 8
	v_sub_u32_e32 v157, v211, v157
	s_lshr_b32 s12, s52, 6
	v_sub_u32_e32 v150, v213, v154
	v_min_i32_e32 v151, 11, v150
	v_mul_lo_u32 v151, v151, s44
	v_sub_u32_e32 v152, 0x6c686080, v151
	v_and_b32_e32 v152, 0xffffff00, v152
	v_cmp_lt_i32_e32 vcc, 11, v150
	v_sub_u32_e32 v151, 0x7c787470, v151
	v_lshlrev_b32_e32 v153, 4, v58
	v_cndmask_b32_e64 v154, v152, 0, vcc
	v_cndmask_b32_e64 v158, v151, 0, vcc
	v_add_u32_e32 v150, 0x7f7f7f00, v154
	v_and_b32_e32 v159, 0x80808000, v150
	v_add_u32_e32 v150, 0x7f7f7f78, v158
	v_and_b32_e32 v160, 0x80808080, v150
	v_sub_u32_e32 v150, v211, v156
	v_min_i32_e32 v151, 11, v150
	v_mul_lo_u32 v151, v151, s44
	v_sub_u32_e32 v152, 0x6c686080, v151
	v_and_b32_e32 v152, 0xffffff00, v152
	v_cmp_lt_i32_e32 vcc, 11, v150
	v_sub_u32_e32 v151, 0x7c787470, v151
	s_lshl_b32 s13, s12, 8
	v_cndmask_b32_e64 v156, v152, 0, vcc
	v_cndmask_b32_e64 v161, v151, 0, vcc
	v_add_u32_e32 v150, 0x7f7f7f00, v156
	v_and_b32_e32 v162, 0x80808000, v150
	v_add_u32_e32 v150, 0x7f7f7f78, v161
	v_and_b32_e32 v163, 0x80808080, v150
	v_and_b32_e32 v150, 0x7070707, v58
	v_lshrrev_b32_e32 v151, 4, v58
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v160, v159, v150
	v_perm_b32 v150, v158, v154, v150
	v_and_or_b32 v152, v152, v153, v150
	v_perm_b32 v150, v160, v159, v151
	v_perm_b32 v151, v158, v154, v151
	v_and_or_b32 v58, v150, v58, v151
	v_perm_b32 v150, v58, v152, s45
	v_perm_b32 v151, v58, v152, s46
	v_and_b32_e32 v58, 0x7070707, v62
	v_lshrrev_b32_e32 v152, 4, v62
	v_and_b32_e32 v152, 0x7070707, v152
	v_perm_b32 v153, v163, v162, v58
	v_perm_b32 v58, v161, v156, v58
	v_and_or_b32 v58, v153, v164, v58
	v_perm_b32 v153, v163, v162, v152
	v_perm_b32 v152, v161, v156, v152
	v_and_or_b32 v62, v153, v62, v152
	v_perm_b32 v152, v62, v58, s45
	v_perm_b32 v153, v62, v58, s46
	v_min_i32_e32 v58, 11, v155
	v_mul_lo_u32 v58, v58, s44
	v_sub_u32_e32 v62, 0x6c686080, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[0:1], v[150:151], v[74:77]
	v_lshlrev_b32_e32 v164, 4, v63
	v_cmp_lt_i32_e32 vcc, 11, v155
	s_mov_b32 s36, s16
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[148:149], v[150:151], v[78:81]
	v_and_b32_e32 v150, 0xffffff00, v62
	v_sub_u32_e32 v151, 0x7c787470, v58
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshrrev_b32_e32 v62, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[0:1], v[152:153], v[82:85]
	v_and_b32_e32 v62, 0x7070707, v62
	v_cndmask_b32_e64 v155, v150, 0, vcc
	v_add_u32_e32 v150, 0x7f7f7f00, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[148:149], v[152:153], v[86:89]
	v_perm_b32 v152, v160, v159, v58
	v_lshlrev_b32_e32 v153, 4, v59
	v_perm_b32 v58, v158, v154, v58
	v_and_or_b32 v152, v152, v153, v58
	v_perm_b32 v58, v160, v159, v62
	v_perm_b32 v62, v158, v154, v62
	v_and_or_b32 v59, v58, v59, v62
	v_perm_b32 v58, v59, v152, s45
	v_perm_b32 v59, v59, v152, s46
	v_and_b32_e32 v62, 0x7070707, v63
	v_lshrrev_b32_e32 v152, 4, v63
	v_and_b32_e32 v152, 0x7070707, v152
	v_perm_b32 v153, v163, v162, v62
	v_perm_b32 v62, v161, v156, v62
	v_and_or_b32 v153, v153, v164, v62
	v_perm_b32 v62, v163, v162, v152
	v_perm_b32 v152, v161, v156, v152
	v_cndmask_b32_e64 v164, v151, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[106:107], v[58:59], v[74:77]
	v_and_or_b32 v63, v62, v63, v152
	v_perm_b32 v62, v63, v153, s45
	v_perm_b32 v63, v63, v153, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[108:109], v[58:59], v[78:81]
	v_add_u32_e32 v58, 0x7f7f7f78, v164
	v_and_b32_e32 v166, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[106:107], v[62:63], v[82:85]
	v_and_b32_e32 v59, 0x7070707, v59
	v_and_b32_e32 v165, 0x80808000, v150
	v_lshlrev_b32_e32 v150, 4, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[108:109], v[62:63], v[86:89]
	v_perm_b32 v62, v160, v159, v58
	v_lshlrev_b32_e32 v63, 4, v60
	v_perm_b32 v58, v158, v154, v58
	v_and_or_b32 v62, v62, v63, v58
	v_perm_b32 v58, v160, v159, v59
	v_perm_b32 v59, v158, v154, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v62, s45
	v_perm_b32 v59, v59, v62, s46
	v_and_b32_e32 v60, 0x7070707, v64
	v_lshrrev_b32_e32 v62, 4, v64
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v163, v162, v60
	v_perm_b32 v60, v161, v156, v60
	v_and_or_b32 v60, v63, v150, v60
	v_perm_b32 v63, v163, v162, v62
	v_perm_b32 v62, v161, v156, v62
	v_and_or_b32 v63, v63, v64, v62
	v_perm_b32 v62, v63, v60, s45
	v_perm_b32 v63, v63, v60, s46
	v_min_i32_e32 v60, 11, v157
	v_mul_lo_u32 v60, v60, s44
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[110:111], v[58:59], v[74:77]
	v_sub_u32_e32 v168, 0x7c787470, v60
	v_cmp_lt_i32_e32 vcc, 11, v157
	s_mov_b32 s11, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[112:113], v[58:59], v[78:81]
	v_sub_u32_e32 v58, 0x6c686080, v60
	v_and_b32_e32 v167, 0xffffff00, v58
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[110:111], v[62:63], v[82:85]
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v160, v159, v58
	v_perm_b32 v58, v158, v154, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[112:113], v[62:63], v[86:89]
	v_lshlrev_b32_e32 v62, 4, v61
	v_and_or_b32 v58, v60, v62, v58
	v_perm_b32 v60, v160, v159, v59
	v_perm_b32 v59, v158, v154, v59
	v_and_or_b32 v59, v60, v61, v59
	v_perm_b32 v150, v59, v58, s45
	v_perm_b32 v151, v59, v58, s46
	v_lshrrev_b32_e32 v59, 4, v65
	v_and_b32_e32 v58, 0x7070707, v65
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v163, v162, v58
	v_lshlrev_b32_e32 v61, 4, v65
	v_perm_b32 v58, v161, v156, v58
	v_perm_b32 v63, v163, v162, v59
	v_perm_b32 v64, v161, v156, v59
	v_and_or_b32 v62, v60, v61, v58
	v_and_or_b32 v63, v63, v65, v64
	v_perm_b32 v152, v63, v62, s45
	v_perm_b32 v153, v63, v62, s46
	v_cndmask_b32_e64 v154, v167, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[130:131], v[150:151], v[74:77]
	v_cndmask_b32_e64 v156, v168, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[130:131], v[152:153], v[82:85]
	s_nop 2
	v_add_u32_e32 v82, 0x7f7f7f00, v154
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[132:133], v[150:151], v[78:81]
	v_and_b32_e32 v150, 0x80808000, v82
	v_and_b32_e32 v82, 0x7070707, v46
	v_lshrrev_b32_e32 v83, 4, v46
	v_and_b32_e32 v83, 0x7070707, v83
	v_perm_b32 v84, v166, v165, v82
	v_lshlrev_b32_e32 v85, 4, v46
	v_perm_b32 v82, v164, v155, v82
	v_and_or_b32 v84, v84, v85, v82
	v_perm_b32 v82, v166, v165, v83
	v_perm_b32 v83, v164, v155, v83
	v_add_u32_e32 v78, 0x7f7f7f78, v156
	v_and_or_b32 v46, v82, v46, v83
	v_and_b32_e32 v151, 0x80808080, v78
	v_perm_b32 v82, v46, v84, s45
	v_perm_b32 v83, v46, v84, s46
	v_and_b32_e32 v46, 0x7070707, v54
	v_lshrrev_b32_e32 v84, 4, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[132:133], v[152:153], v[86:89]
	v_and_b32_e32 v84, 0x7070707, v84
	v_perm_b32 v85, v151, v150, v46
	v_perm_b32 v46, v156, v154, v46
	v_lshlrev_b32_e32 v86, 4, v54
	v_and_or_b32 v46, v85, v86, v46
	v_perm_b32 v85, v151, v150, v84
	v_perm_b32 v84, v156, v154, v84
	v_and_or_b32 v54, v85, v54, v84
	v_perm_b32 v84, v54, v46, s45
	v_perm_b32 v85, v54, v46, s46
	v_and_b32_e32 v46, 0x7070707, v47
	v_lshrrev_b32_e32 v54, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[134:135], v[82:83], v[58:61]
	v_and_b32_e32 v54, 0x7070707, v54
	scratch_load_dword v153, off, off offset:8
	v_lshlrev_b32_e32 v86, 4, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[136:137], v[82:83], v[74:77]
	v_perm_b32 v82, v166, v165, v46
	v_lshlrev_b32_e32 v83, 4, v47
	v_perm_b32 v46, v164, v155, v46
	v_and_or_b32 v82, v82, v83, v46
	v_perm_b32 v46, v166, v165, v54
	v_perm_b32 v54, v164, v155, v54
	v_and_or_b32 v47, v46, v47, v54
	v_perm_b32 v46, v47, v82, s45
	v_perm_b32 v47, v47, v82, s46
	v_and_b32_e32 v54, 0x7070707, v55
	v_lshrrev_b32_e32 v82, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[134:135], v[84:85], v[62:65]
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v83, v151, v150, v54
	v_perm_b32 v54, v156, v154, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[136:137], v[84:85], v[78:81]
	v_lshlrev_b32_e32 v84, 4, v55
	v_and_or_b32 v83, v83, v84, v54
	v_perm_b32 v54, v151, v150, v82
	v_perm_b32 v82, v156, v154, v82
	v_and_or_b32 v55, v54, v55, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[138:139], v[46:47], v[58:61]
	v_perm_b32 v54, v55, v83, s45
	v_perm_b32 v55, v55, v83, s46
	v_lshlrev_b32_e32 v82, 4, v56
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[140:141], v[46:47], v[74:77]
	v_and_b32_e32 v46, 0x7070707, v48
	v_lshrrev_b32_e32 v47, 4, v48
	v_and_b32_e32 v47, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[138:139], v[54:55], v[62:65]
	v_lshlrev_b32_e32 v87, 4, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[140:141], v[54:55], v[78:81]
	v_perm_b32 v54, v166, v165, v46
	v_lshlrev_b32_e32 v55, 4, v48
	v_perm_b32 v46, v164, v155, v46
	v_and_or_b32 v54, v54, v55, v46
	v_perm_b32 v46, v166, v165, v47
	v_perm_b32 v47, v164, v155, v47
	v_and_or_b32 v47, v46, v48, v47
	v_perm_b32 v46, v47, v54, s45
	v_perm_b32 v47, v47, v54, s46
	v_and_b32_e32 v48, 0x7070707, v56
	v_lshrrev_b32_e32 v54, 4, v56
	v_and_b32_e32 v54, 0x7070707, v54
	v_perm_b32 v55, v151, v150, v48
	v_perm_b32 v48, v156, v154, v48
	v_and_or_b32 v48, v55, v82, v48
	v_perm_b32 v55, v151, v150, v54
	v_perm_b32 v54, v156, v154, v54
	v_and_or_b32 v55, v55, v56, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[102:103], v[46:47], v[58:61]
	v_perm_b32 v54, v55, v48, s45
	v_perm_b32 v55, v55, v48, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[104:105], v[46:47], v[74:77]
	v_and_b32_e32 v46, 0x7070707, v49
	v_lshrrev_b32_e32 v47, 4, v49
	v_and_b32_e32 v47, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[102:103], v[54:55], v[62:65]
	v_perm_b32 v48, v166, v165, v46
	v_perm_b32 v46, v164, v155, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[104:105], v[54:55], v[78:81]
	v_lshlrev_b32_e32 v54, 4, v49
	v_and_or_b32 v48, v48, v54, v46
	v_perm_b32 v46, v166, v165, v47
	v_perm_b32 v47, v164, v155, v47
	v_and_or_b32 v47, v46, v49, v47
	v_perm_b32 v46, v47, v48, s45
	v_perm_b32 v47, v47, v48, s46
	v_and_b32_e32 v48, 0x7070707, v57
	v_lshrrev_b32_e32 v49, 4, v57
	v_and_b32_e32 v49, 0x7070707, v49
	v_perm_b32 v54, v151, v150, v48
	v_lshlrev_b32_e32 v55, 4, v57
	v_perm_b32 v48, v156, v154, v48
	v_and_or_b32 v54, v54, v55, v48
	v_perm_b32 v48, v151, v150, v49
	v_perm_b32 v49, v156, v154, v49
	scratch_load_dword v154, off, off offset:16
	v_and_or_b32 v49, v48, v57, v49
	v_perm_b32 v48, v49, v54, s45
	v_perm_b32 v49, v49, v54, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[100:101], v[46:47], v[74:77]
	s_waitcnt vmcnt(1)
	v_sub_u32_sdwa v150, v153, v216 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[98:99], v[46:47], v[58:61]
	v_lshlrev_b32_e32 v77, 4, v26
	s_waitcnt vmcnt(0)
	v_sub_u32_sdwa v74, v154, v217 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s44
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[98:99], v[48:49], v[82:85]
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[100:101], v[48:49], v[78:81]
	s_nop 2
	v_cndmask_b32_e64 v78, v76, 0, vcc
	v_cndmask_b32_e64 v79, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v78
	v_and_b32_e32 v80, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v79
	v_and_b32_e32 v81, 0x80808080, v74
	v_sub_u32_sdwa v74, v153, v216 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s44
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	s_nop 0
	v_cndmask_b32_e64 v82, v76, 0, vcc
	v_cndmask_b32_e64 v83, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v82
	v_and_b32_e32 v84, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v83
	v_and_b32_e32 v85, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v26
	v_lshrrev_b32_e32 v75, 4, v26
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v81, v80, v74
	v_perm_b32 v74, v79, v78, v74
	v_and_or_b32 v76, v76, v77, v74
	v_perm_b32 v74, v81, v80, v75
	v_perm_b32 v75, v79, v78, v75
	v_and_or_b32 v26, v74, v26, v75
	v_perm_b32 v74, v26, v76, s45
	v_perm_b32 v75, v26, v76, s46
	v_and_b32_e32 v26, 0x7070707, v30
	v_lshrrev_b32_e32 v76, 4, v30
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v77, v85, v84, v26
	v_perm_b32 v26, v83, v82, v26
	v_and_or_b32 v26, v77, v86, v26
	v_perm_b32 v77, v85, v84, v76
	v_perm_b32 v76, v83, v82, v76
	v_and_or_b32 v30, v77, v30, v76
	v_sub_u32_sdwa v86, v154, v217 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v76, v30, v26, s45
	v_perm_b32 v77, v30, v26, s46
	v_min_i32_e32 v26, 11, v86
	v_mul_lo_u32 v26, v26, s44
	v_sub_u32_e32 v30, 0x6c686080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[0:1], v[74:75], v[34:37]
	v_cmp_lt_i32_e32 vcc, 11, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[148:149], v[74:75], v[38:41]
	v_and_b32_e32 v74, 0xffffff00, v30
	v_sub_u32_e32 v75, 0x7c787470, v26
	v_and_b32_e32 v26, 0x7070707, v27
	v_lshrrev_b32_e32 v30, 4, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[0:1], v[76:77], v[42:45]
	v_and_b32_e32 v30, 0x7070707, v30
	v_cndmask_b32_e64 v86, v74, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[148:149], v[76:77], v[50:53]
	v_perm_b32 v76, v81, v80, v26
	v_lshlrev_b32_e32 v77, 4, v27
	v_perm_b32 v26, v79, v78, v26
	v_and_or_b32 v76, v76, v77, v26
	v_perm_b32 v26, v81, v80, v30
	v_perm_b32 v30, v79, v78, v30
	v_and_or_b32 v27, v26, v27, v30
	v_perm_b32 v26, v27, v76, s45
	v_perm_b32 v27, v27, v76, s46
	v_and_b32_e32 v30, 0x7070707, v31
	v_lshrrev_b32_e32 v76, 4, v31
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v77, v85, v84, v30
	v_perm_b32 v30, v83, v82, v30
	v_and_or_b32 v77, v77, v87, v30
	v_perm_b32 v30, v85, v84, v76
	v_perm_b32 v76, v83, v82, v76
	v_cndmask_b32_e64 v87, v75, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[106:107], v[26:27], v[34:37]
	v_and_or_b32 v31, v30, v31, v76
	v_perm_b32 v30, v31, v77, s45
	v_perm_b32 v31, v31, v77, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[108:109], v[26:27], v[38:41]
	v_add_u32_e32 v26, 0x7f7f7f78, v87
	v_and_b32_e32 v89, 0x80808080, v26
	v_and_b32_e32 v26, 0x7070707, v28
	v_lshrrev_b32_e32 v27, 4, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[106:107], v[30:31], v[42:45]
	v_and_b32_e32 v27, 0x7070707, v27
	v_and_b32_e32 v88, 0x80808000, v74
	v_lshlrev_b32_e32 v74, 4, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[108:109], v[30:31], v[50:53]
	v_perm_b32 v30, v81, v80, v26
	v_lshlrev_b32_e32 v31, 4, v28
	v_perm_b32 v26, v79, v78, v26
	v_and_or_b32 v30, v30, v31, v26
	v_perm_b32 v26, v81, v80, v27
	v_perm_b32 v27, v79, v78, v27
	v_and_or_b32 v27, v26, v28, v27
	v_perm_b32 v26, v27, v30, s45
	v_perm_b32 v27, v27, v30, s46
	v_and_b32_e32 v28, 0x7070707, v32
	v_lshrrev_b32_e32 v30, 4, v32
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v85, v84, v28
	v_perm_b32 v28, v83, v82, v28
	v_and_or_b32 v28, v31, v74, v28
	v_perm_b32 v31, v85, v84, v30
	v_perm_b32 v30, v83, v82, v30
	v_and_or_b32 v31, v31, v32, v30
	v_perm_b32 v30, v31, v28, s45
	v_perm_b32 v31, v31, v28, s46
	v_min_i32_e32 v28, 11, v150
	v_mul_lo_u32 v28, v28, s44
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[110:111], v[26:27], v[34:37]
	v_sub_u32_e32 v152, 0x7c787470, v28
	v_cmp_lt_i32_e32 vcc, 11, v150
	scratch_load_dword v150, off, off offset:12
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[112:113], v[26:27], v[38:41]
	v_sub_u32_e32 v26, 0x6c686080, v28
	v_and_b32_e32 v151, 0xffffff00, v26
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[110:111], v[30:31], v[42:45]
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v81, v80, v26
	v_perm_b32 v26, v79, v78, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[112:113], v[30:31], v[50:53]
	v_lshlrev_b32_e32 v30, 4, v29
	v_and_or_b32 v26, v28, v30, v26
	v_perm_b32 v28, v81, v80, v27
	v_perm_b32 v27, v79, v78, v27
	v_cndmask_b32_e64 v78, v151, 0, vcc
	scratch_load_dword v151, off, off offset:20
	v_and_or_b32 v27, v28, v29, v27
	v_perm_b32 v74, v27, v26, s45
	v_perm_b32 v75, v27, v26, s46
	v_lshrrev_b32_e32 v27, 4, v33
	v_and_b32_e32 v26, 0x7070707, v33
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v85, v84, v26
	v_lshlrev_b32_e32 v29, 4, v33
	v_perm_b32 v26, v83, v82, v26
	v_perm_b32 v31, v85, v84, v27
	v_perm_b32 v32, v83, v82, v27
	v_and_or_b32 v30, v28, v29, v26
	v_and_or_b32 v31, v31, v33, v32
	v_perm_b32 v76, v31, v30, s45
	v_perm_b32 v77, v31, v30, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[130:131], v[74:75], v[34:37]
	v_cndmask_b32_e64 v79, v152, 0, vcc
	v_lshlrev_b32_e32 v85, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[130:131], v[76:77], v[42:45]
	s_nop 2
	v_add_u32_e32 v42, 0x7f7f7f00, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[132:133], v[74:75], v[38:41]
	v_and_b32_e32 v74, 0x80808000, v42
	v_and_b32_e32 v42, 0x7070707, v18
	v_lshrrev_b32_e32 v43, 4, v18
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v89, v88, v42
	v_lshlrev_b32_e32 v45, 4, v18
	v_perm_b32 v42, v87, v86, v42
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v89, v88, v43
	v_perm_b32 v43, v87, v86, v43
	v_add_u32_e32 v38, 0x7f7f7f78, v79
	v_and_or_b32 v18, v42, v18, v43
	v_and_b32_e32 v75, 0x80808080, v38
	v_perm_b32 v42, v18, v44, s45
	v_perm_b32 v43, v18, v44, s46
	v_and_b32_e32 v18, 0x7070707, v22
	v_lshrrev_b32_e32 v44, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[132:133], v[76:77], v[50:53]
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v75, v74, v18
	v_perm_b32 v18, v79, v78, v18
	v_lshlrev_b32_e32 v50, 4, v22
	v_and_or_b32 v18, v45, v50, v18
	v_perm_b32 v45, v75, v74, v44
	v_perm_b32 v44, v79, v78, v44
	v_and_or_b32 v22, v45, v22, v44
	v_perm_b32 v44, v22, v18, s45
	v_perm_b32 v45, v22, v18, s46
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v22, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[134:135], v[42:43], v[26:29]
	v_and_b32_e32 v22, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[136:137], v[42:43], v[34:37]
	v_perm_b32 v42, v89, v88, v18
	v_lshlrev_b32_e32 v43, 4, v19
	v_perm_b32 v18, v87, v86, v18
	v_and_or_b32 v42, v42, v43, v18
	v_perm_b32 v18, v89, v88, v22
	v_perm_b32 v22, v87, v86, v22
	v_and_or_b32 v19, v18, v19, v22
	v_perm_b32 v18, v19, v42, s45
	v_perm_b32 v19, v19, v42, s46
	v_and_b32_e32 v22, 0x7070707, v23
	v_lshrrev_b32_e32 v42, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[134:135], v[44:45], v[30:33]
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v75, v74, v22
	v_perm_b32 v22, v79, v78, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[136:137], v[44:45], v[38:41]
	v_lshlrev_b32_e32 v44, 4, v23
	v_and_or_b32 v43, v43, v44, v22
	v_perm_b32 v22, v75, v74, v42
	v_perm_b32 v42, v79, v78, v42
	v_and_or_b32 v23, v22, v23, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[138:139], v[18:19], v[26:29]
	v_perm_b32 v22, v23, v43, s45
	v_perm_b32 v23, v23, v43, s46
	v_lshlrev_b32_e32 v42, 4, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[140:141], v[18:19], v[34:37]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[138:139], v[22:23], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[140:141], v[22:23], v[38:41]
	v_perm_b32 v22, v89, v88, v18
	v_lshlrev_b32_e32 v23, 4, v20
	v_perm_b32 v18, v87, v86, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v89, v88, v19
	v_perm_b32 v19, v87, v86, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v22, s45
	v_perm_b32 v19, v19, v22, s46
	v_and_b32_e32 v20, 0x7070707, v24
	v_lshrrev_b32_e32 v22, 4, v24
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v75, v74, v20
	v_perm_b32 v20, v79, v78, v20
	v_and_or_b32 v20, v23, v42, v20
	v_perm_b32 v23, v75, v74, v22
	v_perm_b32 v22, v79, v78, v22
	v_and_or_b32 v23, v23, v24, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[102:103], v[18:19], v[26:29]
	v_perm_b32 v22, v23, v20, s45
	v_perm_b32 v23, v23, v20, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[104:105], v[18:19], v[34:37]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[102:103], v[22:23], v[30:33]
	v_perm_b32 v20, v89, v88, v18
	v_perm_b32 v18, v87, v86, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[104:105], v[22:23], v[38:41]
	v_lshlrev_b32_e32 v22, 4, v21
	v_and_or_b32 v20, v20, v22, v18
	v_perm_b32 v18, v89, v88, v19
	v_perm_b32 v19, v87, v86, v19
	v_and_or_b32 v19, v18, v21, v19
	v_perm_b32 v18, v19, v20, s45
	v_perm_b32 v19, v19, v20, s46
	v_and_b32_e32 v20, 0x7070707, v25
	v_lshrrev_b32_e32 v21, 4, v25
	v_and_b32_e32 v21, 0x7070707, v21
	v_perm_b32 v22, v75, v74, v20
	v_lshlrev_b32_e32 v23, 4, v25
	v_perm_b32 v20, v79, v78, v20
	v_and_or_b32 v22, v22, v23, v20
	v_perm_b32 v20, v75, v74, v21
	v_perm_b32 v21, v79, v78, v21
	v_and_or_b32 v21, v20, v25, v21
	v_perm_b32 v20, v21, v22, s45
	v_perm_b32 v21, v21, v22, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[98:99], v[18:19], v[26:29]
	v_lshlrev_b32_e32 v86, 4, v15
	v_bfe_u32 v74, v215, s10, 8
	s_waitcnt vmcnt(1)
	v_sub_u32_e32 v87, v150, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[20:21], v[42:45]
	s_mov_b32 s10, 0x800000
	s_mov_b32 s38, s10
	s_nop 0
	v_bfe_u32 v42, v214, s8, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[100:101], v[18:19], v[34:37]
	v_bfe_u32 v44, v214, s5, 8
	s_and_b32 s5, s19, 0xffff
	s_mov_b32 s41, s5
	s_waitcnt vmcnt(0)
	v_sub_u32_e32 v35, v151, v42
	v_min_i32_e32 v36, 11, v35
	v_mul_lo_u32 v36, v36, s44
	v_sub_u32_e32 v37, 0x6c686080, v36
	v_and_b32_e32 v37, 0xffffff00, v37
	v_cmp_lt_i32_e32 vcc, 11, v35
	v_sub_u32_e32 v36, 0x7c787470, v36
	v_bfe_u32 v34, v215, s9, 8
	v_cndmask_b32_e64 v75, v37, 0, vcc
	v_cndmask_b32_e64 v76, v36, 0, vcc
	v_add_u32_e32 v35, 0x7f7f7f00, v75
	v_and_b32_e32 v77, 0x80808000, v35
	v_add_u32_e32 v35, 0x7f7f7f78, v76
	v_sub_u32_e32 v34, v150, v34
	v_and_b32_e32 v78, 0x80808080, v35
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s44
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_lshlrev_b32_e32 v37, 4, v10
	v_cndmask_b32_e64 v79, v36, 0, vcc
	v_cndmask_b32_e64 v80, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v79
	v_and_b32_e32 v81, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v80
	v_and_b32_e32 v82, 0x80808080, v34
	v_and_b32_e32 v34, 0x7070707, v10
	v_lshrrev_b32_e32 v35, 4, v10
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v78, v77, v34
	v_perm_b32 v34, v76, v75, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v78, v77, v35
	v_perm_b32 v35, v76, v75, v35
	v_and_or_b32 v10, v36, v10, v35
	v_perm_b32 v42, v10, v34, s45
	v_perm_b32 v43, v10, v34, s46
	v_lshrrev_b32_e32 v34, 4, v14
	v_and_b32_e32 v10, 0x7070707, v14
	v_and_b32_e32 v34, 0x7070707, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[100:101], v[20:21], v[38:41]
	v_perm_b32 v35, v82, v81, v10
	v_lshlrev_b32_e32 v36, 4, v14
	v_perm_b32 v10, v80, v79, v10
	v_perm_b32 v38, v82, v81, v34
	v_perm_b32 v39, v80, v79, v34
	v_and_or_b32 v10, v35, v36, v10
	v_and_or_b32 v14, v38, v14, v39
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[0:1], v[42:43], v[118:121]
	v_perm_b32 v50, v14, v10, s45
	v_perm_b32 v51, v14, v10, s46
	v_sub_u32_e32 v14, v151, v44
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[148:149], v[42:43], v[114:117]
	v_cmp_lt_i32_e32 vcc, 11, v14
	s_and_b32 s9, s17, 0xffff
	s_mov_b32 s37, s9
	scratch_load_dword v117, off, off offset:140
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[0:1], v[50:51], v[126:129]
	v_min_i32_e32 v0, 11, v14
	v_mul_lo_u32 v0, v0, s44
	v_sub_u32_e32 v1, 0x6c686080, v0
	v_and_b32_e32 v83, 0xffffff00, v1
	v_sub_u32_e32 v84, 0x7c787470, v0
	v_and_b32_e32 v0, 0x7070707, v11
	v_lshrrev_b32_e32 v1, 4, v11
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v10, v78, v77, v0
	v_perm_b32 v0, v76, v75, v0
	v_and_or_b32 v10, v10, v85, v0
	v_perm_b32 v0, v78, v77, v1
	v_perm_b32 v1, v76, v75, v1
	v_and_or_b32 v1, v0, v11, v1
	v_perm_b32 v0, v1, v10, s45
	v_perm_b32 v1, v1, v10, s46
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v11, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[148:149], v[50:51], v[122:125]
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v85, v82, v81, v10
	v_perm_b32 v10, v80, v79, v10
	v_and_or_b32 v85, v85, v86, v10
	v_perm_b32 v10, v82, v81, v11
	v_perm_b32 v11, v80, v79, v11
	v_cndmask_b32_e64 v84, v84, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[106:107], v[0:1], v[34:37]
	v_and_or_b32 v11, v10, v15, v11
	v_perm_b32 v10, v11, v85, s45
	v_perm_b32 v11, v11, v85, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[108:109], v[0:1], v[42:45]
	v_add_u32_e32 v0, 0x7f7f7f78, v84
	v_and_b32_e32 v86, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v12
	v_lshrrev_b32_e32 v1, 4, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[106:107], v[10:11], v[38:41]
	v_and_b32_e32 v1, 0x7070707, v1
	v_cndmask_b32_e64 v83, v83, 0, vcc
	v_add_u32_e32 v14, 0x7f7f7f00, v83
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[108:109], v[10:11], v[50:53]
	v_perm_b32 v10, v78, v77, v0
	v_lshlrev_b32_e32 v11, 4, v12
	v_perm_b32 v0, v76, v75, v0
	v_and_or_b32 v10, v10, v11, v0
	v_perm_b32 v0, v78, v77, v1
	v_perm_b32 v1, v76, v75, v1
	v_and_or_b32 v1, v0, v12, v1
	v_perm_b32 v0, v1, v10, s45
	v_perm_b32 v1, v1, v10, s46
	v_and_b32_e32 v10, 0x7070707, v16
	v_lshrrev_b32_e32 v11, 4, v16
	v_and_b32_e32 v85, 0x80808000, v14
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v82, v81, v10
	v_lshlrev_b32_e32 v14, 4, v16
	v_perm_b32 v10, v80, v79, v10
	v_and_or_b32 v12, v12, v14, v10
	v_perm_b32 v10, v82, v81, v11
	v_perm_b32 v11, v80, v79, v11
	v_and_or_b32 v11, v10, v16, v11
	v_perm_b32 v10, v11, v12, s45
	v_perm_b32 v11, v11, v12, s46
	v_min_i32_e32 v12, 11, v87
	v_mul_lo_u32 v12, v12, s44
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[110:111], v[0:1], v[34:37]
	v_sub_u32_e32 v89, 0x7c787470, v12
	v_cmp_lt_i32_e32 vcc, 11, v87
	scratch_load_dword v126, off, off offset:136
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[112:113], v[0:1], v[42:45]
	v_sub_u32_e32 v0, 0x6c686080, v12
	v_and_b32_e32 v88, 0xffffff00, v0
	v_and_b32_e32 v0, 0x7070707, v13
	v_lshrrev_b32_e32 v1, 4, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[110:111], v[10:11], v[38:41]
	v_and_b32_e32 v1, 0x7070707, v1
	v_mov_b32_e32 v115, 0xfd800000
	s_mov_b32 s17, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[112:113], v[10:11], v[50:53]
	v_perm_b32 v10, v78, v77, v0
	v_lshlrev_b32_e32 v11, 4, v13
	v_perm_b32 v0, v76, v75, v0
	v_and_or_b32 v10, v10, v11, v0
	v_perm_b32 v0, v78, v77, v1
	v_perm_b32 v1, v76, v75, v1
	v_and_or_b32 v1, v0, v13, v1
	v_perm_b32 v0, v1, v10, s45
	v_perm_b32 v1, v1, v10, s46
	v_and_b32_e32 v10, 0x7070707, v17
	v_lshrrev_b32_e32 v11, 4, v17
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v82, v81, v10
	v_lshlrev_b32_e32 v13, 4, v17
	v_perm_b32 v10, v80, v79, v10
	v_cndmask_b32_e64 v77, v89, 0, vcc
	v_and_or_b32 v14, v12, v13, v10
	v_perm_b32 v15, v82, v81, v11
	v_perm_b32 v16, v80, v79, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[130:131], v[0:1], v[34:37]
	v_and_or_b32 v15, v15, v17, v16
	v_perm_b32 v74, v15, v14, s45
	v_perm_b32 v75, v15, v14, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[132:133], v[0:1], v[42:45]
	v_add_u32_e32 v0, 0x7f7f7f78, v77
	v_and_b32_e32 v79, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v6
	v_lshrrev_b32_e32 v1, 4, v6
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v42, v86, v85, v0
	v_lshlrev_b32_e32 v43, 4, v6
	v_perm_b32 v0, v84, v83, v0
	v_cndmask_b32_e64 v76, v88, 0, vcc
	v_and_or_b32 v42, v42, v43, v0
	v_perm_b32 v0, v86, v85, v1
	v_perm_b32 v1, v84, v83, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[130:131], v[74:75], v[38:41]
	v_and_or_b32 v1, v0, v6, v1
	v_perm_b32 v0, v1, v42, s45
	v_perm_b32 v1, v1, v42, s46
	v_add_u32_e32 v38, 0x7f7f7f00, v76
	v_and_b32_e32 v78, 0x80808000, v38
	v_and_b32_e32 v6, 0x7070707, v2
	v_lshrrev_b32_e32 v42, 4, v2
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v79, v78, v6
	v_lshlrev_b32_e32 v44, 4, v2
	v_perm_b32 v6, v77, v76, v6
	v_and_or_b32 v6, v43, v44, v6
	v_perm_b32 v43, v79, v78, v42
	v_perm_b32 v42, v77, v76, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[134:135], v[0:1], v[10:13]
	v_and_or_b32 v2, v43, v2, v42
	v_perm_b32 v42, v2, v6, s45
	v_perm_b32 v43, v2, v6, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[136:137], v[0:1], v[34:37]
	v_and_b32_e32 v0, 0x7070707, v7
	v_lshrrev_b32_e32 v1, 4, v7
	v_and_b32_e32 v1, 0x7070707, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[132:133], v[74:75], v[50:53]
	v_perm_b32 v2, v86, v85, v0
	v_lshlrev_b32_e32 v6, 4, v7
	v_perm_b32 v0, v84, v83, v0
	v_and_or_b32 v0, v2, v6, v0
	v_perm_b32 v2, v86, v85, v1
	v_perm_b32 v1, v84, v83, v1
	v_and_or_b32 v1, v2, v7, v1
	v_perm_b32 v6, v1, v0, s45
	v_perm_b32 v7, v1, v0, s46
	v_and_b32_e32 v0, 0x7070707, v3
	v_lshrrev_b32_e32 v1, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[134:135], v[42:43], v[14:17]
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v79, v78, v0
	v_perm_b32 v0, v77, v76, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[136:137], v[42:43], v[38:41]
	v_lshlrev_b32_e32 v42, 4, v3
	v_and_or_b32 v0, v2, v42, v0
	v_perm_b32 v2, v79, v78, v1
	v_perm_b32 v1, v77, v76, v1
	v_and_or_b32 v1, v2, v3, v1
	v_perm_b32 v42, v1, v0, s45
	v_perm_b32 v43, v1, v0, s46
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[138:139], v[6:7], v[10:13]
	v_cmp_lt_i32_e32 vcc, 5, v213
	v_add_u32_e32 v81, 17, v153
	s_mov_b32 s19, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[0:3], v[138:139], v[42:43], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[140:141], v[6:7], v[34:37]
	v_and_b32_e32 v6, 0x7070707, v8
	v_lshrrev_b32_e32 v7, 4, v8
	v_and_b32_e32 v7, 0x7070707, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[140:141], v[42:43], v[38:41]
	s_nop 2
	v_perm_b32 v38, v86, v85, v6
	v_lshlrev_b32_e32 v39, 4, v8
	v_perm_b32 v6, v84, v83, v6
	v_and_or_b32 v38, v38, v39, v6
	v_perm_b32 v6, v86, v85, v7
	v_perm_b32 v7, v84, v83, v7
	v_and_or_b32 v7, v6, v8, v7
	v_perm_b32 v6, v7, v38, s45
	v_perm_b32 v7, v7, v38, s46
	v_and_b32_e32 v8, 0x7070707, v4
	v_lshrrev_b32_e32 v38, 4, v4
	v_and_b32_e32 v38, 0x7070707, v38
	v_perm_b32 v39, v79, v78, v8
	v_lshlrev_b32_e32 v40, 4, v4
	v_perm_b32 v8, v77, v76, v8
	v_and_or_b32 v8, v39, v40, v8
	v_perm_b32 v39, v79, v78, v38
	v_perm_b32 v38, v77, v76, v38
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v40, 2, v117
	v_and_or_b32 v4, v39, v4, v38
	v_or_b32_e32 v38, s48, v40
	v_perm_b32 v74, v4, v8, s45
	v_perm_b32 v75, v4, v8, s46
	v_ashrrev_i32_e32 v39, 31, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[102:103], v[6:7], v[10:13]
	v_mov_b32_e32 v41, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[74:75], v[0:3]
	s_nop 2
	v_lshl_add_u64 v[0:1], v[38:39], 2, s[20:21]
	global_load_dword v39, v[0:1], off
	v_and_b32_e32 v0, 0x7070707, v9
	v_lshrrev_b32_e32 v1, 4, v9
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v2, v86, v85, v0
	v_lshlrev_b32_e32 v3, 4, v9
	v_perm_b32 v0, v84, v83, v0
	v_and_or_b32 v0, v2, v3, v0
	v_perm_b32 v2, v86, v85, v1
	v_perm_b32 v1, v84, v83, v1
	v_and_or_b32 v1, v2, v9, v1
	v_perm_b32 v2, v1, v0, s45
	v_perm_b32 v3, v1, v0, s46
	v_and_b32_e32 v0, 0x7070707, v5
	v_lshrrev_b32_e32 v1, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[104:105], v[6:7], v[14:17]
	v_and_b32_e32 v1, 0x7070707, v1
	v_perm_b32 v4, v79, v78, v0
	v_lshlrev_b32_e32 v6, 4, v5
	v_perm_b32 v0, v77, v76, v0
	v_and_or_b32 v6, v4, v6, v0
	v_perm_b32 v4, v79, v78, v1
	v_perm_b32 v7, v77, v76, v1
	v_lshl_add_u64 v[0:1], s[48:49], 0, v[40:41]
	v_lshl_add_u64 v[0:1], v[0:1], 2, s[20:21]
	global_load_dwordx3 v[76:78], v[0:1], off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[98:99], v[2:3], v[42:45]
	v_and_or_b32 v5, v4, v5, v7
	v_perm_b32 v4, v5, v6, s45
	v_perm_b32 v5, v5, v6, s46
	global_load_dwordx4 v[42:45], v[0:1], off offset:64
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[104:105], v[74:75], v[34:37]
	v_add_u32_e32 v1, 17, v212
	v_lshlrev_b32_e64 v1, v1, 1
	v_add_u32_e32 v75, 17, v172
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[98:99], v[4:5], v[50:53]
	v_mov_b32_e32 v84, v90
	v_mov_b32_e32 v85, v58
	v_add_u32_e32 v79, 17, v150
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[100:101], v[2:3], v[10:13]
	v_add_u32_e32 v53, 17, v211
	v_lshlrev_b32_e64 v53, v53, 1
	v_mov_b32_e32 v86, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[100:101], v[4:5], v[34:37]
	v_mov_b32_e32 v87, v6
	v_mov_b32_e32 v58, v91
	s_lshl_b32 s49, s12, 9
	v_lshl_add_u32 v35, v213, 23, v115
	v_lshl_add_u32 v34, v212, 23, v115
	v_add_u32_e32 v37, 17, v151
	v_lshlrev_b32_e64 v37, v37, 1
	s_and_b32 s21, s21, 0xffff
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v0, 2, v39
	v_and_b32_e32 v0, 0x3fffffc, v0
	buffer_load_dword v74, v0, s[0:3], 0 offen
	v_add_u32_e32 v0, 17, v213
	v_lshlrev_b32_e64 v0, v0, 1
	v_cndmask_b32_e32 v35, v0, v35, vcc
	v_cmp_lt_i32_e32 vcc, 5, v212
	v_add_u32_e32 v39, 17, v154
	v_lshlrev_b32_e64 v39, v39, 1
	v_cndmask_b32_e32 v34, v1, v34, vcc
	v_cmp_lt_i32_e32 vcc, 5, v211
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v0, 2, v76
	v_and_b32_e32 v1, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v77
	v_and_b32_e32 v50, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v78
	v_and_b32_e32 v51, 0x3fffffc, v0
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v0, 2, v42
	v_and_b32_e32 v42, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v43
	v_and_b32_e32 v43, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v44
	v_and_b32_e32 v44, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v45
	v_and_b32_e32 v45, 0x3fffffc, v0
	buffer_load_dword v0, v1, s[0:3], 0 offen
	buffer_load_dword v78, v50, s[0:3], 0 offen
	buffer_load_dword v80, v51, s[0:3], 0 offen
	buffer_load_dword v76, v42, s[0:3], 0 offen
	buffer_load_dword v52, v43, s[0:3], 0 offen
	buffer_load_dword v40, v44, s[0:3], 0 offen
	buffer_load_dword v36, v45, s[0:3], 0 offen
	scratch_load_dword v50, off, off offset:156
	v_mov_b32_e32 v44, v94
	v_mov_b32_e32 v45, v62
	s_mov_b32 s0, 0xbfb8aa3b
	v_lshlrev_b32_e32 v1, 10, v117
	v_lshlrev_b32_e64 v62, v75, 1
	s_add_i32 s2, s12, 28
	s_waitcnt vmcnt(8)
	v_pk_mul_f32 v[42:43], v[74:75], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[42:43]
	s_waitcnt vmcnt(0)
	v_add_u32_e32 v116, v50, v1
	v_pk_mul_f32 v[42:43], v[44:45], s[0:1] op_sel_hi:[1,0]
	v_lshlrev_b32_e32 v114, 1, v116
	v_exp_f32_e32 v42, v42
	v_exp_f32_e32 v43, v43
	s_nop 0
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v50, v42
	v_rcp_f32_e32 v51, v43
	v_lshl_add_u32 v43, v211, 23, v115
	v_lshl_add_u32 v42, v172, 23, v115
	v_cndmask_b32_e32 v43, v53, v43, vcc
	v_cmp_lt_i32_e32 vcc, 5, v172
	v_pk_mul_f32 v[44:45], v[44:45], v[50:51]
	s_nop 0
	v_cndmask_b32_e32 v42, v62, v42, vcc
	v_pk_mul_f32 v[82:83], v[74:75], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[82:83], v[84:85], v[82:83]
	v_mov_b32_e32 v62, v95
	v_pk_mul_f32 v[44:45], v[82:83], v[44:45]
	v_mov_b32_e32 v82, v30
	v_bfe_u32 v50, v45, 16, 1
	v_add3_u32 v50, v50, v45, s47
	v_or_b32_e32 v51, 0x400000, v45
	v_cmp_u_f32_e32 vcc, v45, v45
	v_bfe_u32 v45, v44, 16, 1
	v_add3_u32 v45, v45, v44, s47
	v_cndmask_b32_e32 v53, v50, v51, vcc
	v_or_b32_e32 v50, 0x400000, v44
	v_cmp_u_f32_e32 vcc, v44, v44
	v_mov_b32_e32 v83, v14
	v_add_u32_e32 v14, s51, v126
	v_cndmask_b32_e32 v44, v45, v50, vcc
	v_lshl_add_u32 v45, v151, 23, v115
	v_cmp_lt_i32_e32 vcc, 5, v151
	ds_write_b16_d16_hi v114, v44 offset:16384
	v_lshl_add_u32 v44, v154, 23, v115
	v_cndmask_b32_e32 v45, v37, v45, vcc
	v_cmp_lt_i32_e32 vcc, 5, v154
	v_add_lshl_u32 v37, v14, v1, 1
	v_lshl_add_u32 v14, v150, 23, v115
	v_cndmask_b32_e32 v44, v39, v44, vcc
	v_pk_mul_f32 v[50:51], v[74:75], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[82:83], v[82:83], v[50:51]
	v_lshlrev_b32_e64 v39, v79, 1
	v_pk_mul_f32 v[50:51], v[82:83], s[0:1] op_sel_hi:[1,0]
	v_cmp_lt_i32_e32 vcc, 5, v150
	v_exp_f32_e32 v50, v50
	v_exp_f32_e32 v51, v51
	v_lshl_add_u32 v1, v153, 23, v115
	v_lshlrev_b32_e64 v30, v81, 1
	ds_write_b16_d16_hi v37, v53 offset:16416
	v_pk_add_f32 v[50:51], v[50:51], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v84, v50
	v_rcp_f32_e32 v85, v51
	v_cndmask_b32_e32 v51, v39, v14, vcc
	v_cmp_lt_i32_e32 vcc, 5, v153
	v_pk_mul_f32 v[82:83], v[82:83], v[84:85]
	s_nop 0
	v_cndmask_b32_e32 v50, v30, v1, vcc
	v_pk_mul_f32 v[74:75], v[74:75], v[50:51] op_sel_hi:[0,1]
	v_pk_mul_f32 v[74:75], v[86:87], v[74:75]
	s_nop 0
	v_pk_mul_f32 v[74:75], v[74:75], v[82:83]
	s_nop 0
	v_bfe_u32 v1, v75, 16, 1
	v_add3_u32 v1, v1, v75, s47
	v_or_b32_e32 v6, 0x400000, v75
	v_cmp_u_f32_e32 vcc, v75, v75
	v_or_b32_e32 v14, 0x400000, v74
	s_nop 0
	v_cndmask_b32_e32 v1, v1, v6, vcc
	v_pk_mul_f32 v[82:83], v[0:1], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[62:63], v[62:63], v[82:83]
	v_bfe_u32 v6, v74, 16, 1
	v_pk_mul_f32 v[82:83], v[62:63], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v6, v6, v74, s47
	v_exp_f32_e32 v82, v82
	v_exp_f32_e32 v83, v83
	v_cmp_u_f32_e32 vcc, v74, v74
	v_pk_add_f32 v[74:75], v[82:83], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[82:83], v[0:1], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v74, v74
	v_rcp_f32_e32 v75, v75
	v_pk_mul_f32 v[58:59], v[58:59], v[82:83]
	v_cndmask_b32_e32 v6, v6, v14, vcc
	ds_write_b16_d16_hi v37, v6 offset:16448
	ds_write_b16_d16_hi v37, v1 offset:16480
	v_pk_mul_f32 v[62:63], v[62:63], v[74:75]
	v_mov_b32_e32 v14, v31
	v_pk_mul_f32 v[58:59], v[58:59], v[62:63]
	s_nop 0
	v_bfe_u32 v1, v59, 16, 1
	v_add3_u32 v1, v1, v59, s47
	v_or_b32_e32 v6, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	v_or_b32_e32 v26, 0x400000, v58
	s_nop 0
	v_cndmask_b32_e32 v1, v1, v6, vcc
	v_pk_mul_f32 v[62:63], v[0:1], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[14:15], v[62:63]
	v_bfe_u32 v6, v58, 16, 1
	v_pk_mul_f32 v[30:31], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v6, v6, v58, s47
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cmp_u_f32_e32 vcc, v58, v58
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v6, v6, v26, vcc
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	ds_write_b16_d16_hi v37, v6 offset:16896
	ds_write_b16_d16_hi v37, v1 offset:16928
	v_pk_mul_f32 v[0:1], v[0:1], v[50:51] op_sel_hi:[0,1]
	v_mov_b32_e32 v6, v27
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	v_pk_mul_f32 v[6:7], v[14:15], v[30:31]
	v_mov_b32_e32 v14, v96
	v_pk_mul_f32 v[0:1], v[0:1], v[6:7]
	v_mov_b32_e32 v15, v64
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s47
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v27, 0x400000, v0
	v_mov_b32_e32 v64, v97
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v26, v6, v0, s47
	v_pk_mul_f32 v[6:7], v[78:79], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[14:15], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v0, v26, v27, vcc
	ds_write_b16_d16_hi v37, v0 offset:16960
	ds_write_b16_d16_hi v37, v1 offset:16992
	v_mov_b32_e32 v26, v92
	v_pk_add_f32 v[0:1], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[78:79], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v27, v60
	v_pk_mul_f32 v[14:15], v[26:27], v[14:15]
	v_mov_b32_e32 v60, v93
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[14:15], v[0:1]
	v_mov_b32_e32 v14, v32
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s47
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_mov_b32_e32 v15, v16
	v_or_b32_e32 v27, 0x400000, v0
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v26, v6, v0, s47
	v_pk_mul_f32 v[6:7], v[78:79], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[14:15], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v0, v26, v27, vcc
	ds_write_b16_d16_hi v37, v0 offset:17408
	ds_write_b16_d16_hi v37, v1 offset:17440
	v_mov_b32_e32 v26, v28
	v_pk_add_f32 v[0:1], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[78:79], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v27, v8
	v_pk_mul_f32 v[14:15], v[26:27], v[14:15]
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[14:15], v[0:1]
	s_nop 0
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s47
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v16, 0x400000, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v8, v6, v0, s47
	v_pk_mul_f32 v[6:7], v[80:81], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[64:65], v[6:7]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[14:15], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v0, v8, v16, vcc
	ds_write_b16_d16_hi v37, v0 offset:17472
	ds_write_b16_d16_hi v37, v1 offset:17504
	v_mov_b32_e32 v16, v33
	v_pk_add_f32 v[0:1], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[80:81], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_pk_mul_f32 v[14:15], v[60:61], v[14:15]
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[14:15], v[0:1]
	s_nop 0
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s47
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v26, 0x400000, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v8, v6, v0, s47
	v_pk_mul_f32 v[6:7], v[80:81], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[16:17], v[6:7]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[14:15], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v0, v8, v26, vcc
	ds_write_b16_d16_hi v37, v0 offset:17920
	ds_write_b16_d16_hi v37, v1 offset:17952
	v_mov_b32_e32 v8, v29
	v_pk_add_f32 v[0:1], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[80:81], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_pk_mul_f32 v[8:9], v[8:9], v[14:15]
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[8:9], v[0:1]
	v_mov_b32_e32 v8, v70
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s47
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_mov_b32_e32 v9, v54
	v_or_b32_e32 v15, 0x400000, v0
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v14, v6, v0, s47
	v_pk_mul_f32 v[6:7], v[76:77], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v54, v71
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v0, v14, v15, vcc
	ds_write_b16_d16_hi v37, v0 offset:17984
	ds_write_b16_d16_hi v37, v1 offset:18016
	v_mov_b32_e32 v14, v66
	v_pk_add_f32 v[0:1], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[76:77], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v15, v46
	v_pk_mul_f32 v[8:9], v[14:15], v[8:9]
	v_mov_b32_e32 v46, v67
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[8:9], v[0:1]
	v_mov_b32_e32 v8, v22
	v_bfe_u32 v6, v1, 16, 1
	v_add3_u32 v6, v6, v1, s47
	v_or_b32_e32 v7, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_mov_b32_e32 v9, v10
	v_or_b32_e32 v15, 0x400000, v0
	v_cndmask_b32_e32 v1, v6, v7, vcc
	v_bfe_u32 v6, v0, 16, 1
	v_add3_u32 v14, v6, v0, s47
	v_pk_mul_f32 v[6:7], v[76:77], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v0, v14, v15, vcc
	ds_write_b16_d16_hi v37, v0 offset:24576
	ds_write_b16_d16_hi v37, v1 offset:24608
	v_mov_b32_e32 v14, v18
	v_pk_add_f32 v[0:1], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[76:77], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v15, v2
	v_pk_mul_f32 v[8:9], v[14:15], v[8:9]
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[8:9], v[0:1]
	s_nop 0
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v6, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v10, 0x400000, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v2, v6, vcc
	v_pk_mul_f32 v[6:7], v[52:53], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[54:55], v[6:7]
	v_bfe_u32 v2, v0, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v2, v2, v0, s47
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v2, v10, vcc
	ds_write_b16_d16_hi v37, v0 offset:24640
	ds_write_b16_d16_hi v37, v1 offset:24672
	v_pk_add_f32 v[0:1], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[52:53], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_pk_mul_f32 v[8:9], v[46:47], v[8:9]
	v_mov_b32_e32 v10, v23
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[8:9], v[0:1]
	s_nop 0
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v6, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v14, 0x400000, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v2, v6, vcc
	v_pk_mul_f32 v[6:7], v[52:53], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_bfe_u32 v2, v0, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v2, v2, v0, s47
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v2, v14, vcc
	ds_write_b16_d16_hi v37, v0 offset:25088
	ds_write_b16_d16_hi v37, v1 offset:25120
	v_pk_add_f32 v[0:1], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[52:53], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v2, v19
	v_pk_mul_f32 v[2:3], v[2:3], v[8:9]
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	v_mov_b32_e32 v6, v72
	v_pk_mul_f32 v[0:1], v[2:3], v[0:1]
	v_mov_b32_e32 v7, v56
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v3, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v9, 0x400000, v0
	v_mov_b32_e32 v56, v73
	v_cndmask_b32_e32 v1, v2, v3, vcc
	v_bfe_u32 v2, v0, 16, 1
	v_add3_u32 v8, v2, v0, s47
	v_pk_mul_f32 v[2:3], v[40:41], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[6:7], v[2:3], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v6, v6
	v_exp_f32_e32 v7, v7
	v_cndmask_b32_e32 v0, v8, v9, vcc
	ds_write_b16_d16_hi v37, v0 offset:25152
	ds_write_b16_d16_hi v37, v1 offset:25184
	v_mov_b32_e32 v8, v68
	v_pk_add_f32 v[0:1], v[6:7], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[40:41], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v9, v48
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v48, v69
	v_pk_mul_f32 v[0:1], v[2:3], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	v_mov_b32_e32 v6, v24
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v3, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_mov_b32_e32 v7, v12
	v_or_b32_e32 v9, 0x400000, v0
	v_cndmask_b32_e32 v1, v2, v3, vcc
	v_bfe_u32 v2, v0, 16, 1
	v_add3_u32 v8, v2, v0, s47
	v_pk_mul_f32 v[2:3], v[40:41], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[6:7], v[2:3], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v12, v25
	v_exp_f32_e32 v6, v6
	v_exp_f32_e32 v7, v7
	v_cndmask_b32_e32 v0, v8, v9, vcc
	ds_write_b16_d16_hi v37, v0 offset:25600
	ds_write_b16_d16_hi v37, v1 offset:25632
	v_mov_b32_e32 v8, v20
	v_pk_add_f32 v[0:1], v[6:7], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[40:41], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_mov_b32_e32 v9, v4
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_pk_mul_f32 v[0:1], v[2:3], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v3, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v8, 0x400000, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v2, v3, vcc
	v_bfe_u32 v2, v0, 16, 1
	v_add3_u32 v4, v2, v0, s47
	v_pk_mul_f32 v[2:3], v[36:37], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[56:57], v[2:3]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[6:7], v[2:3], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v6, v6
	v_exp_f32_e32 v7, v7
	v_cndmask_b32_e32 v0, v4, v8, vcc
	ds_write_b16_d16_hi v37, v0 offset:25664
	ds_write_b16_d16_hi v37, v1 offset:25696
	v_pk_add_f32 v[0:1], v[6:7], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[36:37], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_pk_mul_f32 v[6:7], v[48:49], v[6:7]
	v_pk_mul_f32 v[0:1], v[2:3], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[6:7], v[0:1]
	s_nop 0
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v3, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	v_or_b32_e32 v8, 0x400000, v0
	s_nop 0
	v_cndmask_b32_e32 v1, v2, v3, vcc
	v_bfe_u32 v2, v0, 16, 1
	v_add3_u32 v4, v2, v0, s47
	v_pk_mul_f32 v[2:3], v[36:37], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[2:3], v[12:13], v[2:3]
	v_cmp_u_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[6:7], v[2:3], s[0:1] op_sel_hi:[1,0]
	s_mov_b32 s0, 0x43700000
	v_exp_f32_e32 v6, v6
	v_exp_f32_e32 v7, v7
	v_cndmask_b32_e32 v0, v4, v8, vcc
	ds_write_b16_d16_hi v37, v0 offset:26112
	ds_write_b16_d16_hi v37, v1 offset:26144
	v_mov_b32_e32 v4, v21
	v_pk_add_f32 v[0:1], v[6:7], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[36:37], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v0, v0
	v_rcp_f32_e32 v1, v1
	v_pk_mul_f32 v[4:5], v[4:5], v[6:7]
	s_lshl_b32 s1, s12, 2
	v_pk_mul_f32 v[0:1], v[2:3], v[0:1]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1]
	s_nop 0
	v_bfe_u32 v2, v1, 16, 1
	v_add3_u32 v2, v2, v1, s47
	v_or_b32_e32 v3, 0x400000, v1
	v_cmp_u_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v2, v3, vcc
	v_bfe_u32 v2, v0, 16, 1
	v_add3_u32 v2, v2, v0, s47
	v_or_b32_e32 v3, 0x400000, v0
	v_cmp_u_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v2, v3, vcc
	ds_write_b16_d16_hi v37, v0 offset:26176
	ds_write_b16_d16_hi v37, v1 offset:26208
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v13, off, off offset:152
	v_mov_b32_e32 v3, 0x7fc00000
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v2, 2, v13
	v_or_b32_e32 v0, s13, v2
	v_lshlrev_b32_e32 v0, 1, v0
	ds_read_b64 v[0:1], v0 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v1
	v_lshlrev_b32_e32 v6, 16, v1
	v_and_b32_e32 v1, 0xffff0000, v0
	v_lshlrev_b32_e32 v0, 16, v0
	v_max_f32_e64 v4, |v0|, 0
	v_cmp_o_f32_e64 vcc, |v0|, |v0|
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v4, vcc
	v_max_f32_e64 v5, v4, |v1|
	v_cmp_o_f32_e64 vcc, v4, |v1|
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v5, vcc
	v_max_f32_e64 v5, v4, |v6|
	v_cmp_o_f32_e64 vcc, v4, |v6|
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v5, vcc
	v_max_f32_e64 v5, v4, |v7|
	v_cmp_o_f32_e64 vcc, v4, |v7|
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v5, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v8, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v8, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v8, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v8, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v8, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v8, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v8, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v8, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v8, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	v_xor_b32_e32 v4, 0x80, v2
	s_nop 0
	v_cndmask_b32_e32 v5, v3, v8, vcc
	ds_bpermute_b32 v8, v4, v5
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v9, v5, v8
	v_cmp_o_f32_e32 vcc, v5, v8
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v9, vcc
	v_div_scale_f32 v8, s[6:7], s0, s0, v5
	v_rcp_f32_e32 v9, v8
	s_nop 0
	v_fma_f32 v10, -v8, v9, 1.0
	v_fmac_f32_e32 v9, v10, v9
	v_div_scale_f32 v10, vcc, v5, s0, v5
	v_mul_f32_e32 v11, v10, v9
	v_fma_f32 v12, -v8, v11, v10
	v_fmac_f32_e32 v11, v12, v9
	v_fma_f32 v8, -v8, v11, v10
	v_div_fmas_f32 v8, v8, v9, v11
	v_div_fixup_f32 v8, v8, s0, v5
	v_cmp_neq_f32_e32 vcc, 0, v5
	s_nop 1
	v_cndmask_b32_e32 v9, 1.0, v8, vcc
	v_div_scale_f32 v5, s[6:7], v9, v9, 1.0
	v_rcp_f32_e32 v8, v5
	s_nop 0
	v_fma_f32 v10, -v5, v8, 1.0
	v_fmac_f32_e32 v8, v10, v8
	v_div_scale_f32 v10, vcc, 1.0, v9, 1.0
	v_mul_f32_e32 v11, v10, v8
	v_fma_f32 v12, -v5, v11, v10
	v_fmac_f32_e32 v11, v12, v8
	v_fma_f32 v5, -v5, v11, v10
	v_div_fmas_f32 v5, v5, v8, v11
	v_div_fixup_f32 v8, v5, v9, 1.0
	v_pk_mul_f32 v[0:1], v[8:9], v[0:1] op_sel_hi:[0,1]
	v_min_f32_e32 v5, 0x43700000, v0
	v_cmp_o_f32_e32 vcc, v0, v0
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	s_nop 0
	v_cndmask_b32_e32 v0, v3, v5, vcc
	v_max_f32_e32 v5, 0xc3700000, v0
	v_cmp_o_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v5, vcc
	v_min_f32_e32 v5, 0x43700000, v1
	v_cmp_o_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v5, vcc
	v_max_f32_e32 v5, 0xc3700000, v1
	v_cmp_o_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v5, vcc
	v_min_f32_e32 v5, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v5, vcc
	v_max_f32_e32 v6, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	v_mov_b32_e32 v7, v41
	v_cvt_pk_fp8_f32 v7, v0, v1
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_max_f32_e32 v0, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_cvt_pk_fp8_f32 v7, v5, v0 op_sel:[0,0,1]
	v_mov_b32_e32 v5, s1
	s_lshr_b32 s1, s52, 2
	s_and_b32 s1, s1, 0xf0
	v_and_b32_e32 v0, 0x7f7f7f7f, v7
	v_add_u32_e32 v0, 0x7f7f7f7f, v0
	v_or_b32_e32 v0, 0x7f7f7f7f, v0
	v_xor_b32_e32 v1, s1, v2
	v_and_b32_e32 v0, v0, v7
	v_or_b32_e32 v1, s13, v1
	ds_write_b32 v5, v9 offset:8192
	ds_write_b32 v1, v0
	s_add_i32 s1, s12, 4
	v_lshlrev_b32_e32 v0, 3, v13
	v_lshl_or_b32 v6, s1, 9, v0
	ds_read_b64 v[6:7], v6 offset:16384
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v9, 0xffff0000, v7
	v_lshlrev_b32_e32 v8, 16, v7
	v_and_b32_e32 v7, 0xffff0000, v6
	v_lshlrev_b32_e32 v6, 16, v6
	v_max_f32_e64 v10, |v6|, 0
	v_cmp_o_f32_e64 vcc, |v6|, |v6|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v10, vcc
	v_max_f32_e64 v11, v10, |v7|
	v_cmp_o_f32_e64 vcc, v10, |v7|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v8|
	v_cmp_o_f32_e64 vcc, v10, |v8|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v9|
	v_cmp_o_f32_e64 vcc, v10, |v9|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_bpermute_b32 v11, v4, v10
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_div_scale_f32 v11, s[6:7], s0, s0, v10
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v10, s0, v10
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s0, v10
	v_cmp_neq_f32_e32 vcc, 0, v10
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v10, s[6:7], v11, v11, 1.0
	v_rcp_f32_e32 v12, v10
	ds_write_b32 v5, v11 offset:8208
	v_fma_f32 v13, -v10, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v10, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v10, -v10, v14, v13
	v_div_fmas_f32 v10, v10, v12, v14
	v_div_fixup_f32 v10, v10, v11, 1.0
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v10, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v10, vcc
	v_mov_b32_e32 v10, v41
	v_cvt_pk_fp8_f32 v10, v6, v7
	v_max_f32_e32 v6, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	v_xor_b32_e32 v7, s1, v2
	v_or_b32_e32 v7, s13, v7
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	s_add_i32 s1, s12, 8
	v_and_b32_e32 v6, 0x7f7f7f7f, v10
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v10
	ds_write_b32 v7, v6 offset:1024
	v_lshl_or_b32 v6, s1, 9, v0
	ds_read_b64 v[6:7], v6 offset:16384
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v9, 0xffff0000, v7
	v_lshlrev_b32_e32 v8, 16, v7
	v_and_b32_e32 v7, 0xffff0000, v6
	v_lshlrev_b32_e32 v6, 16, v6
	v_max_f32_e64 v10, |v6|, 0
	v_cmp_o_f32_e64 vcc, |v6|, |v6|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v10, vcc
	v_max_f32_e64 v11, v10, |v7|
	v_cmp_o_f32_e64 vcc, v10, |v7|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v8|
	v_cmp_o_f32_e64 vcc, v10, |v8|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v9|
	v_cmp_o_f32_e64 vcc, v10, |v9|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_bpermute_b32 v11, v4, v10
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_div_scale_f32 v11, s[6:7], s0, s0, v10
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v10, s0, v10
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s0, v10
	v_cmp_neq_f32_e32 vcc, 0, v10
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v10, s[6:7], v11, v11, 1.0
	v_rcp_f32_e32 v12, v10
	ds_write_b32 v5, v11 offset:8224
	v_fma_f32 v13, -v10, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v10, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v10, -v10, v14, v13
	v_div_fmas_f32 v10, v10, v12, v14
	v_div_fixup_f32 v10, v10, v11, 1.0
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v10, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v10, vcc
	v_mov_b32_e32 v10, v41
	v_cvt_pk_fp8_f32 v10, v6, v7
	v_max_f32_e32 v6, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	v_xor_b32_e32 v7, s1, v2
	v_or_b32_e32 v7, s13, v7
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	s_add_i32 s1, s12, 12
	v_and_b32_e32 v6, 0x7f7f7f7f, v10
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v10
	ds_write_b32 v7, v6 offset:2048
	v_lshl_or_b32 v6, s1, 9, v0
	ds_read_b64 v[6:7], v6 offset:16384
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v9, 0xffff0000, v7
	v_lshlrev_b32_e32 v8, 16, v7
	v_and_b32_e32 v7, 0xffff0000, v6
	v_lshlrev_b32_e32 v6, 16, v6
	v_max_f32_e64 v10, |v6|, 0
	v_cmp_o_f32_e64 vcc, |v6|, |v6|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v10, vcc
	v_max_f32_e64 v11, v10, |v7|
	v_cmp_o_f32_e64 vcc, v10, |v7|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v8|
	v_cmp_o_f32_e64 vcc, v10, |v8|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v9|
	v_cmp_o_f32_e64 vcc, v10, |v9|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_bpermute_b32 v11, v4, v10
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_div_scale_f32 v11, s[6:7], s0, s0, v10
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v10, s0, v10
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s0, v10
	v_cmp_neq_f32_e32 vcc, 0, v10
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v10, s[6:7], v11, v11, 1.0
	v_rcp_f32_e32 v12, v10
	ds_write_b32 v5, v11 offset:8240
	v_fma_f32 v13, -v10, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v10, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v10, -v10, v14, v13
	v_div_fmas_f32 v10, v10, v12, v14
	v_div_fixup_f32 v10, v10, v11, 1.0
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v10, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v10, vcc
	v_mov_b32_e32 v10, v41
	v_cvt_pk_fp8_f32 v10, v6, v7
	v_max_f32_e32 v6, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	v_xor_b32_e32 v7, s1, v2
	v_or_b32_e32 v7, s13, v7
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	s_add_i32 s1, s49, 0x2000
	v_and_b32_e32 v6, 0x7f7f7f7f, v10
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v10
	ds_write_b32 v7, v6 offset:3072
	v_or_b32_e32 v6, s1, v0
	ds_read_b64 v[6:7], v6 offset:16384
	s_add_i32 s1, s12, 20
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v9, 0xffff0000, v7
	v_lshlrev_b32_e32 v8, 16, v7
	v_and_b32_e32 v7, 0xffff0000, v6
	v_lshlrev_b32_e32 v6, 16, v6
	v_max_f32_e64 v10, |v6|, 0
	v_cmp_o_f32_e64 vcc, |v6|, |v6|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v10, vcc
	v_max_f32_e64 v11, v10, |v7|
	v_cmp_o_f32_e64 vcc, v10, |v7|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v8|
	v_cmp_o_f32_e64 vcc, v10, |v8|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	v_max_f32_e64 v11, v10, |v9|
	v_cmp_o_f32_e64 vcc, v10, |v9|
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v11, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_swizzle_b32 v11, v10 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	ds_bpermute_b32 v11, v4, v10
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v10, v11
	v_cmp_o_f32_e32 vcc, v10, v11
	s_nop 1
	v_cndmask_b32_e32 v10, v3, v12, vcc
	v_div_scale_f32 v11, s[6:7], s0, s0, v10
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v10, s0, v10
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s0, v10
	v_cmp_neq_f32_e32 vcc, 0, v10
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v10, s[6:7], v11, v11, 1.0
	v_rcp_f32_e32 v12, v10
	ds_write_b32 v5, v11 offset:8256
	v_fma_f32 v13, -v10, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v10, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v10, -v10, v14, v13
	v_div_fmas_f32 v10, v10, v12, v14
	v_div_fixup_f32 v10, v10, v11, 1.0
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v10, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v10, vcc
	v_mov_b32_e32 v10, v41
	v_cvt_pk_fp8_f32 v10, v6, v7
	v_max_f32_e32 v6, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v6, 0x7f7f7f7f, v10
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v10
	ds_write_b32 v1, v6 offset:4096
	v_lshl_or_b32 v1, s1, 9, v0
	ds_read_b64 v[6:7], v1 offset:16384
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
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
	ds_bpermute_b32 v10, v4, v1
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	v_div_scale_f32 v10, s[6:7], s0, s0, v1
	v_rcp_f32_e32 v11, v10
	s_nop 0
	v_fma_f32 v12, -v10, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, v1, s0, v1
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v10, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v10, -v10, v13, v12
	v_div_fmas_f32 v10, v10, v11, v13
	v_div_fixup_f32 v10, v10, s0, v1
	v_cmp_neq_f32_e32 vcc, 0, v1
	s_nop 1
	v_cndmask_b32_e32 v1, 1.0, v10, vcc
	v_div_scale_f32 v10, s[6:7], v1, v1, 1.0
	v_rcp_f32_e32 v11, v10
	ds_write_b32 v5, v1 offset:8272
	v_fma_f32 v12, -v10, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, 1.0, v1, 1.0
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v10, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v10, -v10, v13, v12
	v_div_fmas_f32 v10, v10, v11, v13
	v_div_fixup_f32 v10, v10, v1, 1.0
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v10, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v10, vcc
	v_mov_b32_e32 v10, v41
	v_cvt_pk_fp8_f32 v10, v6, v7
	v_max_f32_e32 v6, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	v_xor_b32_e32 v6, s1, v2
	v_or_b32_e32 v6, s13, v6
	s_add_i32 s1, s12, 24
	v_and_b32_e32 v1, 0x7f7f7f7f, v10
	v_add_u32_e32 v1, 0x7f7f7f7f, v1
	v_or_b32_e32 v1, 0x7f7f7f7f, v1
	v_and_b32_e32 v1, v1, v10
	ds_write_b32 v6, v1 offset:5120
	v_lshl_or_b32 v1, s1, 9, v0
	ds_read_b64 v[6:7], v1 offset:16384
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	v_lshl_or_b32 v0, s2, 9, v0
	s_lshl_b32 s12, s12, 13
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
	ds_bpermute_b32 v10, v4, v1
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v1, v10
	v_cmp_o_f32_e32 vcc, v1, v10
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v11, vcc
	v_div_scale_f32 v10, s[6:7], s0, s0, v1
	v_rcp_f32_e32 v11, v10
	s_nop 0
	v_fma_f32 v12, -v10, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, v1, s0, v1
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v10, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v10, -v10, v13, v12
	v_div_fmas_f32 v10, v10, v11, v13
	v_div_fixup_f32 v10, v10, s0, v1
	v_cmp_neq_f32_e32 vcc, 0, v1
	s_nop 1
	v_cndmask_b32_e32 v1, 1.0, v10, vcc
	v_div_scale_f32 v10, s[6:7], v1, v1, 1.0
	v_rcp_f32_e32 v11, v10
	ds_write_b32 v5, v1 offset:8288
	v_fma_f32 v12, -v10, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, 1.0, v1, 1.0
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v10, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v10, -v10, v13, v12
	v_div_fmas_f32 v10, v10, v11, v13
	v_div_fixup_f32 v10, v10, v1, 1.0
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v10, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_max_f32_e32 v10, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	v_min_f32_e32 v10, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v9, v3, v10, vcc
	v_mov_b32_e32 v10, v41
	v_cvt_pk_fp8_f32 v10, v6, v7
	v_max_f32_e32 v6, 0xc3700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	v_xor_b32_e32 v6, s1, v2
	v_or_b32_e32 v6, s13, v6
	v_and_b32_e32 v1, 0x7f7f7f7f, v10
	v_add_u32_e32 v1, 0x7f7f7f7f, v1
	v_or_b32_e32 v1, 0x7f7f7f7f, v1
	v_and_b32_e32 v1, v1, v10
	ds_write_b32 v6, v1 offset:6144
	ds_read_b64 v[0:1], v0 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v1
	v_lshlrev_b32_e32 v6, 16, v1
	v_and_b32_e32 v1, 0xffff0000, v0
	v_lshlrev_b32_e32 v0, 16, v0
	v_max_f32_e64 v8, |v0|, 0
	v_cmp_o_f32_e64 vcc, |v0|, |v0|
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_max_f32_e64 v9, v8, |v1|
	v_cmp_o_f32_e64 vcc, v8, |v1|
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v9, vcc
	v_max_f32_e64 v9, v8, |v6|
	v_cmp_o_f32_e64 vcc, v8, |v6|
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v9, vcc
	v_max_f32_e64 v9, v8, |v7|
	v_cmp_o_f32_e64 vcc, v8, |v7|
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v9, vcc
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v8, v9
	v_cmp_o_f32_e32 vcc, v8, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v8, v9
	v_cmp_o_f32_e32 vcc, v8, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v8, v9
	v_cmp_o_f32_e32 vcc, v8, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v8, v9
	v_cmp_o_f32_e32 vcc, v8, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	ds_swizzle_b32 v9, v8 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v8, v9
	v_cmp_o_f32_e32 vcc, v8, v9
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v10, vcc
	ds_bpermute_b32 v4, v4, v8
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v9, v8, v4
	v_cmp_o_f32_e32 vcc, v8, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v9, vcc
	v_div_scale_f32 v8, s[6:7], s0, s0, v4
	v_rcp_f32_e32 v9, v8
	s_mov_b32 s6, 0x400000
	s_mov_b32 s42, s6
	v_fma_f32 v10, -v8, v9, 1.0
	v_fmac_f32_e32 v9, v10, v9
	v_div_scale_f32 v10, vcc, v4, s0, v4
	v_mul_f32_e32 v11, v10, v9
	v_fma_f32 v12, -v8, v11, v10
	v_fmac_f32_e32 v11, v12, v9
	v_fma_f32 v8, -v8, v11, v10
	v_div_fmas_f32 v8, v8, v9, v11
	v_div_fixup_f32 v8, v8, s0, v4
	v_cmp_neq_f32_e32 vcc, 0, v4
	s_nop 1
	v_cndmask_b32_e32 v8, 1.0, v8, vcc
	v_div_scale_f32 v4, s[0:1], v8, v8, 1.0
	v_rcp_f32_e32 v9, v4
	s_lshl_b32 s0, s2, 4
	s_and_b32 s0, s0, 0xf0
	ds_write_b32 v5, v8 offset:8304
	v_fma_f32 v10, -v4, v9, 1.0
	v_fmac_f32_e32 v9, v10, v9
	v_div_scale_f32 v10, vcc, 1.0, v8, 1.0
	v_mul_f32_e32 v11, v10, v9
	v_fma_f32 v12, -v4, v11, v10
	v_fmac_f32_e32 v11, v12, v9
	v_fma_f32 v4, -v4, v11, v10
	v_div_fmas_f32 v4, v4, v9, v11
	v_div_fixup_f32 v4, v4, v8, 1.0
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[4:5], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v4, 0x43700000, v0
	v_cmp_o_f32_e32 vcc, v0, v0
	s_and_b32 s1, s15, 0xffff
	s_brev_b32 s2, 16
	v_cndmask_b32_e32 v0, v3, v4, vcc
	v_max_f32_e32 v4, 0xc3700000, v0
	v_cmp_o_f32_e32 vcc, v0, v0
	s_mov_b32 s29, s1
	s_mov_b32 s30, s2
	v_cndmask_b32_e32 v0, v3, v4, vcc
	v_min_f32_e32 v4, 0x43700000, v1
	v_cmp_o_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v4, vcc
	v_max_f32_e32 v4, 0xc3700000, v1
	v_cmp_o_f32_e32 vcc, v1, v1
	s_nop 1
	v_cndmask_b32_e32 v1, v3, v4, vcc
	v_min_f32_e32 v4, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	v_cvt_pk_fp8_f32 v41, v0, v1
	v_xor_b32_e32 v1, s0, v2
	v_cndmask_b32_e32 v4, v3, v4, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_or_b32_e32 v1, s13, v1
	s_mul_i32 s0, s50, 0xe00
	v_cndmask_b32_e32 v4, v3, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_add_i32 s15, s4, s0
	s_lshl_b32 s0, s15, 1
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_max_f32_e32 v0, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_ashr_i32 s4, s15, 31
	s_lshr_b32 s7, s4, 27
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_cvt_pk_fp8_f32 v41, v4, v0 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v0, 0x7f7f7f7f, v41
	v_add_u32_e32 v0, 0x7f7f7f7f, v0
	v_or_b32_e32 v0, 0x7f7f7f7f, v0
	v_and_b32_e32 v0, v0, v41
	ds_write_b32 v1, v0 offset:7168
	s_waitcnt lgkmcnt(0)
	s_barrier
	scratch_load_dword v8, off, off offset:144
	scratch_load_dword v45, off, off offset:132
	v_lshlrev_b32_e32 v0, 2, v38
	v_or_b32_e32 v1, 4, v0
	v_or_b32_e32 v2, 8, v0
	v_or_b32_e32 v3, 12, v0
	v_or_b32_e32 v4, 64, v0
	v_or_b32_e32 v5, 0x44, v0
	v_or_b32_e32 v6, 0x48, v0
	v_or_b32_e32 v7, 0x4c, v0
	buffer_load_dword v110, v0, s[24:27], 0 offen
	buffer_load_dword v111, v1, s[24:27], 0 offen
	buffer_load_dword v112, v2, s[24:27], 0 offen
	buffer_load_dword v113, v3, s[24:27], 0 offen
	buffer_load_dword v106, v4, s[24:27], 0 offen
	buffer_load_dword v107, v5, s[24:27], 0 offen
	buffer_load_dword v108, v6, s[24:27], 0 offen
	buffer_load_dword v109, v7, s[24:27], 0 offen
	v_or_b32_e32 v0, s15, v126
	v_lshlrev_b32_e32 v0, 2, v0
	s_waitcnt vmcnt(9)
	v_or3_b32 v1, s0, v8, v126
	s_lshl_b32 s0, s15, 3
	v_or3_b32 v2, s0, v8, v126
	s_or_b32 s0, s15, 16
	v_lshlrev_b32_e32 v2, 4, v2
	s_add_i32 s8, s0, s7
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[102:105], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[90:93], v3, s[28:31], 0 offen nt
	v_or_b32_e32 v2, s0, v126
	s_lshr_b32 s8, s8, 5
	s_lshl_b32 s0, s0, 3
	s_add_i32 s8, s8, s4
	v_or3_b32 v4, s0, v8, v126
	s_lshl_b32 s8, s8, 6
	v_lshlrev_b32_e32 v4, 4, v4
	s_or_b32 s0, s15, 32
	v_or3_b32 v3, s8, v8, v126
	v_or_b32_e32 v5, 0x400, v4
	buffer_load_dwordx4 v[98:101], v4, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[94:97], v5, s[28:31], 0 offen nt
	v_or_b32_e32 v4, s0, v126
	s_lshl_b32 s8, s0, 1
	s_lshl_b32 s0, s0, 3
	v_or3_b32 v6, s0, v8, v126
	s_or_b32 s0, s15, 48
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_lshlrev_b32_e32 v6, 4, v6
	s_add_i32 s7, s7, s4
	v_or_b32_e32 v7, 0x400, v6
	buffer_load_dwordx4 v[86:89], v6, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[82:85], v7, s[28:31], 0 offen nt
	v_or_b32_e32 v6, s0, v126
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v2, 2, v2
	v_lshlrev_b32_e32 v4, 2, v4
	v_lshlrev_b32_e32 v6, 2, v6
	buffer_load_dword v141, v0, s[40:43], 0 offen
	buffer_load_dword v140, v2, s[40:43], 0 offen
	buffer_load_dword v139, v4, s[40:43], 0 offen
	buffer_load_dword v138, v6, s[40:43], 0 offen
	v_or3_b32 v0, s4, v8, v126
	v_lshlrev_b32_e32 v1, 2, v1
	v_or3_b32 v5, s8, v8, v126
	v_lshlrev_b32_e32 v0, 2, v0
	s_lshl_b32 s0, s0, 3
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshlrev_b32_e32 v5, 2, v5
	buffer_load_dword v149, v1, s[36:39], 0 offen
	buffer_load_dword v130, v3, s[36:39], 0 offen
	buffer_load_dword v148, v5, s[36:39], 0 offen
	buffer_load_dword v128, v0, s[36:39], 0 offen
	v_or3_b32 v0, s0, v8, v126
	v_lshlrev_b32_e32 v0, 4, v0
	v_or_b32_e32 v1, 0x400, v0
	buffer_load_dwordx4 v[78:81], v0, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[74:77], v1, s[28:31], 0 offen nt
	v_add_u32_e32 v0, v201, v170
	ds_read2st64_b64 v[38:41], v0 offset1:8
	ds_read2st64_b64 v[34:37], v142 offset1:8
	ds_read2st64_b64 v[30:33], v143 offset1:8
	ds_read2st64_b64 v[26:29], v144 offset1:8
	ds_read2st64_b64 v[22:25], v145 offset1:8
	ds_read2st64_b64 v[18:21], v146 offset1:8
	ds_read2st64_b64 v[14:17], v147 offset1:8
	ds_read2st64_b64 v[10:13], v171 offset1:8
	v_lshlrev_b32_e32 v0, 4, v117
	ds_read_b128 v[6:9], v0 offset:8192
	ds_read_b128 v[2:5], v0 offset:8256
	s_waitcnt vmcnt(24)
	v_lshrrev_b32_e32 v0, 5, v45
	v_or_b32_e32 v1, s48, v0
	v_lshlrev_b32_e32 v124, 2, v1
	v_or_b32_e32 v1, 8, v0
	v_or_b32_e32 v42, s48, v1
	v_lshlrev_b32_e32 v122, 2, v42
	v_or_b32_e32 v42, 16, v0
	v_or_b32_e32 v43, s48, v42
	v_lshlrev_b32_e32 v121, 2, v43
	v_or_b32_e32 v43, 24, v0
	v_lshlrev_b32_e32 v125, 9, v0
	v_lshlrev_b32_e32 v0, 2, v45
	v_and_b32_e32 v117, 0x7c, v0
	v_and_b32_e32 v131, 0xfc, v0
	scratch_load_dword v0, off, off
	s_mov_b32 s8, s16
	s_lshl_b32 s16, s50, 19
	s_add_i32 s16, s16, s12
	s_lshl_b32 s12, s50, 15
	s_add_i32 s12, s12, s49
	s_mov_b32 s0, s14
	s_lshl_b32 s14, s50, 12
	s_mov_b32 s4, s18
	v_or_b32_e32 v44, s48, v43
	s_add_i32 s18, s14, s51
	s_mov_b32 s7, s3
	v_lshlrev_b32_e32 v119, 2, v44
	v_lshlrev_b32_e32 v123, 9, v1
	v_lshlrev_b32_e32 v120, 9, v42
	v_lshlrev_b32_e32 v118, 9, v43
	s_add_i32 s14, s18, 0x130
	s_lshl3_add_u32 s18, s18, 0x900
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v132, 0x3f0, v0
	v_and_b32_e32 v0, 31, v45
	v_lshlrev_b32_e32 v133, 2, v0
	v_or_b32_e32 v0, s12, v131
	s_lshl_b32 s12, s50, 14
	s_add_i32 s12, s12, s13
	v_or_b32_e32 v134, s16, v132
	v_add_u32_e32 v135, 0x800, v0
	v_lshl_or_b32 v136, v126, 2, s12
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[12:13]
	s_add_i32 s19, s19, 1
	s_add_i32 s17, s17, 0x8000
	s_addk_i32 s14, 0x100
	s_addk_i32 s18, 0x800
	v_add_u32_e32 v136, 0x400, v136
	v_add_u32_e32 v133, 0x200, v133
	v_add_u32_e32 v135, 0x800, v135
	s_cmp_lg_u32 s17, 0x78000
	v_mov_b64_e32 v[104:105], v[72:73]
	v_mov_b64_e32 v[102:103], v[70:71]
	v_mov_b64_e32 v[92:93], v[68:69]
	v_mov_b64_e32 v[90:91], v[66:67]
	v_mov_b64_e32 v[100:101], v[64:65]
	v_mov_b64_e32 v[98:99], v[62:63]
	v_mov_b64_e32 v[96:97], v[60:61]
	v_mov_b64_e32 v[94:95], v[58:59]
	v_mov_b64_e32 v[88:89], v[56:57]
	v_mov_b64_e32 v[86:87], v[54:55]
	v_mov_b64_e32 v[84:85], v[52:53]
	v_mov_b64_e32 v[82:83], v[50:51]
	v_mov_b64_e32 v[80:81], v[48:49]
	v_mov_b64_e32 v[78:79], v[46:47]
	v_mov_b64_e32 v[76:77], v[44:45]
	v_mov_b64_e32 v[74:75], v[42:43]
	v_mov_b32_e32 v138, v0
	v_mov_b32_e32 v139, v1
	v_mov_b32_e32 v140, v126
	v_mov_b32_e32 v141, v127
	v_mov_b32_e32 v148, v129
	v_mov_b32_e32 v149, v137
	s_cbranch_scc0 .LBB0_13
.LBB0_5:
	s_add_i32 s12, s14, 0xfffffed1
	s_lshr_b32 s13, s12, 31
	s_add_i32 s13, s12, s13
	s_and_b32 s13, s13, 0x1ffffffe
	s_sub_i32 s12, s12, s13
	s_lshl_b32 s12, s12, 3
	s_add_i32 s13, s12, 16
	v_bfe_u32 v157, v130, s13, 8
	v_bfe_u32 v142, v128, s13, 8
	s_sub_i32 s13, s14, 32
	s_ashr_i32 s24, s13, 31
	s_lshr_b32 s24, s24, 27
	v_bfe_u32 v156, v130, s12, 8
	v_bfe_u32 v143, v128, s12, 8
	s_sub_i32 s12, s14, 48
	s_add_i32 s13, s13, s24
	s_lshr_b32 s13, s13, 5
	s_ashr_i32 s12, s12, 31
	s_add_i32 s13, s13, s12
	v_add_u32_e32 v0, s17, v134
	v_lshl_or_b32 v42, s13, 8, v131
	s_add_i32 s13, s16, s17
	v_add_u32_e32 v0, 0x8000, v0
	s_add_i32 s24, s13, 0x8800
	buffer_load_dwordx4 v[70:73], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[66:69], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s24, v132
	s_add_i32 s24, s13, 0x9000
	buffer_load_dwordx4 v[62:65], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[58:61], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s24, v132
	s_ashr_i32 s24, s14, 31
	s_lshr_b32 s24, s24, 27
	s_add_i32 s24, s14, s24
	buffer_load_dwordx4 v[54:57], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[50:53], v0, s[0:3], 0 offen offset:1024 nt
	buffer_load_dword v127, v136, s[4:7], 0 offen offset:1024
	buffer_load_dword v126, v136, s[4:7], 0 offen offset:1088
	buffer_load_dword v1, v136, s[4:7], 0 offen offset:1152
	s_nop 0
	buffer_load_dword v0, v136, s[4:7], 0 offen offset:1216
	s_lshr_b32 s24, s24, 5
	s_add_i32 s24, s24, s12
	v_or_b32_e32 v43, s18, v131
	v_lshl_or_b32 v44, s24, 8, v131
	buffer_load_dword v137, v135, s[8:11], 0 offen
	buffer_load_dword v130, v42, s[8:11], 0 offen
	buffer_load_dword v129, v43, s[8:11], 0 offen
	buffer_load_dword v128, v44, s[8:11], 0 offen
	s_add_i32 s13, s13, 0x9800
	v_or_b32_e32 v42, s13, v132
	buffer_load_dwordx4 v[46:49], v42, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[42:45], v42, s[0:3], 0 offen offset:1024 nt
	s_and_b32 s12, s19, 1
	v_sub_u32_sdwa v144, v141, v149 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v145, 11, v144
	v_mul_lo_u32 v145, v145, s44
	v_sub_u32_e32 v146, 0x6c686080, v145
	v_and_b32_e32 v146, 0xffffff00, v146
	v_cmp_lt_i32_e32 vcc, 11, v144
	v_sub_u32_e32 v145, 0x7c787470, v145
	v_lshlrev_b32_e32 v147, 4, v102
	v_cndmask_b32_e64 v154, v146, 0, vcc
	v_cndmask_b32_e64 v155, v145, 0, vcc
	v_add_u32_e32 v144, 0x7f7f7f00, v154
	v_and_b32_e32 v158, 0x80808000, v144
	v_add_u32_e32 v144, 0x7f7f7f78, v155
	v_and_b32_e32 v159, 0x80808080, v144
	v_and_b32_e32 v144, 0x7070707, v102
	v_lshrrev_b32_e32 v145, 4, v102
	v_and_b32_e32 v145, 0x7070707, v145
	v_perm_b32 v146, v159, v158, v144
	v_perm_b32 v144, v155, v154, v144
	v_and_or_b32 v144, v146, v147, v144
	v_perm_b32 v146, v159, v158, v145
	v_perm_b32 v145, v155, v154, v145
	v_and_or_b32 v102, v146, v102, v145
	v_sub_u32_sdwa v149, v141, v149 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v150, v102, v144, s45
	v_perm_b32 v151, v102, v144, s46
	v_min_i32_e32 v102, 11, v149
	v_mul_lo_u32 v160, v102, s44
	v_and_b32_e32 v102, 0x7070707, v103
	v_lshrrev_b32_e32 v161, 4, v103
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[38:39], v[150:151], 0
	v_and_b32_e32 v161, 0x7070707, v161
	v_perm_b32 v162, v159, v158, v102
	v_lshlrev_b32_e32 v163, 4, v103
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[40:41], v[150:151], 0
	v_perm_b32 v102, v155, v154, v102
	v_and_or_b32 v162, v162, v163, v102
	v_perm_b32 v102, v159, v158, v161
	v_perm_b32 v161, v155, v154, v161
	v_and_or_b32 v103, v102, v103, v161
	v_perm_b32 v102, v103, v162, s45
	v_perm_b32 v103, v103, v162, s46
	v_lshlrev_b32_e32 v163, 4, v104
	v_sub_u32_e32 v161, 0x6c686080, v160
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[34:35], v[102:103], v[144:147]
	v_and_b32_e32 v161, 0xffffff00, v161
	v_sub_u32_e32 v160, 0x7c787470, v160
	v_cmp_lt_i32_e32 vcc, 11, v149
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[36:37], v[102:103], v[150:153]
	v_and_b32_e32 v102, 0x7070707, v104
	v_lshrrev_b32_e32 v103, 4, v104
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v162, v159, v158, v102
	v_perm_b32 v102, v155, v154, v102
	v_and_or_b32 v162, v162, v163, v102
	v_perm_b32 v102, v159, v158, v103
	v_perm_b32 v103, v155, v154, v103
	v_and_or_b32 v103, v102, v104, v103
	v_perm_b32 v102, v103, v162, s45
	v_perm_b32 v103, v103, v162, s46
	v_lshlrev_b32_e32 v162, 4, v105
	v_cndmask_b32_e64 v149, v161, 0, vcc
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[30:31], v[102:103], v[144:147]
	v_cndmask_b32_e64 v160, v160, 0, vcc
	v_add_u32_e32 v161, 0x7f7f7f00, v149
	v_sub_u32_e32 v157, v140, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[32:33], v[102:103], v[150:153]
	v_and_b32_e32 v102, 0x7070707, v105
	v_lshrrev_b32_e32 v103, 4, v105
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v159, v158, v102
	v_perm_b32 v102, v155, v154, v102
	v_and_or_b32 v102, v104, v162, v102
	v_perm_b32 v104, v159, v158, v103
	v_perm_b32 v103, v155, v154, v103
	v_and_or_b32 v103, v104, v105, v103
	v_perm_b32 v154, v103, v102, s45
	v_perm_b32 v155, v103, v102, s46
	v_and_b32_e32 v158, 0x80808000, v161
	v_lshlrev_b32_e32 v161, 4, v99
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[26:27], v[154:155], v[144:147]
	v_sub_u32_e32 v143, v138, v143
	s_cmp_eq_u32 s12, 0
	s_cselect_b32 s24, 0x4000, 0
	v_add_u32_e32 v144, 0x7f7f7f78, v160
	v_and_b32_e32 v159, 0x80808080, v144
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[28:29], v[154:155], v[150:153]
	s_nop 2
	v_and_b32_e32 v150, 0x7070707, v90
	v_lshrrev_b32_e32 v151, 4, v90
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v159, v158, v150
	v_lshlrev_b32_e32 v153, 4, v90
	v_perm_b32 v150, v160, v149, v150
	v_and_or_b32 v152, v152, v153, v150
	v_perm_b32 v150, v159, v158, v151
	v_perm_b32 v151, v160, v149, v151
	v_and_or_b32 v90, v150, v90, v151
	v_perm_b32 v150, v90, v152, s45
	v_perm_b32 v151, v90, v152, s46
	v_and_b32_e32 v90, 0x7070707, v91
	v_lshlrev_b32_e32 v152, 4, v91
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[22:23], v[150:151], v[102:105]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[24:25], v[150:151], v[144:147]
	v_lshrrev_b32_e32 v150, 4, v91
	v_and_b32_e32 v150, 0x7070707, v150
	v_perm_b32 v151, v159, v158, v90
	v_perm_b32 v90, v160, v149, v90
	v_and_or_b32 v151, v151, v152, v90
	v_perm_b32 v90, v159, v158, v150
	v_perm_b32 v150, v160, v149, v150
	v_and_or_b32 v91, v90, v91, v150
	v_perm_b32 v90, v91, v151, s45
	v_perm_b32 v91, v91, v151, s46
	v_lshlrev_b32_e32 v151, 4, v92
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[18:19], v[90:91], v[102:105]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[20:21], v[90:91], v[144:147]
	v_and_b32_e32 v90, 0x7070707, v92
	v_lshrrev_b32_e32 v91, 4, v92
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v150, v159, v158, v90
	v_perm_b32 v90, v160, v149, v90
	v_and_or_b32 v150, v150, v151, v90
	v_perm_b32 v90, v159, v158, v91
	v_perm_b32 v91, v160, v149, v91
	v_and_or_b32 v91, v90, v92, v91
	v_perm_b32 v90, v91, v150, s45
	v_perm_b32 v91, v91, v150, s46
	v_lshlrev_b32_e32 v150, 4, v93
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[14:15], v[90:91], v[102:105]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[16:17], v[90:91], v[144:147]
	v_and_b32_e32 v90, 0x7070707, v93
	v_lshrrev_b32_e32 v91, 4, v93
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v159, v158, v90
	v_perm_b32 v90, v160, v149, v90
	v_and_or_b32 v92, v92, v150, v90
	v_perm_b32 v90, v159, v158, v91
	v_perm_b32 v91, v160, v149, v91
	v_and_or_b32 v91, v90, v93, v91
	v_perm_b32 v90, v91, v92, s45
	v_perm_b32 v91, v91, v92, s46
	v_lshrrev_b32_e32 v159, 4, v99
	v_and_b32_e32 v159, 0x7070707, v159
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[10:11], v[90:91], v[102:105]
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[12:13], v[90:91], v[144:147]
	s_nop 2
	v_sub_u32_e32 v144, v140, v156
	v_min_i32_e32 v145, 11, v144
	v_mul_lo_u32 v145, v145, s44
	v_sub_u32_e32 v146, 0x6c686080, v145
	v_and_b32_e32 v146, 0xffffff00, v146
	v_cmp_lt_i32_e32 vcc, 11, v144
	v_sub_u32_e32 v145, 0x7c787470, v145
	v_lshlrev_b32_e32 v147, 4, v98
	v_cndmask_b32_e64 v149, v146, 0, vcc
	v_cndmask_b32_e64 v154, v145, 0, vcc
	v_add_u32_e32 v144, 0x7f7f7f00, v149
	v_and_b32_e32 v155, 0x80808000, v144
	v_add_u32_e32 v144, 0x7f7f7f78, v154
	v_and_b32_e32 v156, 0x80808080, v144
	v_and_b32_e32 v144, 0x7070707, v98
	v_lshrrev_b32_e32 v145, 4, v98
	v_and_b32_e32 v145, 0x7070707, v145
	v_perm_b32 v146, v156, v155, v144
	v_perm_b32 v144, v154, v149, v144
	v_and_or_b32 v144, v146, v147, v144
	v_perm_b32 v146, v156, v155, v145
	v_perm_b32 v145, v154, v149, v145
	v_and_or_b32 v98, v146, v98, v145
	v_perm_b32 v150, v98, v144, s45
	v_perm_b32 v151, v98, v144, s46
	v_min_i32_e32 v98, 11, v157
	v_mul_lo_u32 v158, v98, s44
	v_and_b32_e32 v98, 0x7070707, v99
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[38:39], v[150:151], 0
	v_perm_b32 v160, v156, v155, v98
	v_perm_b32 v98, v154, v149, v98
	v_and_or_b32 v160, v160, v161, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[40:41], v[150:151], 0
	v_perm_b32 v98, v156, v155, v159
	v_perm_b32 v159, v154, v149, v159
	v_and_or_b32 v99, v98, v99, v159
	v_perm_b32 v98, v99, v160, s45
	v_perm_b32 v99, v99, v160, s46
	v_lshlrev_b32_e32 v161, 4, v100
	v_sub_u32_e32 v159, 0x6c686080, v158
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[34:35], v[98:99], v[144:147]
	v_and_b32_e32 v159, 0xffffff00, v159
	v_sub_u32_e32 v158, 0x7c787470, v158
	v_cmp_lt_i32_e32 vcc, 11, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[36:37], v[98:99], v[150:153]
	v_and_b32_e32 v98, 0x7070707, v100
	v_lshrrev_b32_e32 v99, 4, v100
	v_and_b32_e32 v99, 0x7070707, v99
	v_perm_b32 v160, v156, v155, v98
	v_perm_b32 v98, v154, v149, v98
	v_and_or_b32 v160, v160, v161, v98
	v_perm_b32 v98, v156, v155, v99
	v_perm_b32 v99, v154, v149, v99
	v_and_or_b32 v99, v98, v100, v99
	v_perm_b32 v98, v99, v160, s45
	v_perm_b32 v99, v99, v160, s46
	v_lshlrev_b32_e32 v160, 4, v101
	v_cndmask_b32_e64 v157, v159, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[30:31], v[98:99], v[144:147]
	v_cndmask_b32_e64 v158, v158, 0, vcc
	v_add_u32_e32 v159, 0x7f7f7f00, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[32:33], v[98:99], v[150:153]
	v_and_b32_e32 v98, 0x7070707, v101
	v_lshrrev_b32_e32 v99, 4, v101
	v_and_b32_e32 v99, 0x7070707, v99
	v_perm_b32 v100, v156, v155, v98
	v_perm_b32 v98, v154, v149, v98
	v_and_or_b32 v98, v100, v160, v98
	v_perm_b32 v100, v156, v155, v99
	v_perm_b32 v99, v154, v149, v99
	v_and_or_b32 v99, v100, v101, v99
	v_perm_b32 v154, v99, v98, s45
	v_perm_b32 v155, v99, v98, s46
	v_and_b32_e32 v149, 0x80808000, v159
	v_lshlrev_b32_e32 v160, 4, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[26:27], v[154:155], v[144:147]
	s_nop 2
	v_add_u32_e32 v144, 0x7f7f7f78, v158
	v_and_b32_e32 v156, 0x80808080, v144
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[28:29], v[154:155], v[150:153]
	s_nop 2
	v_and_b32_e32 v150, 0x7070707, v94
	v_lshrrev_b32_e32 v151, 4, v94
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v156, v149, v150
	v_lshlrev_b32_e32 v153, 4, v94
	v_perm_b32 v150, v158, v157, v150
	v_and_or_b32 v152, v152, v153, v150
	v_perm_b32 v150, v156, v149, v151
	v_perm_b32 v151, v158, v157, v151
	v_and_or_b32 v94, v150, v94, v151
	v_perm_b32 v150, v94, v152, s45
	v_perm_b32 v151, v94, v152, s46
	v_and_b32_e32 v94, 0x7070707, v95
	v_lshlrev_b32_e32 v152, 4, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[22:23], v[150:151], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[24:25], v[150:151], v[144:147]
	v_lshrrev_b32_e32 v150, 4, v95
	v_and_b32_e32 v150, 0x7070707, v150
	v_perm_b32 v151, v156, v149, v94
	v_perm_b32 v94, v158, v157, v94
	v_and_or_b32 v151, v151, v152, v94
	v_perm_b32 v94, v156, v149, v150
	v_perm_b32 v150, v158, v157, v150
	v_and_or_b32 v95, v94, v95, v150
	v_perm_b32 v94, v95, v151, s45
	v_perm_b32 v95, v95, v151, s46
	v_lshlrev_b32_e32 v151, 4, v96
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[18:19], v[94:95], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[20:21], v[94:95], v[144:147]
	v_and_b32_e32 v94, 0x7070707, v96
	v_lshrrev_b32_e32 v95, 4, v96
	v_and_b32_e32 v95, 0x7070707, v95
	v_perm_b32 v150, v156, v149, v94
	v_perm_b32 v94, v158, v157, v94
	v_and_or_b32 v150, v150, v151, v94
	v_perm_b32 v94, v156, v149, v95
	v_perm_b32 v95, v158, v157, v95
	v_and_or_b32 v95, v94, v96, v95
	v_perm_b32 v94, v95, v150, s45
	v_perm_b32 v95, v95, v150, s46
	v_lshlrev_b32_e32 v150, 4, v97
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[14:15], v[94:95], v[98:101]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[16:17], v[94:95], v[144:147]
	v_and_b32_e32 v94, 0x7070707, v97
	v_lshrrev_b32_e32 v95, 4, v97
	v_and_b32_e32 v95, 0x7070707, v95
	v_perm_b32 v96, v156, v149, v94
	v_perm_b32 v94, v158, v157, v94
	v_and_or_b32 v96, v96, v150, v94
	v_perm_b32 v94, v156, v149, v95
	v_perm_b32 v95, v158, v157, v95
	v_and_or_b32 v95, v94, v97, v95
	v_perm_b32 v94, v95, v96, s45
	v_perm_b32 v95, v95, v96, s46
	v_sub_u32_sdwa v156, v139, v148 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshrrev_b32_e32 v158, 4, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[10:11], v[94:95], v[98:101]
	v_and_b32_e32 v158, 0x7070707, v158
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[12:13], v[94:95], v[144:147]
	s_nop 2
	v_sub_u32_sdwa v144, v139, v148 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v145, 11, v144
	v_mul_lo_u32 v145, v145, s44
	v_sub_u32_e32 v146, 0x6c686080, v145
	v_and_b32_e32 v146, 0xffffff00, v146
	v_cmp_lt_i32_e32 vcc, 11, v144
	v_sub_u32_e32 v145, 0x7c787470, v145
	v_lshlrev_b32_e32 v147, 4, v86
	v_cndmask_b32_e64 v152, v146, 0, vcc
	v_cndmask_b32_e64 v153, v145, 0, vcc
	v_add_u32_e32 v144, 0x7f7f7f00, v152
	v_and_b32_e32 v154, 0x80808000, v144
	v_add_u32_e32 v144, 0x7f7f7f78, v153
	v_and_b32_e32 v155, 0x80808080, v144
	v_and_b32_e32 v144, 0x7070707, v86
	v_lshrrev_b32_e32 v145, 4, v86
	v_and_b32_e32 v145, 0x7070707, v145
	v_perm_b32 v146, v155, v154, v144
	v_perm_b32 v144, v153, v152, v144
	v_and_or_b32 v144, v146, v147, v144
	v_perm_b32 v146, v155, v154, v145
	v_perm_b32 v145, v153, v152, v145
	v_and_or_b32 v86, v146, v86, v145
	v_perm_b32 v150, v86, v144, s45
	v_perm_b32 v151, v86, v144, s46
	v_min_i32_e32 v86, 11, v156
	v_mul_lo_u32 v157, v86, s44
	v_and_b32_e32 v86, 0x7070707, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[38:39], v[150:151], 0
	v_perm_b32 v159, v155, v154, v86
	v_perm_b32 v86, v153, v152, v86
	v_and_or_b32 v159, v159, v160, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[148:151], v[40:41], v[150:151], 0
	v_perm_b32 v86, v155, v154, v158
	v_perm_b32 v158, v153, v152, v158
	v_and_or_b32 v87, v86, v87, v158
	v_perm_b32 v86, v87, v159, s45
	v_perm_b32 v87, v87, v159, s46
	v_lshlrev_b32_e32 v160, 4, v88
	v_sub_u32_e32 v158, 0x6c686080, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[34:35], v[86:87], v[144:147]
	v_and_b32_e32 v158, 0xffffff00, v158
	v_sub_u32_e32 v157, 0x7c787470, v157
	v_cmp_lt_i32_e32 vcc, 11, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[148:151], v[36:37], v[86:87], v[148:151]
	v_and_b32_e32 v86, 0x7070707, v88
	v_lshrrev_b32_e32 v87, 4, v88
	v_and_b32_e32 v87, 0x7070707, v87
	v_perm_b32 v159, v155, v154, v86
	v_perm_b32 v86, v153, v152, v86
	v_and_or_b32 v159, v159, v160, v86
	v_perm_b32 v86, v155, v154, v87
	v_perm_b32 v87, v153, v152, v87
	v_and_or_b32 v87, v86, v88, v87
	v_perm_b32 v86, v87, v159, s45
	v_perm_b32 v87, v87, v159, s46
	v_lshlrev_b32_e32 v159, 4, v89
	v_cndmask_b32_e64 v156, v158, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[30:31], v[86:87], v[144:147]
	v_cndmask_b32_e64 v157, v157, 0, vcc
	v_add_u32_e32 v158, 0x7f7f7f00, v156
	v_cmp_lt_i32_e32 vcc, 11, v143
	v_mfma_f32_16x16x32_fp8_fp8 v[148:151], v[32:33], v[86:87], v[148:151]
	v_and_b32_e32 v86, 0x7070707, v89
	v_lshrrev_b32_e32 v87, 4, v89
	v_and_b32_e32 v87, 0x7070707, v87
	v_perm_b32 v88, v155, v154, v86
	v_perm_b32 v86, v153, v152, v86
	v_and_or_b32 v86, v88, v159, v86
	v_perm_b32 v88, v155, v154, v87
	v_perm_b32 v87, v153, v152, v87
	v_and_or_b32 v87, v88, v89, v87
	v_perm_b32 v152, v87, v86, s45
	v_perm_b32 v153, v87, v86, s46
	v_and_b32_e32 v154, 0x80808000, v158
	v_lshlrev_b32_e32 v158, 4, v79
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[26:27], v[152:153], v[144:147]
	s_nop 2
	v_add_u32_e32 v144, 0x7f7f7f78, v157
	v_and_b32_e32 v155, 0x80808080, v144
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[28:29], v[152:153], v[148:151]
	s_nop 2
	v_and_b32_e32 v148, 0x7070707, v82
	v_lshrrev_b32_e32 v149, 4, v82
	v_and_b32_e32 v149, 0x7070707, v149
	v_perm_b32 v150, v155, v154, v148
	v_lshlrev_b32_e32 v151, 4, v82
	v_perm_b32 v148, v157, v156, v148
	v_and_or_b32 v150, v150, v151, v148
	v_perm_b32 v148, v155, v154, v149
	v_perm_b32 v149, v157, v156, v149
	v_and_or_b32 v82, v148, v82, v149
	v_perm_b32 v148, v82, v150, s45
	v_perm_b32 v149, v82, v150, s46
	v_and_b32_e32 v82, 0x7070707, v83
	v_lshlrev_b32_e32 v150, 4, v83
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[22:23], v[148:149], v[86:89]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[24:25], v[148:149], v[144:147]
	v_lshrrev_b32_e32 v148, 4, v83
	v_and_b32_e32 v148, 0x7070707, v148
	v_perm_b32 v149, v155, v154, v82
	v_perm_b32 v82, v157, v156, v82
	v_and_or_b32 v149, v149, v150, v82
	v_perm_b32 v82, v155, v154, v148
	v_perm_b32 v148, v157, v156, v148
	v_and_or_b32 v83, v82, v83, v148
	v_perm_b32 v82, v83, v149, s45
	v_perm_b32 v83, v83, v149, s46
	v_lshlrev_b32_e32 v149, 4, v84
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[18:19], v[82:83], v[86:89]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[20:21], v[82:83], v[144:147]
	v_and_b32_e32 v82, 0x7070707, v84
	v_lshrrev_b32_e32 v83, 4, v84
	v_and_b32_e32 v83, 0x7070707, v83
	v_perm_b32 v148, v155, v154, v82
	v_perm_b32 v82, v157, v156, v82
	v_and_or_b32 v148, v148, v149, v82
	v_perm_b32 v82, v155, v154, v83
	v_perm_b32 v83, v157, v156, v83
	v_and_or_b32 v83, v82, v84, v83
	v_perm_b32 v82, v83, v148, s45
	v_perm_b32 v83, v83, v148, s46
	v_lshlrev_b32_e32 v148, 4, v85
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[14:15], v[82:83], v[86:89]
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[16:17], v[82:83], v[144:147]
	v_and_b32_e32 v82, 0x7070707, v85
	v_lshrrev_b32_e32 v83, 4, v85
	v_and_b32_e32 v83, 0x7070707, v83
	v_perm_b32 v84, v155, v154, v82
	v_perm_b32 v82, v157, v156, v82
	v_and_or_b32 v84, v84, v148, v82
	v_perm_b32 v82, v155, v154, v83
	v_perm_b32 v83, v157, v156, v83
	v_and_or_b32 v83, v82, v85, v83
	v_perm_b32 v82, v83, v84, s45
	v_perm_b32 v83, v83, v84, s46
	v_sub_u32_e32 v156, v138, v142
	v_lshrrev_b32_e32 v142, 4, v79
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[10:11], v[82:83], v[86:89]
	v_and_b32_e32 v142, 0x7070707, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[12:13], v[82:83], v[144:147]
	s_nop 2
	v_min_i32_e32 v144, 11, v143
	v_mul_lo_u32 v144, v144, s44
	v_sub_u32_e32 v145, 0x6c686080, v144
	v_and_b32_e32 v145, 0xffffff00, v145
	v_sub_u32_e32 v144, 0x7c787470, v144
	v_cndmask_b32_e64 v152, v145, 0, vcc
	v_cndmask_b32_e64 v153, v144, 0, vcc
	v_add_u32_e32 v143, 0x7f7f7f00, v152
	v_and_b32_e32 v154, 0x80808000, v143
	v_add_u32_e32 v143, 0x7f7f7f78, v153
	v_and_b32_e32 v155, 0x80808080, v143
	v_and_b32_e32 v143, 0x7070707, v78
	v_lshrrev_b32_e32 v144, 4, v78
	v_and_b32_e32 v144, 0x7070707, v144
	v_perm_b32 v145, v155, v154, v143
	v_lshlrev_b32_e32 v146, 4, v78
	v_perm_b32 v143, v153, v152, v143
	v_and_or_b32 v143, v145, v146, v143
	v_perm_b32 v145, v155, v154, v144
	v_perm_b32 v144, v153, v152, v144
	v_and_or_b32 v78, v145, v78, v144
	v_perm_b32 v148, v78, v143, s45
	v_perm_b32 v149, v78, v143, s46
	v_min_i32_e32 v78, 11, v156
	v_mul_lo_u32 v157, v78, s44
	v_and_b32_e32 v78, 0x7070707, v79
	v_mfma_f32_16x16x32_fp8_fp8 v[144:147], v[38:39], v[148:149], 0
	v_perm_b32 v143, v155, v154, v78
	v_perm_b32 v78, v153, v152, v78
	v_and_or_b32 v143, v143, v158, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[148:151], v[40:41], v[148:149], 0
	v_perm_b32 v78, v155, v154, v142
	v_perm_b32 v142, v153, v152, v142
	v_and_or_b32 v79, v78, v79, v142
	v_perm_b32 v78, v79, v143, s45
	v_perm_b32 v79, v79, v143, s46
	v_cmp_lt_i32_e32 vcc, 11, v156
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[34:35], v[78:79], v[144:147]
	s_nop 2
	v_sub_u32_e32 v146, 0x6c686080, v157
	v_and_b32_e32 v158, 0xffffff00, v146
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[36:37], v[78:79], v[148:151]
	v_and_b32_e32 v78, 0x7070707, v80
	v_lshrrev_b32_e32 v79, 4, v80
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v150, v155, v154, v78
	v_lshlrev_b32_e32 v151, 4, v80
	v_perm_b32 v78, v153, v152, v78
	v_and_or_b32 v150, v150, v151, v78
	v_perm_b32 v78, v155, v154, v79
	v_perm_b32 v79, v153, v152, v79
	v_and_or_b32 v79, v78, v80, v79
	v_perm_b32 v78, v79, v150, s45
	v_perm_b32 v79, v79, v150, s46
	v_lshlrev_b32_e32 v150, 4, v81
	v_sub_u32_e32 v157, 0x7c787470, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[30:31], v[78:79], v[142:145]
	v_cndmask_b32_e64 v156, v158, 0, vcc
	v_cndmask_b32_e64 v157, v157, 0, vcc
	v_add_u32_e32 v158, 0x7f7f7f00, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[32:33], v[78:79], v[146:149]
	v_and_b32_e32 v78, 0x7070707, v81
	v_lshrrev_b32_e32 v79, 4, v81
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v155, v154, v78
	v_perm_b32 v78, v153, v152, v78
	v_and_or_b32 v78, v80, v150, v78
	v_perm_b32 v80, v155, v154, v79
	v_perm_b32 v79, v153, v152, v79
	v_and_or_b32 v79, v80, v81, v79
	v_perm_b32 v150, v79, v78, s45
	v_perm_b32 v151, v79, v78, s46
	v_and_b32_e32 v152, 0x80808000, v158
	v_cmp_lt_i32_e32 vcc, 5, v141
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[26:27], v[150:151], v[142:145]
	s_nop 2
	v_add_u32_e32 v142, 0x7f7f7f78, v157
	v_and_b32_e32 v153, 0x80808080, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[28:29], v[150:151], v[146:149]
	s_nop 2
	v_and_b32_e32 v146, 0x7070707, v74
	v_lshrrev_b32_e32 v147, 4, v74
	v_and_b32_e32 v147, 0x7070707, v147
	v_perm_b32 v148, v153, v152, v146
	v_lshlrev_b32_e32 v149, 4, v74
	v_perm_b32 v146, v157, v156, v146
	v_and_or_b32 v148, v148, v149, v146
	v_perm_b32 v146, v153, v152, v147
	v_perm_b32 v147, v157, v156, v147
	v_and_or_b32 v74, v146, v74, v147
	v_perm_b32 v146, v74, v148, s45
	v_perm_b32 v147, v74, v148, s46
	v_and_b32_e32 v74, 0x7070707, v75
	v_lshlrev_b32_e32 v148, 4, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[22:23], v[146:147], v[78:81]
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[24:25], v[146:147], v[142:145]
	v_lshrrev_b32_e32 v146, 4, v75
	v_and_b32_e32 v146, 0x7070707, v146
	v_perm_b32 v147, v153, v152, v74
	v_perm_b32 v74, v157, v156, v74
	v_and_or_b32 v147, v147, v148, v74
	v_perm_b32 v74, v153, v152, v146
	v_perm_b32 v146, v157, v156, v146
	v_and_or_b32 v75, v74, v75, v146
	v_perm_b32 v74, v75, v147, s45
	v_perm_b32 v75, v75, v147, s46
	v_lshlrev_b32_e32 v147, 4, v76
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[18:19], v[74:75], v[78:81]
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[20:21], v[74:75], v[142:145]
	v_and_b32_e32 v74, 0x7070707, v76
	v_lshrrev_b32_e32 v75, 4, v76
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v146, v153, v152, v74
	v_perm_b32 v74, v157, v156, v74
	v_and_or_b32 v146, v146, v147, v74
	v_perm_b32 v74, v153, v152, v75
	v_perm_b32 v75, v157, v156, v75
	v_and_or_b32 v75, v74, v76, v75
	v_perm_b32 v74, v75, v146, s45
	v_perm_b32 v75, v75, v146, s46
	v_lshlrev_b32_e32 v146, 4, v77
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[14:15], v[74:75], v[78:81]
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[16:17], v[74:75], v[142:145]
	v_and_b32_e32 v74, 0x7070707, v77
	v_lshrrev_b32_e32 v75, 4, v77
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v153, v152, v74
	v_perm_b32 v74, v157, v156, v74
	v_and_or_b32 v76, v76, v146, v74
	v_perm_b32 v74, v153, v152, v75
	v_perm_b32 v75, v157, v156, v75
	v_and_or_b32 v75, v74, v77, v75
	v_perm_b32 v74, v75, v76, s45
	v_perm_b32 v75, v75, v76, s46
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[10:11], v[74:75], v[78:81]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[12:13], v[74:75], v[142:145]
	s_nop 2
	v_add_u32_e32 v143, 17, v141
	v_lshl_add_u32 v142, v141, 23, v115
	v_lshlrev_b32_e64 v143, v143, 1
	v_cndmask_b32_e32 v142, v143, v142, vcc
	v_add_u32_e32 v143, 17, v140
	v_lshl_add_u32 v141, v140, 23, v115
	v_lshlrev_b32_e64 v143, v143, 1
	v_cmp_lt_i32_e32 vcc, 5, v140
	s_nop 1
	v_cndmask_b32_e32 v140, v143, v141, vcc
	v_add_u32_e32 v143, 17, v139
	v_lshl_add_u32 v141, v139, 23, v115
	v_lshlrev_b32_e64 v143, v143, 1
	v_cmp_lt_i32_e32 vcc, 5, v139
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[148:149], v[8:9], v[142:143] op_sel_hi:[1,0]
	v_lshl_add_u32 v139, v138, 23, v115
	v_cndmask_b32_e32 v144, v143, v141, vcc
	v_add_u32_e32 v141, 17, v138
	v_pk_mul_f32 v[104:105], v[148:149], v[104:105]
	v_lshlrev_b32_e64 v141, v141, 1
	v_cmp_lt_i32_e32 vcc, 5, v138
	v_pk_mul_f32 v[104:105], v[104:105], v[112:113]
	v_pk_mul_f32 v[146:147], v[6:7], v[142:143] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v138, v141, v139, vcc
	v_bfe_u32 v139, v105, 16, 1
	v_add3_u32 v139, v139, v105, s47
	v_or_b32_e32 v141, 0x400000, v105
	v_cmp_u_f32_e32 vcc, v105, v105
	v_pk_mul_f32 v[102:103], v[146:147], v[102:103]
	s_nop 0
	v_cndmask_b32_e32 v105, v139, v141, vcc
	v_bfe_u32 v139, v104, 16, 1
	v_pk_mul_f32 v[102:103], v[102:103], v[110:111]
	v_add3_u32 v139, v139, v104, s47
	v_or_b32_e32 v141, 0x400000, v104
	v_cmp_u_f32_e32 vcc, v104, v104
	s_nop 1
	v_cndmask_b32_e32 v104, v139, v141, vcc
	v_bfe_u32 v139, v103, 16, 1
	v_add3_u32 v139, v139, v103, s47
	v_or_b32_e32 v141, 0x400000, v103
	v_cmp_u_f32_e32 vcc, v103, v103
	s_nop 1
	v_cndmask_b32_e32 v103, v139, v141, vcc
	v_bfe_u32 v139, v102, 16, 1
	v_add3_u32 v139, v139, v102, s47
	v_or_b32_e32 v141, 0x400000, v102
	v_cmp_u_f32_e32 vcc, v102, v102
	s_nop 1
	v_cndmask_b32_e32 v102, v139, v141, vcc
	v_lshl_add_u32 v139, v116, 1, s24
	ds_write_b16_d16_hi v139, v102
	ds_write_b16_d16_hi v139, v103 offset:512
	ds_write_b16_d16_hi v139, v104 offset:1024
	ds_write_b16_d16_hi v139, v105 offset:1536
	v_pk_mul_f32 v[104:105], v[8:9], v[140:141] op_sel_hi:[1,0]
	v_pk_mul_f32 v[102:103], v[6:7], v[140:141] op_sel_hi:[1,0]
	v_pk_mul_f32 v[100:101], v[104:105], v[100:101]
	v_pk_mul_f32 v[98:99], v[102:103], v[98:99]
	v_pk_mul_f32 v[100:101], v[100:101], v[112:113]
	v_pk_mul_f32 v[98:99], v[98:99], v[110:111]
	v_bfe_u32 v102, v101, 16, 1
	v_add3_u32 v102, v102, v101, s47
	v_or_b32_e32 v103, 0x400000, v101
	v_cmp_u_f32_e32 vcc, v101, v101
	s_nop 1
	v_cndmask_b32_e32 v101, v102, v103, vcc
	v_bfe_u32 v102, v100, 16, 1
	v_add3_u32 v102, v102, v100, s47
	v_or_b32_e32 v103, 0x400000, v100
	v_cmp_u_f32_e32 vcc, v100, v100
	s_nop 1
	v_cndmask_b32_e32 v100, v102, v103, vcc
	v_bfe_u32 v102, v99, 16, 1
	v_add3_u32 v102, v102, v99, s47
	v_or_b32_e32 v103, 0x400000, v99
	v_cmp_u_f32_e32 vcc, v99, v99
	s_nop 1
	v_cndmask_b32_e32 v99, v102, v103, vcc
	v_bfe_u32 v102, v98, 16, 1
	v_add3_u32 v102, v102, v98, s47
	v_or_b32_e32 v103, 0x400000, v98
	v_cmp_u_f32_e32 vcc, v98, v98
	s_nop 1
	v_cndmask_b32_e32 v98, v102, v103, vcc
	ds_write_b16_d16_hi v139, v98 offset:32
	ds_write_b16_d16_hi v139, v99 offset:544
	ds_write_b16_d16_hi v139, v100 offset:1056
	ds_write_b16_d16_hi v139, v101 offset:1568
	v_pk_mul_f32 v[100:101], v[8:9], v[144:145] op_sel_hi:[1,0]
	v_pk_mul_f32 v[98:99], v[6:7], v[144:145] op_sel_hi:[1,0]
	v_pk_mul_f32 v[88:89], v[100:101], v[88:89]
	v_pk_mul_f32 v[86:87], v[98:99], v[86:87]
	v_pk_mul_f32 v[88:89], v[88:89], v[112:113]
	v_pk_mul_f32 v[86:87], v[86:87], v[110:111]
	v_bfe_u32 v98, v89, 16, 1
	v_add3_u32 v98, v98, v89, s47
	v_or_b32_e32 v99, 0x400000, v89
	v_cmp_u_f32_e32 vcc, v89, v89
	s_nop 1
	v_cndmask_b32_e32 v89, v98, v99, vcc
	v_bfe_u32 v98, v88, 16, 1
	v_add3_u32 v98, v98, v88, s47
	v_or_b32_e32 v99, 0x400000, v88
	v_cmp_u_f32_e32 vcc, v88, v88
	s_nop 1
	v_cndmask_b32_e32 v88, v98, v99, vcc
	v_bfe_u32 v98, v87, 16, 1
	v_add3_u32 v98, v98, v87, s47
	v_or_b32_e32 v99, 0x400000, v87
	v_cmp_u_f32_e32 vcc, v87, v87
	s_nop 1
	v_cndmask_b32_e32 v87, v98, v99, vcc
	v_bfe_u32 v98, v86, 16, 1
	v_add3_u32 v98, v98, v86, s47
	v_or_b32_e32 v99, 0x400000, v86
	v_cmp_u_f32_e32 vcc, v86, v86
	s_nop 1
	v_cndmask_b32_e32 v86, v98, v99, vcc
	ds_write_b16_d16_hi v139, v86 offset:64
	ds_write_b16_d16_hi v139, v87 offset:576
	ds_write_b16_d16_hi v139, v88 offset:1088
	ds_write_b16_d16_hi v139, v89 offset:1600
	v_pk_mul_f32 v[88:89], v[8:9], v[138:139] op_sel_hi:[1,0]
	v_pk_mul_f32 v[86:87], v[6:7], v[138:139] op_sel_hi:[1,0]
	v_pk_mul_f32 v[80:81], v[88:89], v[80:81]
	v_pk_mul_f32 v[78:79], v[86:87], v[78:79]
	v_pk_mul_f32 v[80:81], v[80:81], v[112:113]
	v_pk_mul_f32 v[78:79], v[78:79], v[110:111]
	v_bfe_u32 v86, v81, 16, 1
	v_add3_u32 v86, v86, v81, s47
	v_or_b32_e32 v87, 0x400000, v81
	v_cmp_u_f32_e32 vcc, v81, v81
	s_nop 1
	v_cndmask_b32_e32 v81, v86, v87, vcc
	v_bfe_u32 v86, v80, 16, 1
	v_add3_u32 v86, v86, v80, s47
	v_or_b32_e32 v87, 0x400000, v80
	v_cmp_u_f32_e32 vcc, v80, v80
	s_nop 1
	v_cndmask_b32_e32 v80, v86, v87, vcc
	v_bfe_u32 v86, v79, 16, 1
	v_add3_u32 v86, v86, v79, s47
	v_or_b32_e32 v87, 0x400000, v79
	v_cmp_u_f32_e32 vcc, v79, v79
	s_nop 1
	v_cndmask_b32_e32 v79, v86, v87, vcc
	v_bfe_u32 v86, v78, 16, 1
	v_add3_u32 v86, v86, v78, s47
	v_or_b32_e32 v87, 0x400000, v78
	v_cmp_u_f32_e32 vcc, v78, v78
	s_nop 1
	v_cndmask_b32_e32 v78, v86, v87, vcc
	ds_write_b16_d16_hi v139, v78 offset:96
	ds_write_b16_d16_hi v139, v79 offset:608
	ds_write_b16_d16_hi v139, v80 offset:1120
	ds_write_b16_d16_hi v139, v81 offset:1632
	s_waitcnt lgkmcnt(14)
	v_pk_mul_f32 v[80:81], v[4:5], v[142:143] op_sel_hi:[1,0]
	v_pk_mul_f32 v[78:79], v[2:3], v[142:143] op_sel_hi:[1,0]
	v_pk_mul_f32 v[80:81], v[80:81], v[92:93]
	v_pk_mul_f32 v[78:79], v[78:79], v[90:91]
	v_pk_mul_f32 v[80:81], v[80:81], v[108:109]
	v_pk_mul_f32 v[78:79], v[78:79], v[106:107]
	v_bfe_u32 v86, v81, 16, 1
	v_add3_u32 v86, v86, v81, s47
	v_or_b32_e32 v87, 0x400000, v81
	v_cmp_u_f32_e32 vcc, v81, v81
	s_nop 1
	v_cndmask_b32_e32 v81, v86, v87, vcc
	v_bfe_u32 v86, v80, 16, 1
	v_add3_u32 v86, v86, v80, s47
	v_or_b32_e32 v87, 0x400000, v80
	v_cmp_u_f32_e32 vcc, v80, v80
	s_nop 1
	v_cndmask_b32_e32 v80, v86, v87, vcc
	v_bfe_u32 v86, v79, 16, 1
	v_add3_u32 v86, v86, v79, s47
	v_or_b32_e32 v87, 0x400000, v79
	v_cmp_u_f32_e32 vcc, v79, v79
	s_nop 1
	v_cndmask_b32_e32 v79, v86, v87, vcc
	v_bfe_u32 v86, v78, 16, 1
	v_add3_u32 v86, v86, v78, s47
	v_or_b32_e32 v87, 0x400000, v78
	v_cmp_u_f32_e32 vcc, v78, v78
	s_nop 1
	v_cndmask_b32_e32 v78, v86, v87, vcc
	ds_write_b16_d16_hi v139, v78 offset:8192
	ds_write_b16_d16_hi v139, v79 offset:8704
	ds_write_b16_d16_hi v139, v80 offset:9216
	ds_write_b16_d16_hi v139, v81 offset:9728
	v_pk_mul_f32 v[80:81], v[4:5], v[140:141] op_sel_hi:[1,0]
	v_pk_mul_f32 v[78:79], v[2:3], v[140:141] op_sel_hi:[1,0]
	v_pk_mul_f32 v[80:81], v[80:81], v[96:97]
	v_pk_mul_f32 v[78:79], v[78:79], v[94:95]
	v_pk_mul_f32 v[80:81], v[80:81], v[108:109]
	v_pk_mul_f32 v[78:79], v[78:79], v[106:107]
	v_bfe_u32 v86, v81, 16, 1
	v_add3_u32 v86, v86, v81, s47
	v_or_b32_e32 v87, 0x400000, v81
	v_cmp_u_f32_e32 vcc, v81, v81
	s_nop 1
	v_cndmask_b32_e32 v81, v86, v87, vcc
	v_bfe_u32 v86, v80, 16, 1
	v_add3_u32 v86, v86, v80, s47
	v_or_b32_e32 v87, 0x400000, v80
	v_cmp_u_f32_e32 vcc, v80, v80
	s_nop 1
	v_cndmask_b32_e32 v80, v86, v87, vcc
	v_bfe_u32 v86, v79, 16, 1
	v_add3_u32 v86, v86, v79, s47
	v_or_b32_e32 v87, 0x400000, v79
	v_cmp_u_f32_e32 vcc, v79, v79
	s_nop 1
	v_cndmask_b32_e32 v79, v86, v87, vcc
	v_bfe_u32 v86, v78, 16, 1
	v_add3_u32 v86, v86, v78, s47
	v_or_b32_e32 v87, 0x400000, v78
	v_cmp_u_f32_e32 vcc, v78, v78
	s_nop 1
	v_cndmask_b32_e32 v78, v86, v87, vcc
	ds_write_b16_d16_hi v139, v78 offset:8224
	ds_write_b16_d16_hi v139, v79 offset:8736
	ds_write_b16_d16_hi v139, v80 offset:9248
	ds_write_b16_d16_hi v139, v81 offset:9760
	v_pk_mul_f32 v[80:81], v[4:5], v[144:145] op_sel_hi:[1,0]
	v_pk_mul_f32 v[78:79], v[2:3], v[144:145] op_sel_hi:[1,0]
	v_pk_mul_f32 v[80:81], v[80:81], v[84:85]
	v_pk_mul_f32 v[78:79], v[78:79], v[82:83]
	v_pk_mul_f32 v[80:81], v[80:81], v[108:109]
	v_pk_mul_f32 v[78:79], v[78:79], v[106:107]
	v_bfe_u32 v82, v81, 16, 1
	v_add3_u32 v82, v82, v81, s47
	v_or_b32_e32 v83, 0x400000, v81
	v_cmp_u_f32_e32 vcc, v81, v81
	s_nop 1
	v_cndmask_b32_e32 v81, v82, v83, vcc
	v_bfe_u32 v82, v80, 16, 1
	v_add3_u32 v82, v82, v80, s47
	v_or_b32_e32 v83, 0x400000, v80
	v_cmp_u_f32_e32 vcc, v80, v80
	s_nop 1
	v_cndmask_b32_e32 v80, v82, v83, vcc
	v_bfe_u32 v82, v79, 16, 1
	v_add3_u32 v82, v82, v79, s47
	v_or_b32_e32 v83, 0x400000, v79
	v_cmp_u_f32_e32 vcc, v79, v79
	s_nop 1
	v_cndmask_b32_e32 v79, v82, v83, vcc
	v_bfe_u32 v82, v78, 16, 1
	v_add3_u32 v82, v82, v78, s47
	v_or_b32_e32 v83, 0x400000, v78
	v_cmp_u_f32_e32 vcc, v78, v78
	s_nop 1
	v_cndmask_b32_e32 v78, v82, v83, vcc
	ds_write_b16_d16_hi v139, v78 offset:8256
	ds_write_b16_d16_hi v139, v79 offset:8768
	ds_write_b16_d16_hi v139, v80 offset:9280
	ds_write_b16_d16_hi v139, v81 offset:9792
	v_pk_mul_f32 v[80:81], v[4:5], v[138:139] op_sel_hi:[1,0]
	v_pk_mul_f32 v[78:79], v[2:3], v[138:139] op_sel_hi:[1,0]
	v_pk_mul_f32 v[76:77], v[80:81], v[76:77]
	v_pk_mul_f32 v[74:75], v[78:79], v[74:75]
	v_pk_mul_f32 v[76:77], v[76:77], v[108:109]
	v_pk_mul_f32 v[74:75], v[74:75], v[106:107]
	v_bfe_u32 v78, v77, 16, 1
	v_add3_u32 v78, v78, v77, s47
	v_or_b32_e32 v79, 0x400000, v77
	v_cmp_u_f32_e32 vcc, v77, v77
	s_nop 1
	v_cndmask_b32_e32 v77, v78, v79, vcc
	v_bfe_u32 v78, v76, 16, 1
	v_add3_u32 v78, v78, v76, s47
	v_or_b32_e32 v79, 0x400000, v76
	v_cmp_u_f32_e32 vcc, v76, v76
	s_nop 1
	v_cndmask_b32_e32 v76, v78, v79, vcc
	v_bfe_u32 v78, v75, 16, 1
	v_add3_u32 v78, v78, v75, s47
	v_or_b32_e32 v79, 0x400000, v75
	v_cmp_u_f32_e32 vcc, v75, v75
	s_nop 1
	v_cndmask_b32_e32 v75, v78, v79, vcc
	v_bfe_u32 v78, v74, 16, 1
	v_add3_u32 v78, v78, v74, s47
	v_or_b32_e32 v79, 0x400000, v74
	v_cmp_u_f32_e32 vcc, v74, v74
	s_nop 1
	v_cndmask_b32_e32 v74, v78, v79, vcc
	ds_write_b16_d16_hi v139, v74 offset:8288
	ds_write_b16_d16_hi v139, v75 offset:8800
	ds_write_b16_d16_hi v139, v76 offset:9312
	ds_write_b16_d16_hi v139, v77 offset:9824
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v74, v124, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v75, 0xffffff, v74
	v_cmp_gt_i32_e32 vcc, s33, v75
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_7
	v_add3_u32 v76, s24, v125, v117
	ds_read_b32 v77, v76
	v_lshl_add_u32 v74, v74, 13, v133
	v_ashrrev_i32_e32 v75, 31, v74
	v_lshl_add_u64 v[74:75], s[34:35], 0, v[74:75]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off
	ds_read_b32 v77, v76 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:128
	ds_read_b32 v77, v76 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:256
	ds_read_b32 v76, v76 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v76, off offset:384
.LBB0_7:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v74, v122, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v75, 0xffffff, v74
	v_cmp_gt_i32_e32 vcc, s33, v75
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_9
	v_add3_u32 v76, s24, v123, v117
	ds_read_b32 v77, v76
	v_lshl_add_u32 v74, v74, 13, v133
	v_ashrrev_i32_e32 v75, 31, v74
	v_lshl_add_u64 v[74:75], s[34:35], 0, v[74:75]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off
	ds_read_b32 v77, v76 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:128
	ds_read_b32 v77, v76 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:256
	ds_read_b32 v76, v76 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v76, off offset:384
.LBB0_9:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v74, v121, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v75, 0xffffff, v74
	v_cmp_gt_i32_e32 vcc, s33, v75
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_11
	v_add3_u32 v76, s24, v120, v117
	ds_read_b32 v77, v76
	v_lshl_add_u32 v74, v74, 13, v133
	v_ashrrev_i32_e32 v75, 31, v74
	v_lshl_add_u64 v[74:75], s[34:35], 0, v[74:75]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off
	ds_read_b32 v77, v76 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:128
	ds_read_b32 v77, v76 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:256
	ds_read_b32 v76, v76 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v76, off offset:384
.LBB0_11:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v74, v119, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v75, 0xffffff, v74
	v_cmp_gt_i32_e32 vcc, s33, v75
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_4
	v_add3_u32 v76, s24, v118, v117
	ds_read_b32 v77, v76
	v_lshl_add_u32 v74, v74, 13, v133
	v_ashrrev_i32_e32 v75, 31, v74
	v_lshl_add_u64 v[74:75], s[34:35], 0, v[74:75]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off
	ds_read_b32 v77, v76 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:128
	ds_read_b32 v77, v76 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v77, off offset:256
	ds_read_b32 v76, v76 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[74:75], v76, off offset:384
	s_branch .LBB0_4
.LBB0_13:
	v_sub_u32_sdwa v74, v127, v137 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v75, 11, v74
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v75, v75, s2
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_lshlrev_b32_e32 v77, 4, v70
	v_cndmask_b32_e64 v82, v76, 0, vcc
	v_cndmask_b32_e64 v83, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v82
	v_and_b32_e32 v84, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v83
	v_and_b32_e32 v85, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v70
	v_lshrrev_b32_e32 v75, 4, v70
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v85, v84, v74
	v_perm_b32 v74, v83, v82, v74
	v_and_or_b32 v74, v76, v77, v74
	v_perm_b32 v76, v85, v84, v75
	v_perm_b32 v75, v83, v82, v75
	v_and_or_b32 v70, v76, v70, v75
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_sub_u32_sdwa v86, v127, v137 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v78, v70, v74, s0
	v_perm_b32 v79, v70, v74, s1
	v_min_i32_e32 v70, 11, v86
	v_mul_lo_u32 v87, v70, s2
	v_and_b32_e32 v70, 0x7070707, v71
	v_lshrrev_b32_e32 v88, 4, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[38:39], v[78:79], 0
	v_and_b32_e32 v88, 0x7070707, v88
	v_perm_b32 v89, v85, v84, v70
	v_lshlrev_b32_e32 v90, 4, v71
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[40:41], v[78:79], 0
	v_perm_b32 v70, v83, v82, v70
	v_and_or_b32 v89, v89, v90, v70
	v_perm_b32 v70, v85, v84, v88
	v_perm_b32 v88, v83, v82, v88
	v_and_or_b32 v71, v70, v71, v88
	v_perm_b32 v70, v71, v89, s0
	v_perm_b32 v71, v71, v89, s1
	v_lshlrev_b32_e32 v90, 4, v72
	v_sub_u32_e32 v88, 0x6c686080, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[34:35], v[70:71], v[74:77]
	v_and_b32_e32 v88, 0xffffff00, v88
	v_sub_u32_e32 v87, 0x7c787470, v87
	v_cmp_lt_i32_e32 vcc, 11, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[36:37], v[70:71], v[78:81]
	v_and_b32_e32 v70, 0x7070707, v72
	v_lshrrev_b32_e32 v71, 4, v72
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v89, v85, v84, v70
	v_perm_b32 v70, v83, v82, v70
	v_and_or_b32 v89, v89, v90, v70
	v_perm_b32 v70, v85, v84, v71
	v_perm_b32 v71, v83, v82, v71
	v_and_or_b32 v71, v70, v72, v71
	v_perm_b32 v70, v71, v89, s0
	v_perm_b32 v71, v71, v89, s1
	v_lshlrev_b32_e32 v89, 4, v73
	v_cndmask_b32_e64 v86, v88, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[30:31], v[70:71], v[74:77]
	v_cndmask_b32_e64 v87, v87, 0, vcc
	v_add_u32_e32 v88, 0x7f7f7f00, v86
	s_add_i32 s3, s15, 0xf01
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[32:33], v[70:71], v[78:81]
	v_and_b32_e32 v70, 0x7070707, v73
	v_lshrrev_b32_e32 v71, 4, v73
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v85, v84, v70
	v_perm_b32 v70, v83, v82, v70
	v_and_or_b32 v70, v72, v89, v70
	v_perm_b32 v72, v85, v84, v71
	v_perm_b32 v71, v83, v82, v71
	v_and_or_b32 v71, v72, v73, v71
	v_perm_b32 v82, v71, v70, s0
	v_perm_b32 v83, v71, v70, s1
	v_and_b32_e32 v84, 0x80808000, v88
	s_lshr_b32 s4, s3, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[26:27], v[82:83], v[74:77]
	s_add_i32 s4, s3, s4
	s_and_b32 s4, s4, 0x1ffffffe
	s_sub_i32 s3, s3, s4
	v_add_u32_e32 v74, 0x7f7f7f78, v87
	v_and_b32_e32 v85, 0x80808080, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[28:29], v[82:83], v[78:81]
	s_lshl_b32 s3, s3, 3
	s_add_i32 s4, s3, 16
	v_lshrrev_b32_e32 v88, 4, v63
	v_and_b32_e32 v78, 0x7070707, v66
	v_lshrrev_b32_e32 v79, 4, v66
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v85, v84, v78
	v_lshlrev_b32_e32 v81, 4, v66
	v_perm_b32 v78, v87, v86, v78
	v_and_or_b32 v80, v80, v81, v78
	v_perm_b32 v78, v85, v84, v79
	v_perm_b32 v79, v87, v86, v79
	v_and_or_b32 v66, v78, v66, v79
	v_perm_b32 v78, v66, v80, s0
	v_perm_b32 v79, v66, v80, s1
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshlrev_b32_e32 v80, 4, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[22:23], v[78:79], v[70:73]
	v_and_b32_e32 v88, 0x7070707, v88
	v_lshlrev_b32_e32 v90, 4, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[24:25], v[78:79], v[74:77]
	v_lshrrev_b32_e32 v78, 4, v67
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v85, v84, v66
	v_perm_b32 v66, v87, v86, v66
	v_and_or_b32 v79, v79, v80, v66
	v_perm_b32 v66, v85, v84, v78
	v_perm_b32 v78, v87, v86, v78
	v_and_or_b32 v67, v66, v67, v78
	v_perm_b32 v66, v67, v79, s0
	v_perm_b32 v67, v67, v79, s1
	v_lshlrev_b32_e32 v79, 4, v68
	v_bfe_u32 v80, v130, s4, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[18:19], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[20:21], v[66:67], v[74:77]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v78, v85, v84, v66
	v_perm_b32 v66, v87, v86, v66
	v_and_or_b32 v78, v78, v79, v66
	v_perm_b32 v66, v85, v84, v67
	v_perm_b32 v67, v87, v86, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v78, s0
	v_perm_b32 v67, v67, v78, s1
	v_lshlrev_b32_e32 v78, 4, v69
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[14:15], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[16:17], v[66:67], v[74:77]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v68, v85, v84, v66
	v_perm_b32 v66, v87, v86, v66
	v_and_or_b32 v68, v68, v78, v66
	v_perm_b32 v66, v85, v84, v67
	v_perm_b32 v67, v87, v86, v67
	v_and_or_b32 v67, v66, v69, v67
	v_perm_b32 v66, v67, v68, s0
	v_perm_b32 v67, v67, v68, s1
	v_bfe_u32 v78, v130, s3, 8
	v_sub_u32_e32 v86, v126, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[10:11], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[12:13], v[66:67], v[74:77]
	s_nop 2
	v_sub_u32_e32 v74, v126, v78
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s2
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_lshlrev_b32_e32 v77, 4, v62
	v_cndmask_b32_e64 v82, v76, 0, vcc
	v_cndmask_b32_e64 v83, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v82
	v_and_b32_e32 v84, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v83
	v_and_b32_e32 v85, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v62
	v_lshrrev_b32_e32 v75, 4, v62
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v85, v84, v74
	v_perm_b32 v74, v83, v82, v74
	v_and_or_b32 v74, v76, v77, v74
	v_perm_b32 v76, v85, v84, v75
	v_perm_b32 v75, v83, v82, v75
	v_and_or_b32 v62, v76, v62, v75
	v_perm_b32 v78, v62, v74, s0
	v_perm_b32 v79, v62, v74, s1
	v_min_i32_e32 v62, 11, v86
	v_mul_lo_u32 v87, v62, s2
	v_and_b32_e32 v62, 0x7070707, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[38:39], v[78:79], 0
	v_perm_b32 v89, v85, v84, v62
	v_perm_b32 v62, v83, v82, v62
	v_and_or_b32 v89, v89, v90, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[40:41], v[78:79], 0
	v_perm_b32 v62, v85, v84, v88
	v_perm_b32 v88, v83, v82, v88
	v_and_or_b32 v63, v62, v63, v88
	v_perm_b32 v62, v63, v89, s0
	v_perm_b32 v63, v63, v89, s1
	v_lshlrev_b32_e32 v90, 4, v64
	v_sub_u32_e32 v88, 0x6c686080, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[34:35], v[62:63], v[74:77]
	v_and_b32_e32 v88, 0xffffff00, v88
	v_sub_u32_e32 v87, 0x7c787470, v87
	v_cmp_lt_i32_e32 vcc, 11, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[36:37], v[62:63], v[78:81]
	v_and_b32_e32 v62, 0x7070707, v64
	v_lshrrev_b32_e32 v63, 4, v64
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v89, v85, v84, v62
	v_perm_b32 v62, v83, v82, v62
	v_and_or_b32 v89, v89, v90, v62
	v_perm_b32 v62, v85, v84, v63
	v_perm_b32 v63, v83, v82, v63
	v_and_or_b32 v63, v62, v64, v63
	v_perm_b32 v62, v63, v89, s0
	v_perm_b32 v63, v63, v89, s1
	v_lshlrev_b32_e32 v89, 4, v65
	v_cndmask_b32_e64 v86, v88, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[30:31], v[62:63], v[74:77]
	v_cndmask_b32_e64 v87, v87, 0, vcc
	v_add_u32_e32 v88, 0x7f7f7f00, v86
	v_lshlrev_b32_e32 v90, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[32:33], v[62:63], v[78:81]
	v_and_b32_e32 v62, 0x7070707, v65
	v_lshrrev_b32_e32 v63, 4, v65
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v85, v84, v62
	v_perm_b32 v62, v83, v82, v62
	v_and_or_b32 v62, v64, v89, v62
	v_perm_b32 v64, v85, v84, v63
	v_perm_b32 v63, v83, v82, v63
	v_and_or_b32 v63, v64, v65, v63
	v_perm_b32 v82, v63, v62, s0
	v_perm_b32 v83, v63, v62, s1
	v_and_b32_e32 v84, 0x80808000, v88
	v_lshrrev_b32_e32 v88, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[82:83], v[74:77]
	v_and_b32_e32 v88, 0x7070707, v88
	s_nop 1
	v_add_u32_e32 v74, 0x7f7f7f78, v87
	v_and_b32_e32 v85, 0x80808080, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[28:29], v[82:83], v[78:81]
	s_nop 2
	v_and_b32_e32 v78, 0x7070707, v58
	v_lshrrev_b32_e32 v79, 4, v58
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v85, v84, v78
	v_lshlrev_b32_e32 v81, 4, v58
	v_perm_b32 v78, v87, v86, v78
	v_and_or_b32 v80, v80, v81, v78
	v_perm_b32 v78, v85, v84, v79
	v_perm_b32 v79, v87, v86, v79
	v_and_or_b32 v58, v78, v58, v79
	v_perm_b32 v78, v58, v80, s0
	v_perm_b32 v79, v58, v80, s1
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshlrev_b32_e32 v80, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[22:23], v[78:79], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[24:25], v[78:79], v[74:77]
	v_lshrrev_b32_e32 v78, 4, v59
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v85, v84, v58
	v_perm_b32 v58, v87, v86, v58
	v_and_or_b32 v79, v79, v80, v58
	v_perm_b32 v58, v85, v84, v78
	v_perm_b32 v78, v87, v86, v78
	v_and_or_b32 v59, v58, v59, v78
	v_perm_b32 v58, v59, v79, s0
	v_perm_b32 v59, v59, v79, s1
	v_lshlrev_b32_e32 v79, 4, v60
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[20:21], v[58:59], v[74:77]
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v78, v85, v84, v58
	v_perm_b32 v58, v87, v86, v58
	v_and_or_b32 v78, v78, v79, v58
	v_perm_b32 v58, v85, v84, v59
	v_perm_b32 v59, v87, v86, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v78, s0
	v_perm_b32 v59, v59, v78, s1
	v_lshlrev_b32_e32 v78, 4, v61
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[16:17], v[58:59], v[74:77]
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v85, v84, v58
	v_perm_b32 v58, v87, v86, v58
	v_and_or_b32 v60, v60, v78, v58
	v_perm_b32 v58, v85, v84, v59
	v_perm_b32 v59, v87, v86, v59
	v_and_or_b32 v59, v58, v61, v59
	v_perm_b32 v58, v59, v60, s0
	v_perm_b32 v59, v59, v60, s1
	v_sub_u32_sdwa v86, v1, v129 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[10:11], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[12:13], v[58:59], v[74:77]
	s_nop 2
	v_sub_u32_sdwa v74, v1, v129 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s2
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_lshlrev_b32_e32 v77, 4, v54
	v_cndmask_b32_e64 v82, v76, 0, vcc
	v_cndmask_b32_e64 v83, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v82
	v_and_b32_e32 v84, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v83
	v_and_b32_e32 v85, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v54
	v_lshrrev_b32_e32 v75, 4, v54
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v85, v84, v74
	v_perm_b32 v74, v83, v82, v74
	v_and_or_b32 v74, v76, v77, v74
	v_perm_b32 v76, v85, v84, v75
	v_perm_b32 v75, v83, v82, v75
	v_and_or_b32 v54, v76, v54, v75
	v_perm_b32 v78, v54, v74, s0
	v_perm_b32 v79, v54, v74, s1
	v_min_i32_e32 v54, 11, v86
	v_mul_lo_u32 v87, v54, s2
	v_and_b32_e32 v54, 0x7070707, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[38:39], v[78:79], 0
	v_perm_b32 v89, v85, v84, v54
	v_perm_b32 v54, v83, v82, v54
	v_and_or_b32 v89, v89, v90, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[40:41], v[78:79], 0
	v_perm_b32 v54, v85, v84, v88
	v_perm_b32 v88, v83, v82, v88
	v_and_or_b32 v55, v54, v55, v88
	v_perm_b32 v54, v55, v89, s0
	v_perm_b32 v55, v55, v89, s1
	v_lshlrev_b32_e32 v90, 4, v56
	v_sub_u32_e32 v88, 0x6c686080, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[34:35], v[54:55], v[74:77]
	v_and_b32_e32 v88, 0xffffff00, v88
	v_sub_u32_e32 v87, 0x7c787470, v87
	v_cmp_lt_i32_e32 vcc, 11, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[36:37], v[54:55], v[78:81]
	v_and_b32_e32 v54, 0x7070707, v56
	v_lshrrev_b32_e32 v55, 4, v56
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v89, v85, v84, v54
	v_perm_b32 v54, v83, v82, v54
	v_and_or_b32 v89, v89, v90, v54
	v_perm_b32 v54, v85, v84, v55
	v_perm_b32 v55, v83, v82, v55
	v_and_or_b32 v55, v54, v56, v55
	v_perm_b32 v54, v55, v89, s0
	v_perm_b32 v55, v55, v89, s1
	v_lshlrev_b32_e32 v89, 4, v57
	v_cndmask_b32_e64 v86, v88, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[30:31], v[54:55], v[74:77]
	v_cndmask_b32_e64 v87, v87, 0, vcc
	v_add_u32_e32 v88, 0x7f7f7f00, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[32:33], v[54:55], v[78:81]
	v_and_b32_e32 v54, 0x7070707, v57
	v_lshrrev_b32_e32 v55, 4, v57
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v56, v85, v84, v54
	v_perm_b32 v54, v83, v82, v54
	v_and_or_b32 v54, v56, v89, v54
	v_perm_b32 v56, v85, v84, v55
	v_perm_b32 v55, v83, v82, v55
	v_and_or_b32 v55, v56, v57, v55
	v_perm_b32 v82, v55, v54, s0
	v_perm_b32 v83, v55, v54, s1
	v_and_b32_e32 v84, 0x80808000, v88
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[26:27], v[82:83], v[74:77]
	s_nop 2
	v_add_u32_e32 v74, 0x7f7f7f78, v87
	v_and_b32_e32 v85, 0x80808080, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[28:29], v[82:83], v[78:81]
	s_nop 2
	v_and_b32_e32 v78, 0x7070707, v50
	v_lshrrev_b32_e32 v79, 4, v50
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v85, v84, v78
	v_lshlrev_b32_e32 v81, 4, v50
	v_perm_b32 v78, v87, v86, v78
	v_and_or_b32 v80, v80, v81, v78
	v_perm_b32 v78, v85, v84, v79
	v_perm_b32 v79, v87, v86, v79
	v_and_or_b32 v50, v78, v50, v79
	v_perm_b32 v78, v50, v80, s0
	v_perm_b32 v79, v50, v80, s1
	v_and_b32_e32 v50, 0x7070707, v51
	v_lshlrev_b32_e32 v80, 4, v51
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[22:23], v[78:79], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[24:25], v[78:79], v[74:77]
	v_lshrrev_b32_e32 v78, 4, v51
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v85, v84, v50
	v_perm_b32 v50, v87, v86, v50
	v_and_or_b32 v79, v79, v80, v50
	v_perm_b32 v50, v85, v84, v78
	v_perm_b32 v78, v87, v86, v78
	v_and_or_b32 v51, v50, v51, v78
	v_perm_b32 v50, v51, v79, s0
	v_perm_b32 v51, v51, v79, s1
	v_lshlrev_b32_e32 v79, 4, v52
	v_bfe_u32 v80, v128, s4, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[18:19], v[50:51], v[54:57]
	v_sub_u32_e32 v80, v0, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[20:21], v[50:51], v[74:77]
	v_and_b32_e32 v50, 0x7070707, v52
	v_lshrrev_b32_e32 v51, 4, v52
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v78, v85, v84, v50
	v_perm_b32 v50, v87, v86, v50
	v_and_or_b32 v78, v78, v79, v50
	v_perm_b32 v50, v85, v84, v51
	v_perm_b32 v51, v87, v86, v51
	v_and_or_b32 v51, v50, v52, v51
	v_perm_b32 v50, v51, v78, s0
	v_perm_b32 v51, v51, v78, s1
	v_lshlrev_b32_e32 v78, 4, v53
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[14:15], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[16:17], v[50:51], v[74:77]
	v_and_b32_e32 v50, 0x7070707, v53
	v_lshrrev_b32_e32 v51, 4, v53
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v85, v84, v50
	v_perm_b32 v50, v87, v86, v50
	v_and_or_b32 v52, v52, v78, v50
	v_perm_b32 v50, v85, v84, v51
	v_perm_b32 v51, v87, v86, v51
	v_and_or_b32 v51, v50, v53, v51
	v_perm_b32 v50, v51, v52, s0
	v_perm_b32 v51, v51, v52, s1
	v_bfe_u32 v78, v128, s3, 8
	v_lshlrev_b32_e32 v86, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[10:11], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[12:13], v[50:51], v[74:77]
	s_nop 2
	v_sub_u32_e32 v74, v0, v78
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s2
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	v_lshlrev_b32_e32 v77, 4, v46
	v_cndmask_b32_e64 v81, v76, 0, vcc
	v_cndmask_b32_e64 v82, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v81
	v_and_b32_e32 v83, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v82
	v_and_b32_e32 v84, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v46
	v_lshrrev_b32_e32 v75, 4, v46
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v84, v83, v74
	v_perm_b32 v74, v82, v81, v74
	v_and_or_b32 v74, v76, v77, v74
	v_perm_b32 v76, v84, v83, v75
	v_perm_b32 v75, v82, v81, v75
	v_and_or_b32 v46, v76, v46, v75
	v_perm_b32 v78, v46, v74, s0
	v_perm_b32 v79, v46, v74, s1
	v_and_b32_e32 v46, 0x7070707, v47
	v_cmp_lt_i32_e32 vcc, 11, v80
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[38:39], v[78:79], 0
	v_min_i32_e32 v38, 11, v80
	v_mul_lo_u32 v85, v38, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[40:41], v[78:79], 0
	v_lshrrev_b32_e32 v78, 4, v47
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v84, v83, v46
	v_perm_b32 v46, v82, v81, v46
	v_and_or_b32 v79, v79, v86, v46
	v_perm_b32 v46, v84, v83, v78
	v_perm_b32 v78, v82, v81, v78
	v_and_or_b32 v47, v46, v47, v78
	v_perm_b32 v46, v47, v79, s0
	v_perm_b32 v47, v47, v79, s1
	v_sub_u32_e32 v79, 0x7c787470, v85
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[34:35], v[46:47], v[74:77]
	v_sub_u32_e32 v34, 0x6c686080, v85
	v_and_b32_e32 v78, 0xffffff00, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[46:47], v[38:41]
	s_nop 2
	v_and_b32_e32 v38, 0x7070707, v48
	v_lshrrev_b32_e32 v39, 4, v48
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v40, v84, v83, v38
	v_lshlrev_b32_e32 v41, 4, v48
	v_perm_b32 v38, v82, v81, v38
	v_and_or_b32 v38, v40, v41, v38
	v_perm_b32 v40, v84, v83, v39
	v_perm_b32 v39, v82, v81, v39
	v_and_or_b32 v39, v40, v48, v39
	v_perm_b32 v46, v39, v38, s0
	v_perm_b32 v47, v39, v38, s1
	v_cndmask_b32_e64 v48, v78, 0, vcc
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[30:31], v[46:47], v[74:77]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[32:33], v[46:47], v[34:37]
	s_nop 1
	v_cndmask_b32_e64 v74, v79, 0, vcc
	v_add_u32_e32 v75, 0x7f7f7f00, v48
	v_cmp_lt_i32_e32 vcc, 5, v127
	v_and_b32_e32 v34, 0x7070707, v49
	v_lshrrev_b32_e32 v35, 4, v49
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v84, v83, v34
	v_lshlrev_b32_e32 v37, 4, v49
	v_perm_b32 v34, v82, v81, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v84, v83, v35
	v_perm_b32 v35, v82, v81, v35
	v_and_or_b32 v35, v36, v49, v35
	v_perm_b32 v46, v35, v34, s0
	v_perm_b32 v47, v35, v34, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[26:27], v[46:47], v[38:41]
	v_add_u32_e32 v26, 0x7f7f7f78, v74
	s_nop 1
	v_and_b32_e32 v40, 0x80808000, v75
	v_and_b32_e32 v41, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[46:47], v[30:33]
	s_nop 2
	v_and_b32_e32 v30, 0x7070707, v42
	v_lshrrev_b32_e32 v31, 4, v42
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v41, v40, v30
	v_lshlrev_b32_e32 v33, 4, v42
	v_perm_b32 v30, v74, v48, v30
	v_and_or_b32 v30, v32, v33, v30
	v_perm_b32 v32, v41, v40, v31
	v_perm_b32 v31, v74, v48, v31
	v_and_or_b32 v31, v32, v42, v31
	v_perm_b32 v38, v31, v30, s0
	v_perm_b32 v39, v31, v30, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[22:23], v[38:39], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[24:25], v[38:39], v[26:29]
	s_nop 2
	v_and_b32_e32 v26, 0x7070707, v43
	v_lshrrev_b32_e32 v27, 4, v43
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v41, v40, v26
	v_lshlrev_b32_e32 v29, 4, v43
	v_perm_b32 v26, v74, v48, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v41, v40, v27
	v_perm_b32 v27, v74, v48, v27
	v_and_or_b32 v27, v28, v43, v27
	v_perm_b32 v34, v27, v26, s0
	v_perm_b32 v35, v27, v26, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[18:19], v[34:35], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[20:21], v[34:35], v[22:25]
	s_nop 2
	v_and_b32_e32 v22, 0x7070707, v44
	v_lshrrev_b32_e32 v23, 4, v44
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v41, v40, v22
	v_lshlrev_b32_e32 v25, 4, v44
	v_perm_b32 v22, v74, v48, v22
	v_and_or_b32 v22, v24, v25, v22
	v_perm_b32 v24, v41, v40, v23
	v_perm_b32 v23, v74, v48, v23
	v_and_or_b32 v23, v24, v44, v23
	v_perm_b32 v30, v23, v22, s0
	v_perm_b32 v31, v23, v22, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[14:15], v[30:31], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[30:31], v[18:21]
	s_nop 2
	v_and_b32_e32 v18, 0x7070707, v45
	v_lshrrev_b32_e32 v19, 4, v45
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v41, v40, v18
	v_lshlrev_b32_e32 v21, 4, v45
	v_perm_b32 v18, v74, v48, v18
	v_and_or_b32 v18, v20, v21, v18
	v_perm_b32 v20, v41, v40, v19
	v_perm_b32 v19, v74, v48, v19
	v_and_or_b32 v19, v20, v45, v19
	v_perm_b32 v26, v19, v18, s0
	v_perm_b32 v27, v19, v18, s1
	s_movk_i32 s0, 0x7fff
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[26:27], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[12:13], v[26:27], v[14:17]
	s_nop 1
	v_add_u32_e32 v22, 17, v1
	v_lshlrev_b32_e64 v22, v22, 1
	v_mov_b32_e32 v15, 0xfd800000
	v_add_u32_e32 v16, 17, v127
	v_lshl_add_u32 v14, v127, 23, v15
	v_lshlrev_b32_e64 v16, v16, 1
	v_add_u32_e32 v17, 17, v126
	v_cndmask_b32_e32 v14, v16, v14, vcc
	v_lshl_add_u32 v16, v126, 23, v15
	v_lshlrev_b32_e64 v17, v17, 1
	v_cmp_lt_i32_e32 vcc, 5, v126
	s_nop 1
	v_cndmask_b32_e32 v16, v17, v16, vcc
	v_lshl_add_u32 v17, v1, 23, v15
	v_cmp_lt_i32_e32 vcc, 5, v1
	v_lshl_add_u32 v1, v0, 23, v15
	v_add_u32_e32 v15, 17, v0
	v_lshlrev_b32_e64 v15, v15, 1
	v_pk_mul_f32 v[26:27], v[8:9], v[14:15] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v22, v22, v17, vcc
	v_pk_mul_f32 v[26:27], v[26:27], v[72:73]
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[26:27], v[26:27], v[112:113]
	v_pk_mul_f32 v[24:25], v[6:7], v[14:15] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v0, v15, v1, vcc
	v_bfe_u32 v1, v27, 16, 1
	v_add3_u32 v1, v1, v27, s0
	v_or_b32_e32 v15, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	v_pk_mul_f32 v[24:25], v[24:25], v[70:71]
	v_or_b32_e32 v17, 0x400000, v26
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_bfe_u32 v15, v26, 16, 1
	v_pk_mul_f32 v[24:25], v[24:25], v[110:111]
	v_add3_u32 v15, v15, v26, s0
	v_cmp_u_f32_e32 vcc, v26, v26
	v_or_b32_e32 v23, 0x400000, v25
	s_nop 0
	v_cndmask_b32_e32 v15, v15, v17, vcc
	v_bfe_u32 v17, v25, 16, 1
	v_add3_u32 v17, v17, v25, s0
	v_cmp_u_f32_e32 vcc, v25, v25
	v_or_b32_e32 v25, 0x400000, v24
	s_nop 0
	v_cndmask_b32_e32 v17, v17, v23, vcc
	v_bfe_u32 v23, v24, 16, 1
	v_pk_mul_f32 v[26:27], v[8:9], v[16:17] op_sel_hi:[1,0]
	v_add3_u32 v23, v23, v24, s0
	v_cmp_u_f32_e32 vcc, v24, v24
	v_pk_mul_f32 v[26:27], v[26:27], v[64:65]
	s_nop 0
	v_cndmask_b32_e32 v23, v23, v25, vcc
	v_pk_mul_f32 v[26:27], v[26:27], v[112:113]
	ds_write_b16_d16_hi v114, v23
	ds_write_b16_d16_hi v114, v17 offset:512
	ds_write_b16_d16_hi v114, v15 offset:1024
	ds_write_b16_d16_hi v114, v1 offset:1536
	v_bfe_u32 v1, v27, 16, 1
	v_pk_mul_f32 v[24:25], v[6:7], v[16:17] op_sel_hi:[1,0]
	v_add3_u32 v1, v1, v27, s0
	v_or_b32_e32 v15, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	v_pk_mul_f32 v[24:25], v[24:25], v[62:63]
	v_or_b32_e32 v17, 0x400000, v26
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_bfe_u32 v15, v26, 16, 1
	v_pk_mul_f32 v[24:25], v[24:25], v[110:111]
	v_add3_u32 v15, v15, v26, s0
	v_cmp_u_f32_e32 vcc, v26, v26
	v_or_b32_e32 v23, 0x400000, v25
	s_nop 0
	v_cndmask_b32_e32 v15, v15, v17, vcc
	v_bfe_u32 v17, v25, 16, 1
	v_add3_u32 v17, v17, v25, s0
	v_cmp_u_f32_e32 vcc, v25, v25
	v_or_b32_e32 v25, 0x400000, v24
	s_nop 0
	v_cndmask_b32_e32 v17, v17, v23, vcc
	v_bfe_u32 v23, v24, 16, 1
	v_add3_u32 v23, v23, v24, s0
	v_cmp_u_f32_e32 vcc, v24, v24
	s_nop 1
	v_cndmask_b32_e32 v23, v23, v25, vcc
	v_pk_mul_f32 v[26:27], v[8:9], v[22:23] op_sel_hi:[1,0]
	ds_write_b16_d16_hi v114, v23 offset:32
	ds_write_b16_d16_hi v114, v17 offset:544
	ds_write_b16_d16_hi v114, v15 offset:1056
	ds_write_b16_d16_hi v114, v1 offset:1568
	v_pk_mul_f32 v[26:27], v[26:27], v[56:57]
	v_pk_mul_f32 v[24:25], v[6:7], v[22:23] op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[26:27], v[112:113]
	v_pk_mul_f32 v[24:25], v[24:25], v[54:55]
	v_bfe_u32 v1, v27, 16, 1
	v_add3_u32 v1, v1, v27, s0
	v_or_b32_e32 v15, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	v_pk_mul_f32 v[24:25], v[24:25], v[110:111]
	v_or_b32_e32 v17, 0x400000, v26
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_bfe_u32 v15, v26, 16, 1
	v_add3_u32 v15, v15, v26, s0
	v_cmp_u_f32_e32 vcc, v26, v26
	v_or_b32_e32 v23, 0x400000, v25
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v15, v15, v17, vcc
	v_bfe_u32 v17, v25, 16, 1
	v_add3_u32 v17, v17, v25, s0
	v_cmp_u_f32_e32 vcc, v25, v25
	v_or_b32_e32 v25, 0x400000, v24
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_cndmask_b32_e32 v17, v17, v23, vcc
	v_bfe_u32 v23, v24, 16, 1
	v_add3_u32 v23, v23, v24, s0
	v_cmp_u_f32_e32 vcc, v24, v24
	v_pk_mul_f32 v[8:9], v[8:9], v[112:113]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v23, v23, v25, vcc
	ds_write_b16_d16_hi v114, v23 offset:64
	ds_write_b16_d16_hi v114, v17 offset:576
	ds_write_b16_d16_hi v114, v15 offset:1088
	ds_write_b16_d16_hi v114, v1 offset:1600
	v_bfe_u32 v1, v9, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v15, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_pk_mul_f32 v[6:7], v[6:7], v[110:111]
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
	ds_write_b16_d16_hi v114, v6 offset:96
	ds_write_b16_d16_hi v114, v7 offset:608
	ds_write_b16_d16_hi v114, v8 offset:1120
	ds_write_b16_d16_hi v114, v1 offset:1632
	v_pk_mul_f32 v[8:9], v[4:5], v[14:15] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[14:15] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[68:69]
	v_pk_mul_f32 v[6:7], v[6:7], v[66:67]
	v_pk_mul_f32 v[8:9], v[8:9], v[108:109]
	v_pk_mul_f32 v[6:7], v[6:7], v[106:107]
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v14, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v14, vcc
	v_or_b32_e32 v14, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v14, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v14, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v114, v6 offset:8192
	ds_write_b16_d16_hi v114, v7 offset:8704
	ds_write_b16_d16_hi v114, v8 offset:9216
	ds_write_b16_d16_hi v114, v1 offset:9728
	v_pk_mul_f32 v[8:9], v[4:5], v[16:17] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[16:17] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[60:61]
	v_pk_mul_f32 v[6:7], v[6:7], v[58:59]
	v_pk_mul_f32 v[8:9], v[8:9], v[108:109]
	v_pk_mul_f32 v[6:7], v[6:7], v[106:107]
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v14, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v14, vcc
	v_or_b32_e32 v14, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v14, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v14, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v114, v6 offset:8224
	ds_write_b16_d16_hi v114, v7 offset:8736
	ds_write_b16_d16_hi v114, v8 offset:9248
	ds_write_b16_d16_hi v114, v1 offset:9760
	v_pk_mul_f32 v[8:9], v[4:5], v[22:23] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[22:23] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[52:53]
	v_pk_mul_f32 v[6:7], v[6:7], v[50:51]
	v_pk_mul_f32 v[8:9], v[8:9], v[108:109]
	v_pk_mul_f32 v[6:7], v[6:7], v[106:107]
	v_bfe_u32 v1, v9, 16, 1
	v_add3_u32 v1, v1, v9, s0
	v_or_b32_e32 v14, 0x400000, v9
	v_cmp_u_f32_e32 vcc, v9, v9
	v_bfe_u32 v9, v8, 16, 1
	v_add3_u32 v9, v9, v8, s0
	v_cndmask_b32_e32 v1, v1, v14, vcc
	v_or_b32_e32 v14, 0x400000, v8
	v_cmp_u_f32_e32 vcc, v8, v8
	v_pk_mul_f32 v[2:3], v[2:3], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_bfe_u32 v9, v7, 16, 1
	v_add3_u32 v9, v9, v7, s0
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	s_nop 0
	v_cndmask_b32_e32 v7, v9, v14, vcc
	v_bfe_u32 v9, v6, 16, 1
	v_add3_u32 v9, v9, v6, s0
	v_or_b32_e32 v14, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[2:3], v[2:3], v[106:107]
	s_nop 0
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v114, v6 offset:8256
	ds_write_b16_d16_hi v114, v7 offset:8768
	ds_write_b16_d16_hi v114, v8 offset:9280
	ds_write_b16_d16_hi v114, v1 offset:9792
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[12:13]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[108:109]
	s_nop 0
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
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s0
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s0
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v5, vcc
	ds_write_b16_d16_hi v114, v2 offset:8288
	ds_write_b16_d16_hi v114, v3 offset:8800
	ds_write_b16_d16_hi v114, v0 offset:9312
	ds_write_b16_d16_hi v114, v1 offset:9824
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v124, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_15
	v_add_u32_e32 v2, v125, v117
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v117
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
.LBB0_15:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v122, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_17
	v_add_u32_e32 v2, v123, v117
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v117
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
.LBB0_17:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v121, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_19
	v_add_u32_e32 v2, v120, v117
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v117
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
.LBB0_19:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v119, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_21
	v_add_u32_e32 v2, v118, v117
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v117
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
.LBB0_21:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db
		.amdhsa_group_segment_fixed_size 32768
		.amdhsa_private_segment_fixed_size 164
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
		.amdhsa_next_free_vgpr 256
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 256
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.num_vgpr, 256
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.numbered_sgpr, 57
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.private_seg_size, 164
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.has_indirect_call, 0
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
    .max_flat_workgroup_size: 256
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db
    .private_segment_fixed_size: 164
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     63
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn256_bcm12_xcd1_w2_ftz_a2r_db.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     256
    .vgpr_spill_count: 40
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
