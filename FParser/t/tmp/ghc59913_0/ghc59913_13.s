.data
.align 3
.align 0
.globl ___stginit_F95ParserCommon
___stginit_F95ParserCommon:
.data
.align 3
.align 0
_r38R_closure:
	.quad	_r38R_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r38R_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_r38R_info)+0
	.quad	0
	.quad	12884901910
_r38R_info:
Lc3bZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3c0
Lc3c1:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3bY
Lc3bX:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3bY:
	jmp *(%rbx)
Lc3c0:
	jmp *-16(%r13)
	.long  _r38R_info - _r38R_info_dsp
.data
.align 3
.align 0
_r3b1_closure:
	.quad	_r3b1_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c3cH_str:
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
_s3bo_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bo_info)+16
	.quad	0
	.quad	4294967312
_s3bo_info:
Lc3cI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cJ
Lc3cK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3cH_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3cJ:
	jmp *-16(%r13)
	.long  _s3bo_info - _s3bo_info_dsp
.text
.align 3
_s3bp_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bp_info)+16
	.quad	0
	.quad	30064771088
_s3bp_info:
Lc3cL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cM
Lc3cN:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3cP
Lc3cO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s3bo_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%rsi
	leaq _r38R_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_oneOf_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3cP:
	movq $16,904(%r13)
Lc3cM:
	jmp *-16(%r13)
	.long  _s3bp_info - _s3bp_info_dsp
.text
.align 3
_s3bn_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bn_info)+40
	.quad	0
	.quad	12884901904
_s3bn_info:
Lc3cU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3cV
Lc3cW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r3b1_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_opLetter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3cV:
	jmp *-16(%r13)
	.long  _s3bn_info - _s3bn_info_dsp
.text
.align 3
_s3bk_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bk_info)+32
	.quad	0
	.quad	38654705680
_s3bk_info:
Lc3d9:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3da
Lc3db:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 1521(%rax),%rsi
	leaq _r38R_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3da:
	jmp *-16(%r13)
	.long  _s3bk_info - _s3bk_info_dsp
.text
.align 3
_s3bi_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bi_info)+32
	.quad	0
	.quad	38654705680
_s3bi_info:
Lc3dg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dh
Lc3di:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	leaq 577(%rax),%rsi
	leaq _r38R_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_char_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3dh:
	jmp *-16(%r13)
	.long  _s3bi_info - _s3bi_info_dsp
.text
.align 3
_s3bl_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bl_info)+32
	.quad	0
	.quad	107374182416
_s3bl_info:
Lc3dj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dk
Lc3dl:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3dn
Lc3dm:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s3bk_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s3bi_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3dn:
	movq $32,904(%r13)
Lc3dk:
	jmp *-16(%r13)
	.long  _s3bl_info - _s3bl_info_dsp
.text
.align 3
_s3bg_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bg_info)+32
	.quad	0
	.quad	141733920784
_s3bg_info:
Lc3ds:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dt
Lc3du:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r38R_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3dt:
	jmp *-16(%r13)
	.long  _s3bg_info - _s3bg_info_dsp
.text
.align 3
_s3bm_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bm_info)+32
	.quad	0
	.quad	244813135888
_s3bm_info:
Lc3dv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dw
Lc3dx:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3dz
Lc3dy:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s3bl_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s3bg_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3dz:
	movq $32,904(%r13)
Lc3dw:
	jmp *-16(%r13)
	.long  _s3bm_info - _s3bm_info_dsp
.const
.align 3
.align 0
_c3dE_str:
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s3bf_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bf_info)+16
	.quad	0
	.quad	4294967312
_s3bf_info:
Lc3dF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dG
Lc3dH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3dE_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3dG:
	jmp *-16(%r13)
	.long  _s3bf_info - _s3bf_info_dsp
.text
.align 3
_r3b1_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_r3b1_info)+16
	.quad	0
	.quad	2194728288278
_r3b1_info:
Lc3dI:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3dN
Lc3dO:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3ct
Lc3cs:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c3cu_info(%rip),%rax
	movq %rax,-24(%rbp)
	leaq _parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure(%rip),%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc3cu
Lc3cv:
	jmp *(%rbx)
Lc3ct:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3c2_srt-(_c3cu_info)+16
	.quad	0
	.quad	1095216660512
_c3cu_info:
Lc3cu:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc3dM
Lc3dL:
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
	leaq _s3bp_info(%rip),%rbx
	movq %rbx,-152(%r12)
	leaq -152(%r12),%rbx
	leaq _s3bn_info(%rip),%rcx
	movq %rcx,-136(%r12)
	leaq -136(%r12),%rcx
	leaq _s3bm_info(%rip),%rdx
	movq %rdx,-120(%r12)
	leaq -120(%r12),%rdx
	leaq _s3bf_info(%rip),%rsi
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
Lc3dM:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3dN:
	jmp *-16(%r13)
	.long  _r3b1_info - _r3b1_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_f95Def_closure
_F95ParserCommon_f95Def_closure:
	.quad	_stg_IND_STATIC_info
	.quad	_r3b1_closure
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
_s3bq_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bq_info)+0
	.quad	0
	.quad	12884901904
_s3bq_info:
Lc3f2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3f3
Lc3f4:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3f3:
	jmp *-16(%r13)
	.long  _s3bq_info - _s3bq_info_dsp
.text
.align 3
_F95ParserCommon_lexer_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_F95ParserCommon_lexer_info)+0
	.quad	0
	.quad	9083855831062
.globl _F95ParserCommon_lexer_info
_F95ParserCommon_lexer_info:
Lc3f5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3f6
Lc3f7:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3f9
Lc3f8:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3eX
Lc3eW:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s3bq_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _r3b1_closure(%rip),%rsi
	movq %rax,%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3eX:
	jmp *(%rbx)
Lc3f9:
	movq $16,904(%r13)
Lc3f6:
	jmp *-16(%r13)
	.long  _F95ParserCommon_lexer_info - _F95ParserCommon_lexer_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_parens_info)+96
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_parens_info
_F95ParserCommon_parens_info:
Lc3fr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fs
Lc3ft:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3fq
Lc3fp:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_parens_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3fq:
	jmp *(%rbx)
Lc3fs:
	jmp *-16(%r13)
	.long  _F95ParserCommon_parens_info - _F95ParserCommon_parens_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_commaSep_info)+104
	.quad	0
	.quad	12884901910
.globl _F95ParserCommon_commaSep_info
_F95ParserCommon_commaSep_info:
Lc3fG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fH
Lc3fI:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3fF
Lc3fE:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3fF:
	jmp *(%rbx)
Lc3fH:
	jmp *-16(%r13)
	.long  _F95ParserCommon_commaSep_info - _F95ParserCommon_commaSep_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_commaSep1_info)+104
	.quad	0
	.quad	21474836502
.globl _F95ParserCommon_commaSep1_info
_F95ParserCommon_commaSep1_info:
Lc3fV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fW
Lc3fX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3fU
Lc3fT:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3fU:
	jmp *(%rbx)
Lc3fW:
	jmp *-16(%r13)
	.long  _F95ParserCommon_commaSep1_info - _F95ParserCommon_commaSep1_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_whiteSpace_info)+104
	.quad	0
	.quad	38654705686
.globl _F95ParserCommon_whiteSpace_info
_F95ParserCommon_whiteSpace_info:
Lc3ga:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gb
Lc3gc:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3g9
Lc3g8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3g9:
	jmp *(%rbx)
Lc3gb:
	jmp *-16(%r13)
	.long  _F95ParserCommon_whiteSpace_info - _F95ParserCommon_whiteSpace_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_symbol_info)+104
	.quad	0
	.quad	73014444054
.globl _F95ParserCommon_symbol_info
_F95ParserCommon_symbol_info:
Lc3gp:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gq
Lc3gr:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3go
Lc3gn:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_symbol_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3go:
	jmp *(%rbx)
Lc3gq:
	jmp *-16(%r13)
	.long  _F95ParserCommon_symbol_info - _F95ParserCommon_symbol_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_word_info)+104
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_word_info
_F95ParserCommon_word_info:
Lc3gE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gF
Lc3gG:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3gD
Lc3gC:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3gD:
	jmp *(%rbx)
Lc3gF:
	jmp *-16(%r13)
	.long  _F95ParserCommon_word_info - _F95ParserCommon_word_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_identifier_info)+104
	.quad	0
	.quad	141733920790
.globl _F95ParserCommon_identifier_info
_F95ParserCommon_identifier_info:
Lc3gT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3gU
Lc3gV:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3gS
Lc3gR:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_identifier_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3gS:
	jmp *(%rbx)
Lc3gU:
	jmp *-16(%r13)
	.long  _F95ParserCommon_identifier_info - _F95ParserCommon_identifier_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_reserved_info)+104
	.quad	0
	.quad	279172874262
.globl _F95ParserCommon_reserved_info
_F95ParserCommon_reserved_info:
Lc3h8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3h9
Lc3ha:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3h7
Lc3h6:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reserved_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3h7:
	jmp *(%rbx)
Lc3h9:
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
	.quad	_S3c2_srt-(_F95ParserCommon_reservedOp_info)+104
	.quad	0
	.quad	554050781206
.globl _F95ParserCommon_reservedOp_info
_F95ParserCommon_reservedOp_info:
Lc3hn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ho
Lc3hp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3hm
Lc3hl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3hm:
	jmp *(%rbx)
Lc3ho:
	jmp *-16(%r13)
	.long  _F95ParserCommon_reservedOp_info - _F95ParserCommon_reservedOp_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_integer_info)+104
	.quad	0
	.quad	1103806595094
.globl _F95ParserCommon_integer_info
_F95ParserCommon_integer_info:
Lc3hC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3hD
Lc3hE:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3hB
Lc3hA:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_integer_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3hB:
	jmp *(%rbx)
Lc3hD:
	jmp *-16(%r13)
	.long  _F95ParserCommon_integer_info - _F95ParserCommon_integer_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_charLiteral_info)+104
	.quad	0
	.quad	2203318222870
.globl _F95ParserCommon_charLiteral_info
_F95ParserCommon_charLiteral_info:
Lc3hR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3hS
Lc3hT:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3hQ
Lc3hP:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3hQ:
	jmp *(%rbx)
Lc3hS:
	jmp *-16(%r13)
	.long  _F95ParserCommon_charLiteral_info - _F95ParserCommon_charLiteral_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_stringLiteral_info)+104
	.quad	0
	.quad	4402341478422
.globl _F95ParserCommon_stringLiteral_info
_F95ParserCommon_stringLiteral_info:
Lc3i6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3i7
Lc3i8:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3i5
Lc3i4:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3i5:
	jmp *(%rbx)
Lc3i7:
	jmp *-16(%r13)
	.long  _F95ParserCommon_stringLiteral_info - _F95ParserCommon_stringLiteral_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_comma_info)+104
	.quad	0
	.quad	8800387989526
.globl _F95ParserCommon_comma_info
_F95ParserCommon_comma_info:
Lc3il:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3im
Lc3in:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3ik
Lc3ij:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_comma_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3ik:
	jmp *(%rbx)
Lc3im:
	jmp *-16(%r13)
	.long  _F95ParserCommon_comma_info - _F95ParserCommon_comma_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_semi_info)+104
	.quad	0
	.quad	17596481011734
.globl _F95ParserCommon_semi_info
_F95ParserCommon_semi_info:
Lc3iA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iB
Lc3iC:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3iz
Lc3iy:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_semi_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3iz:
	jmp *(%rbx)
Lc3iB:
	jmp *-16(%r13)
	.long  _F95ParserCommon_semi_info - _F95ParserCommon_semi_info_dsp
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
	.quad	_S3c2_srt-(_F95ParserCommon_natural_info)+104
	.quad	0
	.quad	35188667056150
.globl _F95ParserCommon_natural_info
_F95ParserCommon_natural_info:
Lc3iP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iQ
Lc3iR:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3iO
Lc3iN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _F95ParserCommon_lexer_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziToken_natural_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3iO:
	jmp *(%rbx)
Lc3iQ:
	jmp *-16(%r13)
	.long  _F95ParserCommon_natural_info - _F95ParserCommon_natural_info_dsp
.data
.align 3
.align 0
_r3b2_closure:
	.quad	_r3b2_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r3b2_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_r3b2_info)+0
	.quad	0
	.quad	12884901910
_r3b2_info:
Lc3j4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3j5
Lc3j6:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc3j3
Lc3j2:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3j3:
	jmp *(%rbx)
Lc3j5:
	jmp *-16(%r13)
	.long  _r3b2_info - _r3b2_info_dsp
.data
.align 3
.align 0
.globl _F95ParserCommon_runzuparser_closure
_F95ParserCommon_runzuparser_closure:
	.quad	_F95ParserCommon_runzuparser_info
	.quad	0
.text
.align 3
_s3bw_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bw_info)+216
	.quad	1
	.quad	4294967313
_s3bw_info:
Lc3jy:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jz
Lc3jA:
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
Lc3jz:
	jmp *-16(%r13)
	.long  _s3bw_info - _s3bw_info_dsp
.const
.align 3
.align 0
_c3jF_str:
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
_s3bv_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bv_info)+16
	.quad	0
	.quad	4294967312
_s3bv_info:
Lc3jG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jH
Lc3jI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3jF_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3jH:
	jmp *-16(%r13)
	.long  _s3bv_info - _s3bv_info_dsp
.text
.align 3
_F95ParserCommon_runzuparser_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_F95ParserCommon_runzuparser_info)+16
	.quad	8589934607
	.quad	0
	.quad	9079256853073887247
.globl _F95ParserCommon_runzuparser_info
_F95ParserCommon_runzuparser_info:
Lc3jQ:
	leaq -8(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3k2
Lc3k3:
	leaq _c3jq_info(%rip),%rax
	movq %rax,-8(%rbp)
	movq %rsi,%r8
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %r14,%rsi
	leaq _r3b2_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziPrim_parse_closure(%rip),%rbx
	addq $-8,%rbp
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S3c2_srt-(_c3jq_info)+16
	.quad	0
	.quad	1008806320825958432
_c3jq_info:
Lc3jq:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc3jO
Lc3jP:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc3k1
Lc3k0:
	movq 7(%rbx),%rax
	leaq _s3bw_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s3bv_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c3jR_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc3jO:
	movq 6(%rbx),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp _stg_ap_0_fast
.text
.align 3
	.quad	_S3c2_srt-(_c3jR_info)+232
	.quad	0
	.quad	4294967328
_c3jR_info:
Lc3jR:
	movq %rbx,%r14
	addq $8,%rbp
	jmp _base_GHCziErr_error_info
Lc3k1:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3k2:
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
_s3bA_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bA_info)+0
	.quad	0
	.quad	12884901904
_s3bA_info:
Lc3kC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3kD
Lc3kE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure(%rip),%r14
	leaq _parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3kD:
	jmp *-16(%r13)
	.long  _s3bA_info - _s3bA_info_dsp
.text
.align 3
_s3bH_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bH_info)+216
	.quad	1
	.quad	279172874257
_s3bH_info:
Lc3kS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3kT
Lc3kU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure(%rip),%r14
	leaq _base_SystemziIO_print_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3kT:
	jmp *-16(%r13)
	.long  _s3bH_info - _s3bH_info_dsp
.const
.align 3
.align 0
_c3l3_str:
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
_s3bF_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bF_info)+16
	.quad	0
	.quad	4294967312
_s3bF_info:
Lc3l4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3l5
Lc3l6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3l3_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3l5:
	jmp *-16(%r13)
	.long  _s3bF_info - _s3bF_info_dsp
.text
.align 3
_s3bG_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bG_info)+272
	.quad	0
	.quad	12884901904
_s3bG_info:
Lc3l7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3l8
Lc3l9:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3lb
Lc3la:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s3bF_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStr_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3lb:
	movq $16,904(%r13)
Lc3l8:
	jmp *-16(%r13)
	.long  _s3bG_info - _s3bG_info_dsp
.text
.align 3
_s3bK_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s3bK_info:
Lc3lr:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ls
Lc3lt:
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
Lc3ls:
	jmp *-16(%r13)
	.long  _s3bK_info - _s3bK_info_dsp
.text
.align 3
_s3bN_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bN_info)+224
	.quad	2
	.quad	4294967315
_s3bN_info:
Lc3lu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3lv
Lc3lw:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc3ly
Lc3lx:
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
	leaq _s3bK_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rcx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3ly:
	movq $56,904(%r13)
Lc3lv:
	jmp *-16(%r13)
	.long  _s3bN_info - _s3bN_info_dsp
.const
.align 3
.align 0
_c3lD_str:
	.byte	32
	.byte	32
	.byte	32
	.byte	32
	.byte	0
.text
.align 3
_s3bJ_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bJ_info)+280
	.quad	0
	.quad	4294967312
_s3bJ_info:
Lc3lE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3lF
Lc3lG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3lD_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3lF:
	jmp *-16(%r13)
	.long  _s3bJ_info - _s3bJ_info_dsp
.text
.align 3
_s3bO_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bO_info)+224
	.quad	2
	.quad	554050781203
_s3bO_info:
Lc3lH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3lI
Lc3lJ:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc3lL
Lc3lK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s3bN_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s3bJ_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3lL:
	movq $48,904(%r13)
Lc3lI:
	jmp *-16(%r13)
	.long  _s3bO_info - _s3bO_info_dsp
.text
.align 3
_s3bP_info_dsp:
.text
.align 3
	.quad	_S3c2_srt-(_s3bP_info)+216
	.quad	8589934607
	.quad	2
	.quad	8568459755532
_s3bP_info:
Lc3lT:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3m0
Lc3m1:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _c3kK_info(%rip),%rcx
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
	.quad	_S3c2_srt-(_c3kK_info)+216
	.quad	1
	.quad	8534100017184
_c3kK_info:
Lc3kK:
	movq 8(%rbp),%rax
	movq %rbx,%rcx
	andq $7,%rcx
	cmpq $2,%rcx
	jae Lc3lR
Lc3lS:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc3lZ
Lc3lY:
	movq 7(%rbx),%rax
	leaq _s3bH_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s3bG_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-8(%rbp)
	movq %rbx,(%rbp)
	movq %rax,8(%rbp)
	addq $-8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc3lR:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc3lW
Lc3lV:
	movq 6(%rbx),%rbx
	leaq _s3bO_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $16,%rbp
	jmp _stg_ap_p_fast
Lc3lW:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3lZ:
	movq $40,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3m0:
	jmp *-8(%r13)
	.long  _s3bP_info - _s3bP_info_dsp
.const_data
.align 3
.align 0
_u3m7_srtd:
	.quad	_S3c2_srt
	.quad	39
	.quad	542642274307
.text
.align 3
_F95ParserCommon_runzuparserzuprint_info_dsp:
.text
.align 3
	.quad	_u3m7_srtd-(_F95ParserCommon_runzuparserzuprint_info)+0
	.quad	4294967301
	.quad	0
	.quad	-4294967281
.globl _F95ParserCommon_runzuparserzuprint_info
_F95ParserCommon_runzuparserzuprint_info:
Lc3m2:
Lc3m4:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc3m6
Lc3m5:
	leaq _s3bA_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -32(%r12),%rax
	leaq _s3bP_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,-8(%r12)
	movq %rax,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	jmp *(%rbp)
Lc3m6:
	movq $40,904(%r13)
Lc3m3:
	leaq _F95ParserCommon_runzuparserzuprint_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _F95ParserCommon_runzuparserzuprint_info - _F95ParserCommon_runzuparserzuprint_info_dsp
.const_data
.align 3
.align 0
_S3c2_srt:
	.quad	_transformerszm0zi3zi0zi0_DataziFunctorziIdentity_zdfMonadIdentity_closure
	.quad	_parseczm3zi1zi5_TextziParsecziString_zdfStreamZMZNmtok_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_oneOf_closure
	.quad	_r38R_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_opLetter_closure
	.quad	_r3b1_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_char_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_zlzbzg_closure
	.quad	_parseczm3zi1zi5_TextziParsecziChar_alphaNum_closure
	.quad	_parseczm3zi1zi5_TextziParsecziLanguage_emptyDef_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_makeTokenParser_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_parens_closure
	.quad	_F95ParserCommon_lexer_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_commaSep_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_commaSep1_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_whiteSpace_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_symbol_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_identifier_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_reserved_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_reservedOp_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_integer_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_charLiteral_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_stringLiteral_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_comma_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_semi_closure
	.quad	_parseczm3zi1zi5_TextziParsecziToken_natural_closure
	.quad	_parseczm3zi1zi5_TextziParsecziError_zdfShowParseError_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_GHCziErr_error_closure
	.quad	_parseczm3zi1zi5_TextziParsecziPrim_parse_closure
	.quad	_F95ParserCommon_runzuparser_closure
	.quad	_r3b2_closure
	.quad	_base_SystemziIO_print_closure
	.quad	_base_SystemziIO_putStr_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_base_SystemziIO_putStrLn_closure
	.quad	_F95ParserCommon_runzuparserzuprint_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

