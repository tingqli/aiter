	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db,@function
a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db:
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
	s_lshl_b32 s44, s2, 5
	v_lshrrev_b32_e32 v34, 4, v0
	v_or_b32_e32 v2, s44, v34
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dword v6, v[2:3], off
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dwordx2 s[34:35], s[0:1], 0x60
	s_load_dword s33, s[0:1], 0x68
	v_and_b32_e32 v1, 15, v0
	v_lshlrev_b32_e32 v106, 4, v0
	s_waitcnt lgkmcnt(0)
	s_and_b32 s29, s11, 0xffff
	s_load_dword s11, s[46:47], 0x0
	s_and_b32 s1, s5, 0xffff
	s_and_b32 s25, s9, 0xffff
	s_lshl_b32 s9, s48, 5
	v_xor_b32_e32 v2, v106, v0
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s5, s11, 9
	v_or_b32_e32 v113, s9, v1
	s_add_i32 s46, s5, s9
	v_and_b32_e32 v108, 48, v0
	v_and_b32_e32 v7, 0xf0, v2
	v_add_u32_e32 v2, s5, v113
	s_lshl_b32 s24, s46, 5
	s_add_i32 s27, s46, 0x100
	s_add_i32 s51, s46, 0x110
	s_lshl_b32 s5, s46, 7
	s_ashr_i32 s28, s46, 31
	v_add_u32_e32 v4, 0x100, v2
	v_or3_b32 v128, s24, v108, v1
	s_lshl_b32 s24, s27, 5
	s_ashr_i32 s53, s51, 31
	s_or_b32 s47, s46, 16
	v_ashrrev_i32_e32 v3, 31, v2
	v_or3_b32 v127, s5, v108, v1
	s_lshl_b32 s5, s27, 7
	s_lshr_b32 s31, s28, 27
	v_ashrrev_i32_e32 v5, 31, v4
	v_or3_b32 v130, s24, v108, v1
	s_lshr_b32 s24, s53, 27
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s4
	s_lshl_b32 s2, s33, 12
	s_lshl_b32 s27, s47, 7
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	v_or3_b32 v129, s5, v108, v1
	s_add_i32 s5, s47, s31
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	s_add_i32 s12, s51, s24
	s_brev_b32 s26, 8
	s_lshl_b32 s52, s51, 7
	v_or3_b32 v131, s27, v108, v1
	s_lshr_b32 s5, s5, 5
	s_mov_b32 s42, s26
	s_mov_b32 s43, s3
	s_mov_b32 s40, s8
	s_mov_b32 s41, s25
	v_or3_b32 v132, s52, v108, v1
	v_lshlrev_b32_e32 v8, 4, v127
	v_lshlrev_b32_e32 v37, 4, v131
	s_add_i32 s5, s5, s28
	s_mov_b32 s30, 0x1000000
	global_load_dword v116, v[2:3], off
	global_load_dword v117, v[2:3], off offset:64
	global_load_dword v114, v[4:5], off
	global_load_dword v115, v[4:5], off offset:64
	buffer_load_dwordx4 v[30:33], v8, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v8, s[40:43], 0 offen offset:1024 sc0
	v_lshlrev_b32_e32 v38, 4, v129
	v_lshlrev_b32_e32 v39, 4, v132
	s_lshl_b32 s5, s5, 10
	s_mov_b32 s38, s30
	s_mov_b32 s39, s3
	s_mov_b32 s36, s10
	s_mov_b32 s37, s29
	v_lshlrev_b32_e32 v35, 2, v128
	v_or3_b32 v135, s5, v108, v1
	v_lshlrev_b32_e32 v36, 2, v130
	s_mov_b32 s27, s3
	s_mov_b32 s31, s3
	v_bfe_u32 v107, v0, 4, 2
	v_mov_b32_e32 v66, 0
	v_lshlrev_b32_e32 v109, 8, v1
	s_mov_b32 s24, s8
	v_and_b32_e32 v112, 63, v0
	s_mov_b32 s49, 0x8080808
	s_mov_b32 s50, 0x5010400
	v_mov_b32_e32 v67, v66
	v_mov_b32_e32 v68, v66
	v_mov_b32_e32 v69, v66
	v_mov_b32_e32 v58, v66
	s_waitcnt vmcnt(6)
	v_lshl_or_b32 v134, v6, 12, v7
	buffer_load_dwordx4 v[44:47], v134, s[0:3], 0 offen nt
	s_lshr_b32 s0, s12, 5
	s_add_i32 s0, s0, s53
	buffer_load_dwordx4 v[14:17], v37, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v37, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[26:29], v38, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v38, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[10:13], v39, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v39, s[40:43], 0 offen offset:1024 sc0
	s_lshl_b32 s0, s0, 10
	v_or3_b32 v136, s0, v108, v1
	v_lshlrev_b32_e32 v37, 2, v135
	v_lshlrev_b32_e32 v38, 2, v136
	buffer_load_dword v100, v35, s[36:39], 0 offen
	buffer_load_dword v119, v37, s[36:39], 0 offen
	buffer_load_dword v99, v36, s[36:39], 0 offen
	buffer_load_dword v118, v38, s[36:39], 0 offen
	s_mov_b32 s38, s2
	s_mov_b32 s37, s1
	s_lshr_b32 s0, s46, 31
	s_ashr_i32 s1, s47, 4
	s_ashr_i32 s2, s51, 4
	s_lshr_b32 s3, s51, 31
	s_add_i32 s0, s1, s0
	s_add_i32 s3, s2, s3
	v_and_b32_e32 v35, 0xf0, v106
	v_lshlrev_b32_e32 v36, 5, v107
	v_lshlrev_b32_e32 v37, 4, v1
	s_and_b32 s0, s0, -2
	s_and_b32 s3, s3, -2
	v_lshl_or_b32 v34, v34, 8, v35
	v_xor_b32_e32 v110, v36, v37
	v_or_b32_e32 v35, 8, v36
	v_or_b32_e32 v38, 16, v36
	v_or_b32_e32 v39, 24, v36
	v_or_b32_e32 v40, 0x80, v36
	v_or_b32_e32 v41, 0x88, v36
	v_or_b32_e32 v42, 0x90, v36
	v_or_b32_e32 v36, 0x98, v36
	s_sub_i32 s0, s1, s0
	s_sub_i32 s1, s2, s3
	v_xor_b32_e32 v125, v35, v37
	v_xor_b32_e32 v35, v36, v37
	s_lshl_b32 s12, s0, 3
	s_lshl_b32 s8, s1, 3
	s_mov_b32 s40, 0x7030602
	v_mov_b32_e32 v59, v66
	v_mov_b32_e32 v60, v66
	v_mov_b32_e32 v61, v66
	v_mov_b32_e32 v74, v66
	v_mov_b32_e32 v75, v66
	v_mov_b32_e32 v76, v66
	v_mov_b32_e32 v77, v66
	v_or_b32_e32 v126, 0x1000, v109
	v_lshrrev_b32_e32 v138, 2, v34
	v_xor_b32_e32 v124, v38, v37
	v_xor_b32_e32 v123, v39, v37
	v_xor_b32_e32 v122, v40, v37
	v_xor_b32_e32 v121, v41, v37
	v_xor_b32_e32 v120, v42, v37
	v_or_b32_e32 v133, v109, v110
	v_or_b32_e32 v111, v109, v35
	s_mov_b32 s36, s4
	s_mov_b32 s28, s10
	s_add_i32 s13, s12, 16
	s_add_i32 s10, s8, 16
	v_mov_b32_e32 v50, v66
	v_mov_b32_e32 v51, v66
	v_mov_b32_e32 v52, v66
	v_mov_b32_e32 v53, v66
	v_mov_b32_e32 v78, v66
	v_mov_b32_e32 v79, v66
	v_mov_b32_e32 v80, v66
	v_mov_b32_e32 v81, v66
	v_mov_b32_e32 v62, v66
	v_mov_b32_e32 v63, v66
	v_mov_b32_e32 v64, v66
	v_mov_b32_e32 v65, v66
	v_mov_b32_e32 v82, v66
	v_mov_b32_e32 v83, v66
	v_mov_b32_e32 v84, v66
	v_mov_b32_e32 v85, v66
	v_mov_b32_e32 v54, v66
	v_mov_b32_e32 v55, v66
	v_mov_b32_e32 v56, v66
	v_mov_b32_e32 v57, v66
	s_waitcnt vmcnt(10)
	ds_write_b128 v34, v[44:47]
.LBB0_2:
	s_and_b32 s41, s45, 1
	s_add_i32 s45, s45, 1
	s_lshl_b32 s1, s45, 7
	s_waitcnt vmcnt(4)
	v_mov_b64_e32 v[36:37], v[4:5]
	v_mov_b64_e32 v[34:35], v[2:3]
	v_mov_b64_e32 v[72:73], v[12:13]
	v_mov_b64_e32 v[70:71], v[10:11]
	v_mov_b64_e32 v[40:41], v[8:9]
	v_mov_b64_e32 v[38:39], v[6:7]
	v_lshl_add_u32 v2, s45, 8, v134
	s_lshl_b32 s0, s45, 6
	v_or_b32_e32 v6, s1, v127
	v_or_b32_e32 v11, s1, v129
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[44:45], v[20:21]
	v_mov_b64_e32 v[42:43], v[18:19]
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx4 v[186:189], v2, s[36:39], 0 offen nt
	v_add_lshl_u32 v2, s0, v128, 2
	v_add_lshl_u32 v3, s0, v135, 2
	v_add_lshl_u32 v4, s0, v130, 2
	v_add_lshl_u32 v5, s0, v136, 2
	v_add_lshl_u32 v10, s1, v131, 4
	v_add_lshl_u32 v18, s1, v132, 4
	v_lshlrev_b32_e32 v19, 4, v6
	v_lshlrev_b32_e32 v20, 4, v11
	v_mov_b64_e32 v[92:93], v[28:29]
	v_mov_b64_e32 v[90:91], v[26:27]
	v_mov_b64_e32 v[88:89], v[16:17]
	v_mov_b64_e32 v[86:87], v[14:15]
	v_mov_b64_e32 v[48:49], v[24:25]
	v_mov_b64_e32 v[46:47], v[22:23]
	v_mov_b64_e32 v[96:97], v[32:33]
	v_mov_b64_e32 v[94:95], v[30:31]
	s_waitcnt vmcnt(3)
	v_bfe_u32 v142, v119, s12, 8
	v_bfe_u32 v159, v119, s13, 8
	s_waitcnt vmcnt(1)
	v_bfe_u32 v143, v118, s8, 8
	v_bfe_u32 v151, v118, s10, 8
	buffer_load_dword v139, v2, s[28:31], 0 offen
	buffer_load_dword v119, v3, s[28:31], 0 offen
	buffer_load_dword v137, v4, s[28:31], 0 offen
	buffer_load_dword v118, v5, s[28:31], 0 offen
	buffer_load_dwordx4 v[14:17], v10, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v10, s[24:27], 0 offen offset:1024 sc0
	s_nop 0
	buffer_load_dwordx4 v[10:13], v18, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v18, s[24:27], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[30:33], v19, s[24:27], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v19, s[24:27], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[26:29], v20, s[24:27], 0 offen sc0
	s_nop 0
	buffer_load_dwordx4 v[18:21], v20, s[24:27], 0 offen offset:1024 sc0
	v_sub_u32_sdwa v98, v116, v100 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v190, 11, v98
	v_sub_u32_e32 v156, v117, v142
	v_lshrrev_b32_e32 v184, 4, v86
	v_cmp_lt_i32_e64 s[4:5], 11, v98
	v_mul_lo_u32 v98, v190, s49
	v_sub_u32_sdwa v102, v114, v99 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v204, 11, v156
	v_and_b32_e32 v206, 0x7070707, v184
	v_sub_u32_e32 v184, 0x6c686080, v98
	s_lshl_b32 s42, s41, 13
	v_sub_u32_e32 v181, v115, v143
	v_min_i32_e32 v191, 11, v102
	v_cmp_lt_i32_e64 s[0:1], 11, v156
	v_mul_lo_u32 v156, v204, s49
	v_sub_u32_e32 v98, 0x7c787470, v98
	v_and_b32_e32 v184, 0xffffff00, v184
	v_lshrrev_b32_e32 v185, 4, v70
	v_or_b32_e32 v192, s42, v133
	v_min_i32_e32 v205, 11, v181
	v_cmp_lt_i32_e32 vcc, 11, v102
	v_mul_lo_u32 v102, v191, s49
	v_sub_u32_e32 v204, 0x6c686080, v156
	v_sub_u32_e32 v156, 0x7c787470, v156
	v_cndmask_b32_e64 v208, v98, 0, s[4:5]
	v_cndmask_b32_e64 v212, v184, 0, s[4:5]
	v_and_b32_e32 v207, 0x7070707, v185
	v_cmp_lt_i32_e64 s[2:3], 11, v181
	ds_read2st64_b64 v[190:193], v192 offset1:8
	v_mul_lo_u32 v181, v205, s49
	v_sub_u32_e32 v185, 0x6c686080, v102
	v_cndmask_b32_e64 v210, v156, 0, s[0:1]
	v_add_u32_e32 v98, 0x7f7f7f78, v208
	v_add_u32_e32 v156, 0x7f7f7f00, v212
	v_sub_u32_sdwa v141, v114, v99 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_and_b32_e32 v99, 0x7070707, v94
	v_sub_u32_e32 v102, 0x7c787470, v102
	v_sub_u32_e32 v205, 0x6c686080, v181
	v_sub_u32_e32 v181, 0x7c787470, v181
	v_and_b32_e32 v185, 0xffffff00, v185
	v_and_b32_e32 v214, 0x80808080, v98
	v_and_b32_e32 v215, 0x80808000, v156
	v_sub_u32_sdwa v140, v116, v100 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_lshlrev_b32_e32 v100, 4, v94
	v_cndmask_b32_e64 v209, v102, 0, vcc
	v_cndmask_b32_e64 v211, v181, 0, s[2:3]
	v_cndmask_b32_e64 v213, v185, 0, vcc
	v_perm_b32 v181, v208, v212, v99
	v_perm_b32 v98, v214, v215, v99
	v_add_u32_e32 v102, 0x7f7f7f78, v209
	v_and_or_b32 v99, v98, v100, v181
	v_add_u32_e32 v98, 0x7f7f7f00, v213
	v_lshrrev_b32_e32 v104, 4, v94
	v_and_b32_e32 v101, 0x7070707, v90
	v_and_b32_e32 v216, 0x80808080, v102
	v_and_b32_e32 v217, 0x80808000, v98
	v_lshlrev_b32_e32 v103, 4, v90
	v_and_b32_e32 v104, 0x7070707, v104
	v_perm_b32 v100, v209, v213, v101
	v_perm_b32 v98, v216, v217, v101
	v_lshrrev_b32_e32 v105, 4, v90
	v_and_or_b32 v100, v98, v103, v100
	v_perm_b32 v98, v208, v212, v104
	v_perm_b32 v102, v214, v215, v104
	v_and_b32_e32 v105, 0x7070707, v105
	v_and_b32_e32 v204, 0xffffff00, v204
	v_and_or_b32 v94, v102, v94, v98
	v_cndmask_b32_e64 v204, v204, 0, s[0:1]
	v_perm_b32 v101, v209, v213, v105
	v_perm_b32 v103, v216, v217, v105
	v_perm_b32 v98, v94, v99, s50
	v_perm_b32 v99, v94, v99, s40
	v_and_b32_e32 v205, 0xffffff00, v205
	v_and_or_b32 v90, v103, v90, v101
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[190:191], v[98:99], v[66:69]
	v_and_b32_e32 v194, 0x7070707, v86
	v_cndmask_b32_e64 v205, v205, 0, s[2:3]
	v_lshlrev_b32_e32 v195, 4, v86
	v_add_u32_e32 v66, 0x7f7f7f78, v210
	v_add_u32_e32 v68, 0x7f7f7f00, v204
	v_and_b32_e32 v218, 0x80808080, v66
	v_and_b32_e32 v219, 0x80808000, v68
	v_add_u32_e32 v67, 0x7f7f7f78, v211
	v_perm_b32 v69, v210, v204, v194
	v_perm_b32 v66, v218, v219, v194
	v_add_u32_e32 v68, 0x7f7f7f00, v205
	v_and_b32_e32 v196, 0x7070707, v70
	v_perm_b32 v184, v90, v100, s50
	v_perm_b32 v185, v90, v100, s40
	v_and_or_b32 v66, v66, v195, v69
	v_perm_b32 v69, v210, v204, v206
	v_and_b32_e32 v220, 0x80808080, v67
	v_and_b32_e32 v221, 0x80808000, v68
	v_perm_b32 v67, v218, v219, v206
	v_lshlrev_b32_e32 v197, 4, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[192:193], v[98:99], v[74:77]
	v_perm_b32 v68, v220, v221, v196
	v_and_or_b32 v67, v67, v86, v69
	v_lshrrev_b32_e32 v164, 4, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[192:193], v[184:185], v[82:85]
	v_lshrrev_b32_e32 v166, 4, v96
	v_lshrrev_b32_e32 v198, 4, v97
	v_lshrrev_b32_e32 v163, 4, v91
	v_perm_b32 v82, v211, v205, v196
	v_perm_b32 v84, v211, v205, v207
	v_perm_b32 v85, v220, v221, v207
	v_and_or_b32 v86, v68, v197, v82
	v_perm_b32 v82, v67, v66, s50
	v_perm_b32 v83, v67, v66, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[190:191], v[184:185], v[78:81]
	v_and_b32_e32 v158, 0x7070707, v96
	v_lshlrev_b32_e32 v146, 4, v96
	v_lshrrev_b32_e32 v165, 4, v92
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[190:191], v[82:83], v[58:61]
	v_and_b32_e32 v177, 0x7070707, v97
	v_lshlrev_b32_e32 v162, 4, v97
	v_lshrrev_b32_e32 v200, 4, v87
	v_and_or_b32 v58, v85, v70, v84
	v_perm_b32 v194, v58, v86, s50
	v_perm_b32 v195, v58, v86, s40
	v_and_b32_e32 v154, 0x7070707, v91
	v_lshlrev_b32_e32 v145, 4, v91
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[190:191], v[194:195], v[62:65]
	v_lshrrev_b32_e32 v201, 4, v88
	v_lshrrev_b32_e32 v199, 4, v93
	v_and_b32_e32 v173, 0x7070707, v87
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[192:193], v[82:83], v[50:53]
	v_lshlrev_b32_e32 v160, 4, v87
	v_lshrrev_b32_e32 v175, 4, v71
	v_cmp_lt_i32_e64 s[0:1], 11, v140
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[192:193], v[194:195], v[54:57]
	v_sub_u32_e32 v192, v115, v151
	v_and_b32_e32 v151, 0x7070707, v201
	v_min_i32_e32 v140, 11, v140
	v_and_b32_e32 v55, 0x7070707, v164
	v_and_b32_e32 v56, 0x7070707, v166
	v_perm_b32 v86, v208, v212, v55
	v_perm_b32 v55, v214, v215, v55
	v_and_b32_e32 v57, 0x7070707, v198
	v_and_or_b32 v190, v55, v95, v86
	v_perm_b32 v55, v208, v212, v56
	v_perm_b32 v56, v214, v215, v56
	v_and_or_b32 v166, v56, v96, v55
	v_perm_b32 v55, v208, v212, v57
	v_perm_b32 v56, v214, v215, v57
	v_and_b32_e32 v96, 0x7070707, v163
	v_and_or_b32 v164, v56, v97, v55
	v_and_b32_e32 v97, 0x7070707, v165
	v_perm_b32 v163, v209, v213, v96
	v_perm_b32 v96, v216, v217, v96
	v_and_or_b32 v191, v96, v91, v163
	v_perm_b32 v91, v209, v213, v97
	v_perm_b32 v96, v216, v217, v97
	v_and_b32_e32 v97, 0x7070707, v200
	v_perm_b32 v165, v210, v204, v97
	v_perm_b32 v97, v218, v219, v97
	v_and_or_b32 v193, v97, v87, v165
	v_perm_b32 v87, v210, v204, v151
	v_perm_b32 v97, v218, v219, v151
	v_and_b32_e32 v155, 0x7070707, v95
	v_and_b32_e32 v157, 0x7070707, v92
	v_and_b32_e32 v176, 0x7070707, v93
	v_lshrrev_b32_e32 v180, 4, v72
	v_lshrrev_b32_e32 v203, 4, v73
	v_sub_u32_e32 v57, v117, v159
	v_and_b32_e32 v159, 0x7070707, v199
	v_and_or_b32 v165, v97, v88, v87
	v_and_b32_e32 v97, 0x7070707, v175
	v_mul_lo_u32 v140, v140, s49
	v_lshlrev_b32_e32 v167, 4, v92
	v_lshrrev_b32_e32 v202, 4, v89
	v_and_or_b32 v163, v96, v92, v91
	v_perm_b32 v91, v209, v213, v159
	v_perm_b32 v92, v216, v217, v159
	v_and_b32_e32 v151, 0x7070707, v180
	v_and_b32_e32 v175, 0x7070707, v203
	v_perm_b32 v180, v211, v205, v97
	v_perm_b32 v97, v220, v221, v97
	v_perm_b32 v194, v208, v212, v155
	v_perm_b32 v195, v208, v212, v158
	v_perm_b32 v196, v208, v212, v177
	v_perm_b32 v203, v209, v213, v154
	v_perm_b32 v206, v209, v213, v157
	v_perm_b32 v207, v209, v213, v176
	v_perm_b32 v208, v216, v217, v154
	v_perm_b32 v157, v216, v217, v157
	v_perm_b32 v209, v216, v217, v176
	v_cmp_lt_i32_e32 vcc, 11, v141
	v_min_i32_e32 v217, 11, v141
	v_sub_u32_e32 v141, 0x6c686080, v140
	v_and_b32_e32 v174, 0x7070707, v71
	v_lshlrev_b32_e32 v152, 4, v71
	v_and_b32_e32 v178, 0x7070707, v88
	v_and_b32_e32 v179, 0x7070707, v72
	v_and_b32_e32 v182, 0x7070707, v89
	v_and_b32_e32 v183, 0x7070707, v73
	v_and_b32_e32 v159, 0x7070707, v202
	v_and_or_b32 v185, v97, v71, v180
	v_perm_b32 v71, v211, v205, v151
	v_perm_b32 v97, v220, v221, v151
	v_sub_u32_e32 v140, 0x7c787470, v140
	v_and_b32_e32 v141, 0xffffff00, v141
	v_lshlrev_b32_e32 v149, 4, v88
	v_lshlrev_b32_e32 v153, 4, v72
	v_perm_b32 v87, v210, v204, v159
	v_perm_b32 v88, v218, v219, v159
	v_and_or_b32 v180, v97, v72, v71
	v_perm_b32 v71, v211, v205, v175
	v_perm_b32 v72, v220, v221, v175
	v_perm_b32 v155, v214, v215, v155
	v_perm_b32 v197, v214, v215, v158
	v_perm_b32 v202, v214, v215, v177
	v_perm_b32 v212, v210, v204, v173
	v_perm_b32 v213, v210, v204, v178
	v_perm_b32 v176, v210, v204, v182
	v_perm_b32 v204, v218, v219, v173
	v_perm_b32 v210, v218, v219, v178
	v_perm_b32 v177, v218, v219, v182
	v_perm_b32 v214, v211, v205, v174
	v_perm_b32 v215, v211, v205, v179
	v_perm_b32 v158, v211, v205, v183
	v_perm_b32 v174, v220, v221, v174
	v_perm_b32 v211, v220, v221, v179
	v_perm_b32 v173, v220, v221, v183
	v_cndmask_b32_e64 v219, v140, 0, s[0:1]
	v_cndmask_b32_e64 v220, v141, 0, s[0:1]
	v_add_u32_e32 v140, 0x7f7f7f78, v219
	v_add_u32_e32 v141, 0x7f7f7f00, v220
	v_lshlrev_b32_e32 v161, 4, v93
	v_and_b32_e32 v171, 0x7070707, v46
	v_and_b32_e32 v140, 0x80808080, v140
	v_and_b32_e32 v141, 0x80808000, v141
	v_lshlrev_b32_e32 v147, 4, v95
	v_lshlrev_b32_e32 v172, 4, v46
	v_and_or_b32 v218, v202, v162, v196
	v_and_or_b32 v209, v209, v161, v207
	v_perm_b32 v161, v219, v220, v171
	v_perm_b32 v162, v140, v141, v171
	v_and_or_b32 v179, v155, v147, v194
	v_and_or_b32 v161, v162, v172, v161
	v_or_b32_e32 v162, s42, v125
	v_perm_b32 v178, v190, v179, s50
	v_perm_b32 v179, v190, v179, s40
	v_or_b32_e32 v190, v162, v109
	v_or_b32_e32 v162, v162, v126
	ds_read_b64 v[230:231], v190
	ds_read_b64 v[232:233], v162
	v_lshrrev_b32_e32 v54, 4, v44
	v_lshrrev_b32_e32 v55, 4, v49
	v_and_or_b32 v194, v208, v145, v203
	v_or_b32_e32 v171, s42, v124
	v_and_or_b32 v160, v204, v160, v212
	v_and_or_b32 v208, v197, v146, v195
	v_and_or_b32 v167, v157, v167, v206
	v_cmp_lt_i32_e64 s[0:1], 11, v192
	v_min_i32_e32 v172, 11, v192
	v_perm_b32 v202, v191, v194, s50
	v_perm_b32 v203, v191, v194, s40
	v_perm_b32 v206, v193, v160, s50
	v_perm_b32 v207, v193, v160, s40
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[190:193], v[230:231], v[178:179], v[102:105]
	v_lshrrev_b32_e32 v56, 4, v45
	v_or_b32_e32 v160, s42, v123
	v_lshrrev_b32_e32 v170, 4, v42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[194:197], v[232:233], v[178:179], v[98:101]
	v_and_b32_e32 v104, 0x7070707, v54
	v_or_b32_e32 v54, v171, v109
	ds_read_b64 v[234:235], v54
	v_and_b32_e32 v101, 0x7070707, v55
	v_or_b32_e32 v55, v171, v126
	ds_read_b64 v[236:237], v55
	v_lshrrev_b32_e32 v216, 4, v37
	v_cmp_lt_i32_e64 s[2:3], 11, v57
	v_min_i32_e32 v57, 11, v57
	v_or_b32_e32 v204, s42, v122
	v_or_b32_e32 v162, s42, v121
	v_and_b32_e32 v100, 0x7070707, v56
	v_or_b32_e32 v56, v160, v126
	v_lshrrev_b32_e32 v184, 4, v48
	v_lshrrev_b32_e32 v198, 4, v38
	v_lshrrev_b32_e32 v199, 4, v34
	v_lshrrev_b32_e32 v200, 4, v39
	v_lshrrev_b32_e32 v201, 4, v35
	v_lshrrev_b32_e32 v182, 4, v40
	v_lshrrev_b32_e32 v183, 4, v36
	v_and_b32_e32 v221, 0x7070707, v170
	v_or_b32_e32 v170, s42, v120
	v_and_b32_e32 v98, 0x7070707, v216
	v_mul_lo_u32 v216, v57, s49
	v_or_b32_e32 v57, v204, v126
	ds_read_b64 v[178:179], v56
	v_or_b32_e32 v55, v160, v109
	v_or_b32_e32 v160, v162, v109
	v_or_b32_e32 v162, v162, v126
	v_lshrrev_b32_e32 v168, 4, v46
	v_lshrrev_b32_e32 v169, 4, v47
	v_lshrrev_b32_e32 v205, 4, v41
	v_and_b32_e32 v105, 0x7070707, v184
	v_and_b32_e32 v223, 0x7070707, v198
	v_and_b32_e32 v224, 0x7070707, v199
	v_and_b32_e32 v225, 0x7070707, v200
	v_and_b32_e32 v226, 0x7070707, v201
	v_and_b32_e32 v103, 0x7070707, v182
	v_and_b32_e32 v102, 0x7070707, v183
	v_or_b32_e32 v54, s42, v111
	v_mul_lo_u32 v184, v217, s49
	v_mul_lo_u32 v172, v172, s49
	ds_read_b64 v[182:183], v55
	v_mfma_f32_16x16x32_fp8_fp8 v[198:201], v[230:231], v[202:203], v[78:81]
	v_and_b32_e32 v212, 0x7070707, v168
	v_and_b32_e32 v222, 0x7070707, v169
	v_and_b32_e32 v99, 0x7070707, v205
	v_or_b32_e32 v78, v170, v109
	v_or_b32_e32 v79, v170, v126
	ds_read_b64 v[170:171], v57
	ds_read_b64 v[80:81], v162
	v_or_b32_e32 v55, v204, v109
	ds_read_b64 v[168:169], v55
	v_mfma_f32_16x16x32_fp8_fp8 v[202:205], v[232:233], v[202:203], v[74:77]
	v_sub_u32_e32 v217, 0x6c686080, v172
	v_and_or_b32 v152, v174, v152, v214
	v_sub_u32_e32 v162, 0x6c686080, v216
	ds_read_b64 v[74:75], v78
	ds_read2st64_b64 v[54:57], v54 offset1:8
	ds_read_b64 v[76:77], v160
	v_sub_u32_e32 v160, 0x6c686080, v184
	v_sub_u32_e32 v184, 0x7c787470, v184
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[230:231], v[206:207], v[66:69]
	v_cndmask_b32_e64 v227, v184, 0, vcc
	v_and_b32_e32 v184, 0xffffff00, v217
	v_sub_u32_e32 v216, 0x7c787470, v216
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[232:233], v[206:207], v[62:65]
	v_cndmask_b32_e64 v206, v184, 0, s[0:1]
	v_perm_b32 v184, v185, v152, s50
	v_perm_b32 v185, v185, v152, s40
	v_and_or_b32 v149, v210, v149, v213
	v_and_b32_e32 v162, 0xffffff00, v162
	v_cndmask_b32_e64 v216, v216, 0, s[2:3]
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[230:231], v[184:185], v[58:61]
	v_perm_b32 v152, v165, v149, s50
	v_cndmask_b32_e64 v228, v162, 0, s[2:3]
	v_add_u32_e32 v162, 0x7f7f7f78, v216
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[232:233], v[184:185], v[50:53]
	v_perm_b32 v184, v166, v208, s50
	v_perm_b32 v185, v166, v208, s40
	v_and_or_b32 v166, v211, v153, v215
	v_perm_b32 v153, v165, v149, s40
	v_lshlrev_b32_e32 v150, 4, v89
	v_and_b32_e32 v213, 0x80808080, v162
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[234:235], v[152:153], v[66:69]
	v_perm_b32 v162, v163, v167, s50
	v_perm_b32 v163, v163, v167, s40
	v_lshlrev_b32_e32 v148, 4, v73
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[236:237], v[152:153], v[62:65]
	v_and_or_b32 v159, v88, v89, v87
	v_and_or_b32 v149, v177, v150, v176
	v_sub_u32_e32 v172, 0x7c787470, v172
	v_mfma_f32_16x16x32_fp8_fp8 v[190:193], v[234:235], v[184:185], v[190:193]
	v_and_b32_e32 v160, 0xffffff00, v160
	v_and_or_b32 v158, v173, v148, v158
	v_perm_b32 v148, v159, v149, s50
	v_mfma_f32_16x16x32_fp8_fp8 v[194:197], v[236:237], v[184:185], v[194:197]
	v_perm_b32 v149, v159, v149, s40
	v_and_or_b32 v96, v92, v93, v91
	v_cndmask_b32_e64 v172, v172, 0, s[0:1]
	v_mfma_f32_16x16x32_fp8_fp8 v[198:201], v[234:235], v[162:163], v[198:201]
	v_cndmask_b32_e64 v160, v160, 0, vcc
	v_perm_b32 v152, v180, v166, s50
	v_perm_b32 v153, v180, v166, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[202:205], v[236:237], v[162:163], v[202:205]
	v_and_b32_e32 v93, 0x7070707, v38
	v_and_b32_e32 v88, 0x7070707, v34
	v_and_b32_e32 v89, 0x7070707, v39
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[182:183], v[148:149], v[66:69]
	v_and_or_b32 v175, v72, v73, v71
	v_and_b32_e32 v72, 0x7070707, v35
	v_and_b32_e32 v97, 0x7070707, v40
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[178:179], v[148:149], v[62:65]
	v_add_u32_e32 v148, 0x7f7f7f00, v206
	v_and_b32_e32 v154, 0x7070707, v36
	v_and_b32_e32 v145, 0x7070707, v41
	v_and_b32_e32 v155, 0x7070707, v37
	v_add_u32_e32 v217, 0x7f7f7f78, v227
	v_add_u32_e32 v207, 0x7f7f7f78, v172
	v_add_u32_e32 v174, 0x7f7f7f00, v160
	v_add_u32_e32 v208, 0x7f7f7f00, v228
	v_perm_b32 v211, v219, v220, v212
	v_perm_b32 v166, v164, v218, s50
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[234:235], v[152:153], v[58:61]
	v_perm_b32 v167, v164, v218, s40
	v_and_b32_e32 v240, 0x80808000, v148
	v_perm_b32 v148, v140, v141, v212
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[236:237], v[152:153], v[50:53]
	v_perm_b32 v152, v96, v209, s50
	v_perm_b32 v153, v96, v209, s40
	v_and_b32_e32 v143, 0x7070707, v42
	v_and_b32_e32 v217, 0x80808080, v217
	v_perm_b32 v210, v216, v228, v93
	v_perm_b32 v184, v172, v206, v88
	v_perm_b32 v185, v216, v228, v89
	v_perm_b32 v150, v216, v228, v223
	v_mfma_f32_16x16x32_fp8_fp8 v[162:165], v[182:183], v[166:167], v[190:193]
	v_perm_b32 v236, v172, v206, v224
	v_perm_b32 v96, v216, v228, v225
	v_perm_b32 v209, v172, v206, v72
	v_mfma_f32_16x16x32_fp8_fp8 v[190:193], v[178:179], v[166:167], v[194:197]
	v_perm_b32 v237, v172, v206, v226
	v_perm_b32 v238, v216, v228, v97
	v_perm_b32 v239, v172, v206, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[194:197], v[182:183], v[152:153], v[198:201]
	v_and_b32_e32 v208, 0x80808000, v208
	v_and_or_b32 v46, v148, v46, v211
	v_lshlrev_b32_e32 v142, 4, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[198:201], v[178:179], v[152:153], v[202:205]
	v_perm_b32 v214, v227, v160, v143
	v_perm_b32 v215, v227, v160, v221
	v_perm_b32 v148, v46, v161, s50
	v_perm_b32 v202, v216, v228, v103
	v_perm_b32 v203, v172, v206, v154
	v_perm_b32 v204, v172, v206, v102
	v_perm_b32 v205, v216, v228, v145
	v_perm_b32 v216, v216, v228, v99
	v_perm_b32 v228, v172, v206, v155
	v_and_b32_e32 v206, 0x80808080, v207
	v_and_b32_e32 v207, 0x80808000, v174
	v_perm_b32 v143, v217, v207, v143
	v_perm_b32 v149, v46, v161, s40
	v_perm_b32 v46, v213, v208, v93
	v_perm_b32 v93, v217, v207, v221
	v_and_or_b32 v143, v143, v142, v214
	v_and_or_b32 v42, v93, v42, v215
	v_lshlrev_b32_e32 v92, 4, v38
	v_perm_b32 v142, v42, v143, s50
	v_perm_b32 v143, v42, v143, s40
	v_perm_b32 v42, v206, v240, v88
	v_perm_b32 v88, v213, v208, v223
	v_lshrrev_b32_e32 v181, 4, v43
	v_and_or_b32 v46, v46, v92, v210
	v_and_or_b32 v38, v88, v38, v150
	v_and_b32_e32 v144, 0x7070707, v47
	v_and_b32_e32 v156, 0x7070707, v43
	v_and_b32_e32 v70, 0x7070707, v48
	v_and_b32_e32 v94, 0x7070707, v44
	v_and_b32_e32 v82, 0x7070707, v49
	v_and_b32_e32 v95, 0x7070707, v45
	v_lshlrev_b32_e32 v87, 4, v34
	v_and_b32_e32 v181, 0x7070707, v181
	v_perm_b32 v152, v175, v158, s50
	v_perm_b32 v153, v175, v158, s40
	v_perm_b32 v92, v38, v46, s50
	v_perm_b32 v93, v38, v46, s40
	v_perm_b32 v46, v206, v240, v224
	v_perm_b32 v229, v219, v220, v144
	v_perm_b32 v230, v227, v160, v156
	v_perm_b32 v231, v219, v220, v222
	v_perm_b32 v232, v227, v160, v181
	v_perm_b32 v233, v219, v220, v70
	v_perm_b32 v180, v219, v220, v105
	v_perm_b32 v218, v227, v160, v94
	v_perm_b32 v234, v227, v160, v104
	v_perm_b32 v235, v219, v220, v82
	v_perm_b32 v219, v219, v220, v101
	v_perm_b32 v220, v227, v160, v95
	v_perm_b32 v227, v227, v160, v100
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[182:183], v[152:153], v[58:61]
	v_and_or_b32 v42, v42, v87, v184
	v_and_or_b32 v34, v46, v34, v236
	v_lshlrev_b32_e32 v84, 4, v47
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[178:179], v[152:153], v[50:53]
	ds_read_b64 v[78:79], v79
	v_perm_b32 v144, v140, v141, v144
	v_perm_b32 v38, v213, v208, v89
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[158:161], v[168:169], v[148:149], v[162:165]
	v_perm_b32 v88, v34, v42, s50
	v_perm_b32 v89, v34, v42, s40
	v_perm_b32 v34, v140, v141, v222
	v_mfma_f32_16x16x32_fp8_fp8 v[162:165], v[170:171], v[148:149], v[190:193]
	v_lshlrev_b32_e32 v83, 4, v43
	v_perm_b32 v156, v217, v207, v156
	v_perm_b32 v42, v217, v207, v181
	v_mfma_f32_16x16x32_fp8_fp8 v[172:175], v[168:169], v[142:143], v[194:197]
	v_and_or_b32 v84, v144, v84, v229
	v_and_or_b32 v34, v34, v47, v231
	v_perm_b32 v46, v34, v84, s50
	v_mfma_f32_16x16x32_fp8_fp8 v[176:179], v[170:171], v[142:143], v[198:201]
	v_perm_b32 v47, v34, v84, s40
	v_and_or_b32 v83, v156, v83, v230
	v_and_or_b32 v43, v42, v43, v232
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[168:169], v[92:93], v[66:69]
	v_lshlrev_b32_e32 v71, 4, v39
	v_lshlrev_b32_e32 v73, 4, v35
	v_perm_b32 v34, v213, v208, v225
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[170:171], v[92:93], v[62:65]
	v_perm_b32 v72, v206, v240, v72
	v_perm_b32 v42, v43, v83, s50
	v_perm_b32 v43, v43, v83, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[168:169], v[88:89], v[58:61]
	v_and_or_b32 v34, v34, v39, v96
	v_lshlrev_b32_e32 v85, 4, v48
	v_lshlrev_b32_e32 v90, 4, v44
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[170:171], v[88:89], v[50:53]
	v_lshlrev_b32_e32 v151, 4, v40
	v_lshlrev_b32_e32 v147, 4, v36
	v_lshlrev_b32_e32 v86, 4, v49
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[158:161], v[76:77], v[46:47], v[158:161]
	v_lshlrev_b32_e32 v91, 4, v45
	v_lshlrev_b32_e32 v146, 4, v41
	v_lshlrev_b32_e32 v157, 4, v37
	v_mfma_f32_16x16x32_fp8_fp8 v[162:165], v[80:81], v[46:47], v[162:165]
	v_perm_b32 v46, v206, v240, v226
	v_and_or_b32 v47, v38, v71, v185
	v_and_or_b32 v35, v46, v35, v237
	v_mfma_f32_16x16x32_fp8_fp8 v[166:169], v[76:77], v[42:43], v[172:175]
	v_perm_b32 v38, v34, v47, s50
	v_perm_b32 v39, v34, v47, s40
	v_perm_b32 v46, v217, v207, v94
	v_mfma_f32_16x16x32_fp8_fp8 v[170:173], v[80:81], v[42:43], v[176:179]
	v_and_or_b32 v42, v72, v73, v209
	v_perm_b32 v34, v35, v42, s50
	v_perm_b32 v35, v35, v42, s40
	v_perm_b32 v42, v140, v141, v70
	v_perm_b32 v43, v140, v141, v105
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[76:77], v[38:39], v[66:69]
	s_cmp_lg_u32 s45, 15
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[80:81], v[38:39], v[62:65]
	v_perm_b32 v38, v217, v207, v104
	v_and_or_b32 v39, v42, v85, v233
	v_and_or_b32 v42, v43, v48, v180
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[76:77], v[34:35], v[58:61]
	v_and_or_b32 v43, v46, v90, v218
	v_perm_b32 v46, v206, v240, v102
	v_and_or_b32 v36, v46, v36, v204
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[80:81], v[34:35], v[50:53]
	v_perm_b32 v34, v42, v39, s50
	v_perm_b32 v35, v42, v39, s40
	v_and_or_b32 v39, v38, v44, v234
	v_perm_b32 v38, v39, v43, s50
	v_perm_b32 v39, v39, v43, s40
	v_perm_b32 v42, v213, v208, v97
	v_perm_b32 v43, v213, v208, v103
	v_perm_b32 v44, v206, v240, v154
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[74:75], v[34:35], v[158:161]
	v_and_or_b32 v40, v43, v40, v202
	v_perm_b32 v43, v217, v207, v100
	s_waitcnt vmcnt(11)
	v_mov_b32_e32 v100, v139
	v_mfma_f32_16x16x32_fp8_fp8 v[158:161], v[74:75], v[38:39], v[166:169]
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[162:165], v[78:79], v[34:35], v[162:165]
	v_and_or_b32 v35, v42, v151, v238
	v_perm_b32 v34, v40, v35, s50
	v_perm_b32 v35, v40, v35, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[78:79], v[38:39], v[170:173]
	v_and_or_b32 v39, v44, v147, v203
	v_perm_b32 v38, v36, v39, s50
	v_perm_b32 v39, v36, v39, s40
	v_perm_b32 v36, v140, v141, v82
	v_perm_b32 v40, v140, v141, v101
	v_mfma_f32_16x16x32_fp8_fp8 v[148:151], v[74:75], v[34:35], v[66:69]
	v_perm_b32 v42, v217, v207, v95
	v_mfma_f32_16x16x32_fp8_fp8 v[92:95], v[78:79], v[34:35], v[62:65]
	v_and_or_b32 v35, v36, v86, v235
	v_and_or_b32 v36, v40, v49, v219
	v_perm_b32 v34, v36, v35, s50
	v_mfma_f32_16x16x32_fp8_fp8 v[166:169], v[74:75], v[38:39], v[58:61]
	v_perm_b32 v35, v36, v35, s40
	v_and_or_b32 v36, v43, v45, v227
	v_perm_b32 v40, v213, v208, v99
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[78:79], v[38:39], v[50:53]
	v_and_or_b32 v39, v42, v91, v220
	v_perm_b32 v38, v36, v39, s50
	v_perm_b32 v39, v36, v39, s40
	v_perm_b32 v36, v213, v208, v145
	v_perm_b32 v42, v206, v240, v155
	v_perm_b32 v43, v206, v240, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[54:55], v[34:35], v[70:73]
	v_and_or_b32 v37, v43, v37, v239
	s_waitcnt vmcnt(9)
	v_mov_b32_e32 v99, v137
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[54:55], v[38:39], v[158:161]
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[56:57], v[34:35], v[162:165]
	v_and_or_b32 v35, v36, v146, v205
	v_and_or_b32 v36, v40, v41, v216
	v_perm_b32 v34, v36, v35, s50
	v_mfma_f32_16x16x32_fp8_fp8 v[82:85], v[56:57], v[38:39], v[102:105]
	v_and_or_b32 v38, v42, v157, v228
	v_perm_b32 v35, v36, v35, s40
	v_perm_b32 v36, v37, v38, s50
	v_perm_b32 v37, v37, v38, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[54:55], v[34:35], v[148:151]
	v_lshl_or_b32 v38, s41, 11, v138
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[54:55], v[36:37], v[166:169]
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[56:57], v[34:35], v[92:95]
	v_xor_b32_e32 v34, 0x800, v38
	v_lshlrev_b32_e32 v34, 2, v34
	ds_write_b128 v34, v[186:189]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[56:57], v[36:37], v[46:49]
	s_cbranch_scc1 .LBB0_2
	v_sub_u32_sdwa v34, v116, v139 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v35, 11, v34
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	s_waitcnt vmcnt(3)
	v_lshlrev_b32_e32 v37, 4, v30
	v_cndmask_b32_e64 v86, v36, 0, vcc
	v_cndmask_b32_e64 v87, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v86
	v_and_b32_e32 v88, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v87
	v_and_b32_e32 v89, 0x80808080, v34
	v_sub_u32_sdwa v34, v114, v137 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	s_mov_b32 s41, 0x5010400
	v_cndmask_b32_e64 v94, v36, 0, vcc
	v_cndmask_b32_e64 v95, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v94
	v_and_b32_e32 v96, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v95
	v_and_b32_e32 v97, 0x80808080, v34
	v_and_b32_e32 v34, 0x7070707, v30
	v_lshrrev_b32_e32 v35, 4, v30
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v89, v88, v34
	v_perm_b32 v34, v87, v86, v34
	v_and_or_b32 v34, v36, v37, v34
	v_perm_b32 v36, v89, v88, v35
	v_perm_b32 v35, v87, v86, v35
	v_and_or_b32 v30, v36, v30, v35
	s_mov_b32 s42, 0x7030602
	v_perm_b32 v42, v30, v34, s41
	v_perm_b32 v43, v30, v34, s42
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v34, 4, v26
	v_and_b32_e32 v34, 0x7070707, v34
	v_perm_b32 v38, v97, v96, v34
	v_perm_b32 v39, v95, v94, v34
	v_or_b32_e32 v34, v110, v126
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[90:91], v133 offset:8192
	ds_read_b64 v[92:93], v34 offset:8192
	v_and_b32_e32 v30, 0x7070707, v26
	v_perm_b32 v35, v97, v96, v30
	v_lshlrev_b32_e32 v36, 4, v26
	v_perm_b32 v30, v95, v94, v30
	v_and_or_b32 v30, v35, v36, v30
	v_and_or_b32 v26, v38, v26, v39
	v_sub_u32_sdwa v70, v116, v139 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v44, v26, v30, s41
	v_perm_b32 v45, v26, v30, s42
	v_min_i32_e32 v26, 11, v70
	v_mul_lo_u32 v26, v26, s40
	v_sub_u32_e32 v30, 0x6c686080, v26
	v_and_b32_e32 v71, 0xffffff00, v30
	v_sub_u32_e32 v72, 0x7c787470, v26
	v_and_b32_e32 v26, 0x7070707, v31
	v_lshrrev_b32_e32 v30, 4, v31
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[90:91], v[42:43], v[66:69]
	v_and_b32_e32 v30, 0x7070707, v30
	v_lshrrev_b32_e32 v73, 4, v27
	v_and_b32_e32 v73, 0x7070707, v73
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[92:93], v[42:43], v[74:77]
	v_perm_b32 v42, v89, v88, v26
	v_lshlrev_b32_e32 v43, 4, v31
	v_perm_b32 v26, v87, v86, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[92:93], v[44:45], v[82:85]
	v_and_or_b32 v26, v42, v43, v26
	v_perm_b32 v42, v89, v88, v30
	v_perm_b32 v30, v87, v86, v30
	v_add_u32_e32 v83, v109, v125
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[90:91], v[44:45], v[78:81]
	v_and_or_b32 v31, v42, v31, v30
	ds_read2st64_b64 v[42:45], v83 offset0:16 offset1:24
	v_perm_b32 v30, v31, v26, s41
	v_perm_b32 v31, v31, v26, s42
	v_and_b32_e32 v26, 0x7070707, v27
	v_perm_b32 v74, v97, v96, v26
	v_lshlrev_b32_e32 v75, 4, v27
	v_perm_b32 v26, v95, v94, v26
	v_and_or_b32 v74, v74, v75, v26
	v_perm_b32 v26, v97, v96, v73
	v_perm_b32 v73, v95, v94, v73
	v_and_or_b32 v27, v26, v27, v73
	v_cmp_lt_i32_e32 vcc, 11, v70
	v_perm_b32 v26, v27, v74, s41
	v_perm_b32 v27, v27, v74, s42
	v_cndmask_b32_e64 v98, v72, 0, vcc
	v_add_u32_e32 v84, v109, v124
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[42:43], v[30:31], v[34:37]
	v_cndmask_b32_e64 v82, v71, 0, vcc
	v_add_u32_e32 v74, 0x7f7f7f00, v82
	v_and_b32_e32 v99, 0x80808000, v74
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[42:43], v[26:27], v[38:41]
	v_lshlrev_b32_e32 v74, 4, v28
	v_sub_u32_sdwa v101, v114, v137 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_add_u32_e32 v85, v109, v123
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[44:45], v[30:31], v[46:49]
	v_add_u32_e32 v30, 0x7f7f7f78, v98
	v_and_b32_e32 v100, 0x80808080, v30
	v_lshlrev_b32_e32 v31, 4, v32
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[44:45], v[26:27], v[66:69]
	v_and_b32_e32 v26, 0x7070707, v32
	v_lshrrev_b32_e32 v27, 4, v32
	ds_read2st64_b64 v[46:49], v84 offset0:16 offset1:24
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v30, v89, v88, v26
	v_perm_b32 v26, v87, v86, v26
	v_and_or_b32 v30, v30, v31, v26
	v_perm_b32 v26, v89, v88, v27
	v_perm_b32 v27, v87, v86, v27
	v_and_or_b32 v27, v26, v32, v27
	v_perm_b32 v26, v27, v30, s41
	v_perm_b32 v27, v27, v30, s42
	v_and_b32_e32 v30, 0x7070707, v28
	v_lshrrev_b32_e32 v31, 4, v28
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v97, v96, v30
	v_perm_b32 v30, v95, v94, v30
	v_and_or_b32 v32, v32, v74, v30
	v_perm_b32 v30, v97, v96, v31
	v_perm_b32 v31, v95, v94, v31
	v_and_or_b32 v28, v30, v28, v31
	v_perm_b32 v30, v28, v32, s41
	v_perm_b32 v31, v28, v32, s42
	v_min_i32_e32 v28, 11, v101
	v_mul_lo_u32 v28, v28, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[74:77], v[48:49], v[30:31], v[66:69]
	v_sub_u32_e32 v103, 0x7c787470, v28
	v_cmp_lt_i32_e32 vcc, 11, v101
	s_ashr_i32 s45, s44, 31
	ds_read2st64_b64 v[66:69], v85 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[46:47], v[26:27], v[34:37]
	v_cndmask_b32_e64 v101, v103, 0, vcc
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[48:49], v[26:27], v[70:73]
	v_sub_u32_e32 v26, 0x6c686080, v28
	v_and_b32_e32 v102, 0xffffff00, v26
	v_and_b32_e32 v26, 0x7070707, v33
	v_lshrrev_b32_e32 v27, 4, v33
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[46:47], v[30:31], v[38:41]
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v89, v88, v26
	v_lshlrev_b32_e32 v30, 4, v33
	v_perm_b32 v26, v87, v86, v26
	v_and_or_b32 v26, v28, v30, v26
	v_perm_b32 v28, v89, v88, v27
	v_perm_b32 v27, v87, v86, v27
	v_and_or_b32 v27, v28, v33, v27
	v_perm_b32 v78, v27, v26, s41
	v_perm_b32 v79, v27, v26, s42
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v97, v96, v26
	v_lshlrev_b32_e32 v30, 4, v29
	v_perm_b32 v26, v95, v94, v26
	v_and_or_b32 v26, v28, v30, v26
	v_perm_b32 v28, v97, v96, v27
	v_perm_b32 v27, v95, v94, v27
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[66:67], v[78:79], v[34:37]
	v_and_or_b32 v27, v28, v29, v27
	v_perm_b32 v80, v27, v26, s41
	v_perm_b32 v81, v27, v26, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[68:69], v[78:79], v[70:73]
	v_cndmask_b32_e64 v88, v102, 0, vcc
	v_add_u32_e32 v86, v109, v122
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v78, 4, v18
	v_and_b32_e32 v70, 0x7070707, v22
	v_lshrrev_b32_e32 v71, 4, v22
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v100, v99, v70
	v_lshlrev_b32_e32 v73, 4, v22
	v_perm_b32 v70, v98, v82, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[66:67], v[80:81], v[38:41]
	v_and_or_b32 v70, v72, v73, v70
	v_perm_b32 v72, v100, v99, v71
	v_perm_b32 v71, v98, v82, v71
	v_add_u32_e32 v38, 0x7f7f7f00, v88
	v_and_b32_e32 v102, 0x80808000, v38
	v_add_u32_e32 v38, 0x7f7f7f78, v101
	v_and_or_b32 v22, v72, v22, v71
	v_and_b32_e32 v103, 0x80808080, v38
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[68:69], v[80:81], v[74:77]
	v_add_u32_e32 v87, v109, v121
	v_lshlrev_b32_e32 v80, 4, v19
	v_add_u32_e32 v89, v109, v120
	v_perm_b32 v74, v22, v70, s41
	v_perm_b32 v75, v22, v70, s42
	ds_read2st64_b64 v[70:73], v86 offset0:16 offset1:24
	v_and_b32_e32 v22, 0x7070707, v18
	v_lshrrev_b32_e32 v76, 4, v18
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v77, v103, v102, v22
	v_perm_b32 v22, v101, v88, v22
	v_and_or_b32 v22, v77, v78, v22
	v_perm_b32 v77, v103, v102, v76
	v_perm_b32 v76, v101, v88, v76
	v_and_or_b32 v18, v77, v18, v76
	v_perm_b32 v76, v18, v22, s41
	v_perm_b32 v77, v18, v22, s42
	v_and_b32_e32 v18, 0x7070707, v23
	v_lshrrev_b32_e32 v22, 4, v23
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[70:71], v[74:75], v[30:33]
	v_and_b32_e32 v22, 0x7070707, v22
	v_lshrrev_b32_e32 v78, 4, v19
	v_and_b32_e32 v78, 0x7070707, v78
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[72:73], v[74:75], v[34:37]
	v_perm_b32 v74, v100, v99, v18
	v_lshlrev_b32_e32 v75, 4, v23
	v_perm_b32 v18, v98, v82, v18
	v_and_or_b32 v18, v74, v75, v18
	v_perm_b32 v74, v100, v99, v22
	v_perm_b32 v22, v98, v82, v22
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[70:71], v[76:77], v[26:29]
	v_and_or_b32 v23, v74, v23, v22
	v_perm_b32 v22, v23, v18, s41
	v_perm_b32 v23, v23, v18, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[72:73], v[76:77], v[38:41]
	ds_read2st64_b64 v[74:77], v87 offset0:16 offset1:24
	v_and_b32_e32 v18, 0x7070707, v19
	v_perm_b32 v79, v103, v102, v18
	v_perm_b32 v18, v101, v88, v18
	v_and_or_b32 v79, v79, v80, v18
	v_perm_b32 v18, v103, v102, v78
	v_perm_b32 v78, v101, v88, v78
	v_and_or_b32 v19, v18, v19, v78
	v_perm_b32 v18, v19, v79, s41
	v_perm_b32 v19, v19, v79, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[74:75], v[22:23], v[30:33]
	v_lshlrev_b32_e32 v94, 4, v20
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s6
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[76:77], v[18:19], v[38:41]
	s_movk_i32 s43, 0x7fff
	s_mulk_i32 s11, 0xe00
	s_and_b32 s25, s23, 0xffff
	ds_read2st64_b64 v[38:41], v89 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[74:75], v[18:19], v[26:29]
	v_and_b32_e32 v18, 0x7070707, v24
	v_lshrrev_b32_e32 v19, 4, v24
	v_and_b32_e32 v19, 0x7070707, v19
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[76:77], v[22:23], v[34:37]
	v_perm_b32 v22, v100, v99, v18
	v_lshlrev_b32_e32 v23, 4, v24
	v_perm_b32 v18, v98, v82, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v100, v99, v19
	v_perm_b32 v19, v98, v82, v19
	v_and_or_b32 v19, v18, v24, v19
	v_perm_b32 v18, v19, v22, s41
	v_perm_b32 v19, v19, v22, s42
	v_and_b32_e32 v22, 0x7070707, v20
	v_lshrrev_b32_e32 v23, 4, v20
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v103, v102, v22
	v_perm_b32 v22, v101, v88, v22
	v_and_or_b32 v24, v24, v94, v22
	v_perm_b32 v22, v103, v102, v23
	v_perm_b32 v23, v101, v88, v23
	v_and_or_b32 v20, v22, v20, v23
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[38:39], v[18:19], v[30:33]
	v_perm_b32 v22, v20, v24, s41
	v_perm_b32 v23, v20, v24, s42
	v_lshlrev_b32_e32 v24, 4, v21
	v_mfma_f32_16x16x32_fp8_fp8 v[94:97], v[40:41], v[18:19], v[34:37]
	v_and_b32_e32 v18, 0x7070707, v25
	v_lshrrev_b32_e32 v19, 4, v25
	v_and_b32_e32 v19, 0x7070707, v19
	ds_read2st64_b64 v[34:37], v111 offset0:16 offset1:24
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[38:39], v[22:23], v[26:29]
	v_perm_b32 v20, v100, v99, v18
	v_perm_b32 v18, v98, v82, v18
	s_mov_b32 s26, -1
	v_mfma_f32_16x16x32_fp8_fp8 v[78:81], v[40:41], v[22:23], v[78:81]
	v_lshlrev_b32_e32 v22, 4, v25
	v_and_or_b32 v20, v20, v22, v18
	v_perm_b32 v18, v100, v99, v19
	v_perm_b32 v19, v98, v82, v19
	v_and_or_b32 v19, v18, v25, v19
	v_perm_b32 v18, v19, v20, s41
	v_perm_b32 v19, v19, v20, s42
	v_and_b32_e32 v20, 0x7070707, v21
	v_lshrrev_b32_e32 v22, 4, v21
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v103, v102, v20
	v_perm_b32 v20, v101, v88, v20
	v_and_or_b32 v23, v23, v24, v20
	v_perm_b32 v20, v103, v102, v22
	v_perm_b32 v22, v101, v88, v22
	v_and_or_b32 v21, v20, v21, v22
	v_perm_b32 v20, v21, v23, s41
	v_perm_b32 v21, v21, v23, s42
	v_bfe_u32 v82, v119, s12, 8
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[34:35], v[18:19], v[30:33]
	v_lshlrev_b32_e32 v102, 4, v10
	v_bfe_u32 v88, v119, s13, 8
	v_sub_u32_e32 v88, v117, v88
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[34:35], v[20:21], v[26:29]
	s_add_i32 s12, s46, s11
	s_mov_b32 s24, s22
	s_mov_b32 s27, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[36:37], v[18:19], v[94:97]
	s_mov_b32 s6, 0x400000
	s_mov_b32 s28, s14
	s_mov_b32 s31, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[36:37], v[20:21], v[78:81]
	v_bfe_u32 v94, v118, s8, 8
	v_bfe_u32 v95, v118, s10, 8
	s_mov_b32 s50, s6
	v_sub_u32_e32 v78, v117, v82
	v_min_i32_e32 v79, 11, v78
	v_mul_lo_u32 v79, v79, s40
	v_sub_u32_e32 v80, 0x6c686080, v79
	v_and_b32_e32 v80, 0xffffff00, v80
	v_cmp_lt_i32_e32 vcc, 11, v78
	v_sub_u32_e32 v79, 0x7c787470, v79
	v_lshlrev_b32_e32 v81, 4, v14
	v_cndmask_b32_e64 v82, v80, 0, vcc
	v_cndmask_b32_e64 v96, v79, 0, vcc
	v_add_u32_e32 v78, 0x7f7f7f00, v82
	v_and_b32_e32 v97, 0x80808000, v78
	v_add_u32_e32 v78, 0x7f7f7f78, v96
	v_and_b32_e32 v98, 0x80808080, v78
	v_sub_u32_e32 v78, v115, v94
	v_min_i32_e32 v79, 11, v78
	v_mul_lo_u32 v79, v79, s40
	v_sub_u32_e32 v80, 0x6c686080, v79
	v_and_b32_e32 v80, 0xffffff00, v80
	v_cmp_lt_i32_e32 vcc, 11, v78
	v_sub_u32_e32 v79, 0x7c787470, v79
	s_mov_b32 s51, s3
	v_cndmask_b32_e64 v94, v80, 0, vcc
	v_cndmask_b32_e64 v99, v79, 0, vcc
	v_add_u32_e32 v78, 0x7f7f7f00, v94
	v_and_b32_e32 v100, 0x80808000, v78
	v_add_u32_e32 v78, 0x7f7f7f78, v99
	v_and_b32_e32 v101, 0x80808080, v78
	v_and_b32_e32 v78, 0x7070707, v14
	v_lshrrev_b32_e32 v79, 4, v14
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v98, v97, v78
	v_perm_b32 v78, v96, v82, v78
	v_and_or_b32 v80, v80, v81, v78
	v_perm_b32 v78, v98, v97, v79
	v_perm_b32 v79, v96, v82, v79
	v_and_or_b32 v14, v78, v14, v79
	v_perm_b32 v78, v14, v80, s41
	v_perm_b32 v79, v14, v80, s42
	v_and_b32_e32 v14, 0x7070707, v10
	v_lshrrev_b32_e32 v80, 4, v10
	v_and_b32_e32 v80, 0x7070707, v80
	v_perm_b32 v81, v101, v100, v14
	v_perm_b32 v14, v99, v94, v14
	v_and_or_b32 v14, v81, v102, v14
	v_perm_b32 v81, v101, v100, v80
	v_perm_b32 v80, v99, v94, v80
	v_and_or_b32 v10, v81, v10, v80
	v_perm_b32 v80, v10, v14, s41
	v_perm_b32 v81, v10, v14, s42
	v_min_i32_e32 v10, 11, v88
	v_mul_lo_u32 v10, v10, s40
	v_sub_u32_e32 v14, 0x6c686080, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[90:91], v[78:79], v[58:61]
	v_cmp_lt_i32_e32 vcc, 11, v88
	v_mov_b32_e32 v88, 0xfd800000
	s_mov_b32 s10, 0x800000
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[92:93], v[78:79], v[50:53]
	v_and_b32_e32 v78, 0xffffff00, v14
	v_sub_u32_e32 v79, 0x7c787470, v10
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v14, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[90:91], v[80:81], v[62:65]
	v_and_b32_e32 v14, 0x7070707, v14
	v_lshlrev_b32_e32 v90, 4, v11
	v_cndmask_b32_e64 v78, v78, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[92:93], v[80:81], v[54:57]
	v_perm_b32 v80, v98, v97, v10
	v_lshlrev_b32_e32 v81, 4, v15
	v_perm_b32 v10, v96, v82, v10
	v_and_or_b32 v10, v80, v81, v10
	v_perm_b32 v80, v98, v97, v14
	v_perm_b32 v14, v96, v82, v14
	v_and_or_b32 v15, v80, v15, v14
	v_perm_b32 v14, v15, v10, s41
	v_perm_b32 v15, v15, v10, s42
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v80, 4, v11
	v_and_b32_e32 v80, 0x7070707, v80
	v_perm_b32 v81, v101, v100, v10
	v_perm_b32 v10, v99, v94, v10
	v_and_or_b32 v81, v81, v90, v10
	v_perm_b32 v10, v101, v100, v80
	v_perm_b32 v80, v99, v94, v80
	v_and_or_b32 v11, v10, v11, v80
	v_perm_b32 v10, v11, v81, s41
	v_perm_b32 v11, v11, v81, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[42:43], v[14:15], v[58:61]
	v_cndmask_b32_e64 v79, v79, 0, vcc
	s_mov_b32 s36, s16
	s_mov_b32 s38, s10
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[42:43], v[10:11], v[62:65]
	v_add_u32_e32 v42, 0x7f7f7f00, v78
	v_and_b32_e32 v80, 0x80808000, v42
	s_mov_b32 s39, s3
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[44:45], v[14:15], v[50:53]
	v_add_u32_e32 v14, 0x7f7f7f78, v79
	v_and_b32_e32 v81, 0x80808080, v14
	v_lshlrev_b32_e32 v15, 4, v16
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[44:45], v[10:11], v[54:57]
	v_and_b32_e32 v10, 0x7070707, v16
	v_lshrrev_b32_e32 v11, 4, v16
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v14, v98, v97, v10
	v_perm_b32 v10, v96, v82, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v98, v97, v11
	v_perm_b32 v11, v96, v82, v11
	v_and_or_b32 v11, v10, v16, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v14, 0x7070707, v12
	v_lshrrev_b32_e32 v15, 4, v12
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v101, v100, v14
	v_lshlrev_b32_e32 v54, 4, v12
	v_perm_b32 v14, v99, v94, v14
	v_and_or_b32 v16, v16, v54, v14
	v_perm_b32 v14, v101, v100, v15
	v_perm_b32 v15, v99, v94, v15
	v_and_or_b32 v12, v14, v12, v15
	v_perm_b32 v14, v12, v16, s41
	v_perm_b32 v15, v12, v16, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[46:47], v[10:11], v[58:61]
	s_mov_b32 s11, s3
	s_mov_b32 s8, s16
	s_add_i32 s16, s12, 1
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[46:47], v[14:15], v[62:65]
	s_mov_b32 s22, s26
	s_mov_b32 s23, s3
	s_nop 0
	v_sub_u32_e32 v62, v115, v95
	v_min_i32_e32 v12, 11, v62
	v_mul_lo_u32 v12, v12, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[48:49], v[10:11], v[50:53]
	v_sub_u32_e32 v10, 0x6c686080, v12
	v_and_b32_e32 v63, 0xffffff00, v10
	v_and_b32_e32 v10, 0x7070707, v17
	v_lshrrev_b32_e32 v11, 4, v17
	v_sub_u32_e32 v64, 0x7c787470, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[48:49], v[14:15], v[42:45]
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v98, v97, v10
	v_lshlrev_b32_e32 v14, 4, v17
	v_perm_b32 v10, v96, v82, v10
	v_and_or_b32 v10, v12, v14, v10
	v_perm_b32 v12, v98, v97, v11
	v_perm_b32 v11, v96, v82, v11
	v_and_or_b32 v11, v12, v17, v11
	v_perm_b32 v46, v11, v10, s41
	v_perm_b32 v47, v11, v10, s42
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_cmp_lt_i32_e32 vcc, 11, v62
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v101, v100, v10
	v_lshlrev_b32_e32 v14, 4, v13
	v_perm_b32 v10, v99, v94, v10
	v_cndmask_b32_e64 v62, v64, 0, vcc
	v_and_or_b32 v10, v12, v14, v10
	v_perm_b32 v12, v101, v100, v11
	v_perm_b32 v11, v99, v94, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[66:67], v[46:47], v[54:57]
	v_and_or_b32 v11, v12, v13, v11
	v_and_b32_e32 v94, 0x3f0, v106
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[68:69], v[46:47], v[50:53]
	v_perm_b32 v54, v11, v10, s41
	v_perm_b32 v55, v11, v10, s42
	s_nop 0
	v_add_u32_e32 v50, 0x7f7f7f78, v62
	v_and_b32_e32 v64, 0x80808080, v50
	v_and_b32_e32 v50, 0x7070707, v6
	v_lshrrev_b32_e32 v51, 4, v6
	v_and_b32_e32 v51, 0x7070707, v51
	v_perm_b32 v52, v81, v80, v50
	v_lshlrev_b32_e32 v53, 4, v6
	v_perm_b32 v50, v79, v78, v50
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[66:67], v[54:55], v[58:61]
	v_and_or_b32 v52, v52, v53, v50
	v_perm_b32 v50, v81, v80, v51
	v_perm_b32 v51, v79, v78, v51
	v_cndmask_b32_e64 v61, v63, 0, vcc
	v_add_u32_e32 v56, 0x7f7f7f00, v61
	v_and_or_b32 v6, v50, v6, v51
	v_and_b32_e32 v63, 0x80808000, v56
	v_perm_b32 v50, v6, v52, s41
	v_perm_b32 v51, v6, v52, s42
	v_and_b32_e32 v6, 0x7070707, v2
	v_lshrrev_b32_e32 v52, 4, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[68:69], v[54:55], v[42:45]
	v_and_b32_e32 v52, 0x7070707, v52
	v_perm_b32 v53, v64, v63, v6
	v_lshlrev_b32_e32 v54, 4, v2
	v_perm_b32 v6, v62, v61, v6
	v_and_or_b32 v6, v53, v54, v6
	v_perm_b32 v53, v64, v63, v52
	v_perm_b32 v52, v62, v61, v52
	v_and_or_b32 v2, v53, v2, v52
	v_perm_b32 v52, v2, v6, s41
	v_perm_b32 v53, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[70:71], v[50:51], v[14:17]
	v_and_b32_e32 v6, 0x7070707, v6
	v_cmp_lt_i32_e32 vcc, 5, v117
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[72:73], v[50:51], v[46:49]
	v_perm_b32 v50, v81, v80, v2
	v_lshlrev_b32_e32 v51, 4, v7
	v_perm_b32 v2, v79, v78, v2
	v_and_or_b32 v2, v50, v51, v2
	v_perm_b32 v50, v81, v80, v6
	v_perm_b32 v6, v79, v78, v6
	v_and_or_b32 v7, v50, v7, v6
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v50, 4, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[70:71], v[52:53], v[10:13]
	v_and_b32_e32 v50, 0x7070707, v50
	v_perm_b32 v51, v64, v63, v2
	v_perm_b32 v2, v62, v61, v2
	v_mfma_f32_16x16x32_fp8_fp8 v[42:45], v[72:73], v[52:53], v[42:45]
	v_lshlrev_b32_e32 v52, 4, v3
	v_and_or_b32 v51, v51, v52, v2
	v_perm_b32 v2, v64, v63, v50
	v_perm_b32 v50, v62, v61, v50
	v_and_or_b32 v3, v2, v3, v50
	v_perm_b32 v2, v3, v51, s41
	v_perm_b32 v3, v3, v51, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[74:75], v[6:7], v[14:17]
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[74:75], v[2:3], v[10:13]
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[76:77], v[2:3], v[42:45]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[76:77], v[6:7], v[46:49]
	v_perm_b32 v6, v81, v80, v2
	v_lshlrev_b32_e32 v7, 4, v8
	v_perm_b32 v2, v79, v78, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v81, v80, v3
	v_perm_b32 v3, v79, v78, v3
	v_and_or_b32 v3, v2, v8, v3
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_and_b32_e32 v6, 0x7070707, v4
	v_lshrrev_b32_e32 v7, 4, v4
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v64, v63, v6
	v_lshlrev_b32_e32 v10, 4, v4
	v_perm_b32 v6, v62, v61, v6
	v_and_or_b32 v8, v8, v10, v6
	v_perm_b32 v6, v64, v63, v7
	v_perm_b32 v7, v62, v61, v7
	v_lshlrev_b32_e32 v44, 2, v107
	v_and_or_b32 v4, v6, v4, v7
	v_or_b32_e32 v42, s44, v44
	v_perm_b32 v6, v4, v8, s41
	v_perm_b32 v7, v4, v8, s42
	v_ashrrev_i32_e32 v43, 31, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[38:39], v[2:3], v[14:17]
	v_mov_b32_e32 v45, 0
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[38:39], v[6:7], v[50:53]
	v_lshl_add_u64 v[38:39], v[42:43], 2, s[20:21]
	global_load_dword v4, v[38:39], off
	v_lshlrev_b32_e32 v38, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[40:41], v[2:3], v[46:49]
	v_lshl_add_u64 v[2:3], s[44:45], 0, v[44:45]
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[20:21]
	global_load_dwordx3 v[58:60], v[2:3], off offset:4
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[40:41], v[6:7], v[54:57]
	v_and_b32_e32 v6, 0x7070707, v9
	v_lshrrev_b32_e32 v7, 4, v9
	v_and_b32_e32 v7, 0x7070707, v7
	global_load_dwordx4 v[54:57], v[2:3], off offset:64
	v_perm_b32 v8, v81, v80, v6
	v_perm_b32 v6, v79, v78, v6
	v_and_or_b32 v8, v8, v38, v6
	v_perm_b32 v6, v81, v80, v7
	v_perm_b32 v7, v79, v78, v7
	v_and_or_b32 v7, v6, v9, v7
	v_lshrrev_b32_e32 v9, 4, v5
	v_perm_b32 v6, v7, v8, s41
	v_perm_b32 v7, v7, v8, s42
	v_and_b32_e32 v8, 0x7070707, v5
	v_and_b32_e32 v9, 0x7070707, v9
	v_perm_b32 v38, v64, v63, v8
	v_lshlrev_b32_e32 v39, 4, v5
	v_perm_b32 v8, v62, v61, v8
	v_perm_b32 v43, v64, v63, v9
	v_perm_b32 v2, v62, v61, v9
	v_and_or_b32 v8, v38, v39, v8
	v_and_or_b32 v3, v43, v5, v2
	v_perm_b32 v2, v3, v8, s41
	v_perm_b32 v3, v3, v8, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[34:35], v[6:7], v[10:13]
	s_and_b32 s21, s21, 0xffff
	s_waitcnt vmcnt(2)
	v_lshlrev_b32_e32 v4, 2, v4
	v_and_b32_e32 v4, 0x3fffffc, v4
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[34:35], v[2:3], v[14:17]
	v_add_u32_e32 v35, 17, v114
	v_lshlrev_b32_e64 v35, v35, 1
	s_waitcnt vmcnt(0)
	v_lshlrev_b32_e32 v44, 2, v55
	buffer_load_dword v16, v4, s[0:3], 0 offen
	v_lshlrev_b32_e32 v4, 2, v58
	v_and_b32_e32 v4, 0x3fffffc, v4
	buffer_load_dword v34, v4, s[0:3], 0 offen
	v_add_u32_e32 v14, 17, v117
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[36:37], v[6:7], v[46:49]
	v_add_u32_e32 v15, 17, v116
	v_lshlrev_b32_e64 v14, v14, 1
	v_lshlrev_b32_e64 v43, v15, 1
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[36:37], v[2:3], v[50:53]
	v_lshl_add_u32 v37, v117, 23, v88
	v_lshl_add_u32 v36, v116, 23, v88
	v_cndmask_b32_e32 v15, v14, v37, vcc
	v_cmp_lt_i32_e32 vcc, 5, v116
	v_lshlrev_b32_e32 v37, 2, v60
	v_and_b32_e32 v47, 0x3fffffc, v44
	v_cndmask_b32_e32 v14, v43, v36, vcc
	v_lshlrev_b32_e32 v36, 2, v59
	v_and_b32_e32 v36, 0x3fffffc, v36
	buffer_load_dword v36, v36, s[0:3], 0 offen
	v_lshlrev_b32_e32 v44, 2, v56
	v_and_b32_e32 v37, 0x3fffffc, v37
	v_lshlrev_b32_e32 v43, 2, v54
	v_and_b32_e32 v49, 0x3fffffc, v44
	v_lshlrev_b32_e32 v44, 2, v57
	v_and_b32_e32 v43, 0x3fffffc, v43
	v_and_b32_e32 v51, 0x3fffffc, v44
	buffer_load_dword v44, v37, s[0:3], 0 offen
	buffer_load_dword v46, v43, s[0:3], 0 offen
	buffer_load_dword v48, v47, s[0:3], 0 offen
	buffer_load_dword v50, v49, s[0:3], 0 offen
	buffer_load_dword v52, v51, s[0:3], 0 offen
	v_add_u32_e32 v17, 17, v115
	v_mov_b32_e32 v56, v30
	v_mov_b32_e32 v57, v38
	s_mov_b32 s0, 0xbfb8aa3b
	v_lshl_add_u32 v38, v115, 23, v88
	v_cmp_lt_i32_e32 vcc, 5, v115
	v_lshl_add_u32 v30, v114, 23, v88
	v_mov_b32_e32 v60, v26
	v_mov_b32_e32 v61, v10
	v_lshlrev_b32_e32 v37, 10, v107
	v_add_u32_e32 v90, v113, v37
	v_lshlrev_b32_e32 v82, 1, v90
	s_lshl_b32 s2, s48, 2
	v_lshlrev_b32_e32 v43, 1, v0
	v_and_b32_e32 v92, 62, v43
	s_waitcnt vmcnt(7)
	v_pk_mul_f32 v[54:55], v[16:17], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[54:55], v[56:57], v[54:55]
	v_lshlrev_b32_e64 v17, v17, 1
	v_pk_mul_f32 v[56:57], v[54:55], s[0:1] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v59, v17, v38, vcc
	v_exp_f32_e32 v56, v56
	v_exp_f32_e32 v57, v57
	v_cmp_lt_i32_e32 vcc, 5, v114
	v_mov_b32_e32 v38, v31
	v_pk_add_f32 v[56:57], v[56:57], 1.0 op_sel_hi:[1,0]
	v_cndmask_b32_e32 v58, v35, v30, vcc
	v_rcp_f32_e32 v56, v56
	v_rcp_f32_e32 v57, v57
	v_pk_mul_f32 v[16:17], v[16:17], v[58:59] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[60:61], v[16:17]
	v_pk_mul_f32 v[54:55], v[54:55], v[56:57]
	s_nop 0
	v_pk_mul_f32 v[16:17], v[16:17], v[54:55]
	s_nop 0
	v_bfe_u32 v10, v17, 16, 1
	v_add3_u32 v10, v10, v17, s43
	v_or_b32_e32 v26, 0x400000, v17
	v_cmp_u_f32_e32 vcc, v17, v17
	v_bfe_u32 v17, v16, 16, 1
	v_add3_u32 v17, v17, v16, s43
	v_cndmask_b32_e32 v10, v10, v26, vcc
	v_or_b32_e32 v26, 0x400000, v16
	v_cmp_u_f32_e32 vcc, v16, v16
	s_nop 1
	v_cndmask_b32_e32 v16, v17, v26, vcc
	ds_write_b16_d16_hi v82, v16 offset:16384
	s_waitcnt vmcnt(6)
	v_pk_mul_f32 v[16:17], v[34:35], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[38:39], v[16:17]
	v_add_u32_e32 v26, s9, v1
	v_pk_mul_f32 v[30:31], v[16:17], s[0:1] op_sel_hi:[1,0]
	v_add_lshl_u32 v37, v26, v37, 1
	v_exp_f32_e32 v30, v30
	v_exp_f32_e32 v31, v31
	ds_write_b16_d16_hi v37, v10 offset:16416
	v_pk_mul_f32 v[34:35], v[34:35], v[58:59] op_sel_hi:[0,1]
	v_mov_b32_e32 v10, v27
	v_pk_add_f32 v[30:31], v[30:31], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[10:11], v[10:11], v[34:35]
	v_rcp_f32_e32 v30, v30
	v_rcp_f32_e32 v31, v31
	v_mov_b32_e32 v26, v32
	v_mov_b32_e32 v27, v40
	v_mov_b32_e32 v40, v33
	v_pk_mul_f32 v[16:17], v[16:17], v[30:31]
	s_and_b32 s9, s17, 0xffff
	v_pk_mul_f32 v[10:11], v[10:11], v[16:17]
	s_mov_b32 s37, s9
	v_bfe_u32 v16, v11, 16, 1
	v_add3_u32 v16, v16, v11, s43
	v_or_b32_e32 v17, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v31, 0x400000, v10
	s_nop 0
	v_cndmask_b32_e32 v11, v16, v17, vcc
	v_bfe_u32 v16, v10, 16, 1
	v_add3_u32 v30, v16, v10, s43
	s_waitcnt vmcnt(5)
	v_pk_mul_f32 v[16:17], v[36:37], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[26:27], v[16:17]
	v_cmp_u_f32_e32 vcc, v10, v10
	v_pk_mul_f32 v[26:27], v[16:17], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cndmask_b32_e32 v10, v30, v31, vcc
	ds_write_b16_d16_hi v37, v10 offset:16896
	ds_write_b16_d16_hi v37, v11 offset:16928
	v_mov_b32_e32 v30, v28
	v_pk_add_f32 v[10:11], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[36:37], v[58:59] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mov_b32_e32 v31, v12
	v_pk_mul_f32 v[26:27], v[30:31], v[26:27]
	v_pk_mul_f32 v[10:11], v[16:17], v[10:11]
	s_nop 0
	v_pk_mul_f32 v[10:11], v[26:27], v[10:11]
	s_nop 0
	v_bfe_u32 v12, v11, 16, 1
	v_add3_u32 v12, v12, v11, s43
	v_or_b32_e32 v16, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v28, 0x400000, v10
	s_nop 0
	v_cndmask_b32_e32 v11, v12, v16, vcc
	s_waitcnt vmcnt(4)
	v_pk_mul_f32 v[16:17], v[44:45], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[16:17], v[40:41], v[16:17]
	v_bfe_u32 v12, v10, 16, 1
	v_pk_mul_f32 v[26:27], v[16:17], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v12, v12, v10, s43
	v_exp_f32_e32 v26, v26
	v_exp_f32_e32 v27, v27
	v_cmp_u_f32_e32 vcc, v10, v10
	s_nop 1
	v_cndmask_b32_e32 v10, v12, v28, vcc
	ds_write_b16_d16_hi v37, v10 offset:17408
	ds_write_b16_d16_hi v37, v11 offset:17440
	v_pk_add_f32 v[10:11], v[26:27], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[26:27], v[44:45], v[58:59] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mov_b32_e32 v12, v29
	v_pk_mul_f32 v[12:13], v[12:13], v[26:27]
	v_pk_mul_f32 v[10:11], v[16:17], v[10:11]
	v_mov_b32_e32 v16, v22
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11]
	v_mov_b32_e32 v17, v6
	v_bfe_u32 v12, v11, 16, 1
	v_add3_u32 v12, v12, v11, s43
	v_or_b32_e32 v13, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v27, 0x400000, v10
	s_nop 0
	v_cndmask_b32_e32 v11, v12, v13, vcc
	v_bfe_u32 v12, v10, 16, 1
	v_add3_u32 v26, v12, v10, s43
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[12:13], v[46:47], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[12:13], v[16:17], v[12:13]
	v_cmp_u_f32_e32 vcc, v10, v10
	v_pk_mul_f32 v[16:17], v[12:13], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v16, v16
	v_exp_f32_e32 v17, v17
	v_cndmask_b32_e32 v6, v26, v27, vcc
	ds_write_b16_d16_hi v37, v6 offset:17920
	ds_write_b16_d16_hi v37, v11 offset:17952
	v_mov_b32_e32 v26, v18
	v_pk_add_f32 v[10:11], v[16:17], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[16:17], v[46:47], v[58:59] op_sel_hi:[0,1]
	v_rcp_f32_e32 v10, v10
	v_rcp_f32_e32 v11, v11
	v_mov_b32_e32 v27, v2
	v_pk_mul_f32 v[16:17], v[26:27], v[16:17]
	v_pk_mul_f32 v[10:11], v[12:13], v[10:11]
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[12:13], v[48:49], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[10:11], v[16:17], v[10:11]
	s_nop 0
	v_bfe_u32 v2, v11, 16, 1
	v_add3_u32 v2, v2, v11, s43
	v_or_b32_e32 v6, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_or_b32_e32 v16, 0x400000, v10
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
	v_cndmask_b32_e32 v10, v11, v16, vcc
	ds_write_b16_d16_hi v37, v10 offset:24576
	ds_write_b16_d16_hi v37, v2 offset:24608
	v_mov_b32_e32 v2, v19
	v_pk_add_f32 v[10:11], v[12:13], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[12:13], v[48:49], v[58:59] op_sel_hi:[0,1]
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
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[6:7], v[50:51], v[14:15] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[10:11], v[6:7]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_pk_mul_f32 v[10:11], v[6:7], s[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_exp_f32_e32 v10, v10
	v_exp_f32_e32 v11, v11
	v_cndmask_b32_e32 v2, v12, v13, vcc
	ds_write_b16_d16_hi v37, v2 offset:25088
	ds_write_b16_d16_hi v37, v3 offset:25120
	v_mov_b32_e32 v12, v20
	v_pk_add_f32 v[2:3], v[10:11], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[10:11], v[50:51], v[58:59] op_sel_hi:[0,1]
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
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[52:53], v[14:15] op_sel_hi:[0,1]
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
	ds_write_b16_d16_hi v37, v2 offset:25600
	ds_write_b16_d16_hi v37, v3 offset:25632
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[52:53], v[58:59] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v4, v21
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_mov_b32_e32 v9, 0x7fc00000
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
	ds_write_b16_d16_hi v37, v2 offset:26112
	ds_write_b16_d16_hi v37, v3 offset:26144
	v_lshlrev_b32_e32 v2, 2, v112
	v_or_b32_e32 v3, s0, v2
	v_lshlrev_b32_e32 v3, 1, v3
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[4:5], v3 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v3, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v3, vcc
	v_max_f32_e64 v8, v3, |v5|
	v_cmp_o_f32_e64 vcc, v3, |v5|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v6|
	v_cmp_o_f32_e64 vcc, v3, |v6|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v7|
	v_cmp_o_f32_e64 vcc, v3, |v7|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	v_xor_b32_e32 v10, 0x80, v2
	ds_bpermute_b32 v8, v10, v3
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v11, vcc
	v_div_scale_f32 v8, s[4:5], s1, s1, v3
	v_rcp_f32_e32 v11, v8
	s_nop 0
	v_fma_f32 v12, -v8, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, v3, s1, v3
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v11, v13
	v_div_fixup_f32 v8, v8, s1, v3
	v_cmp_neq_f32_e32 vcc, 0, v3
	s_nop 1
	v_cndmask_b32_e32 v3, 1.0, v8, vcc
	v_div_scale_f32 v8, s[4:5], v3, v3, 1.0
	v_rcp_f32_e32 v11, v8
	s_nop 0
	v_fma_f32 v12, -v8, v11, 1.0
	v_fmac_f32_e32 v11, v12, v11
	v_div_scale_f32 v12, vcc, 1.0, v3, 1.0
	v_mul_f32_e32 v13, v12, v11
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v11
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v11, v13
	v_div_fixup_f32 v8, v8, v3, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_mov_b32_e32 v11, s2
	ds_write_b32 v11, v3 offset:8192
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_lshl_b32 s2, s48, 4
	s_and_b32 s2, s2, 0xf0
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_mov_b32_e32 v8, v45
	v_cvt_pk_fp8_f32 v8, v4, v5
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v8, v6, v4 op_sel:[0,0,1]
	v_xor_b32_e32 v4, s2, v2
	v_or_b32_e32 v12, s0, v4
	s_add_i32 s2, s48, 8
	v_and_b32_e32 v3, 0x7f7f7f7f, v8
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v8
	ds_write_b32 v12, v3
	v_lshlrev_b32_e32 v3, 3, v112
	v_lshl_or_b32 v4, s2, 9, v3
	ds_read_b64 v[4:5], v4 offset:16384
	s_lshl_b32 s2, s2, 4
	s_and_b32 s2, s2, 0xf0
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v8, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v8, vcc
	v_max_f32_e64 v13, v8, |v5|
	v_cmp_o_f32_e64 vcc, v8, |v5|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v6|
	v_cmp_o_f32_e64 vcc, v8, |v6|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v7|
	v_cmp_o_f32_e64 vcc, v8, |v7|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_bpermute_b32 v13, v10, v8
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_div_scale_f32 v13, s[4:5], s1, s1, v8
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v8, s1, v8
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s1, v8
	v_cmp_neq_f32_e32 vcc, 0, v8
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v8, s[4:5], v13, v13, 1.0
	v_rcp_f32_e32 v14, v8
	ds_write_b32 v11, v13 offset:8224
	v_fma_f32 v15, -v8, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v8, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v8, -v8, v16, v15
	v_div_fmas_f32 v8, v8, v14, v16
	v_div_fixup_f32 v8, v8, v13, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_mov_b32_e32 v8, v45
	v_cvt_pk_fp8_f32 v8, v4, v5
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	v_xor_b32_e32 v5, s2, v2
	s_lshl_b32 s2, s48, 9
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v8, v6, v4 op_sel:[0,0,1]
	v_or_b32_e32 v5, s0, v5
	s_addk_i32 s2, 0x2000
	s_add_i32 s48, s48, 24
	v_and_b32_e32 v4, 0x7f7f7f7f, v8
	v_add_u32_e32 v4, 0x7f7f7f7f, v4
	v_or_b32_e32 v4, 0x7f7f7f7f, v4
	v_and_b32_e32 v4, v4, v8
	ds_write_b32 v5, v4 offset:2048
	v_or_b32_e32 v4, s2, v3
	ds_read_b64 v[4:5], v4 offset:16384
	v_lshl_or_b32 v3, s48, 9, v3
	s_brev_b32 s2, 16
	s_mov_b32 s30, s2
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v8, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v8, vcc
	v_max_f32_e64 v13, v8, |v5|
	v_cmp_o_f32_e64 vcc, v8, |v5|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v6|
	v_cmp_o_f32_e64 vcc, v8, |v6|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	v_max_f32_e64 v13, v8, |v7|
	v_cmp_o_f32_e64 vcc, v8, |v7|
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v13, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_swizzle_b32 v13, v8 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	ds_bpermute_b32 v13, v10, v8
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v8, v13
	v_cmp_o_f32_e32 vcc, v8, v13
	s_nop 1
	v_cndmask_b32_e32 v8, v9, v14, vcc
	v_div_scale_f32 v13, s[4:5], s1, s1, v8
	v_rcp_f32_e32 v14, v13
	s_nop 0
	v_fma_f32 v15, -v13, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, v8, s1, v8
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v13, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v13, -v13, v16, v15
	v_div_fmas_f32 v13, v13, v14, v16
	v_div_fixup_f32 v13, v13, s1, v8
	v_cmp_neq_f32_e32 vcc, 0, v8
	s_nop 1
	v_cndmask_b32_e32 v13, 1.0, v13, vcc
	v_div_scale_f32 v8, s[4:5], v13, v13, 1.0
	v_rcp_f32_e32 v14, v8
	ds_write_b32 v11, v13 offset:8256
	v_fma_f32 v15, -v8, v14, 1.0
	v_fmac_f32_e32 v14, v15, v14
	v_div_scale_f32 v15, vcc, 1.0, v13, 1.0
	v_mul_f32_e32 v16, v15, v14
	v_fma_f32 v17, -v8, v16, v15
	v_fmac_f32_e32 v16, v17, v14
	v_fma_f32 v8, -v8, v16, v15
	v_div_fmas_f32 v8, v8, v14, v16
	v_div_fixup_f32 v8, v8, v13, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_mov_b32_e32 v8, v45
	v_cvt_pk_fp8_f32 v8, v4, v5
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v8, v6, v4 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v4, 0x7f7f7f7f, v8
	v_add_u32_e32 v4, 0x7f7f7f7f, v4
	v_or_b32_e32 v4, 0x7f7f7f7f, v4
	v_and_b32_e32 v4, v4, v8
	ds_write_b32 v12, v4 offset:4096
	ds_read_b64 v[4:5], v3 offset:16384
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v7, 0xffff0000, v5
	v_lshlrev_b32_e32 v6, 16, v5
	v_and_b32_e32 v5, 0xffff0000, v4
	v_lshlrev_b32_e32 v4, 16, v4
	v_max_f32_e64 v3, |v4|, 0
	v_cmp_o_f32_e64 vcc, |v4|, |v4|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v3, vcc
	v_max_f32_e64 v8, v3, |v5|
	v_cmp_o_f32_e64 vcc, v3, |v5|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v6|
	v_cmp_o_f32_e64 vcc, v3, |v6|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	v_max_f32_e64 v8, v3, |v7|
	v_cmp_o_f32_e64 vcc, v3, |v7|
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v8, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_swizzle_b32 v8, v3 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v12, vcc
	ds_bpermute_b32 v8, v10, v3
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v10, v3, v8
	v_cmp_o_f32_e32 vcc, v3, v8
	s_nop 1
	v_cndmask_b32_e32 v3, v9, v10, vcc
	v_div_scale_f32 v8, s[4:5], s1, s1, v3
	v_rcp_f32_e32 v10, v8
	s_nop 0
	v_fma_f32 v12, -v8, v10, 1.0
	v_fmac_f32_e32 v10, v12, v10
	v_div_scale_f32 v12, vcc, v3, s1, v3
	v_mul_f32_e32 v13, v12, v10
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v10
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v10, v13
	v_div_fixup_f32 v8, v8, s1, v3
	v_cmp_neq_f32_e32 vcc, 0, v3
	s_lshl_b32 s1, s48, 4
	s_and_b32 s1, s1, 0xf0
	v_cndmask_b32_e32 v3, 1.0, v8, vcc
	v_div_scale_f32 v8, s[4:5], v3, v3, 1.0
	v_rcp_f32_e32 v10, v8
	ds_write_b32 v11, v3 offset:8288
	v_xor_b32_e32 v2, s1, v2
	v_or_b32_e32 v2, s0, v2
	v_fma_f32 v12, -v8, v10, 1.0
	v_fmac_f32_e32 v10, v12, v10
	v_div_scale_f32 v12, vcc, 1.0, v3, 1.0
	v_mul_f32_e32 v13, v12, v10
	v_fma_f32 v14, -v8, v13, v12
	v_fmac_f32_e32 v13, v14, v10
	v_fma_f32 v8, -v8, v13, v12
	v_div_fmas_f32 v8, v8, v10, v13
	v_div_fixup_f32 v8, v8, v3, 1.0
	v_pk_mul_f32 v[4:5], v[8:9], v[4:5] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7] op_sel_hi:[0,1]
	v_min_f32_e32 v8, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_lshl_b32 s0, s12, 1
	s_ashr_i32 s4, s12, 31
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_lshr_b32 s7, s4, 27
	s_and_b32 s1, s15, 0xffff
	v_cndmask_b32_e32 v4, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_mov_b32 s29, s1
	s_and_b32 s5, s19, 0xffff
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_mov_b32 s48, s18
	s_mov_b32 s49, s5
	v_cndmask_b32_e32 v5, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	v_cvt_pk_fp8_f32 v45, v4, v5
	s_mov_b32 s15, 0
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_max_f32_e32 v8, 0xc3700000, v6
	v_cmp_o_f32_e32 vcc, v6, v6
	s_nop 1
	v_cndmask_b32_e32 v6, v9, v8, vcc
	v_min_f32_e32 v8, 0x43700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v7, v9, v8, vcc
	v_max_f32_e32 v4, 0xc3700000, v7
	v_cmp_o_f32_e32 vcc, v7, v7
	s_nop 1
	v_cndmask_b32_e32 v4, v9, v4, vcc
	v_cvt_pk_fp8_f32 v45, v6, v4 op_sel:[0,0,1]
	s_nop 0
	v_and_b32_e32 v3, 0x7f7f7f7f, v45
	v_add_u32_e32 v3, 0x7f7f7f7f, v3
	v_or_b32_e32 v3, 0x7f7f7f7f, v3
	v_and_b32_e32 v3, v3, v45
	ds_write_b32 v2, v3 offset:6144
	v_lshlrev_b32_e32 v2, 2, v42
	v_or_b32_e32 v3, 4, v2
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_or_b32_e32 v4, 8, v2
	v_or_b32_e32 v5, 12, v2
	v_or_b32_e32 v6, 64, v2
	v_or_b32_e32 v7, 0x44, v2
	v_or_b32_e32 v8, 0x48, v2
	v_or_b32_e32 v9, 0x4c, v2
	buffer_load_dword v78, v2, s[24:27], 0 offen
	buffer_load_dword v79, v3, s[24:27], 0 offen
	buffer_load_dword v80, v4, s[24:27], 0 offen
	buffer_load_dword v81, v5, s[24:27], 0 offen
	buffer_load_dword v74, v6, s[24:27], 0 offen
	buffer_load_dword v75, v7, s[24:27], 0 offen
	buffer_load_dword v76, v8, s[24:27], 0 offen
	buffer_load_dword v77, v9, s[24:27], 0 offen
	v_or3_b32 v3, s0, v108, v1
	s_lshl_b32 s0, s12, 3
	v_or3_b32 v4, s0, v108, v1
	s_or_b32 s0, s12, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_or_b32_e32 v2, s12, v1
	v_lshlrev_b32_e32 v4, 4, v4
	s_add_i32 s7, s7, s4
	v_lshlrev_b32_e32 v2, 2, v2
	v_or_b32_e32 v5, 0x400, v4
	buffer_load_dwordx4 v[70:73], v4, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[66:69], v5, s[28:31], 0 offen nt
	v_or_b32_e32 v4, s0, v1
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dword v97, v2, s[48:51], 0 offen
	buffer_load_dword v96, v4, s[48:51], 0 offen
	v_or3_b32 v2, s4, v108, v1
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s0, 3
	buffer_load_dword v98, v3, s[36:39], 0 offen
	buffer_load_dword v91, v2, s[36:39], 0 offen
	v_or3_b32 v2, s0, v108, v1
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[62:65], v2, s[28:31], 0 offen nt
	buffer_load_dwordx4 v[58:61], v3, s[28:31], 0 offen nt
	v_add_u32_e32 v2, v109, v110
	ds_read2st64_b64 v[38:41], v2 offset1:8
	ds_read2st64_b64 v[34:37], v83 offset1:8
	ds_read2st64_b64 v[30:33], v84 offset1:8
	ds_read2st64_b64 v[26:29], v85 offset1:8
	ds_read2st64_b64 v[22:25], v86 offset1:8
	ds_read2st64_b64 v[18:21], v87 offset1:8
	ds_read2st64_b64 v[14:17], v89 offset1:8
	ds_read2st64_b64 v[10:13], v111 offset1:8
	v_lshlrev_b32_e32 v2, 4, v107
	ds_read_b128 v[6:9], v2 offset:8192
	ds_read_b128 v[2:5], v2 offset:8256
	v_lshrrev_b32_e32 v42, 5, v0
	v_or_b32_e32 v43, s44, v42
	v_lshlrev_b32_e32 v87, 2, v43
	v_or_b32_e32 v43, 16, v42
	v_or_b32_e32 v44, s44, v43
	v_lshlrev_b32_e32 v0, 2, v0
	s_mov_b32 s0, s14
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_add_i32 s14, s12, 0x100
	v_lshlrev_b32_e32 v85, 2, v44
	v_lshlrev_b32_e32 v86, 9, v42
	v_lshlrev_b32_e32 v83, 1, v92
	v_lshlrev_b32_e32 v84, 9, v43
	v_and_b32_e32 v93, 0xfc, v0
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
	v_mov_b64_e32 v[60:61], v[44:45]
	v_mov_b64_e32 v[58:59], v[42:43]
	v_mov_b32_e32 v96, v0
	v_mov_b32_e32 v97, v89
	v_mov_b32_e32 v98, v95
	s_cbranch_scc0 .LBB0_9
.LBB0_5:
	s_lshl_b32 s17, s15, 8
	s_add_i32 s12, s16, s17
	s_lshr_b32 s13, s12, 31
	s_add_i32 s13, s12, s13
	s_and_b32 s13, s13, 0x1ffffffe
	s_sub_i32 s12, s12, s13
	s_lshl_b32 s12, s12, 3
	s_waitcnt vmcnt(2)
	v_bfe_u32 v108, v91, s12, 8
	s_add_i32 s12, s12, 16
	v_bfe_u32 v109, v91, s12, 8
	s_add_i32 s12, s14, s17
	v_or_b32_e32 v0, s12, v1
	v_lshlrev_b32_e32 v42, 2, v0
	v_lshl_or_b32 v43, s12, 3, v93
	v_lshl_or_b32 v0, s12, 7, v94
	s_or_b32 s13, s12, 16
	s_ashr_i32 s12, s12, 31
	s_lshr_b32 s18, s12, 27
	s_add_i32 s18, s13, s18
	s_lshr_b32 s18, s18, 5
	buffer_load_dwordx4 v[54:57], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[50:53], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s13, v1
	s_add_i32 s18, s18, s12
	v_lshlrev_b32_e32 v44, 2, v0
	buffer_load_dword v89, v42, s[4:7], 0 offen
	buffer_load_dword v0, v44, s[4:7], 0 offen
	v_lshl_or_b32 v42, s18, 8, v93
	v_lshl_or_b32 v99, s13, 7, v94
	buffer_load_dword v95, v43, s[8:11], 0 offen
	buffer_load_dword v91, v42, s[8:11], 0 offen
	buffer_load_dwordx4 v[46:49], v99, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[42:45], v99, s[0:3], 0 offen offset:1024 nt
	s_and_b32 s12, s15, 1
	v_sub_u32_sdwa v99, v97, v98 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v100, 11, v99
	v_mul_lo_u32 v100, v100, s40
	v_sub_u32_e32 v101, 0x6c686080, v100
	v_and_b32_e32 v101, 0xffffff00, v101
	v_cmp_lt_i32_e32 vcc, 11, v99
	v_sub_u32_e32 v100, 0x7c787470, v100
	v_lshlrev_b32_e32 v102, 4, v70
	v_cndmask_b32_e64 v110, v101, 0, vcc
	v_cndmask_b32_e64 v111, v100, 0, vcc
	v_add_u32_e32 v99, 0x7f7f7f00, v110
	v_and_b32_e32 v112, 0x80808000, v99
	v_add_u32_e32 v99, 0x7f7f7f78, v111
	v_and_b32_e32 v113, 0x80808080, v99
	v_and_b32_e32 v99, 0x7070707, v70
	v_lshrrev_b32_e32 v100, 4, v70
	v_and_b32_e32 v100, 0x7070707, v100
	v_perm_b32 v101, v113, v112, v99
	v_perm_b32 v99, v111, v110, v99
	v_and_or_b32 v99, v101, v102, v99
	v_perm_b32 v101, v113, v112, v100
	v_perm_b32 v100, v111, v110, v100
	v_and_or_b32 v70, v101, v70, v100
	v_sub_u32_sdwa v114, v97, v98 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_perm_b32 v104, v70, v99, s41
	v_perm_b32 v105, v70, v99, s42
	v_min_i32_e32 v70, 11, v114
	v_mul_lo_u32 v115, v70, s40
	v_and_b32_e32 v70, 0x7070707, v71
	v_lshrrev_b32_e32 v98, 4, v71
	s_waitcnt lgkmcnt(9)
	v_mfma_f32_16x16x32_fp8_fp8 v[100:103], v[38:39], v[104:105], 0
	v_and_b32_e32 v98, 0x7070707, v98
	v_perm_b32 v99, v113, v112, v70
	v_lshlrev_b32_e32 v116, 4, v71
	v_perm_b32 v70, v111, v110, v70
	v_mfma_f32_16x16x32_fp8_fp8 v[104:107], v[40:41], v[104:105], 0
	v_and_or_b32 v99, v99, v116, v70
	v_perm_b32 v70, v113, v112, v98
	v_perm_b32 v98, v111, v110, v98
	v_and_or_b32 v71, v70, v71, v98
	v_perm_b32 v70, v71, v99, s41
	v_perm_b32 v71, v71, v99, s42
	v_cmp_lt_i32_e32 vcc, 11, v114
	v_sub_u32_e32 v109, v96, v109
	s_waitcnt lgkmcnt(8)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[34:35], v[70:71], v[100:103]
	s_cmp_eq_u32 s12, 0
	s_cselect_b32 s18, 0x4000, 0
	s_nop 0
	v_sub_u32_e32 v102, 0x6c686080, v115
	v_and_b32_e32 v116, 0xffffff00, v102
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[36:37], v[70:71], v[104:107]
	v_and_b32_e32 v70, 0x7070707, v72
	v_lshrrev_b32_e32 v71, 4, v72
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v106, v113, v112, v70
	v_lshlrev_b32_e32 v107, 4, v72
	v_perm_b32 v70, v111, v110, v70
	v_and_or_b32 v106, v106, v107, v70
	v_perm_b32 v70, v113, v112, v71
	v_perm_b32 v71, v111, v110, v71
	v_and_or_b32 v71, v70, v72, v71
	v_perm_b32 v70, v71, v106, s41
	v_perm_b32 v71, v71, v106, s42
	v_lshlrev_b32_e32 v106, 4, v73
	v_sub_u32_e32 v115, 0x7c787470, v115
	s_waitcnt lgkmcnt(7)
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[30:31], v[70:71], v[98:101]
	v_cndmask_b32_e64 v114, v116, 0, vcc
	v_cndmask_b32_e64 v115, v115, 0, vcc
	v_add_u32_e32 v116, 0x7f7f7f00, v114
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[32:33], v[70:71], v[102:105]
	v_and_b32_e32 v70, 0x7070707, v73
	v_lshrrev_b32_e32 v71, 4, v73
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v113, v112, v70
	v_perm_b32 v70, v111, v110, v70
	v_and_or_b32 v70, v72, v106, v70
	v_perm_b32 v72, v113, v112, v71
	v_perm_b32 v71, v111, v110, v71
	v_and_or_b32 v71, v72, v73, v71
	v_perm_b32 v106, v71, v70, s41
	v_perm_b32 v107, v71, v70, s42
	v_and_b32_e32 v110, 0x80808000, v116
	s_waitcnt vmcnt(9)
	v_lshrrev_b32_e32 v112, 4, v63
	s_waitcnt lgkmcnt(6)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[26:27], v[106:107], v[98:101]
	v_and_b32_e32 v112, 0x7070707, v112
	s_nop 1
	v_add_u32_e32 v98, 0x7f7f7f78, v115
	v_and_b32_e32 v111, 0x80808080, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[28:29], v[106:107], v[102:105]
	s_nop 2
	v_and_b32_e32 v102, 0x7070707, v66
	v_lshrrev_b32_e32 v103, 4, v66
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v111, v110, v102
	v_lshlrev_b32_e32 v105, 4, v66
	v_perm_b32 v102, v115, v114, v102
	v_and_or_b32 v104, v104, v105, v102
	v_perm_b32 v102, v111, v110, v103
	v_perm_b32 v103, v115, v114, v103
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
	v_perm_b32 v66, v115, v114, v66
	v_and_or_b32 v103, v103, v104, v66
	v_perm_b32 v66, v111, v110, v102
	v_perm_b32 v102, v115, v114, v102
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
	v_perm_b32 v66, v115, v114, v66
	v_and_or_b32 v102, v102, v103, v66
	v_perm_b32 v66, v111, v110, v67
	v_perm_b32 v67, v115, v114, v67
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
	v_perm_b32 v66, v115, v114, v66
	v_and_or_b32 v68, v68, v102, v66
	v_perm_b32 v66, v111, v110, v67
	v_perm_b32 v67, v115, v114, v67
	v_and_or_b32 v67, v66, v69, v67
	v_perm_b32 v66, v67, v68, s41
	v_perm_b32 v67, v67, v68, s42
	v_lshlrev_b32_e32 v114, 4, v63
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[70:73], v[10:11], v[66:67], v[70:73]
	v_mfma_f32_16x16x32_fp8_fp8 v[66:69], v[12:13], v[66:67], v[98:101]
	s_nop 2
	v_sub_u32_e32 v98, v96, v108
	v_min_i32_e32 v99, 11, v98
	v_mul_lo_u32 v99, v99, s40
	v_sub_u32_e32 v100, 0x6c686080, v99
	v_and_b32_e32 v100, 0xffffff00, v100
	v_cmp_lt_i32_e32 vcc, 11, v98
	v_sub_u32_e32 v99, 0x7c787470, v99
	v_lshlrev_b32_e32 v101, 4, v62
	v_cndmask_b32_e64 v106, v100, 0, vcc
	v_cndmask_b32_e64 v107, v99, 0, vcc
	v_add_u32_e32 v98, 0x7f7f7f00, v106
	v_and_b32_e32 v108, 0x80808000, v98
	v_add_u32_e32 v98, 0x7f7f7f78, v107
	v_and_b32_e32 v110, 0x80808080, v98
	v_and_b32_e32 v98, 0x7070707, v62
	v_lshrrev_b32_e32 v99, 4, v62
	v_and_b32_e32 v99, 0x7070707, v99
	v_perm_b32 v100, v110, v108, v98
	v_perm_b32 v98, v107, v106, v98
	v_and_or_b32 v98, v100, v101, v98
	v_perm_b32 v100, v110, v108, v99
	v_perm_b32 v99, v107, v106, v99
	v_and_or_b32 v62, v100, v62, v99
	v_perm_b32 v102, v62, v98, s41
	v_perm_b32 v103, v62, v98, s42
	v_min_i32_e32 v62, 11, v109
	v_mul_lo_u32 v111, v62, s40
	v_and_b32_e32 v62, 0x7070707, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[38:39], v[102:103], 0
	v_perm_b32 v113, v110, v108, v62
	v_perm_b32 v62, v107, v106, v62
	v_and_or_b32 v113, v113, v114, v62
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[40:41], v[102:103], 0
	v_perm_b32 v62, v110, v108, v112
	v_perm_b32 v112, v107, v106, v112
	v_and_or_b32 v63, v62, v63, v112
	v_perm_b32 v62, v63, v113, s41
	v_perm_b32 v63, v63, v113, s42
	v_lshlrev_b32_e32 v114, 4, v64
	v_sub_u32_e32 v112, 0x6c686080, v111
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[34:35], v[62:63], v[98:101]
	v_and_b32_e32 v112, 0xffffff00, v112
	v_sub_u32_e32 v111, 0x7c787470, v111
	v_cmp_lt_i32_e32 vcc, 11, v109
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[36:37], v[62:63], v[102:105]
	v_and_b32_e32 v62, 0x7070707, v64
	v_lshrrev_b32_e32 v63, 4, v64
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v113, v110, v108, v62
	v_perm_b32 v62, v107, v106, v62
	v_and_or_b32 v113, v113, v114, v62
	v_perm_b32 v62, v110, v108, v63
	v_perm_b32 v63, v107, v106, v63
	v_and_or_b32 v63, v62, v64, v63
	v_perm_b32 v62, v63, v113, s41
	v_perm_b32 v63, v63, v113, s42
	v_lshlrev_b32_e32 v113, 4, v65
	v_cndmask_b32_e64 v109, v112, 0, vcc
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[30:31], v[62:63], v[98:101]
	v_cndmask_b32_e64 v111, v111, 0, vcc
	v_add_u32_e32 v112, 0x7f7f7f00, v109
	v_cmp_lt_i32_e32 vcc, 5, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[102:105], v[32:33], v[62:63], v[102:105]
	v_and_b32_e32 v62, 0x7070707, v65
	v_lshrrev_b32_e32 v63, 4, v65
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v110, v108, v62
	v_perm_b32 v62, v107, v106, v62
	v_and_or_b32 v62, v64, v113, v62
	v_perm_b32 v64, v110, v108, v63
	v_perm_b32 v63, v107, v106, v63
	v_and_or_b32 v63, v64, v65, v63
	v_perm_b32 v106, v63, v62, s41
	v_perm_b32 v107, v63, v62, s42
	v_and_b32_e32 v108, 0x80808000, v112
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[26:27], v[106:107], v[98:101]
	s_nop 2
	v_add_u32_e32 v98, 0x7f7f7f78, v111
	v_and_b32_e32 v110, 0x80808080, v98
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[28:29], v[106:107], v[102:105]
	s_waitcnt vmcnt(8)
	s_nop 1
	v_and_b32_e32 v102, 0x7070707, v58
	v_lshrrev_b32_e32 v103, 4, v58
	v_and_b32_e32 v103, 0x7070707, v103
	v_perm_b32 v104, v110, v108, v102
	v_lshlrev_b32_e32 v105, 4, v58
	v_perm_b32 v102, v111, v109, v102
	v_and_or_b32 v104, v104, v105, v102
	v_perm_b32 v102, v110, v108, v103
	v_perm_b32 v103, v111, v109, v103
	v_and_or_b32 v58, v102, v58, v103
	v_perm_b32 v102, v58, v104, s41
	v_perm_b32 v103, v58, v104, s42
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshlrev_b32_e32 v104, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[22:23], v[102:103], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[24:25], v[102:103], v[98:101]
	v_lshrrev_b32_e32 v102, 4, v59
	v_and_b32_e32 v102, 0x7070707, v102
	v_perm_b32 v103, v110, v108, v58
	v_perm_b32 v58, v111, v109, v58
	v_and_or_b32 v103, v103, v104, v58
	v_perm_b32 v58, v110, v108, v102
	v_perm_b32 v102, v111, v109, v102
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
	v_perm_b32 v102, v110, v108, v58
	v_perm_b32 v58, v111, v109, v58
	v_and_or_b32 v102, v102, v103, v58
	v_perm_b32 v58, v110, v108, v59
	v_perm_b32 v59, v111, v109, v59
	v_and_or_b32 v59, v58, v60, v59
	v_perm_b32 v58, v59, v102, s41
	v_perm_b32 v59, v59, v102, s42
	v_lshlrev_b32_e32 v102, 4, v61
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[14:15], v[58:59], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[98:101], v[16:17], v[58:59], v[98:101]
	v_and_b32_e32 v58, 0x7070707, v61
	v_lshrrev_b32_e32 v59, 4, v61
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v110, v108, v58
	v_perm_b32 v58, v111, v109, v58
	v_and_or_b32 v58, v60, v102, v58
	v_perm_b32 v60, v110, v108, v59
	v_perm_b32 v59, v111, v109, v59
	v_and_or_b32 v59, v60, v61, v59
	v_perm_b32 v102, v59, v58, s41
	v_perm_b32 v103, v59, v58, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[58:61], v[10:11], v[102:103], v[62:65]
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[12:13], v[102:103], v[98:101]
	s_nop 2
	v_add_u32_e32 v99, 17, v97
	v_lshl_add_u32 v98, v97, 23, v88
	v_lshlrev_b32_e64 v99, v99, 1
	v_cndmask_b32_e32 v98, v99, v98, vcc
	v_add_u32_e32 v99, 17, v96
	v_lshlrev_b32_e64 v99, v99, 1
	s_waitcnt lgkmcnt(1)
	v_pk_mul_f32 v[102:103], v[8:9], v[98:99] op_sel_hi:[1,0]
	v_lshl_add_u32 v97, v96, 23, v88
	v_pk_mul_f32 v[72:73], v[102:103], v[72:73]
	v_cmp_lt_i32_e32 vcc, 5, v96
	v_pk_mul_f32 v[72:73], v[72:73], v[80:81]
	v_pk_mul_f32 v[100:101], v[6:7], v[98:99] op_sel_hi:[1,0]
	v_cndmask_b32_e32 v96, v99, v97, vcc
	v_bfe_u32 v97, v73, 16, 1
	v_add3_u32 v97, v97, v73, s43
	v_or_b32_e32 v99, 0x400000, v73
	v_cmp_u_f32_e32 vcc, v73, v73
	v_pk_mul_f32 v[70:71], v[100:101], v[70:71]
	s_nop 0
	v_cndmask_b32_e32 v73, v97, v99, vcc
	v_bfe_u32 v97, v72, 16, 1
	v_pk_mul_f32 v[70:71], v[70:71], v[78:79]
	v_add3_u32 v97, v97, v72, s43
	v_or_b32_e32 v99, 0x400000, v72
	v_cmp_u_f32_e32 vcc, v72, v72
	s_nop 1
	v_cndmask_b32_e32 v72, v97, v99, vcc
	v_bfe_u32 v97, v71, 16, 1
	v_add3_u32 v97, v97, v71, s43
	v_or_b32_e32 v99, 0x400000, v71
	v_cmp_u_f32_e32 vcc, v71, v71
	s_nop 1
	v_cndmask_b32_e32 v71, v97, v99, vcc
	v_bfe_u32 v97, v70, 16, 1
	v_add3_u32 v97, v97, v70, s43
	v_or_b32_e32 v99, 0x400000, v70
	v_cmp_u_f32_e32 vcc, v70, v70
	s_nop 1
	v_cndmask_b32_e32 v70, v97, v99, vcc
	v_lshl_add_u32 v97, v90, 1, s18
	ds_write_b16_d16_hi v97, v70
	ds_write_b16_d16_hi v97, v71 offset:512
	ds_write_b16_d16_hi v97, v72 offset:1024
	ds_write_b16_d16_hi v97, v73 offset:1536
	v_pk_mul_f32 v[72:73], v[8:9], v[96:97] op_sel_hi:[1,0]
	v_pk_mul_f32 v[70:71], v[6:7], v[96:97] op_sel_hi:[1,0]
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
	ds_write_b16_d16_hi v97, v58 offset:32
	ds_write_b16_d16_hi v97, v59 offset:544
	ds_write_b16_d16_hi v97, v60 offset:1056
	ds_write_b16_d16_hi v97, v61 offset:1568
	s_waitcnt lgkmcnt(8)
	v_pk_mul_f32 v[60:61], v[4:5], v[98:99] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[98:99] op_sel_hi:[1,0]
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
	ds_write_b16_d16_hi v97, v58 offset:8192
	ds_write_b16_d16_hi v97, v59 offset:8704
	ds_write_b16_d16_hi v97, v60 offset:9216
	ds_write_b16_d16_hi v97, v61 offset:9728
	v_pk_mul_f32 v[60:61], v[4:5], v[96:97] op_sel_hi:[1,0]
	v_pk_mul_f32 v[58:59], v[2:3], v[96:97] op_sel_hi:[1,0]
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
	ds_write_b16_d16_hi v97, v58 offset:8224
	ds_write_b16_d16_hi v97, v59 offset:8736
	ds_write_b16_d16_hi v97, v60 offset:9248
	ds_write_b16_d16_hi v97, v61 offset:9760
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v58, v87, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_7
	v_add3_u32 v60, s18, v86, v83
	v_lshl_add_u32 v58, v58, 12, s17
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v92
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v61, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:128
	ds_read_b32 v61, v60 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:256
	ds_read_b32 v60, v60 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:384
.LBB0_7:
	s_or_b64 exec, exec, s[12:13]
	buffer_load_dword v58, v85, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v59, 0xffffff, v58
	v_cmp_gt_i32_e32 vcc, s33, v59
	s_and_saveexec_b64 s[12:13], vcc
	s_cbranch_execz .LBB0_4
	v_add3_u32 v60, s18, v84, v83
	v_lshl_add_u32 v58, v58, 12, s17
	ds_read_b32 v61, v60
	v_or_b32_e32 v58, v58, v92
	v_lshlrev_b32_e32 v58, 1, v58
	v_ashrrev_i32_e32 v59, 31, v58
	v_lshl_add_u64 v[58:59], s[34:35], 0, v[58:59]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off
	ds_read_b32 v61, v60 offset:128
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:128
	ds_read_b32 v61, v60 offset:256
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v61, off offset:256
	ds_read_b32 v60, v60 offset:384
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[58:59], v60, off offset:384
	s_branch .LBB0_4
.LBB0_9:
	v_sub_u32_sdwa v1, v89, v95 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
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
	v_sub_u32_sdwa v69, v89, v95 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
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
	v_sub_u32_e32 v1, v0, v1
	v_mfma_f32_16x16x32_fp8_fp8 v[54:57], v[10:11], v[50:51], v[54:57]
	v_cmp_lt_i32_e32 vcc, 11, v1
	s_add_i32 s3, s3, 16
	v_bfe_u32 v64, v91, s3, 8
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
	v_cmp_lt_i32_e32 vcc, 5, v89
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
	v_add_u32_e32 v15, 17, v89
	v_lshl_add_u32 v14, v89, 23, v1
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
	v_pk_mul_f32 v[8:9], v[8:9], v[80:81]
	ds_write_b16_d16_hi v82, v16
	ds_write_b16_d16_hi v82, v17 offset:512
	ds_write_b16_d16_hi v82, v15 offset:1024
	ds_write_b16_d16_hi v82, v1 offset:1536
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
	ds_write_b16_d16_hi v82, v6 offset:32
	ds_write_b16_d16_hi v82, v7 offset:544
	ds_write_b16_d16_hi v82, v8 offset:1056
	ds_write_b16_d16_hi v82, v1 offset:1568
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
	ds_write_b16_d16_hi v82, v6 offset:8192
	ds_write_b16_d16_hi v82, v7 offset:8704
	ds_write_b16_d16_hi v82, v8 offset:9216
	ds_write_b16_d16_hi v82, v1 offset:9728
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
	ds_write_b16_d16_hi v82, v2 offset:8224
	ds_write_b16_d16_hi v82, v3 offset:8736
	ds_write_b16_d16_hi v82, v0 offset:9248
	ds_write_b16_d16_hi v82, v1 offset:9760
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v87, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_11
	v_add_u32_e32 v2, v86, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
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
	buffer_load_dword v0, v85, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_13
	v_add_u32_e32 v2, v84, v83
	ds_read_b32 v3, v2
	v_lshl_or_b32 v0, v0, 13, v83
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
	.size	a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db
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
		.amdhsa_next_free_vgpr 241
		.amdhsa_next_free_sgpr 96
		.amdhsa_accum_offset 244
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.num_vgpr, 241
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.numbered_sgpr, 54
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.has_indirect_call, 0
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
    .name:           a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 512
      - 1
      - 1
    .sgpr_count:     60
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm32_nw8_tk256_tn256_bcm12_xcd1_ftz_a2r_db.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     241
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
