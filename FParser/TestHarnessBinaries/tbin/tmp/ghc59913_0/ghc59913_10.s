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
_s2ti_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2ti_info)+0
	.quad	1
	.quad	12884901905
_s2ti_info:
Lc2tC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2tD
Lc2tE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _base_GHCziUnicode_toLower_closure(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2tD:
	jmp *-16(%r13)
	.long  _s2ti_info - _s2ti_info_dsp
.text
.align 3
_s2td_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2td_info)+16
	.quad	1
	.quad	4294967313
_s2td_info:
Lc2u0:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2u1
Lc2u2:
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
Lc2u1:
	jmp *-16(%r13)
	.long  _s2td_info - _s2td_info_dsp
.text
.align 3
_s2tb_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tb_info)+16
	.quad	1
	.quad	4294967313
_s2tb_info:
Lc2u7:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2u8
Lc2u9:
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
Lc2u8:
	jmp *-16(%r13)
	.long  _s2tb_info - _s2tb_info_dsp
.text
.align 3
_s2te_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2te_info)+16
	.quad	1
	.quad	12884901905
_s2te_info:
Lc2ua:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ub
Lc2uc:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2ue
Lc2ud:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2td_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2tb_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2ue:
	movq $48,904(%r13)
Lc2ub:
	jmp *-16(%r13)
	.long  _s2te_info - _s2te_info_dsp
.text
.align 3
_s2t9_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2t9_info)+16
	.quad	1
	.quad	4294967313
_s2t9_info:
Lc2uj:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uk
Lc2ul:
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
Lc2uk:
	jmp *-16(%r13)
	.long  _s2t9_info - _s2t9_info_dsp
.text
.align 3
_s2tf_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tf_info)+16
	.quad	1
	.quad	12884901905
_s2tf_info:
Lc2um:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2un
Lc2uo:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2uq
Lc2up:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2te_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2t9_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2uq:
	movq $48,904(%r13)
Lc2un:
	jmp *-16(%r13)
	.long  _s2tf_info - _s2tf_info_dsp
.text
.align 3
_s2t6_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2t6_info)+32
	.quad	1
	.quad	4294967313
_s2t6_info:
Lc2uz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uA
Lc2uB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_DataziChar_isSeparator_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uA:
	jmp *-16(%r13)
	.long  _s2t6_info - _s2t6_info_dsp
.text
.align 3
_s2t7_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2t7_info)+32
	.quad	1
	.quad	12884901905
_s2t7_info:
Lc2uC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uD
Lc2uE:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2uG
Lc2uF:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2t6_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uG:
	movq $24,904(%r13)
Lc2uD:
	jmp *-16(%r13)
	.long  _s2t7_info - _s2t7_info_dsp
.text
.align 3
_s2tg_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tg_info)+16
	.quad	1
	.quad	64424509457
_s2tg_info:
Lc2uH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uI
Lc2uJ:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2uL
Lc2uK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2tf_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2t7_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2uL:
	movq $48,904(%r13)
Lc2uI:
	jmp *-16(%r13)
	.long  _s2tg_info - _s2tg_info_dsp
.text
.align 3
_s2t4_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2t4_info)+48
	.quad	1
	.quad	4294967313
_s2t4_info:
Lc2uU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uV
Lc2uW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziUnicode_isSpace_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2uV:
	jmp *-16(%r13)
	.long  _s2t4_info - _s2t4_info_dsp
.text
.align 3
_s2t5_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2t5_info)+40
	.quad	1
	.quad	12884901905
_s2t5_info:
Lc2uX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2uY
Lc2uZ:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2v1
Lc2v0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2t4_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2v1:
	movq $24,904(%r13)
Lc2uY:
	jmp *-16(%r13)
	.long  _s2t5_info - _s2t5_info_dsp
.text
.align 3
_s2th_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2th_info)+16
	.quad	4294967301
	.quad	4294967296
	.quad	133143986187
_s2th_info:
Lc2v2:
Lc2v4:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2v6
Lc2v5:
	leaq _s2tg_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2t5_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2v6:
	movq $48,904(%r13)
Lc2v3:
	jmp *-8(%r13)
	.long  _s2th_info - _s2th_info_dsp
.text
.align 3
_NormaliseF95Code_normalisezuF95zucode_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_NormaliseF95Code_normalisezuF95zucode_info)+0
	.quad	4294967301
	.quad	0
	.quad	2194728288271
.globl _NormaliseF95Code_normalisezuF95zucode_info
_NormaliseF95Code_normalisezuF95zucode_info:
Lc2v7:
Lc2v9:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2vb
Lc2va:
	leaq _s2ti_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2th_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2vb:
	movq $40,904(%r13)
Lc2v8:
	leaq _NormaliseF95Code_normalisezuF95zucode_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _NormaliseF95Code_normalisezuF95zucode_info - _NormaliseF95Code_normalisezuF95zucode_info_dsp
.data
.align 3
.align 0
_r2sr_closure:
	.quad	_r2sr_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r2sr_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_r2sr_info)+16
	.quad	0
	.quad	554050781206
_r2sr_info:
Lc2ws:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wt
Lc2wu:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2wr
Lc2wq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wr:
	jmp *(%rbx)
Lc2wt:
	jmp *-16(%r13)
	.long  _r2sr_info - _r2sr_info_dsp
.data
.align 3
.align 0
.globl _NormaliseF95Code_normalisezuF95zucodezulines_closure
_NormaliseF95Code_normalisezuF95zucodezulines_closure:
	.quad	_NormaliseF95Code_normalisezuF95zucodezulines_info
	.quad	0
.text
.align 3
_s2tq_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tq_info)+0
	.quad	1
	.quad	1103806595089
_s2tq_info:
Lc2wJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wK
Lc2wL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _NormaliseF95Code_normalisezuF95zucode_closure+1(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2wK:
	jmp *-16(%r13)
	.long  _s2tq_info - _s2tq_info_dsp
.text
.align 3
_s2tm_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tm_info)+80
	.quad	1
	.quad	4294967313
_s2tm_info:
Lc2wZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2x0
Lc2x1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2x0:
	jmp *-16(%r13)
	.long  _s2tm_info - _s2tm_info_dsp
.text
.align 3
_s2to_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2to_info)+16
	.quad	1
	.quad	1103806595089
_s2to_info:
Lc2x2:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2x3
Lc2x4:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2x6
Lc2x5:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2tm_info(%rip),%rbx
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
Lc2x6:
	movq $24,904(%r13)
Lc2x3:
	jmp *-16(%r13)
	.long  _s2to_info - _s2to_info_dsp
.text
.align 3
_s2tl_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tl_info)+88
	.quad	1
	.quad	4294967313
_s2tl_info:
Lc2xb:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xc
Lc2xd:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _r2sr_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,-32(%rbp)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2xc:
	jmp *-16(%r13)
	.long  _s2tl_info - _s2tl_info_dsp
.text
.align 3
_s2tp_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_s2tp_info)+16
	.quad	4294967301
	.quad	4294967296
	.quad	3311419785227
_s2tp_info:
Lc2xe:
Lc2xg:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2xi
Lc2xh:
	leaq _s2to_info(%rip),%rax
	movq %rax,-40(%r12)
	movq %r14,-24(%r12)
	leaq -40(%r12),%rax
	leaq _s2tl_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2xi:
	movq $48,904(%r13)
Lc2xf:
	jmp *-8(%r13)
	.long  _s2tp_info - _s2tp_info_dsp
.text
.align 3
_NormaliseF95Code_normalisezuF95zucodezulines_info_dsp:
.text
.align 3
	.quad	_S2vc_srt-(_NormaliseF95Code_normalisezuF95zucodezulines_info)+0
	.quad	4294967301
	.quad	0
	.quad	32491427594255
.globl _NormaliseF95Code_normalisezuF95zucodezulines_info
_NormaliseF95Code_normalisezuF95zucodezulines_info:
Lc2xj:
Lc2xl:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2xn
Lc2xm:
	leaq _s2tq_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2tp_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2xn:
	movq $40,904(%r13)
Lc2xk:
	leaq _NormaliseF95Code_normalisezuF95zucodezulines_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _NormaliseF95Code_normalisezuF95zucodezulines_info - _NormaliseF95Code_normalisezuF95zucodezulines_info_dsp
.const_data
.align 3
.align 0
_S2vc_srt:
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
	.quad	_r2sr_closure
	.quad	_NormaliseF95Code_normalisezuF95zucodezulines_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

