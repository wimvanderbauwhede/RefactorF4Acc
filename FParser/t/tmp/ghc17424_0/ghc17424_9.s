.data
.align 3
.align 0
.globl ___stginit_F95ParserCommon
___stginit_F95ParserCommon:
.data
.align 3
.align 0
_r2kb_closure:
	.quad	_r2kb_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2kb_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_r2kb_info)+0
	.quad	0
	.quad	12884901910
_r2kb_info:
Lc2nJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nK
Lc2nL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2nI
Lc2nH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2nI:
	jmp *(%rbx)
Lc2nK:
	jmp *-16(%r13)
	.long  _r2kb_info - _r2kb_info_dsp
.data
.align 3
.align 0
_r2mx_closure:
	.quad	_r2mx_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2or_str:
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
_s2mX_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mX_info)+16
	.quad	0
	.quad	4294967312
_s2mX_info:
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
	.long  _s2mX_info - _s2mX_info_dsp
.text
.align 3
_s2mY_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mY_info)+16
	.quad	0
	.quad	30064771088
_s2mY_info:
Lc2ov:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ow
Lc2ox:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2oz
Lc2oy:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mX_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _r2kb_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_oneOf_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oz:
	movq $16,904(%r13)
Lc2ow:
	jmp *-16(%r13)
	.long  _s2mY_info - _s2mY_info_dsp
.text
.align 3
_s2mW_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mW_info)+40
	.quad	0
	.quad	12884901904
_s2mW_info:
Lc2oE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oF
Lc2oG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2mx_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_opLetter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2oF:
	jmp *-16(%r13)
	.long  _s2mW_info - _s2mW_info_dsp
.text
.align 3
_s2mT_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mT_info)+32
	.quad	0
	.quad	38654705680
_s2mT_info:
Lc2oT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oU
Lc2oV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 1521(%rax),%rsi
	leaq _r2kb_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oU:
	jmp *-16(%r13)
	.long  _s2mT_info - _s2mT_info_dsp
.text
.align 3
_s2mR_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mR_info)+32
	.quad	0
	.quad	38654705680
_s2mR_info:
Lc2p0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2p1
Lc2p2:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 577(%rax),%rsi
	leaq _r2kb_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2p1:
	jmp *-16(%r13)
	.long  _s2mR_info - _s2mR_info_dsp
.text
.align 3
_s2mU_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mU_info)+32
	.quad	0
	.quad	107374182416
_s2mU_info:
Lc2p3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2p4
Lc2p5:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2p7
Lc2p6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mT_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2mR_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2p7:
	movq $32,904(%r13)
Lc2p4:
	jmp *-16(%r13)
	.long  _s2mU_info - _s2mU_info_dsp
.text
.align 3
_s2mP_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mP_info)+32
	.quad	0
	.quad	141733920784
_s2mP_info:
Lc2pc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pd
Lc2pe:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2kb_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2pd:
	jmp *-16(%r13)
	.long  _s2mP_info - _s2mP_info_dsp
.text
.align 3
_s2mV_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mV_info)+32
	.quad	0
	.quad	244813135888
_s2mV_info:
Lc2pf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pg
Lc2ph:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2pj
Lc2pi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2mU_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2mP_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2pj:
	movq $32,904(%r13)
Lc2pg:
	jmp *-16(%r13)
	.long  _s2mV_info - _s2mV_info_dsp
.const
.align 3
.align 0
_c2po_str:
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s2mO_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mO_info)+16
	.quad	0
	.quad	4294967312
_s2mO_info:
Lc2pp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pq
Lc2pr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2po_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2pq:
	jmp *-16(%r13)
	.long  _s2mO_info - _s2mO_info_dsp
.text
.align 3
_r2mx_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_r2mx_info)+16
	.quad	0
	.quad	2194728288278
_r2mx_info:
Lc2ps:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2px
Lc2py:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2od
Lc2oc:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2oe_info(%rip),%rax
	movq %rax,-24(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure(%rip),%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2oe
Lc2of:
	jmp *(%rbx)
Lc2od:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2nM_srt-(_c2oe_info)+16
	.quad	0
	.quad	1095216660512
_c2oe_info:
Lc2oe:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc2pw
Lc2pv:
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
	leaq _s2mY_info(%rip),%rbx
	movq %rbx,-152(%r12)
	leaq -152(%r12),%rbx
	leaq _s2mW_info(%rip),%rcx
	movq %rcx,-136(%r12)
	leaq -136(%r12),%rcx
	leaq _s2mV_info(%rip),%rdx
	movq %rdx,-120(%r12)
	leaq -120(%r12),%rdx
	leaq _s2mO_info(%rip),%rsi
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
Lc2pw:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2px:
	jmp *-16(%r13)
	.long  _r2mx_info - _r2mx_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_f95Def_closure
_F95ParserCommon_f95Def_closure:
	.quad	_stg_IND_STATIC_info
	.quad	_r2mx_closure
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
_s2mZ_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2mZ_info)+0
	.quad	0
	.quad	12884901904
_s2mZ_info:
Lc2qM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qN
Lc2qO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2qN:
	jmp *-16(%r13)
	.long  _s2mZ_info - _s2mZ_info_dsp
.text
.align 3
_F95ParserCommon_lexer_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_F95ParserCommon_lexer_info)+0
	.quad	0
	.quad	9083855831062
.globl _F95ParserCommon_lexer_info
_F95ParserCommon_lexer_info:
Lc2qP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qQ
Lc2qR:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2qT
Lc2qS:
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
	leaq _s2mZ_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _r2mx_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2qH:
	jmp *(%rbx)
Lc2qT:
	movq $16,904(%r13)
Lc2qQ:
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
	.quad	_S2nM_srt-(_F95ParserCommon_integer_info)+96
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_integer_info
_F95ParserCommon_integer_info:
Lc2rb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rc
Lc2rd:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2ra
Lc2r9:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_integer_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2ra:
	jmp *(%rbx)
Lc2rc:
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
	.quad	_S2nM_srt-(_F95ParserCommon_identifier_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_identifier_info
_F95ParserCommon_identifier_info:
Lc2rq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rr
Lc2rs:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rp
Lc2ro:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rp:
	jmp *(%rbx)
Lc2rr:
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
	.quad	_S2nM_srt-(_F95ParserCommon_commaSep1_info)+96
	.quad	0
	.quad	38654705686
.globl _F95ParserCommon_commaSep1_info
_F95ParserCommon_commaSep1_info:
Lc2rF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rG
Lc2rH:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rE
Lc2rD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rE:
	jmp *(%rbx)
Lc2rG:
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
	.quad	_S2nM_srt-(_F95ParserCommon_commaSep_info)+96
	.quad	0
	.quad	73014444054
.globl _F95ParserCommon_commaSep_info
_F95ParserCommon_commaSep_info:
Lc2rU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rV
Lc2rW:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2rT
Lc2rS:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2rT:
	jmp *(%rbx)
Lc2rV:
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
	.quad	_S2nM_srt-(_F95ParserCommon_comma_info)+96
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_comma_info
_F95ParserCommon_comma_info:
Lc2s9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sa
Lc2sb:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2s8
Lc2s7:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_comma_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2s8:
	jmp *(%rbx)
Lc2sa:
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
	.quad	_S2nM_srt-(_F95ParserCommon_charLiteral_info)+96
	.quad	0
	.quad	279172874262
.globl _F95ParserCommon_charLiteral_info
_F95ParserCommon_charLiteral_info:
Lc2so:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sp
Lc2sq:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sn
Lc2sm:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sn:
	jmp *(%rbx)
Lc2sp:
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
	.quad	_S2nM_srt-(_F95ParserCommon_natural_info)+96
	.quad	0
	.quad	554050781206
.globl _F95ParserCommon_natural_info
_F95ParserCommon_natural_info:
Lc2sD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sE
Lc2sF:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sC
Lc2sB:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_natural_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sC:
	jmp *(%rbx)
Lc2sE:
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
	.quad	_S2nM_srt-(_F95ParserCommon_parens_info)+96
	.quad	0
	.quad	1103806595094
.globl _F95ParserCommon_parens_info
_F95ParserCommon_parens_info:
Lc2sS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2sT
Lc2sU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2sR
Lc2sQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2sR:
	jmp *(%rbx)
Lc2sT:
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
	.quad	_S2nM_srt-(_F95ParserCommon_reserved_info)+96
	.quad	0
	.quad	2203318222870
.globl _F95ParserCommon_reserved_info
_F95ParserCommon_reserved_info:
Lc2t7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2t8
Lc2t9:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2t6
Lc2t5:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reserved_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2t6:
	jmp *(%rbx)
Lc2t8:
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
	.quad	_S2nM_srt-(_F95ParserCommon_reservedOp_info)+96
	.quad	0
	.quad	4402341478422
.globl _F95ParserCommon_reservedOp_info
_F95ParserCommon_reservedOp_info:
Lc2tm:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tn
Lc2to:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2tl
Lc2tk:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2tl:
	jmp *(%rbx)
Lc2tn:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reservedOp_info - _F95ParserCommon_reservedOp_info_dsp
.data
.align 3
.align 0
_r2my_closure:
	.quad	_r2my_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2my_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_r2my_info)+0
	.quad	0
	.quad	12884901910
_r2my_info:
Lc2tB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tC
Lc2tD:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2tA
Lc2tz:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2tA:
	jmp *(%rbx)
Lc2tC:
	jmp *-16(%r13)
	.long  _r2my_info - _r2my_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparser_closure
_F95ParserCommon_runzuparser_closure:
	.quad	_F95ParserCommon_runzuparser_info
	.quad	0
.text
.align 3
_s2n5_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2n5_info)+184
	.quad	1
	.quad	4294967313
_s2n5_info:
Lc2u5:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2u6
Lc2u7:
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
Lc2u6:
	jmp *-16(%r13)
	.long  _s2n5_info - _s2n5_info_dsp
.const
.align 3
.align 0
_c2uc_str:
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
_s2n4_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2n4_info)+16
	.quad	0
	.quad	4294967312
_s2n4_info:
Lc2ud:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ue
Lc2uf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2uc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ue:
	jmp *-16(%r13)
	.long  _s2n4_info - _s2n4_info_dsp
.text
.align 3
_F95ParserCommon_runzuparser_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_F95ParserCommon_runzuparser_info)+16
	.quad	8589934607
	.quad	0
	.quad	567453557343649807
.globl _F95ParserCommon_runzuparser_info
_F95ParserCommon_runzuparser_info:
Lc2un:
	leaq -8(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uz
Lc2uA:
	leaq _c2tX_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	leaq _r2my_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	addq $-8,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2nM_srt-(_c2tX_info)+16
	.quad	0
	.quad	63050399078154272
_c2tX_info:
Lc2tX:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc2ul
Lc2um:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2uy
Lc2ux:
	movq 7(%rbx),%rax
	leaq _s2n5_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2n4_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2uo_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2ul:
	movq 6(%rbx),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp _stg_ap_0_fast
.text
.align 3
	.quad	_S2nM_srt-(_c2uo_info)+200
	.quad	0
	.quad	4294967328
_c2uo_info:
Lc2uo:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2uy:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2uz:
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
_s2n9_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2n9_info)+0
	.quad	0
	.quad	12884901904
_s2n9_info:
Lc2v9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2va
Lc2vb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2va:
	jmp *-16(%r13)
	.long  _s2n9_info - _s2n9_info_dsp
.text
.align 3
_s2ng_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2ng_info)+184
	.quad	1
	.quad	279172874257
_s2ng_info:
Lc2vp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vq
Lc2vr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	leaq _base_SystemziIO_print_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2vq:
	jmp *-16(%r13)
	.long  _s2ng_info - _s2ng_info_dsp
.const
.align 3
.align 0
_c2vA_str:
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
_s2ne_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2ne_info)+16
	.quad	0
	.quad	4294967312
_s2ne_info:
Lc2vB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vC
Lc2vD:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vA_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vC:
	jmp *-16(%r13)
	.long  _s2ne_info - _s2ne_info_dsp
.text
.align 3
_s2nf_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nf_info)+16
	.quad	0
	.quad	1152921508901814288
_s2nf_info:
Lc2vE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vF
Lc2vG:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vI
Lc2vH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2ne_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStr_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2vI:
	movq $16,904(%r13)
Lc2vF:
	jmp *-16(%r13)
	.long  _s2nf_info - _s2nf_info_dsp
.text
.align 3
_s2nj_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2nj_info:
Lc2vY:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vZ
Lc2w0:
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
Lc2vZ:
	jmp *-16(%r13)
	.long  _s2nj_info - _s2nj_info_dsp
.text
.align 3
_s2nm_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nm_info)+192
	.quad	2
	.quad	4294967315
_s2nm_info:
Lc2w1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w2
Lc2w3:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2w5
Lc2w4:
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
	leaq _s2nj_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rcx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2w5:
	movq $56,904(%r13)
Lc2w2:
	jmp *-16(%r13)
	.long  _s2nm_info - _s2nm_info_dsp
.const
.align 3
.align 0
_c2wa_str:
	.byte	32
	.byte	32
	.byte	32
	.byte	32
	.byte	0
.text
.align 3
_s2ni_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2ni_info)+16
	.quad	0
	.quad	4294967312
_s2ni_info:
Lc2wb:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wc
Lc2wd:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2wa_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2wc:
	jmp *-16(%r13)
	.long  _s2ni_info - _s2ni_info_dsp
.text
.align 3
_s2nn_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nn_info)+16
	.quad	2
	.quad	18014402804449299
_s2nn_info:
Lc2we:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wf
Lc2wg:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2wi
Lc2wh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2nm_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s2ni_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2wi:
	movq $48,904(%r13)
Lc2wf:
	jmp *-16(%r13)
	.long  _s2nn_info - _s2nn_info_dsp
.text
.align 3
_s2no_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2no_info)+16
	.quad	8589934607
	.quad	2
	.quad	8818048074686398476
_s2no_info:
Lc2wq:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wx
Lc2wy:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2vh_info(%rip),%rcx
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
	.quad	_S2nM_srt-(_c2vh_info)+16
	.quad	1
	.quad	8673932886610542624
_c2vh_info:
Lc2vh:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2wo
Lc2wp:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2ww
Lc2wv:
	movq 7(%rbx),%rax
	leaq _s2ng_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2nf_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	movq %rax,8(%rbp)
	addq $-8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2wo:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2wt
Lc2ws:
	movq 6(%rbx),%rbx
	leaq _s2nn_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2wt:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2ww:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2wx:
	jmp *-8(%r13)
	.long  _s2no_info - _s2no_info_dsp
.const_data
.align 3
.align 0
_u2wE_srtd:
	.quad	_S2nM_srt
	.quad	34
	.quad	16802381831
.text
.align 3
_F95ParserCommon_runzuparserzuprint_info_dsp:
.text
.align 3
	.quad	_u2wE_srtd-(_F95ParserCommon_runzuparserzuprint_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_runzuparserzuprint_info
_F95ParserCommon_runzuparserzuprint_info:
Lc2wz:
Lc2wB:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2wD
Lc2wC:
	leaq _s2n9_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -32(%r12),%rax
	leaq _s2no_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,-8(%r12)
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2wD:
	movq $40,904(%r13)
Lc2wA:
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
	.quad	_S2nM_srt-(_F95ParserCommon_semi_info)+96
	.quad	0
	.quad	18014402804449302
.globl _F95ParserCommon_semi_info
_F95ParserCommon_semi_info:
Lc2xI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xJ
Lc2xK:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xH
Lc2xG:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_semi_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xH:
	jmp *(%rbx)
Lc2xJ:
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
	.quad	_S2nM_srt-(_F95ParserCommon_stringLiteral_info)+96
	.quad	0
	.quad	36028801313931286
.globl _F95ParserCommon_stringLiteral_info
_F95ParserCommon_stringLiteral_info:
Lc2xX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xY
Lc2xZ:
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
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xW:
	jmp *(%rbx)
Lc2xY:
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
	.quad	_S2nM_srt-(_F95ParserCommon_symbol_info)+96
	.quad	0
	.quad	72057598332895254
.globl _F95ParserCommon_symbol_info
_F95ParserCommon_symbol_info:
Lc2yc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yd
Lc2ye:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yb
Lc2ya:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yb:
	jmp *(%rbx)
Lc2yd:
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
_s2nC_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nC_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2nC_info:
Lc2yu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yv
Lc2yw:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2yv:
	jmp *-8(%r13)
	.long  _s2nC_info - _s2nC_info_dsp
.text
.align 3
_s2nx_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nx_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2nx_info:
Lc2yO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yP
Lc2yQ:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2yP:
	jmp *-8(%r13)
	.long  _s2nx_info - _s2nx_info_dsp
.text
.align 3
_s2ny_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2ny_info)+296
	.quad	1
	.quad	4294967313
_s2ny_info:
Lc2yR:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yS
Lc2yT:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2yV
Lc2yU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2nx_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2yV:
	movq $16,904(%r13)
Lc2yS:
	jmp *-16(%r13)
	.long  _s2ny_info - _s2ny_info_dsp
.const
.align 3
.align 0
_c2z4_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2nu_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nu_info)+304
	.quad	0
	.quad	4294967312
_s2nu_info:
Lc2z5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z6
Lc2z7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2z4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2z6:
	jmp *-16(%r13)
	.long  _s2nu_info - _s2nu_info_dsp
.text
.align 3
_s2nv_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nv_info)+304
	.quad	0
	.quad	12884901904
_s2nv_info:
Lc2z8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z9
Lc2za:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2zc
Lc2zb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2nu_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2zc:
	movq $16,904(%r13)
Lc2z9:
	jmp *-16(%r13)
	.long  _s2nv_info - _s2nv_info_dsp
.text
.align 3
_s2nz_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nz_info)+296
	.quad	1
	.quad	30064771089
_s2nz_info:
Lc2zd:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ze
Lc2zf:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2zh
Lc2zg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ny_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2nv_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2zh:
	movq $40,904(%r13)
Lc2ze:
	jmp *-16(%r13)
	.long  _s2nz_info - _s2nz_info_dsp
.text
.align 3
_s2nr_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nr_info)+296
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2nr_info:
Lc2zv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zw
Lc2zx:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2zw:
	jmp *-8(%r13)
	.long  _s2nr_info - _s2nr_info_dsp
.text
.align 3
_s2ns_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2ns_info)+296
	.quad	1
	.quad	4294967313
_s2ns_info:
Lc2zy:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zz
Lc2zA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2zC
Lc2zB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2nr_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2zC:
	movq $16,904(%r13)
Lc2zz:
	jmp *-16(%r13)
	.long  _s2ns_info - _s2ns_info_dsp
.text
.align 3
_s2nt_info_dsp:
.text
.align 3
	.quad	_S2nM_srt-(_s2nt_info)+296
	.quad	1
	.quad	38654705681
_s2nt_info:
Lc2zD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zE
Lc2zF:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2zH
Lc2zG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ns_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2zH:
	movq $24,904(%r13)
Lc2zE:
	jmp *-16(%r13)
	.long  _s2nt_info - _s2nt_info_dsp
.const_data
.align 3
.align 0
_u2zS_srtd:
	.quad	_S2nM_srt+64
	.quad	33
	.quad	8053063681
.text
.align 3
_s2nA_info_dsp:
.text
.align 3
	.quad	_u2zS_srtd-(_s2nA_info)+0
	.quad	1
	.quad	-4294967279
_s2nA_info:
Lc2zI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zJ
Lc2zK:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2zM
Lc2zL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2nz_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2nt_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2zM:
	movq $48,904(%r13)
Lc2zJ:
	jmp *-16(%r13)
	.long  _s2nA_info - _s2nA_info_dsp
.const_data
.align 3
.align 0
_u2zT_srtd:
	.quad	_S2nM_srt+64
	.quad	34
	.quad	16642998273
.text
.align 3
_F95ParserCommon_arglistzuparserzuwrapper_info_dsp:
.text
.align 3
	.quad	_u2zT_srtd-(_F95ParserCommon_arglistzuparserzuwrapper_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_arglistzuparserzuwrapper_info
_F95ParserCommon_arglistzuparserzuwrapper_info:
Lc2zN:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zO
Lc2zP:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2zR
Lc2zQ:
	leaq _s2nC_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -31(%r12),%rax
	leaq _s2nA_info(%rip),%rbx
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
Lc2zR:
	movq $40,904(%r13)
Lc2zO:
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
	.quad	_S2nM_srt-(_F95ParserCommon_whiteSpace_info)+96
	.quad	0
	.quad	4611686022722355222
.globl _F95ParserCommon_whiteSpace_info
_F95ParserCommon_whiteSpace_info:
Lc2B0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2B1
Lc2B2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2AZ
Lc2AY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2AZ:
	jmp *(%rbx)
Lc2B1:
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
	.quad	_S2nM_srt-(_F95ParserCommon_word_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_word_info
_F95ParserCommon_word_info:
Lc2Bf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bg
Lc2Bh:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Be
Lc2Bd:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Be:
	jmp *(%rbx)
Lc2Bg:
	jmp *-16(%r13)
	.long  _F95ParserCommon_word_info - _F95ParserCommon_word_info_dsp
.const_data
.align 3
.align 0
_S2nM_srt:
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_oneOf_closure
	.quad	_r2kb_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_opLetter_closure
	.quad	_r2mx_closure
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
	.quad	_r2my_closure
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

