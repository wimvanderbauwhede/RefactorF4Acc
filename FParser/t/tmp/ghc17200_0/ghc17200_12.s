.data
.align 3
.align 0
.globl ___stginit_F95VarDeclParser
___stginit_F95VarDeclParser:
.data
.align 3
.align 0
.globl _F95VarDeclParser_constzuexpr_closure
_F95VarDeclParser_constzuexpr_closure:
	.quad	_F95VarDeclParser_constzuexpr_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2QN_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2QN_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2QN_info:
Lc2TW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TX
Lc2TY:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2U0
Lc2TZ:
	leaq _F95VarDecl_Const_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -6(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2U0:
	movq $16,904(%r13)
Lc2TX:
	jmp *-8(%r13)
	.long  _s2QN_info - _s2QN_info_dsp
.text
.align 3
_F95VarDeclParser_constzuexpr_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_constzuexpr_info)+0
	.quad	0
	.quad	12884901910
.globl _F95VarDeclParser_constzuexpr_info
_F95VarDeclParser_constzuexpr_info:
Lc2U1:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2U2
Lc2U3:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2U5
Lc2U4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2TP
Lc2TO:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2QN_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2TP:
	jmp *(%rbx)
Lc2U5:
	movq $16,904(%r13)
Lc2U2:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_constzuexpr_info - _F95VarDeclParser_constzuexpr_info_dsp
.data
.align 3
.align 0
_r2LW_closure:
	.quad	_r2LW_info
	.quad	0
.text
.align 3
_s2QS_info_dsp:
.text
.align 3
	.quad	4294967301
	.quad	1
	.quad	10
_s2QS_info:
Lc2UE:
Lc2UG:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2UI
Lc2UH:
	movq 7(%rbx),%rax
	leaq _F95VarDecl_MkPrefixOpExpr_con_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -31(%r12),%rax
	leaq _F95VarDecl_Pref_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -4(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2UI:
	movq $40,904(%r13)
Lc2UF:
	jmp *-8(%r13)
	.long  _s2QS_info - _s2QS_info_dsp
.text
.align 3
_s2QT_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2QT_info)+0
	.quad	1
	.quad	4294967313
_s2QT_info:
Lc2UJ:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2UK
Lc2UL:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2UN
Lc2UM:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2QS_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2UN:
	movq $16,904(%r13)
Lc2UK:
	jmp *-16(%r13)
	.long  _s2QT_info - _s2QT_info_dsp
.text
.align 3
_s2QP_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2QP_info)+16
	.quad	1
	.quad	4294967313
_s2QP_info:
Lc2US:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2UT
Lc2UU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2UT:
	jmp *-16(%r13)
	.long  _s2QP_info - _s2QP_info_dsp
.text
.align 3
_s2QU_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2QU_info)+0
	.quad	1
	.quad	21474836497
_s2QU_info:
Lc2UV:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2UW
Lc2UX:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2UZ
Lc2UY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2QT_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2QP_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2UZ:
	movq $48,904(%r13)
Lc2UW:
	jmp *-16(%r13)
	.long  _s2QU_info - _s2QU_info_dsp
.text
.align 3
_r2LW_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2LW_info)+0
	.quad	4294967301
	.quad	0
	.quad	55834574863
_r2LW_info:
Lc2V1:
Lc2V3:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2V5
Lc2V4:
	leaq _s2QU_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_Prefix_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2V5:
	movq $40,904(%r13)
Lc2V2:
	leaq _r2LW_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2LW_info - _r2LW_info_dsp
.data
.align 3
.align 0
_r2Qt_closure:
	.quad	_r2Qt_info
	.quad	0
.text
.align 3
_s2R1_info_dsp:
.text
.align 3
	.quad	8589934607
	.quad	1
	.quad	10
_s2R1_info:
Lc2VQ:
Lc2VS:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2VU
Lc2VT:
	movq 6(%rbx),%rax
	leaq _F95VarDecl_MkOpExpr_con_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-32(%r12)
	movq %r14,-24(%r12)
	movq %rsi,-16(%r12)
	leaq -39(%r12),%rax
	leaq _F95VarDecl_Op_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -5(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2VU:
	movq $48,904(%r13)
Lc2VR:
	jmp *-8(%r13)
	.long  _s2R1_info - _s2R1_info_dsp
.text
.align 3
_s2R2_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2R2_info)+0
	.quad	1
	.quad	4294967313
_s2R2_info:
Lc2VV:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2VW
Lc2VX:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2VZ
Lc2VY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2R1_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2VZ:
	movq $16,904(%r13)
Lc2VW:
	jmp *-16(%r13)
	.long  _s2R2_info - _s2R2_info_dsp
.text
.align 3
_s2QX_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2QX_info)+16
	.quad	1
	.quad	4294967313
_s2QX_info:
Lc2W4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2W5
Lc2W6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2W5:
	jmp *-16(%r13)
	.long  _s2QX_info - _s2QX_info_dsp
.text
.align 3
_s2R3_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2R3_info)+0
	.quad	1
	.quad	21474836497
_s2R3_info:
Lc2W7:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2W8
Lc2W9:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Wb
Lc2Wa:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2R2_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2QX_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Wb:
	movq $48,904(%r13)
Lc2W8:
	jmp *-16(%r13)
	.long  _s2R3_info - _s2R3_info_dsp
.text
.align 3
_r2Qt_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2Qt_info)+0
	.quad	8589934607
	.quad	0
	.quad	90194313231
_r2Qt_info:
Lc2Wd:
Lc2Wf:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Wh
Lc2Wg:
	leaq _s2R3_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_Infix_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rsi,(%r12)
	leaq -15(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2Wh:
	movq $48,904(%r13)
Lc2We:
	leaq _r2Qt_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2Qt_info - _r2Qt_info_dsp
.data
.align 3
.align 0
_r2Qu_closure:
	.quad	_r2Qu_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2Qu_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2Qu_info)+24
	.quad	0
	.quad	4294967318
_r2Qu_info:
Lc2WQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2WR
Lc2WS:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2WU
Lc2WT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2WO
Lc2WN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $721,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%r14
	addq $-16,%rbp
	jmp _r2LW_info
Lc2WO:
	jmp *(%rbx)
Lc2WU:
	movq $24,904(%r13)
Lc2WR:
	jmp *-16(%r13)
	.long  _r2Qu_info - _r2Qu_info_dsp
.data
.align 3
.align 0
_r2Qv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2Qu_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2Qw_closure:
	.quad	_r2Qw_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2Qw_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2Qw_info)+32
	.quad	0
	.quad	4294967318
_r2Qw_info:
Lc2Xe:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Xf
Lc2Xg:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Xi
Lc2Xh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Xc
Lc2Xb:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $673,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziExpr_AssocLeft_closure+2(%rip),%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _r2Qt_info
Lc2Xc:
	jmp *(%rbx)
Lc2Xi:
	movq $24,904(%r13)
Lc2Xf:
	jmp *-16(%r13)
	.long  _r2Qw_info - _r2Qw_info_dsp
.data
.align 3
.align 0
_r2Qx_closure:
	.quad	_r2Qx_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2Qx_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2Qx_info)+32
	.quad	0
	.quad	4294967318
_r2Qx_info:
Lc2XA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2XB
Lc2XC:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2XE
Lc2XD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Xy
Lc2Xx:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $753,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziExpr_AssocLeft_closure+2(%rip),%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _r2Qt_info
Lc2Xy:
	jmp *(%rbx)
Lc2XE:
	movq $24,904(%r13)
Lc2XB:
	jmp *-16(%r13)
	.long  _r2Qx_info - _r2Qx_info_dsp
.data
.align 3
.align 0
_r2Qy_closure:
	.quad	_r2Qy_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2Qy_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2Qy_info)+32
	.quad	0
	.quad	4294967318
_r2Qy_info:
Lc2XW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2XX
Lc2XY:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Y0
Lc2XZ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2XU
Lc2XT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $593,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziExpr_AssocLeft_closure+2(%rip),%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _r2Qt_info
Lc2XU:
	jmp *(%rbx)
Lc2Y0:
	movq $24,904(%r13)
Lc2XX:
	jmp *-16(%r13)
	.long  _r2Qy_info - _r2Qy_info_dsp
.data
.align 3
.align 0
_r2Qz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2Qy_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2QA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2Qx_closure
	.quad	_r2Qz_closure+2
	.quad	0
.data
.align 3
.align 0
_r2QB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2Qw_closure
	.quad	_r2QA_closure+2
	.quad	0
.data
.align 3
.align 0
_r2QC_closure:
	.quad	_r2QC_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2QC_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2QC_info)+32
	.quad	0
	.quad	4294967318
_r2QC_info:
Lc2Yo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yp
Lc2Yq:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ys
Lc2Yr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ym
Lc2Yl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $689,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziExpr_AssocLeft_closure+2(%rip),%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _r2Qt_info
Lc2Ym:
	jmp *(%rbx)
Lc2Ys:
	movq $24,904(%r13)
Lc2Yp:
	jmp *-16(%r13)
	.long  _r2QC_info - _r2QC_info_dsp
.data
.align 3
.align 0
_r2QD_closure:
	.quad	_r2QD_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2QD_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_r2QD_info)+32
	.quad	0
	.quad	4294967318
_r2QD_info:
Lc2YK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YL
Lc2YM:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2YO
Lc2YN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2YI
Lc2YH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $721,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziExpr_AssocLeft_closure+2(%rip),%rsi
	movq %rax,%r14
	addq $-16,%rbp
	jmp _r2Qt_info
Lc2YI:
	jmp *(%rbx)
Lc2YO:
	movq $24,904(%r13)
Lc2YL:
	jmp *-16(%r13)
	.long  _r2QD_info - _r2QD_info_dsp
.data
.align 3
.align 0
_r2QE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2QD_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2QF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2QC_closure
	.quad	_r2QE_closure+2
	.quad	0
.data
.align 3
.align 0
_r2QG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2QF_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2QH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2QB_closure+2
	.quad	_r2QG_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95VarDeclParser_optable_closure
_F95VarDeclParser_optable_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2Qv_closure+2
	.quad	_r2QH_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95VarDeclParser_varzuexpr_closure
_F95VarDeclParser_varzuexpr_closure:
	.quad	_F95VarDeclParser_varzuexpr_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2Ri_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Ri_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2Ri_info:
Lc2Zl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zm
Lc2Zn:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zp
Lc2Zo:
	leaq _F95VarDecl_Var_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Zp:
	movq $16,904(%r13)
Lc2Zm:
	jmp *-8(%r13)
	.long  _s2Ri_info - _s2Ri_info_dsp
.text
.align 3
_F95VarDeclParser_varzuexpr_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_varzuexpr_info)+0
	.quad	0
	.quad	141733920790
.globl _F95VarDeclParser_varzuexpr_info
_F95VarDeclParser_varzuexpr_info:
Lc2Zq:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zr
Lc2Zs:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zu
Lc2Zt:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ze
Lc2Zd:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Ri_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Ze:
	jmp *(%rbx)
Lc2Zu:
	movq $16,904(%r13)
Lc2Zr:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_varzuexpr_info - _F95VarDeclParser_varzuexpr_info_dsp
.data
.align 3
.align 0
_s2Rk_closure:
	.quad	_s2Rk_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2ZY_str:
	.byte	101
	.byte	120
	.byte	112
	.byte	114
	.byte	101
	.byte	115
	.byte	115
	.byte	105
	.byte	111
	.byte	110
	.byte	0
.text
.align 3
_s2Rk_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rk_info)+48
	.quad	0
	.quad	4294967318
_s2Rk_info:
Lc2ZZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc300
Lc301:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ZX
Lc2ZW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2ZY_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ZX:
	jmp *(%rbx)
Lc300:
	jmp *-16(%r13)
	.long  _s2Rk_info - _s2Rk_info_dsp
.data
.align 3
.align 0
_s2Rj_closure:
	.quad	_s2Rj_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2Rj_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rj_info)+56
	.quad	0
	.quad	30064771094
_s2Rj_info:
Lc308:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc309
Lc30a:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc307
Lc306:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95VarDeclParser_term_closure(%rip),%rsi
	leaq _F95VarDeclParser_optable_closure+2(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc307:
	jmp *(%rbx)
Lc309:
	jmp *-16(%r13)
	.long  _s2Rj_info - _s2Rj_info_dsp
.data
.align 3
.align 0
_s2Rq_closure:
	.quad	_s2Rq_info
	.quad	0
.text
.align 3
_s2Rp_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rp_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2Rp_info:
Lc30l:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30m
Lc30n:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc30p
Lc30o:
	movq 7(%rbx),%rax
	leaq _F95VarDecl_ArrayIdx_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -11(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc30p:
	movq $24,904(%r13)
Lc30m:
	jmp *-8(%r13)
	.long  _s2Rp_info - _s2Rp_info_dsp
.text
.align 3
_s2Rm_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rm_info)+80
	.quad	0
	.quad	12884901904
_s2Rm_info:
Lc30u:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30v
Lc30w:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc30v:
	jmp *-16(%r13)
	.long  _s2Rm_info - _s2Rm_info_dsp
.text
.align 3
_s2Rq_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rq_info)+0
	.quad	4294967301
	.quad	0
	.quad	30790620545039
_s2Rq_info:
Lc30x:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30y
Lc30z:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc30B
Lc30A:
	leaq _s2Rp_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2Rm_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc30B:
	movq $32,904(%r13)
Lc30y:
	leaq _s2Rq_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2Rq_info - _s2Rq_info_dsp
.data
.align 3
.align 0
_s2Rw_closure:
	.quad	_s2Rw_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c30I_str:
	.byte	115
	.byte	105
	.byte	109
	.byte	112
	.byte	108
	.byte	101
	.byte	32
	.byte	101
	.byte	120
	.byte	112
	.byte	114
	.byte	101
	.byte	115
	.byte	115
	.byte	105
	.byte	111
	.byte	110
	.byte	0
.text
.align 3
_s2Rw_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rw_info)+48
	.quad	0
	.quad	4294967318
_s2Rw_info:
Lc30J:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30K
Lc30L:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc30H
Lc30G:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c30I_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc30H:
	jmp *(%rbx)
Lc30K:
	jmp *-16(%r13)
	.long  _s2Rw_info - _s2Rw_info_dsp
.data
.align 3
.align 0
_s2Rv_closure:
	.quad	_s2Rv_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2Rs_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rs_info)+104
	.quad	0
	.quad	12884901904
_s2Rs_info:
Lc314:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc315
Lc316:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_arrayzuidxzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc315:
	jmp *-16(%r13)
	.long  _s2Rs_info - _s2Rs_info_dsp
.text
.align 3
_s2Rt_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rt_info)+104
	.quad	0
	.quad	64424509456
_s2Rt_info:
Lc317:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc318
Lc319:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc31b
Lc31a:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Rs_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _F95VarDeclParser_varzuexpr_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc31b:
	movq $16,904(%r13)
Lc318:
	jmp *-16(%r13)
	.long  _s2Rt_info - _s2Rt_info_dsp
.text
.align 3
_s2Ru_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Ru_info)+104
	.quad	0
	.quad	133143986192
_s2Ru_info:
Lc31c:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31d
Lc31e:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc31g
Lc31f:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Rt_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_constzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc31g:
	movq $16,904(%r13)
Lc31d:
	jmp *-16(%r13)
	.long  _s2Ru_info - _s2Ru_info_dsp
.text
.align 3
_s2Rr_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rr_info)+80
	.quad	0
	.quad	12884901904
_s2Rr_info:
Lc31l:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31m
Lc31n:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc31m:
	jmp *-16(%r13)
	.long  _s2Rr_info - _s2Rr_info_dsp
.text
.align 3
_s2Rv_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rv_info)+80
	.quad	0
	.quad	1078036791318
_s2Rv_info:
Lc31o:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31p
Lc31q:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc31s
Lc31r:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc30R
Lc30Q:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Ru_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2Rr_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc30R:
	jmp *(%rbx)
Lc31s:
	movq $32,904(%r13)
Lc31p:
	jmp *-16(%r13)
	.long  _s2Rv_info - _s2Rv_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_exprzuparser_closure
_F95VarDeclParser_exprzuparser_closure:
	.quad	_F95VarDeclParser_exprzuparser_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_exprzuparser_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_exprzuparser_info)+144
	.quad	0
	.quad	30064771094
.globl _F95VarDeclParser_exprzuparser_info
_F95VarDeclParser_exprzuparser_info:
Lc31z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31A
Lc31B:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31y
Lc31x:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Rk_closure(%rip),%rsi
	leaq _s2Rj_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc31y:
	jmp *(%rbx)
Lc31A:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_exprzuparser_info - _F95VarDeclParser_exprzuparser_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_arrayzuidxzuexpr_closure
_F95VarDeclParser_arrayzuidxzuexpr_closure:
	.quad	_F95VarDeclParser_arrayzuidxzuexpr_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_arrayzuidxzuexpr_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_arrayzuidxzuexpr_info)+0
	.quad	0
	.quad	17733919965206
.globl _F95VarDeclParser_arrayzuidxzuexpr_info
_F95VarDeclParser_arrayzuidxzuexpr_info:
Lc31I:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31J
Lc31K:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31H
Lc31G:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2Rq_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc31H:
	jmp *(%rbx)
Lc31J:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_arrayzuidxzuexpr_info - _F95VarDeclParser_arrayzuidxzuexpr_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_term_closure
_F95VarDeclParser_term_closure:
	.quad	_F95VarDeclParser_term_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_term_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_term_info)+144
	.quad	0
	.quad	107374182422
.globl _F95VarDeclParser_term_info
_F95VarDeclParser_term_info:
Lc31R:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31S
Lc31T:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31Q
Lc31P:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Rw_closure(%rip),%rsi
	leaq _s2Rv_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc31Q:
	jmp *(%rbx)
Lc31S:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_term_info - _F95VarDeclParser_term_info_dsp
.data
.align 3
.align 0
_s2RC_closure:
	.quad	_s2RC_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2RB_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RB_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2RB_info:
Lc33k:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33l
Lc33m:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc33l:
	jmp *-8(%r13)
	.long  _s2RB_info - _s2RB_info_dsp
.text
.align 3
_s2Rz_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rz_info)+40
	.quad	0
	.quad	1125904201809936
_s2Rz_info:
Lc33r:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33s
Lc33t:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33s:
	jmp *-16(%r13)
	.long  _s2Rz_info - _s2Rz_info_dsp
.text
.align 3
_s2RC_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RC_info)+0
	.quad	0
	.quad	36028938752884758
_s2RC_info:
Lc33u:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33v
Lc33w:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc33y
Lc33x:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc33e
Lc33d:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2RB_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2Rz_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc33e:
	jmp *(%rbx)
Lc33y:
	movq $32,904(%r13)
Lc33v:
	jmp *-16(%r13)
	.long  _s2RC_info - _s2RC_info_dsp
.data
.align 3
.align 0
_s2Ry_closure:
	.quad	_s2Ry_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c340_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2Rx_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Rx_info)+48
	.quad	0
	.quad	4294967312
_s2Rx_info:
Lc341:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc342
Lc343:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c340_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc342:
	jmp *-16(%r13)
	.long  _s2Rx_info - _s2Rx_info_dsp
.text
.align 3
_s2Ry_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Ry_info)+48
	.quad	0
	.quad	1125904201809942
_s2Ry_info:
Lc344:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc345
Lc346:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc348
Lc347:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc33V
Lc33U:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Rx_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33V:
	jmp *(%rbx)
Lc348:
	movq $16,904(%r13)
Lc345:
	jmp *-16(%r13)
	.long  _s2Ry_info - _s2Ry_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_arglistzuparser_closure
_F95VarDeclParser_arglistzuparser_closure:
	.quad	_F95VarDeclParser_arglistzuparser_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_arglistzuparser_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_arglistzuparser_info)+0
	.quad	0
	.quad	432345568522534934
.globl _F95VarDeclParser_arglistzuparser_info
_F95VarDeclParser_arglistzuparser_info:
Lc34r:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34s
Lc34t:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc34q
Lc34p:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2Ry_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2RC_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc34q:
	jmp *(%rbx)
Lc34s:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_arglistzuparser_info - _F95VarDeclParser_arglistzuparser_info_dsp
.data
.align 3
.align 0
_s2RQ_closure:
	.quad	_s2RQ_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2RH_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RH_info)+216
	.quad	0
	.quad	12884901904
_s2RH_info:
Lc35e:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35f
Lc35g:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc35f:
	jmp *-16(%r13)
	.long  _s2RH_info - _s2RH_info_dsp
.const
.align 3
.align 0
_c35l_str:
	.byte	105
	.byte	110
	.byte	0
.text
.align 3
_s2RI_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RI_info)+48
	.quad	0
	.quad	4294967312
_s2RI_info:
Lc35m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35n
Lc35o:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c35l_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc35n:
	jmp *-16(%r13)
	.long  _s2RI_info - _s2RI_info_dsp
.const
.align 3
.align 0
_c35x_str:
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2RK_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RK_info)+48
	.quad	0
	.quad	4294967312
_s2RK_info:
Lc35y:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35z
Lc35A:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c35x_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc35z:
	jmp *-16(%r13)
	.long  _s2RK_info - _s2RK_info_dsp
.const
.align 3
.align 0
_c35J_str:
	.byte	105
	.byte	110
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2RM_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RM_info)+48
	.quad	0
	.quad	4294967312
_s2RM_info:
Lc35K:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35L
Lc35M:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c35J_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc35L:
	jmp *-16(%r13)
	.long  _s2RM_info - _s2RM_info_dsp
.const
.align 3
.align 0
_c35Z_str:
	.byte	46
	.byte	46
	.byte	47
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
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	40
	.byte	57
	.byte	57
	.byte	44
	.byte	57
	.byte	41
	.byte	45
	.byte	40
	.byte	49
	.byte	48
	.byte	50
	.byte	44
	.byte	51
	.byte	57
	.byte	41
	.byte	124
	.byte	102
	.byte	117
	.byte	110
	.byte	99
	.byte	116
	.byte	105
	.byte	111
	.byte	110
	.byte	32
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	110
	.byte	116
	.byte	0
.text
.align 3
_s2RO_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RO_info)+48
	.quad	1
	.quad	63050399078154257
_s2RO_info:
Lc35U:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc36u
Lc36v:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc36x
Lc36w:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2RH_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2RI_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c35p_info(%rip),%rdx
	movq %rdx,-40(%rbp)
	movq %rbx,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rdx
	movq %rdx,-64(%rbp)
	movq %rax,-56(%rbp)
	movq %rcx,-48(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-64,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c35p_info)+48
	.quad	2
	.quad	36028801313931296
_c35p_info:
Lc35p:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc35S
Lc35T:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc36t
Lc36s:
	leaq _s2RK_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c35B_info(%rip),%rdx
	movq %rdx,(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rbx,-8(%rbp)
	addq $-24,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c35B_info)+48
	.quad	2
	.quad	36028801313931296
_c35B_info:
Lc35B:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc368
Lc369:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc36q
Lc36p:
	leaq _s2RM_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c35V_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc35S:
	leaq _F95VarDecl_In_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2U6_srt-(_c35V_info)+232
	.quad	0
	.quad	4294967328
_c35V_info:
Lc35V:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc36i
Lc36j:
	leaq _c35Z_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc368:
	leaq _F95VarDecl_Out_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc36i:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc36q:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc36t:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc36x:
	movq $32,904(%r13)
Lc36u:
	jmp *-16(%r13)
	.long  _s2RO_info - _s2RO_info_dsp
.text
.align 3
_s2RP_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RP_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4035225545296838667
_s2RP_info:
Lc36y:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc36z
Lc36A:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc36C
Lc36B:
	leaq _s2RO_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc36C:
	movq $24,904(%r13)
Lc36z:
	jmp *-8(%r13)
	.long  _s2RP_info - _s2RP_info_dsp
.text
.align 3
_s2RF_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RF_info)+40
	.quad	0
	.quad	141733920784
_s2RF_info:
Lc36H:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc36I
Lc36J:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc36I:
	jmp *-16(%r13)
	.long  _s2RF_info - _s2RF_info_dsp
.text
.align 3
_s2RQ_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RQ_info)+0
	.quad	0
	.quad	4035230080782303254
_s2RQ_info:
Lc36K:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc36L
Lc36M:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc36O
Lc36N:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc350
Lc34Z:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2RP_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2RF_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc350:
	jmp *(%rbx)
Lc36O:
	movq $32,904(%r13)
Lc36L:
	jmp *-16(%r13)
	.long  _s2RQ_info - _s2RQ_info_dsp
.data
.align 3
.align 0
_s2RE_closure:
	.quad	_s2RE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c37S_str:
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	110
	.byte	116
	.byte	0
.text
.align 3
_s2RD_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RD_info)+48
	.quad	0
	.quad	4294967312
_s2RD_info:
Lc37T:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc37U
Lc37V:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c37S_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc37U:
	jmp *-16(%r13)
	.long  _s2RD_info - _s2RD_info_dsp
.text
.align 3
_s2RE_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RE_info)+48
	.quad	0
	.quad	1125904201809942
_s2RE_info:
Lc37W:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc37X
Lc37Y:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc380
Lc37Z:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc37N
Lc37M:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2RD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc37N:
	jmp *(%rbx)
Lc380:
	movq $16,904(%r13)
Lc37X:
	jmp *-16(%r13)
	.long  _s2RE_info - _s2RE_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_intentzuparser_closure
_F95VarDeclParser_intentzuparser_closure:
	.quad	_F95VarDeclParser_intentzuparser_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_intentzuparser_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_intentzuparser_info)+0
	.quad	0
	.quad	-4611686014132420586
.globl _F95VarDeclParser_intentzuparser_info
_F95VarDeclParser_intentzuparser_info:
Lc38j:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc38k
Lc38l:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc38i
Lc38h:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2RE_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2RQ_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc38i:
	jmp *(%rbx)
Lc38k:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_intentzuparser_info - _F95VarDeclParser_intentzuparser_info_dsp
.data
.align 3
.align 0
_s2RZ_closure:
	.quad	_s2RZ_info
	.quad	0
.text
.align 3
_s2RX_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RX_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2RX_info:
Lc38J:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc38K
Lc38L:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc38N
Lc38M:
	movq 7(%rbx),%rax
	leaq _F95VarDecl_MkRange_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -15(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc38N:
	movq $24,904(%r13)
Lc38K:
	jmp *-8(%r13)
	.long  _s2RX_info - _s2RX_info_dsp
.text
.align 3
_s2RY_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RY_info)+0
	.quad	1
	.quad	8800387989521
_s2RY_info:
Lc38O:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc38P
Lc38Q:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc38S
Lc38R:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2RX_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc38S:
	movq $16,904(%r13)
Lc38P:
	jmp *-16(%r13)
	.long  _s2RY_info - _s2RY_info_dsp
.text
.align 3
_s2RU_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2RU_info)+192
	.quad	0
	.quad	4294967312
_s2RU_info:
Lc38Y:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc38Z
Lc390:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc392
Lc391:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $929,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc392:
	movq $24,904(%r13)
Lc38Z:
	jmp *-16(%r13)
	.long  _s2RU_info - _s2RU_info_dsp
.const_data
.align 3
.align 0
_u398_srtd:
	.quad	_S2U6_srt
	.quad	33
	.quad	4311746561
.text
.align 3
_s2RZ_info_dsp:
.text
.align 3
	.quad	_u398_srtd-(_s2RZ_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2RZ_info:
Lc393:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc394
Lc395:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc397
Lc396:
	leaq _s2RY_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2RU_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc397:
	movq $40,904(%r13)
Lc394:
	leaq _s2RZ_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2RZ_info - _s2RZ_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_rangezuexpr_closure
_F95VarDeclParser_rangezuexpr_closure:
	.quad	_F95VarDeclParser_rangezuexpr_info
	.quad	0
	.quad	0
	.quad	0
.const_data
.align 3
.align 0
_u39L_srtd:
	.quad	_S2U6_srt
	.quad	33
	.quad	4294969345
.text
.align 3
_F95VarDeclParser_rangezuexpr_info_dsp:
.text
.align 3
	.quad	_u39L_srtd-(_F95VarDeclParser_rangezuexpr_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_rangezuexpr_info
_F95VarDeclParser_rangezuexpr_info:
Lc39I:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc39J
Lc39K:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc39H
Lc39G:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2RZ_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc39H:
	jmp *(%rbx)
Lc39J:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuexpr_info - _F95VarDeclParser_rangezuexpr_info_dsp
.data
.align 3
.align 0
_s2S4_closure:
	.quad	_s2S4_info
	.quad	0
.text
.align 3
_s2S4_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2S4_info)+264
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2S4_info:
Lc3a3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3a4
Lc3a5:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc3a7
Lc3a6:
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-48(%r12)
	movq $1,-40(%r12)
	leaq -47(%r12),%rax
	leaq _F95VarDecl_Const_con_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	leaq -30(%r12),%rax
	leaq _F95VarDecl_MkRange_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -15(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3a7:
	movq $56,904(%r13)
Lc3a4:
	leaq _s2S4_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2S4_info - _s2S4_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_singlezuexprzurange_closure
_F95VarDeclParser_singlezuexprzurange_closure:
	.quad	_F95VarDeclParser_singlezuexprzurange_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_singlezuexprzurange_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_singlezuexprzurange_info)+88
	.quad	0
	.quad	54043199823413270
.globl _F95VarDeclParser_singlezuexprzurange_info
_F95VarDeclParser_singlezuexprzurange_info:
Lc3an:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ao
Lc3ap:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3am
Lc3al:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2S4_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3am:
	jmp *(%rbx)
Lc3ao:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuexprzurange_info - _F95VarDeclParser_singlezuexprzurange_info_dsp
.data
.align 3
.align 0
_s2Sa_closure:
	.quad	_s2Sa_info
	.quad	0
.text
.align 3
_s2Sa_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sa_info)+272
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2Sa_info:
Lc3aH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3aI
Lc3aJ:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc3aL
Lc3aK:
	leaq _F95VarDecl_Const_con_info(%rip),%rax
	movq %rax,-64(%r12)
	movq %r14,-56(%r12)
	leaq -62(%r12),%rax
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rbx
	movq %rbx,-48(%r12)
	movq $1,-40(%r12)
	leaq -47(%r12),%rbx
	leaq _F95VarDecl_Const_con_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	leaq -30(%r12),%rbx
	leaq _F95VarDecl_MkRange_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -15(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3aL:
	movq $72,904(%r13)
Lc3aI:
	leaq _s2Sa_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2Sa_info - _s2Sa_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_singlezuconstzurange_closure
_F95VarDeclParser_singlezuconstzurange_closure:
	.quad	_F95VarDeclParser_singlezuconstzurange_info
	.quad	0
	.quad	0
	.quad	0
.const_data
.align 3
.align 0
_u3b5_srtd:
	.quad	_S2U6_srt+8
	.quad	35
	.quad	25769803777
.text
.align 3
_F95VarDeclParser_singlezuconstzurange_info_dsp:
.text
.align 3
	.quad	_u3b5_srtd-(_F95VarDeclParser_singlezuconstzurange_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_singlezuconstzurange_info
_F95VarDeclParser_singlezuconstzurange_info:
Lc3b2:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3b3
Lc3b4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3b1
Lc3b0:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2Sa_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3b1:
	jmp *(%rbx)
Lc3b3:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuconstzurange_info - _F95VarDeclParser_singlezuconstzurange_info_dsp
.data
.align 3
.align 0
_s2Sg_closure:
	.quad	_s2Sg_info
	.quad	0
.text
.align 3
_s2Sg_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sg_info)+272
	.quad	4294967301
	.quad	0
	.quad	21474836495
_s2Sg_info:
Lc3bo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3bp
Lc3bq:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc3bs
Lc3br:
	leaq _F95VarDecl_Var_con_info(%rip),%rax
	movq %rax,-64(%r12)
	movq %r14,-56(%r12)
	leaq -63(%r12),%rax
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rbx
	movq %rbx,-48(%r12)
	movq $1,-40(%r12)
	leaq -47(%r12),%rbx
	leaq _F95VarDecl_Const_con_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	leaq -30(%r12),%rbx
	leaq _F95VarDecl_MkRange_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -15(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3bs:
	movq $72,904(%r13)
Lc3bp:
	leaq _s2Sg_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2Sg_info - _s2Sg_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_singlezuvarzurange_closure
_F95VarDeclParser_singlezuvarzurange_closure:
	.quad	_F95VarDeclParser_singlezuvarzurange_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_singlezuvarzurange_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_singlezuvarzurange_info)+40
	.quad	0
	.quad	-6917529023346114538
.globl _F95VarDeclParser_singlezuvarzurange_info
_F95VarDeclParser_singlezuvarzurange_info:
Lc3bJ:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3bK
Lc3bL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3bI
Lc3bH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2Sg_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3bI:
	jmp *(%rbx)
Lc3bK:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuvarzurange_info - _F95VarDeclParser_singlezuvarzurange_info_dsp
.data
.align 3
.align 0
_s2So_closure:
	.quad	_s2So_info
	.quad	0
.text
.align 3
_s2So_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2So_info)+272
	.quad	4294967301
	.quad	0
	.quad	38654705679
_s2So_info:
Lc3bZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3c0
Lc3c1:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3c0:
	leaq _s2So_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2So_info - _s2So_info_dsp
.data
.align 3
.align 0
_s2Sm_closure:
	.quad	_s2Sm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c3ci_str:
	.byte	82
	.byte	97
	.byte	110
	.byte	103
	.byte	101
	.byte	32
	.byte	112
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	32
	.byte	102
	.byte	97
	.byte	105
	.byte	108
	.byte	101
	.byte	100
	.byte	0
.text
.align 3
_s2Sl_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sl_info)+48
	.quad	0
	.quad	4294967312
_s2Sl_info:
Lc3cj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ck
Lc3cl:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3ci_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3ck:
	jmp *-16(%r13)
	.long  _s2Sl_info - _s2Sl_info_dsp
.text
.align 3
_s2Si_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Si_info)+120
	.quad	0
	.quad	108086395351859216
_s2Si_info:
Lc3cy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cz
Lc3cA:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_singlezuconstzurange_closure(%rip),%rsi
	leaq _F95VarDeclParser_singlezuvarzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3cz:
	jmp *-16(%r13)
	.long  _s2Si_info - _s2Si_info_dsp
.text
.align 3
_s2Sj_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sj_info)+120
	.quad	0
	.quad	252201583427715088
_s2Sj_info:
Lc3cB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cC
Lc3cD:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3cF
Lc3cE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Si_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_singlezuexprzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3cF:
	movq $16,904(%r13)
Lc3cC:
	jmp *-16(%r13)
	.long  _s2Sj_info - _s2Sj_info_dsp
.text
.align 3
_s2Sh_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sh_info)+104
	.quad	0
	.quad	1152921508901814288
_s2Sh_info:
Lc3cK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cL
Lc3cM:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3cL:
	jmp *-16(%r13)
	.long  _s2Sh_info - _s2Sh_info_dsp
.text
.align 3
_s2Sk_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sk_info)+104
	.quad	0
	.quad	2161727842612674576
_s2Sk_info:
Lc3cN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cO
Lc3cP:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3cR
Lc3cQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Sj_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2Sh_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3cR:
	movq $32,904(%r13)
Lc3cO:
	jmp *-16(%r13)
	.long  _s2Sk_info - _s2Sk_info_dsp
.const_data
.align 3
.align 0
_u3cX_srtd:
	.quad	_S2U6_srt+48
	.quad	36
	.quad	64424514177
.text
.align 3
_s2Sm_info_dsp:
.text
.align 3
	.quad	_u3cX_srtd-(_s2Sm_info)+0
	.quad	0
	.quad	-4294967274
_s2Sm_info:
Lc3cS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cT
Lc3cU:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3cW
Lc3cV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3cd
Lc3cc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Sl_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2Sk_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3cd:
	jmp *(%rbx)
Lc3cW:
	movq $32,904(%r13)
Lc3cT:
	jmp *-16(%r13)
	.long  _s2Sm_info - _s2Sm_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_rangezuparser_closure
_F95VarDeclParser_rangezuparser_closure:
	.quad	_F95VarDeclParser_rangezuparser_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_rangezuparser_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_rangezuparser_info)+272
	.quad	0
	.quad	1138166333462
.globl _F95VarDeclParser_rangezuparser_info
_F95VarDeclParser_rangezuparser_info:
Lc3dB:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dC
Lc3dD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3dA
Lc3dz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2Sm_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2So_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3dA:
	jmp *(%rbx)
Lc3dC:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuparser_info - _F95VarDeclParser_rangezuparser_info_dsp
.data
.align 3
.align 0
_s2Sv_closure:
	.quad	_s2Sv_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2Su_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Su_info)+272
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2Su_info:
Lc3dY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dZ
Lc3e0:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3dZ:
	jmp *-8(%r13)
	.long  _s2Su_info - _s2Su_info_dsp
.text
.align 3
_s2Sr_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sr_info)+184
	.quad	0
	.quad	4503603922337808
_s2Sr_info:
Lc3e9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ea
Lc3eb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuparser_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3ea:
	jmp *-16(%r13)
	.long  _s2Sr_info - _s2Sr_info_dsp
.const_data
.align 3
.align 0
_u3em_srtd:
	.quad	_S2U6_srt+80
	.quad	34
	.quad	8589942785
.text
.align 3
_s2Ss_info_dsp:
.text
.align 3
	.quad	_u3em_srtd-(_s2Ss_info)+0
	.quad	0
	.quad	-4294967280
_s2Ss_info:
Lc3ec:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ed
Lc3ee:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3eg
Lc3ef:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Sr_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3eg:
	movq $16,904(%r13)
Lc3ed:
	jmp *-16(%r13)
	.long  _s2Ss_info - _s2Ss_info_dsp
.const_data
.align 3
.align 0
_u3en_srtd:
	.quad	_S2U6_srt+80
	.quad	34
	.quad	8606720001
.text
.align 3
_s2Sv_info_dsp:
.text
.align 3
	.quad	_u3en_srtd-(_s2Sv_info)+0
	.quad	0
	.quad	-4294967274
_s2Sv_info:
Lc3eh:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ei
Lc3ej:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3el
Lc3ek:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3dS
Lc3dR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Su_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2Ss_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3dS:
	jmp *(%rbx)
Lc3el:
	movq $32,904(%r13)
Lc3ei:
	jmp *-16(%r13)
	.long  _s2Sv_info - _s2Sv_info_dsp
.data
.align 3
.align 0
_s2Sq_closure:
	.quad	_s2Sq_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c3eW_str:
	.byte	100
	.byte	105
	.byte	109
	.byte	101
	.byte	110
	.byte	115
	.byte	105
	.byte	111
	.byte	110
	.byte	0
.text
.align 3
_s2Sp_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sp_info)+352
	.quad	0
	.quad	4294967312
_s2Sp_info:
Lc3eX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3eY
Lc3eZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3eW_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3eY:
	jmp *-16(%r13)
	.long  _s2Sp_info - _s2Sp_info_dsp
.text
.align 3
_s2Sq_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sq_info)+192
	.quad	0
	.quad	4503603922337814
_s2Sq_info:
Lc3f0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3f1
Lc3f2:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3f4
Lc3f3:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3eR
Lc3eQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Sp_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3eR:
	jmp *(%rbx)
Lc3f4:
	movq $16,904(%r13)
Lc3f1:
	jmp *-16(%r13)
	.long  _s2Sq_info - _s2Sq_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_dimzuparser_closure
_F95VarDeclParser_dimzuparser_closure:
	.quad	_F95VarDeclParser_dimzuparser_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_dimzuparser_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_dimzuparser_info)+272
	.quad	0
	.quad	26392574033942
.globl _F95VarDeclParser_dimzuparser_info
_F95VarDeclParser_dimzuparser_info:
Lc3fn:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fo
Lc3fp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3fm
Lc3fl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2Sq_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2Sv_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3fm:
	jmp *(%rbx)
Lc3fo:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_dimzuparser_info - _F95VarDeclParser_dimzuparser_info_dsp
.data
.align 3
.align 0
_s2SW_closure:
	.quad	_s2SW_info
	.quad	0
.text
.align 3
_s2SQ_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SQ_info)+376
	.quad	1
	.quad	4294967313
_s2SQ_info:
Lc3ge:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gf
Lc3gg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3gf:
	jmp *-16(%r13)
	.long  _s2SQ_info - _s2SQ_info_dsp
.text
.align 3
_s2ST_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2ST_info)+376
	.quad	1
	.quad	30064771089
_s2ST_info:
Lc3gq:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gA
Lc3gB:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3gD
Lc3gC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2SQ_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c3gh_info(%rip),%rcx
	movq %rcx,-32(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqInt_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-56(%rbp)
	movq %rbx,-48(%rbp)
	movq _stg_INTLIKE_closure@GOTPCREL(%rip),%rbx
	addq $257,%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-24(%rbp)
	addq $-56,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3gh_info)+384
	.quad	1
	.quad	4294967328
_c3gh_info:
Lc3gh:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc3go
Lc3gp:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc3go:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3gx
Lc3gw:
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $4,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc3gx:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3gD:
	movq $24,904(%r13)
Lc3gA:
	jmp *-16(%r13)
	.long  _s2ST_info - _s2ST_info_dsp
.text
.align 3
_s2SI_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SI_info)+216
	.quad	0
	.quad	12884901904
_s2SI_info:
Lc3gM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gN
Lc3gO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3gN:
	jmp *-16(%r13)
	.long  _s2SI_info - _s2SI_info_dsp
.const
.align 3
.align 0
_c3gT_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	108
	.byte	0
.text
.align 3
_s2SJ_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SJ_info)+352
	.quad	0
	.quad	4294967312
_s2SJ_info:
Lc3gU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gV
Lc3gW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3gT_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3gV:
	jmp *-16(%r13)
	.long  _s2SJ_info - _s2SJ_info_dsp
.const
.align 3
.align 0
_c3h5_str:
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	103
	.byte	101
	.byte	114
	.byte	0
.text
.align 3
_s2SL_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SL_info)+352
	.quad	0
	.quad	4294967312
_s2SL_info:
Lc3h6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3h7
Lc3h8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3h5_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3h7:
	jmp *-16(%r13)
	.long  _s2SL_info - _s2SL_info_dsp
.const
.align 3
.align 0
_c3hh_str:
	.byte	85
	.byte	110
	.byte	107
	.byte	110
	.byte	111
	.byte	119
	.byte	110
	.byte	32
	.byte	78
	.byte	117
	.byte	109
	.byte	101
	.byte	114
	.byte	105
	.byte	99
	.byte	32
	.byte	84
	.byte	121
	.byte	112
	.byte	101
	.byte	58
	.byte	32
	.byte	0
.text
.align 3
_s2SN_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SN_info)+352
	.quad	0
	.quad	4294967312
_s2SN_info:
Lc3hi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3hj
Lc3hk:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3hh_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3hj:
	jmp *-16(%r13)
	.long  _s2SN_info - _s2SN_info_dsp
.text
.align 3
_s2SP_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SP_info)+216
	.quad	1
	.quad	108649353895215121
_s2SP_info:
Lc3hs:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3hR
Lc3hS:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3hU
Lc3hT:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2SI_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2SJ_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c3gX_info(%rip),%rdx
	movq %rdx,-40(%rbp)
	movq %rbx,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rdx
	movq %rdx,-64(%rbp)
	movq %rax,-56(%rbp)
	movq %rcx,-48(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-64,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3gX_info)+352
	.quad	2
	.quad	828928688160
_c3gX_info:
Lc3gX:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc3hq
Lc3hr:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3hQ
Lc3hP:
	leaq _s2SL_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c3h9_info(%rip),%rdx
	movq %rdx,8(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	addq $-16,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3h9_info)+352
	.quad	1
	.quad	828928688160
_c3h9_info:
Lc3h9:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc3hC
Lc3hD:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3hN
Lc3hM:
	leaq _s2SN_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c3ht_info(%rip),%rcx
	movq %rcx,8(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $8,%rbp
	jmp _stg_ap_pp_fast
Lc3hq:
	leaq _F95VarDecl_F95Real_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2U6_srt-(_c3ht_info)+408
	.quad	0
	.quad	4294967328
_c3ht_info:
Lc3ht:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc3hC:
	leaq _F95VarDecl_F95Integer_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc3hN:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3hQ:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3hU:
	movq $32,904(%r13)
Lc3hR:
	jmp *-16(%r13)
	.long  _s2SP_info - _s2SP_info_dsp
.text
.align 3
_s2SV_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SV_info)+216
	.quad	4294967301
	.quad	1
	.quad	140175101042622474
_s2SV_info:
Lc3hW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3hX
Lc3hY:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc3i0
Lc3hZ:
	movq 7(%rbx),%rax
	leaq _s2ST_info(%rip),%rbx
	movq %rbx,-64(%r12)
	movq %r14,-48(%r12)
	leaq -64(%r12),%rbx
	leaq _s2SP_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rax
	leaq _F95VarDecl_MkVarType_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -15(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3i0:
	movq $72,904(%r13)
Lc3hX:
	jmp *-8(%r13)
	.long  _s2SV_info - _s2SV_info_dsp
.text
.align 3
_s2SB_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SB_info)+192
	.quad	0
	.quad	4294967312
_s2SB_info:
Lc3iq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ir
Lc3is:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3iu
Lc3it:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rax
	movq %rax,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $977,%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3iu:
	movq $24,904(%r13)
Lc3ir:
	jmp *-16(%r13)
	.long  _s2SB_info - _s2SB_info_dsp
.const
.align 3
.align 0
_c3iD_str:
	.byte	107
	.byte	105
	.byte	110
	.byte	100
	.byte	0
.text
.align 3
_s2Sx_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sx_info)+352
	.quad	0
	.quad	4294967312
_s2Sx_info:
Lc3iE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iF
Lc3iG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3iD_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3iF:
	jmp *-16(%r13)
	.long  _s2Sx_info - _s2Sx_info_dsp
.text
.align 3
_s2Sy_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Sy_info)+192
	.quad	0
	.quad	4503603922337808
_s2Sy_info:
Lc3iH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iI
Lc3iJ:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3iL
Lc3iK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Sx_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3iL:
	movq $16,904(%r13)
Lc3iI:
	jmp *-16(%r13)
	.long  _s2Sy_info - _s2Sy_info_dsp
.text
.align 3
_s2SC_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SC_info)+192
	.quad	0
	.quad	4508001968848912
_s2SC_info:
Lc3iM:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iN
Lc3iO:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3iQ
Lc3iP:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2SB_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2Sy_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3iQ:
	movq $32,904(%r13)
Lc3iN:
	jmp *-16(%r13)
	.long  _s2SC_info - _s2SC_info_dsp
.const_data
.align 3
.align 0
_u3jg_srtd:
	.quad	_S2U6_srt+8
	.quad	44
	.quad	8804691345409
.text
.align 3
_s2SD_info_dsp:
.text
.align 3
	.quad	_u3jg_srtd-(_s2SD_info)+0
	.quad	0
	.quad	-4294967280
_s2SD_info:
Lc3iR:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iS
Lc3iT:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3iV
Lc3iU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2SC_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3iV:
	movq $16,904(%r13)
Lc3iS:
	jmp *-16(%r13)
	.long  _s2SD_info - _s2SD_info_dsp
.const_data
.align 3
.align 0
_u3jh_srtd:
	.quad	_S2U6_srt+8
	.quad	44
	.quad	8804691361793
.text
.align 3
_s2SE_info_dsp:
.text
.align 3
	.quad	_u3jh_srtd-(_s2SE_info)+0
	.quad	0
	.quad	-4294967280
_s2SE_info:
Lc3iW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iX
Lc3iY:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3j0
Lc3iZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2SD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95ParserCommon_natural_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3j0:
	movq $16,904(%r13)
Lc3iX:
	jmp *-16(%r13)
	.long  _s2SE_info - _s2SE_info_dsp
.const_data
.align 3
.align 0
_u3ji_srtd:
	.quad	_S2U6_srt+8
	.quad	44
	.quad	8804691362305
.text
.align 3
_s2SF_info_dsp:
.text
.align 3
	.quad	_u3ji_srtd-(_s2SF_info)+0
	.quad	0
	.quad	-4294967280
_s2SF_info:
Lc3j1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3j2
Lc3j3:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3j5
Lc3j4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2SE_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3j5:
	movq $16,904(%r13)
Lc3j2:
	jmp *-16(%r13)
	.long  _s2SF_info - _s2SF_info_dsp
.const_data
.align 3
.align 0
_u3jj_srtd:
	.quad	_S2U6_srt+8
	.quad	52
	.quad	2260604505047553
.text
.align 3
_s2SG_info_dsp:
.text
.align 3
	.quad	_u3jj_srtd-(_s2SG_info)+0
	.quad	0
	.quad	-4294967280
_s2SG_info:
Lc3j6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3j7
Lc3j8:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3ja
Lc3j9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2SF_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3ja:
	movq $16,904(%r13)
Lc3j7:
	jmp *-16(%r13)
	.long  _s2SG_info - _s2SG_info_dsp
.const_data
.align 3
.align 0
_u3jk_srtd:
	.quad	_S2U6_srt+8
	.quad	53
	.quad	8945635403252225
.text
.align 3
_s2SW_info_dsp:
.text
.align 3
	.quad	_u3jk_srtd-(_s2SW_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2SW_info:
Lc3jb:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jc
Lc3jd:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3jf
Lc3je:
	leaq _s2SV_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2SG_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3jf:
	movq $32,904(%r13)
Lc3jc:
	leaq _s2SW_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2SW_info - _s2SW_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_typezuparser_closure
_F95VarDeclParser_typezuparser_closure:
	.quad	_F95VarDeclParser_typezuparser_info
	.quad	0
	.quad	0
	.quad	0
.const_data
.align 3
.align 0
_u3lm_srtd:
	.quad	_S2U6_srt+40
	.quad	49
	.quad	281475513581569
.text
.align 3
_F95VarDeclParser_typezuparser_info_dsp:
.text
.align 3
	.quad	_u3lm_srtd-(_F95VarDeclParser_typezuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_typezuparser_info
_F95VarDeclParser_typezuparser_info:
Lc3lj:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3lk
Lc3ll:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3li
Lc3lh:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2SW_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3li:
	jmp *(%rbx)
Lc3lk:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_typezuparser_info - _F95VarDeclParser_typezuparser_info_dsp
.data
.align 3
.align 0
_s2Tf_closure:
	.quad	_s2Tf_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2T3_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2T3_info)+216
	.quad	0
	.quad	12884901904
_s2T3_info:
Lc3mn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3mo
Lc3mp:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3mo:
	jmp *-16(%r13)
	.long  _s2T3_info - _s2T3_info_dsp
.const
.align 3
.align 0
_c3mu_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	100
	.byte	0
.text
.align 3
_s2T4_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2T4_info)+352
	.quad	0
	.quad	4294967312
_s2T4_info:
Lc3mv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3mw
Lc3mx:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3mu_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3mw:
	jmp *-16(%r13)
	.long  _s2T4_info - _s2T4_info_dsp
.const
.align 3
.align 0
_c3mG_str:
	.byte	119
	.byte	114
	.byte	105
	.byte	116
	.byte	101
	.byte	0
.text
.align 3
_s2T6_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2T6_info)+352
	.quad	0
	.quad	4294967312
_s2T6_info:
Lc3mH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3mI
Lc3mJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3mG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3mI:
	jmp *-16(%r13)
	.long  _s2T6_info - _s2T6_info_dsp
.const
.align 3
.align 0
_c3mS_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	100
	.byte	119
	.byte	114
	.byte	105
	.byte	116
	.byte	101
	.byte	0
.text
.align 3
_s2T8_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2T8_info)+352
	.quad	0
	.quad	4294967312
_s2T8_info:
Lc3mT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3mU
Lc3mV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3mS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3mU:
	jmp *-16(%r13)
	.long  _s2T8_info - _s2T8_info_dsp
.const
.align 3
.align 0
_c3n8_str:
	.byte	46
	.byte	46
	.byte	47
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
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	40
	.byte	49
	.byte	49
	.byte	57
	.byte	44
	.byte	49
	.byte	51
	.byte	41
	.byte	45
	.byte	40
	.byte	49
	.byte	50
	.byte	50
	.byte	44
	.byte	53
	.byte	49
	.byte	41
	.byte	124
	.byte	102
	.byte	117
	.byte	110
	.byte	99
	.byte	116
	.byte	105
	.byte	111
	.byte	110
	.byte	32
	.byte	111
	.byte	99
	.byte	108
	.byte	97
	.byte	114
	.byte	103
	.byte	109
	.byte	111
	.byte	100
	.byte	101
	.byte	0
.text
.align 3
_s2Ta_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Ta_info)+216
	.quad	1
	.quad	562980018192401
_s2Ta_info:
Lc3n3:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3nD
Lc3nE:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3nG
Lc3nF:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2T3_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2T4_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c3my_info(%rip),%rdx
	movq %rdx,-40(%rbp)
	movq %rbx,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rdx
	movq %rdx,-64(%rbp)
	movq %rax,-56(%rbp)
	movq %rcx,-48(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-64,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3my_info)+232
	.quad	2
	.quad	140741783322656
_c3my_info:
Lc3my:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc3n1
Lc3n2:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3nC
Lc3nB:
	leaq _s2T6_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c3mK_info(%rip),%rdx
	movq %rdx,(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rbx,-8(%rbp)
	addq $-24,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3mK_info)+232
	.quad	2
	.quad	140741783322656
_c3mK_info:
Lc3mK:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc3nh
Lc3ni:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3nz
Lc3ny:
	leaq _s2T8_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c3n4_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc3n1:
	leaq _F95VarDecl_Read_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2U6_srt-(_c3n4_info)+232
	.quad	0
	.quad	4294967328
_c3n4_info:
Lc3n4:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc3nr
Lc3ns:
	leaq _c3n8_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc3nh:
	leaq _F95VarDecl_Write_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc3nr:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc3nz:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3nC:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3nG:
	movq $32,904(%r13)
Lc3nD:
	jmp *-16(%r13)
	.long  _s2Ta_info - _s2Ta_info_dsp
.text
.align 3
_s2Tb_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tb_info)+216
	.quad	4294967301
	.quad	4294967296
	.quad	563529774006283
_s2Tb_info:
Lc3nH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3nI
Lc3nJ:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3nL
Lc3nK:
	leaq _s2Ta_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3nL:
	movq $24,904(%r13)
Lc3nI:
	jmp *-8(%r13)
	.long  _s2Tb_info - _s2Tb_info_dsp
.const_data
.align 3
.align 0
_u3on_srtd:
	.quad	_S2U6_srt+40
	.quad	40
	.quad	550322044929
.text
.align 3
_s2Tc_info_dsp:
.text
.align 3
	.quad	_u3on_srtd-(_s2Tc_info)+0
	.quad	0
	.quad	-4294967280
_s2Tc_info:
Lc3nM:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3nN
Lc3nO:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3nQ
Lc3nP:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Tb_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3nQ:
	movq $16,904(%r13)
Lc3nN:
	jmp *-16(%r13)
	.long  _s2Tc_info - _s2Tc_info_dsp
.const_data
.align 3
.align 0
_u3oo_srtd:
	.quad	_S2U6_srt+40
	.quad	40
	.quad	550322044929
.text
.align 3
_s2Td_info_dsp:
.text
.align 3
	.quad	_u3oo_srtd-(_s2Td_info)+0
	.quad	0
	.quad	-4294967280
_s2Td_info:
Lc3nR:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3nS
Lc3nT:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3nV
Lc3nU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Tc_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3nV:
	movq $16,904(%r13)
Lc3nS:
	jmp *-16(%r13)
	.long  _s2Td_info - _s2Td_info_dsp
.const
.align 3
.align 0
_c3o4_str:
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	0
.text
.align 3
_s2T0_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2T0_info)+352
	.quad	0
	.quad	4294967312
_s2T0_info:
Lc3o5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3o6
Lc3o7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3o4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3o6:
	jmp *-16(%r13)
	.long  _s2T0_info - _s2T0_info_dsp
.text
.align 3
_s2T1_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2T1_info)+192
	.quad	0
	.quad	4503603922337808
_s2T1_info:
Lc3o8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3o9
Lc3oa:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3oc
Lc3ob:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2T0_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3oc:
	movq $16,904(%r13)
Lc3o9:
	jmp *-16(%r13)
	.long  _s2T1_info - _s2T1_info_dsp
.const_data
.align 3
.align 0
_u3op_srtd:
	.quad	_S2U6_srt+40
	.quad	40
	.quad	550322569217
.text
.align 3
_s2Te_info_dsp:
.text
.align 3
	.quad	_u3op_srtd-(_s2Te_info)+0
	.quad	0
	.quad	-4294967280
_s2Te_info:
Lc3od:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3oe
Lc3of:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3oh
Lc3og:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Td_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2T1_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3oh:
	movq $32,904(%r13)
Lc3oe:
	jmp *-16(%r13)
	.long  _s2Te_info - _s2Te_info_dsp
.const_data
.align 3
.align 0
_u3oq_srtd:
	.quad	_S2U6_srt+40
	.quad	50
	.quad	563500275990529
.text
.align 3
_s2Tf_info_dsp:
.text
.align 3
	.quad	_u3oq_srtd-(_s2Tf_info)+0
	.quad	0
	.quad	-4294967274
_s2Tf_info:
Lc3oi:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3oj
Lc3ok:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3om
Lc3ol:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3lX
Lc3lW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2Te_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95ParserCommon_whiteSpace_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3lX:
	jmp *(%rbx)
Lc3om:
	movq $16,904(%r13)
Lc3oj:
	jmp *-16(%r13)
	.long  _s2Tf_info - _s2Tf_info_dsp
.data
.align 3
.align 0
_s2SZ_closure:
	.quad	_s2SZ_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2SX_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SX_info)+440
	.quad	0
	.quad	12884901904
_s2SX_info:
Lc3pZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3q0
Lc3q1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3q0:
	jmp *-16(%r13)
	.long  _s2SX_info - _s2SX_info_dsp
.text
.align 3
_s2SZ_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2SZ_info)+440
	.quad	0
	.quad	30064771094
_s2SZ_info:
Lc3q2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3q3
Lc3q4:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3q6
Lc3q5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3pU
Lc3pT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2SX_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rbx
	leaq 529(%rbx),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3pU:
	jmp *(%rbx)
Lc3q6:
	movq $16,904(%r13)
Lc3q3:
	jmp *-16(%r13)
	.long  _s2SZ_info - _s2SZ_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_oclzuargmodezuparser_closure
_F95VarDeclParser_oclzuargmodezuparser_closure:
	.quad	_F95VarDeclParser_oclzuargmodezuparser_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95VarDeclParser_oclzuargmodezuparser_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_F95VarDeclParser_oclzuargmodezuparser_info)+272
	.quad	0
	.quad	216172786408751126
.globl _F95VarDeclParser_oclzuargmodezuparser_info
_F95VarDeclParser_oclzuargmodezuparser_info:
Lc3qp:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3qq
Lc3qr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3qo
Lc3qn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2SZ_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2Tf_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3qo:
	jmp *(%rbx)
Lc3qq:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_oclzuargmodezuparser_info - _F95VarDeclParser_oclzuargmodezuparser_info_dsp
.data
.align 3
.align 0
_s2TJ_closure:
	.quad	_s2TJ_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2Tp_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tp_info)+376
	.quad	1
	.quad	4294967313
_s2Tp_info:
Lc3rl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3rm
Lc3rn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3rm:
	jmp *-16(%r13)
	.long  _s2Tp_info - _s2Tp_info_dsp
.text
.align 3
_s2To_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2To_info)+376
	.quad	1
	.quad	30064771089
_s2To_info:
Lc3rx:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3rE
Lc3rF:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3rH
Lc3rG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Tp_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c3ro_info(%rip),%rcx
	movq %rcx,-32(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqInt_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-56(%rbp)
	movq %rbx,-48(%rbp)
	movq _stg_INTLIKE_closure@GOTPCREL(%rip),%rbx
	addq $257,%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-24(%rbp)
	addq $-56,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3ro_info)+384
	.quad	1
	.quad	4294967328
_c3ro_info:
Lc3ro:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc3rv
Lc3rw:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc3rv:
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc3rH:
	movq $24,904(%r13)
Lc3rE:
	jmp *-16(%r13)
	.long  _s2To_info - _s2To_info_dsp
.text
.align 3
_s2Tt_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tt_info)+376
	.quad	1
	.quad	4294967313
_s2Tt_info:
Lc3rQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3rR
Lc3rS:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3rR:
	jmp *-16(%r13)
	.long  _s2Tt_info - _s2Tt_info_dsp
.text
.align 3
_s2Ts_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Ts_info)+376
	.quad	1
	.quad	30064771089
_s2Ts_info:
Lc3s2:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3s9
Lc3sa:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3sc
Lc3sb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Tt_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c3rT_info(%rip),%rcx
	movq %rcx,-32(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqInt_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-56(%rbp)
	movq %rbx,-48(%rbp)
	movq _stg_INTLIKE_closure@GOTPCREL(%rip),%rbx
	addq $257,%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-24(%rbp)
	addq $-56,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3rT_info)+384
	.quad	1
	.quad	4294967328
_c3rT_info:
Lc3rT:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc3s0
Lc3s1:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc3s0:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc3sc:
	movq $24,904(%r13)
Lc3s9:
	jmp *-16(%r13)
	.long  _s2Ts_info - _s2Ts_info_dsp
.text
.align 3
_s2Tz_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tz_info)+376
	.quad	1
	.quad	4294967313
_s2Tz_info:
Lc3sE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3sF
Lc3sG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3sF:
	jmp *-16(%r13)
	.long  _s2Tz_info - _s2Tz_info_dsp
.text
.align 3
_s2TC_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2TC_info)+376
	.quad	1
	.quad	30064771089
_s2TC_info:
Lc3sQ:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3sX
Lc3sY:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3t0
Lc3sZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Tz_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c3sH_info(%rip),%rcx
	movq %rcx,-32(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqInt_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-56(%rbp)
	movq %rbx,-48(%rbp)
	movq _stg_INTLIKE_closure@GOTPCREL(%rip),%rbx
	addq $257,%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-24(%rbp)
	addq $-56,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2U6_srt-(_c3sH_info)+384
	.quad	1
	.quad	4294967328
_c3sH_info:
Lc3sH:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc3sO
Lc3sP:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc3sO:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc3t0:
	movq $24,904(%r13)
Lc3sX:
	jmp *-16(%r13)
	.long  _s2TC_info - _s2TC_info_dsp
.text
.align 3
_s2TE_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2TE_info)+272
	.quad	4294967301
	.quad	4
	.quad	246294899589129
_s2TE_info:
Lc3t2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3t3
Lc3t4:
	addq $96,%r12
	cmpq 856(%r13),%r12
	ja Lc3t6
Lc3t5:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rdx
	movq 31(%rbx),%rbx
	leaq _s2TC_info(%rip),%rsi
	movq %rsi,-88(%r12)
	movq %r14,-72(%r12)
	leaq -88(%r12),%rsi
	leaq _F95VarDecl_MkVarDecl_con_info(%rip),%rdi
	movq %rdi,-64(%r12)
	movq %rax,-56(%r12)
	movq %rcx,-48(%r12)
	movq %rdx,-40(%r12)
	movq %rbx,-32(%r12)
	movq %rsi,-24(%r12)
	leaq _ghczmprim_GHCziTypes_True_closure+2(%rip),%rax
	movq %rax,-16(%r12)
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -63(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc3t6:
	movq $96,904(%r13)
Lc3t3:
	jmp *-8(%r13)
	.long  _s2TE_info - _s2TE_info_dsp
.text
.align 3
_s2Tx_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tx_info)+416
	.quad	0
	.quad	1103806595088
_s2Tx_info:
Lc3tb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tc
Lc3td:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_oclzuargmodezuparser_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3tc:
	jmp *-16(%r13)
	.long  _s2Tx_info - _s2Tx_info_dsp
.text
.align 3
_s2TF_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2TF_info)+272
	.quad	4294967301
	.quad	3
	.quad	289602570958143497
_s2TF_info:
Lc3te:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tf
Lc3tg:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc3ti
Lc3th:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _s2TE_info(%rip),%rdx
	movq %rdx,-48(%r12)
	movq %rax,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	leaq -47(%r12),%rax
	leaq _s2Tx_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3ti:
	movq $56,904(%r13)
Lc3tf:
	jmp *-8(%r13)
	.long  _s2TF_info - _s2TF_info_dsp
.text
.align 3
_s2TG_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2TG_info)+272
	.quad	4294967301
	.quad	2
	.quad	866063323261566988
_s2TG_info:
Lc3tj:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tk
Lc3tl:
	addq $80,%r12
	cmpq 856(%r13),%r12
	ja Lc3tn
Lc3tm:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _s2To_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %rbx,-56(%r12)
	leaq -72(%r12),%rbx
	leaq _s2Ts_info(%rip),%rcx
	movq %rcx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rcx
	leaq _s2TF_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-16(%r12)
	movq %rbx,-8(%r12)
	movq %rcx,(%r12)
	leaq -23(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-24(%rbp)
	leaq _F95VarDeclParser_arglistzuparser_closure(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3tn:
	movq $80,904(%r13)
Lc3tk:
	jmp *-8(%r13)
	.long  _s2TG_info - _s2TG_info_dsp
.text
.align 3
_s2Tl_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tl_info)+272
	.quad	0
	.quad	3458764518115508240
_s2Tl_info:
Lc3tw:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tx
Lc3ty:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_comma_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _F95VarDeclParser_intentzuparser_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3tx:
	jmp *-16(%r13)
	.long  _s2Tl_info - _s2Tl_info_dsp
.text
.align 3
_s2Tm_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Tm_info)+272
	.quad	0
	.quad	3459890418022350864
_s2Tm_info:
Lc3tz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tA
Lc3tB:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3tD
Lc3tC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Tl_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3tD:
	movq $16,904(%r13)
Lc3tA:
	jmp *-16(%r13)
	.long  _s2Tm_info - _s2Tm_info_dsp
.text
.align 3
_s2TH_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2TH_info)+272
	.quad	4294967301
	.quad	1
	.quad	4324827837082107914
_s2TH_info:
Lc3tE:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tF
Lc3tG:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc3tI
Lc3tH:
	movq 7(%rbx),%rax
	leaq _s2TG_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -31(%r12),%rax
	leaq _s2Tm_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3tI:
	movq $40,904(%r13)
Lc3tF:
	jmp *-8(%r13)
	.long  _s2TH_info - _s2TH_info_dsp
.text
.align 3
_s2Th_info_dsp:
.text
.align 3
	.quad	_S2U6_srt-(_s2Th_info)+272
	.quad	0
	.quad	5764607527329202192
_s2Th_info:
Lc3tV:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tW
Lc3tX:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_comma_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _F95VarDeclParser_dimzuparser_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3tW:
	jmp *-16(%r13)
	.long  _s2Th_info - _s2Th_info_dsp
.const_data
.align 3
.align 0
_u3ui_srtd:
	.quad	_S2U6_srt+104
	.quad	52
	.quad	2814749769203713
.text
.align 3
_s2Ti_info_dsp:
.text
.align 3
	.quad	_u3ui_srtd-(_s2Ti_info)+0
	.quad	0
	.quad	-4294967280
_s2Ti_info:
Lc3tY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3tZ
Lc3u0:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3u2
Lc3u1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Th_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3u2:
	movq $16,904(%r13)
Lc3tZ:
	jmp *-16(%r13)
	.long  _s2Ti_info - _s2Ti_info_dsp
.const_data
.align 3
.align 0
_u3uj_srtd:
	.quad	_S2U6_srt+104
	.quad	52
	.quad	2815299525017601
.text
.align 3
_s2Tj_info_dsp:
.text
.align 3
	.quad	_u3uj_srtd-(_s2Tj_info)+0
	.quad	0
	.quad	-4294967280
_s2Tj_info:
Lc3u3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3u4
Lc3u5:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3u7
Lc3u6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2Ti_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3u7:
	movq $16,904(%r13)
Lc3u4:
	jmp *-16(%r13)
	.long  _s2Tj_info - _s2Tj_info_dsp
.const_data
.align 3
.align 0
_u3uk_srtd:
	.quad	_S2U6_srt+104
	.quad	52
	.quad	4363532156010497
.text
.align 3
_s2TI_info_dsp:
.text
.align 3
	.quad	_u3uk_srtd-(_s2TI_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	-4294967285
_s2TI_info:
Lc3u8:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3u9
Lc3ua:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3uc
Lc3ub:
	leaq _s2TH_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2Tj_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3uc:
	movq $32,904(%r13)
Lc3u9:
	jmp *-8(%r13)
	.long  _s2TI_info - _s2TI_info_dsp
.const_data
.align 3
.align 0
_u3ul_srtd:
	.quad	_S2U6_srt+104
	.quad	53
	.quad	8867131783380993
.text
.align 3
_s2TJ_info_dsp:
.text
.align 3
	.quad	_u3ul_srtd-(_s2TJ_info)+0
	.quad	0
	.quad	-4294967274
_s2TJ_info:
Lc3ud:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ue
Lc3uf:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3uh
Lc3ug:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3qX
Lc3qW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2TI_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95VarDeclParser_typezuparser_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc3qX:
	jmp *(%rbx)
Lc3uh:
	movq $16,904(%r13)
Lc3ue:
	jmp *-16(%r13)
	.long  _s2TJ_info - _s2TJ_info_dsp
.data
.align 3
.align 0
.globl _F95VarDeclParser_f95zuvarzudeclzuparser_closure
_F95VarDeclParser_f95zuvarzudeclzuparser_closure:
	.quad	_F95VarDeclParser_f95zuvarzudeclzuparser_info
	.quad	0
	.quad	0
	.quad	0
.const_data
.align 3
.align 0
_u3wu_srtd:
	.quad	_S2U6_srt+272
	.quad	33
	.quad	4296015873
.text
.align 3
_F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp:
.text
.align 3
	.quad	_u3wu_srtd-(_F95VarDeclParser_f95zuvarzudeclzuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_f95zuvarzudeclzuparser_info
_F95VarDeclParser_f95zuvarzudeclzuparser_info:
Lc3wr:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ws
Lc3wt:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3wq
Lc3wp:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_whiteSpace_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2TJ_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3wq:
	jmp *(%rbx)
Lc3ws:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_f95zuvarzudeclzuparser_info - _F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp
.const_data
.align 3
.align 0
_S2U6_srt:
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_F95ParserCommon_natural_closure
	.quad	_F95ParserCommon_reservedOp_closure
	.quad	_r2LW_closure
	.quad	_r2Qt_closure
	.quad	_F95ParserCommon_word_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure
	.quad	_F95VarDeclParser_term_closure
	.quad	_F95VarDeclParser_optable_closure
	.quad	_F95ParserCommon_parens_closure
	.quad	_F95VarDeclParser_exprzuparser_closure
	.quad	_s2Rq_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95VarDeclParser_arrayzuidxzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure
	.quad	_F95VarDeclParser_varzuexpr_closure
	.quad	_F95VarDeclParser_constzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure
	.quad	_s2Rj_closure
	.quad	_s2Rk_closure
	.quad	_s2Rv_closure
	.quad	_s2Rw_closure
	.quad	_F95ParserCommon_commaSep_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_s2Ry_closure
	.quad	_s2RC_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_base_ControlziExceptionziBase_patError_closure
	.quad	_s2RE_closure
	.quad	_s2RQ_closure
	.quad	_s2RZ_closure
	.quad	_s2S4_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_s2Sa_closure
	.quad	_s2Sg_closure
	.quad	_s2So_closure
	.quad	_F95VarDeclParser_singlezuvarzurange_closure
	.quad	_F95VarDeclParser_singlezuconstzurange_closure
	.quad	_F95VarDeclParser_singlezuexprzurange_closure
	.quad	_F95VarDeclParser_rangezuexpr_closure
	.quad	_s2Sm_closure
	.quad	_F95VarDeclParser_rangezuparser_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_s2Sq_closure
	.quad	_s2Sv_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziList_head_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqInt_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_many_closure
	.quad	_s2SW_closure
	.quad	_F95ParserCommon_whiteSpace_closure
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_s2SZ_closure
	.quad	_s2Tf_closure
	.quad	_F95VarDeclParser_oclzuargmodezuparser_closure
	.quad	_F95VarDeclParser_arglistzuparser_closure
	.quad	_F95ParserCommon_comma_closure
	.quad	_F95VarDeclParser_intentzuparser_closure
	.quad	_F95VarDeclParser_dimzuparser_closure
	.quad	_F95VarDeclParser_typezuparser_closure
	.quad	_s2TJ_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

