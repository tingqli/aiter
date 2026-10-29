	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db:
	s_load_dwordx8 s[16:23], s[0:1], 0x40
	v_readfirstlane_b32 s50, v0
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
	s_add_u32 s52, s16, s4
	s_addc_u32 s53, s17, s5
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
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dwordx2 s[34:35], s[0:1], 0x60
	s_load_dword s33, s[0:1], 0x68
	v_and_b32_e32 v1, 63, v0
	v_accvgpr_write_b32 a26, v1
	s_waitcnt lgkmcnt(0)
	s_mov_b32 s44, s4
	s_mov_b32 s28, s4
	s_load_dword s4, s[52:53], 0x0
	s_mov_b32 s0, s8
	s_mov_b32 s36, s8
	s_and_b32 s45, s5, 0xffff
	s_and_b32 s5, s50, 0xffffffc0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s8, s4, 9
	s_and_b32 s1, s9, 0xffff
	s_add_i32 s9, s8, s5
	s_ashr_i32 s53, s9, 31
	v_and_b32_e32 v7, 48, v0
	v_and_b32_e32 v1, 15, v0
	s_mov_b32 s24, s10
	s_mov_b32 s40, s10
	s_and_b32 s25, s11, 0xffff
	s_lshl_b32 s10, s9, 7
	s_lshl_b32 s11, s9, 5
	s_add_i32 s51, s9, 0x100
	s_or_b32 s52, s9, 16
	s_lshr_b32 s56, s53, 27
	v_or3_b32 v10, s10, v7, v1
	v_or3_b32 v8, s11, v7, v1
	s_lshl_b32 s10, s51, 7
	s_lshl_b32 s11, s51, 5
	s_ashr_i32 s51, s52, 4
	s_lshl_b32 s55, s52, 7
	s_add_i32 s52, s52, s56
	v_or3_b32 v9, s11, v7, v1
	s_lshr_b32 s11, s52, 5
	s_add_i32 s11, s11, s53
	s_lshl_b32 s11, s11, 10
	v_or3_b32 v12, s11, v7, v1
	s_add_i32 s11, s9, 0x110
	s_lshr_b32 s54, s9, 31
	s_lshl_b32 s52, s11, 7
	v_or3_b32 v14, s10, v7, v1
	s_add_i32 s10, s51, s54
	v_or3_b32 v15, s52, v7, v1
	s_ashr_i32 s52, s11, 31
	v_or3_b32 v11, s55, v7, v1
	s_and_b32 s10, s10, -2
	s_lshr_b32 s55, s52, 27
	s_sub_i32 s10, s51, s10
	s_ashr_i32 s51, s11, 4
	s_add_i32 s55, s11, s55
	s_lshr_b32 s11, s11, 31
	s_lshr_b32 s55, s55, 5
	s_add_i32 s11, s51, s11
	s_add_i32 s55, s55, s52
	s_and_b32 s11, s11, -2
	s_lshl_b32 s52, s55, 10
	s_sub_i32 s11, s51, s11
	s_or_b32 s51, s9, 32
	v_lshlrev_b32_e32 v37, 4, v0
	v_xor_b32_e32 v2, v4, v0
	v_or3_b32 v234, s52, v7, v1
	s_lshl_b32 s52, s51, 7
	s_lshl_b32 s51, s51, 5
	v_xor_b32_e32 v3, v37, v0
	v_lshlrev_b32_e32 v2, 4, v2
	v_or3_b32 v236, s51, v7, v1
	s_add_i32 s51, s9, 0x120
	v_bfe_u32 v50, v0, 4, 2
	v_accvgpr_write_b32 a20, v0
	v_and_b32_e32 v0, 0xf0, v3
	v_and_b32_e32 v2, 0xf0, v2
	v_or3_b32 v235, s52, v7, v1
	s_lshl_b32 s52, s51, 7
	s_lshl_b32 s51, s51, 5
	s_mov_b32 s47, 0x27000
	s_lshl_b32 s46, s33, 12
	v_or3_b32 v238, s51, v7, v1
	s_or_b32 s51, s9, 48
	s_addk_i32 s9, 0x130
	s_waitcnt vmcnt(1)
	v_lshl_or_b32 v0, v5, 12, v0
	s_waitcnt vmcnt(0)
	v_lshl_or_b32 v2, v6, 12, v2
	s_mov_b32 s30, s46
	buffer_load_dwordx4 v[38:41], v0, s[44:47], 0 offen nt
	buffer_load_dwordx4 v[42:45], v2, s[44:47], 0 offen nt
	s_lshl_b32 s46, s9, 7
	v_or_b32_e32 v3, s5, v1
	v_or3_b32 v243, s46, v7, v1
	s_ashr_i32 s46, s9, 31
	s_mov_b32 s31, s47
	s_mov_b32 s3, s47
	s_mov_b32 s39, s47
	s_mov_b32 s27, s47
	s_mov_b32 s43, s47
	v_accvgpr_write_b32 a40, v2
	s_lshr_b32 s47, s46, 27
	v_add_u32_e32 v2, s8, v3
	v_or3_b32 v237, s52, v7, v1
	s_ashr_i32 s52, s51, 4
	s_lshl_b32 s55, s51, 7
	s_add_i32 s51, s51, s56
	s_add_i32 s47, s9, s47
	v_accvgpr_write_b32 a27, v3
	v_ashrrev_i32_e32 v3, 31, v2
	s_lshr_b32 s44, s51, 5
	s_lshr_b32 s47, s47, 5
	v_lshl_add_u64 v[4:5], v[2:3], 2, s[12:13]
	v_add_u32_e32 v2, 0x100, v2
	s_add_i32 s44, s44, s53
	s_add_i32 s47, s47, s46
	v_ashrrev_i32_e32 v3, 31, v2
	s_mov_b32 s26, 0x1000000
	s_lshl_b32 s44, s44, 10
	s_lshl_b32 s46, s47, 10
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	s_brev_b32 s2, 8
	s_mov_b32 s42, s26
	s_mov_b32 s41, s25
	v_or3_b32 v241, s44, v7, v1
	v_or3_b32 v244, s46, v7, v1
	global_load_dword v212, v[4:5], off
	global_load_dword v213, v[4:5], off offset:64
	global_load_dword v208, v[4:5], off offset:128
	global_load_dword v209, v[4:5], off offset:192
	global_load_dword v210, v[2:3], off
	global_load_dword v211, v[2:3], off offset:64
	global_load_dword v206, v[2:3], off offset:128
	global_load_dword v207, v[2:3], off offset:192
	v_lshlrev_b32_e32 v2, 2, v8
	s_mov_b32 s38, s2
	s_mov_b32 s37, s1
	v_or3_b32 v239, s55, v7, v1
	v_accvgpr_write_b32 a39, v0
	v_accvgpr_write_b32 a23, v7
	v_accvgpr_write_b32 a33, v8
	v_lshlrev_b32_e32 v3, 2, v12
	v_lshlrev_b32_e32 v4, 2, v236
	v_lshlrev_b32_e32 v5, 2, v241
	v_accvgpr_write_b32 a36, v9
	v_lshlrev_b32_e32 v6, 2, v9
	v_lshlrev_b32_e32 v7, 2, v234
	v_lshlrev_b32_e32 v8, 2, v238
	v_lshlrev_b32_e32 v9, 2, v244
	buffer_load_dword v0, v2, s[40:43], 0 offen
	buffer_load_dword v218, v3, s[40:43], 0 offen
	buffer_load_dword v254, v4, s[40:43], 0 offen
	buffer_load_dword v214, v5, s[40:43], 0 offen
	buffer_load_dword v150, v6, s[40:43], 0 offen
	buffer_load_dword v219, v7, s[40:43], 0 offen
	buffer_load_dword v249, v8, s[40:43], 0 offen
	buffer_load_dword v215, v9, s[40:43], 0 offen
	v_lshlrev_b32_e32 v2, 4, v10
	buffer_load_dwordx4 v[90:93], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[66:69], v2, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v2, 4, v11
	buffer_load_dwordx4 v[58:61], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[46:49], v2, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v2, 4, v235
	buffer_load_dwordx4 v[26:29], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v2, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v2, 4, v239
	v_accvgpr_write_b32 a38, v12
	v_accvgpr_write_b32 a32, v10
	v_accvgpr_write_b32 a37, v11
	buffer_load_dwordx4 v[10:13], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v2, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v2, 4, v14
	buffer_load_dwordx4 v[94:97], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[70:73], v2, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v2, 4, v15
	buffer_load_dwordx4 v[62:65], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[54:57], v2, s[36:39], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v2, 4, v237
	v_lshlrev_b32_e32 v36, 4, v243
	v_accvgpr_write_b32 a35, v14
	v_accvgpr_write_b32 a41, v15
	buffer_load_dwordx4 v[30:33], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v2, s[36:39], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[14:17], v36, s[36:39], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v36, s[36:39], 0 offen offset:1024 sc0
	v_and_b32_e32 v35, 0xf0, v37
	v_lshl_or_b32 v246, v34, 8, v35
	v_lshlrev_b32_e32 v34, 5, v50
	v_lshlrev_b32_e32 v35, 4, v1
	v_or_b32_e32 v36, 8, v34
	v_xor_b32_e32 v240, v36, v35
	v_or_b32_e32 v36, 16, v34
	v_xor_b32_e32 v36, v36, v35
	v_accvgpr_write_b32 a34, v36
	v_or_b32_e32 v36, 24, v34
	v_xor_b32_e32 v36, v36, v35
	v_accvgpr_write_b32 a31, v36
	v_or_b32_e32 v36, 0x80, v34
	v_xor_b32_e32 v36, v36, v35
	v_accvgpr_write_b32 a30, v36
	v_or_b32_e32 v36, 0x88, v34
	s_mov_b32 s29, s45
	s_ashr_i32 s45, s9, 4
	s_lshr_b32 s9, s9, 31
	v_xor_b32_e32 v36, v36, v35
	s_add_i32 s44, s52, s54
	s_add_i32 s9, s45, s9
	v_accvgpr_write_b32 a21, v37
	s_waitcnt vmcnt(32)
	ds_write_b128 v37, v[42:45] offset:4096
	v_xor_b32_e32 v37, v34, v35
	v_accvgpr_write_b32 a29, v36
	v_or_b32_e32 v36, 0x90, v34
	v_or_b32_e32 v34, 0x98, v34
	s_and_b32 s44, s44, -2
	s_and_b32 s9, s9, -2
	v_lshlrev_b32_e32 v201, 8, v1
	v_xor_b32_e32 v34, v34, v35
	s_sub_i32 s44, s52, s44
	s_sub_i32 s45, s45, s9
	v_or_b32_e32 v34, v201, v34
	s_lshl_b32 s13, s10, 3
	s_lshl_b32 s9, s44, 3
	s_lshl_b32 s36, s11, 3
	s_lshl_b32 s10, s45, 3
	v_xor_b32_e32 v36, v36, v35
	v_accvgpr_write_b32 a25, v34
	v_or_b32_e32 v34, v201, v37
	v_mov_b32_e32 v98, 0
	ds_write_b128 v246, v[38:41]
	s_add_i32 s12, s13, 16
	s_add_i32 s8, s9, 16
	s_add_i32 s37, s36, 16
	s_add_i32 s11, s10, 16
	v_accvgpr_write_b32 a22, v50
	v_or_b32_e32 v242, 0x1000, v201
	v_accvgpr_write_b32 a28, v36
	v_accvgpr_write_b32 a24, v37
	v_accvgpr_write_b32 a42, v34
	s_mov_b32 s38, 0x8080808
	s_mov_b32 s39, 0x5010400
	s_mov_b32 s40, 0x7030602
	v_mov_b32_e32 v99, v98
	v_mov_b32_e32 v100, v98
	v_mov_b32_e32 v101, v98
	v_mov_b32_e32 v74, v98
	v_mov_b32_e32 v75, v98
	v_mov_b32_e32 v76, v98
	v_mov_b32_e32 v77, v98
	v_mov_b32_e32 v34, v98
	v_mov_b32_e32 v35, v98
	v_mov_b32_e32 v36, v98
	v_mov_b32_e32 v37, v98
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
	v_mov_b32_e32 v38, v98
	v_mov_b32_e32 v39, v98
	v_mov_b32_e32 v40, v98
	v_mov_b32_e32 v41, v98
	v_mov_b32_e32 v114, v98
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
	v_mov_b32_e32 v44, v98
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
	v_mov_b32_e32 v50, v98
	v_mov_b32_e32 v51, v98
	v_mov_b32_e32 v52, v98
	v_mov_b32_e32 v53, v98
	v_mov_b32_e32 v122, v98
	v_mov_b32_e32 v123, v98
	v_mov_b32_e32 v124, v98
	v_mov_b32_e32 v125, v98
.LBB0_2:
	s_add_i32 s41, s49, 1
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[132:133], v[4:5]
	v_mov_b64_e32 v[130:131], v[2:3]
	s_lshl_b32 s42, s41, 8
	v_accvgpr_read_b32 v2, a39
	v_add_u32_e32 v2, s42, v2
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx4 a[0:3], v2, s[28:31], 0 offen nt
	v_accvgpr_read_b32 v2, a40
	v_add_u32_e32 v2, s42, v2
	buffer_load_dwordx4 a[4:7], v2, s[28:31], 0 offen nt
	s_lshl_b32 s42, s41, 6
	v_accvgpr_read_b32 v2, a33
	v_add_lshl_u32 v2, s42, v2, 2
	buffer_load_dword v248, v2, s[24:27], 0 offen
	v_accvgpr_read_b32 v2, a38
	v_add_lshl_u32 v2, s42, v2, 2
	v_bfe_u32 v205, v218, s13, 8
	v_bfe_u32 v199, v218, s12, 8
	buffer_load_dword v218, v2, s[24:27], 0 offen
	v_add_lshl_u32 v2, s42, v236, 2
	buffer_load_dword v217, v2, s[24:27], 0 offen
	v_add_lshl_u32 v2, s42, v241, 2
	v_bfe_u32 v253, v214, s9, 8
	v_bfe_u32 v252, v214, s8, 8
	buffer_load_dword v214, v2, s[24:27], 0 offen
	v_accvgpr_read_b32 v2, a36
	v_add_lshl_u32 v2, s42, v2, 2
	buffer_load_dword v247, v2, s[24:27], 0 offen
	v_add_lshl_u32 v2, s42, v234, 2
	v_bfe_u32 v204, v219, s36, 8
	v_bfe_u32 v255, v219, s37, 8
	buffer_load_dword v219, v2, s[24:27], 0 offen
	v_add_lshl_u32 v2, s42, v238, 2
	buffer_load_dword v216, v2, s[24:27], 0 offen
	v_add_lshl_u32 v2, s42, v244, 2
	v_bfe_u32 v251, v215, s10, 8
	v_bfe_u32 v250, v215, s11, 8
	buffer_load_dword v215, v2, s[24:27], 0 offen
	s_lshl_b32 s42, s41, 7
	v_accvgpr_read_b32 v2, a32
	v_or_b32_e32 v2, s42, v2
	v_lshlrev_b32_e32 v2, 4, v2
	v_mov_b64_e32 v[188:189], v[68:69]
	v_mov_b64_e32 v[186:187], v[66:67]
	v_mov_b64_e32 v[196:197], v[92:93]
	v_mov_b64_e32 v[194:195], v[90:91]
	buffer_load_dwordx4 v[90:93], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[66:69], v2, s[0:3], 0 offen offset:1024 sc0
	v_accvgpr_read_b32 v2, a37
	v_add_lshl_u32 v2, s42, v2, 4
	v_mov_b64_e32 v[176:177], v[48:49]
	v_mov_b64_e32 v[174:175], v[46:47]
	v_mov_b64_e32 v[184:185], v[60:61]
	v_mov_b64_e32 v[182:183], v[58:59]
	buffer_load_dwordx4 v[58:61], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[46:49], v2, s[0:3], 0 offen offset:1024 sc0
	v_or_b32_e32 v2, s42, v235
	v_lshlrev_b32_e32 v2, 4, v2
	v_mov_b64_e32 v[160:161], v[20:21]
	v_mov_b64_e32 v[158:159], v[18:19]
	v_mov_b64_e32 v[168:169], v[28:29]
	v_mov_b64_e32 v[166:167], v[26:27]
	buffer_load_dwordx4 v[26:29], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v2, s[0:3], 0 offen offset:1024 sc0
	v_add_lshl_u32 v2, s42, v239, 4
	v_mov_b64_e32 v[136:137], v[8:9]
	v_mov_b64_e32 v[134:135], v[6:7]
	v_mov_b64_e32 v[148:149], v[12:13]
	v_mov_b64_e32 v[146:147], v[10:11]
	buffer_load_dwordx4 v[10:13], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v2, s[0:3], 0 offen offset:1024 sc0
	v_accvgpr_read_b32 v2, a35
	v_or_b32_e32 v2, s42, v2
	v_lshlrev_b32_e32 v2, 4, v2
	v_mov_b64_e32 v[140:141], v[72:73]
	v_mov_b64_e32 v[138:139], v[70:71]
	v_mov_b64_e32 v[192:193], v[96:97]
	v_mov_b64_e32 v[190:191], v[94:95]
	buffer_load_dwordx4 v[94:97], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[70:73], v2, s[0:3], 0 offen offset:1024 sc0
	v_accvgpr_read_b32 v2, a41
	v_add_lshl_u32 v2, s42, v2, 4
	v_mov_b64_e32 v[172:173], v[56:57]
	v_mov_b64_e32 v[170:171], v[54:55]
	v_mov_b64_e32 v[180:181], v[64:65]
	v_mov_b64_e32 v[178:179], v[62:63]
	buffer_load_dwordx4 v[62:65], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[54:57], v2, s[0:3], 0 offen offset:1024 sc0
	v_add_lshl_u32 v2, s42, v237, 4
	v_mov_b64_e32 v[156:157], v[24:25]
	v_mov_b64_e32 v[154:155], v[22:23]
	v_mov_b64_e32 v[164:165], v[32:33]
	v_mov_b64_e32 v[162:163], v[30:31]
	buffer_load_dwordx4 v[30:33], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v2, s[0:3], 0 offen offset:1024 sc0
	v_add_lshl_u32 v2, s42, v243, 4
	v_mov_b64_e32 v[144:145], v[16:17]
	v_mov_b64_e32 v[142:143], v[14:15]
	buffer_load_dwordx4 v[14:17], v2, s[0:3], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v2, s[0:3], 0 offen offset:1024 sc0
	v_sub_u32_sdwa v151, v212, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v152, 11, v151
	v_mul_lo_u32 v152, v152, s38
	v_sub_u32_e32 v153, 0x6c686080, v152
	v_and_b32_e32 v153, 0xffffff00, v153
	v_cmp_lt_i32_e32 vcc, 11, v151
	v_sub_u32_e32 v152, 0x7c787470, v152
	v_sub_u32_sdwa v0, v212, v0 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cndmask_b32_e64 v222, v153, 0, vcc
	v_cndmask_b32_e64 v223, v152, 0, vcc
	v_add_u32_e32 v151, 0x7f7f7f00, v222
	v_and_b32_e32 v224, 0x80808000, v151
	v_add_u32_e32 v151, 0x7f7f7f78, v223
	v_and_b32_e32 v225, 0x80808080, v151
	v_min_i32_e32 v151, 11, v0
	v_mul_lo_u32 v151, v151, s38
	v_sub_u32_e32 v152, 0x6c686080, v151
	v_sub_u32_e32 v151, 0x7c787470, v151
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_and_b32_e32 v152, 0xffffff00, v152
	s_lshl_b32 s42, s49, 13
	v_cndmask_b32_e64 v200, v151, 0, vcc
	v_sub_u32_sdwa v151, v210, v150 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_cndmask_b32_e64 v202, v152, 0, vcc
	v_min_i32_e32 v152, 11, v151
	v_mul_lo_u32 v152, v152, s38
	v_sub_u32_e32 v153, 0x6c686080, v152
	v_and_b32_e32 v153, 0xffffff00, v153
	v_cmp_lt_i32_e32 vcc, 11, v151
	v_sub_u32_e32 v152, 0x7c787470, v152
	v_sub_u32_sdwa v150, v210, v150 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cndmask_b32_e64 v230, v153, 0, vcc
	v_cndmask_b32_e64 v231, v152, 0, vcc
	v_add_u32_e32 v151, 0x7f7f7f00, v230
	v_and_b32_e32 v232, 0x80808000, v151
	v_add_u32_e32 v151, 0x7f7f7f78, v231
	v_and_b32_e32 v233, 0x80808080, v151
	v_min_i32_e32 v151, 11, v150
	v_mul_lo_u32 v151, v151, s38
	v_sub_u32_e32 v152, 0x6c686080, v151
	v_and_b32_e32 v152, 0xffffff00, v152
	v_cmp_lt_i32_e32 vcc, 11, v150
	v_sub_u32_e32 v151, 0x7c787470, v151
	v_lshlrev_b32_e32 v153, 4, v194
	v_cndmask_b32_e64 v203, v152, 0, vcc
	v_cndmask_b32_e64 v198, v151, 0, vcc
	v_add_u32_e32 v150, 0x7f7f7f00, v203
	v_and_b32_e32 v220, 0x80808000, v150
	v_add_u32_e32 v150, 0x7f7f7f78, v198
	v_and_b32_e32 v221, 0x80808080, v150
	v_and_b32_e32 v150, 0x7070707, v194
	v_lshrrev_b32_e32 v151, 4, v194
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v225, v224, v150
	v_perm_b32 v150, v223, v222, v150
	v_and_or_b32 v150, v152, v153, v150
	v_perm_b32 v152, v225, v224, v151
	v_perm_b32 v151, v223, v222, v151
	v_and_or_b32 v151, v152, v194, v151
	v_perm_b32 v226, v151, v150, s39
	v_perm_b32 v227, v151, v150, s40
	v_and_b32_e32 v150, 0x7070707, v190
	v_lshrrev_b32_e32 v151, 4, v190
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v233, v232, v150
	v_lshlrev_b32_e32 v153, 4, v190
	v_perm_b32 v150, v231, v230, v150
	v_and_or_b32 v150, v152, v153, v150
	v_perm_b32 v152, v233, v232, v151
	v_perm_b32 v151, v231, v230, v151
	v_and_or_b32 v151, v152, v190, v151
	v_perm_b32 v228, v151, v150, s39
	v_perm_b32 v229, v151, v150, s40
	s_and_b32 s42, s42, 0x2000
	v_accvgpr_read_b32 v150, a42
	v_or_b32_e32 v150, s42, v150
	ds_read2st64_b64 v[150:153], v150 offset1:8
	v_and_b32_e32 v190, 0x7070707, v195
	v_lshrrev_b32_e32 v194, 4, v195
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[150:151], v[226:227], v[98:101]
	v_and_b32_e32 v194, 0x7070707, v194
	v_add_u32_e32 v0, 0x7f7f7f00, v202
	v_and_b32_e32 v245, 0x80808000, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[152:153], v[226:227], v[102:105]
	v_perm_b32 v226, v225, v224, v190
	v_lshlrev_b32_e32 v227, 4, v195
	v_perm_b32 v190, v223, v222, v190
	v_and_or_b32 v190, v226, v227, v190
	v_perm_b32 v226, v225, v224, v194
	v_perm_b32 v194, v223, v222, v194
	v_and_or_b32 v195, v226, v195, v194
	v_perm_b32 v194, v195, v190, s39
	v_perm_b32 v195, v195, v190, s40
	v_and_b32_e32 v190, 0x7070707, v191
	v_lshrrev_b32_e32 v226, 4, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[150:151], v[228:229], v[106:109]
	v_and_b32_e32 v226, 0x7070707, v226
	v_perm_b32 v227, v233, v232, v190
	v_perm_b32 v190, v231, v230, v190
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[152:153], v[228:229], v[110:113]
	v_lshlrev_b32_e32 v228, 4, v191
	v_and_or_b32 v227, v227, v228, v190
	v_perm_b32 v190, v233, v232, v226
	v_perm_b32 v226, v231, v230, v226
	v_and_or_b32 v191, v190, v191, v226
	v_or_b32_e32 v226, s42, v240
	v_perm_b32 v190, v191, v227, s39
	v_perm_b32 v191, v191, v227, s40
	v_or_b32_e32 v227, v226, v201
	v_or_b32_e32 v226, v226, v242
	ds_read_b64 a[16:17], v227
	ds_read_b64 a[18:19], v226
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], a[16:17], v[190:191], v[106:109]
	v_lshlrev_b32_e32 v226, 4, v192
	v_add_u32_e32 v0, 0x7f7f7f78, v200
	v_and_b32_e32 v0, 0x80808080, v0
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], a[18:19], v[190:191], v[110:113]
	v_and_b32_e32 v190, 0x7070707, v196
	v_lshrrev_b32_e32 v191, 4, v196
	v_and_b32_e32 v191, 0x7070707, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], a[16:17], v[194:195], v[98:101]
	s_mov_b32 s49, s41
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], a[18:19], v[194:195], v[102:105]
	v_perm_b32 v194, v225, v224, v190
	v_lshlrev_b32_e32 v195, 4, v196
	v_perm_b32 v190, v223, v222, v190
	v_and_or_b32 v194, v194, v195, v190
	v_perm_b32 v190, v225, v224, v191
	v_perm_b32 v191, v223, v222, v191
	v_and_or_b32 v191, v190, v196, v191
	v_perm_b32 v190, v191, v194, s39
	v_perm_b32 v191, v191, v194, s40
	v_and_b32_e32 v194, 0x7070707, v192
	v_lshrrev_b32_e32 v195, 4, v192
	v_and_b32_e32 v195, 0x7070707, v195
	v_perm_b32 v196, v233, v232, v194
	v_perm_b32 v194, v231, v230, v194
	v_and_or_b32 v196, v196, v226, v194
	v_perm_b32 v194, v233, v232, v195
	v_perm_b32 v195, v231, v230, v195
	v_and_or_b32 v192, v194, v192, v195
	v_perm_b32 v194, v192, v196, s39
	v_perm_b32 v195, v192, v196, s40
	v_accvgpr_read_b32 v192, a34
	v_or_b32_e32 v192, s42, v192
	v_or_b32_e32 v196, v192, v201
	v_or_b32_e32 v192, v192, v242
	ds_read_b64 a[12:13], v196
	ds_read_b64 a[14:15], v192
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], a[12:13], v[190:191], v[98:101]
	v_lshlrev_b32_e32 v196, 4, v193
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], a[14:15], v[190:191], v[102:105]
	v_and_b32_e32 v190, 0x7070707, v197
	v_lshrrev_b32_e32 v191, 4, v197
	v_and_b32_e32 v191, 0x7070707, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], a[12:13], v[194:195], v[106:109]
	v_perm_b32 v192, v225, v224, v190
	v_perm_b32 v190, v223, v222, v190
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], a[14:15], v[194:195], v[110:113]
	v_lshlrev_b32_e32 v194, 4, v197
	v_and_or_b32 v192, v192, v194, v190
	v_perm_b32 v190, v225, v224, v191
	v_perm_b32 v191, v223, v222, v191
	v_and_or_b32 v191, v190, v197, v191
	v_perm_b32 v190, v191, v192, s39
	v_perm_b32 v191, v191, v192, s40
	v_and_b32_e32 v192, 0x7070707, v193
	v_lshrrev_b32_e32 v194, 4, v193
	v_and_b32_e32 v194, 0x7070707, v194
	v_perm_b32 v195, v233, v232, v192
	v_perm_b32 v192, v231, v230, v192
	v_and_or_b32 v195, v195, v196, v192
	v_perm_b32 v192, v233, v232, v194
	v_perm_b32 v194, v231, v230, v194
	v_and_or_b32 v193, v192, v193, v194
	v_accvgpr_read_b32 v194, a31
	v_or_b32_e32 v194, s42, v194
	v_perm_b32 v192, v193, v195, s39
	v_perm_b32 v193, v193, v195, s40
	v_or_b32_e32 v195, v194, v201
	v_or_b32_e32 v194, v194, v242
	ds_read_b64 a[8:9], v195
	ds_read_b64 a[10:11], v194
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], a[8:9], v[190:191], v[98:101]
	v_lshlrev_b32_e32 v194, 4, v138
	v_lshlrev_b32_e32 v232, 4, v178
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], a[10:11], v[190:191], v[102:105]
	v_and_b32_e32 v190, 0x7070707, v186
	v_lshrrev_b32_e32 v191, 4, v186
	v_and_b32_e32 v191, 0x7070707, v191
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], a[8:9], v[192:193], v[106:109]
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], a[10:11], v[192:193], v[110:113]
	v_perm_b32 v192, v0, v245, v190
	v_lshlrev_b32_e32 v193, 4, v186
	v_perm_b32 v190, v200, v202, v190
	v_and_or_b32 v192, v192, v193, v190
	v_perm_b32 v190, v0, v245, v191
	v_perm_b32 v191, v200, v202, v191
	v_and_or_b32 v186, v190, v186, v191
	v_perm_b32 v190, v186, v192, s39
	v_perm_b32 v191, v186, v192, s40
	v_and_b32_e32 v186, 0x7070707, v138
	v_lshrrev_b32_e32 v192, 4, v138
	v_and_b32_e32 v192, 0x7070707, v192
	v_perm_b32 v193, v221, v220, v186
	v_perm_b32 v186, v198, v203, v186
	v_and_or_b32 v186, v193, v194, v186
	v_perm_b32 v193, v221, v220, v192
	v_perm_b32 v192, v198, v203, v192
	v_and_or_b32 v138, v193, v138, v192
	v_perm_b32 v192, v138, v186, s39
	v_perm_b32 v193, v138, v186, s40
	v_accvgpr_read_b32 v138, a30
	v_or_b32_e32 v138, s42, v138
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
	v_perm_b32 v190, v0, v245, v138
	v_lshlrev_b32_e32 v191, 4, v187
	v_perm_b32 v138, v200, v202, v138
	v_and_or_b32 v138, v190, v191, v138
	v_perm_b32 v190, v0, v245, v186
	v_perm_b32 v186, v200, v202, v186
	v_and_or_b32 v187, v190, v187, v186
	v_perm_b32 v186, v187, v138, s39
	v_perm_b32 v187, v187, v138, s40
	v_and_b32_e32 v138, 0x7070707, v139
	v_lshrrev_b32_e32 v190, 4, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[222:223], v[192:193], v[106:109]
	v_and_b32_e32 v190, 0x7070707, v190
	v_perm_b32 v191, v221, v220, v138
	v_perm_b32 v138, v198, v203, v138
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[224:225], v[192:193], v[110:113]
	v_lshlrev_b32_e32 v192, 4, v139
	v_and_or_b32 v191, v191, v192, v138
	v_perm_b32 v138, v221, v220, v190
	v_perm_b32 v190, v198, v203, v190
	v_and_or_b32 v139, v138, v139, v190
	v_accvgpr_read_b32 v190, a29
	v_or_b32_e32 v190, s42, v190
	v_perm_b32 v138, v139, v191, s39
	v_perm_b32 v139, v139, v191, s40
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
	v_perm_b32 v186, v0, v245, v138
	v_lshlrev_b32_e32 v187, 4, v188
	v_perm_b32 v138, v200, v202, v138
	v_and_or_b32 v186, v186, v187, v138
	v_perm_b32 v138, v0, v245, v139
	v_perm_b32 v139, v200, v202, v139
	v_and_or_b32 v139, v138, v188, v139
	v_perm_b32 v138, v139, v186, s39
	v_perm_b32 v139, v139, v186, s40
	v_and_b32_e32 v186, 0x7070707, v140
	v_lshrrev_b32_e32 v187, 4, v140
	v_and_b32_e32 v187, 0x7070707, v187
	v_perm_b32 v188, v221, v220, v186
	v_perm_b32 v186, v198, v203, v186
	v_and_or_b32 v188, v188, v190, v186
	v_perm_b32 v186, v221, v220, v187
	v_perm_b32 v187, v198, v203, v187
	v_and_or_b32 v140, v186, v140, v187
	v_perm_b32 v186, v140, v188, s39
	v_perm_b32 v187, v140, v188, s40
	v_accvgpr_read_b32 v140, a28
	v_or_b32_e32 v140, s42, v140
	v_or_b32_e32 v188, v140, v201
	v_or_b32_e32 v140, v140, v242
	ds_read_b64 v[190:191], v188
	ds_read_b64 v[192:193], v140
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[190:191], v[138:139], v[98:101]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[192:193], v[138:139], v[102:105]
	v_lshrrev_b32_e32 v139, 4, v189
	v_and_b32_e32 v138, 0x7070707, v189
	v_and_b32_e32 v139, 0x7070707, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[190:191], v[186:187], v[106:109]
	v_perm_b32 v140, v0, v245, v138
	v_perm_b32 v138, v200, v202, v138
	v_perm_b32 v0, v0, v245, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[192:193], v[186:187], v[110:113]
	v_lshlrev_b32_e32 v186, 4, v189
	v_perm_b32 v139, v200, v202, v139
	v_and_or_b32 v138, v140, v186, v138
	v_and_or_b32 v0, v0, v189, v139
	v_perm_b32 v186, v0, v138, s39
	v_perm_b32 v187, v0, v138, s40
	v_and_b32_e32 v0, 0x7070707, v141
	v_lshrrev_b32_e32 v138, 4, v141
	v_and_b32_e32 v138, 0x7070707, v138
	v_perm_b32 v139, v221, v220, v0
	v_lshlrev_b32_e32 v140, 4, v141
	v_perm_b32 v0, v198, v203, v0
	v_and_or_b32 v0, v139, v140, v0
	v_perm_b32 v139, v221, v220, v138
	v_perm_b32 v138, v198, v203, v138
	v_and_or_b32 v138, v139, v141, v138
	v_perm_b32 v188, v138, v0, s39
	v_perm_b32 v189, v138, v0, s40
	v_accvgpr_read_b32 v0, a25
	v_or_b32_e32 v0, s42, v0
	ds_read2st64_b64 v[138:141], v0 offset1:8
	v_sub_u32_e32 v0, v213, v205
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[138:139], v[186:187], v[98:101]
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v198, v211, v204
	v_lshlrev_b32_e32 v203, 4, v182
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[140:141], v[186:187], v[102:105]
	v_min_i32_e32 v186, 11, v0
	v_mul_lo_u32 v186, v186, s38
	v_sub_u32_e32 v187, 0x6c686080, v186
	v_and_b32_e32 v187, 0xffffff00, v187
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[138:139], v[188:189], v[106:109]
	v_sub_u32_e32 v186, 0x7c787470, v186
	v_cndmask_b32_e64 v200, v186, 0, vcc
	s_xor_b32 s42, s42, 0x2000
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[140:141], v[188:189], v[110:113]
	v_cndmask_b32_e64 v189, v187, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v189
	v_and_b32_e32 v205, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v200
	v_and_b32_e32 v220, 0x80808080, v0
	v_sub_u32_e32 v0, v213, v199
	v_min_i32_e32 v186, 11, v0
	v_mul_lo_u32 v186, v186, s38
	v_min_i32_e32 v199, 11, v198
	v_sub_u32_e32 v187, 0x6c686080, v186
	v_mul_lo_u32 v199, v199, s38
	v_and_b32_e32 v187, 0xffffff00, v187
	v_sub_u32_e32 v186, 0x7c787470, v186
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v202, 0x6c686080, v199
	v_and_b32_e32 v202, 0xffffff00, v202
	v_cndmask_b32_e64 v0, v187, 0, vcc
	v_cndmask_b32_e64 v186, v186, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v198
	v_sub_u32_e32 v199, 0x7c787470, v199
	v_add_u32_e32 v187, 0x7f7f7f00, v0
	v_cndmask_b32_e64 v204, v202, 0, vcc
	v_cndmask_b32_e64 v221, v199, 0, vcc
	v_add_u32_e32 v198, 0x7f7f7f00, v204
	v_and_b32_e32 v226, 0x80808000, v198
	v_add_u32_e32 v198, 0x7f7f7f78, v221
	v_and_b32_e32 v227, 0x80808080, v198
	v_sub_u32_e32 v198, v211, v255
	v_min_i32_e32 v199, 11, v198
	v_mul_lo_u32 v199, v199, s38
	v_sub_u32_e32 v202, 0x6c686080, v199
	v_and_b32_e32 v202, 0xffffff00, v202
	v_cmp_lt_i32_e32 vcc, 11, v198
	v_sub_u32_e32 v199, 0x7c787470, v199
	v_add_u32_e32 v188, 0x7f7f7f78, v186
	v_cndmask_b32_e64 v228, v202, 0, vcc
	v_cndmask_b32_e64 v229, v199, 0, vcc
	v_add_u32_e32 v198, 0x7f7f7f00, v228
	v_and_b32_e32 v230, 0x80808000, v198
	v_add_u32_e32 v198, 0x7f7f7f78, v229
	v_and_b32_e32 v231, 0x80808080, v198
	v_and_b32_e32 v198, 0x7070707, v182
	v_lshrrev_b32_e32 v199, 4, v182
	v_and_b32_e32 v199, 0x7070707, v199
	v_perm_b32 v202, v220, v205, v198
	v_perm_b32 v198, v200, v189, v198
	v_and_or_b32 v202, v202, v203, v198
	v_perm_b32 v198, v220, v205, v199
	v_perm_b32 v199, v200, v189, v199
	v_and_or_b32 v182, v198, v182, v199
	v_perm_b32 v198, v182, v202, s39
	v_perm_b32 v199, v182, v202, s40
	v_and_b32_e32 v182, 0x7070707, v178
	v_lshrrev_b32_e32 v202, 4, v178
	v_and_b32_e32 v202, 0x7070707, v202
	v_perm_b32 v203, v227, v226, v182
	v_perm_b32 v182, v221, v204, v182
	v_and_or_b32 v182, v203, v232, v182
	v_perm_b32 v203, v227, v226, v202
	v_perm_b32 v202, v221, v204, v202
	v_and_or_b32 v178, v203, v178, v202
	v_perm_b32 v202, v178, v182, s39
	v_perm_b32 v203, v178, v182, s40
	v_and_b32_e32 v178, 0x7070707, v183
	v_lshrrev_b32_e32 v182, 4, v183
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[150:151], v[198:199], v[74:77]
	v_and_b32_e32 v182, 0x7070707, v182
	v_and_b32_e32 v187, 0x80808000, v187
	v_and_b32_e32 v188, 0x80808080, v188
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[152:153], v[198:199], v[78:81]
	v_perm_b32 v198, v220, v205, v178
	v_lshlrev_b32_e32 v199, 4, v183
	v_perm_b32 v178, v200, v189, v178
	v_and_or_b32 v178, v198, v199, v178
	v_perm_b32 v198, v220, v205, v182
	v_perm_b32 v182, v200, v189, v182
	v_and_or_b32 v183, v198, v183, v182
	v_perm_b32 v182, v183, v178, s39
	v_perm_b32 v183, v183, v178, s40
	v_and_b32_e32 v178, 0x7070707, v179
	v_lshrrev_b32_e32 v198, 4, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[150:151], v[202:203], v[82:85]
	v_and_b32_e32 v198, 0x7070707, v198
	v_perm_b32 v199, v227, v226, v178
	v_perm_b32 v178, v221, v204, v178
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[152:153], v[202:203], v[86:89]
	v_lshlrev_b32_e32 v202, 4, v179
	v_and_or_b32 v199, v199, v202, v178
	v_perm_b32 v178, v227, v226, v198
	v_perm_b32 v198, v221, v204, v198
	v_and_or_b32 v179, v178, v179, v198
	v_perm_b32 v178, v179, v199, s39
	v_perm_b32 v179, v179, v199, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], a[16:17], v[182:183], v[74:77]
	v_lshlrev_b32_e32 v198, 4, v180
	s_cmp_lg_u32 s41, 15
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], a[16:17], v[178:179], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], a[18:19], v[178:179], v[86:89]
	v_and_b32_e32 v178, 0x7070707, v184
	v_lshrrev_b32_e32 v179, 4, v184
	v_and_b32_e32 v179, 0x7070707, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], a[18:19], v[182:183], v[78:81]
	v_perm_b32 v182, v220, v205, v178
	v_lshlrev_b32_e32 v183, 4, v184
	v_perm_b32 v178, v200, v189, v178
	v_and_or_b32 v182, v182, v183, v178
	v_perm_b32 v178, v220, v205, v179
	v_perm_b32 v179, v200, v189, v179
	v_and_or_b32 v179, v178, v184, v179
	v_perm_b32 v178, v179, v182, s39
	v_perm_b32 v179, v179, v182, s40
	v_and_b32_e32 v182, 0x7070707, v180
	v_lshrrev_b32_e32 v183, 4, v180
	v_and_b32_e32 v183, 0x7070707, v183
	v_perm_b32 v184, v227, v226, v182
	v_perm_b32 v182, v221, v204, v182
	v_and_or_b32 v184, v184, v198, v182
	v_perm_b32 v182, v227, v226, v183
	v_perm_b32 v183, v221, v204, v183
	v_and_or_b32 v180, v182, v180, v183
	v_perm_b32 v182, v180, v184, s39
	v_perm_b32 v183, v180, v184, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], a[12:13], v[178:179], v[74:77]
	v_lshlrev_b32_e32 v184, 4, v181
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], a[14:15], v[178:179], v[78:81]
	v_and_b32_e32 v178, 0x7070707, v185
	v_lshrrev_b32_e32 v179, 4, v185
	v_and_b32_e32 v179, 0x7070707, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], a[12:13], v[182:183], v[82:85]
	v_perm_b32 v180, v220, v205, v178
	v_perm_b32 v178, v200, v189, v178
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], a[14:15], v[182:183], v[86:89]
	v_lshlrev_b32_e32 v182, 4, v185
	v_and_or_b32 v180, v180, v182, v178
	v_perm_b32 v178, v220, v205, v179
	v_perm_b32 v179, v200, v189, v179
	v_and_or_b32 v179, v178, v185, v179
	v_perm_b32 v178, v179, v180, s39
	v_perm_b32 v179, v179, v180, s40
	v_and_b32_e32 v180, 0x7070707, v181
	v_lshrrev_b32_e32 v182, 4, v181
	v_and_b32_e32 v182, 0x7070707, v182
	v_perm_b32 v183, v227, v226, v180
	v_perm_b32 v180, v221, v204, v180
	v_and_or_b32 v183, v183, v184, v180
	v_perm_b32 v180, v227, v226, v182
	v_perm_b32 v182, v221, v204, v182
	v_and_or_b32 v181, v180, v181, v182
	v_perm_b32 v180, v181, v183, s39
	v_perm_b32 v181, v181, v183, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], a[8:9], v[178:179], v[74:77]
	v_lshlrev_b32_e32 v182, 4, v170
	v_lshlrev_b32_e32 v189, 4, v162
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], a[10:11], v[178:179], v[78:81]
	v_and_b32_e32 v178, 0x7070707, v174
	v_lshrrev_b32_e32 v179, 4, v174
	v_and_b32_e32 v179, 0x7070707, v179
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], a[8:9], v[180:181], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], a[10:11], v[180:181], v[86:89]
	v_perm_b32 v180, v188, v187, v178
	v_lshlrev_b32_e32 v181, 4, v174
	v_perm_b32 v178, v186, v0, v178
	v_and_or_b32 v180, v180, v181, v178
	v_perm_b32 v178, v188, v187, v179
	v_perm_b32 v179, v186, v0, v179
	v_and_or_b32 v174, v178, v174, v179
	v_perm_b32 v178, v174, v180, s39
	v_perm_b32 v179, v174, v180, s40
	v_and_b32_e32 v174, 0x7070707, v170
	v_lshrrev_b32_e32 v180, 4, v170
	v_and_b32_e32 v180, 0x7070707, v180
	v_perm_b32 v181, v231, v230, v174
	v_perm_b32 v174, v229, v228, v174
	v_and_or_b32 v174, v181, v182, v174
	v_perm_b32 v181, v231, v230, v180
	v_perm_b32 v180, v229, v228, v180
	v_and_or_b32 v170, v181, v170, v180
	v_perm_b32 v180, v170, v174, s39
	v_perm_b32 v181, v170, v174, s40
	v_and_b32_e32 v170, 0x7070707, v175
	v_lshrrev_b32_e32 v174, 4, v175
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[222:223], v[178:179], v[74:77]
	v_and_b32_e32 v174, 0x7070707, v174
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[224:225], v[178:179], v[78:81]
	v_perm_b32 v178, v188, v187, v170
	v_lshlrev_b32_e32 v179, 4, v175
	v_perm_b32 v170, v186, v0, v170
	v_and_or_b32 v170, v178, v179, v170
	v_perm_b32 v178, v188, v187, v174
	v_perm_b32 v174, v186, v0, v174
	v_and_or_b32 v175, v178, v175, v174
	v_perm_b32 v174, v175, v170, s39
	v_perm_b32 v175, v175, v170, s40
	v_and_b32_e32 v170, 0x7070707, v171
	v_lshrrev_b32_e32 v178, 4, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[222:223], v[180:181], v[82:85]
	v_and_b32_e32 v178, 0x7070707, v178
	v_perm_b32 v179, v231, v230, v170
	v_perm_b32 v170, v229, v228, v170
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[224:225], v[180:181], v[86:89]
	v_lshlrev_b32_e32 v180, 4, v171
	v_and_or_b32 v179, v179, v180, v170
	v_perm_b32 v170, v231, v230, v178
	v_perm_b32 v178, v229, v228, v178
	v_and_or_b32 v171, v170, v171, v178
	v_perm_b32 v170, v171, v179, s39
	v_perm_b32 v171, v171, v179, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[194:195], v[174:175], v[74:77]
	v_lshlrev_b32_e32 v178, 4, v172
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[194:195], v[170:171], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[196:197], v[170:171], v[86:89]
	v_and_b32_e32 v170, 0x7070707, v176
	v_lshrrev_b32_e32 v171, 4, v176
	v_and_b32_e32 v171, 0x7070707, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[196:197], v[174:175], v[78:81]
	v_perm_b32 v174, v188, v187, v170
	v_lshlrev_b32_e32 v175, 4, v176
	v_perm_b32 v170, v186, v0, v170
	v_and_or_b32 v174, v174, v175, v170
	v_perm_b32 v170, v188, v187, v171
	v_perm_b32 v171, v186, v0, v171
	v_and_or_b32 v171, v170, v176, v171
	v_perm_b32 v170, v171, v174, s39
	v_perm_b32 v171, v171, v174, s40
	v_and_b32_e32 v174, 0x7070707, v172
	v_lshrrev_b32_e32 v175, 4, v172
	v_and_b32_e32 v175, 0x7070707, v175
	v_perm_b32 v176, v231, v230, v174
	v_perm_b32 v174, v229, v228, v174
	v_and_or_b32 v176, v176, v178, v174
	v_perm_b32 v174, v231, v230, v175
	v_perm_b32 v175, v229, v228, v175
	v_and_or_b32 v172, v174, v172, v175
	v_perm_b32 v174, v172, v176, s39
	v_perm_b32 v175, v172, v176, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[190:191], v[170:171], v[74:77]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[192:193], v[170:171], v[78:81]
	v_and_b32_e32 v170, 0x7070707, v177
	v_lshrrev_b32_e32 v171, 4, v177
	v_and_b32_e32 v171, 0x7070707, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[190:191], v[174:175], v[82:85]
	v_perm_b32 v172, v188, v187, v170
	v_perm_b32 v170, v186, v0, v170
	v_perm_b32 v0, v186, v0, v171
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[192:193], v[174:175], v[86:89]
	v_lshlrev_b32_e32 v174, 4, v177
	v_and_or_b32 v172, v172, v174, v170
	v_perm_b32 v170, v188, v187, v171
	v_and_or_b32 v0, v170, v177, v0
	v_perm_b32 v170, v0, v172, s39
	v_perm_b32 v171, v0, v172, s40
	v_and_b32_e32 v0, 0x7070707, v173
	v_lshrrev_b32_e32 v172, 4, v173
	v_and_b32_e32 v172, 0x7070707, v172
	v_perm_b32 v174, v231, v230, v0
	v_lshlrev_b32_e32 v175, 4, v173
	v_perm_b32 v0, v229, v228, v0
	v_and_or_b32 v0, v174, v175, v0
	v_perm_b32 v174, v231, v230, v172
	v_perm_b32 v172, v229, v228, v172
	v_and_or_b32 v173, v174, v173, v172
	v_perm_b32 v172, v173, v0, s39
	v_perm_b32 v173, v173, v0, s40
	v_sub_u32_sdwa v0, v208, v254 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[138:139], v[170:171], v[74:77]
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[140:141], v[170:171], v[78:81]
	v_min_i32_e32 v170, 11, v0
	v_mul_lo_u32 v170, v170, s38
	v_sub_u32_e32 v171, 0x6c686080, v170
	v_and_b32_e32 v171, 0xffffff00, v171
	v_sub_u32_e32 v170, 0x7c787470, v170
	v_cndmask_b32_e64 v0, v171, 0, vcc
	v_cndmask_b32_e64 v174, v170, 0, vcc
	v_add_u32_e32 v170, 0x7f7f7f00, v0
	v_and_b32_e32 v175, 0x80808000, v170
	v_add_u32_e32 v170, 0x7f7f7f78, v174
	v_and_b32_e32 v176, 0x80808080, v170
	v_sub_u32_sdwa v170, v208, v254 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v171, 11, v170
	v_mul_lo_u32 v171, v171, s38
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[138:139], v[172:173], v[82:85]
	v_cmp_lt_i32_e32 vcc, 11, v170
	s_waitcnt vmcnt(21)
	v_mov_b32_e32 v254, v217
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[140:141], v[172:173], v[86:89]
	v_sub_u32_e32 v172, 0x6c686080, v171
	v_and_b32_e32 v172, 0xffffff00, v172
	v_sub_u32_e32 v171, 0x7c787470, v171
	v_cndmask_b32_e64 v177, v172, 0, vcc
	v_cndmask_b32_e64 v178, v171, 0, vcc
	v_add_u32_e32 v170, 0x7f7f7f00, v177
	v_and_b32_e32 v179, 0x80808000, v170
	v_add_u32_e32 v170, 0x7f7f7f78, v178
	v_and_b32_e32 v180, 0x80808080, v170
	v_sub_u32_sdwa v170, v206, v249 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v171, 11, v170
	v_mul_lo_u32 v171, v171, s38
	v_sub_u32_e32 v172, 0x6c686080, v171
	v_and_b32_e32 v172, 0xffffff00, v172
	v_cmp_lt_i32_e32 vcc, 11, v170
	v_sub_u32_e32 v171, 0x7c787470, v171
	v_lshlrev_b32_e32 v173, 4, v166
	v_cndmask_b32_e64 v181, v172, 0, vcc
	v_cndmask_b32_e64 v182, v171, 0, vcc
	v_add_u32_e32 v170, 0x7f7f7f00, v181
	v_and_b32_e32 v183, 0x80808000, v170
	v_add_u32_e32 v170, 0x7f7f7f78, v182
	v_and_b32_e32 v184, 0x80808080, v170
	v_sub_u32_sdwa v170, v206, v249 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v171, 11, v170
	v_mul_lo_u32 v171, v171, s38
	v_sub_u32_e32 v172, 0x6c686080, v171
	v_and_b32_e32 v172, 0xffffff00, v172
	v_cmp_lt_i32_e32 vcc, 11, v170
	v_sub_u32_e32 v171, 0x7c787470, v171
	s_waitcnt vmcnt(17)
	v_mov_b32_e32 v249, v216
	v_cndmask_b32_e64 v185, v172, 0, vcc
	v_cndmask_b32_e64 v186, v171, 0, vcc
	v_add_u32_e32 v170, 0x7f7f7f00, v185
	v_and_b32_e32 v187, 0x80808000, v170
	v_add_u32_e32 v170, 0x7f7f7f78, v186
	v_and_b32_e32 v188, 0x80808080, v170
	v_and_b32_e32 v170, 0x7070707, v166
	v_lshrrev_b32_e32 v171, 4, v166
	v_and_b32_e32 v171, 0x7070707, v171
	v_perm_b32 v172, v176, v175, v170
	v_perm_b32 v170, v174, v0, v170
	v_and_or_b32 v172, v172, v173, v170
	v_perm_b32 v170, v176, v175, v171
	v_perm_b32 v171, v174, v0, v171
	v_and_or_b32 v166, v170, v166, v171
	v_perm_b32 v170, v166, v172, s39
	v_perm_b32 v171, v166, v172, s40
	v_and_b32_e32 v166, 0x7070707, v162
	v_lshrrev_b32_e32 v172, 4, v162
	v_and_b32_e32 v172, 0x7070707, v172
	v_perm_b32 v173, v184, v183, v166
	v_perm_b32 v166, v182, v181, v166
	v_and_or_b32 v166, v173, v189, v166
	v_perm_b32 v173, v184, v183, v172
	v_perm_b32 v172, v182, v181, v172
	v_and_or_b32 v162, v173, v162, v172
	v_perm_b32 v172, v162, v166, s39
	v_perm_b32 v173, v162, v166, s40
	v_and_b32_e32 v162, 0x7070707, v167
	v_lshrrev_b32_e32 v166, 4, v167
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[150:151], v[170:171], v[34:37]
	v_and_b32_e32 v166, 0x7070707, v166
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[152:153], v[170:171], v[38:41]
	v_perm_b32 v170, v176, v175, v162
	v_lshlrev_b32_e32 v171, 4, v167
	v_perm_b32 v162, v174, v0, v162
	v_and_or_b32 v162, v170, v171, v162
	v_perm_b32 v170, v176, v175, v166
	v_perm_b32 v166, v174, v0, v166
	v_and_or_b32 v167, v170, v167, v166
	v_perm_b32 v166, v167, v162, s39
	v_perm_b32 v167, v167, v162, s40
	v_and_b32_e32 v162, 0x7070707, v163
	v_lshrrev_b32_e32 v170, 4, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[150:151], v[172:173], v[42:45]
	v_and_b32_e32 v170, 0x7070707, v170
	v_perm_b32 v171, v184, v183, v162
	v_perm_b32 v162, v182, v181, v162
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[152:153], v[172:173], v[50:53]
	v_lshlrev_b32_e32 v172, 4, v163
	v_and_or_b32 v171, v171, v172, v162
	v_perm_b32 v162, v184, v183, v170
	v_perm_b32 v170, v182, v181, v170
	v_and_or_b32 v163, v162, v163, v170
	v_perm_b32 v162, v163, v171, s39
	v_perm_b32 v163, v163, v171, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], a[16:17], v[166:167], v[34:37]
	v_lshlrev_b32_e32 v170, 4, v164
	v_lshlrev_b32_e32 v172, 4, v146
	v_lshlrev_b32_e32 v173, 4, v142
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], a[16:17], v[162:163], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], a[18:19], v[162:163], v[50:53]
	v_and_b32_e32 v162, 0x7070707, v168
	v_lshrrev_b32_e32 v163, 4, v168
	v_and_b32_e32 v163, 0x7070707, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], a[18:19], v[166:167], v[38:41]
	v_perm_b32 v166, v176, v175, v162
	v_lshlrev_b32_e32 v167, 4, v168
	v_perm_b32 v162, v174, v0, v162
	v_and_or_b32 v166, v166, v167, v162
	v_perm_b32 v162, v176, v175, v163
	v_perm_b32 v163, v174, v0, v163
	v_and_or_b32 v163, v162, v168, v163
	v_perm_b32 v162, v163, v166, s39
	v_perm_b32 v163, v163, v166, s40
	v_and_b32_e32 v166, 0x7070707, v164
	v_lshrrev_b32_e32 v167, 4, v164
	v_and_b32_e32 v167, 0x7070707, v167
	v_perm_b32 v168, v184, v183, v166
	v_perm_b32 v166, v182, v181, v166
	v_and_or_b32 v168, v168, v170, v166
	v_perm_b32 v166, v184, v183, v167
	v_perm_b32 v167, v182, v181, v167
	v_and_or_b32 v164, v166, v164, v167
	v_perm_b32 v166, v164, v168, s39
	v_perm_b32 v167, v164, v168, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], a[12:13], v[162:163], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], a[14:15], v[162:163], v[38:41]
	v_and_b32_e32 v162, 0x7070707, v169
	v_lshrrev_b32_e32 v163, 4, v169
	v_and_b32_e32 v163, 0x7070707, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], a[12:13], v[166:167], v[42:45]
	v_perm_b32 v164, v176, v175, v162
	v_perm_b32 v162, v174, v0, v162
	v_perm_b32 v0, v174, v0, v163
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], a[14:15], v[166:167], v[50:53]
	v_lshlrev_b32_e32 v166, 4, v169
	v_and_or_b32 v164, v164, v166, v162
	v_perm_b32 v162, v176, v175, v163
	v_and_or_b32 v0, v162, v169, v0
	v_perm_b32 v162, v0, v164, s39
	v_perm_b32 v163, v0, v164, s40
	v_and_b32_e32 v0, 0x7070707, v165
	v_lshrrev_b32_e32 v164, 4, v165
	v_and_b32_e32 v164, 0x7070707, v164
	v_perm_b32 v166, v184, v183, v0
	v_lshlrev_b32_e32 v167, 4, v165
	v_perm_b32 v0, v182, v181, v0
	v_and_or_b32 v0, v166, v167, v0
	v_perm_b32 v166, v184, v183, v164
	v_perm_b32 v164, v182, v181, v164
	v_and_or_b32 v165, v166, v165, v164
	v_perm_b32 v164, v165, v0, s39
	v_perm_b32 v165, v165, v0, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], a[8:9], v[162:163], v[34:37]
	v_and_b32_e32 v0, 0x7070707, v158
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], a[10:11], v[162:163], v[38:41]
	v_lshrrev_b32_e32 v162, 4, v158
	v_and_b32_e32 v162, 0x7070707, v162
	v_perm_b32 v163, v180, v179, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], a[8:9], v[164:165], v[42:45]
	v_perm_b32 v0, v178, v177, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], a[10:11], v[164:165], v[50:53]
	v_lshlrev_b32_e32 v164, 4, v158
	v_and_or_b32 v0, v163, v164, v0
	v_perm_b32 v163, v180, v179, v162
	v_perm_b32 v162, v178, v177, v162
	v_and_or_b32 v158, v163, v158, v162
	v_perm_b32 v162, v158, v0, s39
	v_perm_b32 v163, v158, v0, s40
	v_and_b32_e32 v0, 0x7070707, v154
	v_lshrrev_b32_e32 v158, 4, v154
	v_and_b32_e32 v158, 0x7070707, v158
	v_perm_b32 v164, v188, v187, v0
	v_lshlrev_b32_e32 v165, 4, v154
	v_perm_b32 v0, v186, v185, v0
	v_and_or_b32 v0, v164, v165, v0
	v_perm_b32 v164, v188, v187, v158
	v_perm_b32 v158, v186, v185, v158
	v_and_or_b32 v154, v164, v154, v158
	v_perm_b32 v164, v154, v0, s39
	v_perm_b32 v165, v154, v0, s40
	v_and_b32_e32 v0, 0x7070707, v159
	v_lshrrev_b32_e32 v154, 4, v159
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[222:223], v[162:163], v[34:37]
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v158, v180, v179, v0
	v_perm_b32 v0, v178, v177, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[224:225], v[162:163], v[38:41]
	v_lshlrev_b32_e32 v162, 4, v159
	v_and_or_b32 v0, v158, v162, v0
	v_perm_b32 v158, v180, v179, v154
	v_perm_b32 v154, v178, v177, v154
	v_and_or_b32 v154, v158, v159, v154
	v_perm_b32 v158, v154, v0, s39
	v_perm_b32 v159, v154, v0, s40
	v_and_b32_e32 v0, 0x7070707, v155
	v_lshrrev_b32_e32 v154, 4, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[222:223], v[164:165], v[42:45]
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v162, v188, v187, v0
	v_lshlrev_b32_e32 v163, 4, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[224:225], v[164:165], v[50:53]
	v_perm_b32 v0, v186, v185, v0
	v_and_or_b32 v0, v162, v163, v0
	v_perm_b32 v162, v188, v187, v154
	v_perm_b32 v154, v186, v185, v154
	v_and_or_b32 v155, v162, v155, v154
	v_perm_b32 v154, v155, v0, s39
	v_perm_b32 v155, v155, v0, s40
	v_and_b32_e32 v0, 0x7070707, v160
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[194:195], v[158:159], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[194:195], v[154:155], v[42:45]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[196:197], v[154:155], v[50:53]
	v_lshrrev_b32_e32 v154, 4, v160
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v155, v180, v179, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[196:197], v[158:159], v[38:41]
	v_lshlrev_b32_e32 v158, 4, v160
	v_perm_b32 v0, v178, v177, v0
	v_and_or_b32 v0, v155, v158, v0
	v_perm_b32 v155, v180, v179, v154
	v_perm_b32 v154, v178, v177, v154
	v_and_or_b32 v155, v155, v160, v154
	v_perm_b32 v154, v155, v0, s39
	v_perm_b32 v155, v155, v0, s40
	v_and_b32_e32 v0, 0x7070707, v156
	v_lshrrev_b32_e32 v158, 4, v156
	v_and_b32_e32 v158, 0x7070707, v158
	v_perm_b32 v159, v188, v187, v0
	v_lshlrev_b32_e32 v160, 4, v156
	v_perm_b32 v0, v186, v185, v0
	v_and_or_b32 v0, v159, v160, v0
	v_perm_b32 v159, v188, v187, v158
	v_perm_b32 v158, v186, v185, v158
	v_and_or_b32 v156, v159, v156, v158
	v_perm_b32 v158, v156, v0, s39
	v_perm_b32 v159, v156, v0, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[190:191], v[154:155], v[34:37]
	v_and_b32_e32 v0, 0x7070707, v161
	v_lshlrev_b32_e32 v156, 4, v161
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[192:193], v[154:155], v[38:41]
	v_lshrrev_b32_e32 v154, 4, v161
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v155, v180, v179, v0
	v_perm_b32 v0, v178, v177, v0
	v_and_or_b32 v0, v155, v156, v0
	v_perm_b32 v155, v180, v179, v154
	v_perm_b32 v154, v178, v177, v154
	v_and_or_b32 v155, v155, v161, v154
	v_perm_b32 v154, v155, v0, s39
	v_perm_b32 v155, v155, v0, s40
	v_and_b32_e32 v0, 0x7070707, v157
	v_lshrrev_b32_e32 v156, 4, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[190:191], v[158:159], v[42:45]
	v_and_b32_e32 v156, 0x7070707, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[192:193], v[158:159], v[50:53]
	v_perm_b32 v158, v188, v187, v0
	v_lshlrev_b32_e32 v159, 4, v157
	v_perm_b32 v0, v186, v185, v0
	v_and_or_b32 v0, v158, v159, v0
	v_perm_b32 v158, v188, v187, v156
	v_perm_b32 v156, v186, v185, v156
	v_and_or_b32 v157, v158, v157, v156
	v_perm_b32 v156, v157, v0, s39
	v_perm_b32 v157, v157, v0, s40
	v_sub_u32_e32 v0, v209, v253
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[138:139], v[154:155], v[34:37]
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[140:141], v[154:155], v[38:41]
	v_min_i32_e32 v154, 11, v0
	v_mul_lo_u32 v154, v154, s38
	v_sub_u32_e32 v155, 0x6c686080, v154
	v_and_b32_e32 v155, 0xffffff00, v155
	v_sub_u32_e32 v154, 0x7c787470, v154
	v_cndmask_b32_e64 v166, v155, 0, vcc
	v_cndmask_b32_e64 v167, v154, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v166
	v_and_b32_e32 v170, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v167
	v_and_b32_e32 v171, 0x80808080, v0
	v_sub_u32_e32 v0, v209, v252
	v_min_i32_e32 v154, 11, v0
	v_mul_lo_u32 v154, v154, s38
	v_sub_u32_e32 v155, 0x6c686080, v154
	v_and_b32_e32 v155, 0xffffff00, v155
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v154, 0x7c787470, v154
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[138:139], v[156:157], v[42:45]
	v_cndmask_b32_e64 v160, v155, 0, vcc
	v_cndmask_b32_e64 v161, v154, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v160
	v_and_b32_e32 v162, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v161
	v_and_b32_e32 v163, 0x80808080, v0
	v_sub_u32_e32 v0, v207, v251
	v_min_i32_e32 v154, 11, v0
	v_mul_lo_u32 v154, v154, s38
	v_sub_u32_e32 v155, 0x6c686080, v154
	v_and_b32_e32 v155, 0xffffff00, v155
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v154, 0x7c787470, v154
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[140:141], v[156:157], v[50:53]
	v_cndmask_b32_e64 v164, v155, 0, vcc
	v_cndmask_b32_e64 v165, v154, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v164
	v_and_b32_e32 v168, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v165
	v_and_b32_e32 v169, 0x80808080, v0
	v_sub_u32_e32 v0, v207, v250
	v_min_i32_e32 v154, 11, v0
	v_mul_lo_u32 v154, v154, s38
	v_sub_u32_e32 v155, 0x6c686080, v154
	v_and_b32_e32 v155, 0xffffff00, v155
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v154, 0x7c787470, v154
	s_nop 0
	v_cndmask_b32_e64 v156, v155, 0, vcc
	v_cndmask_b32_e64 v157, v154, 0, vcc
	v_add_u32_e32 v0, 0x7f7f7f00, v156
	v_and_b32_e32 v158, 0x80808000, v0
	v_add_u32_e32 v0, 0x7f7f7f78, v157
	v_and_b32_e32 v159, 0x80808080, v0
	v_and_b32_e32 v0, 0x7070707, v146
	v_lshrrev_b32_e32 v154, 4, v146
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v155, v171, v170, v0
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v0, v155, v172, v0
	v_perm_b32 v155, v171, v170, v154
	v_perm_b32 v154, v167, v166, v154
	v_and_or_b32 v146, v155, v146, v154
	v_perm_b32 v154, v146, v0, s39
	v_perm_b32 v155, v146, v0, s40
	v_and_b32_e32 v0, 0x7070707, v142
	v_lshrrev_b32_e32 v146, 4, v142
	v_and_b32_e32 v146, 0x7070707, v146
	v_perm_b32 v172, v169, v168, v0
	v_perm_b32 v0, v165, v164, v0
	v_and_or_b32 v0, v172, v173, v0
	v_perm_b32 v172, v169, v168, v146
	v_perm_b32 v146, v165, v164, v146
	v_and_or_b32 v142, v172, v142, v146
	v_perm_b32 v172, v142, v0, s39
	v_perm_b32 v173, v142, v0, s40
	v_and_b32_e32 v0, 0x7070707, v147
	v_lshrrev_b32_e32 v142, 4, v147
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[150:151], v[154:155], v[118:121]
	v_and_b32_e32 v142, 0x7070707, v142
	v_perm_b32 v146, v171, v170, v0
	v_perm_b32 v0, v167, v166, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[150:151], v[172:173], v[126:129]
	v_lshlrev_b32_e32 v150, 4, v147
	v_and_or_b32 v0, v146, v150, v0
	v_perm_b32 v146, v171, v170, v142
	v_perm_b32 v142, v167, v166, v142
	v_and_or_b32 v142, v146, v147, v142
	v_perm_b32 v146, v142, v0, s39
	v_perm_b32 v147, v142, v0, s40
	v_and_b32_e32 v0, 0x7070707, v143
	v_lshrrev_b32_e32 v142, 4, v143
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[152:153], v[172:173], v[122:125]
	v_and_b32_e32 v142, 0x7070707, v142
	v_perm_b32 v150, v169, v168, v0
	v_lshlrev_b32_e32 v151, 4, v143
	v_perm_b32 v0, v165, v164, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[152:153], v[154:155], v[114:117]
	v_and_or_b32 v0, v150, v151, v0
	v_perm_b32 v150, v169, v168, v142
	v_perm_b32 v142, v165, v164, v142
	v_and_or_b32 v143, v150, v143, v142
	v_perm_b32 v142, v143, v0, s39
	v_perm_b32 v143, v143, v0, s40
	v_and_b32_e32 v0, 0x7070707, v148
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], a[16:17], v[146:147], v[118:121]
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], a[16:17], v[142:143], v[126:129]
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], a[18:19], v[142:143], v[122:125]
	v_lshrrev_b32_e32 v142, 4, v148
	v_and_b32_e32 v142, 0x7070707, v142
	v_perm_b32 v143, v171, v170, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], a[18:19], v[146:147], v[114:117]
	v_lshlrev_b32_e32 v146, 4, v148
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v0, v143, v146, v0
	v_perm_b32 v143, v171, v170, v142
	v_perm_b32 v142, v167, v166, v142
	v_and_or_b32 v143, v143, v148, v142
	v_perm_b32 v142, v143, v0, s39
	v_perm_b32 v143, v143, v0, s40
	v_and_b32_e32 v0, 0x7070707, v144
	v_lshrrev_b32_e32 v146, 4, v144
	v_and_b32_e32 v146, 0x7070707, v146
	v_perm_b32 v147, v169, v168, v0
	v_lshlrev_b32_e32 v148, 4, v144
	v_perm_b32 v0, v165, v164, v0
	v_and_or_b32 v0, v147, v148, v0
	v_perm_b32 v147, v169, v168, v146
	v_perm_b32 v146, v165, v164, v146
	v_and_or_b32 v144, v147, v144, v146
	v_perm_b32 v146, v144, v0, s39
	v_perm_b32 v147, v144, v0, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], a[14:15], v[142:143], v[114:117]
	v_and_b32_e32 v0, 0x7070707, v149
	v_lshlrev_b32_e32 v144, 4, v134
	s_nop 0
	v_lshrrev_b32_e32 v114, 4, v149
	v_and_b32_e32 v114, 0x7070707, v114
	v_perm_b32 v115, v171, v170, v0
	v_lshlrev_b32_e32 v116, 4, v149
	v_perm_b32 v0, v167, v166, v0
	v_and_or_b32 v0, v115, v116, v0
	v_perm_b32 v115, v171, v170, v114
	v_perm_b32 v114, v167, v166, v114
	v_and_or_b32 v114, v115, v149, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[172:175], a[14:15], v[146:147], v[122:125]
	v_lshlrev_b32_e32 v116, 4, v145
	s_nop 1
	v_perm_b32 v122, v114, v0, s39
	v_perm_b32 v123, v114, v0, s40
	v_and_b32_e32 v0, 0x7070707, v145
	v_lshrrev_b32_e32 v114, 4, v145
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], a[12:13], v[142:143], v[118:121]
	v_and_b32_e32 v114, 0x7070707, v114
	v_perm_b32 v115, v169, v168, v0
	v_perm_b32 v0, v165, v164, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], a[12:13], v[146:147], v[126:129]
	v_and_or_b32 v0, v115, v116, v0
	v_perm_b32 v115, v169, v168, v114
	v_perm_b32 v114, v165, v164, v114
	v_and_or_b32 v114, v115, v145, v114
	v_perm_b32 v142, v114, v0, s39
	v_perm_b32 v143, v114, v0, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], a[8:9], v[122:123], v[118:121]
	v_and_b32_e32 v0, 0x7070707, v134
	v_lshlrev_b32_e32 v145, 4, v130
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], a[8:9], v[142:143], v[126:129]
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], a[10:11], v[142:143], v[172:175]
	v_lshrrev_b32_e32 v142, 4, v134
	v_and_b32_e32 v142, 0x7070707, v142
	v_perm_b32 v143, v163, v162, v0
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v0, v143, v144, v0
	v_perm_b32 v143, v163, v162, v142
	v_perm_b32 v142, v161, v160, v142
	v_and_or_b32 v134, v143, v134, v142
	v_perm_b32 v142, v134, v0, s39
	v_perm_b32 v143, v134, v0, s40
	v_and_b32_e32 v0, 0x7070707, v130
	v_lshrrev_b32_e32 v134, 4, v130
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], a[10:11], v[122:123], v[150:153]
	v_and_b32_e32 v134, 0x7070707, v134
	v_perm_b32 v144, v159, v158, v0
	v_perm_b32 v0, v157, v156, v0
	v_and_or_b32 v0, v144, v145, v0
	v_perm_b32 v144, v159, v158, v134
	v_perm_b32 v134, v157, v156, v134
	v_and_or_b32 v130, v144, v130, v134
	v_perm_b32 v144, v130, v0, s39
	v_perm_b32 v145, v130, v0, s40
	v_and_b32_e32 v0, 0x7070707, v135
	v_lshrrev_b32_e32 v130, 4, v135
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[222:223], v[142:143], v[114:117]
	v_and_b32_e32 v130, 0x7070707, v130
	v_perm_b32 v134, v163, v162, v0
	v_perm_b32 v0, v161, v160, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[224:225], v[142:143], v[122:125]
	v_lshlrev_b32_e32 v142, 4, v135
	v_and_or_b32 v0, v134, v142, v0
	v_perm_b32 v134, v163, v162, v130
	v_perm_b32 v130, v161, v160, v130
	v_and_or_b32 v130, v134, v135, v130
	v_perm_b32 v134, v130, v0, s39
	v_perm_b32 v135, v130, v0, s40
	v_and_b32_e32 v0, 0x7070707, v131
	v_lshrrev_b32_e32 v130, 4, v131
	v_and_b32_e32 v130, 0x7070707, v130
	v_perm_b32 v142, v159, v158, v0
	v_lshlrev_b32_e32 v143, 4, v131
	v_perm_b32 v0, v157, v156, v0
	v_and_or_b32 v0, v142, v143, v0
	v_perm_b32 v142, v159, v158, v130
	v_perm_b32 v130, v157, v156, v130
	v_and_or_b32 v131, v142, v131, v130
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[222:223], v[144:145], v[118:121]
	v_perm_b32 v130, v131, v0, s39
	v_perm_b32 v131, v131, v0, s40
	v_and_b32_e32 v0, 0x7070707, v136
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[224:225], v[144:145], v[126:129]
	v_mov_b32_e32 v150, v247
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[196:197], v[134:135], v[122:125]
	s_nop 2
	v_lshrrev_b32_e32 v122, 4, v136
	v_and_b32_e32 v122, 0x7070707, v122
	v_perm_b32 v123, v163, v162, v0
	v_lshlrev_b32_e32 v124, 4, v136
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v0, v123, v124, v0
	v_perm_b32 v123, v163, v162, v122
	v_perm_b32 v122, v161, v160, v122
	v_and_or_b32 v122, v123, v136, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[194:195], v[130:131], v[118:121]
	v_lshlrev_b32_e32 v124, 4, v132
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[196:197], v[130:131], v[126:129]
	v_perm_b32 v130, v122, v0, s39
	v_perm_b32 v131, v122, v0, s40
	v_and_b32_e32 v0, 0x7070707, v132
	v_lshrrev_b32_e32 v122, 4, v132
	v_and_b32_e32 v122, 0x7070707, v122
	v_perm_b32 v123, v159, v158, v0
	v_perm_b32 v0, v157, v156, v0
	v_and_or_b32 v0, v123, v124, v0
	v_perm_b32 v123, v159, v158, v122
	v_perm_b32 v122, v157, v156, v122
	v_and_or_b32 v122, v123, v132, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[194:195], v[134:135], v[114:117]
	v_perm_b32 v134, v122, v0, s39
	v_perm_b32 v135, v122, v0, s40
	v_and_b32_e32 v0, 0x7070707, v137
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[190:191], v[130:131], v[114:117]
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[190:191], v[134:135], v[118:121]
	s_nop 2
	v_lshrrev_b32_e32 v118, 4, v137
	v_and_b32_e32 v118, 0x7070707, v118
	v_perm_b32 v119, v163, v162, v0
	v_lshlrev_b32_e32 v120, 4, v137
	v_perm_b32 v0, v161, v160, v0
	v_and_or_b32 v0, v119, v120, v0
	v_perm_b32 v119, v163, v162, v118
	v_perm_b32 v118, v161, v160, v118
	v_and_or_b32 v118, v119, v137, v118
	v_mfma_f32_16x16x32_fp8_fp8 v[142:145], v[192:193], v[130:131], v[142:145]
	v_perm_b32 v130, v118, v0, s39
	v_perm_b32 v131, v118, v0, s40
	v_and_b32_e32 v0, 0x7070707, v133
	v_lshrrev_b32_e32 v118, 4, v133
	v_mfma_f32_16x16x32_fp8_fp8 v[146:149], v[192:193], v[134:135], v[126:129]
	v_and_b32_e32 v118, 0x7070707, v118
	v_perm_b32 v119, v159, v158, v0
	v_lshlrev_b32_e32 v120, 4, v133
	v_perm_b32 v0, v157, v156, v0
	v_and_or_b32 v0, v119, v120, v0
	v_perm_b32 v119, v159, v158, v118
	v_perm_b32 v118, v157, v156, v118
	v_and_or_b32 v118, v119, v133, v118
	v_perm_b32 v132, v118, v0, s39
	v_perm_b32 v133, v118, v0, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[138:139], v[130:131], v[114:117]
	v_or_b32_e32 v0, s42, v246
	ds_write_b128 v0, a[0:3]
	v_accvgpr_read_b32 v0, a21
	v_mfma_f32_16x16x32_fp8_fp8 v[126:129], v[138:139], v[132:133], v[122:125]
	v_or_b32_e32 v0, s42, v0
	ds_write_b128 v0, a[4:7] offset:4096
	v_mov_b32_e32 v0, v248
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[140:141], v[130:131], v[142:145]
	v_mfma_f32_16x16x32_fp8_fp8 v[122:125], v[140:141], v[132:133], v[146:149]
	s_cbranch_scc1 .LBB0_2
	v_sub_u32_sdwa v0, v212, v248 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v130, 11, v0
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v130, v130, s40
	v_sub_u32_e32 v131, 0x6c686080, v130
	v_and_b32_e32 v131, 0xffffff00, v131
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_sub_u32_e32 v130, 0x7c787470, v130
	s_waitcnt vmcnt(15)
	v_lshlrev_b32_e32 v133, 4, v90
	v_cndmask_b32_e64 v0, v131, 0, vcc
	v_cndmask_b32_e64 v144, v130, 0, vcc
	v_add_u32_e32 v130, 0x7f7f7f00, v0
	v_and_b32_e32 v145, 0x80808000, v130
	v_add_u32_e32 v130, 0x7f7f7f78, v144
	v_and_b32_e32 v146, 0x80808080, v130
	v_sub_u32_sdwa v130, v210, v247 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v131, 11, v130
	v_mul_lo_u32 v131, v131, s40
	v_sub_u32_e32 v132, 0x6c686080, v131
	v_and_b32_e32 v132, 0xffffff00, v132
	v_cmp_lt_i32_e32 vcc, 11, v130
	v_sub_u32_e32 v131, 0x7c787470, v131
	s_mov_b32 s41, 0x5010400
	v_cndmask_b32_e64 v152, v132, 0, vcc
	v_cndmask_b32_e64 v153, v131, 0, vcc
	v_add_u32_e32 v130, 0x7f7f7f00, v152
	v_and_b32_e32 v154, 0x80808000, v130
	v_add_u32_e32 v130, 0x7f7f7f78, v153
	v_and_b32_e32 v155, 0x80808080, v130
	v_and_b32_e32 v130, 0x7070707, v90
	v_lshrrev_b32_e32 v131, 4, v90
	v_and_b32_e32 v131, 0x7070707, v131
	v_perm_b32 v132, v146, v145, v130
	v_perm_b32 v130, v144, v0, v130
	v_and_or_b32 v130, v132, v133, v130
	v_perm_b32 v132, v146, v145, v131
	v_perm_b32 v131, v144, v0, v131
	v_and_or_b32 v90, v132, v90, v131
	s_mov_b32 s42, 0x7030602
	v_perm_b32 v134, v90, v130, s41
	v_perm_b32 v135, v90, v130, s42
	s_waitcnt vmcnt(7)
	v_and_b32_e32 v90, 0x7070707, v94
	v_accvgpr_read_b32 v131, a42
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[148:149], v131 offset:8192
	v_perm_b32 v131, v155, v154, v90
	v_lshlrev_b32_e32 v132, 4, v94
	v_perm_b32 v90, v153, v152, v90
	v_accvgpr_read_b32 v171, a24
	v_and_or_b32 v90, v131, v132, v90
	v_or_b32_e32 v132, v171, v242
	ds_read_b64 v[150:151], v132 offset:8192
	v_lshrrev_b32_e32 v130, 4, v94
	v_and_b32_e32 v130, 0x7070707, v130
	v_perm_b32 v131, v155, v154, v130
	v_perm_b32 v130, v153, v152, v130
	v_and_or_b32 v94, v131, v94, v130
	v_sub_u32_sdwa v138, v212, v248 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v136, v94, v90, s41
	v_perm_b32 v137, v94, v90, s42
	v_min_i32_e32 v90, 11, v138
	v_mul_lo_u32 v90, v90, s40
	v_sub_u32_e32 v94, 0x6c686080, v90
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[148:149], v[134:135], v[98:101]
	v_add_u32_e32 v142, v201, v240
	v_lshlrev_b32_e32 v139, 4, v95
	v_cmp_lt_i32_e32 vcc, 11, v138
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[150:151], v[134:135], v[102:105]
	v_and_b32_e32 v134, 0xffffff00, v94
	v_sub_u32_e32 v135, 0x7c787470, v90
	v_and_b32_e32 v90, 0x7070707, v91
	v_lshrrev_b32_e32 v94, 4, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[130:133], v[148:149], v[136:137], v[106:109]
	v_and_b32_e32 v94, 0x7070707, v94
	v_cndmask_b32_e64 v165, v135, 0, vcc
	v_cndmask_b32_e64 v164, v134, 0, vcc
	v_perm_b32 v106, v146, v145, v90
	v_lshlrev_b32_e32 v107, 4, v91
	v_perm_b32 v90, v144, v0, v90
	v_and_or_b32 v106, v106, v107, v90
	v_perm_b32 v90, v146, v145, v94
	v_perm_b32 v94, v144, v0, v94
	v_and_or_b32 v91, v90, v91, v94
	v_perm_b32 v90, v91, v106, s41
	v_perm_b32 v91, v91, v106, s42
	ds_read2st64_b64 v[106:109], v142 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[150:151], v[136:137], v[110:113]
	v_and_b32_e32 v94, 0x7070707, v95
	v_lshrrev_b32_e32 v136, 4, v95
	v_and_b32_e32 v136, 0x7070707, v136
	v_perm_b32 v137, v155, v154, v94
	v_perm_b32 v94, v153, v152, v94
	v_and_or_b32 v137, v137, v139, v94
	v_perm_b32 v94, v155, v154, v136
	v_perm_b32 v136, v153, v152, v136
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[106:107], v[90:91], v[98:101]
	v_and_or_b32 v95, v94, v95, v136
	v_perm_b32 v94, v95, v137, s41
	v_perm_b32 v95, v95, v137, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[108:109], v[90:91], v[102:105]
	v_add_u32_e32 v90, 0x7f7f7f78, v165
	v_add_u32_e32 v134, 0x7f7f7f00, v164
	v_and_b32_e32 v167, 0x80808080, v90
	v_and_b32_e32 v90, 0x7070707, v92
	v_lshrrev_b32_e32 v91, 4, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[130:133], v[106:107], v[94:95], v[130:133]
	v_and_b32_e32 v166, 0x80808000, v134
	v_and_b32_e32 v91, 0x7070707, v91
	v_lshlrev_b32_e32 v138, 4, v96
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[108:109], v[94:95], v[110:113]
	v_perm_b32 v94, v146, v145, v90
	v_lshlrev_b32_e32 v95, 4, v92
	v_perm_b32 v90, v144, v0, v90
	v_and_or_b32 v94, v94, v95, v90
	v_perm_b32 v90, v146, v145, v91
	v_perm_b32 v91, v144, v0, v91
	v_and_or_b32 v91, v90, v92, v91
	v_perm_b32 v90, v91, v94, s41
	v_perm_b32 v91, v91, v94, s42
	v_accvgpr_read_b32 v94, a34
	v_add_u32_e32 v143, v201, v94
	ds_read2st64_b64 v[110:113], v143 offset0:16 offset1:24
	v_and_b32_e32 v92, 0x7070707, v96
	v_lshrrev_b32_e32 v94, 4, v96
	v_and_b32_e32 v94, 0x7070707, v94
	v_perm_b32 v95, v155, v154, v92
	v_perm_b32 v92, v153, v152, v92
	v_and_or_b32 v92, v95, v138, v92
	v_perm_b32 v95, v155, v154, v94
	v_perm_b32 v94, v153, v152, v94
	v_and_or_b32 v95, v95, v96, v94
	v_sub_u32_sdwa v156, v210, v247 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v94, v95, v92, s41
	v_perm_b32 v95, v95, v92, s42
	v_min_i32_e32 v92, 11, v156
	v_mul_lo_u32 v92, v92, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[110:111], v[90:91], v[98:101]
	v_sub_u32_e32 v158, 0x7c787470, v92
	v_cmp_lt_i32_e32 vcc, 11, v156
	s_waitcnt vmcnt(6)
	v_lshlrev_b32_e32 v156, 4, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[112:113], v[90:91], v[102:105]
	v_sub_u32_e32 v90, 0x6c686080, v92
	v_and_b32_e32 v157, 0xffffff00, v90
	v_and_b32_e32 v90, 0x7070707, v93
	v_lshrrev_b32_e32 v91, 4, v93
	v_mfma_f32_16x16x32_fp8_fp8 v[138:141], v[110:111], v[94:95], v[130:133]
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v146, v145, v90
	v_perm_b32 v90, v144, v0, v90
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[112:113], v[94:95], v[134:137]
	v_lshlrev_b32_e32 v94, 4, v93
	v_and_or_b32 v90, v92, v94, v90
	v_perm_b32 v92, v146, v145, v91
	v_perm_b32 v0, v144, v0, v91
	v_and_or_b32 v0, v92, v93, v0
	v_perm_b32 v146, v0, v90, s41
	v_perm_b32 v147, v0, v90, s42
	v_accvgpr_read_b32 v90, a31
	v_add_u32_e32 v144, v201, v90
	ds_read2st64_b64 v[130:133], v144 offset0:16 offset1:24
	v_lshrrev_b32_e32 v90, 4, v97
	v_and_b32_e32 v0, 0x7070707, v97
	v_and_b32_e32 v90, 0x7070707, v90
	v_perm_b32 v91, v155, v154, v0
	v_lshlrev_b32_e32 v92, 4, v97
	v_perm_b32 v0, v153, v152, v0
	v_perm_b32 v94, v155, v154, v90
	v_perm_b32 v95, v153, v152, v90
	v_and_or_b32 v0, v91, v92, v0
	v_and_or_b32 v94, v94, v97, v95
	v_cndmask_b32_e64 v168, v158, 0, vcc
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[130:131], v[146:147], v[98:101]
	v_perm_b32 v152, v94, v0, s41
	v_perm_b32 v153, v94, v0, s42
	v_cndmask_b32_e64 v0, v157, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[132:133], v[146:147], v[102:105]
	v_lshlrev_b32_e32 v146, 4, v70
	v_lshrrev_b32_e32 v147, 4, v71
	v_and_b32_e32 v147, 0x7070707, v147
	v_add_u32_e32 v102, 0x7f7f7f78, v168
	v_and_b32_e32 v170, 0x80808080, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[132:133], v[152:153], v[134:137]
	v_accvgpr_read_b32 v172, a25
	s_ashr_i32 s49, s48, 31
	s_lshl_b32 s2, s33, 2
	v_and_b32_e32 v134, 0x7070707, v66
	v_lshrrev_b32_e32 v135, 4, v66
	v_and_b32_e32 v135, 0x7070707, v135
	v_perm_b32 v136, v167, v166, v134
	v_lshlrev_b32_e32 v137, 4, v66
	v_perm_b32 v134, v165, v164, v134
	v_and_or_b32 v134, v136, v137, v134
	v_perm_b32 v136, v167, v166, v135
	v_perm_b32 v135, v165, v164, v135
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[130:131], v[152:153], v[138:141]
	v_and_or_b32 v66, v136, v66, v135
	v_lshlrev_b32_e32 v153, 4, v71
	s_and_b32 s1, s7, 0xffff
	v_add_u32_e32 v138, 0x7f7f7f00, v0
	v_and_b32_e32 v169, 0x80808000, v138
	v_perm_b32 v138, v66, v134, s41
	v_perm_b32 v139, v66, v134, s42
	v_accvgpr_read_b32 v134, a30
	v_add_u32_e32 v145, v201, v134
	ds_read2st64_b64 v[134:137], v145 offset0:16 offset1:24
	v_and_b32_e32 v66, 0x7070707, v70
	v_lshrrev_b32_e32 v140, 4, v70
	v_and_b32_e32 v140, 0x7070707, v140
	v_perm_b32 v141, v170, v169, v66
	v_perm_b32 v66, v168, v0, v66
	v_and_or_b32 v66, v141, v146, v66
	v_perm_b32 v141, v170, v169, v140
	v_perm_b32 v140, v168, v0, v140
	v_and_or_b32 v70, v141, v70, v140
	v_perm_b32 v140, v70, v66, s41
	v_perm_b32 v141, v70, v66, s42
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshrrev_b32_e32 v70, 4, v67
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[134:135], v[138:139], v[90:93]
	v_and_b32_e32 v70, 0x7070707, v70
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[136:137], v[138:139], v[98:101]
	v_perm_b32 v138, v167, v166, v66
	v_lshlrev_b32_e32 v139, 4, v67
	v_perm_b32 v66, v165, v164, v66
	v_and_or_b32 v138, v138, v139, v66
	v_perm_b32 v66, v167, v166, v70
	v_perm_b32 v70, v165, v164, v70
	v_and_or_b32 v67, v66, v67, v70
	v_perm_b32 v66, v67, v138, s41
	v_perm_b32 v67, v67, v138, s42
	v_accvgpr_read_b32 v138, a29
	v_add_u32_e32 v146, v201, v138
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[134:135], v[140:141], v[94:97]
	v_and_b32_e32 v70, 0x7070707, v71
	v_perm_b32 v152, v170, v169, v70
	v_perm_b32 v70, v168, v0, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[136:137], v[140:141], v[102:105]
	ds_read2st64_b64 v[138:141], v146 offset0:16 offset1:24
	v_and_or_b32 v152, v152, v153, v70
	v_perm_b32 v70, v170, v169, v147
	v_perm_b32 v147, v168, v0, v147
	v_and_or_b32 v71, v70, v71, v147
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[138:139], v[66:67], v[90:93]
	v_perm_b32 v70, v71, v152, s41
	v_perm_b32 v71, v71, v152, s42
	s_movk_i32 s43, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[140:141], v[66:67], v[98:101]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[138:139], v[70:71], v[94:97]
	s_lshr_b32 s7, s50, 6
	s_and_b32 s25, s23, 0xffff
	s_mov_b32 s26, -1
	v_mfma_f32_16x16x32_fp8_fp8 v[152:155], v[140:141], v[70:71], v[102:105]
	v_perm_b32 v70, v167, v166, v66
	v_lshlrev_b32_e32 v71, 4, v68
	v_perm_b32 v66, v165, v164, v66
	v_and_or_b32 v70, v70, v71, v66
	v_perm_b32 v66, v167, v166, v67
	v_perm_b32 v67, v165, v164, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v70, s41
	v_perm_b32 v67, v67, v70, s42
	v_accvgpr_read_b32 v70, a28
	v_add_u32_e32 v147, v201, v70
	ds_read2st64_b64 v[102:105], v147 offset0:16 offset1:24
	v_and_b32_e32 v68, 0x7070707, v72
	v_lshrrev_b32_e32 v70, 4, v72
	v_and_b32_e32 v70, 0x7070707, v70
	v_perm_b32 v71, v170, v169, v68
	v_perm_b32 v68, v168, v0, v68
	v_and_or_b32 v68, v71, v156, v68
	v_perm_b32 v71, v170, v169, v70
	v_perm_b32 v70, v168, v0, v70
	v_and_or_b32 v71, v71, v72, v70
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[102:103], v[66:67], v[90:93]
	v_perm_b32 v70, v71, v68, s41
	v_perm_b32 v71, v71, v68, s42
	s_mov_b32 s24, s22
	v_mfma_f32_16x16x32_fp8_fp8 v[160:163], v[104:105], v[66:67], v[98:101]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[156:159], v[102:103], v[70:71], v[94:97]
	v_perm_b32 v68, v167, v166, v66
	v_perm_b32 v66, v165, v164, v66
	ds_read2st64_b64 v[98:101], v172 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[152:155], v[104:105], v[70:71], v[152:155]
	v_lshlrev_b32_e32 v70, 4, v69
	v_and_or_b32 v68, v68, v70, v66
	v_perm_b32 v66, v167, v166, v67
	v_perm_b32 v67, v165, v164, v67
	v_and_or_b32 v67, v66, v69, v67
	v_perm_b32 v66, v67, v68, s41
	v_perm_b32 v67, v67, v68, s42
	v_and_b32_e32 v68, 0x7070707, v73
	v_lshrrev_b32_e32 v69, 4, v73
	v_and_b32_e32 v69, 0x7070707, v69
	v_perm_b32 v70, v170, v169, v68
	v_lshlrev_b32_e32 v71, 4, v73
	v_perm_b32 v68, v168, v0, v68
	v_and_or_b32 v70, v70, v71, v68
	v_perm_b32 v68, v170, v169, v69
	v_perm_b32 v0, v168, v0, v69
	v_and_or_b32 v0, v68, v73, v0
	v_perm_b32 v68, v0, v70, s41
	v_perm_b32 v69, v0, v70, s42
	v_bfe_u32 v0, v218, s13, 8
	v_sub_u32_e32 v0, v213, v0
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[98:99], v[66:67], v[90:93]
	v_cmp_lt_i32_e32 vcc, 11, v0
	s_waitcnt vmcnt(5)
	v_lshlrev_b32_e32 v165, 4, v62
	s_mov_b32 s27, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[98:99], v[68:69], v[156:159]
	s_mov_b32 s6, 0x400000
	s_mov_b32 s28, s14
	s_mov_b32 s31, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[100:101], v[66:67], v[160:163]
	v_bfe_u32 v157, v219, s36, 8
	v_bfe_u32 v156, v218, s12, 8
	v_sub_u32_e32 v156, v213, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[100:101], v[68:69], v[152:155]
	v_bfe_u32 v158, v219, s37, 8
	v_sub_u32_e32 v158, v211, v158
	s_lshl_b32 s12, s7, 5
	v_min_i32_e32 v152, 11, v0
	v_mul_lo_u32 v152, v152, s40
	v_sub_u32_e32 v153, 0x6c686080, v152
	v_and_b32_e32 v153, 0xffffff00, v153
	v_sub_u32_e32 v152, 0x7c787470, v152
	v_cndmask_b32_e64 v0, v153, 0, vcc
	v_cndmask_b32_e64 v159, v152, 0, vcc
	v_add_u32_e32 v152, 0x7f7f7f00, v0
	v_and_b32_e32 v160, 0x80808000, v152
	v_add_u32_e32 v152, 0x7f7f7f78, v159
	v_and_b32_e32 v161, 0x80808080, v152
	v_sub_u32_e32 v152, v211, v157
	v_min_i32_e32 v153, 11, v152
	v_mul_lo_u32 v153, v153, s40
	v_sub_u32_e32 v154, 0x6c686080, v153
	v_and_b32_e32 v154, 0xffffff00, v154
	v_cmp_lt_i32_e32 vcc, 11, v152
	v_sub_u32_e32 v153, 0x7c787470, v153
	v_lshlrev_b32_e32 v155, 4, v58
	v_cndmask_b32_e64 v157, v154, 0, vcc
	v_cndmask_b32_e64 v162, v153, 0, vcc
	v_add_u32_e32 v152, 0x7f7f7f00, v157
	v_and_b32_e32 v163, 0x80808000, v152
	v_add_u32_e32 v152, 0x7f7f7f78, v162
	v_and_b32_e32 v164, 0x80808080, v152
	v_and_b32_e32 v152, 0x7070707, v58
	v_lshrrev_b32_e32 v153, 4, v58
	v_and_b32_e32 v153, 0x7070707, v153
	v_perm_b32 v154, v161, v160, v152
	v_perm_b32 v152, v159, v0, v152
	v_and_or_b32 v154, v154, v155, v152
	v_perm_b32 v152, v161, v160, v153
	v_perm_b32 v153, v159, v0, v153
	v_and_or_b32 v58, v152, v58, v153
	v_perm_b32 v152, v58, v154, s41
	v_perm_b32 v153, v58, v154, s42
	v_and_b32_e32 v58, 0x7070707, v62
	v_lshrrev_b32_e32 v154, 4, v62
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v155, v164, v163, v58
	v_perm_b32 v58, v162, v157, v58
	v_and_or_b32 v58, v155, v165, v58
	v_perm_b32 v155, v164, v163, v154
	v_perm_b32 v154, v162, v157, v154
	v_and_or_b32 v62, v155, v62, v154
	v_perm_b32 v154, v62, v58, s41
	v_perm_b32 v155, v62, v58, s42
	v_min_i32_e32 v58, 11, v156
	v_mul_lo_u32 v58, v58, s40
	v_sub_u32_e32 v62, 0x6c686080, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[148:149], v[152:153], v[74:77]
	v_lshlrev_b32_e32 v165, 4, v63
	v_cmp_lt_i32_e32 vcc, 11, v156
	s_mov_b32 s44, s18
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[150:151], v[152:153], v[78:81]
	v_and_b32_e32 v152, 0xffffff00, v62
	v_sub_u32_e32 v153, 0x7c787470, v58
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshrrev_b32_e32 v62, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[148:149], v[154:155], v[82:85]
	v_and_b32_e32 v62, 0x7070707, v62
	v_cndmask_b32_e64 v156, v152, 0, vcc
	v_add_u32_e32 v152, 0x7f7f7f00, v156
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[150:151], v[154:155], v[86:89]
	v_perm_b32 v154, v161, v160, v58
	v_lshlrev_b32_e32 v155, 4, v59
	v_perm_b32 v58, v159, v0, v58
	v_and_or_b32 v154, v154, v155, v58
	v_perm_b32 v58, v161, v160, v62
	v_perm_b32 v62, v159, v0, v62
	v_and_or_b32 v59, v58, v59, v62
	v_perm_b32 v58, v59, v154, s41
	v_perm_b32 v59, v59, v154, s42
	v_and_b32_e32 v62, 0x7070707, v63
	v_lshrrev_b32_e32 v154, 4, v63
	v_and_b32_e32 v154, 0x7070707, v154
	v_perm_b32 v155, v164, v163, v62
	v_perm_b32 v62, v162, v157, v62
	v_and_or_b32 v155, v155, v165, v62
	v_perm_b32 v62, v164, v163, v154
	v_perm_b32 v154, v162, v157, v154
	v_cndmask_b32_e64 v165, v153, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[106:107], v[58:59], v[74:77]
	v_and_or_b32 v63, v62, v63, v154
	v_perm_b32 v62, v63, v155, s41
	v_perm_b32 v63, v63, v155, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[108:109], v[58:59], v[78:81]
	v_add_u32_e32 v58, 0x7f7f7f78, v165
	v_and_b32_e32 v167, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[106:107], v[62:63], v[82:85]
	v_and_b32_e32 v59, 0x7070707, v59
	v_and_b32_e32 v166, 0x80808000, v152
	v_lshlrev_b32_e32 v152, 4, v64
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[108:109], v[62:63], v[86:89]
	v_perm_b32 v62, v161, v160, v58
	v_lshlrev_b32_e32 v63, 4, v60
	v_perm_b32 v58, v159, v0, v58
	v_and_or_b32 v62, v62, v63, v58
	v_perm_b32 v58, v161, v160, v59
	v_perm_b32 v59, v159, v0, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v62, s41
	v_perm_b32 v59, v59, v62, s42
	v_and_b32_e32 v60, 0x7070707, v64
	v_lshrrev_b32_e32 v62, 4, v64
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v164, v163, v60
	v_perm_b32 v60, v162, v157, v60
	v_and_or_b32 v60, v63, v152, v60
	v_perm_b32 v63, v164, v163, v62
	v_perm_b32 v62, v162, v157, v62
	v_and_or_b32 v63, v63, v64, v62
	v_perm_b32 v62, v63, v60, s41
	v_perm_b32 v63, v63, v60, s42
	v_min_i32_e32 v60, 11, v158
	v_mul_lo_u32 v60, v60, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[110:111], v[58:59], v[74:77]
	v_sub_u32_e32 v169, 0x7c787470, v60
	v_cmp_lt_i32_e32 vcc, 11, v158
	s_mov_b32 s46, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[112:113], v[58:59], v[78:81]
	v_sub_u32_e32 v58, 0x6c686080, v60
	v_and_b32_e32 v168, 0xffffff00, v58
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[110:111], v[62:63], v[82:85]
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v161, v160, v58
	v_perm_b32 v58, v159, v0, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[112:113], v[62:63], v[86:89]
	v_lshlrev_b32_e32 v62, 4, v61
	v_and_or_b32 v58, v60, v62, v58
	v_perm_b32 v60, v161, v160, v59
	v_perm_b32 v0, v159, v0, v59
	v_and_or_b32 v0, v60, v61, v0
	v_perm_b32 v152, v0, v58, s41
	v_perm_b32 v153, v0, v58, s42
	v_lshrrev_b32_e32 v58, 4, v65
	v_and_b32_e32 v0, 0x7070707, v65
	v_and_b32_e32 v58, 0x7070707, v58
	v_perm_b32 v59, v164, v163, v0
	v_lshlrev_b32_e32 v60, 4, v65
	v_perm_b32 v0, v162, v157, v0
	v_perm_b32 v62, v164, v163, v58
	v_perm_b32 v63, v162, v157, v58
	v_and_or_b32 v0, v59, v60, v0
	v_and_or_b32 v62, v62, v65, v63
	v_perm_b32 v154, v62, v0, s41
	v_perm_b32 v155, v62, v0, s42
	v_cndmask_b32_e64 v0, v168, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[130:131], v[152:153], v[74:77]
	v_cndmask_b32_e64 v157, v169, 0, vcc
	s_mov_b32 s47, s3
	s_mov_b32 s36, s16
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[130:131], v[154:155], v[82:85]
	s_mov_b32 s39, s3
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	v_add_u32_e32 v82, 0x7f7f7f00, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[132:133], v[152:153], v[78:81]
	v_and_b32_e32 v152, 0x80808000, v82
	v_and_b32_e32 v82, 0x7070707, v46
	v_lshrrev_b32_e32 v83, 4, v46
	v_and_b32_e32 v83, 0x7070707, v83
	v_perm_b32 v84, v167, v166, v82
	v_lshlrev_b32_e32 v85, 4, v46
	v_perm_b32 v82, v165, v156, v82
	v_and_or_b32 v84, v84, v85, v82
	v_perm_b32 v82, v167, v166, v83
	v_perm_b32 v83, v165, v156, v83
	v_add_u32_e32 v78, 0x7f7f7f78, v157
	v_and_or_b32 v46, v82, v46, v83
	v_and_b32_e32 v153, 0x80808080, v78
	v_perm_b32 v82, v46, v84, s41
	v_perm_b32 v83, v46, v84, s42
	s_waitcnt vmcnt(4)
	v_and_b32_e32 v46, 0x7070707, v54
	v_lshrrev_b32_e32 v84, 4, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[132:133], v[154:155], v[86:89]
	v_and_b32_e32 v84, 0x7070707, v84
	v_perm_b32 v85, v153, v152, v46
	v_perm_b32 v46, v157, v0, v46
	v_lshlrev_b32_e32 v86, 4, v54
	v_and_or_b32 v46, v85, v86, v46
	v_perm_b32 v85, v153, v152, v84
	v_perm_b32 v84, v157, v0, v84
	v_and_or_b32 v54, v85, v54, v84
	v_perm_b32 v84, v54, v46, s41
	v_perm_b32 v85, v54, v46, s42
	v_and_b32_e32 v46, 0x7070707, v47
	v_lshrrev_b32_e32 v54, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[134:135], v[82:83], v[58:61]
	v_and_b32_e32 v54, 0x7070707, v54
	s_waitcnt vmcnt(3)
	v_lshlrev_b32_e32 v86, 4, v31
	v_sub_u32_sdwa v89, v206, v216 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[136:137], v[82:83], v[74:77]
	v_perm_b32 v82, v167, v166, v46
	v_lshlrev_b32_e32 v83, 4, v47
	v_perm_b32 v46, v165, v156, v46
	v_and_or_b32 v82, v82, v83, v46
	v_perm_b32 v46, v167, v166, v54
	v_perm_b32 v54, v165, v156, v54
	v_and_or_b32 v47, v46, v47, v54
	v_perm_b32 v46, v47, v82, s41
	v_perm_b32 v47, v47, v82, s42
	v_and_b32_e32 v54, 0x7070707, v55
	v_lshrrev_b32_e32 v82, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[134:135], v[84:85], v[62:65]
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v83, v153, v152, v54
	v_perm_b32 v54, v157, v0, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[136:137], v[84:85], v[78:81]
	v_lshlrev_b32_e32 v84, 4, v55
	v_and_or_b32 v83, v83, v84, v54
	v_perm_b32 v54, v153, v152, v82
	v_perm_b32 v82, v157, v0, v82
	v_and_or_b32 v55, v54, v55, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[138:139], v[46:47], v[58:61]
	v_perm_b32 v54, v55, v83, s41
	v_perm_b32 v55, v55, v83, s42
	v_lshlrev_b32_e32 v82, 4, v56
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[140:141], v[46:47], v[74:77]
	v_and_b32_e32 v46, 0x7070707, v48
	v_lshrrev_b32_e32 v47, 4, v48
	v_and_b32_e32 v47, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[138:139], v[54:55], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[140:141], v[54:55], v[78:81]
	v_perm_b32 v54, v167, v166, v46
	v_lshlrev_b32_e32 v55, 4, v48
	v_perm_b32 v46, v165, v156, v46
	v_and_or_b32 v54, v54, v55, v46
	v_perm_b32 v46, v167, v166, v47
	v_perm_b32 v47, v165, v156, v47
	v_and_or_b32 v47, v46, v48, v47
	v_perm_b32 v46, v47, v54, s41
	v_perm_b32 v47, v47, v54, s42
	v_and_b32_e32 v48, 0x7070707, v56
	v_lshrrev_b32_e32 v54, 4, v56
	v_and_b32_e32 v54, 0x7070707, v54
	v_perm_b32 v55, v153, v152, v48
	v_perm_b32 v48, v157, v0, v48
	v_and_or_b32 v48, v55, v82, v48
	v_perm_b32 v55, v153, v152, v54
	v_perm_b32 v54, v157, v0, v54
	v_and_or_b32 v55, v55, v56, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[102:103], v[46:47], v[58:61]
	v_perm_b32 v54, v55, v48, s41
	v_perm_b32 v55, v55, v48, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[104:105], v[46:47], v[74:77]
	v_and_b32_e32 v46, 0x7070707, v49
	v_lshrrev_b32_e32 v47, 4, v49
	v_and_b32_e32 v47, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[102:103], v[54:55], v[62:65]
	v_perm_b32 v48, v167, v166, v46
	v_perm_b32 v46, v165, v156, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[104:105], v[54:55], v[78:81]
	v_lshlrev_b32_e32 v54, 4, v49
	v_and_or_b32 v48, v48, v54, v46
	v_perm_b32 v46, v167, v166, v47
	v_perm_b32 v47, v165, v156, v47
	v_and_or_b32 v47, v46, v49, v47
	v_perm_b32 v46, v47, v48, s41
	v_perm_b32 v47, v47, v48, s42
	v_and_b32_e32 v48, 0x7070707, v57
	v_lshrrev_b32_e32 v49, 4, v57
	v_and_b32_e32 v49, 0x7070707, v49
	v_perm_b32 v54, v153, v152, v48
	v_lshlrev_b32_e32 v55, 4, v57
	v_perm_b32 v48, v157, v0, v48
	v_and_or_b32 v54, v54, v55, v48
	v_perm_b32 v48, v153, v152, v49
	v_perm_b32 v0, v157, v0, v49
	v_and_or_b32 v0, v48, v57, v0
	v_perm_b32 v48, v0, v54, s41
	v_perm_b32 v49, v0, v54, s42
	v_sub_u32_sdwa v0, v208, v217 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[100:101], v[46:47], v[74:77]
	v_cmp_lt_i32_e32 vcc, 11, v0
	s_nop 1
	v_min_i32_e32 v74, 11, v0
	v_mul_lo_u32 v74, v74, s40
	v_sub_u32_e32 v75, 0x6c686080, v74
	v_and_b32_e32 v75, 0xffffff00, v75
	v_sub_u32_e32 v74, 0x7c787470, v74
	v_cndmask_b32_e64 v0, v75, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[98:99], v[46:47], v[58:61]
	v_lshlrev_b32_e32 v77, 4, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[98:99], v[48:49], v[82:85]
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[100:101], v[48:49], v[78:81]
	s_nop 1
	v_lshlrev_b32_e32 v85, 4, v30
	v_cndmask_b32_e64 v78, v74, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v0
	v_and_b32_e32 v79, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v78
	v_and_b32_e32 v80, 0x80808080, v74
	v_sub_u32_sdwa v74, v206, v216 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v75, 11, v74
	v_mul_lo_u32 v75, v75, s40
	v_sub_u32_e32 v76, 0x6c686080, v75
	v_and_b32_e32 v76, 0xffffff00, v76
	v_cmp_lt_i32_e32 vcc, 11, v74
	v_sub_u32_e32 v75, 0x7c787470, v75
	s_nop 0
	v_cndmask_b32_e64 v81, v76, 0, vcc
	v_cndmask_b32_e64 v82, v75, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v81
	v_and_b32_e32 v83, 0x80808000, v74
	v_add_u32_e32 v74, 0x7f7f7f78, v82
	v_and_b32_e32 v84, 0x80808080, v74
	v_and_b32_e32 v74, 0x7070707, v26
	v_lshrrev_b32_e32 v75, 4, v26
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v80, v79, v74
	v_perm_b32 v74, v78, v0, v74
	v_and_or_b32 v76, v76, v77, v74
	v_perm_b32 v74, v80, v79, v75
	v_perm_b32 v75, v78, v0, v75
	v_and_or_b32 v26, v74, v26, v75
	v_perm_b32 v74, v26, v76, s41
	v_perm_b32 v75, v26, v76, s42
	v_and_b32_e32 v26, 0x7070707, v30
	v_lshrrev_b32_e32 v76, 4, v30
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v77, v84, v83, v26
	v_perm_b32 v26, v82, v81, v26
	v_and_or_b32 v26, v77, v85, v26
	v_perm_b32 v77, v84, v83, v76
	v_perm_b32 v76, v82, v81, v76
	v_and_or_b32 v30, v77, v30, v76
	v_sub_u32_sdwa v85, v208, v217 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v76, v30, v26, s41
	v_perm_b32 v77, v30, v26, s42
	v_min_i32_e32 v26, 11, v85
	v_mul_lo_u32 v26, v26, s40
	v_sub_u32_e32 v30, 0x6c686080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[148:149], v[74:75], v[34:37]
	v_cmp_lt_i32_e32 vcc, 11, v85
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[150:151], v[74:75], v[38:41]
	v_and_b32_e32 v74, 0xffffff00, v30
	v_sub_u32_e32 v75, 0x7c787470, v26
	v_and_b32_e32 v26, 0x7070707, v27
	v_lshrrev_b32_e32 v30, 4, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[148:149], v[76:77], v[42:45]
	v_and_b32_e32 v30, 0x7070707, v30
	v_cndmask_b32_e64 v85, v74, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v85
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[150:151], v[76:77], v[50:53]
	v_perm_b32 v76, v80, v79, v26
	v_lshlrev_b32_e32 v77, 4, v27
	v_perm_b32 v26, v78, v0, v26
	v_and_or_b32 v76, v76, v77, v26
	v_perm_b32 v26, v80, v79, v30
	v_perm_b32 v30, v78, v0, v30
	v_and_or_b32 v27, v26, v27, v30
	v_perm_b32 v26, v27, v76, s41
	v_perm_b32 v27, v27, v76, s42
	v_and_b32_e32 v30, 0x7070707, v31
	v_lshrrev_b32_e32 v76, 4, v31
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v77, v84, v83, v30
	v_perm_b32 v30, v82, v81, v30
	v_and_or_b32 v77, v77, v86, v30
	v_perm_b32 v30, v84, v83, v76
	v_perm_b32 v76, v82, v81, v76
	v_cndmask_b32_e64 v86, v75, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[106:107], v[26:27], v[34:37]
	v_and_or_b32 v31, v30, v31, v76
	v_perm_b32 v30, v31, v77, s41
	v_perm_b32 v31, v31, v77, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[108:109], v[26:27], v[38:41]
	v_add_u32_e32 v26, 0x7f7f7f78, v86
	v_and_b32_e32 v88, 0x80808080, v26
	v_and_b32_e32 v26, 0x7070707, v28
	v_lshrrev_b32_e32 v27, 4, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[106:107], v[30:31], v[42:45]
	v_and_b32_e32 v27, 0x7070707, v27
	v_and_b32_e32 v87, 0x80808000, v74
	v_lshlrev_b32_e32 v74, 4, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[108:109], v[30:31], v[50:53]
	v_perm_b32 v30, v80, v79, v26
	v_lshlrev_b32_e32 v31, 4, v28
	v_perm_b32 v26, v78, v0, v26
	v_and_or_b32 v30, v30, v31, v26
	v_perm_b32 v26, v80, v79, v27
	v_perm_b32 v27, v78, v0, v27
	v_and_or_b32 v27, v26, v28, v27
	v_perm_b32 v26, v27, v30, s41
	v_perm_b32 v27, v27, v30, s42
	v_and_b32_e32 v28, 0x7070707, v32
	v_lshrrev_b32_e32 v30, 4, v32
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v31, v84, v83, v28
	v_perm_b32 v28, v82, v81, v28
	v_and_or_b32 v28, v31, v74, v28
	v_perm_b32 v31, v84, v83, v30
	v_perm_b32 v30, v82, v81, v30
	v_and_or_b32 v31, v31, v32, v30
	v_perm_b32 v30, v31, v28, s41
	v_perm_b32 v31, v31, v28, s42
	v_min_i32_e32 v28, 11, v89
	v_mul_lo_u32 v28, v28, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[110:111], v[26:27], v[34:37]
	v_sub_u32_e32 v153, 0x7c787470, v28
	v_cmp_lt_i32_e32 vcc, 11, v89
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[112:113], v[26:27], v[38:41]
	v_sub_u32_e32 v26, 0x6c686080, v28
	v_and_b32_e32 v152, 0xffffff00, v26
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[110:111], v[30:31], v[42:45]
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v80, v79, v26
	v_perm_b32 v26, v78, v0, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[112:113], v[30:31], v[50:53]
	v_lshlrev_b32_e32 v30, 4, v29
	v_and_or_b32 v26, v28, v30, v26
	v_perm_b32 v28, v80, v79, v27
	v_perm_b32 v0, v78, v0, v27
	v_and_or_b32 v0, v28, v29, v0
	v_perm_b32 v74, v0, v26, s41
	v_perm_b32 v75, v0, v26, s42
	v_lshrrev_b32_e32 v26, 4, v33
	v_and_b32_e32 v0, 0x7070707, v33
	v_and_b32_e32 v26, 0x7070707, v26
	v_perm_b32 v27, v84, v83, v0
	v_lshlrev_b32_e32 v28, 4, v33
	v_perm_b32 v0, v82, v81, v0
	v_perm_b32 v30, v84, v83, v26
	v_perm_b32 v31, v82, v81, v26
	v_and_or_b32 v0, v27, v28, v0
	v_and_or_b32 v30, v30, v33, v31
	v_perm_b32 v76, v30, v0, s41
	v_perm_b32 v77, v30, v0, s42
	v_cndmask_b32_e64 v0, v152, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[130:131], v[74:75], v[34:37]
	v_cndmask_b32_e64 v78, v153, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[130:131], v[76:77], v[42:45]
	s_nop 2
	v_add_u32_e32 v42, 0x7f7f7f00, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[132:133], v[74:75], v[38:41]
	v_and_b32_e32 v74, 0x80808000, v42
	v_and_b32_e32 v42, 0x7070707, v18
	v_lshrrev_b32_e32 v43, 4, v18
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v88, v87, v42
	v_lshlrev_b32_e32 v45, 4, v18
	v_perm_b32 v42, v86, v85, v42
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v88, v87, v43
	v_perm_b32 v43, v86, v85, v43
	v_add_u32_e32 v38, 0x7f7f7f78, v78
	v_and_or_b32 v18, v42, v18, v43
	v_and_b32_e32 v75, 0x80808080, v38
	v_perm_b32 v42, v18, v44, s41
	v_perm_b32 v43, v18, v44, s42
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v18, 0x7070707, v22
	v_lshrrev_b32_e32 v44, 4, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[132:133], v[76:77], v[50:53]
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v75, v74, v18
	v_perm_b32 v18, v78, v0, v18
	v_lshlrev_b32_e32 v50, 4, v22
	v_and_or_b32 v18, v45, v50, v18
	v_perm_b32 v45, v75, v74, v44
	v_perm_b32 v44, v78, v0, v44
	v_and_or_b32 v22, v45, v22, v44
	v_perm_b32 v44, v22, v18, s41
	v_perm_b32 v45, v22, v18, s42
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v22, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[134:135], v[42:43], v[26:29]
	v_and_b32_e32 v22, 0x7070707, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[136:137], v[42:43], v[34:37]
	v_perm_b32 v42, v88, v87, v18
	v_lshlrev_b32_e32 v43, 4, v19
	v_perm_b32 v18, v86, v85, v18
	v_and_or_b32 v42, v42, v43, v18
	v_perm_b32 v18, v88, v87, v22
	v_perm_b32 v22, v86, v85, v22
	v_and_or_b32 v19, v18, v19, v22
	v_perm_b32 v18, v19, v42, s41
	v_perm_b32 v19, v19, v42, s42
	v_and_b32_e32 v22, 0x7070707, v23
	v_lshrrev_b32_e32 v42, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[134:135], v[44:45], v[30:33]
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v75, v74, v22
	v_perm_b32 v22, v78, v0, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[136:137], v[44:45], v[38:41]
	v_lshlrev_b32_e32 v44, 4, v23
	v_and_or_b32 v43, v43, v44, v22
	v_perm_b32 v22, v75, v74, v42
	v_perm_b32 v42, v78, v0, v42
	v_and_or_b32 v23, v22, v23, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[138:139], v[18:19], v[26:29]
	v_perm_b32 v22, v23, v43, s41
	v_perm_b32 v23, v23, v43, s42
	v_lshlrev_b32_e32 v42, 4, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[140:141], v[18:19], v[34:37]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[138:139], v[22:23], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[140:141], v[22:23], v[38:41]
	v_perm_b32 v22, v88, v87, v18
	v_lshlrev_b32_e32 v23, 4, v20
	v_perm_b32 v18, v86, v85, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v88, v87, v19
	v_perm_b32 v19, v86, v85, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v22, s41
	v_perm_b32 v19, v19, v22, s42
	v_and_b32_e32 v20, 0x7070707, v24
	v_lshrrev_b32_e32 v22, 4, v24
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v75, v74, v20
	v_perm_b32 v20, v78, v0, v20
	v_and_or_b32 v20, v23, v42, v20
	v_perm_b32 v23, v75, v74, v22
	v_perm_b32 v22, v78, v0, v22
	v_and_or_b32 v23, v23, v24, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[102:103], v[18:19], v[26:29]
	v_perm_b32 v22, v23, v20, s41
	v_perm_b32 v23, v23, v20, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[104:105], v[18:19], v[34:37]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[102:103], v[22:23], v[30:33]
	v_perm_b32 v20, v88, v87, v18
	v_perm_b32 v18, v86, v85, v18
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[104:105], v[22:23], v[38:41]
	v_lshlrev_b32_e32 v22, 4, v21
	v_and_or_b32 v20, v20, v22, v18
	v_perm_b32 v18, v88, v87, v19
	v_perm_b32 v19, v86, v85, v19
	v_and_or_b32 v19, v18, v21, v19
	v_perm_b32 v18, v19, v20, s41
	v_perm_b32 v19, v19, v20, s42
	v_and_b32_e32 v20, 0x7070707, v25
	v_lshrrev_b32_e32 v21, 4, v25
	v_and_b32_e32 v21, 0x7070707, v21
	v_perm_b32 v22, v75, v74, v20
	v_lshlrev_b32_e32 v23, 4, v25
	v_perm_b32 v20, v78, v0, v20
	v_and_or_b32 v22, v22, v23, v20
	v_perm_b32 v20, v75, v74, v21
	v_perm_b32 v0, v78, v0, v21
	v_and_or_b32 v0, v20, v25, v0
	v_perm_b32 v20, v0, v22, s41
	v_perm_b32 v21, v0, v22, s42
	v_bfe_u32 v0, v214, s9, 8
	v_sub_u32_e32 v0, v209, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[100:101], v[18:19], v[34:37]
	v_cmp_lt_i32_e32 vcc, 11, v0
	v_lshlrev_b32_e32 v86, 4, v11
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v87, 4, v15
	v_min_i32_e32 v35, 11, v0
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_cndmask_b32_e64 v0, v36, 0, vcc
	v_bfe_u32 v34, v215, s10, 8
	v_cndmask_b32_e64 v75, v35, 0, vcc
	v_add_u32_e32 v35, 0x7f7f7f00, v0
	v_and_b32_e32 v76, 0x80808000, v35
	v_add_u32_e32 v35, 0x7f7f7f78, v75
	v_sub_u32_e32 v34, v207, v34
	v_and_b32_e32 v77, 0x80808080, v35
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_lshlrev_b32_e32 v37, 4, v10
	v_cndmask_b32_e64 v78, v36, 0, vcc
	v_cndmask_b32_e64 v79, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v78
	v_and_b32_e32 v80, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v79
	v_and_b32_e32 v81, 0x80808080, v34
	v_and_b32_e32 v34, 0x7070707, v10
	v_lshrrev_b32_e32 v35, 4, v10
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v77, v76, v34
	v_perm_b32 v34, v75, v0, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v77, v76, v35
	v_perm_b32 v35, v75, v0, v35
	v_and_or_b32 v10, v36, v10, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[98:99], v[18:19], v[26:29]
	v_lshlrev_b32_e32 v36, 4, v14
	v_bfe_u32 v74, v215, s11, 8
	s_mov_b32 s10, 0x800000
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[20:21], v[42:45]
	s_mov_b32 s38, s10
	s_mov_b32 s11, s3
	s_nop 0
	v_perm_b32 v42, v10, v34, s41
	v_perm_b32 v43, v10, v34, s42
	v_lshrrev_b32_e32 v34, 4, v14
	v_and_b32_e32 v10, 0x7070707, v14
	v_and_b32_e32 v34, 0x7070707, v34
	v_bfe_u32 v44, v214, s8, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[100:101], v[20:21], v[38:41]
	v_perm_b32 v35, v81, v80, v10
	v_perm_b32 v10, v79, v78, v10
	v_and_or_b32 v10, v35, v36, v10
	v_perm_b32 v38, v81, v80, v34
	v_perm_b32 v39, v79, v78, v34
	v_and_or_b32 v14, v38, v14, v39
	v_sub_u32_e32 v82, v209, v44
	v_perm_b32 v50, v14, v10, s41
	v_perm_b32 v51, v14, v10, s42
	v_min_i32_e32 v10, 11, v82
	v_mul_lo_u32 v10, v10, s40
	v_sub_u32_e32 v14, 0x6c686080, v10
	v_and_b32_e32 v83, 0xffffff00, v14
	v_sub_u32_e32 v84, 0x7c787470, v10
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v14, 4, v11
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v85, v77, v76, v10
	v_perm_b32 v10, v75, v0, v10
	v_and_or_b32 v85, v85, v86, v10
	v_perm_b32 v10, v77, v76, v14
	v_perm_b32 v14, v75, v0, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[148:149], v[42:43], v[118:121]
	v_and_or_b32 v11, v10, v11, v14
	v_perm_b32 v10, v11, v85, s41
	v_perm_b32 v11, v11, v85, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[150:151], v[42:43], v[114:117]
	v_and_b32_e32 v14, 0x7070707, v15
	v_lshrrev_b32_e32 v85, 4, v15
	v_and_b32_e32 v85, 0x7070707, v85
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[148:149], v[50:51], v[126:129]
	v_perm_b32 v86, v81, v80, v14
	v_perm_b32 v14, v79, v78, v14
	v_cmp_lt_i32_e32 vcc, 11, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[150:151], v[50:51], v[122:125]
	v_and_or_b32 v86, v86, v87, v14
	v_perm_b32 v14, v81, v80, v85
	v_perm_b32 v85, v79, v78, v85
	v_cndmask_b32_e64 v82, v83, 0, vcc
	v_cndmask_b32_e64 v83, v84, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[106:107], v[10:11], v[34:37]
	v_and_or_b32 v15, v14, v15, v85
	v_perm_b32 v14, v15, v86, s41
	v_perm_b32 v15, v15, v86, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[108:109], v[10:11], v[42:45]
	v_add_u32_e32 v10, 0x7f7f7f78, v83
	v_and_b32_e32 v85, 0x80808080, v10
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[106:107], v[14:15], v[38:41]
	v_and_b32_e32 v11, 0x7070707, v11
	v_lshlrev_b32_e32 v86, 4, v16
	v_add_u32_e32 v84, 0x7f7f7f00, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[108:109], v[14:15], v[50:53]
	v_perm_b32 v14, v77, v76, v10
	v_lshlrev_b32_e32 v15, 4, v12
	v_perm_b32 v10, v75, v0, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v77, v76, v11
	v_perm_b32 v11, v75, v0, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v12, 0x7070707, v16
	v_lshrrev_b32_e32 v14, 4, v16
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v15, v81, v80, v12
	v_perm_b32 v12, v79, v78, v12
	v_and_or_b32 v12, v15, v86, v12
	v_perm_b32 v15, v81, v80, v14
	v_perm_b32 v14, v79, v78, v14
	v_and_or_b32 v15, v15, v16, v14
	v_sub_u32_e32 v86, v207, v74
	v_perm_b32 v14, v15, v12, s41
	v_perm_b32 v15, v15, v12, s42
	v_min_i32_e32 v12, 11, v86
	v_mul_lo_u32 v12, v12, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[110:111], v[10:11], v[34:37]
	v_sub_u32_e32 v88, 0x7c787470, v12
	v_and_b32_e32 v84, 0x80808000, v84
	v_cmp_lt_i32_e32 vcc, 11, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[112:113], v[10:11], v[42:45]
	v_sub_u32_e32 v10, 0x6c686080, v12
	v_and_b32_e32 v87, 0xffffff00, v10
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[110:111], v[14:15], v[38:41]
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v77, v76, v10
	v_perm_b32 v10, v75, v0, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[112:113], v[14:15], v[50:53]
	v_lshlrev_b32_e32 v14, 4, v13
	v_and_or_b32 v10, v12, v14, v10
	v_perm_b32 v12, v77, v76, v11
	v_perm_b32 v0, v75, v0, v11
	v_and_or_b32 v0, v12, v13, v0
	v_perm_b32 v74, v0, v10, s41
	v_perm_b32 v75, v0, v10, s42
	v_lshrrev_b32_e32 v10, 4, v17
	v_and_b32_e32 v0, 0x7070707, v17
	v_and_b32_e32 v10, 0x7070707, v10
	v_perm_b32 v11, v81, v80, v0
	v_lshlrev_b32_e32 v12, 4, v17
	v_perm_b32 v0, v79, v78, v0
	v_perm_b32 v14, v81, v80, v10
	v_perm_b32 v15, v79, v78, v10
	v_and_or_b32 v0, v11, v12, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[130:131], v[74:75], v[34:37]
	v_and_or_b32 v14, v14, v17, v15
	v_perm_b32 v76, v14, v0, s41
	v_perm_b32 v77, v14, v0, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[132:133], v[74:75], v[42:45]
	v_cndmask_b32_e64 v0, v87, 0, vcc
	v_cndmask_b32_e64 v78, v88, 0, vcc
	v_cmp_lt_i32_e32 vcc, 5, v213
	v_and_b32_e32 v42, 0x7070707, v6
	v_lshrrev_b32_e32 v43, 4, v6
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v85, v84, v42
	v_lshlrev_b32_e32 v45, 4, v6
	v_perm_b32 v42, v83, v82, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[130:131], v[76:77], v[38:41]
	v_and_or_b32 v44, v44, v45, v42
	v_perm_b32 v42, v85, v84, v43
	v_perm_b32 v43, v83, v82, v43
	v_add_u32_e32 v38, 0x7f7f7f00, v0
	v_and_b32_e32 v79, 0x80808000, v38
	v_add_u32_e32 v38, 0x7f7f7f78, v78
	v_and_or_b32 v6, v42, v6, v43
	v_and_b32_e32 v80, 0x80808080, v38
	v_perm_b32 v42, v6, v44, s41
	v_perm_b32 v43, v6, v44, s42
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v6, 0x7070707, v2
	v_lshrrev_b32_e32 v44, 4, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[132:133], v[76:77], v[50:53]
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v80, v79, v6
	v_perm_b32 v6, v78, v0, v6
	v_lshlrev_b32_e32 v50, 4, v2
	v_and_or_b32 v6, v45, v50, v6
	v_perm_b32 v45, v80, v79, v44
	v_perm_b32 v44, v78, v0, v44
	v_and_or_b32 v2, v45, v2, v44
	v_perm_b32 v44, v2, v6, s41
	v_perm_b32 v45, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[134:135], v[42:43], v[10:13]
	v_and_b32_e32 v6, 0x7070707, v6
	v_mov_b32_e32 v86, v90
	v_mov_b32_e32 v87, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[136:137], v[42:43], v[34:37]
	v_perm_b32 v42, v85, v84, v2
	v_lshlrev_b32_e32 v43, 4, v7
	v_perm_b32 v2, v83, v82, v2
	v_and_or_b32 v2, v42, v43, v2
	v_perm_b32 v42, v85, v84, v6
	v_perm_b32 v6, v83, v82, v6
	v_and_or_b32 v7, v42, v7, v6
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v42, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[134:135], v[44:45], v[14:17]
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v80, v79, v2
	v_perm_b32 v2, v78, v0, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[136:137], v[44:45], v[38:41]
	v_lshlrev_b32_e32 v44, 4, v3
	v_and_or_b32 v43, v43, v44, v2
	v_perm_b32 v2, v80, v79, v42
	v_perm_b32 v42, v78, v0, v42
	v_and_or_b32 v3, v2, v3, v42
	v_perm_b32 v2, v3, v43, s41
	v_perm_b32 v3, v3, v43, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[138:139], v[6:7], v[10:13]
	v_add_u32_e32 v81, 17, v206
	v_mov_b32_e32 v88, v26
	v_mov_b32_e32 v58, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[138:139], v[2:3], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[140:141], v[2:3], v[38:41]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[140:141], v[6:7], v[34:37]
	v_perm_b32 v6, v85, v84, v2
	v_lshlrev_b32_e32 v7, 4, v8
	v_perm_b32 v2, v83, v82, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v85, v84, v3
	v_perm_b32 v3, v83, v82, v3
	v_and_or_b32 v3, v2, v8, v3
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_and_b32_e32 v6, 0x7070707, v4
	v_lshrrev_b32_e32 v7, 4, v4
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v80, v79, v6
	v_lshlrev_b32_e32 v38, 4, v4
	v_perm_b32 v6, v78, v0, v6
	v_and_or_b32 v8, v8, v38, v6
	v_perm_b32 v6, v80, v79, v7
	v_perm_b32 v7, v78, v0, v7
	v_and_or_b32 v4, v6, v4, v7
	v_perm_b32 v6, v4, v8, s41
	v_perm_b32 v7, v4, v8, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[2:3], v[10:13]
	v_lshlrev_b32_e32 v8, 4, v5
	v_mov_b32_e32 v41, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[102:103], v[6:7], v[14:17]
	v_accvgpr_read_b32 v103, a22
	v_lshlrev_b32_e32 v40, 2, v103
	v_or_b32_e32 v38, s48, v40
	v_ashrrev_i32_e32 v39, 31, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[104:105], v[2:3], v[34:37]
	v_lshl_add_u64 v[2:3], v[38:39], 2, s[20:21]
	global_load_dword v39, v[2:3], off
	v_and_b32_e32 v2, 0x7070707, v9
	v_lshrrev_b32_e32 v3, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[104:105], v[6:7], v[42:45]
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v85, v84, v2
	v_lshlrev_b32_e32 v6, 4, v9
	v_perm_b32 v2, v83, v82, v2
	v_and_or_b32 v4, v4, v6, v2
	v_perm_b32 v2, v85, v84, v3
	v_perm_b32 v3, v83, v82, v3
	v_and_or_b32 v3, v2, v9, v3
	v_perm_b32 v2, v3, v4, s41
	v_perm_b32 v3, v3, v4, s42
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshrrev_b32_e32 v6, 4, v5
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v80, v79, v4
	v_perm_b32 v4, v78, v0, v4
	v_and_or_b32 v8, v7, v8, v4
	v_perm_b32 v4, v80, v79, v6
	v_perm_b32 v0, v78, v0, v6
	v_lshl_add_u64 v[6:7], s[48:49], 0, v[40:41]
	v_lshl_add_u64 v[42:43], v[6:7], 2, s[20:21]
	global_load_dwordx3 v[78:80], v[42:43], off offset:4
	v_and_or_b32 v0, v4, v5, v0
	global_load_dwordx4 v[42:45], v[42:43], off offset:64
	v_perm_b32 v4, v0, v8, s41
	v_perm_b32 v5, v0, v8, s42
	v_mov_b32_e32 v82, 0xfd800000
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[98:99], v[2:3], v[50:53]
	s_and_b32 s21, s21, 0xffff
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v0, 2, v39
	v_and_b32_e32 v0, 0x3fffffc, v0
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[98:99], v[4:5], v[74:77]
	v_add_u32_e32 v53, 17, v211
	v_lshlrev_b32_e64 v53, v53, 1
	v_add_u32_e32 v39, 17, v208
	buffer_load_dword v74, v0, s[0:3], 0 offen
	v_add_u32_e32 v0, 17, v213
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[100:101], v[2:3], v[10:13]
	v_lshlrev_b32_e64 v0, v0, 1
	v_add_u32_e32 v75, 17, v210
	v_lshlrev_b32_e64 v39, v39, 1
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[100:101], v[4:5], v[34:37]
	v_add_u32_e32 v77, 17, v207
	v_mov_b32_e32 v89, v6
	s_nop 0
	v_lshl_add_u32 v35, v213, 23, v82
	v_cndmask_b32_e32 v35, v0, v35, vcc
	v_add_u32_e32 v34, 17, v212
	v_lshl_add_u32 v36, v212, 23, v82
	v_lshlrev_b32_e64 v34, v34, 1
	v_cmp_lt_i32_e32 vcc, 5, v212
	v_add_u32_e32 v37, 17, v209
	v_lshlrev_b32_e64 v37, v37, 1
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v0, 2, v78
	v_and_b32_e32 v50, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v79
	v_and_b32_e32 v51, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v80
	v_and_b32_e32 v79, 0x3fffffc, v0
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v0, 2, v42
	v_and_b32_e32 v42, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v43
	v_and_b32_e32 v43, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v44
	v_and_b32_e32 v44, 0x3fffffc, v0
	v_lshlrev_b32_e32 v0, 2, v45
	v_cndmask_b32_e32 v34, v34, v36, vcc
	v_and_b32_e32 v45, 0x3fffffc, v0
	buffer_load_dword v0, v50, s[0:3], 0 offen
	buffer_load_dword v78, v51, s[0:3], 0 offen
	buffer_load_dword v80, v79, s[0:3], 0 offen
	buffer_load_dword v76, v42, s[0:3], 0 offen
	buffer_load_dword v52, v43, s[0:3], 0 offen
	buffer_load_dword v40, v44, s[0:3], 0 offen
	buffer_load_dword v36, v45, s[0:3], 0 offen
	v_mov_b32_e32 v44, v94
	v_mov_b32_e32 v45, v62
	s_mov_b32 s0, 0xbfb8aa3b
	v_mov_b32_e32 v50, 0x4000
	v_lshl_or_b32 v62, v103, 11, v50
	v_accvgpr_read_b32 v50, a27
	v_lshl_add_u32 v79, v50, 1, v62
	v_cmp_lt_i32_e32 vcc, 5, v211
	s_lshl_b32 s2, s7, 2
	s_waitcnt vmcnt(7)
	v_pk_mul_f32 v[42:43], v[74:75], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[44:45], v[44:45], v[42:43]
	v_lshlrev_b32_e64 v75, v75, 1
	v_pk_mul_f32 v[42:43], v[44:45], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v42, v42
	v_exp_f32_e32 v43, v43
	s_nop 0
	v_pk_add_f32 v[42:43], v[42:43], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v50, v42
	v_rcp_f32_e32 v51, v43
	v_lshl_add_u32 v43, v211, 23, v82
	v_lshl_add_u32 v42, v210, 23, v82
	v_cndmask_b32_e32 v43, v53, v43, vcc
	v_cmp_lt_i32_e32 vcc, 5, v210
	v_pk_mul_f32 v[44:45], v[44:45], v[50:51]
	s_nop 0
	v_cndmask_b32_e32 v42, v75, v42, vcc
	v_pk_mul_f32 v[84:85], v[74:75], v[42:43] op_sel_hi:[0,1]
	v_pk_mul_f32 v[84:85], v[86:87], v[84:85]
	s_nop 0
	v_pk_mul_f32 v[44:45], v[84:85], v[44:45]
	v_mov_b32_e32 v84, v30
	v_bfe_u32 v50, v45, 16, 1
	v_add3_u32 v50, v50, v45, s43
	v_or_b32_e32 v51, 0x400000, v45
	v_cmp_u_f32_e32 vcc, v45, v45
	v_bfe_u32 v45, v44, 16, 1
	v_add3_u32 v45, v45, v44, s43
	v_cndmask_b32_e32 v53, v50, v51, vcc
	v_or_b32_e32 v50, 0x400000, v44
	v_cmp_u_f32_e32 vcc, v44, v44
	v_mov_b32_e32 v85, v14
	v_add_u32_e32 v14, s5, v1
	v_cndmask_b32_e32 v44, v45, v50, vcc
	v_lshl_add_u32 v45, v209, 23, v82
	v_cmp_lt_i32_e32 vcc, 5, v209
	ds_write_b16_d16_hi v79, v44
	v_lshl_add_u32 v44, v208, 23, v82
	v_cndmask_b32_e32 v45, v37, v45, vcc
	v_cmp_lt_i32_e32 vcc, 5, v208
	v_lshl_add_u32 v30, v207, 23, v82
	v_lshl_add_u32 v37, v14, 1, v62
	v_cndmask_b32_e32 v44, v39, v44, vcc
	v_pk_mul_f32 v[50:51], v[74:75], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[84:85], v[84:85], v[50:51]
	v_cmp_lt_i32_e32 vcc, 5, v207
	v_pk_mul_f32 v[50:51], v[84:85], s[0:1] op_sel_hi:[1,0]
	v_lshl_add_u32 v14, v206, 23, v82
	v_exp_f32_e32 v50, v50
	v_exp_f32_e32 v51, v51
	v_lshlrev_b32_e64 v39, v81, 1
	v_mov_b32_e32 v62, v95
	ds_write_b16_d16_hi v37, v53 offset:32
	v_pk_add_f32 v[50:51], v[50:51], 1.0 op_sel_hi:[1,0]
	s_and_b32 s5, s19, 0xffff
	v_rcp_f32_e32 v86, v50
	v_rcp_f32_e32 v87, v51
	v_lshlrev_b32_e64 v50, v77, 1
	v_cndmask_b32_e32 v51, v50, v30, vcc
	v_cmp_lt_i32_e32 vcc, 5, v206
	v_pk_mul_f32 v[84:85], v[84:85], v[86:87]
	s_mov_b32 s45, s5
	v_cndmask_b32_e32 v50, v39, v14, vcc
	v_pk_mul_f32 v[74:75], v[74:75], v[50:51] op_sel_hi:[0,1]
	v_pk_mul_f32 v[74:75], v[88:89], v[74:75]
	s_nop 0
	v_pk_mul_f32 v[74:75], v[74:75], v[84:85]
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[84:85], v[0:1], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[62:63], v[62:63], v[84:85]
	v_bfe_u32 v6, v75, 16, 1
	v_pk_mul_f32 v[84:85], v[62:63], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v6, v6, v75, s43
	v_exp_f32_e32 v84, v84
	v_exp_f32_e32 v85, v85
	v_or_b32_e32 v14, 0x400000, v75
	v_cmp_u_f32_e32 vcc, v75, v75
	v_or_b32_e32 v26, 0x400000, v74
	s_nop 0
	v_cndmask_b32_e32 v6, v6, v14, vcc
	v_bfe_u32 v14, v74, 16, 1
	v_add3_u32 v14, v14, v74, s43
	v_cmp_u_f32_e32 vcc, v74, v74
	v_pk_add_f32 v[74:75], v[84:85], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[84:85], v[0:1], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v74, v74
	v_rcp_f32_e32 v75, v75
	v_pk_mul_f32 v[58:59], v[58:59], v[84:85]
	v_cndmask_b32_e32 v14, v14, v26, vcc
	ds_write_b16_d16_hi v37, v14 offset:64
	ds_write_b16_d16_hi v37, v6 offset:96
	v_pk_mul_f32 v[62:63], v[62:63], v[74:75]
	s_nop 0
	v_pk_mul_f32 v[58:59], v[58:59], v[62:63]
	v_pk_mul_f32 v[62:63], v[0:1], v[44:45] op_sel_hi:[0,1]
	v_bfe_u32 v6, v59, 16, 1
	v_add3_u32 v6, v6, v59, s43
	v_or_b32_e32 v14, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	v_or_b32_e32 v39, 0x400000, v58
	s_nop 0
	v_cndmask_b32_e32 v6, v6, v14, vcc
	v_bfe_u32 v14, v58, 16, 1
	v_add3_u32 v26, v14, v58, s43
	v_mov_b32_e32 v14, v31
	v_pk_mul_f32 v[14:15], v[14:15], v[62:63]
	v_cmp_u_f32_e32 vcc, v58, v58
	v_pk_mul_f32 v[30:31], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[0:1], v[50:51] op_sel_hi:[0,1]
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v26, v26, v39, vcc
	ds_write_b16_d16_hi v37, v26 offset:512
	ds_write_b16_d16_hi v37, v6 offset:544
	v_mov_b32_e32 v6, v27
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[58:59]
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	v_mov_b32_e32 v26, v96
	v_mov_b32_e32 v27, v64
	v_mov_b32_e32 v64, v97
	v_pk_mul_f32 v[14:15], v[14:15], v[30:31]
	v_mov_b32_e32 v31, v60
	v_pk_mul_f32 v[6:7], v[6:7], v[14:15]
	v_mov_b32_e32 v60, v93
	v_bfe_u32 v0, v7, 16, 1
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_bfe_u32 v7, v6, 16, 1
	v_add3_u32 v7, v7, v6, s43
	v_cndmask_b32_e32 v0, v0, v14, vcc
	s_waitcnt vmcnt(5)
	v_pk_mul_f32 v[14:15], v[78:79], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[26:27], v[14:15]
	v_or_b32_e32 v30, 0x400000, v6
	v_pk_mul_f32 v[26:27], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v6, v7, v30, vcc
	ds_write_b16_d16_hi v37, v6 offset:576
	ds_write_b16_d16_hi v37, v0 offset:608
	v_mov_b32_e32 v30, v92
	v_pk_add_f32 v[6:7], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[78:79], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_mov_b32_e32 v31, v8
	v_or_b32_e32 v92, s12, v1
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_lshlrev_b32_e32 v93, 10, v103
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	v_mov_b32_e32 v26, v32
	v_bfe_u32 v0, v7, 16, 1
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v14, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_mov_b32_e32 v27, v16
	v_bfe_u32 v7, v6, 16, 1
	v_cndmask_b32_e32 v0, v0, v14, vcc
	v_pk_mul_f32 v[14:15], v[78:79], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[26:27], v[14:15]
	v_add3_u32 v7, v7, v6, s43
	v_pk_mul_f32 v[26:27], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_or_b32_e32 v30, 0x400000, v6
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cmp_u_f32_e32 vcc, v6, v6
	v_mov_b32_e32 v16, v33
	s_nop 0
	v_cndmask_b32_e32 v6, v7, v30, vcc
	ds_write_b16_d16_hi v37, v6 offset:1024
	ds_write_b16_d16_hi v37, v0 offset:1056
	v_pk_add_f32 v[6:7], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[78:79], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v30, v28
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[14:15], v[80:81], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[64:65], v[14:15]
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	v_pk_mul_f32 v[26:27], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v0, v7, 16, 1
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v8, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_bfe_u32 v7, v6, 16, 1
	v_add3_u32 v7, v7, v6, s43
	v_cndmask_b32_e32 v0, v0, v8, vcc
	v_or_b32_e32 v8, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v7, v8, vcc
	ds_write_b16_d16_hi v37, v6 offset:1088
	ds_write_b16_d16_hi v37, v0 offset:1120
	v_pk_add_f32 v[6:7], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[80:81], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[26:27], v[60:61], v[26:27]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_pk_mul_f32 v[14:15], v[80:81], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[14:15], v[16:17], v[14:15]
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	v_pk_mul_f32 v[16:17], v[14:15], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v0, v7, 16, 1
	v_exp_f32_e32 v16, v16
	v_exp_f32_e32 v17, v17
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v8, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_bfe_u32 v7, v6, 16, 1
	v_add3_u32 v7, v7, v6, s43
	v_cndmask_b32_e32 v0, v0, v8, vcc
	v_or_b32_e32 v8, 0x400000, v6
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v7, v8, vcc
	ds_write_b16_d16_hi v37, v6 offset:1536
	ds_write_b16_d16_hi v37, v0 offset:1568
	v_pk_add_f32 v[6:7], v[16:17], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[16:17], v[80:81], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v8, v29
	v_pk_mul_f32 v[8:9], v[8:9], v[16:17]
	v_mov_b32_e32 v17, v46
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_mov_b32_e32 v14, v70
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v15, v54
	v_bfe_u32 v0, v7, 16, 1
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v8, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_bfe_u32 v7, v6, 16, 1
	v_add3_u32 v7, v7, v6, s43
	v_cndmask_b32_e32 v0, v0, v8, vcc
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[8:9], v[76:77], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[14:15], v[8:9]
	v_or_b32_e32 v16, 0x400000, v6
	v_pk_mul_f32 v[14:15], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v6, v7, v16, vcc
	ds_write_b16_d16_hi v37, v6 offset:1600
	ds_write_b16_d16_hi v37, v0 offset:1632
	v_mov_b32_e32 v16, v66
	v_pk_add_f32 v[6:7], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[76:77], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[14:15], v[16:17], v[14:15]
	v_mov_b32_e32 v17, v2
	v_mov_b32_e32 v54, v71
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v46, v67
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_mov_b32_e32 v14, v22
	v_bfe_u32 v0, v7, 16, 1
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v8, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_mov_b32_e32 v15, v10
	v_bfe_u32 v7, v6, 16, 1
	v_cndmask_b32_e32 v0, v0, v8, vcc
	v_pk_mul_f32 v[8:9], v[76:77], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[14:15], v[8:9]
	v_add3_u32 v7, v7, v6, s43
	v_pk_mul_f32 v[14:15], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_or_b32_e32 v16, 0x400000, v6
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cmp_u_f32_e32 vcc, v6, v6
	v_mov_b32_e32 v10, v23
	s_nop 0
	v_cndmask_b32_e32 v6, v7, v16, vcc
	ds_write_b16_d16_hi v37, v6 offset:8192
	ds_write_b16_d16_hi v37, v0 offset:8224
	v_pk_add_f32 v[6:7], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[76:77], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v16, v18
	v_pk_mul_f32 v[14:15], v[16:17], v[14:15]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[8:9], v[52:53], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[54:55], v[8:9]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_pk_mul_f32 v[14:15], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v0, v7, 16, 1
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v2, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_or_b32_e32 v7, 0x400000, v6
	s_nop 0
	v_cndmask_b32_e32 v0, v0, v2, vcc
	v_bfe_u32 v2, v6, 16, 1
	v_add3_u32 v2, v2, v6, s43
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v2, v2, v7, vcc
	v_pk_add_f32 v[6:7], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[52:53], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[14:15], v[46:47], v[14:15]
	ds_write_b16_d16_hi v37, v2 offset:8256
	ds_write_b16_d16_hi v37, v0 offset:8288
	v_accvgpr_read_b32 v46, a20
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_pk_mul_f32 v[8:9], v[52:53], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9]
	v_pk_mul_f32 v[6:7], v[14:15], v[6:7]
	v_pk_mul_f32 v[10:11], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v0, v7, 16, 1
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_add3_u32 v0, v0, v7, s43
	v_or_b32_e32 v2, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_or_b32_e32 v7, 0x400000, v6
	v_accvgpr_read_b32 v14, a26
	v_cndmask_b32_e32 v0, v0, v2, vcc
	v_bfe_u32 v2, v6, 16, 1
	v_add3_u32 v2, v2, v6, s43
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v2, v2, v7, vcc
	v_pk_add_f32 v[6:7], v[10:11], 1.0 op_sel_hi:[1,0]
	ds_write_b16_d16_hi v37, v2 offset:8704
	ds_write_b16_d16_hi v37, v0 offset:8736
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[10:11], v[52:53], v[50:51] op_sel_hi:[0,1]
	v_mov_b32_e32 v2, v19
	v_pk_mul_f32 v[2:3], v[2:3], v[10:11]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v8, v72
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	v_mov_b32_e32 v9, v56
	v_bfe_u32 v0, v3, 16, 1
	v_add3_u32 v0, v0, v3, s43
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_bfe_u32 v3, v2, 16, 1
	v_add3_u32 v3, v3, v2, s43
	v_cndmask_b32_e32 v0, v0, v6, vcc
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[6:7], v[40:41], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_or_b32_e32 v10, 0x400000, v2
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v2, v3, v10, vcc
	ds_write_b16_d16_hi v37, v2 offset:8768
	ds_write_b16_d16_hi v37, v0 offset:8800
	v_mov_b32_e32 v10, v68
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[40:41], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v11, v48
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9]
	v_mov_b32_e32 v11, v4
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_mov_b32_e32 v56, v73
	v_pk_mul_f32 v[2:3], v[8:9], v[2:3]
	v_mov_b32_e32 v8, v24
	v_bfe_u32 v0, v3, 16, 1
	v_add3_u32 v0, v0, v3, s43
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_mov_b32_e32 v9, v12
	v_bfe_u32 v3, v2, 16, 1
	v_cndmask_b32_e32 v0, v0, v6, vcc
	v_pk_mul_f32 v[6:7], v[40:41], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_add3_u32 v3, v3, v2, s43
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_or_b32_e32 v10, 0x400000, v2
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v2, v2
	v_mov_b32_e32 v48, v69
	v_mov_b32_e32 v12, v25
	v_cndmask_b32_e32 v2, v3, v10, vcc
	ds_write_b16_d16_hi v37, v2 offset:9216
	ds_write_b16_d16_hi v37, v0 offset:9248
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[40:41], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v10, v20
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[36:37], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[56:57], v[6:7]
	v_pk_mul_f32 v[2:3], v[8:9], v[2:3]
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v0, v3, 16, 1
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_add3_u32 v0, v0, v3, s43
	v_or_b32_e32 v4, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_bfe_u32 v3, v2, 16, 1
	v_add3_u32 v3, v3, v2, s43
	v_cndmask_b32_e32 v0, v0, v4, vcc
	v_or_b32_e32 v4, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v3, v4, vcc
	ds_write_b16_d16_hi v37, v2 offset:9280
	ds_write_b16_d16_hi v37, v0 offset:9312
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[36:37], v[42:43] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_pk_mul_f32 v[8:9], v[48:49], v[8:9]
	v_lshlrev_b32_e32 v42, 1, v46
	v_and_b32_e32 v96, 62, v42
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_pk_mul_f32 v[6:7], v[36:37], v[44:45] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[12:13], v[6:7]
	v_pk_mul_f32 v[2:3], v[8:9], v[2:3]
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v0, v3, 16, 1
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_add3_u32 v0, v0, v3, s43
	v_or_b32_e32 v4, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_bfe_u32 v3, v2, 16, 1
	v_add3_u32 v3, v3, v2, s43
	v_cndmask_b32_e32 v0, v0, v4, vcc
	v_or_b32_e32 v4, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_lshl_b32 s0, s7, 8
	s_mov_b32 s1, 0x43700000
	v_cndmask_b32_e32 v2, v3, v4, vcc
	ds_write_b16_d16_hi v37, v2 offset:9728
	ds_write_b16_d16_hi v37, v0 offset:9760
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[36:37], v[50:51] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v4, v21
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_lshlrev_b32_e32 v83, 1, v96
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[4:5], v[2:3]
	s_nop 0
	v_bfe_u32 v0, v3, 16, 1
	v_add3_u32 v0, v0, v3, s43
	v_or_b32_e32 v4, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_bfe_u32 v3, v2, 16, 1
	v_add3_u32 v3, v3, v2, s43
	v_cndmask_b32_e32 v0, v0, v4, vcc
	v_or_b32_e32 v4, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v3, v4, vcc
	ds_write_b16_d16_hi v37, v2 offset:9792
	ds_write_b16_d16_hi v37, v0 offset:9824
	v_lshlrev_b32_e32 v2, 2, v14
	v_or_b32_e32 v0, s0, v2
	v_lshlrev_b32_e32 v0, 1, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[4:5], v0 offset:16384
	v_mov_b32_e32 v3, 0x7fc00000
	s_waitcnt lgkmcnt(0)
	v_lshlrev_b32_e32 v8, 16, v4
	v_max_f32_e64 v0, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	v_and_b32_e32 v9, 0xffff0000, v4
	v_lshlrev_b32_e32 v6, 16, v5
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_max_f32_e64 v4, v0, |v9|
	v_cmp_o_f32_e64 vcc, v0, |v9|
	v_and_b32_e32 v7, 0xffff0000, v5
	s_nop 0
	v_cndmask_b32_e32 v0, v3, v4, vcc
	v_max_f32_e64 v4, v0, |v6|
	v_cmp_o_f32_e64 vcc, v0, |v6|
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v4, vcc
	v_max_f32_e64 v4, v0, |v7|
	v_cmp_o_f32_e64 vcc, v0, |v7|
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v4, vcc
	ds_swizzle_b32 v4, v0 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v0, v4
	v_cmp_o_f32_e32 vcc, v0, v4
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v5, vcc
	ds_swizzle_b32 v4, v0 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v0, v4
	v_cmp_o_f32_e32 vcc, v0, v4
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v5, vcc
	ds_swizzle_b32 v4, v0 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v0, v4
	v_cmp_o_f32_e32 vcc, v0, v4
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v5, vcc
	ds_swizzle_b32 v4, v0 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v0, v4
	v_cmp_o_f32_e32 vcc, v0, v4
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v5, vcc
	ds_swizzle_b32 v4, v0 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v5, v0, v4
	v_cmp_o_f32_e32 vcc, v0, v4
	v_xor_b32_e32 v4, 0x80, v2
	s_nop 0
	v_cndmask_b32_e32 v0, v3, v5, vcc
	ds_bpermute_b32 v5, v4, v0
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v0, v5
	v_cmp_o_f32_e32 vcc, v0, v5
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v10, vcc
	v_div_scale_f32 v5, s[8:9], s1, s1, v0
	v_rcp_f32_e32 v10, v5
	s_nop 0
	v_fma_f32 v11, -v5, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, v0, s1, v0
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v5, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v5, -v5, v12, v11
	v_div_fmas_f32 v5, v5, v10, v12
	v_div_fixup_f32 v5, v5, s1, v0
	v_cmp_neq_f32_e32 vcc, 0, v0
	s_nop 1
	v_cndmask_b32_e32 v10, 1.0, v5, vcc
	v_div_scale_f32 v0, s[8:9], v10, v10, 1.0
	v_rcp_f32_e32 v5, v0
	s_nop 0
	v_fma_f32 v11, -v0, v5, 1.0
	v_fmac_f32_e32 v5, v11, v5
	v_div_scale_f32 v11, vcc, 1.0, v10, 1.0
	v_mul_f32_e32 v12, v11, v5
	v_fma_f32 v13, -v0, v12, v11
	v_fmac_f32_e32 v12, v13, v5
	v_fma_f32 v0, -v0, v12, v11
	v_div_fmas_f32 v0, v0, v5, v12
	v_div_fixup_f32 v0, v0, v10, 1.0
	v_pk_mul_f32 v[8:9], v[0:1], v[8:9] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[0:1], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v0, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_max_f32_e32 v5, 0xc3700000, v0
	v_cmp_o_f32_e32 vcc, v0, v0
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v5, vcc
	v_min_f32_e32 v5, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v5, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v3, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v3, v8, vcc
	v_mov_b32_e32 v8, v41
	v_cvt_pk_fp8_f32 v8, v0, v5
	v_max_f32_e32 v0, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	v_mov_b32_e32 v5, s2
	s_lshr_b32 s2, s50, 2
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_cvt_pk_fp8_f32 v8, v6, v0 op_sel:[0,0,1]
	s_and_b32 s2, s2, 0xf0
	v_xor_b32_e32 v6, s2, v2
	v_or_b32_e32 v6, s0, v6
	v_and_b32_e32 v0, 0x7f7f7f7f, v8
	v_add_u32_e32 v0, 0x7f7f7f7f, v0
	v_or_b32_e32 v0, 0x7f7f7f7f, v0
	v_and_b32_e32 v0, v0, v8
	ds_write_b32 v5, v10 offset:8192
	ds_write_b32 v6, v0
	s_add_i32 s2, s7, 4
	v_lshlrev_b32_e32 v0, 3, v14
	v_lshl_or_b32 v7, s2, 9, v0
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
	v_div_scale_f32 v12, s[8:9], s1, s1, v7
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
	v_div_scale_f32 v12, s[8:9], v7, v7, 1.0
	v_rcp_f32_e32 v13, v12
	ds_write_b32 v5, v7 offset:8208
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
	v_mov_b32_e32 v12, v41
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	v_xor_b32_e32 v8, s2, v2
	v_or_b32_e32 v8, s0, v8
	s_add_i32 s2, s7, 8
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	ds_write_b32 v8, v7 offset:1024
	v_lshl_or_b32 v7, s2, 9, v0
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
	v_div_scale_f32 v12, s[8:9], s1, s1, v7
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
	v_div_scale_f32 v12, s[8:9], v7, v7, 1.0
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
	v_mov_b32_e32 v12, v41
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	v_xor_b32_e32 v8, s2, v2
	v_or_b32_e32 v8, s0, v8
	s_add_i32 s2, s7, 12
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	ds_write_b32 v8, v7 offset:2048
	v_lshl_or_b32 v7, s2, 9, v0
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
	v_div_scale_f32 v12, s[8:9], s1, s1, v7
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
	v_div_scale_f32 v12, s[8:9], v7, v7, 1.0
	v_rcp_f32_e32 v13, v12
	ds_write_b32 v5, v7 offset:8240
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
	v_mov_b32_e32 v12, v41
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	v_xor_b32_e32 v8, s2, v2
	s_lshl_b32 s2, s7, 9
	v_or_b32_e32 v8, s0, v8
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	s_addk_i32 s2, 0x2000
	ds_write_b32 v8, v7 offset:3072
	v_or_b32_e32 v7, s2, v0
	ds_read_b64 v[8:9], v7 offset:16384
	s_add_i32 s2, s7, 20
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
	v_div_scale_f32 v12, s[8:9], s1, s1, v7
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
	v_div_scale_f32 v12, s[8:9], v7, v7, 1.0
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
	v_mov_b32_e32 v12, v41
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
	ds_write_b32 v6, v7 offset:4096
	v_lshl_or_b32 v6, s2, 9, v0
	ds_read_b64 v[6:7], v6 offset:16384
	s_lshl_b32 s2, s2, 4
	s_and_b32 s2, s2, 0xf0
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
	v_div_scale_f32 v11, s[8:9], s1, s1, v10
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v10, s1, v10
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s1, v10
	v_cmp_neq_f32_e32 vcc, 0, v10
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v10, s[8:9], v11, v11, 1.0
	v_rcp_f32_e32 v12, v10
	ds_write_b32 v5, v11 offset:8272
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
	v_xor_b32_e32 v7, s2, v2
	v_or_b32_e32 v7, s0, v7
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	s_add_i32 s2, s7, 24
	v_and_b32_e32 v6, 0x7f7f7f7f, v10
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v10
	ds_write_b32 v7, v6 offset:5120
	v_lshl_or_b32 v6, s2, 9, v0
	ds_read_b64 v[6:7], v6 offset:16384
	s_lshl_b32 s2, s2, 4
	s_and_b32 s2, s2, 0xf0
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
	v_div_scale_f32 v11, s[8:9], s1, s1, v10
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v13, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v13, v12
	v_div_scale_f32 v13, vcc, v10, s1, v10
	v_mul_f32_e32 v14, v13, v12
	v_fma_f32 v15, -v11, v14, v13
	v_fmac_f32_e32 v14, v15, v12
	v_fma_f32 v11, -v11, v14, v13
	v_div_fmas_f32 v11, v11, v12, v14
	v_div_fixup_f32 v11, v11, s1, v10
	v_cmp_neq_f32_e32 vcc, 0, v10
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v10, s[8:9], v11, v11, 1.0
	v_rcp_f32_e32 v12, v10
	ds_write_b32 v5, v11 offset:8288
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
	v_xor_b32_e32 v7, s2, v2
	v_or_b32_e32 v7, s0, v7
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_cvt_pk_fp8_f32 v10, v8, v6 op_sel:[0,0,1]
	s_add_i32 s2, s7, 28
	v_lshl_or_b32 v0, s2, 9, v0
	v_and_b32_e32 v6, 0x7f7f7f7f, v10
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_and_b32_e32 v6, v6, v10
	ds_write_b32 v7, v6 offset:6144
	ds_read_b64 v[6:7], v0 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v9, 0xffff0000, v7
	v_lshlrev_b32_e32 v8, 16, v7
	v_and_b32_e32 v7, 0xffff0000, v6
	v_lshlrev_b32_e32 v6, 16, v6
	v_max_f32_e64 v0, |v6|, 0
	v_cmp_o_f32_e64 vcc, |v6|, |v6|
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_max_f32_e64 v10, v0, |v7|
	v_cmp_o_f32_e64 vcc, v0, |v7|
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v10, vcc
	v_max_f32_e64 v10, v0, |v8|
	v_cmp_o_f32_e64 vcc, v0, |v8|
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v10, vcc
	v_max_f32_e64 v10, v0, |v9|
	v_cmp_o_f32_e64 vcc, v0, |v9|
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v10, vcc
	ds_swizzle_b32 v10, v0 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v0, v10
	v_cmp_o_f32_e32 vcc, v0, v10
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v11, vcc
	ds_swizzle_b32 v10, v0 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v0, v10
	v_cmp_o_f32_e32 vcc, v0, v10
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v11, vcc
	ds_swizzle_b32 v10, v0 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v0, v10
	v_cmp_o_f32_e32 vcc, v0, v10
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v11, vcc
	ds_swizzle_b32 v10, v0 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v0, v10
	v_cmp_o_f32_e32 vcc, v0, v10
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v11, vcc
	ds_swizzle_b32 v10, v0 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v0, v10
	v_cmp_o_f32_e32 vcc, v0, v10
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v11, vcc
	ds_bpermute_b32 v4, v4, v0
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v0, v4
	v_cmp_o_f32_e32 vcc, v0, v4
	s_nop 1
	v_cndmask_b32_e32 v0, v3, v10, vcc
	v_div_scale_f32 v4, s[8:9], s1, s1, v0
	v_rcp_f32_e32 v10, v4
	s_nop 0
	v_fma_f32 v11, -v4, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, v0, s1, v0
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v4, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v4, -v4, v12, v11
	v_div_fmas_f32 v4, v4, v10, v12
	v_div_fixup_f32 v4, v4, s1, v0
	v_cmp_neq_f32_e32 vcc, 0, v0
	s_lshl_b32 s1, s2, 4
	s_and_b32 s1, s1, 0xf0
	v_cndmask_b32_e32 v4, 1.0, v4, vcc
	v_div_scale_f32 v0, s[8:9], v4, v4, 1.0
	v_rcp_f32_e32 v10, v0
	v_xor_b32_e32 v2, s1, v2
	v_or_b32_e32 v2, s0, v2
	ds_write_b32 v5, v4 offset:8304
	v_fma_f32 v11, -v0, v10, 1.0
	v_fmac_f32_e32 v10, v11, v10
	v_div_scale_f32 v11, vcc, 1.0, v4, 1.0
	v_mul_f32_e32 v12, v11, v10
	v_fma_f32 v13, -v0, v12, v11
	v_fmac_f32_e32 v12, v13, v10
	v_fma_f32 v0, -v0, v12, v11
	v_div_fmas_f32 v0, v0, v10, v12
	v_div_fixup_f32 v0, v0, v4, 1.0
	v_pk_mul_f32 v[6:7], v[0:1], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[0:1], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v0, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_and_b32 s1, s15, 0xffff
	s_lshl_b32 s15, s4, 12
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_max_f32_e32 v6, 0xc3700000, v0
	v_cmp_o_f32_e32 vcc, v0, v0
	s_add_i32 s15, s15, s12
	s_lshl_b32 s0, s15, 1
	v_cndmask_b32_e32 v0, v3, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_ashr_i32 s4, s15, 31
	s_lshr_b32 s7, s4, 27
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_max_f32_e32 v7, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_brev_b32 s2, 16
	s_mov_b32 s29, s1
	v_cndmask_b32_e32 v6, v3, v7, vcc
	v_min_f32_e32 v7, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	v_cvt_pk_fp8_f32 v41, v0, v6
	s_mov_b32 s30, s2
	v_cndmask_b32_e32 v7, v3, v7, vcc
	v_max_f32_e32 v8, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_and_b32 s9, s17, 0xffff
	s_mov_b32 s37, s9
	v_cndmask_b32_e32 v7, v3, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	s_mov_b32 s17, 0
	s_mov_b32 s8, s16
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_max_f32_e32 v0, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	s_add_i32 s16, s15, 0x80
	s_nop 0
	v_cndmask_b32_e32 v0, v3, v0, vcc
	v_cvt_pk_fp8_f32 v41, v7, v0 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v0, 0x7f7f7f7f, v41
	v_add_u32_e32 v0, 0x7f7f7f7f, v0
	v_or_b32_e32 v0, 0x7f7f7f7f, v0
	v_and_b32_e32 v0, v0, v41
	ds_write_b32 v2, v0 offset:7168
	v_lshlrev_b32_e32 v0, 2, v38
	v_or_b32_e32 v4, 12, v0
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_or_b32_e32 v2, 4, v0
	v_or_b32_e32 v3, 8, v0
	v_or_b32_e32 v5, 64, v0
	v_or_b32_e32 v6, 0x44, v0
	v_or_b32_e32 v7, 0x48, v0
	v_or_b32_e32 v8, 0x4c, v0
	buffer_load_dword v78, v0, s[24:27], 0 offen
	buffer_load_dword v79, v2, s[24:27], 0 offen
	buffer_load_dword v80, v3, s[24:27], 0 offen
	buffer_load_dword v81, v4, s[24:27], 0 offen
	buffer_load_dword v74, v5, s[24:27], 0 offen
	buffer_load_dword v75, v6, s[24:27], 0 offen
	buffer_load_dword v76, v7, s[24:27], 0 offen
	buffer_load_dword v77, v8, s[24:27], 0 offen
	v_accvgpr_read_b32 v4, a23
	v_or3_b32 v2, s0, v4, v1
	s_lshl_b32 s0, s15, 3
	v_or3_b32 v3, s0, v4, v1
	s_or_b32 s0, s15, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_or_b32_e32 v0, s15, v1
	v_lshlrev_b32_e32 v3, 4, v3
	s_add_i32 s7, s7, s4
	v_lshlrev_b32_e32 v0, 2, v0
	buffer_load_dwordx4 v[70:73], v3, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[66:69], v3, s[28:31], 0 offen offset:1024 nt
	v_or_b32_e32 v3, s0, v1
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v3, 2, v3
	buffer_load_dword v101, v0, s[44:47], 0 offen
	buffer_load_dword v100, v3, s[44:47], 0 offen
	v_or3_b32 v0, s4, v4, v1
	v_lshlrev_b32_e32 v2, 2, v2
	v_lshlrev_b32_e32 v0, 2, v0
	s_lshl_b32 s0, s0, 3
	buffer_load_dword v102, v2, s[36:39], 0 offen
	buffer_load_dword v95, v0, s[36:39], 0 offen
	v_or3_b32 v0, s0, v4, v1
	v_lshlrev_b32_e32 v0, 4, v0
	v_or_b32_e32 v2, 0x400, v0
	buffer_load_dwordx4 v[62:65], v0, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[58:61], v2, s[28:31], 0 offen nt
	v_add_u32_e32 v0, v201, v171
	ds_read2st64_b64 v[38:41], v0 offset1:8
	ds_read2st64_b64 v[34:37], v142 offset1:8
	ds_read2st64_b64 v[30:33], v143 offset1:8
	ds_read2st64_b64 v[26:29], v144 offset1:8
	ds_read2st64_b64 v[22:25], v145 offset1:8
	ds_read2st64_b64 v[18:21], v146 offset1:8
	ds_read2st64_b64 v[14:17], v147 offset1:8
	ds_read2st64_b64 v[10:13], v172 offset1:8
	v_lshlrev_b32_e32 v0, 4, v103
	ds_read_b128 v[6:9], v0 offset:8192
	ds_read_b128 v[2:5], v0 offset:8256
	v_lshrrev_b32_e32 v0, 5, v46
	v_or_b32_e32 v42, s48, v0
	v_lshlrev_b32_e32 v90, 2, v42
	v_or_b32_e32 v42, 8, v0
	v_or_b32_e32 v43, s48, v42
	v_lshlrev_b32_e32 v88, 2, v43
	v_or_b32_e32 v43, 16, v0
	v_or_b32_e32 v44, s48, v43
	v_lshlrev_b32_e32 v87, 2, v44
	v_or_b32_e32 v44, 24, v0
	v_lshlrev_b32_e32 v91, 8, v0
	v_lshlrev_b32_e32 v0, 2, v46
	v_or_b32_e32 v45, s48, v44
	v_and_b32_e32 v97, 0xfc, v0
	v_accvgpr_read_b32 v0, a21
	s_mov_b32 s0, s14
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_or_b32 s14, s15, 1
	v_lshlrev_b32_e32 v85, 2, v45
	v_lshlrev_b32_e32 v89, 8, v42
	v_lshlrev_b32_e32 v86, 8, v43
	v_lshlrev_b32_e32 v84, 8, v44
	v_and_b32_e32 v98, 0x3f0, v0
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[12:13]
	s_add_i32 s17, s17, 1
	s_cmp_lg_u32 s17, 31
	v_mov_b64_e32 v[72:73], v[56:57]
	v_mov_b64_e32 v[70:71], v[54:55]
	v_mov_b64_e32 v[68:69], v[52:53]
	v_mov_b64_e32 v[66:67], v[50:51]
	v_mov_b64_e32 v[64:65], v[48:49]
	v_mov_b64_e32 v[62:63], v[46:47]
	v_mov_b64_e32 v[60:61], v[44:45]
	v_mov_b64_e32 v[58:59], v[42:43]
	v_mov_b32_e32 v100, v0
	v_mov_b32_e32 v101, v94
	v_mov_b32_e32 v102, v99
	s_cbranch_scc0 .LBB0_13
.LBB0_5:
	s_lshl_b32 s18, s17, 7
	s_add_i32 s12, s14, s18
	s_lshr_b32 s13, s12, 31
	s_add_i32 s13, s12, s13
	s_and_b32 s13, s13, 0x1ffffffe
	s_sub_i32 s12, s12, s13
	s_lshl_b32 s12, s12, 3
	s_waitcnt vmcnt(2)
	v_bfe_u32 v112, v95, s12, 8
	s_add_i32 s12, s12, 16
	v_bfe_u32 v113, v95, s12, 8
	s_add_i32 s12, s16, s18
	v_or_b32_e32 v0, s12, v1
	v_lshlrev_b32_e32 v42, 2, v0
	v_lshl_or_b32 v43, s12, 3, v97
	v_lshl_or_b32 v0, s12, 7, v98
	s_or_b32 s13, s12, 16
	s_ashr_i32 s12, s12, 31
	s_lshr_b32 s19, s12, 27
	s_add_i32 s19, s13, s19
	s_lshr_b32 s19, s19, 5
	buffer_load_dwordx4 v[54:57], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[50:53], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s13, v1
	s_add_i32 s19, s19, s12
	v_lshlrev_b32_e32 v44, 2, v0
	buffer_load_dword v94, v42, s[4:7], 0 offen
	buffer_load_dword v0, v44, s[4:7], 0 offen
	v_lshl_or_b32 v42, s19, 8, v97
	v_lshl_or_b32 v103, s13, 7, v98
	buffer_load_dword v99, v43, s[8:11], 0 offen
	buffer_load_dword v95, v42, s[8:11], 0 offen
	buffer_load_dwordx4 v[46:49], v103, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[42:45], v103, s[0:3], 0 offen offset:1024 nt
	s_and_b32 s12, s17, 1
	v_sub_u32_sdwa v103, v101, v102 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v104, 11, v103
	v_mul_lo_u32 v104, v104, s40
	v_sub_u32_e32 v105, 0x6c686080, v104
	v_and_b32_e32 v105, 0xffffff00, v105
	v_cmp_lt_i32_e32 vcc, 11, v103
	v_sub_u32_e32 v104, 0x7c787470, v104
	v_lshlrev_b32_e32 v106, 4, v70
	v_cndmask_b32_e64 v114, v105, 0, vcc
	v_cndmask_b32_e64 v115, v104, 0, vcc
	v_add_u32_e32 v103, 0x7f7f7f00, v114
	v_and_b32_e32 v116, 0x80808000, v103
	v_add_u32_e32 v103, 0x7f7f7f78, v115
	v_and_b32_e32 v117, 0x80808080, v103
	v_and_b32_e32 v103, 0x7070707, v70
	v_lshrrev_b32_e32 v104, 4, v70
	v_and_b32_e32 v104, 0x7070707, v104
	v_perm_b32 v105, v117, v116, v103
	v_perm_b32 v103, v115, v114, v103
	v_and_or_b32 v103, v105, v106, v103
	v_perm_b32 v105, v117, v116, v104
	v_perm_b32 v104, v115, v114, v104
	v_and_or_b32 v70, v105, v70, v104
	v_sub_u32_sdwa v118, v101, v102 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v108, v70, v103, s41
	v_perm_b32 v109, v70, v103, s42
	v_min_i32_e32 v70, 11, v118
	v_mul_lo_u32 v119, v70, s40
	v_and_b32_e32 v70, 0x7070707, v71
	v_lshrrev_b32_e32 v102, 4, v71
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[38:39], v[108:109], 0
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v103, v117, v116, v70
	v_lshlrev_b32_e32 v120, 4, v71
	v_perm_b32 v70, v115, v114, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[108:111], v[40:41], v[108:109], 0
	v_and_or_b32 v103, v103, v120, v70
	v_perm_b32 v70, v117, v116, v102
	v_perm_b32 v102, v115, v114, v102
	v_and_or_b32 v71, v70, v71, v102
	v_perm_b32 v70, v71, v103, s41
	v_perm_b32 v71, v71, v103, s42
	v_cmp_lt_i32_e32 vcc, 11, v118
	v_sub_u32_e32 v113, v100, v113
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[34:35], v[70:71], v[104:107]
	s_cmp_eq_u32 s12, 0
	s_cselect_b32 s19, 0x4000, 0
	s_nop 0
	v_sub_u32_e32 v106, 0x6c686080, v119
	v_and_b32_e32 v120, 0xffffff00, v106
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[36:37], v[70:71], v[108:111]
	v_and_b32_e32 v70, 0x7070707, v72
	v_lshrrev_b32_e32 v71, 4, v72
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v110, v117, v116, v70
	v_lshlrev_b32_e32 v111, 4, v72
	v_perm_b32 v70, v115, v114, v70
	v_and_or_b32 v110, v110, v111, v70
	v_perm_b32 v70, v117, v116, v71
	v_perm_b32 v71, v115, v114, v71
	v_and_or_b32 v71, v70, v72, v71
	v_perm_b32 v70, v71, v110, s41
	v_perm_b32 v71, v71, v110, s42
	v_lshlrev_b32_e32 v110, 4, v73
	v_sub_u32_e32 v119, 0x7c787470, v119
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[30:31], v[70:71], v[102:105]
	v_cndmask_b32_e64 v118, v120, 0, vcc
	v_cndmask_b32_e64 v119, v119, 0, vcc
	v_add_u32_e32 v120, 0x7f7f7f00, v118
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[32:33], v[70:71], v[106:109]
	v_and_b32_e32 v70, 0x7070707, v73
	v_lshrrev_b32_e32 v71, 4, v73
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v117, v116, v70
	v_perm_b32 v70, v115, v114, v70
	v_and_or_b32 v70, v72, v110, v70
	v_perm_b32 v72, v117, v116, v71
	v_perm_b32 v71, v115, v114, v71
	v_and_or_b32 v71, v72, v73, v71
	v_perm_b32 v110, v71, v70, s41
	v_perm_b32 v111, v71, v70, s42
	v_and_b32_e32 v114, 0x80808000, v120
	s_waitcnt vmcnt(9)
	v_lshrrev_b32_e32 v116, 4, v63
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[26:27], v[110:111], v[102:105]
	v_and_b32_e32 v116, 0x7070707, v116
	s_nop 1
	v_add_u32_e32 v102, 0x7f7f7f78, v119
	v_and_b32_e32 v115, 0x80808080, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[28:29], v[110:111], v[106:109]
	s_nop 2
	v_and_b32_e32 v106, 0x7070707, v66
	v_lshrrev_b32_e32 v107, 4, v66
	v_and_b32_e32 v107, 0x7070707, v107
	v_perm_b32 v108, v115, v114, v106
	v_lshlrev_b32_e32 v109, 4, v66
	v_perm_b32 v106, v119, v118, v106
	v_and_or_b32 v108, v108, v109, v106
	v_perm_b32 v106, v115, v114, v107
	v_perm_b32 v107, v119, v118, v107
	v_and_or_b32 v66, v106, v66, v107
	v_perm_b32 v106, v66, v108, s41
	v_perm_b32 v107, v66, v108, s42
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshlrev_b32_e32 v108, 4, v67
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[22:23], v[106:107], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[24:25], v[106:107], v[102:105]
	v_lshrrev_b32_e32 v106, 4, v67
	v_and_b32_e32 v106, 0x7070707, v106
	v_perm_b32 v107, v115, v114, v66
	v_perm_b32 v66, v119, v118, v66
	v_and_or_b32 v107, v107, v108, v66
	v_perm_b32 v66, v115, v114, v106
	v_perm_b32 v106, v119, v118, v106
	v_and_or_b32 v67, v66, v67, v106
	v_perm_b32 v66, v67, v107, s41
	v_perm_b32 v67, v67, v107, s42
	v_lshlrev_b32_e32 v107, 4, v68
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[18:19], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[20:21], v[66:67], v[102:105]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v106, v115, v114, v66
	v_perm_b32 v66, v119, v118, v66
	v_and_or_b32 v106, v106, v107, v66
	v_perm_b32 v66, v115, v114, v67
	v_perm_b32 v67, v119, v118, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v106, s41
	v_perm_b32 v67, v67, v106, s42
	v_lshlrev_b32_e32 v106, 4, v69
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[14:15], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[16:17], v[66:67], v[102:105]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v68, v115, v114, v66
	v_perm_b32 v66, v119, v118, v66
	v_and_or_b32 v68, v68, v106, v66
	v_perm_b32 v66, v115, v114, v67
	v_perm_b32 v67, v119, v118, v67
	v_and_or_b32 v67, v66, v69, v67
	v_perm_b32 v66, v67, v68, s41
	v_perm_b32 v67, v67, v68, s42
	v_lshlrev_b32_e32 v118, 4, v63
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[10:11], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[12:13], v[66:67], v[102:105]
	s_nop 2
	v_sub_u32_e32 v102, v100, v112
	v_min_i32_e32 v103, 11, v102
	v_mul_lo_u32 v103, v103, s40
	v_sub_u32_e32 v104, 0x6c686080, v103
	v_and_b32_e32 v104, 0xffffff00, v104
	v_cmp_lt_i32_e32 vcc, 11, v102
	v_sub_u32_e32 v103, 0x7c787470, v103
	v_lshlrev_b32_e32 v105, 4, v62
	v_cndmask_b32_e64 v110, v104, 0, vcc
	v_cndmask_b32_e64 v111, v103, 0, vcc
	v_add_u32_e32 v102, 0x7f7f7f00, v110
	v_and_b32_e32 v112, 0x80808000, v102
	v_add_u32_e32 v102, 0x7f7f7f78, v111
	v_and_b32_e32 v114, 0x80808080, v102
	v_and_b32_e32 v102, 0x7070707, v62
	v_lshrrev_b32_e32 v103, 4, v62
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v114, v112, v102
	v_perm_b32 v102, v111, v110, v102
	v_and_or_b32 v102, v104, v105, v102
	v_perm_b32 v104, v114, v112, v103
	v_perm_b32 v103, v111, v110, v103
	v_and_or_b32 v62, v104, v62, v103
	v_perm_b32 v106, v62, v102, s41
	v_perm_b32 v107, v62, v102, s42
	v_min_i32_e32 v62, 11, v113
	v_mul_lo_u32 v115, v62, s40
	v_and_b32_e32 v62, 0x7070707, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[38:39], v[106:107], 0
	v_perm_b32 v117, v114, v112, v62
	v_perm_b32 v62, v111, v110, v62
	v_and_or_b32 v117, v117, v118, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[40:41], v[106:107], 0
	v_perm_b32 v62, v114, v112, v116
	v_perm_b32 v116, v111, v110, v116
	v_and_or_b32 v63, v62, v63, v116
	v_perm_b32 v62, v63, v117, s41
	v_perm_b32 v63, v63, v117, s42
	v_lshlrev_b32_e32 v118, 4, v64
	v_sub_u32_e32 v116, 0x6c686080, v115
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[34:35], v[62:63], v[102:105]
	v_and_b32_e32 v116, 0xffffff00, v116
	v_sub_u32_e32 v115, 0x7c787470, v115
	v_cmp_lt_i32_e32 vcc, 11, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[36:37], v[62:63], v[106:109]
	v_and_b32_e32 v62, 0x7070707, v64
	v_lshrrev_b32_e32 v63, 4, v64
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v117, v114, v112, v62
	v_perm_b32 v62, v111, v110, v62
	v_and_or_b32 v117, v117, v118, v62
	v_perm_b32 v62, v114, v112, v63
	v_perm_b32 v63, v111, v110, v63
	v_and_or_b32 v63, v62, v64, v63
	v_perm_b32 v62, v63, v117, s41
	v_perm_b32 v63, v63, v117, s42
	v_lshlrev_b32_e32 v117, 4, v65
	v_cndmask_b32_e64 v113, v116, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[30:31], v[62:63], v[102:105]
	v_cndmask_b32_e64 v115, v115, 0, vcc
	v_add_u32_e32 v116, 0x7f7f7f00, v113
	v_cmp_lt_i32_e32 vcc, 5, v101
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[32:33], v[62:63], v[106:109]
	v_and_b32_e32 v62, 0x7070707, v65
	v_lshrrev_b32_e32 v63, 4, v65
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v114, v112, v62
	v_perm_b32 v62, v111, v110, v62
	v_and_or_b32 v62, v64, v117, v62
	v_perm_b32 v64, v114, v112, v63
	v_perm_b32 v63, v111, v110, v63
	v_and_or_b32 v63, v64, v65, v63
	v_perm_b32 v110, v63, v62, s41
	v_perm_b32 v111, v63, v62, s42
	v_and_b32_e32 v112, 0x80808000, v116
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[110:111], v[102:105]
	s_nop 2
	v_add_u32_e32 v102, 0x7f7f7f78, v115
	v_and_b32_e32 v114, 0x80808080, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[28:29], v[110:111], v[106:109]
	s_waitcnt vmcnt(8)
	s_nop 1
	v_and_b32_e32 v106, 0x7070707, v58
	v_lshrrev_b32_e32 v107, 4, v58
	v_and_b32_e32 v107, 0x7070707, v107
	v_perm_b32 v108, v114, v112, v106
	v_lshlrev_b32_e32 v109, 4, v58
	v_perm_b32 v106, v115, v113, v106
	v_and_or_b32 v108, v108, v109, v106
	v_perm_b32 v106, v114, v112, v107
	v_perm_b32 v107, v115, v113, v107
	v_and_or_b32 v58, v106, v58, v107
	v_perm_b32 v106, v58, v108, s41
	v_perm_b32 v107, v58, v108, s42
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshlrev_b32_e32 v108, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[22:23], v[106:107], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[24:25], v[106:107], v[102:105]
	v_lshrrev_b32_e32 v106, 4, v59
	v_and_b32_e32 v106, 0x7070707, v106
	v_perm_b32 v107, v114, v112, v58
	v_perm_b32 v58, v115, v113, v58
	v_and_or_b32 v107, v107, v108, v58
	v_perm_b32 v58, v114, v112, v106
	v_perm_b32 v106, v115, v113, v106
	v_and_or_b32 v59, v58, v59, v106
	v_perm_b32 v58, v59, v107, s41
	v_perm_b32 v59, v59, v107, s42
	v_lshlrev_b32_e32 v107, 4, v60
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[18:19], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[20:21], v[58:59], v[102:105]
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v106, v114, v112, v58
	v_perm_b32 v58, v115, v113, v58
	v_and_or_b32 v106, v106, v107, v58
	v_perm_b32 v58, v114, v112, v59
	v_perm_b32 v59, v115, v113, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v106, s41
	v_perm_b32 v59, v59, v106, s42
	v_lshlrev_b32_e32 v106, 4, v61
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[16:17], v[58:59], v[102:105]
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v114, v112, v58
	v_perm_b32 v58, v115, v113, v58
	v_and_or_b32 v58, v60, v106, v58
	v_perm_b32 v60, v114, v112, v59
	v_perm_b32 v59, v115, v113, v59
	v_and_or_b32 v59, v60, v61, v59
	v_perm_b32 v106, v59, v58, s41
	v_perm_b32 v107, v59, v58, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[10:11], v[106:107], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[12:13], v[106:107], v[102:105]
	s_nop 2
	v_add_u32_e32 v103, 17, v101
	v_lshl_add_u32 v102, v101, 23, v82
	v_lshlrev_b32_e64 v103, v103, 1
	v_cndmask_b32_e32 v102, v103, v102, vcc
	v_add_u32_e32 v103, 17, v100
	v_lshlrev_b32_e64 v103, v103, 1
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[106:107], v[8:9], v[102:103] op_sel_hi:[1,0]
	v_lshl_add_u32 v101, v100, 23, v82
	v_pk_mul_f32 v[72:73], v[106:107], v[72:73]
	v_cmp_lt_i32_e32 vcc, 5, v100
	v_pk_mul_f32 v[72:73], v[72:73], v[80:81]
	v_pk_mul_f32 v[104:105], v[6:7], v[102:103] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v100, v103, v101, vcc
	v_bfe_u32 v101, v73, 16, 1
	v_add3_u32 v101, v101, v73, s43
	v_or_b32_e32 v103, 0x400000, v73
	v_cmp_u_f32_e32 vcc, v73, v73
	v_pk_mul_f32 v[70:71], v[104:105], v[70:71]
	s_nop 0
	v_cndmask_b32_e32 v73, v101, v103, vcc
	v_bfe_u32 v101, v72, 16, 1
	v_pk_mul_f32 v[70:71], v[70:71], v[78:79]
	v_add3_u32 v101, v101, v72, s43
	v_or_b32_e32 v103, 0x400000, v72
	v_cmp_u_f32_e32 vcc, v72, v72
	s_nop 1
	v_cndmask_b32_e32 v72, v101, v103, vcc
	v_bfe_u32 v101, v71, 16, 1
	v_add3_u32 v101, v101, v71, s43
	v_or_b32_e32 v103, 0x400000, v71
	v_cmp_u_f32_e32 vcc, v71, v71
	s_nop 1
	v_cndmask_b32_e32 v71, v101, v103, vcc
	v_bfe_u32 v101, v70, 16, 1
	v_add3_u32 v101, v101, v70, s43
	v_or_b32_e32 v103, 0x400000, v70
	v_cmp_u_f32_e32 vcc, v70, v70
	s_nop 1
	v_cndmask_b32_e32 v70, v101, v103, vcc
	v_or_b32_e32 v101, s19, v93
	v_lshl_add_u32 v101, v92, 1, v101
	ds_write_b16_d16_hi v101, v70
	ds_write_b16_d16_hi v101, v71 offset:256
	ds_write_b16_d16_hi v101, v72 offset:512
	ds_write_b16_d16_hi v101, v73 offset:768
	v_pk_mul_f32 v[72:73], v[8:9], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[70:71], v[6:7], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[72:73], v[60:61]
	v_pk_mul_f32 v[58:59], v[70:71], v[58:59]
	v_pk_mul_f32 v[60:61], v[60:61], v[80:81]
	v_pk_mul_f32 v[58:59], v[58:59], v[78:79]
	v_bfe_u32 v70, v61, 16, 1
	v_add3_u32 v70, v70, v61, s43
	v_or_b32_e32 v71, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	s_nop 1
	v_cndmask_b32_e32 v61, v70, v71, vcc
	v_bfe_u32 v70, v60, 16, 1
	v_add3_u32 v70, v70, v60, s43
	v_or_b32_e32 v71, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v70, v71, vcc
	v_bfe_u32 v70, v59, 16, 1
	v_add3_u32 v70, v70, v59, s43
	v_or_b32_e32 v71, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v70, v71, vcc
	v_bfe_u32 v70, v58, 16, 1
	v_add3_u32 v70, v70, v58, s43
	v_or_b32_e32 v71, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v70, v71, vcc
	ds_write_b16_d16_hi v101, v58 offset:32
	ds_write_b16_d16_hi v101, v59 offset:288
	ds_write_b16_d16_hi v101, v60 offset:544
	ds_write_b16_d16_hi v101, v61 offset:800
	s_waitcnt lgkmcnt(8)
	v_pk_mul_f32 v[60:61], v[4:5], v[102:103] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[102:103] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[60:61], v[68:69]
	v_pk_mul_f32 v[58:59], v[58:59], v[66:67]
	v_pk_mul_f32 v[60:61], v[60:61], v[76:77]
	v_pk_mul_f32 v[58:59], v[58:59], v[74:75]
	v_bfe_u32 v66, v61, 16, 1
	v_add3_u32 v66, v66, v61, s43
	v_or_b32_e32 v67, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	s_nop 1
	v_cndmask_b32_e32 v61, v66, v67, vcc
	v_bfe_u32 v66, v60, 16, 1
	v_add3_u32 v66, v66, v60, s43
	v_or_b32_e32 v67, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v66, v67, vcc
	v_bfe_u32 v66, v59, 16, 1
	v_add3_u32 v66, v66, v59, s43
	v_or_b32_e32 v67, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v66, v67, vcc
	v_bfe_u32 v66, v58, 16, 1
	v_add3_u32 v66, v66, v58, s43
	v_or_b32_e32 v67, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v66, v67, vcc
	ds_write_b16_d16_hi v101, v58 offset:4096
	ds_write_b16_d16_hi v101, v59 offset:4352
	ds_write_b16_d16_hi v101, v60 offset:4608
	ds_write_b16_d16_hi v101, v61 offset:4864
	v_pk_mul_f32 v[60:61], v[4:5], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[100:101] op_sel_hi:[1,0]
	v_pk_mul_f32 v[60:61], v[60:61], v[64:65]
	v_pk_mul_f32 v[58:59], v[58:59], v[62:63]
	v_pk_mul_f32 v[60:61], v[60:61], v[76:77]
	v_pk_mul_f32 v[58:59], v[58:59], v[74:75]
	v_bfe_u32 v62, v61, 16, 1
	v_add3_u32 v62, v62, v61, s43
	v_or_b32_e32 v63, 0x400000, v61
	v_cmp_u_f32_e32 vcc, v61, v61
	s_nop 1
	v_cndmask_b32_e32 v61, v62, v63, vcc
	v_bfe_u32 v62, v60, 16, 1
	v_add3_u32 v62, v62, v60, s43
	v_or_b32_e32 v63, 0x400000, v60
	v_cmp_u_f32_e32 vcc, v60, v60
	s_nop 1
	v_cndmask_b32_e32 v60, v62, v63, vcc
	v_bfe_u32 v62, v59, 16, 1
	v_add3_u32 v62, v62, v59, s43
	v_or_b32_e32 v63, 0x400000, v59
	v_cmp_u_f32_e32 vcc, v59, v59
	s_nop 1
	v_cndmask_b32_e32 v59, v62, v63, vcc
	v_bfe_u32 v62, v58, 16, 1
	v_add3_u32 v62, v62, v58, s43
	v_or_b32_e32 v63, 0x400000, v58
	v_cmp_u_f32_e32 vcc, v58, v58
	s_nop 1
	v_cndmask_b32_e32 v58, v62, v63, vcc
	ds_write_b16_d16_hi v101, v58 offset:4128
	ds_write_b16_d16_hi v101, v59 offset:4384
	ds_write_b16_d16_hi v101, v60 offset:4640
	ds_write_b16_d16_hi v101, v61 offset:4896
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v58, v90, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_7
	v_add3_u32 v60, s19, v91, v83
	v_lshl_add_u32 v58, v58, 12, s18
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v96
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v60, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:128
.LBB0_7:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v58, v88, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_9
	v_add3_u32 v60, s19, v89, v83
	v_lshl_add_u32 v58, v58, 12, s18
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v96
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v60, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:128
.LBB0_9:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v58, v87, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_11
	v_add3_u32 v60, s19, v86, v83
	v_lshl_add_u32 v58, v58, 12, s18
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v96
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v60, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:128
.LBB0_11:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v58, v85, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_4
	v_add3_u32 v60, s19, v84, v83
	v_lshl_add_u32 v58, v58, 12, s18
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v96
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v60, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:128
	s_branch .LBB0_4
.LBB0_13:
	v_sub_u32_sdwa v1, v94, v99 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
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
	v_sub_u32_sdwa v69, v94, v99 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v62, v54, v58, s0
	v_perm_b32 v63, v54, v58, s1
	v_min_i32_e32 v54, 11, v69
	v_mul_lo_u32 v70, v54, s2
	v_and_b32_e32 v54, 0x7070707, v55
	v_lshrrev_b32_e32 v71, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[38:39], v[62:63], 0
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v68, v67, v54
	v_lshlrev_b32_e32 v73, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[40:41], v[62:63], 0
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
	s_add_i32 s3, s15, 0xf81
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
	v_bfe_u32 v1, v95, s3, 8
	v_sub_u32_e32 v1, v0, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[10:11], v[50:51], v[54:57]
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_add_i32 s3, s3, 16
	v_bfe_u32 v64, v95, s3, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[12:13], v[50:51], v[58:61]
	v_sub_u32_e32 v64, v0, v64
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
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[38:39], v[62:63], 0
	v_min_i32_e32 v38, 11, v64
	v_mul_lo_u32 v68, v38, s2
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[40:41], v[62:63], 0
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
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[36:37], v[46:47], v[38:41]
	s_nop 2
	v_and_b32_e32 v38, 0x7070707, v48
	v_lshrrev_b32_e32 v39, 4, v48
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v40, v67, v66, v38
	v_lshlrev_b32_e32 v41, 4, v48
	v_perm_b32 v38, v65, v1, v38
	v_and_or_b32 v38, v40, v41, v38
	v_perm_b32 v40, v67, v66, v39
	v_perm_b32 v39, v65, v1, v39
	v_and_or_b32 v39, v40, v48, v39
	v_perm_b32 v46, v39, v38, s0
	v_perm_b32 v47, v39, v38, s1
	v_cndmask_b32_e64 v48, v62, 0, vcc
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[30:31], v[46:47], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[32:33], v[46:47], v[34:37]
	s_nop 1
	v_cndmask_b32_e64 v58, v63, 0, vcc
	v_add_u32_e32 v59, 0x7f7f7f00, v48
	v_cmp_lt_i32_e32 vcc, 5, v94
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
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[26:27], v[46:47], v[38:41]
	v_add_u32_e32 v26, 0x7f7f7f78, v58
	s_nop 1
	v_and_b32_e32 v40, 0x80808080, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[28:29], v[46:47], v[30:33]
	s_nop 2
	v_and_b32_e32 v30, 0x7070707, v42
	v_lshrrev_b32_e32 v31, 4, v42
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v40, v1, v30
	v_lshlrev_b32_e32 v33, 4, v42
	v_perm_b32 v30, v58, v48, v30
	v_and_or_b32 v30, v32, v33, v30
	v_perm_b32 v32, v40, v1, v31
	v_perm_b32 v31, v58, v48, v31
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
	v_perm_b32 v28, v40, v1, v26
	v_lshlrev_b32_e32 v29, 4, v43
	v_perm_b32 v26, v58, v48, v26
	v_and_or_b32 v26, v28, v29, v26
	v_perm_b32 v28, v40, v1, v27
	v_perm_b32 v27, v58, v48, v27
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
	v_perm_b32 v24, v40, v1, v22
	v_lshlrev_b32_e32 v25, 4, v44
	v_perm_b32 v22, v58, v48, v22
	v_and_or_b32 v22, v24, v25, v22
	v_perm_b32 v24, v40, v1, v23
	v_perm_b32 v23, v58, v48, v23
	v_and_or_b32 v23, v24, v44, v23
	v_perm_b32 v30, v23, v22, s0
	v_perm_b32 v31, v23, v22, s1
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[14:15], v[30:31], v[26:29]
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[16:17], v[30:31], v[18:21]
	s_nop 2
	v_lshrrev_b32_e32 v19, 4, v45
	v_and_b32_e32 v18, 0x7070707, v45
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v40, v1, v18
	v_lshlrev_b32_e32 v21, 4, v45
	v_perm_b32 v18, v58, v48, v18
	v_perm_b32 v1, v40, v1, v19
	v_perm_b32 v19, v58, v48, v19
	v_and_or_b32 v18, v20, v21, v18
	v_and_or_b32 v1, v1, v45, v19
	v_perm_b32 v26, v1, v18, s0
	v_perm_b32 v27, v1, v18, s1
	v_mov_b32_e32 v1, 0xfd800000
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[10:11], v[26:27], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[12:13], v[26:27], v[14:17]
	s_nop 2
	v_add_u32_e32 v15, 17, v94
	v_lshl_add_u32 v14, v94, 23, v1
	v_lshlrev_b32_e64 v15, v15, 1
	v_cndmask_b32_e32 v14, v15, v14, vcc
	v_add_u32_e32 v15, 17, v0
	v_lshlrev_b32_e64 v15, v15, 1
	v_pk_mul_f32 v[22:23], v[8:9], v[14:15] op_sel_hi:[1,0]
	v_lshl_add_u32 v1, v0, 23, v1
	v_pk_mul_f32 v[22:23], v[22:23], v[56:57]
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[22:23], v[22:23], v[80:81]
	v_pk_mul_f32 v[16:17], v[6:7], v[14:15] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v0, v15, v1, vcc
	v_bfe_u32 v1, v23, 16, 1
	v_pk_mul_f32 v[16:17], v[16:17], v[54:55]
	v_add3_u32 v1, v1, v23, s0
	v_or_b32_e32 v15, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	v_pk_mul_f32 v[16:17], v[16:17], v[78:79]
	v_or_b32_e32 v23, 0x400000, v22
	v_cndmask_b32_e32 v1, v1, v15, vcc
	v_bfe_u32 v15, v22, 16, 1
	v_add3_u32 v15, v15, v22, s0
	v_cmp_u_f32_e32 vcc, v22, v22
	v_bfe_u32 v22, v17, 16, 1
	v_add3_u32 v22, v22, v17, s0
	v_cndmask_b32_e32 v15, v15, v23, vcc
	v_or_b32_e32 v23, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v17, v22, v23, vcc
	v_bfe_u32 v22, v16, 16, 1
	v_add3_u32 v22, v22, v16, s0
	v_or_b32_e32 v23, 0x400000, v16
	v_cmp_u_f32_e32 vcc, v16, v16
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
	v_cndmask_b32_e32 v16, v22, v23, vcc
	v_lshl_add_u32 v22, v92, 1, v93
	v_pk_mul_f32 v[8:9], v[8:9], v[80:81]
	ds_write_b16_d16_hi v22, v16
	ds_write_b16_d16_hi v22, v17 offset:256
	ds_write_b16_d16_hi v22, v15 offset:512
	ds_write_b16_d16_hi v22, v1 offset:768
	v_bfe_u32 v1, v9, 16, 1
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
	ds_write_b16_d16_hi v22, v6 offset:32
	ds_write_b16_d16_hi v22, v7 offset:288
	ds_write_b16_d16_hi v22, v8 offset:544
	ds_write_b16_d16_hi v22, v1 offset:800
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
	v_pk_mul_f32 v[2:3], v[2:3], v[74:75]
	s_nop 0
	v_cndmask_b32_e32 v6, v9, v14, vcc
	ds_write_b16_d16_hi v22, v6 offset:4096
	ds_write_b16_d16_hi v22, v7 offset:4352
	ds_write_b16_d16_hi v22, v8 offset:4608
	ds_write_b16_d16_hi v22, v1 offset:4864
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[12:13]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[76:77]
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
	ds_write_b16_d16_hi v22, v2 offset:4128
	ds_write_b16_d16_hi v22, v3 offset:4384
	ds_write_b16_d16_hi v22, v0 offset:4640
	ds_write_b16_d16_hi v22, v1 offset:4896
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v90, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_15
	v_add_u32_e32 v2, v91, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_15:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v88, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_17
	v_add_u32_e32 v2, v89, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_17:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v87, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_19
	v_add_u32_e32 v2, v86, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_19:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v85, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_21
	v_add_u32_e32 v2, v84, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[34:35], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v3, off offset:3840
	ds_read_b32 v2, v2 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_21:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db
		.amdhsa_group_segment_fixed_size 32768
		.amdhsa_private_segment_fixed_size 0
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
		.amdhsa_enable_private_segment 0
		.amdhsa_system_sgpr_workgroup_id_x 1
		.amdhsa_system_sgpr_workgroup_id_y 0
		.amdhsa_system_sgpr_workgroup_id_z 0
		.amdhsa_system_sgpr_workgroup_info 0
		.amdhsa_system_vgpr_workitem_id 0
		.amdhsa_next_free_vgpr 299
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.num_vgpr, 256
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.num_agpr, 43
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.numbered_sgpr, 57
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.has_indirect_call, 0
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
  - .agpr_count:     43
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
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     63
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk256_tn128_bcm12_xcd1_ftz_a2r_db.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     299
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
