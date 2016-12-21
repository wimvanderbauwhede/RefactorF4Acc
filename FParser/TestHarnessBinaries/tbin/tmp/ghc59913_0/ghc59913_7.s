.data
.align 3
.align 0
.globl ___stginit_F95ArgDeclParserTestRefs
___stginit_F95ArgDeclParserTestRefs:
.data
.align 3
.align 0
_r1Al_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Kg_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Al_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Kh_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ki_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Kh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Kj_closure:
	.quad	_r1Kj_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Tx_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Kj_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Kj_info)+0
	.quad	0
	.quad	4294967318
_r1Kj_info:
Lc1Ty:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Tz
Lc1TA:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Tw
Lc1Tv:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Tx_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Tw:
	jmp *(%rbx)
Lc1Tz:
	jmp *-16(%r13)
	.long  _r1Kj_info - _r1Kj_info_dsp
.data
.align 3
.align 0
_r1Kk_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Kj_closure
	.quad	0
.data
.align 3
.align 0
_r1Kl_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ki_closure+2
	.quad	_r1Kk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Km_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Kn_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Km_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ko_closure:
	.quad	_r1Ko_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1TX_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Ko_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Ko_info)+0
	.quad	0
	.quad	4294967318
_r1Ko_info:
Lc1TY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1TZ
Lc1U0:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1TW
Lc1TV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1TX_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1TW:
	jmp *(%rbx)
Lc1TZ:
	jmp *-16(%r13)
	.long  _r1Ko_info - _r1Ko_info_dsp
.data
.align 3
.align 0
_r1Kp_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ko_closure
	.quad	0
.data
.align 3
.align 0
_r1Kq_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Kn_closure+2
	.quad	_r1Kp_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Kr_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ks_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Kr_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Kt_closure:
	.quad	_r1Kt_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Um_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Kt_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Kt_info)+0
	.quad	0
	.quad	4294967318
_r1Kt_info:
Lc1Un:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Uo
Lc1Up:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ul
Lc1Uk:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Um_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Ul:
	jmp *(%rbx)
Lc1Uo:
	jmp *-16(%r13)
	.long  _r1Kt_info - _r1Kt_info_dsp
.data
.align 3
.align 0
_r1Ku_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Kt_closure
	.quad	0
.data
.align 3
.align 0
_r1Kv_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ks_closure+2
	.quad	_r1Ku_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Kw_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Kv_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Kx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Kq_closure+1
	.quad	_r1Kw_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ky_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Kl_closure+1
	.quad	_r1Kx_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Kz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1KA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Kz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1KB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1KA_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1KC_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Kg_closure+1
	.quad	_r1Ky_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1KB_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KD_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1KE_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1KD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KF_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1KG_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1KF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KH_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1KI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1KH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1KJ_closure:
	.quad	_r1KJ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1V7_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1KJ_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1KJ_info)+0
	.quad	0
	.quad	4294967318
_r1KJ_info:
Lc1V8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1V9
Lc1Va:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1V6
Lc1V5:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1V7_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1V6:
	jmp *(%rbx)
Lc1V9:
	jmp *-16(%r13)
	.long  _r1KJ_info - _r1KJ_info_dsp
.data
.align 3
.align 0
_r1KK_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1KJ_closure
	.quad	0
.data
.align 3
.align 0
_r1KL_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1KM_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1KL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KN_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1KI_closure+2
	.quad	_r1KK_closure+1
	.quad	_r1KM_closure+2
	.quad	0
.data
.align 3
.align 0
_r1KO_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1KN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KP_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1KG_closure+2
	.quad	_r1KO_closure+3
	.quad	0
.data
.align 3
.align 0
_r1KQ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1KR_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1KQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KS_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1KT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1KS_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1KU_closure:
	.quad	_r1KU_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1VI_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1KU_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1KU_info)+0
	.quad	0
	.quad	4294967318
_r1KU_info:
Lc1VJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1VK
Lc1VL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1VH
Lc1VG:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1VI_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1VH:
	jmp *(%rbx)
Lc1VK:
	jmp *-16(%r13)
	.long  _r1KU_info - _r1KU_info_dsp
.data
.align 3
.align 0
_r1KV_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1KU_closure
	.quad	0
.data
.align 3
.align 0
_r1KW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1KX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1KW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1KY_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1KT_closure+2
	.quad	_r1KV_closure+1
	.quad	_r1KX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1KZ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1KY_closure+1
	.quad	0
.data
.align 3
.align 0
_r1L0_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1KR_closure+2
	.quad	_r1KZ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1L1_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1L2_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1L1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1L3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1L4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1L3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1L5_closure:
	.quad	_r1L5_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Wj_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1L5_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1L5_info)+0
	.quad	0
	.quad	4294967318
_r1L5_info:
Lc1Wk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Wl
Lc1Wm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Wi
Lc1Wh:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Wj_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Wi:
	jmp *(%rbx)
Lc1Wl:
	jmp *-16(%r13)
	.long  _r1L5_info - _r1L5_info_dsp
.data
.align 3
.align 0
_r1L6_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1L5_closure
	.quad	0
.data
.align 3
.align 0
_r1L7_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1L8_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1L7_closure+1
	.quad	0
.data
.align 3
.align 0
_r1L9_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1L4_closure+2
	.quad	_r1L6_closure+1
	.quad	_r1L8_closure+2
	.quad	0
.data
.align 3
.align 0
_r1La_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1L9_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Lb_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1L2_closure+2
	.quad	_r1La_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Lc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Lb_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ld_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1L0_closure+1
	.quad	_r1Lc_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Le_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1KP_closure+1
	.quad	_r1Ld_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Lf_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1Lg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Lf_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Lh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Lg_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Li_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1KE_closure+1
	.quad	_r1Le_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1Lh_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Lj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Lk_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Lj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ll_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Lm_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ll_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ln_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Lo_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ln_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Lp_closure:
	.quad	_r1Lp_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Xc_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Lp_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Lp_info)+0
	.quad	0
	.quad	4294967318
_r1Lp_info:
Lc1Xd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Xe
Lc1Xf:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Xb
Lc1Xa:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Xc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Xb:
	jmp *(%rbx)
Lc1Xe:
	jmp *-16(%r13)
	.long  _r1Lp_info - _r1Lp_info_dsp
.data
.align 3
.align 0
_r1Lq_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Lp_closure
	.quad	0
.data
.align 3
.align 0
_r1Lr_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ls_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Lr_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Lt_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Lo_closure+2
	.quad	_r1Lq_closure+1
	.quad	_r1Ls_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Lu_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Lt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Lv_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Lm_closure+2
	.quad	_r1Lu_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Lw_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Lx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Lw_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ly_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Lz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ly_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LA_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Lx_closure+2
	.quad	_r1Lz_closure+2
	.quad	0
.data
.align 3
.align 0
_r1LB_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1LA_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1LD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1LC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1LE_closure:
	.quad	_r1LE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1XV_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1LE_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1LE_info)+0
	.quad	0
	.quad	4294967318
_r1LE_info:
Lc1XW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1XX
Lc1XY:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1XU
Lc1XT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1XV_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1XU:
	jmp *(%rbx)
Lc1XX:
	jmp *-16(%r13)
	.long  _r1LE_info - _r1LE_info_dsp
.data
.align 3
.align 0
_r1LF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1LE_closure
	.quad	0
.data
.align 3
.align 0
_r1LG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1LH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1LG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LI_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1LD_closure+2
	.quad	_r1LF_closure+1
	.quad	_r1LH_closure+2
	.quad	0
.data
.align 3
.align 0
_r1LJ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1LI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1LB_closure+4
	.quad	_r1LJ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1LL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1LM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1LL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1LN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1LO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1LN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LP_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1LM_closure+2
	.quad	_r1LO_closure+2
	.quad	0
.data
.align 3
.align 0
_r1LQ_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1LP_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1LS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1LR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1LT_closure:
	.quad	_r1LT_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1YE_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1LT_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1LT_info)+0
	.quad	0
	.quad	4294967318
_r1LT_info:
Lc1YF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1YG
Lc1YH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1YD
Lc1YC:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1YE_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1YD:
	jmp *(%rbx)
Lc1YG:
	jmp *-16(%r13)
	.long  _r1LT_info - _r1LT_info_dsp
.data
.align 3
.align 0
_r1LU_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1LT_closure
	.quad	0
.data
.align 3
.align 0
_r1LV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1LW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1LV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LX_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1LS_closure+2
	.quad	_r1LU_closure+1
	.quad	_r1LW_closure+2
	.quad	0
.data
.align 3
.align 0
_r1LY_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1LX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1LZ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1LQ_closure+4
	.quad	_r1LY_closure+3
	.quad	0
.data
.align 3
.align 0
_r1M0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1LZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1M1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1LK_closure+1
	.quad	_r1M0_closure+2
	.quad	0
.data
.align 3
.align 0
_r1M2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Lv_closure+1
	.quad	_r1M1_closure+2
	.quad	0
.data
.align 3
.align 0
_r1M3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1M4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1M3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1M5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1M4_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1M6_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Lk_closure+1
	.quad	_r1M2_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1M5_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1M7_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1M8_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1M7_closure+1
	.quad	0
.data
.align 3
.align 0
_r1M9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Ma_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1M9_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Mb_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Mc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Mb_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Md_closure:
	.quad	_r1Md_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Zx_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Md_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Md_info)+0
	.quad	0
	.quad	4294967318
_r1Md_info:
Lc1Zy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Zz
Lc1ZA:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Zw
Lc1Zv:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Zx_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Zw:
	jmp *(%rbx)
Lc1Zz:
	jmp *-16(%r13)
	.long  _r1Md_info - _r1Md_info_dsp
.data
.align 3
.align 0
_r1Me_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Md_closure
	.quad	0
.data
.align 3
.align 0
_r1Mf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Mg_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Mf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Mh_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Mc_closure+2
	.quad	_r1Me_closure+1
	.quad	_r1Mg_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Mi_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Mh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Mj_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ma_closure+2
	.quad	_r1Mi_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Mk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Ml_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Mk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Mm_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Mn_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Mm_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Mo_closure:
	.quad	_r1Mo_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c208_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Mo_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Mo_info)+0
	.quad	0
	.quad	4294967318
_r1Mo_info:
Lc209:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc20a
Lc20b:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc207
Lc206:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c208_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc207:
	jmp *(%rbx)
Lc20a:
	jmp *-16(%r13)
	.long  _r1Mo_info - _r1Mo_info_dsp
.data
.align 3
.align 0
_r1Mp_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Mo_closure
	.quad	0
.data
.align 3
.align 0
_r1Mq_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Mr_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Mq_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ms_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Mn_closure+2
	.quad	_r1Mp_closure+1
	.quad	_r1Mr_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Mt_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Ms_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Mu_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ml_closure+2
	.quad	_r1Mt_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Mv_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Mw_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Mv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Mx_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1My_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Mx_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Mz_closure:
	.quad	_r1Mz_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c20J_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Mz_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Mz_info)+0
	.quad	0
	.quad	4294967318
_r1Mz_info:
Lc20K:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc20L
Lc20M:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc20I
Lc20H:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c20J_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc20I:
	jmp *(%rbx)
Lc20L:
	jmp *-16(%r13)
	.long  _r1Mz_info - _r1Mz_info_dsp
.data
.align 3
.align 0
_r1MA_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Mz_closure
	.quad	0
.data
.align 3
.align 0
_r1MB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1MC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1MB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1MD_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1My_closure+2
	.quad	_r1MA_closure+1
	.quad	_r1MC_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ME_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1MD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1MF_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Mw_closure+2
	.quad	_r1ME_closure+3
	.quad	0
.data
.align 3
.align 0
_r1MG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1MH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Mu_closure+1
	.quad	_r1MG_closure+2
	.quad	0
.data
.align 3
.align 0
_r1MI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Mj_closure+1
	.quad	_r1MH_closure+2
	.quad	0
.data
.align 3
.align 0
_r1MJ_closure:
	.quad	_r1MJ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c21i_str:
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_r1MJ_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1MJ_info)+0
	.quad	0
	.quad	4294967318
_r1MJ_info:
Lc21j:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc21k
Lc21l:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc21h
Lc21g:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c21i_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc21h:
	jmp *(%rbx)
Lc21k:
	jmp *-16(%r13)
	.long  _r1MJ_info - _r1MJ_info_dsp
.data
.align 3
.align 0
_r1MK_closure:
	.quad	_r1MK_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c21z_str:
	.byte	116
	.byte	50
	.byte	0
.text
.align 3
_r1MK_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1MK_info)+0
	.quad	0
	.quad	4294967318
_r1MK_info:
Lc21A:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc21B
Lc21C:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc21y
Lc21x:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c21z_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc21y:
	jmp *(%rbx)
Lc21B:
	jmp *-16(%r13)
	.long  _r1MK_info - _r1MK_info_dsp
.data
.align 3
.align 0
_r1ML_closure:
	.quad	_r1ML_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c21Q_str:
	.byte	116
	.byte	51
	.byte	0
.text
.align 3
_r1ML_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1ML_info)+0
	.quad	0
	.quad	4294967318
_r1ML_info:
Lc21R:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc21S
Lc21T:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc21P
Lc21O:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c21Q_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc21P:
	jmp *(%rbx)
Lc21S:
	jmp *-16(%r13)
	.long  _r1ML_info - _r1ML_info_dsp
.data
.align 3
.align 0
_r1MM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ML_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1MN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MK_closure
	.quad	_r1MM_closure+2
	.quad	0
.data
.align 3
.align 0
_r1MO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MJ_closure
	.quad	_r1MN_closure+2
	.quad	0
.data
.align 3
.align 0
_r1MP_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1M8_closure+1
	.quad	_r1MI_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1MO_closure+2
	.quad	_F95VarDecl_Read_closure+1
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1MQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MP_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1MR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1M6_closure+1
	.quad	_r1MQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1MS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Li_closure+1
	.quad	_r1MR_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure
_F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1KC_closure+1
	.quad	_r1MS_closure+2
	.quad	0
.data
.align 3
.align 0
_r1MT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1MU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Write_closure+2
	.quad	_r1MT_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure
_F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Read_closure+1
	.quad	_r1MU_closure+2
	.quad	1
.data
.align 3
.align 0
_r1MV_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	112
.data
.align 3
.align 0
_r1MW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MV_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1MX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MW_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1MY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1MZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1N0_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1N1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1N2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1N3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1N4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N3_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1N5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N1_closure+2
	.quad	_r1N4_closure+2
	.quad	1
.data
.align 3
.align 0
_r1N6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MZ_closure+2
	.quad	_r1N5_closure+2
	.quad	1
.data
.align 3
.align 0
_r1N7_closure:
	.quad	_r1N7_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c22R_str:
	.byte	102
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1N7_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1N7_info)+0
	.quad	0
	.quad	4294967318
_r1N7_info:
Lc22S:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc22T
Lc22U:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc22Q
Lc22P:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c22R_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc22Q:
	jmp *(%rbx)
Lc22T:
	jmp *-16(%r13)
	.long  _r1N7_info - _r1N7_info_dsp
.data
.align 3
.align 0
_r1N8_closure:
	.quad	_r1N8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c238_str:
	.byte	103
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1N8_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1N8_info)+0
	.quad	0
	.quad	4294967318
_r1N8_info:
Lc239:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23a
Lc23b:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc237
Lc236:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c238_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc237:
	jmp *(%rbx)
Lc23a:
	jmp *-16(%r13)
	.long  _r1N8_info - _r1N8_info_dsp
.data
.align 3
.align 0
_r1N9_closure:
	.quad	_r1N9_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c23p_str:
	.byte	104
	.byte	52
	.byte	50
	.byte	0
.text
.align 3
_r1N9_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1N9_info)+0
	.quad	0
	.quad	4294967318
_r1N9_info:
Lc23q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23r
Lc23s:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc23o
Lc23n:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c23p_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc23o:
	jmp *(%rbx)
Lc23r:
	jmp *-16(%r13)
	.long  _r1N9_info - _r1N9_info_dsp
.data
.align 3
.align 0
_r1Na_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N9_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N8_closure
	.quad	_r1Na_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Nc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N7_closure
	.quad	_r1Nb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Nd_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Nc_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ne_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1N6_closure+2
	.quad	_r1Nd_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_arglistzuparserzutests_closure
_F95ArgDeclParserTestRefs_arglistzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1MX_closure+2
	.quad	_r1Ne_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Nf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Ng_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Nf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nh_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Ni_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Nh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Nk_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1Nj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nl_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1Nm_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1Nl_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nn_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1No_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Nn_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Np_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1No_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Nm_closure+1
	.quad	_r1Np_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Nr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Nk_closure+1
	.quad	_r1Nq_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ns_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ni_closure+1
	.quad	_r1Nr_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_typezuparserzutests_closure
_F95ArgDeclParserTestRefs_typezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ng_closure+1
	.quad	_r1Ns_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Nt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Nu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Out_closure+2
	.quad	_r1Nt_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_intentzuparserzutests_closure
_F95ArgDeclParserTestRefs_intentzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_In_closure+1
	.quad	_r1Nu_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Nv_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Nw_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Nv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Nx_closure:
	.quad	_r1Nx_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c24w_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Nx_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Nx_info)+0
	.quad	0
	.quad	4294967318
_r1Nx_info:
Lc24x:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc24y
Lc24z:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc24v
Lc24u:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c24w_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc24v:
	jmp *(%rbx)
Lc24y:
	jmp *-16(%r13)
	.long  _r1Nx_info - _r1Nx_info_dsp
.data
.align 3
.align 0
_r1Ny_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Nx_closure
	.quad	0
.data
.align 3
.align 0
_r1Nz_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Nw_closure+2
	.quad	_r1Ny_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Nz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1NC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1NB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ND_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1NE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ND_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1NF_closure:
	.quad	_r1NF_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c251_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1NF_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1NF_info)+0
	.quad	0
	.quad	4294967318
_r1NF_info:
Lc252:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc253
Lc254:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc250
Lc24Z:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c251_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc250:
	jmp *(%rbx)
Lc253:
	jmp *-16(%r13)
	.long  _r1NF_info - _r1NF_info_dsp
.data
.align 3
.align 0
_r1NG_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1NF_closure
	.quad	0
.data
.align 3
.align 0
_r1NH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1NI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1NH_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NJ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1NE_closure+2
	.quad	_r1NG_closure+1
	.quad	_r1NI_closure+2
	.quad	0
.data
.align 3
.align 0
_r1NK_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1NJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NL_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1NC_closure+2
	.quad	_r1NK_closure+3
	.quad	0
.data
.align 3
.align 0
_r1NM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1NO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1NN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NP_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1NQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NP_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1NR_closure:
	.quad	_r1NR_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c25E_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1NR_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1NR_info)+0
	.quad	0
	.quad	4294967318
_r1NR_info:
Lc25F:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc25G
Lc25H:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc25D
Lc25C:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c25E_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc25D:
	jmp *(%rbx)
Lc25G:
	jmp *-16(%r13)
	.long  _r1NR_info - _r1NR_info_dsp
.data
.align 3
.align 0
_r1NS_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1NR_closure
	.quad	0
.data
.align 3
.align 0
_r1NT_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1NU_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1NT_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NV_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1NQ_closure+2
	.quad	_r1NS_closure+1
	.quad	_r1NU_closure+2
	.quad	0
.data
.align 3
.align 0
_r1NW_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1NV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NX_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1NO_closure+2
	.quad	_r1NW_closure+3
	.quad	0
.data
.align 3
.align 0
_r1NY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NX_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1NZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1O0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1O1_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1O2_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1O1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1O3_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1O0_closure+2
	.quad	_r1O2_closure+2
	.quad	0
.data
.align 3
.align 0
_r1O4_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1O3_closure+1
	.quad	0
.data
.align 3
.align 0
_r1O5_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1O6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1O5_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1O7_closure:
	.quad	_r1O7_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c26p_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1O7_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1O7_info)+0
	.quad	0
	.quad	4294967318
_r1O7_info:
Lc26q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc26r
Lc26s:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc26o
Lc26n:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c26p_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc26o:
	jmp *(%rbx)
Lc26r:
	jmp *-16(%r13)
	.long  _r1O7_info - _r1O7_info_dsp
.data
.align 3
.align 0
_r1O8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1O7_closure
	.quad	0
.data
.align 3
.align 0
_r1O9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Oa_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1O9_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ob_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1O6_closure+2
	.quad	_r1O8_closure+1
	.quad	_r1Oa_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Oc_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Ob_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Od_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1O4_closure+4
	.quad	_r1Oc_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Oe_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Od_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Of_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Og_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Of_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Oh_closure:
	.quad	_r1Oh_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c26Y_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Oh_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Oh_info)+0
	.quad	0
	.quad	4294967318
_r1Oh_info:
Lc26Z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc270
Lc271:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc26X
Lc26W:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c26Y_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc26X:
	jmp *(%rbx)
Lc270:
	jmp *-16(%r13)
	.long  _r1Oh_info - _r1Oh_info_dsp
.data
.align 3
.align 0
_r1Oi_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Oh_closure
	.quad	0
.data
.align 3
.align 0
_r1Oj_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Og_closure+2
	.quad	_r1Oi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ok_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ol_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ok_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Om_closure:
	.quad	_r1Om_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c27n_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Om_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Om_info)+0
	.quad	0
	.quad	4294967318
_r1Om_info:
Lc27o:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc27p
Lc27q:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc27m
Lc27l:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c27n_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc27m:
	jmp *(%rbx)
Lc27p:
	jmp *-16(%r13)
	.long  _r1Om_info - _r1Om_info_dsp
.data
.align 3
.align 0
_r1On_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Om_closure
	.quad	0
.data
.align 3
.align 0
_r1Oo_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ol_closure+2
	.quad	_r1On_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Op_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Oq_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Op_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Or_closure:
	.quad	_r1Or_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c27M_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Or_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Or_info)+0
	.quad	0
	.quad	4294967318
_r1Or_info:
Lc27N:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc27O
Lc27P:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc27L
Lc27K:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c27M_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc27L:
	jmp *(%rbx)
Lc27O:
	jmp *-16(%r13)
	.long  _r1Or_info - _r1Or_info_dsp
.data
.align 3
.align 0
_r1Os_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Or_closure
	.quad	0
.data
.align 3
.align 0
_r1Ot_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Oq_closure+2
	.quad	_r1Os_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ou_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ot_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ov_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Oo_closure+1
	.quad	_r1Ou_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ow_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Oj_closure+1
	.quad	_r1Ov_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ox_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Oy_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ox_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Oz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1OA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Oz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1OB_closure:
	.quad	_r1OB_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c28l_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1OB_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1OB_info)+0
	.quad	0
	.quad	4294967318
_r1OB_info:
Lc28m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc28n
Lc28o:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc28k
Lc28j:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c28l_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc28k:
	jmp *(%rbx)
Lc28n:
	jmp *-16(%r13)
	.long  _r1OB_info - _r1OB_info_dsp
.data
.align 3
.align 0
_r1OC_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1OB_closure
	.quad	0
.data
.align 3
.align 0
_r1OD_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1OE_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1OD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1OF_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1OA_closure+2
	.quad	_r1OC_closure+1
	.quad	_r1OE_closure+2
	.quad	0
.data
.align 3
.align 0
_r1OG_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1OF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1OH_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Oy_closure+2
	.quad	_r1OG_closure+3
	.quad	0
.data
.align 3
.align 0
_r1OI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1OJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1OI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1OK_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1OL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1OK_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1OM_closure:
	.quad	_r1OM_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c28W_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1OM_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1OM_info)+0
	.quad	0
	.quad	4294967318
_r1OM_info:
Lc28X:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc28Y
Lc28Z:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc28V
Lc28U:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c28W_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc28V:
	jmp *(%rbx)
Lc28Y:
	jmp *-16(%r13)
	.long  _r1OM_info - _r1OM_info_dsp
.data
.align 3
.align 0
_r1ON_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1OM_closure
	.quad	0
.data
.align 3
.align 0
_r1OO_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1OP_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1OO_closure+1
	.quad	0
.data
.align 3
.align 0
_r1OQ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1OL_closure+2
	.quad	_r1ON_closure+1
	.quad	_r1OP_closure+2
	.quad	0
.data
.align 3
.align 0
_r1OR_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1OQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1OS_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1OJ_closure+2
	.quad	_r1OR_closure+3
	.quad	0
.data
.align 3
.align 0
_r1OT_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1OU_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1OT_closure+1
	.quad	0
.data
.align 3
.align 0
_r1OV_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1OW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1OV_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1OX_closure:
	.quad	_r1OX_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c29x_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1OX_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1OX_info)+0
	.quad	0
	.quad	4294967318
_r1OX_info:
Lc29y:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc29z
Lc29A:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc29w
Lc29v:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c29x_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc29w:
	jmp *(%rbx)
Lc29z:
	jmp *-16(%r13)
	.long  _r1OX_info - _r1OX_info_dsp
.data
.align 3
.align 0
_r1OY_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1OX_closure
	.quad	0
.data
.align 3
.align 0
_r1OZ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1P0_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1OZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1P1_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1OW_closure+2
	.quad	_r1OY_closure+1
	.quad	_r1P0_closure+2
	.quad	0
.data
.align 3
.align 0
_r1P2_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1P1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1P3_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1OU_closure+2
	.quad	_r1P2_closure+3
	.quad	0
.data
.align 3
.align 0
_r1P4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1P3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1P5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1OS_closure+1
	.quad	_r1P4_closure+2
	.quad	0
.data
.align 3
.align 0
_r1P6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1OH_closure+1
	.quad	_r1P5_closure+2
	.quad	0
.data
.align 3
.align 0
_r1P7_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1P8_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1P7_closure+1
	.quad	0
.data
.align 3
.align 0
_r1P9_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Pa_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1P9_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Pb_closure:
	.quad	_r1Pb_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ae_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Pb_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Pb_info)+0
	.quad	0
	.quad	4294967318
_r1Pb_info:
Lc2af:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ag
Lc2ah:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ad
Lc2ac:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ae_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ad:
	jmp *(%rbx)
Lc2ag:
	jmp *-16(%r13)
	.long  _r1Pb_info - _r1Pb_info_dsp
.data
.align 3
.align 0
_r1Pc_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Pb_closure
	.quad	0
.data
.align 3
.align 0
_r1Pd_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Pe_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Pd_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Pf_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Pa_closure+2
	.quad	_r1Pc_closure+1
	.quad	_r1Pe_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Pg_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Pf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ph_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1P8_closure+2
	.quad	_r1Pg_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Pi_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Pj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Pi_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Pk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Pl_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Pk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Pm_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Pj_closure+2
	.quad	_r1Pl_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Pn_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Pm_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Po_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Pp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Po_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Pq_closure:
	.quad	_r1Pq_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2aX_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Pq_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1Pq_info)+0
	.quad	0
	.quad	4294967318
_r1Pq_info:
Lc2aY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2aZ
Lc2b0:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2aW
Lc2aV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2aX_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2aW:
	jmp *(%rbx)
Lc2aZ:
	jmp *-16(%r13)
	.long  _r1Pq_info - _r1Pq_info_dsp
.data
.align 3
.align 0
_r1Pr_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Pq_closure
	.quad	0
.data
.align 3
.align 0
_r1Ps_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Pt_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ps_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Pu_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Pp_closure+2
	.quad	_r1Pr_closure+1
	.quad	_r1Pt_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Pv_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Pu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Pw_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Pn_closure+4
	.quad	_r1Pv_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Px_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Py_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Px_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Pz_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1PA_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Pz_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PB_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Py_closure+2
	.quad	_r1PA_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PC_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1PB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PD_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1PE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1PD_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1PF_closure:
	.quad	_r1PF_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2bG_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1PF_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1PF_info)+0
	.quad	0
	.quad	4294967318
_r1PF_info:
Lc2bH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2bI
Lc2bJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2bF
Lc2bE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2bG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2bF:
	jmp *(%rbx)
Lc2bI:
	jmp *-16(%r13)
	.long  _r1PF_info - _r1PF_info_dsp
.data
.align 3
.align 0
_r1PG_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1PF_closure
	.quad	0
.data
.align 3
.align 0
_r1PH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1PI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1PH_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PJ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1PE_closure+2
	.quad	_r1PG_closure+1
	.quad	_r1PI_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PK_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1PJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PL_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1PC_closure+4
	.quad	_r1PK_closure+3
	.quad	0
.data
.align 3
.align 0
_r1PM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1PL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Pw_closure+1
	.quad	_r1PM_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ph_closure+1
	.quad	_r1PN_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1PO_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1P6_closure+2
	.quad	_r1PP_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ow_closure+2
	.quad	_r1PQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Oe_closure+2
	.quad	_r1PR_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NY_closure+2
	.quad	_r1PS_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NM_closure+2
	.quad	_r1PT_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_dimzuparserzutests_closure
_F95ArgDeclParserTestRefs_dimzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1NA_closure+2
	.quad	_r1PU_closure+2
	.quad	0
.data
.align 3
.align 0
_r1PV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1PW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1PV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PX_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1PY_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1PX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1PZ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1PW_closure+2
	.quad	_r1PY_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Q0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Q1_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Q0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Q2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Q3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Q2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Q4_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Q3_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Q5_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Q1_closure+2
	.quad	_r1Q4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Q6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Q7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Q6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Q8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Q7_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Q9_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Qa_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Q9_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Qb_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Qa_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Qc_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Q8_closure+1
	.quad	_r1Qb_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Qd_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Qe_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Qd_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Qf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Qg_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Qf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Qh_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Qe_closure+2
	.quad	_r1Qg_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Qi_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Qh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Qj_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Qk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Qj_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ql_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Qm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ql_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Qn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Qm_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Qo_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Qp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Qo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Qq_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Qk_closure+2
	.quad	_r1Qn_closure+1
	.quad	_r1Qp_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Qr_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Qq_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Qs_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Qi_closure+4
	.quad	_r1Qr_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Qt_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Qu_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Qt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Qv_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Qw_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Qv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Qx_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Qu_closure+2
	.quad	_r1Qw_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Qy_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Qz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Qy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1QA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1QB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QC_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1QB_closure+2
	.quad	1
.data
.align 3
.align 0
_r1QD_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Qz_closure+2
	.quad	_r1QC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1QE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1QF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1QE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1QG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1QH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QI_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1QJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QI_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QK_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1QJ_closure+2
	.quad	1
.data
.align 3
.align 0
_r1QL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1QM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QN_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1QM_closure+2
	.quad	1
.data
.align 3
.align 0
_r1QO_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1QH_closure+2
	.quad	_r1QK_closure+1
	.quad	_r1QN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QP_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1QO_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QQ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1QF_closure+2
	.quad	_r1QP_closure+3
	.quad	0
.data
.align 3
.align 0
_r1QR_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1QS_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1QR_closure+1
	.quad	0
.data
.align 3
.align 0
_r1QT_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1QU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QT_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1QV_closure:
	.quad	_r1QV_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2et_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1QV_info_dsp:
.text
.align 3
	.quad	_S1TB_srt-(_r1QV_info)+0
	.quad	0
	.quad	4294967318
_r1QV_info:
Lc2eu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ev
Lc2ew:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2es
Lc2er:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2et_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2es:
	jmp *(%rbx)
Lc2ev:
	jmp *-16(%r13)
	.long  _r1QV_info - _r1QV_info_dsp
.data
.align 3
.align 0
_r1QW_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1QV_closure
	.quad	0
.data
.align 3
.align 0
_r1QX_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1QY_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1QX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1QZ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1QU_closure+2
	.quad	_r1QW_closure+1
	.quad	_r1QY_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R0_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1QZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1R1_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1QS_closure+2
	.quad	_r1R0_closure+3
	.quad	0
.data
.align 3
.align 0
_r1R2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1R1_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1R3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QQ_closure+1
	.quad	_r1R2_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1QD_closure+1
	.quad	_r1R3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Qx_closure+1
	.quad	_r1R4_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Qs_closure+1
	.quad	_r1R5_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Qc_closure+1
	.quad	_r1R6_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Q5_closure+1
	.quad	_r1R7_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuparserzutests_closure
_F95ArgDeclParserTestRefs_rangezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1PZ_closure+1
	.quad	_r1R8_closure+2
	.quad	0
.data
.align 3
.align 0
_r1R9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Ra_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1R9_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Rb_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Rc_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Rb_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Rd_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ra_closure+2
	.quad	_r1Rc_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Re_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Rf_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Re_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Rg_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Rh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ri_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Rh_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Rj_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Rf_closure+2
	.quad	_r1Ri_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Rk_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Rl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rk_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Rm_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Rl_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Rn_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Ro_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rn_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Rp_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ro_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Rq_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Rm_closure+1
	.quad	_r1Rp_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Rr_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Rs_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rr_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Rt_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ru_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Rt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Rv_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Rs_closure+2
	.quad	_r1Ru_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Rw_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Rv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Rx_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Ry_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rx_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Rz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1RA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1RB_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1RA_closure+2
	.quad	1
.data
.align 3
.align 0
_r1RC_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1RD_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1RC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1RE_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Ry_closure+2
	.quad	_r1RB_closure+1
	.quad	_r1RD_closure+2
	.quad	0
.data
.align 3
.align 0
_r1RF_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1RE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1RG_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Rw_closure+4
	.quad	_r1RF_closure+3
	.quad	0
.data
.align 3
.align 0
_r1RH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1RG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1RI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rq_closure+1
	.quad	_r1RH_closure+2
	.quad	0
.data
.align 3
.align 0
_r1RJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rj_closure+1
	.quad	_r1RI_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuexprzutests_closure
_F95ArgDeclParserTestRefs_rangezuexprzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Rd_closure+1
	.quad	_r1RJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1RK_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1RL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1RK_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1RM_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1RN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1RM_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1RO_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1RN_closure+2
	.quad	1
.data
.align 3
.align 0
_r1RP_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1RQ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1RP_closure+1
	.quad	0
.data
.align 3
.align 0
_r1RR_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1RL_closure+2
	.quad	_r1RO_closure+1
	.quad	_r1RQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1RS_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1RR_closure+1
	.quad	0
.data
.align 3
.align 0
_r1RT_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1RU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1RT_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1RV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1RW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1RV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1RX_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1RY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1RX_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1RZ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1RY_closure+2
	.quad	1
.data
.align 3
.align 0
_r1S0_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1RU_closure+2
	.quad	_r1RW_closure+2
	.quad	_r1RZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1S1_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1S0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1S2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1S3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1S2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1S4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1S5_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1S4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1S6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1S7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1S6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1S8_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1S9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1S8_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Sa_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1S9_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Sb_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Sc_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Sb_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sd_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1S7_closure+2
	.quad	_r1Sa_closure+1
	.quad	_r1Sc_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Se_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Sd_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sf_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1S3_closure+2
	.quad	_r1S5_closure+2
	.quad	_r1Se_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Sg_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Sf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sh_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Si_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sh_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Sj_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1Sk_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Sj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sl_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1Sm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sl_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Sn_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1So_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sn_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Sp_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1So_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Sq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Sr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ss_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Sr_closure+2
	.quad	1
.data
.align 3
.align 0
_r1St_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Sm_closure+2
	.quad	_r1Sp_closure+1
	.quad	_r1Ss_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Su_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1St_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Sv_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Si_closure+2
	.quad	_r1Sk_closure+2
	.quad	_r1Su_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Sw_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Sv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sx_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1Sy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sx_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Sz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1SA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1SC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1SB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SD_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1SA_closure+2
	.quad	_r1SC_closure+2
	.quad	0
.data
.align 3
.align 0
_r1SE_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1SD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SF_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1SG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SH_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1SI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SJ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1SI_closure+2
	.quad	1
.data
.align 3
.align 0
_r1SK_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1SL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SK_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SM_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1SL_closure+2
	.quad	1
.data
.align 3
.align 0
_r1SN_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1SG_closure+2
	.quad	_r1SJ_closure+1
	.quad	_r1SM_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SO_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1SN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SP_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Sy_closure+2
	.quad	_r1SE_closure+4
	.quad	_r1SO_closure+3
	.quad	0
.data
.align 3
.align 0
_r1SQ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1SP_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1SS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ST_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1SU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ST_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1SW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1SV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SX_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1SY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SX_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1T0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1T1_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1T0_closure+2
	.quad	1
.data
.align 3
.align 0
_r1T2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1T3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1T2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1T4_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1T3_closure+2
	.quad	1
.data
.align 3
.align 0
_r1T5_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1SY_closure+2
	.quad	_r1T1_closure+1
	.quad	_r1T4_closure+1
	.quad	1
.data
.align 3
.align 0
_r1T6_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1T5_closure+1
	.quad	1
.data
.align 3
.align 0
_r1T7_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1SU_closure+2
	.quad	_r1SW_closure+2
	.quad	_r1T6_closure+3
	.quad	0
.data
.align 3
.align 0
_r1T8_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1T7_closure+1
	.quad	0
.data
.align 3
.align 0
_r1T9_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1SS_closure+2
	.quad	_r1T8_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Ta_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1T9_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ta_closure+4
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SQ_closure+3
	.quad	_r1Tb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Td_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sw_closure+3
	.quad	_r1Tc_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Te_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sg_closure+3
	.quad	_r1Td_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Tf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1S1_closure+3
	.quad	_r1Te_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_exprzuparserzutests_closure
_F95ArgDeclParserTestRefs_exprzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1RS_closure+3
	.quad	_r1Tf_closure+2
	.quad	0
.const_data
.align 3
.align 0
_S1TB_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

