.data
.align 3
.align 0
.globl ___stginit_F95ParserCommon
___stginit_F95ParserCommon:
.data
.align 3
.align 0
_r2jY_closure:
	.quad	_r2jY_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2jY_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_r2jY_info)+0
	.quad	0
	.quad	12884901910
_r2jY_info:
Lc2nr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ns
Lc2nt:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nq
Lc2np:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2nq:
	jmp *(%rbx)
Lc2ns:
	jmp *-16(%r13)
	.long  _r2jY_info - _r2jY_info_dsp
.data
.align 3
.align 0
_r2mi_closure:
	.quad	_r2mi_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2o9_str:
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
_s2mI_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mI_info)+16
	.quad	0
	.quad	4294967312
_s2mI_info:
Lc2oa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ob
Lc2oc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2o9_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ob:
	jmp *-16(%r13)
	.long  _s2mI_info - _s2mI_info_dsp
.text
.align 3
_s2mJ_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mJ_info)+16
	.quad	0
	.quad	30064771088
_s2mJ_info:
Lc2od:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oe
Lc2of:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2oh
Lc2og:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mI_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _r2jY_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_oneOf_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oh:
	movq $16,904(%r13)
Lc2oe:
	jmp *-16(%r13)
	.long  _s2mJ_info - _s2mJ_info_dsp
.text
.align 3
_s2mH_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mH_info)+40
	.quad	0
	.quad	12884901904
_s2mH_info:
Lc2om:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2on
Lc2oo:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2mi_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_opLetter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2on:
	jmp *-16(%r13)
	.long  _s2mH_info - _s2mH_info_dsp
.text
.align 3
_s2mE_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mE_info)+32
	.quad	0
	.quad	38654705680
_s2mE_info:
Lc2oB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oC
Lc2oD:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 1521(%rax),%rsi
	leaq _r2jY_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oC:
	jmp *-16(%r13)
	.long  _s2mE_info - _s2mE_info_dsp
.text
.align 3
_s2mC_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mC_info)+32
	.quad	0
	.quad	38654705680
_s2mC_info:
Lc2oI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oJ
Lc2oK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 577(%rax),%rsi
	leaq _r2jY_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oJ:
	jmp *-16(%r13)
	.long  _s2mC_info - _s2mC_info_dsp
.text
.align 3
_s2mF_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mF_info)+32
	.quad	0
	.quad	107374182416
_s2mF_info:
Lc2oL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oM
Lc2oN:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2oP
Lc2oO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mE_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2mC_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oP:
	movq $32,904(%r13)
Lc2oM:
	jmp *-16(%r13)
	.long  _s2mF_info - _s2mF_info_dsp
.text
.align 3
_s2mA_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mA_info)+32
	.quad	0
	.quad	141733920784
_s2mA_info:
Lc2oU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oV
Lc2oW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2jY_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2oV:
	jmp *-16(%r13)
	.long  _s2mA_info - _s2mA_info_dsp
.text
.align 3
_s2mG_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mG_info)+32
	.quad	0
	.quad	244813135888
_s2mG_info:
Lc2oX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oY
Lc2oZ:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2p1
Lc2p0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mF_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2mA_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2p1:
	movq $32,904(%r13)
Lc2oY:
	jmp *-16(%r13)
	.long  _s2mG_info - _s2mG_info_dsp
.const
.align 3
.align 0
_c2p6_str:
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s2mz_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mz_info)+16
	.quad	0
	.quad	4294967312
_s2mz_info:
Lc2p7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2p8
Lc2p9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2p6_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2p8:
	jmp *-16(%r13)
	.long  _s2mz_info - _s2mz_info_dsp
.text
.align 3
_r2mi_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_r2mi_info)+16
	.quad	0
	.quad	2194728288278
_r2mi_info:
Lc2pa:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pf
Lc2pg:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nV
Lc2nU:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2nW_info(%rip),%rax
	movq %rax,-24(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure(%rip),%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2nW
Lc2nX:
	jmp *(%rbx)
Lc2nV:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2nu_srt-(_c2nW_info)+16
	.quad	0
	.quad	1095216660512
_c2nW_info:
Lc2nW:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc2pe
Lc2pd:
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
	leaq _s2mJ_info(%rip),%rbx
	movq %rbx,-152(%r12)
	leaq -152(%r12),%rbx
	leaq _s2mH_info(%rip),%rcx
	movq %rcx,-136(%r12)
	leaq -136(%r12),%rcx
	leaq _s2mG_info(%rip),%rdx
	movq %rdx,-120(%r12)
	leaq -120(%r12),%rdx
	leaq _s2mz_info(%rip),%rsi
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
Lc2pe:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2pf:
	jmp *-16(%r13)
	.long  _r2mi_info - _r2mi_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_f95Def_closure
_F95ParserCommon_f95Def_closure:
	.quad	_stg_IND_STATIC_info
	.quad	_r2mi_closure
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
_s2mK_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mK_info)+0
	.quad	0
	.quad	12884901904
_s2mK_info:
Lc2qu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qv
Lc2qw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qv:
	jmp *-16(%r13)
	.long  _s2mK_info - _s2mK_info_dsp
.text
.align 3
_F95ParserCommon_lexer_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_F95ParserCommon_lexer_info)+0
	.quad	0
	.quad	9083855831062
.globl _F95ParserCommon_lexer_info
_F95ParserCommon_lexer_info:
Lc2qx:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qy
Lc2qz:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2qB
Lc2qA:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qp
Lc2qo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2mK_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _r2mi_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2qp:
	jmp *(%rbx)
Lc2qB:
	movq $16,904(%r13)
Lc2qy:
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
	.quad	_S2nu_srt-(_F95ParserCommon_integer_info)+96
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_integer_info
_F95ParserCommon_integer_info:
Lc2qT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qU
Lc2qV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qS
Lc2qR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_integer_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qS:
	jmp *(%rbx)
Lc2qU:
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
	.quad	_S2nu_srt-(_F95ParserCommon_identifier_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_identifier_info
_F95ParserCommon_identifier_info:
Lc2r8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2r9
Lc2ra:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2r7
Lc2r6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2r7:
	jmp *(%rbx)
Lc2r9:
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
	.quad	_S2nu_srt-(_F95ParserCommon_commaSep1_info)+96
	.quad	0
	.quad	38654705686
.globl _F95ParserCommon_commaSep1_info
_F95ParserCommon_commaSep1_info:
Lc2rn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ro
Lc2rp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rm
Lc2rl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rm:
	jmp *(%rbx)
Lc2ro:
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
	.quad	_S2nu_srt-(_F95ParserCommon_commaSep_info)+96
	.quad	0
	.quad	73014444054
.globl _F95ParserCommon_commaSep_info
_F95ParserCommon_commaSep_info:
Lc2rC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rD
Lc2rE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rB
Lc2rA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rB:
	jmp *(%rbx)
Lc2rD:
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
	.quad	_S2nu_srt-(_F95ParserCommon_comma_info)+96
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_comma_info
_F95ParserCommon_comma_info:
Lc2rR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rS
Lc2rT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rQ
Lc2rP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_comma_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rQ:
	jmp *(%rbx)
Lc2rS:
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
	.quad	_S2nu_srt-(_F95ParserCommon_charLiteral_info)+96
	.quad	0
	.quad	279172874262
.globl _F95ParserCommon_charLiteral_info
_F95ParserCommon_charLiteral_info:
Lc2s6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2s7
Lc2s8:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2s5
Lc2s4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2s5:
	jmp *(%rbx)
Lc2s7:
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
	.quad	_S2nu_srt-(_F95ParserCommon_natural_info)+96
	.quad	0
	.quad	554050781206
.globl _F95ParserCommon_natural_info
_F95ParserCommon_natural_info:
Lc2sl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sm
Lc2sn:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sk
Lc2sj:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_natural_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sk:
	jmp *(%rbx)
Lc2sm:
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
	.quad	_S2nu_srt-(_F95ParserCommon_parens_info)+96
	.quad	0
	.quad	1103806595094
.globl _F95ParserCommon_parens_info
_F95ParserCommon_parens_info:
Lc2sA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sB
Lc2sC:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sz
Lc2sy:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sz:
	jmp *(%rbx)
Lc2sB:
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
	.quad	_S2nu_srt-(_F95ParserCommon_reserved_info)+96
	.quad	0
	.quad	2203318222870
.globl _F95ParserCommon_reserved_info
_F95ParserCommon_reserved_info:
Lc2sP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sQ
Lc2sR:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sO
Lc2sN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reserved_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sO:
	jmp *(%rbx)
Lc2sQ:
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
	.quad	_S2nu_srt-(_F95ParserCommon_reservedOp_info)+96
	.quad	0
	.quad	4402341478422
.globl _F95ParserCommon_reservedOp_info
_F95ParserCommon_reservedOp_info:
Lc2t4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2t5
Lc2t6:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2t3
Lc2t2:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2t3:
	jmp *(%rbx)
Lc2t5:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reservedOp_info - _F95ParserCommon_reservedOp_info_dsp
.data
.align 3
.align 0
_r2mj_closure:
	.quad	_r2mj_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2mj_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_r2mj_info)+0
	.quad	0
	.quad	12884901910
_r2mj_info:
Lc2tj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tk
Lc2tl:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ti
Lc2th:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2ti:
	jmp *(%rbx)
Lc2tk:
	jmp *-16(%r13)
	.long  _r2mj_info - _r2mj_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparser_closure
_F95ParserCommon_runzuparser_closure:
	.quad	_F95ParserCommon_runzuparser_info
	.quad	0
.text
.align 3
_s2mQ_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mQ_info)+184
	.quad	1
	.quad	4294967313
_s2mQ_info:
Lc2tN:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tO
Lc2tP:
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
Lc2tO:
	jmp *-16(%r13)
	.long  _s2mQ_info - _s2mQ_info_dsp
.const
.align 3
.align 0
_c2tU_str:
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
_s2mP_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mP_info)+16
	.quad	0
	.quad	4294967312
_s2mP_info:
Lc2tV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tW
Lc2tX:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2tU_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2tW:
	jmp *-16(%r13)
	.long  _s2mP_info - _s2mP_info_dsp
.text
.align 3
_F95ParserCommon_runzuparser_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_F95ParserCommon_runzuparser_info)+16
	.quad	8589934607
	.quad	0
	.quad	567453557343649807
.globl _F95ParserCommon_runzuparser_info
_F95ParserCommon_runzuparser_info:
Lc2u5:
	leaq -8(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uh
Lc2ui:
	leaq _c2tF_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	leaq _r2mj_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	addq $-8,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2nu_srt-(_c2tF_info)+16
	.quad	0
	.quad	63050399078154272
_c2tF_info:
Lc2tF:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc2u3
Lc2u4:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2ug
Lc2uf:
	movq 7(%rbx),%rax
	leaq _s2mQ_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2mP_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2u6_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2u3:
	movq 6(%rbx),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp _stg_ap_0_fast
.text
.align 3
	.quad	_S2nu_srt-(_c2u6_info)+200
	.quad	0
	.quad	4294967328
_c2u6_info:
Lc2u6:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2ug:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2uh:
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
_s2mU_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mU_info)+0
	.quad	0
	.quad	12884901904
_s2mU_info:
Lc2uR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uS
Lc2uT:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uS:
	jmp *-16(%r13)
	.long  _s2mU_info - _s2mU_info_dsp
.text
.align 3
_s2n1_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2n1_info)+184
	.quad	1
	.quad	279172874257
_s2n1_info:
Lc2v7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2v8
Lc2v9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	leaq _base_SystemziIO_print_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2v8:
	jmp *-16(%r13)
	.long  _s2n1_info - _s2n1_info_dsp
.const
.align 3
.align 0
_c2vi_str:
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
_s2mZ_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2mZ_info)+16
	.quad	0
	.quad	4294967312
_s2mZ_info:
Lc2vj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vk
Lc2vl:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vi_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vk:
	jmp *-16(%r13)
	.long  _s2mZ_info - _s2mZ_info_dsp
.text
.align 3
_s2n0_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2n0_info)+16
	.quad	0
	.quad	1152921508901814288
_s2n0_info:
Lc2vm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vn
Lc2vo:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vq
Lc2vp:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mZ_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStr_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2vq:
	movq $16,904(%r13)
Lc2vn:
	jmp *-16(%r13)
	.long  _s2n0_info - _s2n0_info_dsp
.text
.align 3
_s2n4_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2n4_info:
Lc2vG:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vH
Lc2vI:
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
Lc2vH:
	jmp *-16(%r13)
	.long  _s2n4_info - _s2n4_info_dsp
.text
.align 3
_s2n7_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2n7_info)+192
	.quad	2
	.quad	4294967315
_s2n7_info:
Lc2vJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vK
Lc2vL:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2vN
Lc2vM:
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
	leaq _s2n4_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rcx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2vN:
	movq $56,904(%r13)
Lc2vK:
	jmp *-16(%r13)
	.long  _s2n7_info - _s2n7_info_dsp
.const
.align 3
.align 0
_c2vS_str:
	.byte	32
	.byte	32
	.byte	32
	.byte	32
	.byte	0
.text
.align 3
_s2n3_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2n3_info)+16
	.quad	0
	.quad	4294967312
_s2n3_info:
Lc2vT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vU
Lc2vV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vS_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vU:
	jmp *-16(%r13)
	.long  _s2n3_info - _s2n3_info_dsp
.text
.align 3
_s2n8_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2n8_info)+16
	.quad	2
	.quad	18014402804449299
_s2n8_info:
Lc2vW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vX
Lc2vY:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2w0
Lc2vZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2n7_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s2n3_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2w0:
	movq $48,904(%r13)
Lc2vX:
	jmp *-16(%r13)
	.long  _s2n8_info - _s2n8_info_dsp
.text
.align 3
_s2n9_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2n9_info)+16
	.quad	8589934607
	.quad	2
	.quad	8818048074686398476
_s2n9_info:
Lc2w8:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wf
Lc2wg:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2uZ_info(%rip),%rcx
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
	.quad	_S2nu_srt-(_c2uZ_info)+16
	.quad	1
	.quad	8673932886610542624
_c2uZ_info:
Lc2uZ:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2w6
Lc2w7:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2we
Lc2wd:
	movq 7(%rbx),%rax
	leaq _s2n1_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2n0_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	movq %rax,8(%rbp)
	addq $-8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2w6:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2wb
Lc2wa:
	movq 6(%rbx),%rbx
	leaq _s2n8_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2wb:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2we:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2wf:
	jmp *-8(%r13)
	.long  _s2n9_info - _s2n9_info_dsp
.const_data
.align 3
.align 0
_u2wm_srtd:
	.quad	_S2nu_srt
	.quad	34
	.quad	16802381831
.text
.align 3
_F95ParserCommon_runzuparserzuprint_info_dsp:
.text
.align 3
	.quad	_u2wm_srtd-(_F95ParserCommon_runzuparserzuprint_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_runzuparserzuprint_info
_F95ParserCommon_runzuparserzuprint_info:
Lc2wh:
Lc2wj:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wl
Lc2wk:
	leaq _s2mU_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -32(%r12),%rax
	leaq _s2n9_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,-8(%r12)
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2wl:
	movq $40,904(%r13)
Lc2wi:
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
	.quad	_S2nu_srt-(_F95ParserCommon_semi_info)+96
	.quad	0
	.quad	18014402804449302
.globl _F95ParserCommon_semi_info
_F95ParserCommon_semi_info:
Lc2xq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xr
Lc2xs:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xp
Lc2xo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_semi_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xp:
	jmp *(%rbx)
Lc2xr:
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
	.quad	_S2nu_srt-(_F95ParserCommon_stringLiteral_info)+96
	.quad	0
	.quad	36028801313931286
.globl _F95ParserCommon_stringLiteral_info
_F95ParserCommon_stringLiteral_info:
Lc2xF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xG
Lc2xH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xE
Lc2xD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xE:
	jmp *(%rbx)
Lc2xG:
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
	.quad	_S2nu_srt-(_F95ParserCommon_symbol_info)+96
	.quad	0
	.quad	72057598332895254
.globl _F95ParserCommon_symbol_info
_F95ParserCommon_symbol_info:
Lc2xU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xV
Lc2xW:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xT
Lc2xS:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xT:
	jmp *(%rbx)
Lc2xV:
	jmp *-16(%r13)
	.long  _F95ParserCommon_symbol_info - _F95ParserCommon_symbol_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_arglistzuparserzuwrapper_closure
_F95ParserCommon_arglistzuparserzuwrapper_closure:
	.quad	_F95ParserCommon_arglistzuparserzuwrapper_info
	.quad	0
.text
.align 3
_s2nk_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2nk_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2nk_info:
Lc2yc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yd
Lc2ye:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2yd:
	jmp *-8(%r13)
	.long  _s2nk_info - _s2nk_info_dsp
.text
.align 3
_s2nf_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2nf_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2nf_info:
Lc2yw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yx
Lc2yy:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2yx:
	jmp *-8(%r13)
	.long  _s2nf_info - _s2nf_info_dsp
.text
.align 3
_s2ng_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2ng_info)+296
	.quad	1
	.quad	4294967313
_s2ng_info:
Lc2yz:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yA
Lc2yB:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2yD
Lc2yC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2nf_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2yD:
	movq $16,904(%r13)
Lc2yA:
	jmp *-16(%r13)
	.long  _s2ng_info - _s2ng_info_dsp
.const
.align 3
.align 0
_c2yM_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2nc_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2nc_info)+304
	.quad	0
	.quad	4294967312
_s2nc_info:
Lc2yN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yO
Lc2yP:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2yM_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2yO:
	jmp *-16(%r13)
	.long  _s2nc_info - _s2nc_info_dsp
.text
.align 3
_s2nd_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2nd_info)+304
	.quad	0
	.quad	12884901904
_s2nd_info:
Lc2yQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yR
Lc2yS:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2yU
Lc2yT:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2nc_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yU:
	movq $16,904(%r13)
Lc2yR:
	jmp *-16(%r13)
	.long  _s2nd_info - _s2nd_info_dsp
.text
.align 3
_s2nh_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2nh_info)+296
	.quad	1
	.quad	30064771089
_s2nh_info:
Lc2yV:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yW
Lc2yX:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2yZ
Lc2yY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ng_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2nd_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2yZ:
	movq $40,904(%r13)
Lc2yW:
	jmp *-16(%r13)
	.long  _s2nh_info - _s2nh_info_dsp
.text
.align 3
_s2nb_info_dsp:
.text
.align 3
	.quad	_S2nu_srt-(_s2nb_info)+320
	.quad	1
	.quad	4294967313
_s2nb_info:
Lc2z4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z5
Lc2z6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2z5:
	jmp *-16(%r13)
	.long  _s2nb_info - _s2nb_info_dsp
.const_data
.align 3
.align 0
_u2zh_srtd:
	.quad	_S2nu_srt+64
	.quad	33
	.quad	8053063681
.text
.align 3
_s2ni_info_dsp:
.text
.align 3
	.quad	_u2zh_srtd-(_s2ni_info)+0
	.quad	1
	.quad	-4294967279
_s2ni_info:
Lc2z7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z8
Lc2z9:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2zb
Lc2za:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2nh_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2nb_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2zb:
	movq $48,904(%r13)
Lc2z8:
	jmp *-16(%r13)
	.long  _s2ni_info - _s2ni_info_dsp
.const_data
.align 3
.align 0
_u2zi_srtd:
	.quad	_S2nu_srt+64
	.quad	34
	.quad	16642998273
.text
.align 3
_F95ParserCommon_arglistzuparserzuwrapper_info_dsp:
.text
.align 3
	.quad	_u2zi_srtd-(_F95ParserCommon_arglistzuparserzuwrapper_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_arglistzuparserzuwrapper_info
_F95ParserCommon_arglistzuparserzuwrapper_info:
Lc2zc:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zd
Lc2ze:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2zg
Lc2zf:
	leaq _s2nk_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -31(%r12),%rax
	leaq _s2ni_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2zg:
	movq $40,904(%r13)
Lc2zd:
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
	.quad	_S2nu_srt-(_F95ParserCommon_whiteSpace_info)+96
	.quad	0
	.quad	4611686022722355222
.globl _F95ParserCommon_whiteSpace_info
_F95ParserCommon_whiteSpace_info:
Lc2Ae:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Af
Lc2Ag:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ad
Lc2Ac:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ad:
	jmp *(%rbx)
Lc2Af:
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
	.quad	_S2nu_srt-(_F95ParserCommon_word_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_word_info
_F95ParserCommon_word_info:
Lc2At:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Au
Lc2Av:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2As
Lc2Ar:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2As:
	jmp *(%rbx)
Lc2Au:
	jmp *-16(%r13)
	.long  _F95ParserCommon_word_info - _F95ParserCommon_word_info_dsp
.const_data
.align 3
.align 0
_S2nu_srt:
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_oneOf_closure
	.quad	_r2jY_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_opLetter_closure
	.quad	_r2mi_closure
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
	.quad	_r2mj_closure
	.quad	_base_SystemziIO_print_closure
	.quad	_base_SystemziIO_putStr_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_base_SystemziIO_putStrLn_closure
	.quad	_F95ParserCommon_runzuparserzuprint_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_semi_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_symbol_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95ParserCommon_arglistzuparserzuwrapper_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

