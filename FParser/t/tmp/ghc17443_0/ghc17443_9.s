.data
.align 3
.align 0
.globl ___stginit_F95ParserCommon
___stginit_F95ParserCommon:
.data
.align 3
.align 0
_r2ri_closure:
	.quad	_r2ri_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2ri_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_r2ri_info)+0
	.quad	0
	.quad	12884901910
_r2ri_info:
Lc2uP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uQ
Lc2uR:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2uO
Lc2uN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uO:
	jmp *(%rbx)
Lc2uQ:
	jmp *-16(%r13)
	.long  _r2ri_info - _r2ri_info_dsp
.data
.align 3
.align 0
_r2tE_closure:
	.quad	_r2tE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2vx_str:
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
_s2u4_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u4_info)+16
	.quad	0
	.quad	4294967312
_s2u4_info:
Lc2vy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vz
Lc2vA:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2vx_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2vz:
	jmp *-16(%r13)
	.long  _s2u4_info - _s2u4_info_dsp
.text
.align 3
_s2u5_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u5_info)+16
	.quad	0
	.quad	30064771088
_s2u5_info:
Lc2vB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vC
Lc2vD:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2vF
Lc2vE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2u4_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _r2ri_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_oneOf_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2vF:
	movq $16,904(%r13)
Lc2vC:
	jmp *-16(%r13)
	.long  _s2u5_info - _s2u5_info_dsp
.text
.align 3
_s2u3_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u3_info)+40
	.quad	0
	.quad	12884901904
_s2u3_info:
Lc2vK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2vL
Lc2vM:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2tE_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_opLetter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2vL:
	jmp *-16(%r13)
	.long  _s2u3_info - _s2u3_info_dsp
.text
.align 3
_s2u0_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u0_info)+32
	.quad	0
	.quad	38654705680
_s2u0_info:
Lc2vZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w0
Lc2w1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 1521(%rax),%rsi
	leaq _r2ri_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2w0:
	jmp *-16(%r13)
	.long  _s2u0_info - _s2u0_info_dsp
.text
.align 3
_s2tY_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2tY_info)+32
	.quad	0
	.quad	38654705680
_s2tY_info:
Lc2w6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2w7
Lc2w8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 577(%rax),%rsi
	leaq _r2ri_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2w7:
	jmp *-16(%r13)
	.long  _s2tY_info - _s2tY_info_dsp
.text
.align 3
_s2u1_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u1_info)+32
	.quad	0
	.quad	107374182416
_s2u1_info:
Lc2w9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wa
Lc2wb:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2wd
Lc2wc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2u0_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2tY_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2wd:
	movq $32,904(%r13)
Lc2wa:
	jmp *-16(%r13)
	.long  _s2u1_info - _s2u1_info_dsp
.text
.align 3
_s2tW_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2tW_info)+32
	.quad	0
	.quad	141733920784
_s2tW_info:
Lc2wi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wj
Lc2wk:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r2ri_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wj:
	jmp *-16(%r13)
	.long  _s2tW_info - _s2tW_info_dsp
.text
.align 3
_s2u2_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u2_info)+32
	.quad	0
	.quad	244813135888
_s2u2_info:
Lc2wl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wm
Lc2wn:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2wp
Lc2wo:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2u1_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s2tW_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2wp:
	movq $32,904(%r13)
Lc2wm:
	jmp *-16(%r13)
	.long  _s2u2_info - _s2u2_info_dsp
.const
.align 3
.align 0
_c2wu_str:
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s2tV_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2tV_info)+16
	.quad	0
	.quad	4294967312
_s2tV_info:
Lc2wv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ww
Lc2wx:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2wu_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2ww:
	jmp *-16(%r13)
	.long  _s2tV_info - _s2tV_info_dsp
.text
.align 3
_r2tE_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_r2tE_info)+16
	.quad	0
	.quad	2194728288278
_r2tE_info:
Lc2wy:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wD
Lc2wE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2vj
Lc2vi:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2vk_info(%rip),%rax
	movq %rax,-24(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure(%rip),%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2vk
Lc2vl:
	jmp *(%rbx)
Lc2vj:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2uS_srt-(_c2vk_info)+16
	.quad	0
	.quad	1095216660512
_c2vk_info:
Lc2vk:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc2wC
Lc2wB:
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
	leaq _s2u5_info(%rip),%rbx
	movq %rbx,-152(%r12)
	leaq -152(%r12),%rbx
	leaq _s2u3_info(%rip),%rcx
	movq %rcx,-136(%r12)
	leaq -136(%r12),%rcx
	leaq _s2u2_info(%rip),%rdx
	movq %rdx,-120(%r12)
	leaq -120(%r12),%rdx
	leaq _s2tV_info(%rip),%rsi
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
Lc2wC:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2wD:
	jmp *-16(%r13)
	.long  _r2tE_info - _r2tE_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_f95Def_closure
_F95ParserCommon_f95Def_closure:
	.quad	_stg_IND_STATIC_info
	.quad	_r2tE_closure
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
_s2u6_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2u6_info)+0
	.quad	0
	.quad	12884901904
_s2u6_info:
Lc2xS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xT
Lc2xU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2xT:
	jmp *-16(%r13)
	.long  _s2u6_info - _s2u6_info_dsp
.text
.align 3
_F95ParserCommon_lexer_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_F95ParserCommon_lexer_info)+0
	.quad	0
	.quad	9083855831062
.globl _F95ParserCommon_lexer_info
_F95ParserCommon_lexer_info:
Lc2xV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xW
Lc2xX:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2xZ
Lc2xY:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2xN
Lc2xM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2u6_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _r2tE_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2xN:
	jmp *(%rbx)
Lc2xZ:
	movq $16,904(%r13)
Lc2xW:
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
	.quad	_S2uS_srt-(_F95ParserCommon_integer_info)+96
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_integer_info
_F95ParserCommon_integer_info:
Lc2yh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yi
Lc2yj:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yg
Lc2yf:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_integer_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yg:
	jmp *(%rbx)
Lc2yi:
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
	.quad	_S2uS_srt-(_F95ParserCommon_identifier_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_identifier_info
_F95ParserCommon_identifier_info:
Lc2yw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yx
Lc2yy:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yv
Lc2yu:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yv:
	jmp *(%rbx)
Lc2yx:
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
	.quad	_S2uS_srt-(_F95ParserCommon_commaSep1_info)+96
	.quad	0
	.quad	38654705686
.globl _F95ParserCommon_commaSep1_info
_F95ParserCommon_commaSep1_info:
Lc2yL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2yM
Lc2yN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yK
Lc2yJ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yK:
	jmp *(%rbx)
Lc2yM:
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
	.quad	_S2uS_srt-(_F95ParserCommon_commaSep_info)+96
	.quad	0
	.quad	73014444054
.globl _F95ParserCommon_commaSep_info
_F95ParserCommon_commaSep_info:
Lc2z0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2z1
Lc2z2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2yZ
Lc2yY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2yZ:
	jmp *(%rbx)
Lc2z1:
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
	.quad	_S2uS_srt-(_F95ParserCommon_comma_info)+96
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_comma_info
_F95ParserCommon_comma_info:
Lc2zf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zg
Lc2zh:
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
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_comma_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2ze:
	jmp *(%rbx)
Lc2zg:
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
	.quad	_S2uS_srt-(_F95ParserCommon_charLiteral_info)+96
	.quad	0
	.quad	279172874262
.globl _F95ParserCommon_charLiteral_info
_F95ParserCommon_charLiteral_info:
Lc2zu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zv
Lc2zw:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zt
Lc2zs:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2zt:
	jmp *(%rbx)
Lc2zv:
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
	.quad	_S2uS_srt-(_F95ParserCommon_natural_info)+96
	.quad	0
	.quad	554050781206
.globl _F95ParserCommon_natural_info
_F95ParserCommon_natural_info:
Lc2zJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zK
Lc2zL:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zI
Lc2zH:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_natural_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2zI:
	jmp *(%rbx)
Lc2zK:
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
	.quad	_S2uS_srt-(_F95ParserCommon_parens_info)+96
	.quad	0
	.quad	1103806595094
.globl _F95ParserCommon_parens_info
_F95ParserCommon_parens_info:
Lc2zY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2zZ
Lc2A0:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2zX
Lc2zW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2zX:
	jmp *(%rbx)
Lc2zZ:
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
	.quad	_S2uS_srt-(_F95ParserCommon_reserved_info)+96
	.quad	0
	.quad	2203318222870
.globl _F95ParserCommon_reserved_info
_F95ParserCommon_reserved_info:
Lc2Ad:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ae
Lc2Af:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ac
Lc2Ab:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reserved_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ac:
	jmp *(%rbx)
Lc2Ae:
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
	.quad	_S2uS_srt-(_F95ParserCommon_reservedOp_info)+96
	.quad	0
	.quad	4402341478422
.globl _F95ParserCommon_reservedOp_info
_F95ParserCommon_reservedOp_info:
Lc2As:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2At
Lc2Au:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ar
Lc2Aq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ar:
	jmp *(%rbx)
Lc2At:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reservedOp_info - _F95ParserCommon_reservedOp_info_dsp
.data
.align 3
.align 0
_r2tF_closure:
	.quad	_r2tF_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2tF_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_r2tF_info)+0
	.quad	0
	.quad	12884901910
_r2tF_info:
Lc2AH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2AI
Lc2AJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2AG
Lc2AF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2AG:
	jmp *(%rbx)
Lc2AI:
	jmp *-16(%r13)
	.long  _r2tF_info - _r2tF_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparser_closure
_F95ParserCommon_runzuparser_closure:
	.quad	_F95ParserCommon_runzuparser_info
	.quad	0
.text
.align 3
_s2uc_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uc_info)+184
	.quad	1
	.quad	4294967313
_s2uc_info:
Lc2Bb:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bc
Lc2Bd:
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
Lc2Bc:
	jmp *-16(%r13)
	.long  _s2uc_info - _s2uc_info_dsp
.const
.align 3
.align 0
_c2Bi_str:
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
_s2ub_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2ub_info)+16
	.quad	0
	.quad	4294967312
_s2ub_info:
Lc2Bj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Bk
Lc2Bl:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Bi_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Bk:
	jmp *-16(%r13)
	.long  _s2ub_info - _s2ub_info_dsp
.text
.align 3
_F95ParserCommon_runzuparser_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_F95ParserCommon_runzuparser_info)+16
	.quad	8589934607
	.quad	0
	.quad	567453557343649807
.globl _F95ParserCommon_runzuparser_info
_F95ParserCommon_runzuparser_info:
Lc2Bt:
	leaq -8(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BF
Lc2BG:
	leaq _c2B3_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	leaq _r2tF_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	addq $-8,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2uS_srt-(_c2B3_info)+16
	.quad	0
	.quad	63050399078154272
_c2B3_info:
Lc2B3:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc2Br
Lc2Bs:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2BE
Lc2BD:
	movq 7(%rbx),%rax
	leaq _s2uc_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2ub_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Bu_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2Br:
	movq 6(%rbx),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp _stg_ap_0_fast
.text
.align 3
	.quad	_S2uS_srt-(_c2Bu_info)+200
	.quad	0
	.quad	4294967328
_c2Bu_info:
Lc2Bu:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc2BE:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2BF:
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
_s2ug_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2ug_info)+0
	.quad	0
	.quad	12884901904
_s2ug_info:
Lc2Cf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cg
Lc2Ch:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Cg:
	jmp *-16(%r13)
	.long  _s2ug_info - _s2ug_info_dsp
.text
.align 3
_s2un_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2un_info)+184
	.quad	1
	.quad	279172874257
_s2un_info:
Lc2Cv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cw
Lc2Cx:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	leaq _base_SystemziIO_print_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Cw:
	jmp *-16(%r13)
	.long  _s2un_info - _s2un_info_dsp
.const
.align 3
.align 0
_c2CG_str:
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
_s2ul_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2ul_info)+16
	.quad	0
	.quad	4294967312
_s2ul_info:
Lc2CH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CI
Lc2CJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2CG_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2CI:
	jmp *-16(%r13)
	.long  _s2ul_info - _s2ul_info_dsp
.text
.align 3
_s2um_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2um_info)+16
	.quad	0
	.quad	1152921508901814288
_s2um_info:
Lc2CK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CL
Lc2CM:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2CO
Lc2CN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2ul_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStr_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2CO:
	movq $16,904(%r13)
Lc2CL:
	jmp *-16(%r13)
	.long  _s2um_info - _s2um_info_dsp
.text
.align 3
_s2uq_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2uq_info:
Lc2D4:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2D5
Lc2D6:
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
Lc2D5:
	jmp *-16(%r13)
	.long  _s2uq_info - _s2uq_info_dsp
.text
.align 3
_s2ut_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2ut_info)+192
	.quad	2
	.quad	4294967315
_s2ut_info:
Lc2D7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2D8
Lc2D9:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2Db
Lc2Da:
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
	leaq _s2uq_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rcx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Db:
	movq $56,904(%r13)
Lc2D8:
	jmp *-16(%r13)
	.long  _s2ut_info - _s2ut_info_dsp
.const
.align 3
.align 0
_c2Dg_str:
	.byte	32
	.byte	32
	.byte	32
	.byte	32
	.byte	0
.text
.align 3
_s2up_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2up_info)+16
	.quad	0
	.quad	4294967312
_s2up_info:
Lc2Dh:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Di
Lc2Dj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Dg_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Di:
	jmp *-16(%r13)
	.long  _s2up_info - _s2up_info_dsp
.text
.align 3
_s2uu_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uu_info)+16
	.quad	2
	.quad	18014402804449299
_s2uu_info:
Lc2Dk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Dl
Lc2Dm:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Do
Lc2Dn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2ut_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s2up_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Do:
	movq $48,904(%r13)
Lc2Dl:
	jmp *-16(%r13)
	.long  _s2uu_info - _s2uu_info_dsp
.text
.align 3
_s2uv_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uv_info)+16
	.quad	8589934607
	.quad	2
	.quad	8818048074686398476
_s2uv_info:
Lc2Dw:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2DD
Lc2DE:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c2Cn_info(%rip),%rcx
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
	.quad	_S2uS_srt-(_c2Cn_info)+16
	.quad	1
	.quad	8673932886610542624
_c2Cn_info:
Lc2Cn:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2Du
Lc2Dv:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2DC
Lc2DB:
	movq 7(%rbx),%rax
	leaq _s2un_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2um_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	movq %rax,8(%rbp)
	addq $-8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2Du:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Dz
Lc2Dy:
	movq 6(%rbx),%rbx
	leaq _s2uu_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc2Dz:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2DC:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2DD:
	jmp *-8(%r13)
	.long  _s2uv_info - _s2uv_info_dsp
.const_data
.align 3
.align 0
_u2DK_srtd:
	.quad	_S2uS_srt
	.quad	34
	.quad	16802381831
.text
.align 3
_F95ParserCommon_runzuparserzuprint_info_dsp:
.text
.align 3
	.quad	_u2DK_srtd-(_F95ParserCommon_runzuparserzuprint_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_runzuparserzuprint_info
_F95ParserCommon_runzuparserzuprint_info:
Lc2DF:
Lc2DH:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2DJ
Lc2DI:
	leaq _s2ug_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -32(%r12),%rax
	leaq _s2uv_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,-8(%r12)
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2DJ:
	movq $40,904(%r13)
Lc2DG:
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
	.quad	_S2uS_srt-(_F95ParserCommon_semi_info)+96
	.quad	0
	.quad	18014402804449302
.globl _F95ParserCommon_semi_info
_F95ParserCommon_semi_info:
Lc2EO:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EP
Lc2EQ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2EN
Lc2EM:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_semi_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2EN:
	jmp *(%rbx)
Lc2EP:
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
	.quad	_S2uS_srt-(_F95ParserCommon_stringLiteral_info)+96
	.quad	0
	.quad	36028801313931286
.globl _F95ParserCommon_stringLiteral_info
_F95ParserCommon_stringLiteral_info:
Lc2F3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2F4
Lc2F5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2F2
Lc2F1:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2F2:
	jmp *(%rbx)
Lc2F4:
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
	.quad	_S2uS_srt-(_F95ParserCommon_symbol_info)+96
	.quad	0
	.quad	72057598332895254
.globl _F95ParserCommon_symbol_info
_F95ParserCommon_symbol_info:
Lc2Fi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fj
Lc2Fk:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Fh
Lc2Fg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Fh:
	jmp *(%rbx)
Lc2Fj:
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
_s2ux_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2ux_info)+296
	.quad	1
	.quad	4294967313
_s2ux_info:
Lc2Fz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2FA
Lc2FB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2FA:
	jmp *-16(%r13)
	.long  _s2ux_info - _s2ux_info_dsp
.text
.align 3
_s2uF_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uF_info)+304
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s2uF_info:
Lc2G7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2G8
Lc2G9:
	movq %r14,%rax
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc2G8:
	jmp *-8(%r13)
	.long  _s2uF_info - _s2uF_info_dsp
.text
.align 3
_s2uG_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uG_info)+304
	.quad	1
	.quad	4294967313
_s2uG_info:
Lc2Ga:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Gb
Lc2Gc:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Ge
Lc2Gd:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2uF_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2Ge:
	movq $16,904(%r13)
Lc2Gb:
	jmp *-16(%r13)
	.long  _s2uG_info - _s2uG_info_dsp
.const
.align 3
.align 0
_c2Gn_str:
	.byte	58
	.byte	58
	.byte	0
.text
.align 3
_s2uC_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uC_info)+312
	.quad	0
	.quad	4294967312
_s2uC_info:
Lc2Go:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Gp
Lc2Gq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Gn_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Gp:
	jmp *-16(%r13)
	.long  _s2uC_info - _s2uC_info_dsp
.text
.align 3
_s2uD_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uD_info)+312
	.quad	0
	.quad	12884901904
_s2uD_info:
Lc2Gr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Gs
Lc2Gt:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Gv
Lc2Gu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2uC_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95ParserCommon_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Gv:
	movq $16,904(%r13)
Lc2Gs:
	jmp *-16(%r13)
	.long  _s2uD_info - _s2uD_info_dsp
.text
.align 3
_s2uH_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uH_info)+304
	.quad	4294967301
	.quad	2
	.quad	30064771084
_s2uH_info:
Lc2GD:
	leaq -48(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GJ
Lc2GK:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _c2FT_info(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %r14,%rcx
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-48(%rbp)
	movq %rcx,-40(%rbp)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-32(%rbp)
	movq %rbx,-16(%rbp)
	movq %rcx,-8(%rbp)
	addq $-48,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
.text
.align 3
	.quad	_S2uS_srt-(_c2FT_info)+304
	.quad	2
	.quad	30064771104
_c2FT_info:
Lc2FT:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc2GB
Lc2GC:
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rax
	movq %rax,8(%rbp)
	addq $8,%rbp
	jmp _base_GHCziBase_return_info
Lc2GB:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2GG
Lc2GF:
	leaq _s2uG_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2uD_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,8(%rbp)
	movq %rax,16(%rbp)
	jmp _base_GHCziBase_zgzg_info
Lc2GG:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2GJ:
	jmp *-8(%r13)
	.long  _s2uH_info - _s2uH_info_dsp
.text
.align 3
_s2uz_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uz_info)+328
	.quad	1
	.quad	4294967313
_s2uz_info:
Lc2GP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GQ
Lc2GR:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2GQ:
	jmp *-16(%r13)
	.long  _s2uz_info - _s2uz_info_dsp
.text
.align 3
_s2uI_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_s2uI_info)+304
	.quad	4294967301
	.quad	1
	.quad	64424509450
_s2uI_info:
Lc2GS:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2GT
Lc2GU:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2GW
Lc2GV:
	movq 7(%rbx),%rax
	leaq _s2uH_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-32(%r12)
	movq %r14,-24(%r12)
	leaq -39(%r12),%rax
	leaq _s2uz_info(%rip),%rbx
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
Lc2GW:
	movq $48,904(%r13)
Lc2GT:
	jmp *-8(%r13)
	.long  _s2uI_info - _s2uI_info_dsp
.text
.align 3
_F95ParserCommon_arglistzuparserzuwrapper_info_dsp:
.text
.align 3
	.quad	_S2uS_srt-(_F95ParserCommon_arglistzuparserzuwrapper_info)+296
	.quad	4294967301
	.quad	0
	.quad	270582939663
.globl _F95ParserCommon_arglistzuparserzuwrapper_info
_F95ParserCommon_arglistzuparserzuwrapper_info:
Lc2GX:
Lc2GZ:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2H1
Lc2H0:
	leaq _s2ux_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2uI_info(%rip),%rbx
	movq %rbx,-8(%r12)
	movq %rax,(%r12)
	leaq -7(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc2H1:
	movq $40,904(%r13)
Lc2GY:
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
	.quad	_S2uS_srt-(_F95ParserCommon_whiteSpace_info)+96
	.quad	0
	.quad	-9223372032559808490
.globl _F95ParserCommon_whiteSpace_info
_F95ParserCommon_whiteSpace_info:
Lc2HX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2HY
Lc2HZ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2HW
Lc2HV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2HW:
	jmp *(%rbx)
Lc2HY:
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
	.quad	_S2uS_srt-(_F95ParserCommon_word_info)+96
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_word_info
_F95ParserCommon_word_info:
Lc2Ic:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Id
Lc2Ie:
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
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ib:
	jmp *(%rbx)
Lc2Id:
	jmp *-16(%r13)
	.long  _F95ParserCommon_word_info - _F95ParserCommon_word_info_dsp
.const_data
.align 3
.align 0
_S2uS_srt:
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_oneOf_closure
	.quad	_r2ri_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_opLetter_closure
	.quad	_r2tE_closure
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
	.quad	_r2tF_closure
	.quad	_base_SystemziIO_print_closure
	.quad	_base_SystemziIO_putStr_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_base_SystemziIO_putStrLn_closure
	.quad	_F95ParserCommon_runzuparserzuprint_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_semi_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_symbol_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zdfMonadParsecT_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_F95ParserCommon_symbol_closure
	.quad	_parseczm3zi1zi5_TextziParserCombinatorsziParsecziPrim_try_closure
	.quad	_F95ParserCommon_arglistzuparserzuwrapper_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

