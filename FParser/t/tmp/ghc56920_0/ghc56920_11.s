.data
.align 3
.align 0
.globl ___stginit_NormaliseF95Code
___stginit_NormaliseF95Code:
.data
.align 3
.align 0
.globl _NormaliseF95Code_normalisezuF95zucode_closure
_NormaliseF95Code_normalisezuF95zucode_closure:
	.quad	_NormaliseF95Code_normalisezuF95zucode_info
	.quad	0
.text
.align 3
_s2Bg_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bg_info)+0
	.quad	1
	.quad	12884901905
_s2Bg_info:
Lc2BA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BB
Lc2BC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _base_GHCziUnicode_toLower_closure(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2BB:
	jmp *-16(%r13)
	.long  _s2Bg_info - _s2Bg_info_dsp
.text
.align 3
_s2Bb_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bb_info)+16
	.quad	1
	.quad	4294967313
_s2Bb_info:
Lc2BY:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2BZ
Lc2C0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $161,%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2BZ:
	jmp *-16(%r13)
	.long  _s2Bb_info - _s2Bb_info_dsp
.text
.align 3
_s2B9_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2B9_info)+16
	.quad	1
	.quad	4294967313
_s2B9_info:
Lc2C5:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2C6
Lc2C7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $209,%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2C6:
	jmp *-16(%r13)
	.long  _s2B9_info - _s2B9_info_dsp
.text
.align 3
_s2Bc_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bc_info)+16
	.quad	1
	.quad	12884901905
_s2Bc_info:
Lc2C8:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2C9
Lc2Ca:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Cc
Lc2Cb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Bb_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2B9_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Cc:
	movq $48,904(%r13)
Lc2C9:
	jmp *-16(%r13)
	.long  _s2Bc_info - _s2Bc_info_dsp
.text
.align 3
_s2B7_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2B7_info)+16
	.quad	1
	.quad	4294967313
_s2B7_info:
Lc2Ch:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ci
Lc2Cj:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $145,%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2Ci:
	jmp *-16(%r13)
	.long  _s2B7_info - _s2B7_info_dsp
.text
.align 3
_s2Bd_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bd_info)+16
	.quad	1
	.quad	12884901905
_s2Bd_info:
Lc2Ck:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cl
Lc2Cm:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Co
Lc2Cn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Bc_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2B7_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Co:
	movq $48,904(%r13)
Lc2Cl:
	jmp *-16(%r13)
	.long  _s2Bd_info - _s2Bd_info_dsp
.text
.align 3
_s2B4_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2B4_info)+32
	.quad	1
	.quad	4294967313
_s2B4_info:
Lc2Cx:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Cy
Lc2Cz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_DataziChar_isSeparator_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Cy:
	jmp *-16(%r13)
	.long  _s2B4_info - _s2B4_info_dsp
.text
.align 3
_s2B5_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2B5_info)+32
	.quad	1
	.quad	12884901905
_s2B5_info:
Lc2CA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CB
Lc2CC:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2CE
Lc2CD:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2B4_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2CE:
	movq $24,904(%r13)
Lc2CB:
	jmp *-16(%r13)
	.long  _s2B5_info - _s2B5_info_dsp
.text
.align 3
_s2Be_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Be_info)+16
	.quad	1
	.quad	64424509457
_s2Be_info:
Lc2CF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CG
Lc2CH:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2CJ
Lc2CI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Bd_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2B5_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2CJ:
	movq $48,904(%r13)
Lc2CG:
	jmp *-16(%r13)
	.long  _s2Be_info - _s2Be_info_dsp
.text
.align 3
_s2B2_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2B2_info)+48
	.quad	1
	.quad	4294967313
_s2B2_info:
Lc2CS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CT
Lc2CU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziUnicode_isSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2CT:
	jmp *-16(%r13)
	.long  _s2B2_info - _s2B2_info_dsp
.text
.align 3
_s2B3_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2B3_info)+40
	.quad	1
	.quad	12884901905
_s2B3_info:
Lc2CV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2CW
Lc2CX:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2CZ
Lc2CY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2B2_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2CZ:
	movq $24,904(%r13)
Lc2CW:
	jmp *-16(%r13)
	.long  _s2B3_info - _s2B3_info_dsp
.text
.align 3
_s2Bf_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bf_info)+16
	.quad	4294967301
	.quad	4294967296
	.quad	133143986187
_s2Bf_info:
Lc2D0:
Lc2D2:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2D4
Lc2D3:
	leaq _s2Be_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2B3_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2D4:
	movq $48,904(%r13)
Lc2D1:
	jmp *-8(%r13)
	.long  _s2Bf_info - _s2Bf_info_dsp
.text
.align 3
_NormaliseF95Code_normalisezuF95zucode_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_NormaliseF95Code_normalisezuF95zucode_info)+0
	.quad	4294967301
	.quad	0
	.quad	2194728288271
.globl _NormaliseF95Code_normalisezuF95zucode_info
_NormaliseF95Code_normalisezuF95zucode_info:
Lc2D5:
Lc2D7:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2D9
Lc2D8:
	leaq _s2Bg_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2Bf_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2D9:
	movq $40,904(%r13)
Lc2D6:
	leaq _NormaliseF95Code_normalisezuF95zucode_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _NormaliseF95Code_normalisezuF95zucode_info - _NormaliseF95Code_normalisezuF95zucode_info_dsp
.data
.align 3
.align 0
_r2Ap_closure:
	.quad	_r2Ap_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2Ap_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_r2Ap_info)+16
	.quad	0
	.quad	554050781206
_r2Ap_info:
Lc2Eq:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Er
Lc2Es:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Ep
Lc2Eo:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ep:
	jmp *(%rbx)
Lc2Er:
	jmp *-16(%r13)
	.long  _r2Ap_info - _r2Ap_info_dsp
.data
.align 3
.align 0
.globl _NormaliseF95Code_normalisezuF95zucodezulines_closure
_NormaliseF95Code_normalisezuF95zucodezulines_closure:
	.quad	_NormaliseF95Code_normalisezuF95zucodezulines_info
	.quad	0
.text
.align 3
_s2Bo_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bo_info)+0
	.quad	1
	.quad	1103806595089
_s2Bo_info:
Lc2EH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EI
Lc2EJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _NormaliseF95Code_normalisezuF95zucode_closure+1(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2EI:
	jmp *-16(%r13)
	.long  _s2Bo_info - _s2Bo_info_dsp
.text
.align 3
_s2Bk_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bk_info)+80
	.quad	1
	.quad	4294967313
_s2Bk_info:
Lc2EX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2EY
Lc2EZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2EY:
	jmp *-16(%r13)
	.long  _s2Bk_info - _s2Bk_info_dsp
.text
.align 3
_s2Bm_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bm_info)+16
	.quad	1
	.quad	1103806595089
_s2Bm_info:
Lc2F0:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2F1
Lc2F2:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2F4
Lc2F3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2Bk_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rax
	addq $529,%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2F4:
	movq $24,904(%r13)
Lc2F1:
	jmp *-16(%r13)
	.long  _s2Bm_info - _s2Bm_info_dsp
.text
.align 3
_s2Bj_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bj_info)+88
	.quad	1
	.quad	4294967313
_s2Bj_info:
Lc2F9:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Fa
Lc2Fb:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _r2Ap_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2Fa:
	jmp *-16(%r13)
	.long  _s2Bj_info - _s2Bj_info_dsp
.text
.align 3
_s2Bn_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_s2Bn_info)+16
	.quad	4294967301
	.quad	4294967296
	.quad	3311419785227
_s2Bn_info:
Lc2Fc:
Lc2Fe:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Fg
Lc2Ff:
	leaq _s2Bm_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2Bj_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2Fg:
	movq $48,904(%r13)
Lc2Fd:
	jmp *-8(%r13)
	.long  _s2Bn_info - _s2Bn_info_dsp
.text
.align 3
_NormaliseF95Code_normalisezuF95zucodezulines_info_dsp:
.text
.align 3
	.quad	_S2Da_srt-(_NormaliseF95Code_normalisezuF95zucodezulines_info)+0
	.quad	4294967301
	.quad	0
	.quad	32491427594255
.globl _NormaliseF95Code_normalisezuF95zucodezulines_info
_NormaliseF95Code_normalisezuF95zucodezulines_info:
Lc2Fh:
Lc2Fj:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2Fl
Lc2Fk:
	leaq _s2Bo_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2Bn_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2Fl:
	movq $40,904(%r13)
Lc2Fi:
	leaq _NormaliseF95Code_normalisezuF95zucodezulines_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _NormaliseF95Code_normalisezuF95zucodezulines_info - _NormaliseF95Code_normalisezuF95zucodezulines_info_dsp
.const_data
.align 3
.align 0
_S2Da_srt:
	.quad	_base_GHCziBase_map_closure
	.quad	_base_GHCziUnicode_toLower_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_ghczmprim_GHCziClasses_zaza_closure
	.quad	_base_DataziChar_isSeparator_closure
	.quad	_ghczmprim_GHCziClasses_not_closure
	.quad	_base_GHCziUnicode_isSpace_closure
	.quad	_base_GHCziList_filter_closure
	.quad	_NormaliseF95Code_normalisezuF95zucode_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_base_GHCziList_head_closure
	.quad	_r2Ap_closure
	.quad	_NormaliseF95Code_normalisezuF95zucodezulines_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

