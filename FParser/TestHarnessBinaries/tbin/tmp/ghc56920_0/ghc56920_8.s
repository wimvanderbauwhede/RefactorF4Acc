.data
.align 3
.align 0
.globl ___stginit_F95ArgDeclParserTestRefs
___stginit_F95ArgDeclParserTestRefs:
.data
.align 3
.align 0
_r1Io_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Sj_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Io_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Sl_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Sk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sm_closure:
	.quad	_r1Sm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c21A_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Sm_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Sm_info)+0
	.quad	0
	.quad	4294967318
_r1Sm_info:
Lc21B:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc21C
Lc21D:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc21z
Lc21y:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c21A_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc21z:
	jmp *(%rbx)
Lc21C:
	jmp *-16(%r13)
	.long  _r1Sm_info - _r1Sm_info_dsp
.data
.align 3
.align 0
_r1Sn_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Sm_closure
	.quad	0
.data
.align 3
.align 0
_r1So_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Sl_closure+2
	.quad	_r1Sn_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sp_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Sq_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Sp_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sr_closure:
	.quad	_r1Sr_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c220_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Sr_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Sr_info)+0
	.quad	0
	.quad	4294967318
_r1Sr_info:
Lc221:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc222
Lc223:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc21Z
Lc21Y:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c220_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc21Z:
	jmp *(%rbx)
Lc222:
	jmp *-16(%r13)
	.long  _r1Sr_info - _r1Sr_info_dsp
.data
.align 3
.align 0
_r1Ss_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Sr_closure
	.quad	0
.data
.align 3
.align 0
_r1St_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Sq_closure+2
	.quad	_r1Ss_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Su_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Sv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Su_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sw_closure:
	.quad	_r1Sw_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c22p_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Sw_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Sw_info)+0
	.quad	0
	.quad	4294967318
_r1Sw_info:
Lc22q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc22r
Lc22s:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc22o
Lc22n:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c22p_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc22o:
	jmp *(%rbx)
Lc22r:
	jmp *-16(%r13)
	.long  _r1Sw_info - _r1Sw_info_dsp
.data
.align 3
.align 0
_r1Sx_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Sw_closure
	.quad	0
.data
.align 3
.align 0
_r1Sy_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Sv_closure+2
	.quad	_r1Sx_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Sz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Sy_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1St_closure+1
	.quad	_r1Sz_closure+2
	.quad	0
.data
.align 3
.align 0
_r1SB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1So_closure+1
	.quad	_r1SA_closure+2
	.quad	0
.data
.align 3
.align 0
_r1SC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1SD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SD_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SF_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Sj_closure+1
	.quad	_r1SB_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1SE_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1SH_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1SG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SI_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1SJ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1SI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SK_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
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
	.quad	_r1SM_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c23a_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1SM_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1SM_info)+0
	.quad	0
	.quad	4294967318
_r1SM_info:
Lc23b:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23c
Lc23d:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc239
Lc238:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c23a_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc239:
	jmp *(%rbx)
Lc23c:
	jmp *-16(%r13)
	.long  _r1SM_info - _r1SM_info_dsp
.data
.align 3
.align 0
_r1SN_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1SM_closure
	.quad	0
.data
.align 3
.align 0
_r1SO_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1SP_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1SO_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SQ_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1SL_closure+2
	.quad	_r1SN_closure+1
	.quad	_r1SP_closure+2
	.quad	0
.data
.align 3
.align 0
_r1SR_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1SQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SS_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1SJ_closure+2
	.quad	_r1SR_closure+3
	.quad	0
.data
.align 3
.align 0
_r1ST_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1SU_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ST_closure+1
	.quad	0
.data
.align 3
.align 0
_r1SV_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1SW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SV_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1SX_closure:
	.quad	_r1SX_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c23L_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1SX_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1SX_info)+0
	.quad	0
	.quad	4294967318
_r1SX_info:
Lc23M:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc23N
Lc23O:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc23K
Lc23J:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c23L_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc23K:
	jmp *(%rbx)
Lc23N:
	jmp *-16(%r13)
	.long  _r1SX_info - _r1SX_info_dsp
.data
.align 3
.align 0
_r1SY_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1SX_closure
	.quad	0
.data
.align 3
.align 0
_r1SZ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1T0_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1SZ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1T1_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1SW_closure+2
	.quad	_r1SY_closure+1
	.quad	_r1T0_closure+2
	.quad	0
.data
.align 3
.align 0
_r1T2_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1T1_closure+1
	.quad	0
.data
.align 3
.align 0
_r1T3_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1SU_closure+2
	.quad	_r1T2_closure+3
	.quad	0
.data
.align 3
.align 0
_r1T4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1T5_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1T4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1T6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1T7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1T6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1T8_closure:
	.quad	_r1T8_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c24m_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1T8_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1T8_info)+0
	.quad	0
	.quad	4294967318
_r1T8_info:
Lc24n:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc24o
Lc24p:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc24l
Lc24k:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c24m_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc24l:
	jmp *(%rbx)
Lc24o:
	jmp *-16(%r13)
	.long  _r1T8_info - _r1T8_info_dsp
.data
.align 3
.align 0
_r1T9_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1T8_closure
	.quad	0
.data
.align 3
.align 0
_r1Ta_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Tb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ta_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tc_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1T7_closure+2
	.quad	_r1T9_closure+1
	.quad	_r1Tb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Td_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Tc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Te_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1T5_closure+2
	.quad	_r1Td_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Tf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Te_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1T3_closure+1
	.quad	_r1Tf_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Th_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SS_closure+1
	.quad	_r1Tg_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ti_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1Tj_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ti_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Tk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Tj_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Tl_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1SH_closure+1
	.quad	_r1Th_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1Tk_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tm_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Tn_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Tm_closure+1
	.quad	0
.data
.align 3
.align 0
_r1To_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Tp_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1To_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Tr_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Tq_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ts_closure:
	.quad	_r1Ts_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c25f_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Ts_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Ts_info)+0
	.quad	0
	.quad	4294967318
_r1Ts_info:
Lc25g:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc25h
Lc25i:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc25e
Lc25d:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c25f_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc25e:
	jmp *(%rbx)
Lc25h:
	jmp *-16(%r13)
	.long  _r1Ts_info - _r1Ts_info_dsp
.data
.align 3
.align 0
_r1Tt_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ts_closure
	.quad	0
.data
.align 3
.align 0
_r1Tu_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Tv_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Tu_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Tw_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Tr_closure+2
	.quad	_r1Tt_closure+1
	.quad	_r1Tv_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Tx_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Tw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ty_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Tp_closure+2
	.quad	_r1Tx_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Tz_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1TA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Tz_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1TC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1TB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TD_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1TA_closure+2
	.quad	_r1TC_closure+2
	.quad	0
.data
.align 3
.align 0
_r1TE_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1TD_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TF_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1TG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TF_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TH_closure:
	.quad	_r1TH_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c25Y_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1TH_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1TH_info)+0
	.quad	0
	.quad	4294967318
_r1TH_info:
Lc25Z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc260
Lc261:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc25X
Lc25W:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c25Y_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc25X:
	jmp *(%rbx)
Lc260:
	jmp *-16(%r13)
	.long  _r1TH_info - _r1TH_info_dsp
.data
.align 3
.align 0
_r1TI_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1TH_closure
	.quad	0
.data
.align 3
.align 0
_r1TJ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1TK_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1TJ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TL_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1TG_closure+2
	.quad	_r1TI_closure+1
	.quad	_r1TK_closure+2
	.quad	0
.data
.align 3
.align 0
_r1TM_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1TL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TN_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1TE_closure+4
	.quad	_r1TM_closure+3
	.quad	0
.data
.align 3
.align 0
_r1TO_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1TP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TQ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1TR_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1TQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TS_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1TP_closure+2
	.quad	_r1TR_closure+2
	.quad	0
.data
.align 3
.align 0
_r1TT_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1TS_closure+1
	.quad	0
.data
.align 3
.align 0
_r1TU_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1TV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TU_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1TW_closure:
	.quad	_r1TW_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c26H_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1TW_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1TW_info)+0
	.quad	0
	.quad	4294967318
_r1TW_info:
Lc26I:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc26J
Lc26K:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc26G
Lc26F:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c26H_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc26G:
	jmp *(%rbx)
Lc26J:
	jmp *-16(%r13)
	.long  _r1TW_info - _r1TW_info_dsp
.data
.align 3
.align 0
_r1TX_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1TW_closure
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
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1TV_closure+2
	.quad	_r1TX_closure+1
	.quad	_r1TZ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1U1_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1U0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1U2_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1TT_closure+4
	.quad	_r1U1_closure+3
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
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1TN_closure+1
	.quad	_r1U3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1U5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ty_closure+1
	.quad	_r1U4_closure+2
	.quad	0
.data
.align 3
.align 0
_r1U6_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
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
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1U7_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1U9_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Tn_closure+1
	.quad	_r1U5_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1U8_closure+2
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ua_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1Ub_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1Ua_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Ud_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Uc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ue_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Uf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ue_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ug_closure:
	.quad	_r1Ug_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c27A_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Ug_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Ug_info)+0
	.quad	0
	.quad	4294967318
_r1Ug_info:
Lc27B:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc27C
Lc27D:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc27z
Lc27y:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c27A_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc27z:
	jmp *(%rbx)
Lc27C:
	jmp *-16(%r13)
	.long  _r1Ug_info - _r1Ug_info_dsp
.data
.align 3
.align 0
_r1Uh_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ug_closure
	.quad	0
.data
.align 3
.align 0
_r1Ui_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Uj_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ui_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uk_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Uf_closure+2
	.quad	_r1Uh_closure+1
	.quad	_r1Uj_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Ul_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Uk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Um_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Ud_closure+2
	.quad	_r1Ul_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Un_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Uo_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Un_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Up_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Uq_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Up_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ur_closure:
	.quad	_r1Ur_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c28b_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Ur_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Ur_info)+0
	.quad	0
	.quad	4294967318
_r1Ur_info:
Lc28c:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc28d
Lc28e:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc28a
Lc289:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c28b_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc28a:
	jmp *(%rbx)
Lc28d:
	jmp *-16(%r13)
	.long  _r1Ur_info - _r1Ur_info_dsp
.data
.align 3
.align 0
_r1Us_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ur_closure
	.quad	0
.data
.align 3
.align 0
_r1Ut_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Uu_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ut_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Uv_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Uq_closure+2
	.quad	_r1Us_closure+1
	.quad	_r1Uu_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Uw_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Uv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ux_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Uo_closure+2
	.quad	_r1Uw_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Uy_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Uz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Uy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1UB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1UC_closure:
	.quad	_r1UC_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c28M_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1UC_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1UC_info)+0
	.quad	0
	.quad	4294967318
_r1UC_info:
Lc28N:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc28O
Lc28P:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc28L
Lc28K:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c28M_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc28L:
	jmp *(%rbx)
Lc28O:
	jmp *-16(%r13)
	.long  _r1UC_info - _r1UC_info_dsp
.data
.align 3
.align 0
_r1UD_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1UC_closure
	.quad	0
.data
.align 3
.align 0
_r1UE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1UF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1UE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UG_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1UB_closure+2
	.quad	_r1UD_closure+1
	.quad	_r1UF_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UH_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1UG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UI_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Uz_closure+2
	.quad	_r1UH_closure+3
	.quad	0
.data
.align 3
.align 0
_r1UJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UI_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ux_closure+1
	.quad	_r1UJ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Um_closure+1
	.quad	_r1UK_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UM_closure:
	.quad	_r1UM_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c29l_str:
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_r1UM_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1UM_info)+0
	.quad	0
	.quad	4294967318
_r1UM_info:
Lc29m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc29n
Lc29o:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc29k
Lc29j:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c29l_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc29k:
	jmp *(%rbx)
Lc29n:
	jmp *-16(%r13)
	.long  _r1UM_info - _r1UM_info_dsp
.data
.align 3
.align 0
_r1UN_closure:
	.quad	_r1UN_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c29C_str:
	.byte	116
	.byte	50
	.byte	0
.text
.align 3
_r1UN_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1UN_info)+0
	.quad	0
	.quad	4294967318
_r1UN_info:
Lc29D:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc29E
Lc29F:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc29B
Lc29A:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c29C_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc29B:
	jmp *(%rbx)
Lc29E:
	jmp *-16(%r13)
	.long  _r1UN_info - _r1UN_info_dsp
.data
.align 3
.align 0
_r1UO_closure:
	.quad	_r1UO_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c29T_str:
	.byte	116
	.byte	51
	.byte	0
.text
.align 3
_r1UO_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1UO_info)+0
	.quad	0
	.quad	4294967318
_r1UO_info:
Lc29U:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc29V
Lc29W:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc29S
Lc29R:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c29T_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc29S:
	jmp *(%rbx)
Lc29V:
	jmp *-16(%r13)
	.long  _r1UO_info - _r1UO_info_dsp
.data
.align 3
.align 0
_r1UP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UO_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UN_closure
	.quad	_r1UP_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UM_closure
	.quad	_r1UQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1US_closure:
	.quad	_F95VarDecl_MkVarDecl_static_info
	.quad	_r1Ub_closure+1
	.quad	_r1UL_closure+2
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_r1UR_closure+2
	.quad	_F95VarDecl_Read_closure+1
	.quad	_ghczmprim_GHCziTypes_True_closure+2
	.quad	_ghczmprim_GHCziTypes_False_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1US_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1UU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1U9_closure+1
	.quad	_r1UT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Tl_closure+1
	.quad	_r1UU_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure
_F95ArgDeclParserTestRefs_f95zuargzudeclzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1SF_closure+1
	.quad	_r1UV_closure+2
	.quad	0
.data
.align 3
.align 0
_r1UW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_ReadWrite_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1UX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Write_closure+2
	.quad	_r1UW_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure
_F95ArgDeclParserTestRefs_oclzuargmodezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Read_closure+1
	.quad	_r1UX_closure+2
	.quad	1
.data
.align 3
.align 0
_r1UY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	112
.data
.align 3
.align 0
_r1UZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V0_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1UZ_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V1_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	117
.data
.align 3
.align 0
_r1V2_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V1_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V3_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	118
.data
.align 3
.align 0
_r1V4_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V3_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V5_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	119
.data
.align 3
.align 0
_r1V6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V5_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V6_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1V8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V4_closure+2
	.quad	_r1V7_closure+2
	.quad	1
.data
.align 3
.align 0
_r1V9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V2_closure+2
	.quad	_r1V8_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Va_closure:
	.quad	_r1Va_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2aU_str:
	.byte	102
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1Va_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Va_info)+0
	.quad	0
	.quad	4294967318
_r1Va_info:
Lc2aV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2aW
Lc2aX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2aT
Lc2aS:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2aU_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2aT:
	jmp *(%rbx)
Lc2aW:
	jmp *-16(%r13)
	.long  _r1Va_info - _r1Va_info_dsp
.data
.align 3
.align 0
_r1Vb_closure:
	.quad	_r1Vb_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2bb_str:
	.byte	103
	.byte	111
	.byte	108
	.byte	100
	.byte	0
.text
.align 3
_r1Vb_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Vb_info)+0
	.quad	0
	.quad	4294967318
_r1Vb_info:
Lc2bc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2bd
Lc2be:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ba
Lc2b9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2bb_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ba:
	jmp *(%rbx)
Lc2bd:
	jmp *-16(%r13)
	.long  _r1Vb_info - _r1Vb_info_dsp
.data
.align 3
.align 0
_r1Vc_closure:
	.quad	_r1Vc_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2bs_str:
	.byte	104
	.byte	52
	.byte	50
	.byte	0
.text
.align 3
_r1Vc_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Vc_info)+0
	.quad	0
	.quad	4294967318
_r1Vc_info:
Lc2bt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2bu
Lc2bv:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2br
Lc2bq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2bs_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2br:
	jmp *(%rbx)
Lc2bu:
	jmp *-16(%r13)
	.long  _r1Vc_info - _r1Vc_info_dsp
.data
.align 3
.align 0
_r1Vd_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vc_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ve_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vb_closure
	.quad	_r1Vd_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vf_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Va_closure
	.quad	_r1Ve_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vg_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vf_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V9_closure+2
	.quad	_r1Vg_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_arglistzuparserzutests_closure
_F95ArgDeclParserTestRefs_arglistzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1V0_closure+2
	.quad	_r1Vh_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vi_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Vj_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Vi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vk_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Vl_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Vk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vm_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	4
.data
.align 3
.align 0
_r1Vn_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1Vm_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vo_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1Vp_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Integer_closure+1
	.quad	_r1Vo_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vq_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	8
.data
.align 3
.align 0
_r1Vr_closure:
	.quad	_F95VarDecl_MkVarType_static_info
	.quad	_F95VarDecl_F95Real_closure+2
	.quad	_r1Vq_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vs_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vr_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Vt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vp_closure+1
	.quad	_r1Vs_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vn_closure+1
	.quad	_r1Vt_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vl_closure+1
	.quad	_r1Vu_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_typezuparserzutests_closure
_F95ArgDeclParserTestRefs_typezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Vj_closure+1
	.quad	_r1Vv_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Vw_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_InOut_closure+3
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Vx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_Out_closure+2
	.quad	_r1Vw_closure+2
	.quad	1
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_intentzuparserzutests_closure
_F95ArgDeclParserTestRefs_intentzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_F95VarDecl_In_closure+1
	.quad	_r1Vx_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Vy_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Vz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Vy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VA_closure:
	.quad	_r1VA_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2cz_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1VA_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1VA_info)+0
	.quad	0
	.quad	4294967318
_r1VA_info:
Lc2cA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2cB
Lc2cC:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2cy
Lc2cx:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2cz_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2cy:
	jmp *(%rbx)
Lc2cB:
	jmp *-16(%r13)
	.long  _r1VA_info - _r1VA_info_dsp
.data
.align 3
.align 0
_r1VB_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1VA_closure
	.quad	0
.data
.align 3
.align 0
_r1VC_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Vz_closure+2
	.quad	_r1VB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VE_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1VF_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1VH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1VI_closure:
	.quad	_r1VI_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2d4_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1VI_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1VI_info)+0
	.quad	0
	.quad	4294967318
_r1VI_info:
Lc2d5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2d6
Lc2d7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2d3
Lc2d2:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2d4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2d3:
	jmp *(%rbx)
Lc2d6:
	jmp *-16(%r13)
	.long  _r1VI_info - _r1VI_info_dsp
.data
.align 3
.align 0
_r1VJ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1VI_closure
	.quad	0
.data
.align 3
.align 0
_r1VK_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1VL_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VK_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VM_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1VH_closure+2
	.quad	_r1VJ_closure+1
	.quad	_r1VL_closure+2
	.quad	0
.data
.align 3
.align 0
_r1VN_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1VM_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VO_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1VF_closure+2
	.quad	_r1VN_closure+3
	.quad	0
.data
.align 3
.align 0
_r1VP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VQ_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1VR_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VQ_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VS_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1VT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VS_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1VU_closure:
	.quad	_r1VU_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2dH_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1VU_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1VU_info)+0
	.quad	0
	.quad	4294967318
_r1VU_info:
Lc2dI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2dJ
Lc2dK:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2dG
Lc2dF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2dH_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2dG:
	jmp *(%rbx)
Lc2dJ:
	jmp *-16(%r13)
	.long  _r1VU_info - _r1VU_info_dsp
.data
.align 3
.align 0
_r1VV_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1VU_closure
	.quad	0
.data
.align 3
.align 0
_r1VW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1VX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1VW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1VY_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1VT_closure+2
	.quad	_r1VV_closure+1
	.quad	_r1VX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1VZ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1VY_closure+1
	.quad	0
.data
.align 3
.align 0
_r1W0_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1VR_closure+2
	.quad	_r1VZ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1W1_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1W0_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1W2_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1W3_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1W2_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1W4_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1W5_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1W4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1W6_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1W3_closure+2
	.quad	_r1W5_closure+2
	.quad	0
.data
.align 3
.align 0
_r1W7_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1W6_closure+1
	.quad	0
.data
.align 3
.align 0
_r1W8_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1W9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1W8_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Wa_closure:
	.quad	_r1Wa_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2es_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Wa_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Wa_info)+0
	.quad	0
	.quad	4294967318
_r1Wa_info:
Lc2et:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2eu
Lc2ev:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2er
Lc2eq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2es_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2er:
	jmp *(%rbx)
Lc2eu:
	jmp *-16(%r13)
	.long  _r1Wa_info - _r1Wa_info_dsp
.data
.align 3
.align 0
_r1Wb_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Wa_closure
	.quad	0
.data
.align 3
.align 0
_r1Wc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Wd_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Wc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1We_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1W9_closure+2
	.quad	_r1Wb_closure+1
	.quad	_r1Wd_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wf_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1We_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wg_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1W7_closure+4
	.quad	_r1Wf_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Wh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wi_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Wj_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Wi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wk_closure:
	.quad	_r1Wk_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2f1_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Wk_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Wk_info)+0
	.quad	0
	.quad	4294967318
_r1Wk_info:
Lc2f2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2f3
Lc2f4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2f0
Lc2eZ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2f1_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2f0:
	jmp *(%rbx)
Lc2f3:
	jmp *-16(%r13)
	.long  _r1Wk_info - _r1Wk_info_dsp
.data
.align 3
.align 0
_r1Wl_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Wk_closure
	.quad	0
.data
.align 3
.align 0
_r1Wm_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Wj_closure+2
	.quad	_r1Wl_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wn_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Wo_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Wn_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wp_closure:
	.quad	_r1Wp_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2fq_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Wp_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Wp_info)+0
	.quad	0
	.quad	4294967318
_r1Wp_info:
Lc2fr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2fs
Lc2ft:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2fp
Lc2fo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2fq_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2fp:
	jmp *(%rbx)
Lc2fs:
	jmp *-16(%r13)
	.long  _r1Wp_info - _r1Wp_info_dsp
.data
.align 3
.align 0
_r1Wq_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Wp_closure
	.quad	0
.data
.align 3
.align 0
_r1Wr_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Wo_closure+2
	.quad	_r1Wq_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ws_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Wt_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ws_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wu_closure:
	.quad	_r1Wu_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2fP_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1Wu_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Wu_info)+0
	.quad	0
	.quad	4294967318
_r1Wu_info:
Lc2fQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2fR
Lc2fS:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2fO
Lc2fN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2fP_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2fO:
	jmp *(%rbx)
Lc2fR:
	jmp *-16(%r13)
	.long  _r1Wu_info - _r1Wu_info_dsp
.data
.align 3
.align 0
_r1Wv_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Wu_closure
	.quad	0
.data
.align 3
.align 0
_r1Ww_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Wt_closure+2
	.quad	_r1Wv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wx_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ww_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Wy_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wr_closure+1
	.quad	_r1Wx_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Wz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wm_closure+1
	.quad	_r1Wy_closure+2
	.quad	0
.data
.align 3
.align 0
_r1WA_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1WB_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WA_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1WD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WE_closure:
	.quad	_r1WE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2go_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1WE_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1WE_info)+0
	.quad	0
	.quad	4294967318
_r1WE_info:
Lc2gp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2gq
Lc2gr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2gn
Lc2gm:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2go_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2gn:
	jmp *(%rbx)
Lc2gq:
	jmp *-16(%r13)
	.long  _r1WE_info - _r1WE_info_dsp
.data
.align 3
.align 0
_r1WF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1WE_closure
	.quad	0
.data
.align 3
.align 0
_r1WG_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1WH_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WG_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WI_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1WD_closure+2
	.quad	_r1WF_closure+1
	.quad	_r1WH_closure+2
	.quad	0
.data
.align 3
.align 0
_r1WJ_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1WI_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WK_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1WB_closure+2
	.quad	_r1WJ_closure+3
	.quad	0
.data
.align 3
.align 0
_r1WL_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1WM_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WL_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WN_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1WO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1WP_closure:
	.quad	_r1WP_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2gZ_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1WP_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1WP_info)+0
	.quad	0
	.quad	4294967318
_r1WP_info:
Lc2h0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2h1
Lc2h2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2gY
Lc2gX:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2gZ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2gY:
	jmp *(%rbx)
Lc2h1:
	jmp *-16(%r13)
	.long  _r1WP_info - _r1WP_info_dsp
.data
.align 3
.align 0
_r1WQ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1WP_closure
	.quad	0
.data
.align 3
.align 0
_r1WR_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1WS_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WR_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WT_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1WO_closure+2
	.quad	_r1WQ_closure+1
	.quad	_r1WS_closure+2
	.quad	0
.data
.align 3
.align 0
_r1WU_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1WT_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WV_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1WM_closure+2
	.quad	_r1WU_closure+3
	.quad	0
.data
.align 3
.align 0
_r1WW_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1WX_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1WW_closure+1
	.quad	0
.data
.align 3
.align 0
_r1WY_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1WZ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WY_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1X0_closure:
	.quad	_r1X0_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2hA_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1X0_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1X0_info)+0
	.quad	0
	.quad	4294967318
_r1X0_info:
Lc2hB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2hC
Lc2hD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2hz
Lc2hy:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2hA_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2hz:
	jmp *(%rbx)
Lc2hC:
	jmp *-16(%r13)
	.long  _r1X0_info - _r1X0_info_dsp
.data
.align 3
.align 0
_r1X1_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1X0_closure
	.quad	0
.data
.align 3
.align 0
_r1X2_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1X3_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1X2_closure+1
	.quad	0
.data
.align 3
.align 0
_r1X4_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1WZ_closure+2
	.quad	_r1X1_closure+1
	.quad	_r1X3_closure+2
	.quad	0
.data
.align 3
.align 0
_r1X5_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1X4_closure+1
	.quad	0
.data
.align 3
.align 0
_r1X6_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1WX_closure+2
	.quad	_r1X5_closure+3
	.quad	0
.data
.align 3
.align 0
_r1X7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1X6_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1X8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WV_closure+1
	.quad	_r1X7_closure+2
	.quad	0
.data
.align 3
.align 0
_r1X9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1WK_closure+1
	.quad	_r1X8_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Xa_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Xb_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Xa_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xc_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
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
	.quad	_r1Xe_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ih_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1Xe_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Xe_info)+0
	.quad	0
	.quad	4294967318
_r1Xe_info:
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
	.long  _r1Xe_info - _r1Xe_info_dsp
.data
.align 3
.align 0
_r1Xf_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Xe_closure
	.quad	0
.data
.align 3
.align 0
_r1Xg_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Xh_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Xg_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xi_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Xd_closure+2
	.quad	_r1Xf_closure+1
	.quad	_r1Xh_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Xj_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Xi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xk_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Xb_closure+2
	.quad	_r1Xj_closure+3
	.quad	0
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
	.quad	_r1Xt_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2j0_str:
	.byte	106
	.byte	112
	.byte	0
.text
.align 3
_r1Xt_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1Xt_info)+0
	.quad	0
	.quad	4294967318
_r1Xt_info:
Lc2j1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2j2
Lc2j3:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2iZ
Lc2iY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2j0_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2iZ:
	jmp *(%rbx)
Lc2j2:
	jmp *-16(%r13)
	.long  _r1Xt_info - _r1Xt_info_dsp
.data
.align 3
.align 0
_r1Xu_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Xt_closure
	.quad	0
.data
.align 3
.align 0
_r1Xv_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Xw_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Xv_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xx_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Xs_closure+2
	.quad	_r1Xu_closure+1
	.quad	_r1Xw_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Xy_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Xx_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Xz_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Xq_closure+4
	.quad	_r1Xy_closure+3
	.quad	0
.data
.align 3
.align 0
_r1XA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1XB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XC_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1XD_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1XC_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XE_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1XB_closure+2
	.quad	_r1XD_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XF_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1XE_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XG_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1XH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XG_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1XI_closure:
	.quad	_r1XI_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2jJ_str:
	.byte	107
	.byte	112
	.byte	0
.text
.align 3
_r1XI_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1XI_info)+0
	.quad	0
	.quad	4294967318
_r1XI_info:
Lc2jK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2jL
Lc2jM:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2jI
Lc2jH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2jJ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2jI:
	jmp *(%rbx)
Lc2jL:
	jmp *-16(%r13)
	.long  _r1XI_info - _r1XI_info_dsp
.data
.align 3
.align 0
_r1XJ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1XI_closure
	.quad	0
.data
.align 3
.align 0
_r1XK_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1XL_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1XK_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XM_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1XH_closure+2
	.quad	_r1XJ_closure+1
	.quad	_r1XL_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XN_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1XM_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XO_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1XF_closure+4
	.quad	_r1XN_closure+3
	.quad	0
.data
.align 3
.align 0
_r1XP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xz_closure+1
	.quad	_r1XP_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XR_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Xk_closure+1
	.quad	_r1XQ_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XS_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1XR_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1XT_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1X9_closure+2
	.quad	_r1XS_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XU_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wz_closure+2
	.quad	_r1XT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XV_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Wh_closure+2
	.quad	_r1XU_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XW_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1W1_closure+2
	.quad	_r1XV_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VP_closure+2
	.quad	_r1XW_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_dimzuparserzutests_closure
_F95ArgDeclParserTestRefs_dimzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1VD_closure+2
	.quad	_r1XX_closure+2
	.quad	0
.data
.align 3
.align 0
_r1XY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1XZ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1XY_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Y0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Y1_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Y0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Y2_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1XZ_closure+2
	.quad	_r1Y1_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Y3_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Y4_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Y3_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Y5_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Y6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Y5_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Y7_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Y6_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Y8_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Y4_closure+2
	.quad	_r1Y7_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Y9_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Ya_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Y9_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yb_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Ya_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Yc_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1Yd_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yc_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Ye_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Yd_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Yf_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Yb_closure+1
	.quad	_r1Ye_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yg_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Yh_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yg_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yi_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Yj_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yi_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yk_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Yh_closure+2
	.quad	_r1Yj_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Yl_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Yk_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ym_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1Yn_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Ym_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yo_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Yp_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yo_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Yq_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Yp_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Yr_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Ys_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yr_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yt_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1Yn_closure+2
	.quad	_r1Yq_closure+1
	.quad	_r1Ys_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Yu_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Yt_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yv_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Yl_closure+4
	.quad	_r1Yu_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Yw_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Yx_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Yy_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Yz_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Yy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YA_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Yx_closure+2
	.quad	_r1Yz_closure+2
	.quad	0
.data
.align 3
.align 0
_r1YB_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YC_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YB_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YD_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1YE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YD_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YF_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1YE_closure+2
	.quad	1
.data
.align 3
.align 0
_r1YG_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1YC_closure+2
	.quad	_r1YF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YH_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YI_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YH_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YJ_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1YK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YL_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1YM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YL_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YN_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1YM_closure+2
	.quad	1
.data
.align 3
.align 0
_r1YO_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r1YP_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YO_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YQ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1YP_closure+2
	.quad	1
.data
.align 3
.align 0
_r1YR_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1YK_closure+2
	.quad	_r1YN_closure+1
	.quad	_r1YQ_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YS_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1YR_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YT_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1YI_closure+2
	.quad	_r1YS_closure+3
	.quad	0
.data
.align 3
.align 0
_r1YU_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1YV_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1YU_closure+1
	.quad	0
.data
.align 3
.align 0
_r1YW_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1YX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YW_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1YY_closure:
	.quad	_r1YY_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2mw_str:
	.byte	105
	.byte	112
	.byte	0
.text
.align 3
_r1YY_info_dsp:
.text
.align 3
	.quad	_S21E_srt-(_r1YY_info)+0
	.quad	0
	.quad	4294967318
_r1YY_info:
Lc2mx:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2my
Lc2mz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mv
Lc2mu:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2mw_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mv:
	jmp *(%rbx)
Lc2my:
	jmp *-16(%r13)
	.long  _r1YY_info - _r1YY_info_dsp
.data
.align 3
.align 0
_r1YZ_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1YY_closure
	.quad	0
.data
.align 3
.align 0
_r1Z0_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Z1_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Z0_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Z2_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1YX_closure+2
	.quad	_r1YZ_closure+1
	.quad	_r1Z1_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Z3_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1Z2_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Z4_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1YV_closure+2
	.quad	_r1Z3_closure+3
	.quad	0
.data
.align 3
.align 0
_r1Z5_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Z4_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Z6_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YT_closure+1
	.quad	_r1Z5_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Z7_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YG_closure+1
	.quad	_r1Z6_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Z8_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1YA_closure+1
	.quad	_r1Z7_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Z9_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yv_closure+1
	.quad	_r1Z8_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Za_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Yf_closure+1
	.quad	_r1Z9_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zb_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Y8_closure+1
	.quad	_r1Za_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuparserzutests_closure
_F95ArgDeclParserTestRefs_rangezuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Y2_closure+1
	.quad	_r1Zb_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zc_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Zd_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Zc_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Ze_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Zf_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Ze_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zg_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Zd_closure+2
	.quad	_r1Zf_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zh_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	0
.data
.align 3
.align 0
_r1Zi_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Zh_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zj_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Zk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zj_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zl_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Zk_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Zm_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Zi_closure+2
	.quad	_r1Zl_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zn_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1Zo_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zn_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zp_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Zo_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Zq_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
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
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1Zr_closure+2
	.quad	1
.data
.align 3
.align 0
_r1Zt_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Zp_closure+1
	.quad	_r1Zs_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zu_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r1Zv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zu_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1Zw_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1Zx_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1Zw_closure+1
	.quad	0
.data
.align 3
.align 0
_r1Zy_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r1Zv_closure+2
	.quad	_r1Zx_closure+2
	.quad	0
.data
.align 3
.align 0
_r1Zz_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r1Zy_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZA_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1ZB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZA_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZC_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1ZD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZC_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZE_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1ZD_closure+2
	.quad	1
.data
.align 3
.align 0
_r1ZF_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1ZG_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ZF_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZH_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1ZB_closure+2
	.quad	_r1ZE_closure+1
	.quad	_r1ZG_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZI_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1ZH_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZJ_closure:
	.quad	_F95VarDecl_MkRange_static_info
	.quad	_r1Zz_closure+4
	.quad	_r1ZI_closure+3
	.quad	0
.data
.align 3
.align 0
_r1ZK_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZJ_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZL_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zt_closure+1
	.quad	_r1ZK_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZM_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zm_closure+1
	.quad	_r1ZL_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_rangezuexprzutests_closure
_F95ArgDeclParserTestRefs_rangezuexprzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1Zg_closure+1
	.quad	_r1ZM_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZN_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r1ZO_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZN_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZP_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r1ZQ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZP_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZR_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r1ZQ_closure+2
	.quad	1
.data
.align 3
.align 0
_r1ZS_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r1ZT_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ZS_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZU_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1ZO_closure+2
	.quad	_r1ZR_closure+1
	.quad	_r1ZT_closure+2
	.quad	0
.data
.align 3
.align 0
_r1ZV_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r1ZU_closure+1
	.quad	0
.data
.align 3
.align 0
_r1ZW_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r1ZX_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZW_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r1ZY_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r1ZZ_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r1ZY_closure+1
	.quad	0
.data
.align 3
.align 0
_r200_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r201_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r200_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r202_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r201_closure+2
	.quad	1
.data
.align 3
.align 0
_r203_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r1ZX_closure+2
	.quad	_r1ZZ_closure+2
	.quad	_r202_closure+1
	.quad	0
.data
.align 3
.align 0
_r204_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r203_closure+1
	.quad	0
.data
.align 3
.align 0
_r205_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r206_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r205_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r207_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r208_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r207_closure+1
	.quad	0
.data
.align 3
.align 0
_r209_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r20a_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r209_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20b_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r20c_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20b_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20d_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20c_closure+2
	.quad	1
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
	.quad	_r20a_closure+2
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
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r206_closure+2
	.quad	_r208_closure+2
	.quad	_r20h_closure+3
	.quad	0
.data
.align 3
.align 0
_r20j_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20i_closure+1
	.quad	0
.data
.align 3
.align 0
_r20k_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r20l_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20k_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20m_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	2
.data
.align 3
.align 0
_r20n_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20m_closure+1
	.quad	0
.data
.align 3
.align 0
_r20o_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r20p_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20o_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20q_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r20r_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20q_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20s_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20r_closure+2
	.quad	1
.data
.align 3
.align 0
_r20t_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r20u_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20t_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20v_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20u_closure+2
	.quad	1
.data
.align 3
.align 0
_r20w_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20p_closure+2
	.quad	_r20s_closure+1
	.quad	_r20v_closure+1
	.quad	1
.data
.align 3
.align 0
_r20x_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20w_closure+1
	.quad	1
.data
.align 3
.align 0
_r20y_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20l_closure+2
	.quad	_r20n_closure+2
	.quad	_r20x_closure+3
	.quad	0
.data
.align 3
.align 0
_r20z_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20y_closure+1
	.quad	0
.data
.align 3
.align 0
_r20A_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
.data
.align 3
.align 0
_r20B_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20A_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20C_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r20D_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20C_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20E_closure:
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r20F_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20E_closure+1
	.quad	0
.data
.align 3
.align 0
_r20G_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r20D_closure+2
	.quad	_r20F_closure+2
	.quad	0
.data
.align 3
.align 0
_r20H_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r20G_closure+1
	.quad	0
.data
.align 3
.align 0
_r20I_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r20J_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20I_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20K_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r20L_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20K_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20M_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20L_closure+2
	.quad	1
.data
.align 3
.align 0
_r20N_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r20O_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20N_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20P_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r20O_closure+2
	.quad	1
.data
.align 3
.align 0
_r20Q_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20J_closure+2
	.quad	_r20M_closure+1
	.quad	_r20P_closure+1
	.quad	1
.data
.align 3
.align 0
_r20R_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20Q_closure+1
	.quad	1
.data
.align 3
.align 0
_r20S_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20B_closure+2
	.quad	_r20H_closure+4
	.quad	_r20R_closure+3
	.quad	0
.data
.align 3
.align 0
_r20T_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r20S_closure+1
	.quad	0
.data
.align 3
.align 0
_r20U_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	45
.data
.align 3
.align 0
_r20V_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20U_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r20W_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	42
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
	.quad	_integerzmgmp_GHCziIntegerziType_Szh_static_info
	.quad	1
.data
.align 3
.align 0
_r20Z_closure:
	.quad	_F95VarDecl_Const_static_info
	.quad	_r20Y_closure+1
	.quad	0
.data
.align 3
.align 0
_r210_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	43
.data
.align 3
.align 0
_r211_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r210_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r212_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	120
.data
.align 3
.align 0
_r213_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r212_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r214_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r213_closure+2
	.quad	1
.data
.align 3
.align 0
_r215_closure:
	.quad	_ghczmprim_GHCziTypes_Czh_static_info
	.quad	121
.data
.align 3
.align 0
_r216_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r215_closure+1
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	1
.data
.align 3
.align 0
_r217_closure:
	.quad	_F95VarDecl_Var_static_info
	.quad	_r216_closure+2
	.quad	1
.data
.align 3
.align 0
_r218_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r211_closure+2
	.quad	_r214_closure+1
	.quad	_r217_closure+1
	.quad	1
.data
.align 3
.align 0
_r219_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r218_closure+1
	.quad	1
.data
.align 3
.align 0
_r21a_closure:
	.quad	_F95VarDecl_MkOpExpr_static_info
	.quad	_r20X_closure+2
	.quad	_r20Z_closure+2
	.quad	_r219_closure+3
	.quad	0
.data
.align 3
.align 0
_r21b_closure:
	.quad	_F95VarDecl_Op_static_info
	.quad	_r21a_closure+1
	.quad	0
.data
.align 3
.align 0
_r21c_closure:
	.quad	_F95VarDecl_MkPrefixOpExpr_static_info
	.quad	_r20V_closure+2
	.quad	_r21b_closure+3
	.quad	0
.data
.align 3
.align 0
_r21d_closure:
	.quad	_F95VarDecl_Pref_static_info
	.quad	_r21c_closure+1
	.quad	0
.data
.align 3
.align 0
_r21e_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r21d_closure+4
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r21f_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20T_closure+3
	.quad	_r21e_closure+2
	.quad	0
.data
.align 3
.align 0
_r21g_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20z_closure+3
	.quad	_r21f_closure+2
	.quad	0
.data
.align 3
.align 0
_r21h_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r20j_closure+3
	.quad	_r21g_closure+2
	.quad	0
.data
.align 3
.align 0
_r21i_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r204_closure+3
	.quad	_r21h_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95ArgDeclParserTestRefs_exprzuparserzutests_closure
_F95ArgDeclParserTestRefs_exprzuparserzutests_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r1ZV_closure+3
	.quad	_r21i_closure+2
	.quad	0
.const_data
.align 3
.align 0
_S21E_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

