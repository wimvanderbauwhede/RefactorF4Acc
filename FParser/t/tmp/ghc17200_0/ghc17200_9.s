.data
.align 3
.align 0
.globl ___stginit_F95ParserCommon
___stginit_F95ParserCommon:
.data
.align 3
.align 0
_r2jt_closure:
	.quad	_r2jt_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2jt_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_r2jt_info)+0
	.quad	0
	.quad	12884901910
_r2jt_info:
Lc2mM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mN
Lc2mO:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2mL
Lc2mK:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2mL:
	jmp *(%rbx)
Lc2mN:
	jmp *-16(%r13)
	.long  _r2jt_info - _r2jt_info_dsp
.data
.align 3
.align 0
_r2lJ_closure:
	.quad	_r2lJ_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2nu_str:
	.byte	61
	.byte	43
	.byte	45
	.byte	42
	.byte	47
	.byte	46
	.byte	58
	.byte	37
	.byte	38
	.byte	60
	.byte	62
	.byte	0
.text
.align 3
_s2m9_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m9_info)+16
	.quad	0
	.quad	4294967312
_s2m9_info:
Lc2nv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nw
Lc2nx:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2nu_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2nw:
	jmp *-16(%r13)
	.long  _s2m9_info - _s2m9_info_dsp
.text
.align 3
_s2ma_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2ma_info)+16
	.quad	0
	.quad	30064771088
_s2ma_info:
Lc2ny:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nz
Lc2nA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2nC
Lc2nB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2m9_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _r2jt_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_oneOf_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2nC:
	movq $16,904(%r13)
Lc2nz:
	jmp *-16(%r13)
	.long  _s2ma_info - _s2ma_info_dsp
.text
.align 3
_s2m8_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m8_info)+40
	.quad	0
	.quad	12884901904
_s2m8_info:
Lc2nH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nI
Lc2nJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2lJ_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_opLetter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2nI:
	jmp *-16(%r13)
	.long  _s2m8_info - _s2m8_info_dsp
.text
.align 3
_s2m5_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m5_info)+32
	.quad	0
	.quad	38654705680
_s2m5_info:
Lc2nW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nX
Lc2nY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 1521(%rax),%rsi
	leaq _r2jt_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2nX:
	jmp *-16(%r13)
	.long  _s2m5_info - _s2m5_info_dsp
.text
.align 3
_s2m3_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m3_info)+32
	.quad	0
	.quad	38654705680
_s2m3_info:
Lc2o3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2o4
Lc2o5:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 577(%rax),%rsi
	leaq _r2jt_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2o4:
	jmp *-16(%r13)
	.long  _s2m3_info - _s2m3_info_dsp
.text
.align 3
_s2m6_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m6_info)+32
	.quad	0
	.quad	107374182416
_s2m6_info:
Lc2o6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2o7
Lc2o8:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2oa
Lc2o9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2m5_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2m3_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oa:
	movq $32,904(%r13)
Lc2o7:
	jmp *-16(%r13)
	.long  _s2m6_info - _s2m6_info_dsp
.text
.align 3
_s2m1_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m1_info)+32
	.quad	0
	.quad	141733920784
_s2m1_info:
Lc2of:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2og
Lc2oh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2jt_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2og:
	jmp *-16(%r13)
	.long  _s2m1_info - _s2m1_info_dsp
.text
.align 3
_s2m7_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m7_info)+32
	.quad	0
	.quad	244813135888
_s2m7_info:
Lc2oi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oj
Lc2ok:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2om
Lc2ol:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2m6_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2m1_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2om:
	movq $32,904(%r13)
Lc2oj:
	jmp *-16(%r13)
	.long  _s2m7_info - _s2m7_info_dsp
.const
.align 3
.align 0
_c2or_str:
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s2m0_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2m0_info)+16
	.quad	0
	.quad	4294967312
_s2m0_info:
Lc2os:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ot
Lc2ou:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2or_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ot:
	jmp *-16(%r13)
	.long  _s2m0_info - _s2m0_info_dsp
.text
.align 3
_r2lJ_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_r2lJ_info)+16
	.quad	0
	.quad	2194728288278
_r2lJ_info:
Lc2ov:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oA
Lc2oB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ng
Lc2nf:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2nh_info(%rip),%rax
	movq %rax,-24(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure(%rip),%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2nh
Lc2ni:
	jmp *(%rbx)
Lc2ng:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2mP_srt-(_c2nh_info)+16
	.quad	0
	.quad	1095216660512
_c2nh_info:
Lc2nh:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc2oz
Lc2oy:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rax
	movq 23(%rbx),%rax
	movq 31(%rbx),%rax
	movq 39(%rbx),%rax
	movq 47(%rbx),%rcx
	movq 55(%rbx),%rcx
	movq 63(%rbx),%rcx
	movq 71(%rbx),%rcx
	movq 79(%rbx),%rcx
	movq 87(%rbx),%rbx
	leaq _s2ma_info(%rip),%rbx
	movq %rbx,-152(%r12)
	leaq -152(%r12),%rbx
	leaq _s2m8_info(%rip),%rcx
	movq %rcx,-136(%r12)
	leaq -136(%r12),%rcx
	leaq _s2m7_info(%rip),%rdx
	movq %rdx,-120(%r12)
	leaq -120(%r12),%rdx
	leaq _s2m0_info(%rip),%rsi
	movq %rsi,-104(%r12)
	leaq -104(%r12),%rsi
	leaq _parseczm3zi1zi5_TextziParsecziToken_LanguageDef_con_info(%rip),%rdi
	movq %rdi,-88(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %rdi,-80(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %rdi,-72(%r12)
	movq %rsi,-64(%r12)
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rsi
	movq %rsi,-56(%r12)
	movq %rax,-48(%r12)
	movq %rdx,-40(%r12)
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-16(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-8(%r12)
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rax
	movq %rax,(%r12)
	leaq -87(%r12),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2oz:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2oA:
	jmp *-16(%r13)
	.long  _r2lJ_info - _r2lJ_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_f95Def_closure
_F95ParserCommon_f95Def_closure:
	.quad	_stg_IND_STATIC_info
	.quad	_r2lJ_closure
	.quad	0
	.quad	0
.data
.align 3
.align 0
.globl _F95ParserCommon_lexer_closure
_F95ParserCommon_lexer_closure:
	.quad	_F95ParserCommon_lexer_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_s2mb_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mb_info)+0
	.quad	0
	.quad	12884901904
_s2mb_info:
Lc2pP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pQ
Lc2pR:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2pQ:
	jmp *-16(%r13)
	.long  _s2mb_info - _s2mb_info_dsp
.text
.align 3
_F95ParserCommon_lexer_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_lexer_info)+0
	.quad	0
	.quad	9083855831062
.globl _F95ParserCommon_lexer_info
_F95ParserCommon_lexer_info:
Lc2pS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pT
Lc2pU:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2pW
Lc2pV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2pK
Lc2pJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2mb_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _r2lJ_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2pK:
	jmp *(%rbx)
Lc2pW:
	movq $16,904(%r13)
Lc2pT:
	jmp *-16(%r13)
	.long  _F95ParserCommon_lexer_info - _F95ParserCommon_lexer_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_integer_closure
_F95ParserCommon_integer_closure:
	.quad	_F95ParserCommon_integer_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_integer_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_integer_info)+96
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_integer_info
_F95ParserCommon_integer_info:
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
	je Lc2qd
Lc2qc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_integer_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qd:
	jmp *(%rbx)
Lc2qf:
	jmp *-16(%r13)
	.long  _F95ParserCommon_integer_info - _F95ParserCommon_integer_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_identifier_closure
_F95ParserCommon_identifier_closure:
	.quad	_F95ParserCommon_identifier_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_identifier_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_identifier_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_identifier_info
_F95ParserCommon_identifier_info:
Lc2qt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qu
Lc2qv:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qs
Lc2qr:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qs:
	jmp *(%rbx)
Lc2qu:
	jmp *-16(%r13)
	.long  _F95ParserCommon_identifier_info - _F95ParserCommon_identifier_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_commaSep1_closure
_F95ParserCommon_commaSep1_closure:
	.quad	_F95ParserCommon_commaSep1_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_commaSep1_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_commaSep1_info)+96
	.quad	0
	.quad	38654705686
.globl _F95ParserCommon_commaSep1_info
_F95ParserCommon_commaSep1_info:
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
	je Lc2qH
Lc2qG:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qH:
	jmp *(%rbx)
Lc2qJ:
	jmp *-16(%r13)
	.long  _F95ParserCommon_commaSep1_info - _F95ParserCommon_commaSep1_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_commaSep_closure
_F95ParserCommon_commaSep_closure:
	.quad	_F95ParserCommon_commaSep_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_commaSep_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_commaSep_info)+96
	.quad	0
	.quad	73014444054
.globl _F95ParserCommon_commaSep_info
_F95ParserCommon_commaSep_info:
Lc2qX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qY
Lc2qZ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qW
Lc2qV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qW:
	jmp *(%rbx)
Lc2qY:
	jmp *-16(%r13)
	.long  _F95ParserCommon_commaSep_info - _F95ParserCommon_commaSep_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_comma_closure
_F95ParserCommon_comma_closure:
	.quad	_F95ParserCommon_comma_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_comma_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_comma_info)+96
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_comma_info
_F95ParserCommon_comma_info:
Lc2rc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rd
Lc2re:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rb
Lc2ra:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_comma_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rb:
	jmp *(%rbx)
Lc2rd:
	jmp *-16(%r13)
	.long  _F95ParserCommon_comma_info - _F95ParserCommon_comma_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_charLiteral_closure
_F95ParserCommon_charLiteral_closure:
	.quad	_F95ParserCommon_charLiteral_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_charLiteral_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_charLiteral_info)+96
	.quad	0
	.quad	279172874262
.globl _F95ParserCommon_charLiteral_info
_F95ParserCommon_charLiteral_info:
Lc2rr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rs
Lc2rt:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rq
Lc2rp:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rq:
	jmp *(%rbx)
Lc2rs:
	jmp *-16(%r13)
	.long  _F95ParserCommon_charLiteral_info - _F95ParserCommon_charLiteral_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_natural_closure
_F95ParserCommon_natural_closure:
	.quad	_F95ParserCommon_natural_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_natural_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_natural_info)+96
	.quad	0
	.quad	554050781206
.globl _F95ParserCommon_natural_info
_F95ParserCommon_natural_info:
Lc2rG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rH
Lc2rI:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rF
Lc2rE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_natural_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rF:
	jmp *(%rbx)
Lc2rH:
	jmp *-16(%r13)
	.long  _F95ParserCommon_natural_info - _F95ParserCommon_natural_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_parens_closure
_F95ParserCommon_parens_closure:
	.quad	_F95ParserCommon_parens_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_parens_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_parens_info)+96
	.quad	0
	.quad	1103806595094
.globl _F95ParserCommon_parens_info
_F95ParserCommon_parens_info:
Lc2rV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rW
Lc2rX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rU
Lc2rT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rU:
	jmp *(%rbx)
Lc2rW:
	jmp *-16(%r13)
	.long  _F95ParserCommon_parens_info - _F95ParserCommon_parens_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_reserved_closure
_F95ParserCommon_reserved_closure:
	.quad	_F95ParserCommon_reserved_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_reserved_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_reserved_info)+96
	.quad	0
	.quad	2203318222870
.globl _F95ParserCommon_reserved_info
_F95ParserCommon_reserved_info:
Lc2sa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sb
Lc2sc:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2s9
Lc2s8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reserved_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2s9:
	jmp *(%rbx)
Lc2sb:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reserved_info - _F95ParserCommon_reserved_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_reservedOp_closure
_F95ParserCommon_reservedOp_closure:
	.quad	_F95ParserCommon_reservedOp_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_reservedOp_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_reservedOp_info)+96
	.quad	0
	.quad	4402341478422
.globl _F95ParserCommon_reservedOp_info
_F95ParserCommon_reservedOp_info:
Lc2sp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sq
Lc2sr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2so
Lc2sn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2so:
	jmp *(%rbx)
Lc2sq:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reservedOp_info - _F95ParserCommon_reservedOp_info_dsp
.data
.align 3
.align 0
_r2lK_closure:
	.quad	_r2lK_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2lK_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_r2lK_info)+0
	.quad	0
	.quad	12884901910
_r2lK_info:
Lc2sE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sF
Lc2sG:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sD
Lc2sC:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sD:
	jmp *(%rbx)
Lc2sF:
	jmp *-16(%r13)
	.long  _r2lK_info - _r2lK_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparser_closure
_F95ParserCommon_runzuparser_closure:
	.quad	_F95ParserCommon_runzuparser_info
	.quad	0
.text
.align 3
_s2mh_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mh_info)+184
	.quad	1
	.quad	4294967313
_s2mh_info:
Lc2t8:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2t9
Lc2ta:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziShow_show_info
Lc2t9:
	jmp *-16(%r13)
	.long  _s2mh_info - _s2mh_info_dsp
.const
.align 3
.align 0
_c2tf_str:
	.byte	112
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	32
	.byte	101
	.byte	114
	.byte	114
	.byte	111
	.byte	114
	.byte	32
	.byte	97
	.byte	116
	.byte	32
	.byte	0
.text
.align 3
_s2mg_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mg_info)+16
	.quad	0
	.quad	4294967312
_s2mg_info:
Lc2tg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2th
Lc2ti:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2tf_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2th:
	jmp *-16(%r13)
	.long  _s2mg_info - _s2mg_info_dsp
.text
.align 3
_F95ParserCommon_runzuparser_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_runzuparser_info)+16
	.quad	8589934607
	.quad	0
	.quad	567453557343649807
.globl _F95ParserCommon_runzuparser_info
_F95ParserCommon_runzuparser_info:
Lc2tq:
	leaq -8(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tC
Lc2tD:
	leaq _c2t0_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	leaq _r2lK_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	addq $-8,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2mP_srt-(_c2t0_info)+16
	.quad	0
	.quad	63050399078154272
_c2t0_info:
Lc2t0:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc2to
Lc2tp:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2tB
Lc2tA:
	movq 7(%rbx),%rax
	leaq _s2mh_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2mg_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2tr_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2to:
	movq 6(%rbx),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp _stg_ap_0_fast
.text
.align 3
	.quad	_S2mP_srt-(_c2tr_info)+200
	.quad	0
	.quad	4294967328
_c2tr_info:
Lc2tr:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2tB:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2tC:
	leaq _F95ParserCommon_runzuparser_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _F95ParserCommon_runzuparser_info - _F95ParserCommon_runzuparser_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparserzuprint_closure
_F95ParserCommon_runzuparserzuprint_closure:
	.quad	_F95ParserCommon_runzuparserzuprint_info
	.quad	0
.text
.align 3
_s2ml_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2ml_info)+0
	.quad	0
	.quad	12884901904
_s2ml_info:
Lc2uc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ud
Lc2ue:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2ud:
	jmp *-16(%r13)
	.long  _s2ml_info - _s2ml_info_dsp
.text
.align 3
_s2ms_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2ms_info)+184
	.quad	1
	.quad	279172874257
_s2ms_info:
Lc2us:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ut
Lc2uu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	leaq _base_SystemziIO_print_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2ut:
	jmp *-16(%r13)
	.long  _s2ms_info - _s2ms_info_dsp
.const
.align 3
.align 0
_c2uD_str:
	.byte	112
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	32
	.byte	101
	.byte	114
	.byte	114
	.byte	111
	.byte	114
	.byte	32
	.byte	97
	.byte	116
	.byte	32
	.byte	0
.text
.align 3
_s2mq_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mq_info)+16
	.quad	0
	.quad	4294967312
_s2mq_info:
Lc2uE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uF
Lc2uG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2uD_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2uF:
	jmp *-16(%r13)
	.long  _s2mq_info - _s2mq_info_dsp
.text
.align 3
_s2mr_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mr_info)+16
	.quad	0
	.quad	1152921508901814288
_s2mr_info:
Lc2uH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uI
Lc2uJ:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2uL
Lc2uK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mq_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStr_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uL:
	movq $16,904(%r13)
Lc2uI:
	jmp *-16(%r13)
	.long  _s2mr_info - _s2mr_info_dsp
.text
.align 3
_s2mv_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2mv_info:
Lc2v1:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2v2
Lc2v3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rax,%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rax
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziShow_show_info
Lc2v2:
	jmp *-16(%r13)
	.long  _s2mv_info - _s2mv_info_dsp
.text
.align 3
_s2my_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2my_info)+192
	.quad	2
	.quad	4294967315
_s2my_info:
Lc2v4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2v5
Lc2v6:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2v8
Lc2v7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-48(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rcx
	addq $705,%rcx
	movq %rcx,-40(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rcx
	movq %rcx,-32(%r12)
	leaq -46(%r12),%rcx
	leaq _s2mv_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rcx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2v8:
	movq $56,904(%r13)
Lc2v5:
	jmp *-16(%r13)
	.long  _s2my_info - _s2my_info_dsp
.const
.align 3
.align 0
_c2vd_str:
	.byte	32
	.byte	32
	.byte	32
	.byte	32
	.byte	0
.text
.align 3
_s2mu_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mu_info)+16
	.quad	0
	.quad	4294967312
_s2mu_info:
Lc2ve:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vf
Lc2vg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vd_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vf:
	jmp *-16(%r13)
	.long  _s2mu_info - _s2mu_info_dsp
.text
.align 3
_s2mz_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mz_info)+16
	.quad	2
	.quad	18014402804449299
_s2mz_info:
Lc2vh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vi
Lc2vj:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2vl
Lc2vk:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2my_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s2mu_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2vl:
	movq $48,904(%r13)
Lc2vi:
	jmp *-16(%r13)
	.long  _s2mz_info - _s2mz_info_dsp
.text
.align 3
_s2mA_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mA_info)+16
	.quad	8589934607
	.quad	2
	.quad	8818048074686398476
_s2mA_info:
Lc2vt:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vA
Lc2vB:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2uk_info(%rip),%rcx
	movq %rcx,-16(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2mP_srt-(_c2uk_info)+16
	.quad	1
	.quad	8673932886610542624
_c2uk_info:
Lc2uk:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2vr
Lc2vs:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2vz
Lc2vy:
	movq 7(%rbx),%rax
	leaq _s2ms_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2mr_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	movq %rax,8(%rbp)
	addq $-8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2vr:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2vw
Lc2vv:
	movq 6(%rbx),%rbx
	leaq _s2mz_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2vw:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2vz:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2vA:
	jmp *-8(%r13)
	.long  _s2mA_info - _s2mA_info_dsp
.const_data
.align 3
.align 0
_u2vH_srtd:
	.quad	_S2mP_srt
	.quad	34
	.quad	16802381831
.text
.align 3
_F95ParserCommon_runzuparserzuprint_info_dsp:
.text
.align 3
	.quad	_u2vH_srtd-(_F95ParserCommon_runzuparserzuprint_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_runzuparserzuprint_info
_F95ParserCommon_runzuparserzuprint_info:
Lc2vC:
Lc2vE:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2vG
Lc2vF:
	leaq _s2ml_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -32(%r12),%rax
	leaq _s2mA_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,-8(%r12)
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2vG:
	movq $40,904(%r13)
Lc2vD:
	leaq _F95ParserCommon_runzuparserzuprint_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _F95ParserCommon_runzuparserzuprint_info - _F95ParserCommon_runzuparserzuprint_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_semi_closure
_F95ParserCommon_semi_closure:
	.quad	_F95ParserCommon_semi_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_semi_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_semi_info)+96
	.quad	0
	.quad	18014402804449302
.globl _F95ParserCommon_semi_info
_F95ParserCommon_semi_info:
Lc2wL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wM
Lc2wN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2wK
Lc2wJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_semi_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wK:
	jmp *(%rbx)
Lc2wM:
	jmp *-16(%r13)
	.long  _F95ParserCommon_semi_info - _F95ParserCommon_semi_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_stringLiteral_closure
_F95ParserCommon_stringLiteral_closure:
	.quad	_F95ParserCommon_stringLiteral_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_stringLiteral_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_stringLiteral_info)+96
	.quad	0
	.quad	36028801313931286
.globl _F95ParserCommon_stringLiteral_info
_F95ParserCommon_stringLiteral_info:
Lc2x0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2x1
Lc2x2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2wZ
Lc2wY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wZ:
	jmp *(%rbx)
Lc2x1:
	jmp *-16(%r13)
	.long  _F95ParserCommon_stringLiteral_info - _F95ParserCommon_stringLiteral_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_symbol_closure
_F95ParserCommon_symbol_closure:
	.quad	_F95ParserCommon_symbol_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_symbol_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_symbol_info)+96
	.quad	0
	.quad	72057598332895254
.globl _F95ParserCommon_symbol_info
_F95ParserCommon_symbol_info:
Lc2xf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xg
Lc2xh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xe
Lc2xd:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xe:
	jmp *(%rbx)
Lc2xg:
	jmp *-16(%r13)
	.long  _F95ParserCommon_symbol_info - _F95ParserCommon_symbol_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_arglistzuparserzuwrapper_closure
_F95ParserCommon_arglistzuparserzuwrapper_closure:
	.quad	_F95ParserCommon_arglistzuparserzuwrapper_info
	.quad	0
.const
.align 3
.align 0
_c2xE_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2mD_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mD_info)+296
	.quad	0
	.quad	4294967312
_s2mD_info:
Lc2xF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xG
Lc2xH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2xE_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2xG:
	jmp *-16(%r13)
	.long  _s2mD_info - _s2mD_info_dsp
.text
.align 3
_s2mE_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mE_info)+296
	.quad	0
	.quad	12884901904
_s2mE_info:
Lc2xI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xJ
Lc2xK:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2xM
Lc2xL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xM:
	movq $16,904(%r13)
Lc2xJ:
	jmp *-16(%r13)
	.long  _s2mE_info - _s2mE_info_dsp
.text
.align 3
_s2mF_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mF_info)+296
	.quad	1
	.quad	30064771089
_s2mF_info:
Lc2xN:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xO
Lc2xP:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2xR
Lc2xQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2mE_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2xR:
	movq $16,904(%r13)
Lc2xO:
	jmp *-16(%r13)
	.long  _s2mF_info - _s2mF_info_dsp
.text
.align 3
_s2mC_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_s2mC_info)+320
	.quad	1
	.quad	4294967313
_s2mC_info:
Lc2xW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xX
Lc2xY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xX:
	jmp *-16(%r13)
	.long  _s2mC_info - _s2mC_info_dsp
.const_data
.align 3
.align 0
_u2y4_srtd:
	.quad	_S2mP_srt+64
	.quad	34
	.quad	16642998273
.text
.align 3
_F95ParserCommon_arglistzuparserzuwrapper_info_dsp:
.text
.align 3
	.quad	_u2y4_srtd-(_F95ParserCommon_arglistzuparserzuwrapper_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_arglistzuparserzuwrapper_info
_F95ParserCommon_arglistzuparserzuwrapper_info:
Lc2xZ:
Lc2y1:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2y3
Lc2y2:
	leaq _s2mF_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2mC_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2y3:
	movq $48,904(%r13)
Lc2y0:
	leaq _F95ParserCommon_arglistzuparserzuwrapper_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _F95ParserCommon_arglistzuparserzuwrapper_info - _F95ParserCommon_arglistzuparserzuwrapper_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_whiteSpace_closure
_F95ParserCommon_whiteSpace_closure:
	.quad	_F95ParserCommon_whiteSpace_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_whiteSpace_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_whiteSpace_info)+96
	.quad	0
	.quad	4611686022722355222
.globl _F95ParserCommon_whiteSpace_info
_F95ParserCommon_whiteSpace_info:
Lc2yC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yD
Lc2yE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yB
Lc2yA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yB:
	jmp *(%rbx)
Lc2yD:
	jmp *-16(%r13)
	.long  _F95ParserCommon_whiteSpace_info - _F95ParserCommon_whiteSpace_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_word_closure
_F95ParserCommon_word_closure:
	.quad	_F95ParserCommon_word_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_F95ParserCommon_word_info_dsp:
.text
.align 3
	.quad	_S2mP_srt-(_F95ParserCommon_word_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_word_info
_F95ParserCommon_word_info:
Lc2yR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yS
Lc2yT:
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
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yQ:
	jmp *(%rbx)
Lc2yS:
	jmp *-16(%r13)
	.long  _F95ParserCommon_word_info - _F95ParserCommon_word_info_dsp
.const_data
.align 3
.align 0
_S2mP_srt:
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_oneOf_closure
	.quad	_r2jt_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_opLetter_closure
	.quad	_r2lJ_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure
	.quad	_parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure
	.quad	_F95ParserCommon_lexer_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_integer_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_identifier_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_commaSep_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_comma_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_natural_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_parens_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_reserved_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure
	.quad	_parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_F95ParserCommon_runzuparser_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_parse_closure
	.quad	_r2lK_closure
	.quad	_base_SystemziIO_print_closure
	.quad	_base_SystemziIO_putStr_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_base_SystemziIO_putStrLn_closure
	.quad	_F95ParserCommon_runzuparserzuprint_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_semi_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_symbol_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95ParserCommon_arglistzuparserzuwrapper_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

