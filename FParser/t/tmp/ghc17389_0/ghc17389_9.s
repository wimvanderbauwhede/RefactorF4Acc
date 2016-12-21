.data
.align 3
.align 0
.globl ___stginit_F95ParserCommon
___stginit_F95ParserCommon:
.data
.align 3
.align 0
_r2jT_closure:
	.quad	_r2jT_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2jT_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_r2jT_info)+0
	.quad	0
	.quad	12884901910
_r2jT_info:
Lc2nq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nr
Lc2ns:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2np
Lc2no:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2np:
	jmp *(%rbx)
Lc2nr:
	jmp *-16(%r13)
	.long  _r2jT_info - _r2jT_info_dsp
.data
.align 3
.align 0
_r2mf_closure:
	.quad	_r2mf_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2o8_str:
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
_s2mF_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mF_info)+16
	.quad	0
	.quad	4294967312
_s2mF_info:
Lc2o9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oa
Lc2ob:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2o8_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2oa:
	jmp *-16(%r13)
	.long  _s2mF_info - _s2mF_info_dsp
.text
.align 3
_s2mG_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mG_info)+16
	.quad	0
	.quad	30064771088
_s2mG_info:
Lc2oc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2od
Lc2oe:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2og
Lc2of:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mF_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _r2jT_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_oneOf_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2og:
	movq $16,904(%r13)
Lc2od:
	jmp *-16(%r13)
	.long  _s2mG_info - _s2mG_info_dsp
.text
.align 3
_s2mE_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mE_info)+40
	.quad	0
	.quad	12884901904
_s2mE_info:
Lc2ol:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2om
Lc2on:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2mf_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_opLetter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2om:
	jmp *-16(%r13)
	.long  _s2mE_info - _s2mE_info_dsp
.text
.align 3
_s2mB_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mB_info)+32
	.quad	0
	.quad	38654705680
_s2mB_info:
Lc2oA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oB
Lc2oC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 1521(%rax),%rsi
	leaq _r2jT_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oB:
	jmp *-16(%r13)
	.long  _s2mB_info - _s2mB_info_dsp
.text
.align 3
_s2mz_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mz_info)+32
	.quad	0
	.quad	38654705680
_s2mz_info:
Lc2oH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oI
Lc2oJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 577(%rax),%rsi
	leaq _r2jT_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oI:
	jmp *-16(%r13)
	.long  _s2mz_info - _s2mz_info_dsp
.text
.align 3
_s2mC_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mC_info)+32
	.quad	0
	.quad	107374182416
_s2mC_info:
Lc2oK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oL
Lc2oM:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2oO
Lc2oN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mB_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2mz_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oO:
	movq $32,904(%r13)
Lc2oL:
	jmp *-16(%r13)
	.long  _s2mC_info - _s2mC_info_dsp
.text
.align 3
_s2mx_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mx_info)+32
	.quad	0
	.quad	141733920784
_s2mx_info:
Lc2oT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oU
Lc2oV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2jT_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2oU:
	jmp *-16(%r13)
	.long  _s2mx_info - _s2mx_info_dsp
.text
.align 3
_s2mD_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mD_info)+32
	.quad	0
	.quad	244813135888
_s2mD_info:
Lc2oW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oX
Lc2oY:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2p0
Lc2oZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mC_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2mx_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2p0:
	movq $32,904(%r13)
Lc2oX:
	jmp *-16(%r13)
	.long  _s2mD_info - _s2mD_info_dsp
.const
.align 3
.align 0
_c2p5_str:
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s2mw_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mw_info)+16
	.quad	0
	.quad	4294967312
_s2mw_info:
Lc2p6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2p7
Lc2p8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2p5_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2p7:
	jmp *-16(%r13)
	.long  _s2mw_info - _s2mw_info_dsp
.text
.align 3
_r2mf_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_r2mf_info)+16
	.quad	0
	.quad	2194728288278
_r2mf_info:
Lc2p9:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pe
Lc2pf:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nU
Lc2nT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2nV_info(%rip),%rax
	movq %rax,-24(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure(%rip),%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2nV
Lc2nW:
	jmp *(%rbx)
Lc2nU:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2nt_srt-(_c2nV_info)+16
	.quad	0
	.quad	1095216660512
_c2nV_info:
Lc2nV:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc2pd
Lc2pc:
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
	leaq _s2mG_info(%rip),%rbx
	movq %rbx,-152(%r12)
	leaq -152(%r12),%rbx
	leaq _s2mE_info(%rip),%rcx
	movq %rcx,-136(%r12)
	leaq -136(%r12),%rcx
	leaq _s2mD_info(%rip),%rdx
	movq %rdx,-120(%r12)
	leaq -120(%r12),%rdx
	leaq _s2mw_info(%rip),%rsi
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
Lc2pd:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2pe:
	jmp *-16(%r13)
	.long  _r2mf_info - _r2mf_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_f95Def_closure
_F95ParserCommon_f95Def_closure:
	.quad	_stg_IND_STATIC_info
	.quad	_r2mf_closure
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
_s2mH_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mH_info)+0
	.quad	0
	.quad	12884901904
_s2mH_info:
Lc2qt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qu
Lc2qv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qu:
	jmp *-16(%r13)
	.long  _s2mH_info - _s2mH_info_dsp
.text
.align 3
_F95ParserCommon_lexer_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_F95ParserCommon_lexer_info)+0
	.quad	0
	.quad	9083855831062
.globl _F95ParserCommon_lexer_info
_F95ParserCommon_lexer_info:
Lc2qw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qx
Lc2qy:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2qA
Lc2qz:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qo
Lc2qn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2mH_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _r2mf_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2qo:
	jmp *(%rbx)
Lc2qA:
	movq $16,904(%r13)
Lc2qx:
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
	.quad	_S2nt_srt-(_F95ParserCommon_integer_info)+96
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_integer_info
_F95ParserCommon_integer_info:
Lc2qS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qT
Lc2qU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2qR
Lc2qQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_integer_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qR:
	jmp *(%rbx)
Lc2qT:
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
	.quad	_S2nt_srt-(_F95ParserCommon_identifier_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_identifier_info
_F95ParserCommon_identifier_info:
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
	je Lc2r6
Lc2r5:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2r6:
	jmp *(%rbx)
Lc2r8:
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
	.quad	_S2nt_srt-(_F95ParserCommon_commaSep1_info)+96
	.quad	0
	.quad	38654705686
.globl _F95ParserCommon_commaSep1_info
_F95ParserCommon_commaSep1_info:
Lc2rm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rn
Lc2ro:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rl
Lc2rk:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rl:
	jmp *(%rbx)
Lc2rn:
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
	.quad	_S2nt_srt-(_F95ParserCommon_commaSep_info)+96
	.quad	0
	.quad	73014444054
.globl _F95ParserCommon_commaSep_info
_F95ParserCommon_commaSep_info:
Lc2rB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rC
Lc2rD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rA
Lc2rz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rA:
	jmp *(%rbx)
Lc2rC:
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
	.quad	_S2nt_srt-(_F95ParserCommon_comma_info)+96
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_comma_info
_F95ParserCommon_comma_info:
Lc2rQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rR
Lc2rS:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rP
Lc2rO:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_comma_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rP:
	jmp *(%rbx)
Lc2rR:
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
	.quad	_S2nt_srt-(_F95ParserCommon_charLiteral_info)+96
	.quad	0
	.quad	279172874262
.globl _F95ParserCommon_charLiteral_info
_F95ParserCommon_charLiteral_info:
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
	je Lc2s4
Lc2s3:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2s4:
	jmp *(%rbx)
Lc2s6:
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
	.quad	_S2nt_srt-(_F95ParserCommon_natural_info)+96
	.quad	0
	.quad	554050781206
.globl _F95ParserCommon_natural_info
_F95ParserCommon_natural_info:
Lc2sk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sl
Lc2sm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sj
Lc2si:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_natural_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sj:
	jmp *(%rbx)
Lc2sl:
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
	.quad	_S2nt_srt-(_F95ParserCommon_parens_info)+96
	.quad	0
	.quad	1103806595094
.globl _F95ParserCommon_parens_info
_F95ParserCommon_parens_info:
Lc2sz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sA
Lc2sB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sy
Lc2sx:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sy:
	jmp *(%rbx)
Lc2sA:
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
	.quad	_S2nt_srt-(_F95ParserCommon_reserved_info)+96
	.quad	0
	.quad	2203318222870
.globl _F95ParserCommon_reserved_info
_F95ParserCommon_reserved_info:
Lc2sO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sP
Lc2sQ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sN
Lc2sM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reserved_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sN:
	jmp *(%rbx)
Lc2sP:
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
	.quad	_S2nt_srt-(_F95ParserCommon_reservedOp_info)+96
	.quad	0
	.quad	4402341478422
.globl _F95ParserCommon_reservedOp_info
_F95ParserCommon_reservedOp_info:
Lc2t3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2t4
Lc2t5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2t2
Lc2t1:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2t2:
	jmp *(%rbx)
Lc2t4:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reservedOp_info - _F95ParserCommon_reservedOp_info_dsp
.data
.align 3
.align 0
_r2mg_closure:
	.quad	_r2mg_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2mg_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_r2mg_info)+0
	.quad	0
	.quad	12884901910
_r2mg_info:
Lc2ti:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tj
Lc2tk:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2th
Lc2tg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2th:
	jmp *(%rbx)
Lc2tj:
	jmp *-16(%r13)
	.long  _r2mg_info - _r2mg_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparser_closure
_F95ParserCommon_runzuparser_closure:
	.quad	_F95ParserCommon_runzuparser_info
	.quad	0
.text
.align 3
_s2mN_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mN_info)+184
	.quad	1
	.quad	4294967313
_s2mN_info:
Lc2tM:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tN
Lc2tO:
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
Lc2tN:
	jmp *-16(%r13)
	.long  _s2mN_info - _s2mN_info_dsp
.const
.align 3
.align 0
_c2tT_str:
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
_s2mM_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mM_info)+16
	.quad	0
	.quad	4294967312
_s2mM_info:
Lc2tU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tV
Lc2tW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2tT_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2tV:
	jmp *-16(%r13)
	.long  _s2mM_info - _s2mM_info_dsp
.text
.align 3
_F95ParserCommon_runzuparser_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_F95ParserCommon_runzuparser_info)+16
	.quad	8589934607
	.quad	0
	.quad	567453557343649807
.globl _F95ParserCommon_runzuparser_info
_F95ParserCommon_runzuparser_info:
Lc2u4:
	leaq -8(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ug
Lc2uh:
	leaq _c2tE_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	leaq _r2mg_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	addq $-8,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2nt_srt-(_c2tE_info)+16
	.quad	0
	.quad	63050399078154272
_c2tE_info:
Lc2tE:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc2u2
Lc2u3:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2uf
Lc2ue:
	movq 7(%rbx),%rax
	leaq _s2mN_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2mM_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2u5_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2u2:
	movq 6(%rbx),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp _stg_ap_0_fast
.text
.align 3
	.quad	_S2nt_srt-(_c2u5_info)+200
	.quad	0
	.quad	4294967328
_c2u5_info:
Lc2u5:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2uf:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2ug:
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
_s2mR_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mR_info)+0
	.quad	0
	.quad	12884901904
_s2mR_info:
Lc2uQ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uR
Lc2uS:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uR:
	jmp *-16(%r13)
	.long  _s2mR_info - _s2mR_info_dsp
.text
.align 3
_s2mY_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mY_info)+184
	.quad	1
	.quad	279172874257
_s2mY_info:
Lc2v6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2v7
Lc2v8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	leaq _base_SystemziIO_print_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2v7:
	jmp *-16(%r13)
	.long  _s2mY_info - _s2mY_info_dsp
.const
.align 3
.align 0
_c2vh_str:
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
_s2mW_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mW_info)+16
	.quad	0
	.quad	4294967312
_s2mW_info:
Lc2vi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vj
Lc2vk:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vh_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vj:
	jmp *-16(%r13)
	.long  _s2mW_info - _s2mW_info_dsp
.text
.align 3
_s2mX_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2mX_info)+16
	.quad	0
	.quad	1152921508901814288
_s2mX_info:
Lc2vl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vm
Lc2vn:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vp
Lc2vo:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mW_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStr_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2vp:
	movq $16,904(%r13)
Lc2vm:
	jmp *-16(%r13)
	.long  _s2mX_info - _s2mX_info_dsp
.text
.align 3
_s2n1_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2n1_info:
Lc2vF:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vG
Lc2vH:
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
Lc2vG:
	jmp *-16(%r13)
	.long  _s2n1_info - _s2n1_info_dsp
.text
.align 3
_s2n4_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2n4_info)+192
	.quad	2
	.quad	4294967315
_s2n4_info:
Lc2vI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vJ
Lc2vK:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2vM
Lc2vL:
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
	leaq _s2n1_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rcx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2vM:
	movq $56,904(%r13)
Lc2vJ:
	jmp *-16(%r13)
	.long  _s2n4_info - _s2n4_info_dsp
.const
.align 3
.align 0
_c2vR_str:
	.byte	32
	.byte	32
	.byte	32
	.byte	32
	.byte	0
.text
.align 3
_s2n0_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2n0_info)+16
	.quad	0
	.quad	4294967312
_s2n0_info:
Lc2vS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vT
Lc2vU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vT:
	jmp *-16(%r13)
	.long  _s2n0_info - _s2n0_info_dsp
.text
.align 3
_s2n5_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2n5_info)+16
	.quad	2
	.quad	18014402804449299
_s2n5_info:
Lc2vV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vW
Lc2vX:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2vZ
Lc2vY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2n4_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s2n0_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2vZ:
	movq $48,904(%r13)
Lc2vW:
	jmp *-16(%r13)
	.long  _s2n5_info - _s2n5_info_dsp
.text
.align 3
_s2n6_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2n6_info)+16
	.quad	8589934607
	.quad	2
	.quad	8818048074686398476
_s2n6_info:
Lc2w7:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2we
Lc2wf:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2uY_info(%rip),%rcx
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
	.quad	_S2nt_srt-(_c2uY_info)+16
	.quad	1
	.quad	8673932886610542624
_c2uY_info:
Lc2uY:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2w5
Lc2w6:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wd
Lc2wc:
	movq 7(%rbx),%rax
	leaq _s2mY_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2mX_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	movq %rax,8(%rbp)
	addq $-8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2w5:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2wa
Lc2w9:
	movq 6(%rbx),%rbx
	leaq _s2n5_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2wa:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2wd:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2we:
	jmp *-8(%r13)
	.long  _s2n6_info - _s2n6_info_dsp
.const_data
.align 3
.align 0
_u2wl_srtd:
	.quad	_S2nt_srt
	.quad	34
	.quad	16802381831
.text
.align 3
_F95ParserCommon_runzuparserzuprint_info_dsp:
.text
.align 3
	.quad	_u2wl_srtd-(_F95ParserCommon_runzuparserzuprint_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_runzuparserzuprint_info
_F95ParserCommon_runzuparserzuprint_info:
Lc2wg:
Lc2wi:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wk
Lc2wj:
	leaq _s2mR_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -32(%r12),%rax
	leaq _s2n6_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,-8(%r12)
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2wk:
	movq $40,904(%r13)
Lc2wh:
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
	.quad	_S2nt_srt-(_F95ParserCommon_semi_info)+96
	.quad	0
	.quad	18014402804449302
.globl _F95ParserCommon_semi_info
_F95ParserCommon_semi_info:
Lc2xp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xq
Lc2xr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xo
Lc2xn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_semi_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xo:
	jmp *(%rbx)
Lc2xq:
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
	.quad	_S2nt_srt-(_F95ParserCommon_stringLiteral_info)+96
	.quad	0
	.quad	36028801313931286
.globl _F95ParserCommon_stringLiteral_info
_F95ParserCommon_stringLiteral_info:
Lc2xE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xF
Lc2xG:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xD
Lc2xC:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xD:
	jmp *(%rbx)
Lc2xF:
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
	.quad	_S2nt_srt-(_F95ParserCommon_symbol_info)+96
	.quad	0
	.quad	72057598332895254
.globl _F95ParserCommon_symbol_info
_F95ParserCommon_symbol_info:
Lc2xT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xU
Lc2xV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xS
Lc2xR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xS:
	jmp *(%rbx)
Lc2xU:
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
_s2nj_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2nj_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2nj_info:
Lc2yb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yc
Lc2yd:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2yc:
	jmp *-8(%r13)
	.long  _s2nj_info - _s2nj_info_dsp
.text
.align 3
_s2ne_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2ne_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2ne_info:
Lc2yv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yw
Lc2yx:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2yw:
	jmp *-8(%r13)
	.long  _s2ne_info - _s2ne_info_dsp
.text
.align 3
_s2nf_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2nf_info)+296
	.quad	1
	.quad	4294967313
_s2nf_info:
Lc2yy:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yz
Lc2yA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2yC
Lc2yB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ne_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2yC:
	movq $16,904(%r13)
Lc2yz:
	jmp *-16(%r13)
	.long  _s2nf_info - _s2nf_info_dsp
.const
.align 3
.align 0
_c2yL_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2nb_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2nb_info)+304
	.quad	0
	.quad	4294967312
_s2nb_info:
Lc2yM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yN
Lc2yO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2yL_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2yN:
	jmp *-16(%r13)
	.long  _s2nb_info - _s2nb_info_dsp
.text
.align 3
_s2nc_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2nc_info)+304
	.quad	0
	.quad	12884901904
_s2nc_info:
Lc2yP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yQ
Lc2yR:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2yT
Lc2yS:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2nb_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yT:
	movq $16,904(%r13)
Lc2yQ:
	jmp *-16(%r13)
	.long  _s2nc_info - _s2nc_info_dsp
.text
.align 3
_s2ng_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2ng_info)+296
	.quad	1
	.quad	30064771089
_s2ng_info:
Lc2yU:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yV
Lc2yW:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2yY
Lc2yX:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2nf_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2nc_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2yY:
	movq $40,904(%r13)
Lc2yV:
	jmp *-16(%r13)
	.long  _s2ng_info - _s2ng_info_dsp
.text
.align 3
_s2n9_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2n9_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2n9_info:
Lc2z8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z9
Lc2za:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2z9:
	jmp *-8(%r13)
	.long  _s2n9_info - _s2n9_info_dsp
.text
.align 3
_s2na_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2na_info)+296
	.quad	1
	.quad	4294967313
_s2na_info:
Lc2zb:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zc
Lc2zd:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2zf
Lc2ze:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2n9_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2zf:
	movq $16,904(%r13)
Lc2zc:
	jmp *-16(%r13)
	.long  _s2na_info - _s2na_info_dsp
.text
.align 3
_s2nh_info_dsp:
.text
.align 3
	.quad	_S2nt_srt-(_s2nh_info)+64
	.quad	1
	.quad	-2305843004918726639
_s2nh_info:
Lc2zg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zh
Lc2zi:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2zk
Lc2zj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ng_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2na_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2zk:
	movq $48,904(%r13)
Lc2zh:
	jmp *-16(%r13)
	.long  _s2nh_info - _s2nh_info_dsp
.const_data
.align 3
.align 0
_u2zq_srtd:
	.quad	_S2nt_srt+64
	.quad	33
	.quad	8053063681
.text
.align 3
_F95ParserCommon_arglistzuparserzuwrapper_info_dsp:
.text
.align 3
	.quad	_u2zq_srtd-(_F95ParserCommon_arglistzuparserzuwrapper_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_arglistzuparserzuwrapper_info
_F95ParserCommon_arglistzuparserzuwrapper_info:
Lc2zl:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zm
Lc2zn:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2zp
Lc2zo:
	leaq _s2nj_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -31(%r12),%rax
	leaq _s2nh_info(%rip),%rbx
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
Lc2zp:
	movq $40,904(%r13)
Lc2zm:
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
	.quad	_S2nt_srt-(_F95ParserCommon_whiteSpace_info)+96
	.quad	0
	.quad	2305843013508661270
.globl _F95ParserCommon_whiteSpace_info
_F95ParserCommon_whiteSpace_info:
Lc2Ar:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2As
Lc2At:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Aq
Lc2Ap:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Aq:
	jmp *(%rbx)
Lc2As:
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
	.quad	_S2nt_srt-(_F95ParserCommon_word_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_word_info
_F95ParserCommon_word_info:
Lc2AG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2AH
Lc2AI:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2AF
Lc2AE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2AF:
	jmp *(%rbx)
Lc2AH:
	jmp *-16(%r13)
	.long  _F95ParserCommon_word_info - _F95ParserCommon_word_info_dsp
.const_data
.align 3
.align 0
_S2nt_srt:
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_oneOf_closure
	.quad	_r2jT_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_opLetter_closure
	.quad	_r2mf_closure
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
	.quad	_r2mg_closure
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
	.quad	_F95ParserCommon_arglistzuparserzuwrapper_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

