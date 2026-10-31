	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz
	.p2align	8
	.type	a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz,@function
a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz:
	s_load_dwordx8 s[16:23], s[0:1], 0x40
	v_readfirstlane_b32 s3, v0
	s_mov_b32 s35, 0
	s_waitcnt lgkmcnt(0)
	s_load_dword s6, s[18:19], 0x0
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s4, s6, 31
	s_lshr_b32 s4, s4, 28
	s_add_i32 s4, s6, s4
	s_ashr_i32 s8, s4, 4
	s_and_b32 s4, s4, -16
	s_cmp_lg_u32 s6, s4
	s_cselect_b64 s[4:5], -1, 0
	s_cmp_lt_i32 s6, 0
	s_cselect_b64 s[6:7], -1, 0
	s_and_b64 s[4:5], s[6:7], s[4:5]
	s_subb_u32 s4, s8, 0
	s_cmp_ge_i32 s2, s4
	s_cbranch_scc1 .LBB0_10
	s_lshr_b32 s48, s3, 6
	s_and_b32 s3, s4, 7
	s_and_b32 s5, s2, 7
	s_lshr_b32 s4, s4, 3
	s_min_u32 s3, s5, s3
	s_lshr_b32 s2, s2, 3
	s_mul_i32 s4, s4, s5
	s_add_i32 s2, s3, s2
	s_add_i32 s4, s2, s4
	s_ashr_i32 s5, s4, 31
	s_lshl_b64 s[2:3], s[4:5], 2
	s_add_u32 s2, s16, s2
	s_addc_u32 s3, s17, s3
	s_lshl_b32 s34, s4, 4
	v_lshrrev_b32_e32 v35, 5, v0
	v_or_b32_e32 v82, s34, v35
	v_ashrrev_i32_e32 v83, 31, v82
	v_lshl_add_u64 v[2:3], v[82:83], 2, s[20:21]
	global_load_dword v6, v[2:3], off
	s_load_dwordx16 s[4:19], s[0:1], 0x0
	s_load_dword s33, s[0:1], 0x68
	v_and_b32_e32 v1, 15, v0
	v_lshlrev_b32_e32 v2, 3, v0
	v_and_b32_e32 v44, 0xf8, v2
	s_waitcnt lgkmcnt(0)
	s_and_b32 s29, s11, 0xffff
	s_load_dword s11, s[2:3], 0x0
	s_and_b32 s37, s5, 0xffff
	s_lshl_b32 s5, s48, 5
	v_lshlrev_b32_e32 v2, 4, v35
	v_or_b32_e32 v90, s5, v1
	s_waitcnt lgkmcnt(0)
	s_lshl_b32 s2, s11, 9
	s_add_i32 s49, s2, s5
	v_and_b32_e32 v86, 48, v0
	v_xor_b32_e32 v7, v44, v2
	s_and_b32 s25, s9, 0xffff
	v_add_u32_e32 v2, s2, v90
	s_lshl_b32 s2, s49, 7
	s_lshl_b32 s3, s49, 5
	s_add_i32 s9, s49, 0x100
	s_ashr_i32 s24, s49, 31
	s_add_i32 s51, s49, 0x110
	s_or_b32 s50, s49, 16
	v_or3_b32 v99, s2, v86, v1
	v_or3_b32 v100, s3, v86, v1
	s_lshl_b32 s2, s9, 7
	s_lshl_b32 s3, s9, 5
	s_lshr_b32 s27, s24, 27
	s_ashr_i32 s31, s51, 31
	v_or3_b32 v101, s2, v86, v1
	v_or3_b32 v102, s3, v86, v1
	s_add_i32 s2, s50, s27
	s_lshr_b32 s3, s31, 27
	s_lshr_b32 s2, s2, 5
	s_add_i32 s3, s51, s3
	s_add_i32 s2, s2, s24
	s_lshr_b32 s3, s3, 5
	v_add_u32_e32 v4, 0x100, v2
	s_lshl_b32 s2, s2, 10
	s_add_i32 s3, s3, s31
	v_ashrrev_i32_e32 v3, 31, v2
	v_ashrrev_i32_e32 v5, 31, v4
	v_or3_b32 v105, s2, v86, v1
	s_lshl_b32 s2, s3, 10
	s_mov_b32 s39, 0x27000
	s_brev_b32 s26, 8
	s_mov_b32 s30, 0x1000000
	s_lshl_b32 s9, s50, 7
	s_lshl_b32 s28, s51, 7
	v_lshl_add_u64 v[2:3], v[2:3], 2, s[12:13]
	v_lshl_add_u64 v[4:5], v[4:5], 2, s[12:13]
	v_or3_b32 v107, s2, v86, v1
	s_mov_b32 s42, s26
	s_mov_b32 s43, s39
	s_mov_b32 s46, s30
	s_mov_b32 s47, s39
	s_mov_b32 s40, s8
	s_mov_b32 s44, s10
	s_mov_b32 s41, s25
	s_mov_b32 s45, s29
	v_or3_b32 v103, s9, v86, v1
	v_or3_b32 v104, s28, v86, v1
	v_lshlrev_b32_e32 v8, 2, v100
	v_lshlrev_b32_e32 v34, 4, v99
	global_load_dword v93, v[2:3], off
	global_load_dword v94, v[2:3], off offset:64
	global_load_dword v91, v[4:5], off
	global_load_dword v92, v[4:5], off offset:64
	v_lshlrev_b32_e32 v2, 2, v102
	v_lshlrev_b32_e32 v3, 2, v105
	v_lshlrev_b32_e32 v4, 2, v107
	v_lshlrev_b32_e32 v36, 4, v103
	v_lshlrev_b32_e32 v37, 4, v101
	buffer_load_dword v126, v8, s[44:47], 0 offen
	buffer_load_dword v109, v3, s[44:47], 0 offen
	buffer_load_dword v130, v2, s[44:47], 0 offen
	buffer_load_dword v108, v4, s[44:47], 0 offen
	v_lshlrev_b32_e32 v38, 4, v104
	s_mov_b32 s36, s4
	s_lshl_b32 s38, s33, 12
	s_load_dwordx2 s[12:13], s[0:1], 0x60
	s_mov_b32 s0, s4
	s_mov_b32 s24, s8
	s_mov_b32 s28, s10
	s_mov_b32 s1, s37
	s_lshr_b32 s4, s49, 31
	s_waitcnt vmcnt(8)
	v_lshl_or_b32 v106, v6, 12, v7
	buffer_load_dwordx4 v[30:33], v34, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[22:25], v34, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[14:17], v36, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[6:9], v36, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[26:29], v37, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[18:21], v37, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx4 v[10:13], v38, s[40:43], 0 offen sc0
	buffer_load_dwordx4 v[2:5], v38, s[40:43], 0 offen offset:1024 sc0
	buffer_load_dwordx2 v[42:43], v106, s[36:39], 0 offen nt
	s_ashr_i32 s8, s50, 4
	s_ashr_i32 s10, s51, 4
	s_lshr_b32 s37, s51, 31
	v_bfe_u32 v88, v0, 4, 2
	s_add_i32 s4, s8, s4
	s_add_i32 s37, s10, s37
	v_lshlrev_b32_e32 v45, 5, v88
	v_lshlrev_b32_e32 v54, 4, v1
	s_and_b32 s4, s4, -2
	s_and_b32 s37, s37, -2
	v_lshlrev_b32_e32 v87, 8, v35
	v_xor_b32_e32 v85, v45, v54
	v_or_b32_e32 v55, 8, v45
	v_or_b32_e32 v56, 16, v45
	v_or_b32_e32 v57, 24, v45
	v_or_b32_e32 v58, 0x80, v45
	v_or_b32_e32 v59, 0x88, v45
	v_or_b32_e32 v60, 0x90, v45
	v_or_b32_e32 v45, 0x98, v45
	s_sub_i32 s4, s8, s4
	s_sub_i32 s10, s10, s37
	v_mov_b32_e32 v34, 0
	v_lshlrev_b32_e32 v84, 8, v1
	v_or_b32_e32 v44, v87, v44
	v_xor_b32_e32 v111, v55, v54
	v_xor_b32_e32 v110, v56, v54
	v_xor_b32_e32 v98, v57, v54
	v_xor_b32_e32 v95, v58, v54
	v_xor_b32_e32 v96, v59, v54
	v_xor_b32_e32 v97, v60, v54
	v_xor_b32_e32 v45, v45, v54
	s_lshl_b32 s8, s4, 3
	s_lshl_b32 s4, s10, 3
	v_and_b32_e32 v89, 63, v0
	s_mov_b32 s9, 0x8080808
	s_mov_b32 s36, 0x5010400
	s_mov_b32 s40, 0x7030602
	s_mov_b32 s3, s39
	s_mov_b32 s27, s39
	s_mov_b32 s31, s39
	v_mov_b32_e32 v35, v34
	v_mov_b32_e32 v36, v34
	v_mov_b32_e32 v37, v34
	v_mov_b32_e32 v46, v34
	v_mov_b32_e32 v47, v34
	v_mov_b32_e32 v48, v34
	v_mov_b32_e32 v49, v34
	v_mov_b32_e32 v38, v34
	v_mov_b32_e32 v39, v34
	v_mov_b32_e32 v40, v34
	v_mov_b32_e32 v41, v34
	v_mov_b32_e32 v50, v34
	v_mov_b32_e32 v51, v34
	v_mov_b32_e32 v52, v34
	v_mov_b32_e32 v53, v34
	v_lshrrev_b32_e32 v113, 2, v44
	v_or_b32_e32 v112, v84, v85
	v_or_b32_e32 v114, v84, v111
	v_or_b32_e32 v115, v84, v110
	v_or_b32_e32 v116, v84, v98
	v_or_b32_e32 v117, v84, v95
	v_or_b32_e32 v83, v84, v45
	s_mov_b32 s2, s38
	s_add_i32 s37, s8, 16
	s_add_i32 s10, s4, 16
	v_or_b32_e32 v118, v84, v96
	v_or_b32_e32 v119, v84, v97
	s_waitcnt vmcnt(0)
	ds_write_b64 v44, v[42:43]
.LBB0_2:
	s_and_b32 s38, s35, 1
	s_add_i32 s35, s35, 1
	s_lshl_b32 s41, s35, 7
	s_waitcnt vmcnt(4)
	v_mov_b64_e32 v[44:45], v[4:5]
	v_mov_b64_e32 v[42:43], v[2:3]
	v_mov_b64_e32 v[60:61], v[12:13]
	v_mov_b64_e32 v[58:59], v[10:11]
	v_mov_b64_e32 v[56:57], v[8:9]
	v_mov_b64_e32 v[54:55], v[6:7]
	v_lshl_add_u32 v2, s35, 8, v106
	s_lshl_b32 s39, s35, 6
	v_or_b32_e32 v6, s41, v99
	v_or_b32_e32 v11, s41, v101
	s_waitcnt vmcnt(0)
	v_mov_b64_e32 v[68:69], v[20:21]
	v_mov_b64_e32 v[66:67], v[18:19]
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dwordx2 v[142:143], v2, s[0:3], 0 offen nt
	v_add_lshl_u32 v2, s39, v100, 2
	v_add_lshl_u32 v3, s39, v105, 2
	v_add_lshl_u32 v4, s39, v102, 2
	v_add_lshl_u32 v5, s39, v107, 2
	v_add_lshl_u32 v10, s41, v103, 4
	v_add_lshl_u32 v18, s41, v104, 4
	v_lshlrev_b32_e32 v19, 4, v6
	v_lshlrev_b32_e32 v20, 4, v11
	v_mov_b64_e32 v[76:77], v[28:29]
	v_mov_b64_e32 v[74:75], v[26:27]
	v_mov_b64_e32 v[64:65], v[16:17]
	v_mov_b64_e32 v[62:63], v[14:15]
	v_mov_b64_e32 v[72:73], v[24:25]
	v_mov_b64_e32 v[70:71], v[22:23]
	v_mov_b64_e32 v[80:81], v[32:33]
	v_mov_b64_e32 v[78:79], v[30:31]
	v_bfe_u32 v125, v109, s8, 8
	v_bfe_u32 v124, v109, s37, 8
	v_bfe_u32 v123, v108, s4, 8
	v_bfe_u32 v122, v108, s10, 8
	buffer_load_dword v121, v2, s[28:31], 0 offen
	buffer_load_dword v109, v3, s[28:31], 0 offen
	buffer_load_dword v120, v4, s[28:31], 0 offen
	buffer_load_dword v108, v5, s[28:31], 0 offen
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
	v_sub_u32_sdwa v127, v93, v126 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v128, 11, v127
	v_mul_lo_u32 v128, v128, s9
	v_sub_u32_e32 v129, 0x6c686080, v128
	v_and_b32_e32 v129, 0xffffff00, v129
	v_cmp_lt_i32_e32 vcc, 11, v127
	v_sub_u32_e32 v128, 0x7c787470, v128
	v_sub_u32_sdwa v126, v93, v126 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_cndmask_b32_e64 v134, v129, 0, vcc
	v_cndmask_b32_e64 v135, v128, 0, vcc
	v_add_u32_e32 v127, 0x7f7f7f00, v134
	v_and_b32_e32 v136, 0x80808000, v127
	v_add_u32_e32 v127, 0x7f7f7f78, v135
	v_and_b32_e32 v137, 0x80808080, v127
	v_min_i32_e32 v127, 11, v126
	v_sub_u32_sdwa v131, v91, v130 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_mul_lo_u32 v127, v127, s9
	v_min_i32_e32 v132, 11, v131
	v_sub_u32_e32 v128, 0x6c686080, v127
	v_mul_lo_u32 v132, v132, s9
	v_and_b32_e32 v128, 0xffffff00, v128
	v_sub_u32_e32 v127, 0x7c787470, v127
	v_cmp_lt_i32_e32 vcc, 11, v126
	v_sub_u32_e32 v133, 0x6c686080, v132
	v_and_b32_e32 v133, 0xffffff00, v133
	v_cndmask_b32_e64 v126, v128, 0, vcc
	v_cndmask_b32_e64 v127, v127, 0, vcc
	v_cmp_lt_i32_e32 vcc, 11, v131
	v_and_b32_e32 v144, 0x7070707, v78
	v_lshrrev_b32_e32 v145, 4, v78
	v_sub_u32_e32 v132, 0x7c787470, v132
	v_cndmask_b32_e64 v138, v133, 0, vcc
	v_and_b32_e32 v145, 0x7070707, v145
	v_perm_b32 v146, v137, v136, v144
	v_lshlrev_b32_e32 v147, 4, v78
	v_perm_b32 v144, v135, v134, v144
	v_cndmask_b32_e64 v139, v132, 0, vcc
	v_add_u32_e32 v131, 0x7f7f7f00, v138
	v_and_or_b32 v146, v146, v147, v144
	v_perm_b32 v144, v137, v136, v145
	v_perm_b32 v145, v135, v134, v145
	v_and_b32_e32 v140, 0x80808000, v131
	v_add_u32_e32 v131, 0x7f7f7f78, v139
	v_and_or_b32 v78, v144, v78, v145
	v_and_b32_e32 v141, 0x80808080, v131
	v_perm_b32 v144, v78, v146, s36
	v_perm_b32 v145, v78, v146, s40
	v_and_b32_e32 v78, 0x7070707, v74
	v_lshrrev_b32_e32 v146, 4, v74
	v_and_b32_e32 v146, 0x7070707, v146
	v_perm_b32 v147, v141, v140, v78
	v_lshlrev_b32_e32 v148, 4, v74
	v_perm_b32 v78, v139, v138, v78
	v_and_or_b32 v78, v147, v148, v78
	v_perm_b32 v147, v141, v140, v146
	v_perm_b32 v146, v139, v138, v146
	v_and_or_b32 v74, v147, v74, v146
	s_lshl_b32 s39, s38, 12
	v_perm_b32 v146, v74, v78, s36
	v_perm_b32 v147, v74, v78, s40
	v_or_b32_e32 v74, s39, v112
	ds_read_b64 v[148:149], v74
	v_and_b32_e32 v74, 0x7070707, v79
	v_lshrrev_b32_e32 v78, 4, v79
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[148:149], v[144:145], v[34:37]
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v144, v137, v136, v74
	v_lshlrev_b32_e32 v145, 4, v79
	v_perm_b32 v74, v135, v134, v74
	v_and_or_b32 v74, v144, v145, v74
	v_perm_b32 v144, v137, v136, v78
	v_perm_b32 v78, v135, v134, v78
	v_and_or_b32 v79, v144, v79, v78
	v_perm_b32 v78, v79, v74, s36
	v_perm_b32 v79, v79, v74, s40
	v_and_b32_e32 v74, 0x7070707, v75
	v_lshrrev_b32_e32 v144, 4, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[148:149], v[146:147], v[38:41]
	v_and_b32_e32 v144, 0x7070707, v144
	v_perm_b32 v145, v141, v140, v74
	v_lshlrev_b32_e32 v146, 4, v75
	v_perm_b32 v74, v139, v138, v74
	v_and_or_b32 v145, v145, v146, v74
	v_perm_b32 v74, v141, v140, v144
	v_perm_b32 v144, v139, v138, v144
	v_and_or_b32 v75, v74, v75, v144
	v_or_b32_e32 v144, s39, v114
	ds_read_b64 v[146:147], v144
	v_perm_b32 v74, v75, v145, s36
	v_perm_b32 v75, v75, v145, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[146:147], v[78:79], v[34:37]
	v_lshlrev_b32_e32 v79, 4, v80
	v_lshlrev_b32_e32 v144, 4, v76
	v_sub_u32_sdwa v130, v91, v130 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[146:147], v[74:75], v[38:41]
	v_and_b32_e32 v74, 0x7070707, v80
	v_lshrrev_b32_e32 v75, 4, v80
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v78, v137, v136, v74
	v_perm_b32 v74, v135, v134, v74
	v_and_or_b32 v78, v78, v79, v74
	v_perm_b32 v74, v137, v136, v75
	v_perm_b32 v75, v135, v134, v75
	v_and_or_b32 v75, v74, v80, v75
	v_perm_b32 v74, v75, v78, s36
	v_perm_b32 v75, v75, v78, s40
	v_and_b32_e32 v78, 0x7070707, v76
	v_lshrrev_b32_e32 v79, 4, v76
	v_and_b32_e32 v79, 0x7070707, v79
	v_perm_b32 v80, v141, v140, v78
	v_perm_b32 v78, v139, v138, v78
	v_and_or_b32 v80, v80, v144, v78
	v_perm_b32 v78, v141, v140, v79
	v_perm_b32 v79, v139, v138, v79
	v_and_or_b32 v76, v78, v76, v79
	v_perm_b32 v78, v76, v80, s36
	v_perm_b32 v79, v76, v80, s40
	v_or_b32_e32 v76, s39, v115
	ds_read_b64 v[144:145], v76
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[144:145], v[74:75], v[34:37]
	v_and_b32_e32 v74, 0x7070707, v81
	v_lshrrev_b32_e32 v75, 4, v81
	v_and_b32_e32 v75, 0x7070707, v75
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[144:145], v[78:79], v[38:41]
	v_perm_b32 v76, v137, v136, v74
	v_lshlrev_b32_e32 v78, 4, v81
	v_perm_b32 v74, v135, v134, v74
	v_and_or_b32 v76, v76, v78, v74
	v_perm_b32 v74, v137, v136, v75
	v_perm_b32 v75, v135, v134, v75
	v_and_or_b32 v75, v74, v81, v75
	v_perm_b32 v74, v75, v76, s36
	v_perm_b32 v75, v75, v76, s40
	v_and_b32_e32 v76, 0x7070707, v77
	v_lshrrev_b32_e32 v78, 4, v77
	v_and_b32_e32 v78, 0x7070707, v78
	v_perm_b32 v79, v141, v140, v76
	v_lshlrev_b32_e32 v80, 4, v77
	v_perm_b32 v76, v139, v138, v76
	v_and_or_b32 v79, v79, v80, v76
	v_perm_b32 v76, v141, v140, v78
	v_perm_b32 v78, v139, v138, v78
	v_and_or_b32 v77, v76, v77, v78
	v_or_b32_e32 v78, s39, v116
	ds_read_b64 v[140:141], v78
	v_min_i32_e32 v131, 11, v130
	v_add_u32_e32 v128, 0x7f7f7f00, v126
	v_add_u32_e32 v129, 0x7f7f7f78, v127
	v_mul_lo_u32 v131, v131, s9
	v_and_b32_e32 v128, 0x80808000, v128
	v_and_b32_e32 v129, 0x80808080, v129
	v_sub_u32_e32 v132, 0x6c686080, v131
	v_perm_b32 v76, v77, v79, s36
	v_perm_b32 v77, v77, v79, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[140:141], v[74:75], v[34:37]
	v_and_b32_e32 v74, 0x7070707, v70
	v_lshrrev_b32_e32 v75, 4, v70
	v_and_b32_e32 v132, 0xffffff00, v132
	v_sub_u32_e32 v131, 0x7c787470, v131
	v_cmp_lt_i32_e32 vcc, 11, v130
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[140:141], v[76:77], v[38:41]
	v_and_b32_e32 v75, 0x7070707, v75
	v_perm_b32 v76, v129, v128, v74
	v_lshlrev_b32_e32 v77, 4, v70
	v_perm_b32 v74, v127, v126, v74
	v_cndmask_b32_e64 v130, v132, 0, vcc
	v_cndmask_b32_e64 v131, v131, 0, vcc
	v_and_or_b32 v76, v76, v77, v74
	v_perm_b32 v74, v129, v128, v75
	v_perm_b32 v75, v127, v126, v75
	v_add_u32_e32 v132, 0x7f7f7f00, v130
	v_add_u32_e32 v133, 0x7f7f7f78, v131
	v_and_or_b32 v70, v74, v70, v75
	v_and_b32_e32 v132, 0x80808000, v132
	v_and_b32_e32 v133, 0x80808080, v133
	v_perm_b32 v74, v70, v76, s36
	v_perm_b32 v75, v70, v76, s40
	v_and_b32_e32 v70, 0x7070707, v66
	v_lshrrev_b32_e32 v76, 4, v66
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v77, v133, v132, v70
	v_lshlrev_b32_e32 v78, 4, v66
	v_perm_b32 v70, v131, v130, v70
	v_and_or_b32 v70, v77, v78, v70
	v_perm_b32 v77, v133, v132, v76
	v_perm_b32 v76, v131, v130, v76
	v_and_or_b32 v66, v77, v66, v76
	v_perm_b32 v76, v66, v70, s36
	v_perm_b32 v77, v66, v70, s40
	v_or_b32_e32 v66, s39, v117
	ds_read_b64 v[136:137], v66
	v_and_b32_e32 v66, 0x7070707, v71
	v_lshrrev_b32_e32 v70, 4, v71
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[136:137], v[74:75], v[34:37]
	v_and_b32_e32 v70, 0x7070707, v70
	v_perm_b32 v74, v129, v128, v66
	v_lshlrev_b32_e32 v75, 4, v71
	v_perm_b32 v66, v127, v126, v66
	v_and_or_b32 v66, v74, v75, v66
	v_perm_b32 v74, v129, v128, v70
	v_perm_b32 v70, v127, v126, v70
	v_and_or_b32 v71, v74, v71, v70
	v_perm_b32 v70, v71, v66, s36
	v_perm_b32 v71, v71, v66, s40
	v_and_b32_e32 v66, 0x7070707, v67
	v_lshrrev_b32_e32 v74, 4, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[136:137], v[76:77], v[38:41]
	v_and_b32_e32 v74, 0x7070707, v74
	v_perm_b32 v75, v133, v132, v66
	v_lshlrev_b32_e32 v76, 4, v67
	v_perm_b32 v66, v131, v130, v66
	v_and_or_b32 v75, v75, v76, v66
	v_perm_b32 v66, v133, v132, v74
	v_perm_b32 v74, v131, v130, v74
	v_and_or_b32 v67, v66, v67, v74
	v_or_b32_e32 v74, s39, v118
	ds_read_b64 v[138:139], v74
	v_perm_b32 v66, v67, v75, s36
	v_perm_b32 v67, v67, v75, s40
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[138:139], v[70:71], v[34:37]
	v_lshlrev_b32_e32 v71, 4, v72
	v_lshlrev_b32_e32 v74, 4, v68
	s_cmp_lg_u32 s35, 15
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[138:139], v[66:67], v[38:41]
	v_and_b32_e32 v66, 0x7070707, v72
	v_lshrrev_b32_e32 v67, 4, v72
	v_and_b32_e32 v67, 0x7070707, v67
	v_perm_b32 v70, v129, v128, v66
	v_perm_b32 v66, v127, v126, v66
	v_and_or_b32 v70, v70, v71, v66
	v_perm_b32 v66, v129, v128, v67
	v_perm_b32 v67, v127, v126, v67
	v_and_or_b32 v67, v66, v72, v67
	v_perm_b32 v66, v67, v70, s36
	v_perm_b32 v67, v67, v70, s40
	v_and_b32_e32 v70, 0x7070707, v68
	v_lshrrev_b32_e32 v71, 4, v68
	v_and_b32_e32 v71, 0x7070707, v71
	v_perm_b32 v72, v133, v132, v70
	v_perm_b32 v70, v131, v130, v70
	v_and_or_b32 v72, v72, v74, v70
	v_perm_b32 v70, v133, v132, v71
	v_perm_b32 v71, v131, v130, v71
	v_and_or_b32 v68, v70, v68, v71
	v_perm_b32 v70, v68, v72, s36
	v_perm_b32 v71, v68, v72, s40
	v_or_b32_e32 v68, s39, v119
	ds_read_b64 v[134:135], v68
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[134:135], v[66:67], v[34:37]
	v_and_b32_e32 v66, 0x7070707, v73
	v_lshrrev_b32_e32 v67, 4, v73
	v_and_b32_e32 v67, 0x7070707, v67
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[134:135], v[70:71], v[38:41]
	v_perm_b32 v68, v129, v128, v66
	v_lshlrev_b32_e32 v70, 4, v73
	v_perm_b32 v66, v127, v126, v66
	v_and_or_b32 v68, v68, v70, v66
	v_perm_b32 v66, v129, v128, v67
	v_perm_b32 v67, v127, v126, v67
	v_and_or_b32 v67, v66, v73, v67
	v_perm_b32 v66, v67, v68, s36
	v_perm_b32 v67, v67, v68, s40
	v_and_b32_e32 v68, 0x7070707, v69
	v_lshrrev_b32_e32 v70, 4, v69
	v_and_b32_e32 v70, 0x7070707, v70
	v_perm_b32 v71, v133, v132, v68
	v_lshlrev_b32_e32 v72, 4, v69
	v_perm_b32 v68, v131, v130, v68
	v_and_or_b32 v71, v71, v72, v68
	v_perm_b32 v68, v133, v132, v70
	v_perm_b32 v70, v131, v130, v70
	v_and_or_b32 v69, v68, v69, v70
	v_or_b32_e32 v70, s39, v83
	ds_read_b64 v[126:127], v70
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[126:127], v[66:67], v[34:37]
	v_sub_u32_e32 v66, v94, v125
	v_min_i32_e32 v67, 11, v66
	v_perm_b32 v68, v69, v71, s36
	v_perm_b32 v69, v69, v71, s40
	v_mul_lo_u32 v67, v67, s9
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[126:127], v[68:69], v[38:41]
	v_sub_u32_e32 v68, 0x6c686080, v67
	v_and_b32_e32 v68, 0xffffff00, v68
	v_sub_u32_e32 v67, 0x7c787470, v67
	v_cndmask_b32_e64 v78, v68, 0, vcc
	v_cndmask_b32_e64 v79, v67, 0, vcc
	v_add_u32_e32 v66, 0x7f7f7f00, v78
	v_and_b32_e32 v80, 0x80808000, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v79
	v_and_b32_e32 v81, 0x80808080, v66
	v_sub_u32_e32 v66, v94, v124
	v_min_i32_e32 v67, 11, v66
	v_mul_lo_u32 v67, v67, s9
	v_sub_u32_e32 v68, 0x6c686080, v67
	v_and_b32_e32 v68, 0xffffff00, v68
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_sub_u32_e32 v67, 0x7c787470, v67
	v_lshlrev_b32_e32 v125, 4, v62
	v_cndmask_b32_e64 v70, v68, 0, vcc
	v_cndmask_b32_e64 v71, v67, 0, vcc
	v_add_u32_e32 v66, 0x7f7f7f00, v70
	v_and_b32_e32 v72, 0x80808000, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v71
	v_and_b32_e32 v73, 0x80808080, v66
	v_sub_u32_e32 v66, v92, v123
	v_min_i32_e32 v67, 11, v66
	v_mul_lo_u32 v67, v67, s9
	v_sub_u32_e32 v68, 0x6c686080, v67
	v_and_b32_e32 v68, 0xffffff00, v68
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_sub_u32_e32 v67, 0x7c787470, v67
	v_lshrrev_b32_e32 v123, 4, v62
	v_cndmask_b32_e64 v74, v68, 0, vcc
	v_cndmask_b32_e64 v75, v67, 0, vcc
	v_add_u32_e32 v66, 0x7f7f7f00, v74
	v_and_b32_e32 v76, 0x80808000, v66
	v_add_u32_e32 v66, 0x7f7f7f78, v75
	v_and_b32_e32 v77, 0x80808080, v66
	v_sub_u32_e32 v66, v92, v122
	v_and_b32_e32 v122, 0x7070707, v62
	v_and_b32_e32 v123, 0x7070707, v123
	v_perm_b32 v124, v81, v80, v122
	v_perm_b32 v122, v79, v78, v122
	v_and_or_b32 v124, v124, v125, v122
	v_perm_b32 v122, v81, v80, v123
	v_perm_b32 v123, v79, v78, v123
	v_and_or_b32 v62, v122, v62, v123
	v_perm_b32 v122, v62, v124, s36
	v_perm_b32 v123, v62, v124, s40
	v_and_b32_e32 v62, 0x7070707, v58
	v_lshrrev_b32_e32 v124, 4, v58
	v_and_b32_e32 v124, 0x7070707, v124
	v_perm_b32 v125, v77, v76, v62
	v_lshlrev_b32_e32 v128, 4, v58
	v_perm_b32 v62, v75, v74, v62
	v_and_or_b32 v62, v125, v128, v62
	v_perm_b32 v125, v77, v76, v124
	v_perm_b32 v124, v75, v74, v124
	v_and_or_b32 v58, v125, v58, v124
	v_perm_b32 v124, v58, v62, s36
	v_perm_b32 v125, v58, v62, s40
	v_and_b32_e32 v58, 0x7070707, v63
	v_lshrrev_b32_e32 v62, 4, v63
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[148:149], v[122:123], v[46:49]
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v122, v81, v80, v58
	v_lshlrev_b32_e32 v123, 4, v63
	v_perm_b32 v58, v79, v78, v58
	v_and_or_b32 v58, v122, v123, v58
	v_perm_b32 v122, v81, v80, v62
	v_perm_b32 v62, v79, v78, v62
	v_and_or_b32 v63, v122, v63, v62
	v_perm_b32 v62, v63, v58, s36
	v_perm_b32 v63, v63, v58, s40
	v_and_b32_e32 v58, 0x7070707, v59
	v_lshrrev_b32_e32 v122, 4, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[148:149], v[124:125], v[50:53]
	v_and_b32_e32 v122, 0x7070707, v122
	v_perm_b32 v123, v77, v76, v58
	v_lshlrev_b32_e32 v124, 4, v59
	v_perm_b32 v58, v75, v74, v58
	v_and_or_b32 v123, v123, v124, v58
	v_perm_b32 v58, v77, v76, v122
	v_perm_b32 v122, v75, v74, v122
	v_and_or_b32 v59, v58, v59, v122
	v_perm_b32 v58, v59, v123, s36
	v_perm_b32 v59, v59, v123, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[146:147], v[62:63], v[46:49]
	v_lshlrev_b32_e32 v63, 4, v64
	v_lshlrev_b32_e32 v122, 4, v60
	v_min_i32_e32 v67, 11, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[146:147], v[58:59], v[50:53]
	v_and_b32_e32 v58, 0x7070707, v64
	v_lshrrev_b32_e32 v59, 4, v64
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v62, v81, v80, v58
	v_perm_b32 v58, v79, v78, v58
	v_and_or_b32 v62, v62, v63, v58
	v_perm_b32 v58, v81, v80, v59
	v_perm_b32 v59, v79, v78, v59
	v_and_or_b32 v59, v58, v64, v59
	v_perm_b32 v58, v59, v62, s36
	v_perm_b32 v59, v59, v62, s40
	v_and_b32_e32 v62, 0x7070707, v60
	v_lshrrev_b32_e32 v63, 4, v60
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v77, v76, v62
	v_perm_b32 v62, v75, v74, v62
	v_and_or_b32 v64, v64, v122, v62
	v_perm_b32 v62, v77, v76, v63
	v_perm_b32 v63, v75, v74, v63
	v_and_or_b32 v60, v62, v60, v63
	v_perm_b32 v62, v60, v64, s36
	v_perm_b32 v63, v60, v64, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[144:145], v[58:59], v[46:49]
	v_and_b32_e32 v58, 0x7070707, v65
	v_lshrrev_b32_e32 v59, 4, v65
	v_and_b32_e32 v59, 0x7070707, v59
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[144:145], v[62:63], v[50:53]
	v_perm_b32 v60, v81, v80, v58
	v_lshlrev_b32_e32 v62, 4, v65
	v_perm_b32 v58, v79, v78, v58
	v_and_or_b32 v60, v60, v62, v58
	v_perm_b32 v58, v81, v80, v59
	v_perm_b32 v59, v79, v78, v59
	v_and_or_b32 v59, v58, v65, v59
	v_perm_b32 v58, v59, v60, s36
	v_perm_b32 v59, v59, v60, s40
	v_and_b32_e32 v60, 0x7070707, v61
	v_lshrrev_b32_e32 v62, 4, v61
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v77, v76, v60
	v_lshlrev_b32_e32 v64, 4, v61
	v_perm_b32 v60, v75, v74, v60
	v_and_or_b32 v63, v63, v64, v60
	v_perm_b32 v60, v77, v76, v62
	v_perm_b32 v62, v75, v74, v62
	v_mul_lo_u32 v67, v67, s9
	v_and_or_b32 v61, v60, v61, v62
	v_sub_u32_e32 v68, 0x6c686080, v67
	v_perm_b32 v60, v61, v63, s36
	v_perm_b32 v61, v61, v63, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[140:141], v[58:59], v[46:49]
	v_and_b32_e32 v58, 0x7070707, v54
	v_lshrrev_b32_e32 v59, 4, v54
	v_and_b32_e32 v68, 0xffffff00, v68
	v_sub_u32_e32 v67, 0x7c787470, v67
	v_cmp_lt_i32_e32 vcc, 11, v66
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[140:141], v[60:61], v[50:53]
	v_and_b32_e32 v59, 0x7070707, v59
	v_perm_b32 v60, v73, v72, v58
	v_lshlrev_b32_e32 v61, 4, v54
	v_perm_b32 v58, v71, v70, v58
	v_cndmask_b32_e64 v66, v68, 0, vcc
	v_cndmask_b32_e64 v67, v67, 0, vcc
	v_and_or_b32 v60, v60, v61, v58
	v_perm_b32 v58, v73, v72, v59
	v_perm_b32 v59, v71, v70, v59
	v_add_u32_e32 v68, 0x7f7f7f00, v66
	v_add_u32_e32 v69, 0x7f7f7f78, v67
	v_and_or_b32 v54, v58, v54, v59
	v_and_b32_e32 v68, 0x80808000, v68
	v_and_b32_e32 v69, 0x80808080, v69
	v_perm_b32 v58, v54, v60, s36
	v_perm_b32 v59, v54, v60, s40
	v_and_b32_e32 v54, 0x7070707, v42
	v_lshrrev_b32_e32 v60, 4, v42
	v_and_b32_e32 v60, 0x7070707, v60
	v_perm_b32 v61, v69, v68, v54
	v_lshlrev_b32_e32 v62, 4, v42
	v_perm_b32 v54, v67, v66, v54
	v_and_or_b32 v54, v61, v62, v54
	v_perm_b32 v61, v69, v68, v60
	v_perm_b32 v60, v67, v66, v60
	v_and_or_b32 v42, v61, v42, v60
	v_perm_b32 v60, v42, v54, s36
	v_perm_b32 v61, v42, v54, s40
	v_and_b32_e32 v42, 0x7070707, v55
	v_lshrrev_b32_e32 v54, 4, v55
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[136:137], v[58:59], v[46:49]
	v_and_b32_e32 v54, 0x7070707, v54
	v_perm_b32 v58, v73, v72, v42
	v_lshlrev_b32_e32 v59, 4, v55
	v_perm_b32 v42, v71, v70, v42
	v_and_or_b32 v42, v58, v59, v42
	v_perm_b32 v58, v73, v72, v54
	v_perm_b32 v54, v71, v70, v54
	v_and_or_b32 v55, v58, v55, v54
	v_perm_b32 v54, v55, v42, s36
	v_perm_b32 v55, v55, v42, s40
	v_and_b32_e32 v42, 0x7070707, v43
	v_lshrrev_b32_e32 v58, 4, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[136:137], v[60:61], v[50:53]
	v_and_b32_e32 v58, 0x7070707, v58
	v_perm_b32 v59, v69, v68, v42
	v_lshlrev_b32_e32 v60, 4, v43
	v_perm_b32 v42, v67, v66, v42
	v_and_or_b32 v59, v59, v60, v42
	v_perm_b32 v42, v69, v68, v58
	v_perm_b32 v58, v67, v66, v58
	v_and_or_b32 v43, v42, v43, v58
	v_perm_b32 v42, v43, v59, s36
	v_perm_b32 v43, v43, v59, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[138:139], v[54:55], v[46:49]
	v_lshlrev_b32_e32 v55, 4, v56
	v_lshlrev_b32_e32 v58, 4, v44
	s_waitcnt vmcnt(9)
	v_mov_b32_e32 v130, v120
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[138:139], v[42:43], v[50:53]
	v_and_b32_e32 v42, 0x7070707, v56
	v_lshrrev_b32_e32 v43, 4, v56
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v54, v73, v72, v42
	v_perm_b32 v42, v71, v70, v42
	v_and_or_b32 v54, v54, v55, v42
	v_perm_b32 v42, v73, v72, v43
	v_perm_b32 v43, v71, v70, v43
	v_and_or_b32 v43, v42, v56, v43
	v_perm_b32 v42, v43, v54, s36
	v_perm_b32 v43, v43, v54, s40
	v_and_b32_e32 v54, 0x7070707, v44
	v_lshrrev_b32_e32 v55, 4, v44
	v_and_b32_e32 v55, 0x7070707, v55
	v_perm_b32 v56, v69, v68, v54
	v_perm_b32 v54, v67, v66, v54
	v_and_or_b32 v56, v56, v58, v54
	v_perm_b32 v54, v69, v68, v55
	v_perm_b32 v55, v67, v66, v55
	v_and_or_b32 v44, v54, v44, v55
	v_perm_b32 v54, v44, v56, s36
	v_perm_b32 v55, v44, v56, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[134:135], v[42:43], v[46:49]
	v_and_b32_e32 v42, 0x7070707, v57
	v_lshrrev_b32_e32 v43, 4, v57
	v_and_b32_e32 v43, 0x7070707, v43
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[134:135], v[54:55], v[50:53]
	v_perm_b32 v44, v73, v72, v42
	v_lshlrev_b32_e32 v54, 4, v57
	v_perm_b32 v42, v71, v70, v42
	v_and_or_b32 v44, v44, v54, v42
	v_perm_b32 v42, v73, v72, v43
	v_perm_b32 v43, v71, v70, v43
	v_and_or_b32 v43, v42, v57, v43
	v_perm_b32 v42, v43, v44, s36
	v_perm_b32 v43, v43, v44, s40
	v_and_b32_e32 v44, 0x7070707, v45
	v_lshrrev_b32_e32 v54, 4, v45
	v_and_b32_e32 v54, 0x7070707, v54
	v_perm_b32 v55, v69, v68, v44
	v_lshlrev_b32_e32 v56, 4, v45
	v_perm_b32 v44, v67, v66, v44
	v_and_or_b32 v55, v55, v56, v44
	v_perm_b32 v44, v69, v68, v54
	v_perm_b32 v54, v67, v66, v54
	v_and_or_b32 v45, v44, v45, v54
	v_perm_b32 v44, v45, v55, s36
	v_perm_b32 v45, v45, v55, s40
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[126:127], v[42:43], v[46:49]
	v_lshl_or_b32 v42, s38, 10, v113
	v_xor_b32_e32 v42, 0x400, v42
	v_lshlrev_b32_e32 v42, 2, v42
	v_mfma_f32_16x16x32_fp8_fp8 v[50:53], v[126:127], v[44:45], v[50:53]
	v_mov_b32_e32 v126, v121
	ds_write_b64 v42, v[142:143]
	s_cbranch_scc1 .LBB0_2
	v_sub_u32_sdwa v42, v93, v121 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v43, 11, v42
	s_mov_b32 s40, 0x8080808
	v_mul_lo_u32 v43, v43, s40
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	s_waitcnt lgkmcnt(0)
	v_cndmask_b32_e64 v54, v44, 0, vcc
	v_cndmask_b32_e64 v55, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v54
	v_and_b32_e32 v72, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v55
	v_and_b32_e32 v73, 0x80808080, v42
	v_sub_u32_sdwa v42, v93, v121 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s40
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	s_nop 0
	v_cndmask_b32_e64 v74, v44, 0, vcc
	v_cndmask_b32_e64 v75, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v74
	v_and_b32_e32 v76, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v75
	v_and_b32_e32 v77, 0x80808080, v42
	v_sub_u32_sdwa v42, v91, v120 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s40
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	s_barrier
	v_cndmask_b32_e64 v78, v44, 0, vcc
	v_cndmask_b32_e64 v79, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v78
	v_and_b32_e32 v80, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v79
	v_and_b32_e32 v81, 0x80808080, v42
	v_sub_u32_sdwa v42, v91, v120 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v43, 11, v42
	v_mul_lo_u32 v43, v43, s40
	v_sub_u32_e32 v44, 0x6c686080, v43
	v_and_b32_e32 v44, 0xffffff00, v44
	v_cmp_lt_i32_e32 vcc, 11, v42
	v_sub_u32_e32 v43, 0x7c787470, v43
	s_nop 0
	v_cndmask_b32_e64 v99, v44, 0, vcc
	v_cndmask_b32_e64 v100, v43, 0, vcc
	v_add_u32_e32 v42, 0x7f7f7f00, v99
	v_and_b32_e32 v101, 0x80808000, v42
	v_add_u32_e32 v42, 0x7f7f7f78, v100
	ds_read_b64 v[62:63], v112 offset:4096
	v_and_b32_e32 v102, 0x80808080, v42
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v42, 0x7070707, v30
	v_lshrrev_b32_e32 v43, 4, v30
	v_and_b32_e32 v43, 0x7070707, v43
	v_perm_b32 v44, v73, v72, v42
	v_lshlrev_b32_e32 v45, 4, v30
	v_perm_b32 v42, v55, v54, v42
	v_and_or_b32 v42, v44, v45, v42
	v_perm_b32 v44, v73, v72, v43
	v_perm_b32 v43, v55, v54, v43
	v_and_or_b32 v30, v44, v30, v43
	s_mov_b32 s41, 0x5010400
	s_mov_b32 s42, 0x7030602
	v_perm_b32 v44, v30, v42, s41
	v_perm_b32 v45, v30, v42, s42
	s_waitcnt vmcnt(1)
	v_lshrrev_b32_e32 v42, 4, v26
	v_and_b32_e32 v30, 0x7070707, v26
	v_and_b32_e32 v42, 0x7070707, v42
	v_perm_b32 v43, v81, v80, v30
	v_lshlrev_b32_e32 v60, 4, v26
	v_perm_b32 v30, v79, v78, v30
	v_perm_b32 v68, v81, v80, v42
	v_perm_b32 v69, v79, v78, v42
	v_and_or_b32 v30, v43, v60, v30
	v_and_or_b32 v26, v68, v26, v69
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[62:63], v[44:45], v[34:37]
	v_perm_b32 v44, v26, v30, s41
	v_perm_b32 v45, v26, v30, s42
	v_and_b32_e32 v26, 0x7070707, v31
	v_lshrrev_b32_e32 v30, 4, v31
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[62:63], v[44:45], v[38:41]
	v_and_b32_e32 v30, 0x7070707, v30
	v_perm_b32 v44, v73, v72, v26
	v_lshlrev_b32_e32 v45, 4, v31
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v26, v44, v45, v26
	v_perm_b32 v44, v73, v72, v30
	v_perm_b32 v30, v55, v54, v30
	v_and_or_b32 v31, v44, v31, v30
	v_perm_b32 v30, v31, v26, s41
	v_perm_b32 v31, v31, v26, s42
	v_and_b32_e32 v26, 0x7070707, v27
	v_lshrrev_b32_e32 v44, 4, v27
	v_add_u32_e32 v42, v84, v111
	v_and_b32_e32 v44, 0x7070707, v44
	v_perm_b32 v45, v81, v80, v26
	v_lshlrev_b32_e32 v68, 4, v27
	v_perm_b32 v26, v79, v78, v26
	v_add_u32_e32 v43, v84, v110
	ds_read_b64 v[66:67], v42 offset:4096
	ds_read_b64 v[64:65], v43 offset:4096
	ds_read_b64 v[60:61], v83 offset:4096
	v_and_or_b32 v45, v45, v68, v26
	v_perm_b32 v26, v81, v80, v44
	v_perm_b32 v44, v79, v78, v44
	v_and_or_b32 v27, v26, v27, v44
	v_perm_b32 v26, v27, v45, s41
	v_perm_b32 v27, v27, v45, s42
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[66:67], v[30:31], v[34:37]
	v_lshlrev_b32_e32 v31, 4, v32
	v_lshlrev_b32_e32 v44, 4, v28
	v_add_u32_e32 v45, v84, v97
	v_mfma_f32_16x16x32_fp8_fp8 v[38:41], v[66:67], v[26:27], v[38:41]
	v_and_b32_e32 v26, 0x7070707, v32
	v_lshrrev_b32_e32 v27, 4, v32
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v30, v73, v72, v26
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v30, v30, v31, v26
	v_perm_b32 v26, v73, v72, v27
	v_perm_b32 v27, v55, v54, v27
	v_and_or_b32 v27, v26, v32, v27
	v_perm_b32 v26, v27, v30, s41
	v_perm_b32 v27, v27, v30, s42
	v_and_b32_e32 v30, 0x7070707, v28
	v_lshrrev_b32_e32 v31, 4, v28
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v81, v80, v30
	v_perm_b32 v30, v79, v78, v30
	v_and_or_b32 v30, v32, v44, v30
	v_perm_b32 v32, v81, v80, v31
	v_perm_b32 v31, v79, v78, v31
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[64:65], v[26:27], v[34:37]
	v_and_or_b32 v27, v32, v28, v31
	v_perm_b32 v26, v27, v30, s41
	v_perm_b32 v27, v27, v30, s42
	v_add_u32_e32 v44, v84, v98
	ds_read_b64 v[34:35], v44 offset:4096
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[64:65], v[26:27], v[38:41]
	v_and_b32_e32 v26, 0x7070707, v33
	v_lshrrev_b32_e32 v27, 4, v33
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v73, v72, v26
	v_lshlrev_b32_e32 v30, 4, v33
	v_perm_b32 v26, v55, v54, v26
	v_and_or_b32 v26, v28, v30, v26
	v_perm_b32 v28, v73, v72, v27
	v_perm_b32 v27, v55, v54, v27
	v_and_or_b32 v27, v28, v33, v27
	v_perm_b32 v40, v27, v26, s41
	v_perm_b32 v41, v27, v26, s42
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v81, v80, v26
	v_lshlrev_b32_e32 v30, 4, v29
	v_perm_b32 v26, v79, v78, v26
	v_and_or_b32 v72, v28, v30, v26
	v_perm_b32 v28, v81, v80, v27
	v_perm_b32 v73, v79, v78, v27
	v_and_or_b32 v29, v28, v29, v73
	v_perm_b32 v28, v29, v72, s41
	v_perm_b32 v29, v29, v72, s42
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[34:35], v[40:41], v[68:71]
	v_lshlrev_b32_e32 v41, 4, v22
	v_add_u32_e32 v55, v84, v95
	v_add_u32_e32 v54, v84, v96
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[34:35], v[28:29], v[36:39]
	v_and_b32_e32 v28, 0x7070707, v22
	v_lshrrev_b32_e32 v29, 4, v22
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v40, v77, v76, v28
	v_perm_b32 v28, v75, v74, v28
	v_and_or_b32 v40, v40, v41, v28
	v_perm_b32 v28, v77, v76, v29
	v_perm_b32 v29, v75, v74, v29
	v_and_or_b32 v22, v28, v22, v29
	v_perm_b32 v28, v22, v40, s41
	v_perm_b32 v29, v22, v40, s42
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v22, 0x7070707, v18
	v_lshrrev_b32_e32 v40, 4, v18
	ds_read_b64 v[32:33], v55 offset:4096
	ds_read_b64 v[30:31], v54 offset:4096
	ds_read_b64 v[26:27], v45 offset:4096
	v_and_b32_e32 v40, 0x7070707, v40
	v_perm_b32 v41, v102, v101, v22
	v_lshlrev_b32_e32 v72, 4, v18
	v_perm_b32 v22, v100, v99, v22
	v_and_or_b32 v22, v41, v72, v22
	v_perm_b32 v41, v102, v101, v40
	v_perm_b32 v40, v100, v99, v40
	v_and_or_b32 v18, v41, v18, v40
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[32:33], v[28:29], v[68:71]
	v_perm_b32 v28, v18, v22, s41
	v_perm_b32 v29, v18, v22, s42
	v_and_b32_e32 v18, 0x7070707, v23
	v_lshrrev_b32_e32 v22, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[32:33], v[28:29], v[36:39]
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v28, v77, v76, v18
	v_lshlrev_b32_e32 v29, 4, v23
	v_perm_b32 v18, v75, v74, v18
	v_and_or_b32 v18, v28, v29, v18
	v_perm_b32 v28, v77, v76, v22
	v_perm_b32 v22, v75, v74, v22
	v_and_or_b32 v23, v28, v23, v22
	v_perm_b32 v22, v23, v18, s41
	v_perm_b32 v23, v23, v18, s42
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v28, 4, v19
	v_and_b32_e32 v28, 0x7070707, v28
	v_perm_b32 v29, v102, v101, v18
	v_lshlrev_b32_e32 v40, 4, v19
	v_perm_b32 v18, v100, v99, v18
	v_and_or_b32 v29, v29, v40, v18
	v_perm_b32 v18, v102, v101, v28
	v_perm_b32 v28, v100, v99, v28
	v_and_or_b32 v19, v18, v19, v28
	v_perm_b32 v18, v19, v29, s41
	v_perm_b32 v19, v19, v29, s42
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[30:31], v[22:23], v[68:71]
	v_lshlrev_b32_e32 v23, 4, v24
	v_lshlrev_b32_e32 v28, 4, v20
	v_bfe_u32 v59, v109, s8, 8
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[30:31], v[18:19], v[36:39]
	v_and_b32_e32 v18, 0x7070707, v24
	v_lshrrev_b32_e32 v19, 4, v24
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v22, v77, v76, v18
	v_perm_b32 v18, v75, v74, v18
	v_and_or_b32 v22, v22, v23, v18
	v_perm_b32 v18, v77, v76, v19
	v_perm_b32 v19, v75, v74, v19
	v_and_or_b32 v19, v18, v24, v19
	v_perm_b32 v18, v19, v22, s41
	v_perm_b32 v19, v19, v22, s42
	v_and_b32_e32 v22, 0x7070707, v20
	v_lshrrev_b32_e32 v23, 4, v20
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v102, v101, v22
	v_perm_b32 v22, v100, v99, v22
	v_and_or_b32 v22, v24, v28, v22
	v_perm_b32 v24, v102, v101, v23
	v_perm_b32 v23, v100, v99, v23
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[68:71], v[26:27], v[18:19], v[68:71]
	v_and_or_b32 v19, v24, v20, v23
	v_perm_b32 v18, v19, v22, s41
	v_perm_b32 v19, v19, v22, s42
	v_lshlrev_b32_e32 v22, 4, v25
	v_lshlrev_b32_e32 v24, 4, v21
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[26:27], v[18:19], v[36:39]
	v_and_b32_e32 v18, 0x7070707, v25
	v_lshrrev_b32_e32 v19, 4, v25
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v77, v76, v18
	v_perm_b32 v18, v75, v74, v18
	v_and_or_b32 v20, v20, v22, v18
	v_perm_b32 v18, v77, v76, v19
	v_perm_b32 v19, v75, v74, v19
	v_and_or_b32 v19, v18, v25, v19
	v_lshrrev_b32_e32 v22, 4, v21
	v_perm_b32 v18, v19, v20, s41
	v_perm_b32 v19, v19, v20, s42
	v_and_b32_e32 v20, 0x7070707, v21
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v102, v101, v20
	v_perm_b32 v20, v100, v99, v20
	v_perm_b32 v28, v102, v101, v22
	v_perm_b32 v29, v100, v99, v22
	v_and_or_b32 v20, v23, v24, v20
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[60:61], v[18:19], v[68:71]
	v_and_or_b32 v19, v28, v21, v29
	v_sub_u32_e32 v28, v94, v59
	v_min_i32_e32 v29, 11, v28
	v_perm_b32 v18, v19, v20, s41
	v_perm_b32 v19, v19, v20, s42
	v_mul_lo_u32 v29, v29, s40
	v_cmp_lt_i32_e32 vcc, 11, v28
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[60:61], v[18:19], v[36:39]
	v_bfe_u32 v58, v109, s37, 8
	v_bfe_u32 v57, v108, s4, 8
	v_bfe_u32 v56, v108, s10, 8
	v_sub_u32_e32 v36, 0x6c686080, v29
	v_and_b32_e32 v36, 0xffffff00, v36
	v_sub_u32_e32 v29, 0x7c787470, v29
	v_cndmask_b32_e64 v40, v36, 0, vcc
	v_cndmask_b32_e64 v41, v29, 0, vcc
	v_add_u32_e32 v28, 0x7f7f7f00, v40
	v_and_b32_e32 v59, 0x80808000, v28
	v_add_u32_e32 v28, 0x7f7f7f78, v41
	v_and_b32_e32 v68, 0x80808080, v28
	v_sub_u32_e32 v28, v94, v58
	v_min_i32_e32 v29, 11, v28
	v_mul_lo_u32 v29, v29, s40
	v_sub_u32_e32 v36, 0x6c686080, v29
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v28
	v_sub_u32_e32 v29, 0x7c787470, v29
	v_lshlrev_b32_e32 v37, 4, v14
	v_cndmask_b32_e64 v58, v36, 0, vcc
	v_cndmask_b32_e64 v69, v29, 0, vcc
	v_add_u32_e32 v28, 0x7f7f7f00, v58
	v_and_b32_e32 v70, 0x80808000, v28
	v_add_u32_e32 v28, 0x7f7f7f78, v69
	v_and_b32_e32 v71, 0x80808080, v28
	v_sub_u32_e32 v28, v92, v57
	v_min_i32_e32 v29, 11, v28
	v_mul_lo_u32 v29, v29, s40
	v_sub_u32_e32 v36, 0x6c686080, v29
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v28
	v_sub_u32_e32 v29, 0x7c787470, v29
	v_lshlrev_b32_e32 v38, 4, v10
	v_cndmask_b32_e64 v57, v36, 0, vcc
	v_cndmask_b32_e64 v72, v29, 0, vcc
	v_add_u32_e32 v28, 0x7f7f7f00, v57
	v_and_b32_e32 v73, 0x80808000, v28
	v_add_u32_e32 v28, 0x7f7f7f78, v72
	v_and_b32_e32 v74, 0x80808080, v28
	v_sub_u32_e32 v28, v92, v56
	v_min_i32_e32 v29, 11, v28
	v_mul_lo_u32 v29, v29, s40
	v_sub_u32_e32 v36, 0x6c686080, v29
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v28
	v_sub_u32_e32 v29, 0x7c787470, v29
	s_ashr_i32 s35, s34, 31
	v_cndmask_b32_e64 v56, v36, 0, vcc
	v_cndmask_b32_e64 v75, v29, 0, vcc
	v_add_u32_e32 v28, 0x7f7f7f00, v56
	v_and_b32_e32 v76, 0x80808000, v28
	v_add_u32_e32 v28, 0x7f7f7f78, v75
	v_and_b32_e32 v77, 0x80808080, v28
	v_and_b32_e32 v28, 0x7070707, v14
	v_lshrrev_b32_e32 v29, 4, v14
	v_and_b32_e32 v29, 0x7070707, v29
	v_perm_b32 v36, v68, v59, v28
	v_perm_b32 v28, v41, v40, v28
	v_and_or_b32 v36, v36, v37, v28
	v_perm_b32 v28, v68, v59, v29
	v_perm_b32 v29, v41, v40, v29
	v_and_or_b32 v14, v28, v14, v29
	v_perm_b32 v28, v14, v36, s41
	v_perm_b32 v29, v14, v36, s42
	v_lshrrev_b32_e32 v36, 4, v10
	v_and_b32_e32 v14, 0x7070707, v10
	v_and_b32_e32 v36, 0x7070707, v36
	v_perm_b32 v37, v74, v73, v14
	v_perm_b32 v14, v72, v57, v14
	v_perm_b32 v78, v74, v73, v36
	v_perm_b32 v79, v72, v57, v36
	v_and_or_b32 v14, v37, v38, v14
	v_and_or_b32 v10, v78, v10, v79
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[62:63], v[28:29], v[46:49]
	v_perm_b32 v28, v10, v14, s41
	v_perm_b32 v29, v10, v14, s42
	v_and_b32_e32 v10, 0x7070707, v15
	v_lshrrev_b32_e32 v14, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[62:63], v[28:29], v[50:53]
	v_and_b32_e32 v14, 0x7070707, v14
	v_perm_b32 v28, v68, v59, v10
	v_lshlrev_b32_e32 v29, 4, v15
	v_perm_b32 v10, v41, v40, v10
	v_and_or_b32 v10, v28, v29, v10
	v_perm_b32 v28, v68, v59, v14
	v_perm_b32 v14, v41, v40, v14
	v_and_or_b32 v15, v28, v15, v14
	v_perm_b32 v14, v15, v10, s41
	v_perm_b32 v15, v15, v10, s42
	v_and_b32_e32 v10, 0x7070707, v11
	v_lshrrev_b32_e32 v28, 4, v11
	v_and_b32_e32 v28, 0x7070707, v28
	v_perm_b32 v29, v74, v73, v10
	v_lshlrev_b32_e32 v50, 4, v11
	v_perm_b32 v10, v72, v57, v10
	v_and_or_b32 v29, v29, v50, v10
	v_perm_b32 v10, v74, v73, v28
	v_perm_b32 v28, v72, v57, v28
	v_and_or_b32 v11, v10, v11, v28
	v_perm_b32 v10, v11, v29, s41
	v_perm_b32 v11, v11, v29, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[66:67], v[14:15], v[36:39]
	v_lshlrev_b32_e32 v15, 4, v16
	v_lshlrev_b32_e32 v28, 4, v12
	v_lshlrev_b32_e32 v29, 4, v13
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[66:67], v[10:11], v[46:49]
	v_and_b32_e32 v10, 0x7070707, v16
	v_lshrrev_b32_e32 v11, 4, v16
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v14, v68, v59, v10
	v_perm_b32 v10, v41, v40, v10
	v_and_or_b32 v14, v14, v15, v10
	v_perm_b32 v10, v68, v59, v11
	v_perm_b32 v11, v41, v40, v11
	v_and_or_b32 v11, v10, v16, v11
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_and_b32_e32 v14, 0x7070707, v12
	v_lshrrev_b32_e32 v15, 4, v12
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v74, v73, v14
	v_perm_b32 v14, v72, v57, v14
	v_and_or_b32 v14, v16, v28, v14
	v_perm_b32 v16, v74, v73, v15
	v_perm_b32 v15, v72, v57, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[36:39], v[64:65], v[10:11], v[36:39]
	v_and_or_b32 v11, v16, v12, v15
	v_perm_b32 v10, v11, v14, s41
	v_perm_b32 v11, v11, v14, s42
	v_lshlrev_b32_e32 v12, 2, v88
	v_and_b32_e32 v16, 0x7070707, v17
	v_mfma_f32_16x16x32_fp8_fp8 v[46:49], v[64:65], v[10:11], v[46:49]
	v_lshrrev_b32_e32 v10, 4, v17
	v_and_b32_e32 v28, 0x7070707, v10
	v_or_b32_e32 v10, s34, v12
	v_ashrrev_i32_e32 v11, 31, v10
	v_lshl_add_u64 v[14:15], v[10:11], 2, s[20:21]
	global_load_dword v11, v[14:15], off
	v_perm_b32 v14, v68, v59, v16
	v_lshlrev_b32_e32 v15, 4, v17
	v_perm_b32 v16, v41, v40, v16
	v_and_or_b32 v15, v14, v15, v16
	v_perm_b32 v14, v68, v59, v28
	v_perm_b32 v16, v41, v40, v28
	v_and_or_b32 v16, v14, v17, v16
	v_perm_b32 v14, v16, v15, s41
	v_perm_b32 v15, v16, v15, s42
	v_and_b32_e32 v16, 0x7070707, v13
	v_lshrrev_b32_e32 v17, 4, v13
	v_and_b32_e32 v17, 0x7070707, v17
	v_perm_b32 v28, v74, v73, v16
	v_perm_b32 v16, v72, v57, v16
	v_and_or_b32 v29, v28, v29, v16
	v_perm_b32 v28, v74, v73, v17
	v_perm_b32 v40, v72, v57, v17
	v_and_or_b32 v13, v28, v13, v40
	v_perm_b32 v28, v13, v29, s41
	v_perm_b32 v29, v13, v29, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[34:35], v[14:15], v[36:39]
	v_and_b32_e32 v13, 0x7070707, v6
	s_lshl_b32 s2, s33, 2
	s_and_b32 s1, s7, 0xffff
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[34:35], v[28:29], v[46:49]
	v_lshrrev_b32_e32 v28, 4, v6
	v_and_b32_e32 v28, 0x7070707, v28
	v_perm_b32 v29, v71, v70, v13
	v_lshlrev_b32_e32 v38, 4, v6
	v_perm_b32 v13, v69, v58, v13
	v_and_or_b32 v13, v29, v38, v13
	v_perm_b32 v29, v71, v70, v28
	v_perm_b32 v28, v69, v58, v28
	v_and_or_b32 v6, v29, v6, v28
	v_perm_b32 v28, v6, v13, s41
	v_perm_b32 v29, v6, v13, s42
	v_mov_b32_e32 v13, 0
	v_lshl_add_u64 v[38:39], s[34:35], 0, v[12:13]
	v_lshl_add_u64 v[38:39], v[38:39], 2, s[20:21]
	global_load_dwordx3 v[38:40], v[38:39], off offset:4
	v_and_b32_e32 v6, 0x7070707, v2
	v_lshrrev_b32_e32 v12, 4, v2
	v_and_b32_e32 v12, 0x7070707, v12
	v_perm_b32 v41, v77, v76, v6
	v_lshlrev_b32_e32 v46, 4, v2
	v_perm_b32 v6, v75, v56, v6
	v_and_or_b32 v6, v41, v46, v6
	v_perm_b32 v41, v77, v76, v12
	v_perm_b32 v12, v75, v56, v12
	v_and_or_b32 v2, v41, v2, v12
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[32:33], v[28:29], v[14:17]
	v_perm_b32 v28, v2, v6, s41
	v_perm_b32 v29, v2, v6, s42
	v_and_b32_e32 v2, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[32:35], v[32:33], v[28:29], v[34:37]
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v12, v71, v70, v2
	v_lshlrev_b32_e32 v28, 4, v7
	v_perm_b32 v2, v69, v58, v2
	v_and_or_b32 v2, v12, v28, v2
	v_perm_b32 v12, v71, v70, v6
	v_perm_b32 v6, v69, v58, v6
	v_and_or_b32 v7, v12, v7, v6
	v_perm_b32 v6, v7, v2, s41
	v_perm_b32 v7, v7, v2, s42
	v_and_b32_e32 v2, 0x7070707, v3
	v_lshrrev_b32_e32 v12, 4, v3
	v_and_b32_e32 v12, 0x7070707, v12
	v_perm_b32 v28, v77, v76, v2
	v_lshlrev_b32_e32 v29, 4, v3
	v_perm_b32 v2, v75, v56, v2
	s_mov_b32 s3, 0x27000
	s_mov_b32 s0, s6
	v_and_or_b32 v28, v28, v29, v2
	v_perm_b32 v2, v77, v76, v12
	v_perm_b32 v29, v75, v56, v12
	v_and_or_b32 v3, v2, v3, v29
	v_perm_b32 v2, v3, v28, s41
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v11, 2, v11
	v_and_b32_e32 v11, 0x3fffffc, v11
	buffer_load_dword v12, v11, s[0:3], 0 offen
	v_perm_b32 v3, v3, v28, s42
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[30:31], v[6:7], v[14:17]
	v_lshlrev_b32_e32 v7, 4, v8
	v_lshlrev_b32_e32 v11, 4, v4
	v_mov_b32_e32 v48, 0xfd800000
	v_mfma_f32_16x16x32_fp8_fp8 v[28:31], v[30:31], v[2:3], v[32:35]
	v_and_b32_e32 v2, 0x7070707, v8
	v_lshrrev_b32_e32 v3, 4, v8
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v6, v71, v70, v2
	v_perm_b32 v2, v69, v58, v2
	v_and_or_b32 v6, v6, v7, v2
	v_perm_b32 v2, v71, v70, v3
	v_perm_b32 v3, v69, v58, v3
	v_and_or_b32 v3, v2, v8, v3
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_and_b32_e32 v6, 0x7070707, v4
	v_lshrrev_b32_e32 v7, 4, v4
	v_and_b32_e32 v7, 0x7070707, v7
	v_perm_b32 v8, v77, v76, v6
	v_perm_b32 v6, v75, v56, v6
	v_and_or_b32 v6, v8, v11, v6
	v_perm_b32 v8, v77, v76, v7
	v_perm_b32 v7, v75, v56, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[26:27], v[2:3], v[14:17]
	v_and_or_b32 v3, v8, v4, v7
	v_perm_b32 v2, v3, v6, s41
	v_perm_b32 v3, v3, v6, s42
	v_lshlrev_b32_e32 v6, 4, v9
	v_lshlrev_b32_e32 v8, 4, v5
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[26:27], v[2:3], v[28:31]
	v_and_b32_e32 v2, 0x7070707, v9
	v_lshrrev_b32_e32 v3, 4, v9
	v_and_b32_e32 v3, 0x7070707, v3
	v_perm_b32 v4, v71, v70, v2
	v_perm_b32 v2, v69, v58, v2
	s_waitcnt vmcnt(1)
	v_lshlrev_b32_e32 v7, 2, v38
	v_and_b32_e32 v7, 0x3fffffc, v7
	buffer_load_dword v30, v7, s[0:3], 0 offen
	v_and_or_b32 v4, v4, v6, v2
	v_perm_b32 v2, v71, v70, v3
	v_perm_b32 v3, v69, v58, v3
	v_and_or_b32 v3, v2, v9, v3
	v_perm_b32 v2, v3, v4, s41
	v_perm_b32 v3, v3, v4, s42
	v_and_b32_e32 v4, 0x7070707, v5
	v_lshrrev_b32_e32 v6, 4, v5
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v77, v76, v4
	v_perm_b32 v4, v75, v56, v4
	v_and_or_b32 v4, v7, v8, v4
	v_perm_b32 v11, v77, v76, v6
	v_perm_b32 v31, v75, v56, v6
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[60:61], v[2:3], v[14:17]
	v_and_or_b32 v3, v11, v5, v31
	v_add_u32_e32 v11, 17, v94
	v_lshlrev_b32_e64 v11, v11, 1
	v_lshlrev_b32_e32 v14, 2, v39
	v_and_b32_e32 v14, 0x3fffffc, v14
	buffer_load_dword v14, v14, s[0:3], 0 offen
	v_lshl_add_u32 v17, v94, 23, v48
	v_cmp_lt_i32_e32 vcc, 5, v94
	v_perm_b32 v2, v3, v4, s41
	v_perm_b32 v3, v3, v4, s42
	v_cndmask_b32_e32 v17, v11, v17, vcc
	v_lshlrev_b32_e32 v11, 2, v40
	v_and_b32_e32 v11, 0x3fffffc, v11
	v_mfma_f32_16x16x32_fp8_fp8 v[2:5], v[60:61], v[2:3], v[26:29]
	v_add_u32_e32 v15, 17, v93
	v_lshl_add_u32 v16, v93, 23, v48
	v_lshlrev_b32_e64 v15, v15, 1
	buffer_load_dword v26, v11, s[0:3], 0 offen
	v_cmp_lt_i32_e32 vcc, 5, v93
	v_mov_b32_e32 v32, v22
	v_mov_b32_e32 v33, v6
	v_cndmask_b32_e32 v16, v15, v16, vcc
	s_mov_b32 s0, 0xbfb8aa3b
	v_add_u32_e32 v27, 17, v92
	s_waitcnt vmcnt(3)
	v_pk_mul_f32 v[28:29], v[12:13], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[28:29], v[32:33], v[28:29]
	v_add_u32_e32 v31, 17, v91
	v_pk_mul_f32 v[32:33], v[28:29], s[0:1] op_sel_hi:[1,0]
	v_mov_b32_e32 v6, 0x2000
	v_exp_f32_e32 v32, v32
	v_exp_f32_e32 v33, v33
	v_lshl_add_u32 v15, v92, 23, v48
	v_lshlrev_b32_e64 v27, v27, 1
	v_cmp_lt_i32_e32 vcc, 5, v92
	v_pk_add_f32 v[32:33], v[32:33], 1.0 op_sel_hi:[1,0]
	v_lshl_or_b32 v11, v88, 11, v6
	v_rcp_f32_e32 v32, v32
	v_rcp_f32_e32 v33, v33
	v_lshl_add_u32 v6, v91, 23, v48
	v_lshlrev_b32_e64 v22, v31, 1
	v_cndmask_b32_e32 v35, v27, v15, vcc
	v_cmp_lt_i32_e32 vcc, 5, v91
	v_mov_b32_e32 v38, v18
	v_mov_b32_e32 v39, v2
	v_cndmask_b32_e32 v34, v22, v6, vcc
	v_pk_mul_f32 v[36:37], v[12:13], v[34:35] op_sel_hi:[0,1]
	v_pk_mul_f32 v[36:37], v[38:39], v[36:37]
	v_pk_mul_f32 v[28:29], v[28:29], v[32:33]
	s_movk_i32 s34, 0x7fff
	v_pk_mul_f32 v[28:29], v[36:37], v[28:29]
	v_lshl_add_u32 v46, v90, 1, v11
	v_bfe_u32 v2, v29, 16, 1
	v_add3_u32 v2, v2, v29, s34
	v_or_b32_e32 v6, 0x400000, v29
	v_cmp_u_f32_e32 vcc, v29, v29
	v_or_b32_e32 v12, 0x400000, v28
	v_mov_b32_e32 v18, v24
	v_cndmask_b32_e32 v2, v2, v6, vcc
	v_bfe_u32 v6, v28, 16, 1
	v_add3_u32 v6, v6, v28, s34
	v_cmp_u_f32_e32 vcc, v28, v28
	s_lshl_b32 s2, s48, 2
	s_mulk_i32 s11, 0xe00
	v_cndmask_b32_e32 v6, v6, v12, vcc
	ds_write_b16_d16_hi v46, v6
	s_waitcnt vmcnt(2)
	v_pk_mul_f32 v[28:29], v[30:31], v[16:17] op_sel_hi:[0,1]
	v_mov_b32_e32 v6, v23
	v_pk_mul_f32 v[6:7], v[6:7], v[28:29]
	v_add_u32_e32 v12, s5, v1
	v_pk_mul_f32 v[22:23], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_lshl_add_u32 v47, v12, 1, v11
	v_exp_f32_e32 v22, v22
	v_exp_f32_e32 v23, v23
	ds_write_b16_d16_hi v47, v2 offset:32
	v_pk_mul_f32 v[28:29], v[30:31], v[34:35] op_sel_hi:[0,1]
	v_mov_b32_e32 v2, v19
	v_pk_add_f32 v[22:23], v[22:23], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[2:3], v[2:3], v[28:29]
	v_rcp_f32_e32 v22, v22
	v_rcp_f32_e32 v23, v23
	v_mov_b32_e32 v19, v8
	v_mov_b32_e32 v8, v25
	s_and_b32 s29, s23, 0xffff
	v_pk_mul_f32 v[6:7], v[6:7], v[22:23]
	s_mov_b32 s30, -1
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	s_mov_b32 s28, s22
	v_bfe_u32 v6, v3, 16, 1
	v_add3_u32 v6, v6, v3, s34
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v12, 0x400000, v2
	s_mov_b32 s31, s3
	v_cndmask_b32_e32 v3, v6, v7, vcc
	v_bfe_u32 v6, v2, 16, 1
	v_add3_u32 v11, v6, v2, s34
	s_waitcnt vmcnt(1)
	v_pk_mul_f32 v[6:7], v[14:15], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[18:19], v[6:7]
	v_cmp_u_f32_e32 vcc, v2, v2
	v_pk_mul_f32 v[18:19], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[14:15], v[14:15], v[34:35] op_sel_hi:[0,1]
	v_exp_f32_e32 v18, v18
	v_exp_f32_e32 v19, v19
	v_cndmask_b32_e32 v2, v11, v12, vcc
	ds_write_b16_d16_hi v47, v2 offset:512
	ds_write_b16_d16_hi v47, v3 offset:544
	s_mov_b32 s6, 0x400000
	v_pk_add_f32 v[2:3], v[18:19], 1.0 op_sel_hi:[1,0]
	v_mov_b32_e32 v18, v20
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v19, v4
	v_pk_mul_f32 v[14:15], v[18:19], v[14:15]
	s_mov_b32 s24, s14
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	s_mov_b32 s27, s3
	v_pk_mul_f32 v[2:3], v[14:15], v[2:3]
	s_mov_b32 s44, s18
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s34
	v_or_b32_e32 v6, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	v_or_b32_e32 v11, 0x400000, v2
	s_mov_b32 s46, s6
	v_cndmask_b32_e32 v3, v4, v6, vcc
	s_waitcnt vmcnt(0)
	v_pk_mul_f32 v[6:7], v[26:27], v[16:17] op_sel_hi:[0,1]
	v_pk_mul_f32 v[6:7], v[8:9], v[6:7]
	v_bfe_u32 v4, v2, 16, 1
	v_pk_mul_f32 v[8:9], v[6:7], s[0:1] op_sel_hi:[1,0]
	v_add3_u32 v4, v4, v2, s34
	v_exp_f32_e32 v8, v8
	v_exp_f32_e32 v9, v9
	v_cmp_u_f32_e32 vcc, v2, v2
	s_lshl_b32 s0, s48, 8
	s_mov_b32 s1, 0x43700000
	v_cndmask_b32_e32 v2, v4, v11, vcc
	ds_write_b16_d16_hi v47, v2 offset:1024
	ds_write_b16_d16_hi v47, v3 offset:1056
	v_pk_add_f32 v[2:3], v[8:9], 1.0 op_sel_hi:[1,0]
	v_pk_mul_f32 v[8:9], v[26:27], v[34:35] op_sel_hi:[0,1]
	v_rcp_f32_e32 v2, v2
	v_rcp_f32_e32 v3, v3
	v_mov_b32_e32 v4, v21
	v_pk_mul_f32 v[4:5], v[4:5], v[8:9]
	v_mov_b32_e32 v8, 0x7fc00000
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3]
	v_lshlrev_b32_e32 v7, 2, v89
	v_pk_mul_f32 v[2:3], v[4:5], v[2:3]
	s_mov_b32 s47, s3
	v_bfe_u32 v4, v3, 16, 1
	v_add3_u32 v4, v4, v3, s34
	v_or_b32_e32 v5, 0x400000, v3
	v_cmp_u_f32_e32 vcc, v3, v3
	s_mov_b32 s10, 0x800000
	s_and_b32 s9, s17, 0xffff
	v_cndmask_b32_e32 v3, v4, v5, vcc
	v_bfe_u32 v4, v2, 16, 1
	v_add3_u32 v4, v4, v2, s34
	v_or_b32_e32 v5, 0x400000, v2
	v_cmp_u_f32_e32 vcc, v2, v2
	s_mov_b32 s36, s16
	s_mov_b32 s37, s9
	v_cndmask_b32_e32 v2, v4, v5, vcc
	ds_write_b16_d16_hi v47, v2 offset:1536
	ds_write_b16_d16_hi v47, v3 offset:1568
	v_or_b32_e32 v2, s0, v7
	v_lshlrev_b32_e32 v2, 1, v2
	s_waitcnt lgkmcnt(0)
	s_barrier
	ds_read_b64 v[2:3], v2 offset:8192
	s_mov_b32 s38, s10
	s_mov_b32 s39, s3
	s_mov_b32 s17, 0
	s_mov_b32 s8, s16
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v5, 0xffff0000, v3
	v_lshlrev_b32_e32 v4, 16, v3
	v_and_b32_e32 v3, 0xffff0000, v2
	v_lshlrev_b32_e32 v2, 16, v2
	v_max_f32_e64 v6, |v2|, 0
	v_cmp_o_f32_e64 vcc, |v2|, |v2|
	s_mov_b32 s22, s30
	s_mov_b32 s23, s3
	v_cndmask_b32_e32 v6, v8, v6, vcc
	v_max_f32_e64 v9, v6, |v3|
	v_cmp_o_f32_e64 vcc, v6, |v3|
	s_and_b32 s21, s21, 0xffff
	v_lshlrev_b32_e32 v51, 2, v82
	v_cndmask_b32_e32 v6, v8, v9, vcc
	v_max_f32_e64 v9, v6, |v4|
	v_cmp_o_f32_e64 vcc, v6, |v4|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	v_max_f32_e64 v9, v6, |v5|
	v_cmp_o_f32_e64 vcc, v6, |v5|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v9, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v9, v6 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	v_xor_b32_e32 v9, 0x80, v7
	s_nop 0
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_bpermute_b32 v11, v9, v6
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v12, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v12, vcc
	v_div_scale_f32 v11, s[4:5], s1, s1, v6
	v_rcp_f32_e32 v12, v11
	s_nop 0
	v_fma_f32 v14, -v11, v12, 1.0
	v_fmac_f32_e32 v12, v14, v12
	v_div_scale_f32 v14, vcc, v6, s1, v6
	v_mul_f32_e32 v15, v14, v12
	v_fma_f32 v16, -v11, v15, v14
	v_fmac_f32_e32 v15, v16, v12
	v_fma_f32 v11, -v11, v15, v14
	v_div_fmas_f32 v11, v11, v12, v15
	v_div_fixup_f32 v11, v11, s1, v6
	v_cmp_neq_f32_e32 vcc, 0, v6
	s_nop 1
	v_cndmask_b32_e32 v11, 1.0, v11, vcc
	v_div_scale_f32 v6, s[4:5], v11, v11, 1.0
	v_rcp_f32_e32 v12, v6
	s_nop 0
	v_fma_f32 v14, -v6, v12, 1.0
	v_fmac_f32_e32 v12, v14, v12
	v_div_scale_f32 v14, vcc, 1.0, v11, 1.0
	v_mul_f32_e32 v15, v14, v12
	v_fma_f32 v16, -v6, v15, v14
	v_fmac_f32_e32 v15, v16, v12
	v_fma_f32 v6, -v6, v15, v14
	v_div_fmas_f32 v6, v6, v12, v15
	v_div_fixup_f32 v6, v6, v11, 1.0
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[6:7], v[4:5] op_sel_hi:[0,1]
	v_min_f32_e32 v6, 0x43700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	v_mov_b32_e32 v12, s2
	s_lshl_b32 s2, s48, 4
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	s_and_b32 s2, s2, 0xf0
	ds_write_b32 v12, v11 offset:4096
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_add_i32 s48, s48, 8
	s_nop 0
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	s_nop 1
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_nop 1
	v_cndmask_b32_e32 v5, v8, v6, vcc
	v_mov_b32_e32 v6, v13
	v_cvt_pk_fp8_f32 v6, v2, v3
	v_max_f32_e32 v2, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	v_xor_b32_e32 v3, s2, v7
	v_or_b32_e32 v3, s0, v3
	v_cndmask_b32_e32 v2, v8, v2, vcc
	v_cvt_pk_fp8_f32 v6, v4, v2 op_sel:[0,0,1]
	s_brev_b32 s2, 16
	s_mov_b32 s26, s2
	v_and_b32_e32 v2, 0x7f7f7f7f, v6
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v2, v2, v6
	ds_write_b32 v3, v2
	v_lshlrev_b32_e32 v2, 3, v89
	v_lshl_or_b32 v2, s48, 9, v2
	ds_read_b64 v[2:3], v2 offset:8192
	s_waitcnt lgkmcnt(0)
	v_and_b32_e32 v5, 0xffff0000, v3
	v_lshlrev_b32_e32 v4, 16, v3
	v_and_b32_e32 v3, 0xffff0000, v2
	v_lshlrev_b32_e32 v2, 16, v2
	v_max_f32_e64 v6, |v2|, 0
	v_cmp_o_f32_e64 vcc, |v2|, |v2|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v6, vcc
	v_max_f32_e64 v11, v6, |v3|
	v_cmp_o_f32_e64 vcc, v6, |v3|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	v_max_f32_e64 v11, v6, |v4|
	v_cmp_o_f32_e64 vcc, v6, |v4|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	v_max_f32_e64 v11, v6, |v5|
	v_cmp_o_f32_e64 vcc, v6, |v5|
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,1)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v14, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,2)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v14, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,4)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v14, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,8)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v14, vcc
	ds_swizzle_b32 v11, v6 offset:swizzle(SWAP,16)
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v14, v6, v11
	v_cmp_o_f32_e32 vcc, v6, v11
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v14, vcc
	ds_bpermute_b32 v9, v9, v6
	s_waitcnt lgkmcnt(0)
	v_max_f32_e32 v11, v6, v9
	v_cmp_o_f32_e32 vcc, v6, v9
	s_nop 1
	v_cndmask_b32_e32 v6, v8, v11, vcc
	v_div_scale_f32 v9, s[4:5], s1, s1, v6
	v_rcp_f32_e32 v11, v9
	s_nop 0
	v_fma_f32 v14, -v9, v11, 1.0
	v_fmac_f32_e32 v11, v14, v11
	v_div_scale_f32 v14, vcc, v6, s1, v6
	v_mul_f32_e32 v15, v14, v11
	v_fma_f32 v16, -v9, v15, v14
	v_fmac_f32_e32 v15, v16, v11
	v_fma_f32 v9, -v9, v15, v14
	v_div_fmas_f32 v9, v9, v11, v15
	v_div_fixup_f32 v9, v9, s1, v6
	v_cmp_neq_f32_e32 vcc, 0, v6
	s_lshl_b32 s1, s48, 4
	s_and_b32 s1, s1, 0xf0
	v_cndmask_b32_e32 v9, 1.0, v9, vcc
	v_div_scale_f32 v6, s[4:5], v9, v9, 1.0
	v_rcp_f32_e32 v11, v6
	ds_write_b32 v12, v9 offset:4128
	s_and_b32 s5, s19, 0xffff
	s_mov_b32 s45, s5
	v_fma_f32 v14, -v6, v11, 1.0
	v_fmac_f32_e32 v11, v14, v11
	v_div_scale_f32 v14, vcc, 1.0, v9, 1.0
	v_mul_f32_e32 v15, v14, v11
	v_fma_f32 v16, -v6, v15, v14
	v_fmac_f32_e32 v15, v16, v11
	v_fma_f32 v6, -v6, v15, v14
	v_div_fmas_f32 v6, v6, v11, v15
	v_div_fixup_f32 v6, v6, v9, 1.0
	v_pk_mul_f32 v[2:3], v[6:7], v[2:3] op_sel_hi:[0,1]
	v_pk_mul_f32 v[4:5], v[6:7], v[4:5] op_sel_hi:[0,1]
	v_min_f32_e32 v6, 0x43700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v2
	v_cmp_o_f32_e32 vcc, v2, v2
	s_nop 1
	v_cndmask_b32_e32 v2, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v3
	v_cmp_o_f32_e32 vcc, v3, v3
	s_nop 1
	v_cndmask_b32_e32 v3, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_cvt_pk_fp8_f32 v13, v2, v3
	v_xor_b32_e32 v3, s1, v7
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_max_f32_e32 v6, 0xc3700000, v4
	v_cmp_o_f32_e32 vcc, v4, v4
	v_or_b32_e32 v3, s0, v3
	s_and_b32 s1, s15, 0xffff
	v_cndmask_b32_e32 v4, v8, v6, vcc
	v_min_f32_e32 v6, 0x43700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_add_i32 s15, s49, s11
	s_lshl_b32 s0, s15, 1
	v_cndmask_b32_e32 v5, v8, v6, vcc
	v_max_f32_e32 v2, 0xc3700000, v5
	v_cmp_o_f32_e32 vcc, v5, v5
	s_ashr_i32 s4, s15, 31
	s_lshr_b32 s7, s4, 27
	v_cndmask_b32_e32 v2, v8, v2, vcc
	v_cvt_pk_fp8_f32 v13, v4, v2 op_sel:[0,0,1]
	s_mov_b32 s25, s1
	v_lshlrev_b32_e32 v6, 1, v0
	v_and_b32_e32 v50, 62, v6
	v_and_b32_e32 v2, 0x7f7f7f7f, v13
	v_add_u32_e32 v2, 0x7f7f7f7f, v2
	v_or_b32_e32 v2, 0x7f7f7f7f, v2
	v_and_b32_e32 v2, v2, v13
	ds_write_b32 v3, v2 offset:2048
	v_lshlrev_b32_e32 v2, 2, v10
	v_or_b32_e32 v3, 4, v2
	s_waitcnt lgkmcnt(0)
	s_barrier
	v_or_b32_e32 v4, 8, v2
	v_or_b32_e32 v5, 12, v2
	buffer_load_dword v38, v2, s[28:31], 0 offen
	buffer_load_dword v39, v3, s[28:31], 0 offen
	buffer_load_dword v40, v4, s[28:31], 0 offen
	buffer_load_dword v41, v5, s[28:31], 0 offen
	v_or3_b32 v3, s0, v86, v1
	s_lshl_b32 s0, s15, 3
	v_or3_b32 v4, s0, v86, v1
	s_or_b32 s0, s15, 16
	s_add_i32 s7, s0, s7
	s_lshr_b32 s7, s7, 5
	v_or_b32_e32 v2, s15, v1
	v_lshlrev_b32_e32 v4, 4, v4
	s_add_i32 s7, s7, s4
	v_lshlrev_b32_e32 v2, 2, v2
	v_or_b32_e32 v5, 0x400, v4
	buffer_load_dwordx4 v[34:37], v4, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[30:33], v5, s[24:27], 0 offen nt
	v_or_b32_e32 v4, s0, v1
	s_lshl_b32 s4, s7, 6
	v_lshlrev_b32_e32 v4, 2, v4
	buffer_load_dword v61, v2, s[44:47], 0 offen
	buffer_load_dword v60, v4, s[44:47], 0 offen
	v_or3_b32 v2, s4, v86, v1
	v_lshlrev_b32_e32 v3, 2, v3
	v_lshlrev_b32_e32 v2, 2, v2
	s_lshl_b32 s0, s0, 3
	buffer_load_dword v62, v3, s[36:39], 0 offen
	buffer_load_dword v53, v2, s[36:39], 0 offen
	v_or3_b32 v2, s0, v86, v1
	v_lshlrev_b32_e32 v2, 4, v2
	v_or_b32_e32 v3, 0x400, v2
	buffer_load_dwordx4 v[26:29], v2, s[24:27], 0 offen nt
	buffer_load_dwordx4 v[22:25], v3, s[24:27], 0 offen nt
	v_lshlrev_b32_e32 v2, 4, v88
	ds_read_b128 v[2:5], v2 offset:4096
	v_or_b32_e32 v6, v87, v50
	v_lshlrev_b32_e32 v49, 1, v6
	v_lshlrev_b32_e32 v6, 2, v0
	v_lshlrev_b32_e32 v0, 4, v0
	s_mov_b32 s0, s14
	s_mov_b32 s11, s3
	s_mov_b32 s7, s3
	s_mov_b32 s4, s18
	s_add_i32 s18, s15, 1
	s_add_i32 s16, s15, 0x100
	v_and_b32_e32 v56, 0xfc, v6
	v_and_b32_e32 v57, 0x3f0, v0
	s_branch .LBB0_5
.LBB0_4:
	s_or_b64 exec, exec, s[14:15]
	s_add_i32 s17, s17, 1
	s_cmp_lg_u32 s17, 15
	v_mov_b64_e32 v[36:37], v[20:21]
	v_mov_b64_e32 v[34:35], v[18:19]
	v_mov_b64_e32 v[32:33], v[16:17]
	v_mov_b64_e32 v[30:31], v[14:15]
	v_mov_b64_e32 v[28:29], v[12:13]
	v_mov_b64_e32 v[26:27], v[10:11]
	v_mov_b64_e32 v[24:25], v[8:9]
	v_mov_b64_e32 v[22:23], v[6:7]
	v_mov_b32_e32 v60, v0
	v_mov_b32_e32 v61, v52
	v_mov_b32_e32 v62, v58
	s_barrier
	s_cbranch_scc0 .LBB0_7
.LBB0_5:
	s_lshl_b32 s19, s17, 8
	s_add_i32 s14, s18, s19
	s_lshr_b32 s15, s14, 31
	s_add_i32 s15, s14, s15
	s_and_b32 s15, s15, 0x1ffffffe
	s_sub_i32 s14, s14, s15
	s_lshl_b32 s14, s14, 3
	s_waitcnt vmcnt(2)
	v_bfe_u32 v66, v53, s14, 8
	s_add_i32 s14, s14, 16
	v_bfe_u32 v67, v53, s14, 8
	s_add_i32 s14, s16, s19
	v_or_b32_e32 v0, s14, v1
	v_lshlrev_b32_e32 v6, 2, v0
	v_lshl_or_b32 v7, s14, 3, v56
	v_lshl_or_b32 v0, s14, 7, v57
	s_or_b32 s15, s14, 16
	s_ashr_i32 s14, s14, 31
	s_lshr_b32 s24, s14, 27
	s_add_i32 s24, s15, s24
	s_lshr_b32 s24, s24, 5
	buffer_load_dwordx4 v[18:21], v0, s[0:3], 0 offen nt
	buffer_load_dwordx4 v[14:17], v0, s[0:3], 0 offen offset:1024 nt
	v_or_b32_e32 v0, s15, v1
	s_add_i32 s24, s24, s14
	v_lshlrev_b32_e32 v8, 2, v0
	buffer_load_dword v52, v6, s[4:7], 0 offen
	buffer_load_dword v0, v8, s[4:7], 0 offen
	v_lshl_or_b32 v6, s24, 8, v56
	v_lshl_or_b32 v59, s15, 7, v57
	buffer_load_dword v58, v7, s[8:11], 0 offen
	buffer_load_dword v53, v6, s[8:11], 0 offen
	buffer_load_dwordx4 v[10:13], v59, s[0:3], 0 offen nt
	s_nop 0
	buffer_load_dwordx4 v[6:9], v59, s[0:3], 0 offen offset:1024 nt
	v_sub_u32_sdwa v59, v61, v62 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v63, 11, v59
	v_mul_lo_u32 v63, v63, s40
	v_sub_u32_e32 v64, 0x6c686080, v63
	v_and_b32_e32 v64, 0xffffff00, v64
	v_cmp_lt_i32_e32 vcc, 11, v59
	v_sub_u32_e32 v63, 0x7c787470, v63
	v_lshlrev_b32_e32 v78, 4, v35
	v_cndmask_b32_e64 v68, v64, 0, vcc
	v_cndmask_b32_e64 v69, v63, 0, vcc
	v_add_u32_e32 v59, 0x7f7f7f00, v68
	v_and_b32_e32 v70, 0x80808000, v59
	v_add_u32_e32 v59, 0x7f7f7f78, v69
	v_and_b32_e32 v71, 0x80808080, v59
	v_sub_u32_sdwa v59, v61, v62 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v62, 11, v59
	v_mul_lo_u32 v62, v62, s40
	v_sub_u32_e32 v63, 0x6c686080, v62
	v_and_b32_e32 v63, 0xffffff00, v63
	v_cmp_lt_i32_e32 vcc, 11, v59
	v_sub_u32_e32 v62, 0x7c787470, v62
	v_lshlrev_b32_e32 v64, 4, v34
	v_cndmask_b32_e64 v72, v63, 0, vcc
	v_cndmask_b32_e64 v73, v62, 0, vcc
	v_add_u32_e32 v59, 0x7f7f7f00, v72
	v_and_b32_e32 v74, 0x80808000, v59
	v_add_u32_e32 v59, 0x7f7f7f78, v73
	v_and_b32_e32 v75, 0x80808080, v59
	v_and_b32_e32 v59, 0x7070707, v34
	v_lshrrev_b32_e32 v62, 4, v34
	v_perm_b32 v63, v71, v70, v59
	v_perm_b32 v59, v69, v68, v59
	v_and_b32_e32 v62, 0x7070707, v62
	v_and_or_b32 v63, v63, v64, v59
	v_add_u32_e32 v59, v84, v85
	ds_read_b64 v[80:81], v59
	v_perm_b32 v64, v71, v70, v62
	v_perm_b32 v62, v69, v68, v62
	v_and_or_b32 v34, v64, v34, v62
	v_perm_b32 v62, v34, v63, s41
	v_perm_b32 v63, v34, v63, s42
	v_and_b32_e32 v34, 0x7070707, v35
	v_perm_b32 v77, v71, v70, v34
	v_perm_b32 v34, v69, v68, v34
	v_and_or_b32 v77, v77, v78, v34
	ds_read_b64 v[78:79], v42
	v_lshrrev_b32_e32 v76, 4, v35
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[80:81], v[62:63], 0
	v_and_b32_e32 v76, 0x7070707, v76
	v_perm_b32 v34, v71, v70, v76
	v_perm_b32 v76, v69, v68, v76
	v_and_or_b32 v35, v34, v35, v76
	v_perm_b32 v34, v35, v77, s41
	v_perm_b32 v35, v35, v77, s42
	v_lshlrev_b32_e32 v77, 4, v36
	ds_read_b64 v[92:93], v43
	ds_read_b64 v[94:95], v44
	ds_read_b64 v[96:97], v83
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[78:79], v[34:35], v[62:65]
	v_and_b32_e32 v34, 0x7070707, v36
	v_lshrrev_b32_e32 v35, 4, v36
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v76, v71, v70, v34
	v_perm_b32 v34, v69, v68, v34
	v_and_or_b32 v76, v76, v77, v34
	v_perm_b32 v34, v71, v70, v35
	v_perm_b32 v35, v69, v68, v35
	v_and_or_b32 v35, v34, v36, v35
	v_perm_b32 v34, v35, v76, s41
	v_perm_b32 v35, v35, v76, s42
	v_lshlrev_b32_e32 v76, 4, v37
	ds_read_b64 v[86:87], v55
	ds_read_b64 v[88:89], v54
	ds_read_b64 v[90:91], v45
	s_waitcnt lgkmcnt(5)
	v_mfma_f32_16x16x32_fp8_fp8 v[62:65], v[92:93], v[34:35], v[62:65]
	v_and_b32_e32 v34, 0x7070707, v37
	v_lshrrev_b32_e32 v35, 4, v37
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v71, v70, v34
	v_perm_b32 v34, v69, v68, v34
	v_and_or_b32 v36, v36, v76, v34
	v_perm_b32 v34, v71, v70, v35
	v_perm_b32 v35, v69, v68, v35
	v_and_or_b32 v35, v34, v37, v35
	v_perm_b32 v34, v35, v36, s41
	v_perm_b32 v35, v35, v36, s42
	s_waitcnt vmcnt(9)
	v_lshrrev_b32_e32 v70, 4, v27
	v_and_b32_e32 v70, 0x7070707, v70
	s_waitcnt lgkmcnt(4)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[94:95], v[34:35], v[62:65]
	s_nop 2
	v_and_b32_e32 v62, 0x7070707, v30
	v_lshrrev_b32_e32 v63, 4, v30
	v_and_b32_e32 v63, 0x7070707, v63
	v_perm_b32 v64, v75, v74, v62
	v_lshlrev_b32_e32 v65, 4, v30
	v_perm_b32 v62, v73, v72, v62
	v_and_or_b32 v64, v64, v65, v62
	v_perm_b32 v62, v75, v74, v63
	v_perm_b32 v63, v73, v72, v63
	v_and_or_b32 v30, v62, v30, v63
	v_perm_b32 v62, v30, v64, s41
	v_perm_b32 v63, v30, v64, s42
	v_and_b32_e32 v30, 0x7070707, v31
	v_lshlrev_b32_e32 v64, 4, v31
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[86:87], v[62:63], v[34:37]
	v_lshrrev_b32_e32 v62, 4, v31
	v_and_b32_e32 v62, 0x7070707, v62
	v_perm_b32 v63, v75, v74, v30
	v_perm_b32 v30, v73, v72, v30
	v_and_or_b32 v63, v63, v64, v30
	v_perm_b32 v30, v75, v74, v62
	v_perm_b32 v62, v73, v72, v62
	v_and_or_b32 v31, v30, v31, v62
	v_perm_b32 v30, v31, v63, s41
	v_perm_b32 v31, v31, v63, s42
	v_lshlrev_b32_e32 v63, 4, v32
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[88:89], v[30:31], v[34:37]
	v_and_b32_e32 v30, 0x7070707, v32
	v_lshrrev_b32_e32 v31, 4, v32
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v62, v75, v74, v30
	v_perm_b32 v30, v73, v72, v30
	v_and_or_b32 v62, v62, v63, v30
	v_perm_b32 v30, v75, v74, v31
	v_perm_b32 v31, v73, v72, v31
	v_and_or_b32 v31, v30, v32, v31
	v_perm_b32 v30, v31, v62, s41
	v_perm_b32 v31, v31, v62, s42
	v_lshlrev_b32_e32 v62, 4, v33
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[90:91], v[30:31], v[34:37]
	v_and_b32_e32 v30, 0x7070707, v33
	v_lshrrev_b32_e32 v31, 4, v33
	v_and_b32_e32 v31, 0x7070707, v31
	v_perm_b32 v32, v75, v74, v30
	v_perm_b32 v30, v73, v72, v30
	v_and_or_b32 v32, v32, v62, v30
	v_perm_b32 v30, v75, v74, v31
	v_perm_b32 v31, v73, v72, v31
	v_and_or_b32 v31, v30, v33, v31
	v_perm_b32 v30, v31, v32, s41
	v_perm_b32 v31, v31, v32, s42
	v_lshlrev_b32_e32 v72, 4, v27
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[30:33], v[96:97], v[30:31], v[34:37]
	s_nop 2
	v_sub_u32_e32 v34, v60, v66
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	v_lshlrev_b32_e32 v37, 4, v26
	v_cndmask_b32_e64 v62, v36, 0, vcc
	v_cndmask_b32_e64 v63, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v62
	v_and_b32_e32 v64, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v63
	v_and_b32_e32 v65, 0x80808080, v34
	v_sub_u32_e32 v34, v60, v67
	v_min_i32_e32 v35, 11, v34
	v_mul_lo_u32 v35, v35, s40
	v_sub_u32_e32 v36, 0x6c686080, v35
	v_and_b32_e32 v36, 0xffffff00, v36
	v_cmp_lt_i32_e32 vcc, 11, v34
	v_sub_u32_e32 v35, 0x7c787470, v35
	s_nop 0
	v_cndmask_b32_e64 v66, v36, 0, vcc
	v_cndmask_b32_e64 v67, v35, 0, vcc
	v_add_u32_e32 v34, 0x7f7f7f00, v66
	v_and_b32_e32 v68, 0x80808000, v34
	v_add_u32_e32 v34, 0x7f7f7f78, v67
	v_and_b32_e32 v69, 0x80808080, v34
	v_and_b32_e32 v34, 0x7070707, v26
	v_lshrrev_b32_e32 v35, 4, v26
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v65, v64, v34
	v_perm_b32 v34, v63, v62, v34
	v_and_or_b32 v36, v36, v37, v34
	v_perm_b32 v34, v65, v64, v35
	v_perm_b32 v35, v63, v62, v35
	v_and_or_b32 v26, v34, v26, v35
	v_perm_b32 v34, v26, v36, s41
	v_perm_b32 v35, v26, v36, s42
	v_and_b32_e32 v26, 0x7070707, v27
	v_perm_b32 v71, v65, v64, v26
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[80:81], v[34:35], 0
	v_perm_b32 v26, v63, v62, v26
	v_and_or_b32 v71, v71, v72, v26
	v_perm_b32 v26, v65, v64, v70
	v_perm_b32 v70, v63, v62, v70
	v_and_or_b32 v27, v26, v27, v70
	v_perm_b32 v26, v27, v71, s41
	v_perm_b32 v27, v27, v71, s42
	v_lshlrev_b32_e32 v71, 4, v28
	v_cmp_lt_i32_e32 vcc, 5, v61
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[78:79], v[26:27], v[34:37]
	v_and_b32_e32 v26, 0x7070707, v28
	v_lshrrev_b32_e32 v27, 4, v28
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v70, v65, v64, v26
	v_perm_b32 v26, v63, v62, v26
	v_and_or_b32 v70, v70, v71, v26
	v_perm_b32 v26, v65, v64, v27
	v_perm_b32 v27, v63, v62, v27
	v_and_or_b32 v27, v26, v28, v27
	v_perm_b32 v26, v27, v70, s41
	v_perm_b32 v27, v27, v70, s42
	v_lshlrev_b32_e32 v70, 4, v29
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[34:37], v[92:93], v[26:27], v[34:37]
	v_and_b32_e32 v26, 0x7070707, v29
	v_lshrrev_b32_e32 v27, 4, v29
	v_and_b32_e32 v27, 0x7070707, v27
	v_perm_b32 v28, v65, v64, v26
	v_perm_b32 v26, v63, v62, v26
	v_and_or_b32 v28, v28, v70, v26
	v_perm_b32 v26, v65, v64, v27
	v_perm_b32 v27, v63, v62, v27
	v_and_or_b32 v27, v26, v29, v27
	v_perm_b32 v26, v27, v28, s41
	v_perm_b32 v27, v27, v28, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[94:95], v[26:27], v[34:37]
	s_waitcnt vmcnt(8)
	s_nop 1
	v_and_b32_e32 v34, 0x7070707, v22
	v_lshrrev_b32_e32 v35, 4, v22
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v69, v68, v34
	v_lshlrev_b32_e32 v37, 4, v22
	v_perm_b32 v34, v67, v66, v34
	v_and_or_b32 v36, v36, v37, v34
	v_perm_b32 v34, v69, v68, v35
	v_perm_b32 v35, v67, v66, v35
	v_and_or_b32 v22, v34, v22, v35
	v_perm_b32 v34, v22, v36, s41
	v_perm_b32 v35, v22, v36, s42
	v_and_b32_e32 v22, 0x7070707, v23
	v_lshlrev_b32_e32 v36, 4, v23
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[86:87], v[34:35], v[26:29]
	v_lshrrev_b32_e32 v34, 4, v23
	v_and_b32_e32 v34, 0x7070707, v34
	v_perm_b32 v35, v69, v68, v22
	v_perm_b32 v22, v67, v66, v22
	v_and_or_b32 v35, v35, v36, v22
	v_perm_b32 v22, v69, v68, v34
	v_perm_b32 v34, v67, v66, v34
	v_and_or_b32 v23, v22, v23, v34
	v_perm_b32 v22, v23, v35, s41
	v_perm_b32 v23, v23, v35, s42
	v_lshlrev_b32_e32 v35, 4, v24
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[88:89], v[22:23], v[26:29]
	v_and_b32_e32 v22, 0x7070707, v24
	v_lshrrev_b32_e32 v23, 4, v24
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v34, v69, v68, v22
	v_perm_b32 v22, v67, v66, v22
	v_and_or_b32 v34, v34, v35, v22
	v_perm_b32 v22, v69, v68, v23
	v_perm_b32 v23, v67, v66, v23
	v_and_or_b32 v23, v22, v24, v23
	v_perm_b32 v22, v23, v34, s41
	v_perm_b32 v23, v23, v34, s42
	v_lshlrev_b32_e32 v34, 4, v25
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[26:29], v[90:91], v[22:23], v[26:29]
	v_and_b32_e32 v22, 0x7070707, v25
	v_lshrrev_b32_e32 v23, 4, v25
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v69, v68, v22
	v_perm_b32 v22, v67, v66, v22
	v_and_or_b32 v24, v24, v34, v22
	v_perm_b32 v22, v69, v68, v23
	v_perm_b32 v23, v67, v66, v23
	v_and_or_b32 v23, v22, v25, v23
	v_perm_b32 v22, v23, v24, s41
	v_perm_b32 v23, v23, v24, s42
	s_nop 1
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[96:97], v[22:23], v[26:29]
	s_nop 2
	v_add_u32_e32 v27, 17, v61
	v_lshl_add_u32 v26, v61, 23, v48
	v_lshlrev_b32_e64 v27, v27, 1
	v_add_u32_e32 v28, 17, v60
	v_cndmask_b32_e32 v26, v27, v26, vcc
	v_lshl_add_u32 v27, v60, 23, v48
	v_lshlrev_b32_e64 v28, v28, 1
	v_cmp_lt_i32_e32 vcc, 5, v60
	v_pk_mul_f32 v[34:35], v[2:3], v[26:27] op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v28, v28, v27, vcc
	v_pk_mul_f32 v[26:27], v[4:5], v[26:27] op_sel_hi:[1,0]
	v_pk_mul_f32 v[30:31], v[34:35], v[30:31]
	v_pk_mul_f32 v[26:27], v[26:27], v[32:33]
	v_pk_mul_f32 v[30:31], v[30:31], v[38:39]
	v_pk_mul_f32 v[26:27], v[26:27], v[40:41]
	s_nop 0
	v_bfe_u32 v29, v27, 16, 1
	v_add3_u32 v29, v29, v27, s34
	v_or_b32_e32 v32, 0x400000, v27
	v_cmp_u_f32_e32 vcc, v27, v27
	s_nop 1
	v_cndmask_b32_e32 v27, v29, v32, vcc
	v_bfe_u32 v29, v26, 16, 1
	v_add3_u32 v29, v29, v26, s34
	v_or_b32_e32 v32, 0x400000, v26
	v_cmp_u_f32_e32 vcc, v26, v26
	s_nop 1
	v_cndmask_b32_e32 v26, v29, v32, vcc
	v_bfe_u32 v29, v31, 16, 1
	v_add3_u32 v29, v29, v31, s34
	v_or_b32_e32 v32, 0x400000, v31
	v_cmp_u_f32_e32 vcc, v31, v31
	v_bfe_u32 v31, v30, 16, 1
	v_add3_u32 v31, v31, v30, s34
	v_cndmask_b32_e32 v29, v29, v32, vcc
	v_or_b32_e32 v32, 0x400000, v30
	v_cmp_u_f32_e32 vcc, v30, v30
	s_nop 1
	v_cndmask_b32_e32 v30, v31, v32, vcc
	ds_write_b16_d16_hi v46, v30
	ds_write_b16_d16_hi v47, v29 offset:512
	ds_write_b16_d16_hi v47, v26 offset:1024
	ds_write_b16_d16_hi v47, v27 offset:1536
	v_pk_mul_f32 v[26:27], v[2:3], v[28:29] op_sel_hi:[1,0]
	v_pk_mul_f32 v[28:29], v[4:5], v[28:29] op_sel_hi:[1,0]
	v_pk_mul_f32 v[22:23], v[26:27], v[22:23]
	v_pk_mul_f32 v[24:25], v[28:29], v[24:25]
	v_pk_mul_f32 v[22:23], v[22:23], v[38:39]
	v_pk_mul_f32 v[24:25], v[24:25], v[40:41]
	s_nop 0
	v_bfe_u32 v26, v25, 16, 1
	v_add3_u32 v26, v26, v25, s34
	v_or_b32_e32 v27, 0x400000, v25
	v_cmp_u_f32_e32 vcc, v25, v25
	s_nop 1
	v_cndmask_b32_e32 v25, v26, v27, vcc
	v_bfe_u32 v26, v24, 16, 1
	v_add3_u32 v26, v26, v24, s34
	v_or_b32_e32 v27, 0x400000, v24
	v_cmp_u_f32_e32 vcc, v24, v24
	s_nop 1
	v_cndmask_b32_e32 v24, v26, v27, vcc
	v_bfe_u32 v26, v23, 16, 1
	v_add3_u32 v26, v26, v23, s34
	v_or_b32_e32 v27, 0x400000, v23
	v_cmp_u_f32_e32 vcc, v23, v23
	s_nop 1
	v_cndmask_b32_e32 v23, v26, v27, vcc
	v_bfe_u32 v26, v22, 16, 1
	v_add3_u32 v26, v26, v22, s34
	v_or_b32_e32 v27, 0x400000, v22
	v_cmp_u_f32_e32 vcc, v22, v22
	s_nop 1
	v_cndmask_b32_e32 v22, v26, v27, vcc
	ds_write_b16_d16_hi v47, v22 offset:32
	ds_write_b16_d16_hi v47, v23 offset:544
	ds_write_b16_d16_hi v47, v24 offset:1056
	ds_write_b16_d16_hi v47, v25 offset:1568
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v22, v51, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v23, 0xffffff, v22
	v_cmp_gt_i32_e32 vcc, s33, v23
	s_and_saveexec_b64 s[14:15], vcc
	s_cbranch_execz .LBB0_4
	v_lshl_add_u32 v22, v22, 12, s19
	ds_read_b32 v24, v49 offset:8192
	v_or_b32_e32 v22, v22, v50
	v_lshlrev_b32_e32 v22, 1, v22
	v_ashrrev_i32_e32 v23, 31, v22
	v_lshl_add_u64 v[22:23], s[12:13], 0, v[22:23]
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[22:23], v24, off
	ds_read_b32 v24, v49 offset:8320
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[22:23], v24, off offset:128
	ds_read_b32 v24, v49 offset:8448
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[22:23], v24, off offset:256
	ds_read_b32 v24, v49 offset:8576
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[22:23], v24, off offset:384
	s_branch .LBB0_4
.LBB0_7:
	v_sub_u32_sdwa v22, v52, v58 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_0
	v_min_i32_e32 v23, 11, v22
	s_mov_b32 s2, 0x8080808
	v_mul_lo_u32 v23, v23, s2
	v_sub_u32_e32 v24, 0x6c686080, v23
	v_and_b32_e32 v24, 0xffffff00, v24
	v_cmp_lt_i32_e32 vcc, 11, v22
	v_sub_u32_e32 v23, 0x7c787470, v23
	s_add_i32 s0, s16, 0xe01
	v_cndmask_b32_e64 v27, v24, 0, vcc
	v_cndmask_b32_e64 v28, v23, 0, vcc
	v_add_u32_e32 v22, 0x7f7f7f00, v27
	v_and_b32_e32 v29, 0x80808000, v22
	v_add_u32_e32 v22, 0x7f7f7f78, v28
	v_and_b32_e32 v30, 0x80808080, v22
	v_sub_u32_sdwa v22, v52, v58 dst_sel:DWORD dst_unused:UNUSED_PAD src0_sel:DWORD src1_sel:BYTE_2
	v_min_i32_e32 v23, 11, v22
	v_mul_lo_u32 v23, v23, s2
	v_sub_u32_e32 v24, 0x6c686080, v23
	v_and_b32_e32 v24, 0xffffff00, v24
	v_cmp_lt_i32_e32 vcc, 11, v22
	ds_read_b64 v[56:57], v59
	ds_read_b64 v[62:63], v42
	s_lshr_b32 s1, s0, 31
	v_sub_u32_e32 v23, 0x7c787470, v23
	v_cndmask_b32_e64 v31, v24, 0, vcc
	s_add_i32 s1, s0, s1
	v_cndmask_b32_e64 v32, v23, 0, vcc
	v_add_u32_e32 v22, 0x7f7f7f00, v31
	s_and_b32 s1, s1, 0x1ffffffe
	v_and_b32_e32 v33, 0x80808000, v22
	v_add_u32_e32 v22, 0x7f7f7f78, v32
	s_sub_i32 s0, s0, s1
	v_and_b32_e32 v34, 0x80808080, v22
	v_and_b32_e32 v22, 0x7070707, v18
	v_lshrrev_b32_e32 v23, 4, v18
	s_lshl_b32 s0, s0, 3
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v30, v29, v22
	v_lshlrev_b32_e32 v25, 4, v18
	v_perm_b32 v22, v28, v27, v22
	v_bfe_u32 v1, v53, s0, 8
	s_add_i32 s0, s0, 16
	v_and_or_b32 v24, v24, v25, v22
	v_perm_b32 v22, v30, v29, v23
	v_perm_b32 v23, v28, v27, v23
	v_bfe_u32 v26, v53, s0, 8
	v_and_or_b32 v18, v22, v18, v23
	s_mov_b32 s0, 0x5010400
	s_mov_b32 s1, 0x7030602
	v_perm_b32 v22, v18, v24, s0
	v_perm_b32 v23, v18, v24, s1
	v_and_b32_e32 v18, 0x7070707, v19
	v_lshrrev_b32_e32 v35, 4, v19
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[56:57], v[22:23], 0
	v_and_b32_e32 v35, 0x7070707, v35
	v_perm_b32 v36, v30, v29, v18
	v_lshlrev_b32_e32 v37, 4, v19
	v_perm_b32 v18, v28, v27, v18
	v_and_or_b32 v36, v36, v37, v18
	v_perm_b32 v18, v30, v29, v35
	v_perm_b32 v35, v28, v27, v35
	v_and_or_b32 v19, v18, v19, v35
	v_perm_b32 v18, v19, v36, s0
	v_perm_b32 v19, v19, v36, s1
	v_lshlrev_b32_e32 v36, 4, v20
	ds_read_b64 v[58:59], v55
	ds_read_b64 v[54:55], v54
	ds_read_b64 v[60:61], v45
	s_waitcnt lgkmcnt(3)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[62:63], v[18:19], v[22:25]
	v_and_b32_e32 v18, 0x7070707, v20
	v_lshrrev_b32_e32 v19, 4, v20
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v35, v30, v29, v18
	v_perm_b32 v18, v28, v27, v18
	ds_read_b64 v[42:43], v43
	ds_read_b64 v[44:45], v44
	ds_read_b64 v[64:65], v83
	v_and_or_b32 v35, v35, v36, v18
	v_perm_b32 v18, v30, v29, v19
	v_perm_b32 v19, v28, v27, v19
	v_and_or_b32 v19, v18, v20, v19
	v_perm_b32 v18, v19, v35, s0
	v_perm_b32 v19, v19, v35, s1
	v_lshlrev_b32_e32 v35, 4, v21
	v_sub_u32_e32 v1, v0, v1
	s_waitcnt lgkmcnt(2)
	v_mfma_f32_16x16x32_fp8_fp8 v[22:25], v[42:43], v[18:19], v[22:25]
	v_and_b32_e32 v18, 0x7070707, v21
	v_lshrrev_b32_e32 v19, 4, v21
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v30, v29, v18
	v_perm_b32 v18, v28, v27, v18
	v_and_or_b32 v20, v20, v35, v18
	v_perm_b32 v18, v30, v29, v19
	v_perm_b32 v19, v28, v27, v19
	v_and_or_b32 v19, v18, v21, v19
	v_perm_b32 v18, v19, v20, s0
	v_perm_b32 v19, v19, v20, s1
	v_cmp_lt_i32_e32 vcc, 11, v1
	v_lshrrev_b32_e32 v29, 4, v11
	s_waitcnt lgkmcnt(1)
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[44:45], v[18:19], v[22:25]
	v_and_b32_e32 v29, 0x7070707, v29
	s_nop 1
	v_and_b32_e32 v22, 0x7070707, v14
	v_lshrrev_b32_e32 v23, 4, v14
	v_and_b32_e32 v23, 0x7070707, v23
	v_perm_b32 v24, v34, v33, v22
	v_lshlrev_b32_e32 v25, 4, v14
	v_perm_b32 v22, v32, v31, v22
	v_and_or_b32 v24, v24, v25, v22
	v_perm_b32 v22, v34, v33, v23
	v_perm_b32 v23, v32, v31, v23
	v_and_or_b32 v14, v22, v14, v23
	v_perm_b32 v22, v14, v24, s0
	v_perm_b32 v23, v14, v24, s1
	v_and_b32_e32 v14, 0x7070707, v15
	v_lshlrev_b32_e32 v24, 4, v15
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[58:59], v[22:23], v[18:21]
	v_lshrrev_b32_e32 v22, 4, v15
	v_and_b32_e32 v22, 0x7070707, v22
	v_perm_b32 v23, v34, v33, v14
	v_perm_b32 v14, v32, v31, v14
	v_and_or_b32 v23, v23, v24, v14
	v_perm_b32 v14, v34, v33, v22
	v_perm_b32 v22, v32, v31, v22
	v_and_or_b32 v15, v14, v15, v22
	v_perm_b32 v14, v15, v23, s0
	v_perm_b32 v15, v15, v23, s1
	v_lshlrev_b32_e32 v23, 4, v16
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[54:55], v[14:15], v[18:21]
	v_and_b32_e32 v14, 0x7070707, v16
	v_lshrrev_b32_e32 v15, 4, v16
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v22, v34, v33, v14
	v_perm_b32 v14, v32, v31, v14
	v_and_or_b32 v22, v22, v23, v14
	v_perm_b32 v14, v34, v33, v15
	v_perm_b32 v15, v32, v31, v15
	v_and_or_b32 v15, v14, v16, v15
	v_perm_b32 v14, v15, v22, s0
	v_perm_b32 v15, v15, v22, s1
	v_lshlrev_b32_e32 v22, 4, v17
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[60:61], v[14:15], v[18:21]
	v_and_b32_e32 v14, 0x7070707, v17
	v_lshrrev_b32_e32 v15, 4, v17
	v_and_b32_e32 v15, 0x7070707, v15
	v_perm_b32 v16, v34, v33, v14
	v_perm_b32 v14, v32, v31, v14
	v_and_or_b32 v16, v16, v22, v14
	v_perm_b32 v14, v34, v33, v15
	v_perm_b32 v15, v32, v31, v15
	v_and_or_b32 v15, v14, v17, v15
	v_perm_b32 v14, v15, v16, s0
	v_perm_b32 v15, v15, v16, s1
	v_lshlrev_b32_e32 v31, 4, v11
	s_waitcnt lgkmcnt(0)
	v_mfma_f32_16x16x32_fp8_fp8 v[14:17], v[64:65], v[14:15], v[18:21]
	s_nop 2
	v_min_i32_e32 v18, 11, v1
	v_mul_lo_u32 v18, v18, s2
	v_sub_u32_e32 v19, 0x6c686080, v18
	v_and_b32_e32 v19, 0xffffff00, v19
	v_sub_u32_e32 v18, 0x7c787470, v18
	v_cndmask_b32_e64 v1, v19, 0, vcc
	v_cndmask_b32_e64 v22, v18, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v1
	v_and_b32_e32 v23, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v22
	v_and_b32_e32 v24, 0x80808080, v18
	v_sub_u32_e32 v18, v0, v26
	v_min_i32_e32 v19, 11, v18
	v_mul_lo_u32 v19, v19, s2
	v_sub_u32_e32 v20, 0x6c686080, v19
	v_and_b32_e32 v20, 0xffffff00, v20
	v_cmp_lt_i32_e32 vcc, 11, v18
	v_sub_u32_e32 v19, 0x7c787470, v19
	v_lshlrev_b32_e32 v21, 4, v10
	v_cndmask_b32_e64 v25, v20, 0, vcc
	v_cndmask_b32_e64 v26, v19, 0, vcc
	v_add_u32_e32 v18, 0x7f7f7f00, v25
	v_and_b32_e32 v27, 0x80808000, v18
	v_add_u32_e32 v18, 0x7f7f7f78, v26
	v_and_b32_e32 v28, 0x80808080, v18
	v_and_b32_e32 v18, 0x7070707, v10
	v_lshrrev_b32_e32 v19, 4, v10
	v_and_b32_e32 v19, 0x7070707, v19
	v_perm_b32 v20, v24, v23, v18
	v_perm_b32 v18, v22, v1, v18
	v_and_or_b32 v20, v20, v21, v18
	v_perm_b32 v18, v24, v23, v19
	v_perm_b32 v19, v22, v1, v19
	v_and_or_b32 v10, v18, v10, v19
	v_perm_b32 v18, v10, v20, s0
	v_perm_b32 v19, v10, v20, s1
	v_and_b32_e32 v10, 0x7070707, v11
	v_perm_b32 v30, v24, v23, v10
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[56:57], v[18:19], 0
	v_perm_b32 v10, v22, v1, v10
	v_and_or_b32 v30, v30, v31, v10
	v_perm_b32 v10, v24, v23, v29
	v_perm_b32 v29, v22, v1, v29
	v_and_or_b32 v11, v10, v11, v29
	v_perm_b32 v10, v11, v30, s0
	v_perm_b32 v11, v11, v30, s1
	v_lshlrev_b32_e32 v30, 4, v12
	v_cmp_lt_i32_e32 vcc, 5, v52
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[62:63], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v12
	v_lshrrev_b32_e32 v11, 4, v12
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v29, v24, v23, v10
	v_perm_b32 v10, v22, v1, v10
	v_and_or_b32 v29, v29, v30, v10
	v_perm_b32 v10, v24, v23, v11
	v_perm_b32 v11, v22, v1, v11
	v_and_or_b32 v11, v10, v12, v11
	v_perm_b32 v10, v11, v29, s0
	v_perm_b32 v11, v11, v29, s1
	v_lshlrev_b32_e32 v29, 4, v13
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[18:21], v[42:43], v[10:11], v[18:21]
	v_and_b32_e32 v10, 0x7070707, v13
	v_lshrrev_b32_e32 v11, 4, v13
	v_and_b32_e32 v11, 0x7070707, v11
	v_perm_b32 v12, v24, v23, v10
	v_perm_b32 v10, v22, v1, v10
	v_and_or_b32 v12, v12, v29, v10
	v_perm_b32 v10, v24, v23, v11
	v_perm_b32 v1, v22, v1, v11
	v_and_or_b32 v1, v10, v13, v1
	v_perm_b32 v10, v1, v12, s0
	v_perm_b32 v11, v1, v12, s1
	v_and_b32_e32 v1, 0x7070707, v6
	s_nop 0
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[44:45], v[10:11], v[18:21]
	s_nop 2
	v_lshrrev_b32_e32 v18, 4, v6
	v_and_b32_e32 v18, 0x7070707, v18
	v_perm_b32 v19, v28, v27, v1
	v_lshlrev_b32_e32 v20, 4, v6
	v_perm_b32 v1, v26, v25, v1
	v_and_or_b32 v1, v19, v20, v1
	v_perm_b32 v19, v28, v27, v18
	v_perm_b32 v18, v26, v25, v18
	v_and_or_b32 v6, v19, v6, v18
	v_perm_b32 v18, v6, v1, s0
	v_perm_b32 v19, v6, v1, s1
	v_and_b32_e32 v1, 0x7070707, v7
	v_lshrrev_b32_e32 v6, 4, v7
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[58:59], v[18:19], v[10:13]
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v18, v28, v27, v1
	v_lshlrev_b32_e32 v19, 4, v7
	v_perm_b32 v1, v26, v25, v1
	v_and_or_b32 v1, v18, v19, v1
	v_perm_b32 v18, v28, v27, v6
	v_perm_b32 v6, v26, v25, v6
	v_and_or_b32 v7, v18, v7, v6
	v_perm_b32 v6, v7, v1, s0
	v_perm_b32 v7, v7, v1, s1
	v_and_b32_e32 v1, 0x7070707, v8
	v_lshlrev_b32_e32 v18, 4, v8
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[54:55], v[6:7], v[10:13]
	v_lshrrev_b32_e32 v6, 4, v8
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v28, v27, v1
	v_perm_b32 v1, v26, v25, v1
	v_and_or_b32 v1, v7, v18, v1
	v_perm_b32 v7, v28, v27, v6
	v_perm_b32 v6, v26, v25, v6
	v_and_or_b32 v7, v7, v8, v6
	v_perm_b32 v6, v7, v1, s0
	v_perm_b32 v7, v7, v1, s1
	v_and_b32_e32 v1, 0x7070707, v9
	v_lshlrev_b32_e32 v8, 4, v9
	v_mfma_f32_16x16x32_fp8_fp8 v[10:13], v[60:61], v[6:7], v[10:13]
	v_lshrrev_b32_e32 v6, 4, v9
	v_and_b32_e32 v6, 0x7070707, v6
	v_perm_b32 v7, v28, v27, v1
	v_perm_b32 v1, v26, v25, v1
	v_and_or_b32 v1, v7, v8, v1
	v_perm_b32 v7, v28, v27, v6
	v_perm_b32 v6, v26, v25, v6
	v_and_or_b32 v7, v7, v9, v6
	v_perm_b32 v6, v7, v1, s0
	v_perm_b32 v7, v7, v1, s1
	v_mov_b32_e32 v1, 0xfd800000
	s_movk_i32 s0, 0x7fff
	v_mfma_f32_16x16x32_fp8_fp8 v[6:9], v[64:65], v[6:7], v[10:13]
	s_nop 2
	v_add_u32_e32 v11, 17, v52
	v_lshl_add_u32 v10, v52, 23, v1
	v_lshlrev_b32_e64 v11, v11, 1
	v_cndmask_b32_e32 v10, v11, v10, vcc
	v_add_u32_e32 v11, 17, v0
	v_lshl_add_u32 v1, v0, 23, v1
	v_lshlrev_b32_e64 v11, v11, 1
	v_cmp_lt_i32_e32 vcc, 5, v0
	v_pk_mul_f32 v[12:13], v[2:3], v[10:11] op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v0, v11, v1, vcc
	v_pk_mul_f32 v[10:11], v[4:5], v[10:11] op_sel_hi:[1,0]
	v_pk_mul_f32 v[12:13], v[12:13], v[14:15]
	v_pk_mul_f32 v[10:11], v[10:11], v[16:17]
	v_pk_mul_f32 v[12:13], v[12:13], v[38:39]
	v_pk_mul_f32 v[10:11], v[10:11], v[40:41]
	s_nop 0
	v_bfe_u32 v1, v11, 16, 1
	v_add3_u32 v1, v1, v11, s0
	v_or_b32_e32 v14, 0x400000, v11
	v_cmp_u_f32_e32 vcc, v11, v11
	v_bfe_u32 v11, v10, 16, 1
	v_add3_u32 v11, v11, v10, s0
	v_cndmask_b32_e32 v1, v1, v14, vcc
	v_or_b32_e32 v14, 0x400000, v10
	v_cmp_u_f32_e32 vcc, v10, v10
	v_pk_mul_f32 v[2:3], v[2:3], v[0:1] op_sel_hi:[1,0]
	s_nop 0
	v_cndmask_b32_e32 v10, v11, v14, vcc
	v_bfe_u32 v11, v13, 16, 1
	v_add3_u32 v11, v11, v13, s0
	v_or_b32_e32 v14, 0x400000, v13
	v_cmp_u_f32_e32 vcc, v13, v13
	v_bfe_u32 v13, v12, 16, 1
	v_add3_u32 v13, v13, v12, s0
	v_cndmask_b32_e32 v11, v11, v14, vcc
	v_or_b32_e32 v14, 0x400000, v12
	v_cmp_u_f32_e32 vcc, v12, v12
	v_pk_mul_f32 v[2:3], v[2:3], v[6:7]
	s_nop 0
	v_cndmask_b32_e32 v12, v13, v14, vcc
	ds_write_b16_d16_hi v46, v12
	ds_write_b16_d16_hi v47, v11 offset:512
	ds_write_b16_d16_hi v47, v10 offset:1024
	ds_write_b16_d16_hi v47, v1 offset:1536
	v_pk_mul_f32 v[0:1], v[4:5], v[0:1] op_sel_hi:[1,0]
	v_pk_mul_f32 v[2:3], v[2:3], v[38:39]
	v_pk_mul_f32 v[0:1], v[0:1], v[8:9]
	s_nop 0
	v_pk_mul_f32 v[0:1], v[0:1], v[40:41]
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
	ds_write_b16_d16_hi v47, v2 offset:32
	ds_write_b16_d16_hi v47, v3 offset:544
	ds_write_b16_d16_hi v47, v0 offset:1056
	ds_write_b16_d16_hi v47, v1 offset:1568
	s_waitcnt lgkmcnt(0)
	s_barrier
	buffer_load_dword v0, v51, s[20:23], 0 offen
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v1, 0xffffff, v0
	v_cmp_gt_i32_e32 vcc, s33, v1
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_9
	v_lshlrev_b32_e32 v1, 1, v50
	ds_read_b32 v2, v49 offset:8192
	v_lshl_or_b32 v0, v0, 13, v1
	v_ashrrev_i32_e32 v1, 31, v0
	v_lshl_add_u64 v[0:1], s[12:13], 0, v[0:1]
	v_add_co_u32_e32 v0, vcc, 0x1000, v0
	s_nop 1
	v_addc_co_u32_e32 v1, vcc, 0, v1, vcc
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3584
	ds_read_b32 v2, v49 offset:8320
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3712
	ds_read_b32 v2, v49 offset:8448
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3840
	ds_read_b32 v2, v49 offset:8576
	s_waitcnt lgkmcnt(0)
	global_atomic_pk_add_bf16 v[0:1], v2, off offset:3968
.LBB0_9:
	s_or_b64 exec, exec, s[0:1]
	s_barrier
.LBB0_10:
	s_endpgm
.Lfunc_end0:
	.size	a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz, .Lfunc_end0-a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz
		.amdhsa_group_segment_fixed_size 16384
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
		.amdhsa_next_free_vgpr 150
		.amdhsa_next_free_sgpr 52
		.amdhsa_accum_offset 152
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

	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.num_vgpr, 150
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.num_agpr, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.numbered_sgpr, 52
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.num_named_barrier, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.private_seg_size, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.uses_vcc, 1
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.uses_flat_scratch, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.has_dyn_sized_stack, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.has_recursion, 0
	.set .La8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.has_indirect_call, 0
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
    .group_segment_fixed_size: 16384
    .kernarg_segment_align: 8
    .kernarg_segment_size: 108
    .max_flat_workgroup_size: 512
    .name:           a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 512
      - 1
      - 1
    .sgpr_count:     58
    .sgpr_spill_count: 0
    .symbol:         a8w4_fmoe_h4096_i256_ne256_bm16_nw8_tk256_tn256_bcm12_xcd1_ftz.kd
    .uniform_work_group_size: 1
    .uses_dynamic_stack: false
    .vgpr_count:     150
    .vgpr_spill_count: 0
    .wavefront_size: 64
amdhsa.target:   amdgcn-amd-amdhsa-unknown-gfx942
amdhsa.version:
  - 1
  - 2
...

	.end_amdgpu_metadata
