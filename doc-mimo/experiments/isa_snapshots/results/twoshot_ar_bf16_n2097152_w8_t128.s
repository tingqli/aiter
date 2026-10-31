	.amdgcn_target "amdgcn-amd-amdhsa-unknown-gfx942"
	.amdhsa_code_object_version 6
	.text
	.globl	twoshot_ar_bf16_n2097152_w8_t128
	.p2align	8
	.type	twoshot_ar_bf16_n2097152_w8_t128,@function
twoshot_ar_bf16_n2097152_w8_t128:
	s_load_dwordx2 s[34:35], s[0:1], 0x10
	s_load_dwordx4 s[4:7], s[0:1], 0x0
	v_lshlrev_b32_e32 v1, 4, v0
	v_lshl_or_b32 v4, s2, 11, v1
	s_mov_b32 s11, 0x27000
	s_waitcnt lgkmcnt(0)
	s_ashr_i32 s1, s34, 31
	s_lshr_b32 s0, s1, 29
	s_add_i32 s0, s34, s0
	s_and_b32 s0, s0, -8
	s_sub_i32 s12, s34, s0
	s_add_i32 s0, s34, 1
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_sub_i32 s14, s0, s3
	s_add_i32 s0, s34, 2
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_sub_i32 s16, s0, s3
	s_add_i32 s0, s34, 3
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_sub_i32 s18, s0, s3
	s_add_i32 s0, s34, 4
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_sub_i32 s20, s0, s3
	s_add_i32 s0, s34, 5
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_sub_i32 s24, s0, s3
	s_add_i32 s0, s34, 6
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_sub_i32 s26, s0, s3
	s_add_i32 s0, s34, 7
	s_ashr_i32 s3, s0, 31
	s_lshr_b32 s3, s3, 29
	s_add_i32 s3, s0, s3
	s_and_b32 s3, s3, -8
	s_ashr_i32 s13, s12, 31
	s_sub_i32 s28, s0, s3
	s_lshl_b64 s[8:9], s[12:13], 3
	s_add_u32 s22, s6, s8
	s_addc_u32 s23, s7, s9
	s_ashr_i32 s15, s14, 31
	s_lshl_b64 s[8:9], s[14:15], 3
	s_add_u32 s30, s6, s8
	s_addc_u32 s31, s7, s9
	s_ashr_i32 s17, s16, 31
	s_lshl_b64 s[8:9], s[16:17], 3
	s_add_u32 s36, s6, s8
	s_addc_u32 s37, s7, s9
	s_ashr_i32 s19, s18, 31
	s_lshl_b64 s[8:9], s[18:19], 3
	s_add_u32 s38, s6, s8
	s_addc_u32 s39, s7, s9
	s_ashr_i32 s21, s20, 31
	s_lshl_b64 s[8:9], s[20:21], 3
	s_add_u32 s40, s6, s8
	s_addc_u32 s41, s7, s9
	s_ashr_i32 s25, s24, 31
	s_lshl_b64 s[8:9], s[24:25], 3
	s_add_u32 s42, s6, s8
	s_addc_u32 s43, s7, s9
	s_ashr_i32 s27, s26, 31
	s_lshl_b64 s[8:9], s[26:27], 3
	s_add_u32 s44, s6, s8
	s_addc_u32 s45, s7, s9
	s_ashr_i32 s29, s28, 31
	s_lshl_b64 s[8:9], s[28:29], 3
	s_add_u32 s46, s6, s8
	s_addc_u32 s47, s7, s9
	s_and_b32 s9, s5, 0xffff
	s_mov_b32 s10, -1
	s_mov_b32 s8, s4
	v_lshl_add_u32 v1, s12, 19, v4
	buffer_load_dwordx4 v[6:9], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s14, 19, v4
	buffer_load_dwordx4 v[10:13], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s16, 19, v4
	buffer_load_dwordx4 v[14:17], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s18, 19, v4
	buffer_load_dwordx4 v[18:21], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s20, 19, v4
	buffer_load_dwordx4 v[22:25], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s24, 19, v4
	buffer_load_dwordx4 v[26:29], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s26, 19, v4
	buffer_load_dwordx4 v[30:33], v1, s[8:11], 0 offen
	v_lshl_add_u32 v1, s28, 19, v4
	buffer_load_dwordx4 v[34:37], v1, s[8:11], 0 offen
	s_lshl_b32 s0, s34, 10
	s_lshl_b32 s3, s2, 2
	s_add_i32 s2, s0, s3
	s_mov_b32 s0, s34
	s_lshl_b64 s[0:1], s[0:1], 19
	s_load_dwordx2 s[4:5], s[22:23], 0x0
	s_load_dwordx2 s[8:9], s[30:31], 0x0
	s_load_dwordx2 s[20:21], s[36:37], 0x0
	s_load_dwordx2 s[24:25], s[38:39], 0x0
	s_load_dwordx2 s[28:29], s[40:41], 0x0
	s_load_dwordx2 s[48:49], s[42:43], 0x0
	s_load_dwordx2 s[50:51], s[44:45], 0x0
	s_load_dwordx2 s[52:53], s[46:47], 0x0
	s_waitcnt lgkmcnt(0)
	s_add_u32 s12, s4, s0
	s_addc_u32 s33, s5, s1
	s_and_b32 s13, s33, 0xffff
	s_mov_b32 s14, s10
	s_mov_b32 s15, s11
	s_add_u32 s16, s8, s0
	s_mov_b32 s18, s10
	s_mov_b32 s19, s11
	s_mov_b32 s22, s10
	s_mov_b32 s23, s11
	v_add_u32_e32 v5, s34, v0
	s_mov_b32 s26, s10
	s_mov_b32 s27, s11
	s_mov_b32 s30, s10
	s_mov_b32 s31, s11
	s_mov_b32 s38, s10
	s_mov_b32 s39, s11
	s_mov_b32 s42, s10
	s_mov_b32 s43, s11
	s_mov_b32 s46, s10
	s_mov_b32 s47, s11
	v_cmp_gt_u32_e32 vcc, 8, v0
	v_lshl_add_u32 v0, v0, 10, s3
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[6:9], v4, s[12:15], 0 offen sc1
	s_addc_u32 s13, s9, s1
	s_and_b32 s17, s13, 0xffff
	s_add_u32 s20, s20, s0
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[10:13], v4, s[16:19], 0 offen sc1
	s_addc_u32 s17, s21, s1
	s_and_b32 s21, s17, 0xffff
	s_add_u32 s24, s24, s0
	s_addc_u32 s18, s25, s1
	s_and_b32 s25, s18, 0xffff
	s_add_u32 s28, s28, s0
	s_addc_u32 s19, s29, s1
	s_and_b32 s29, s19, 0xffff
	s_add_u32 s36, s48, s0
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[14:17], v4, s[20:23], 0 offen sc1
	s_addc_u32 s21, s49, s1
	s_and_b32 s37, s21, 0xffff
	s_add_u32 s40, s50, s0
	s_addc_u32 s22, s51, s1
	s_and_b32 s41, s22, 0xffff
	s_add_u32 s44, s52, s0
	s_addc_u32 s23, s53, s1
	s_and_b32 s45, s23, 0xffff
	v_ashrrev_i32_e32 v6, 31, v5
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[18:21], v4, s[24:27], 0 offen sc1
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[22:25], v4, s[28:31], 0 offen sc1
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[26:29], v4, s[36:39], 0 offen sc1
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[30:33], v4, s[40:43], 0 offen sc1
	s_waitcnt vmcnt(7)
	buffer_store_dwordx4 v[34:37], v4, s[44:47], 0 offen sc1
	buffer_wbl2 sc0 sc1
	s_waitcnt vmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[8:9], vcc
	s_cbranch_execz .LBB0_4
	v_lshrrev_b32_e32 v1, 29, v6
	v_add_u32_e32 v1, v5, v1
	v_and_b32_e32 v1, -8, v1
	v_sub_u32_e32 v2, v5, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 3, s[6:7]
	global_load_dwordx2 v[2:3], v[2:3], off
	s_mov_b64 s[0:1], 0x800000
	s_ashr_i32 s3, s2, 31
	s_add_u32 s14, s4, 0x800000
	v_mov_b32_e32 v7, s35
	v_ashrrev_i32_e32 v1, 31, v0
	s_addc_u32 s15, s5, 0
	s_waitcnt vmcnt(0)
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[0:1]
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[2:3]
	buffer_wbl2 sc0 sc1
	s_waitcnt vmcnt(0)
	global_atomic_swap v[2:3], v7, off sc1
	v_lshl_add_u64 v[2:3], s[14:15], 0, v[0:1]
	global_load_dword v1, v[2:3], off sc0 sc1
	s_waitcnt vmcnt(0)
	buffer_inv sc0 sc1
	v_cmp_gt_i32_e64 s[0:1], s35, v1
	s_and_b64 exec, exec, s[0:1]
	s_cbranch_execz .LBB0_4
	s_mov_b64 s[14:15], 0
.LBB0_3:
	s_sleep 1
	global_load_dword v1, v[2:3], off sc0 sc1
	s_waitcnt vmcnt(0)
	buffer_inv sc0 sc1
	v_cmp_le_i32_e64 s[0:1], s35, v1
	s_or_b64 s[14:15], s[0:1], s[14:15]
	s_andn2_b64 exec, exec, s[14:15]
	s_cbranch_execnz .LBB0_3
.LBB0_4:
	s_or_b64 exec, exec, s[8:9]
	s_and_b32 s9, s5, 0xffff
	s_mov_b32 s8, s4
	v_add_u32_e32 v1, 0x80000, v4
	s_barrier
	buffer_load_dwordx4 v[8:11], v4, s[8:11], 0 offen sc0 sc1
	buffer_load_dwordx4 v[12:15], v1, s[8:11], 0 offen sc0 sc1
	v_add_u32_e32 v1, 0x100000, v4
	buffer_load_dwordx4 v[16:19], v1, s[8:11], 0 offen sc0 sc1
	v_add_u32_e32 v1, 0x180000, v4
	buffer_load_dwordx4 v[20:23], v1, s[8:11], 0 offen sc0 sc1
	v_add_u32_e32 v1, 0x200000, v4
	buffer_load_dwordx4 v[24:27], v1, s[8:11], 0 offen sc0 sc1
	v_add_u32_e32 v1, 0x280000, v4
	buffer_load_dwordx4 v[28:31], v1, s[8:11], 0 offen sc0 sc1
	v_add_u32_e32 v1, 0x300000, v4
	buffer_load_dwordx4 v[32:35], v1, s[8:11], 0 offen sc0 sc1
	v_add_u32_e32 v1, 0x380000, v4
	buffer_load_dwordx4 v[36:39], v1, s[8:11], 0 offen sc0 sc1
	s_movk_i32 s3, 0x7fff
	s_mov_b32 s8, 0x7060302
	s_waitcnt vmcnt(7)
	v_and_b32_e32 v51, 0xffff0000, v9
	v_lshlrev_b32_e32 v50, 16, v9
	v_and_b32_e32 v3, 0xffff0000, v8
	v_lshlrev_b32_e32 v2, 16, v8
	s_waitcnt vmcnt(6)
	v_and_b32_e32 v41, 0xffff0000, v12
	v_lshlrev_b32_e32 v40, 16, v12
	s_waitcnt vmcnt(5)
	v_and_b32_e32 v43, 0xffff0000, v16
	v_lshlrev_b32_e32 v42, 16, v16
	s_waitcnt vmcnt(4)
	v_and_b32_e32 v45, 0xffff0000, v20
	v_lshlrev_b32_e32 v44, 16, v20
	s_waitcnt vmcnt(3)
	v_and_b32_e32 v47, 0xffff0000, v24
	v_lshlrev_b32_e32 v46, 16, v24
	s_waitcnt vmcnt(2)
	v_and_b32_e32 v49, 0xffff0000, v28
	v_lshlrev_b32_e32 v48, 16, v28
	v_and_b32_e32 v9, 0xffff0000, v13
	v_lshlrev_b32_e32 v8, 16, v13
	v_and_b32_e32 v13, 0xffff0000, v17
	v_lshlrev_b32_e32 v12, 16, v17
	v_and_b32_e32 v17, 0xffff0000, v21
	v_lshlrev_b32_e32 v16, 16, v21
	v_and_b32_e32 v21, 0xffff0000, v25
	v_lshlrev_b32_e32 v20, 16, v25
	v_and_b32_e32 v25, 0xffff0000, v29
	v_lshlrev_b32_e32 v24, 16, v29
	v_and_b32_e32 v29, 0xffff0000, v10
	v_lshlrev_b32_e32 v28, 16, v10
	v_and_b32_e32 v53, 0xffff0000, v14
	v_lshlrev_b32_e32 v52, 16, v14
	v_and_b32_e32 v55, 0xffff0000, v11
	v_lshlrev_b32_e32 v54, 16, v11
	v_and_b32_e32 v11, 0xffff0000, v18
	v_lshlrev_b32_e32 v10, 16, v18
	v_and_b32_e32 v57, 0xffff0000, v15
	v_lshlrev_b32_e32 v56, 16, v15
	v_and_b32_e32 v15, 0xffff0000, v22
	v_lshlrev_b32_e32 v14, 16, v22
	v_and_b32_e32 v59, 0xffff0000, v19
	v_lshlrev_b32_e32 v58, 16, v19
	v_and_b32_e32 v19, 0xffff0000, v26
	v_lshlrev_b32_e32 v18, 16, v26
	v_and_b32_e32 v61, 0xffff0000, v23
	v_lshlrev_b32_e32 v60, 16, v23
	v_and_b32_e32 v23, 0xffff0000, v30
	v_lshlrev_b32_e32 v22, 16, v30
	v_and_b32_e32 v63, 0xffff0000, v27
	v_lshlrev_b32_e32 v62, 16, v27
	v_and_b32_e32 v27, 0xffff0000, v31
	v_lshlrev_b32_e32 v26, 16, v31
	s_waitcnt vmcnt(1)
	v_and_b32_e32 v31, 0xffff0000, v32
	v_lshlrev_b32_e32 v30, 16, v32
	v_and_b32_e32 v65, 0xffff0000, v33
	v_lshlrev_b32_e32 v64, 16, v33
	v_and_b32_e32 v33, 0xffff0000, v34
	v_lshlrev_b32_e32 v32, 16, v34
	v_and_b32_e32 v67, 0xffff0000, v35
	v_lshlrev_b32_e32 v66, 16, v35
	s_waitcnt vmcnt(0)
	v_and_b32_e32 v35, 0xffff0000, v36
	v_lshlrev_b32_e32 v34, 16, v36
	v_and_b32_e32 v69, 0xffff0000, v37
	v_lshlrev_b32_e32 v68, 16, v37
	v_and_b32_e32 v37, 0xffff0000, v38
	v_lshlrev_b32_e32 v36, 16, v38
	v_and_b32_e32 v71, 0xffff0000, v39
	v_lshlrev_b32_e32 v70, 16, v39
	v_pk_add_f32 v[38:39], v[50:51], 0 op_sel_hi:[1,0]
	v_pk_add_f32 v[28:29], v[28:29], 0 op_sel_hi:[1,0]
	v_pk_add_f32 v[8:9], v[38:39], v[8:9]
	v_pk_add_f32 v[38:39], v[54:55], 0 op_sel_hi:[1,0]
	v_pk_add_f32 v[28:29], v[28:29], v[52:53]
	v_pk_add_f32 v[38:39], v[38:39], v[56:57]
	v_pk_add_f32 v[10:11], v[28:29], v[10:11]
	v_pk_add_f32 v[38:39], v[38:39], v[58:59]
	v_pk_add_f32 v[8:9], v[8:9], v[12:13]
	v_pk_add_f32 v[10:11], v[10:11], v[14:15]
	v_pk_add_f32 v[12:13], v[38:39], v[60:61]
	v_pk_add_f32 v[10:11], v[10:11], v[18:19]
	v_pk_add_f32 v[12:13], v[12:13], v[62:63]
	v_pk_add_f32 v[10:11], v[10:11], v[22:23]
	v_pk_add_f32 v[12:13], v[12:13], v[26:27]
	v_pk_add_f32 v[10:11], v[10:11], v[32:33]
	v_pk_add_f32 v[12:13], v[12:13], v[66:67]
	v_pk_add_f32 v[14:15], v[10:11], v[36:37]
	v_pk_add_f32 v[10:11], v[12:13], v[70:71]
	v_pk_add_f32 v[8:9], v[8:9], v[16:17]
	v_bfe_u32 v1, v10, 16, 1
	v_add3_u32 v1, v1, v10, s3
	v_or_b32_e32 v7, 0x400000, v10
	v_cmp_u_f32_e64 s[0:1], v10, v10
	v_or_b32_e32 v10, 0x400000, v11
	v_pk_add_f32 v[8:9], v[8:9], v[20:21]
	v_cndmask_b32_e64 v1, v1, v7, s[0:1]
	v_bfe_u32 v7, v11, 16, 1
	v_add3_u32 v7, v7, v11, s3
	v_cmp_u_f32_e64 s[0:1], v11, v11
	v_pk_add_f32 v[2:3], v[2:3], 0 op_sel_hi:[1,0]
	v_pk_add_f32 v[8:9], v[8:9], v[24:25]
	v_cndmask_b32_e64 v7, v7, v10, s[0:1]
	v_perm_b32 v11, v7, v1, s8
	v_bfe_u32 v1, v14, 16, 1
	v_add3_u32 v1, v1, v14, s3
	v_or_b32_e32 v7, 0x400000, v14
	v_cmp_u_f32_e64 s[0:1], v14, v14
	v_pk_add_f32 v[2:3], v[2:3], v[40:41]
	v_pk_add_f32 v[8:9], v[8:9], v[64:65]
	v_cndmask_b32_e64 v1, v1, v7, s[0:1]
	v_bfe_u32 v7, v15, 16, 1
	v_add3_u32 v7, v7, v15, s3
	v_or_b32_e32 v10, 0x400000, v15
	v_cmp_u_f32_e64 s[0:1], v15, v15
	v_pk_add_f32 v[2:3], v[2:3], v[42:43]
	v_pk_add_f32 v[8:9], v[8:9], v[68:69]
	v_cndmask_b32_e64 v7, v7, v10, s[0:1]
	v_pk_add_f32 v[2:3], v[2:3], v[44:45]
	v_perm_b32 v10, v7, v1, s8
	v_bfe_u32 v1, v8, 16, 1
	v_pk_add_f32 v[2:3], v[2:3], v[46:47]
	v_add3_u32 v1, v1, v8, s3
	v_or_b32_e32 v7, 0x400000, v8
	v_cmp_u_f32_e64 s[0:1], v8, v8
	v_pk_add_f32 v[2:3], v[2:3], v[48:49]
	v_or_b32_e32 v8, 0x400000, v9
	v_cndmask_b32_e64 v1, v1, v7, s[0:1]
	v_bfe_u32 v7, v9, 16, 1
	v_pk_add_f32 v[2:3], v[2:3], v[30:31]
	v_add3_u32 v7, v7, v9, s3
	v_cmp_u_f32_e64 s[0:1], v9, v9
	v_pk_add_f32 v[2:3], v[2:3], v[34:35]
	s_nop 0
	v_cndmask_b32_e64 v7, v7, v8, s[0:1]
	v_perm_b32 v9, v7, v1, s8
	v_bfe_u32 v1, v2, 16, 1
	v_add3_u32 v1, v1, v2, s3
	v_or_b32_e32 v7, 0x400000, v2
	v_cmp_u_f32_e64 s[0:1], v2, v2
	v_bfe_u32 v2, v3, 16, 1
	v_add3_u32 v2, v2, v3, s3
	v_cndmask_b32_e64 v1, v1, v7, s[0:1]
	v_or_b32_e32 v7, 0x400000, v3
	v_cmp_u_f32_e64 s[0:1], v3, v3
	s_nop 1
	v_cndmask_b32_e64 v2, v2, v7, s[0:1]
	v_perm_b32 v8, v2, v1, s8
	s_add_u32 s8, s12, 0x400000
	s_addc_u32 s0, s33, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s16, 0x400000
	s_addc_u32 s0, s13, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s20, 0x400000
	s_addc_u32 s0, s17, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s24, 0x400000
	s_addc_u32 s0, s18, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s28, 0x400000
	s_addc_u32 s0, s19, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s36, 0x400000
	s_addc_u32 s0, s21, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s40, 0x400000
	s_addc_u32 s0, s22, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	s_add_u32 s8, s44, 0x400000
	s_addc_u32 s0, s23, 0
	s_and_b32 s9, s0, 0xffff
	buffer_store_dwordx4 v[8:11], v4, s[8:11], 0 offen sc1
	buffer_wbl2 sc0 sc1
	s_waitcnt vmcnt(0)
	s_barrier
	s_and_saveexec_b64 s[0:1], vcc
	s_cbranch_execz .LBB0_8
	v_lshrrev_b32_e32 v1, 29, v6
	v_add_u32_e32 v1, v5, v1
	v_and_b32_e32 v1, -8, v1
	v_sub_u32_e32 v2, v5, v1
	v_ashrrev_i32_e32 v3, 31, v2
	v_lshl_add_u64 v[2:3], v[2:3], 3, s[6:7]
	global_load_dwordx2 v[2:3], v[2:3], off
	s_mov_b64 s[0:1], 0x802000
	s_ashr_i32 s3, s2, 31
	s_add_u32 s4, s4, 0x802000
	v_mov_b32_e32 v4, s35
	v_ashrrev_i32_e32 v1, 31, v0
	s_addc_u32 s5, s5, 0
	v_lshl_add_u64 v[0:1], s[4:5], 0, v[0:1]
	s_waitcnt vmcnt(0)
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[0:1]
	v_lshl_add_u64 v[2:3], v[2:3], 0, s[2:3]
	buffer_wbl2 sc0 sc1
	s_waitcnt vmcnt(0)
	global_atomic_swap v[2:3], v4, off sc1
	global_load_dword v2, v[0:1], off sc0 sc1
	s_waitcnt vmcnt(0)
	buffer_inv sc0 sc1
	v_cmp_gt_i32_e32 vcc, s35, v2
	s_and_b64 exec, exec, vcc
	s_cbranch_execz .LBB0_8
	s_mov_b64 s[0:1], 0
.LBB0_7:
	s_sleep 1
	global_load_dword v2, v[0:1], off sc0 sc1
	s_waitcnt vmcnt(0)
	buffer_inv sc0 sc1
	v_cmp_le_i32_e32 vcc, s35, v2
	s_or_b64 s[0:1], vcc, s[0:1]
	s_andn2_b64 exec, exec, s[0:1]
	s_cbranch_execnz .LBB0_7
.LBB0_8:
	s_endpgm
.Lfunc_end0:
	.size	twoshot_ar_bf16_n2097152_w8_t128, .Lfunc_end0-twoshot_ar_bf16_n2097152_w8_t128
	.section	.rodata,"a",@progbits
	.p2align	6, 0x0
	.amdhsa_kernel twoshot_ar_bf16_n2097152_w8_t128
		.amdhsa_group_segment_fixed_size 0
		.amdhsa_private_segment_fixed_size 0
		.amdhsa_kernarg_size 24
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
		.amdhsa_next_free_sgpr 54
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

	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.num_vgpr, 72
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.num_agpr, 0
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.numbered_sgpr, 54
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.num_named_barrier, 0
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.private_seg_size, 0
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.uses_vcc, 1
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.uses_flat_scratch, 0
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.has_dyn_sized_stack, 0
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.has_recursion, 0
	.set .Ltwoshot_ar_bf16_n2097152_w8_t128.has_indirect_call, 0
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
        .size:           4
        .value_kind:     by_value
      - .offset:         20
        .size:           4
        .value_kind:     by_value
    .group_segment_fixed_size: 0
    .kernarg_segment_align: 8
    .kernarg_segment_size: 24
    .max_flat_workgroup_size: 128
    .name:           twoshot_ar_bf16_n2097152_w8_t128
    .private_segment_fixed_size: 0
    .reqd_workgroup_size:
      - 128
      - 1
      - 1
    .sgpr_count:     60
    .sgpr_spill_count: 0
    .symbol:         twoshot_ar_bf16_n2097152_w8_t128.kd
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
