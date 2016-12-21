.data
.align 3
.align 0
.globl ___stginit_F95ArgDeclParserTestRefs
___stginit_F95ArgDeclParserTestRefs:
.data
.align 3
.align 0
_r1l6_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1v9_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1l6_closure+1
	.quad	0
.data
.align 3
.align 0
_r1va_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1va_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vc_closure:
	.quad	_r1vc_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ey_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1vc_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vc_info)+0
	.quad	0
	.quad	4294967318
_r1vc_info:
Lc1Ez:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1EA
Lc1EB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ex
Lc1Ew:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Ey_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Ex:
	jmp *(%rbx)
Lc1EA:
	jmp *-16(%r13)
	.long  _r1vc_info - _r1vc_info_dsp
.data
.align 3
.align 0
_r1vd_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1vc_closure
	.quad	0
.data
.align 3
.align 0
_r1ve_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1vb_closure+2
	.quad	_r1vd_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vg_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vh_closure:
	.quad	_r1vh_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1EY_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1vh_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vh_info)+0
	.quad	0
	.quad	4294967318
_r1vh_info:
Lc1EZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1F0
Lc1F1:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1EX
Lc1EW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1EY_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1EX:
	jmp *(%rbx)
Lc1F0:
	jmp *-16(%r13)
	.long  _r1vh_info - _r1vh_info_dsp
.data
.align 3
.align 0
_r1vi_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1vh_closure
	.quad	0
.data
.align 3
.align 0
_r1vj_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1vg_closure+2
	.quad	_r1vi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vl_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vm_closure:
	.quad	_r1vm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Fn_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1vm_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vm_info)+0
	.quad	0
	.quad	4294967318
_r1vm_info:
Lc1Fo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Fp
Lc1Fq:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Fm
Lc1Fl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Fn_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Fm:
	jmp *(%rbx)
Lc1Fp:
	jmp *-16(%r13)
	.long  _r1vm_info - _r1vm_info_dsp
.data
.align 3
.align 0
_r1vn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1vm_closure
	.quad	0
.data
.align 3
.align 0
_r1vo_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1vl_closure+2
	.quad	_r1vn_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vo_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vj_closure+1
	.quad	_r1vp_closure+2
	.quad	0
.data
.align 3
.align 0
_r1vr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ve_closure+1
	.quad	_r1vq_closure+2
	.quad	0
.data
.align 3
.align 0
_r1vs_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1vt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vs_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1vu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vt_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1vv_closure:
	.quad	_r1vv_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1FU_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	48
	.byte	58
	.byte	53
	.byte	45
	.byte	51
	.byte	49
	.byte	54
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	104
	.byte	97
	.byte	115
	.byte	95
	.byte	99
	.byte	111
	.byte	110
	.byte	115
	.byte	116
	.byte	95
	.byte	114
	.byte	97
	.byte	110
	.byte	103
	.byte	101
	.byte	115
	.byte	0
.text
.align 3
_r1vv_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vv_info)+8
	.quad	0
	.quad	4294967318
_r1vv_info:
Lc1FV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1FW
Lc1FX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1FT
Lc1FS:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1FU_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1FT:
	jmp *(%rbx)
Lc1FW:
	jmp *-16(%r13)
	.long  _r1vv_info - _r1vv_info_dsp
.data
.align 3
.align 0
_r1vw_closure:
	.quad	_r1vw_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Gb_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	48
	.byte	58
	.byte	53
	.byte	45
	.byte	51
	.byte	49
	.byte	54
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	115
	.byte	104
	.byte	97
	.byte	112
	.byte	101
	.byte	0
.text
.align 3
_r1vw_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vw_info)+8
	.quad	0
	.quad	4294967318
_r1vw_info:
Lc1Gc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Gd
Lc1Ge:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ga
Lc1G9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Gb_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1Ga:
	jmp *(%rbx)
Lc1Gd:
	jmp *-16(%r13)
	.long  _r1vw_info - _r1vw_info_dsp
.data
.align 3
.align 0
_r1vx_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1v9_closure+1
	.quad	_r1vr_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1vu_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_r1vv_closure
	.quad	_r1vw_closure
	.quad	0
.data
.align 3
.align 0
_r1vy_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1vz_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1vy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vA_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1vD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1vE_closure:
	.quad	_r1vE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1GG_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1vE_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vE_info)+0
	.quad	0
	.quad	4294967318
_r1vE_info:
Lc1GH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1GI
Lc1GJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1GF
Lc1GE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1GG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1GF:
	jmp *(%rbx)
Lc1GI:
	jmp *-16(%r13)
	.long  _r1vE_info - _r1vE_info_dsp
.data
.align 3
.align 0
_r1vF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1vE_closure
	.quad	0
.data
.align 3
.align 0
_r1vG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vI_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1vD_closure+2
	.quad	_r1vF_closure+1
	.quad	_r1vH_closure+2
	.quad	0
.data
.align 3
.align 0
_r1vJ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1vI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1vB_closure+2
	.quad	_r1vJ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1vL_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vM_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vN_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1vO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1vP_closure:
	.quad	_r1vP_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Hh_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1vP_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1vP_info)+0
	.quad	0
	.quad	4294967318
_r1vP_info:
Lc1Hi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Hj
Lc1Hk:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Hg
Lc1Hf:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Hh_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Hg:
	jmp *(%rbx)
Lc1Hj:
	jmp *-16(%r13)
	.long  _r1vP_info - _r1vP_info_dsp
.data
.align 3
.align 0
_r1vQ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1vP_closure
	.quad	0
.data
.align 3
.align 0
_r1vR_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vS_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vR_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vT_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1vO_closure+2
	.quad	_r1vQ_closure+1
	.quad	_r1vS_closure+2
	.quad	0
.data
.align 3
.align 0
_r1vU_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1vT_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vV_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1vM_closure+2
	.quad	_r1vU_closure+3
	.quad	0
.data
.align 3
.align 0
_r1vW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1vX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1vW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1vY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1vZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1w0_closure:
	.quad	_r1w0_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1HS_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1w0_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1w0_info)+0
	.quad	0
	.quad	4294967318
_r1w0_info:
Lc1HT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1HU
Lc1HV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1HR
Lc1HQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1HS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1HR:
	jmp *(%rbx)
Lc1HU:
	jmp *-16(%r13)
	.long  _r1w0_info - _r1w0_info_dsp
.data
.align 3
.align 0
_r1w1_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1w0_closure
	.quad	0
.data
.align 3
.align 0
_r1w2_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1w3_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1w2_closure+1
	.quad	0
.data
.align 3
.align 0
_r1w4_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1vZ_closure+2
	.quad	_r1w1_closure+1
	.quad	_r1w3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1w5_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1w4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1w6_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1vX_closure+2
	.quad	_r1w5_closure+3
	.quad	0
.data
.align 3
.align 0
_r1w7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1w6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1w8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vV_closure+1
	.quad	_r1w7_closure+2
	.quad	0
.data
.align 3
.align 0
_r1w9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vK_closure+1
	.quad	_r1w8_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wa_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1wb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wa_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wb_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wd_closure:
	.quad	_r1wd_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ix_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	49
	.byte	58
	.byte	53
	.byte	45
	.byte	52
	.byte	56
	.byte	52
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	104
	.byte	97
	.byte	115
	.byte	95
	.byte	99
	.byte	111
	.byte	110
	.byte	115
	.byte	116
	.byte	95
	.byte	114
	.byte	97
	.byte	110
	.byte	103
	.byte	101
	.byte	115
	.byte	0
.text
.align 3
_r1wd_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1wd_info)+8
	.quad	0
	.quad	4294967318
_r1wd_info:
Lc1Iy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Iz
Lc1IA:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Iw
Lc1Iv:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Ix_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1Iw:
	jmp *(%rbx)
Lc1Iz:
	jmp *-16(%r13)
	.long  _r1wd_info - _r1wd_info_dsp
.data
.align 3
.align 0
_r1we_closure:
	.quad	_r1we_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1IO_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	49
	.byte	58
	.byte	53
	.byte	45
	.byte	52
	.byte	56
	.byte	52
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	115
	.byte	104
	.byte	97
	.byte	112
	.byte	101
	.byte	0
.text
.align 3
_r1we_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1we_info)+8
	.quad	0
	.quad	4294967318
_r1we_info:
Lc1IP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1IQ
Lc1IR:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1IN
Lc1IM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1IO_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1IN:
	jmp *(%rbx)
Lc1IQ:
	jmp *-16(%r13)
	.long  _r1we_info - _r1we_info_dsp
.data
.align 3
.align 0
_r1wf_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1vz_closure+1
	.quad	_r1w9_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1wc_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_r1wd_closure
	.quad	_r1we_closure
	.quad	0
.data
.align 3
.align 0
_r1wg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1wh_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1wg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wi_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1wj_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1wi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wk_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1wl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wk_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wm_closure:
	.quad	_r1wm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Jj_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1wm_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1wm_info)+0
	.quad	0
	.quad	4294967318
_r1wm_info:
Lc1Jk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Jl
Lc1Jm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ji
Lc1Jh:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Jj_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Ji:
	jmp *(%rbx)
Lc1Jl:
	jmp *-16(%r13)
	.long  _r1wm_info - _r1wm_info_dsp
.data
.align 3
.align 0
_r1wn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1wm_closure
	.quad	0
.data
.align 3
.align 0
_r1wo_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1wp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1wo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wq_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1wl_closure+2
	.quad	_r1wn_closure+1
	.quad	_r1wp_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wr_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1wq_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ws_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1wj_closure+2
	.quad	_r1wr_closure+3
	.quad	0
.data
.align 3
.align 0
_r1wt_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1wu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wt_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wv_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1ww_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1wv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wx_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1wu_closure+2
	.quad	_r1ww_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wy_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1wx_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1wA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wB_closure:
	.quad	_r1wB_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1K2_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1wB_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1wB_info)+0
	.quad	0
	.quad	4294967318
_r1wB_info:
Lc1K3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1K4
Lc1K5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1K1
Lc1K0:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1K2_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1K1:
	jmp *(%rbx)
Lc1K4:
	jmp *-16(%r13)
	.long  _r1wB_info - _r1wB_info_dsp
.data
.align 3
.align 0
_r1wC_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1wB_closure
	.quad	0
.data
.align 3
.align 0
_r1wD_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1wE_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1wD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wF_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1wA_closure+2
	.quad	_r1wC_closure+1
	.quad	_r1wE_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wG_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1wF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wH_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1wy_closure+4
	.quad	_r1wG_closure+3
	.quad	0
.data
.align 3
.align 0
_r1wI_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1wJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wI_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wK_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1wL_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1wK_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wM_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1wJ_closure+2
	.quad	_r1wL_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wN_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1wM_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wO_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1wP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1wQ_closure:
	.quad	_r1wQ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1KL_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1wQ_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1wQ_info)+0
	.quad	0
	.quad	4294967318
_r1wQ_info:
Lc1KM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1KN
Lc1KO:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1KK
Lc1KJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1KL_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1KK:
	jmp *(%rbx)
Lc1KN:
	jmp *-16(%r13)
	.long  _r1wQ_info - _r1wQ_info_dsp
.data
.align 3
.align 0
_r1wR_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1wQ_closure
	.quad	0
.data
.align 3
.align 0
_r1wS_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1wT_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1wS_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wU_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1wP_closure+2
	.quad	_r1wR_closure+1
	.quad	_r1wT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wV_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1wU_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wW_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1wN_closure+4
	.quad	_r1wV_closure+3
	.quad	0
.data
.align 3
.align 0
_r1wX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wW_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1wY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wH_closure+1
	.quad	_r1wX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1wZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ws_closure+1
	.quad	_r1wY_closure+2
	.quad	0
.data
.align 3
.align 0
_r1x0_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1x1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1x0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1x2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1x1_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1x3_closure:
	.quad	_r1x3_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Lq_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	51
	.byte	58
	.byte	53
	.byte	45
	.byte	53
	.byte	56
	.byte	48
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	104
	.byte	97
	.byte	115
	.byte	95
	.byte	99
	.byte	111
	.byte	110
	.byte	115
	.byte	116
	.byte	95
	.byte	114
	.byte	97
	.byte	110
	.byte	103
	.byte	101
	.byte	115
	.byte	0
.text
.align 3
_r1x3_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1x3_info)+8
	.quad	0
	.quad	4294967318
_r1x3_info:
Lc1Lr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ls
Lc1Lt:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Lp
Lc1Lo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Lq_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1Lp:
	jmp *(%rbx)
Lc1Ls:
	jmp *-16(%r13)
	.long  _r1x3_info - _r1x3_info_dsp
.data
.align 3
.align 0
_r1x4_closure:
	.quad	_r1x4_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1LH_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	51
	.byte	58
	.byte	53
	.byte	45
	.byte	53
	.byte	56
	.byte	48
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	115
	.byte	104
	.byte	97
	.byte	112
	.byte	101
	.byte	0
.text
.align 3
_r1x4_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1x4_info)+8
	.quad	0
	.quad	4294967318
_r1x4_info:
Lc1LI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1LJ
Lc1LK:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1LG
Lc1LF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1LH_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1LG:
	jmp *(%rbx)
Lc1LJ:
	jmp *-16(%r13)
	.long  _r1x4_info - _r1x4_info_dsp
.data
.align 3
.align 0
_r1x5_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1wh_closure+1
	.quad	_r1wZ_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1x2_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_r1x3_closure
	.quad	_r1x4_closure
	.quad	0
.data
.align 3
.align 0
_r1x6_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1x7_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1x6_closure+1
	.quad	0
.data
.align 3
.align 0
_r1x8_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1x9_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1x8_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xa_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1xb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xa_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1xc_closure:
	.quad	_r1xc_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Mc_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1xc_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xc_info)+0
	.quad	0
	.quad	4294967318
_r1xc_info:
Lc1Md:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Me
Lc1Mf:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Mb
Lc1Ma:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Mc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Mb:
	jmp *(%rbx)
Lc1Me:
	jmp *-16(%r13)
	.long  _r1xc_info - _r1xc_info_dsp
.data
.align 3
.align 0
_r1xd_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1xc_closure
	.quad	0
.data
.align 3
.align 0
_r1xe_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1xf_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1xe_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xg_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1xb_closure+2
	.quad	_r1xd_closure+1
	.quad	_r1xf_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xh_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1xg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xi_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1x9_closure+2
	.quad	_r1xh_closure+3
	.quad	0
.data
.align 3
.align 0
_r1xj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1xk_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1xj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xl_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1xm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xl_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1xn_closure:
	.quad	_r1xn_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1MN_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1xn_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xn_info)+0
	.quad	0
	.quad	4294967318
_r1xn_info:
Lc1MO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1MP
Lc1MQ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1MM
Lc1ML:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1MN_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1MM:
	jmp *(%rbx)
Lc1MP:
	jmp *-16(%r13)
	.long  _r1xn_info - _r1xn_info_dsp
.data
.align 3
.align 0
_r1xo_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1xn_closure
	.quad	0
.data
.align 3
.align 0
_r1xp_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1xq_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1xp_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xr_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1xm_closure+2
	.quad	_r1xo_closure+1
	.quad	_r1xq_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xs_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1xr_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xt_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1xk_closure+2
	.quad	_r1xs_closure+3
	.quad	0
.data
.align 3
.align 0
_r1xu_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1xv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1xu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xw_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1xx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xw_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1xy_closure:
	.quad	_r1xy_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1No_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1xy_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xy_info)+0
	.quad	0
	.quad	4294967318
_r1xy_info:
Lc1Np:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Nq
Lc1Nr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Nn
Lc1Nm:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1No_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Nn:
	jmp *(%rbx)
Lc1Nq:
	jmp *-16(%r13)
	.long  _r1xy_info - _r1xy_info_dsp
.data
.align 3
.align 0
_r1xz_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1xy_closure
	.quad	0
.data
.align 3
.align 0
_r1xA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1xB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1xA_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xC_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1xx_closure+2
	.quad	_r1xz_closure+1
	.quad	_r1xB_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xD_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1xC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xE_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1xv_closure+2
	.quad	_r1xD_closure+3
	.quad	0
.data
.align 3
.align 0
_r1xF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xt_closure+1
	.quad	_r1xF_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xi_closure+1
	.quad	_r1xG_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xI_closure:
	.quad	_r1xI_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1NX_str:
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_r1xI_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xI_info)+0
	.quad	0
	.quad	4294967318
_r1xI_info:
Lc1NY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1NZ
Lc1O0:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1NW
Lc1NV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1NX_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1NW:
	jmp *(%rbx)
Lc1NZ:
	jmp *-16(%r13)
	.long  _r1xI_info - _r1xI_info_dsp
.data
.align 3
.align 0
_r1xJ_closure:
	.quad	_r1xJ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Oe_str:
	.byte	116
	.byte	50
	.byte	0
.text
.align 3
_r1xJ_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xJ_info)+0
	.quad	0
	.quad	4294967318
_r1xJ_info:
Lc1Of:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Og
Lc1Oh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Od
Lc1Oc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Oe_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Od:
	jmp *(%rbx)
Lc1Og:
	jmp *-16(%r13)
	.long  _r1xJ_info - _r1xJ_info_dsp
.data
.align 3
.align 0
_r1xK_closure:
	.quad	_r1xK_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ov_str:
	.byte	116
	.byte	51
	.byte	0
.text
.align 3
_r1xK_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xK_info)+0
	.quad	0
	.quad	4294967318
_r1xK_info:
Lc1Ow:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ox
Lc1Oy:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ou
Lc1Ot:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Ov_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Ou:
	jmp *(%rbx)
Lc1Ox:
	jmp *-16(%r13)
	.long  _r1xK_info - _r1xK_info_dsp
.data
.align 3
.align 0
_r1xL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xK_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xJ_closure
	.quad	_r1xL_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xI_closure
	.quad	_r1xM_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xO_closure:
	.quad	_r1xO_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1OS_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	53
	.byte	58
	.byte	53
	.byte	45
	.byte	52
	.byte	57
	.byte	51
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	104
	.byte	97
	.byte	115
	.byte	95
	.byte	99
	.byte	111
	.byte	110
	.byte	115
	.byte	116
	.byte	95
	.byte	114
	.byte	97
	.byte	110
	.byte	103
	.byte	101
	.byte	115
	.byte	0
.text
.align 3
_r1xO_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xO_info)+8
	.quad	0
	.quad	4294967318
_r1xO_info:
Lc1OT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1OU
Lc1OV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1OR
Lc1OQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1OS_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1OR:
	jmp *(%rbx)
Lc1OU:
	jmp *-16(%r13)
	.long  _r1xO_info - _r1xO_info_dsp
.data
.align 3
.align 0
_r1xP_closure:
	.quad	_r1xP_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1P9_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	65
	.byte	114
	.byte	103
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	84
	.byte	101
	.byte	115
	.byte	116
	.byte	82
	.byte	101
	.byte	102
	.byte	115
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	49
	.byte	48
	.byte	53
	.byte	58
	.byte	53
	.byte	45
	.byte	52
	.byte	57
	.byte	51
	.byte	124
	.byte	70
	.byte	57
	.byte	53
	.byte	86
	.byte	97
	.byte	114
	.byte	68
	.byte	101
	.byte	99
	.byte	108
	.byte	46
	.byte	118
	.byte	100
	.byte	95
	.byte	115
	.byte	104
	.byte	97
	.byte	112
	.byte	101
	.byte	0
.text
.align 3
_r1xP_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1xP_info)+8
	.quad	0
	.quad	4294967318
_r1xP_info:
Lc1Pa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Pb
Lc1Pc:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1P8
Lc1P7:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1P9_str(%rip),%r14
	addq $-16,%rbp
	jmp _base_ControlziExceptionziBase_recConError_info
Lc1P8:
	jmp *(%rbx)
Lc1Pb:
	jmp *-16(%r13)
	.long  _r1xP_info - _r1xP_info_dsp
.data
.align 3
.align 0
_r1xQ_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1x7_closure+1
	.quad	_r1xH_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1xN_closure+2
	.quad	_F95VarDecl_Read_closure+1
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_r1xO_closure
	.quad	_r1xP_closure
	.quad	0
.data
.align 3
.align 0
_r1xR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xQ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1xS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1x5_closure+1
	.quad	_r1xR_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1wf_closure+1
	.quad	_r1xS_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure
_F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1vx_closure+1
	.quad	_r1xT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1xU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1xV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Write_closure+2
	.quad	_r1xU_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure
_F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Read_closure+1
	.quad	_r1xV_closure+2
	.quad	1
.data
.align 3
.align 0
_r1xW_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	112
.data
.align 3
.align 0
_r1xX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xW_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1xY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xX_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1xZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1y0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1y1_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1y2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y1_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1y3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1y4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1y5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y4_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1y6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y2_closure+2
	.quad	_r1y5_closure+2
	.quad	1
.data
.align 3
.align 0
_r1y7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y0_closure+2
	.quad	_r1y6_closure+2
	.quad	1
.data
.align 3
.align 0
_r1y8_closure:
	.quad	_r1y8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Q4_str:
	.byte	102
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1y8_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1y8_info)+0
	.quad	0
	.quad	4294967318
_r1y8_info:
Lc1Q5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Q6
Lc1Q7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Q3
Lc1Q2:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Q4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Q3:
	jmp *(%rbx)
Lc1Q6:
	jmp *-16(%r13)
	.long  _r1y8_info - _r1y8_info_dsp
.data
.align 3
.align 0
_r1y9_closure:
	.quad	_r1y9_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ql_str:
	.byte	103
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1y9_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1y9_info)+0
	.quad	0
	.quad	4294967318
_r1y9_info:
Lc1Qm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Qn
Lc1Qo:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Qk
Lc1Qj:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Ql_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Qk:
	jmp *(%rbx)
Lc1Qn:
	jmp *-16(%r13)
	.long  _r1y9_info - _r1y9_info_dsp
.data
.align 3
.align 0
_r1ya_closure:
	.quad	_r1ya_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1QC_str:
	.byte	104
	.byte	52
	.byte	50
	.byte	0
.text
.align 3
_r1ya_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1ya_info)+0
	.quad	0
	.quad	4294967318
_r1ya_info:
Lc1QD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1QE
Lc1QF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1QB
Lc1QA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1QC_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1QB:
	jmp *(%rbx)
Lc1QE:
	jmp *-16(%r13)
	.long  _r1ya_info - _r1ya_info_dsp
.data
.align 3
.align 0
_r1yb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ya_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y9_closure
	.quad	_r1yb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1yd_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y8_closure
	.quad	_r1yc_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ye_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yd_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1y7_closure+2
	.quad	_r1ye_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_arglistzuparserzutests_closure
_F95ArgDeclParserTestRefs_arglistzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1xY_closure+2
	.quad	_r1yf_closure+2
	.quad	0
.data
.align 3
.align 0
_r1yg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1yh_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1yg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yi_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1yj_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1yi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1yl_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1yk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ym_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1yn_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1ym_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yo_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1yp_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1yo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yp_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yn_closure+1
	.quad	_r1yq_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ys_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yl_closure+1
	.quad	_r1yr_closure+2
	.quad	0
.data
.align 3
.align 0
_r1yt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yj_closure+1
	.quad	_r1ys_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_typezuparserzutests_closure
_F95ArgDeclParserTestRefs_typezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yh_closure+1
	.quad	_r1yt_closure+2
	.quad	0
.data
.align 3
.align 0
_r1yu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1yv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Out_closure+2
	.quad	_r1yu_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_intentzuparserzutests_closure
_F95ArgDeclParserTestRefs_intentzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_In_closure+1
	.quad	_r1yv_closure+2
	.quad	1
.data
.align 3
.align 0
_r1yw_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1yx_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1yw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yy_closure:
	.quad	_r1yy_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1RJ_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1yy_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1yy_info)+0
	.quad	0
	.quad	4294967318
_r1yy_info:
Lc1RK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1RL
Lc1RM:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1RI
Lc1RH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1RJ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1RI:
	jmp *(%rbx)
Lc1RL:
	jmp *-16(%r13)
	.long  _r1yy_info - _r1yy_info_dsp
.data
.align 3
.align 0
_r1yz_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1yy_closure
	.quad	0
.data
.align 3
.align 0
_r1yA_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1yx_closure+2
	.quad	_r1yz_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yC_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1yD_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1yC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yE_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1yF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1yG_closure:
	.quad	_r1yG_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Se_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1yG_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1yG_info)+0
	.quad	0
	.quad	4294967318
_r1yG_info:
Lc1Sf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Sg
Lc1Sh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Sd
Lc1Sc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Se_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Sd:
	jmp *(%rbx)
Lc1Sg:
	jmp *-16(%r13)
	.long  _r1yG_info - _r1yG_info_dsp
.data
.align 3
.align 0
_r1yH_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1yG_closure
	.quad	0
.data
.align 3
.align 0
_r1yI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1yJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1yI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yK_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1yF_closure+2
	.quad	_r1yH_closure+1
	.quad	_r1yJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1yL_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1yK_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yM_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1yD_closure+2
	.quad	_r1yL_closure+3
	.quad	0
.data
.align 3
.align 0
_r1yN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yM_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yO_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1yP_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1yO_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yQ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1yR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yQ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1yS_closure:
	.quad	_r1yS_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1SR_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1yS_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1yS_info)+0
	.quad	0
	.quad	4294967318
_r1yS_info:
Lc1SS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1ST
Lc1SU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1SQ
Lc1SP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1SR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1SQ:
	jmp *(%rbx)
Lc1ST:
	jmp *-16(%r13)
	.long  _r1yS_info - _r1yS_info_dsp
.data
.align 3
.align 0
_r1yT_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1yS_closure
	.quad	0
.data
.align 3
.align 0
_r1yU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1yV_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1yU_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yW_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1yR_closure+2
	.quad	_r1yT_closure+1
	.quad	_r1yV_closure+2
	.quad	0
.data
.align 3
.align 0
_r1yX_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1yW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1yY_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1yP_closure+2
	.quad	_r1yX_closure+3
	.quad	0
.data
.align 3
.align 0
_r1yZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1z0_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1z1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1z0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1z2_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1z3_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1z2_closure+1
	.quad	0
.data
.align 3
.align 0
_r1z4_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1z1_closure+2
	.quad	_r1z3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1z5_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1z4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1z6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1z7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1z6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1z8_closure:
	.quad	_r1z8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1TC_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1z8_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1z8_info)+0
	.quad	0
	.quad	4294967318
_r1z8_info:
Lc1TD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1TE
Lc1TF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1TB
Lc1TA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1TC_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1TB:
	jmp *(%rbx)
Lc1TE:
	jmp *-16(%r13)
	.long  _r1z8_info - _r1z8_info_dsp
.data
.align 3
.align 0
_r1z9_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1z8_closure
	.quad	0
.data
.align 3
.align 0
_r1za_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1za_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zc_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1z7_closure+2
	.quad	_r1z9_closure+1
	.quad	_r1zb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1zd_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1zc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ze_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1z5_closure+4
	.quad	_r1zd_closure+3
	.quad	0
.data
.align 3
.align 0
_r1zf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ze_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zh_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zi_closure:
	.quad	_r1zi_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ub_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1zi_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1zi_info)+0
	.quad	0
	.quad	4294967318
_r1zi_info:
Lc1Uc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ud
Lc1Ue:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ua
Lc1U9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Ub_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Ua:
	jmp *(%rbx)
Lc1Ud:
	jmp *-16(%r13)
	.long  _r1zi_info - _r1zi_info_dsp
.data
.align 3
.align 0
_r1zj_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1zi_closure
	.quad	0
.data
.align 3
.align 0
_r1zk_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1zh_closure+2
	.quad	_r1zj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zl_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zm_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zl_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zn_closure:
	.quad	_r1zn_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1UA_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1zn_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1zn_info)+0
	.quad	0
	.quad	4294967318
_r1zn_info:
Lc1UB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1UC
Lc1UD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Uz
Lc1Uy:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1UA_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Uz:
	jmp *(%rbx)
Lc1UC:
	jmp *-16(%r13)
	.long  _r1zn_info - _r1zn_info_dsp
.data
.align 3
.align 0
_r1zo_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1zn_closure
	.quad	0
.data
.align 3
.align 0
_r1zp_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1zm_closure+2
	.quad	_r1zo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zq_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zr_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zq_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zs_closure:
	.quad	_r1zs_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1UZ_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1zs_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1zs_info)+0
	.quad	0
	.quad	4294967318
_r1zs_info:
Lc1V0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1V1
Lc1V2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1UY
Lc1UX:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1UZ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1UY:
	jmp *(%rbx)
Lc1V1:
	jmp *-16(%r13)
	.long  _r1zs_info - _r1zs_info_dsp
.data
.align 3
.align 0
_r1zt_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1zs_closure
	.quad	0
.data
.align 3
.align 0
_r1zu_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1zr_closure+2
	.quad	_r1zt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zu_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zw_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zp_closure+1
	.quad	_r1zv_closure+2
	.quad	0
.data
.align 3
.align 0
_r1zx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zk_closure+1
	.quad	_r1zw_closure+2
	.quad	0
.data
.align 3
.align 0
_r1zy_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1zB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1zC_closure:
	.quad	_r1zC_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Vy_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1zC_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1zC_info)+0
	.quad	0
	.quad	4294967318
_r1zC_info:
Lc1Vz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1VA
Lc1VB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Vx
Lc1Vw:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Vy_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Vx:
	jmp *(%rbx)
Lc1VA:
	jmp *-16(%r13)
	.long  _r1zC_info - _r1zC_info_dsp
.data
.align 3
.align 0
_r1zD_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1zC_closure
	.quad	0
.data
.align 3
.align 0
_r1zE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zG_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1zB_closure+2
	.quad	_r1zD_closure+1
	.quad	_r1zF_closure+2
	.quad	0
.data
.align 3
.align 0
_r1zH_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1zG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zI_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1zz_closure+2
	.quad	_r1zH_closure+3
	.quad	0
.data
.align 3
.align 0
_r1zJ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zK_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1zM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1zN_closure:
	.quad	_r1zN_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1W9_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1zN_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1zN_info)+0
	.quad	0
	.quad	4294967318
_r1zN_info:
Lc1Wa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Wb
Lc1Wc:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1W8
Lc1W7:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1W9_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1W8:
	jmp *(%rbx)
Lc1Wb:
	jmp *-16(%r13)
	.long  _r1zN_info - _r1zN_info_dsp
.data
.align 3
.align 0
_r1zO_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1zN_closure
	.quad	0
.data
.align 3
.align 0
_r1zP_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zQ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zP_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zR_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1zM_closure+2
	.quad	_r1zO_closure+1
	.quad	_r1zQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1zS_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1zR_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zT_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1zK_closure+2
	.quad	_r1zS_closure+3
	.quad	0
.data
.align 3
.align 0
_r1zU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1zV_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1zU_closure+1
	.quad	0
.data
.align 3
.align 0
_r1zW_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1zX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zW_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1zY_closure:
	.quad	_r1zY_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1WK_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1zY_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1zY_info)+0
	.quad	0
	.quad	4294967318
_r1zY_info:
Lc1WL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1WM
Lc1WN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1WJ
Lc1WI:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1WK_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1WJ:
	jmp *(%rbx)
Lc1WM:
	jmp *-16(%r13)
	.long  _r1zY_info - _r1zY_info_dsp
.data
.align 3
.align 0
_r1zZ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1zY_closure
	.quad	0
.data
.align 3
.align 0
_r1A0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1A1_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1A0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1A2_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1zX_closure+2
	.quad	_r1zZ_closure+1
	.quad	_r1A1_closure+2
	.quad	0
.data
.align 3
.align 0
_r1A3_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1A2_closure+1
	.quad	0
.data
.align 3
.align 0
_r1A4_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1zV_closure+2
	.quad	_r1A3_closure+3
	.quad	0
.data
.align 3
.align 0
_r1A5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1A4_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1A6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zT_closure+1
	.quad	_r1A5_closure+2
	.quad	0
.data
.align 3
.align 0
_r1A7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zI_closure+1
	.quad	_r1A6_closure+2
	.quad	0
.data
.align 3
.align 0
_r1A8_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1A9_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1A8_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Aa_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Ab_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Aa_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ac_closure:
	.quad	_r1Ac_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Xr_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Ac_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1Ac_info)+0
	.quad	0
	.quad	4294967318
_r1Ac_info:
Lc1Xs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Xt
Lc1Xu:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Xq
Lc1Xp:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Xr_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Xq:
	jmp *(%rbx)
Lc1Xt:
	jmp *-16(%r13)
	.long  _r1Ac_info - _r1Ac_info_dsp
.data
.align 3
.align 0
_r1Ad_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ac_closure
	.quad	0
.data
.align 3
.align 0
_r1Ae_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Af_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ae_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ag_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Ab_closure+2
	.quad	_r1Ad_closure+1
	.quad	_r1Af_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ah_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Ag_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ai_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1A9_closure+2
	.quad	_r1Ah_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Aj_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Ak_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Aj_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Al_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Am_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Al_closure+1
	.quad	0
.data
.align 3
.align 0
_r1An_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Ak_closure+2
	.quad	_r1Am_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ao_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1An_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ap_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Aq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ap_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ar_closure:
	.quad	_r1Ar_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ya_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Ar_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1Ar_info)+0
	.quad	0
	.quad	4294967318
_r1Ar_info:
Lc1Yb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Yc
Lc1Yd:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Y9
Lc1Y8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Ya_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Y9:
	jmp *(%rbx)
Lc1Yc:
	jmp *-16(%r13)
	.long  _r1Ar_info - _r1Ar_info_dsp
.data
.align 3
.align 0
_r1As_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ar_closure
	.quad	0
.data
.align 3
.align 0
_r1At_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Au_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1At_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Av_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Aq_closure+2
	.quad	_r1As_closure+1
	.quad	_r1Au_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Aw_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Av_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ax_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ao_closure+4
	.quad	_r1Aw_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Ay_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Az_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ay_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1AA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1AB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1AA_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AC_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Az_closure+2
	.quad	_r1AB_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AD_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1AC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AE_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1AF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1AE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1AG_closure:
	.quad	_r1AG_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1YT_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1AG_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1AG_info)+0
	.quad	0
	.quad	4294967318
_r1AG_info:
Lc1YU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1YV
Lc1YW:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1YS
Lc1YR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1YT_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1YS:
	jmp *(%rbx)
Lc1YV:
	jmp *-16(%r13)
	.long  _r1AG_info - _r1AG_info_dsp
.data
.align 3
.align 0
_r1AH_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1AG_closure
	.quad	0
.data
.align 3
.align 0
_r1AI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1AJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1AI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AK_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1AF_closure+2
	.quad	_r1AH_closure+1
	.quad	_r1AJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AL_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1AK_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AM_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1AD_closure+4
	.quad	_r1AL_closure+3
	.quad	0
.data
.align 3
.align 0
_r1AN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1AM_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ax_closure+1
	.quad	_r1AN_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ai_closure+1
	.quad	_r1AO_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1AP_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1A7_closure+2
	.quad	_r1AQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zx_closure+2
	.quad	_r1AR_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1zf_closure+2
	.quad	_r1AS_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yZ_closure+2
	.quad	_r1AT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yN_closure+2
	.quad	_r1AU_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_dimzuparserzutests_closure
_F95ArgDeclParserTestRefs_dimzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1yB_closure+2
	.quad	_r1AV_closure+2
	.quad	0
.data
.align 3
.align 0
_r1AW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1AX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1AW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1AY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1AZ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1AY_closure+1
	.quad	0
.data
.align 3
.align 0
_r1B0_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1AX_closure+2
	.quad	_r1AZ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1B1_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1B2_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1B1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1B3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1B4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1B3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1B5_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1B4_closure+2
	.quad	1
.data
.align 3
.align 0
_r1B6_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1B2_closure+2
	.quad	_r1B5_closure+1
	.quad	0
.data
.align 3
.align 0
_r1B7_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1B8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1B7_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1B9_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1B8_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Ba_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Bb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ba_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Bc_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Bb_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Bd_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1B9_closure+1
	.quad	_r1Bc_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Be_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Bf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Be_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Bg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Bh_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Bg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Bi_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Bf_closure+2
	.quad	_r1Bh_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Bj_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Bi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Bk_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Bl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Bk_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Bm_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Bn_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Bm_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Bo_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Bn_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Bp_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Bq_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Bp_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Br_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Bl_closure+2
	.quad	_r1Bo_closure+1
	.quad	_r1Bq_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Bs_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Br_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Bt_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Bj_closure+4
	.quad	_r1Bs_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Bu_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Bv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Bu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Bw_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Bx_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Bw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1By_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Bv_closure+2
	.quad	_r1Bx_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Bz_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1BA_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Bz_closure+1
	.quad	0
.data
.align 3
.align 0
_r1BB_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1BC_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BB_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BD_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1BC_closure+2
	.quad	1
.data
.align 3
.align 0
_r1BE_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1BA_closure+2
	.quad	_r1BD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1BF_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1BG_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1BF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1BH_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1BI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BJ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1BK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BL_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1BK_closure+2
	.quad	1
.data
.align 3
.align 0
_r1BM_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1BN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BM_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BO_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1BN_closure+2
	.quad	1
.data
.align 3
.align 0
_r1BP_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1BI_closure+2
	.quad	_r1BL_closure+1
	.quad	_r1BO_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BQ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1BP_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BR_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1BG_closure+2
	.quad	_r1BQ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1BS_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1BT_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1BS_closure+1
	.quad	0
.data
.align 3
.align 0
_r1BU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1BV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1BW_closure:
	.quad	_r1BW_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c21G_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1BW_info_dsp:
.text
.align 3
	.quad	_S1EC_srt-(_r1BW_info)+0
	.quad	0
	.quad	4294967318
_r1BW_info:
Lc21H:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc21I
Lc21J:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc21F
Lc21E:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c21G_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc21F:
	jmp *(%rbx)
Lc21I:
	jmp *-16(%r13)
	.long  _r1BW_info - _r1BW_info_dsp
.data
.align 3
.align 0
_r1BX_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1BW_closure
	.quad	0
.data
.align 3
.align 0
_r1BY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1BZ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1BY_closure+1
	.quad	0
.data
.align 3
.align 0
_r1C0_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1BV_closure+2
	.quad	_r1BX_closure+1
	.quad	_r1BZ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1C1_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1C0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1C2_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1BT_closure+2
	.quad	_r1C1_closure+3
	.quad	0
.data
.align 3
.align 0
_r1C3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1C2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1C4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BR_closure+1
	.quad	_r1C3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1C5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1BE_closure+1
	.quad	_r1C4_closure+2
	.quad	0
.data
.align 3
.align 0
_r1C6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1By_closure+1
	.quad	_r1C5_closure+2
	.quad	0
.data
.align 3
.align 0
_r1C7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Bt_closure+1
	.quad	_r1C6_closure+2
	.quad	0
.data
.align 3
.align 0
_r1C8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Bd_closure+1
	.quad	_r1C7_closure+2
	.quad	0
.data
.align 3
.align 0
_r1C9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1B6_closure+1
	.quad	_r1C8_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuparserzutests_closure
_F95ArgDeclParserTestRefs_rangezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1B0_closure+1
	.quad	_r1C9_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ca_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Cb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ca_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Cc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Cd_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Cc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ce_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Cb_closure+2
	.quad	_r1Cd_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Cf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Cg_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Cf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ch_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Ci_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ch_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Cj_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ci_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Ck_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Cg_closure+2
	.quad	_r1Cj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Cl_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Cm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Cl_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Cn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Cm_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Co_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Cp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Co_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Cq_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Cp_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Cr_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Cn_closure+1
	.quad	_r1Cq_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Cs_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Ct_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Cs_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Cu_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Cv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Cu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Cw_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Ct_closure+2
	.quad	_r1Cv_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Cx_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Cw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Cy_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Cz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Cy_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1CA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1CB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1CC_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1CB_closure+2
	.quad	1
.data
.align 3
.align 0
_r1CD_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1CE_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1CD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1CF_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Cz_closure+2
	.quad	_r1CC_closure+1
	.quad	_r1CE_closure+2
	.quad	0
.data
.align 3
.align 0
_r1CG_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1CF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1CH_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Cx_closure+4
	.quad	_r1CG_closure+3
	.quad	0
.data
.align 3
.align 0
_r1CI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1CJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Cr_closure+1
	.quad	_r1CI_closure+2
	.quad	0
.data
.align 3
.align 0
_r1CK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ck_closure+1
	.quad	_r1CJ_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuexprzutests_closure
_F95ArgDeclParserTestRefs_rangezuexprzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ce_closure+1
	.quad	_r1CK_closure+2
	.quad	0
.data
.align 3
.align 0
_r1CL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1CM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1CN_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1CO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1CP_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1CO_closure+2
	.quad	1
.data
.align 3
.align 0
_r1CQ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1CR_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1CQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1CS_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1CM_closure+2
	.quad	_r1CP_closure+1
	.quad	_r1CR_closure+2
	.quad	0
.data
.align 3
.align 0
_r1CT_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1CS_closure+1
	.quad	0
.data
.align 3
.align 0
_r1CU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1CV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1CW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1CX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1CW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1CY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1CZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1D0_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1CZ_closure+2
	.quad	1
.data
.align 3
.align 0
_r1D1_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1CV_closure+2
	.quad	_r1CX_closure+2
	.quad	_r1D0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1D2_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1D1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1D3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1D4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1D3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1D5_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1D6_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1D5_closure+1
	.quad	0
.data
.align 3
.align 0
_r1D7_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1D8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1D7_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1D9_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Da_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1D9_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Db_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Da_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Dc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Dd_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Dc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1De_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1D8_closure+2
	.quad	_r1Db_closure+1
	.quad	_r1Dd_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Df_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1De_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Dg_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1D4_closure+2
	.quad	_r1D6_closure+2
	.quad	_r1Df_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Dh_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Dg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Di_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Dj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Di_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Dk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1Dl_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Dk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Dm_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1Dn_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Dm_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Do_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Dp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Do_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Dq_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Dp_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Dr_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Ds_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Dr_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Dt_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ds_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Du_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Dn_closure+2
	.quad	_r1Dq_closure+1
	.quad	_r1Dt_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Dv_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Du_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Dw_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Dj_closure+2
	.quad	_r1Dl_closure+2
	.quad	_r1Dv_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Dx_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Dw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Dy_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1Dz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Dy_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1DB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DC_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1DD_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1DC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1DE_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1DB_closure+2
	.quad	_r1DD_closure+2
	.quad	0
.data
.align 3
.align 0
_r1DF_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1DE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1DG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1DH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DI_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1DJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DI_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DK_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1DJ_closure+2
	.quad	1
.data
.align 3
.align 0
_r1DL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1DM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DN_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1DM_closure+2
	.quad	1
.data
.align 3
.align 0
_r1DO_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1DH_closure+2
	.quad	_r1DK_closure+1
	.quad	_r1DN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DP_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1DO_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DQ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Dz_closure+2
	.quad	_r1DF_closure+4
	.quad	_r1DP_closure+3
	.quad	0
.data
.align 3
.align 0
_r1DR_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1DQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1DS_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1DT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DS_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1DV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1DW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1DX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1DW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1DY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1DZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1E0_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1E1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1E0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1E2_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1E1_closure+2
	.quad	1
.data
.align 3
.align 0
_r1E3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1E4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1E3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1E5_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1E4_closure+2
	.quad	1
.data
.align 3
.align 0
_r1E6_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1DZ_closure+2
	.quad	_r1E2_closure+1
	.quad	_r1E5_closure+1
	.quad	1
.data
.align 3
.align 0
_r1E7_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1E6_closure+1
	.quad	1
.data
.align 3
.align 0
_r1E8_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1DV_closure+2
	.quad	_r1DX_closure+2
	.quad	_r1E7_closure+3
	.quad	0
.data
.align 3
.align 0
_r1E9_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1E8_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ea_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1DT_closure+2
	.quad	_r1E9_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Eb_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Ea_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ec_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Eb_closure+4
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ed_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1DR_closure+3
	.quad	_r1Ec_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ee_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Dx_closure+3
	.quad	_r1Ed_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ef_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Dh_closure+3
	.quad	_r1Ee_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Eg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1D2_closure+3
	.quad	_r1Ef_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_exprzuparserzutests_closure
_F95ArgDeclParserTestRefs_exprzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1CT_closure+3
	.quad	_r1Eg_closure+2
	.quad	0
.const_data
.align 3
.align 0
_S1EC_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_base_ControlziExceptionziBase_recConError_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

