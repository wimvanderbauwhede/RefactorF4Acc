.data
.align 3
.align 0
.globl ___stginit_F95ArgDeclParserTestRefs
___stginit_F95ArgDeclParserTestRefs:
.data
.align 3
.align 0
_r22J_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	112
.data
.align 3
.align 0
_r2cT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22J_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cT_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cV_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r2cW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cV_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cX_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r2cY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cX_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r2d0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2d1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2d0_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2d2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cY_closure+2
	.quad	_r2d1_closure+2
	.quad	1
.data
.align 3
.align 0
_r2d3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cW_closure+2
	.quad	_r2d2_closure+2
	.quad	1
.data
.align 3
.align 0
_r2d4_closure:
	.quad	_r2d4_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2mF_str:
	.byte	102
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r2d4_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2d4_info)+0
	.quad	0
	.quad	4294967318
_r2d4_info:
Lc2mG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mH
Lc2mI:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mE
Lc2mD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2mF_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mE:
	jmp *(%rbx)
Lc2mH:
	jmp *-16(%r13)
	.long  _r2d4_info - _r2d4_info_dsp
.data
.align 3
.align 0
_r2d5_closure:
	.quad	_r2d5_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2mX_str:
	.byte	103
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r2d5_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2d5_info)+0
	.quad	0
	.quad	4294967318
_r2d5_info:
Lc2mY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mZ
Lc2n0:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mW
Lc2mV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2mX_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mW:
	jmp *(%rbx)
Lc2mZ:
	jmp *-16(%r13)
	.long  _r2d5_info - _r2d5_info_dsp
.data
.align 3
.align 0
_r2d6_closure:
	.quad	_r2d6_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ne_str:
	.byte	104
	.byte	52
	.byte	50
	.byte	0
.text
.align 3
_r2d6_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2d6_info)+0
	.quad	0
	.quad	4294967318
_r2d6_info:
Lc2nf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ng
Lc2nh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nd
Lc2nc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ne_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2nd:
	jmp *(%rbx)
Lc2ng:
	jmp *-16(%r13)
	.long  _r2d6_info - _r2d6_info_dsp
.data
.align 3
.align 0
_r2d7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2d6_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2d8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2d5_closure
	.quad	_r2d7_closure+2
	.quad	0
.data
.align 3
.align 0
_r2d9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2d4_closure
	.quad	_r2d8_closure+2
	.quad	0
.data
.align 3
.align 0
_r2da_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2d9_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2db_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2d3_closure+2
	.quad	_r2da_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_arglistzuparserzutests_closure
_F95ArgDeclParserTestRefs_arglistzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cU_closure+2
	.quad	_r2db_closure+2
	.quad	0
.data
.align 3
.align 0
_r2dc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dd_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2dc_closure+1
	.quad	0
.data
.align 3
.align 0
_r2de_closure:
	.quad	_r2de_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2nL_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2de_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2de_info)+0
	.quad	0
	.quad	4294967318
_r2de_info:
Lc2nM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nN
Lc2nO:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nK
Lc2nJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2nL_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2nK:
	jmp *(%rbx)
Lc2nN:
	jmp *-16(%r13)
	.long  _r2de_info - _r2de_info_dsp
.data
.align 3
.align 0
_r2df_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2de_closure
	.quad	0
.data
.align 3
.align 0
_r2dg_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2dd_closure+2
	.quad	_r2df_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2di_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dj_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2di_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dk_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2dl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dk_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2dm_closure:
	.quad	_r2dm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2og_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2dm_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2dm_info)+0
	.quad	0
	.quad	4294967318
_r2dm_info:
Lc2oh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oi
Lc2oj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2of
Lc2oe:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2og_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2of:
	jmp *(%rbx)
Lc2oi:
	jmp *-16(%r13)
	.long  _r2dm_info - _r2dm_info_dsp
.data
.align 3
.align 0
_r2dn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2dm_closure
	.quad	0
.data
.align 3
.align 0
_r2do_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2do_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dq_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2dl_closure+2
	.quad	_r2dn_closure+1
	.quad	_r2dp_closure+2
	.quad	0
.data
.align 3
.align 0
_r2dr_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2dq_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ds_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2dj_closure+2
	.quad	_r2dr_closure+3
	.quad	0
.data
.align 3
.align 0
_r2dt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ds_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2du_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2dv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2du_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dw_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2dx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dw_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2dy_closure:
	.quad	_r2dy_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2oT_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2dy_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2dy_info)+0
	.quad	0
	.quad	4294967318
_r2dy_info:
Lc2oU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oV
Lc2oW:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2oS
Lc2oR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2oT_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2oS:
	jmp *(%rbx)
Lc2oV:
	jmp *-16(%r13)
	.long  _r2dy_info - _r2dy_info_dsp
.data
.align 3
.align 0
_r2dz_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2dy_closure
	.quad	0
.data
.align 3
.align 0
_r2dA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2dA_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dC_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2dx_closure+2
	.quad	_r2dz_closure+1
	.quad	_r2dB_closure+2
	.quad	0
.data
.align 3
.align 0
_r2dD_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2dC_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dE_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2dv_closure+2
	.quad	_r2dD_closure+3
	.quad	0
.data
.align 3
.align 0
_r2dF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2dH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2dI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2dI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dK_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2dH_closure+2
	.quad	_r2dJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2dL_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2dK_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dM_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2dN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dM_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2dO_closure:
	.quad	_r2dO_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2pE_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2dO_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2dO_info)+0
	.quad	0
	.quad	4294967318
_r2dO_info:
Lc2pF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pG
Lc2pH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2pD
Lc2pC:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2pE_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2pD:
	jmp *(%rbx)
Lc2pG:
	jmp *-16(%r13)
	.long  _r2dO_info - _r2dO_info_dsp
.data
.align 3
.align 0
_r2dP_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2dO_closure
	.quad	0
.data
.align 3
.align 0
_r2dQ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dR_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2dQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dS_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2dN_closure+2
	.quad	_r2dP_closure+1
	.quad	_r2dR_closure+2
	.quad	0
.data
.align 3
.align 0
_r2dT_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2dS_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dU_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2dL_closure+4
	.quad	_r2dT_closure+3
	.quad	0
.data
.align 3
.align 0
_r2dV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2dX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2dW_closure+1
	.quad	0
.data
.align 3
.align 0
_r2dY_closure:
	.quad	_r2dY_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2qd_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2dY_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2dY_info)+0
	.quad	0
	.quad	4294967318
_r2dY_info:
Lc2qe:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qf
Lc2qg:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qc
Lc2qb:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2qd_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2qc:
	jmp *(%rbx)
Lc2qf:
	jmp *-16(%r13)
	.long  _r2dY_info - _r2dY_info_dsp
.data
.align 3
.align 0
_r2dZ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2dY_closure
	.quad	0
.data
.align 3
.align 0
_r2e0_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2dX_closure+2
	.quad	_r2dZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2e1_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2e2_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2e1_closure+1
	.quad	0
.data
.align 3
.align 0
_r2e3_closure:
	.quad	_r2e3_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2qC_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2e3_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2e3_info)+0
	.quad	0
	.quad	4294967318
_r2e3_info:
Lc2qD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qE
Lc2qF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qB
Lc2qA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2qC_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2qB:
	jmp *(%rbx)
Lc2qE:
	jmp *-16(%r13)
	.long  _r2e3_info - _r2e3_info_dsp
.data
.align 3
.align 0
_r2e4_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2e3_closure
	.quad	0
.data
.align 3
.align 0
_r2e5_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2e2_closure+2
	.quad	_r2e4_closure+1
	.quad	0
.data
.align 3
.align 0
_r2e6_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2e7_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2e6_closure+1
	.quad	0
.data
.align 3
.align 0
_r2e8_closure:
	.quad	_r2e8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2r1_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2e8_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2e8_info)+0
	.quad	0
	.quad	4294967318
_r2e8_info:
Lc2r2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2r3
Lc2r4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2r0
Lc2qZ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2r1_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2r0:
	jmp *(%rbx)
Lc2r3:
	jmp *-16(%r13)
	.long  _r2e8_info - _r2e8_info_dsp
.data
.align 3
.align 0
_r2e9_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2e8_closure
	.quad	0
.data
.align 3
.align 0
_r2ea_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2e7_closure+2
	.quad	_r2e9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ea_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ec_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2e5_closure+1
	.quad	_r2eb_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ed_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2e0_closure+1
	.quad	_r2ec_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ee_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ef_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ee_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eg_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2eh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ei_closure:
	.quad	_r2ei_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2rA_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2ei_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2ei_info)+0
	.quad	0
	.quad	4294967318
_r2ei_info:
Lc2rB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rC
Lc2rD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rz
Lc2ry:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2rA_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2rz:
	jmp *(%rbx)
Lc2rC:
	jmp *-16(%r13)
	.long  _r2ei_info - _r2ei_info_dsp
.data
.align 3
.align 0
_r2ej_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2ei_closure
	.quad	0
.data
.align 3
.align 0
_r2ek_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2el_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ek_closure+1
	.quad	0
.data
.align 3
.align 0
_r2em_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2eh_closure+2
	.quad	_r2ej_closure+1
	.quad	_r2el_closure+2
	.quad	0
.data
.align 3
.align 0
_r2en_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2em_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eo_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2ef_closure+2
	.quad	_r2en_closure+3
	.quad	0
.data
.align 3
.align 0
_r2ep_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2eq_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ep_closure+1
	.quad	0
.data
.align 3
.align 0
_r2er_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2es_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2er_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2et_closure:
	.quad	_r2et_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2sb_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2et_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2et_info)+0
	.quad	0
	.quad	4294967318
_r2et_info:
Lc2sc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sd
Lc2se:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sa
Lc2s9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2sb_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2sa:
	jmp *(%rbx)
Lc2sd:
	jmp *-16(%r13)
	.long  _r2et_info - _r2et_info_dsp
.data
.align 3
.align 0
_r2eu_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2et_closure
	.quad	0
.data
.align 3
.align 0
_r2ev_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ew_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ev_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ex_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2es_closure+2
	.quad	_r2eu_closure+1
	.quad	_r2ew_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ey_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2ex_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ez_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2eq_closure+2
	.quad	_r2ey_closure+3
	.quad	0
.data
.align 3
.align 0
_r2eA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2eB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2eA_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2eD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2eE_closure:
	.quad	_r2eE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2sM_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2eE_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2eE_info)+0
	.quad	0
	.quad	4294967318
_r2eE_info:
Lc2sN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sO
Lc2sP:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sL
Lc2sK:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2sM_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2sL:
	jmp *(%rbx)
Lc2sO:
	jmp *-16(%r13)
	.long  _r2eE_info - _r2eE_info_dsp
.data
.align 3
.align 0
_r2eF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2eE_closure
	.quad	0
.data
.align 3
.align 0
_r2eG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2eH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2eG_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eI_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2eD_closure+2
	.quad	_r2eF_closure+1
	.quad	_r2eH_closure+2
	.quad	0
.data
.align 3
.align 0
_r2eJ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2eI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2eB_closure+2
	.quad	_r2eJ_closure+3
	.quad	0
.data
.align 3
.align 0
_r2eL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eK_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ez_closure+1
	.quad	_r2eL_closure+2
	.quad	0
.data
.align 3
.align 0
_r2eN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eo_closure+1
	.quad	_r2eM_closure+2
	.quad	0
.data
.align 3
.align 0
_r2eO_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2eP_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2eO_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eQ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2eR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eQ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2eS_closure:
	.quad	_r2eS_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2tt_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2eS_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2eS_info)+0
	.quad	0
	.quad	4294967318
_r2eS_info:
Lc2tu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tv
Lc2tw:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ts
Lc2tr:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2tt_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ts:
	jmp *(%rbx)
Lc2tv:
	jmp *-16(%r13)
	.long  _r2eS_info - _r2eS_info_dsp
.data
.align 3
.align 0
_r2eT_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2eS_closure
	.quad	0
.data
.align 3
.align 0
_r2eU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2eV_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2eU_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eW_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2eR_closure+2
	.quad	_r2eT_closure+1
	.quad	_r2eV_closure+2
	.quad	0
.data
.align 3
.align 0
_r2eX_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2eW_closure+1
	.quad	0
.data
.align 3
.align 0
_r2eY_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2eP_closure+2
	.quad	_r2eX_closure+3
	.quad	0
.data
.align 3
.align 0
_r2eZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2f0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2f1_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2f2_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2f1_closure+1
	.quad	0
.data
.align 3
.align 0
_r2f3_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2f0_closure+2
	.quad	_r2f2_closure+2
	.quad	0
.data
.align 3
.align 0
_r2f4_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2f3_closure+1
	.quad	0
.data
.align 3
.align 0
_r2f5_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2f6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2f5_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2f7_closure:
	.quad	_r2f7_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2uc_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2f7_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2f7_info)+0
	.quad	0
	.quad	4294967318
_r2f7_info:
Lc2ud:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ue
Lc2uf:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ub
Lc2ua:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2uc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ub:
	jmp *(%rbx)
Lc2ue:
	jmp *-16(%r13)
	.long  _r2f7_info - _r2f7_info_dsp
.data
.align 3
.align 0
_r2f8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2f7_closure
	.quad	0
.data
.align 3
.align 0
_r2f9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2fa_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2f9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fb_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2f6_closure+2
	.quad	_r2f8_closure+1
	.quad	_r2fa_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fc_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2fb_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fd_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2f4_closure+4
	.quad	_r2fc_closure+3
	.quad	0
.data
.align 3
.align 0
_r2fe_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2ff_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fe_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2fh_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2fg_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fi_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2ff_closure+2
	.quad	_r2fh_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fj_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2fi_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fk_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2fl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fk_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fm_closure:
	.quad	_r2fm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2uV_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2fm_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2fm_info)+0
	.quad	0
	.quad	4294967318
_r2fm_info:
Lc2uW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uX
Lc2uY:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2uU
Lc2uT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2uV_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2uU:
	jmp *(%rbx)
Lc2uX:
	jmp *-16(%r13)
	.long  _r2fm_info - _r2fm_info_dsp
.data
.align 3
.align 0
_r2fn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2fm_closure
	.quad	0
.data
.align 3
.align 0
_r2fo_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2fp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2fo_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fq_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2fl_closure+2
	.quad	_r2fn_closure+1
	.quad	_r2fp_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fr_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2fq_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fs_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2fj_closure+4
	.quad	_r2fr_closure+3
	.quad	0
.data
.align 3
.align 0
_r2ft_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fs_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fd_closure+1
	.quad	_r2ft_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eY_closure+1
	.quad	_r2fu_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fw_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fv_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2eN_closure+2
	.quad	_r2fw_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ed_closure+2
	.quad	_r2fx_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dV_closure+2
	.quad	_r2fy_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dF_closure+2
	.quad	_r2fz_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dt_closure+2
	.quad	_r2fA_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_dimzuparserzutests_closure
_F95ArgDeclParserTestRefs_dimzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2dh_closure+2
	.quad	_r2fB_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2fD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fE_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2fF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fG_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2fF_closure+2
	.quad	1
.data
.align 3
.align 0
_r2fH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2fI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2fH_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fJ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2fD_closure+2
	.quad	_r2fG_closure+1
	.quad	_r2fI_closure+2
	.quad	0
.data
.align 3
.align 0
_r2fK_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2fJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2fM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2fO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2fN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fP_closure:
	.quad	_r2fP_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2w8_str:
	.byte	121
	.byte	50
	.byte	0
.text
.align 3
_r2fP_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2fP_info)+0
	.quad	0
	.quad	4294967318
_r2fP_info:
Lc2w9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wa
Lc2wb:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2w7
Lc2w6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2w8_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2w7:
	jmp *(%rbx)
Lc2wa:
	jmp *-16(%r13)
	.long  _r2fP_info - _r2fP_info_dsp
.data
.align 3
.align 0
_r2fQ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2fP_closure
	.quad	0
.data
.align 3
.align 0
_r2fR_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2fM_closure+2
	.quad	_r2fO_closure+2
	.quad	_r2fQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fS_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2fR_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fT_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2fU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fT_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2fW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2fV_closure+1
	.quad	0
.data
.align 3
.align 0
_r2fX_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2fY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fX_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2fZ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2fY_closure+2
	.quad	1
.data
.align 3
.align 0
_r2g0_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2fU_closure+2
	.quad	_r2fW_closure+2
	.quad	_r2fZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2g1_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2g0_closure+1
	.quad	0
.data
.align 3
.align 0
_r2g2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2g3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2g2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2g4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2g5_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2g4_closure+1
	.quad	0
.data
.align 3
.align 0
_r2g6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2g7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2g6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2g8_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2g9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2g8_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ga_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2g9_closure+2
	.quad	1
.data
.align 3
.align 0
_r2gb_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2gc_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2gb_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gd_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2g7_closure+2
	.quad	_r2ga_closure+1
	.quad	_r2gc_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ge_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2gd_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gf_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2g3_closure+2
	.quad	_r2g5_closure+2
	.quad	_r2ge_closure+3
	.quad	0
.data
.align 3
.align 0
_r2gg_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2gf_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gh_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2gi_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gh_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2gk_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2gj_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gl_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2gm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gl_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gn_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2go_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gn_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gp_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2go_closure+2
	.quad	1
.data
.align 3
.align 0
_r2gq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2gr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gs_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2gr_closure+2
	.quad	1
.data
.align 3
.align 0
_r2gt_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2gm_closure+2
	.quad	_r2gp_closure+1
	.quad	_r2gs_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gu_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2gt_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gv_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2gi_closure+2
	.quad	_r2gk_closure+2
	.quad	_r2gu_closure+3
	.quad	0
.data
.align 3
.align 0
_r2gw_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2gv_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gx_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2gy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gx_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2gA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2gC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2gB_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gD_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2gA_closure+2
	.quad	_r2gC_closure+2
	.quad	0
.data
.align 3
.align 0
_r2gE_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2gD_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gF_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2gG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gH_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2gI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gJ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2gI_closure+2
	.quad	1
.data
.align 3
.align 0
_r2gK_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2gL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gK_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gM_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2gL_closure+2
	.quad	1
.data
.align 3
.align 0
_r2gN_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2gG_closure+2
	.quad	_r2gJ_closure+1
	.quad	_r2gM_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gO_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2gN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gP_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2gy_closure+2
	.quad	_r2gE_closure+4
	.quad	_r2gO_closure+3
	.quad	0
.data
.align 3
.align 0
_r2gQ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2gP_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2gS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gT_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2gU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gT_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2gW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2gV_closure+1
	.quad	0
.data
.align 3
.align 0
_r2gX_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2gY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gX_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2gZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2h0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2h1_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2h0_closure+2
	.quad	1
.data
.align 3
.align 0
_r2h2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2h3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2h2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2h4_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2h3_closure+2
	.quad	1
.data
.align 3
.align 0
_r2h5_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2gY_closure+2
	.quad	_r2h1_closure+1
	.quad	_r2h4_closure+1
	.quad	1
.data
.align 3
.align 0
_r2h6_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2h5_closure+1
	.quad	1
.data
.align 3
.align 0
_r2h7_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2gU_closure+2
	.quad	_r2gW_closure+2
	.quad	_r2h6_closure+3
	.quad	0
.data
.align 3
.align 0
_r2h8_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2h7_closure+1
	.quad	0
.data
.align 3
.align 0
_r2h9_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2gS_closure+2
	.quad	_r2h8_closure+3
	.quad	0
.data
.align 3
.align 0
_r2ha_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2h9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ha_closure+4
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gQ_closure+3
	.quad	_r2hb_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hd_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gw_closure+3
	.quad	_r2hc_closure+2
	.quad	0
.data
.align 3
.align 0
_r2he_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2gg_closure+3
	.quad	_r2hd_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2g1_closure+3
	.quad	_r2he_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fS_closure+3
	.quad	_r2hf_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_exprzuparserzutests_closure
_F95ArgDeclParserTestRefs_exprzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2fK_closure+3
	.quad	_r2hg_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hh_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r2hi_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r2hh_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hk_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2hj_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hl_closure:
	.quad	_r2hl_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2zr_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2hl_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2hl_info)+0
	.quad	0
	.quad	4294967318
_r2hl_info:
Lc2zs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zt
Lc2zu:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zq
Lc2zp:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2zr_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2zq:
	jmp *(%rbx)
Lc2zt:
	jmp *-16(%r13)
	.long  _r2hl_info - _r2hl_info_dsp
.data
.align 3
.align 0
_r2hm_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2hl_closure
	.quad	0
.data
.align 3
.align 0
_r2hn_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2hk_closure+2
	.quad	_r2hm_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ho_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ho_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hq_closure:
	.quad	_r2hq_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2zQ_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2hq_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2hq_info)+0
	.quad	0
	.quad	4294967318
_r2hq_info:
Lc2zR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zS
Lc2zT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zP
Lc2zO:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2zQ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2zP:
	jmp *(%rbx)
Lc2zS:
	jmp *-16(%r13)
	.long  _r2hq_info - _r2hq_info_dsp
.data
.align 3
.align 0
_r2hr_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2hq_closure
	.quad	0
.data
.align 3
.align 0
_r2hs_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2hp_closure+2
	.quad	_r2hr_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ht_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hu_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ht_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hv_closure:
	.quad	_r2hv_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Af_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2hv_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2hv_info)+0
	.quad	0
	.quad	4294967318
_r2hv_info:
Lc2Ag:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ah
Lc2Ai:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ae
Lc2Ad:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Af_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ae:
	jmp *(%rbx)
Lc2Ah:
	jmp *-16(%r13)
	.long  _r2hv_info - _r2hv_info_dsp
.data
.align 3
.align 0
_r2hw_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2hv_closure
	.quad	0
.data
.align 3
.align 0
_r2hx_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2hu_closure+2
	.quad	_r2hw_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hx_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hs_closure+1
	.quad	_r2hy_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hn_closure+1
	.quad	_r2hz_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hB_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r2hC_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hB_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2hD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hC_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2hE_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r2hi_closure+1
	.quad	_r2hA_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r2hD_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hF_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r2hG_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r2hF_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2hH_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hJ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2hK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2hL_closure:
	.quad	_r2hL_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2B0_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2hL_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2hL_info)+0
	.quad	0
	.quad	4294967318
_r2hL_info:
Lc2B1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2B2
Lc2B3:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2AZ
Lc2AY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2B0_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2AZ:
	jmp *(%rbx)
Lc2B2:
	jmp *-16(%r13)
	.long  _r2hL_info - _r2hL_info_dsp
.data
.align 3
.align 0
_r2hM_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2hL_closure
	.quad	0
.data
.align 3
.align 0
_r2hN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2hN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hP_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2hK_closure+2
	.quad	_r2hM_closure+1
	.quad	_r2hO_closure+2
	.quad	0
.data
.align 3
.align 0
_r2hQ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2hP_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hR_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2hI_closure+2
	.quad	_r2hQ_closure+3
	.quad	0
.data
.align 3
.align 0
_r2hS_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hT_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2hS_closure+1
	.quad	0
.data
.align 3
.align 0
_r2hU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2hV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2hW_closure:
	.quad	_r2hW_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2BB_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2hW_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2hW_info)+0
	.quad	0
	.quad	4294967318
_r2hW_info:
Lc2BC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BD
Lc2BE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2BA
Lc2Bz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2BB_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2BA:
	jmp *(%rbx)
Lc2BD:
	jmp *-16(%r13)
	.long  _r2hW_info - _r2hW_info_dsp
.data
.align 3
.align 0
_r2hX_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2hW_closure
	.quad	0
.data
.align 3
.align 0
_r2hY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2hZ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2hY_closure+1
	.quad	0
.data
.align 3
.align 0
_r2i0_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2hV_closure+2
	.quad	_r2hX_closure+1
	.quad	_r2hZ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2i1_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2i0_closure+1
	.quad	0
.data
.align 3
.align 0
_r2i2_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2hT_closure+2
	.quad	_r2i1_closure+3
	.quad	0
.data
.align 3
.align 0
_r2i3_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2i4_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2i3_closure+1
	.quad	0
.data
.align 3
.align 0
_r2i5_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2i6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2i5_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2i7_closure:
	.quad	_r2i7_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Cc_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2i7_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2i7_info)+0
	.quad	0
	.quad	4294967318
_r2i7_info:
Lc2Cd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ce
Lc2Cf:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Cb
Lc2Ca:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Cc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Cb:
	jmp *(%rbx)
Lc2Ce:
	jmp *-16(%r13)
	.long  _r2i7_info - _r2i7_info_dsp
.data
.align 3
.align 0
_r2i8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2i7_closure
	.quad	0
.data
.align 3
.align 0
_r2i9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ia_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2i9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ib_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2i6_closure+2
	.quad	_r2i8_closure+1
	.quad	_r2ia_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ic_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2ib_closure+1
	.quad	0
.data
.align 3
.align 0
_r2id_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2i4_closure+2
	.quad	_r2ic_closure+3
	.quad	0
.data
.align 3
.align 0
_r2ie_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2id_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2if_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2i2_closure+1
	.quad	_r2ie_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ig_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hR_closure+1
	.quad	_r2if_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ih_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r2ii_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ih_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ij_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ii_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ik_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r2hG_closure+1
	.quad	_r2ig_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r2ij_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2il_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r2im_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r2il_closure+1
	.quad	0
.data
.align 3
.align 0
_r2in_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2io_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2in_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ip_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2iq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ip_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ir_closure:
	.quad	_r2ir_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2D5_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2ir_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2ir_info)+0
	.quad	0
	.quad	4294967318
_r2ir_info:
Lc2D6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2D7
Lc2D8:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2D4
Lc2D3:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2D5_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2D4:
	jmp *(%rbx)
Lc2D7:
	jmp *-16(%r13)
	.long  _r2ir_info - _r2ir_info_dsp
.data
.align 3
.align 0
_r2is_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2ir_closure
	.quad	0
.data
.align 3
.align 0
_r2it_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2iu_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2it_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iv_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2iq_closure+2
	.quad	_r2is_closure+1
	.quad	_r2iu_closure+2
	.quad	0
.data
.align 3
.align 0
_r2iw_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2iv_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ix_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2io_closure+2
	.quad	_r2iw_closure+3
	.quad	0
.data
.align 3
.align 0
_r2iy_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2iz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2iy_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2iA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2iB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2iA_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iC_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2iz_closure+2
	.quad	_r2iB_closure+2
	.quad	0
.data
.align 3
.align 0
_r2iD_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2iC_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iE_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2iF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2iE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2iG_closure:
	.quad	_r2iG_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2DO_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2iG_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2iG_info)+0
	.quad	0
	.quad	4294967318
_r2iG_info:
Lc2DP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2DQ
Lc2DR:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2DN
Lc2DM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2DO_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2DN:
	jmp *(%rbx)
Lc2DQ:
	jmp *-16(%r13)
	.long  _r2iG_info - _r2iG_info_dsp
.data
.align 3
.align 0
_r2iH_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2iG_closure
	.quad	0
.data
.align 3
.align 0
_r2iI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2iJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2iI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iK_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2iF_closure+2
	.quad	_r2iH_closure+1
	.quad	_r2iJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2iL_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2iK_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iM_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2iD_closure+4
	.quad	_r2iL_closure+3
	.quad	0
.data
.align 3
.align 0
_r2iN_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2iO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2iN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2iP_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2iQ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2iP_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iR_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2iO_closure+2
	.quad	_r2iQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2iS_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2iR_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iT_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2iU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2iT_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2iV_closure:
	.quad	_r2iV_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Ex_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2iV_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2iV_info)+0
	.quad	0
	.quad	4294967318
_r2iV_info:
Lc2Ey:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ez
Lc2EA:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ew
Lc2Ev:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Ex_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ew:
	jmp *(%rbx)
Lc2Ez:
	jmp *-16(%r13)
	.long  _r2iV_info - _r2iV_info_dsp
.data
.align 3
.align 0
_r2iW_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2iV_closure
	.quad	0
.data
.align 3
.align 0
_r2iX_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2iY_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2iX_closure+1
	.quad	0
.data
.align 3
.align 0
_r2iZ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2iU_closure+2
	.quad	_r2iW_closure+1
	.quad	_r2iY_closure+2
	.quad	0
.data
.align 3
.align 0
_r2j0_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2iZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2j1_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2iS_closure+4
	.quad	_r2j0_closure+3
	.quad	0
.data
.align 3
.align 0
_r2j2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2j1_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2j3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2iM_closure+1
	.quad	_r2j2_closure+2
	.quad	0
.data
.align 3
.align 0
_r2j4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ix_closure+1
	.quad	_r2j3_closure+2
	.quad	0
.data
.align 3
.align 0
_r2j5_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r2j6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2j5_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2j7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2j6_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2j8_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r2im_closure+1
	.quad	_r2j4_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r2j7_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2j9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r2ja_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r2j9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jb_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2jc_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2jb_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jd_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2je_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jd_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2jf_closure:
	.quad	_r2jf_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Fq_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2jf_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jf_info)+0
	.quad	0
	.quad	4294967318
_r2jf_info:
Lc2Fr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fs
Lc2Ft:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Fp
Lc2Fo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Fq_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Fp:
	jmp *(%rbx)
Lc2Fs:
	jmp *-16(%r13)
	.long  _r2jf_info - _r2jf_info_dsp
.data
.align 3
.align 0
_r2jg_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2jf_closure
	.quad	0
.data
.align 3
.align 0
_r2jh_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ji_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2jh_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jj_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2je_closure+2
	.quad	_r2jg_closure+1
	.quad	_r2ji_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jk_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2jj_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jl_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2jc_closure+2
	.quad	_r2jk_closure+3
	.quad	0
.data
.align 3
.align 0
_r2jm_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2jn_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2jm_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jo_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2jp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jo_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2jq_closure:
	.quad	_r2jq_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2G1_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r2jq_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jq_info)+0
	.quad	0
	.quad	4294967318
_r2jq_info:
Lc2G2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2G3
Lc2G4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2G0
Lc2FZ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2G1_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2G0:
	jmp *(%rbx)
Lc2G3:
	jmp *-16(%r13)
	.long  _r2jq_info - _r2jq_info_dsp
.data
.align 3
.align 0
_r2jr_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2jq_closure
	.quad	0
.data
.align 3
.align 0
_r2js_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2jt_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2js_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ju_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2jp_closure+2
	.quad	_r2jr_closure+1
	.quad	_r2jt_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jv_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2ju_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jw_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2jn_closure+2
	.quad	_r2jv_closure+3
	.quad	0
.data
.align 3
.align 0
_r2jx_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2jy_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2jx_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2jA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2jB_closure:
	.quad	_r2jB_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2GC_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r2jB_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jB_info)+0
	.quad	0
	.quad	4294967318
_r2jB_info:
Lc2GD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GE
Lc2GF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2GB
Lc2GA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2GC_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2GB:
	jmp *(%rbx)
Lc2GE:
	jmp *-16(%r13)
	.long  _r2jB_info - _r2jB_info_dsp
.data
.align 3
.align 0
_r2jC_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2jB_closure
	.quad	0
.data
.align 3
.align 0
_r2jD_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2jE_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2jD_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jF_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2jA_closure+2
	.quad	_r2jC_closure+1
	.quad	_r2jE_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jG_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2jF_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jH_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2jy_closure+2
	.quad	_r2jG_closure+3
	.quad	0
.data
.align 3
.align 0
_r2jI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jw_closure+1
	.quad	_r2jI_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jl_closure+1
	.quad	_r2jJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jL_closure:
	.quad	_r2jL_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Hb_str:
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_r2jL_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jL_info)+0
	.quad	0
	.quad	4294967318
_r2jL_info:
Lc2Hc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hd
Lc2He:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ha
Lc2H9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Hb_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ha:
	jmp *(%rbx)
Lc2Hd:
	jmp *-16(%r13)
	.long  _r2jL_info - _r2jL_info_dsp
.data
.align 3
.align 0
_r2jM_closure:
	.quad	_r2jM_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Hs_str:
	.byte	116
	.byte	50
	.byte	0
.text
.align 3
_r2jM_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jM_info)+0
	.quad	0
	.quad	4294967318
_r2jM_info:
Lc2Ht:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hu
Lc2Hv:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Hr
Lc2Hq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Hs_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Hr:
	jmp *(%rbx)
Lc2Hu:
	jmp *-16(%r13)
	.long  _r2jM_info - _r2jM_info_dsp
.data
.align 3
.align 0
_r2jN_closure:
	.quad	_r2jN_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2HJ_str:
	.byte	116
	.byte	51
	.byte	0
.text
.align 3
_r2jN_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jN_info)+0
	.quad	0
	.quad	4294967318
_r2jN_info:
Lc2HK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HL
Lc2HM:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2HI
Lc2HH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2HJ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2HI:
	jmp *(%rbx)
Lc2HL:
	jmp *-16(%r13)
	.long  _r2jN_info - _r2jN_info_dsp
.data
.align 3
.align 0
_r2jO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jN_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jM_closure
	.quad	_r2jO_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jL_closure
	.quad	_r2jP_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jR_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r2ja_closure+1
	.quad	_r2jK_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r2jQ_closure+2
	.quad	_F95VarDecl_Read_closure+1
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2jR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2jT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2j8_closure+1
	.quad	_r2jS_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ik_closure+1
	.quad	_r2jT_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure
_F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2hE_closure+1
	.quad	_r2jU_closure+2
	.quad	0
.data
.align 3
.align 0
_r2jV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2jW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Out_closure+2
	.quad	_r2jV_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_intentzuparserzutests_closure
_F95ArgDeclParserTestRefs_intentzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_In_closure+1
	.quad	_r2jW_closure+2
	.quad	1
.data
.align 3
.align 0
_r2jX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2jY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Write_closure+2
	.quad	_r2jX_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure
_F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Read_closure+1
	.quad	_r2jY_closure+2
	.quad	1
.data
.align 3
.align 0
_r2jZ_closure:
	.quad	_r2jZ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Is_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2jZ_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2jZ_info)+0
	.quad	0
	.quad	4294967318
_r2jZ_info:
Lc2It:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Iu
Lc2Iv:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ir
Lc2Iq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Is_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ir:
	jmp *(%rbx)
Lc2Iu:
	jmp *-16(%r13)
	.long  _r2jZ_info - _r2jZ_info_dsp
.data
.align 3
.align 0
_r2k0_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2jZ_closure
	.quad	0
.data
.align 3
.align 0
_r2k1_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	5
.data
.align 3
.align 0
_r2k2_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2k1_closure+1
	.quad	0
.data
.align 3
.align 0
_r2k3_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2k0_closure+1
	.quad	_r2k2_closure+2
	.quad	0
.data
.align 3
.align 0
_r2k4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2k5_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2k4_closure+1
	.quad	0
.data
.align 3
.align 0
_r2k6_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2k7_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2k6_closure+1
	.quad	0
.data
.align 3
.align 0
_r2k8_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2k5_closure+2
	.quad	_r2k7_closure+2
	.quad	0
.data
.align 3
.align 0
_r2k9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2ka_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2k9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kb_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2kc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kb_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kd_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kc_closure+2
	.quad	1
.data
.align 3
.align 0
_r2ke_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2ka_closure+2
	.quad	_r2kd_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kf_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2kg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kf_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kh_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kg_closure+2
	.quad	1
.data
.align 3
.align 0
_r2ki_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2kj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ki_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kk_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kj_closure+2
	.quad	1
.data
.align 3
.align 0
_r2kl_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2kh_closure+1
	.quad	_r2kk_closure+1
	.quad	1
.data
.align 3
.align 0
_r2km_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2kn_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2km_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ko_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2kp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ko_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kq_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2kn_closure+2
	.quad	_r2kp_closure+2
	.quad	0
.data
.align 3
.align 0
_r2kr_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2kq_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ks_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2kt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ks_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ku_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2kv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ku_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kw_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kv_closure+2
	.quad	1
.data
.align 3
.align 0
_r2kx_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ky_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2kx_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kz_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2kt_closure+2
	.quad	_r2kw_closure+1
	.quad	_r2ky_closure+2
	.quad	0
.data
.align 3
.align 0
_r2kA_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2kz_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kB_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2kr_closure+4
	.quad	_r2kA_closure+3
	.quad	0
.data
.align 3
.align 0
_r2kC_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kB_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kl_closure+1
	.quad	_r2kC_closure+2
	.quad	0
.data
.align 3
.align 0
_r2kE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ke_closure+1
	.quad	_r2kD_closure+2
	.quad	0
.data
.align 3
.align 0
_r2kF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2k8_closure+1
	.quad	_r2kE_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuexprzutests_closure
_F95ArgDeclParserTestRefs_rangezuexprzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2k3_closure+1
	.quad	_r2kF_closure+2
	.quad	0
.data
.align 3
.align 0
_r2kG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2kH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2kG_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2kJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2kI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2kH_closure+2
	.quad	_r2kJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2kL_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2kM_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2kL_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kN_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2kO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kP_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kO_closure+2
	.quad	1
.data
.align 3
.align 0
_r2kQ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2kM_closure+2
	.quad	_r2kP_closure+1
	.quad	0
.data
.align 3
.align 0
_r2kR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2kS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kT_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kS_closure+2
	.quad	1
.data
.align 3
.align 0
_r2kU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2kV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kW_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2kV_closure+2
	.quad	1
.data
.align 3
.align 0
_r2kX_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2kT_closure+1
	.quad	_r2kW_closure+1
	.quad	1
.data
.align 3
.align 0
_r2kY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2kZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2l0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2l1_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2l0_closure+1
	.quad	0
.data
.align 3
.align 0
_r2l2_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2kZ_closure+2
	.quad	_r2l1_closure+2
	.quad	0
.data
.align 3
.align 0
_r2l3_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2l2_closure+1
	.quad	0
.data
.align 3
.align 0
_r2l4_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2l5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2l4_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2l6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2l7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2l6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2l8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2l7_closure+2
	.quad	1
.data
.align 3
.align 0
_r2l9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2la_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2l9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lb_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2l5_closure+2
	.quad	_r2l8_closure+1
	.quad	_r2la_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lc_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2lb_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ld_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2l3_closure+4
	.quad	_r2lc_closure+3
	.quad	0
.data
.align 3
.align 0
_r2le_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2lf_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2le_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2lh_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2lg_closure+1
	.quad	0
.data
.align 3
.align 0
_r2li_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2lf_closure+2
	.quad	_r2lh_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2lk_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2lj_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ll_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2lm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ll_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ln_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2lm_closure+2
	.quad	1
.data
.align 3
.align 0
_r2lo_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2lk_closure+2
	.quad	_r2ln_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lp_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2lq_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2lp_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lr_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2ls_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lr_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2lt_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2lu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lt_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2lv_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2lu_closure+2
	.quad	1
.data
.align 3
.align 0
_r2lw_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2lx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lw_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ly_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2lx_closure+2
	.quad	1
.data
.align 3
.align 0
_r2lz_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2ls_closure+2
	.quad	_r2lv_closure+1
	.quad	_r2ly_closure+1
	.quad	1
.data
.align 3
.align 0
_r2lA_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2lz_closure+1
	.quad	1
.data
.align 3
.align 0
_r2lB_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2lq_closure+2
	.quad	_r2lA_closure+3
	.quad	0
.data
.align 3
.align 0
_r2lC_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2lD_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2lC_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lE_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2lF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lE_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2lG_closure:
	.quad	_r2lG_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2M7_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2lG_info_dsp:
.text
.align 3
	.quad	_S2mJ_srt-(_r2lG_info)+0
	.quad	0
	.quad	4294967318
_r2lG_info:
Lc2M8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2M9
Lc2Ma:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2M6
Lc2M5:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2M7_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2M6:
	jmp *(%rbx)
Lc2M9:
	jmp *-16(%r13)
	.long  _r2lG_info - _r2lG_info_dsp
.data
.align 3
.align 0
_r2lH_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2lG_closure
	.quad	0
.data
.align 3
.align 0
_r2lI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2lJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2lI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lK_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2lF_closure+2
	.quad	_r2lH_closure+1
	.quad	_r2lJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lL_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2lK_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lM_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2lD_closure+2
	.quad	_r2lL_closure+3
	.quad	0
.data
.align 3
.align 0
_r2lN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lM_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lB_closure+1
	.quad	_r2lN_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lo_closure+1
	.quad	_r2lO_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2li_closure+1
	.quad	_r2lP_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ld_closure+1
	.quad	_r2lQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kX_closure+1
	.quad	_r2lR_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kQ_closure+1
	.quad	_r2lS_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuparserzutests_closure
_F95ArgDeclParserTestRefs_rangezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2kK_closure+1
	.quad	_r2lT_closure+2
	.quad	0
.data
.align 3
.align 0
_r2lU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r2lV_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r2lU_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r2lX_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r2lW_closure+1
	.quad	0
.data
.align 3
.align 0
_r2lY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r2lZ_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r2lY_closure+1
	.quad	0
.data
.align 3
.align 0
_r2m0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r2m1_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r2m0_closure+1
	.quad	0
.data
.align 3
.align 0
_r2m2_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r2m3_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r2m2_closure+1
	.quad	0
.data
.align 3
.align 0
_r2m4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2m3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2m5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2m1_closure+1
	.quad	_r2m4_closure+2
	.quad	0
.data
.align 3
.align 0
_r2m6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lZ_closure+1
	.quad	_r2m5_closure+2
	.quad	0
.data
.align 3
.align 0
_r2m7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lX_closure+1
	.quad	_r2m6_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_typezuparserzutests_closure
_F95ArgDeclParserTestRefs_typezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2lV_closure+1
	.quad	_r2m7_closure+2
	.quad	0
.const_data
.align 3
.align 0
_S2mJ_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

