.data
.align 3
.align 0
.globl ___stginit_F95ArgDeclParserTestRefs
___stginit_F95ArgDeclParserTestRefs:
.data
.align 3
.align 0
_r1JC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	112
.data
.align 3
.align 0
_r1TF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1JC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TF_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TH_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1TI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TH_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TJ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1TK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1TM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TN_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TM_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TK_closure+2
	.quad	_r1TN_closure+2
	.quad	1
.data
.align 3
.align 0
_r1TP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TI_closure+2
	.quad	_r1TO_closure+2
	.quad	1
.data
.align 3
.align 0
_r1TQ_closure:
	.quad	_r1TQ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c23l_str:
	.byte	102
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1TQ_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1TQ_info)+0
	.quad	0
	.quad	4294967318
_r1TQ_info:
Lc23m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23n
Lc23o:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc23k
Lc23j:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c23l_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc23k:
	jmp *(%rbx)
Lc23n:
	jmp *-16(%r13)
	.long  _r1TQ_info - _r1TQ_info_dsp
.data
.align 3
.align 0
_r1TR_closure:
	.quad	_r1TR_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c23D_str:
	.byte	103
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1TR_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1TR_info)+0
	.quad	0
	.quad	4294967318
_r1TR_info:
Lc23E:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23F
Lc23G:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc23C
Lc23B:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c23D_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc23C:
	jmp *(%rbx)
Lc23F:
	jmp *-16(%r13)
	.long  _r1TR_info - _r1TR_info_dsp
.data
.align 3
.align 0
_r1TS_closure:
	.quad	_r1TS_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c23U_str:
	.byte	104
	.byte	52
	.byte	50
	.byte	0
.text
.align 3
_r1TS_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1TS_info)+0
	.quad	0
	.quad	4294967318
_r1TS_info:
Lc23V:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23W
Lc23X:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc23T
Lc23S:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c23U_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc23T:
	jmp *(%rbx)
Lc23W:
	jmp *-16(%r13)
	.long  _r1TS_info - _r1TS_info_dsp
.data
.align 3
.align 0
_r1TT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TS_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TR_closure
	.quad	_r1TT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1TV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TQ_closure
	.quad	_r1TU_closure+2
	.quad	0
.data
.align 3
.align 0
_r1TW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TV_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TP_closure+2
	.quad	_r1TW_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_arglistzuparserzutests_closure
_F95ArgDeclParserTestRefs_arglistzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TG_closure+2
	.quad	_r1TX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1TY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1TZ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1TY_closure+1
	.quad	0
.data
.align 3
.align 0
_r1U0_closure:
	.quad	_r1U0_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c24r_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1U0_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1U0_info)+0
	.quad	0
	.quad	4294967318
_r1U0_info:
Lc24s:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc24t
Lc24u:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc24q
Lc24p:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c24r_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc24q:
	jmp *(%rbx)
Lc24t:
	jmp *-16(%r13)
	.long  _r1U0_info - _r1U0_info_dsp
.data
.align 3
.align 0
_r1U1_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1U0_closure
	.quad	0
.data
.align 3
.align 0
_r1U2_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1TZ_closure+2
	.quad	_r1U1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1U3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1U2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1U4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1U5_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1U4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1U6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1U7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1U6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1U8_closure:
	.quad	_r1U8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c24W_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1U8_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1U8_info)+0
	.quad	0
	.quad	4294967318
_r1U8_info:
Lc24X:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc24Y
Lc24Z:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc24V
Lc24U:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c24W_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc24V:
	jmp *(%rbx)
Lc24Y:
	jmp *-16(%r13)
	.long  _r1U8_info - _r1U8_info_dsp
.data
.align 3
.align 0
_r1U9_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1U8_closure
	.quad	0
.data
.align 3
.align 0
_r1Ua_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ub_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ua_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uc_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1U7_closure+2
	.quad	_r1U9_closure+1
	.quad	_r1Ub_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ud_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Uc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ue_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1U5_closure+2
	.quad	_r1Ud_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Uf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ue_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ug_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Uh_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ug_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ui_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Uj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ui_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Uk_closure:
	.quad	_r1Uk_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c25z_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Uk_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Uk_info)+0
	.quad	0
	.quad	4294967318
_r1Uk_info:
Lc25A:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc25B
Lc25C:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc25y
Lc25x:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c25z_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc25y:
	jmp *(%rbx)
Lc25B:
	jmp *-16(%r13)
	.long  _r1Uk_info - _r1Uk_info_dsp
.data
.align 3
.align 0
_r1Ul_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Uk_closure
	.quad	0
.data
.align 3
.align 0
_r1Um_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Un_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Um_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uo_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Uj_closure+2
	.quad	_r1Ul_closure+1
	.quad	_r1Un_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Up_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Uo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uq_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Uh_closure+2
	.quad	_r1Up_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Ur_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Uq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Us_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Ut_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Us_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Uu_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Uv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Uu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uw_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Ut_closure+2
	.quad	_r1Uv_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ux_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Uw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uy_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Uz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Uy_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1UA_closure:
	.quad	_r1UA_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c26k_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1UA_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1UA_info)+0
	.quad	0
	.quad	4294967318
_r1UA_info:
Lc26l:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc26m
Lc26n:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc26j
Lc26i:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c26k_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc26j:
	jmp *(%rbx)
Lc26m:
	jmp *-16(%r13)
	.long  _r1UA_info - _r1UA_info_dsp
.data
.align 3
.align 0
_r1UB_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1UA_closure
	.quad	0
.data
.align 3
.align 0
_r1UC_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1UD_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1UC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UE_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Uz_closure+2
	.quad	_r1UB_closure+1
	.quad	_r1UD_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UF_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1UE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UG_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ux_closure+4
	.quad	_r1UF_closure+3
	.quad	0
.data
.align 3
.align 0
_r1UH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1UJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1UI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UK_closure:
	.quad	_r1UK_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c26T_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1UK_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1UK_info)+0
	.quad	0
	.quad	4294967318
_r1UK_info:
Lc26U:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc26V
Lc26W:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc26S
Lc26R:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c26T_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc26S:
	jmp *(%rbx)
Lc26V:
	jmp *-16(%r13)
	.long  _r1UK_info - _r1UK_info_dsp
.data
.align 3
.align 0
_r1UL_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1UK_closure
	.quad	0
.data
.align 3
.align 0
_r1UM_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1UJ_closure+2
	.quad	_r1UL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1UO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1UN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UP_closure:
	.quad	_r1UP_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c27i_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1UP_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1UP_info)+0
	.quad	0
	.quad	4294967318
_r1UP_info:
Lc27j:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc27k
Lc27l:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc27h
Lc27g:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c27i_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc27h:
	jmp *(%rbx)
Lc27k:
	jmp *-16(%r13)
	.long  _r1UP_info - _r1UP_info_dsp
.data
.align 3
.align 0
_r1UQ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1UP_closure
	.quad	0
.data
.align 3
.align 0
_r1UR_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1UO_closure+2
	.quad	_r1UQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1US_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1UT_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1US_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UU_closure:
	.quad	_r1UU_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c27H_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1UU_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1UU_info)+0
	.quad	0
	.quad	4294967318
_r1UU_info:
Lc27I:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc27J
Lc27K:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc27G
Lc27F:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c27H_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc27G:
	jmp *(%rbx)
Lc27J:
	jmp *-16(%r13)
	.long  _r1UU_info - _r1UU_info_dsp
.data
.align 3
.align 0
_r1UV_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1UU_closure
	.quad	0
.data
.align 3
.align 0
_r1UW_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1UT_closure+2
	.quad	_r1UV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UW_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UR_closure+1
	.quad	_r1UX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UM_closure+1
	.quad	_r1UY_closure+2
	.quad	0
.data
.align 3
.align 0
_r1V0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1V1_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1V0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1V2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1V3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V4_closure:
	.quad	_r1V4_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c28g_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1V4_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1V4_info)+0
	.quad	0
	.quad	4294967318
_r1V4_info:
Lc28h:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc28i
Lc28j:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc28f
Lc28e:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c28g_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc28f:
	jmp *(%rbx)
Lc28i:
	jmp *-16(%r13)
	.long  _r1V4_info - _r1V4_info_dsp
.data
.align 3
.align 0
_r1V5_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1V4_closure
	.quad	0
.data
.align 3
.align 0
_r1V6_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1V7_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1V6_closure+1
	.quad	0
.data
.align 3
.align 0
_r1V8_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1V3_closure+2
	.quad	_r1V5_closure+1
	.quad	_r1V7_closure+2
	.quad	0
.data
.align 3
.align 0
_r1V9_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1V8_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Va_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1V1_closure+2
	.quad	_r1V9_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Vb_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Vc_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Vb_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vd_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Ve_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vd_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Vf_closure:
	.quad	_r1Vf_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c28R_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Vf_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Vf_info)+0
	.quad	0
	.quad	4294967318
_r1Vf_info:
Lc28S:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc28T
Lc28U:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc28Q
Lc28P:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c28R_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc28Q:
	jmp *(%rbx)
Lc28T:
	jmp *-16(%r13)
	.long  _r1Vf_info - _r1Vf_info_dsp
.data
.align 3
.align 0
_r1Vg_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Vf_closure
	.quad	0
.data
.align 3
.align 0
_r1Vh_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Vi_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Vh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vj_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Ve_closure+2
	.quad	_r1Vg_closure+1
	.quad	_r1Vi_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vk_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Vj_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vl_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Vc_closure+2
	.quad	_r1Vk_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Vm_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Vn_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Vm_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vo_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Vp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vo_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Vq_closure:
	.quad	_r1Vq_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c29s_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Vq_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Vq_info)+0
	.quad	0
	.quad	4294967318
_r1Vq_info:
Lc29t:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc29u
Lc29v:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc29r
Lc29q:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c29s_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc29r:
	jmp *(%rbx)
Lc29u:
	jmp *-16(%r13)
	.long  _r1Vq_info - _r1Vq_info_dsp
.data
.align 3
.align 0
_r1Vr_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Vq_closure
	.quad	0
.data
.align 3
.align 0
_r1Vs_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Vt_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Vs_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vu_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Vp_closure+2
	.quad	_r1Vr_closure+1
	.quad	_r1Vt_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vv_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Vu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vw_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Vn_closure+2
	.quad	_r1Vv_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Vx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vw_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vl_closure+1
	.quad	_r1Vx_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Va_closure+1
	.quad	_r1Vy_closure+2
	.quad	0
.data
.align 3
.align 0
_r1VA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1VB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VA_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1VD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1VE_closure:
	.quad	_r1VE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2a9_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1VE_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1VE_info)+0
	.quad	0
	.quad	4294967318
_r1VE_info:
Lc2aa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ab
Lc2ac:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2a8
Lc2a7:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2a9_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2a8:
	jmp *(%rbx)
Lc2ab:
	jmp *-16(%r13)
	.long  _r1VE_info - _r1VE_info_dsp
.data
.align 3
.align 0
_r1VF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1VE_closure
	.quad	0
.data
.align 3
.align 0
_r1VG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1VH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VI_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1VD_closure+2
	.quad	_r1VF_closure+1
	.quad	_r1VH_closure+2
	.quad	0
.data
.align 3
.align 0
_r1VJ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1VI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1VB_closure+2
	.quad	_r1VJ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1VL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1VM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1VN_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1VO_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VP_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1VM_closure+2
	.quad	_r1VO_closure+2
	.quad	0
.data
.align 3
.align 0
_r1VQ_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1VP_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1VS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1VT_closure:
	.quad	_r1VT_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2aS_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1VT_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1VT_info)+0
	.quad	0
	.quad	4294967318
_r1VT_info:
Lc2aT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2aU
Lc2aV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2aR
Lc2aQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2aS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2aR:
	jmp *(%rbx)
Lc2aU:
	jmp *-16(%r13)
	.long  _r1VT_info - _r1VT_info_dsp
.data
.align 3
.align 0
_r1VU_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1VT_closure
	.quad	0
.data
.align 3
.align 0
_r1VV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1VW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VX_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1VS_closure+2
	.quad	_r1VU_closure+1
	.quad	_r1VW_closure+2
	.quad	0
.data
.align 3
.align 0
_r1VY_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1VX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VZ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1VQ_closure+4
	.quad	_r1VY_closure+3
	.quad	0
.data
.align 3
.align 0
_r1W0_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1W1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1W0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1W2_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1W3_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1W2_closure+1
	.quad	0
.data
.align 3
.align 0
_r1W4_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1W1_closure+2
	.quad	_r1W3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1W5_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1W4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1W6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1W7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1W6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1W8_closure:
	.quad	_r1W8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2bB_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1W8_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1W8_info)+0
	.quad	0
	.quad	4294967318
_r1W8_info:
Lc2bC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2bD
Lc2bE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2bA
Lc2bz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2bB_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2bA:
	jmp *(%rbx)
Lc2bD:
	jmp *-16(%r13)
	.long  _r1W8_info - _r1W8_info_dsp
.data
.align 3
.align 0
_r1W9_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1W8_closure
	.quad	0
.data
.align 3
.align 0
_r1Wa_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Wb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Wa_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wc_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1W7_closure+2
	.quad	_r1W9_closure+1
	.quad	_r1Wb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wd_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Wc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1We_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1W5_closure+4
	.quad	_r1Wd_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Wf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1We_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VZ_closure+1
	.quad	_r1Wf_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VK_closure+1
	.quad	_r1Wg_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wi_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wh_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vz_closure+2
	.quad	_r1Wi_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UZ_closure+2
	.quad	_r1Wj_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UH_closure+2
	.quad	_r1Wk_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ur_closure+2
	.quad	_r1Wl_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wn_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Uf_closure+2
	.quad	_r1Wm_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_dimzuparserzutests_closure
_F95ArgDeclParserTestRefs_dimzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1U3_closure+2
	.quad	_r1Wn_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wo_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Wp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wo_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Wq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Wr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ws_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Wr_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Wt_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Wu_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Wt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wv_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Wp_closure+2
	.quad	_r1Ws_closure+1
	.quad	_r1Wu_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ww_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Wv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wx_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Wy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wx_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Wz_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1WA_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Wz_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WB_closure:
	.quad	_r1WB_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2cO_str:
	.byte	121
	.byte	50
	.byte	0
.text
.align 3
_r1WB_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1WB_info)+0
	.quad	0
	.quad	4294967318
_r1WB_info:
Lc2cP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2cQ
Lc2cR:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2cN
Lc2cM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2cO_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2cN:
	jmp *(%rbx)
Lc2cQ:
	jmp *-16(%r13)
	.long  _r1WB_info - _r1WB_info_dsp
.data
.align 3
.align 0
_r1WC_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1WB_closure
	.quad	0
.data
.align 3
.align 0
_r1WD_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Wy_closure+2
	.quad	_r1WA_closure+2
	.quad	_r1WC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WE_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1WD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WF_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1WG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1WI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WH_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WJ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1WK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WL_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1WK_closure+2
	.quad	1
.data
.align 3
.align 0
_r1WM_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1WG_closure+2
	.quad	_r1WI_closure+2
	.quad	_r1WL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WN_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1WM_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WO_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1WP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WQ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1WR_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WS_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1WT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WS_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1WV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WW_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1WV_closure+2
	.quad	1
.data
.align 3
.align 0
_r1WX_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1WY_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WZ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1WT_closure+2
	.quad	_r1WW_closure+1
	.quad	_r1WY_closure+2
	.quad	0
.data
.align 3
.align 0
_r1X0_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1WZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1X1_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1WP_closure+2
	.quad	_r1WR_closure+2
	.quad	_r1X0_closure+3
	.quad	0
.data
.align 3
.align 0
_r1X2_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1X1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1X3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1X4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1X3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1X5_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1X6_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1X5_closure+1
	.quad	0
.data
.align 3
.align 0
_r1X7_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1X8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1X7_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1X9_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Xa_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1X9_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xb_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Xa_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Xc_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Xd_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xc_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xe_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Xd_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Xf_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1X8_closure+2
	.quad	_r1Xb_closure+1
	.quad	_r1Xe_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xg_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Xf_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xh_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1X4_closure+2
	.quad	_r1X6_closure+2
	.quad	_r1Xg_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Xi_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Xh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xj_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1Xk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xj_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xl_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Xm_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xl_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xn_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Xo_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Xn_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xp_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Xm_closure+2
	.quad	_r1Xo_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Xq_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Xp_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xr_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Xs_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xr_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xt_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Xu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xt_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xv_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Xu_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Xw_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Xx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xw_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Xy_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Xx_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Xz_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Xs_closure+2
	.quad	_r1Xv_closure+1
	.quad	_r1Xy_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XA_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Xz_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XB_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Xk_closure+2
	.quad	_r1Xq_closure+4
	.quad	_r1XA_closure+3
	.quad	0
.data
.align 3
.align 0
_r1XC_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1XB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XD_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1XE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XD_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XF_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1XG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1XI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1XH_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XJ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1XK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1XM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XN_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1XM_closure+2
	.quad	1
.data
.align 3
.align 0
_r1XO_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1XP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XQ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1XP_closure+2
	.quad	1
.data
.align 3
.align 0
_r1XR_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1XK_closure+2
	.quad	_r1XN_closure+1
	.quad	_r1XQ_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XS_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1XR_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XT_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1XG_closure+2
	.quad	_r1XI_closure+2
	.quad	_r1XS_closure+3
	.quad	0
.data
.align 3
.align 0
_r1XU_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1XT_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XV_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1XE_closure+2
	.quad	_r1XU_closure+3
	.quad	0
.data
.align 3
.align 0
_r1XW_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1XV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XW_closure+4
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XY_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XC_closure+3
	.quad	_r1XX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xi_closure+3
	.quad	_r1XY_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Y0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1X2_closure+3
	.quad	_r1XZ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Y1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WN_closure+3
	.quad	_r1Y0_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Y2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WE_closure+3
	.quad	_r1Y1_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_exprzuparserzutests_closure
_F95ArgDeclParserTestRefs_exprzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ww_closure+3
	.quad	_r1Y2_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Y3_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Y4_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Y3_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Y5_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Y6_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Y5_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Y7_closure:
	.quad	_r1Y7_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2g7_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Y7_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Y7_info)+0
	.quad	0
	.quad	4294967318
_r1Y7_info:
Lc2g8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2g9
Lc2ga:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2g6
Lc2g5:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2g7_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2g6:
	jmp *(%rbx)
Lc2g9:
	jmp *-16(%r13)
	.long  _r1Y7_info - _r1Y7_info_dsp
.data
.align 3
.align 0
_r1Y8_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Y7_closure
	.quad	0
.data
.align 3
.align 0
_r1Y9_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Y6_closure+2
	.quad	_r1Y8_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ya_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Yb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ya_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yc_closure:
	.quad	_r1Yc_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2gw_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Yc_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Yc_info)+0
	.quad	0
	.quad	4294967318
_r1Yc_info:
Lc2gx:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2gy
Lc2gz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2gv
Lc2gu:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2gw_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2gv:
	jmp *(%rbx)
Lc2gy:
	jmp *-16(%r13)
	.long  _r1Yc_info - _r1Yc_info_dsp
.data
.align 3
.align 0
_r1Yd_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Yc_closure
	.quad	0
.data
.align 3
.align 0
_r1Ye_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Yb_closure+2
	.quad	_r1Yd_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Yg_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yh_closure:
	.quad	_r1Yh_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2gV_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Yh_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Yh_info)+0
	.quad	0
	.quad	4294967318
_r1Yh_info:
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
	.long  _r1Yh_info - _r1Yh_info_dsp
.data
.align 3
.align 0
_r1Yi_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Yh_closure
	.quad	0
.data
.align 3
.align 0
_r1Yj_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Yg_closure+2
	.quad	_r1Yi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yj_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ye_closure+1
	.quad	_r1Yk_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ym_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Y9_closure+1
	.quad	_r1Yl_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Yn_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1Yo_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yn_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yo_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yq_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Y4_closure+1
	.quad	_r1Ym_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1Yp_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yr_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Ys_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Yr_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yt_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Yu_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yv_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Yw_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yv_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yx_closure:
	.quad	_r1Yx_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2hG_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Yx_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Yx_info)+0
	.quad	0
	.quad	4294967318
_r1Yx_info:
Lc2hH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2hI
Lc2hJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2hF
Lc2hE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2hG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2hF:
	jmp *(%rbx)
Lc2hI:
	jmp *-16(%r13)
	.long  _r1Yx_info - _r1Yx_info_dsp
.data
.align 3
.align 0
_r1Yy_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Yx_closure
	.quad	0
.data
.align 3
.align 0
_r1Yz_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YA_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yz_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YB_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Yw_closure+2
	.quad	_r1Yy_closure+1
	.quad	_r1YA_closure+2
	.quad	0
.data
.align 3
.align 0
_r1YC_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1YB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YD_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Yu_closure+2
	.quad	_r1YC_closure+3
	.quad	0
.data
.align 3
.align 0
_r1YE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1YH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YI_closure:
	.quad	_r1YI_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ih_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1YI_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1YI_info)+0
	.quad	0
	.quad	4294967318
_r1YI_info:
Lc2ii:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ij
Lc2ik:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ig
Lc2if:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ih_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ig:
	jmp *(%rbx)
Lc2ij:
	jmp *-16(%r13)
	.long  _r1YI_info - _r1YI_info_dsp
.data
.align 3
.align 0
_r1YJ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1YI_closure
	.quad	0
.data
.align 3
.align 0
_r1YK_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YL_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YK_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YM_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1YH_closure+2
	.quad	_r1YJ_closure+1
	.quad	_r1YL_closure+2
	.quad	0
.data
.align 3
.align 0
_r1YN_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1YM_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YO_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1YF_closure+2
	.quad	_r1YN_closure+3
	.quad	0
.data
.align 3
.align 0
_r1YP_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YQ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YP_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1YS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YT_closure:
	.quad	_r1YT_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2iS_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1YT_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1YT_info)+0
	.quad	0
	.quad	4294967318
_r1YT_info:
Lc2iT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2iU
Lc2iV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2iR
Lc2iQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2iS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2iR:
	jmp *(%rbx)
Lc2iU:
	jmp *-16(%r13)
	.long  _r1YT_info - _r1YT_info_dsp
.data
.align 3
.align 0
_r1YU_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1YT_closure
	.quad	0
.data
.align 3
.align 0
_r1YV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YW_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YX_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1YS_closure+2
	.quad	_r1YU_closure+1
	.quad	_r1YW_closure+2
	.quad	0
.data
.align 3
.align 0
_r1YY_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1YX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YZ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1YQ_closure+2
	.quad	_r1YY_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Z0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Z1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YO_closure+1
	.quad	_r1Z0_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Z2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YD_closure+1
	.quad	_r1Z1_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Z3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1Z4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Z3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Z5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Z4_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Z6_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Ys_closure+1
	.quad	_r1Z2_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1Z5_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Z7_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Z8_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Z7_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Z9_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Za_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Z9_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zb_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Zc_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zb_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zd_closure:
	.quad	_r1Zd_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2jL_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Zd_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Zd_info)+0
	.quad	0
	.quad	4294967318
_r1Zd_info:
Lc2jM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2jN
Lc2jO:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2jK
Lc2jJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2jL_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2jK:
	jmp *(%rbx)
Lc2jN:
	jmp *-16(%r13)
	.long  _r1Zd_info - _r1Zd_info_dsp
.data
.align 3
.align 0
_r1Ze_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Zd_closure
	.quad	0
.data
.align 3
.align 0
_r1Zf_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Zg_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Zf_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zh_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Zc_closure+2
	.quad	_r1Ze_closure+1
	.quad	_r1Zg_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zi_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Zh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zj_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Za_closure+2
	.quad	_r1Zi_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Zk_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Zl_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zk_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zm_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Zn_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Zm_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zo_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Zl_closure+2
	.quad	_r1Zn_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zp_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Zo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Zr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zs_closure:
	.quad	_r1Zs_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ku_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Zs_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1Zs_info)+0
	.quad	0
	.quad	4294967318
_r1Zs_info:
Lc2kv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2kw
Lc2kx:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2kt
Lc2ks:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ku_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2kt:
	jmp *(%rbx)
Lc2kw:
	jmp *-16(%r13)
	.long  _r1Zs_info - _r1Zs_info_dsp
.data
.align 3
.align 0
_r1Zt_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Zs_closure
	.quad	0
.data
.align 3
.align 0
_r1Zu_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Zv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Zu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zw_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Zr_closure+2
	.quad	_r1Zt_closure+1
	.quad	_r1Zv_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zx_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Zw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zy_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Zp_closure+4
	.quad	_r1Zx_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Zz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1ZA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1ZC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ZB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZD_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1ZA_closure+2
	.quad	_r1ZC_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZE_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1ZD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZF_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1ZG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZH_closure:
	.quad	_r1ZH_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ld_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1ZH_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r1ZH_info)+0
	.quad	0
	.quad	4294967318
_r1ZH_info:
Lc2le:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lf
Lc2lg:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2lc
Lc2lb:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ld_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2lc:
	jmp *(%rbx)
Lc2lf:
	jmp *-16(%r13)
	.long  _r1ZH_info - _r1ZH_info_dsp
.data
.align 3
.align 0
_r1ZI_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1ZH_closure
	.quad	0
.data
.align 3
.align 0
_r1ZJ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1ZK_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ZJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZL_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1ZG_closure+2
	.quad	_r1ZI_closure+1
	.quad	_r1ZK_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZM_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1ZL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZN_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1ZE_closure+4
	.quad	_r1ZM_closure+3
	.quad	0
.data
.align 3
.align 0
_r1ZO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zy_closure+1
	.quad	_r1ZO_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zj_closure+1
	.quad	_r1ZP_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZR_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1ZS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZR_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZS_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZU_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Z8_closure+1
	.quad	_r1ZQ_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1ZT_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZV_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1ZW_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1ZV_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZX_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1ZY_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ZX_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZZ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r200_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZZ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r201_closure:
	.quad	_r201_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2m6_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r201_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r201_info)+0
	.quad	0
	.quad	4294967318
_r201_info:
Lc2m7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2m8
Lc2m9:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2m5
Lc2m4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2m6_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2m5:
	jmp *(%rbx)
Lc2m8:
	jmp *-16(%r13)
	.long  _r201_info - _r201_info_dsp
.data
.align 3
.align 0
_r202_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r201_closure
	.quad	0
.data
.align 3
.align 0
_r203_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r204_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r203_closure+1
	.quad	0
.data
.align 3
.align 0
_r205_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r200_closure+2
	.quad	_r202_closure+1
	.quad	_r204_closure+2
	.quad	0
.data
.align 3
.align 0
_r206_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r205_closure+1
	.quad	0
.data
.align 3
.align 0
_r207_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1ZY_closure+2
	.quad	_r206_closure+3
	.quad	0
.data
.align 3
.align 0
_r208_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r209_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r208_closure+1
	.quad	0
.data
.align 3
.align 0
_r20a_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r20b_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20a_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20c_closure:
	.quad	_r20c_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2mH_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r20c_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r20c_info)+0
	.quad	0
	.quad	4294967318
_r20c_info:
Lc2mI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mJ
Lc2mK:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mG
Lc2mF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2mH_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mG:
	jmp *(%rbx)
Lc2mJ:
	jmp *-16(%r13)
	.long  _r20c_info - _r20c_info_dsp
.data
.align 3
.align 0
_r20d_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20c_closure
	.quad	0
.data
.align 3
.align 0
_r20e_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r20f_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20e_closure+1
	.quad	0
.data
.align 3
.align 0
_r20g_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20b_closure+2
	.quad	_r20d_closure+1
	.quad	_r20f_closure+2
	.quad	0
.data
.align 3
.align 0
_r20h_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20g_closure+1
	.quad	0
.data
.align 3
.align 0
_r20i_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r209_closure+2
	.quad	_r20h_closure+3
	.quad	0
.data
.align 3
.align 0
_r20j_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r20k_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20j_closure+1
	.quad	0
.data
.align 3
.align 0
_r20l_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r20m_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20l_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20n_closure:
	.quad	_r20n_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ni_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r20n_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r20n_info)+0
	.quad	0
	.quad	4294967318
_r20n_info:
Lc2nj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nk
Lc2nl:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nh
Lc2ng:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ni_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2nh:
	jmp *(%rbx)
Lc2nk:
	jmp *-16(%r13)
	.long  _r20n_info - _r20n_info_dsp
.data
.align 3
.align 0
_r20o_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20n_closure
	.quad	0
.data
.align 3
.align 0
_r20p_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r20q_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20p_closure+1
	.quad	0
.data
.align 3
.align 0
_r20r_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20m_closure+2
	.quad	_r20o_closure+1
	.quad	_r20q_closure+2
	.quad	0
.data
.align 3
.align 0
_r20s_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20r_closure+1
	.quad	0
.data
.align 3
.align 0
_r20t_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r20k_closure+2
	.quad	_r20s_closure+3
	.quad	0
.data
.align 3
.align 0
_r20u_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20t_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r20v_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20i_closure+1
	.quad	_r20u_closure+2
	.quad	0
.data
.align 3
.align 0
_r20w_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r207_closure+1
	.quad	_r20v_closure+2
	.quad	0
.data
.align 3
.align 0
_r20x_closure:
	.quad	_r20x_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2nR_str:
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_r20x_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r20x_info)+0
	.quad	0
	.quad	4294967318
_r20x_info:
Lc2nS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nT
Lc2nU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nQ
Lc2nP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2nR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2nQ:
	jmp *(%rbx)
Lc2nT:
	jmp *-16(%r13)
	.long  _r20x_info - _r20x_info_dsp
.data
.align 3
.align 0
_r20y_closure:
	.quad	_r20y_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2o8_str:
	.byte	116
	.byte	50
	.byte	0
.text
.align 3
_r20y_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r20y_info)+0
	.quad	0
	.quad	4294967318
_r20y_info:
Lc2o9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oa
Lc2ob:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2o7
Lc2o6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2o8_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2o7:
	jmp *(%rbx)
Lc2oa:
	jmp *-16(%r13)
	.long  _r20y_info - _r20y_info_dsp
.data
.align 3
.align 0
_r20z_closure:
	.quad	_r20z_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2op_str:
	.byte	116
	.byte	51
	.byte	0
.text
.align 3
_r20z_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r20z_info)+0
	.quad	0
	.quad	4294967318
_r20z_info:
Lc2oq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2or
Lc2os:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2oo
Lc2on:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2op_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2oo:
	jmp *(%rbx)
Lc2or:
	jmp *-16(%r13)
	.long  _r20z_info - _r20z_info_dsp
.data
.align 3
.align 0
_r20A_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20z_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r20B_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20y_closure
	.quad	_r20A_closure+2
	.quad	0
.data
.align 3
.align 0
_r20C_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20x_closure
	.quad	_r20B_closure+2
	.quad	0
.data
.align 3
.align 0
_r20D_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1ZW_closure+1
	.quad	_r20w_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r20C_closure+2
	.quad	_F95VarDecl_Read_closure+1
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r20E_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20D_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r20F_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZU_closure+1
	.quad	_r20E_closure+2
	.quad	0
.data
.align 3
.align 0
_r20G_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Z6_closure+1
	.quad	_r20F_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure
_F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yq_closure+1
	.quad	_r20G_closure+2
	.quad	0
.data
.align 3
.align 0
_r20H_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20I_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Out_closure+2
	.quad	_r20H_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_intentzuparserzutests_closure
_F95ArgDeclParserTestRefs_intentzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_In_closure+1
	.quad	_r20I_closure+2
	.quad	1
.data
.align 3
.align 0
_r20J_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20K_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Write_closure+2
	.quad	_r20J_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure
_F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Read_closure+1
	.quad	_r20K_closure+2
	.quad	1
.data
.align 3
.align 0
_r20L_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r20M_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20L_closure+1
	.quad	0
.data
.align 3
.align 0
_r20N_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r20O_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20N_closure+1
	.quad	0
.data
.align 3
.align 0
_r20P_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r20M_closure+2
	.quad	_r20O_closure+2
	.quad	0
.data
.align 3
.align 0
_r20Q_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r20R_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20Q_closure+1
	.quad	0
.data
.align 3
.align 0
_r20S_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r20T_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20S_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20U_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20T_closure+2
	.quad	1
.data
.align 3
.align 0
_r20V_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r20R_closure+2
	.quad	_r20U_closure+1
	.quad	0
.data
.align 3
.align 0
_r20W_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r20X_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20W_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20Y_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20X_closure+2
	.quad	1
.data
.align 3
.align 0
_r20Z_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r210_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20Z_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r211_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r210_closure+2
	.quad	1
.data
.align 3
.align 0
_r212_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r20Y_closure+1
	.quad	_r211_closure+1
	.quad	1
.data
.align 3
.align 0
_r213_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r214_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r213_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r215_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r216_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r215_closure+1
	.quad	0
.data
.align 3
.align 0
_r217_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r214_closure+2
	.quad	_r216_closure+2
	.quad	0
.data
.align 3
.align 0
_r218_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r217_closure+1
	.quad	0
.data
.align 3
.align 0
_r219_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r21a_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r219_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21b_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r21c_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21b_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21d_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r21c_closure+2
	.quad	1
.data
.align 3
.align 0
_r21e_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r21f_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21e_closure+1
	.quad	0
.data
.align 3
.align 0
_r21g_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r21a_closure+2
	.quad	_r21d_closure+1
	.quad	_r21f_closure+2
	.quad	0
.data
.align 3
.align 0
_r21h_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r21g_closure+1
	.quad	0
.data
.align 3
.align 0
_r21i_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r218_closure+4
	.quad	_r21h_closure+3
	.quad	0
.data
.align 3
.align 0
_r21j_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21i_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r21k_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r212_closure+1
	.quad	_r21j_closure+2
	.quad	0
.data
.align 3
.align 0
_r21l_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20V_closure+1
	.quad	_r21k_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuexprzutests_closure
_F95ArgDeclParserTestRefs_rangezuexprzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20P_closure+1
	.quad	_r21l_closure+2
	.quad	0
.data
.align 3
.align 0
_r21m_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r21n_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21m_closure+1
	.quad	0
.data
.align 3
.align 0
_r21o_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r21p_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21o_closure+1
	.quad	0
.data
.align 3
.align 0
_r21q_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r21n_closure+2
	.quad	_r21p_closure+2
	.quad	0
.data
.align 3
.align 0
_r21r_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r21s_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21r_closure+1
	.quad	0
.data
.align 3
.align 0
_r21t_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r21u_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21t_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21v_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r21u_closure+2
	.quad	1
.data
.align 3
.align 0
_r21w_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r21s_closure+2
	.quad	_r21v_closure+1
	.quad	0
.data
.align 3
.align 0
_r21x_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r21y_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21x_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21z_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r21y_closure+2
	.quad	1
.data
.align 3
.align 0
_r21A_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r21B_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21A_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21C_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r21B_closure+2
	.quad	1
.data
.align 3
.align 0
_r21D_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r21z_closure+1
	.quad	_r21C_closure+1
	.quad	1
.data
.align 3
.align 0
_r21E_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r21F_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21E_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21G_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r21H_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21G_closure+1
	.quad	0
.data
.align 3
.align 0
_r21I_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r21F_closure+2
	.quad	_r21H_closure+2
	.quad	0
.data
.align 3
.align 0
_r21J_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r21I_closure+1
	.quad	0
.data
.align 3
.align 0
_r21K_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r21L_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21K_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21M_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r21N_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21M_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r21O_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r21N_closure+2
	.quad	1
.data
.align 3
.align 0
_r21P_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r21Q_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21P_closure+1
	.quad	0
.data
.align 3
.align 0
_r21R_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r21L_closure+2
	.quad	_r21O_closure+1
	.quad	_r21Q_closure+2
	.quad	0
.data
.align 3
.align 0
_r21S_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r21R_closure+1
	.quad	0
.data
.align 3
.align 0
_r21T_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r21J_closure+4
	.quad	_r21S_closure+3
	.quad	0
.data
.align 3
.align 0
_r21U_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r21V_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21U_closure+1
	.quad	0
.data
.align 3
.align 0
_r21W_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r21X_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21W_closure+1
	.quad	0
.data
.align 3
.align 0
_r21Y_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r21V_closure+2
	.quad	_r21X_closure+2
	.quad	0
.data
.align 3
.align 0
_r21Z_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r220_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r21Z_closure+1
	.quad	0
.data
.align 3
.align 0
_r221_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r222_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r221_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r223_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r222_closure+2
	.quad	1
.data
.align 3
.align 0
_r224_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r220_closure+2
	.quad	_r223_closure+1
	.quad	0
.data
.align 3
.align 0
_r225_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r226_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r225_closure+1
	.quad	0
.data
.align 3
.align 0
_r227_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r228_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r227_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r229_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r22a_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r229_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r22b_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r22a_closure+2
	.quad	1
.data
.align 3
.align 0
_r22c_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r22d_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22c_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r22e_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r22d_closure+2
	.quad	1
.data
.align 3
.align 0
_r22f_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r228_closure+2
	.quad	_r22b_closure+1
	.quad	_r22e_closure+1
	.quad	1
.data
.align 3
.align 0
_r22g_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r22f_closure+1
	.quad	1
.data
.align 3
.align 0
_r22h_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r226_closure+2
	.quad	_r22g_closure+3
	.quad	0
.data
.align 3
.align 0
_r22i_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r22j_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r22i_closure+1
	.quad	0
.data
.align 3
.align 0
_r22k_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r22l_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22k_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r22m_closure:
	.quad	_r22m_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2sm_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r22m_info_dsp:
.text
.align 3
	.quad	_S23p_srt-(_r22m_info)+0
	.quad	0
	.quad	4294967318
_r22m_info:
Lc2sn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2so
Lc2sp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sl
Lc2sk:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2sm_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2sl:
	jmp *(%rbx)
Lc2so:
	jmp *-16(%r13)
	.long  _r22m_info - _r22m_info_dsp
.data
.align 3
.align 0
_r22n_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r22m_closure
	.quad	0
.data
.align 3
.align 0
_r22o_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r22p_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r22o_closure+1
	.quad	0
.data
.align 3
.align 0
_r22q_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r22l_closure+2
	.quad	_r22n_closure+1
	.quad	_r22p_closure+2
	.quad	0
.data
.align 3
.align 0
_r22r_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r22q_closure+1
	.quad	0
.data
.align 3
.align 0
_r22s_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r22j_closure+2
	.quad	_r22r_closure+3
	.quad	0
.data
.align 3
.align 0
_r22t_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22s_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r22u_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22h_closure+1
	.quad	_r22t_closure+2
	.quad	0
.data
.align 3
.align 0
_r22v_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r224_closure+1
	.quad	_r22u_closure+2
	.quad	0
.data
.align 3
.align 0
_r22w_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21Y_closure+1
	.quad	_r22v_closure+2
	.quad	0
.data
.align 3
.align 0
_r22x_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21T_closure+1
	.quad	_r22w_closure+2
	.quad	0
.data
.align 3
.align 0
_r22y_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21D_closure+1
	.quad	_r22x_closure+2
	.quad	0
.data
.align 3
.align 0
_r22z_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21w_closure+1
	.quad	_r22y_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuparserzutests_closure
_F95ArgDeclParserTestRefs_rangezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21q_closure+1
	.quad	_r22z_closure+2
	.quad	0
.data
.align 3
.align 0
_r22A_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r22B_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r22A_closure+1
	.quad	0
.data
.align 3
.align 0
_r22C_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r22D_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r22C_closure+1
	.quad	0
.data
.align 3
.align 0
_r22E_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r22F_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r22E_closure+1
	.quad	0
.data
.align 3
.align 0
_r22G_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r22H_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r22G_closure+1
	.quad	0
.data
.align 3
.align 0
_r22I_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r22J_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r22I_closure+1
	.quad	0
.data
.align 3
.align 0
_r22K_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22J_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r22L_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22H_closure+1
	.quad	_r22K_closure+2
	.quad	0
.data
.align 3
.align 0
_r22M_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22F_closure+1
	.quad	_r22L_closure+2
	.quad	0
.data
.align 3
.align 0
_r22N_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22D_closure+1
	.quad	_r22M_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_typezuparserzutests_closure
_F95ArgDeclParserTestRefs_typezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r22B_closure+1
	.quad	_r22N_closure+2
	.quad	0
.const_data
.align 3
.align 0
_S23p_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

