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
_s2pG_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pG_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2pG_info:
Lc2v4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2v5
Lc2v6:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2v8
Lc2v7:
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
Lc2v8:
	movq $16,904(%r13)
Lc2v5:
	jmp *-8(%r13)
	.long  _s2pG_info - _s2pG_info_dsp
.text
.align 3
_F95VarDeclParser_constzuexpr_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_F95VarDeclParser_constzuexpr_info)+0
	.quad	0
	.quad	12884901910
.globl _F95VarDeclParser_constzuexpr_info
_F95VarDeclParser_constzuexpr_info:
Lc2v9:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2va
Lc2vb:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vd
Lc2vc:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2uX
Lc2uW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2pG_info(%rip),%rax
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
Lc2uX:
	jmp *(%rbx)
Lc2vd:
	movq $16,904(%r13)
Lc2va:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_constzuexpr_info - _F95VarDeclParser_constzuexpr_info_dsp
.data
.align 3
.align 0
_r2kH_closure:
	.quad	_r2kH_info
	.quad	0
.text
.align 3
_s2pL_info_dsp:
.text
.align 3
	.quad	4294967301
	.quad	1
	.quad	10
_s2pL_info:
Lc2vM:
Lc2vO:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2vQ
Lc2vP:
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
Lc2vQ:
	movq $40,904(%r13)
Lc2vN:
	jmp *-8(%r13)
	.long  _s2pL_info - _s2pL_info_dsp
.text
.align 3
_s2pM_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pM_info)+0
	.quad	1
	.quad	4294967313
_s2pM_info:
Lc2vR:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vS
Lc2vT:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vV
Lc2vU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pL_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2vV:
	movq $16,904(%r13)
Lc2vS:
	jmp *-16(%r13)
	.long  _s2pM_info - _s2pM_info_dsp
.text
.align 3
_s2pI_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pI_info)+16
	.quad	1
	.quad	4294967313
_s2pI_info:
Lc2w0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w1
Lc2w2:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2w1:
	jmp *-16(%r13)
	.long  _s2pI_info - _s2pI_info_dsp
.text
.align 3
_s2pN_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pN_info)+0
	.quad	1
	.quad	21474836497
_s2pN_info:
Lc2w3:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w4
Lc2w5:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2w7
Lc2w6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pM_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2pI_info(%rip),%rcx
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
Lc2w7:
	movq $48,904(%r13)
Lc2w4:
	jmp *-16(%r13)
	.long  _s2pN_info - _s2pN_info_dsp
.text
.align 3
_r2kH_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2kH_info)+0
	.quad	4294967301
	.quad	0
	.quad	55834574863
_r2kH_info:
Lc2w9:
Lc2wb:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wd
Lc2wc:
	leaq _s2pN_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_Prefix_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2wd:
	movq $40,904(%r13)
Lc2wa:
	leaq _r2kH_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2kH_info - _r2kH_info_dsp
.data
.align 3
.align 0
_r2pm_closure:
	.quad	_r2pm_info
	.quad	0
.text
.align 3
_s2pU_info_dsp:
.text
.align 3
	.quad	8589934607
	.quad	1
	.quad	10
_s2pU_info:
Lc2wY:
Lc2x0:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2x2
Lc2x1:
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
Lc2x2:
	movq $48,904(%r13)
Lc2wZ:
	jmp *-8(%r13)
	.long  _s2pU_info - _s2pU_info_dsp
.text
.align 3
_s2pV_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pV_info)+0
	.quad	1
	.quad	4294967313
_s2pV_info:
Lc2x3:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2x4
Lc2x5:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2x7
Lc2x6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pU_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2x7:
	movq $16,904(%r13)
Lc2x4:
	jmp *-16(%r13)
	.long  _s2pV_info - _s2pV_info_dsp
.text
.align 3
_s2pQ_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pQ_info)+16
	.quad	1
	.quad	4294967313
_s2pQ_info:
Lc2xc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xd
Lc2xe:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xd:
	jmp *-16(%r13)
	.long  _s2pQ_info - _s2pQ_info_dsp
.text
.align 3
_s2pW_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2pW_info)+0
	.quad	1
	.quad	21474836497
_s2pW_info:
Lc2xf:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xg
Lc2xh:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xj
Lc2xi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pV_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2pQ_info(%rip),%rcx
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
Lc2xj:
	movq $48,904(%r13)
Lc2xg:
	jmp *-16(%r13)
	.long  _s2pW_info - _s2pW_info_dsp
.text
.align 3
_r2pm_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pm_info)+0
	.quad	8589934607
	.quad	0
	.quad	90194313231
_r2pm_info:
Lc2xl:
Lc2xn:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xp
Lc2xo:
	leaq _s2pW_info(%rip),%rax
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
Lc2xp:
	movq $48,904(%r13)
Lc2xm:
	leaq _r2pm_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2pm_info - _r2pm_info_dsp
.data
.align 3
.align 0
_r2pn_closure:
	.quad	_r2pn_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pn_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pn_info)+24
	.quad	0
	.quad	4294967318
_r2pn_info:
Lc2xY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xZ
Lc2y0:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2y2
Lc2y1:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xW
Lc2xV:
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
	jmp _r2kH_info
Lc2xW:
	jmp *(%rbx)
Lc2y2:
	movq $24,904(%r13)
Lc2xZ:
	jmp *-16(%r13)
	.long  _r2pn_info - _r2pn_info_dsp
.data
.align 3
.align 0
_r2po_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pn_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pp_closure:
	.quad	_r2pp_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pp_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pp_info)+32
	.quad	0
	.quad	4294967318
_r2pp_info:
Lc2ym:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yn
Lc2yo:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yq
Lc2yp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yk
Lc2yj:
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
	jmp _r2pm_info
Lc2yk:
	jmp *(%rbx)
Lc2yq:
	movq $24,904(%r13)
Lc2yn:
	jmp *-16(%r13)
	.long  _r2pp_info - _r2pp_info_dsp
.data
.align 3
.align 0
_r2pq_closure:
	.quad	_r2pq_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pq_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pq_info)+32
	.quad	0
	.quad	4294967318
_r2pq_info:
Lc2yI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yJ
Lc2yK:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yM
Lc2yL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yG
Lc2yF:
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
	jmp _r2pm_info
Lc2yG:
	jmp *(%rbx)
Lc2yM:
	movq $24,904(%r13)
Lc2yJ:
	jmp *-16(%r13)
	.long  _r2pq_info - _r2pq_info_dsp
.data
.align 3
.align 0
_r2pr_closure:
	.quad	_r2pr_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pr_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pr_info)+32
	.quad	0
	.quad	4294967318
_r2pr_info:
Lc2z4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z5
Lc2z6:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2z8
Lc2z7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2z2
Lc2z1:
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
	jmp _r2pm_info
Lc2z2:
	jmp *(%rbx)
Lc2z8:
	movq $24,904(%r13)
Lc2z5:
	jmp *-16(%r13)
	.long  _r2pr_info - _r2pr_info_dsp
.data
.align 3
.align 0
_r2ps_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pr_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pt_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pq_closure
	.quad	_r2ps_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pu_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pp_closure
	.quad	_r2pt_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pv_closure:
	.quad	_r2pv_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pv_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pv_info)+32
	.quad	0
	.quad	4294967318
_r2pv_info:
Lc2zw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zx
Lc2zy:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zA
Lc2zz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zu
Lc2zt:
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
	jmp _r2pm_info
Lc2zu:
	jmp *(%rbx)
Lc2zA:
	movq $24,904(%r13)
Lc2zx:
	jmp *-16(%r13)
	.long  _r2pv_info - _r2pv_info_dsp
.data
.align 3
.align 0
_r2pw_closure:
	.quad	_r2pw_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pw_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_r2pw_info)+32
	.quad	0
	.quad	4294967318
_r2pw_info:
Lc2zS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zT
Lc2zU:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zW
Lc2zV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zQ
Lc2zP:
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
	jmp _r2pm_info
Lc2zQ:
	jmp *(%rbx)
Lc2zW:
	movq $24,904(%r13)
Lc2zT:
	jmp *-16(%r13)
	.long  _r2pw_info - _r2pw_info_dsp
.data
.align 3
.align 0
_r2px_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pw_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2py_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pv_closure
	.quad	_r2px_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2py_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pu_closure+2
	.quad	_r2pz_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95VarDeclParser_optable_closure
_F95VarDeclParser_optable_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2po_closure+2
	.quad	_r2pA_closure+2
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
_s2qb_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qb_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2qb_info:
Lc2At:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Au
Lc2Av:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ax
Lc2Aw:
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
Lc2Ax:
	movq $16,904(%r13)
Lc2Au:
	jmp *-8(%r13)
	.long  _s2qb_info - _s2qb_info_dsp
.text
.align 3
_F95VarDeclParser_varzuexpr_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_F95VarDeclParser_varzuexpr_info)+0
	.quad	0
	.quad	141733920790
.globl _F95VarDeclParser_varzuexpr_info
_F95VarDeclParser_varzuexpr_info:
Lc2Ay:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Az
Lc2AA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2AC
Lc2AB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Am
Lc2Al:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qb_info(%rip),%rax
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
Lc2Am:
	jmp *(%rbx)
Lc2AC:
	movq $16,904(%r13)
Lc2Az:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_varzuexpr_info - _F95VarDeclParser_varzuexpr_info_dsp
.data
.align 3
.align 0
_s2qd_closure:
	.quad	_s2qd_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2B6_str:
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
_s2qd_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qd_info)+48
	.quad	0
	.quad	4294967318
_s2qd_info:
Lc2B7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2B8
Lc2B9:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2B5
Lc2B4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2B6_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2B5:
	jmp *(%rbx)
Lc2B8:
	jmp *-16(%r13)
	.long  _s2qd_info - _s2qd_info_dsp
.data
.align 3
.align 0
_s2qc_closure:
	.quad	_s2qc_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qc_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qc_info)+56
	.quad	0
	.quad	30064771094
_s2qc_info:
Lc2Bg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bh
Lc2Bi:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Bf
Lc2Be:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95VarDeclParser_term_closure(%rip),%rsi
	leaq _F95VarDeclParser_optable_closure+2(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Bf:
	jmp *(%rbx)
Lc2Bh:
	jmp *-16(%r13)
	.long  _s2qc_info - _s2qc_info_dsp
.data
.align 3
.align 0
_s2qj_closure:
	.quad	_s2qj_info
	.quad	0
.text
.align 3
_s2qi_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qi_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qi_info:
Lc2Bt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bu
Lc2Bv:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Bx
Lc2Bw:
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
Lc2Bx:
	movq $24,904(%r13)
Lc2Bu:
	jmp *-8(%r13)
	.long  _s2qi_info - _s2qi_info_dsp
.text
.align 3
_s2qf_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qf_info)+80
	.quad	0
	.quad	12884901904
_s2qf_info:
Lc2BC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BD
Lc2BE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2BD:
	jmp *-16(%r13)
	.long  _s2qf_info - _s2qf_info_dsp
.text
.align 3
_s2qj_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qj_info)+0
	.quad	4294967301
	.quad	0
	.quad	30790620545039
_s2qj_info:
Lc2BF:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BG
Lc2BH:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2BJ
Lc2BI:
	leaq _s2qi_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2qf_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2BJ:
	movq $32,904(%r13)
Lc2BG:
	leaq _s2qj_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qj_info - _s2qj_info_dsp
.data
.align 3
.align 0
_s2qp_closure:
	.quad	_s2qp_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2BQ_str:
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
_s2qp_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qp_info)+48
	.quad	0
	.quad	4294967318
_s2qp_info:
Lc2BR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BS
Lc2BT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2BP
Lc2BO:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2BQ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2BP:
	jmp *(%rbx)
Lc2BS:
	jmp *-16(%r13)
	.long  _s2qp_info - _s2qp_info_dsp
.data
.align 3
.align 0
_s2qo_closure:
	.quad	_s2qo_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2ql_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2ql_info)+104
	.quad	0
	.quad	12884901904
_s2ql_info:
Lc2Cc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cd
Lc2Ce:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_arrayzuidxzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Cd:
	jmp *-16(%r13)
	.long  _s2ql_info - _s2ql_info_dsp
.text
.align 3
_s2qm_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qm_info)+104
	.quad	0
	.quad	64424509456
_s2qm_info:
Lc2Cf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cg
Lc2Ch:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Cj
Lc2Ci:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2ql_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _F95VarDeclParser_varzuexpr_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Cj:
	movq $16,904(%r13)
Lc2Cg:
	jmp *-16(%r13)
	.long  _s2qm_info - _s2qm_info_dsp
.text
.align 3
_s2qn_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qn_info)+104
	.quad	0
	.quad	133143986192
_s2qn_info:
Lc2Ck:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cl
Lc2Cm:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Co
Lc2Cn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2qm_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_constzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Co:
	movq $16,904(%r13)
Lc2Cl:
	jmp *-16(%r13)
	.long  _s2qn_info - _s2qn_info_dsp
.text
.align 3
_s2qk_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qk_info)+80
	.quad	0
	.quad	12884901904
_s2qk_info:
Lc2Ct:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cu
Lc2Cv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Cu:
	jmp *-16(%r13)
	.long  _s2qk_info - _s2qk_info_dsp
.text
.align 3
_s2qo_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qo_info)+80
	.quad	0
	.quad	1078036791318
_s2qo_info:
Lc2Cw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cx
Lc2Cy:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2CA
Lc2Cz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2BZ
Lc2BY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qn_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2qk_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2BZ:
	jmp *(%rbx)
Lc2CA:
	movq $32,904(%r13)
Lc2Cx:
	jmp *-16(%r13)
	.long  _s2qo_info - _s2qo_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_exprzuparser_info)+144
	.quad	0
	.quad	30064771094
.globl _F95VarDeclParser_exprzuparser_info
_F95VarDeclParser_exprzuparser_info:
Lc2CH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CI
Lc2CJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2CG
Lc2CF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qd_closure(%rip),%rsi
	leaq _s2qc_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2CG:
	jmp *(%rbx)
Lc2CI:
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
	.quad	_S2ve_srt-(_F95VarDeclParser_arrayzuidxzuexpr_info)+0
	.quad	0
	.quad	17733919965206
.globl _F95VarDeclParser_arrayzuidxzuexpr_info
_F95VarDeclParser_arrayzuidxzuexpr_info:
Lc2CQ:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CR
Lc2CS:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2CP
Lc2CO:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qj_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2CP:
	jmp *(%rbx)
Lc2CR:
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
	.quad	_S2ve_srt-(_F95VarDeclParser_term_info)+144
	.quad	0
	.quad	107374182422
.globl _F95VarDeclParser_term_info
_F95VarDeclParser_term_info:
Lc2CZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2D0
Lc2D1:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2CY
Lc2CX:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qp_closure(%rip),%rsi
	leaq _s2qo_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2CY:
	jmp *(%rbx)
Lc2D0:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_term_info - _F95VarDeclParser_term_info_dsp
.data
.align 3
.align 0
_s2qs_closure:
	.quad	_s2qs_info
	.quad	0
.text
.align 3
_s2qs_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qs_info)+0
	.quad	4294967301
	.quad	0
	.quad	36028801313931279
_s2qs_info:
Lc2El:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Em
Lc2En:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Em:
	leaq _s2qs_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qs_info - _s2qs_info_dsp
.data
.align 3
.align 0
_s2qq_closure:
	.quad	_s2qq_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qq_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qq_info)+40
	.quad	0
	.quad	2251804108652566
_s2qq_info:
Lc2EA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EB
Lc2EC:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ez
Lc2Ey:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ez:
	jmp *(%rbx)
Lc2EB:
	jmp *-16(%r13)
	.long  _s2qq_info - _s2qq_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_arglistzuparser_info)+0
	.quad	0
	.quad	180143989389787158
.globl _F95VarDeclParser_arglistzuparser_info
_F95VarDeclParser_arglistzuparser_info:
Lc2EP:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EQ
Lc2ER:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2EO
Lc2EN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qq_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qs_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2EO:
	jmp *(%rbx)
Lc2EQ:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_arglistzuparser_info - _F95VarDeclParser_arglistzuparser_info_dsp
.data
.align 3
.align 0
_s2qG_closure:
	.quad	_s2qG_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qx_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qx_info)+208
	.quad	0
	.quad	12884901904
_s2qx_info:
Lc2FC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FD
Lc2FE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2FD:
	jmp *-16(%r13)
	.long  _s2qx_info - _s2qx_info_dsp
.const
.align 3
.align 0
_c2FJ_str:
	.byte	105
	.byte	110
	.byte	0
.text
.align 3
_s2qy_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qy_info)+48
	.quad	0
	.quad	4294967312
_s2qy_info:
Lc2FK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FL
Lc2FM:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2FJ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2FL:
	jmp *-16(%r13)
	.long  _s2qy_info - _s2qy_info_dsp
.const
.align 3
.align 0
_c2FV_str:
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qA_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qA_info)+48
	.quad	0
	.quad	4294967312
_s2qA_info:
Lc2FW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FX
Lc2FY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2FV_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2FX:
	jmp *-16(%r13)
	.long  _s2qA_info - _s2qA_info_dsp
.const
.align 3
.align 0
_c2G7_str:
	.byte	105
	.byte	110
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qC_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qC_info)+48
	.quad	0
	.quad	4294967312
_s2qC_info:
Lc2G8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2G9
Lc2Ga:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2G7_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2G9:
	jmp *-16(%r13)
	.long  _s2qC_info - _s2qC_info_dsp
.const
.align 3
.align 0
_c2Gn_str:
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
_s2qE_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qE_info)+48
	.quad	1
	.quad	31525201686560785
_s2qE_info:
Lc2Gi:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GS
Lc2GT:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2GV
Lc2GU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qx_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2qy_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2FN_info(%rip),%rdx
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
	.quad	_S2ve_srt-(_c2FN_info)+48
	.quad	2
	.quad	18014402804449312
_c2FN_info:
Lc2FN:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Gg
Lc2Gh:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2GR
Lc2GQ:
	leaq _s2qA_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2FZ_info(%rip),%rdx
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
	.quad	_S2ve_srt-(_c2FZ_info)+48
	.quad	2
	.quad	18014402804449312
_c2FZ_info:
Lc2FZ:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Gw
Lc2Gx:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2GO
Lc2GN:
	leaq _s2qC_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Gj_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Gg:
	leaq _F95VarDecl_In_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2ve_srt-(_c2Gj_info)+224
	.quad	0
	.quad	4294967328
_c2Gj_info:
Lc2Gj:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2GG
Lc2GH:
	leaq _c2Gn_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2Gw:
	leaq _F95VarDecl_Out_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2GG:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2GO:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2GR:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2GV:
	movq $32,904(%r13)
Lc2GS:
	jmp *-16(%r13)
	.long  _s2qE_info - _s2qE_info_dsp
.text
.align 3
_s2qF_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qF_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	2017612912234856459
_s2qF_info:
Lc2GW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GX
Lc2GY:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2H0
Lc2GZ:
	leaq _s2qE_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2H0:
	movq $24,904(%r13)
Lc2GX:
	jmp *-8(%r13)
	.long  _s2qF_info - _s2qF_info_dsp
.text
.align 3
_s2qv_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qv_info)+40
	.quad	0
	.quad	141733920784
_s2qv_info:
Lc2H5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H6
Lc2H7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2H6:
	jmp *-16(%r13)
	.long  _s2qv_info - _s2qv_info_dsp
.text
.align 3
_s2qG_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qG_info)+0
	.quad	0
	.quad	2017617447720321046
_s2qG_info:
Lc2H8:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H9
Lc2Ha:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Hc
Lc2Hb:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Fo
Lc2Fn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qF_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2qv_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Fo:
	jmp *(%rbx)
Lc2Hc:
	movq $32,904(%r13)
Lc2H9:
	jmp *-16(%r13)
	.long  _s2qG_info - _s2qG_info_dsp
.data
.align 3
.align 0
_s2qu_closure:
	.quad	_s2qu_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Ig_str:
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	110
	.byte	116
	.byte	0
.text
.align 3
_s2qt_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qt_info)+48
	.quad	0
	.quad	4294967312
_s2qt_info:
Lc2Ih:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ii
Lc2Ij:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Ig_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ii:
	jmp *-16(%r13)
	.long  _s2qt_info - _s2qt_info_dsp
.text
.align 3
_s2qu_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qu_info)+48
	.quad	0
	.quad	36028801313931286
_s2qu_info:
Lc2Ik:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Il
Lc2Im:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Io
Lc2In:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ib
Lc2Ia:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qt_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ib:
	jmp *(%rbx)
Lc2Io:
	movq $16,904(%r13)
Lc2Il:
	jmp *-16(%r13)
	.long  _s2qu_info - _s2qu_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_intentzuparser_info)+0
	.quad	0
	.quad	-4611686014132420586
.globl _F95VarDeclParser_intentzuparser_info
_F95VarDeclParser_intentzuparser_info:
Lc2IH:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2II
Lc2IJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2IG
Lc2IF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qu_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qG_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2IG:
	jmp *(%rbx)
Lc2II:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_intentzuparser_info - _F95VarDeclParser_intentzuparser_info_dsp
.data
.align 3
.align 0
_s2qP_closure:
	.quad	_s2qP_info
	.quad	0
.text
.align 3
_s2qN_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qN_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qN_info:
Lc2J7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2J8
Lc2J9:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Jb
Lc2Ja:
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
Lc2Jb:
	movq $24,904(%r13)
Lc2J8:
	jmp *-8(%r13)
	.long  _s2qN_info - _s2qN_info_dsp
.text
.align 3
_s2qO_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qO_info)+0
	.quad	1
	.quad	8800387989521
_s2qO_info:
Lc2Jc:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jd
Lc2Je:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Jg
Lc2Jf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qN_info(%rip),%rbx
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
Lc2Jg:
	movq $16,904(%r13)
Lc2Jd:
	jmp *-16(%r13)
	.long  _s2qO_info - _s2qO_info_dsp
.text
.align 3
_s2qK_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qK_info)+232
	.quad	0
	.quad	4294967312
_s2qK_info:
Lc2Jm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jn
Lc2Jo:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Jq
Lc2Jp:
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
Lc2Jq:
	movq $24,904(%r13)
Lc2Jn:
	jmp *-16(%r13)
	.long  _s2qK_info - _s2qK_info_dsp
.const_data
.align 3
.align 0
_u2Jw_srtd:
	.quad	_S2ve_srt
	.quad	33
	.quad	4831840257
.text
.align 3
_s2qP_info_dsp:
.text
.align 3
	.quad	_u2Jw_srtd-(_s2qP_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2qP_info:
Lc2Jr:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Js
Lc2Jt:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2Jv
Lc2Ju:
	leaq _s2qO_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2qK_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Jv:
	movq $40,904(%r13)
Lc2Js:
	leaq _s2qP_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qP_info - _s2qP_info_dsp
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
_u2K9_srtd:
	.quad	_S2ve_srt
	.quad	33
	.quad	4294969345
.text
.align 3
_F95VarDeclParser_rangezuexpr_info_dsp:
.text
.align 3
	.quad	_u2K9_srtd-(_F95VarDeclParser_rangezuexpr_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_rangezuexpr_info
_F95VarDeclParser_rangezuexpr_info:
Lc2K6:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2K7
Lc2K8:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2K5
Lc2K4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qP_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2K5:
	jmp *(%rbx)
Lc2K7:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuexpr_info - _F95VarDeclParser_rangezuexpr_info_dsp
.data
.align 3
.align 0
_s2qU_closure:
	.quad	_s2qU_info
	.quad	0
.text
.align 3
_s2qU_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2qU_info)+264
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2qU_info:
Lc2Kr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ks
Lc2Kt:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2Kv
Lc2Ku:
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
Lc2Kv:
	movq $56,904(%r13)
Lc2Ks:
	leaq _s2qU_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qU_info - _s2qU_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_singlezuexprzurange_info)+88
	.quad	0
	.quad	54043199823413270
.globl _F95VarDeclParser_singlezuexprzurange_info
_F95VarDeclParser_singlezuexprzurange_info:
Lc2KL:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2KM
Lc2KN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2KK
Lc2KJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qU_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2KK:
	jmp *(%rbx)
Lc2KM:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuexprzurange_info - _F95VarDeclParser_singlezuexprzurange_info_dsp
.data
.align 3
.align 0
_s2r0_closure:
	.quad	_s2r0_info
	.quad	0
.text
.align 3
_s2r0_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2r0_info)+272
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2r0_info:
Lc2L5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2L6
Lc2L7:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2L9
Lc2L8:
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
Lc2L9:
	movq $72,904(%r13)
Lc2L6:
	leaq _s2r0_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r0_info - _s2r0_info_dsp
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
_u2Lt_srtd:
	.quad	_S2ve_srt+8
	.quad	35
	.quad	25769803777
.text
.align 3
_F95VarDeclParser_singlezuconstzurange_info_dsp:
.text
.align 3
	.quad	_u2Lt_srtd-(_F95VarDeclParser_singlezuconstzurange_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_singlezuconstzurange_info
_F95VarDeclParser_singlezuconstzurange_info:
Lc2Lq:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Lr
Lc2Ls:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Lp
Lc2Lo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r0_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Lp:
	jmp *(%rbx)
Lc2Lr:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuconstzurange_info - _F95VarDeclParser_singlezuconstzurange_info_dsp
.data
.align 3
.align 0
_s2r6_closure:
	.quad	_s2r6_info
	.quad	0
.text
.align 3
_s2r6_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2r6_info)+272
	.quad	4294967301
	.quad	0
	.quad	21474836495
_s2r6_info:
Lc2LM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2LN
Lc2LO:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2LQ
Lc2LP:
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
Lc2LQ:
	movq $72,904(%r13)
Lc2LN:
	leaq _s2r6_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r6_info - _s2r6_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_singlezuvarzurange_info)+40
	.quad	0
	.quad	-6917529023346114538
.globl _F95VarDeclParser_singlezuvarzurange_info
_F95VarDeclParser_singlezuvarzurange_info:
Lc2M7:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2M8
Lc2M9:
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
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r6_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2M6:
	jmp *(%rbx)
Lc2M8:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuvarzurange_info - _F95VarDeclParser_singlezuvarzurange_info_dsp
.data
.align 3
.align 0
_s2re_closure:
	.quad	_s2re_info
	.quad	0
.text
.align 3
_s2re_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2re_info)+272
	.quad	4294967301
	.quad	0
	.quad	38654705679
_s2re_info:
Lc2Mn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Mo
Lc2Mp:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Mo:
	leaq _s2re_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2re_info - _s2re_info_dsp
.data
.align 3
.align 0
_s2rc_closure:
	.quad	_s2rc_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2MG_str:
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
_s2rb_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rb_info)+48
	.quad	0
	.quad	4294967312
_s2rb_info:
Lc2MH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2MI
Lc2MJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2MG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2MI:
	jmp *-16(%r13)
	.long  _s2rb_info - _s2rb_info_dsp
.text
.align 3
_s2r8_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2r8_info)+120
	.quad	0
	.quad	108086395351859216
_s2r8_info:
Lc2MW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2MX
Lc2MY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_singlezuconstzurange_closure(%rip),%rsi
	leaq _F95VarDeclParser_singlezuvarzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2MX:
	jmp *-16(%r13)
	.long  _s2r8_info - _s2r8_info_dsp
.text
.align 3
_s2r9_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2r9_info)+120
	.quad	0
	.quad	252201583427715088
_s2r9_info:
Lc2MZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2N0
Lc2N1:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2N3
Lc2N2:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2r8_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_singlezuexprzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2N3:
	movq $16,904(%r13)
Lc2N0:
	jmp *-16(%r13)
	.long  _s2r9_info - _s2r9_info_dsp
.text
.align 3
_s2r7_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2r7_info)+104
	.quad	0
	.quad	1152921508901814288
_s2r7_info:
Lc2N8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2N9
Lc2Na:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2N9:
	jmp *-16(%r13)
	.long  _s2r7_info - _s2r7_info_dsp
.text
.align 3
_s2ra_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2ra_info)+104
	.quad	0
	.quad	2161727842612674576
_s2ra_info:
Lc2Nb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nc
Lc2Nd:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nf
Lc2Ne:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2r9_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2r7_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Nf:
	movq $32,904(%r13)
Lc2Nc:
	jmp *-16(%r13)
	.long  _s2ra_info - _s2ra_info_dsp
.const_data
.align 3
.align 0
_u2Nl_srtd:
	.quad	_S2ve_srt+48
	.quad	36
	.quad	64424514177
.text
.align 3
_s2rc_info_dsp:
.text
.align 3
	.quad	_u2Nl_srtd-(_s2rc_info)+0
	.quad	0
	.quad	-4294967274
_s2rc_info:
Lc2Ng:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nh
Lc2Ni:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nk
Lc2Nj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2MB
Lc2MA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rb_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2ra_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2MB:
	jmp *(%rbx)
Lc2Nk:
	movq $32,904(%r13)
Lc2Nh:
	jmp *-16(%r13)
	.long  _s2rc_info - _s2rc_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_rangezuparser_info)+272
	.quad	0
	.quad	1138166333462
.globl _F95VarDeclParser_rangezuparser_info
_F95VarDeclParser_rangezuparser_info:
Lc2NZ:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O0
Lc2O1:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2NY
Lc2NX:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rc_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2re_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2NY:
	jmp *(%rbx)
Lc2O0:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuparser_info - _F95VarDeclParser_rangezuparser_info_dsp
.data
.align 3
.align 0
_s2rl_closure:
	.quad	_s2rl_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rk_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rk_info)+272
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2rk_info:
Lc2Om:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2On
Lc2Oo:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2On:
	jmp *-8(%r13)
	.long  _s2rk_info - _s2rk_info_dsp
.text
.align 3
_s2rh_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rh_info)+192
	.quad	0
	.quad	2251804108652560
_s2rh_info:
Lc2Ox:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oy
Lc2Oz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuparser_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Oy:
	jmp *-16(%r13)
	.long  _s2rh_info - _s2rh_info_dsp
.const_data
.align 3
.align 0
_u2OK_srtd:
	.quad	_S2ve_srt+80
	.quad	34
	.quad	8589950977
.text
.align 3
_s2ri_info_dsp:
.text
.align 3
	.quad	_u2OK_srtd-(_s2ri_info)+0
	.quad	0
	.quad	-4294967280
_s2ri_info:
Lc2OA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OB
Lc2OC:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2OE
Lc2OD:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rh_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2OE:
	movq $16,904(%r13)
Lc2OB:
	jmp *-16(%r13)
	.long  _s2ri_info - _s2ri_info_dsp
.const_data
.align 3
.align 0
_u2OL_srtd:
	.quad	_S2ve_srt+80
	.quad	34
	.quad	8606728193
.text
.align 3
_s2rl_info_dsp:
.text
.align 3
	.quad	_u2OL_srtd-(_s2rl_info)+0
	.quad	0
	.quad	-4294967274
_s2rl_info:
Lc2OF:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OG
Lc2OH:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2OJ
Lc2OI:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Og
Lc2Of:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rk_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2ri_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Og:
	jmp *(%rbx)
Lc2OJ:
	movq $32,904(%r13)
Lc2OG:
	jmp *-16(%r13)
	.long  _s2rl_info - _s2rl_info_dsp
.data
.align 3
.align 0
_s2rg_closure:
	.quad	_s2rg_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Pk_str:
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
_s2rf_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rf_info)+352
	.quad	0
	.quad	4294967312
_s2rf_info:
Lc2Pl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pm
Lc2Pn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Pk_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Pm:
	jmp *-16(%r13)
	.long  _s2rf_info - _s2rf_info_dsp
.text
.align 3
_s2rg_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rg_info)+232
	.quad	0
	.quad	140741783322646
_s2rg_info:
Lc2Po:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pp
Lc2Pq:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ps
Lc2Pr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Pf
Lc2Pe:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rf_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Pf:
	jmp *(%rbx)
Lc2Ps:
	movq $16,904(%r13)
Lc2Pp:
	jmp *-16(%r13)
	.long  _s2rg_info - _s2rg_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_dimzuparser_info)+272
	.quad	0
	.quad	26392574033942
.globl _F95VarDeclParser_dimzuparser_info
_F95VarDeclParser_dimzuparser_info:
Lc2PL:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PM
Lc2PN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2PK
Lc2PJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rg_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rl_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2PK:
	jmp *(%rbx)
Lc2PM:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_dimzuparser_info - _F95VarDeclParser_dimzuparser_info_dsp
.data
.align 3
.align 0
_s2rM_closure:
	.quad	_s2rM_info
	.quad	0
.text
.align 3
_s2rG_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rG_info)+376
	.quad	1
	.quad	4294967313
_s2rG_info:
Lc2QC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QD
Lc2QE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2QD:
	jmp *-16(%r13)
	.long  _s2rG_info - _s2rG_info_dsp
.text
.align 3
_s2rJ_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rJ_info)+376
	.quad	1
	.quad	30064771089
_s2rJ_info:
Lc2QO:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QY
Lc2QZ:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2R1
Lc2R0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rG_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c2QF_info(%rip),%rcx
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
	.quad	_S2ve_srt-(_c2QF_info)+384
	.quad	1
	.quad	4294967328
_c2QF_info:
Lc2QF:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2QM
Lc2QN:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2QM:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2QV
Lc2QU:
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $4,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2QV:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2R1:
	movq $24,904(%r13)
Lc2QY:
	jmp *-16(%r13)
	.long  _s2rJ_info - _s2rJ_info_dsp
.text
.align 3
_s2ry_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2ry_info)+208
	.quad	0
	.quad	12884901904
_s2ry_info:
Lc2Ra:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Rb
Lc2Rc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Rb:
	jmp *-16(%r13)
	.long  _s2ry_info - _s2ry_info_dsp
.const
.align 3
.align 0
_c2Rh_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	108
	.byte	0
.text
.align 3
_s2rz_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rz_info)+352
	.quad	0
	.quad	4294967312
_s2rz_info:
Lc2Ri:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Rj
Lc2Rk:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Rh_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Rj:
	jmp *-16(%r13)
	.long  _s2rz_info - _s2rz_info_dsp
.const
.align 3
.align 0
_c2Rt_str:
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
_s2rB_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rB_info)+352
	.quad	0
	.quad	4294967312
_s2rB_info:
Lc2Ru:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Rv
Lc2Rw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Rt_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Rv:
	jmp *-16(%r13)
	.long  _s2rB_info - _s2rB_info_dsp
.const
.align 3
.align 0
_c2RF_str:
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
_s2rD_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rD_info)+352
	.quad	0
	.quad	4294967312
_s2rD_info:
Lc2RG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2RH
Lc2RI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2RF_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2RH:
	jmp *-16(%r13)
	.long  _s2rD_info - _s2rD_info_dsp
.text
.align 3
_s2rF_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rF_info)+208
	.quad	1
	.quad	217298694905528337
_s2rF_info:
Lc2RQ:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sf
Lc2Sg:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Si
Lc2Sh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ry_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2rz_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2Rl_info(%rip),%rdx
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
	.quad	_S2ve_srt-(_c2Rl_info)+352
	.quad	2
	.quad	828928688160
_c2Rl_info:
Lc2Rl:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2RO
Lc2RP:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Se
Lc2Sd:
	leaq _s2rB_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Rx_info(%rip),%rdx
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
	.quad	_S2ve_srt-(_c2Rx_info)+352
	.quad	1
	.quad	828928688160
_c2Rx_info:
Lc2Rx:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2S0
Lc2S1:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Sb
Lc2Sa:
	leaq _s2rD_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2RR_info(%rip),%rcx
	movq %rcx,8(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $8,%rbp
	jmp _stg_ap_pp_fast
Lc2RO:
	leaq _F95VarDecl_F95Real_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2ve_srt-(_c2RR_info)+408
	.quad	0
	.quad	4294967328
_c2RR_info:
Lc2RR:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2S0:
	leaq _F95VarDecl_F95Integer_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2Sb:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Se:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Si:
	movq $32,904(%r13)
Lc2Sf:
	jmp *-16(%r13)
	.long  _s2rF_info - _s2rF_info_dsp
.text
.align 3
_s2rL_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rL_info)+208
	.quad	4294967301
	.quad	1
	.quad	280350189200343050
_s2rL_info:
Lc2Sk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sl
Lc2Sm:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2So
Lc2Sn:
	movq 7(%rbx),%rax
	leaq _s2rJ_info(%rip),%rbx
	movq %rbx,-64(%r12)
	movq %r14,-48(%r12)
	leaq -64(%r12),%rbx
	leaq _s2rF_info(%rip),%rcx
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
Lc2So:
	movq $72,904(%r13)
Lc2Sl:
	jmp *-8(%r13)
	.long  _s2rL_info - _s2rL_info_dsp
.text
.align 3
_s2rr_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rr_info)+232
	.quad	0
	.quad	4294967312
_s2rr_info:
Lc2SO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2SP
Lc2SQ:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2SS
Lc2SR:
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
Lc2SS:
	movq $24,904(%r13)
Lc2SP:
	jmp *-16(%r13)
	.long  _s2rr_info - _s2rr_info_dsp
.const
.align 3
.align 0
_c2T1_str:
	.byte	107
	.byte	105
	.byte	110
	.byte	100
	.byte	0
.text
.align 3
_s2rn_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rn_info)+352
	.quad	0
	.quad	4294967312
_s2rn_info:
Lc2T2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2T3
Lc2T4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2T1_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2T3:
	jmp *-16(%r13)
	.long  _s2rn_info - _s2rn_info_dsp
.text
.align 3
_s2ro_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2ro_info)+232
	.quad	0
	.quad	140741783322640
_s2ro_info:
Lc2T5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2T6
Lc2T7:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2T9
Lc2T8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rn_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2T9:
	movq $16,904(%r13)
Lc2T6:
	jmp *-16(%r13)
	.long  _s2ro_info - _s2ro_info_dsp
.text
.align 3
_s2rs_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rs_info)+232
	.quad	0
	.quad	140879222276112
_s2rs_info:
Lc2Ta:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tb
Lc2Tc:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Te
Lc2Td:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rr_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2ro_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Te:
	movq $32,904(%r13)
Lc2Tb:
	jmp *-16(%r13)
	.long  _s2rs_info - _s2rs_info_dsp
.const_data
.align 3
.align 0
_u2TE_srtd:
	.quad	_S2ve_srt+8
	.quad	44
	.quad	8804951392257
.text
.align 3
_s2rt_info_dsp:
.text
.align 3
	.quad	_u2TE_srtd-(_s2rt_info)+0
	.quad	0
	.quad	-4294967280
_s2rt_info:
Lc2Tf:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tg
Lc2Th:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tj
Lc2Ti:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rs_info(%rip),%rax
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
Lc2Tj:
	movq $16,904(%r13)
Lc2Tg:
	jmp *-16(%r13)
	.long  _s2rt_info - _s2rt_info_dsp
.const_data
.align 3
.align 0
_u2TF_srtd:
	.quad	_S2ve_srt+8
	.quad	44
	.quad	8804951408641
.text
.align 3
_s2ru_info_dsp:
.text
.align 3
	.quad	_u2TF_srtd-(_s2ru_info)+0
	.quad	0
	.quad	-4294967280
_s2ru_info:
Lc2Tk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tl
Lc2Tm:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2To
Lc2Tn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rt_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95ParserCommon_natural_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2To:
	movq $16,904(%r13)
Lc2Tl:
	jmp *-16(%r13)
	.long  _s2ru_info - _s2ru_info_dsp
.const_data
.align 3
.align 0
_u2TG_srtd:
	.quad	_S2ve_srt+8
	.quad	44
	.quad	8804951409153
.text
.align 3
_s2rv_info_dsp:
.text
.align 3
	.quad	_u2TG_srtd-(_s2rv_info)+0
	.quad	0
	.quad	-4294967280
_s2rv_info:
Lc2Tp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tq
Lc2Tr:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tt
Lc2Ts:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2ru_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Tt:
	movq $16,904(%r13)
Lc2Tq:
	jmp *-16(%r13)
	.long  _s2rv_info - _s2rv_info_dsp
.const_data
.align 3
.align 0
_u2TH_srtd:
	.quad	_S2ve_srt+8
	.quad	52
	.quad	2260604765094401
.text
.align 3
_s2rw_info_dsp:
.text
.align 3
	.quad	_u2TH_srtd-(_s2rw_info)+0
	.quad	0
	.quad	-4294967280
_s2rw_info:
Lc2Tu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tv
Lc2Tw:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ty
Lc2Tx:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rv_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ty:
	movq $16,904(%r13)
Lc2Tv:
	jmp *-16(%r13)
	.long  _s2rw_info - _s2rw_info_dsp
.const_data
.align 3
.align 0
_u2TI_srtd:
	.quad	_S2ve_srt+8
	.quad	53
	.quad	8945635562635777
.text
.align 3
_s2rM_info_dsp:
.text
.align 3
	.quad	_u2TI_srtd-(_s2rM_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2rM_info:
Lc2Tz:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TA
Lc2TB:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2TD
Lc2TC:
	leaq _s2rL_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2rw_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2TD:
	movq $32,904(%r13)
Lc2TA:
	leaq _s2rM_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rM_info - _s2rM_info_dsp
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
_u2VK_srtd:
	.quad	_S2ve_srt+40
	.quad	49
	.quad	281475513581569
.text
.align 3
_F95VarDeclParser_typezuparser_info_dsp:
.text
.align 3
	.quad	_u2VK_srtd-(_F95VarDeclParser_typezuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_typezuparser_info
_F95VarDeclParser_typezuparser_info:
Lc2VH:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2VI
Lc2VJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2VG
Lc2VF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rM_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2VG:
	jmp *(%rbx)
Lc2VI:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_typezuparser_info - _F95VarDeclParser_typezuparser_info_dsp
.data
.align 3
.align 0
_s2s5_closure:
	.quad	_s2s5_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rT_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rT_info)+208
	.quad	0
	.quad	12884901904
_s2rT_info:
Lc2WL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2WM
Lc2WN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2WM:
	jmp *-16(%r13)
	.long  _s2rT_info - _s2rT_info_dsp
.const
.align 3
.align 0
_c2WS_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	100
	.byte	0
.text
.align 3
_s2rU_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rU_info)+352
	.quad	0
	.quad	4294967312
_s2rU_info:
Lc2WT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2WU
Lc2WV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2WS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2WU:
	jmp *-16(%r13)
	.long  _s2rU_info - _s2rU_info_dsp
.const
.align 3
.align 0
_c2X4_str:
	.byte	119
	.byte	114
	.byte	105
	.byte	116
	.byte	101
	.byte	0
.text
.align 3
_s2rW_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rW_info)+352
	.quad	0
	.quad	4294967312
_s2rW_info:
Lc2X5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2X6
Lc2X7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2X4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2X6:
	jmp *-16(%r13)
	.long  _s2rW_info - _s2rW_info_dsp
.const
.align 3
.align 0
_c2Xg_str:
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
_s2rY_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rY_info)+352
	.quad	0
	.quad	4294967312
_s2rY_info:
Lc2Xh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Xi
Lc2Xj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Xg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Xi:
	jmp *-16(%r13)
	.long  _s2rY_info - _s2rY_info_dsp
.const
.align 3
.align 0
_c2Xw_str:
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
_s2s0_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2s0_info)+208
	.quad	1
	.quad	1125929971613713
_s2s0_info:
Lc2Xr:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Y1
Lc2Y2:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Y4
Lc2Y3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rT_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2rU_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2WW_info(%rip),%rdx
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
	.quad	_S2ve_srt-(_c2WW_info)+224
	.quad	2
	.quad	281479271677984
_c2WW_info:
Lc2WW:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Xp
Lc2Xq:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Y0
Lc2XZ:
	leaq _s2rW_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2X8_info(%rip),%rdx
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
	.quad	_S2ve_srt-(_c2X8_info)+224
	.quad	2
	.quad	281479271677984
_c2X8_info:
Lc2X8:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2XF
Lc2XG:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2XX
Lc2XW:
	leaq _s2rY_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Xs_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Xp:
	leaq _F95VarDecl_Read_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2ve_srt-(_c2Xs_info)+224
	.quad	0
	.quad	4294967328
_c2Xs_info:
Lc2Xs:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2XP
Lc2XQ:
	leaq _c2Xw_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2XF:
	leaq _F95VarDecl_Write_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2XP:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2XX:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Y0:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Y4:
	movq $32,904(%r13)
Lc2Y1:
	jmp *-16(%r13)
	.long  _s2s0_info - _s2s0_info_dsp
.text
.align 3
_s2s1_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2s1_info)+208
	.quad	4294967301
	.quad	4294967296
	.quad	1127029483241483
_s2s1_info:
Lc2Y5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Y6
Lc2Y7:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Y9
Lc2Y8:
	leaq _s2s0_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Y9:
	movq $24,904(%r13)
Lc2Y6:
	jmp *-8(%r13)
	.long  _s2s1_info - _s2s1_info_dsp
.const_data
.align 3
.align 0
_u2YL_srtd:
	.quad	_S2ve_srt+40
	.quad	40
	.quad	550307364865
.text
.align 3
_s2s2_info_dsp:
.text
.align 3
	.quad	_u2YL_srtd-(_s2s2_info)+0
	.quad	0
	.quad	-4294967280
_s2s2_info:
Lc2Ya:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yb
Lc2Yc:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ye
Lc2Yd:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s1_info(%rip),%rax
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
Lc2Ye:
	movq $16,904(%r13)
Lc2Yb:
	jmp *-16(%r13)
	.long  _s2s2_info - _s2s2_info_dsp
.const_data
.align 3
.align 0
_u2YM_srtd:
	.quad	_S2ve_srt+40
	.quad	40
	.quad	550307364865
.text
.align 3
_s2s3_info_dsp:
.text
.align 3
	.quad	_u2YM_srtd-(_s2s3_info)+0
	.quad	0
	.quad	-4294967280
_s2s3_info:
Lc2Yf:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yg
Lc2Yh:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Yj
Lc2Yi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s2_info(%rip),%rax
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
Lc2Yj:
	movq $16,904(%r13)
Lc2Yg:
	jmp *-16(%r13)
	.long  _s2s3_info - _s2s3_info_dsp
.const
.align 3
.align 0
_c2Ys_str:
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	0
.text
.align 3
_s2rQ_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rQ_info)+352
	.quad	0
	.quad	4294967312
_s2rQ_info:
Lc2Yt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yu
Lc2Yv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Ys_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Yu:
	jmp *-16(%r13)
	.long  _s2rQ_info - _s2rQ_info_dsp
.text
.align 3
_s2rR_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rR_info)+232
	.quad	0
	.quad	140741783322640
_s2rR_info:
Lc2Yw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yx
Lc2Yy:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YA
Lc2Yz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rQ_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2YA:
	movq $16,904(%r13)
Lc2Yx:
	jmp *-16(%r13)
	.long  _s2rR_info - _s2rR_info_dsp
.const_data
.align 3
.align 0
_u2YN_srtd:
	.quad	_S2ve_srt+40
	.quad	40
	.quad	550324142081
.text
.align 3
_s2s4_info_dsp:
.text
.align 3
	.quad	_u2YN_srtd-(_s2s4_info)+0
	.quad	0
	.quad	-4294967280
_s2s4_info:
Lc2YB:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YC
Lc2YD:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2YF
Lc2YE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s3_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rR_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2YF:
	movq $32,904(%r13)
Lc2YC:
	jmp *-16(%r13)
	.long  _s2s4_info - _s2s4_info_dsp
.const_data
.align 3
.align 0
_u2YO_srtd:
	.quad	_S2ve_srt+40
	.quad	50
	.quad	563500277563393
.text
.align 3
_s2s5_info_dsp:
.text
.align 3
	.quad	_u2YO_srtd-(_s2s5_info)+0
	.quad	0
	.quad	-4294967274
_s2s5_info:
Lc2YG:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YH
Lc2YI:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YK
Lc2YJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Wl
Lc2Wk:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2s4_info(%rip),%rax
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
Lc2Wl:
	jmp *(%rbx)
Lc2YK:
	movq $16,904(%r13)
Lc2YH:
	jmp *-16(%r13)
	.long  _s2s5_info - _s2s5_info_dsp
.data
.align 3
.align 0
_s2rP_closure:
	.quad	_s2rP_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rN_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rN_info)+440
	.quad	0
	.quad	12884901904
_s2rN_info:
Lc30n:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30o
Lc30p:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc30o:
	jmp *-16(%r13)
	.long  _s2rN_info - _s2rN_info_dsp
.text
.align 3
_s2rP_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2rP_info)+440
	.quad	0
	.quad	30064771094
_s2rP_info:
Lc30q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30r
Lc30s:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc30u
Lc30t:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc30i
Lc30h:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rN_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rbx
	leaq 529(%rbx),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc30i:
	jmp *(%rbx)
Lc30u:
	movq $16,904(%r13)
Lc30r:
	jmp *-16(%r13)
	.long  _s2rP_info - _s2rP_info_dsp
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
	.quad	_S2ve_srt-(_F95VarDeclParser_oclzuargmodezuparser_info)+272
	.quad	0
	.quad	216172786408751126
.globl _F95VarDeclParser_oclzuargmodezuparser_info
_F95VarDeclParser_oclzuargmodezuparser_info:
Lc30N:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30O
Lc30P:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc30M
Lc30L:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rP_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2s5_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc30M:
	jmp *(%rbx)
Lc30O:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_oclzuargmodezuparser_info - _F95VarDeclParser_oclzuargmodezuparser_info_dsp
.data
.align 3
.align 0
_s2sz_closure:
	.quad	_s2sz_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2sf_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sf_info)+376
	.quad	1
	.quad	4294967313
_s2sf_info:
Lc31J:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31K
Lc31L:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc31K:
	jmp *-16(%r13)
	.long  _s2sf_info - _s2sf_info_dsp
.text
.align 3
_s2se_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2se_info)+376
	.quad	1
	.quad	30064771089
_s2se_info:
Lc31V:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc322
Lc323:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc325
Lc324:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sf_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c31M_info(%rip),%rcx
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
	.quad	_S2ve_srt-(_c31M_info)+384
	.quad	1
	.quad	4294967328
_c31M_info:
Lc31M:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc31T
Lc31U:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc31T:
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc325:
	movq $24,904(%r13)
Lc322:
	jmp *-16(%r13)
	.long  _s2se_info - _s2se_info_dsp
.text
.align 3
_s2sj_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sj_info)+376
	.quad	1
	.quad	4294967313
_s2sj_info:
Lc32e:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32f
Lc32g:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc32f:
	jmp *-16(%r13)
	.long  _s2sj_info - _s2sj_info_dsp
.text
.align 3
_s2si_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2si_info)+376
	.quad	1
	.quad	30064771089
_s2si_info:
Lc32q:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32x
Lc32y:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc32A
Lc32z:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sj_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c32h_info(%rip),%rcx
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
	.quad	_S2ve_srt-(_c32h_info)+384
	.quad	1
	.quad	4294967328
_c32h_info:
Lc32h:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc32o
Lc32p:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc32o:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc32A:
	movq $24,904(%r13)
Lc32x:
	jmp *-16(%r13)
	.long  _s2si_info - _s2si_info_dsp
.text
.align 3
_s2sp_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sp_info)+376
	.quad	1
	.quad	4294967313
_s2sp_info:
Lc332:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc333
Lc334:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc333:
	jmp *-16(%r13)
	.long  _s2sp_info - _s2sp_info_dsp
.text
.align 3
_s2ss_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2ss_info)+376
	.quad	1
	.quad	30064771089
_s2ss_info:
Lc33e:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33l
Lc33m:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc33o
Lc33n:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sp_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c335_info(%rip),%rcx
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
	.quad	_S2ve_srt-(_c335_info)+384
	.quad	1
	.quad	4294967328
_c335_info:
Lc335:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc33c
Lc33d:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc33c:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc33o:
	movq $24,904(%r13)
Lc33l:
	jmp *-16(%r13)
	.long  _s2ss_info - _s2ss_info_dsp
.text
.align 3
_s2su_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2su_info)+272
	.quad	4294967301
	.quad	4
	.quad	246294899589129
_s2su_info:
Lc33q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33r
Lc33s:
	addq $96,%r12
	cmpq 856(%r13),%r12
	ja Lc33u
Lc33t:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rdx
	movq 31(%rbx),%rbx
	leaq _s2ss_info(%rip),%rsi
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
Lc33u:
	movq $96,904(%r13)
Lc33r:
	jmp *-8(%r13)
	.long  _s2su_info - _s2su_info_dsp
.text
.align 3
_s2sn_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sn_info)+416
	.quad	0
	.quad	1103806595088
_s2sn_info:
Lc33z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33A
Lc33B:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_oclzuargmodezuparser_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33A:
	jmp *-16(%r13)
	.long  _s2sn_info - _s2sn_info_dsp
.text
.align 3
_s2sv_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sv_info)+272
	.quad	4294967301
	.quad	3
	.quad	289602570958143497
_s2sv_info:
Lc33C:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33D
Lc33E:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc33G
Lc33F:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _s2su_info(%rip),%rdx
	movq %rdx,-48(%r12)
	movq %rax,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	leaq -47(%r12),%rax
	leaq _s2sn_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc33G:
	movq $56,904(%r13)
Lc33D:
	jmp *-8(%r13)
	.long  _s2sv_info - _s2sv_info_dsp
.text
.align 3
_s2sw_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sw_info)+272
	.quad	4294967301
	.quad	2
	.quad	866063323261566988
_s2sw_info:
Lc33H:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33I
Lc33J:
	addq $80,%r12
	cmpq 856(%r13),%r12
	ja Lc33L
Lc33K:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _s2se_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %rbx,-56(%r12)
	leaq -72(%r12),%rbx
	leaq _s2si_info(%rip),%rcx
	movq %rcx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rcx
	leaq _s2sv_info(%rip),%rdx
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
Lc33L:
	movq $80,904(%r13)
Lc33I:
	jmp *-8(%r13)
	.long  _s2sw_info - _s2sw_info_dsp
.text
.align 3
_s2sb_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sb_info)+272
	.quad	0
	.quad	3458764518115508240
_s2sb_info:
Lc33U:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33V
Lc33W:
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
Lc33V:
	jmp *-16(%r13)
	.long  _s2sb_info - _s2sb_info_dsp
.text
.align 3
_s2sc_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sc_info)+272
	.quad	0
	.quad	3459890418022350864
_s2sc_info:
Lc33X:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33Y
Lc33Z:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc341
Lc340:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sb_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc341:
	movq $16,904(%r13)
Lc33Y:
	jmp *-16(%r13)
	.long  _s2sc_info - _s2sc_info_dsp
.text
.align 3
_s2sx_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2sx_info)+272
	.quad	4294967301
	.quad	1
	.quad	4324827837082107914
_s2sx_info:
Lc342:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc343
Lc344:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc346
Lc345:
	movq 7(%rbx),%rax
	leaq _s2sw_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -31(%r12),%rax
	leaq _s2sc_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc346:
	movq $40,904(%r13)
Lc343:
	jmp *-8(%r13)
	.long  _s2sx_info - _s2sx_info_dsp
.text
.align 3
_s2s7_info_dsp:
.text
.align 3
	.quad	_S2ve_srt-(_s2s7_info)+272
	.quad	0
	.quad	5764607527329202192
_s2s7_info:
Lc34j:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34k
Lc34l:
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
Lc34k:
	jmp *-16(%r13)
	.long  _s2s7_info - _s2s7_info_dsp
.const_data
.align 3
.align 0
_u34G_srtd:
	.quad	_S2ve_srt+104
	.quad	52
	.quad	2814749769203713
.text
.align 3
_s2s8_info_dsp:
.text
.align 3
	.quad	_u34G_srtd-(_s2s8_info)+0
	.quad	0
	.quad	-4294967280
_s2s8_info:
Lc34m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34n
Lc34o:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34q
Lc34p:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s7_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34q:
	movq $16,904(%r13)
Lc34n:
	jmp *-16(%r13)
	.long  _s2s8_info - _s2s8_info_dsp
.const_data
.align 3
.align 0
_u34H_srtd:
	.quad	_S2ve_srt+104
	.quad	52
	.quad	2815299525017601
.text
.align 3
_s2s9_info_dsp:
.text
.align 3
	.quad	_u34H_srtd-(_s2s9_info)+0
	.quad	0
	.quad	-4294967280
_s2s9_info:
Lc34r:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34s
Lc34t:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34v
Lc34u:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s8_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34v:
	movq $16,904(%r13)
Lc34s:
	jmp *-16(%r13)
	.long  _s2s9_info - _s2s9_info_dsp
.const_data
.align 3
.align 0
_u34I_srtd:
	.quad	_S2ve_srt+104
	.quad	52
	.quad	4363532156010497
.text
.align 3
_s2sy_info_dsp:
.text
.align 3
	.quad	_u34I_srtd-(_s2sy_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	-4294967285
_s2sy_info:
Lc34w:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34x
Lc34y:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc34A
Lc34z:
	leaq _s2sx_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2s9_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc34A:
	movq $32,904(%r13)
Lc34x:
	jmp *-8(%r13)
	.long  _s2sy_info - _s2sy_info_dsp
.const_data
.align 3
.align 0
_u34J_srtd:
	.quad	_S2ve_srt+104
	.quad	53
	.quad	8867131783380993
.text
.align 3
_s2sz_info_dsp:
.text
.align 3
	.quad	_u34J_srtd-(_s2sz_info)+0
	.quad	0
	.quad	-4294967274
_s2sz_info:
Lc34B:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34C
Lc34D:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34F
Lc34E:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31l
Lc31k:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2sy_info(%rip),%rax
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
Lc31l:
	jmp *(%rbx)
Lc34F:
	movq $16,904(%r13)
Lc34C:
	jmp *-16(%r13)
	.long  _s2sz_info - _s2sz_info_dsp
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
_u36S_srtd:
	.quad	_S2ve_srt+272
	.quad	33
	.quad	4296015873
.text
.align 3
_F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp:
.text
.align 3
	.quad	_u36S_srtd-(_F95VarDeclParser_f95zuvarzudeclzuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_f95zuvarzudeclzuparser_info
_F95VarDeclParser_f95zuvarzudeclzuparser_info:
Lc36P:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc36Q
Lc36R:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc36O
Lc36N:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_whiteSpace_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2sz_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc36O:
	jmp *(%rbx)
Lc36Q:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_f95zuvarzudeclzuparser_info - _F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp
.const_data
.align 3
.align 0
_S2ve_srt:
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_F95ParserCommon_natural_closure
	.quad	_F95ParserCommon_reservedOp_closure
	.quad	_r2kH_closure
	.quad	_r2pm_closure
	.quad	_F95ParserCommon_word_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure
	.quad	_F95VarDeclParser_term_closure
	.quad	_F95VarDeclParser_optable_closure
	.quad	_F95ParserCommon_parens_closure
	.quad	_F95VarDeclParser_exprzuparser_closure
	.quad	_s2qj_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95VarDeclParser_arrayzuidxzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure
	.quad	_F95VarDeclParser_varzuexpr_closure
	.quad	_F95VarDeclParser_constzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure
	.quad	_s2qc_closure
	.quad	_s2qd_closure
	.quad	_s2qo_closure
	.quad	_s2qp_closure
	.quad	_s2qs_closure
	.quad	_F95ParserCommon_commaSep_closure
	.quad	_s2qq_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_base_ControlziExceptionziBase_patError_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_s2qu_closure
	.quad	_s2qG_closure
	.quad	_s2qP_closure
	.quad	_s2qU_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_s2r0_closure
	.quad	_s2r6_closure
	.quad	_s2re_closure
	.quad	_F95VarDeclParser_singlezuvarzurange_closure
	.quad	_F95VarDeclParser_singlezuconstzurange_closure
	.quad	_F95VarDeclParser_singlezuexprzurange_closure
	.quad	_F95VarDeclParser_rangezuexpr_closure
	.quad	_s2rc_closure
	.quad	_F95VarDeclParser_rangezuparser_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_s2rg_closure
	.quad	_s2rl_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziList_head_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqInt_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_many_closure
	.quad	_s2rM_closure
	.quad	_F95ParserCommon_whiteSpace_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_s2rP_closure
	.quad	_s2s5_closure
	.quad	_F95VarDeclParser_oclzuargmodezuparser_closure
	.quad	_F95VarDeclParser_arglistzuparser_closure
	.quad	_F95ParserCommon_comma_closure
	.quad	_F95VarDeclParser_intentzuparser_closure
	.quad	_F95VarDeclParser_dimzuparser_closure
	.quad	_F95VarDeclParser_typezuparser_closure
	.quad	_s2sz_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

