.data
.align 3
.align 0
.globl ___stginit_F95ArgDeclParserTestRefs
___stginit_F95ArgDeclParserTestRefs:
.data
.align 3
.align 0
_r1U4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r23Z_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1U4_closure+1
	.quad	0
.data
.align 3
.align 0
_r240_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r241_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r240_closure+1
	.quad	0
.data
.align 3
.align 0
_r242_closure:
	.quad	_r242_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2dg_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r242_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r242_info)+0
	.quad	0
	.quad	4294967318
_r242_info:
Lc2dh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2di
Lc2dj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2df
Lc2de:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2dg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2df:
	jmp *(%rbx)
Lc2di:
	jmp *-16(%r13)
	.long  _r242_info - _r242_info_dsp
.data
.align 3
.align 0
_r243_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r242_closure
	.quad	0
.data
.align 3
.align 0
_r244_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r241_closure+2
	.quad	_r243_closure+1
	.quad	0
.data
.align 3
.align 0
_r245_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r246_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r245_closure+1
	.quad	0
.data
.align 3
.align 0
_r247_closure:
	.quad	_r247_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2dG_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r247_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r247_info)+0
	.quad	0
	.quad	4294967318
_r247_info:
Lc2dH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2dI
Lc2dJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2dF
Lc2dE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2dG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2dF:
	jmp *(%rbx)
Lc2dI:
	jmp *-16(%r13)
	.long  _r247_info - _r247_info_dsp
.data
.align 3
.align 0
_r248_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r247_closure
	.quad	0
.data
.align 3
.align 0
_r249_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r246_closure+2
	.quad	_r248_closure+1
	.quad	0
.data
.align 3
.align 0
_r24a_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24b_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24a_closure+1
	.quad	0
.data
.align 3
.align 0
_r24c_closure:
	.quad	_r24c_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2e5_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r24c_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r24c_info)+0
	.quad	0
	.quad	4294967318
_r24c_info:
Lc2e6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2e7
Lc2e8:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2e4
Lc2e3:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2e5_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2e4:
	jmp *(%rbx)
Lc2e7:
	jmp *-16(%r13)
	.long  _r24c_info - _r24c_info_dsp
.data
.align 3
.align 0
_r24d_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r24c_closure
	.quad	0
.data
.align 3
.align 0
_r24e_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r24b_closure+2
	.quad	_r24d_closure+1
	.quad	0
.data
.align 3
.align 0
_r24f_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24e_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r24g_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r249_closure+1
	.quad	_r24f_closure+2
	.quad	0
.data
.align 3
.align 0
_r24h_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r244_closure+1
	.quad	_r24g_closure+2
	.quad	0
.data
.align 3
.align 0
_r24i_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r24j_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24i_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r24k_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24j_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r24l_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r23Z_closure+1
	.quad	_r24h_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r24k_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r24m_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r24n_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r24m_closure+1
	.quad	0
.data
.align 3
.align 0
_r24o_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24p_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24o_closure+1
	.quad	0
.data
.align 3
.align 0
_r24q_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r24r_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24q_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r24s_closure:
	.quad	_r24s_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2eQ_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r24s_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r24s_info)+0
	.quad	0
	.quad	4294967318
_r24s_info:
Lc2eR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2eS
Lc2eT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2eP
Lc2eO:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2eQ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2eP:
	jmp *(%rbx)
Lc2eS:
	jmp *-16(%r13)
	.long  _r24s_info - _r24s_info_dsp
.data
.align 3
.align 0
_r24t_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r24s_closure
	.quad	0
.data
.align 3
.align 0
_r24u_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24v_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24u_closure+1
	.quad	0
.data
.align 3
.align 0
_r24w_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r24r_closure+2
	.quad	_r24t_closure+1
	.quad	_r24v_closure+2
	.quad	0
.data
.align 3
.align 0
_r24x_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r24w_closure+1
	.quad	0
.data
.align 3
.align 0
_r24y_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r24p_closure+2
	.quad	_r24x_closure+3
	.quad	0
.data
.align 3
.align 0
_r24z_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24A_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24z_closure+1
	.quad	0
.data
.align 3
.align 0
_r24B_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r24C_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24B_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r24D_closure:
	.quad	_r24D_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2fr_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r24D_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r24D_info)+0
	.quad	0
	.quad	4294967318
_r24D_info:
Lc2fs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ft
Lc2fu:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2fq
Lc2fp:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2fr_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2fq:
	jmp *(%rbx)
Lc2ft:
	jmp *-16(%r13)
	.long  _r24D_info - _r24D_info_dsp
.data
.align 3
.align 0
_r24E_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r24D_closure
	.quad	0
.data
.align 3
.align 0
_r24F_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24G_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24F_closure+1
	.quad	0
.data
.align 3
.align 0
_r24H_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r24C_closure+2
	.quad	_r24E_closure+1
	.quad	_r24G_closure+2
	.quad	0
.data
.align 3
.align 0
_r24I_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r24H_closure+1
	.quad	0
.data
.align 3
.align 0
_r24J_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r24A_closure+2
	.quad	_r24I_closure+3
	.quad	0
.data
.align 3
.align 0
_r24K_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24L_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24K_closure+1
	.quad	0
.data
.align 3
.align 0
_r24M_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r24N_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24M_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r24O_closure:
	.quad	_r24O_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2g2_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r24O_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r24O_info)+0
	.quad	0
	.quad	4294967318
_r24O_info:
Lc2g3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2g4
Lc2g5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2g1
Lc2g0:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2g2_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2g1:
	jmp *(%rbx)
Lc2g4:
	jmp *-16(%r13)
	.long  _r24O_info - _r24O_info_dsp
.data
.align 3
.align 0
_r24P_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r24O_closure
	.quad	0
.data
.align 3
.align 0
_r24Q_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r24R_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r24Q_closure+1
	.quad	0
.data
.align 3
.align 0
_r24S_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r24N_closure+2
	.quad	_r24P_closure+1
	.quad	_r24R_closure+2
	.quad	0
.data
.align 3
.align 0
_r24T_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r24S_closure+1
	.quad	0
.data
.align 3
.align 0
_r24U_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r24L_closure+2
	.quad	_r24T_closure+3
	.quad	0
.data
.align 3
.align 0
_r24V_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24U_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r24W_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24J_closure+1
	.quad	_r24V_closure+2
	.quad	0
.data
.align 3
.align 0
_r24X_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24y_closure+1
	.quad	_r24W_closure+2
	.quad	0
.data
.align 3
.align 0
_r24Y_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r24Z_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24Y_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r250_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24Z_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r251_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r24n_closure+1
	.quad	_r24X_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r250_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r252_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r253_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r252_closure+1
	.quad	0
.data
.align 3
.align 0
_r254_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r255_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r254_closure+1
	.quad	0
.data
.align 3
.align 0
_r256_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r257_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r256_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r258_closure:
	.quad	_r258_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2gV_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r258_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r258_info)+0
	.quad	0
	.quad	4294967318
_r258_info:
Lc2gW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2gX
Lc2gY:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2gU
Lc2gT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2gV_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2gU:
	jmp *(%rbx)
Lc2gX:
	jmp *-16(%r13)
	.long  _r258_info - _r258_info_dsp
.data
.align 3
.align 0
_r259_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r258_closure
	.quad	0
.data
.align 3
.align 0
_r25a_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r25b_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25a_closure+1
	.quad	0
.data
.align 3
.align 0
_r25c_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r257_closure+2
	.quad	_r259_closure+1
	.quad	_r25b_closure+2
	.quad	0
.data
.align 3
.align 0
_r25d_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r25c_closure+1
	.quad	0
.data
.align 3
.align 0
_r25e_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r255_closure+2
	.quad	_r25d_closure+3
	.quad	0
.data
.align 3
.align 0
_r25f_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r25g_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25f_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25h_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r25i_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25h_closure+1
	.quad	0
.data
.align 3
.align 0
_r25j_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r25g_closure+2
	.quad	_r25i_closure+2
	.quad	0
.data
.align 3
.align 0
_r25k_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r25j_closure+1
	.quad	0
.data
.align 3
.align 0
_r25l_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r25m_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25l_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25n_closure:
	.quad	_r25n_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2hE_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r25n_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r25n_info)+0
	.quad	0
	.quad	4294967318
_r25n_info:
Lc2hF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2hG
Lc2hH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2hD
Lc2hC:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2hE_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2hD:
	jmp *(%rbx)
Lc2hG:
	jmp *-16(%r13)
	.long  _r25n_info - _r25n_info_dsp
.data
.align 3
.align 0
_r25o_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r25n_closure
	.quad	0
.data
.align 3
.align 0
_r25p_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r25q_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25p_closure+1
	.quad	0
.data
.align 3
.align 0
_r25r_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r25m_closure+2
	.quad	_r25o_closure+1
	.quad	_r25q_closure+2
	.quad	0
.data
.align 3
.align 0
_r25s_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r25r_closure+1
	.quad	0
.data
.align 3
.align 0
_r25t_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r25k_closure+4
	.quad	_r25s_closure+3
	.quad	0
.data
.align 3
.align 0
_r25u_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r25v_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25u_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25w_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r25x_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25w_closure+1
	.quad	0
.data
.align 3
.align 0
_r25y_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r25v_closure+2
	.quad	_r25x_closure+2
	.quad	0
.data
.align 3
.align 0
_r25z_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r25y_closure+1
	.quad	0
.data
.align 3
.align 0
_r25A_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r25B_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25A_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25C_closure:
	.quad	_r25C_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2in_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r25C_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r25C_info)+0
	.quad	0
	.quad	4294967318
_r25C_info:
Lc2io:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ip
Lc2iq:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2im
Lc2il:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2in_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2im:
	jmp *(%rbx)
Lc2ip:
	jmp *-16(%r13)
	.long  _r25C_info - _r25C_info_dsp
.data
.align 3
.align 0
_r25D_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r25C_closure
	.quad	0
.data
.align 3
.align 0
_r25E_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r25F_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25E_closure+1
	.quad	0
.data
.align 3
.align 0
_r25G_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r25B_closure+2
	.quad	_r25D_closure+1
	.quad	_r25F_closure+2
	.quad	0
.data
.align 3
.align 0
_r25H_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r25G_closure+1
	.quad	0
.data
.align 3
.align 0
_r25I_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r25z_closure+4
	.quad	_r25H_closure+3
	.quad	0
.data
.align 3
.align 0
_r25J_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25I_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r25K_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25t_closure+1
	.quad	_r25J_closure+2
	.quad	0
.data
.align 3
.align 0
_r25L_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25e_closure+1
	.quad	_r25K_closure+2
	.quad	0
.data
.align 3
.align 0
_r25M_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r25N_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25M_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25O_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25N_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25P_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r253_closure+1
	.quad	_r25L_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r25O_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r25Q_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r25R_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r25Q_closure+1
	.quad	0
.data
.align 3
.align 0
_r25S_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r25T_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25S_closure+1
	.quad	0
.data
.align 3
.align 0
_r25U_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r25V_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25U_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r25W_closure:
	.quad	_r25W_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2jg_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r25W_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r25W_info)+0
	.quad	0
	.quad	4294967318
_r25W_info:
Lc2jh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ji
Lc2jj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2jf
Lc2je:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2jg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2jf:
	jmp *(%rbx)
Lc2ji:
	jmp *-16(%r13)
	.long  _r25W_info - _r25W_info_dsp
.data
.align 3
.align 0
_r25X_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r25W_closure
	.quad	0
.data
.align 3
.align 0
_r25Y_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r25Z_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r25Y_closure+1
	.quad	0
.data
.align 3
.align 0
_r260_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r25V_closure+2
	.quad	_r25X_closure+1
	.quad	_r25Z_closure+2
	.quad	0
.data
.align 3
.align 0
_r261_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r260_closure+1
	.quad	0
.data
.align 3
.align 0
_r262_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r25T_closure+2
	.quad	_r261_closure+3
	.quad	0
.data
.align 3
.align 0
_r263_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r264_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r263_closure+1
	.quad	0
.data
.align 3
.align 0
_r265_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r266_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r265_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r267_closure:
	.quad	_r267_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2jR_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r267_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r267_info)+0
	.quad	0
	.quad	4294967318
_r267_info:
Lc2jS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2jT
Lc2jU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2jQ
Lc2jP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2jR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2jQ:
	jmp *(%rbx)
Lc2jT:
	jmp *-16(%r13)
	.long  _r267_info - _r267_info_dsp
.data
.align 3
.align 0
_r268_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r267_closure
	.quad	0
.data
.align 3
.align 0
_r269_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r26a_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r269_closure+1
	.quad	0
.data
.align 3
.align 0
_r26b_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r266_closure+2
	.quad	_r268_closure+1
	.quad	_r26a_closure+2
	.quad	0
.data
.align 3
.align 0
_r26c_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r26b_closure+1
	.quad	0
.data
.align 3
.align 0
_r26d_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r264_closure+2
	.quad	_r26c_closure+3
	.quad	0
.data
.align 3
.align 0
_r26e_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r26f_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r26e_closure+1
	.quad	0
.data
.align 3
.align 0
_r26g_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r26h_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26g_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26i_closure:
	.quad	_r26i_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ks_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r26i_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26i_info)+0
	.quad	0
	.quad	4294967318
_r26i_info:
Lc2kt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ku
Lc2kv:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2kr
Lc2kq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ks_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2kr:
	jmp *(%rbx)
Lc2ku:
	jmp *-16(%r13)
	.long  _r26i_info - _r26i_info_dsp
.data
.align 3
.align 0
_r26j_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r26i_closure
	.quad	0
.data
.align 3
.align 0
_r26k_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r26l_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r26k_closure+1
	.quad	0
.data
.align 3
.align 0
_r26m_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r26h_closure+2
	.quad	_r26j_closure+1
	.quad	_r26l_closure+2
	.quad	0
.data
.align 3
.align 0
_r26n_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r26m_closure+1
	.quad	0
.data
.align 3
.align 0
_r26o_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r26f_closure+2
	.quad	_r26n_closure+3
	.quad	0
.data
.align 3
.align 0
_r26p_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26o_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r26q_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26d_closure+1
	.quad	_r26p_closure+2
	.quad	0
.data
.align 3
.align 0
_r26r_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r262_closure+1
	.quad	_r26q_closure+2
	.quad	0
.data
.align 3
.align 0
_r26s_closure:
	.quad	_r26s_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2l1_str:
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_r26s_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26s_info)+0
	.quad	0
	.quad	4294967318
_r26s_info:
Lc2l2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2l3
Lc2l4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2l0
Lc2kZ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2l1_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2l0:
	jmp *(%rbx)
Lc2l3:
	jmp *-16(%r13)
	.long  _r26s_info - _r26s_info_dsp
.data
.align 3
.align 0
_r26t_closure:
	.quad	_r26t_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2li_str:
	.byte	116
	.byte	50
	.byte	0
.text
.align 3
_r26t_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26t_info)+0
	.quad	0
	.quad	4294967318
_r26t_info:
Lc2lj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lk
Lc2ll:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2lh
Lc2lg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2li_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2lh:
	jmp *(%rbx)
Lc2lk:
	jmp *-16(%r13)
	.long  _r26t_info - _r26t_info_dsp
.data
.align 3
.align 0
_r26u_closure:
	.quad	_r26u_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2lz_str:
	.byte	116
	.byte	51
	.byte	0
.text
.align 3
_r26u_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26u_info)+0
	.quad	0
	.quad	4294967318
_r26u_info:
Lc2lA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lB
Lc2lC:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ly
Lc2lx:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2lz_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ly:
	jmp *(%rbx)
Lc2lB:
	jmp *-16(%r13)
	.long  _r26u_info - _r26u_info_dsp
.data
.align 3
.align 0
_r26v_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26u_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r26w_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26t_closure
	.quad	_r26v_closure+2
	.quad	0
.data
.align 3
.align 0
_r26x_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26s_closure
	.quad	_r26w_closure+2
	.quad	0
.data
.align 3
.align 0
_r26y_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r25R_closure+1
	.quad	_r26r_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r26x_closure+2
	.quad	_F95VarDecl_Read_closure+1
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r26z_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26y_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r26A_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r25P_closure+1
	.quad	_r26z_closure+2
	.quad	0
.data
.align 3
.align 0
_r26B_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r251_closure+1
	.quad	_r26A_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure
_F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r24l_closure+1
	.quad	_r26B_closure+2
	.quad	0
.data
.align 3
.align 0
_r26C_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26D_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Write_closure+2
	.quad	_r26C_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure
_F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Read_closure+1
	.quad	_r26D_closure+2
	.quad	1
.data
.align 3
.align 0
_r26E_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	112
.data
.align 3
.align 0
_r26F_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26E_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26G_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26F_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26H_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r26I_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26H_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26J_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r26K_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26J_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26L_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r26M_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26L_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26N_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26M_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r26O_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26K_closure+2
	.quad	_r26N_closure+2
	.quad	1
.data
.align 3
.align 0
_r26P_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26I_closure+2
	.quad	_r26O_closure+2
	.quad	1
.data
.align 3
.align 0
_r26Q_closure:
	.quad	_r26Q_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2mA_str:
	.byte	102
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r26Q_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26Q_info)+0
	.quad	0
	.quad	4294967318
_r26Q_info:
Lc2mB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mC
Lc2mD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mz
Lc2my:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2mA_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mz:
	jmp *(%rbx)
Lc2mC:
	jmp *-16(%r13)
	.long  _r26Q_info - _r26Q_info_dsp
.data
.align 3
.align 0
_r26R_closure:
	.quad	_r26R_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2mR_str:
	.byte	103
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r26R_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26R_info)+0
	.quad	0
	.quad	4294967318
_r26R_info:
Lc2mS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mT
Lc2mU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mQ
Lc2mP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2mR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mQ:
	jmp *(%rbx)
Lc2mT:
	jmp *-16(%r13)
	.long  _r26R_info - _r26R_info_dsp
.data
.align 3
.align 0
_r26S_closure:
	.quad	_r26S_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2n8_str:
	.byte	104
	.byte	52
	.byte	50
	.byte	0
.text
.align 3
_r26S_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r26S_info)+0
	.quad	0
	.quad	4294967318
_r26S_info:
Lc2n9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2na
Lc2nb:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2n7
Lc2n6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2n8_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2n7:
	jmp *(%rbx)
Lc2na:
	jmp *-16(%r13)
	.long  _r26S_info - _r26S_info_dsp
.data
.align 3
.align 0
_r26T_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26S_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r26U_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26R_closure
	.quad	_r26T_closure+2
	.quad	0
.data
.align 3
.align 0
_r26V_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26Q_closure
	.quad	_r26U_closure+2
	.quad	0
.data
.align 3
.align 0
_r26W_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26V_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r26X_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26P_closure+2
	.quad	_r26W_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_arglistzuparserzutests_closure
_F95ArgDeclParserTestRefs_arglistzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26G_closure+2
	.quad	_r26X_closure+2
	.quad	0
.data
.align 3
.align 0
_r26Y_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r26Z_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r26Y_closure+1
	.quad	0
.data
.align 3
.align 0
_r270_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r271_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r270_closure+1
	.quad	0
.data
.align 3
.align 0
_r272_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r273_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r272_closure+1
	.quad	0
.data
.align 3
.align 0
_r274_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r275_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r274_closure+1
	.quad	0
.data
.align 3
.align 0
_r276_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r277_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r276_closure+1
	.quad	0
.data
.align 3
.align 0
_r278_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r277_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r279_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r275_closure+1
	.quad	_r278_closure+2
	.quad	0
.data
.align 3
.align 0
_r27a_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r273_closure+1
	.quad	_r279_closure+2
	.quad	0
.data
.align 3
.align 0
_r27b_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r271_closure+1
	.quad	_r27a_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_typezuparserzutests_closure
_F95ArgDeclParserTestRefs_typezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r26Z_closure+1
	.quad	_r27b_closure+2
	.quad	0
.data
.align 3
.align 0
_r27c_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r27d_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Out_closure+2
	.quad	_r27c_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_intentzuparserzutests_closure
_F95ArgDeclParserTestRefs_intentzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_In_closure+1
	.quad	_r27d_closure+2
	.quad	1
.data
.align 3
.align 0
_r27e_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27f_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27e_closure+1
	.quad	0
.data
.align 3
.align 0
_r27g_closure:
	.quad	_r27g_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2of_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r27g_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r27g_info)+0
	.quad	0
	.quad	4294967318
_r27g_info:
Lc2og:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oh
Lc2oi:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2oe
Lc2od:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2of_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2oe:
	jmp *(%rbx)
Lc2oh:
	jmp *-16(%r13)
	.long  _r27g_info - _r27g_info_dsp
.data
.align 3
.align 0
_r27h_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r27g_closure
	.quad	0
.data
.align 3
.align 0
_r27i_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r27f_closure+2
	.quad	_r27h_closure+1
	.quad	0
.data
.align 3
.align 0
_r27j_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27i_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r27k_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27l_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27k_closure+1
	.quad	0
.data
.align 3
.align 0
_r27m_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r27n_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27m_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r27o_closure:
	.quad	_r27o_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2oK_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r27o_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r27o_info)+0
	.quad	0
	.quad	4294967318
_r27o_info:
Lc2oL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oM
Lc2oN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2oJ
Lc2oI:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2oK_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2oJ:
	jmp *(%rbx)
Lc2oM:
	jmp *-16(%r13)
	.long  _r27o_info - _r27o_info_dsp
.data
.align 3
.align 0
_r27p_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r27o_closure
	.quad	0
.data
.align 3
.align 0
_r27q_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27r_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27q_closure+1
	.quad	0
.data
.align 3
.align 0
_r27s_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r27n_closure+2
	.quad	_r27p_closure+1
	.quad	_r27r_closure+2
	.quad	0
.data
.align 3
.align 0
_r27t_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r27s_closure+1
	.quad	0
.data
.align 3
.align 0
_r27u_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r27l_closure+2
	.quad	_r27t_closure+3
	.quad	0
.data
.align 3
.align 0
_r27v_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27u_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r27w_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r27x_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27w_closure+1
	.quad	0
.data
.align 3
.align 0
_r27y_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r27z_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27y_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r27A_closure:
	.quad	_r27A_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2pn_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r27A_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r27A_info)+0
	.quad	0
	.quad	4294967318
_r27A_info:
Lc2po:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pp
Lc2pq:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2pm
Lc2pl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2pn_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2pm:
	jmp *(%rbx)
Lc2pp:
	jmp *-16(%r13)
	.long  _r27A_info - _r27A_info_dsp
.data
.align 3
.align 0
_r27B_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r27A_closure
	.quad	0
.data
.align 3
.align 0
_r27C_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27D_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27C_closure+1
	.quad	0
.data
.align 3
.align 0
_r27E_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r27z_closure+2
	.quad	_r27B_closure+1
	.quad	_r27D_closure+2
	.quad	0
.data
.align 3
.align 0
_r27F_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r27E_closure+1
	.quad	0
.data
.align 3
.align 0
_r27G_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r27x_closure+2
	.quad	_r27F_closure+3
	.quad	0
.data
.align 3
.align 0
_r27H_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27G_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r27I_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r27J_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27I_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r27K_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27L_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27K_closure+1
	.quad	0
.data
.align 3
.align 0
_r27M_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r27J_closure+2
	.quad	_r27L_closure+2
	.quad	0
.data
.align 3
.align 0
_r27N_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r27M_closure+1
	.quad	0
.data
.align 3
.align 0
_r27O_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r27P_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27O_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r27Q_closure:
	.quad	_r27Q_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2q8_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r27Q_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r27Q_info)+0
	.quad	0
	.quad	4294967318
_r27Q_info:
Lc2q9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qa
Lc2qb:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2q7
Lc2q6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2q8_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2q7:
	jmp *(%rbx)
Lc2qa:
	jmp *-16(%r13)
	.long  _r27Q_info - _r27Q_info_dsp
.data
.align 3
.align 0
_r27R_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r27Q_closure
	.quad	0
.data
.align 3
.align 0
_r27S_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27T_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27S_closure+1
	.quad	0
.data
.align 3
.align 0
_r27U_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r27P_closure+2
	.quad	_r27R_closure+1
	.quad	_r27T_closure+2
	.quad	0
.data
.align 3
.align 0
_r27V_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r27U_closure+1
	.quad	0
.data
.align 3
.align 0
_r27W_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r27N_closure+4
	.quad	_r27V_closure+3
	.quad	0
.data
.align 3
.align 0
_r27X_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27W_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r27Y_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r27Z_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r27Y_closure+1
	.quad	0
.data
.align 3
.align 0
_r280_closure:
	.quad	_r280_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2qH_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r280_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r280_info)+0
	.quad	0
	.quad	4294967318
_r280_info:
Lc2qI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qJ
Lc2qK:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qG
Lc2qF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2qH_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2qG:
	jmp *(%rbx)
Lc2qJ:
	jmp *-16(%r13)
	.long  _r280_info - _r280_info_dsp
.data
.align 3
.align 0
_r281_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r280_closure
	.quad	0
.data
.align 3
.align 0
_r282_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r27Z_closure+2
	.quad	_r281_closure+1
	.quad	0
.data
.align 3
.align 0
_r283_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r284_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r283_closure+1
	.quad	0
.data
.align 3
.align 0
_r285_closure:
	.quad	_r285_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2r6_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r285_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r285_info)+0
	.quad	0
	.quad	4294967318
_r285_info:
Lc2r7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2r8
Lc2r9:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2r5
Lc2r4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2r6_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2r5:
	jmp *(%rbx)
Lc2r8:
	jmp *-16(%r13)
	.long  _r285_info - _r285_info_dsp
.data
.align 3
.align 0
_r286_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r285_closure
	.quad	0
.data
.align 3
.align 0
_r287_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r284_closure+2
	.quad	_r286_closure+1
	.quad	0
.data
.align 3
.align 0
_r288_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r289_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r288_closure+1
	.quad	0
.data
.align 3
.align 0
_r28a_closure:
	.quad	_r28a_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2rv_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r28a_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r28a_info)+0
	.quad	0
	.quad	4294967318
_r28a_info:
Lc2rw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rx
Lc2ry:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ru
Lc2rt:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2rv_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ru:
	jmp *(%rbx)
Lc2rx:
	jmp *-16(%r13)
	.long  _r28a_info - _r28a_info_dsp
.data
.align 3
.align 0
_r28b_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r28a_closure
	.quad	0
.data
.align 3
.align 0
_r28c_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r289_closure+2
	.quad	_r28b_closure+1
	.quad	0
.data
.align 3
.align 0
_r28d_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28c_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r28e_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r287_closure+1
	.quad	_r28d_closure+2
	.quad	0
.data
.align 3
.align 0
_r28f_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r282_closure+1
	.quad	_r28e_closure+2
	.quad	0
.data
.align 3
.align 0
_r28g_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28h_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28g_closure+1
	.quad	0
.data
.align 3
.align 0
_r28i_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r28j_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28i_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r28k_closure:
	.quad	_r28k_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2s4_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r28k_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r28k_info)+0
	.quad	0
	.quad	4294967318
_r28k_info:
Lc2s5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2s6
Lc2s7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2s3
Lc2s2:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2s4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2s3:
	jmp *(%rbx)
Lc2s6:
	jmp *-16(%r13)
	.long  _r28k_info - _r28k_info_dsp
.data
.align 3
.align 0
_r28l_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r28k_closure
	.quad	0
.data
.align 3
.align 0
_r28m_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28n_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28m_closure+1
	.quad	0
.data
.align 3
.align 0
_r28o_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r28j_closure+2
	.quad	_r28l_closure+1
	.quad	_r28n_closure+2
	.quad	0
.data
.align 3
.align 0
_r28p_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r28o_closure+1
	.quad	0
.data
.align 3
.align 0
_r28q_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r28h_closure+2
	.quad	_r28p_closure+3
	.quad	0
.data
.align 3
.align 0
_r28r_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28s_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28r_closure+1
	.quad	0
.data
.align 3
.align 0
_r28t_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r28u_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28t_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r28v_closure:
	.quad	_r28v_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2sF_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r28v_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r28v_info)+0
	.quad	0
	.quad	4294967318
_r28v_info:
Lc2sG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sH
Lc2sI:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sE
Lc2sD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2sF_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2sE:
	jmp *(%rbx)
Lc2sH:
	jmp *-16(%r13)
	.long  _r28v_info - _r28v_info_dsp
.data
.align 3
.align 0
_r28w_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r28v_closure
	.quad	0
.data
.align 3
.align 0
_r28x_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28y_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28x_closure+1
	.quad	0
.data
.align 3
.align 0
_r28z_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r28u_closure+2
	.quad	_r28w_closure+1
	.quad	_r28y_closure+2
	.quad	0
.data
.align 3
.align 0
_r28A_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r28z_closure+1
	.quad	0
.data
.align 3
.align 0
_r28B_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r28s_closure+2
	.quad	_r28A_closure+3
	.quad	0
.data
.align 3
.align 0
_r28C_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28D_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28C_closure+1
	.quad	0
.data
.align 3
.align 0
_r28E_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r28F_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28E_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r28G_closure:
	.quad	_r28G_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2tg_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r28G_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r28G_info)+0
	.quad	0
	.quad	4294967318
_r28G_info:
Lc2th:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ti
Lc2tj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2tf
Lc2te:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2tg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2tf:
	jmp *(%rbx)
Lc2ti:
	jmp *-16(%r13)
	.long  _r28G_info - _r28G_info_dsp
.data
.align 3
.align 0
_r28H_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r28G_closure
	.quad	0
.data
.align 3
.align 0
_r28I_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28J_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28I_closure+1
	.quad	0
.data
.align 3
.align 0
_r28K_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r28F_closure+2
	.quad	_r28H_closure+1
	.quad	_r28J_closure+2
	.quad	0
.data
.align 3
.align 0
_r28L_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r28K_closure+1
	.quad	0
.data
.align 3
.align 0
_r28M_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r28D_closure+2
	.quad	_r28L_closure+3
	.quad	0
.data
.align 3
.align 0
_r28N_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28M_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r28O_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28B_closure+1
	.quad	_r28N_closure+2
	.quad	0
.data
.align 3
.align 0
_r28P_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28q_closure+1
	.quad	_r28O_closure+2
	.quad	0
.data
.align 3
.align 0
_r28Q_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r28R_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28Q_closure+1
	.quad	0
.data
.align 3
.align 0
_r28S_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r28T_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28S_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r28U_closure:
	.quad	_r28U_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2tX_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r28U_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r28U_info)+0
	.quad	0
	.quad	4294967318
_r28U_info:
Lc2tY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tZ
Lc2u0:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2tW
Lc2tV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2tX_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2tW:
	jmp *(%rbx)
Lc2tZ:
	jmp *-16(%r13)
	.long  _r28U_info - _r28U_info_dsp
.data
.align 3
.align 0
_r28V_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r28U_closure
	.quad	0
.data
.align 3
.align 0
_r28W_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r28X_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r28W_closure+1
	.quad	0
.data
.align 3
.align 0
_r28Y_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r28T_closure+2
	.quad	_r28V_closure+1
	.quad	_r28X_closure+2
	.quad	0
.data
.align 3
.align 0
_r28Z_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r28Y_closure+1
	.quad	0
.data
.align 3
.align 0
_r290_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r28R_closure+2
	.quad	_r28Z_closure+3
	.quad	0
.data
.align 3
.align 0
_r291_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r292_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r291_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r293_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r294_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r293_closure+1
	.quad	0
.data
.align 3
.align 0
_r295_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r292_closure+2
	.quad	_r294_closure+2
	.quad	0
.data
.align 3
.align 0
_r296_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r295_closure+1
	.quad	0
.data
.align 3
.align 0
_r297_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r298_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r297_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r299_closure:
	.quad	_r299_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2uG_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r299_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r299_info)+0
	.quad	0
	.quad	4294967318
_r299_info:
Lc2uH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uI
Lc2uJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2uF
Lc2uE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2uG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2uF:
	jmp *(%rbx)
Lc2uI:
	jmp *-16(%r13)
	.long  _r299_info - _r299_info_dsp
.data
.align 3
.align 0
_r29a_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r299_closure
	.quad	0
.data
.align 3
.align 0
_r29b_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r29c_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29b_closure+1
	.quad	0
.data
.align 3
.align 0
_r29d_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r298_closure+2
	.quad	_r29a_closure+1
	.quad	_r29c_closure+2
	.quad	0
.data
.align 3
.align 0
_r29e_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r29d_closure+1
	.quad	0
.data
.align 3
.align 0
_r29f_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r296_closure+4
	.quad	_r29e_closure+3
	.quad	0
.data
.align 3
.align 0
_r29g_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r29h_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29g_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r29i_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r29j_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29i_closure+1
	.quad	0
.data
.align 3
.align 0
_r29k_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r29h_closure+2
	.quad	_r29j_closure+2
	.quad	0
.data
.align 3
.align 0
_r29l_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r29k_closure+1
	.quad	0
.data
.align 3
.align 0
_r29m_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r29n_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29m_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r29o_closure:
	.quad	_r29o_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2vp_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r29o_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r29o_info)+0
	.quad	0
	.quad	4294967318
_r29o_info:
Lc2vq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vr
Lc2vs:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2vo
Lc2vn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2vp_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vo:
	jmp *(%rbx)
Lc2vr:
	jmp *-16(%r13)
	.long  _r29o_info - _r29o_info_dsp
.data
.align 3
.align 0
_r29p_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r29o_closure
	.quad	0
.data
.align 3
.align 0
_r29q_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r29r_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29q_closure+1
	.quad	0
.data
.align 3
.align 0
_r29s_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r29n_closure+2
	.quad	_r29p_closure+1
	.quad	_r29r_closure+2
	.quad	0
.data
.align 3
.align 0
_r29t_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r29s_closure+1
	.quad	0
.data
.align 3
.align 0
_r29u_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r29l_closure+4
	.quad	_r29t_closure+3
	.quad	0
.data
.align 3
.align 0
_r29v_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29u_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r29w_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29f_closure+1
	.quad	_r29v_closure+2
	.quad	0
.data
.align 3
.align 0
_r29x_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r290_closure+1
	.quad	_r29w_closure+2
	.quad	0
.data
.align 3
.align 0
_r29y_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29x_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r29z_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28P_closure+2
	.quad	_r29y_closure+2
	.quad	0
.data
.align 3
.align 0
_r29A_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r28f_closure+2
	.quad	_r29z_closure+2
	.quad	0
.data
.align 3
.align 0
_r29B_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27X_closure+2
	.quad	_r29A_closure+2
	.quad	0
.data
.align 3
.align 0
_r29C_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27H_closure+2
	.quad	_r29B_closure+2
	.quad	0
.data
.align 3
.align 0
_r29D_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27v_closure+2
	.quad	_r29C_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_dimzuparserzutests_closure
_F95ArgDeclParserTestRefs_dimzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r27j_closure+2
	.quad	_r29D_closure+2
	.quad	0
.data
.align 3
.align 0
_r29E_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r29F_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29E_closure+1
	.quad	0
.data
.align 3
.align 0
_r29G_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r29H_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29G_closure+1
	.quad	0
.data
.align 3
.align 0
_r29I_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r29F_closure+2
	.quad	_r29H_closure+2
	.quad	0
.data
.align 3
.align 0
_r29J_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r29K_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29J_closure+1
	.quad	0
.data
.align 3
.align 0
_r29L_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r29M_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29L_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r29N_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r29M_closure+2
	.quad	1
.data
.align 3
.align 0
_r29O_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r29K_closure+2
	.quad	_r29N_closure+1
	.quad	0
.data
.align 3
.align 0
_r29P_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r29Q_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29P_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r29R_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r29Q_closure+2
	.quad	1
.data
.align 3
.align 0
_r29S_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r29T_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29S_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r29U_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r29T_closure+2
	.quad	1
.data
.align 3
.align 0
_r29V_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r29R_closure+1
	.quad	_r29U_closure+1
	.quad	1
.data
.align 3
.align 0
_r29W_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r29X_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29W_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r29Y_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r29Z_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r29Y_closure+1
	.quad	0
.data
.align 3
.align 0
_r2a0_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r29X_closure+2
	.quad	_r29Z_closure+2
	.quad	0
.data
.align 3
.align 0
_r2a1_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2a0_closure+1
	.quad	0
.data
.align 3
.align 0
_r2a2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2a3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2a2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2a4_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2a5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2a4_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2a6_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2a5_closure+2
	.quad	1
.data
.align 3
.align 0
_r2a7_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2a8_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2a7_closure+1
	.quad	0
.data
.align 3
.align 0
_r2a9_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2a3_closure+2
	.quad	_r2a6_closure+1
	.quad	_r2a8_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aa_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2a9_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ab_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2a1_closure+4
	.quad	_r2aa_closure+3
	.quad	0
.data
.align 3
.align 0
_r2ac_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ad_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ac_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ae_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2af_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ae_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ag_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2ad_closure+2
	.quad	_r2af_closure+2
	.quad	0
.data
.align 3
.align 0
_r2ah_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ai_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ah_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aj_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2ak_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2aj_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2al_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2ak_closure+2
	.quad	1
.data
.align 3
.align 0
_r2am_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2ai_closure+2
	.quad	_r2al_closure+1
	.quad	0
.data
.align 3
.align 0
_r2an_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2ao_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2an_closure+1
	.quad	0
.data
.align 3
.align 0
_r2ap_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2aq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ap_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ar_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2as_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ar_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2at_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2as_closure+2
	.quad	1
.data
.align 3
.align 0
_r2au_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2av_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2au_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2aw_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2av_closure+2
	.quad	1
.data
.align 3
.align 0
_r2ax_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2aq_closure+2
	.quad	_r2at_closure+1
	.quad	_r2aw_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ay_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2ax_closure+1
	.quad	1
.data
.align 3
.align 0
_r2az_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2ao_closure+2
	.quad	_r2ay_closure+3
	.quad	0
.data
.align 3
.align 0
_r2aA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2aB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2aA_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2aD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2aC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2aE_closure:
	.quad	_r2aE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2yc_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r2aE_info_dsp:
.text
.align 3
	.quad	_S2dk_srt-(_r2aE_info)+0
	.quad	0
	.quad	4294967318
_r2aE_info:
Lc2yd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ye
Lc2yf:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yb
Lc2ya:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2yc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2yb:
	jmp *(%rbx)
Lc2ye:
	jmp *-16(%r13)
	.long  _r2aE_info - _r2aE_info_dsp
.data
.align 3
.align 0
_r2aF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2aE_closure
	.quad	0
.data
.align 3
.align 0
_r2aG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2aH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2aG_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aI_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2aD_closure+2
	.quad	_r2aF_closure+1
	.quad	_r2aH_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aJ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2aI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2aB_closure+2
	.quad	_r2aJ_closure+3
	.quad	0
.data
.align 3
.align 0
_r2aL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2aK_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2az_closure+1
	.quad	_r2aL_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2am_closure+1
	.quad	_r2aM_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ag_closure+1
	.quad	_r2aN_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ab_closure+1
	.quad	_r2aO_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29V_closure+1
	.quad	_r2aP_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29O_closure+1
	.quad	_r2aQ_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuparserzutests_closure
_F95ArgDeclParserTestRefs_rangezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r29I_closure+1
	.quad	_r2aR_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aS_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2aT_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2aS_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2aV_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2aU_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aW_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2aT_closure+2
	.quad	_r2aV_closure+2
	.quad	0
.data
.align 3
.align 0
_r2aX_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r2aY_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2aX_closure+1
	.quad	0
.data
.align 3
.align 0
_r2aZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2b0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2aZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2b1_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2b0_closure+2
	.quad	1
.data
.align 3
.align 0
_r2b2_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2aY_closure+2
	.quad	_r2b1_closure+1
	.quad	0
.data
.align 3
.align 0
_r2b3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2b4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2b3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2b5_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2b4_closure+2
	.quad	1
.data
.align 3
.align 0
_r2b6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2b7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2b6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2b8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2b7_closure+2
	.quad	1
.data
.align 3
.align 0
_r2b9_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2b5_closure+1
	.quad	_r2b8_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ba_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2bb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ba_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2bd_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2bc_closure+1
	.quad	0
.data
.align 3
.align 0
_r2be_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2bb_closure+2
	.quad	_r2bd_closure+2
	.quad	0
.data
.align 3
.align 0
_r2bf_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2be_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bg_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2bh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bi_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2bj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bi_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bk_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2bj_closure+2
	.quad	1
.data
.align 3
.align 0
_r2bl_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2bm_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2bl_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bn_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2bh_closure+2
	.quad	_r2bk_closure+1
	.quad	_r2bm_closure+2
	.quad	0
.data
.align 3
.align 0
_r2bo_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2bn_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bp_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r2bf_closure+4
	.quad	_r2bo_closure+3
	.quad	0
.data
.align 3
.align 0
_r2bq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bp_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2br_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2b9_closure+1
	.quad	_r2bq_closure+2
	.quad	0
.data
.align 3
.align 0
_r2bs_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2b2_closure+1
	.quad	_r2br_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuexprzutests_closure
_F95ArgDeclParserTestRefs_rangezuexprzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2aW_closure+1
	.quad	_r2bs_closure+2
	.quad	0
.data
.align 3
.align 0
_r2bt_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2bu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bt_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bv_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2bw_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bv_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bx_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2bw_closure+2
	.quad	1
.data
.align 3
.align 0
_r2by_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2bz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2by_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bA_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2bu_closure+2
	.quad	_r2bx_closure+1
	.quad	_r2bz_closure+2
	.quad	0
.data
.align 3
.align 0
_r2bB_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2bA_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2bD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2bF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2bE_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2bH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bI_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2bH_closure+2
	.quad	1
.data
.align 3
.align 0
_r2bJ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2bD_closure+2
	.quad	_r2bF_closure+2
	.quad	_r2bI_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bK_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2bJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2bM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2bO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2bN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bP_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2bQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bP_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2bS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2bT_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2bS_closure+2
	.quad	1
.data
.align 3
.align 0
_r2bU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2bV_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2bU_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bW_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2bQ_closure+2
	.quad	_r2bT_closure+1
	.quad	_r2bV_closure+2
	.quad	0
.data
.align 3
.align 0
_r2bX_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2bW_closure+1
	.quad	0
.data
.align 3
.align 0
_r2bY_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2bM_closure+2
	.quad	_r2bO_closure+2
	.quad	_r2bX_closure+3
	.quad	0
.data
.align 3
.align 0
_r2bZ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2bY_closure+1
	.quad	0
.data
.align 3
.align 0
_r2c0_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2c1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2c0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2c2_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r2c3_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2c2_closure+1
	.quad	0
.data
.align 3
.align 0
_r2c4_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2c5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2c4_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2c6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2c7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2c6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2c8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2c7_closure+2
	.quad	1
.data
.align 3
.align 0
_r2c9_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2ca_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2c9_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cb_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2ca_closure+2
	.quad	1
.data
.align 3
.align 0
_r2cc_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2c5_closure+2
	.quad	_r2c8_closure+1
	.quad	_r2cb_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cd_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2cc_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ce_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2c1_closure+2
	.quad	_r2c3_closure+2
	.quad	_r2cd_closure+3
	.quad	0
.data
.align 3
.align 0
_r2cf_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2ce_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cg_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2ch_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ci_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2cj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ci_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2ck_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2cl_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2ck_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cm_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2cj_closure+2
	.quad	_r2cl_closure+2
	.quad	0
.data
.align 3
.align 0
_r2cn_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2cm_closure+1
	.quad	0
.data
.align 3
.align 0
_r2co_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2cp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2co_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2cr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cs_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2cr_closure+2
	.quad	1
.data
.align 3
.align 0
_r2ct_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2cu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2ct_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cv_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2cu_closure+2
	.quad	1
.data
.align 3
.align 0
_r2cw_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2cp_closure+2
	.quad	_r2cs_closure+1
	.quad	_r2cv_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cx_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2cw_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cy_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2ch_closure+2
	.quad	_r2cn_closure+4
	.quad	_r2cx_closure+3
	.quad	0
.data
.align 3
.align 0
_r2cz_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2cy_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r2cB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r2cD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r2cF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r2cE_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r2cH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cI_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r2cJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cI_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cK_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2cJ_closure+2
	.quad	1
.data
.align 3
.align 0
_r2cL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r2cM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cN_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r2cM_closure+2
	.quad	1
.data
.align 3
.align 0
_r2cO_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2cH_closure+2
	.quad	_r2cK_closure+1
	.quad	_r2cN_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cP_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2cO_closure+1
	.quad	1
.data
.align 3
.align 0
_r2cQ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r2cD_closure+2
	.quad	_r2cF_closure+2
	.quad	_r2cP_closure+3
	.quad	0
.data
.align 3
.align 0
_r2cR_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r2cQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cS_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r2cB_closure+2
	.quad	_r2cR_closure+3
	.quad	0
.data
.align 3
.align 0
_r2cT_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r2cS_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cT_closure+4
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2cV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cz_closure+3
	.quad	_r2cU_closure+2
	.quad	0
.data
.align 3
.align 0
_r2cW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2cf_closure+3
	.quad	_r2cV_closure+2
	.quad	0
.data
.align 3
.align 0
_r2cX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bZ_closure+3
	.quad	_r2cW_closure+2
	.quad	0
.data
.align 3
.align 0
_r2cY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bK_closure+3
	.quad	_r2cX_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_exprzuparserzutests_closure
_F95ArgDeclParserTestRefs_exprzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2bB_closure+3
	.quad	_r2cY_closure+2
	.quad	0
.const_data
.align 3
.align 0
_S2dk_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

