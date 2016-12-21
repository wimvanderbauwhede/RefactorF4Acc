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
_r2kP_closure:
	.quad	_r2kP_info
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
_r2kP_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_r2kP_info)+0
	.quad	4294967301
	.quad	0
	.quad	55834574863
_r2kP_info:
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
	leaq _r2kP_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _r2kP_info - _r2kP_info_dsp
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
	jmp _r2kP_info
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
_s2qE_closure:
	.quad	_s2qE_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qD_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qD_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2qD_info:
Lc2EE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EF
Lc2EG:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2EF:
	jmp *-8(%r13)
	.long  _s2qD_info - _s2qD_info_dsp
.text
.align 3
_s2qB_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qB_info)+40
	.quad	0
	.quad	1125904201809936
_s2qB_info:
Lc2EL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EM
Lc2EN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2EM:
	jmp *-16(%r13)
	.long  _s2qB_info - _s2qB_info_dsp
.text
.align 3
_s2qE_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qE_info)+0
	.quad	0
	.quad	36028938752884758
_s2qE_info:
Lc2EO:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EP
Lc2EQ:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2ES
Lc2ER:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ey
Lc2Ex:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qD_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2qB_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Ey:
	jmp *(%rbx)
Lc2ES:
	movq $32,904(%r13)
Lc2EP:
	jmp *-16(%r13)
	.long  _s2qE_info - _s2qE_info_dsp
.data
.align 3
.align 0
_s2qA_closure:
	.quad	_s2qA_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Fk_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2qz_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qz_info)+48
	.quad	0
	.quad	4294967312
_s2qz_info:
Lc2Fl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fm
Lc2Fn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Fk_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Fm:
	jmp *-16(%r13)
	.long  _s2qz_info - _s2qz_info_dsp
.text
.align 3
_s2qA_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qA_info)+48
	.quad	0
	.quad	1125904201809942
_s2qA_info:
Lc2Fo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fp
Lc2Fq:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Fs
Lc2Fr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ff
Lc2Fe:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qz_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ff:
	jmp *(%rbx)
Lc2Fs:
	movq $16,904(%r13)
Lc2Fp:
	jmp *-16(%r13)
	.long  _s2qA_info - _s2qA_info_dsp
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
	.quad	432345568522534934
.globl _F95VarDeclParser_arglistzuparser_info
_F95VarDeclParser_arglistzuparser_info:
Lc2FL:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FM
Lc2FN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2FK
Lc2FJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qA_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qE_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2FK:
	jmp *(%rbx)
Lc2FM:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_arglistzuparser_info - _F95VarDeclParser_arglistzuparser_info_dsp
.data
.align 3
.align 0
_s2qS_closure:
	.quad	_s2qS_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2qJ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qJ_info)+216
	.quad	0
	.quad	12884901904
_s2qJ_info:
Lc2Gy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Gz
Lc2GA:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Gz:
	jmp *-16(%r13)
	.long  _s2qJ_info - _s2qJ_info_dsp
.const
.align 3
.align 0
_c2GF_str:
	.byte	105
	.byte	110
	.byte	0
.text
.align 3
_s2qK_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qK_info)+48
	.quad	0
	.quad	4294967312
_s2qK_info:
Lc2GG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GH
Lc2GI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2GF_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2GH:
	jmp *-16(%r13)
	.long  _s2qK_info - _s2qK_info_dsp
.const
.align 3
.align 0
_c2GR_str:
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qM_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qM_info)+48
	.quad	0
	.quad	4294967312
_s2qM_info:
Lc2GS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GT
Lc2GU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2GR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2GT:
	jmp *-16(%r13)
	.long  _s2qM_info - _s2qM_info_dsp
.const
.align 3
.align 0
_c2H3_str:
	.byte	105
	.byte	110
	.byte	111
	.byte	117
	.byte	116
	.byte	0
.text
.align 3
_s2qO_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qO_info)+48
	.quad	0
	.quad	4294967312
_s2qO_info:
Lc2H4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2H5
Lc2H6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2H3_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2H5:
	jmp *-16(%r13)
	.long  _s2qO_info - _s2qO_info_dsp
.const
.align 3
.align 0
_c2Hj_str:
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
_s2qQ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qQ_info)+48
	.quad	1
	.quad	63050399078154257
_s2qQ_info:
Lc2He:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HO
Lc2HP:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2HR
Lc2HQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qJ_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2qK_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2GJ_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2GJ_info)+48
	.quad	2
	.quad	36028801313931296
_c2GJ_info:
Lc2GJ:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Hc
Lc2Hd:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2HN
Lc2HM:
	leaq _s2qM_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2GV_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2GV_info)+48
	.quad	2
	.quad	36028801313931296
_c2GV_info:
Lc2GV:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Hs
Lc2Ht:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2HK
Lc2HJ:
	leaq _s2qO_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Hf_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Hc:
	leaq _F95VarDecl_In_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vq_srt-(_c2Hf_info)+232
	.quad	0
	.quad	4294967328
_c2Hf_info:
Lc2Hf:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2HC
Lc2HD:
	leaq _c2Hj_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2Hs:
	leaq _F95VarDecl_Out_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2HC:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2HK:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2HN:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2HR:
	movq $32,904(%r13)
Lc2HO:
	jmp *-16(%r13)
	.long  _s2qQ_info - _s2qQ_info_dsp
.text
.align 3
_s2qR_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qR_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	4035225545296838667
_s2qR_info:
Lc2HS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HT
Lc2HU:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2HW
Lc2HV:
	leaq _s2qQ_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2HW:
	movq $24,904(%r13)
Lc2HT:
	jmp *-8(%r13)
	.long  _s2qR_info - _s2qR_info_dsp
.text
.align 3
_s2qH_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qH_info)+40
	.quad	0
	.quad	141733920784
_s2qH_info:
Lc2I1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2I2
Lc2I3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2I2:
	jmp *-16(%r13)
	.long  _s2qH_info - _s2qH_info_dsp
.text
.align 3
_s2qS_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qS_info)+0
	.quad	0
	.quad	4035230080782303254
_s2qS_info:
Lc2I4:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2I5
Lc2I6:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2I8
Lc2I7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Gk
Lc2Gj:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qR_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2qH_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Gk:
	jmp *(%rbx)
Lc2I8:
	movq $32,904(%r13)
Lc2I5:
	jmp *-16(%r13)
	.long  _s2qS_info - _s2qS_info_dsp
.data
.align 3
.align 0
_s2qG_closure:
	.quad	_s2qG_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Jc_str:
	.byte	105
	.byte	110
	.byte	116
	.byte	101
	.byte	110
	.byte	116
	.byte	0
.text
.align 3
_s2qF_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qF_info)+48
	.quad	0
	.quad	4294967312
_s2qF_info:
Lc2Jd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Je
Lc2Jf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Jc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Je:
	jmp *-16(%r13)
	.long  _s2qF_info - _s2qF_info_dsp
.text
.align 3
_s2qG_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qG_info)+48
	.quad	0
	.quad	1125904201809942
_s2qG_info:
Lc2Jg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Jh
Lc2Ji:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Jk
Lc2Jj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2J7
Lc2J6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2qF_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2J7:
	jmp *(%rbx)
Lc2Jk:
	movq $16,904(%r13)
Lc2Jh:
	jmp *-16(%r13)
	.long  _s2qG_info - _s2qG_info_dsp
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
Lc2JD:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2JE
Lc2JF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2JC
Lc2JB:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2qG_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2qS_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2JC:
	jmp *(%rbx)
Lc2JE:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_intentzuparser_info - _F95VarDeclParser_intentzuparser_info_dsp
.data
.align 3
.align 0
_s2r1_closure:
	.quad	_s2r1_info
	.quad	0
.text
.align 3
_s2qZ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qZ_info)+0
	.quad	4294967301
	.quad	1
	.quad	4294967306
_s2qZ_info:
Lc2K3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2K4
Lc2K5:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2K7
Lc2K6:
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
Lc2K7:
	movq $24,904(%r13)
Lc2K4:
	jmp *-8(%r13)
	.long  _s2qZ_info - _s2qZ_info_dsp
.text
.align 3
_s2r0_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2r0_info)+0
	.quad	1
	.quad	8800387989521
_s2r0_info:
Lc2K8:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2K9
Lc2Ka:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Kc
Lc2Kb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2qZ_info(%rip),%rbx
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
Lc2Kc:
	movq $16,904(%r13)
Lc2K9:
	jmp *-16(%r13)
	.long  _s2r0_info - _s2r0_info_dsp
.text
.align 3
_s2qW_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2qW_info)+192
	.quad	0
	.quad	4294967312
_s2qW_info:
Lc2Ki:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Kj
Lc2Kk:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Km
Lc2Kl:
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
Lc2Km:
	movq $24,904(%r13)
Lc2Kj:
	jmp *-16(%r13)
	.long  _s2qW_info - _s2qW_info_dsp
.const_data
.align 3
.align 0
_u2Ks_srtd:
	.quad	_S2vq_srt
	.quad	33
	.quad	4311746561
.text
.align 3
_s2r1_info_dsp:
.text
.align 3
	.quad	_u2Ks_srtd-(_s2r1_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2r1_info:
Lc2Kn:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ko
Lc2Kp:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2Kr
Lc2Kq:
	leaq _s2r0_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2qW_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Kr:
	movq $40,904(%r13)
Lc2Ko:
	leaq _s2r1_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r1_info - _s2r1_info_dsp
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
_u2L5_srtd:
	.quad	_S2vq_srt
	.quad	33
	.quad	4294969345
.text
.align 3
_F95VarDeclParser_rangezuexpr_info_dsp:
.text
.align 3
	.quad	_u2L5_srtd-(_F95VarDeclParser_rangezuexpr_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_rangezuexpr_info
_F95VarDeclParser_rangezuexpr_info:
Lc2L2:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2L3
Lc2L4:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2L1
Lc2L0:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r1_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2L1:
	jmp *(%rbx)
Lc2L3:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuexpr_info - _F95VarDeclParser_rangezuexpr_info_dsp
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
	.quad	_S2vq_srt-(_s2r6_info)+264
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2r6_info:
Lc2Ln:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Lo
Lc2Lp:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2Lr
Lc2Lq:
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
Lc2Lr:
	movq $56,904(%r13)
Lc2Lo:
	leaq _s2r6_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2r6_info - _s2r6_info_dsp
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
Lc2LH:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2LI
Lc2LJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2LG
Lc2LF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95VarDeclParser_exprzuparser_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2r6_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2LG:
	jmp *(%rbx)
Lc2LI:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuexprzurange_info - _F95VarDeclParser_singlezuexprzurange_info_dsp
.data
.align 3
.align 0
_s2rc_closure:
	.quad	_s2rc_info
	.quad	0
.text
.align 3
_s2rc_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rc_info)+272
	.quad	4294967301
	.quad	0
	.quad	12884901903
_s2rc_info:
Lc2M1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2M2
Lc2M3:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2M5
Lc2M4:
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
Lc2M5:
	movq $72,904(%r13)
Lc2M2:
	leaq _s2rc_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rc_info - _s2rc_info_dsp
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
_u2Mp_srtd:
	.quad	_S2vq_srt+8
	.quad	35
	.quad	25769803777
.text
.align 3
_F95VarDeclParser_singlezuconstzurange_info_dsp:
.text
.align 3
	.quad	_u2Mp_srtd-(_F95VarDeclParser_singlezuconstzurange_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_singlezuconstzurange_info
_F95VarDeclParser_singlezuconstzurange_info:
Lc2Mm:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Mn
Lc2Mo:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ml
Lc2Mk:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_natural_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rc_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Ml:
	jmp *(%rbx)
Lc2Mn:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuconstzurange_info - _F95VarDeclParser_singlezuconstzurange_info_dsp
.data
.align 3
.align 0
_s2ri_closure:
	.quad	_s2ri_info
	.quad	0
.text
.align 3
_s2ri_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2ri_info)+272
	.quad	4294967301
	.quad	0
	.quad	21474836495
_s2ri_info:
Lc2MI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2MJ
Lc2MK:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2MM
Lc2ML:
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
Lc2MM:
	movq $72,904(%r13)
Lc2MJ:
	leaq _s2ri_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2ri_info - _s2ri_info_dsp
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
Lc2N3:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2N4
Lc2N5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2N2
Lc2N1:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2ri_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2N2:
	jmp *(%rbx)
Lc2N4:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_singlezuvarzurange_info - _F95VarDeclParser_singlezuvarzurange_info_dsp
.data
.align 3
.align 0
_s2rq_closure:
	.quad	_s2rq_info
	.quad	0
.text
.align 3
_s2rq_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rq_info)+272
	.quad	4294967301
	.quad	0
	.quad	38654705679
_s2rq_info:
Lc2Nj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Nk
Lc2Nl:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Nk:
	leaq _s2rq_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rq_info - _s2rq_info_dsp
.data
.align 3
.align 0
_s2ro_closure:
	.quad	_s2ro_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2NC_str:
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
_s2rn_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rn_info)+48
	.quad	0
	.quad	4294967312
_s2rn_info:
Lc2ND:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NE
Lc2NF:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2NC_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2NE:
	jmp *-16(%r13)
	.long  _s2rn_info - _s2rn_info_dsp
.text
.align 3
_s2rk_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rk_info)+120
	.quad	0
	.quad	108086395351859216
_s2rk_info:
Lc2NS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NT
Lc2NU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_singlezuconstzurange_closure(%rip),%rsi
	leaq _F95VarDeclParser_singlezuvarzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NT:
	jmp *-16(%r13)
	.long  _s2rk_info - _s2rk_info_dsp
.text
.align 3
_s2rl_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rl_info)+120
	.quad	0
	.quad	252201583427715088
_s2rl_info:
Lc2NV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NW
Lc2NX:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2NZ
Lc2NY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rk_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95VarDeclParser_singlezuexprzurange_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NZ:
	movq $16,904(%r13)
Lc2NW:
	jmp *-16(%r13)
	.long  _s2rl_info - _s2rl_info_dsp
.text
.align 3
_s2rj_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rj_info)+104
	.quad	0
	.quad	1152921508901814288
_s2rj_info:
Lc2O4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O5
Lc2O6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuexpr_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2O5:
	jmp *-16(%r13)
	.long  _s2rj_info - _s2rj_info_dsp
.text
.align 3
_s2rm_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rm_info)+104
	.quad	0
	.quad	2161727842612674576
_s2rm_info:
Lc2O7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O8
Lc2O9:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ob
Lc2Oa:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rl_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rj_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Ob:
	movq $32,904(%r13)
Lc2O8:
	jmp *-16(%r13)
	.long  _s2rm_info - _s2rm_info_dsp
.const_data
.align 3
.align 0
_u2Oh_srtd:
	.quad	_S2vq_srt+48
	.quad	36
	.quad	64424514177
.text
.align 3
_s2ro_info_dsp:
.text
.align 3
	.quad	_u2Oh_srtd-(_s2ro_info)+0
	.quad	0
	.quad	-4294967274
_s2ro_info:
Lc2Oc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Od
Lc2Oe:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Og
Lc2Of:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Nx
Lc2Nw:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rn_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rm_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlz3fUzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Nx:
	jmp *(%rbx)
Lc2Og:
	movq $32,904(%r13)
Lc2Od:
	jmp *-16(%r13)
	.long  _s2ro_info - _s2ro_info_dsp
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
Lc2OV:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OW
Lc2OX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2OU
Lc2OT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2ro_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rq_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2OU:
	jmp *(%rbx)
Lc2OW:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_rangezuparser_info - _F95VarDeclParser_rangezuparser_info_dsp
.data
.align 3
.align 0
_s2rx_closure:
	.quad	_s2rx_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rw_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rw_info)+272
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2rw_info:
Lc2Pi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pj
Lc2Pk:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Pj:
	jmp *-8(%r13)
	.long  _s2rw_info - _s2rw_info_dsp
.text
.align 3
_s2rt_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rt_info)+184
	.quad	0
	.quad	4503603922337808
_s2rt_info:
Lc2Pt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pu
Lc2Pv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_rangezuparser_closure(%rip),%r14
	leaq _F95ParserCommon_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Pu:
	jmp *-16(%r13)
	.long  _s2rt_info - _s2rt_info_dsp
.const_data
.align 3
.align 0
_u2PG_srtd:
	.quad	_S2vq_srt+80
	.quad	34
	.quad	8589942785
.text
.align 3
_s2ru_info_dsp:
.text
.align 3
	.quad	_u2PG_srtd-(_s2ru_info)+0
	.quad	0
	.quad	-4294967280
_s2ru_info:
Lc2Pw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Px
Lc2Py:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2PA
Lc2Pz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rt_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2PA:
	movq $16,904(%r13)
Lc2Px:
	jmp *-16(%r13)
	.long  _s2ru_info - _s2ru_info_dsp
.const_data
.align 3
.align 0
_u2PH_srtd:
	.quad	_S2vq_srt+80
	.quad	34
	.quad	8606720001
.text
.align 3
_s2rx_info_dsp:
.text
.align 3
	.quad	_u2PH_srtd-(_s2rx_info)+0
	.quad	0
	.quad	-4294967274
_s2rx_info:
Lc2PB:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PC
Lc2PD:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2PF
Lc2PE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Pc
Lc2Pb:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rw_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s2ru_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Pc:
	jmp *(%rbx)
Lc2PF:
	movq $32,904(%r13)
Lc2PC:
	jmp *-16(%r13)
	.long  _s2rx_info - _s2rx_info_dsp
.data
.align 3
.align 0
_s2rs_closure:
	.quad	_s2rs_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2Qg_str:
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
_s2rr_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rr_info)+352
	.quad	0
	.quad	4294967312
_s2rr_info:
Lc2Qh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Qi
Lc2Qj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Qg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Qi:
	jmp *-16(%r13)
	.long  _s2rr_info - _s2rr_info_dsp
.text
.align 3
_s2rs_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rs_info)+192
	.quad	0
	.quad	4503603922337814
_s2rs_info:
Lc2Qk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ql
Lc2Qm:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Qo
Lc2Qn:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Qb
Lc2Qa:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rr_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Qb:
	jmp *(%rbx)
Lc2Qo:
	movq $16,904(%r13)
Lc2Ql:
	jmp *-16(%r13)
	.long  _s2rs_info - _s2rs_info_dsp
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
Lc2QH:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QI
Lc2QJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2QG
Lc2QF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2rs_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rx_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2QG:
	jmp *(%rbx)
Lc2QI:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_dimzuparser_info - _F95VarDeclParser_dimzuparser_info_dsp
.data
.align 3
.align 0
_s2rY_closure:
	.quad	_s2rY_info
	.quad	0
.text
.align 3
_s2rS_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rS_info)+376
	.quad	1
	.quad	4294967313
_s2rS_info:
Lc2Ry:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Rz
Lc2RA:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Rz:
	jmp *-16(%r13)
	.long  _s2rS_info - _s2rS_info_dsp
.text
.align 3
_s2rV_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rV_info)+376
	.quad	1
	.quad	30064771089
_s2rV_info:
Lc2RK:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2RU
Lc2RV:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2RX
Lc2RW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2rS_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c2RB_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c2RB_info)+384
	.quad	1
	.quad	4294967328
_c2RB_info:
Lc2RB:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2RI
Lc2RJ:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2RI:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2RR
Lc2RQ:
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $4,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2RR:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RX:
	movq $24,904(%r13)
Lc2RU:
	jmp *-16(%r13)
	.long  _s2rV_info - _s2rV_info_dsp
.text
.align 3
_s2rK_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rK_info)+216
	.quad	0
	.quad	12884901904
_s2rK_info:
Lc2S6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2S7
Lc2S8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2S7:
	jmp *-16(%r13)
	.long  _s2rK_info - _s2rK_info_dsp
.const
.align 3
.align 0
_c2Sd_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	108
	.byte	0
.text
.align 3
_s2rL_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rL_info)+352
	.quad	0
	.quad	4294967312
_s2rL_info:
Lc2Se:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sf
Lc2Sg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Sd_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Sf:
	jmp *-16(%r13)
	.long  _s2rL_info - _s2rL_info_dsp
.const
.align 3
.align 0
_c2Sp_str:
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
_s2rN_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rN_info)+352
	.quad	0
	.quad	4294967312
_s2rN_info:
Lc2Sq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Sr
Lc2Ss:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Sp_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Sr:
	jmp *-16(%r13)
	.long  _s2rN_info - _s2rN_info_dsp
.const
.align 3
.align 0
_c2SB_str:
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
_s2rP_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rP_info)+352
	.quad	0
	.quad	4294967312
_s2rP_info:
Lc2SC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2SD
Lc2SE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2SB_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2SD:
	jmp *-16(%r13)
	.long  _s2rP_info - _s2rP_info_dsp
.text
.align 3
_s2rR_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rR_info)+216
	.quad	1
	.quad	108649353895215121
_s2rR_info:
Lc2SM:
	leaq -64(%rbp),%rax
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
	movq 16(%rbx),%rax
	leaq _s2rK_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2rL_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2Sh_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2Sh_info)+352
	.quad	2
	.quad	828928688160
_c2Sh_info:
Lc2Sh:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2SK
Lc2SL:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ta
Lc2T9:
	leaq _s2rN_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2St_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2St_info)+352
	.quad	1
	.quad	828928688160
_c2St_info:
Lc2St:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2SW
Lc2SX:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2T7
Lc2T6:
	leaq _s2rP_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2SN_info(%rip),%rcx
	movq %rcx,8(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $8,%rbp
	jmp _stg_ap_pp_fast
Lc2SK:
	leaq _F95VarDecl_F95Real_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vq_srt-(_c2SN_info)+408
	.quad	0
	.quad	4294967328
_c2SN_info:
Lc2SN:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2SW:
	leaq _F95VarDecl_F95Integer_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc2T7:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Ta:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Te:
	movq $32,904(%r13)
Lc2Tb:
	jmp *-16(%r13)
	.long  _s2rR_info - _s2rR_info_dsp
.text
.align 3
_s2rX_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rX_info)+216
	.quad	4294967301
	.quad	1
	.quad	140175101042622474
_s2rX_info:
Lc2Tg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Th
Lc2Ti:
	addq $72,%r12
	cmpq 856(%r13),%r12
	ja Lc2Tk
Lc2Tj:
	movq 7(%rbx),%rax
	leaq _s2rV_info(%rip),%rbx
	movq %rbx,-64(%r12)
	movq %r14,-48(%r12)
	leaq -64(%r12),%rbx
	leaq _s2rR_info(%rip),%rcx
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
Lc2Tk:
	movq $72,904(%r13)
Lc2Th:
	jmp *-8(%r13)
	.long  _s2rX_info - _s2rX_info_dsp
.text
.align 3
_s2rD_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rD_info)+192
	.quad	0
	.quad	4294967312
_s2rD_info:
Lc2TK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TL
Lc2TM:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2TO
Lc2TN:
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
Lc2TO:
	movq $24,904(%r13)
Lc2TL:
	jmp *-16(%r13)
	.long  _s2rD_info - _s2rD_info_dsp
.const
.align 3
.align 0
_c2TX_str:
	.byte	107
	.byte	105
	.byte	110
	.byte	100
	.byte	0
.text
.align 3
_s2rz_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rz_info)+352
	.quad	0
	.quad	4294967312
_s2rz_info:
Lc2TY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2TZ
Lc2U0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2TX_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2TZ:
	jmp *-16(%r13)
	.long  _s2rz_info - _s2rz_info_dsp
.text
.align 3
_s2rA_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rA_info)+192
	.quad	0
	.quad	4503603922337808
_s2rA_info:
Lc2U1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2U2
Lc2U3:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2U5
Lc2U4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rz_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2U5:
	movq $16,904(%r13)
Lc2U2:
	jmp *-16(%r13)
	.long  _s2rA_info - _s2rA_info_dsp
.text
.align 3
_s2rE_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rE_info)+192
	.quad	0
	.quad	4508001968848912
_s2rE_info:
Lc2U6:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2U7
Lc2U8:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ua
Lc2U9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rD_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2rA_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Ua:
	movq $32,904(%r13)
Lc2U7:
	jmp *-16(%r13)
	.long  _s2rE_info - _s2rE_info_dsp
.const_data
.align 3
.align 0
_u2UA_srtd:
	.quad	_S2vq_srt+8
	.quad	44
	.quad	8804691345409
.text
.align 3
_s2rF_info_dsp:
.text
.align 3
	.quad	_u2UA_srtd-(_s2rF_info)+0
	.quad	0
	.quad	-4294967280
_s2rF_info:
Lc2Ub:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Uc
Lc2Ud:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Uf
Lc2Ue:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rE_info(%rip),%rax
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
Lc2Uf:
	movq $16,904(%r13)
Lc2Uc:
	jmp *-16(%r13)
	.long  _s2rF_info - _s2rF_info_dsp
.const_data
.align 3
.align 0
_u2UB_srtd:
	.quad	_S2vq_srt+8
	.quad	44
	.quad	8804691361793
.text
.align 3
_s2rG_info_dsp:
.text
.align 3
	.quad	_u2UB_srtd-(_s2rG_info)+0
	.quad	0
	.quad	-4294967280
_s2rG_info:
Lc2Ug:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Uh
Lc2Ui:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Uk
Lc2Uj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rF_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _F95ParserCommon_natural_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Uk:
	movq $16,904(%r13)
Lc2Uh:
	jmp *-16(%r13)
	.long  _s2rG_info - _s2rG_info_dsp
.const_data
.align 3
.align 0
_u2UC_srtd:
	.quad	_S2vq_srt+8
	.quad	44
	.quad	8804691362305
.text
.align 3
_s2rH_info_dsp:
.text
.align 3
	.quad	_u2UC_srtd-(_s2rH_info)+0
	.quad	0
	.quad	-4294967280
_s2rH_info:
Lc2Ul:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Um
Lc2Un:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Up
Lc2Uo:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rG_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Up:
	movq $16,904(%r13)
Lc2Um:
	jmp *-16(%r13)
	.long  _s2rH_info - _s2rH_info_dsp
.const_data
.align 3
.align 0
_u2UD_srtd:
	.quad	_S2vq_srt+8
	.quad	52
	.quad	2260604505047553
.text
.align 3
_s2rI_info_dsp:
.text
.align 3
	.quad	_u2UD_srtd-(_s2rI_info)+0
	.quad	0
	.quad	-4294967280
_s2rI_info:
Lc2Uq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ur
Lc2Us:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Uu
Lc2Ut:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2rH_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Uu:
	movq $16,904(%r13)
Lc2Ur:
	jmp *-16(%r13)
	.long  _s2rI_info - _s2rI_info_dsp
.const_data
.align 3
.align 0
_u2UE_srtd:
	.quad	_S2vq_srt+8
	.quad	53
	.quad	8945635403252225
.text
.align 3
_s2rY_info_dsp:
.text
.align 3
	.quad	_u2UE_srtd-(_s2rY_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
_s2rY_info:
Lc2Uv:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Uw
Lc2Ux:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Uz
Lc2Uy:
	leaq _s2rX_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2rI_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Uz:
	movq $32,904(%r13)
Lc2Uw:
	leaq _s2rY_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2rY_info - _s2rY_info_dsp
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
_u2WG_srtd:
	.quad	_S2vq_srt+40
	.quad	49
	.quad	281475513581569
.text
.align 3
_F95VarDeclParser_typezuparser_info_dsp:
.text
.align 3
	.quad	_u2WG_srtd-(_F95VarDeclParser_typezuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_typezuparser_info
_F95VarDeclParser_typezuparser_info:
Lc2WD:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2WE
Lc2WF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2WC
Lc2WB:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _F95ParserCommon_word_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2rY_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2WC:
	jmp *(%rbx)
Lc2WE:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_typezuparser_info - _F95VarDeclParser_typezuparser_info_dsp
.data
.align 3
.align 0
_s2sh_closure:
	.quad	_s2sh_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2s5_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s5_info)+216
	.quad	0
	.quad	12884901904
_s2s5_info:
Lc2XH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2XI
Lc2XJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2XI:
	jmp *-16(%r13)
	.long  _s2s5_info - _s2s5_info_dsp
.const
.align 3
.align 0
_c2XO_str:
	.byte	114
	.byte	101
	.byte	97
	.byte	100
	.byte	0
.text
.align 3
_s2s6_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s6_info)+352
	.quad	0
	.quad	4294967312
_s2s6_info:
Lc2XP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2XQ
Lc2XR:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2XO_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2XQ:
	jmp *-16(%r13)
	.long  _s2s6_info - _s2s6_info_dsp
.const
.align 3
.align 0
_c2Y0_str:
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
	.quad	_S2vq_srt-(_s2s8_info)+352
	.quad	0
	.quad	4294967312
_s2s8_info:
Lc2Y1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Y2
Lc2Y3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Y0_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Y2:
	jmp *-16(%r13)
	.long  _s2s8_info - _s2s8_info_dsp
.const
.align 3
.align 0
_c2Yc_str:
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
_s2sa_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sa_info)+352
	.quad	0
	.quad	4294967312
_s2sa_info:
Lc2Yd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ye
Lc2Yf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Yc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ye:
	jmp *-16(%r13)
	.long  _s2sa_info - _s2sa_info_dsp
.const
.align 3
.align 0
_c2Ys_str:
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
_s2sc_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sc_info)+216
	.quad	1
	.quad	562980018192401
_s2sc_info:
Lc2Yn:
	leaq -64(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2YX
Lc2YY:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Z0
Lc2YZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2s5_info(%rip),%rbx
	movq %rbx,-24(%r12)
	leaq -24(%r12),%rbx
	leaq _s2s6_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	leaq _c2XS_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2XS_info)+232
	.quad	2
	.quad	140741783322656
_c2XS_info:
Lc2XS:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2Yl
Lc2Ym:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YW
Lc2YV:
	leaq _s2s8_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Y4_info(%rip),%rdx
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
	.quad	_S2vq_srt-(_c2Y4_info)+232
	.quad	2
	.quad	140741783322656
_c2Y4_info:
Lc2Y4:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2YB
Lc2YC:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2YT
Lc2YS:
	leaq _s2sa_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Yo_info(%rip),%rdx
	movq %rdx,16(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	addq $-8,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Yl:
	leaq _F95VarDecl_Read_closure+1(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2vq_srt-(_c2Yo_info)+232
	.quad	0
	.quad	4294967328
_c2Yo_info:
Lc2Yo:
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2YL
Lc2YM:
	leaq _c2Ys_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_patError_info
Lc2YB:
	leaq _F95VarDecl_Write_closure+2(%rip),%rbx
	addq $24,%rbp
	jmp *(%rbp)
Lc2YL:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2YT:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2YW:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Z0:
	movq $32,904(%r13)
Lc2YX:
	jmp *-16(%r13)
	.long  _s2sc_info - _s2sc_info_dsp
.text
.align 3
_s2sd_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sd_info)+216
	.quad	4294967301
	.quad	4294967296
	.quad	563529774006283
_s2sd_info:
Lc2Z1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Z2
Lc2Z3:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Z5
Lc2Z4:
	leaq _s2sc_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2Z5:
	movq $24,904(%r13)
Lc2Z2:
	jmp *-8(%r13)
	.long  _s2sd_info - _s2sd_info_dsp
.const_data
.align 3
.align 0
_u2ZH_srtd:
	.quad	_S2vq_srt+40
	.quad	40
	.quad	550322044929
.text
.align 3
_s2se_info_dsp:
.text
.align 3
	.quad	_u2ZH_srtd-(_s2se_info)+0
	.quad	0
	.quad	-4294967280
_s2se_info:
Lc2Z6:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Z7
Lc2Z8:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Za
Lc2Z9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sd_info(%rip),%rax
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
Lc2Za:
	movq $16,904(%r13)
Lc2Z7:
	jmp *-16(%r13)
	.long  _s2se_info - _s2se_info_dsp
.const_data
.align 3
.align 0
_u2ZI_srtd:
	.quad	_S2vq_srt+40
	.quad	40
	.quad	550322044929
.text
.align 3
_s2sf_info_dsp:
.text
.align 3
	.quad	_u2ZI_srtd-(_s2sf_info)+0
	.quad	0
	.quad	-4294967280
_s2sf_info:
Lc2Zb:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zc
Lc2Zd:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zf
Lc2Ze:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2se_info(%rip),%rax
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
Lc2Zf:
	movq $16,904(%r13)
Lc2Zc:
	jmp *-16(%r13)
	.long  _s2sf_info - _s2sf_info_dsp
.const
.align 3
.align 0
_c2Zo_str:
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	0
.text
.align 3
_s2s2_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s2_info)+352
	.quad	0
	.quad	4294967312
_s2s2_info:
Lc2Zp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zq
Lc2Zr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Zo_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Zq:
	jmp *-16(%r13)
	.long  _s2s2_info - _s2s2_info_dsp
.text
.align 3
_s2s3_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s3_info)+192
	.quad	0
	.quad	4503603922337808
_s2s3_info:
Lc2Zs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zt
Lc2Zu:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Zw
Lc2Zv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2s2_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Zw:
	movq $16,904(%r13)
Lc2Zt:
	jmp *-16(%r13)
	.long  _s2s3_info - _s2s3_info_dsp
.const_data
.align 3
.align 0
_u2ZJ_srtd:
	.quad	_S2vq_srt+40
	.quad	40
	.quad	550322569217
.text
.align 3
_s2sg_info_dsp:
.text
.align 3
	.quad	_u2ZJ_srtd-(_s2sg_info)+0
	.quad	0
	.quad	-4294967280
_s2sg_info:
Lc2Zx:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Zy
Lc2Zz:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2ZB
Lc2ZA:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sf_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2s3_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2ZB:
	movq $32,904(%r13)
Lc2Zy:
	jmp *-16(%r13)
	.long  _s2sg_info - _s2sg_info_dsp
.const_data
.align 3
.align 0
_u2ZK_srtd:
	.quad	_S2vq_srt+40
	.quad	50
	.quad	563500275990529
.text
.align 3
_s2sh_info_dsp:
.text
.align 3
	.quad	_u2ZK_srtd-(_s2sh_info)+0
	.quad	0
	.quad	-4294967274
_s2sh_info:
Lc2ZC:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ZD
Lc2ZE:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2ZG
Lc2ZF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Xh
Lc2Xg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2sg_info(%rip),%rax
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
Lc2Xh:
	jmp *(%rbx)
Lc2ZG:
	movq $16,904(%r13)
Lc2ZD:
	jmp *-16(%r13)
	.long  _s2sh_info - _s2sh_info_dsp
.data
.align 3
.align 0
_s2s1_closure:
	.quad	_s2s1_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2rZ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2rZ_info)+440
	.quad	0
	.quad	12884901904
_s2rZ_info:
Lc31j:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31k
Lc31l:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc31k:
	jmp *-16(%r13)
	.long  _s2rZ_info - _s2rZ_info_dsp
.text
.align 3
_s2s1_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2s1_info)+440
	.quad	0
	.quad	30064771094
_s2s1_info:
Lc31m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31n
Lc31o:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc31q
Lc31p:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31e
Lc31d:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2rZ_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rbx
	leaq 529(%rbx),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc31e:
	jmp *(%rbx)
Lc31q:
	movq $16,904(%r13)
Lc31n:
	jmp *-16(%r13)
	.long  _s2s1_info - _s2s1_info_dsp
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
Lc31J:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc31K
Lc31L:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc31I
Lc31H:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2s1_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2sh_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc31I:
	jmp *(%rbx)
Lc31K:
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
_s2sr_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sr_info)+376
	.quad	1
	.quad	4294967313
_s2sr_info:
Lc32F:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32G
Lc32H:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc32G:
	jmp *-16(%r13)
	.long  _s2sr_info - _s2sr_info_dsp
.text
.align 3
_s2sq_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sq_info)+376
	.quad	1
	.quad	30064771089
_s2sq_info:
Lc32R:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc32Y
Lc32Z:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc331
Lc330:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sr_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c32I_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c32I_info)+384
	.quad	1
	.quad	4294967328
_c32I_info:
Lc32I:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc32P
Lc32Q:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc32P:
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc331:
	movq $24,904(%r13)
Lc32Y:
	jmp *-16(%r13)
	.long  _s2sq_info - _s2sq_info_dsp
.text
.align 3
_s2sv_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sv_info)+376
	.quad	1
	.quad	4294967313
_s2sv_info:
Lc33a:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33b
Lc33c:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33b:
	jmp *-16(%r13)
	.long  _s2sv_info - _s2sv_info_dsp
.text
.align 3
_s2su_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2su_info)+376
	.quad	1
	.quad	30064771089
_s2su_info:
Lc33m:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33t
Lc33u:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc33w
Lc33v:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sv_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c33d_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c33d_info)+384
	.quad	1
	.quad	4294967328
_c33d_info:
Lc33d:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc33k
Lc33l:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc33k:
	leaq _F95VarDecl_InOut_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc33w:
	movq $24,904(%r13)
Lc33t:
	jmp *-16(%r13)
	.long  _s2su_info - _s2su_info_dsp
.text
.align 3
_s2sB_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sB_info)+376
	.quad	1
	.quad	4294967313
_s2sB_info:
Lc33Y:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc33Z
Lc340:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc33Z:
	jmp *-16(%r13)
	.long  _s2sB_info - _s2sB_info_dsp
.text
.align 3
_s2sE_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sE_info)+376
	.quad	1
	.quad	30064771089
_s2sE_info:
Lc34a:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34h
Lc34i:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc34k
Lc34j:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2sB_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rbx
	leaq _c341_info(%rip),%rcx
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
	.quad	_S2vq_srt-(_c341_info)+384
	.quad	1
	.quad	4294967328
_c341_info:
Lc341:
	movq 8(%rbp),%rax
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc348
Lc349:
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc348:
	leaq _F95VarDecl_ReadWrite_closure+3(%rip),%rbx
	addq $16,%rbp
	jmp *(%rbp)
Lc34k:
	movq $24,904(%r13)
Lc34h:
	jmp *-16(%r13)
	.long  _s2sE_info - _s2sE_info_dsp
.text
.align 3
_s2sG_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sG_info)+272
	.quad	4294967301
	.quad	4
	.quad	246294899589129
_s2sG_info:
Lc34m:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34n
Lc34o:
	addq $96,%r12
	cmpq 856(%r13),%r12
	ja Lc34q
Lc34p:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rdx
	movq 31(%rbx),%rbx
	leaq _s2sE_info(%rip),%rsi
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
Lc34q:
	movq $96,904(%r13)
Lc34n:
	jmp *-8(%r13)
	.long  _s2sG_info - _s2sG_info_dsp
.text
.align 3
_s2sz_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sz_info)+416
	.quad	0
	.quad	1103806595088
_s2sz_info:
Lc34v:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34w
Lc34x:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _F95VarDeclParser_oclzuargmodezuparser_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34w:
	jmp *-16(%r13)
	.long  _s2sz_info - _s2sz_info_dsp
.text
.align 3
_s2sH_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sH_info)+272
	.quad	4294967301
	.quad	3
	.quad	289602570958143497
_s2sH_info:
Lc34y:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34z
Lc34A:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc34C
Lc34B:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _s2sG_info(%rip),%rdx
	movq %rdx,-48(%r12)
	movq %rax,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	leaq -47(%r12),%rax
	leaq _s2sz_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc34C:
	movq $56,904(%r13)
Lc34z:
	jmp *-8(%r13)
	.long  _s2sH_info - _s2sH_info_dsp
.text
.align 3
_s2sI_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sI_info)+272
	.quad	4294967301
	.quad	2
	.quad	866063323261566988
_s2sI_info:
Lc34D:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34E
Lc34F:
	addq $80,%r12
	cmpq 856(%r13),%r12
	ja Lc34H
Lc34G:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _s2sq_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %rbx,-56(%r12)
	leaq -72(%r12),%rbx
	leaq _s2su_info(%rip),%rcx
	movq %rcx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rcx
	leaq _s2sH_info(%rip),%rdx
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
Lc34H:
	movq $80,904(%r13)
Lc34E:
	jmp *-8(%r13)
	.long  _s2sI_info - _s2sI_info_dsp
.text
.align 3
_s2sn_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sn_info)+272
	.quad	0
	.quad	3458764518115508240
_s2sn_info:
Lc34Q:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34R
Lc34S:
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
Lc34R:
	jmp *-16(%r13)
	.long  _s2sn_info - _s2sn_info_dsp
.text
.align 3
_s2so_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2so_info)+272
	.quad	0
	.quad	3459890418022350864
_s2so_info:
Lc34T:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34U
Lc34V:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc34X
Lc34W:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sn_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_many_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc34X:
	movq $16,904(%r13)
Lc34U:
	jmp *-16(%r13)
	.long  _s2so_info - _s2so_info_dsp
.text
.align 3
_s2sJ_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sJ_info)+272
	.quad	4294967301
	.quad	1
	.quad	4324827837082107914
_s2sJ_info:
Lc34Y:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc34Z
Lc350:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc352
Lc351:
	movq 7(%rbx),%rax
	leaq _s2sI_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -31(%r12),%rax
	leaq _s2so_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc352:
	movq $40,904(%r13)
Lc34Z:
	jmp *-8(%r13)
	.long  _s2sJ_info - _s2sJ_info_dsp
.text
.align 3
_s2sj_info_dsp:
.text
.align 3
	.quad	_S2vq_srt-(_s2sj_info)+272
	.quad	0
	.quad	5764607527329202192
_s2sj_info:
Lc35f:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35g
Lc35h:
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
Lc35g:
	jmp *-16(%r13)
	.long  _s2sj_info - _s2sj_info_dsp
.const_data
.align 3
.align 0
_u35C_srtd:
	.quad	_S2vq_srt+104
	.quad	52
	.quad	2814749769203713
.text
.align 3
_s2sk_info_dsp:
.text
.align 3
	.quad	_u35C_srtd-(_s2sk_info)+0
	.quad	0
	.quad	-4294967280
_s2sk_info:
Lc35i:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35j
Lc35k:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35m
Lc35l:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2sj_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc35m:
	movq $16,904(%r13)
Lc35j:
	jmp *-16(%r13)
	.long  _s2sk_info - _s2sk_info_dsp
.const_data
.align 3
.align 0
_u35D_srtd:
	.quad	_S2vq_srt+104
	.quad	52
	.quad	2815299525017601
.text
.align 3
_s2sl_info_dsp:
.text
.align 3
	.quad	_u35D_srtd-(_s2sl_info)+0
	.quad	0
	.quad	-4294967280
_s2sl_info:
Lc35n:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35o
Lc35p:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35r
Lc35q:
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
Lc35r:
	movq $16,904(%r13)
Lc35o:
	jmp *-16(%r13)
	.long  _s2sl_info - _s2sl_info_dsp
.const_data
.align 3
.align 0
_u35E_srtd:
	.quad	_S2vq_srt+104
	.quad	52
	.quad	4363532156010497
.text
.align 3
_s2sK_info_dsp:
.text
.align 3
	.quad	_u35E_srtd-(_s2sK_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	-4294967285
_s2sK_info:
Lc35s:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35t
Lc35u:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc35w
Lc35v:
	leaq _s2sJ_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
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
Lc35w:
	movq $32,904(%r13)
Lc35t:
	jmp *-8(%r13)
	.long  _s2sK_info - _s2sK_info_dsp
.const_data
.align 3
.align 0
_u35F_srtd:
	.quad	_S2vq_srt+104
	.quad	53
	.quad	8867131783380993
.text
.align 3
_s2sL_info_dsp:
.text
.align 3
	.quad	_u35F_srtd-(_s2sL_info)+0
	.quad	0
	.quad	-4294967274
_s2sL_info:
Lc35x:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc35y
Lc35z:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc35B
Lc35A:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc32h
Lc32g:
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
Lc32h:
	jmp *(%rbx)
Lc35B:
	movq $16,904(%r13)
Lc35y:
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
_u37O_srtd:
	.quad	_S2vq_srt+272
	.quad	33
	.quad	4296015873
.text
.align 3
_F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp:
.text
.align 3
	.quad	_u37O_srtd-(_F95VarDeclParser_f95zuvarzudeclzuparser_info)+0
	.quad	0
	.quad	-4294967274
.globl _F95VarDeclParser_f95zuvarzudeclzuparser_info
_F95VarDeclParser_f95zuvarzudeclzuparser_info:
Lc37L:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc37M
Lc37N:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc37K
Lc37J:
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
Lc37K:
	jmp *(%rbx)
Lc37M:
	jmp *-16(%r13)
	.long  _F95VarDeclParser_f95zuvarzudeclzuparser_info - _F95VarDeclParser_f95zuvarzudeclzuparser_info_dsp
.const_data
.align 3
.align 0
_S2vq_srt:
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_F95ParserCommon_natural_closure
	.quad	_F95ParserCommon_reservedOp_closure
	.quad	_r2kP_closure
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
	.quad	_F95ParserCommon_commaSep_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_s2qA_closure
	.quad	_s2qE_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_base_ControlziExceptionziBase_patError_closure
	.quad	_s2qG_closure
	.quad	_s2qS_closure
	.quad	_s2r1_closure
	.quad	_s2r6_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_s2rc_closure
	.quad	_s2ri_closure
	.quad	_s2rq_closure
	.quad	_F95VarDeclParser_singlezuvarzurange_closure
	.quad	_F95VarDeclParser_singlezuconstzurange_closure
	.quad	_F95VarDeclParser_singlezuexprzurange_closure
	.quad	_F95VarDeclParser_rangezuexpr_closure
	.quad	_s2ro_closure
	.quad	_F95VarDeclParser_rangezuparser_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_s2rs_closure
	.quad	_s2rx_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziList_head_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqInt_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_many_closure
	.quad	_s2rY_closure
	.quad	_F95ParserCommon_whiteSpace_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_s2s1_closure
	.quad	_s2sh_closure
	.quad	_F95VarDeclParser_oclzuargmodezuparser_closure
	.quad	_F95VarDeclParser_arglistzuparser_closure
	.quad	_F95ParserCommon_comma_closure
	.quad	_F95VarDeclParser_intentzuparser_closure
	.quad	_F95VarDeclParser_dimzuparser_closure
	.quad	_F95VarDeclParser_typezuparser_closure
	.quad	_s2sL_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

