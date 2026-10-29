	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r:
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
	s_cbranch_scc1 .LBB0_22
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
	v_lshrrev_b32_e32 v4, 3, v0
	v_or_b32_e32 v2, s48, v4
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dword v2, v[2:3], off
	s_load_dword s50, s[54:55], 0x0
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dwordx2 s[34:35], s[0:1], 0x60
	s_load_dword s33, s[0:1], 0x68
	s_and_b32 s51, s52, 0xffffffc0
	v_and_b32_e32 v135, 48, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s45, s5, 0xffff
	s_lshl_b32 s5, s50, 9
	s_mov_b32 s44, s4
	s_mov_b32 s28, s4
	s_add_i32 s4, s5, s51
	s_ashr_i32 s53, s4, 31
	v_and_b32_e32 v1, 15, v0
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
	s_lshr_b32 s57, s53, 27
	s_lshr_b32 s54, s4, 31
	v_or3_b32 v160, s8, v135, v1
	v_or3_b32 v161, s9, v135, v1
	s_lshl_b32 s8, s10, 7
	s_lshl_b32 s9, s10, 5
	s_ashr_i32 s10, s11, 4
	s_lshl_b32 s56, s11, 7
	s_add_i32 s11, s11, s57
	v_or3_b32 v162, s8, v135, v1
	s_add_i32 s8, s10, s54
	s_lshr_b32 s11, s11, 5
	s_and_b32 s8, s8, -2
	s_add_i32 s11, s11, s53
	s_sub_i32 s8, s10, s8
	s_lshl_b32 s10, s11, 10
	v_or3_b32 v167, s10, v135, v1
	s_or_b32 s10, s4, 32
	v_xor_b32_e32 v3, v4, v0
	s_lshl_b32 s11, s10, 7
	s_lshl_b32 s10, s10, 5
	v_lshlrev_b32_e32 v3, 4, v3
	v_or3_b32 v171, s10, v135, v1
	s_add_i32 s10, s4, 0x120
	v_and_b32_e32 v3, 0x70, v3
	v_or3_b32 v170, s11, v135, v1
	s_lshl_b32 s11, s10, 7
	s_lshl_b32 s10, s10, 5
	s_mov_b32 s47, 0x27000
	s_lshl_b32 s46, s33, 12
	v_or3_b32 v174, s10, v135, v1
	s_or_b32 s10, s4, 48
	v_or3_b32 v173, s11, v135, v1
	s_ashr_i32 s11, s10, 4
	s_mov_b32 s29, s45
	s_add_i32 s55, s4, 0x110
	v_or_b32_e32 v144, s51, v1
	s_ashr_i32 s60, s55, 31
	s_mov_b32 s30, s46
	v_or3_b32 v163, s9, v135, v1
	s_lshr_b32 s9, s60, 27
	s_add_i32 s9, s55, s9
	s_lshr_b32 s9, s9, 5
	s_add_i32 s9, s9, s60
	s_mov_b32 s26, 0x1000000
	s_lshl_b32 s9, s9, 10
	s_mov_b32 s42, s26
	s_mov_b32 s43, s47
	s_mov_b32 s41, s25
	v_or3_b32 v169, s9, v135, v1
	v_lshlrev_b32_e32 v6, 2, v163
	v_lshlrev_b32_e32 v7, 2, v169
	v_lshlrev_b32_e32 v8, 2, v174
	s_brev_b32 s2, 8
	v_or3_b32 v164, s56, v135, v1
	s_mov_b32 s38, s2
	s_mov_b32 s39, s47
	s_mov_b32 s37, s1
	s_waitcnt vmcnt(0)
	v_lshl_or_b32 v168, v2, 12, v3
	buffer_load_dwordx4 v[28:31], v168, s[44:47], 0 offen nt
	s_lshl_b32 s44, s10, 7
	s_add_i32 s10, s10, s57
	s_lshr_b32 s10, s10, 5
	s_add_i32 s10, s10, s53
	s_lshl_b32 s10, s10, 10
	v_or3_b32 v176, s10, v135, v1
	s_add_i32 s10, s11, s54
	s_and_b32 s10, s10, -2
	s_sub_i32 s11, s11, s10
	s_add_i32 s10, s4, 0x130
	s_lshl_b32 s45, s10, 7
	v_or3_b32 v177, s45, v135, v1
	s_ashr_i32 s45, s10, 31
	s_lshr_b32 s46, s45, 27
	v_add_u32_e32 v2, s5, v144
	s_add_i32 s46, s10, s46
	v_ashrrev_i32_e32 v3, 31, v2
	s_lshr_b32 s46, s46, 5
	v_lshl_add_u64 v[4:5], v[2:3], 2, s[12:13]
	v_add_u32_e32 v2, 0x100, v2
	s_add_i32 s46, s46, s45
	v_ashrrev_i32_e32 v3, 31, v2
	s_lshl_b32 s45, s46, 10
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	v_or3_b32 v178, s45, v135, v1
	global_load_dword v151, v[4:5], off
	global_load_dword v152, v[4:5], off offset:64
	global_load_dword v147, v[4:5], off offset:128
	global_load_dword v148, v[4:5], off offset:192
	global_load_dword v149, v[2:3], off
	global_load_dword v150, v[2:3], off offset:64
	global_load_dword v145, v[2:3], off offset:128
	global_load_dword v146, v[2:3], off offset:192
	v_lshlrev_b32_e32 v2, 2, v161
	v_lshlrev_b32_e32 v3, 2, v167
	v_lshlrev_b32_e32 v4, 2, v171
	v_lshlrev_b32_e32 v5, 2, v176
	v_lshlrev_b32_e32 v9, 2, v178
	buffer_load_dword v181, v2, s[40:43], 0 offen
	buffer_load_dword v157, v3, s[40:43], 0 offen
	buffer_load_dword v156, v4, s[40:43], 0 offen
	buffer_load_dword v153, v5, s[40:43], 0 offen
	buffer_load_dword v180, v6, s[40:43], 0 offen
	buffer_load_dword v158, v7, s[40:43], 0 offen
	buffer_load_dword v155, v8, s[40:43], 0 offen
	buffer_load_dword v154, v9, s[40:43], 0 offen
	s_lshl_b32 s59, s55, 7
	v_or3_b32 v175, s44, v135, v1
	v_lshlrev_b32_e32 v2, 4, v160
	v_lshlrev_b32_e32 v3, 4, v164
	v_or3_b32 v165, s59, v135, v1
	buffer_load_dwordx4 v[42:45], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v3, s[36:39], 0 offen sc0
	v_lshlrev_b32_e32 v2, 4, v170
	v_lshlrev_b32_e32 v3, 4, v175
	buffer_load_dwordx4 v[10:13], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v3, s[36:39], 0 offen sc0
	v_lshlrev_b32_e32 v2, 4, v162
	v_lshlrev_b32_e32 v3, 4, v165
	v_lshlrev_b32_e32 v26, 4, v173
	buffer_load_dwordx4 v[46:49], v2, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v3, s[36:39], 0 offen sc0
	v_lshlrev_b32_e32 v27, 4, v177
	buffer_load_dwordx4 v[14:17], v26, s[36:39], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v27, s[36:39], 0 offen sc0
	v_bfe_u32 v134, v0, 4, 2
	s_ashr_i32 s58, s55, 4
	s_lshr_b32 s9, s55, 31
	s_ashr_i32 s44, s10, 4
	s_lshr_b32 s10, s10, 31
	s_add_i32 s9, s58, s9
	s_add_i32 s10, s44, s10
	v_lshlrev_b32_e32 v136, 4, v0
	v_lshlrev_b32_e32 v138, 5, v134
	s_and_b32 s9, s9, -2
	s_and_b32 s10, s10, -2
	v_and_b32_e32 v26, 0x70, v136
	v_or_b32_e32 v139, 24, v138
	s_sub_i32 s9, s58, s9
	s_sub_i32 s44, s44, s10
	v_lshlrev_b32_e32 v140, 7, v1
	v_xor_b32_e32 v179, v138, v26
	v_or_b32_e32 v142, 8, v138
	v_or_b32_e32 v141, 16, v138
	v_xor_b32_e32 v159, v139, v26
	v_mov_b32_e32 v66, 0
	v_and_b32_e32 v143, 63, v0
	s_mov_b32 s31, s47
	s_mov_b32 s3, s47
	s_mov_b32 s27, s47
	s_lshl_b32 s10, s8, 3
	s_lshl_b32 s8, s11, 3
	s_lshl_b32 s9, s9, 3
	s_lshl_b32 s5, s44, 3
	v_or_b32_e32 v182, 0x800, v140
	v_xor_b32_e32 v172, v142, v26
	v_xor_b32_e32 v166, v141, v26
	s_waitcnt vmcnt(24)
	ds_write_b128 v136, v[28:31]
	v_or_b32_e32 v183, v140, v159
	v_lshlrev_b32_e32 v137, 2, v0
	v_or_b32_e32 v184, v140, v179
	s_mov_b32 s11, 0x8080808
	s_mov_b32 s12, 0x5010400
	s_mov_b32 s13, 0x7030602
	v_mov_b32_e32 v67, v66
	v_mov_b32_e32 v68, v66
	v_mov_b32_e32 v69, v66
	v_mov_b32_e32 v50, v66
	v_mov_b32_e32 v51, v66
	v_mov_b32_e32 v52, v66
	v_mov_b32_e32 v53, v66
	v_mov_b32_e32 v26, v66
	v_mov_b32_e32 v27, v66
	v_mov_b32_e32 v28, v66
	v_mov_b32_e32 v29, v66
	v_mov_b32_e32 v82, v66
	v_mov_b32_e32 v83, v66
	v_mov_b32_e32 v84, v66
	v_mov_b32_e32 v85, v66
	v_mov_b32_e32 v70, v66
	v_mov_b32_e32 v71, v66
	v_mov_b32_e32 v72, v66
	v_mov_b32_e32 v73, v66
	v_mov_b32_e32 v54, v66
	v_mov_b32_e32 v55, v66
	v_mov_b32_e32 v56, v66
	v_mov_b32_e32 v57, v66
	v_mov_b32_e32 v30, v66
	v_mov_b32_e32 v31, v66
	v_mov_b32_e32 v32, v66
	v_mov_b32_e32 v33, v66
	v_mov_b32_e32 v86, v66
	v_mov_b32_e32 v87, v66
	v_mov_b32_e32 v88, v66
	v_mov_b32_e32 v89, v66
	v_mov_b32_e32 v74, v66
	v_mov_b32_e32 v75, v66
	v_mov_b32_e32 v76, v66
	v_mov_b32_e32 v77, v66
	v_mov_b32_e32 v58, v66
	v_mov_b32_e32 v59, v66
	v_mov_b32_e32 v60, v66
	v_mov_b32_e32 v61, v66
	v_mov_b32_e32 v34, v66
	v_mov_b32_e32 v35, v66
	v_mov_b32_e32 v36, v66
	v_mov_b32_e32 v37, v66
	v_mov_b32_e32 v90, v66
	v_mov_b32_e32 v91, v66
	v_mov_b32_e32 v92, v66
	v_mov_b32_e32 v93, v66
	v_mov_b32_e32 v78, v66
	v_mov_b32_e32 v79, v66
	v_mov_b32_e32 v80, v66
	v_mov_b32_e32 v81, v66
	v_mov_b32_e32 v62, v66
	v_mov_b32_e32 v63, v66
	v_mov_b32_e32 v64, v66
	v_mov_b32_e32 v65, v66
	v_mov_b32_e32 v38, v66
	v_mov_b32_e32 v39, v66
	v_mov_b32_e32 v40, v66
	v_mov_b32_e32 v41, v66
	v_mov_b32_e32 v94, v66
	v_mov_b32_e32 v95, v66
	v_mov_b32_e32 v96, v66
	v_mov_b32_e32 v97, v66
.LBB0_2:
	s_and_b32 s36, s49, 1
	s_add_i32 s49, s49, 1
	s_lshl_b32 s38, s49, 5
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[100:101], v[4:5]
	v_mov_b64_e32 v[98:99], v[2:3]
	s_lshl_b32 s37, s36, 4
	v_lshl_add_u32 v2, s49, 7, v168
	s_lshl_b32 s39, s49, 6
	s_and_b32 s38, s38, 0x7c0
	v_mov_b64_e32 v[112:113], v[16:17]
	v_mov_b64_e32 v[110:111], v[14:15]
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_bfe_u32 v118, v181, s37, 8
	s_add_i32 s40, s37, s10
	v_bfe_u32 v188, v156, s37, 8
	s_add_i32 s41, s37, s8
	v_bfe_u32 v119, v180, s37, 8
	s_add_i32 s42, s37, s9
	v_bfe_u32 v187, v155, s37, 8
	s_add_i32 s37, s37, s5
	buffer_load_dwordx4 v[190:193], v2, s[28:31], 0 offen nt
	v_add_lshl_u32 v2, s39, v160, 4
	v_add_lshl_u32 v3, s39, v164, 4
	v_add_lshl_u32 v4, s39, v170, 4
	v_add_lshl_u32 v5, s39, v175, 4
	v_add_lshl_u32 v14, s39, v162, 4
	v_add_lshl_u32 v15, s39, v165, 4
	v_add_lshl_u32 v16, s39, v173, 4
	v_add_lshl_u32 v120, s39, v177, 4
	v_or_b32_e32 v121, s38, v161
	v_mov_b64_e32 v[124:125], v[24:25]
	v_mov_b64_e32 v[122:123], v[22:23]
	v_mov_b64_e32 v[104:105], v[48:49]
	v_mov_b64_e32 v[102:103], v[46:47]
	v_mov_b64_e32 v[108:109], v[8:9]
	v_mov_b64_e32 v[106:107], v[6:7]
	v_mov_b64_e32 v[116:117], v[12:13]
	v_mov_b64_e32 v[114:115], v[10:11]
	v_mov_b64_e32 v[128:129], v[20:21]
	v_mov_b64_e32 v[126:127], v[18:19]
	v_mov_b64_e32 v[132:133], v[44:45]
	v_mov_b64_e32 v[130:131], v[42:43]
	v_bfe_u32 v186, v153, s41, 8
	v_bfe_u32 v202, v158, s42, 8
	v_bfe_u32 v185, v154, s37, 8
	v_add_lshl_u32 v153, s38, v167, 2
	v_add_lshl_u32 v154, s38, v171, 2
	v_add_lshl_u32 v155, s38, v176, 2
	v_or_b32_e32 v156, s38, v163
	v_add_lshl_u32 v158, s38, v169, 2
	buffer_load_dwordx4 v[42:45], v2, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v3, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[10:13], v4, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v5, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[46:49], v14, s[0:3], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v15, s[0:3], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[14:17], v16, s[0:3], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[2:5], v120, s[0:3], 0 offen sc0
	v_lshlrev_b32_e32 v120, 2, v121
	v_bfe_u32 v189, v157, s40, 8
	v_add_lshl_u32 v194, s38, v174, 2
	v_add_lshl_u32 v195, s38, v178, 2
	v_lshlrev_b32_e32 v121, 2, v156
	buffer_load_dword v181, v120, s[24:27], 0 offen
	buffer_load_dword v157, v153, s[24:27], 0 offen
	buffer_load_dword v156, v154, s[24:27], 0 offen
	s_nop 0
	buffer_load_dword v153, v155, s[24:27], 0 offen
	buffer_load_dword v180, v121, s[24:27], 0 offen
	s_nop 0
	buffer_load_dword v158, v158, s[24:27], 0 offen
	s_nop 0
	buffer_load_dword v155, v194, s[24:27], 0 offen
	buffer_load_dword v154, v195, s[24:27], 0 offen
	v_sub_u32_e32 v118, v151, v118
	v_min_i32_e32 v120, 11, v118
	v_mul_lo_u32 v120, v120, s11
	v_sub_u32_e32 v121, 0x6c686080, v120
	v_and_b32_e32 v121, 0xffffff00, v121
	v_cmp_lt_i32_e32 vcc, 11, v118
	v_sub_u32_e32 v120, 0x7c787470, v120
	s_lshl_b32 s37, s36, 12
	v_cndmask_b32_e64 v203, v121, 0, vcc
	v_cndmask_b32_e64 v204, v120, 0, vcc
	v_add_u32_e32 v118, 0x7f7f7f00, v203
	v_and_b32_e32 v205, 0x80808000, v118
	v_add_u32_e32 v118, 0x7f7f7f78, v204
	v_and_b32_e32 v206, 0x80808080, v118
	v_sub_u32_e32 v118, v149, v119
	v_min_i32_e32 v119, 11, v118
	v_mul_lo_u32 v119, v119, s11
	v_sub_u32_e32 v120, 0x6c686080, v119
	v_and_b32_e32 v120, 0xffffff00, v120
	v_cmp_lt_i32_e32 vcc, 11, v118
	v_sub_u32_e32 v119, 0x7c787470, v119
	v_lshlrev_b32_e32 v121, 4, v130
	v_cndmask_b32_e64 v207, v120, 0, vcc
	v_cndmask_b32_e64 v208, v119, 0, vcc
	v_add_u32_e32 v118, 0x7f7f7f00, v207
	v_and_b32_e32 v209, 0x80808000, v118
	v_add_u32_e32 v118, 0x7f7f7f78, v208
	v_and_b32_e32 v210, 0x80808080, v118
	v_and_b32_e32 v118, 0x7070707, v130
	v_lshrrev_b32_e32 v119, 4, v130
	v_and_b32_e32 v119, 0x7070707, v119
	v_perm_b32 v120, v206, v205, v118
	v_perm_b32 v118, v204, v203, v118
	v_and_or_b32 v118, v120, v121, v118
	v_perm_b32 v120, v206, v205, v119
	v_perm_b32 v119, v204, v203, v119
	v_and_or_b32 v119, v120, v130, v119
	v_perm_b32 v194, v119, v118, s12
	v_perm_b32 v195, v119, v118, s13
	v_and_b32_e32 v118, 0x7070707, v102
	v_lshrrev_b32_e32 v119, 4, v102
	v_and_b32_e32 v119, 0x7070707, v119
	v_perm_b32 v120, v210, v209, v118
	v_lshlrev_b32_e32 v121, 4, v102
	v_perm_b32 v118, v208, v207, v118
	v_and_or_b32 v118, v120, v121, v118
	v_perm_b32 v120, v210, v209, v119
	v_perm_b32 v119, v208, v207, v119
	v_and_or_b32 v102, v120, v102, v119
	v_perm_b32 v196, v102, v118, s12
	v_perm_b32 v197, v102, v118, s13
	v_or_b32_e32 v102, s37, v184
	ds_read2st64_b64 v[118:121], v102 offset1:4
	v_and_b32_e32 v102, 0x7070707, v131
	v_lshrrev_b32_e32 v130, 4, v131
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[118:119], v[194:195], v[66:69]
	v_and_b32_e32 v130, 0x7070707, v130
	v_lshlrev_b32_e32 v198, 4, v104
	s_cmp_lg_u32 s49, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[120:121], v[194:195], v[70:73]
	v_perm_b32 v194, v206, v205, v102
	v_lshlrev_b32_e32 v195, 4, v131
	v_perm_b32 v102, v204, v203, v102
	v_and_or_b32 v102, v194, v195, v102
	v_perm_b32 v194, v206, v205, v130
	v_perm_b32 v130, v204, v203, v130
	v_and_or_b32 v130, v194, v131, v130
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[118:119], v[196:197], v[74:77]
	v_lshlrev_b32_e32 v194, 4, v103
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[120:121], v[196:197], v[78:81]
	v_perm_b32 v196, v130, v102, s12
	v_perm_b32 v197, v130, v102, s13
	v_and_b32_e32 v102, 0x7070707, v103
	v_lshrrev_b32_e32 v130, 4, v103
	v_and_b32_e32 v130, 0x7070707, v130
	v_perm_b32 v131, v210, v209, v102
	v_perm_b32 v102, v208, v207, v102
	v_and_or_b32 v131, v131, v194, v102
	v_perm_b32 v102, v210, v209, v130
	v_perm_b32 v130, v208, v207, v130
	v_or_b32_e32 v194, s37, v172
	v_and_or_b32 v103, v102, v103, v130
	v_or_b32_e32 v130, v194, v140
	v_or_b32_e32 v194, v194, v182
	v_perm_b32 v102, v103, v131, s12
	v_perm_b32 v103, v103, v131, s13
	ds_read_b64 v[130:131], v130
	ds_read_b64 v[194:195], v194
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[130:131], v[102:103], v[74:77]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[194:195], v[102:103], v[78:81]
	v_and_b32_e32 v102, 0x7070707, v132
	v_lshrrev_b32_e32 v103, 4, v132
	v_and_b32_e32 v103, 0x7070707, v103
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[130:131], v[196:197], v[66:69]
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[194:195], v[196:197], v[70:73]
	v_perm_b32 v196, v206, v205, v102
	v_lshlrev_b32_e32 v197, 4, v132
	v_perm_b32 v102, v204, v203, v102
	v_and_or_b32 v196, v196, v197, v102
	v_perm_b32 v102, v206, v205, v103
	v_perm_b32 v103, v204, v203, v103
	v_and_or_b32 v103, v102, v132, v103
	v_perm_b32 v102, v103, v196, s12
	v_perm_b32 v103, v103, v196, s13
	v_and_b32_e32 v132, 0x7070707, v104
	v_lshrrev_b32_e32 v196, 4, v104
	v_and_b32_e32 v196, 0x7070707, v196
	v_perm_b32 v197, v210, v209, v132
	v_perm_b32 v132, v208, v207, v132
	v_and_or_b32 v132, v197, v198, v132
	v_perm_b32 v197, v210, v209, v196
	v_perm_b32 v196, v208, v207, v196
	v_and_or_b32 v104, v197, v104, v196
	v_perm_b32 v200, v104, v132, s12
	v_perm_b32 v201, v104, v132, s13
	v_or_b32_e32 v104, s37, v166
	v_or_b32_e32 v132, v104, v140
	v_or_b32_e32 v104, v104, v182
	ds_read_b64 v[196:197], v132
	ds_read_b64 v[198:199], v104
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[196:197], v[102:103], v[66:69]
	v_lshlrev_b32_e32 v132, 4, v133
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[198:199], v[102:103], v[70:73]
	v_and_b32_e32 v102, 0x7070707, v133
	v_lshrrev_b32_e32 v103, 4, v133
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v206, v205, v102
	v_perm_b32 v102, v204, v203, v102
	v_and_or_b32 v102, v104, v132, v102
	v_perm_b32 v104, v206, v205, v103
	v_perm_b32 v103, v204, v203, v103
	v_and_or_b32 v103, v104, v133, v103
	v_perm_b32 v132, v103, v102, s12
	v_perm_b32 v133, v103, v102, s13
	v_and_b32_e32 v102, 0x7070707, v105
	v_lshrrev_b32_e32 v103, 4, v105
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[196:197], v[200:201], v[74:77]
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v210, v209, v102
	v_perm_b32 v102, v208, v207, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[198:199], v[200:201], v[78:81]
	v_lshlrev_b32_e32 v200, 4, v105
	v_and_or_b32 v102, v104, v200, v102
	v_perm_b32 v104, v210, v209, v103
	v_perm_b32 v103, v208, v207, v103
	v_and_or_b32 v103, v104, v105, v103
	v_perm_b32 v200, v103, v102, s12
	v_perm_b32 v201, v103, v102, s13
	v_or_b32_e32 v102, s37, v183
	ds_read2st64_b64 v[102:105], v102 offset1:4
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[104:105], v[132:133], v[70:73]
	v_lshlrev_b32_e32 v209, 4, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[102:103], v[132:133], v[66:69]
	v_sub_u32_e32 v132, v152, v189
	v_min_i32_e32 v133, 11, v132
	v_mul_lo_u32 v133, v133, s11
	v_sub_u32_e32 v189, 0x6c686080, v133
	v_and_b32_e32 v189, 0xffffff00, v189
	v_cmp_lt_i32_e32 vcc, 11, v132
	v_sub_u32_e32 v133, 0x7c787470, v133
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[102:103], v[200:201], v[74:77]
	v_cndmask_b32_e64 v189, v189, 0, vcc
	v_cndmask_b32_e64 v203, v133, 0, vcc
	v_add_u32_e32 v132, 0x7f7f7f00, v189
	v_and_b32_e32 v204, 0x80808000, v132
	v_add_u32_e32 v132, 0x7f7f7f78, v203
	v_and_b32_e32 v205, 0x80808080, v132
	v_sub_u32_e32 v132, v150, v202
	v_min_i32_e32 v133, 11, v132
	v_mul_lo_u32 v133, v133, s11
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[104:105], v[200:201], v[78:81]
	v_sub_u32_e32 v200, 0x6c686080, v133
	v_and_b32_e32 v200, 0xffffff00, v200
	v_cmp_lt_i32_e32 vcc, 11, v132
	v_sub_u32_e32 v133, 0x7c787470, v133
	v_lshlrev_b32_e32 v201, 4, v126
	v_cndmask_b32_e64 v202, v200, 0, vcc
	v_cndmask_b32_e64 v206, v133, 0, vcc
	v_add_u32_e32 v132, 0x7f7f7f00, v202
	v_and_b32_e32 v207, 0x80808000, v132
	v_add_u32_e32 v132, 0x7f7f7f78, v206
	v_and_b32_e32 v208, 0x80808080, v132
	v_and_b32_e32 v132, 0x7070707, v126
	v_lshrrev_b32_e32 v133, 4, v126
	v_and_b32_e32 v133, 0x7070707, v133
	v_perm_b32 v200, v205, v204, v132
	v_perm_b32 v132, v203, v189, v132
	v_and_or_b32 v200, v200, v201, v132
	v_perm_b32 v132, v205, v204, v133
	v_perm_b32 v133, v203, v189, v133
	v_and_or_b32 v126, v132, v126, v133
	v_perm_b32 v132, v126, v200, s12
	v_perm_b32 v133, v126, v200, s13
	v_and_b32_e32 v126, 0x7070707, v122
	v_lshrrev_b32_e32 v200, 4, v122
	v_and_b32_e32 v200, 0x7070707, v200
	v_perm_b32 v201, v208, v207, v126
	v_perm_b32 v126, v206, v202, v126
	v_and_or_b32 v126, v201, v209, v126
	v_perm_b32 v201, v208, v207, v200
	v_perm_b32 v200, v206, v202, v200
	v_and_or_b32 v122, v201, v122, v200
	v_perm_b32 v200, v122, v126, s12
	v_perm_b32 v201, v122, v126, s13
	v_and_b32_e32 v122, 0x7070707, v127
	v_lshrrev_b32_e32 v126, 4, v127
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[118:119], v[132:133], v[50:53]
	v_and_b32_e32 v126, 0x7070707, v126
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[120:121], v[132:133], v[54:57]
	v_perm_b32 v132, v205, v204, v122
	v_lshlrev_b32_e32 v133, 4, v127
	v_perm_b32 v122, v203, v189, v122
	v_and_or_b32 v122, v132, v133, v122
	v_perm_b32 v132, v205, v204, v126
	v_perm_b32 v126, v203, v189, v126
	v_and_or_b32 v127, v132, v127, v126
	v_perm_b32 v126, v127, v122, s12
	v_perm_b32 v127, v127, v122, s13
	v_and_b32_e32 v122, 0x7070707, v123
	v_lshrrev_b32_e32 v132, 4, v123
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[118:119], v[200:201], v[58:61]
	v_and_b32_e32 v132, 0x7070707, v132
	v_perm_b32 v133, v208, v207, v122
	v_perm_b32 v122, v206, v202, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[120:121], v[200:201], v[62:65]
	v_lshlrev_b32_e32 v200, 4, v123
	v_and_or_b32 v133, v133, v200, v122
	v_perm_b32 v122, v208, v207, v132
	v_perm_b32 v132, v206, v202, v132
	v_and_or_b32 v123, v122, v123, v132
	v_perm_b32 v122, v123, v133, s12
	v_perm_b32 v123, v123, v133, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[130:131], v[126:127], v[50:53]
	v_lshlrev_b32_e32 v132, 4, v124
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[130:131], v[122:123], v[58:61]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[194:195], v[122:123], v[62:65]
	v_and_b32_e32 v122, 0x7070707, v128
	v_lshrrev_b32_e32 v123, 4, v128
	v_and_b32_e32 v123, 0x7070707, v123
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[194:195], v[126:127], v[54:57]
	v_perm_b32 v126, v205, v204, v122
	v_lshlrev_b32_e32 v127, 4, v128
	v_perm_b32 v122, v203, v189, v122
	v_and_or_b32 v126, v126, v127, v122
	v_perm_b32 v122, v205, v204, v123
	v_perm_b32 v123, v203, v189, v123
	v_and_or_b32 v123, v122, v128, v123
	v_perm_b32 v122, v123, v126, s12
	v_perm_b32 v123, v123, v126, s13
	v_and_b32_e32 v126, 0x7070707, v124
	v_lshrrev_b32_e32 v127, 4, v124
	v_and_b32_e32 v127, 0x7070707, v127
	v_perm_b32 v128, v208, v207, v126
	v_perm_b32 v126, v206, v202, v126
	v_and_or_b32 v128, v128, v132, v126
	v_perm_b32 v126, v208, v207, v127
	v_perm_b32 v127, v206, v202, v127
	v_and_or_b32 v124, v126, v124, v127
	v_perm_b32 v126, v124, v128, s12
	v_perm_b32 v127, v124, v128, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[196:197], v[122:123], v[50:53]
	v_lshlrev_b32_e32 v128, 4, v125
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[198:199], v[122:123], v[54:57]
	v_and_b32_e32 v122, 0x7070707, v129
	v_lshrrev_b32_e32 v123, 4, v129
	v_and_b32_e32 v123, 0x7070707, v123
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[196:197], v[126:127], v[58:61]
	v_perm_b32 v124, v205, v204, v122
	v_perm_b32 v122, v203, v189, v122
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[198:199], v[126:127], v[62:65]
	v_lshlrev_b32_e32 v126, 4, v129
	v_and_or_b32 v124, v124, v126, v122
	v_perm_b32 v122, v205, v204, v123
	v_perm_b32 v123, v203, v189, v123
	v_and_or_b32 v123, v122, v129, v123
	v_perm_b32 v122, v123, v124, s12
	v_perm_b32 v123, v123, v124, s13
	v_and_b32_e32 v124, 0x7070707, v125
	v_lshrrev_b32_e32 v126, 4, v125
	v_and_b32_e32 v126, 0x7070707, v126
	v_perm_b32 v127, v208, v207, v124
	v_perm_b32 v124, v206, v202, v124
	v_and_or_b32 v127, v127, v128, v124
	v_perm_b32 v124, v208, v207, v126
	v_perm_b32 v126, v206, v202, v126
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[122:123], v[50:53]
	v_and_or_b32 v125, v124, v125, v126
	v_perm_b32 v124, v125, v127, s12
	v_perm_b32 v125, v125, v127, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[104:105], v[122:123], v[54:57]
	v_sub_u32_e32 v122, v147, v188
	v_min_i32_e32 v123, 11, v122
	v_mul_lo_u32 v123, v123, s11
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[102:103], v[124:125], v[58:61]
	v_cmp_lt_i32_e32 vcc, 11, v122
	v_lshlrev_b32_e32 v189, 4, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[104:105], v[124:125], v[62:65]
	v_sub_u32_e32 v124, 0x6c686080, v123
	v_and_b32_e32 v124, 0xffffff00, v124
	v_sub_u32_e32 v123, 0x7c787470, v123
	v_cndmask_b32_e64 v126, v124, 0, vcc
	v_cndmask_b32_e64 v127, v123, 0, vcc
	v_add_u32_e32 v122, 0x7f7f7f00, v126
	v_and_b32_e32 v128, 0x80808000, v122
	v_add_u32_e32 v122, 0x7f7f7f78, v127
	v_and_b32_e32 v129, 0x80808080, v122
	v_sub_u32_e32 v122, v145, v187
	v_min_i32_e32 v123, 11, v122
	v_mul_lo_u32 v123, v123, s11
	v_sub_u32_e32 v124, 0x6c686080, v123
	v_and_b32_e32 v124, 0xffffff00, v124
	v_cmp_lt_i32_e32 vcc, 11, v122
	v_sub_u32_e32 v123, 0x7c787470, v123
	v_lshlrev_b32_e32 v125, 4, v114
	v_cndmask_b32_e64 v132, v124, 0, vcc
	v_cndmask_b32_e64 v133, v123, 0, vcc
	v_add_u32_e32 v122, 0x7f7f7f00, v132
	v_and_b32_e32 v187, 0x80808000, v122
	v_add_u32_e32 v122, 0x7f7f7f78, v133
	v_and_b32_e32 v188, 0x80808080, v122
	v_and_b32_e32 v122, 0x7070707, v114
	v_lshrrev_b32_e32 v123, 4, v114
	v_and_b32_e32 v123, 0x7070707, v123
	v_perm_b32 v124, v129, v128, v122
	v_perm_b32 v122, v127, v126, v122
	v_and_or_b32 v124, v124, v125, v122
	v_perm_b32 v122, v129, v128, v123
	v_perm_b32 v123, v127, v126, v123
	v_and_or_b32 v114, v122, v114, v123
	v_perm_b32 v122, v114, v124, s12
	v_perm_b32 v123, v114, v124, s13
	v_and_b32_e32 v114, 0x7070707, v110
	v_lshrrev_b32_e32 v124, 4, v110
	v_and_b32_e32 v124, 0x7070707, v124
	v_perm_b32 v125, v188, v187, v114
	v_perm_b32 v114, v133, v132, v114
	v_and_or_b32 v114, v125, v189, v114
	v_perm_b32 v125, v188, v187, v124
	v_perm_b32 v124, v133, v132, v124
	v_and_or_b32 v110, v125, v110, v124
	v_perm_b32 v124, v110, v114, s12
	v_perm_b32 v125, v110, v114, s13
	v_and_b32_e32 v110, 0x7070707, v115
	v_lshrrev_b32_e32 v114, 4, v115
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[118:119], v[122:123], v[26:29]
	v_and_b32_e32 v114, 0x7070707, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[120:121], v[122:123], v[30:33]
	v_perm_b32 v122, v129, v128, v110
	v_lshlrev_b32_e32 v123, 4, v115
	v_perm_b32 v110, v127, v126, v110
	v_and_or_b32 v110, v122, v123, v110
	v_perm_b32 v122, v129, v128, v114
	v_perm_b32 v114, v127, v126, v114
	v_and_or_b32 v115, v122, v115, v114
	v_perm_b32 v114, v115, v110, s12
	v_perm_b32 v115, v115, v110, s13
	v_and_b32_e32 v110, 0x7070707, v111
	v_lshrrev_b32_e32 v122, 4, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[118:119], v[124:125], v[34:37]
	v_and_b32_e32 v122, 0x7070707, v122
	v_perm_b32 v123, v188, v187, v110
	v_perm_b32 v110, v133, v132, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[120:121], v[124:125], v[38:41]
	v_lshlrev_b32_e32 v124, 4, v111
	v_and_or_b32 v123, v123, v124, v110
	v_perm_b32 v110, v188, v187, v122
	v_perm_b32 v122, v133, v132, v122
	v_and_or_b32 v111, v110, v111, v122
	v_perm_b32 v110, v111, v123, s12
	v_perm_b32 v111, v111, v123, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[130:131], v[114:115], v[26:29]
	v_lshlrev_b32_e32 v122, 4, v112
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[130:131], v[110:111], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[194:195], v[110:111], v[38:41]
	v_and_b32_e32 v110, 0x7070707, v116
	v_lshrrev_b32_e32 v111, 4, v116
	v_and_b32_e32 v111, 0x7070707, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[194:195], v[114:115], v[30:33]
	v_perm_b32 v114, v129, v128, v110
	v_lshlrev_b32_e32 v115, 4, v116
	v_perm_b32 v110, v127, v126, v110
	v_and_or_b32 v114, v114, v115, v110
	v_perm_b32 v110, v129, v128, v111
	v_perm_b32 v111, v127, v126, v111
	v_and_or_b32 v111, v110, v116, v111
	v_perm_b32 v110, v111, v114, s12
	v_perm_b32 v111, v111, v114, s13
	v_and_b32_e32 v114, 0x7070707, v112
	v_lshrrev_b32_e32 v115, 4, v112
	v_and_b32_e32 v115, 0x7070707, v115
	v_perm_b32 v116, v188, v187, v114
	v_perm_b32 v114, v133, v132, v114
	v_and_or_b32 v116, v116, v122, v114
	v_perm_b32 v114, v188, v187, v115
	v_perm_b32 v115, v133, v132, v115
	v_and_or_b32 v112, v114, v112, v115
	v_perm_b32 v114, v112, v116, s12
	v_perm_b32 v115, v112, v116, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[196:197], v[110:111], v[26:29]
	v_lshlrev_b32_e32 v116, 4, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[198:199], v[110:111], v[30:33]
	v_and_b32_e32 v110, 0x7070707, v117
	v_lshrrev_b32_e32 v111, 4, v117
	v_and_b32_e32 v111, 0x7070707, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[196:197], v[114:115], v[34:37]
	v_perm_b32 v112, v129, v128, v110
	v_perm_b32 v110, v127, v126, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[198:199], v[114:115], v[38:41]
	v_lshlrev_b32_e32 v114, 4, v117
	v_and_or_b32 v112, v112, v114, v110
	v_perm_b32 v110, v129, v128, v111
	v_perm_b32 v111, v127, v126, v111
	v_and_or_b32 v111, v110, v117, v111
	v_perm_b32 v110, v111, v112, s12
	v_perm_b32 v111, v111, v112, s13
	v_and_b32_e32 v112, 0x7070707, v113
	v_lshrrev_b32_e32 v114, 4, v113
	v_and_b32_e32 v114, 0x7070707, v114
	v_perm_b32 v115, v188, v187, v112
	v_perm_b32 v112, v133, v132, v112
	v_and_or_b32 v115, v115, v116, v112
	v_perm_b32 v112, v188, v187, v114
	v_perm_b32 v114, v133, v132, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[102:103], v[110:111], v[26:29]
	v_and_or_b32 v113, v112, v113, v114
	v_perm_b32 v112, v113, v115, s12
	v_perm_b32 v113, v113, v115, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[104:105], v[110:111], v[30:33]
	v_sub_u32_e32 v110, v148, v186
	v_min_i32_e32 v111, 11, v110
	v_mul_lo_u32 v111, v111, s11
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[102:103], v[112:113], v[34:37]
	v_cmp_lt_i32_e32 vcc, 11, v110
	v_lshlrev_b32_e32 v126, 4, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[104:105], v[112:113], v[38:41]
	v_sub_u32_e32 v112, 0x6c686080, v111
	v_and_b32_e32 v112, 0xffffff00, v112
	v_sub_u32_e32 v111, 0x7c787470, v111
	v_cndmask_b32_e64 v122, v112, 0, vcc
	v_cndmask_b32_e64 v123, v111, 0, vcc
	v_add_u32_e32 v110, 0x7f7f7f00, v122
	v_and_b32_e32 v124, 0x80808000, v110
	v_add_u32_e32 v110, 0x7f7f7f78, v123
	v_and_b32_e32 v125, 0x80808080, v110
	v_sub_u32_e32 v110, v146, v185
	v_min_i32_e32 v111, 11, v110
	v_mul_lo_u32 v111, v111, s11
	v_sub_u32_e32 v112, 0x6c686080, v111
	v_and_b32_e32 v112, 0xffffff00, v112
	v_cmp_lt_i32_e32 vcc, 11, v110
	v_sub_u32_e32 v111, 0x7c787470, v111
	v_lshlrev_b32_e32 v113, 4, v106
	v_cndmask_b32_e64 v114, v112, 0, vcc
	v_cndmask_b32_e64 v115, v111, 0, vcc
	v_add_u32_e32 v110, 0x7f7f7f00, v114
	v_and_b32_e32 v116, 0x80808000, v110
	v_add_u32_e32 v110, 0x7f7f7f78, v115
	v_and_b32_e32 v117, 0x80808080, v110
	v_and_b32_e32 v110, 0x7070707, v106
	v_lshrrev_b32_e32 v111, 4, v106
	v_and_b32_e32 v111, 0x7070707, v111
	v_perm_b32 v112, v125, v124, v110
	v_perm_b32 v110, v123, v122, v110
	v_and_or_b32 v112, v112, v113, v110
	v_perm_b32 v110, v125, v124, v111
	v_perm_b32 v111, v123, v122, v111
	v_and_or_b32 v106, v110, v106, v111
	v_perm_b32 v110, v106, v112, s12
	v_perm_b32 v111, v106, v112, s13
	v_and_b32_e32 v106, 0x7070707, v98
	v_lshrrev_b32_e32 v112, 4, v98
	v_and_b32_e32 v112, 0x7070707, v112
	v_perm_b32 v113, v117, v116, v106
	v_perm_b32 v106, v115, v114, v106
	v_and_or_b32 v106, v113, v126, v106
	v_perm_b32 v113, v117, v116, v112
	v_perm_b32 v112, v115, v114, v112
	v_and_or_b32 v98, v113, v98, v112
	v_perm_b32 v112, v98, v106, s12
	v_perm_b32 v113, v98, v106, s13
	v_and_b32_e32 v98, 0x7070707, v107
	v_lshrrev_b32_e32 v106, 4, v107
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[118:119], v[110:111], v[82:85]
	v_and_b32_e32 v106, 0x7070707, v106
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[120:121], v[110:111], v[86:89]
	v_perm_b32 v110, v125, v124, v98
	v_lshlrev_b32_e32 v111, 4, v107
	v_perm_b32 v98, v123, v122, v98
	v_and_or_b32 v98, v110, v111, v98
	v_perm_b32 v110, v125, v124, v106
	v_perm_b32 v106, v123, v122, v106
	v_and_or_b32 v107, v110, v107, v106
	v_perm_b32 v106, v107, v98, s12
	v_perm_b32 v107, v107, v98, s13
	v_and_b32_e32 v98, 0x7070707, v99
	v_lshrrev_b32_e32 v110, 4, v99
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[118:119], v[112:113], v[90:93]
	v_and_b32_e32 v110, 0x7070707, v110
	v_perm_b32 v111, v117, v116, v98
	v_perm_b32 v98, v115, v114, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[120:121], v[112:113], v[94:97]
	v_lshlrev_b32_e32 v112, 4, v99
	v_and_or_b32 v111, v111, v112, v98
	v_perm_b32 v98, v117, v116, v110
	v_perm_b32 v110, v115, v114, v110
	v_and_or_b32 v99, v98, v99, v110
	v_perm_b32 v98, v99, v111, s12
	v_perm_b32 v99, v99, v111, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[194:195], v[106:107], v[86:89]
	s_nop 2
	v_and_b32_e32 v86, 0x7070707, v108
	v_lshrrev_b32_e32 v87, 4, v108
	v_and_b32_e32 v87, 0x7070707, v87
	v_perm_b32 v88, v125, v124, v86
	v_lshlrev_b32_e32 v89, 4, v108
	v_perm_b32 v86, v123, v122, v86
	v_and_or_b32 v86, v88, v89, v86
	v_perm_b32 v88, v125, v124, v87
	v_perm_b32 v87, v123, v122, v87
	v_and_or_b32 v87, v88, v108, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[118:121], v[194:195], v[98:99], v[94:97]
	v_lshlrev_b32_e32 v89, 4, v100
	s_nop 1
	v_perm_b32 v94, v87, v86, s12
	v_perm_b32 v95, v87, v86, s13
	v_and_b32_e32 v86, 0x7070707, v100
	v_lshrrev_b32_e32 v87, 4, v100
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[130:131], v[98:99], v[90:93]
	v_and_b32_e32 v87, 0x7070707, v87
	v_perm_b32 v88, v117, v116, v86
	v_perm_b32 v86, v115, v114, v86
	v_and_or_b32 v86, v88, v89, v86
	v_perm_b32 v88, v117, v116, v87
	v_perm_b32 v87, v115, v114, v87
	v_and_or_b32 v87, v88, v100, v87
	v_perm_b32 v98, v87, v86, s12
	v_perm_b32 v99, v87, v86, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[130:131], v[106:107], v[82:85]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[196:197], v[98:99], v[90:93]
	s_nop 2
	v_and_b32_e32 v90, 0x7070707, v109
	v_lshrrev_b32_e32 v91, 4, v109
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v125, v124, v90
	v_lshlrev_b32_e32 v93, 4, v109
	v_perm_b32 v90, v123, v122, v90
	v_and_or_b32 v90, v92, v93, v90
	v_perm_b32 v92, v125, v124, v91
	v_perm_b32 v91, v123, v122, v91
	v_and_or_b32 v91, v92, v109, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[196:197], v[94:95], v[82:85]
	v_lshlrev_b32_e32 v93, 4, v101
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[198:199], v[94:95], v[110:113]
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[198:199], v[98:99], v[118:121]
	v_perm_b32 v98, v91, v90, s12
	v_perm_b32 v99, v91, v90, s13
	v_and_b32_e32 v90, 0x7070707, v101
	v_lshrrev_b32_e32 v91, 4, v101
	v_and_b32_e32 v91, 0x7070707, v91
	v_perm_b32 v92, v117, v116, v90
	v_perm_b32 v90, v115, v114, v90
	v_and_or_b32 v90, v92, v93, v90
	v_perm_b32 v92, v117, v116, v91
	v_perm_b32 v91, v115, v114, v91
	v_and_or_b32 v91, v92, v101, v91
	v_perm_b32 v100, v91, v90, s12
	v_perm_b32 v101, v91, v90, s13
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[102:103], v[98:99], v[82:85]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[102:103], v[100:101], v[86:89]
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[104:105], v[98:99], v[94:97]
	v_lshl_or_b32 v98, s36, 10, v137
	v_xor_b32_e32 v98, 0x400, v98
	v_lshlrev_b32_e32 v98, 2, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[104:105], v[100:101], v[110:113]
	s_waitcnt vmcnt(16)
	ds_write_b128 v98, v[190:193]
	s_cbranch_scc1 .LBB0_2
	s_waitcnt vmcnt(7)
	v_sub_u32_sdwa v98, v151, v181 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v99, 11, v98
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v99, v99, s40
	v_sub_u32_e32 v100, 0x6c686080, v99
	v_and_b32_e32 v100, 0xffffff00, v100
	v_cmp_lt_i32_e32 vcc, 11, v98
	v_sub_u32_e32 v99, 0x7c787470, v99
	v_lshlrev_b32_e32 v101, 4, v42
	v_cndmask_b32_e64 v118, v100, 0, vcc
	v_cndmask_b32_e64 v119, v99, 0, vcc
	v_add_u32_e32 v98, 0x7f7f7f00, v118
	v_and_b32_e32 v120, 0x80808000, v98
	v_add_u32_e32 v98, 0x7f7f7f78, v119
	v_and_b32_e32 v121, 0x80808080, v98
	s_waitcnt vmcnt(3)
	v_sub_u32_sdwa v98, v149, v180 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v99, 11, v98
	v_mul_lo_u32 v99, v99, s40
	v_sub_u32_e32 v100, 0x6c686080, v99
	v_and_b32_e32 v100, 0xffffff00, v100
	v_cmp_lt_i32_e32 vcc, 11, v98
	v_sub_u32_e32 v99, 0x7c787470, v99
	s_mov_b32 s41, 0x5010400
	v_cndmask_b32_e64 v122, v100, 0, vcc
	v_cndmask_b32_e64 v123, v99, 0, vcc
	v_add_u32_e32 v98, 0x7f7f7f00, v122
	v_and_b32_e32 v124, 0x80808000, v98
	v_add_u32_e32 v98, 0x7f7f7f78, v123
	v_and_b32_e32 v125, 0x80808080, v98
	v_and_b32_e32 v98, 0x7070707, v42
	v_lshrrev_b32_e32 v99, 4, v42
	v_and_b32_e32 v99, 0x7070707, v99
	v_perm_b32 v100, v121, v120, v98
	v_perm_b32 v98, v119, v118, v98
	v_and_or_b32 v98, v100, v101, v98
	v_perm_b32 v100, v121, v120, v99
	v_perm_b32 v99, v119, v118, v99
	v_and_or_b32 v42, v100, v42, v99
	s_mov_b32 s42, 0x7030602
	v_perm_b32 v106, v42, v98, s41
	v_perm_b32 v107, v42, v98, s42
	v_and_b32_e32 v42, 0x7070707, v46
	v_lshrrev_b32_e32 v98, 4, v46
	v_and_b32_e32 v100, 0x7070707, v98
	v_perm_b32 v98, v125, v124, v42
	v_lshlrev_b32_e32 v99, 4, v46
	v_perm_b32 v42, v123, v122, v42
	v_and_or_b32 v42, v98, v99, v42
	v_add_u32_e32 v98, v140, v179
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[98:99], v98 offset:4096
	v_or_b32_e32 v114, 0x800, v140
	v_perm_b32 v108, v125, v124, v100
	v_perm_b32 v109, v123, v122, v100
	v_add_u32_e32 v100, v114, v179
	v_add_u32_e32 v101, v140, v172
	v_add_u32_e32 v110, v114, v172
	ds_read_b64 v[104:105], v100 offset:4096
	ds_read_b64 v[102:103], v101 offset:4096
	ds_read_b64 v[100:101], v110 offset:4096
	v_and_or_b32 v46, v108, v46, v109
	v_perm_b32 v108, v46, v42, s41
	v_perm_b32 v109, v46, v42, s42
	v_and_b32_e32 v42, 0x7070707, v43
	v_lshrrev_b32_e32 v46, 4, v43
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[98:99], v[106:107], v[66:69]
	v_and_b32_e32 v46, 0x7070707, v46
	s_add_i32 s10, s10, 16
	s_add_i32 s9, s9, 16
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[104:105], v[106:107], v[70:73]
	v_perm_b32 v106, v121, v120, v42
	v_lshlrev_b32_e32 v107, 4, v43
	v_perm_b32 v42, v119, v118, v42
	v_and_or_b32 v106, v106, v107, v42
	v_perm_b32 v42, v121, v120, v46
	v_perm_b32 v46, v119, v118, v46
	v_and_or_b32 v43, v42, v43, v46
	v_perm_b32 v42, v43, v106, s41
	v_perm_b32 v43, v43, v106, s42
	v_and_b32_e32 v46, 0x7070707, v47
	v_lshrrev_b32_e32 v106, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[98:99], v[108:109], v[74:77]
	v_and_b32_e32 v106, 0x7070707, v106
	v_perm_b32 v107, v125, v124, v46
	v_perm_b32 v46, v123, v122, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[104:105], v[108:109], v[78:81]
	v_lshlrev_b32_e32 v108, 4, v47
	v_and_or_b32 v107, v107, v108, v46
	v_perm_b32 v46, v125, v124, v106
	v_perm_b32 v106, v123, v122, v106
	v_and_or_b32 v47, v46, v47, v106
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[102:103], v[42:43], v[66:69]
	v_perm_b32 v46, v47, v107, s41
	v_perm_b32 v47, v47, v107, s42
	s_add_i32 s8, s8, 16
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[100:101], v[42:43], v[70:73]
	v_and_b32_e32 v42, 0x7070707, v44
	v_lshrrev_b32_e32 v43, 4, v44
	v_and_b32_e32 v43, 0x7070707, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[102:103], v[46:47], v[74:77]
	s_add_i32 s5, s5, 16
	s_ashr_i32 s49, s48, 31
	s_lshl_b32 s2, s33, 2
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[100:101], v[46:47], v[78:81]
	v_perm_b32 v46, v121, v120, v42
	v_lshlrev_b32_e32 v47, 4, v44
	v_perm_b32 v42, v119, v118, v42
	v_and_or_b32 v46, v46, v47, v42
	v_perm_b32 v42, v121, v120, v43
	v_perm_b32 v43, v119, v118, v43
	v_and_or_b32 v43, v42, v44, v43
	v_and_b32_e32 v44, 0x7070707, v48
	v_perm_b32 v47, v125, v124, v44
	v_lshlrev_b32_e32 v74, 4, v48
	v_perm_b32 v44, v123, v122, v44
	v_and_or_b32 v44, v47, v74, v44
	v_add_u32_e32 v47, v140, v166
	ds_read_b64 v[80:81], v47 offset:4096
	v_perm_b32 v42, v43, v46, s41
	v_perm_b32 v43, v43, v46, s42
	v_lshrrev_b32_e32 v46, 4, v48
	v_add_u32_e32 v74, v114, v166
	v_add_u32_e32 v75, v140, v159
	v_and_b32_e32 v46, 0x7070707, v46
	v_add_u32_e32 v114, v114, v159
	ds_read_b64 v[78:79], v74 offset:4096
	ds_read_b64 v[76:77], v75 offset:4096
	ds_read_b64 v[74:75], v114 offset:4096
	v_perm_b32 v47, v125, v124, v46
	v_perm_b32 v46, v123, v122, v46
	v_and_or_b32 v47, v47, v48, v46
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[80:81], v[42:43], v[66:69]
	v_perm_b32 v46, v47, v44, s41
	v_perm_b32 v47, v47, v44, s42
	s_and_b32 s1, s7, 0xffff
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[114:117], v[78:79], v[42:43], v[70:73]
	v_and_b32_e32 v42, 0x7070707, v45
	v_lshrrev_b32_e32 v43, 4, v45
	v_and_b32_e32 v43, 0x7070707, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[80:81], v[46:47], v[106:109]
	v_perm_b32 v44, v121, v120, v42
	v_perm_b32 v42, v119, v118, v42
	s_mov_b32 s3, 0x27000
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[78:79], v[46:47], v[110:113]
	v_lshlrev_b32_e32 v46, 4, v45
	v_and_or_b32 v44, v44, v46, v42
	v_perm_b32 v42, v121, v120, v43
	v_perm_b32 v43, v119, v118, v43
	v_and_or_b32 v43, v42, v45, v43
	v_perm_b32 v42, v43, v44, s41
	v_perm_b32 v43, v43, v44, s42
	v_and_b32_e32 v44, 0x7070707, v49
	v_lshrrev_b32_e32 v45, 4, v49
	v_and_b32_e32 v45, 0x7070707, v45
	v_perm_b32 v46, v125, v124, v44
	v_lshlrev_b32_e32 v47, 4, v49
	v_perm_b32 v44, v123, v122, v44
	v_and_or_b32 v46, v46, v47, v44
	v_perm_b32 v44, v125, v124, v45
	v_perm_b32 v45, v123, v122, v45
	v_and_or_b32 v45, v44, v49, v45
	v_perm_b32 v44, v45, v46, s41
	v_perm_b32 v45, v45, v46, s42
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[76:77], v[42:43], v[66:69]
	v_lshlrev_b32_e32 v118, 4, v22
	s_mov_b32 s0, s6
	s_movk_i32 s43, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[76:77], v[44:45], v[106:109]
	s_lshr_b32 s44, s52, 6
	s_lshl_b32 s46, s44, 8
	s_lshl_b32 s47, s44, 9
	v_bfe_u32 v106, v157, s10, 8
	v_sub_u32_e32 v106, v152, v106
	v_min_i32_e32 v108, 11, v106
	v_mul_lo_u32 v108, v108, s40
	v_sub_u32_e32 v109, 0x6c686080, v108
	v_and_b32_e32 v109, 0xffffff00, v109
	v_cmp_lt_i32_e32 vcc, 11, v106
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[74:75], v[42:43], v[114:117]
	v_sub_u32_e32 v108, 0x7c787470, v108
	s_waitcnt vmcnt(2)
	v_bfe_u32 v107, v158, s9, 8
	s_mov_b32 s24, s14
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[74:75], v[44:45], v[110:113]
	s_and_b32 s13, s23, 0xffff
	s_mov_b32 s12, s22
	s_mov_b32 s27, s3
	v_cndmask_b32_e64 v110, v109, 0, vcc
	v_cndmask_b32_e64 v111, v108, 0, vcc
	v_add_u32_e32 v106, 0x7f7f7f00, v110
	v_and_b32_e32 v112, 0x80808000, v106
	v_add_u32_e32 v106, 0x7f7f7f78, v111
	v_and_b32_e32 v113, 0x80808080, v106
	v_sub_u32_e32 v106, v150, v107
	v_min_i32_e32 v107, 11, v106
	v_mul_lo_u32 v107, v107, s40
	v_sub_u32_e32 v108, 0x6c686080, v107
	v_and_b32_e32 v108, 0xffffff00, v108
	v_cmp_lt_i32_e32 vcc, 11, v106
	v_sub_u32_e32 v107, 0x7c787470, v107
	v_lshlrev_b32_e32 v109, 4, v18
	v_cndmask_b32_e64 v114, v108, 0, vcc
	v_cndmask_b32_e64 v115, v107, 0, vcc
	v_add_u32_e32 v106, 0x7f7f7f00, v114
	v_and_b32_e32 v116, 0x80808000, v106
	v_add_u32_e32 v106, 0x7f7f7f78, v115
	v_and_b32_e32 v117, 0x80808080, v106
	v_and_b32_e32 v106, 0x7070707, v18
	v_lshrrev_b32_e32 v107, 4, v18
	v_and_b32_e32 v107, 0x7070707, v107
	v_perm_b32 v108, v113, v112, v106
	v_perm_b32 v106, v111, v110, v106
	v_and_or_b32 v108, v108, v109, v106
	v_perm_b32 v106, v113, v112, v107
	v_perm_b32 v107, v111, v110, v107
	v_and_or_b32 v18, v106, v18, v107
	v_perm_b32 v106, v18, v108, s41
	v_perm_b32 v107, v18, v108, s42
	v_and_b32_e32 v18, 0x7070707, v22
	v_lshrrev_b32_e32 v108, 4, v22
	v_and_b32_e32 v108, 0x7070707, v108
	v_perm_b32 v109, v117, v116, v18
	v_perm_b32 v18, v115, v114, v18
	v_and_or_b32 v18, v109, v118, v18
	v_perm_b32 v109, v117, v116, v108
	v_perm_b32 v108, v115, v114, v108
	v_and_or_b32 v22, v109, v22, v108
	v_perm_b32 v108, v22, v18, s41
	v_perm_b32 v109, v22, v18, s42
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v22, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[98:99], v[106:107], v[50:53]
	v_and_b32_e32 v22, 0x7070707, v22
	s_mov_b32 s36, s18
	s_mov_b32 s39, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[104:105], v[106:107], v[54:57]
	v_perm_b32 v106, v113, v112, v18
	v_lshlrev_b32_e32 v107, 4, v19
	v_perm_b32 v18, v111, v110, v18
	v_and_or_b32 v106, v106, v107, v18
	v_perm_b32 v18, v113, v112, v22
	v_perm_b32 v22, v111, v110, v22
	v_and_or_b32 v19, v18, v19, v22
	v_perm_b32 v18, v19, v106, s41
	v_perm_b32 v19, v19, v106, s42
	v_and_b32_e32 v22, 0x7070707, v23
	v_lshrrev_b32_e32 v106, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[98:99], v[108:109], v[58:61]
	v_and_b32_e32 v106, 0x7070707, v106
	v_perm_b32 v107, v117, v116, v22
	v_perm_b32 v22, v115, v114, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[104:105], v[108:109], v[62:65]
	v_lshlrev_b32_e32 v108, 4, v23
	v_and_or_b32 v107, v107, v108, v22
	v_perm_b32 v22, v117, v116, v106
	v_perm_b32 v106, v115, v114, v106
	v_and_or_b32 v23, v22, v23, v106
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[102:103], v[18:19], v[50:53]
	v_perm_b32 v22, v23, v107, s41
	v_perm_b32 v23, v23, v107, s42
	v_lshlrev_b32_e32 v106, 4, v24
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[100:101], v[18:19], v[54:57]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[102:103], v[22:23], v[58:61]
	s_mov_b32 s10, 0x800000
	s_and_b32 s9, s17, 0xffff
	s_mov_b32 s28, s16
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[100:101], v[22:23], v[62:65]
	v_perm_b32 v22, v113, v112, v18
	v_lshlrev_b32_e32 v23, 4, v20
	v_perm_b32 v18, v111, v110, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v113, v112, v19
	v_perm_b32 v19, v111, v110, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v22, s41
	v_perm_b32 v19, v19, v22, s42
	v_and_b32_e32 v20, 0x7070707, v24
	v_lshrrev_b32_e32 v22, 4, v24
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v117, v116, v20
	v_perm_b32 v20, v115, v114, v20
	v_and_or_b32 v20, v23, v106, v20
	v_perm_b32 v23, v117, v116, v22
	v_perm_b32 v22, v115, v114, v22
	v_and_or_b32 v23, v23, v24, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[80:81], v[18:19], v[50:53]
	v_perm_b32 v22, v23, v20, s41
	v_perm_b32 v23, v23, v20, s42
	s_mov_b32 s29, s9
	v_mfma_f32_16x16x32_fp8_fp8 v[106:109], v[78:79], v[18:19], v[54:57]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[80:81], v[22:23], v[58:61]
	v_perm_b32 v20, v113, v112, v18
	v_perm_b32 v18, v111, v110, v18
	s_mov_b32 s30, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[78:79], v[22:23], v[62:65]
	v_lshlrev_b32_e32 v22, 4, v21
	v_and_or_b32 v20, v20, v22, v18
	v_perm_b32 v18, v113, v112, v19
	v_perm_b32 v19, v111, v110, v19
	v_and_or_b32 v19, v18, v21, v19
	v_perm_b32 v18, v19, v20, s41
	v_perm_b32 v19, v19, v20, s42
	v_and_b32_e32 v20, 0x7070707, v25
	v_lshrrev_b32_e32 v21, 4, v25
	v_and_b32_e32 v21, 0x7070707, v21
	v_perm_b32 v22, v117, v116, v20
	v_lshlrev_b32_e32 v23, 4, v25
	v_perm_b32 v20, v115, v114, v20
	v_and_or_b32 v22, v22, v23, v20
	v_perm_b32 v20, v117, v116, v21
	v_perm_b32 v21, v115, v114, v21
	v_and_or_b32 v21, v20, v25, v21
	v_perm_b32 v20, v21, v22, s41
	v_perm_b32 v21, v21, v22, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[76:77], v[18:19], v[50:53]
	v_lshlrev_b32_e32 v110, 4, v14
	s_mov_b32 s31, s3
	s_mov_b32 s45, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[76:77], v[20:21], v[58:61]
	s_mov_b32 s11, s3
	s_mov_b32 s23, s3
	s_nop 0
	v_sub_u32_sdwa v58, v147, v156 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v59, 11, v58
	v_mul_lo_u32 v59, v59, s40
	v_sub_u32_e32 v60, 0x6c686080, v59
	v_and_b32_e32 v60, 0xffffff00, v60
	v_cmp_lt_i32_e32 vcc, 11, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[74:75], v[18:19], v[106:109]
	v_sub_u32_e32 v59, 0x7c787470, v59
	v_lshlrev_b32_e32 v61, 4, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[74:75], v[20:21], v[62:65]
	s_nop 2
	v_cndmask_b32_e64 v62, v60, 0, vcc
	v_cndmask_b32_e64 v63, v59, 0, vcc
	v_add_u32_e32 v58, 0x7f7f7f00, v62
	v_and_b32_e32 v64, 0x80808000, v58
	v_add_u32_e32 v58, 0x7f7f7f78, v63
	v_and_b32_e32 v65, 0x80808080, v58
	s_waitcnt vmcnt(1)
	v_sub_u32_sdwa v58, v145, v155 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v59, 11, v58
	v_mul_lo_u32 v59, v59, s40
	v_sub_u32_e32 v60, 0x6c686080, v59
	v_and_b32_e32 v60, 0xffffff00, v60
	v_cmp_lt_i32_e32 vcc, 11, v58
	v_sub_u32_e32 v59, 0x7c787470, v59
	s_nop 0
	v_cndmask_b32_e64 v106, v60, 0, vcc
	v_cndmask_b32_e64 v107, v59, 0, vcc
	v_add_u32_e32 v58, 0x7f7f7f00, v106
	v_and_b32_e32 v108, 0x80808000, v58
	v_add_u32_e32 v58, 0x7f7f7f78, v107
	v_and_b32_e32 v109, 0x80808080, v58
	v_and_b32_e32 v58, 0x7070707, v10
	v_lshrrev_b32_e32 v59, 4, v10
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v65, v64, v58
	v_perm_b32 v58, v63, v62, v58
	v_and_or_b32 v60, v60, v61, v58
	v_perm_b32 v58, v65, v64, v59
	v_perm_b32 v59, v63, v62, v59
	v_and_or_b32 v10, v58, v10, v59
	v_perm_b32 v58, v10, v60, s41
	v_perm_b32 v59, v10, v60, s42
	v_and_b32_e32 v10, 0x7070707, v14
	v_lshrrev_b32_e32 v60, 4, v14
	v_and_b32_e32 v60, 0x7070707, v60
	v_perm_b32 v61, v109, v108, v10
	v_perm_b32 v10, v107, v106, v10
	v_and_or_b32 v10, v61, v110, v10
	v_perm_b32 v61, v109, v108, v60
	v_perm_b32 v60, v107, v106, v60
	v_and_or_b32 v14, v61, v14, v60
	v_perm_b32 v60, v14, v10, s41
	v_perm_b32 v61, v14, v10, s42
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v14, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[98:99], v[58:59], v[26:29]
	v_and_b32_e32 v14, 0x7070707, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[104:105], v[58:59], v[30:33]
	v_perm_b32 v58, v65, v64, v10
	v_lshlrev_b32_e32 v59, 4, v11
	v_perm_b32 v10, v63, v62, v10
	v_and_or_b32 v58, v58, v59, v10
	v_perm_b32 v10, v65, v64, v14
	v_perm_b32 v14, v63, v62, v14
	v_and_or_b32 v11, v10, v11, v14
	v_perm_b32 v10, v11, v58, s41
	v_perm_b32 v11, v11, v58, s42
	v_and_b32_e32 v14, 0x7070707, v15
	v_lshrrev_b32_e32 v58, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[98:99], v[60:61], v[34:37]
	v_and_b32_e32 v58, 0x7070707, v58
	v_perm_b32 v59, v109, v108, v14
	v_perm_b32 v14, v107, v106, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[104:105], v[60:61], v[38:41]
	v_lshlrev_b32_e32 v60, 4, v15
	v_and_or_b32 v59, v59, v60, v14
	v_perm_b32 v14, v109, v108, v58
	v_perm_b32 v58, v107, v106, v58
	v_and_or_b32 v15, v14, v15, v58
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[102:103], v[10:11], v[26:29]
	v_perm_b32 v14, v15, v59, s41
	v_perm_b32 v15, v15, v59, s42
	v_lshlrev_b32_e32 v58, 4, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[100:101], v[10:11], v[30:33]
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[102:103], v[14:15], v[34:37]
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[100:101], v[14:15], v[38:41]
	v_perm_b32 v14, v65, v64, v10
	v_lshlrev_b32_e32 v15, 4, v12
	v_perm_b32 v10, v63, v62, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v65, v64, v11
	v_perm_b32 v11, v63, v62, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v12, 0x7070707, v16
	v_lshrrev_b32_e32 v14, 4, v16
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v15, v109, v108, v12
	v_perm_b32 v12, v107, v106, v12
	v_and_or_b32 v12, v15, v58, v12
	v_perm_b32 v15, v109, v108, v14
	v_perm_b32 v14, v107, v106, v14
	v_and_or_b32 v15, v15, v16, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[80:81], v[10:11], v[26:29]
	v_perm_b32 v14, v15, v12, s41
	v_perm_b32 v15, v15, v12, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[78:79], v[10:11], v[30:33]
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[80:81], v[14:15], v[34:37]
	v_perm_b32 v12, v65, v64, v10
	v_perm_b32 v10, v63, v62, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[78:79], v[14:15], v[38:41]
	v_lshlrev_b32_e32 v14, 4, v13
	v_and_or_b32 v12, v12, v14, v10
	v_perm_b32 v10, v65, v64, v11
	v_perm_b32 v11, v63, v62, v11
	v_and_or_b32 v11, v10, v13, v11
	v_perm_b32 v10, v11, v12, s41
	v_perm_b32 v11, v11, v12, s42
	v_and_b32_e32 v12, 0x7070707, v17
	v_lshrrev_b32_e32 v13, 4, v17
	v_and_b32_e32 v13, 0x7070707, v13
	v_perm_b32 v14, v109, v108, v12
	v_lshlrev_b32_e32 v15, 4, v17
	v_perm_b32 v12, v107, v106, v12
	v_and_or_b32 v14, v14, v15, v12
	v_perm_b32 v12, v109, v108, v13
	v_perm_b32 v13, v107, v106, v13
	v_and_or_b32 v13, v12, v17, v13
	v_perm_b32 v12, v13, v14, s41
	v_perm_b32 v13, v13, v14, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[76:77], v[10:11], v[26:29]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[76:77], v[12:13], v[34:37]
	s_nop 2
	v_bfe_u32 v34, v153, s8, 8
	v_sub_u32_e32 v34, v148, v34
	v_min_i32_e32 v36, 11, v34
	v_mul_lo_u32 v36, v36, s40
	v_sub_u32_e32 v37, 0x6c686080, v36
	v_and_b32_e32 v37, 0xffffff00, v37
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v36, 0x7c787470, v36
	s_waitcnt vmcnt(0)
	v_bfe_u32 v35, v154, s5, 8
	v_cndmask_b32_e64 v106, v37, 0, vcc
	v_cndmask_b32_e64 v107, v36, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v106
	v_and_b32_e32 v108, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v107
	v_and_b32_e32 v109, 0x80808080, v34
	v_sub_u32_e32 v34, v146, v35
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_lshlrev_b32_e32 v37, 4, v6
	v_cndmask_b32_e64 v110, v36, 0, vcc
	v_cndmask_b32_e64 v111, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v110
	v_and_b32_e32 v112, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v111
	v_and_b32_e32 v113, 0x80808080, v34
	v_and_b32_e32 v34, 0x7070707, v6
	v_lshrrev_b32_e32 v35, 4, v6
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v109, v108, v34
	v_perm_b32 v34, v107, v106, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v109, v108, v35
	v_perm_b32 v35, v107, v106, v35
	v_and_or_b32 v6, v36, v6, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[74:75], v[10:11], v[58:61]
	v_lshlrev_b32_e32 v36, 4, v2
	v_cmp_lt_i32_e32 vcc, 5, v152
	s_and_b32 s5, s19, 0xffff
	v_perm_b32 v58, v6, v34, s41
	v_perm_b32 v59, v6, v34, s42
	v_lshrrev_b32_e32 v34, 4, v2
	v_and_b32_e32 v6, 0x7070707, v2
	v_and_b32_e32 v34, 0x7070707, v34
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[74:75], v[12:13], v[38:41]
	v_perm_b32 v35, v113, v112, v6
	v_perm_b32 v6, v111, v110, v6
	v_and_or_b32 v6, v35, v36, v6
	v_perm_b32 v38, v113, v112, v34
	v_perm_b32 v39, v111, v110, v34
	v_and_or_b32 v2, v38, v2, v39
	v_perm_b32 v62, v2, v6, s41
	v_perm_b32 v63, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[98:99], v[58:59], v[82:85]
	v_and_b32_e32 v6, 0x7070707, v6
	s_mov_b32 s37, s5
	s_mov_b32 s8, s16
	v_perm_b32 v82, v109, v108, v2
	v_lshlrev_b32_e32 v83, 4, v7
	v_perm_b32 v2, v107, v106, v2
	v_and_or_b32 v2, v82, v83, v2
	v_perm_b32 v82, v109, v108, v6
	v_perm_b32 v6, v107, v106, v6
	v_and_or_b32 v7, v82, v7, v6
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v82, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[98:99], v[62:63], v[90:93]
	v_and_b32_e32 v82, 0x7070707, v82
	v_perm_b32 v83, v113, v112, v2
	v_lshlrev_b32_e32 v84, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[104:105], v[62:63], v[94:97]
	v_perm_b32 v2, v111, v110, v2
	v_and_or_b32 v83, v83, v84, v2
	v_perm_b32 v2, v113, v112, v82
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[104:105], v[58:59], v[86:89]
	v_perm_b32 v82, v111, v110, v82
	v_and_or_b32 v3, v2, v3, v82
	v_perm_b32 v2, v3, v83, s41
	v_perm_b32 v3, v3, v83, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[102:103], v[6:7], v[34:37]
	v_mov_b32_e32 v98, v66
	v_mov_b32_e32 v99, v50
	s_lshl_b32 s16, s50, 19
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[102:103], v[2:3], v[38:41]
	v_mov_b32_e32 v102, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[100:101], v[2:3], v[62:65]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[100:101], v[6:7], v[58:61]
	v_perm_b32 v6, v109, v108, v2
	v_lshlrev_b32_e32 v7, 4, v8
	v_perm_b32 v2, v107, v106, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v109, v108, v3
	v_perm_b32 v3, v107, v106, v3
	v_and_or_b32 v3, v2, v8, v3
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_and_b32_e32 v6, 0x7070707, v4
	v_perm_b32 v8, v113, v112, v6
	v_lshlrev_b32_e32 v62, 4, v4
	v_perm_b32 v6, v111, v110, v6
	v_lshlrev_b32_e32 v64, 2, v134
	v_and_or_b32 v8, v8, v62, v6
	v_or_b32_e32 v62, s48, v64
	v_ashrrev_i32_e32 v63, 31, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[86:89], v[80:81], v[2:3], v[34:37]
	v_lshrrev_b32_e32 v7, 4, v4
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v6, v113, v112, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[78:79], v[2:3], v[58:61]
	v_lshl_add_u64 v[2:3], v[62:63], 2, s[20:21]
	global_load_dword v63, v[2:3], off
	v_perm_b32 v7, v111, v110, v7
	v_and_or_b32 v4, v6, v4, v7
	v_perm_b32 v6, v4, v8, s41
	v_perm_b32 v7, v4, v8, s42
	v_and_b32_e32 v2, 0x7070707, v9
	v_lshrrev_b32_e32 v3, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[90:93], v[80:81], v[6:7], v[38:41]
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v109, v108, v2
	v_perm_b32 v2, v107, v106, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[78:79], v[6:7], v[82:85]
	v_lshlrev_b32_e32 v6, 4, v9
	v_and_or_b32 v4, v4, v6, v2
	v_perm_b32 v2, v109, v108, v3
	v_perm_b32 v3, v107, v106, v3
	v_and_or_b32 v3, v2, v9, v3
	v_perm_b32 v2, v3, v4, s41
	v_perm_b32 v3, v3, v4, s42
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshrrev_b32_e32 v6, 4, v5
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v113, v112, v4
	v_lshlrev_b32_e32 v8, 4, v5
	v_perm_b32 v4, v111, v110, v4
	v_mov_b32_e32 v65, 0
	v_and_or_b32 v8, v7, v8, v4
	v_perm_b32 v4, v113, v112, v6
	v_perm_b32 v9, v111, v110, v6
	v_lshl_add_u64 v[6:7], s[48:49], 0, v[64:65]
	v_lshl_add_u64 v[78:79], v[6:7], 2, s[20:21]
	global_load_dwordx3 v[94:96], v[78:79], off offset:4
	v_and_or_b32 v5, v4, v5, v9
	v_perm_b32 v4, v5, v8, s41
	v_perm_b32 v5, v5, v8, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[76:77], v[2:3], v[86:89]
	v_add_u32_e32 v83, 17, v149
	v_add_u32_e32 v81, 17, v150
	s_and_b32 s21, s21, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[76:77], v[4:5], v[90:93]
	global_load_dwordx4 v[76:79], v[78:79], off offset:64
	v_mov_b32_e32 v86, 0xfd800000
	v_lshl_add_u32 v64, v152, 23, v86
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[74:75], v[2:3], v[34:37]
	v_add_u32_e32 v87, 17, v146
	v_add_u32_e32 v89, 17, v145
	s_nop 0
	v_mov_b32_e32 v103, v6
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v2, 2, v63
	v_and_b32_e32 v2, 0x3fffffc, v2
	buffer_load_dword v82, v2, s[0:3], 0 offen
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[74:75], v[4:5], v[58:61]
	v_add_u32_e32 v63, 17, v147
	v_lshlrev_b32_e64 v63, v63, 1
	s_nop 0
	v_add_u32_e32 v58, 17, v152
	v_add_u32_e32 v59, 17, v151
	v_lshlrev_b32_e64 v58, v58, 1
	v_lshl_add_u32 v60, v151, 23, v86
	v_lshlrev_b32_e64 v74, v59, 1
	v_cndmask_b32_e32 v59, v58, v64, vcc
	v_cmp_lt_i32_e32 vcc, 5, v151
	v_add_u32_e32 v61, 17, v148
	v_lshlrev_b32_e64 v61, v61, 1
	v_cndmask_b32_e32 v58, v74, v60, vcc
	v_cmp_lt_i32_e32 vcc, 5, v150
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v60, 2, v94
	v_and_b32_e32 v74, 0x3fffffc, v60
	v_lshlrev_b32_e32 v60, 2, v95
	v_and_b32_e32 v75, 0x3fffffc, v60
	v_lshlrev_b32_e32 v60, 2, v96
	v_and_b32_e32 v85, 0x3fffffc, v60
	v_mov_b32_e32 v94, 0x2000
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v60, 2, v76
	v_and_b32_e32 v76, 0x3fffffc, v60
	v_lshlrev_b32_e32 v60, 2, v77
	v_and_b32_e32 v77, 0x3fffffc, v60
	v_lshlrev_b32_e32 v60, 2, v78
	v_and_b32_e32 v78, 0x3fffffc, v60
	v_lshlrev_b32_e32 v60, 2, v79
	v_and_b32_e32 v79, 0x3fffffc, v60
	buffer_load_dword v88, v74, s[0:3], 0 offen
	buffer_load_dword v90, v75, s[0:3], 0 offen
	buffer_load_dword v92, v85, s[0:3], 0 offen
	buffer_load_dword v84, v76, s[0:3], 0 offen
	buffer_load_dword v80, v77, s[0:3], 0 offen
	buffer_load_dword v64, v78, s[0:3], 0 offen
	buffer_load_dword v60, v79, s[0:3], 0 offen
	v_mov_b32_e32 v76, v70
	v_mov_b32_e32 v77, v54
	s_mov_b32 s0, 0xbfb8aa3b
	v_lshl_add_u32 v70, v149, 23, v86
	v_lshl_or_b32 v54, v134, 11, v94
	v_lshl_add_u32 v85, v144, 1, v54
	s_add_i32 s2, s44, 28
	s_waitcnt vmcnt(7)
	v_pk_mul_f32 v[74:75], v[82:83], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[76:77], v[76:77], v[74:75]
	v_lshlrev_b32_e64 v83, v83, 1
	v_pk_mul_f32 v[74:75], v[76:77], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v74, v74
	v_exp_f32_e32 v75, v75
	s_nop 0
	v_pk_add_f32 v[74:75], v[74:75], 1.0 op_sel_hi:[1,0]
	s_nop 0
	v_rcp_f32_e32 v78, v74
	v_rcp_f32_e32 v79, v75
	v_lshl_add_u32 v74, v150, 23, v86
	v_lshlrev_b32_e64 v75, v81, 1
	v_cndmask_b32_e32 v75, v75, v74, vcc
	v_cmp_lt_i32_e32 vcc, 5, v149
	v_pk_mul_f32 v[76:77], v[76:77], v[78:79]
	s_nop 0
	v_cndmask_b32_e32 v74, v83, v70, vcc
	v_pk_mul_f32 v[96:97], v[82:83], v[74:75] op_sel_hi:[0,1]
	v_pk_mul_f32 v[96:97], v[98:99], v[96:97]
	s_nop 0
	v_pk_mul_f32 v[76:77], v[96:97], v[76:77]
	v_mov_b32_e32 v96, v30
	v_bfe_u32 v50, v77, 16, 1
	v_add3_u32 v50, v50, v77, s43
	v_or_b32_e32 v66, 0x400000, v77
	v_cmp_u_f32_e32 vcc, v77, v77
	v_or_b32_e32 v70, 0x400000, v76
	v_mov_b32_e32 v97, v38
	v_cndmask_b32_e32 v50, v50, v66, vcc
	v_bfe_u32 v66, v76, 16, 1
	v_add3_u32 v66, v66, v76, s43
	v_cmp_u_f32_e32 vcc, v76, v76
	v_add_u32_e32 v30, s51, v1
	v_lshl_add_u32 v38, v146, 23, v86
	v_cndmask_b32_e32 v66, v66, v70, vcc
	v_lshl_add_u32 v70, v148, 23, v86
	v_cmp_lt_i32_e32 vcc, 5, v148
	ds_write_b16_d16_hi v85, v66
	v_lshl_add_u32 v66, v147, 23, v86
	v_cndmask_b32_e32 v77, v61, v70, vcc
	v_cmp_lt_i32_e32 vcc, 5, v147
	s_nop 1
	v_cndmask_b32_e32 v76, v63, v66, vcc
	v_pk_mul_f32 v[78:79], v[82:83], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[96:97], v[96:97], v[78:79]
	v_lshl_add_u32 v83, v30, 1, v54
	v_pk_mul_f32 v[78:79], v[96:97], s[0:1] op_sel_hi:[1,0]
	v_lshlrev_b32_e64 v54, v87, 1
	v_exp_f32_e32 v78, v78
	v_exp_f32_e32 v79, v79
	v_cmp_lt_i32_e32 vcc, 5, v146
	ds_write_b16_d16_hi v83, v50 offset:32
	v_lshl_add_u32 v30, v145, 23, v86
	v_pk_add_f32 v[78:79], v[78:79], 1.0 op_sel_hi:[1,0]
	v_lshlrev_b32_e64 v50, v89, 1
	v_rcp_f32_e32 v98, v78
	v_rcp_f32_e32 v99, v79
	v_cndmask_b32_e32 v79, v54, v38, vcc
	v_mov_b32_e32 v54, v71
	v_cmp_lt_i32_e32 vcc, 5, v145
	v_pk_mul_f32 v[96:97], v[96:97], v[98:99]
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[98:99], v[88:89], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[54:55], v[54:55], v[98:99]
	v_cndmask_b32_e32 v78, v50, v30, vcc
	v_pk_mul_f32 v[70:71], v[54:55], s[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[100:101], v[82:83], v[78:79] op_sel_hi:[0,1]
	v_exp_f32_e32 v70, v70
	v_exp_f32_e32 v71, v71
	v_pk_mul_f32 v[100:101], v[102:103], v[100:101]
	v_mov_b32_e32 v50, v67
	v_pk_mul_f32 v[96:97], v[100:101], v[96:97]
	v_pk_add_f32 v[70:71], v[70:71], 1.0 op_sel_hi:[1,0]
	v_bfe_u32 v6, v97, 16, 1
	v_rcp_f32_e32 v70, v70
	v_rcp_f32_e32 v71, v71
	v_add3_u32 v6, v6, v97, s43
	v_or_b32_e32 v26, 0x400000, v97
	v_cmp_u_f32_e32 vcc, v97, v97
	v_or_b32_e32 v30, 0x400000, v96
	v_pk_mul_f32 v[54:55], v[54:55], v[70:71]
	v_cndmask_b32_e32 v6, v6, v26, vcc
	v_bfe_u32 v26, v96, 16, 1
	v_add3_u32 v26, v26, v96, s43
	v_cmp_u_f32_e32 vcc, v96, v96
	v_pk_mul_f32 v[96:97], v[88:89], v[74:75] op_sel_hi:[0,1]
	v_pk_mul_f32 v[50:51], v[50:51], v[96:97]
	v_mov_b32_e32 v38, v31
	v_pk_mul_f32 v[50:51], v[50:51], v[54:55]
	v_pk_mul_f32 v[54:55], v[88:89], v[76:77] op_sel_hi:[0,1]
	v_cndmask_b32_e32 v26, v26, v30, vcc
	v_pk_mul_f32 v[30:31], v[38:39], v[54:55]
	ds_write_b16_d16_hi v83, v26 offset:64
	ds_write_b16_d16_hi v83, v6 offset:96
	v_pk_mul_f32 v[38:39], v[30:31], s[0:1] op_sel_hi:[1,0]
	v_bfe_u32 v6, v51, 16, 1
	v_exp_f32_e32 v38, v38
	v_exp_f32_e32 v39, v39
	v_add3_u32 v6, v6, v51, s43
	v_or_b32_e32 v26, 0x400000, v51
	v_cmp_u_f32_e32 vcc, v51, v51
	v_pk_add_f32 v[38:39], v[38:39], 1.0 op_sel_hi:[1,0]
	v_or_b32_e32 v51, 0x400000, v50
	v_cndmask_b32_e32 v6, v6, v26, vcc
	v_bfe_u32 v26, v50, 16, 1
	v_rcp_f32_e32 v38, v38
	v_rcp_f32_e32 v39, v39
	v_add3_u32 v26, v26, v50, s43
	v_cmp_u_f32_e32 vcc, v50, v50
	v_and_b32_e32 v99, 0xfc, v137
	v_and_b32_e32 v100, 0x3f0, v136
	v_cndmask_b32_e32 v26, v26, v51, vcc
	ds_write_b16_d16_hi v83, v26 offset:512
	ds_write_b16_d16_hi v83, v6 offset:544
	v_pk_mul_f32 v[50:51], v[88:89], v[78:79] op_sel_hi:[0,1]
	v_mov_b32_e32 v6, v27
	v_pk_mul_f32 v[6:7], v[6:7], v[50:51]
	v_pk_mul_f32 v[26:27], v[30:31], v[38:39]
	v_mov_b32_e32 v30, v72
	v_pk_mul_f32 v[6:7], v[6:7], v[26:27]
	v_mov_b32_e32 v31, v56
	v_bfe_u32 v26, v7, 16, 1
	v_add3_u32 v26, v26, v7, s43
	v_or_b32_e32 v27, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_or_b32_e32 v39, 0x400000, v6
	v_mov_b32_e32 v56, v73
	v_cndmask_b32_e32 v7, v26, v27, vcc
	v_bfe_u32 v26, v6, 16, 1
	v_add3_u32 v38, v26, v6, s43
	s_waitcnt vmcnt(5)
	v_pk_mul_f32 v[26:27], v[90:91], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[30:31], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_and_b32_e32 v82, 0x7c, v137
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v6, v38, v39, vcc
	ds_write_b16_d16_hi v83, v6 offset:576
	ds_write_b16_d16_hi v83, v7 offset:608
	v_mov_b32_e32 v38, v68
	v_pk_add_f32 v[6:7], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[90:91], v[74:75] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v39, v52
	v_pk_mul_f32 v[30:31], v[38:39], v[30:31]
	v_mov_b32_e32 v52, v69
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	s_nop 0
	v_pk_mul_f32 v[6:7], v[30:31], v[6:7]
	v_mov_b32_e32 v30, v32
	v_bfe_u32 v26, v7, 16, 1
	v_add3_u32 v26, v26, v7, s43
	v_or_b32_e32 v27, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_mov_b32_e32 v31, v40
	v_or_b32_e32 v39, 0x400000, v6
	v_cndmask_b32_e32 v7, v26, v27, vcc
	v_bfe_u32 v26, v6, 16, 1
	v_add3_u32 v38, v26, v6, s43
	v_pk_mul_f32 v[26:27], v[90:91], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[30:31], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v40, v33
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cndmask_b32_e32 v6, v38, v39, vcc
	ds_write_b16_d16_hi v83, v6 offset:1024
	ds_write_b16_d16_hi v83, v7 offset:1056
	v_mov_b32_e32 v38, v28
	v_pk_add_f32 v[6:7], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[90:91], v[78:79] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v39, v8
	v_pk_mul_f32 v[30:31], v[38:39], v[30:31]
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	s_nop 0
	v_pk_mul_f32 v[6:7], v[30:31], v[6:7]
	s_nop 0
	v_bfe_u32 v8, v7, 16, 1
	v_add3_u32 v8, v8, v7, s43
	v_or_b32_e32 v26, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_or_b32_e32 v28, 0x400000, v6
	s_nop 0
	v_cndmask_b32_e32 v7, v8, v26, vcc
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[26:27], v[92:93], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[56:57], v[26:27]
	v_bfe_u32 v8, v6, 16, 1
	v_pk_mul_f32 v[30:31], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v8, v8, v6, s43
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v28, vcc
	ds_write_b16_d16_hi v83, v6 offset:1088
	ds_write_b16_d16_hi v83, v7 offset:1120
	v_pk_add_f32 v[6:7], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[92:93], v[74:75] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[30:31], v[52:53], v[30:31]
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	s_nop 0
	v_pk_mul_f32 v[6:7], v[30:31], v[6:7]
	s_nop 0
	v_bfe_u32 v8, v7, 16, 1
	v_add3_u32 v8, v8, v7, s43
	v_or_b32_e32 v26, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_or_b32_e32 v28, 0x400000, v6
	s_nop 0
	v_cndmask_b32_e32 v7, v8, v26, vcc
	v_pk_mul_f32 v[26:27], v[92:93], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[26:27], v[40:41], v[26:27]
	v_bfe_u32 v8, v6, 16, 1
	v_pk_mul_f32 v[30:31], v[26:27], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v8, v8, v6, s43
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	v_cmp_u_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v28, vcc
	ds_write_b16_d16_hi v83, v6 offset:1536
	ds_write_b16_d16_hi v83, v7 offset:1568
	v_pk_add_f32 v[6:7], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[92:93], v[78:79] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v8, v29
	v_pk_mul_f32 v[8:9], v[8:9], v[30:31]
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	v_mov_b32_e32 v26, v46
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v27, v22
	v_bfe_u32 v8, v7, 16, 1
	v_add3_u32 v8, v8, v7, s43
	v_or_b32_e32 v9, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_or_b32_e32 v29, 0x400000, v6
	s_nop 0
	v_cndmask_b32_e32 v7, v8, v9, vcc
	v_bfe_u32 v8, v6, 16, 1
	v_add3_u32 v28, v8, v6, s43
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[8:9], v[84:85], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[26:27], v[8:9]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[26:27], v[8:9], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v6, v28, v29, vcc
	ds_write_b16_d16_hi v83, v6 offset:1600
	ds_write_b16_d16_hi v83, v7 offset:1632
	v_mov_b32_e32 v28, v42
	v_pk_add_f32 v[6:7], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[84:85], v[74:75] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_mov_b32_e32 v29, v18
	v_pk_mul_f32 v[26:27], v[28:29], v[26:27]
	v_mov_b32_e32 v28, v10
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v29, v2
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	v_mov_b32_e32 v26, v14
	v_bfe_u32 v8, v7, 16, 1
	v_add3_u32 v8, v8, v7, s43
	v_or_b32_e32 v9, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_mov_b32_e32 v27, v34
	v_or_b32_e32 v22, 0x400000, v6
	v_cndmask_b32_e32 v7, v8, v9, vcc
	v_bfe_u32 v8, v6, 16, 1
	v_add3_u32 v18, v8, v6, s43
	v_pk_mul_f32 v[8:9], v[84:85], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[26:27], v[8:9]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_pk_mul_f32 v[26:27], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v34, v15
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v6, v18, v22, vcc
	ds_write_b16_d16_hi v83, v6 offset:8192
	ds_write_b16_d16_hi v83, v7 offset:8224
	v_mov_b32_e32 v22, v47
	v_pk_add_f32 v[6:7], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[84:85], v[78:79] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[26:27], v[28:29], v[26:27]
	v_mov_b32_e32 v18, v43
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	s_nop 0
	v_pk_mul_f32 v[6:7], v[26:27], v[6:7]
	s_nop 0
	v_bfe_u32 v2, v7, 16, 1
	v_add3_u32 v2, v2, v7, s43
	v_or_b32_e32 v8, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_bfe_u32 v7, v6, 16, 1
	v_add3_u32 v7, v7, v6, s43
	v_cndmask_b32_e32 v2, v2, v8, vcc
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[8:9], v[80:81], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[22:23], v[8:9]
	v_or_b32_e32 v10, 0x400000, v6
	v_pk_mul_f32 v[22:23], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_exp_f32_e32 v22, v22
	v_exp_f32_e32 v23, v23
	v_cndmask_b32_e32 v6, v7, v10, vcc
	ds_write_b16_d16_hi v83, v6 offset:8256
	ds_write_b16_d16_hi v83, v2 offset:8288
	v_pk_add_f32 v[6:7], v[22:23], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[22:23], v[80:81], v[74:75] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[18:19], v[18:19], v[22:23]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	s_nop 0
	v_pk_mul_f32 v[6:7], v[18:19], v[6:7]
	s_nop 0
	v_bfe_u32 v2, v7, 16, 1
	v_add3_u32 v2, v2, v7, s43
	v_or_b32_e32 v8, 0x400000, v7
	v_cmp_u_f32_e32 vcc, v7, v7
	v_bfe_u32 v7, v6, 16, 1
	v_add3_u32 v7, v7, v6, s43
	v_cndmask_b32_e32 v2, v2, v8, vcc
	v_pk_mul_f32 v[8:9], v[80:81], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[34:35], v[8:9]
	v_or_b32_e32 v10, 0x400000, v6
	v_pk_mul_f32 v[14:15], v[8:9], s[0:1] op_sel_hi:[1,0]
	v_cmp_u_f32_e32 vcc, v6, v6
	v_exp_f32_e32 v14, v14
	v_exp_f32_e32 v15, v15
	v_cndmask_b32_e32 v6, v7, v10, vcc
	ds_write_b16_d16_hi v83, v6 offset:8704
	ds_write_b16_d16_hi v83, v2 offset:8736
	v_mov_b32_e32 v2, v11
	v_pk_add_f32 v[6:7], v[14:15], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[80:81], v[78:79] op_sel_hi:[0,1]
	v_rcp_f32_e32 v6, v6
	v_rcp_f32_e32 v7, v7
	v_pk_mul_f32 v[2:3], v[2:3], v[14:15]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_mov_b32_e32 v8, v48
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	v_mov_b32_e32 v9, v24
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s43
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v11, 0x400000, v2
	v_mov_b32_e32 v24, v49
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v10, v6, v2, s43
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[6:7], v[64:65], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v2, v10, v11, vcc
	ds_write_b16_d16_hi v83, v2 offset:8768
	ds_write_b16_d16_hi v83, v3 offset:8800
	v_mov_b32_e32 v10, v44
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[64:65], v[74:75] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v11, v20
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9]
	v_mov_b32_e32 v20, v45
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[8:9], v[2:3]
	v_mov_b32_e32 v8, v16
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s43
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_mov_b32_e32 v9, v36
	v_or_b32_e32 v11, 0x400000, v2
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v10, v6, v2, s43
	v_pk_mul_f32 v[6:7], v[64:65], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v36, v17
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cndmask_b32_e32 v2, v10, v11, vcc
	ds_write_b16_d16_hi v83, v2 offset:9216
	ds_write_b16_d16_hi v83, v3 offset:9248
	v_mov_b32_e32 v10, v12
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[64:65], v[78:79] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v11, v4
	v_pk_mul_f32 v[8:9], v[10:11], v[8:9]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[8:9], v[2:3]
	s_nop 0
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s43
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v10, 0x400000, v2
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v6, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[60:61], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[24:25], v[6:7]
	v_bfe_u32 v4, v2, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v4, v4, v2, s43
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v4, v10, vcc
	ds_write_b16_d16_hi v83, v2 offset:9280
	ds_write_b16_d16_hi v83, v3 offset:9312
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[60:61], v[74:75] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_pk_mul_f32 v[8:9], v[20:21], v[8:9]
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_nop 0
	v_pk_mul_f32 v[2:3], v[8:9], v[2:3]
	s_nop 0
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s43
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v10, 0x400000, v2
	s_nop 0
	v_cndmask_b32_e32 v3, v4, v6, vcc
	v_pk_mul_f32 v[6:7], v[60:61], v[76:77] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[36:37], v[6:7]
	v_bfe_u32 v4, v2, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v4, v4, v2, s43
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v2, v2
	s_mov_b32 s0, 0x43700000
	s_lshl_b32 s1, s44, 2
	v_cndmask_b32_e32 v2, v4, v10, vcc
	ds_write_b16_d16_hi v83, v2 offset:9728
	ds_write_b16_d16_hi v83, v3 offset:9760
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[60:61], v[78:79] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v4, v13
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
	ds_write_b16_d16_hi v83, v2 offset:9792
	ds_write_b16_d16_hi v83, v3 offset:9824
	v_lshlrev_b32_e32 v2, 2, v143
	v_or_b32_e32 v3, s46, v2
	v_lshlrev_b32_e32 v3, 1, v3
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[4:5], v3 offset:8192
	v_mov_b32_e32 v3, 0x7fc00000
	s_waitcnt lgkmcnt(0)
	v_lshlrev_b32_e32 v8, 16, v4
	v_and_b32_e32 v9, 0xffff0000, v4
	v_max_f32_e64 v4, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_cndmask_b32_e32 v4, v3, v4, vcc
	v_max_f32_e64 v5, v4, |v9|
	v_cmp_o_f32_e64 vcc, v4, |v9|
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
	v_max_f32_e32 v10, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v10, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v10, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v10, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v10, vcc
	ds_swizzle_b32 v5, v4 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v4, v5
	v_cmp_o_f32_e32 vcc, v4, v5
	v_xor_b32_e32 v4, 0x80, v2
	s_nop 0
	v_cndmask_b32_e32 v5, v3, v10, vcc
	ds_bpermute_b32 v10, v4, v5
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v5, v10
	v_cmp_o_f32_e32 vcc, v5, v10
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v11, vcc
	v_div_scale_f32 v10, s[6:7], s0, s0, v5
	v_rcp_f32_e32 v11, v10
	s_nop 0
	v_fma_f32 v12, -v10, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, v5, s0, v5
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v10, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v10, -v10, v13, v12
	v_div_fmas_f32 v10, v10, v11, v13
	v_div_fixup_f32 v10, v10, s0, v5
	v_cmp_neq_f32_e32 vcc, 0, v5
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v10, vcc
	v_div_scale_f32 v5, s[6:7], v11, v11, 1.0
	v_rcp_f32_e32 v10, v5
	s_nop 0
	v_fma_f32 v12, -v5, v10, 1.0
	v_fmac_f32_e32 v10, v12, v10
	v_div_scale_f32 v12, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v13, v12, v10
	v_fma_f32 v14, -v5, v13, v12
	v_fmac_f32_e32 v13, v14, v10
	v_fma_f32 v5, -v5, v13, v12
	v_div_fmas_f32 v5, v5, v10, v13
	v_div_fixup_f32 v10, v5, v11, 1.0
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
	v_mov_b32_e32 v9, v65
	v_cvt_pk_fp8_f32 v9, v5, v8
	v_max_f32_e32 v5, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v5, v3, v5, vcc
	v_cvt_pk_fp8_f32 v9, v6, v5 op_sel:[0,0,1]
	v_mov_b32_e32 v5, s1
	s_lshr_b32 s1, s52, 2
	s_and_b32 s1, s1, 0xf0
	v_and_b32_e32 v6, 0x7f7f7f7f, v9
	v_add_u32_e32 v6, 0x7f7f7f7f, v6
	v_or_b32_e32 v6, 0x7f7f7f7f, v6
	v_xor_b32_e32 v7, s1, v2
	v_and_b32_e32 v6, v6, v9
	v_or_b32_e32 v7, s46, v7
	ds_write_b32 v5, v11 offset:24576
	ds_write_b32 v7, v6
	s_add_i32 s1, s44, 4
	v_lshlrev_b32_e32 v6, 3, v143
	v_lshl_or_b32 v8, s1, 9, v6
	ds_read_b64 v[8:9], v8 offset:8192
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v11, 0xffff0000, v9
	v_lshlrev_b32_e32 v10, 16, v9
	v_and_b32_e32 v9, 0xffff0000, v8
	v_lshlrev_b32_e32 v8, 16, v8
	v_max_f32_e64 v12, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v12, vcc
	v_max_f32_e64 v13, v12, |v9|
	v_cmp_o_f32_e64 vcc, v12, |v9|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v10|
	v_cmp_o_f32_e64 vcc, v12, |v10|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v11|
	v_cmp_o_f32_e64 vcc, v12, |v11|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_bpermute_b32 v13, v4, v12
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	v_div_scale_f32 v13, s[6:7], s0, s0, v12
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v12, s0, v12
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s0, v12
	v_cmp_neq_f32_e32 vcc, 0, v12
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v12, s[6:7], v13, v13, 1.0
	v_rcp_f32_e32 v14, v12
	ds_write_b32 v5, v13 offset:24592
	v_fma_f32 v15, -v12, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v12, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v12, -v12, v16, v15
	v_div_fmas_f32 v12, v12, v14, v16
	v_div_fixup_f32 v12, v12, v13, 1.0
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
	v_mov_b32_e32 v12, v65
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	v_xor_b32_e32 v9, s1, v2
	v_or_b32_e32 v9, s46, v9
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	s_add_i32 s1, s44, 8
	v_and_b32_e32 v8, 0x7f7f7f7f, v12
	v_add_u32_e32 v8, 0x7f7f7f7f, v8
	v_or_b32_e32 v8, 0x7f7f7f7f, v8
	v_and_b32_e32 v8, v8, v12
	ds_write_b32 v9, v8 offset:1024
	v_lshl_or_b32 v8, s1, 9, v6
	ds_read_b64 v[8:9], v8 offset:8192
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v11, 0xffff0000, v9
	v_lshlrev_b32_e32 v10, 16, v9
	v_and_b32_e32 v9, 0xffff0000, v8
	v_lshlrev_b32_e32 v8, 16, v8
	v_max_f32_e64 v12, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v12, vcc
	v_max_f32_e64 v13, v12, |v9|
	v_cmp_o_f32_e64 vcc, v12, |v9|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v10|
	v_cmp_o_f32_e64 vcc, v12, |v10|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v11|
	v_cmp_o_f32_e64 vcc, v12, |v11|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_bpermute_b32 v13, v4, v12
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	v_div_scale_f32 v13, s[6:7], s0, s0, v12
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v12, s0, v12
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s0, v12
	v_cmp_neq_f32_e32 vcc, 0, v12
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v12, s[6:7], v13, v13, 1.0
	v_rcp_f32_e32 v14, v12
	ds_write_b32 v5, v13 offset:24608
	v_fma_f32 v15, -v12, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v12, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v12, -v12, v16, v15
	v_div_fmas_f32 v12, v12, v14, v16
	v_div_fixup_f32 v12, v12, v13, 1.0
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
	v_mov_b32_e32 v12, v65
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	v_xor_b32_e32 v9, s1, v2
	v_or_b32_e32 v9, s46, v9
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	s_add_i32 s1, s44, 12
	v_and_b32_e32 v8, 0x7f7f7f7f, v12
	v_add_u32_e32 v8, 0x7f7f7f7f, v8
	v_or_b32_e32 v8, 0x7f7f7f7f, v8
	v_and_b32_e32 v8, v8, v12
	ds_write_b32 v9, v8 offset:2048
	v_lshl_or_b32 v8, s1, 9, v6
	ds_read_b64 v[8:9], v8 offset:8192
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v11, 0xffff0000, v9
	v_lshlrev_b32_e32 v10, 16, v9
	v_and_b32_e32 v9, 0xffff0000, v8
	v_lshlrev_b32_e32 v8, 16, v8
	v_max_f32_e64 v12, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v12, vcc
	v_max_f32_e64 v13, v12, |v9|
	v_cmp_o_f32_e64 vcc, v12, |v9|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v10|
	v_cmp_o_f32_e64 vcc, v12, |v10|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v11|
	v_cmp_o_f32_e64 vcc, v12, |v11|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_bpermute_b32 v13, v4, v12
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	v_div_scale_f32 v13, s[6:7], s0, s0, v12
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v12, s0, v12
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s0, v12
	v_cmp_neq_f32_e32 vcc, 0, v12
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v12, s[6:7], v13, v13, 1.0
	v_rcp_f32_e32 v14, v12
	ds_write_b32 v5, v13 offset:24624
	v_fma_f32 v15, -v12, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v12, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v12, -v12, v16, v15
	v_div_fmas_f32 v12, v12, v14, v16
	v_div_fixup_f32 v12, v12, v13, 1.0
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
	v_mov_b32_e32 v12, v65
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	v_xor_b32_e32 v9, s1, v2
	v_or_b32_e32 v9, s46, v9
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	s_add_i32 s1, s47, 0x2000
	v_and_b32_e32 v8, 0x7f7f7f7f, v12
	v_add_u32_e32 v8, 0x7f7f7f7f, v8
	v_or_b32_e32 v8, 0x7f7f7f7f, v8
	v_and_b32_e32 v8, v8, v12
	ds_write_b32 v9, v8 offset:3072
	v_or_b32_e32 v8, s1, v6
	ds_read_b64 v[8:9], v8 offset:8192
	s_add_i32 s1, s44, 20
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v11, 0xffff0000, v9
	v_lshlrev_b32_e32 v10, 16, v9
	v_and_b32_e32 v9, 0xffff0000, v8
	v_lshlrev_b32_e32 v8, 16, v8
	v_max_f32_e64 v12, |v8|, 0
	v_cmp_o_f32_e64 vcc, |v8|, |v8|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v12, vcc
	v_max_f32_e64 v13, v12, |v9|
	v_cmp_o_f32_e64 vcc, v12, |v9|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v10|
	v_cmp_o_f32_e64 vcc, v12, |v10|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	v_max_f32_e64 v13, v12, |v11|
	v_cmp_o_f32_e64 vcc, v12, |v11|
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v13, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_swizzle_b32 v13, v12 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	ds_bpermute_b32 v13, v4, v12
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v12, v13
	v_cmp_o_f32_e32 vcc, v12, v13
	s_nop 1
	v_cndmask_b32_e32 v12, v3, v14, vcc
	v_div_scale_f32 v13, s[6:7], s0, s0, v12
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v12, s0, v12
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s0, v12
	v_cmp_neq_f32_e32 vcc, 0, v12
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v12, s[6:7], v13, v13, 1.0
	v_rcp_f32_e32 v14, v12
	ds_write_b32 v5, v13 offset:24640
	v_fma_f32 v15, -v12, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v12, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v12, -v12, v16, v15
	v_div_fmas_f32 v12, v12, v14, v16
	v_div_fixup_f32 v12, v12, v13, 1.0
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
	v_mov_b32_e32 v12, v65
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v8, 0x7f7f7f7f, v12
	v_add_u32_e32 v8, 0x7f7f7f7f, v8
	v_or_b32_e32 v8, 0x7f7f7f7f, v8
	v_and_b32_e32 v8, v8, v12
	ds_write_b32 v7, v8 offset:4096
	v_lshl_or_b32 v7, s1, 9, v6
	ds_read_b64 v[8:9], v7 offset:8192
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
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
	v_div_scale_f32 v12, s[6:7], s0, s0, v7
	v_rcp_f32_e32 v13, v12
	s_nop 0
	v_fma_f32 v14, -v12, v13, 1.0
	v_fmac_f32_e32 v13, v14, v13
	v_div_scale_f32 v14, vcc, v7, s0, v7
	v_mul_f32_e32 v15, v14, v13
	v_fma_f32 v16, -v12, v15, v14
	v_fmac_f32_e32 v15, v16, v13
	v_fma_f32 v12, -v12, v15, v14
	v_div_fmas_f32 v12, v12, v13, v15
	v_div_fixup_f32 v12, v12, s0, v7
	v_cmp_neq_f32_e32 vcc, 0, v7
	s_nop 1
	v_cndmask_b32_e32 v7, 1.0, v12, vcc
	v_div_scale_f32 v12, s[6:7], v7, v7, 1.0
	v_rcp_f32_e32 v13, v12
	ds_write_b32 v5, v7 offset:24656
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
	v_mov_b32_e32 v12, v65
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	v_xor_b32_e32 v8, s1, v2
	v_or_b32_e32 v8, s46, v8
	s_add_i32 s1, s44, 24
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	ds_write_b32 v8, v7 offset:5120
	v_lshl_or_b32 v7, s1, 9, v6
	ds_read_b64 v[8:9], v7 offset:8192
	s_lshl_b32 s1, s1, 4
	s_and_b32 s1, s1, 0xf0
	v_lshl_or_b32 v6, s2, 9, v6
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
	v_div_scale_f32 v12, s[6:7], s0, s0, v7
	v_rcp_f32_e32 v13, v12
	s_nop 0
	v_fma_f32 v14, -v12, v13, 1.0
	v_fmac_f32_e32 v13, v14, v13
	v_div_scale_f32 v14, vcc, v7, s0, v7
	v_mul_f32_e32 v15, v14, v13
	v_fma_f32 v16, -v12, v15, v14
	v_fmac_f32_e32 v15, v16, v13
	v_fma_f32 v12, -v12, v15, v14
	v_div_fmas_f32 v12, v12, v13, v15
	v_div_fixup_f32 v12, v12, s0, v7
	v_cmp_neq_f32_e32 vcc, 0, v7
	s_nop 1
	v_cndmask_b32_e32 v7, 1.0, v12, vcc
	v_div_scale_f32 v12, s[6:7], v7, v7, 1.0
	v_rcp_f32_e32 v13, v12
	ds_write_b32 v5, v7 offset:24672
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
	v_mov_b32_e32 v12, v65
	v_cvt_pk_fp8_f32 v12, v8, v9
	v_max_f32_e32 v8, 0xc3700000, v11
	v_cmp_o_f32_e32 vcc, v11, v11
	s_nop 1
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_cvt_pk_fp8_f32 v12, v10, v8 op_sel:[0,0,1]
	v_xor_b32_e32 v8, s1, v2
	v_or_b32_e32 v8, s46, v8
	v_and_b32_e32 v7, 0x7f7f7f7f, v12
	v_add_u32_e32 v7, 0x7f7f7f7f, v7
	v_or_b32_e32 v7, 0x7f7f7f7f, v7
	v_and_b32_e32 v7, v7, v12
	ds_write_b32 v8, v7 offset:6144
	ds_read_b64 v[6:7], v6 offset:8192
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
	ds_bpermute_b32 v4, v4, v10
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v10, v4
	v_cmp_o_f32_e32 vcc, v10, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v3, v11, vcc
	v_div_scale_f32 v10, s[6:7], s0, s0, v4
	v_rcp_f32_e32 v11, v10
	s_mul_i32 s7, s50, 0xe00
	s_mov_b32 s6, 0x400000
	s_mov_b32 s38, s6
	v_fma_f32 v12, -v10, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, v4, s0, v4
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v10, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v10, -v10, v13, v12
	v_div_fmas_f32 v10, v10, v11, v13
	v_div_fixup_f32 v10, v10, s0, v4
	v_cmp_neq_f32_e32 vcc, 0, v4
	s_nop 1
	v_cndmask_b32_e32 v10, 1.0, v10, vcc
	v_div_scale_f32 v4, s[0:1], v10, v10, 1.0
	v_rcp_f32_e32 v11, v4
	s_lshl_b32 s0, s2, 4
	s_and_b32 s0, s0, 0xf0
	v_xor_b32_e32 v2, s0, v2
	v_fma_f32 v12, -v4, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, 1.0, v10, 1.0
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v4, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v4, -v4, v13, v12
	v_div_fmas_f32 v4, v4, v11, v13
	v_div_fixup_f32 v4, v4, v10, 1.0
	v_pk_mul_f32 v[6:7], v[4:5], v[6:7] op_sel_hi:[0,1]
	v_pk_mul_f32 v[8:9], v[4:5], v[8:9] op_sel_hi:[0,1]
	v_min_f32_e32 v4, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	v_or_b32_e32 v2, s46, v2
	s_and_b32 s1, s15, 0xffff
	v_cndmask_b32_e32 v4, v3, v4, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_mov_b32 s0, s14
	s_mov_b32 s14, -1
	v_cndmask_b32_e32 v4, v3, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_mov_b32 s15, s3
	v_lshlrev_b32_e32 v12, 2, v62
	v_cndmask_b32_e32 v6, v3, v6, vcc
	v_max_f32_e32 v7, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	ds_write_b32 v5, v10 offset:24688
	v_or_b32_e32 v13, 4, v12
	v_cndmask_b32_e32 v6, v3, v7, vcc
	v_min_f32_e32 v7, 0x43700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	v_cvt_pk_fp8_f32 v65, v4, v6
	v_or_b32_e32 v14, 8, v12
	v_cndmask_b32_e32 v7, v3, v7, vcc
	v_max_f32_e32 v8, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	v_or_b32_e32 v15, 12, v12
	v_or_b32_e32 v16, 64, v12
	v_cndmask_b32_e32 v7, v3, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v9
	v_cmp_o_f32_e32 vcc, v9, v9
	v_or_b32_e32 v17, 0x44, v12
	v_or_b32_e32 v18, 0x48, v12
	v_cndmask_b32_e32 v8, v3, v8, vcc
	v_max_f32_e32 v4, 0xc3700000, v8
	v_cmp_o_f32_e32 vcc, v8, v8
	v_or_b32_e32 v19, 0x4c, v12
	s_brev_b32 s2, 16
	v_cndmask_b32_e32 v3, v3, v4, vcc
	v_cvt_pk_fp8_f32 v65, v7, v3 op_sel:[0,0,1]
	s_mov_b32 s25, s1
	s_mov_b32 s26, s2
	v_add_u32_e32 v4, v140, v140
	v_and_b32_e32 v3, 0x7f7f7f7f, v65
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v65
	ds_write_b32 v2, v3 offset:7168
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v78, v12, s[12:15], 0 offen
	buffer_load_dword v79, v13, s[12:15], 0 offen
	buffer_load_dword v80, v14, s[12:15], 0 offen
	buffer_load_dword v81, v15, s[12:15], 0 offen
	buffer_load_dword v74, v16, s[12:15], 0 offen
	buffer_load_dword v75, v17, s[12:15], 0 offen
	buffer_load_dword v76, v18, s[12:15], 0 offen
	buffer_load_dword v77, v19, s[12:15], 0 offen
	s_add_i32 s15, s4, s7
	s_lshl_b32 s4, s15, 1
	v_or3_b32 v13, s4, v135, v1
	s_lshl_b32 s4, s15, 3
	s_ashr_i32 s7, s15, 31
	v_or3_b32 v14, s4, v135, v1
	s_or_b32 s4, s15, 16
	s_lshr_b32 s12, s7, 27
	v_lshlrev_b32_e32 v14, 4, v14
	s_add_i32 s13, s4, s12
	v_or_b32_e32 v15, 0x400, v14
	buffer_load_dwordx4 v[70:73], v14, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[58:61], v15, s[24:27], 0 offen nt
	v_or_b32_e32 v14, s4, v1
	s_lshr_b32 s13, s13, 5
	s_lshl_b32 s4, s4, 3
	s_add_i32 s13, s13, s7
	v_or3_b32 v16, s4, v135, v1
	s_lshl_b32 s13, s13, 6
	v_lshlrev_b32_e32 v16, 4, v16
	s_or_b32 s4, s15, 32
	v_or3_b32 v15, s13, v135, v1
	v_or_b32_e32 v17, 0x400, v16
	buffer_load_dwordx4 v[66:69], v16, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[62:65], v17, s[24:27], 0 offen nt
	v_or_b32_e32 v16, s4, v1
	s_lshl_b32 s13, s4, 1
	s_lshl_b32 s4, s4, 3
	v_or3_b32 v18, s4, v135, v1
	s_or_b32 s4, s15, 48
	s_add_i32 s12, s4, s12
	s_lshr_b32 s12, s12, 5
	v_or_b32_e32 v12, s15, v1
	v_lshlrev_b32_e32 v18, 4, v18
	s_add_i32 s12, s12, s7
	v_lshlrev_b32_e32 v12, 2, v12
	v_or_b32_e32 v19, 0x400, v18
	buffer_load_dwordx4 v[54:57], v18, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[50:53], v19, s[24:27], 0 offen nt
	v_or_b32_e32 v18, s4, v1
	s_lshl_b32 s7, s12, 6
	v_lshlrev_b32_e32 v14, 2, v14
	v_lshlrev_b32_e32 v16, 2, v16
	v_lshlrev_b32_e32 v18, 2, v18
	buffer_load_dword v109, v12, s[36:39], 0 offen
	buffer_load_dword v108, v14, s[36:39], 0 offen
	buffer_load_dword v107, v16, s[36:39], 0 offen
	buffer_load_dword v106, v18, s[36:39], 0 offen
	v_or3_b32 v12, s7, v135, v1
	v_lshlrev_b32_e32 v13, 2, v13
	v_or3_b32 v17, s13, v135, v1
	v_lshlrev_b32_e32 v12, 2, v12
	s_lshl_b32 s4, s4, 3
	v_lshlrev_b32_e32 v15, 2, v15
	v_lshlrev_b32_e32 v17, 2, v17
	buffer_load_dword v113, v13, s[28:31], 0 offen
	buffer_load_dword v98, v15, s[28:31], 0 offen
	buffer_load_dword v110, v17, s[28:31], 0 offen
	buffer_load_dword v96, v12, s[28:31], 0 offen
	v_or3_b32 v12, s4, v135, v1
	v_lshlrev_b32_e32 v12, 4, v12
	v_or_b32_e32 v13, 0x400, v12
	buffer_load_dwordx4 v[46:49], v12, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[42:45], v13, s[24:27], 0 offen nt
	v_lshlrev_b32_e32 v2, 4, v1
	v_xor_b32_e32 v3, v138, v2
	v_xor_b32_e32 v8, v141, v2
	v_add_u32_e32 v5, v4, v3
	v_xor_b32_e32 v6, v142, v2
	v_add_u32_e32 v9, v4, v8
	v_xor_b32_e32 v10, v139, v2
	v_add_u32_e32 v7, v4, v6
	v_add_u32_e32 v11, v4, v10
	ds_read_b64 v[144:145], v5
	ds_read_b64 v[140:141], v7
	ds_read_b64 v[132:133], v9
	ds_read_b64 v[128:129], v11
	v_or_b32_e32 v5, 0x80, v138
	v_or_b32_e32 v9, 0x88, v138
	v_or_b32_e32 v12, 0x90, v138
	v_or_b32_e32 v14, 0x98, v138
	v_xor_b32_e32 v5, v5, v2
	v_xor_b32_e32 v9, v9, v2
	v_xor_b32_e32 v12, v12, v2
	v_xor_b32_e32 v2, v14, v2
	v_add_u32_e32 v7, v4, v5
	v_add_u32_e32 v11, v4, v9
	v_add_u32_e32 v13, v4, v12
	v_add_u32_e32 v14, v4, v2
	v_or_b32_e32 v4, 0x1000, v4
	ds_read_b64 v[124:125], v7
	ds_read_b64 v[120:121], v11
	ds_read_b64 v[116:117], v13
	ds_read_b64 v[114:115], v14
	v_add_u32_e32 v3, v4, v3
	v_add_u32_e32 v7, v4, v8
	v_add_u32_e32 v8, v4, v10
	v_lshrrev_b32_e32 v10, 5, v0
	v_add_u32_e32 v6, v4, v6
	ds_read_b64 v[148:149], v3
	ds_read_b64 v[146:147], v6
	ds_read_b64 v[142:143], v7
	ds_read_b64 v[138:139], v8
	v_add_u32_e32 v3, v4, v5
	v_or_b32_e32 v11, s48, v10
	v_add_u32_e32 v5, v4, v9
	v_add_u32_e32 v6, v4, v12
	v_add_u32_e32 v2, v4, v2
	ds_read_b64 v[130:131], v3
	ds_read_b64 v[126:127], v5
	ds_read_b64 v[122:123], v6
	ds_read_b64 v[118:119], v2
	v_lshlrev_b32_e32 v92, 2, v11
	v_or_b32_e32 v11, 8, v10
	v_lshlrev_b32_e32 v2, 4, v134
	v_or_b32_e32 v12, s48, v11
	s_lshl_b32 s13, s44, 13
	ds_read_b128 v[6:9], v2 offset:24576
	ds_read_b128 v[2:5], v2 offset:24640
	v_lshlrev_b32_e32 v90, 2, v12
	v_or_b32_e32 v12, 16, v10
	s_add_i32 s16, s16, s13
	s_lshl_b32 s13, s50, 15
	v_or_b32_e32 v13, s48, v12
	v_and_b32_e32 v0, 31, v0
	s_add_i32 s13, s13, s47
	v_lshlrev_b32_e32 v89, 2, v13
	v_or_b32_e32 v13, 24, v10
	v_lshlrev_b32_e32 v101, 2, v0
	s_lshl_b32 s12, s50, 12
	v_or_b32_e32 v0, s13, v99
	s_lshl_b32 s13, s50, 14
	v_or_b32_e32 v14, s48, v13
	s_add_i32 s12, s12, s51
	s_add_i32 s13, s13, s46
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_mov_b32 s22, s14
	v_lshlrev_b32_e32 v87, 2, v14
	v_lshl_or_b32 v93, v10, 9, v94
	v_lshl_or_b32 v91, v11, 9, v94
	v_lshl_add_u32 v88, v12, 9, v94
	v_lshl_add_u32 v84, v13, 9, v94
	s_add_i32 s14, s12, 0x130
	v_or_b32_e32 v102, s16, v100
	v_add_u32_e32 v103, 0x800, v0
	v_lshl_or_b32 v104, v1, 2, s13
	s_lshl3_add_u32 s17, s12, 0x900
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[12:13]
	s_add_i32 s45, s45, 0x8000
	s_addk_i32 s14, 0x100
	s_addk_i32 s17, 0x800
	v_add_u32_e32 v104, 0x400, v104
	v_add_u32_e32 v101, 0x200, v101
	v_add_u32_e32 v103, 0x800, v103
	s_cmp_lg_u32 s45, 0x78000
	v_mov_b64_e32 v[72:73], v[40:41]
	v_mov_b64_e32 v[70:71], v[38:39]
	v_mov_b64_e32 v[60:61], v[36:37]
	v_mov_b64_e32 v[58:59], v[34:35]
	v_mov_b64_e32 v[68:69], v[32:33]
	v_mov_b64_e32 v[66:67], v[30:31]
	v_mov_b64_e32 v[64:65], v[28:29]
	v_mov_b64_e32 v[62:63], v[26:27]
	v_mov_b64_e32 v[56:57], v[24:25]
	v_mov_b64_e32 v[54:55], v[22:23]
	v_mov_b64_e32 v[52:53], v[20:21]
	v_mov_b64_e32 v[50:51], v[18:19]
	v_mov_b64_e32 v[48:49], v[16:17]
	v_mov_b64_e32 v[46:47], v[14:15]
	v_mov_b64_e32 v[44:45], v[12:13]
	v_mov_b64_e32 v[42:43], v[10:11]
	v_mov_b32_e32 v106, v0
	v_mov_b32_e32 v107, v1
	v_mov_b32_e32 v108, v94
	v_mov_b32_e32 v109, v95
	v_mov_b32_e32 v110, v97
	v_mov_b32_e32 v113, v105
	s_barrier
	s_cbranch_scc0 .LBB0_13
.LBB0_5:
	s_add_i32 s12, s14, 0xfffffed1
	s_lshr_b32 s13, s12, 31
	s_add_i32 s13, s12, s13
	s_and_b32 s13, s13, 0x1ffffffe
	s_sub_i32 s12, s12, s13
	s_lshl_b32 s12, s12, 3
	s_add_i32 s13, s12, 16
	s_waitcnt vmcnt(4)
	v_bfe_u32 v157, v98, s13, 8
	s_waitcnt vmcnt(2)
	v_bfe_u32 v111, v96, s13, 8
	s_sub_i32 s13, s14, 32
	s_ashr_i32 s18, s13, 31
	s_lshr_b32 s18, s18, 27
	v_bfe_u32 v156, v98, s12, 8
	v_bfe_u32 v112, v96, s12, 8
	s_sub_i32 s12, s14, 48
	s_add_i32 s13, s13, s18
	s_lshr_b32 s13, s13, 5
	s_ashr_i32 s12, s12, 31
	s_add_i32 s13, s13, s12
	v_add_u32_e32 v0, s45, v102
	v_lshl_or_b32 v10, s13, 8, v99
	s_add_i32 s13, s16, s45
	v_add_u32_e32 v0, 0x8000, v0
	s_add_i32 s18, s13, 0x8800
	buffer_load_dwordx4 v[38:41], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[34:37], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s18, v100
	s_add_i32 s18, s13, 0x9000
	buffer_load_dwordx4 v[30:33], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[26:29], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s18, v100
	s_ashr_i32 s18, s14, 31
	s_lshr_b32 s18, s18, 27
	s_add_i32 s18, s14, s18
	buffer_load_dwordx4 v[22:25], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[18:21], v0, s[0:3], 0 offen offset:1024 nt
	buffer_load_dword v95, v104, s[4:7], 0 offen offset:1024
	buffer_load_dword v94, v104, s[4:7], 0 offen offset:1088
	buffer_load_dword v1, v104, s[4:7], 0 offen offset:1152
	s_nop 0
	buffer_load_dword v0, v104, s[4:7], 0 offen offset:1216
	s_lshr_b32 s18, s18, 5
	s_add_i32 s18, s18, s12
	v_or_b32_e32 v11, s17, v99
	v_lshl_or_b32 v12, s18, 8, v99
	buffer_load_dword v105, v103, s[8:11], 0 offen
	buffer_load_dword v98, v10, s[8:11], 0 offen
	buffer_load_dword v97, v11, s[8:11], 0 offen
	buffer_load_dword v96, v12, s[8:11], 0 offen
	s_add_i32 s13, s13, 0x9800
	v_or_b32_e32 v10, s13, v100
	buffer_load_dwordx4 v[14:17], v10, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[10:13], v10, s[0:3], 0 offen offset:1024 nt
	v_sub_u32_sdwa v134, v109, v113 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v135, 11, v134
	v_mul_lo_u32 v135, v135, s40
	v_sub_u32_e32 v136, 0x6c686080, v135
	v_and_b32_e32 v136, 0xffffff00, v136
	v_cmp_lt_i32_e32 vcc, 11, v134
	v_sub_u32_e32 v135, 0x7c787470, v135
	v_lshlrev_b32_e32 v137, 4, v70
	v_cndmask_b32_e64 v154, v136, 0, vcc
	v_cndmask_b32_e64 v155, v135, 0, vcc
	v_add_u32_e32 v134, 0x7f7f7f00, v154
	v_and_b32_e32 v158, 0x80808000, v134
	v_add_u32_e32 v134, 0x7f7f7f78, v155
	v_and_b32_e32 v159, 0x80808080, v134
	v_and_b32_e32 v134, 0x7070707, v70
	v_lshrrev_b32_e32 v135, 4, v70
	v_and_b32_e32 v135, 0x7070707, v135
	v_perm_b32 v136, v159, v158, v134
	v_perm_b32 v134, v155, v154, v134
	v_and_or_b32 v134, v136, v137, v134
	v_perm_b32 v136, v159, v158, v135
	v_perm_b32 v135, v155, v154, v135
	v_and_or_b32 v70, v136, v70, v135
	v_sub_u32_sdwa v113, v109, v113 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v150, v70, v134, s41
	v_perm_b32 v151, v70, v134, s42
	v_min_i32_e32 v70, 11, v113
	v_mul_lo_u32 v160, v70, s40
	v_and_b32_e32 v70, 0x7070707, v71
	v_lshrrev_b32_e32 v161, 4, v71
	s_waitcnt lgkmcnt(14)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[144:145], v[150:151], 0
	v_and_b32_e32 v161, 0x7070707, v161
	v_perm_b32 v162, v159, v158, v70
	v_lshlrev_b32_e32 v163, 4, v71
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[148:149], v[150:151], 0
	v_perm_b32 v70, v155, v154, v70
	v_and_or_b32 v162, v162, v163, v70
	v_perm_b32 v70, v159, v158, v161
	v_perm_b32 v161, v155, v154, v161
	v_and_or_b32 v71, v70, v71, v161
	v_perm_b32 v70, v71, v162, s41
	v_perm_b32 v71, v71, v162, s42
	v_lshlrev_b32_e32 v163, 4, v72
	v_sub_u32_e32 v161, 0x6c686080, v160
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[140:141], v[70:71], v[134:137]
	v_and_b32_e32 v161, 0xffffff00, v161
	v_sub_u32_e32 v160, 0x7c787470, v160
	v_cmp_lt_i32_e32 vcc, 11, v113
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[146:147], v[70:71], v[150:153]
	v_and_b32_e32 v70, 0x7070707, v72
	v_lshrrev_b32_e32 v71, 4, v72
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v162, v159, v158, v70
	v_perm_b32 v70, v155, v154, v70
	v_and_or_b32 v162, v162, v163, v70
	v_perm_b32 v70, v159, v158, v71
	v_perm_b32 v71, v155, v154, v71
	v_and_or_b32 v71, v70, v72, v71
	v_perm_b32 v70, v71, v162, s41
	v_perm_b32 v71, v71, v162, s42
	v_lshlrev_b32_e32 v162, 4, v73
	v_cndmask_b32_e64 v113, v161, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[132:133], v[70:71], v[134:137]
	v_cndmask_b32_e64 v160, v160, 0, vcc
	v_add_u32_e32 v161, 0x7f7f7f00, v113
	v_sub_u32_e32 v157, v108, v157
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[142:143], v[70:71], v[150:153]
	v_and_b32_e32 v70, 0x7070707, v73
	v_lshrrev_b32_e32 v71, 4, v73
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v159, v158, v70
	v_perm_b32 v70, v155, v154, v70
	v_and_or_b32 v70, v72, v162, v70
	v_perm_b32 v72, v159, v158, v71
	v_perm_b32 v71, v155, v154, v71
	v_and_or_b32 v71, v72, v73, v71
	v_perm_b32 v154, v71, v70, s41
	v_perm_b32 v155, v71, v70, s42
	v_and_b32_e32 v158, 0x80808000, v161
	v_lshlrev_b32_e32 v161, 4, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[128:129], v[154:155], v[134:137]
	s_nop 2
	v_add_u32_e32 v134, 0x7f7f7f78, v160
	v_and_b32_e32 v159, 0x80808080, v134
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[138:139], v[154:155], v[150:153]
	s_nop 2
	v_and_b32_e32 v150, 0x7070707, v58
	v_lshrrev_b32_e32 v151, 4, v58
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v159, v158, v150
	v_lshlrev_b32_e32 v153, 4, v58
	v_perm_b32 v150, v160, v113, v150
	v_and_or_b32 v152, v152, v153, v150
	v_perm_b32 v150, v159, v158, v151
	v_perm_b32 v151, v160, v113, v151
	v_and_or_b32 v58, v150, v58, v151
	v_perm_b32 v150, v58, v152, s41
	v_perm_b32 v151, v58, v152, s42
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshlrev_b32_e32 v152, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[124:125], v[150:151], v[70:73]
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[130:131], v[150:151], v[134:137]
	v_lshrrev_b32_e32 v150, 4, v59
	v_and_b32_e32 v150, 0x7070707, v150
	v_perm_b32 v151, v159, v158, v58
	v_perm_b32 v58, v160, v113, v58
	v_and_or_b32 v151, v151, v152, v58
	v_perm_b32 v58, v159, v158, v150
	v_perm_b32 v150, v160, v113, v150
	v_and_or_b32 v59, v58, v59, v150
	v_perm_b32 v58, v59, v151, s41
	v_perm_b32 v59, v59, v151, s42
	v_lshlrev_b32_e32 v151, 4, v60
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[120:121], v[58:59], v[70:73]
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[126:127], v[58:59], v[134:137]
	v_and_b32_e32 v58, 0x7070707, v60
	v_lshrrev_b32_e32 v59, 4, v60
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v150, v159, v158, v58
	v_perm_b32 v58, v160, v113, v58
	v_and_or_b32 v150, v150, v151, v58
	v_perm_b32 v58, v159, v158, v59
	v_perm_b32 v59, v160, v113, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v150, s41
	v_perm_b32 v59, v59, v150, s42
	v_lshlrev_b32_e32 v150, 4, v61
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[116:117], v[58:59], v[70:73]
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[122:123], v[58:59], v[134:137]
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v159, v158, v58
	v_perm_b32 v58, v160, v113, v58
	v_and_or_b32 v60, v60, v150, v58
	v_perm_b32 v58, v159, v158, v59
	v_perm_b32 v59, v160, v113, v59
	v_and_or_b32 v59, v58, v61, v59
	v_perm_b32 v58, v59, v60, s41
	v_perm_b32 v59, v59, v60, s42
	v_sub_u32_e32 v113, v108, v156
	v_cmp_lt_i32_e32 vcc, 11, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[114:115], v[58:59], v[70:73]
	v_lshrrev_b32_e32 v159, 4, v67
	v_and_b32_e32 v159, 0x7070707, v159
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[118:119], v[58:59], v[134:137]
	s_nop 2
	v_min_i32_e32 v134, 11, v113
	v_mul_lo_u32 v134, v134, s40
	v_sub_u32_e32 v135, 0x6c686080, v134
	v_and_b32_e32 v135, 0xffffff00, v135
	v_sub_u32_e32 v134, 0x7c787470, v134
	v_cndmask_b32_e64 v113, v135, 0, vcc
	v_cndmask_b32_e64 v154, v134, 0, vcc
	v_add_u32_e32 v134, 0x7f7f7f00, v113
	v_and_b32_e32 v155, 0x80808000, v134
	v_add_u32_e32 v134, 0x7f7f7f78, v154
	v_and_b32_e32 v156, 0x80808080, v134
	v_and_b32_e32 v134, 0x7070707, v66
	v_lshrrev_b32_e32 v135, 4, v66
	v_and_b32_e32 v135, 0x7070707, v135
	v_perm_b32 v136, v156, v155, v134
	v_lshlrev_b32_e32 v137, 4, v66
	v_perm_b32 v134, v154, v113, v134
	v_and_or_b32 v134, v136, v137, v134
	v_perm_b32 v136, v156, v155, v135
	v_perm_b32 v135, v154, v113, v135
	v_and_or_b32 v66, v136, v66, v135
	v_perm_b32 v150, v66, v134, s41
	v_perm_b32 v151, v66, v134, s42
	v_min_i32_e32 v66, 11, v157
	v_mul_lo_u32 v158, v66, s40
	v_and_b32_e32 v66, 0x7070707, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[144:145], v[150:151], 0
	v_perm_b32 v160, v156, v155, v66
	v_perm_b32 v66, v154, v113, v66
	v_and_or_b32 v160, v160, v161, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[148:149], v[150:151], 0
	v_perm_b32 v66, v156, v155, v159
	v_perm_b32 v159, v154, v113, v159
	v_and_or_b32 v67, v66, v67, v159
	v_perm_b32 v66, v67, v160, s41
	v_perm_b32 v67, v67, v160, s42
	v_lshlrev_b32_e32 v161, 4, v68
	v_sub_u32_e32 v159, 0x6c686080, v158
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[140:141], v[66:67], v[134:137]
	v_and_b32_e32 v159, 0xffffff00, v159
	v_sub_u32_e32 v158, 0x7c787470, v158
	v_cmp_lt_i32_e32 vcc, 11, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[146:147], v[66:67], v[150:153]
	v_and_b32_e32 v66, 0x7070707, v68
	v_lshrrev_b32_e32 v67, 4, v68
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v160, v156, v155, v66
	v_perm_b32 v66, v154, v113, v66
	v_and_or_b32 v160, v160, v161, v66
	v_perm_b32 v66, v156, v155, v67
	v_perm_b32 v67, v154, v113, v67
	v_and_or_b32 v67, v66, v68, v67
	v_perm_b32 v66, v67, v160, s41
	v_perm_b32 v67, v67, v160, s42
	v_lshlrev_b32_e32 v160, 4, v69
	v_cndmask_b32_e64 v157, v159, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[132:133], v[66:67], v[134:137]
	v_cndmask_b32_e64 v158, v158, 0, vcc
	v_add_u32_e32 v159, 0x7f7f7f00, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[142:143], v[66:67], v[150:153]
	v_and_b32_e32 v66, 0x7070707, v69
	v_lshrrev_b32_e32 v67, 4, v69
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v68, v156, v155, v66
	v_perm_b32 v66, v154, v113, v66
	v_and_or_b32 v66, v68, v160, v66
	v_perm_b32 v68, v156, v155, v67
	v_perm_b32 v67, v154, v113, v67
	v_and_or_b32 v67, v68, v69, v67
	v_perm_b32 v154, v67, v66, s41
	v_perm_b32 v155, v67, v66, s42
	v_and_b32_e32 v113, 0x80808000, v159
	v_lshlrev_b32_e32 v160, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[128:129], v[154:155], v[134:137]
	s_nop 2
	v_add_u32_e32 v134, 0x7f7f7f78, v158
	v_and_b32_e32 v156, 0x80808080, v134
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[138:139], v[154:155], v[150:153]
	s_nop 2
	v_and_b32_e32 v150, 0x7070707, v62
	v_lshrrev_b32_e32 v151, 4, v62
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v156, v113, v150
	v_lshlrev_b32_e32 v153, 4, v62
	v_perm_b32 v150, v158, v157, v150
	v_and_or_b32 v152, v152, v153, v150
	v_perm_b32 v150, v156, v113, v151
	v_perm_b32 v151, v158, v157, v151
	v_and_or_b32 v62, v150, v62, v151
	v_perm_b32 v150, v62, v152, s41
	v_perm_b32 v151, v62, v152, s42
	v_and_b32_e32 v62, 0x7070707, v63
	v_lshlrev_b32_e32 v152, 4, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[124:125], v[150:151], v[66:69]
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[130:131], v[150:151], v[134:137]
	v_lshrrev_b32_e32 v150, 4, v63
	v_and_b32_e32 v150, 0x7070707, v150
	v_perm_b32 v151, v156, v113, v62
	v_perm_b32 v62, v158, v157, v62
	v_and_or_b32 v151, v151, v152, v62
	v_perm_b32 v62, v156, v113, v150
	v_perm_b32 v150, v158, v157, v150
	v_and_or_b32 v63, v62, v63, v150
	v_perm_b32 v62, v63, v151, s41
	v_perm_b32 v63, v63, v151, s42
	v_lshlrev_b32_e32 v151, 4, v64
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[120:121], v[62:63], v[66:69]
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[126:127], v[62:63], v[134:137]
	v_and_b32_e32 v62, 0x7070707, v64
	v_lshrrev_b32_e32 v63, 4, v64
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v150, v156, v113, v62
	v_perm_b32 v62, v158, v157, v62
	v_and_or_b32 v150, v150, v151, v62
	v_perm_b32 v62, v156, v113, v63
	v_perm_b32 v63, v158, v157, v63
	v_and_or_b32 v63, v62, v64, v63
	v_perm_b32 v62, v63, v150, s41
	v_perm_b32 v63, v63, v150, s42
	v_lshlrev_b32_e32 v150, 4, v65
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[116:117], v[62:63], v[66:69]
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[122:123], v[62:63], v[134:137]
	v_and_b32_e32 v62, 0x7070707, v65
	v_lshrrev_b32_e32 v63, 4, v65
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v156, v113, v62
	v_perm_b32 v62, v158, v157, v62
	v_and_or_b32 v64, v64, v150, v62
	v_perm_b32 v62, v156, v113, v63
	v_perm_b32 v63, v158, v157, v63
	v_and_or_b32 v63, v62, v65, v63
	v_perm_b32 v62, v63, v64, s41
	v_perm_b32 v63, v63, v64, s42
	v_sub_u32_sdwa v113, v107, v110 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_cmp_lt_i32_e32 vcc, 11, v113
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[114:115], v[62:63], v[66:69]
	v_sub_u32_sdwa v110, v107, v110 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshrrev_b32_e32 v158, 4, v55
	v_and_b32_e32 v158, 0x7070707, v158
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[118:119], v[62:63], v[134:137]
	s_nop 2
	v_min_i32_e32 v134, 11, v113
	v_mul_lo_u32 v134, v134, s40
	v_sub_u32_e32 v135, 0x6c686080, v134
	v_and_b32_e32 v135, 0xffffff00, v135
	v_sub_u32_e32 v134, 0x7c787470, v134
	v_cndmask_b32_e64 v113, v135, 0, vcc
	v_cndmask_b32_e64 v154, v134, 0, vcc
	v_add_u32_e32 v134, 0x7f7f7f00, v113
	v_and_b32_e32 v155, 0x80808000, v134
	v_add_u32_e32 v134, 0x7f7f7f78, v154
	v_and_b32_e32 v156, 0x80808080, v134
	v_and_b32_e32 v134, 0x7070707, v54
	v_lshrrev_b32_e32 v135, 4, v54
	v_and_b32_e32 v135, 0x7070707, v135
	v_perm_b32 v136, v156, v155, v134
	v_lshlrev_b32_e32 v137, 4, v54
	v_perm_b32 v134, v154, v113, v134
	v_and_or_b32 v134, v136, v137, v134
	v_perm_b32 v136, v156, v155, v135
	v_perm_b32 v135, v154, v113, v135
	v_and_or_b32 v54, v136, v54, v135
	v_perm_b32 v150, v54, v134, s41
	v_perm_b32 v151, v54, v134, s42
	v_min_i32_e32 v54, 11, v110
	v_mul_lo_u32 v157, v54, s40
	v_and_b32_e32 v54, 0x7070707, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[144:145], v[150:151], 0
	v_perm_b32 v159, v156, v155, v54
	v_perm_b32 v54, v154, v113, v54
	v_and_or_b32 v159, v159, v160, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[148:149], v[150:151], 0
	v_perm_b32 v54, v156, v155, v158
	v_perm_b32 v158, v154, v113, v158
	v_and_or_b32 v55, v54, v55, v158
	v_perm_b32 v54, v55, v159, s41
	v_perm_b32 v55, v55, v159, s42
	v_lshlrev_b32_e32 v160, 4, v56
	v_sub_u32_e32 v158, 0x6c686080, v157
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[140:141], v[54:55], v[134:137]
	v_and_b32_e32 v158, 0xffffff00, v158
	v_sub_u32_e32 v157, 0x7c787470, v157
	v_cmp_lt_i32_e32 vcc, 11, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[146:147], v[54:55], v[150:153]
	v_and_b32_e32 v54, 0x7070707, v56
	v_lshrrev_b32_e32 v55, 4, v56
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v159, v156, v155, v54
	v_perm_b32 v54, v154, v113, v54
	v_and_or_b32 v159, v159, v160, v54
	v_perm_b32 v54, v156, v155, v55
	v_perm_b32 v55, v154, v113, v55
	v_and_or_b32 v55, v54, v56, v55
	v_perm_b32 v54, v55, v159, s41
	v_perm_b32 v55, v55, v159, s42
	v_lshlrev_b32_e32 v159, 4, v57
	v_cndmask_b32_e64 v110, v158, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[132:133], v[54:55], v[134:137]
	v_cndmask_b32_e64 v157, v157, 0, vcc
	v_add_u32_e32 v158, 0x7f7f7f00, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[150:153], v[142:143], v[54:55], v[150:153]
	v_and_b32_e32 v54, 0x7070707, v57
	v_lshrrev_b32_e32 v55, 4, v57
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v56, v156, v155, v54
	v_perm_b32 v54, v154, v113, v54
	v_and_or_b32 v54, v56, v159, v54
	v_perm_b32 v56, v156, v155, v55
	v_perm_b32 v55, v154, v113, v55
	v_and_or_b32 v55, v56, v57, v55
	v_perm_b32 v154, v55, v54, s41
	v_perm_b32 v155, v55, v54, s42
	v_and_b32_e32 v113, 0x80808000, v158
	s_waitcnt vmcnt(17)
	v_lshlrev_b32_e32 v158, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[128:129], v[154:155], v[134:137]
	s_nop 2
	v_add_u32_e32 v134, 0x7f7f7f78, v157
	v_and_b32_e32 v156, 0x80808080, v134
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[138:139], v[154:155], v[150:153]
	v_sub_u32_e32 v154, v106, v111
	s_nop 1
	v_and_b32_e32 v150, 0x7070707, v50
	v_lshrrev_b32_e32 v151, 4, v50
	v_and_b32_e32 v151, 0x7070707, v151
	v_perm_b32 v152, v156, v113, v150
	v_lshlrev_b32_e32 v153, 4, v50
	v_perm_b32 v150, v157, v110, v150
	v_and_or_b32 v152, v152, v153, v150
	v_perm_b32 v150, v156, v113, v151
	v_perm_b32 v151, v157, v110, v151
	v_and_or_b32 v50, v150, v50, v151
	v_perm_b32 v150, v50, v152, s41
	v_perm_b32 v151, v50, v152, s42
	v_and_b32_e32 v50, 0x7070707, v51
	v_lshlrev_b32_e32 v152, 4, v51
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[124:125], v[150:151], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[130:131], v[150:151], v[134:137]
	v_lshrrev_b32_e32 v150, 4, v51
	v_and_b32_e32 v150, 0x7070707, v150
	v_perm_b32 v151, v156, v113, v50
	v_perm_b32 v50, v157, v110, v50
	v_and_or_b32 v151, v151, v152, v50
	v_perm_b32 v50, v156, v113, v150
	v_perm_b32 v150, v157, v110, v150
	v_and_or_b32 v51, v50, v51, v150
	v_perm_b32 v50, v51, v151, s41
	v_perm_b32 v51, v51, v151, s42
	v_lshlrev_b32_e32 v151, 4, v52
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[120:121], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[126:127], v[50:51], v[134:137]
	v_and_b32_e32 v50, 0x7070707, v52
	v_lshrrev_b32_e32 v51, 4, v52
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v150, v156, v113, v50
	v_perm_b32 v50, v157, v110, v50
	v_and_or_b32 v150, v150, v151, v50
	v_perm_b32 v50, v156, v113, v51
	v_perm_b32 v51, v157, v110, v51
	v_and_or_b32 v51, v50, v52, v51
	v_perm_b32 v50, v51, v150, s41
	v_perm_b32 v51, v51, v150, s42
	v_lshlrev_b32_e32 v150, 4, v53
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[116:117], v[50:51], v[54:57]
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[122:123], v[50:51], v[134:137]
	v_and_b32_e32 v50, 0x7070707, v53
	v_lshrrev_b32_e32 v51, 4, v53
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v156, v113, v50
	v_perm_b32 v50, v157, v110, v50
	v_and_or_b32 v52, v52, v150, v50
	v_perm_b32 v50, v156, v113, v51
	v_perm_b32 v51, v157, v110, v51
	v_sub_u32_e32 v110, v106, v112
	v_min_i32_e32 v112, 11, v110
	v_mul_lo_u32 v112, v112, s40
	v_sub_u32_e32 v113, 0x6c686080, v112
	v_and_b32_e32 v113, 0xffffff00, v113
	v_cmp_lt_i32_e32 vcc, 11, v110
	v_sub_u32_e32 v112, 0x7c787470, v112
	v_and_or_b32 v51, v50, v53, v51
	v_cndmask_b32_e64 v150, v113, 0, vcc
	v_cndmask_b32_e64 v151, v112, 0, vcc
	v_add_u32_e32 v110, 0x7f7f7f00, v150
	v_and_b32_e32 v152, 0x80808000, v110
	v_add_u32_e32 v110, 0x7f7f7f78, v151
	v_perm_b32 v50, v51, v52, s41
	v_perm_b32 v51, v51, v52, s42
	v_and_b32_e32 v153, 0x80808080, v110
	v_and_b32_e32 v110, 0x7070707, v46
	v_lshrrev_b32_e32 v112, 4, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[114:115], v[50:51], v[54:57]
	v_and_b32_e32 v112, 0x7070707, v112
	v_perm_b32 v113, v153, v152, v110
	v_perm_b32 v110, v151, v150, v110
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[118:119], v[50:51], v[134:137]
	v_lshrrev_b32_e32 v156, 4, v47
	v_and_b32_e32 v156, 0x7070707, v156
	v_cmp_lt_i32_e32 vcc, 11, v154
	v_lshlrev_b32_e32 v134, 4, v46
	v_and_or_b32 v110, v113, v134, v110
	v_perm_b32 v113, v153, v152, v112
	v_perm_b32 v112, v151, v150, v112
	v_and_or_b32 v46, v113, v46, v112
	v_perm_b32 v112, v46, v110, s41
	v_perm_b32 v113, v46, v110, s42
	v_min_i32_e32 v46, 11, v154
	v_mul_lo_u32 v155, v46, s40
	v_and_b32_e32 v46, 0x7070707, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[144:145], v[112:113], 0
	v_perm_b32 v157, v153, v152, v46
	v_perm_b32 v46, v151, v150, v46
	v_and_or_b32 v157, v157, v158, v46
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[148:149], v[112:113], 0
	v_perm_b32 v46, v153, v152, v156
	v_perm_b32 v156, v151, v150, v156
	v_and_or_b32 v47, v46, v47, v156
	v_perm_b32 v46, v47, v157, s41
	v_perm_b32 v47, v47, v157, s42
	v_lshlrev_b32_e32 v158, 4, v48
	v_sub_u32_e32 v156, 0x6c686080, v155
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[140:141], v[46:47], v[134:137]
	v_and_b32_e32 v156, 0xffffff00, v156
	v_sub_u32_e32 v155, 0x7c787470, v155
	v_cndmask_b32_e64 v154, v156, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[146:147], v[46:47], v[110:113]
	v_and_b32_e32 v46, 0x7070707, v48
	v_lshrrev_b32_e32 v47, 4, v48
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v157, v153, v152, v46
	v_perm_b32 v46, v151, v150, v46
	v_and_or_b32 v157, v157, v158, v46
	v_perm_b32 v46, v153, v152, v47
	v_perm_b32 v47, v151, v150, v47
	v_and_or_b32 v47, v46, v48, v47
	v_perm_b32 v46, v47, v157, s41
	v_perm_b32 v47, v47, v157, s42
	v_lshlrev_b32_e32 v157, 4, v49
	v_cndmask_b32_e64 v155, v155, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[134:137], v[132:133], v[46:47], v[134:137]
	v_add_u32_e32 v156, 0x7f7f7f00, v154
	v_cmp_lt_i32_e32 vcc, 5, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[142:143], v[46:47], v[110:113]
	v_and_b32_e32 v46, 0x7070707, v49
	v_lshrrev_b32_e32 v47, 4, v49
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v153, v152, v46
	v_perm_b32 v46, v151, v150, v46
	v_and_or_b32 v46, v48, v157, v46
	v_perm_b32 v48, v153, v152, v47
	v_perm_b32 v47, v151, v150, v47
	v_and_or_b32 v47, v48, v49, v47
	v_perm_b32 v150, v47, v46, s41
	v_perm_b32 v151, v47, v46, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[128:129], v[150:151], v[134:137]
	s_nop 2
	v_add_u32_e32 v134, 0x7f7f7f78, v155
	v_and_b32_e32 v136, 0x80808000, v156
	v_and_b32_e32 v137, 0x80808080, v134
	s_waitcnt vmcnt(16)
	v_and_b32_e32 v134, 0x7070707, v42
	v_lshrrev_b32_e32 v135, 4, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[138:139], v[150:151], v[110:113]
	v_and_b32_e32 v135, 0x7070707, v135
	v_perm_b32 v150, v137, v136, v134
	v_lshlrev_b32_e32 v151, 4, v42
	v_perm_b32 v134, v155, v154, v134
	v_and_or_b32 v150, v150, v151, v134
	v_perm_b32 v134, v137, v136, v135
	v_perm_b32 v135, v155, v154, v135
	v_and_or_b32 v42, v134, v42, v135
	v_perm_b32 v134, v42, v150, s41
	v_perm_b32 v135, v42, v150, s42
	v_and_b32_e32 v42, 0x7070707, v43
	v_lshlrev_b32_e32 v150, 4, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[124:125], v[134:135], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[130:131], v[134:135], v[110:113]
	v_lshrrev_b32_e32 v134, 4, v43
	v_and_b32_e32 v134, 0x7070707, v134
	v_perm_b32 v135, v137, v136, v42
	v_perm_b32 v42, v155, v154, v42
	v_and_or_b32 v135, v135, v150, v42
	v_perm_b32 v42, v137, v136, v134
	v_perm_b32 v134, v155, v154, v134
	v_and_or_b32 v43, v42, v43, v134
	v_perm_b32 v42, v43, v135, s41
	v_perm_b32 v43, v43, v135, s42
	v_lshlrev_b32_e32 v135, 4, v44
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[120:121], v[42:43], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[126:127], v[42:43], v[110:113]
	v_and_b32_e32 v42, 0x7070707, v44
	v_lshrrev_b32_e32 v43, 4, v44
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v134, v137, v136, v42
	v_perm_b32 v42, v155, v154, v42
	v_and_or_b32 v134, v134, v135, v42
	v_perm_b32 v42, v137, v136, v43
	v_perm_b32 v43, v155, v154, v43
	v_and_or_b32 v43, v42, v44, v43
	v_perm_b32 v42, v43, v134, s41
	v_perm_b32 v43, v43, v134, s42
	v_lshlrev_b32_e32 v134, 4, v45
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[116:117], v[42:43], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[110:113], v[122:123], v[42:43], v[110:113]
	v_and_b32_e32 v42, 0x7070707, v45
	v_lshrrev_b32_e32 v43, 4, v45
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v137, v136, v42
	v_perm_b32 v42, v155, v154, v42
	v_and_or_b32 v44, v44, v134, v42
	v_perm_b32 v42, v137, v136, v43
	v_perm_b32 v43, v155, v154, v43
	v_and_or_b32 v43, v42, v45, v43
	v_perm_b32 v42, v43, v44, s41
	v_perm_b32 v43, v43, v44, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[114:115], v[42:43], v[46:49]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[118:119], v[42:43], v[110:113]
	s_nop 2
	v_add_u32_e32 v111, 17, v109
	v_lshl_add_u32 v110, v109, 23, v86
	v_lshlrev_b32_e64 v111, v111, 1
	v_cndmask_b32_e32 v110, v111, v110, vcc
	v_add_u32_e32 v111, 17, v108
	v_lshl_add_u32 v109, v108, 23, v86
	v_lshlrev_b32_e64 v111, v111, 1
	v_cmp_lt_i32_e32 vcc, 5, v108
	s_nop 1
	v_cndmask_b32_e32 v108, v111, v109, vcc
	v_add_u32_e32 v111, 17, v107
	v_lshl_add_u32 v109, v107, 23, v86
	v_lshlrev_b32_e64 v111, v111, 1
	v_cmp_lt_i32_e32 vcc, 5, v107
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[136:137], v[8:9], v[110:111] op_sel_hi:[1,0]
	v_lshl_add_u32 v107, v106, 23, v86
	v_cndmask_b32_e32 v112, v111, v109, vcc
	v_add_u32_e32 v109, 17, v106
	v_pk_mul_f32 v[72:73], v[136:137], v[72:73]
	v_lshlrev_b32_e64 v109, v109, 1
	v_cmp_lt_i32_e32 vcc, 5, v106
	v_pk_mul_f32 v[72:73], v[72:73], v[80:81]
	v_pk_mul_f32 v[134:135], v[6:7], v[110:111] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v106, v109, v107, vcc
	v_bfe_u32 v107, v73, 16, 1
	v_add3_u32 v107, v107, v73, s43
	v_or_b32_e32 v109, 0x400000, v73
	v_cmp_u_f32_e32 vcc, v73, v73
	v_pk_mul_f32 v[70:71], v[134:135], v[70:71]
	s_nop 0
	v_cndmask_b32_e32 v73, v107, v109, vcc
	v_bfe_u32 v107, v72, 16, 1
	v_pk_mul_f32 v[70:71], v[70:71], v[78:79]
	v_add3_u32 v107, v107, v72, s43
	v_or_b32_e32 v109, 0x400000, v72
	v_cmp_u_f32_e32 vcc, v72, v72
	s_nop 1
	v_cndmask_b32_e32 v72, v107, v109, vcc
	v_bfe_u32 v107, v71, 16, 1
	v_add3_u32 v107, v107, v71, s43
	v_or_b32_e32 v109, 0x400000, v71
	v_cmp_u_f32_e32 vcc, v71, v71
	s_nop 1
	v_cndmask_b32_e32 v71, v107, v109, vcc
	v_bfe_u32 v107, v70, 16, 1
	v_add3_u32 v107, v107, v70, s43
	v_or_b32_e32 v109, 0x400000, v70
	v_cmp_u_f32_e32 vcc, v70, v70
	s_nop 1
	v_cndmask_b32_e32 v70, v107, v109, vcc
	ds_write_b16_d16_hi v85, v70
	ds_write_b16_d16_hi v83, v71 offset:512
	ds_write_b16_d16_hi v83, v72 offset:1024
	ds_write_b16_d16_hi v83, v73 offset:1536
	v_pk_mul_f32 v[72:73], v[8:9], v[108:109] op_sel_hi:[1,0]
	v_pk_mul_f32 v[70:71], v[6:7], v[108:109] op_sel_hi:[1,0]
	v_pk_mul_f32 v[68:69], v[72:73], v[68:69]
	v_pk_mul_f32 v[66:67], v[70:71], v[66:67]
	v_pk_mul_f32 v[68:69], v[68:69], v[80:81]
	v_pk_mul_f32 v[66:67], v[66:67], v[78:79]
	v_bfe_u32 v70, v69, 16, 1
	v_add3_u32 v70, v70, v69, s43
	v_or_b32_e32 v71, 0x400000, v69
	v_cmp_u_f32_e32 vcc, v69, v69
	s_nop 1
	v_cndmask_b32_e32 v69, v70, v71, vcc
	v_bfe_u32 v70, v68, 16, 1
	v_add3_u32 v70, v70, v68, s43
	v_or_b32_e32 v71, 0x400000, v68
	v_cmp_u_f32_e32 vcc, v68, v68
	s_nop 1
	v_cndmask_b32_e32 v68, v70, v71, vcc
	v_bfe_u32 v70, v67, 16, 1
	v_add3_u32 v70, v70, v67, s43
	v_or_b32_e32 v71, 0x400000, v67
	v_cmp_u_f32_e32 vcc, v67, v67
	s_nop 1
	v_cndmask_b32_e32 v67, v70, v71, vcc
	v_bfe_u32 v70, v66, 16, 1
	v_add3_u32 v70, v70, v66, s43
	v_or_b32_e32 v71, 0x400000, v66
	v_cmp_u_f32_e32 vcc, v66, v66
	s_nop 1
	v_cndmask_b32_e32 v66, v70, v71, vcc
	ds_write_b16_d16_hi v83, v66 offset:32
	ds_write_b16_d16_hi v83, v67 offset:544
	ds_write_b16_d16_hi v83, v68 offset:1056
	ds_write_b16_d16_hi v83, v69 offset:1568
	v_pk_mul_f32 v[68:69], v[8:9], v[112:113] op_sel_hi:[1,0]
	v_pk_mul_f32 v[66:67], v[6:7], v[112:113] op_sel_hi:[1,0]
	v_pk_mul_f32 v[56:57], v[68:69], v[56:57]
	v_pk_mul_f32 v[54:55], v[66:67], v[54:55]
	v_pk_mul_f32 v[56:57], v[56:57], v[80:81]
	v_pk_mul_f32 v[54:55], v[54:55], v[78:79]
	v_bfe_u32 v66, v57, 16, 1
	v_add3_u32 v66, v66, v57, s43
	v_or_b32_e32 v67, 0x400000, v57
	v_cmp_u_f32_e32 vcc, v57, v57
	s_nop 1
	v_cndmask_b32_e32 v57, v66, v67, vcc
	v_bfe_u32 v66, v56, 16, 1
	v_add3_u32 v66, v66, v56, s43
	v_or_b32_e32 v67, 0x400000, v56
	v_cmp_u_f32_e32 vcc, v56, v56
	s_nop 1
	v_cndmask_b32_e32 v56, v66, v67, vcc
	v_bfe_u32 v66, v55, 16, 1
	v_add3_u32 v66, v66, v55, s43
	v_or_b32_e32 v67, 0x400000, v55
	v_cmp_u_f32_e32 vcc, v55, v55
	s_nop 1
	v_cndmask_b32_e32 v55, v66, v67, vcc
	v_bfe_u32 v66, v54, 16, 1
	v_add3_u32 v66, v66, v54, s43
	v_or_b32_e32 v67, 0x400000, v54
	v_cmp_u_f32_e32 vcc, v54, v54
	s_nop 1
	v_cndmask_b32_e32 v54, v66, v67, vcc
	ds_write_b16_d16_hi v83, v54 offset:64
	ds_write_b16_d16_hi v83, v55 offset:576
	ds_write_b16_d16_hi v83, v56 offset:1088
	ds_write_b16_d16_hi v83, v57 offset:1600
	v_pk_mul_f32 v[56:57], v[8:9], v[106:107] op_sel_hi:[1,0]
	v_pk_mul_f32 v[54:55], v[6:7], v[106:107] op_sel_hi:[1,0]
	v_pk_mul_f32 v[48:49], v[56:57], v[48:49]
	v_pk_mul_f32 v[46:47], v[54:55], v[46:47]
	v_pk_mul_f32 v[48:49], v[48:49], v[80:81]
	v_pk_mul_f32 v[46:47], v[46:47], v[78:79]
	v_bfe_u32 v54, v49, 16, 1
	v_add3_u32 v54, v54, v49, s43
	v_or_b32_e32 v55, 0x400000, v49
	v_cmp_u_f32_e32 vcc, v49, v49
	s_nop 1
	v_cndmask_b32_e32 v49, v54, v55, vcc
	v_bfe_u32 v54, v48, 16, 1
	v_add3_u32 v54, v54, v48, s43
	v_or_b32_e32 v55, 0x400000, v48
	v_cmp_u_f32_e32 vcc, v48, v48
	s_nop 1
	v_cndmask_b32_e32 v48, v54, v55, vcc
	v_bfe_u32 v54, v47, 16, 1
	v_add3_u32 v54, v54, v47, s43
	v_or_b32_e32 v55, 0x400000, v47
	v_cmp_u_f32_e32 vcc, v47, v47
	s_nop 1
	v_cndmask_b32_e32 v47, v54, v55, vcc
	v_bfe_u32 v54, v46, 16, 1
	v_add3_u32 v54, v54, v46, s43
	v_or_b32_e32 v55, 0x400000, v46
	v_cmp_u_f32_e32 vcc, v46, v46
	s_nop 1
	v_cndmask_b32_e32 v46, v54, v55, vcc
	ds_write_b16_d16_hi v83, v46 offset:96
	ds_write_b16_d16_hi v83, v47 offset:608
	ds_write_b16_d16_hi v83, v48 offset:1120
	ds_write_b16_d16_hi v83, v49 offset:1632
	s_waitcnt lgkmcnt(14)
	v_pk_mul_f32 v[48:49], v[4:5], v[110:111] op_sel_hi:[1,0]
	v_pk_mul_f32 v[46:47], v[2:3], v[110:111] op_sel_hi:[1,0]
	v_pk_mul_f32 v[48:49], v[48:49], v[60:61]
	v_pk_mul_f32 v[46:47], v[46:47], v[58:59]
	v_pk_mul_f32 v[48:49], v[48:49], v[76:77]
	v_pk_mul_f32 v[46:47], v[46:47], v[74:75]
	v_bfe_u32 v54, v49, 16, 1
	v_add3_u32 v54, v54, v49, s43
	v_or_b32_e32 v55, 0x400000, v49
	v_cmp_u_f32_e32 vcc, v49, v49
	s_nop 1
	v_cndmask_b32_e32 v49, v54, v55, vcc
	v_bfe_u32 v54, v48, 16, 1
	v_add3_u32 v54, v54, v48, s43
	v_or_b32_e32 v55, 0x400000, v48
	v_cmp_u_f32_e32 vcc, v48, v48
	s_nop 1
	v_cndmask_b32_e32 v48, v54, v55, vcc
	v_bfe_u32 v54, v47, 16, 1
	v_add3_u32 v54, v54, v47, s43
	v_or_b32_e32 v55, 0x400000, v47
	v_cmp_u_f32_e32 vcc, v47, v47
	s_nop 1
	v_cndmask_b32_e32 v47, v54, v55, vcc
	v_bfe_u32 v54, v46, 16, 1
	v_add3_u32 v54, v54, v46, s43
	v_or_b32_e32 v55, 0x400000, v46
	v_cmp_u_f32_e32 vcc, v46, v46
	s_nop 1
	v_cndmask_b32_e32 v46, v54, v55, vcc
	ds_write_b16_d16_hi v83, v46 offset:8192
	ds_write_b16_d16_hi v83, v47 offset:8704
	ds_write_b16_d16_hi v83, v48 offset:9216
	ds_write_b16_d16_hi v83, v49 offset:9728
	v_pk_mul_f32 v[48:49], v[4:5], v[108:109] op_sel_hi:[1,0]
	v_pk_mul_f32 v[46:47], v[2:3], v[108:109] op_sel_hi:[1,0]
	v_pk_mul_f32 v[48:49], v[48:49], v[64:65]
	v_pk_mul_f32 v[46:47], v[46:47], v[62:63]
	v_pk_mul_f32 v[48:49], v[48:49], v[76:77]
	v_pk_mul_f32 v[46:47], v[46:47], v[74:75]
	v_bfe_u32 v54, v49, 16, 1
	v_add3_u32 v54, v54, v49, s43
	v_or_b32_e32 v55, 0x400000, v49
	v_cmp_u_f32_e32 vcc, v49, v49
	s_nop 1
	v_cndmask_b32_e32 v49, v54, v55, vcc
	v_bfe_u32 v54, v48, 16, 1
	v_add3_u32 v54, v54, v48, s43
	v_or_b32_e32 v55, 0x400000, v48
	v_cmp_u_f32_e32 vcc, v48, v48
	s_nop 1
	v_cndmask_b32_e32 v48, v54, v55, vcc
	v_bfe_u32 v54, v47, 16, 1
	v_add3_u32 v54, v54, v47, s43
	v_or_b32_e32 v55, 0x400000, v47
	v_cmp_u_f32_e32 vcc, v47, v47
	s_nop 1
	v_cndmask_b32_e32 v47, v54, v55, vcc
	v_bfe_u32 v54, v46, 16, 1
	v_add3_u32 v54, v54, v46, s43
	v_or_b32_e32 v55, 0x400000, v46
	v_cmp_u_f32_e32 vcc, v46, v46
	s_nop 1
	v_cndmask_b32_e32 v46, v54, v55, vcc
	ds_write_b16_d16_hi v83, v46 offset:8224
	ds_write_b16_d16_hi v83, v47 offset:8736
	ds_write_b16_d16_hi v83, v48 offset:9248
	ds_write_b16_d16_hi v83, v49 offset:9760
	v_pk_mul_f32 v[48:49], v[4:5], v[112:113] op_sel_hi:[1,0]
	v_pk_mul_f32 v[46:47], v[2:3], v[112:113] op_sel_hi:[1,0]
	v_pk_mul_f32 v[48:49], v[48:49], v[52:53]
	v_pk_mul_f32 v[46:47], v[46:47], v[50:51]
	v_pk_mul_f32 v[48:49], v[48:49], v[76:77]
	v_pk_mul_f32 v[46:47], v[46:47], v[74:75]
	v_bfe_u32 v50, v49, 16, 1
	v_add3_u32 v50, v50, v49, s43
	v_or_b32_e32 v51, 0x400000, v49
	v_cmp_u_f32_e32 vcc, v49, v49
	s_nop 1
	v_cndmask_b32_e32 v49, v50, v51, vcc
	v_bfe_u32 v50, v48, 16, 1
	v_add3_u32 v50, v50, v48, s43
	v_or_b32_e32 v51, 0x400000, v48
	v_cmp_u_f32_e32 vcc, v48, v48
	s_nop 1
	v_cndmask_b32_e32 v48, v50, v51, vcc
	v_bfe_u32 v50, v47, 16, 1
	v_add3_u32 v50, v50, v47, s43
	v_or_b32_e32 v51, 0x400000, v47
	v_cmp_u_f32_e32 vcc, v47, v47
	s_nop 1
	v_cndmask_b32_e32 v47, v50, v51, vcc
	v_bfe_u32 v50, v46, 16, 1
	v_add3_u32 v50, v50, v46, s43
	v_or_b32_e32 v51, 0x400000, v46
	v_cmp_u_f32_e32 vcc, v46, v46
	s_nop 1
	v_cndmask_b32_e32 v46, v50, v51, vcc
	ds_write_b16_d16_hi v83, v46 offset:8256
	ds_write_b16_d16_hi v83, v47 offset:8768
	ds_write_b16_d16_hi v83, v48 offset:9280
	ds_write_b16_d16_hi v83, v49 offset:9792
	v_pk_mul_f32 v[48:49], v[4:5], v[106:107] op_sel_hi:[1,0]
	v_pk_mul_f32 v[46:47], v[2:3], v[106:107] op_sel_hi:[1,0]
	v_pk_mul_f32 v[44:45], v[48:49], v[44:45]
	v_pk_mul_f32 v[42:43], v[46:47], v[42:43]
	v_pk_mul_f32 v[44:45], v[44:45], v[76:77]
	v_pk_mul_f32 v[42:43], v[42:43], v[74:75]
	v_bfe_u32 v46, v45, 16, 1
	v_add3_u32 v46, v46, v45, s43
	v_or_b32_e32 v47, 0x400000, v45
	v_cmp_u_f32_e32 vcc, v45, v45
	s_nop 1
	v_cndmask_b32_e32 v45, v46, v47, vcc
	v_bfe_u32 v46, v44, 16, 1
	v_add3_u32 v46, v46, v44, s43
	v_or_b32_e32 v47, 0x400000, v44
	v_cmp_u_f32_e32 vcc, v44, v44
	s_nop 1
	v_cndmask_b32_e32 v44, v46, v47, vcc
	v_bfe_u32 v46, v43, 16, 1
	v_add3_u32 v46, v46, v43, s43
	v_or_b32_e32 v47, 0x400000, v43
	v_cmp_u_f32_e32 vcc, v43, v43
	s_nop 1
	v_cndmask_b32_e32 v43, v46, v47, vcc
	v_bfe_u32 v46, v42, 16, 1
	v_add3_u32 v46, v46, v42, s43
	v_or_b32_e32 v47, 0x400000, v42
	v_cmp_u_f32_e32 vcc, v42, v42
	s_nop 1
	v_cndmask_b32_e32 v42, v46, v47, vcc
	ds_write_b16_d16_hi v83, v42 offset:8288
	ds_write_b16_d16_hi v83, v43 offset:8800
	ds_write_b16_d16_hi v83, v44 offset:9312
	ds_write_b16_d16_hi v83, v45 offset:9824
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v42, v92, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v43, 0xffffff, v42
	v_cmp_gt_i32_e32 vcc, s33, v43
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_7
	v_add_u32_e32 v44, v93, v82
	ds_read_b32 v45, v44
	v_lshl_add_u32 v42, v42, 13, v101
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshl_add_u64 v[42:43], s[34:35], 0, v[42:43]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off
	ds_read_b32 v45, v44 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:128
	ds_read_b32 v45, v44 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:256
	ds_read_b32 v44, v44 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v44, off offset:384
.LBB0_7:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v42, v90, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v43, 0xffffff, v42
	v_cmp_gt_i32_e32 vcc, s33, v43
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_9
	v_add_u32_e32 v44, v91, v82
	ds_read_b32 v45, v44
	v_lshl_add_u32 v42, v42, 13, v101
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshl_add_u64 v[42:43], s[34:35], 0, v[42:43]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off
	ds_read_b32 v45, v44 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:128
	ds_read_b32 v45, v44 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:256
	ds_read_b32 v44, v44 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v44, off offset:384
.LBB0_9:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v42, v89, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v43, 0xffffff, v42
	v_cmp_gt_i32_e32 vcc, s33, v43
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_11
	v_add_u32_e32 v44, v88, v82
	ds_read_b32 v45, v44
	v_lshl_add_u32 v42, v42, 13, v101
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshl_add_u64 v[42:43], s[34:35], 0, v[42:43]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off
	ds_read_b32 v45, v44 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:128
	ds_read_b32 v45, v44 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:256
	ds_read_b32 v44, v44 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v44, off offset:384
.LBB0_11:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v42, v87, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v43, 0xffffff, v42
	v_cmp_gt_i32_e32 vcc, s33, v43
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_4
	v_add_u32_e32 v44, v84, v82
	ds_read_b32 v45, v44
	v_lshl_add_u32 v42, v42, 13, v101
	v_ashrrev_i32_e32 v43, 31, v42
	v_lshl_add_u64 v[42:43], s[34:35], 0, v[42:43]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off
	ds_read_b32 v45, v44 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:128
	ds_read_b32 v45, v44 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v45, off offset:256
	ds_read_b32 v44, v44 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[42:43], v44, off offset:384
	s_branch .LBB0_4
.LBB0_13:
	v_sub_u32_sdwa v42, v95, v105 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v43, 11, v42
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v43, v43, s2
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	v_lshlrev_b32_e32 v45, 4, v38
	v_cndmask_b32_e64 v50, v44, 0, vcc
	v_cndmask_b32_e64 v51, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v50
	v_and_b32_e32 v52, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v51
	v_and_b32_e32 v53, 0x80808080, v42
	v_and_b32_e32 v42, 0x7070707, v38
	v_lshrrev_b32_e32 v43, 4, v38
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v53, v52, v42
	v_perm_b32 v42, v51, v50, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v53, v52, v43
	v_perm_b32 v43, v51, v50, v43
	v_and_or_b32 v38, v44, v38, v43
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_sub_u32_sdwa v54, v95, v105 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v46, v38, v42, s0
	v_perm_b32 v47, v38, v42, s1
	v_min_i32_e32 v38, 11, v54
	v_mul_lo_u32 v55, v38, s2
	v_and_b32_e32 v38, 0x7070707, v39
	v_lshrrev_b32_e32 v56, 4, v39
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[144:145], v[46:47], 0
	v_and_b32_e32 v56, 0x7070707, v56
	v_perm_b32 v57, v53, v52, v38
	v_lshlrev_b32_e32 v58, 4, v39
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[148:149], v[46:47], 0
	v_perm_b32 v38, v51, v50, v38
	v_and_or_b32 v57, v57, v58, v38
	v_perm_b32 v38, v53, v52, v56
	v_perm_b32 v56, v51, v50, v56
	v_and_or_b32 v39, v38, v39, v56
	v_perm_b32 v38, v39, v57, s0
	v_perm_b32 v39, v39, v57, s1
	v_lshlrev_b32_e32 v58, 4, v40
	v_sub_u32_e32 v56, 0x6c686080, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[140:141], v[38:39], v[42:45]
	v_and_b32_e32 v56, 0xffffff00, v56
	v_sub_u32_e32 v55, 0x7c787470, v55
	v_cmp_lt_i32_e32 vcc, 11, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[146:147], v[38:39], v[46:49]
	v_and_b32_e32 v38, 0x7070707, v40
	v_lshrrev_b32_e32 v39, 4, v40
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v57, v53, v52, v38
	v_perm_b32 v38, v51, v50, v38
	v_and_or_b32 v57, v57, v58, v38
	v_perm_b32 v38, v53, v52, v39
	v_perm_b32 v39, v51, v50, v39
	v_and_or_b32 v39, v38, v40, v39
	v_perm_b32 v38, v39, v57, s0
	v_perm_b32 v39, v39, v57, s1
	v_lshlrev_b32_e32 v57, 4, v41
	v_cndmask_b32_e64 v54, v56, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[132:133], v[38:39], v[42:45]
	v_cndmask_b32_e64 v55, v55, 0, vcc
	v_add_u32_e32 v56, 0x7f7f7f00, v54
	s_add_i32 s3, s15, 0xf01
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[142:143], v[38:39], v[46:49]
	v_and_b32_e32 v38, 0x7070707, v41
	v_lshrrev_b32_e32 v39, 4, v41
	v_and_b32_e32 v39, 0x7070707, v39
	v_perm_b32 v40, v53, v52, v38
	v_perm_b32 v38, v51, v50, v38
	v_and_or_b32 v38, v40, v57, v38
	v_perm_b32 v40, v53, v52, v39
	v_perm_b32 v39, v51, v50, v39
	v_and_or_b32 v39, v40, v41, v39
	v_perm_b32 v50, v39, v38, s0
	v_perm_b32 v51, v39, v38, s1
	v_and_b32_e32 v52, 0x80808000, v56
	s_lshr_b32 s4, s3, 31
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[128:129], v[50:51], v[42:45]
	s_add_i32 s4, s3, s4
	s_and_b32 s4, s4, 0x1ffffffe
	s_sub_i32 s3, s3, s4
	v_add_u32_e32 v42, 0x7f7f7f78, v55
	v_and_b32_e32 v53, 0x80808080, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[138:139], v[50:51], v[46:49]
	s_lshl_b32 s3, s3, 3
	s_add_i32 s4, s3, 16
	v_lshrrev_b32_e32 v56, 4, v31
	v_and_b32_e32 v46, 0x7070707, v34
	v_lshrrev_b32_e32 v47, 4, v34
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v53, v52, v46
	v_lshlrev_b32_e32 v49, 4, v34
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v48, v48, v49, v46
	v_perm_b32 v46, v53, v52, v47
	v_perm_b32 v47, v55, v54, v47
	v_and_or_b32 v34, v46, v34, v47
	v_perm_b32 v46, v34, v48, s0
	v_perm_b32 v47, v34, v48, s1
	v_and_b32_e32 v34, 0x7070707, v35
	v_lshlrev_b32_e32 v48, 4, v35
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[124:125], v[46:47], v[38:41]
	v_and_b32_e32 v56, 0x7070707, v56
	v_lshlrev_b32_e32 v58, 4, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[130:131], v[46:47], v[42:45]
	v_lshrrev_b32_e32 v46, 4, v35
	v_and_b32_e32 v46, 0x7070707, v46
	v_perm_b32 v47, v53, v52, v34
	v_perm_b32 v34, v55, v54, v34
	v_and_or_b32 v47, v47, v48, v34
	v_perm_b32 v34, v53, v52, v46
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v35, v34, v35, v46
	v_perm_b32 v34, v35, v47, s0
	v_perm_b32 v35, v35, v47, s1
	v_lshlrev_b32_e32 v47, 4, v36
	v_bfe_u32 v48, v98, s4, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[120:121], v[34:35], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[126:127], v[34:35], v[42:45]
	v_and_b32_e32 v34, 0x7070707, v36
	v_lshrrev_b32_e32 v35, 4, v36
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v46, v53, v52, v34
	v_perm_b32 v34, v55, v54, v34
	v_and_or_b32 v46, v46, v47, v34
	v_perm_b32 v34, v53, v52, v35
	v_perm_b32 v35, v55, v54, v35
	v_and_or_b32 v35, v34, v36, v35
	v_perm_b32 v34, v35, v46, s0
	v_perm_b32 v35, v35, v46, s1
	v_lshlrev_b32_e32 v46, 4, v37
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[116:117], v[34:35], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[122:123], v[34:35], v[42:45]
	v_and_b32_e32 v34, 0x7070707, v37
	v_lshrrev_b32_e32 v35, 4, v37
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v53, v52, v34
	v_perm_b32 v34, v55, v54, v34
	v_and_or_b32 v36, v36, v46, v34
	v_perm_b32 v34, v53, v52, v35
	v_perm_b32 v35, v55, v54, v35
	v_and_or_b32 v35, v34, v37, v35
	v_perm_b32 v34, v35, v36, s0
	v_perm_b32 v35, v35, v36, s1
	v_bfe_u32 v46, v98, s3, 8
	v_sub_u32_e32 v54, v94, v48
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[114:115], v[34:35], v[38:41]
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[118:119], v[34:35], v[42:45]
	s_nop 2
	v_sub_u32_e32 v42, v94, v46
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s2
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	v_lshlrev_b32_e32 v45, 4, v30
	v_cndmask_b32_e64 v50, v44, 0, vcc
	v_cndmask_b32_e64 v51, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v50
	v_and_b32_e32 v52, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v51
	v_and_b32_e32 v53, 0x80808080, v42
	v_and_b32_e32 v42, 0x7070707, v30
	v_lshrrev_b32_e32 v43, 4, v30
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v53, v52, v42
	v_perm_b32 v42, v51, v50, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v53, v52, v43
	v_perm_b32 v43, v51, v50, v43
	v_and_or_b32 v30, v44, v30, v43
	v_perm_b32 v46, v30, v42, s0
	v_perm_b32 v47, v30, v42, s1
	v_min_i32_e32 v30, 11, v54
	v_mul_lo_u32 v55, v30, s2
	v_and_b32_e32 v30, 0x7070707, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[144:145], v[46:47], 0
	v_perm_b32 v57, v53, v52, v30
	v_perm_b32 v30, v51, v50, v30
	v_and_or_b32 v57, v57, v58, v30
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[148:149], v[46:47], 0
	v_perm_b32 v30, v53, v52, v56
	v_perm_b32 v56, v51, v50, v56
	v_and_or_b32 v31, v30, v31, v56
	v_perm_b32 v30, v31, v57, s0
	v_perm_b32 v31, v31, v57, s1
	v_lshlrev_b32_e32 v58, 4, v32
	v_sub_u32_e32 v56, 0x6c686080, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[140:141], v[30:31], v[42:45]
	v_and_b32_e32 v56, 0xffffff00, v56
	v_sub_u32_e32 v55, 0x7c787470, v55
	v_cmp_lt_i32_e32 vcc, 11, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[146:147], v[30:31], v[46:49]
	v_and_b32_e32 v30, 0x7070707, v32
	v_lshrrev_b32_e32 v31, 4, v32
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v57, v53, v52, v30
	v_perm_b32 v30, v51, v50, v30
	v_and_or_b32 v57, v57, v58, v30
	v_perm_b32 v30, v53, v52, v31
	v_perm_b32 v31, v51, v50, v31
	v_and_or_b32 v31, v30, v32, v31
	v_perm_b32 v30, v31, v57, s0
	v_perm_b32 v31, v31, v57, s1
	v_lshlrev_b32_e32 v57, 4, v33
	v_cndmask_b32_e64 v54, v56, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[132:133], v[30:31], v[42:45]
	v_cndmask_b32_e64 v55, v55, 0, vcc
	v_add_u32_e32 v56, 0x7f7f7f00, v54
	v_lshlrev_b32_e32 v58, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[142:143], v[30:31], v[46:49]
	v_and_b32_e32 v30, 0x7070707, v33
	v_lshrrev_b32_e32 v31, 4, v33
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v53, v52, v30
	v_perm_b32 v30, v51, v50, v30
	v_and_or_b32 v30, v32, v57, v30
	v_perm_b32 v32, v53, v52, v31
	v_perm_b32 v31, v51, v50, v31
	v_and_or_b32 v31, v32, v33, v31
	v_perm_b32 v50, v31, v30, s0
	v_perm_b32 v51, v31, v30, s1
	v_and_b32_e32 v52, 0x80808000, v56
	v_lshrrev_b32_e32 v56, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[128:129], v[50:51], v[42:45]
	v_and_b32_e32 v56, 0x7070707, v56
	s_nop 1
	v_add_u32_e32 v42, 0x7f7f7f78, v55
	v_and_b32_e32 v53, 0x80808080, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[138:139], v[50:51], v[46:49]
	s_nop 2
	v_and_b32_e32 v46, 0x7070707, v26
	v_lshrrev_b32_e32 v47, 4, v26
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v53, v52, v46
	v_lshlrev_b32_e32 v49, 4, v26
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v48, v48, v49, v46
	v_perm_b32 v46, v53, v52, v47
	v_perm_b32 v47, v55, v54, v47
	v_and_or_b32 v26, v46, v26, v47
	v_perm_b32 v46, v26, v48, s0
	v_perm_b32 v47, v26, v48, s1
	v_and_b32_e32 v26, 0x7070707, v27
	v_lshlrev_b32_e32 v48, 4, v27
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[124:125], v[46:47], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[130:131], v[46:47], v[42:45]
	v_lshrrev_b32_e32 v46, 4, v27
	v_and_b32_e32 v46, 0x7070707, v46
	v_perm_b32 v47, v53, v52, v26
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v47, v47, v48, v26
	v_perm_b32 v26, v53, v52, v46
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v27, v26, v27, v46
	v_perm_b32 v26, v27, v47, s0
	v_perm_b32 v27, v27, v47, s1
	v_lshlrev_b32_e32 v47, 4, v28
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[120:121], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[126:127], v[26:27], v[42:45]
	v_and_b32_e32 v26, 0x7070707, v28
	v_lshrrev_b32_e32 v27, 4, v28
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v46, v53, v52, v26
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v46, v46, v47, v26
	v_perm_b32 v26, v53, v52, v27
	v_perm_b32 v27, v55, v54, v27
	v_and_or_b32 v27, v26, v28, v27
	v_perm_b32 v26, v27, v46, s0
	v_perm_b32 v27, v27, v46, s1
	v_lshlrev_b32_e32 v46, 4, v29
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[116:117], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[122:123], v[26:27], v[42:45]
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v53, v52, v26
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v28, v28, v46, v26
	v_perm_b32 v26, v53, v52, v27
	v_perm_b32 v27, v55, v54, v27
	v_and_or_b32 v27, v26, v29, v27
	v_perm_b32 v26, v27, v28, s0
	v_perm_b32 v27, v27, v28, s1
	v_sub_u32_sdwa v54, v1, v97 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[114:115], v[26:27], v[30:33]
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[118:119], v[26:27], v[42:45]
	s_nop 2
	v_sub_u32_sdwa v42, v1, v97 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s2
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	v_lshlrev_b32_e32 v45, 4, v22
	v_cndmask_b32_e64 v50, v44, 0, vcc
	v_cndmask_b32_e64 v51, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v50
	v_and_b32_e32 v52, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v51
	v_and_b32_e32 v53, 0x80808080, v42
	v_and_b32_e32 v42, 0x7070707, v22
	v_lshrrev_b32_e32 v43, 4, v22
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v53, v52, v42
	v_perm_b32 v42, v51, v50, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v53, v52, v43
	v_perm_b32 v43, v51, v50, v43
	v_and_or_b32 v22, v44, v22, v43
	v_perm_b32 v46, v22, v42, s0
	v_perm_b32 v47, v22, v42, s1
	v_min_i32_e32 v22, 11, v54
	v_mul_lo_u32 v55, v22, s2
	v_and_b32_e32 v22, 0x7070707, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[144:145], v[46:47], 0
	v_perm_b32 v57, v53, v52, v22
	v_perm_b32 v22, v51, v50, v22
	v_and_or_b32 v57, v57, v58, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[148:149], v[46:47], 0
	v_perm_b32 v22, v53, v52, v56
	v_perm_b32 v56, v51, v50, v56
	v_and_or_b32 v23, v22, v23, v56
	v_perm_b32 v22, v23, v57, s0
	v_perm_b32 v23, v23, v57, s1
	v_lshlrev_b32_e32 v58, 4, v24
	v_sub_u32_e32 v56, 0x6c686080, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[140:141], v[22:23], v[42:45]
	v_and_b32_e32 v56, 0xffffff00, v56
	v_sub_u32_e32 v55, 0x7c787470, v55
	v_cmp_lt_i32_e32 vcc, 11, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[146:147], v[22:23], v[46:49]
	v_and_b32_e32 v22, 0x7070707, v24
	v_lshrrev_b32_e32 v23, 4, v24
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v57, v53, v52, v22
	v_perm_b32 v22, v51, v50, v22
	v_and_or_b32 v57, v57, v58, v22
	v_perm_b32 v22, v53, v52, v23
	v_perm_b32 v23, v51, v50, v23
	v_and_or_b32 v23, v22, v24, v23
	v_perm_b32 v22, v23, v57, s0
	v_perm_b32 v23, v23, v57, s1
	v_lshlrev_b32_e32 v57, 4, v25
	v_cndmask_b32_e64 v54, v56, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[132:133], v[22:23], v[42:45]
	v_cndmask_b32_e64 v55, v55, 0, vcc
	v_add_u32_e32 v56, 0x7f7f7f00, v54
	v_lshlrev_b32_e32 v58, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[142:143], v[22:23], v[46:49]
	v_and_b32_e32 v22, 0x7070707, v25
	v_lshrrev_b32_e32 v23, 4, v25
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v53, v52, v22
	v_perm_b32 v22, v51, v50, v22
	v_and_or_b32 v22, v24, v57, v22
	v_perm_b32 v24, v53, v52, v23
	v_perm_b32 v23, v51, v50, v23
	v_and_or_b32 v23, v24, v25, v23
	v_perm_b32 v50, v23, v22, s0
	v_perm_b32 v51, v23, v22, s1
	v_and_b32_e32 v52, 0x80808000, v56
	v_lshrrev_b32_e32 v56, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[128:129], v[50:51], v[42:45]
	v_and_b32_e32 v56, 0x7070707, v56
	s_nop 1
	v_add_u32_e32 v42, 0x7f7f7f78, v55
	v_and_b32_e32 v53, 0x80808080, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[138:139], v[50:51], v[46:49]
	s_nop 2
	v_and_b32_e32 v46, 0x7070707, v18
	v_lshrrev_b32_e32 v47, 4, v18
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v53, v52, v46
	v_lshlrev_b32_e32 v49, 4, v18
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v48, v48, v49, v46
	v_perm_b32 v46, v53, v52, v47
	v_perm_b32 v47, v55, v54, v47
	v_and_or_b32 v18, v46, v18, v47
	v_perm_b32 v46, v18, v48, s0
	v_perm_b32 v47, v18, v48, s1
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshlrev_b32_e32 v48, 4, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[124:125], v[46:47], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[130:131], v[46:47], v[42:45]
	v_lshrrev_b32_e32 v46, 4, v19
	v_and_b32_e32 v46, 0x7070707, v46
	v_perm_b32 v47, v53, v52, v18
	v_perm_b32 v18, v55, v54, v18
	v_and_or_b32 v47, v47, v48, v18
	v_perm_b32 v18, v53, v52, v46
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v19, v18, v19, v46
	v_perm_b32 v18, v19, v47, s0
	v_perm_b32 v19, v19, v47, s1
	v_lshlrev_b32_e32 v47, 4, v20
	v_bfe_u32 v48, v96, s4, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[120:121], v[18:19], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[126:127], v[18:19], v[42:45]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v46, v53, v52, v18
	v_perm_b32 v18, v55, v54, v18
	v_and_or_b32 v46, v46, v47, v18
	v_perm_b32 v18, v53, v52, v19
	v_perm_b32 v19, v55, v54, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v46, s0
	v_perm_b32 v19, v19, v46, s1
	v_lshlrev_b32_e32 v46, 4, v21
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[116:117], v[18:19], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[122:123], v[18:19], v[42:45]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v53, v52, v18
	v_perm_b32 v18, v55, v54, v18
	v_and_or_b32 v20, v20, v46, v18
	v_perm_b32 v18, v53, v52, v19
	v_perm_b32 v19, v55, v54, v19
	v_and_or_b32 v19, v18, v21, v19
	v_perm_b32 v18, v19, v20, s0
	v_perm_b32 v19, v19, v20, s1
	v_bfe_u32 v46, v96, s3, 8
	v_sub_u32_e32 v54, v0, v48
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[114:115], v[18:19], v[22:25]
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[118:119], v[18:19], v[42:45]
	s_nop 2
	v_sub_u32_e32 v42, v0, v46
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s2
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	v_lshlrev_b32_e32 v45, 4, v14
	v_cndmask_b32_e64 v50, v44, 0, vcc
	v_cndmask_b32_e64 v51, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v50
	v_and_b32_e32 v52, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v51
	v_and_b32_e32 v53, 0x80808080, v42
	v_and_b32_e32 v42, 0x7070707, v14
	v_lshrrev_b32_e32 v43, 4, v14
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v53, v52, v42
	v_perm_b32 v42, v51, v50, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v53, v52, v43
	v_perm_b32 v43, v51, v50, v43
	v_and_or_b32 v14, v44, v14, v43
	v_perm_b32 v46, v14, v42, s0
	v_perm_b32 v47, v14, v42, s1
	v_min_i32_e32 v14, 11, v54
	v_mul_lo_u32 v55, v14, s2
	v_and_b32_e32 v14, 0x7070707, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[144:145], v[46:47], 0
	v_perm_b32 v57, v53, v52, v14
	v_perm_b32 v14, v51, v50, v14
	v_and_or_b32 v57, v57, v58, v14
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[148:149], v[46:47], 0
	v_perm_b32 v14, v53, v52, v56
	v_perm_b32 v56, v51, v50, v56
	v_and_or_b32 v15, v14, v15, v56
	v_perm_b32 v14, v15, v57, s0
	v_perm_b32 v15, v15, v57, s1
	v_lshlrev_b32_e32 v58, 4, v16
	v_sub_u32_e32 v56, 0x6c686080, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[140:141], v[14:15], v[42:45]
	v_and_b32_e32 v56, 0xffffff00, v56
	v_sub_u32_e32 v55, 0x7c787470, v55
	v_cmp_lt_i32_e32 vcc, 11, v54
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[146:147], v[14:15], v[46:49]
	v_and_b32_e32 v14, 0x7070707, v16
	v_lshrrev_b32_e32 v15, 4, v16
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v57, v53, v52, v14
	v_perm_b32 v14, v51, v50, v14
	v_and_or_b32 v57, v57, v58, v14
	v_perm_b32 v14, v53, v52, v15
	v_perm_b32 v15, v51, v50, v15
	v_and_or_b32 v15, v14, v16, v15
	v_perm_b32 v14, v15, v57, s0
	v_perm_b32 v15, v15, v57, s1
	v_lshlrev_b32_e32 v57, 4, v17
	v_cndmask_b32_e64 v54, v56, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[132:133], v[14:15], v[42:45]
	v_cndmask_b32_e64 v55, v55, 0, vcc
	v_add_u32_e32 v56, 0x7f7f7f00, v54
	v_cmp_lt_i32_e32 vcc, 5, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[142:143], v[14:15], v[46:49]
	v_and_b32_e32 v14, 0x7070707, v17
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v53, v52, v14
	v_perm_b32 v14, v51, v50, v14
	v_and_or_b32 v14, v16, v57, v14
	v_perm_b32 v16, v53, v52, v15
	v_perm_b32 v15, v51, v50, v15
	v_and_or_b32 v15, v16, v17, v15
	v_perm_b32 v50, v15, v14, s0
	v_perm_b32 v51, v15, v14, s1
	v_and_b32_e32 v52, 0x80808000, v56
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[128:129], v[50:51], v[42:45]
	s_nop 2
	v_add_u32_e32 v42, 0x7f7f7f78, v55
	v_and_b32_e32 v53, 0x80808080, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[138:139], v[50:51], v[46:49]
	s_nop 2
	v_and_b32_e32 v46, 0x7070707, v10
	v_lshrrev_b32_e32 v47, 4, v10
	v_and_b32_e32 v47, 0x7070707, v47
	v_perm_b32 v48, v53, v52, v46
	v_lshlrev_b32_e32 v49, 4, v10
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v48, v48, v49, v46
	v_perm_b32 v46, v53, v52, v47
	v_perm_b32 v47, v55, v54, v47
	v_and_or_b32 v10, v46, v10, v47
	v_perm_b32 v46, v10, v48, s0
	v_perm_b32 v47, v10, v48, s1
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshlrev_b32_e32 v48, 4, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[124:125], v[46:47], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[130:131], v[46:47], v[42:45]
	v_lshrrev_b32_e32 v46, 4, v11
	v_and_b32_e32 v46, 0x7070707, v46
	v_perm_b32 v47, v53, v52, v10
	v_perm_b32 v10, v55, v54, v10
	v_and_or_b32 v47, v47, v48, v10
	v_perm_b32 v10, v53, v52, v46
	v_perm_b32 v46, v55, v54, v46
	v_and_or_b32 v11, v10, v11, v46
	v_perm_b32 v10, v11, v47, s0
	v_perm_b32 v11, v11, v47, s1
	v_lshlrev_b32_e32 v47, 4, v12
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[120:121], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[126:127], v[10:11], v[42:45]
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v46, v53, v52, v10
	v_perm_b32 v10, v55, v54, v10
	v_and_or_b32 v46, v46, v47, v10
	v_perm_b32 v10, v53, v52, v11
	v_perm_b32 v11, v55, v54, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v46, s0
	v_perm_b32 v11, v11, v46, s1
	v_lshlrev_b32_e32 v46, 4, v13
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[116:117], v[10:11], v[14:17]
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[122:123], v[10:11], v[42:45]
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v53, v52, v10
	v_perm_b32 v10, v55, v54, v10
	v_and_or_b32 v12, v12, v46, v10
	v_perm_b32 v10, v53, v52, v11
	v_perm_b32 v11, v55, v54, v11
	v_and_or_b32 v11, v10, v13, v11
	v_perm_b32 v10, v11, v12, s0
	v_perm_b32 v11, v11, v12, s1
	v_add_u32_e32 v46, 17, v1
	v_lshlrev_b32_e64 v46, v46, 1
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[114:115], v[10:11], v[14:17]
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[118:119], v[10:11], v[42:45]
	s_nop 2
	v_mov_b32_e32 v43, 0xfd800000
	v_add_u32_e32 v44, 17, v95
	v_lshl_add_u32 v42, v95, 23, v43
	v_lshlrev_b32_e64 v44, v44, 1
	v_add_u32_e32 v45, 17, v94
	v_cndmask_b32_e32 v42, v44, v42, vcc
	v_lshl_add_u32 v44, v94, 23, v43
	v_lshlrev_b32_e64 v45, v45, 1
	v_cmp_lt_i32_e32 vcc, 5, v94
	s_nop 1
	v_cndmask_b32_e32 v44, v45, v44, vcc
	v_lshl_add_u32 v45, v1, 23, v43
	v_cmp_lt_i32_e32 vcc, 5, v1
	v_lshl_add_u32 v1, v0, 23, v43
	v_add_u32_e32 v43, 17, v0
	v_lshlrev_b32_e64 v43, v43, 1
	v_pk_mul_f32 v[50:51], v[8:9], v[42:43] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v46, v46, v45, vcc
	v_pk_mul_f32 v[40:41], v[50:51], v[40:41]
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[40:41], v[40:41], v[80:81]
	v_pk_mul_f32 v[48:49], v[6:7], v[42:43] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v0, v43, v1, vcc
	v_bfe_u32 v1, v41, 16, 1
	v_pk_mul_f32 v[38:39], v[48:49], v[38:39]
	v_add3_u32 v1, v1, v41, s0
	v_or_b32_e32 v43, 0x400000, v41
	v_cmp_u_f32_e32 vcc, v41, v41
	v_bfe_u32 v41, v40, 16, 1
	v_pk_mul_f32 v[38:39], v[38:39], v[78:79]
	v_cndmask_b32_e32 v1, v1, v43, vcc
	v_add3_u32 v41, v41, v40, s0
	v_or_b32_e32 v43, 0x400000, v40
	v_cmp_u_f32_e32 vcc, v40, v40
	s_nop 1
	v_cndmask_b32_e32 v40, v41, v43, vcc
	v_bfe_u32 v41, v39, 16, 1
	v_add3_u32 v41, v41, v39, s0
	v_or_b32_e32 v43, 0x400000, v39
	v_cmp_u_f32_e32 vcc, v39, v39
	s_nop 1
	v_cndmask_b32_e32 v39, v41, v43, vcc
	v_bfe_u32 v41, v38, 16, 1
	v_add3_u32 v41, v41, v38, s0
	v_or_b32_e32 v43, 0x400000, v38
	v_cmp_u_f32_e32 vcc, v38, v38
	s_nop 1
	v_cndmask_b32_e32 v38, v41, v43, vcc
	ds_write_b16_d16_hi v85, v38
	ds_write_b16_d16_hi v83, v39 offset:512
	ds_write_b16_d16_hi v83, v40 offset:1024
	ds_write_b16_d16_hi v83, v1 offset:1536
	v_pk_mul_f32 v[40:41], v[8:9], v[44:45] op_sel_hi:[1,0]
	v_pk_mul_f32 v[38:39], v[6:7], v[44:45] op_sel_hi:[1,0]
	v_pk_mul_f32 v[32:33], v[40:41], v[32:33]
	v_pk_mul_f32 v[30:31], v[38:39], v[30:31]
	v_pk_mul_f32 v[32:33], v[32:33], v[80:81]
	v_pk_mul_f32 v[30:31], v[30:31], v[78:79]
	v_bfe_u32 v1, v33, 16, 1
	v_add3_u32 v1, v1, v33, s0
	v_or_b32_e32 v38, 0x400000, v33
	v_cmp_u_f32_e32 vcc, v33, v33
	v_bfe_u32 v33, v32, 16, 1
	v_add3_u32 v33, v33, v32, s0
	v_cndmask_b32_e32 v1, v1, v38, vcc
	v_or_b32_e32 v38, 0x400000, v32
	v_cmp_u_f32_e32 vcc, v32, v32
	s_nop 1
	v_cndmask_b32_e32 v32, v33, v38, vcc
	v_bfe_u32 v33, v31, 16, 1
	v_add3_u32 v33, v33, v31, s0
	v_or_b32_e32 v38, 0x400000, v31
	v_cmp_u_f32_e32 vcc, v31, v31
	s_nop 1
	v_cndmask_b32_e32 v31, v33, v38, vcc
	v_bfe_u32 v33, v30, 16, 1
	v_add3_u32 v33, v33, v30, s0
	v_or_b32_e32 v38, 0x400000, v30
	v_cmp_u_f32_e32 vcc, v30, v30
	s_nop 1
	v_cndmask_b32_e32 v30, v33, v38, vcc
	ds_write_b16_d16_hi v83, v30 offset:32
	ds_write_b16_d16_hi v83, v31 offset:544
	ds_write_b16_d16_hi v83, v32 offset:1056
	ds_write_b16_d16_hi v83, v1 offset:1568
	v_pk_mul_f32 v[32:33], v[8:9], v[46:47] op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[6:7], v[46:47] op_sel_hi:[1,0]
	v_pk_mul_f32 v[24:25], v[32:33], v[24:25]
	v_pk_mul_f32 v[22:23], v[30:31], v[22:23]
	v_pk_mul_f32 v[24:25], v[24:25], v[80:81]
	v_pk_mul_f32 v[22:23], v[22:23], v[78:79]
	v_bfe_u32 v1, v25, 16, 1
	v_add3_u32 v1, v1, v25, s0
	v_or_b32_e32 v30, 0x400000, v25
	v_cmp_u_f32_e32 vcc, v25, v25
	v_bfe_u32 v25, v24, 16, 1
	v_add3_u32 v25, v25, v24, s0
	v_cndmask_b32_e32 v1, v1, v30, vcc
	v_or_b32_e32 v30, 0x400000, v24
	v_cmp_u_f32_e32 vcc, v24, v24
	v_pk_mul_f32 v[8:9], v[8:9], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[6:7], v[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v24, v25, v30, vcc
	v_bfe_u32 v25, v23, 16, 1
	v_add3_u32 v25, v25, v23, s0
	v_or_b32_e32 v30, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	v_pk_mul_f32 v[8:9], v[8:9], v[16:17]
	v_pk_mul_f32 v[6:7], v[6:7], v[14:15]
	v_cndmask_b32_e32 v23, v25, v30, vcc
	v_bfe_u32 v25, v22, 16, 1
	v_add3_u32 v25, v25, v22, s0
	v_or_b32_e32 v30, 0x400000, v22
	v_cmp_u_f32_e32 vcc, v22, v22
	v_pk_mul_f32 v[8:9], v[8:9], v[80:81]
	v_pk_mul_f32 v[6:7], v[6:7], v[78:79]
	v_cndmask_b32_e32 v22, v25, v30, vcc
	ds_write_b16_d16_hi v83, v22 offset:64
	ds_write_b16_d16_hi v83, v23 offset:576
	ds_write_b16_d16_hi v83, v24 offset:1088
	ds_write_b16_d16_hi v83, v1 offset:1600
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
	ds_write_b16_d16_hi v83, v6 offset:96
	ds_write_b16_d16_hi v83, v7 offset:608
	ds_write_b16_d16_hi v83, v8 offset:1120
	ds_write_b16_d16_hi v83, v1 offset:1632
	v_pk_mul_f32 v[8:9], v[4:5], v[42:43] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[42:43] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[36:37]
	v_pk_mul_f32 v[6:7], v[6:7], v[34:35]
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
	ds_write_b16_d16_hi v83, v6 offset:8192
	ds_write_b16_d16_hi v83, v7 offset:8704
	ds_write_b16_d16_hi v83, v8 offset:9216
	ds_write_b16_d16_hi v83, v1 offset:9728
	v_pk_mul_f32 v[8:9], v[4:5], v[44:45] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[44:45] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[28:29]
	v_pk_mul_f32 v[6:7], v[6:7], v[26:27]
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
	ds_write_b16_d16_hi v83, v6 offset:8224
	ds_write_b16_d16_hi v83, v7 offset:8736
	ds_write_b16_d16_hi v83, v8 offset:9248
	ds_write_b16_d16_hi v83, v1 offset:9760
	v_pk_mul_f32 v[8:9], v[4:5], v[46:47] op_sel_hi:[1,0]
	v_pk_mul_f32 v[6:7], v[2:3], v[46:47] op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[8:9], v[20:21]
	v_pk_mul_f32 v[6:7], v[6:7], v[18:19]
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
	ds_write_b16_d16_hi v83, v6 offset:8256
	ds_write_b16_d16_hi v83, v7 offset:8768
	ds_write_b16_d16_hi v83, v8 offset:9280
	ds_write_b16_d16_hi v83, v1 offset:9792
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
	ds_write_b16_d16_hi v83, v2 offset:8288
	ds_write_b16_d16_hi v83, v3 offset:8800
	ds_write_b16_d16_hi v83, v0 offset:9312
	ds_write_b16_d16_hi v83, v1 offset:9824
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v92, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_15
	v_add_u32_e32 v2, v93, v82
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
.LBB0_15:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v90, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_17
	v_add_u32_e32 v2, v91, v82
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
.LBB0_17:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v89, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_19
	v_add_u32_e32 v2, v88, v82
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
.LBB0_19:
	s_or_b64 exec, exec, s[0:1]
	buffer_load_dword v0, v87, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_21
	v_add_u32_e32 v2, v84, v82
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
.LBB0_21:
	s_or_b64 exec, exec, s[0:1]
	s_barrier
.LBB0_22:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r
		.amdhsa_group_segment_fixed_size 24704
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
		.amdhsa_next_free_vgpr 211
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 212
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.num_vgpr, 211
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.numbered_sgpr, 61
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.has_indirect_call, 0
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
    .group_segment_fixed_size: 24704
    .kernarg_segment_align: 8
    .kernarg_segment_size: 108
    .max_flat_workgroup_size: 256
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 256
      - 1
      - 1
    .sgpr_count:     67
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw4_tk128_tn256_bcm12_xcd1_ftz_a2r.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     211
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
