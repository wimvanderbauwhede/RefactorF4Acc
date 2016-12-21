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
_s2pP_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2pP_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2pP_info:
Lc2vg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vh
Lc2vi:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vk
Lc2vj:
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
Lc2vk:
	movq $16,904(%r13)
Lc2vh:
	jmp *-8(%r13)
	.long  _s2pP_info - _s2pP_info_dsp
.text
.align 3
_F95VarDeclParser_constzuexpr_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_F95VarDeclParser_constzuexpr_info)+0
	.quad	0
	.quad	12884901910
.globl _F95VarDeclParser_constzuexpr_info
_F95VarDeclParser_constzuexpr_info:
Lc2vl:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vm
Lc2vn:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vp
Lc2vo:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2v9
Lc2v8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2pP_info(%rip),%rax
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
Lc2v9:
	jmp *(%rbx)
Lc2vp:
	movq $16,904(%r13)
Lc2vm:
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
_s2pU_info_dsp:
.text
.align 3
	.quad	4294967301
	.quad	1
	.quad	10
_s2pU_info:
Lc2vY:
Lc2w0:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2w2
Lc2w1:
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
Lc2w2:
	movq $40,904(%r13)
Lc2vZ:
	jmp *-8(%r13)
	.long  _s2pU_info - _s2pU_info_dsp
.text
.align 3
_s2pV_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2pV_info)+0
	.quad	1
	.quad	4294967313
_s2pV_info:
Lc2w3:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w4
Lc2w5:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2w7
Lc2w6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pU_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2w7:
	movq $16,904(%r13)
Lc2w4:
	jmp *-16(%r13)
	.long  _s2pV_info - _s2pV_info_dsp
.text
.align 3
_s2pR_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2pR_info)+16
	.quad	1
	.quad	4294967313
_s2pR_info:
Lc2wc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wd
Lc2we:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wd:
	jmp *-16(%r13)
	.long  _s2pR_info - _s2pR_info_dsp
.text
.align 3
_s2pW_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2pW_info)+0
	.quad	1
	.quad	21474836497
_s2pW_info:
Lc2wf:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wg
Lc2wh:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2wj
Lc2wi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2pV_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2pR_info(%rip),%rcx
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
Lc2wj:
	movq $48,904(%r13)
Lc2wg:
	jmp *-16(%r13)
	.long  _s2pW_info - _s2pW_info_dsp
.text
.align 3
_r2kH_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2kH_info)+0
	.quad	4294967301
	.quad	0
	.quad	55834574863
_r2kH_info:
Lc2wl:
Lc2wn:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wp
Lc2wo:
	leaq _s2pW_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_Prefix_con_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2wp:
	movq $40,904(%r13)
Lc2wm:
	leaq _r2kH_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2kH_info - _r2kH_info_dsp
.data
.align 3
.align 0
_r2pv_closure:
	.quad	_r2pv_info
	.quad	0
.text
.align 3
_s2q3_info_dsp:
.text
.align 3
	.quad	8589934607
	.quad	1
	.quad	10
_s2q3_info:
Lc2xa:
Lc2xc:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xe
Lc2xd:
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
Lc2xe:
	movq $48,904(%r13)
Lc2xb:
	jmp *-8(%r13)
	.long  _s2q3_info - _s2q3_info_dsp
.text
.align 3
_s2q4_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2q4_info)+0
	.quad	1
	.quad	4294967313
_s2q4_info:
Lc2xf:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xg
Lc2xh:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2xj
Lc2xi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2q3_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -6(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2xj:
	movq $16,904(%r13)
Lc2xg:
	jmp *-16(%r13)
	.long  _s2q4_info - _s2q4_info_dsp
.text
.align 3
_s2pZ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2pZ_info)+16
	.quad	1
	.quad	4294967313
_s2pZ_info:
Lc2xo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xp
Lc2xq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xp:
	jmp *-16(%r13)
	.long  _s2pZ_info - _s2pZ_info_dsp
.text
.align 3
_s2q5_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2q5_info)+0
	.quad	1
	.quad	21474836497
_s2q5_info:
Lc2xr:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xs
Lc2xt:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xv
Lc2xu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2q4_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2pZ_info(%rip),%rcx
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
Lc2xv:
	movq $48,904(%r13)
Lc2xs:
	jmp *-16(%r13)
	.long  _s2q5_info - _s2q5_info_dsp
.text
.align 3
_r2pv_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2pv_info)+0
	.quad	8589934607
	.quad	0
	.quad	90194313231
_r2pv_info:
Lc2xx:
Lc2xz:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xB
Lc2xA:
	leaq _s2q5_info(%rip),%rax
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
Lc2xB:
	movq $48,904(%r13)
Lc2xy:
	leaq _r2pv_closure(%rip),%rbx
	jmp *-8(%r13)
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
	.quad	_S2vq_srt-(_r2pw_info)+24
	.quad	0
	.quad	4294967318
_r2pw_info:
Lc2ya:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yb
Lc2yc:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2ye
Lc2yd:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2y8
Lc2y7:
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
Lc2y8:
	jmp *(%rbx)
Lc2ye:
	movq $24,904(%r13)
Lc2yb:
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
	.quad	_r2py_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2py_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2py_info)+32
	.quad	0
	.quad	4294967318
_r2py_info:
Lc2yy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yz
Lc2yA:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yC
Lc2yB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yw
Lc2yv:
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
	jmp _r2pv_info
Lc2yw:
	jmp *(%rbx)
Lc2yC:
	movq $24,904(%r13)
Lc2yz:
	jmp *-16(%r13)
	.long  _r2py_info - _r2py_info_dsp
.data
.align 3
.align 0
_r2pz_closure:
	.quad	_r2pz_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pz_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2pz_info)+32
	.quad	0
	.quad	4294967318
_r2pz_info:
Lc2yU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yV
Lc2yW:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2yY
Lc2yX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yS
Lc2yR:
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
	jmp _r2pv_info
Lc2yS:
	jmp *(%rbx)
Lc2yY:
	movq $24,904(%r13)
Lc2yV:
	jmp *-16(%r13)
	.long  _r2pz_info - _r2pz_info_dsp
.data
.align 3
.align 0
_r2pA_closure:
	.quad	_r2pA_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pA_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2pA_info)+32
	.quad	0
	.quad	4294967318
_r2pA_info:
Lc2zg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zh
Lc2zi:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zk
Lc2zj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ze
Lc2zd:
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
	jmp _r2pv_info
Lc2ze:
	jmp *(%rbx)
Lc2zk:
	movq $24,904(%r13)
Lc2zh:
	jmp *-16(%r13)
	.long  _r2pA_info - _r2pA_info_dsp
.data
.align 3
.align 0
_r2pB_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pA_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pC_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pz_closure
	.quad	_r2pB_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pD_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2py_closure
	.quad	_r2pC_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pE_closure:
	.quad	_r2pE_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pE_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2pE_info)+32
	.quad	0
	.quad	4294967318
_r2pE_info:
Lc2zI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zJ
Lc2zK:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zM
Lc2zL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zG
Lc2zF:
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
	jmp _r2pv_info
Lc2zG:
	jmp *(%rbx)
Lc2zM:
	movq $24,904(%r13)
Lc2zJ:
	jmp *-16(%r13)
	.long  _r2pE_info - _r2pE_info_dsp
.data
.align 3
.align 0
_r2pF_closure:
	.quad	_r2pF_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2pF_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2pF_info)+32
	.quad	0
	.quad	4294967318
_r2pF_info:
Lc2A4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2A5
Lc2A6:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2A8
Lc2A7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2A2
Lc2A1:
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
	jmp _r2pv_info
Lc2A2:
	jmp *(%rbx)
Lc2A8:
	movq $24,904(%r13)
Lc2A5:
	jmp *-16(%r13)
	.long  _r2pF_info - _r2pF_info_dsp
.data
.align 3
.align 0
_r2pG_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pF_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pH_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pE_closure
	.quad	_r2pG_closure+2
	.quad	0
.data
.align 3
.align 0
_r2pI_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pH_closure+2
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_r2pJ_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2pD_closure+2
	.quad	_r2pI_closure+2
	.quad	0
.data
.align 3
.align 0
.globl _F95VarDeclParser_optable_closure
_F95VarDeclParser_optable_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_r2px_closure+2
	.quad	_r2pJ_closure+2
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
_s2qk_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qk_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2qk_info:
Lc2AF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2AG
Lc2AH:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2AJ
Lc2AI:
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
Lc2AJ:
	movq $16,904(%r13)
Lc2AG:
	jmp *-8(%r13)
	.long  _s2qk_info - _s2qk_info_dsp
.text
.align 3
_F95VarDeclParser_varzuexpr_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_F95VarDeclParser_varzuexpr_info)+0
	.quad	0
	.quad	141733920790
.globl _F95VarDeclParser_varzuexpr_info
_F95VarDeclParser_varzuexpr_info:
Lc2AK:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2AL
Lc2AM:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2AO
Lc2AN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ay
Lc2Ax:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qk_info(%rip),%rax
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
Lc2Ay:
	jmp *(%rbx)
Lc2AO:
	movq $16,904(%r13)
Lc2AL:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_varzuexpr_info - _F95VarDeclParser_varzuexpr_info_dsp
.data
.align 3
.align 0
_s2qm_closure:
	.quad	_s2qm_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Bi_str:
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
_s2qm_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qm_info)+48
	.quad	0
	.quad	4294967318
_s2qm_info:
Lc2Bj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bk
Lc2Bl:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Bh
Lc2Bg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2Bi_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Bh:
	jmp *(%rbx)
Lc2Bk:
	jmp *-16(%r13)
	.long  _s2qm_info - _s2qm_info_dsp
.data
.align 3
.align 0
_s2ql_closure:
	.quad	_s2ql_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2ql_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2ql_info)+56
	.quad	0
	.quad	30064771094
_s2ql_info:
Lc2Bs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bt
Lc2Bu:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Br
Lc2Bq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95VarDeclParser_term_closure(%rip),%rsi
	leaq _F95VarDeclParser_optable_closure+2(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Br:
	jmp *(%rbx)
Lc2Bt:
	jmp *-16(%r13)
	.long  _s2ql_info - _s2ql_info_dsp
.data
.align 3
.align 0
_s2qs_closure:
	.quad	_s2qs_info
	.quad	0
.text
.align 3
_s2qr_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qr_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qr_info:
Lc2BF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BG
Lc2BH:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2BJ
Lc2BI:
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
Lc2BJ:
	movq $24,904(%r13)
Lc2BG:
	jmp *-8(%r13)
	.long  _s2qr_info - _s2qr_info_dsp
.text
.align 3
_s2qo_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qo_info)+80
	.quad	0
	.quad	12884901904
_s2qo_info:
Lc2BO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BP
Lc2BQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2BP:
	jmp *-16(%r13)
	.long  _s2qo_info - _s2qo_info_dsp
.text
.align 3
_s2qs_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qs_info)+0
	.quad	4294967301
	.quad	0
	.quad	30790620545039
_s2qs_info:
Lc2BR:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BS
Lc2BT:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2BV
Lc2BU:
	leaq _s2qr_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2qo_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2BV:
	movq $32,904(%r13)
Lc2BS:
	leaq _s2qs_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qs_info - _s2qs_info_dsp
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
_c2C2_str:
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
_s2qy_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qy_info)+48
	.quad	0
	.quad	4294967318
_s2qy_info:
Lc2C3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2C4
Lc2C5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2C1
Lc2C0:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2C2_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2C1:
	jmp *(%rbx)
Lc2C4:
	jmp *-16(%r13)
	.long  _s2qy_info - _s2qy_info_dsp
.data
.align 3
.align 0
_s2qx_closure:
	.quad	_s2qx_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qu_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qu_info)+104
	.quad	0
	.quad	12884901904
_s2qu_info:
Lc2Co:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cp
Lc2Cq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_arrayzuidxzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Cp:
	jmp *-16(%r13)
	.long  _s2qu_info - _s2qu_info_dsp
.text
.align 3
_s2qv_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qv_info)+104
	.quad	0
	.quad	64424509456
_s2qv_info:
Lc2Cr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cs
Lc2Ct:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Cv
Lc2Cu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2qu_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _F95VarDeclParser_varzuexpr_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Cv:
	movq $16,904(%r13)
Lc2Cs:
	jmp *-16(%r13)
	.long  _s2qv_info - _s2qv_info_dsp
.text
.align 3
_s2qw_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qw_info)+104
	.quad	0
	.quad	133143986192
_s2qw_info:
Lc2Cw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cx
Lc2Cy:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2CA
Lc2Cz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2qv_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_constzuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2CA:
	movq $16,904(%r13)
Lc2Cx:
	jmp *-16(%r13)
	.long  _s2qw_info - _s2qw_info_dsp
.text
.align 3
_s2qt_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qt_info)+80
	.quad	0
	.quad	12884901904
_s2qt_info:
Lc2CF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CG
Lc2CH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2CG:
	jmp *-16(%r13)
	.long  _s2qt_info - _s2qt_info_dsp
.text
.align 3
_s2qx_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qx_info)+80
	.quad	0
	.quad	1078036791318
_s2qx_info:
Lc2CI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CJ
Lc2CK:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2CM
Lc2CL:
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
	leaq _s2qw_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2qt_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Cb:
	jmp *(%rbx)
Lc2CM:
	movq $32,904(%r13)
Lc2CJ:
	jmp *-16(%r13)
	.long  _s2qx_info - _s2qx_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_exprzuparser_info)+144
	.quad	0
	.quad	30064771094
.globl _F95VarDeclParser_exprzuparser_info
_F95VarDeclParser_exprzuparser_info:
Lc2CT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CU
Lc2CV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2CS
Lc2CR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qm_closure(%rip),%rsi
	leaq _s2ql_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2CS:
	jmp *(%rbx)
Lc2CU:
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
	.quad	_S2vq_srt-(_F95VarDeclParser_arrayzuidxzuexpr_info)+0
	.quad	0
	.quad	17733919965206
.globl _F95VarDeclParser_arrayzuidxzuexpr_info
_F95VarDeclParser_arrayzuidxzuexpr_info:
Lc2D2:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2D3
Lc2D4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2D1
Lc2D0:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qs_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2D1:
	jmp *(%rbx)
Lc2D3:
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
	.quad	_S2vq_srt-(_F95VarDeclParser_term_info)+144
	.quad	0
	.quad	107374182422
.globl _F95VarDeclParser_term_info
_F95VarDeclParser_term_info:
Lc2Db:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Dc
Lc2Dd:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Da
Lc2D9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qy_closure(%rip),%rsi
	leaq _s2qx_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Da:
	jmp *(%rbx)
Lc2Dc:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_term_info - _F95VarDeclParser_term_info_dsp
.data
.align 3
.align 0
_s2qB_closure:
	.quad	_s2qB_info
	.quad	0
.text
.align 3
_s2qB_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qB_info)+0
	.quad	4294967301
	.quad	0
	.quad	36028801313931279
_s2qB_info:
Lc2Ex:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ey
Lc2Ez:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Ey:
	leaq _s2qB_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qB_info - _s2qB_info_dsp
.data
.align 3
.align 0
_s2qz_closure:
	.quad	_s2qz_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qz_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qz_info)+40
	.quad	0
	.quad	2251804108652566
_s2qz_info:
Lc2EM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EN
Lc2EO:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2EL
Lc2EK:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2EL:
	jmp *(%rbx)
Lc2EN:
	jmp *-16(%r13)
	.long  _s2qz_info - _s2qz_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_arglistzuparser_info)+0
	.quad	0
	.quad	180143989389787158
.globl _F95VarDeclParser_arglistzuparser_info
_F95VarDeclParser_arglistzuparser_info:
Lc2F1:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2F2
Lc2F3:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2F0
Lc2EZ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qz_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qB_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2F0:
	jmp *(%rbx)
Lc2F2:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_arglistzuparser_info - _F95VarDeclParser_arglistzuparser_info_dsp
.data
.align 3
.align 0
_s2qP_closure:
	.quad	_s2qP_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qG_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qG_info)+208
	.quad	0
	.quad	12884901904
_s2qG_info:
Lc2FO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FP
Lc2FQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2FP:
	jmp *-16(%r13)
	.long  _s2qG_info - _s2qG_info_dsp
.const
.align 3
.align 0
_c2FV_str:
	.byte	105
	.byte	110
	.byte	0
.text
.align 3
_s2qH_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qH_info)+48
	.quad	0
	.quad	4294967312
_s2qH_info:
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
	.long  _s2qH_info - _s2qH_info_dsp
.const
.align 3
.align 0
_c2G7_str:
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qJ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qJ_info)+48
	.quad	0
	.quad	4294967312
_s2qJ_info:
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
	.long  _s2qJ_info - _s2qJ_info_dsp
.const
.align 3
.align 0
_c2Gj_str:
	.byte	105
	.byte	110
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qL_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qL_info)+48
	.quad	0
	.quad	4294967312
_s2qL_info:
Lc2Gk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Gl
Lc2Gm:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Gj_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Gl:
	jmp *-16(%r13)
	.long  _s2qL_info - _s2qL_info_dsp
.const
.align 3
.align 0
_c2Gz_str:
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
	.byte	48
	.byte	48
	.byte	44
	.byte	57
	.byte	41
	.byte	45
	.byte	40
	.byte	49
	.byte	48
	.byte	51
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
_s2qN_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qN_info)+48
	.quad	1
	.quad	31525201686560785
_s2qN_info:
Lc2Gu:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H4
Lc2H5:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2H7
Lc2H6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qG_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2qH_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2FZ_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2FZ_info)+48
	.quad	2
	.quad	18014402804449312
_c2FZ_info:
Lc2FZ:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Gs
Lc2Gt:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2H3
Lc2H2:
	leaq _s2qJ_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Gb_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2Gb_info)+48
	.quad	2
	.quad	18014402804449312
_c2Gb_info:
Lc2Gb:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2GI
Lc2GJ:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2H0
Lc2GZ:
	leaq _s2qL_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Gv_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Gs:
	leaq _F95VarDecl_In_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vq_srt-(_c2Gv_info)+224
	.quad	0
	.quad	4294967328
_c2Gv_info:
Lc2Gv:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2GS
Lc2GT:
	leaq _c2Gz_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2GI:
	leaq _F95VarDecl_Out_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2GS:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2H0:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2H3:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2H7:
	movq $32,904(%r13)
Lc2H4:
	jmp *-16(%r13)
	.long  _s2qN_info - _s2qN_info_dsp
.text
.align 3
_s2qO_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qO_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	2017612912234856459
_s2qO_info:
Lc2H8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H9
Lc2Ha:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Hc
Lc2Hb:
	leaq _s2qN_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Hc:
	movq $24,904(%r13)
Lc2H9:
	jmp *-8(%r13)
	.long  _s2qO_info - _s2qO_info_dsp
.text
.align 3
_s2qE_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qE_info)+40
	.quad	0
	.quad	141733920784
_s2qE_info:
Lc2Hh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hi
Lc2Hj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Hi:
	jmp *-16(%r13)
	.long  _s2qE_info - _s2qE_info_dsp
.text
.align 3
_s2qP_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qP_info)+0
	.quad	0
	.quad	2017617447720321046
_s2qP_info:
Lc2Hk:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Hl
Lc2Hm:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ho
Lc2Hn:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2FA
Lc2Fz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qO_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2qE_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2FA:
	jmp *(%rbx)
Lc2Ho:
	movq $32,904(%r13)
Lc2Hl:
	jmp *-16(%r13)
	.long  _s2qP_info - _s2qP_info_dsp
.data
.align 3
.align 0
_s2qD_closure:
	.quad	_s2qD_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Is_str:
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	110
	.byte	116
	.byte	0
.text
.align 3
_s2qC_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qC_info)+48
	.quad	0
	.quad	4294967312
_s2qC_info:
Lc2It:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Iu
Lc2Iv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Is_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Iu:
	jmp *-16(%r13)
	.long  _s2qC_info - _s2qC_info_dsp
.text
.align 3
_s2qD_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qD_info)+48
	.quad	0
	.quad	36028801313931286
_s2qD_info:
Lc2Iw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ix
Lc2Iy:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2IA
Lc2Iz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2In
Lc2Im:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qC_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2In:
	jmp *(%rbx)
Lc2IA:
	movq $16,904(%r13)
Lc2Ix:
	jmp *-16(%r13)
	.long  _s2qD_info - _s2qD_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_intentzuparser_info)+0
	.quad	0
	.quad	-4611686014132420586
.globl _F95VarDeclParser_intentzuparser_info
_F95VarDeclParser_intentzuparser_info:
Lc2IT:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2IU
Lc2IV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2IS
Lc2IR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qD_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qP_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2IS:
	jmp *(%rbx)
Lc2IU:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_intentzuparser_info - _F95VarDeclParser_intentzuparser_info_dsp
.data
.align 3
.align 0
_s2qY_closure:
	.quad	_s2qY_info
	.quad	0
.text
.align 3
_s2qW_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qW_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qW_info:
Lc2Jj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jk
Lc2Jl:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Jn
Lc2Jm:
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
Lc2Jn:
	movq $24,904(%r13)
Lc2Jk:
	jmp *-8(%r13)
	.long  _s2qW_info - _s2qW_info_dsp
.text
.align 3
_s2qX_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qX_info)+0
	.quad	1
	.quad	8800387989521
_s2qX_info:
Lc2Jo:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jp
Lc2Jq:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Js
Lc2Jr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qW_info(%rip),%rbx
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
Lc2Js:
	movq $16,904(%r13)
Lc2Jp:
	jmp *-16(%r13)
	.long  _s2qX_info - _s2qX_info_dsp
.text
.align 3
_s2qT_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qT_info)+232
	.quad	0
	.quad	4294967312
_s2qT_info:
Lc2Jy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jz
Lc2JA:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2JC
Lc2JB:
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
Lc2JC:
	movq $24,904(%r13)
Lc2Jz:
	jmp *-16(%r13)
	.long  _s2qT_info - _s2qT_info_dsp
.const_data
.align 3
.align 0
_u2JI_srtd:
	.quad	_S2vq_srt
	.quad	33
	.quad	4831840257
.text
.align 3
_s2qY_info_dsp:
.text
.align 3
	.quad	_u2JI_srtd-(_s2qY_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2qY_info:
Lc2JD:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2JE
Lc2JF:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2JH
Lc2JG:
	leaq _s2qX_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2qT_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2JH:
	movq $40,904(%r13)
Lc2JE:
	leaq _s2qY_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2qY_info - _s2qY_info_dsp
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
_u2Kl_srtd:
	.quad	_S2vq_srt
	.quad	33
	.quad	4294969345
.text
.align 3
_F95VarDeclParser_rangezuexpr_info_dsp:
.text
.align 3
	.quad	_u2Kl_srtd-(_F95VarDeclParser_rangezuexpr_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_rangezuexpr_info
_F95VarDeclParser_rangezuexpr_info:
Lc2Ki:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Kj
Lc2Kk:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Kh
Lc2Kg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qY_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Kh:
	jmp *(%rbx)
Lc2Kj:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuexpr_info - _F95VarDeclParser_rangezuexpr_info_dsp
.data
.align 3
.align 0
_s2r3_closure:
	.quad	_s2r3_info
	.quad	0
.text
.align 3
_s2r3_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2r3_info)+264
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2r3_info:
Lc2KD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2KE
Lc2KF:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2KH
Lc2KG:
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
Lc2KH:
	movq $56,904(%r13)
Lc2KE:
	leaq _s2r3_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r3_info - _s2r3_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_singlezuexprzurange_info)+88
	.quad	0
	.quad	54043199823413270
.globl _F95VarDeclParser_singlezuexprzurange_info
_F95VarDeclParser_singlezuexprzurange_info:
Lc2KX:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2KY
Lc2KZ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2KW
Lc2KV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r3_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2KW:
	jmp *(%rbx)
Lc2KY:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuexprzurange_info - _F95VarDeclParser_singlezuexprzurange_info_dsp
.data
.align 3
.align 0
_s2r9_closure:
	.quad	_s2r9_info
	.quad	0
.text
.align 3
_s2r9_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2r9_info)+272
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2r9_info:
Lc2Lh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Li
Lc2Lj:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ll
Lc2Lk:
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
Lc2Ll:
	movq $72,904(%r13)
Lc2Li:
	leaq _s2r9_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r9_info - _s2r9_info_dsp
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
_u2LF_srtd:
	.quad	_S2vq_srt+8
	.quad	35
	.quad	25769803777
.text
.align 3
_F95VarDeclParser_singlezuconstzurange_info_dsp:
.text
.align 3
	.quad	_u2LF_srtd-(_F95VarDeclParser_singlezuconstzurange_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_singlezuconstzurange_info
_F95VarDeclParser_singlezuconstzurange_info:
Lc2LC:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2LD
Lc2LE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2LB
Lc2LA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r9_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2LB:
	jmp *(%rbx)
Lc2LD:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuconstzurange_info - _F95VarDeclParser_singlezuconstzurange_info_dsp
.data
.align 3
.align 0
_s2rf_closure:
	.quad	_s2rf_info
	.quad	0
.text
.align 3
_s2rf_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rf_info)+272
	.quad	4294967301
	.quad	0
	.quad	21474836495
_s2rf_info:
Lc2LY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2LZ
Lc2M0:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2M2
Lc2M1:
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
Lc2M2:
	movq $72,904(%r13)
Lc2LZ:
	leaq _s2rf_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rf_info - _s2rf_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_singlezuvarzurange_info)+40
	.quad	0
	.quad	-6917529023346114538
.globl _F95VarDeclParser_singlezuvarzurange_info
_F95VarDeclParser_singlezuvarzurange_info:
Lc2Mj:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Mk
Lc2Ml:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Mi
Lc2Mh:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rf_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Mi:
	jmp *(%rbx)
Lc2Mk:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuvarzurange_info - _F95VarDeclParser_singlezuvarzurange_info_dsp
.data
.align 3
.align 0
_s2rn_closure:
	.quad	_s2rn_info
	.quad	0
.text
.align 3
_s2rn_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rn_info)+272
	.quad	4294967301
	.quad	0
	.quad	38654705679
_s2rn_info:
Lc2Mz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2MA
Lc2MB:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2MA:
	leaq _s2rn_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rn_info - _s2rn_info_dsp
.data
.align 3
.align 0
_s2rl_closure:
	.quad	_s2rl_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2MS_str:
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
_s2rk_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rk_info)+48
	.quad	0
	.quad	4294967312
_s2rk_info:
Lc2MT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2MU
Lc2MV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2MS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2MU:
	jmp *-16(%r13)
	.long  _s2rk_info - _s2rk_info_dsp
.text
.align 3
_s2rh_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rh_info)+120
	.quad	0
	.quad	108086395351859216
_s2rh_info:
Lc2N8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2N9
Lc2Na:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_singlezuconstzurange_closure(%rip),%rsi
	leaq _F95VarDeclParser_singlezuvarzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2N9:
	jmp *-16(%r13)
	.long  _s2rh_info - _s2rh_info_dsp
.text
.align 3
_s2ri_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2ri_info)+120
	.quad	0
	.quad	252201583427715088
_s2ri_info:
Lc2Nb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nc
Lc2Nd:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nf
Lc2Ne:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rh_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_singlezuexprzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Nf:
	movq $16,904(%r13)
Lc2Nc:
	jmp *-16(%r13)
	.long  _s2ri_info - _s2ri_info_dsp
.text
.align 3
_s2rg_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rg_info)+104
	.quad	0
	.quad	1152921508901814288
_s2rg_info:
Lc2Nk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nl
Lc2Nm:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Nl:
	jmp *-16(%r13)
	.long  _s2rg_info - _s2rg_info_dsp
.text
.align 3
_s2rj_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rj_info)+104
	.quad	0
	.quad	2161727842612674576
_s2rj_info:
Lc2Nn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2No
Lc2Np:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nr
Lc2Nq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2ri_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rg_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Nr:
	movq $32,904(%r13)
Lc2No:
	jmp *-16(%r13)
	.long  _s2rj_info - _s2rj_info_dsp
.const_data
.align 3
.align 0
_u2Nx_srtd:
	.quad	_S2vq_srt+48
	.quad	36
	.quad	64424514177
.text
.align 3
_s2rl_info_dsp:
.text
.align 3
	.quad	_u2Nx_srtd-(_s2rl_info)+0
	.quad	0
	.quad	-4294967274
_s2rl_info:
Lc2Ns:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nt
Lc2Nu:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Nw
Lc2Nv:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2MN
Lc2MM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rk_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rj_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2MN:
	jmp *(%rbx)
Lc2Nw:
	movq $32,904(%r13)
Lc2Nt:
	jmp *-16(%r13)
	.long  _s2rl_info - _s2rl_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_rangezuparser_info)+272
	.quad	0
	.quad	1138166333462
.globl _F95VarDeclParser_rangezuparser_info
_F95VarDeclParser_rangezuparser_info:
Lc2Ob:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oc
Lc2Od:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Oa
Lc2O9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rl_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rn_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Oa:
	jmp *(%rbx)
Lc2Oc:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuparser_info - _F95VarDeclParser_rangezuparser_info_dsp
.data
.align 3
.align 0
_s2ru_closure:
	.quad	_s2ru_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rt_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rt_info)+272
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2rt_info:
Lc2Oy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oz
Lc2OA:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Oz:
	jmp *-8(%r13)
	.long  _s2rt_info - _s2rt_info_dsp
.text
.align 3
_s2rq_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rq_info)+192
	.quad	0
	.quad	2251804108652560
_s2rq_info:
Lc2OJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OK
Lc2OL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuparser_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2OK:
	jmp *-16(%r13)
	.long  _s2rq_info - _s2rq_info_dsp
.const_data
.align 3
.align 0
_u2OW_srtd:
	.quad	_S2vq_srt+80
	.quad	34
	.quad	8589950977
.text
.align 3
_s2rr_info_dsp:
.text
.align 3
	.quad	_u2OW_srtd-(_s2rr_info)+0
	.quad	0
	.quad	-4294967280
_s2rr_info:
Lc2OM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ON
Lc2OO:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2OQ
Lc2OP:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rq_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2OQ:
	movq $16,904(%r13)
Lc2ON:
	jmp *-16(%r13)
	.long  _s2rr_info - _s2rr_info_dsp
.const_data
.align 3
.align 0
_u2OX_srtd:
	.quad	_S2vq_srt+80
	.quad	34
	.quad	8606728193
.text
.align 3
_s2ru_info_dsp:
.text
.align 3
	.quad	_u2OX_srtd-(_s2ru_info)+0
	.quad	0
	.quad	-4294967274
_s2ru_info:
Lc2OR:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OS
Lc2OT:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2OV
Lc2OU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Os
Lc2Or:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rt_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2rr_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Os:
	jmp *(%rbx)
Lc2OV:
	movq $32,904(%r13)
Lc2OS:
	jmp *-16(%r13)
	.long  _s2ru_info - _s2ru_info_dsp
.data
.align 3
.align 0
_s2rp_closure:
	.quad	_s2rp_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Pw_str:
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
_s2ro_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2ro_info)+352
	.quad	0
	.quad	4294967312
_s2ro_info:
Lc2Px:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Py
Lc2Pz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Pw_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Py:
	jmp *-16(%r13)
	.long  _s2ro_info - _s2ro_info_dsp
.text
.align 3
_s2rp_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rp_info)+232
	.quad	0
	.quad	140741783322646
_s2rp_info:
Lc2PA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PB
Lc2PC:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2PE
Lc2PD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Pr
Lc2Pq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2ro_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Pr:
	jmp *(%rbx)
Lc2PE:
	movq $16,904(%r13)
Lc2PB:
	jmp *-16(%r13)
	.long  _s2rp_info - _s2rp_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_dimzuparser_info)+272
	.quad	0
	.quad	26392574033942
.globl _F95VarDeclParser_dimzuparser_info
_F95VarDeclParser_dimzuparser_info:
Lc2PX:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PY
Lc2PZ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2PW
Lc2PV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rp_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2ru_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2PW:
	jmp *(%rbx)
Lc2PY:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_dimzuparser_info - _F95VarDeclParser_dimzuparser_info_dsp
.data
.align 3
.align 0
_s2rV_closure:
	.quad	_s2rV_info
	.quad	0
.text
.align 3
_s2rP_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rP_info)+376
	.quad	1
	.quad	4294967313
_s2rP_info:
Lc2QO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QP
Lc2QQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2QP:
	jmp *-16(%r13)
	.long  _s2rP_info - _s2rP_info_dsp
.text
.align 3
_s2rS_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rS_info)+376
	.quad	1
	.quad	30064771089
_s2rS_info:
Lc2R0:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ra
Lc2Rb:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Rd
Lc2Rc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rP_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c2QR_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c2QR_info)+384
	.quad	1
	.quad	4294967328
_c2QR_info:
Lc2QR:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2QY
Lc2QZ:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2QY:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2R7
Lc2R6:
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $4,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2R7:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Rd:
	movq $24,904(%r13)
Lc2Ra:
	jmp *-16(%r13)
	.long  _s2rS_info - _s2rS_info_dsp
.text
.align 3
_s2rH_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rH_info)+208
	.quad	0
	.quad	12884901904
_s2rH_info:
Lc2Rm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Rn
Lc2Ro:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Rn:
	jmp *-16(%r13)
	.long  _s2rH_info - _s2rH_info_dsp
.const
.align 3
.align 0
_c2Rt_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	108
	.byte	0
.text
.align 3
_s2rI_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rI_info)+352
	.quad	0
	.quad	4294967312
_s2rI_info:
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
	.long  _s2rI_info - _s2rI_info_dsp
.const
.align 3
.align 0
_c2RF_str:
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
_s2rK_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rK_info)+352
	.quad	0
	.quad	4294967312
_s2rK_info:
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
	.long  _s2rK_info - _s2rK_info_dsp
.const
.align 3
.align 0
_c2RR_str:
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
_s2rM_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rM_info)+352
	.quad	0
	.quad	4294967312
_s2rM_info:
Lc2RS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2RT
Lc2RU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2RR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2RT:
	jmp *-16(%r13)
	.long  _s2rM_info - _s2rM_info_dsp
.text
.align 3
_s2rO_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rO_info)+208
	.quad	1
	.quad	217298694905528337
_s2rO_info:
Lc2S2:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sr
Lc2Ss:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Su
Lc2St:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rH_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2rI_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2Rx_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2Rx_info)+352
	.quad	2
	.quad	828928688160
_c2Rx_info:
Lc2Rx:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2S0
Lc2S1:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Sq
Lc2Sp:
	leaq _s2rK_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2RJ_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2RJ_info)+352
	.quad	1
	.quad	828928688160
_c2RJ_info:
Lc2RJ:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2Sc
Lc2Sd:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Sn
Lc2Sm:
	leaq _s2rM_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2S3_info(%rip),%rcx
	movq %rcx,8(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $8,%rbp
	jmp _stg_ap_pp_fast
Lc2S0:
	leaq _F95VarDecl_F95Real_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vq_srt-(_c2S3_info)+408
	.quad	0
	.quad	4294967328
_c2S3_info:
Lc2S3:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2Sc:
	leaq _F95VarDecl_F95Integer_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2Sn:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Sq:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Su:
	movq $32,904(%r13)
Lc2Sr:
	jmp *-16(%r13)
	.long  _s2rO_info - _s2rO_info_dsp
.text
.align 3
_s2rU_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rU_info)+208
	.quad	4294967301
	.quad	1
	.quad	280350189200343050
_s2rU_info:
Lc2Sw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sx
Lc2Sy:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2SA
Lc2Sz:
	movq 7(%rbx),%rax
	leaq _s2rS_info(%rip),%rbx
	movq %rbx,-64(%r12)
	movq %r14,-48(%r12)
	leaq -64(%r12),%rbx
	leaq _s2rO_info(%rip),%rcx
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
Lc2SA:
	movq $72,904(%r13)
Lc2Sx:
	jmp *-8(%r13)
	.long  _s2rU_info - _s2rU_info_dsp
.text
.align 3
_s2rA_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rA_info)+232
	.quad	0
	.quad	4294967312
_s2rA_info:
Lc2T0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2T1
Lc2T2:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2T4
Lc2T3:
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
Lc2T4:
	movq $24,904(%r13)
Lc2T1:
	jmp *-16(%r13)
	.long  _s2rA_info - _s2rA_info_dsp
.const
.align 3
.align 0
_c2Td_str:
	.byte	107
	.byte	105
	.byte	110
	.byte	100
	.byte	0
.text
.align 3
_s2rw_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rw_info)+352
	.quad	0
	.quad	4294967312
_s2rw_info:
Lc2Te:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tf
Lc2Tg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Td_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Tf:
	jmp *-16(%r13)
	.long  _s2rw_info - _s2rw_info_dsp
.text
.align 3
_s2rx_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rx_info)+232
	.quad	0
	.quad	140741783322640
_s2rx_info:
Lc2Th:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ti
Lc2Tj:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tl
Lc2Tk:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rw_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Tl:
	movq $16,904(%r13)
Lc2Ti:
	jmp *-16(%r13)
	.long  _s2rx_info - _s2rx_info_dsp
.text
.align 3
_s2rB_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rB_info)+232
	.quad	0
	.quad	140879222276112
_s2rB_info:
Lc2Tm:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tn
Lc2To:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tq
Lc2Tp:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rA_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rx_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Tq:
	movq $32,904(%r13)
Lc2Tn:
	jmp *-16(%r13)
	.long  _s2rB_info - _s2rB_info_dsp
.const_data
.align 3
.align 0
_u2TQ_srtd:
	.quad	_S2vq_srt+8
	.quad	44
	.quad	8804951392257
.text
.align 3
_s2rC_info_dsp:
.text
.align 3
	.quad	_u2TQ_srtd-(_s2rC_info)+0
	.quad	0
	.quad	-4294967280
_s2rC_info:
Lc2Tr:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ts
Lc2Tt:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tv
Lc2Tu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rB_info(%rip),%rax
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
Lc2Tv:
	movq $16,904(%r13)
Lc2Ts:
	jmp *-16(%r13)
	.long  _s2rC_info - _s2rC_info_dsp
.const_data
.align 3
.align 0
_u2TR_srtd:
	.quad	_S2vq_srt+8
	.quad	44
	.quad	8804951408641
.text
.align 3
_s2rD_info_dsp:
.text
.align 3
	.quad	_u2TR_srtd-(_s2rD_info)+0
	.quad	0
	.quad	-4294967280
_s2rD_info:
Lc2Tw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Tx
Lc2Ty:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2TA
Lc2Tz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rC_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95ParserCommon_natural_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2TA:
	movq $16,904(%r13)
Lc2Tx:
	jmp *-16(%r13)
	.long  _s2rD_info - _s2rD_info_dsp
.const_data
.align 3
.align 0
_u2TS_srtd:
	.quad	_S2vq_srt+8
	.quad	44
	.quad	8804951409153
.text
.align 3
_s2rE_info_dsp:
.text
.align 3
	.quad	_u2TS_srtd-(_s2rE_info)+0
	.quad	0
	.quad	-4294967280
_s2rE_info:
Lc2TB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TC
Lc2TD:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2TF
Lc2TE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2TF:
	movq $16,904(%r13)
Lc2TC:
	jmp *-16(%r13)
	.long  _s2rE_info - _s2rE_info_dsp
.const_data
.align 3
.align 0
_u2TT_srtd:
	.quad	_S2vq_srt+8
	.quad	52
	.quad	2260604765094401
.text
.align 3
_s2rF_info_dsp:
.text
.align 3
	.quad	_u2TT_srtd-(_s2rF_info)+0
	.quad	0
	.quad	-4294967280
_s2rF_info:
Lc2TG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TH
Lc2TI:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2TK
Lc2TJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rE_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2TK:
	movq $16,904(%r13)
Lc2TH:
	jmp *-16(%r13)
	.long  _s2rF_info - _s2rF_info_dsp
.const_data
.align 3
.align 0
_u2TU_srtd:
	.quad	_S2vq_srt+8
	.quad	53
	.quad	8945635562635777
.text
.align 3
_s2rV_info_dsp:
.text
.align 3
	.quad	_u2TU_srtd-(_s2rV_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2rV_info:
Lc2TL:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TM
Lc2TN:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2TP
Lc2TO:
	leaq _s2rU_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2rF_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2TP:
	movq $32,904(%r13)
Lc2TM:
	leaq _s2rV_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rV_info - _s2rV_info_dsp
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
_u2VW_srtd:
	.quad	_S2vq_srt+40
	.quad	49
	.quad	281475513581569
.text
.align 3
_F95VarDeclParser_typezuparser_info_dsp:
.text
.align 3
	.quad	_u2VW_srtd-(_F95VarDeclParser_typezuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_typezuparser_info
_F95VarDeclParser_typezuparser_info:
Lc2VT:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2VU
Lc2VV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2VS
Lc2VR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rV_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2VS:
	jmp *(%rbx)
Lc2VU:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_typezuparser_info - _F95VarDeclParser_typezuparser_info_dsp
.data
.align 3
.align 0
_s2se_closure:
	.quad	_s2se_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2s2_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s2_info)+208
	.quad	0
	.quad	12884901904
_s2s2_info:
Lc2WX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2WY
Lc2WZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2WY:
	jmp *-16(%r13)
	.long  _s2s2_info - _s2s2_info_dsp
.const
.align 3
.align 0
_c2X4_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	100
	.byte	0
.text
.align 3
_s2s3_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s3_info)+352
	.quad	0
	.quad	4294967312
_s2s3_info:
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
	.long  _s2s3_info - _s2s3_info_dsp
.const
.align 3
.align 0
_c2Xg_str:
	.byte	119
	.byte	114
	.byte	105
	.byte	116
	.byte	101
	.byte	0
.text
.align 3
_s2s5_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s5_info)+352
	.quad	0
	.quad	4294967312
_s2s5_info:
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
	.long  _s2s5_info - _s2s5_info_dsp
.const
.align 3
.align 0
_c2Xs_str:
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
_s2s7_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s7_info)+352
	.quad	0
	.quad	4294967312
_s2s7_info:
Lc2Xt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Xu
Lc2Xv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Xs_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Xu:
	jmp *-16(%r13)
	.long  _s2s7_info - _s2s7_info_dsp
.const
.align 3
.align 0
_c2XI_str:
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
	.byte	50
	.byte	48
	.byte	44
	.byte	49
	.byte	51
	.byte	41
	.byte	45
	.byte	40
	.byte	49
	.byte	50
	.byte	51
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
_s2s9_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s9_info)+208
	.quad	1
	.quad	1125929971613713
_s2s9_info:
Lc2XD:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yd
Lc2Ye:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Yg
Lc2Yf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2s2_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2s3_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2X8_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2X8_info)+224
	.quad	2
	.quad	281479271677984
_c2X8_info:
Lc2X8:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2XB
Lc2XC:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Yc
Lc2Yb:
	leaq _s2s5_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Xk_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2Xk_info)+224
	.quad	2
	.quad	281479271677984
_c2Xk_info:
Lc2Xk:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2XR
Lc2XS:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Y9
Lc2Y8:
	leaq _s2s7_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2XE_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2XB:
	leaq _F95VarDecl_Read_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vq_srt-(_c2XE_info)+224
	.quad	0
	.quad	4294967328
_c2XE_info:
Lc2XE:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2Y1
Lc2Y2:
	leaq _c2XI_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2XR:
	leaq _F95VarDecl_Write_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2Y1:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2Y9:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Yc:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Yg:
	movq $32,904(%r13)
Lc2Yd:
	jmp *-16(%r13)
	.long  _s2s9_info - _s2s9_info_dsp
.text
.align 3
_s2sa_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sa_info)+208
	.quad	4294967301
	.quad	4294967296
	.quad	1127029483241483
_s2sa_info:
Lc2Yh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yi
Lc2Yj:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Yl
Lc2Yk:
	leaq _s2s9_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Yl:
	movq $24,904(%r13)
Lc2Yi:
	jmp *-8(%r13)
	.long  _s2sa_info - _s2sa_info_dsp
.const_data
.align 3
.align 0
_u2YX_srtd:
	.quad	_S2vq_srt+40
	.quad	40
	.quad	550307364865
.text
.align 3
_s2sb_info_dsp:
.text
.align 3
	.quad	_u2YX_srtd-(_s2sb_info)+0
	.quad	0
	.quad	-4294967280
_s2sb_info:
Lc2Ym:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Yn
Lc2Yo:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Yq
Lc2Yp:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sa_info(%rip),%rax
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
Lc2Yq:
	movq $16,904(%r13)
Lc2Yn:
	jmp *-16(%r13)
	.long  _s2sb_info - _s2sb_info_dsp
.const_data
.align 3
.align 0
_u2YY_srtd:
	.quad	_S2vq_srt+40
	.quad	40
	.quad	550307364865
.text
.align 3
_s2sc_info_dsp:
.text
.align 3
	.quad	_u2YY_srtd-(_s2sc_info)+0
	.quad	0
	.quad	-4294967280
_s2sc_info:
Lc2Yr:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ys
Lc2Yt:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Yv
Lc2Yu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sb_info(%rip),%rax
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
Lc2Yv:
	movq $16,904(%r13)
Lc2Ys:
	jmp *-16(%r13)
	.long  _s2sc_info - _s2sc_info_dsp
.const
.align 3
.align 0
_c2YE_str:
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	0
.text
.align 3
_s2rZ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rZ_info)+352
	.quad	0
	.quad	4294967312
_s2rZ_info:
Lc2YF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YG
Lc2YH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2YE_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2YG:
	jmp *-16(%r13)
	.long  _s2rZ_info - _s2rZ_info_dsp
.text
.align 3
_s2s0_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s0_info)+232
	.quad	0
	.quad	140741783322640
_s2s0_info:
Lc2YI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YJ
Lc2YK:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YM
Lc2YL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rZ_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2YM:
	movq $16,904(%r13)
Lc2YJ:
	jmp *-16(%r13)
	.long  _s2s0_info - _s2s0_info_dsp
.const_data
.align 3
.align 0
_u2YZ_srtd:
	.quad	_S2vq_srt+40
	.quad	40
	.quad	550324142081
.text
.align 3
_s2sd_info_dsp:
.text
.align 3
	.quad	_u2YZ_srtd-(_s2sd_info)+0
	.quad	0
	.quad	-4294967280
_s2sd_info:
Lc2YN:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YO
Lc2YP:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2YR
Lc2YQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sc_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2s0_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2YR:
	movq $32,904(%r13)
Lc2YO:
	jmp *-16(%r13)
	.long  _s2sd_info - _s2sd_info_dsp
.const_data
.align 3
.align 0
_u2Z0_srtd:
	.quad	_S2vq_srt+40
	.quad	50
	.quad	563500277563393
.text
.align 3
_s2se_info_dsp:
.text
.align 3
	.quad	_u2Z0_srtd-(_s2se_info)+0
	.quad	0
	.quad	-4294967274
_s2se_info:
Lc2YS:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YT
Lc2YU:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YW
Lc2YV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Wx
Lc2Ww:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2sd_info(%rip),%rax
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
Lc2Wx:
	jmp *(%rbx)
Lc2YW:
	movq $16,904(%r13)
Lc2YT:
	jmp *-16(%r13)
	.long  _s2se_info - _s2se_info_dsp
.data
.align 3
.align 0
_s2rY_closure:
	.quad	_s2rY_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rW_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rW_info)+440
	.quad	0
	.quad	12884901904
_s2rW_info:
Lc30z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30A
Lc30B:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc30A:
	jmp *-16(%r13)
	.long  _s2rW_info - _s2rW_info_dsp
.text
.align 3
_s2rY_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rY_info)+440
	.quad	0
	.quad	30064771094
_s2rY_info:
Lc30C:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc30D
Lc30E:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc30G
Lc30F:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc30u
Lc30t:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rW_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rbx
	leaq 529(%rbx),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc30u:
	jmp *(%rbx)
Lc30G:
	movq $16,904(%r13)
Lc30D:
	jmp *-16(%r13)
	.long  _s2rY_info - _s2rY_info_dsp
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
	.quad	_S2vq_srt-(_F95VarDeclParser_oclzuargmodezuparser_info)+272
	.quad	0
	.quad	216172786408751126
.globl _F95VarDeclParser_oclzuargmodezuparser_info
_F95VarDeclParser_oclzuargmodezuparser_info:
Lc30Z:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc310
Lc311:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc30Y
Lc30X:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rY_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2se_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc30Y:
	jmp *(%rbx)
Lc310:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_oclzuargmodezuparser_info - _F95VarDeclParser_oclzuargmodezuparser_info_dsp
.data
.align 3
.align 0
_s2sL_closure:
	.quad	_s2sL_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2so_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2so_info)+376
	.quad	1
	.quad	4294967313
_s2so_info:
Lc31V:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31W
Lc31X:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc31W:
	jmp *-16(%r13)
	.long  _s2so_info - _s2so_info_dsp
.text
.align 3
_s2sn_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sn_info)+376
	.quad	1
	.quad	30064771089
_s2sn_info:
Lc327:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32e
Lc32f:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc32h
Lc32g:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2so_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c31Y_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c31Y_info)+384
	.quad	1
	.quad	4294967328
_c31Y_info:
Lc31Y:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc325
Lc326:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc325:
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc32h:
	movq $24,904(%r13)
Lc32e:
	jmp *-16(%r13)
	.long  _s2sn_info - _s2sn_info_dsp
.text
.align 3
_s2ss_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2ss_info)+376
	.quad	1
	.quad	4294967313
_s2ss_info:
Lc32q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32r
Lc32s:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc32r:
	jmp *-16(%r13)
	.long  _s2ss_info - _s2ss_info_dsp
.text
.align 3
_s2sr_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sr_info)+376
	.quad	1
	.quad	30064771089
_s2sr_info:
Lc32C:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32J
Lc32K:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc32M
Lc32L:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ss_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c32t_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c32t_info)+384
	.quad	1
	.quad	4294967328
_c32t_info:
Lc32t:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc32A
Lc32B:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc32A:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc32M:
	movq $24,904(%r13)
Lc32J:
	jmp *-16(%r13)
	.long  _s2sr_info - _s2sr_info_dsp
.text
.align 3
_s2sA_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sA_info)+376
	.quad	1
	.quad	4294967313
_s2sA_info:
Lc33j:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33k
Lc33l:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33k:
	jmp *-16(%r13)
	.long  _s2sA_info - _s2sA_info_dsp
.text
.align 3
_s2sD_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sD_info)+376
	.quad	1
	.quad	30064771089
_s2sD_info:
Lc33v:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33C
Lc33D:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc33F
Lc33E:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sA_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c33m_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c33m_info)+384
	.quad	1
	.quad	4294967328
_c33m_info:
Lc33m:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc33t
Lc33u:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc33t:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc33F:
	movq $24,904(%r13)
Lc33C:
	jmp *-16(%r13)
	.long  _s2sD_info - _s2sD_info_dsp
.text
.align 3
_s2sF_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sF_info)+272
	.quad	4294967301
	.quad	4
	.quad	246294899589129
_s2sF_info:
Lc33H:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33I
Lc33J:
	addq $96,%r12
	cmpq 856(%r13),%r12
	ja Lc33L
Lc33K:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rdx
	movq 31(%rbx),%rbx
	leaq _s2sD_info(%rip),%rsi
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
Lc33L:
	movq $96,904(%r13)
Lc33I:
	jmp *-8(%r13)
	.long  _s2sF_info - _s2sF_info_dsp
.text
.align 3
_s2sy_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sy_info)+416
	.quad	0
	.quad	1103806595088
_s2sy_info:
Lc33Q:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33R
Lc33S:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_oclzuargmodezuparser_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33R:
	jmp *-16(%r13)
	.long  _s2sy_info - _s2sy_info_dsp
.text
.align 3
_s2sG_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sG_info)+272
	.quad	4294967301
	.quad	3
	.quad	289602570958143497
_s2sG_info:
Lc33T:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33U
Lc33V:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc33X
Lc33W:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _s2sF_info(%rip),%rdx
	movq %rdx,-48(%r12)
	movq %rax,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	leaq -47(%r12),%rax
	leaq _s2sy_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc33X:
	movq $56,904(%r13)
Lc33U:
	jmp *-8(%r13)
	.long  _s2sG_info - _s2sG_info_dsp
.text
.align 3
_s2sH_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sH_info)+272
	.quad	3
	.quad	866063323261566992
_s2sH_info:
Lc33Y:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33Z
Lc340:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc342
Lc341:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rbx
	leaq _s2sG_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-16(%r12)
	movq %rcx,-8(%r12)
	movq %rbx,(%r12)
	leaq -23(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	leaq _F95VarDeclParser_arglistzuparser_closure(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc342:
	movq $32,904(%r13)
Lc33Z:
	jmp *-16(%r13)
	.long  _s2sH_info - _s2sH_info_dsp
.const
.align 3
.align 0
_c34b_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2sv_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sv_info)+352
	.quad	0
	.quad	4294967312
_s2sv_info:
Lc34c:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34d
Lc34e:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c34b_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc34d:
	jmp *-16(%r13)
	.long  _s2sv_info - _s2sv_info_dsp
.text
.align 3
_s2sw_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sw_info)+232
	.quad	0
	.quad	140741783322640
_s2sw_info:
Lc34f:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34g
Lc34h:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34j
Lc34i:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sv_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34j:
	movq $16,904(%r13)
Lc34g:
	jmp *-16(%r13)
	.long  _s2sw_info - _s2sw_info_dsp
.const_data
.align 3
.align 0
_u35j_srtd:
	.quad	_S2vq_srt+232
	.quad	33
	.quad	6452707361
.text
.align 3
_s2sI_info_dsp:
.text
.align 3
	.quad	_u35j_srtd-(_s2sI_info)+0
	.quad	4294967301
	.quad	2
	.quad	-4294967284
_s2sI_info:
Lc34k:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34l
Lc34m:
	addq $104,%r12
	cmpq 856(%r13),%r12
	ja Lc34o
Lc34n:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _s2sn_info(%rip),%rcx
	movq %rcx,-96(%r12)
	movq %rbx,-80(%r12)
	leaq -96(%r12),%rbx
	leaq _s2sr_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %r14,-56(%r12)
	leaq -72(%r12),%rcx
	leaq _s2sH_info(%rip),%rdx
	movq %rdx,-48(%r12)
	movq %rax,-32(%r12)
	movq %rbx,-24(%r12)
	movq %rcx,-16(%r12)
	leaq -48(%r12),%rax
	leaq _s2sw_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc34o:
	movq $104,904(%r13)
Lc34l:
	jmp *-8(%r13)
	.long  _s2sI_info - _s2sI_info_dsp
.text
.align 3
_s2sk_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sk_info)+272
	.quad	0
	.quad	3458764518115508240
_s2sk_info:
Lc34x:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34y
Lc34z:
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
Lc34y:
	jmp *-16(%r13)
	.long  _s2sk_info - _s2sk_info_dsp
.text
.align 3
_s2sl_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sl_info)+272
	.quad	0
	.quad	3459890418022350864
_s2sl_info:
Lc34A:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34B
Lc34C:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34E
Lc34D:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sk_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34E:
	movq $16,904(%r13)
Lc34B:
	jmp *-16(%r13)
	.long  _s2sl_info - _s2sl_info_dsp
.const_data
.align 3
.align 0
_u35k_srtd:
	.quad	_S2vq_srt+232
	.quad	35
	.quad	32222511137
.text
.align 3
_s2sJ_info_dsp:
.text
.align 3
	.quad	_u35k_srtd-(_s2sJ_info)+0
	.quad	4294967301
	.quad	1
	.quad	-4294967286
_s2sJ_info:
Lc34F:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34G
Lc34H:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc34J
Lc34I:
	movq 7(%rbx),%rax
	leaq _s2sI_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -31(%r12),%rax
	leaq _s2sl_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc34J:
	movq $40,904(%r13)
Lc34G:
	jmp *-8(%r13)
	.long  _s2sJ_info - _s2sJ_info_dsp
.text
.align 3
_s2sg_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sg_info)+272
	.quad	0
	.quad	5764607527329202192
_s2sg_info:
Lc34W:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34X
Lc34Y:
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
Lc34X:
	jmp *-16(%r13)
	.long  _s2sg_info - _s2sg_info_dsp
.const_data
.align 3
.align 0
_u35l_srtd:
	.quad	_S2vq_srt+104
	.quad	52
	.quad	2814749769203713
.text
.align 3
_s2sh_info_dsp:
.text
.align 3
	.quad	_u35l_srtd-(_s2sh_info)+0
	.quad	0
	.quad	-4294967280
_s2sh_info:
Lc34Z:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc350
Lc351:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc353
Lc352:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sg_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc353:
	movq $16,904(%r13)
Lc350:
	jmp *-16(%r13)
	.long  _s2sh_info - _s2sh_info_dsp
.const_data
.align 3
.align 0
_u35m_srtd:
	.quad	_S2vq_srt+104
	.quad	52
	.quad	2815299525017601
.text
.align 3
_s2si_info_dsp:
.text
.align 3
	.quad	_u35m_srtd-(_s2si_info)+0
	.quad	0
	.quad	-4294967280
_s2si_info:
Lc354:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc355
Lc356:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc358
Lc357:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sh_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc358:
	movq $16,904(%r13)
Lc355:
	jmp *-16(%r13)
	.long  _s2si_info - _s2si_info_dsp
.const_data
.align 3
.align 0
_u35n_srtd:
	.quad	_S2vq_srt+104
	.quad	52
	.quad	4363534303559681
.text
.align 3
_s2sK_info_dsp:
.text
.align 3
	.quad	_u35n_srtd-(_s2sK_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	-4294967285
_s2sK_info:
Lc359:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35a
Lc35b:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc35d
Lc35c:
	leaq _s2sJ_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2si_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc35d:
	movq $32,904(%r13)
Lc35a:
	jmp *-8(%r13)
	.long  _s2sK_info - _s2sK_info_dsp
.const_data
.align 3
.align 0
_u35o_srtd:
	.quad	_S2vq_srt+104
	.quad	53
	.quad	8867133930930177
.text
.align 3
_s2sL_info_dsp:
.text
.align 3
	.quad	_u35o_srtd-(_s2sL_info)+0
	.quad	0
	.quad	-4294967274
_s2sL_info:
Lc35e:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35f
Lc35g:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35i
Lc35h:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31x
Lc31w:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2sK_info(%rip),%rax
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
Lc31x:
	jmp *(%rbx)
Lc35i:
	movq $16,904(%r13)
Lc35f:
	jmp *-16(%r13)
	.long  _s2sL_info - _s2sL_info_dsp
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
_u37Q_srtd:
	.quad	_S2vq_srt+272
	.quad	33
	.quad	4296015873
.text
.align 3
_F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp:
.text
.align 3
	.quad	_u37Q_srtd-(_F95VarDeclParser_f95zuvarzudeclzuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_f95zuvarzudeclzuparser_info
_F95VarDeclParser_f95zuvarzudeclzuparser_info:
Lc37N:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc37O
Lc37P:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc37M
Lc37L:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_whiteSpace_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2sL_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc37M:
	jmp *(%rbx)
Lc37O:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_f95zuvarzudeclzuparser_info - _F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp
.const_data
.align 3
.align 0
_S2vq_srt:
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_F95ParserCommon_natural_closure
	.quad	_F95ParserCommon_reservedOp_closure
	.quad	_r2kH_closure
	.quad	_r2pv_closure
	.quad	_F95ParserCommon_word_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziExpr_buildExpressionParser_closure
	.quad	_F95VarDeclParser_term_closure
	.quad	_F95VarDeclParser_optable_closure
	.quad	_F95ParserCommon_parens_closure
	.quad	_F95VarDeclParser_exprzuparser_closure
	.quad	_s2qs_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95VarDeclParser_arrayzuidxzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure
	.quad	_F95VarDeclParser_varzuexpr_closure
	.quad	_F95VarDeclParser_constzuexpr_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure
	.quad	_s2ql_closure
	.quad	_s2qm_closure
	.quad	_s2qx_closure
	.quad	_s2qy_closure
	.quad	_s2qB_closure
	.quad	_F95ParserCommon_commaSep_closure
	.quad	_s2qz_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_base_ControlziExceptionziBase_patError_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_s2qD_closure
	.quad	_s2qP_closure
	.quad	_s2qY_closure
	.quad	_s2r3_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_s2r9_closure
	.quad	_s2rf_closure
	.quad	_s2rn_closure
	.quad	_F95VarDeclParser_singlezuvarzurange_closure
	.quad	_F95VarDeclParser_singlezuconstzurange_closure
	.quad	_F95VarDeclParser_singlezuexprzurange_closure
	.quad	_F95VarDeclParser_rangezuexpr_closure
	.quad	_s2rl_closure
	.quad	_F95VarDeclParser_rangezuparser_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_s2rp_closure
	.quad	_s2ru_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziList_head_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqInt_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_many_closure
	.quad	_s2rV_closure
	.quad	_F95ParserCommon_whiteSpace_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_s2rY_closure
	.quad	_s2se_closure
	.quad	_F95VarDeclParser_oclzuargmodezuparser_closure
	.quad	_F95VarDeclParser_arglistzuparser_closure
	.quad	_F95ParserCommon_comma_closure
	.quad	_F95VarDeclParser_intentzuparser_closure
	.quad	_F95VarDeclParser_dimzuparser_closure
	.quad	_F95VarDeclParser_typezuparser_closure
	.quad	_s2sL_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

