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
_s2pN_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2pN_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2pN_info:
Lc2ve:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vf
Lc2vg:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vi
Lc2vh:
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
Lc2vi:
	movq $16,904(%r13)
Lc2vf:
	jmp *-8(%r13)
	.long  _s2pN_info - _s2pN_info_dsp
.text
.align 3
_F95VarDeclParser_constzuexpr_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_F95VarDeclParser_constzuexpr_info)+0
	.quad	0
	.quad	12884901910
.globl _F95VarDeclParser_constzuexpr_info
_F95VarDeclParser_constzuexpr_info:
Lc2vj:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vk
Lc2vl:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vn
Lc2vm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2v7
Lc2v6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2pN_info(%rip),%rax
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
Lc2v7:
	jmp *(%rbx)
Lc2vn:
	movq $16,904(%r13)
Lc2vk:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_constzuexpr_info - _F95VarDeclParser_constzuexpr_info_dsp
.data
.align 3
.align 0
_r2kN_closure:
	.quad	_r2kN_info
	.quad	0
.text
.align 3
_s2pS_info_dsp:
.text
.align 3
	.quad	4294967301
	.quad	1
	.quad	10
_s2pS_info:
Lc2vW:
Lc2vY:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2w0
Lc2vZ:
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
Lc2w0:
	movq $40,904(%r13)
Lc2vX:
	jmp *-8(%r13)
	.long  _s2pS_info - _s2pS_info_dsp
.text
.align 3
_s2pT_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2pT_info)+0
	.quad	1
	.quad	4294967313
_s2pT_info:
Lc2w1:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w2
Lc2w3:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2w5
Lc2w4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pS_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2w5:
	movq $16,904(%r13)
Lc2w2:
	jmp *-16(%r13)
	.long  _s2pT_info - _s2pT_info_dsp
.text
.align 3
_s2pP_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2pP_info)+16
	.quad	1
	.quad	4294967313
_s2pP_info:
Lc2wa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wb
Lc2wc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wb:
	jmp *-16(%r13)
	.long  _s2pP_info - _s2pP_info_dsp
.text
.align 3
_s2pU_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2pU_info)+0
	.quad	1
	.quad	21474836497
_s2pU_info:
Lc2wd:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2we
Lc2wf:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2wh
Lc2wg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pT_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2pP_info(%rip),%rcx
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
Lc2wh:
	movq $48,904(%r13)
Lc2we:
	jmp *-16(%r13)
	.long  _s2pU_info - _s2pU_info_dsp
.text
.align 3
_r2kN_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2kN_info)+0
	.quad	4294967301
	.quad	0
	.quad	55834574863
_r2kN_info:
Lc2wj:
Lc2wl:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wn
Lc2wm:
	leaq _s2pU_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_Prefix_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2wn:
	movq $40,904(%r13)
Lc2wk:
	leaq _r2kN_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2kN_info - _r2kN_info_dsp
.data
.align 3
.align 0
_r2pt_closure:
	.quad	_r2pt_info
	.quad	0
.text
.align 3
_s2q1_info_dsp:
.text
.align 3
	.quad	8589934607
	.quad	1
	.quad	10
_s2q1_info:
Lc2x8:
Lc2xa:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xc
Lc2xb:
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
Lc2xc:
	movq $48,904(%r13)
Lc2x9:
	jmp *-8(%r13)
	.long  _s2q1_info - _s2q1_info_dsp
.text
.align 3
_s2q2_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2q2_info)+0
	.quad	1
	.quad	4294967313
_s2q2_info:
Lc2xd:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xe
Lc2xf:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2xh
Lc2xg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2q1_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2xh:
	movq $16,904(%r13)
Lc2xe:
	jmp *-16(%r13)
	.long  _s2q2_info - _s2q2_info_dsp
.text
.align 3
_s2pX_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2pX_info)+16
	.quad	1
	.quad	4294967313
_s2pX_info:
Lc2xm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xn
Lc2xo:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xn:
	jmp *-16(%r13)
	.long  _s2pX_info - _s2pX_info_dsp
.text
.align 3
_s2q3_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2q3_info)+0
	.quad	1
	.quad	21474836497
_s2q3_info:
Lc2xp:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xq
Lc2xr:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xt
Lc2xs:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2q2_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2pX_info(%rip),%rcx
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
Lc2xt:
	movq $48,904(%r13)
Lc2xq:
	jmp *-16(%r13)
	.long  _s2q3_info - _s2q3_info_dsp
.text
.align 3
_r2pt_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2pt_info)+0
	.quad	8589934607
	.quad	0
	.quad	90194313231
_r2pt_info:
Lc2xv:
Lc2xx:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xz
Lc2xy:
	leaq _s2q3_info(%rip),%rax
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
Lc2xz:
	movq $48,904(%r13)
Lc2xw:
	leaq _r2pt_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2pt_info - _r2pt_info_dsp
.data
.align 3
.align 0
_r2pu_closure:
	.quad	_r2pu_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pu_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2pu_info)+24
	.quad	0
	.quad	4294967318
_r2pu_info:
Lc2y8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2y9
Lc2ya:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yc
Lc2yb:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2y6
Lc2y5:
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
	jmp _r2kN_info
Lc2y6:
	jmp *(%rbx)
Lc2yc:
	movq $24,904(%r13)
Lc2y9:
	jmp *-16(%r13)
	.long  _r2pu_info - _r2pu_info_dsp
.data
.align 3
.align 0
_r2pv_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pu_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
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
	.quad	_S2vo_srt-(_r2pw_info)+32
	.quad	0
	.quad	4294967318
_r2pw_info:
Lc2yw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yx
Lc2yy:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yA
Lc2yz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yu
Lc2yt:
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
	jmp _r2pt_info
Lc2yu:
	jmp *(%rbx)
Lc2yA:
	movq $24,904(%r13)
Lc2yx:
	jmp *-16(%r13)
	.long  _r2pw_info - _r2pw_info_dsp
.data
.align 3
.align 0
_r2px_closure:
	.quad	_r2px_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2px_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2px_info)+32
	.quad	0
	.quad	4294967318
_r2px_info:
Lc2yS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yT
Lc2yU:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yW
Lc2yV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yQ
Lc2yP:
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
	jmp _r2pt_info
Lc2yQ:
	jmp *(%rbx)
Lc2yW:
	movq $24,904(%r13)
Lc2yT:
	jmp *-16(%r13)
	.long  _r2px_info - _r2px_info_dsp
.data
.align 3
.align 0
_r2py_closure:
	.quad	_r2py_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2py_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2py_info)+32
	.quad	0
	.quad	4294967318
_r2py_info:
Lc2ze:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zf
Lc2zg:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zi
Lc2zh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zc
Lc2zb:
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
	jmp _r2pt_info
Lc2zc:
	jmp *(%rbx)
Lc2zi:
	movq $24,904(%r13)
Lc2zf:
	jmp *-16(%r13)
	.long  _r2py_info - _r2py_info_dsp
.data
.align 3
.align 0
_r2pz_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2py_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pA_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2px_closure
	.quad	_r2pz_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pw_closure
	.quad	_r2pA_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pC_closure:
	.quad	_r2pC_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pC_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2pC_info)+32
	.quad	0
	.quad	4294967318
_r2pC_info:
Lc2zG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zH
Lc2zI:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zK
Lc2zJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zE
Lc2zD:
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
	jmp _r2pt_info
Lc2zE:
	jmp *(%rbx)
Lc2zK:
	movq $24,904(%r13)
Lc2zH:
	jmp *-16(%r13)
	.long  _r2pC_info - _r2pC_info_dsp
.data
.align 3
.align 0
_r2pD_closure:
	.quad	_r2pD_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pD_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_r2pD_info)+32
	.quad	0
	.quad	4294967318
_r2pD_info:
Lc2A2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2A3
Lc2A4:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2A6
Lc2A5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2A0
Lc2zZ:
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
	jmp _r2pt_info
Lc2A0:
	jmp *(%rbx)
Lc2A6:
	movq $24,904(%r13)
Lc2A3:
	jmp *-16(%r13)
	.long  _r2pD_info - _r2pD_info_dsp
.data
.align 3
.align 0
_r2pE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pD_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pF_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pC_closure
	.quad	_r2pE_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pF_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pB_closure+2
	.quad	_r2pG_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95VarDeclParser_optable_closure
_F95VarDeclParser_optable_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pv_closure+2
	.quad	_r2pH_closure+2
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
_s2qi_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qi_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2qi_info:
Lc2AD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2AE
Lc2AF:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2AH
Lc2AG:
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
Lc2AH:
	movq $16,904(%r13)
Lc2AE:
	jmp *-8(%r13)
	.long  _s2qi_info - _s2qi_info_dsp
.text
.align 3
_F95VarDeclParser_varzuexpr_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_F95VarDeclParser_varzuexpr_info)+0
	.quad	0
	.quad	141733920790
.globl _F95VarDeclParser_varzuexpr_info
_F95VarDeclParser_varzuexpr_info:
Lc2AI:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2AJ
Lc2AK:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2AM
Lc2AL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Aw
Lc2Av:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qi_info(%rip),%rax
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
Lc2Aw:
	jmp *(%rbx)
Lc2AM:
	movq $16,904(%r13)
Lc2AJ:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_varzuexpr_info - _F95VarDeclParser_varzuexpr_info_dsp
.data
.align 3
.align 0
_s2qk_closure:
	.quad	_s2qk_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Bg_str:
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
_s2qk_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qk_info)+48
	.quad	0
	.quad	4294967318
_s2qk_info:
Lc2Bh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bi
Lc2Bj:
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
	leaq _c2Bg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Bf:
	jmp *(%rbx)
Lc2Bi:
	jmp *-16(%r13)
	.long  _s2qk_info - _s2qk_info_dsp
.data
.align 3
.align 0
_s2qj_closure:
	.quad	_s2qj_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qj_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qj_info)+56
	.quad	0
	.quad	30064771094
_s2qj_info:
Lc2Bq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Br
Lc2Bs:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Bp
Lc2Bo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95VarDeclParser_term_closure(%rip),%rsi
	leaq _F95VarDeclParser_optable_closure+2(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Bp:
	jmp *(%rbx)
Lc2Br:
	jmp *-16(%r13)
	.long  _s2qj_info - _s2qj_info_dsp
.data
.align 3
.align 0
_s2qq_closure:
	.quad	_s2qq_info
	.quad	0
.text
.align 3
_s2qp_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qp_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qp_info:
Lc2BD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BE
Lc2BF:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2BH
Lc2BG:
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
Lc2BH:
	movq $24,904(%r13)
Lc2BE:
	jmp *-8(%r13)
	.long  _s2qp_info - _s2qp_info_dsp
.text
.align 3
_s2qm_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qm_info)+80
	.quad	0
	.quad	12884901904
_s2qm_info:
Lc2BM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BN
Lc2BO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2BN:
	jmp *-16(%r13)
	.long  _s2qm_info - _s2qm_info_dsp
.text
.align 3
_s2qq_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qq_info)+0
	.quad	4294967301
	.quad	0
	.quad	30790620545039
_s2qq_info:
Lc2BP:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BQ
Lc2BR:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2BT
Lc2BS:
	leaq _s2qp_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2qm_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2BT:
	movq $32,904(%r13)
Lc2BQ:
	leaq _s2qq_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qq_info - _s2qq_info_dsp
.data
.align 3
.align 0
_s2qw_closure:
	.quad	_s2qw_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2C0_str:
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
_s2qw_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qw_info)+48
	.quad	0
	.quad	4294967318
_s2qw_info:
Lc2C1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2C2
Lc2C3:
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
	leaq _c2C0_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2BZ:
	jmp *(%rbx)
Lc2C2:
	jmp *-16(%r13)
	.long  _s2qw_info - _s2qw_info_dsp
.data
.align 3
.align 0
_s2qv_closure:
	.quad	_s2qv_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qs_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qs_info)+104
	.quad	0
	.quad	12884901904
_s2qs_info:
Lc2Cm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cn
Lc2Co:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_arrayzuidxzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Cn:
	jmp *-16(%r13)
	.long  _s2qs_info - _s2qs_info_dsp
.text
.align 3
_s2qt_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qt_info)+104
	.quad	0
	.quad	64424509456
_s2qt_info:
Lc2Cp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cq
Lc2Cr:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ct
Lc2Cs:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2qs_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _F95VarDeclParser_varzuexpr_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Ct:
	movq $16,904(%r13)
Lc2Cq:
	jmp *-16(%r13)
	.long  _s2qt_info - _s2qt_info_dsp
.text
.align 3
_s2qu_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qu_info)+104
	.quad	0
	.quad	133143986192
_s2qu_info:
Lc2Cu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cv
Lc2Cw:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Cy
Lc2Cx:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2qt_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_constzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Cy:
	movq $16,904(%r13)
Lc2Cv:
	jmp *-16(%r13)
	.long  _s2qu_info - _s2qu_info_dsp
.text
.align 3
_s2qr_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qr_info)+80
	.quad	0
	.quad	12884901904
_s2qr_info:
Lc2CD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CE
Lc2CF:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2CE:
	jmp *-16(%r13)
	.long  _s2qr_info - _s2qr_info_dsp
.text
.align 3
_s2qv_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qv_info)+80
	.quad	0
	.quad	1078036791318
_s2qv_info:
Lc2CG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CH
Lc2CI:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2CK
Lc2CJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2C9
Lc2C8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qu_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2qr_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2C9:
	jmp *(%rbx)
Lc2CK:
	movq $32,904(%r13)
Lc2CH:
	jmp *-16(%r13)
	.long  _s2qv_info - _s2qv_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_exprzuparser_info)+144
	.quad	0
	.quad	30064771094
.globl _F95VarDeclParser_exprzuparser_info
_F95VarDeclParser_exprzuparser_info:
Lc2CR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CS
Lc2CT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2CQ
Lc2CP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qk_closure(%rip),%rsi
	leaq _s2qj_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2CQ:
	jmp *(%rbx)
Lc2CS:
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
	.quad	_S2vo_srt-(_F95VarDeclParser_arrayzuidxzuexpr_info)+0
	.quad	0
	.quad	17733919965206
.globl _F95VarDeclParser_arrayzuidxzuexpr_info
_F95VarDeclParser_arrayzuidxzuexpr_info:
Lc2D0:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2D1
Lc2D2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2CZ
Lc2CY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qq_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2CZ:
	jmp *(%rbx)
Lc2D1:
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
	.quad	_S2vo_srt-(_F95VarDeclParser_term_info)+144
	.quad	0
	.quad	107374182422
.globl _F95VarDeclParser_term_info
_F95VarDeclParser_term_info:
Lc2D9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Da
Lc2Db:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2D8
Lc2D7:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qw_closure(%rip),%rsi
	leaq _s2qv_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2D8:
	jmp *(%rbx)
Lc2Da:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_term_info - _F95VarDeclParser_term_info_dsp
.data
.align 3
.align 0
_s2qC_closure:
	.quad	_s2qC_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qB_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qB_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2qB_info:
Lc2EC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ED
Lc2EE:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2ED:
	jmp *-8(%r13)
	.long  _s2qB_info - _s2qB_info_dsp
.text
.align 3
_s2qz_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qz_info)+40
	.quad	0
	.quad	1125904201809936
_s2qz_info:
Lc2EJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EK
Lc2EL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2EK:
	jmp *-16(%r13)
	.long  _s2qz_info - _s2qz_info_dsp
.text
.align 3
_s2qC_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qC_info)+0
	.quad	0
	.quad	36028938752884758
_s2qC_info:
Lc2EM:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EN
Lc2EO:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2EQ
Lc2EP:
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
	leaq _s2qB_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2qz_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Ew:
	jmp *(%rbx)
Lc2EQ:
	movq $32,904(%r13)
Lc2EN:
	jmp *-16(%r13)
	.long  _s2qC_info - _s2qC_info_dsp
.data
.align 3
.align 0
_s2qy_closure:
	.quad	_s2qy_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Fi_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2qx_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qx_info)+48
	.quad	0
	.quad	4294967312
_s2qx_info:
Lc2Fj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fk
Lc2Fl:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Fi_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Fk:
	jmp *-16(%r13)
	.long  _s2qx_info - _s2qx_info_dsp
.text
.align 3
_s2qy_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qy_info)+48
	.quad	0
	.quad	1125904201809942
_s2qy_info:
Lc2Fm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fn
Lc2Fo:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Fq
Lc2Fp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Fd
Lc2Fc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qx_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Fd:
	jmp *(%rbx)
Lc2Fq:
	movq $16,904(%r13)
Lc2Fn:
	jmp *-16(%r13)
	.long  _s2qy_info - _s2qy_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_arglistzuparser_info)+0
	.quad	0
	.quad	432345568522534934
.globl _F95VarDeclParser_arglistzuparser_info
_F95VarDeclParser_arglistzuparser_info:
Lc2FJ:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FK
Lc2FL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2FI
Lc2FH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qy_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qC_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2FI:
	jmp *(%rbx)
Lc2FK:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_arglistzuparser_info - _F95VarDeclParser_arglistzuparser_info_dsp
.data
.align 3
.align 0
_s2qQ_closure:
	.quad	_s2qQ_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qH_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qH_info)+216
	.quad	0
	.quad	12884901904
_s2qH_info:
Lc2Gw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Gx
Lc2Gy:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Gx:
	jmp *-16(%r13)
	.long  _s2qH_info - _s2qH_info_dsp
.const
.align 3
.align 0
_c2GD_str:
	.byte	105
	.byte	110
	.byte	0
.text
.align 3
_s2qI_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qI_info)+48
	.quad	0
	.quad	4294967312
_s2qI_info:
Lc2GE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GF
Lc2GG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2GD_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2GF:
	jmp *-16(%r13)
	.long  _s2qI_info - _s2qI_info_dsp
.const
.align 3
.align 0
_c2GP_str:
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qK_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qK_info)+48
	.quad	0
	.quad	4294967312
_s2qK_info:
Lc2GQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GR
Lc2GS:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2GP_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2GR:
	jmp *-16(%r13)
	.long  _s2qK_info - _s2qK_info_dsp
.const
.align 3
.align 0
_c2H1_str:
	.byte	105
	.byte	110
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qM_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qM_info)+48
	.quad	0
	.quad	4294967312
_s2qM_info:
Lc2H2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H3
Lc2H4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2H1_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2H3:
	jmp *-16(%r13)
	.long  _s2qM_info - _s2qM_info_dsp
.const
.align 3
.align 0
_c2Hh_str:
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
_s2qO_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qO_info)+48
	.quad	1
	.quad	63050399078154257
_s2qO_info:
Lc2Hc:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HM
Lc2HN:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2HP
Lc2HO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qH_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2qI_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2GH_info(%rip),%rdx
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
	.quad	_S2vo_srt-(_c2GH_info)+48
	.quad	2
	.quad	36028801313931296
_c2GH_info:
Lc2GH:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Ha
Lc2Hb:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2HL
Lc2HK:
	leaq _s2qK_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2GT_info(%rip),%rdx
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
	.quad	_S2vo_srt-(_c2GT_info)+48
	.quad	2
	.quad	36028801313931296
_c2GT_info:
Lc2GT:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Hq
Lc2Hr:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2HI
Lc2HH:
	leaq _s2qM_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Hd_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Ha:
	leaq _F95VarDecl_In_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vo_srt-(_c2Hd_info)+232
	.quad	0
	.quad	4294967328
_c2Hd_info:
Lc2Hd:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2HA
Lc2HB:
	leaq _c2Hh_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2Hq:
	leaq _F95VarDecl_Out_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2HA:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2HI:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2HL:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2HP:
	movq $32,904(%r13)
Lc2HM:
	jmp *-16(%r13)
	.long  _s2qO_info - _s2qO_info_dsp
.text
.align 3
_s2qP_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qP_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4035225545296838667
_s2qP_info:
Lc2HQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HR
Lc2HS:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2HU
Lc2HT:
	leaq _s2qO_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2HU:
	movq $24,904(%r13)
Lc2HR:
	jmp *-8(%r13)
	.long  _s2qP_info - _s2qP_info_dsp
.text
.align 3
_s2qF_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qF_info)+40
	.quad	0
	.quad	141733920784
_s2qF_info:
Lc2HZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2I0
Lc2I1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2I0:
	jmp *-16(%r13)
	.long  _s2qF_info - _s2qF_info_dsp
.text
.align 3
_s2qQ_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qQ_info)+0
	.quad	0
	.quad	4035230080782303254
_s2qQ_info:
Lc2I2:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2I3
Lc2I4:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2I6
Lc2I5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Gi
Lc2Gh:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qP_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2qF_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Gi:
	jmp *(%rbx)
Lc2I6:
	movq $32,904(%r13)
Lc2I3:
	jmp *-16(%r13)
	.long  _s2qQ_info - _s2qQ_info_dsp
.data
.align 3
.align 0
_s2qE_closure:
	.quad	_s2qE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Ja_str:
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	110
	.byte	116
	.byte	0
.text
.align 3
_s2qD_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qD_info)+48
	.quad	0
	.quad	4294967312
_s2qD_info:
Lc2Jb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jc
Lc2Jd:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Ja_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Jc:
	jmp *-16(%r13)
	.long  _s2qD_info - _s2qD_info_dsp
.text
.align 3
_s2qE_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qE_info)+48
	.quad	0
	.quad	1125904201809942
_s2qE_info:
Lc2Je:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jf
Lc2Jg:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ji
Lc2Jh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2J5
Lc2J4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2J5:
	jmp *(%rbx)
Lc2Ji:
	movq $16,904(%r13)
Lc2Jf:
	jmp *-16(%r13)
	.long  _s2qE_info - _s2qE_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_intentzuparser_info)+0
	.quad	0
	.quad	-4611686014132420586
.globl _F95VarDeclParser_intentzuparser_info
_F95VarDeclParser_intentzuparser_info:
Lc2JB:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2JC
Lc2JD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2JA
Lc2Jz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qE_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qQ_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2JA:
	jmp *(%rbx)
Lc2JC:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_intentzuparser_info - _F95VarDeclParser_intentzuparser_info_dsp
.data
.align 3
.align 0
_s2qZ_closure:
	.quad	_s2qZ_info
	.quad	0
.text
.align 3
_s2qX_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qX_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qX_info:
Lc2K1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2K2
Lc2K3:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2K5
Lc2K4:
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
Lc2K5:
	movq $24,904(%r13)
Lc2K2:
	jmp *-8(%r13)
	.long  _s2qX_info - _s2qX_info_dsp
.text
.align 3
_s2qY_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qY_info)+0
	.quad	1
	.quad	8800387989521
_s2qY_info:
Lc2K6:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2K7
Lc2K8:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ka
Lc2K9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qX_info(%rip),%rbx
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
Lc2Ka:
	movq $16,904(%r13)
Lc2K7:
	jmp *-16(%r13)
	.long  _s2qY_info - _s2qY_info_dsp
.text
.align 3
_s2qU_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2qU_info)+192
	.quad	0
	.quad	4294967312
_s2qU_info:
Lc2Kg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Kh
Lc2Ki:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Kk
Lc2Kj:
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
Lc2Kk:
	movq $24,904(%r13)
Lc2Kh:
	jmp *-16(%r13)
	.long  _s2qU_info - _s2qU_info_dsp
.const_data
.align 3
.align 0
_u2Kq_srtd:
	.quad	_S2vo_srt
	.quad	33
	.quad	4311746561
.text
.align 3
_s2qZ_info_dsp:
.text
.align 3
	.quad	_u2Kq_srtd-(_s2qZ_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2qZ_info:
Lc2Kl:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Km
Lc2Kn:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2Kp
Lc2Ko:
	leaq _s2qY_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2qU_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Kp:
	movq $40,904(%r13)
Lc2Km:
	leaq _s2qZ_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qZ_info - _s2qZ_info_dsp
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
_u2L3_srtd:
	.quad	_S2vo_srt
	.quad	33
	.quad	4294969345
.text
.align 3
_F95VarDeclParser_rangezuexpr_info_dsp:
.text
.align 3
	.quad	_u2L3_srtd-(_F95VarDeclParser_rangezuexpr_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_rangezuexpr_info
_F95VarDeclParser_rangezuexpr_info:
Lc2L0:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2L1
Lc2L2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2KZ
Lc2KY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qZ_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2KZ:
	jmp *(%rbx)
Lc2L1:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuexpr_info - _F95VarDeclParser_rangezuexpr_info_dsp
.data
.align 3
.align 0
_s2r4_closure:
	.quad	_s2r4_info
	.quad	0
.text
.align 3
_s2r4_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2r4_info)+264
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2r4_info:
Lc2Ll:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Lm
Lc2Ln:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2Lp
Lc2Lo:
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
Lc2Lp:
	movq $56,904(%r13)
Lc2Lm:
	leaq _s2r4_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r4_info - _s2r4_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_singlezuexprzurange_info)+88
	.quad	0
	.quad	54043199823413270
.globl _F95VarDeclParser_singlezuexprzurange_info
_F95VarDeclParser_singlezuexprzurange_info:
Lc2LF:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2LG
Lc2LH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2LE
Lc2LD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r4_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2LE:
	jmp *(%rbx)
Lc2LG:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuexprzurange_info - _F95VarDeclParser_singlezuexprzurange_info_dsp
.data
.align 3
.align 0
_s2ra_closure:
	.quad	_s2ra_info
	.quad	0
.text
.align 3
_s2ra_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2ra_info)+272
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2ra_info:
Lc2LZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2M0
Lc2M1:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2M3
Lc2M2:
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
Lc2M3:
	movq $72,904(%r13)
Lc2M0:
	leaq _s2ra_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2ra_info - _s2ra_info_dsp
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
_u2Mn_srtd:
	.quad	_S2vo_srt+8
	.quad	35
	.quad	25769803777
.text
.align 3
_F95VarDeclParser_singlezuconstzurange_info_dsp:
.text
.align 3
	.quad	_u2Mn_srtd-(_F95VarDeclParser_singlezuconstzurange_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_singlezuconstzurange_info
_F95VarDeclParser_singlezuconstzurange_info:
Lc2Mk:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ml
Lc2Mm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Mj
Lc2Mi:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2ra_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Mj:
	jmp *(%rbx)
Lc2Ml:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuconstzurange_info - _F95VarDeclParser_singlezuconstzurange_info_dsp
.data
.align 3
.align 0
_s2rg_closure:
	.quad	_s2rg_info
	.quad	0
.text
.align 3
_s2rg_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rg_info)+272
	.quad	4294967301
	.quad	0
	.quad	21474836495
_s2rg_info:
Lc2MG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2MH
Lc2MI:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2MK
Lc2MJ:
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
Lc2MK:
	movq $72,904(%r13)
Lc2MH:
	leaq _s2rg_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rg_info - _s2rg_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_singlezuvarzurange_info)+40
	.quad	0
	.quad	-6917529023346114538
.globl _F95VarDeclParser_singlezuvarzurange_info
_F95VarDeclParser_singlezuvarzurange_info:
Lc2N1:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2N2
Lc2N3:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2N0
Lc2MZ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rg_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2N0:
	jmp *(%rbx)
Lc2N2:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuvarzurange_info - _F95VarDeclParser_singlezuvarzurange_info_dsp
.data
.align 3
.align 0
_s2ro_closure:
	.quad	_s2ro_info
	.quad	0
.text
.align 3
_s2ro_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2ro_info)+272
	.quad	4294967301
	.quad	0
	.quad	38654705679
_s2ro_info:
Lc2Nh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ni
Lc2Nj:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Ni:
	leaq _s2ro_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2ro_info - _s2ro_info_dsp
.data
.align 3
.align 0
_s2rm_closure:
	.quad	_s2rm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2NA_str:
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
_s2rl_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rl_info)+48
	.quad	0
	.quad	4294967312
_s2rl_info:
Lc2NB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NC
Lc2ND:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2NA_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2NC:
	jmp *-16(%r13)
	.long  _s2rl_info - _s2rl_info_dsp
.text
.align 3
_s2ri_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2ri_info)+120
	.quad	0
	.quad	108086395351859216
_s2ri_info:
Lc2NQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NR
Lc2NS:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_singlezuconstzurange_closure(%rip),%rsi
	leaq _F95VarDeclParser_singlezuvarzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NR:
	jmp *-16(%r13)
	.long  _s2ri_info - _s2ri_info_dsp
.text
.align 3
_s2rj_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rj_info)+120
	.quad	0
	.quad	252201583427715088
_s2rj_info:
Lc2NT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NU
Lc2NV:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2NX
Lc2NW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2ri_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_singlezuexprzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NX:
	movq $16,904(%r13)
Lc2NU:
	jmp *-16(%r13)
	.long  _s2rj_info - _s2rj_info_dsp
.text
.align 3
_s2rh_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rh_info)+104
	.quad	0
	.quad	1152921508901814288
_s2rh_info:
Lc2O2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O3
Lc2O4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2O3:
	jmp *-16(%r13)
	.long  _s2rh_info - _s2rh_info_dsp
.text
.align 3
_s2rk_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rk_info)+104
	.quad	0
	.quad	2161727842612674576
_s2rk_info:
Lc2O5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O6
Lc2O7:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2O9
Lc2O8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rj_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rh_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2O9:
	movq $32,904(%r13)
Lc2O6:
	jmp *-16(%r13)
	.long  _s2rk_info - _s2rk_info_dsp
.const_data
.align 3
.align 0
_u2Of_srtd:
	.quad	_S2vo_srt+48
	.quad	36
	.quad	64424514177
.text
.align 3
_s2rm_info_dsp:
.text
.align 3
	.quad	_u2Of_srtd-(_s2rm_info)+0
	.quad	0
	.quad	-4294967274
_s2rm_info:
Lc2Oa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ob
Lc2Oc:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Oe
Lc2Od:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Nv
Lc2Nu:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rl_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rk_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Nv:
	jmp *(%rbx)
Lc2Oe:
	movq $32,904(%r13)
Lc2Ob:
	jmp *-16(%r13)
	.long  _s2rm_info - _s2rm_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_rangezuparser_info)+272
	.quad	0
	.quad	1138166333462
.globl _F95VarDeclParser_rangezuparser_info
_F95VarDeclParser_rangezuparser_info:
Lc2OT:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OU
Lc2OV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2OS
Lc2OR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rm_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2ro_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2OS:
	jmp *(%rbx)
Lc2OU:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuparser_info - _F95VarDeclParser_rangezuparser_info_dsp
.data
.align 3
.align 0
_s2rv_closure:
	.quad	_s2rv_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2ru_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2ru_info)+272
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2ru_info:
Lc2Pg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ph
Lc2Pi:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Ph:
	jmp *-8(%r13)
	.long  _s2ru_info - _s2ru_info_dsp
.text
.align 3
_s2rr_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rr_info)+184
	.quad	0
	.quad	4503603922337808
_s2rr_info:
Lc2Pr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ps
Lc2Pt:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuparser_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ps:
	jmp *-16(%r13)
	.long  _s2rr_info - _s2rr_info_dsp
.const_data
.align 3
.align 0
_u2PE_srtd:
	.quad	_S2vo_srt+80
	.quad	34
	.quad	8589942785
.text
.align 3
_s2rs_info_dsp:
.text
.align 3
	.quad	_u2PE_srtd-(_s2rs_info)+0
	.quad	0
	.quad	-4294967280
_s2rs_info:
Lc2Pu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pv
Lc2Pw:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Py
Lc2Px:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rr_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Py:
	movq $16,904(%r13)
Lc2Pv:
	jmp *-16(%r13)
	.long  _s2rs_info - _s2rs_info_dsp
.const_data
.align 3
.align 0
_u2PF_srtd:
	.quad	_S2vo_srt+80
	.quad	34
	.quad	8606720001
.text
.align 3
_s2rv_info_dsp:
.text
.align 3
	.quad	_u2PF_srtd-(_s2rv_info)+0
	.quad	0
	.quad	-4294967274
_s2rv_info:
Lc2Pz:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PA
Lc2PB:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2PD
Lc2PC:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Pa
Lc2P9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2ru_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2rs_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Pa:
	jmp *(%rbx)
Lc2PD:
	movq $32,904(%r13)
Lc2PA:
	jmp *-16(%r13)
	.long  _s2rv_info - _s2rv_info_dsp
.data
.align 3
.align 0
_s2rq_closure:
	.quad	_s2rq_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Qe_str:
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
_s2rp_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rp_info)+352
	.quad	0
	.quad	4294967312
_s2rp_info:
Lc2Qf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Qg
Lc2Qh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Qe_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Qg:
	jmp *-16(%r13)
	.long  _s2rp_info - _s2rp_info_dsp
.text
.align 3
_s2rq_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rq_info)+192
	.quad	0
	.quad	4503603922337814
_s2rq_info:
Lc2Qi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Qj
Lc2Qk:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Qm
Lc2Ql:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Q9
Lc2Q8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rp_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Q9:
	jmp *(%rbx)
Lc2Qm:
	movq $16,904(%r13)
Lc2Qj:
	jmp *-16(%r13)
	.long  _s2rq_info - _s2rq_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_dimzuparser_info)+272
	.quad	0
	.quad	26392574033942
.globl _F95VarDeclParser_dimzuparser_info
_F95VarDeclParser_dimzuparser_info:
Lc2QF:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QG
Lc2QH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2QE
Lc2QD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rq_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rv_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2QE:
	jmp *(%rbx)
Lc2QG:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_dimzuparser_info - _F95VarDeclParser_dimzuparser_info_dsp
.data
.align 3
.align 0
_s2rW_closure:
	.quad	_s2rW_info
	.quad	0
.text
.align 3
_s2rQ_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rQ_info)+376
	.quad	1
	.quad	4294967313
_s2rQ_info:
Lc2Rw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Rx
Lc2Ry:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Rx:
	jmp *-16(%r13)
	.long  _s2rQ_info - _s2rQ_info_dsp
.text
.align 3
_s2rT_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rT_info)+376
	.quad	1
	.quad	30064771089
_s2rT_info:
Lc2RI:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2RS
Lc2RT:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2RV
Lc2RU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rQ_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c2Rz_info(%rip),%rcx
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
	.quad	_S2vo_srt-(_c2Rz_info)+384
	.quad	1
	.quad	4294967328
_c2Rz_info:
Lc2Rz:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2RG
Lc2RH:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2RG:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2RP
Lc2RO:
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $4,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2RP:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RV:
	movq $24,904(%r13)
Lc2RS:
	jmp *-16(%r13)
	.long  _s2rT_info - _s2rT_info_dsp
.text
.align 3
_s2rI_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rI_info)+216
	.quad	0
	.quad	12884901904
_s2rI_info:
Lc2S4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2S5
Lc2S6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2S5:
	jmp *-16(%r13)
	.long  _s2rI_info - _s2rI_info_dsp
.const
.align 3
.align 0
_c2Sb_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	108
	.byte	0
.text
.align 3
_s2rJ_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rJ_info)+352
	.quad	0
	.quad	4294967312
_s2rJ_info:
Lc2Sc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sd
Lc2Se:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Sb_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Sd:
	jmp *-16(%r13)
	.long  _s2rJ_info - _s2rJ_info_dsp
.const
.align 3
.align 0
_c2Sn_str:
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
_s2rL_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rL_info)+352
	.quad	0
	.quad	4294967312
_s2rL_info:
Lc2So:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sp
Lc2Sq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Sn_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Sp:
	jmp *-16(%r13)
	.long  _s2rL_info - _s2rL_info_dsp
.const
.align 3
.align 0
_c2Sz_str:
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
_s2rN_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rN_info)+352
	.quad	0
	.quad	4294967312
_s2rN_info:
Lc2SA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2SB
Lc2SC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Sz_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2SB:
	jmp *-16(%r13)
	.long  _s2rN_info - _s2rN_info_dsp
.text
.align 3
_s2rP_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rP_info)+216
	.quad	1
	.quad	108649353895215121
_s2rP_info:
Lc2SK:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2T9
Lc2Ta:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tc
Lc2Tb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rI_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2rJ_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2Sf_info(%rip),%rdx
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
	.quad	_S2vo_srt-(_c2Sf_info)+352
	.quad	2
	.quad	828928688160
_c2Sf_info:
Lc2Sf:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2SI
Lc2SJ:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2T8
Lc2T7:
	leaq _s2rL_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Sr_info(%rip),%rdx
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
	.quad	_S2vo_srt-(_c2Sr_info)+352
	.quad	1
	.quad	828928688160
_c2Sr_info:
Lc2Sr:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2SU
Lc2SV:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2T5
Lc2T4:
	leaq _s2rN_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2SL_info(%rip),%rcx
	movq %rcx,8(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $8,%rbp
	jmp _stg_ap_pp_fast
Lc2SI:
	leaq _F95VarDecl_F95Real_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vo_srt-(_c2SL_info)+408
	.quad	0
	.quad	4294967328
_c2SL_info:
Lc2SL:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2SU:
	leaq _F95VarDecl_F95Integer_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2T5:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2T8:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Tc:
	movq $32,904(%r13)
Lc2T9:
	jmp *-16(%r13)
	.long  _s2rP_info - _s2rP_info_dsp
.text
.align 3
_s2rV_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rV_info)+216
	.quad	4294967301
	.quad	1
	.quad	140175101042622474
_s2rV_info:
Lc2Te:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tf
Lc2Tg:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ti
Lc2Th:
	movq 7(%rbx),%rax
	leaq _s2rT_info(%rip),%rbx
	movq %rbx,-64(%r12)
	movq %r14,-48(%r12)
	leaq -64(%r12),%rbx
	leaq _s2rP_info(%rip),%rcx
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
Lc2Ti:
	movq $72,904(%r13)
Lc2Tf:
	jmp *-8(%r13)
	.long  _s2rV_info - _s2rV_info_dsp
.text
.align 3
_s2rB_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rB_info)+192
	.quad	0
	.quad	4294967312
_s2rB_info:
Lc2TI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TJ
Lc2TK:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2TM
Lc2TL:
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
Lc2TM:
	movq $24,904(%r13)
Lc2TJ:
	jmp *-16(%r13)
	.long  _s2rB_info - _s2rB_info_dsp
.const
.align 3
.align 0
_c2TV_str:
	.byte	107
	.byte	105
	.byte	110
	.byte	100
	.byte	0
.text
.align 3
_s2rx_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rx_info)+352
	.quad	0
	.quad	4294967312
_s2rx_info:
Lc2TW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TX
Lc2TY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2TV_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2TX:
	jmp *-16(%r13)
	.long  _s2rx_info - _s2rx_info_dsp
.text
.align 3
_s2ry_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2ry_info)+192
	.quad	0
	.quad	4503603922337808
_s2ry_info:
Lc2TZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2U0
Lc2U1:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2U3
Lc2U2:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rx_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2U3:
	movq $16,904(%r13)
Lc2U0:
	jmp *-16(%r13)
	.long  _s2ry_info - _s2ry_info_dsp
.text
.align 3
_s2rC_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rC_info)+192
	.quad	0
	.quad	4508001968848912
_s2rC_info:
Lc2U4:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2U5
Lc2U6:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2U8
Lc2U7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rB_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2ry_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2U8:
	movq $32,904(%r13)
Lc2U5:
	jmp *-16(%r13)
	.long  _s2rC_info - _s2rC_info_dsp
.const_data
.align 3
.align 0
_u2Uy_srtd:
	.quad	_S2vo_srt+8
	.quad	44
	.quad	8804691345409
.text
.align 3
_s2rD_info_dsp:
.text
.align 3
	.quad	_u2Uy_srtd-(_s2rD_info)+0
	.quad	0
	.quad	-4294967280
_s2rD_info:
Lc2U9:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ua
Lc2Ub:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ud
Lc2Uc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rC_info(%rip),%rax
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
Lc2Ud:
	movq $16,904(%r13)
Lc2Ua:
	jmp *-16(%r13)
	.long  _s2rD_info - _s2rD_info_dsp
.const_data
.align 3
.align 0
_u2Uz_srtd:
	.quad	_S2vo_srt+8
	.quad	44
	.quad	8804691361793
.text
.align 3
_s2rE_info_dsp:
.text
.align 3
	.quad	_u2Uz_srtd-(_s2rE_info)+0
	.quad	0
	.quad	-4294967280
_s2rE_info:
Lc2Ue:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Uf
Lc2Ug:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ui
Lc2Uh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95ParserCommon_natural_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Ui:
	movq $16,904(%r13)
Lc2Uf:
	jmp *-16(%r13)
	.long  _s2rE_info - _s2rE_info_dsp
.const_data
.align 3
.align 0
_u2UA_srtd:
	.quad	_S2vo_srt+8
	.quad	44
	.quad	8804691362305
.text
.align 3
_s2rF_info_dsp:
.text
.align 3
	.quad	_u2UA_srtd-(_s2rF_info)+0
	.quad	0
	.quad	-4294967280
_s2rF_info:
Lc2Uj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Uk
Lc2Ul:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Un
Lc2Um:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rE_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Un:
	movq $16,904(%r13)
Lc2Uk:
	jmp *-16(%r13)
	.long  _s2rF_info - _s2rF_info_dsp
.const_data
.align 3
.align 0
_u2UB_srtd:
	.quad	_S2vo_srt+8
	.quad	52
	.quad	2260604505047553
.text
.align 3
_s2rG_info_dsp:
.text
.align 3
	.quad	_u2UB_srtd-(_s2rG_info)+0
	.quad	0
	.quad	-4294967280
_s2rG_info:
Lc2Uo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Up
Lc2Uq:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Us
Lc2Ur:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rF_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Us:
	movq $16,904(%r13)
Lc2Up:
	jmp *-16(%r13)
	.long  _s2rG_info - _s2rG_info_dsp
.const_data
.align 3
.align 0
_u2UC_srtd:
	.quad	_S2vo_srt+8
	.quad	53
	.quad	8945635403252225
.text
.align 3
_s2rW_info_dsp:
.text
.align 3
	.quad	_u2UC_srtd-(_s2rW_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2rW_info:
Lc2Ut:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Uu
Lc2Uv:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ux
Lc2Uw:
	leaq _s2rV_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2rG_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Ux:
	movq $32,904(%r13)
Lc2Uu:
	leaq _s2rW_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rW_info - _s2rW_info_dsp
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
_u2WE_srtd:
	.quad	_S2vo_srt+40
	.quad	49
	.quad	281475513581569
.text
.align 3
_F95VarDeclParser_typezuparser_info_dsp:
.text
.align 3
	.quad	_u2WE_srtd-(_F95VarDeclParser_typezuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_typezuparser_info
_F95VarDeclParser_typezuparser_info:
Lc2WB:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2WC
Lc2WD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2WA
Lc2Wz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rW_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2WA:
	jmp *(%rbx)
Lc2WC:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_typezuparser_info - _F95VarDeclParser_typezuparser_info_dsp
.data
.align 3
.align 0
_s2sf_closure:
	.quad	_s2sf_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2s3_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2s3_info)+216
	.quad	0
	.quad	12884901904
_s2s3_info:
Lc2XF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2XG
Lc2XH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2XG:
	jmp *-16(%r13)
	.long  _s2s3_info - _s2s3_info_dsp
.const
.align 3
.align 0
_c2XM_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	100
	.byte	0
.text
.align 3
_s2s4_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2s4_info)+352
	.quad	0
	.quad	4294967312
_s2s4_info:
Lc2XN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2XO
Lc2XP:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2XM_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2XO:
	jmp *-16(%r13)
	.long  _s2s4_info - _s2s4_info_dsp
.const
.align 3
.align 0
_c2XY_str:
	.byte	119
	.byte	114
	.byte	105
	.byte	116
	.byte	101
	.byte	0
.text
.align 3
_s2s6_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2s6_info)+352
	.quad	0
	.quad	4294967312
_s2s6_info:
Lc2XZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Y0
Lc2Y1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2XY_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Y0:
	jmp *-16(%r13)
	.long  _s2s6_info - _s2s6_info_dsp
.const
.align 3
.align 0
_c2Ya_str:
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
_s2s8_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2s8_info)+352
	.quad	0
	.quad	4294967312
_s2s8_info:
Lc2Yb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yc
Lc2Yd:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Ya_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Yc:
	jmp *-16(%r13)
	.long  _s2s8_info - _s2s8_info_dsp
.const
.align 3
.align 0
_c2Yq_str:
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
_s2sa_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sa_info)+216
	.quad	1
	.quad	562980018192401
_s2sa_info:
Lc2Yl:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YV
Lc2YW:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2YY
Lc2YX:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2s3_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2s4_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2XQ_info(%rip),%rdx
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
	.quad	_S2vo_srt-(_c2XQ_info)+232
	.quad	2
	.quad	140741783322656
_c2XQ_info:
Lc2XQ:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Yj
Lc2Yk:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YU
Lc2YT:
	leaq _s2s6_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Y2_info(%rip),%rdx
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
	.quad	_S2vo_srt-(_c2Y2_info)+232
	.quad	2
	.quad	140741783322656
_c2Y2_info:
Lc2Y2:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Yz
Lc2YA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YR
Lc2YQ:
	leaq _s2s8_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Ym_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Yj:
	leaq _F95VarDecl_Read_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vo_srt-(_c2Ym_info)+232
	.quad	0
	.quad	4294967328
_c2Ym_info:
Lc2Ym:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2YJ
Lc2YK:
	leaq _c2Yq_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2Yz:
	leaq _F95VarDecl_Write_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2YJ:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2YR:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2YU:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2YY:
	movq $32,904(%r13)
Lc2YV:
	jmp *-16(%r13)
	.long  _s2sa_info - _s2sa_info_dsp
.text
.align 3
_s2sb_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sb_info)+216
	.quad	4294967301
	.quad	4294967296
	.quad	563529774006283
_s2sb_info:
Lc2YZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Z0
Lc2Z1:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Z3
Lc2Z2:
	leaq _s2sa_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Z3:
	movq $24,904(%r13)
Lc2Z0:
	jmp *-8(%r13)
	.long  _s2sb_info - _s2sb_info_dsp
.const_data
.align 3
.align 0
_u2ZF_srtd:
	.quad	_S2vo_srt+40
	.quad	40
	.quad	550322044929
.text
.align 3
_s2sc_info_dsp:
.text
.align 3
	.quad	_u2ZF_srtd-(_s2sc_info)+0
	.quad	0
	.quad	-4294967280
_s2sc_info:
Lc2Z4:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Z5
Lc2Z6:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Z8
Lc2Z7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sb_info(%rip),%rax
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
Lc2Z8:
	movq $16,904(%r13)
Lc2Z5:
	jmp *-16(%r13)
	.long  _s2sc_info - _s2sc_info_dsp
.const_data
.align 3
.align 0
_u2ZG_srtd:
	.quad	_S2vo_srt+40
	.quad	40
	.quad	550322044929
.text
.align 3
_s2sd_info_dsp:
.text
.align 3
	.quad	_u2ZG_srtd-(_s2sd_info)+0
	.quad	0
	.quad	-4294967280
_s2sd_info:
Lc2Z9:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Za
Lc2Zb:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zd
Lc2Zc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sc_info(%rip),%rax
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
Lc2Zd:
	movq $16,904(%r13)
Lc2Za:
	jmp *-16(%r13)
	.long  _s2sd_info - _s2sd_info_dsp
.const
.align 3
.align 0
_c2Zm_str:
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	0
.text
.align 3
_s2s0_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2s0_info)+352
	.quad	0
	.quad	4294967312
_s2s0_info:
Lc2Zn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zo
Lc2Zp:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Zm_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Zo:
	jmp *-16(%r13)
	.long  _s2s0_info - _s2s0_info_dsp
.text
.align 3
_s2s1_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2s1_info)+192
	.quad	0
	.quad	4503603922337808
_s2s1_info:
Lc2Zq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zr
Lc2Zs:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zu
Lc2Zt:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s0_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Zu:
	movq $16,904(%r13)
Lc2Zr:
	jmp *-16(%r13)
	.long  _s2s1_info - _s2s1_info_dsp
.const_data
.align 3
.align 0
_u2ZH_srtd:
	.quad	_S2vo_srt+40
	.quad	40
	.quad	550322569217
.text
.align 3
_s2se_info_dsp:
.text
.align 3
	.quad	_u2ZH_srtd-(_s2se_info)+0
	.quad	0
	.quad	-4294967280
_s2se_info:
Lc2Zv:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zw
Lc2Zx:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zz
Lc2Zy:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sd_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2s1_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Zz:
	movq $32,904(%r13)
Lc2Zw:
	jmp *-16(%r13)
	.long  _s2se_info - _s2se_info_dsp
.const_data
.align 3
.align 0
_u2ZI_srtd:
	.quad	_S2vo_srt+40
	.quad	50
	.quad	563500275990529
.text
.align 3
_s2sf_info_dsp:
.text
.align 3
	.quad	_u2ZI_srtd-(_s2sf_info)+0
	.quad	0
	.quad	-4294967274
_s2sf_info:
Lc2ZA:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ZB
Lc2ZC:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2ZE
Lc2ZD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Xf
Lc2Xe:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2se_info(%rip),%rax
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
Lc2Xf:
	jmp *(%rbx)
Lc2ZE:
	movq $16,904(%r13)
Lc2ZB:
	jmp *-16(%r13)
	.long  _s2sf_info - _s2sf_info_dsp
.data
.align 3
.align 0
_s2rZ_closure:
	.quad	_s2rZ_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rX_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rX_info)+440
	.quad	0
	.quad	12884901904
_s2rX_info:
Lc31h:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31i
Lc31j:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc31i:
	jmp *-16(%r13)
	.long  _s2rX_info - _s2rX_info_dsp
.text
.align 3
_s2rZ_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2rZ_info)+440
	.quad	0
	.quad	30064771094
_s2rZ_info:
Lc31k:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31l
Lc31m:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc31o
Lc31n:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31c
Lc31b:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rX_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rbx
	leaq 529(%rbx),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc31c:
	jmp *(%rbx)
Lc31o:
	movq $16,904(%r13)
Lc31l:
	jmp *-16(%r13)
	.long  _s2rZ_info - _s2rZ_info_dsp
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
	.quad	_S2vo_srt-(_F95VarDeclParser_oclzuargmodezuparser_info)+272
	.quad	0
	.quad	216172786408751126
.globl _F95VarDeclParser_oclzuargmodezuparser_info
_F95VarDeclParser_oclzuargmodezuparser_info:
Lc31H:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31I
Lc31J:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31G
Lc31F:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rZ_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2sf_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc31G:
	jmp *(%rbx)
Lc31I:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_oclzuargmodezuparser_info - _F95VarDeclParser_oclzuargmodezuparser_info_dsp
.data
.align 3
.align 0
_s2sJ_closure:
	.quad	_s2sJ_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2sp_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sp_info)+376
	.quad	1
	.quad	4294967313
_s2sp_info:
Lc32D:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32E
Lc32F:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc32E:
	jmp *-16(%r13)
	.long  _s2sp_info - _s2sp_info_dsp
.text
.align 3
_s2so_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2so_info)+376
	.quad	1
	.quad	30064771089
_s2so_info:
Lc32P:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32W
Lc32X:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc32Z
Lc32Y:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sp_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c32G_info(%rip),%rcx
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
	.quad	_S2vo_srt-(_c32G_info)+384
	.quad	1
	.quad	4294967328
_c32G_info:
Lc32G:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc32N
Lc32O:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc32N:
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc32Z:
	movq $24,904(%r13)
Lc32W:
	jmp *-16(%r13)
	.long  _s2so_info - _s2so_info_dsp
.text
.align 3
_s2st_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2st_info)+376
	.quad	1
	.quad	4294967313
_s2st_info:
Lc338:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc339
Lc33a:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc339:
	jmp *-16(%r13)
	.long  _s2st_info - _s2st_info_dsp
.text
.align 3
_s2ss_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2ss_info)+376
	.quad	1
	.quad	30064771089
_s2ss_info:
Lc33k:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33r
Lc33s:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc33u
Lc33t:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2st_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c33b_info(%rip),%rcx
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
	.quad	_S2vo_srt-(_c33b_info)+384
	.quad	1
	.quad	4294967328
_c33b_info:
Lc33b:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc33i
Lc33j:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc33i:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc33u:
	movq $24,904(%r13)
Lc33r:
	jmp *-16(%r13)
	.long  _s2ss_info - _s2ss_info_dsp
.text
.align 3
_s2sz_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sz_info)+376
	.quad	1
	.quad	4294967313
_s2sz_info:
Lc33W:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33X
Lc33Y:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33X:
	jmp *-16(%r13)
	.long  _s2sz_info - _s2sz_info_dsp
.text
.align 3
_s2sC_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sC_info)+376
	.quad	1
	.quad	30064771089
_s2sC_info:
Lc348:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34f
Lc34g:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc34i
Lc34h:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sz_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c33Z_info(%rip),%rcx
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
	.quad	_S2vo_srt-(_c33Z_info)+384
	.quad	1
	.quad	4294967328
_c33Z_info:
Lc33Z:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc346
Lc347:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc346:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc34i:
	movq $24,904(%r13)
Lc34f:
	jmp *-16(%r13)
	.long  _s2sC_info - _s2sC_info_dsp
.text
.align 3
_s2sE_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sE_info)+272
	.quad	4294967301
	.quad	4
	.quad	246294899589129
_s2sE_info:
Lc34k:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34l
Lc34m:
	addq $96,%r12
	cmpq 856(%r13),%r12
	ja Lc34o
Lc34n:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rdx
	movq 31(%rbx),%rbx
	leaq _s2sC_info(%rip),%rsi
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
Lc34o:
	movq $96,904(%r13)
Lc34l:
	jmp *-8(%r13)
	.long  _s2sE_info - _s2sE_info_dsp
.text
.align 3
_s2sx_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sx_info)+416
	.quad	0
	.quad	1103806595088
_s2sx_info:
Lc34t:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34u
Lc34v:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_oclzuargmodezuparser_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34u:
	jmp *-16(%r13)
	.long  _s2sx_info - _s2sx_info_dsp
.text
.align 3
_s2sF_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sF_info)+272
	.quad	4294967301
	.quad	3
	.quad	289602570958143497
_s2sF_info:
Lc34w:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34x
Lc34y:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc34A
Lc34z:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _s2sE_info(%rip),%rdx
	movq %rdx,-48(%r12)
	movq %rax,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	leaq -47(%r12),%rax
	leaq _s2sx_info(%rip),%rbx
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
	movq $56,904(%r13)
Lc34x:
	jmp *-8(%r13)
	.long  _s2sF_info - _s2sF_info_dsp
.text
.align 3
_s2sG_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sG_info)+272
	.quad	4294967301
	.quad	2
	.quad	866063323261566988
_s2sG_info:
Lc34B:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34C
Lc34D:
	addq $80,%r12
	cmpq 856(%r13),%r12
	ja Lc34F
Lc34E:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _s2so_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %rbx,-56(%r12)
	leaq -72(%r12),%rbx
	leaq _s2ss_info(%rip),%rcx
	movq %rcx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rcx
	leaq _s2sF_info(%rip),%rdx
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
Lc34F:
	movq $80,904(%r13)
Lc34C:
	jmp *-8(%r13)
	.long  _s2sG_info - _s2sG_info_dsp
.text
.align 3
_s2sl_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sl_info)+272
	.quad	0
	.quad	3458764518115508240
_s2sl_info:
Lc34O:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34P
Lc34Q:
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
Lc34P:
	jmp *-16(%r13)
	.long  _s2sl_info - _s2sl_info_dsp
.text
.align 3
_s2sm_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sm_info)+272
	.quad	0
	.quad	3459890418022350864
_s2sm_info:
Lc34R:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34S
Lc34T:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34V
Lc34U:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sl_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34V:
	movq $16,904(%r13)
Lc34S:
	jmp *-16(%r13)
	.long  _s2sm_info - _s2sm_info_dsp
.text
.align 3
_s2sH_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sH_info)+272
	.quad	4294967301
	.quad	1
	.quad	4324827837082107914
_s2sH_info:
Lc34W:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34X
Lc34Y:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc350
Lc34Z:
	movq 7(%rbx),%rax
	leaq _s2sG_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -31(%r12),%rax
	leaq _s2sm_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc350:
	movq $40,904(%r13)
Lc34X:
	jmp *-8(%r13)
	.long  _s2sH_info - _s2sH_info_dsp
.text
.align 3
_s2sh_info_dsp:
.text
.align 3
	.quad	_S2vo_srt-(_s2sh_info)+272
	.quad	0
	.quad	5764607527329202192
_s2sh_info:
Lc35d:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35e
Lc35f:
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
Lc35e:
	jmp *-16(%r13)
	.long  _s2sh_info - _s2sh_info_dsp
.const_data
.align 3
.align 0
_u35A_srtd:
	.quad	_S2vo_srt+104
	.quad	52
	.quad	2814749769203713
.text
.align 3
_s2si_info_dsp:
.text
.align 3
	.quad	_u35A_srtd-(_s2si_info)+0
	.quad	0
	.quad	-4294967280
_s2si_info:
Lc35g:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35h
Lc35i:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35k
Lc35j:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sh_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc35k:
	movq $16,904(%r13)
Lc35h:
	jmp *-16(%r13)
	.long  _s2si_info - _s2si_info_dsp
.const_data
.align 3
.align 0
_u35B_srtd:
	.quad	_S2vo_srt+104
	.quad	52
	.quad	2815299525017601
.text
.align 3
_s2sj_info_dsp:
.text
.align 3
	.quad	_u35B_srtd-(_s2sj_info)+0
	.quad	0
	.quad	-4294967280
_s2sj_info:
Lc35l:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35m
Lc35n:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35p
Lc35o:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2si_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc35p:
	movq $16,904(%r13)
Lc35m:
	jmp *-16(%r13)
	.long  _s2sj_info - _s2sj_info_dsp
.const_data
.align 3
.align 0
_u35C_srtd:
	.quad	_S2vo_srt+104
	.quad	52
	.quad	4363532156010497
.text
.align 3
_s2sI_info_dsp:
.text
.align 3
	.quad	_u35C_srtd-(_s2sI_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	-4294967285
_s2sI_info:
Lc35q:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35r
Lc35s:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc35u
Lc35t:
	leaq _s2sH_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2sj_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc35u:
	movq $32,904(%r13)
Lc35r:
	jmp *-8(%r13)
	.long  _s2sI_info - _s2sI_info_dsp
.const_data
.align 3
.align 0
_u35D_srtd:
	.quad	_S2vo_srt+104
	.quad	53
	.quad	8867131783380993
.text
.align 3
_s2sJ_info_dsp:
.text
.align 3
	.quad	_u35D_srtd-(_s2sJ_info)+0
	.quad	0
	.quad	-4294967274
_s2sJ_info:
Lc35v:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35w
Lc35x:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35z
Lc35y:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc32f
Lc32e:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2sI_info(%rip),%rax
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
Lc32f:
	jmp *(%rbx)
Lc35z:
	movq $16,904(%r13)
Lc35w:
	jmp *-16(%r13)
	.long  _s2sJ_info - _s2sJ_info_dsp
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
_u37M_srtd:
	.quad	_S2vo_srt+272
	.quad	33
	.quad	4296015873
.text
.align 3
_F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp:
.text
.align 3
	.quad	_u37M_srtd-(_F95VarDeclParser_f95zuvarzudeclzuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_f95zuvarzudeclzuparser_info
_F95VarDeclParser_f95zuvarzudeclzuparser_info:
Lc37J:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc37K
Lc37L:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc37I
Lc37H:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_whiteSpace_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2sJ_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc37I:
	jmp *(%rbx)
Lc37K:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_f95zuvarzudeclzuparser_info - _F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp
.const_data
.align 3
.align 0
_S2vo_srt:
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_F95ParserCommon_natural_closure
	.quad	_F95ParserCommon_reservedOp_closure
	.quad	_r2kN_closure
	.quad	_r2pt_closure
	.quad	_F95ParserCommon_word_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure
	.quad	_F95VarDeclParser_term_closure
	.quad	_F95VarDeclParser_optable_closure
	.quad	_F95ParserCommon_parens_closure
	.quad	_F95VarDeclParser_exprzuparser_closure
	.quad	_s2qq_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95VarDeclParser_arrayzuidxzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure
	.quad	_F95VarDeclParser_varzuexpr_closure
	.quad	_F95VarDeclParser_constzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure
	.quad	_s2qj_closure
	.quad	_s2qk_closure
	.quad	_s2qv_closure
	.quad	_s2qw_closure
	.quad	_F95ParserCommon_commaSep_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_s2qy_closure
	.quad	_s2qC_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_base_ControlziExceptionziBase_patError_closure
	.quad	_s2qE_closure
	.quad	_s2qQ_closure
	.quad	_s2qZ_closure
	.quad	_s2r4_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_s2ra_closure
	.quad	_s2rg_closure
	.quad	_s2ro_closure
	.quad	_F95VarDeclParser_singlezuvarzurange_closure
	.quad	_F95VarDeclParser_singlezuconstzurange_closure
	.quad	_F95VarDeclParser_singlezuexprzurange_closure
	.quad	_F95VarDeclParser_rangezuexpr_closure
	.quad	_s2rm_closure
	.quad	_F95VarDeclParser_rangezuparser_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_s2rq_closure
	.quad	_s2rv_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziList_head_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqInt_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_many_closure
	.quad	_s2rW_closure
	.quad	_F95ParserCommon_whiteSpace_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_s2rZ_closure
	.quad	_s2sf_closure
	.quad	_F95VarDeclParser_oclzuargmodezuparser_closure
	.quad	_F95VarDeclParser_arglistzuparser_closure
	.quad	_F95ParserCommon_comma_closure
	.quad	_F95VarDeclParser_intentzuparser_closure
	.quad	_F95VarDeclParser_dimzuparser_closure
	.quad	_F95VarDeclParser_typezuparser_closure
	.quad	_s2sJ_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

