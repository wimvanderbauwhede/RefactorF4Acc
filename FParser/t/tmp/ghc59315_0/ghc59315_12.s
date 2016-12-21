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
_s2MT_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MT_info)+0
	.quad	1
	.quad	12884901905
_s2MT_info:
Lc2Nd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ne
Lc2Nf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _base_GHCziUnicode_toLower_closure(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Ne:
	jmp *-16(%r13)
	.long  _s2MT_info - _s2MT_info_dsp
.text
.align 3
_s2MO_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MO_info)+16
	.quad	1
	.quad	4294967313
_s2MO_info:
Lc2NB:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NC
Lc2ND:
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
Lc2NC:
	jmp *-16(%r13)
	.long  _s2MO_info - _s2MO_info_dsp
.text
.align 3
_s2MM_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MM_info)+16
	.quad	1
	.quad	4294967313
_s2MM_info:
Lc2NI:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NJ
Lc2NK:
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
Lc2NJ:
	jmp *-16(%r13)
	.long  _s2MM_info - _s2MM_info_dsp
.text
.align 3
_s2MP_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MP_info)+16
	.quad	1
	.quad	12884901905
_s2MP_info:
Lc2NL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NM
Lc2NN:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2NP
Lc2NO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2MO_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2MM_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2NP:
	movq $48,904(%r13)
Lc2NM:
	jmp *-16(%r13)
	.long  _s2MP_info - _s2MP_info_dsp
.text
.align 3
_s2MK_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MK_info)+16
	.quad	1
	.quad	4294967313
_s2MK_info:
Lc2NU:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NV
Lc2NW:
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
Lc2NV:
	jmp *-16(%r13)
	.long  _s2MK_info - _s2MK_info_dsp
.text
.align 3
_s2MQ_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MQ_info)+16
	.quad	1
	.quad	12884901905
_s2MQ_info:
Lc2NX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NY
Lc2NZ:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2O1
Lc2O0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2MP_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2MK_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2O1:
	movq $48,904(%r13)
Lc2NY:
	jmp *-16(%r13)
	.long  _s2MQ_info - _s2MQ_info_dsp
.text
.align 3
_s2MH_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MH_info)+32
	.quad	1
	.quad	4294967313
_s2MH_info:
Lc2Oa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ob
Lc2Oc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_DataziChar_isSeparator_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ob:
	jmp *-16(%r13)
	.long  _s2MH_info - _s2MH_info_dsp
.text
.align 3
_s2MI_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MI_info)+32
	.quad	1
	.quad	12884901905
_s2MI_info:
Lc2Od:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oe
Lc2Of:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Oh
Lc2Og:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2MH_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Oh:
	movq $24,904(%r13)
Lc2Oe:
	jmp *-16(%r13)
	.long  _s2MI_info - _s2MI_info_dsp
.text
.align 3
_s2MR_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MR_info)+16
	.quad	1
	.quad	64424509457
_s2MR_info:
Lc2Oi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oj
Lc2Ok:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2Om
Lc2Ol:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2MQ_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2MI_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Om:
	movq $48,904(%r13)
Lc2Oj:
	jmp *-16(%r13)
	.long  _s2MR_info - _s2MR_info_dsp
.text
.align 3
_s2MF_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MF_info)+48
	.quad	1
	.quad	4294967313
_s2MF_info:
Lc2Ov:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ow
Lc2Ox:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziUnicode_isSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ow:
	jmp *-16(%r13)
	.long  _s2MF_info - _s2MF_info_dsp
.text
.align 3
_s2MG_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MG_info)+40
	.quad	1
	.quad	12884901905
_s2MG_info:
Lc2Oy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oz
Lc2OA:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2OC
Lc2OB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2MF_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2OC:
	movq $24,904(%r13)
Lc2Oz:
	jmp *-16(%r13)
	.long  _s2MG_info - _s2MG_info_dsp
.text
.align 3
_s2MS_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MS_info)+16
	.quad	4294967301
	.quad	4294967296
	.quad	133143986187
_s2MS_info:
Lc2OD:
Lc2OF:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2OH
Lc2OG:
	leaq _s2MR_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2MG_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2OH:
	movq $48,904(%r13)
Lc2OE:
	jmp *-8(%r13)
	.long  _s2MS_info - _s2MS_info_dsp
.text
.align 3
_NormaliseF95Code_normalisezuF95zucode_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_NormaliseF95Code_normalisezuF95zucode_info)+0
	.quad	4294967301
	.quad	0
	.quad	2194728288271
.globl _NormaliseF95Code_normalisezuF95zucode_info
_NormaliseF95Code_normalisezuF95zucode_info:
Lc2OI:
Lc2OK:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2OM
Lc2OL:
	leaq _s2MT_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2MS_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2OM:
	movq $40,904(%r13)
Lc2OJ:
	leaq _NormaliseF95Code_normalisezuF95zucode_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _NormaliseF95Code_normalisezuF95zucode_info - _NormaliseF95Code_normalisezuF95zucode_info_dsp
.data
.align 3
.align 0
_r2M2_closure:
	.quad	_r2M2_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2M2_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_r2M2_info)+16
	.quad	0
	.quad	554050781206
_r2M2_info:
Lc2Q3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Q4
Lc2Q5:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2Q2
Lc2Q1:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Q2:
	jmp *(%rbx)
Lc2Q4:
	jmp *-16(%r13)
	.long  _r2M2_info - _r2M2_info_dsp
.data
.align 3
.align 0
.globl _NormaliseF95Code_normalisezuF95zucodezulines_closure
_NormaliseF95Code_normalisezuF95zucodezulines_closure:
	.quad	_NormaliseF95Code_normalisezuF95zucodezulines_info
	.quad	0
.text
.align 3
_s2N1_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2N1_info)+0
	.quad	1
	.quad	1103806595089
_s2N1_info:
Lc2Qk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ql
Lc2Qm:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _NormaliseF95Code_normalisezuF95zucode_closure+1(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Ql:
	jmp *-16(%r13)
	.long  _s2N1_info - _s2N1_info_dsp
.text
.align 3
_s2MX_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MX_info)+80
	.quad	1
	.quad	4294967313
_s2MX_info:
Lc2QA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QB
Lc2QC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2QB:
	jmp *-16(%r13)
	.long  _s2MX_info - _s2MX_info_dsp
.text
.align 3
_s2MZ_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MZ_info)+16
	.quad	1
	.quad	1103806595089
_s2MZ_info:
Lc2QD:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QE
Lc2QF:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2QH
Lc2QG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2MX_info(%rip),%rbx
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
Lc2QH:
	movq $24,904(%r13)
Lc2QE:
	jmp *-16(%r13)
	.long  _s2MZ_info - _s2MZ_info_dsp
.text
.align 3
_s2MW_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2MW_info)+88
	.quad	1
	.quad	4294967313
_s2MW_info:
Lc2QM:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2QN
Lc2QO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _r2M2_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2QN:
	jmp *-16(%r13)
	.long  _s2MW_info - _s2MW_info_dsp
.text
.align 3
_s2N0_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_s2N0_info)+16
	.quad	4294967301
	.quad	4294967296
	.quad	3311419785227
_s2N0_info:
Lc2QP:
Lc2QR:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2QT
Lc2QS:
	leaq _s2MZ_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2MW_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2QT:
	movq $48,904(%r13)
Lc2QQ:
	jmp *-8(%r13)
	.long  _s2N0_info - _s2N0_info_dsp
.text
.align 3
_NormaliseF95Code_normalisezuF95zucodezulines_info_dsp:
.text
.align 3
	.quad	_S2ON_srt-(_NormaliseF95Code_normalisezuF95zucodezulines_info)+0
	.quad	4294967301
	.quad	0
	.quad	32491427594255
.globl _NormaliseF95Code_normalisezuF95zucodezulines_info
_NormaliseF95Code_normalisezuF95zucodezulines_info:
Lc2QU:
Lc2QW:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2QY
Lc2QX:
	leaq _s2N1_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2N0_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2QY:
	movq $40,904(%r13)
Lc2QV:
	leaq _NormaliseF95Code_normalisezuF95zucodezulines_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _NormaliseF95Code_normalisezuF95zucodezulines_info - _NormaliseF95Code_normalisezuF95zucodezulines_info_dsp
.const_data
.align 3
.align 0
_S2ON_srt:
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
	.quad	_r2M2_closure
	.quad	_NormaliseF95Code_normalisezuF95zucodezulines_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

