.data
.align 3
.align 0
.globl ___stginit_Main
___stginit_Main:
.data
.align 3
.align 0
_r1BA_closure:
	.quad	_r1BA_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r1BA_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_r1BA_info)+0
	.quad	0
	.quad	12884901910
_r1BA_info:
Lc1EP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1EQ
Lc1ER:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1EO
Lc1EN:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _base_GHCziShow_zdfShowChar_closure(%rip),%r14
	leaq _base_GHCziShow_zdfShowZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1EO:
	jmp *(%rbx)
Lc1EQ:
	jmp *-16(%r13)
	.long  _r1BA_info - _r1BA_info_dsp
.data
.align 3
.align 0
_r1Cb_closure:
	.quad	_r1Cb_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r1Cb_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_r1Cb_info)+16
	.quad	0
	.quad	12884901910
_r1Cb_info:
Lc1F5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1F6
Lc1F7:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1F4
Lc1F3:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1F4:
	jmp *(%rbx)
Lc1F6:
	jmp *-16(%r13)
	.long  _r1Cb_info - _r1Cb_info_dsp
.data
.align 3
.align 0
_s1Ez_closure:
	.quad	_s1Ez_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Ft_str:
	.byte	68
	.byte	105
	.byte	102
	.byte	102
	.byte	0
.text
.align 3
_s1Ex_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ex_info)+32
	.quad	0
	.quad	4294967312
_s1Ex_info:
Lc1Fu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Fv
Lc1Fw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Ft_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Fv:
	jmp *-16(%r13)
	.long  _s1Ex_info - _s1Ex_info_dsp
.text
.align 3
_s1Ey_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ey_info)+32
	.quad	4294967301
	.quad	4294967296
	.quad	64424509451
_s1Ey_info:
Lc1Fx:
Lc1Fz:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc1FB
Lc1FA:
	leaq _s1Ex_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%r9
	movq %r14,%r8
	movq %rax,%rdi
	leaq _r1BA_closure(%rip),%rsi
	leaq _r1Cb_closure(%rip),%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure(%rip),%rbx
	jmp _stg_ap_ppppp_fast
Lc1FB:
	movq $16,904(%r13)
Lc1Fy:
	jmp *-8(%r13)
	.long  _s1Ey_info - _s1Ey_info_dsp
.text
.align 3
_s1Eu_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Eu_info)+64
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s1Eu_info:
Lc1FL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1FM
Lc1FN:
	movq %r14,%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc1FM:
	jmp *-8(%r13)
	.long  _s1Eu_info - _s1Eu_info_dsp
.const
.align 3
.align 0
_c1FW_str:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	95
	.byte	109
	.byte	111
	.byte	100
	.byte	117
	.byte	108
	.byte	101
	.byte	95
	.byte	76
	.byte	69
	.byte	83
	.byte	95
	.byte	111
	.byte	99
	.byte	108
	.byte	95
	.byte	84
	.byte	69
	.byte	77
	.byte	80
	.byte	76
	.byte	46
	.byte	102
	.byte	57
	.byte	53
	.byte	0
.text
.align 3
_s1En_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1En_info)+32
	.quad	0
	.quad	4294967312
_s1En_info:
Lc1FX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1FY
Lc1FZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1FW_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1FY:
	jmp *-16(%r13)
	.long  _s1En_info - _s1En_info_dsp
.const
.align 3
.align 0
_c1G5_str:
	.byte	109
	.byte	111
	.byte	100
	.byte	117
	.byte	108
	.byte	101
	.byte	95
	.byte	76
	.byte	69
	.byte	83
	.byte	95
	.byte	111
	.byte	99
	.byte	108
	.byte	95
	.byte	84
	.byte	69
	.byte	77
	.byte	80
	.byte	76
	.byte	46
	.byte	102
	.byte	57
	.byte	53
	.byte	0
.text
.align 3
_s1Em_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Em_info)+32
	.quad	0
	.quad	4294967312
_s1Em_info:
Lc1G6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1G7
Lc1G8:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1G5_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1G7:
	jmp *-16(%r13)
	.long  _s1Em_info - _s1Em_info_dsp
.const
.align 3
.align 0
_c1Ge_str:
	.byte	45
	.byte	105
	.byte	0
.text
.align 3
_s1El_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1El_info)+32
	.quad	0
	.quad	4294967312
_s1El_info:
Lc1Gf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Gg
Lc1Gh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Ge_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Gg:
	jmp *-16(%r13)
	.long  _s1El_info - _s1El_info_dsp
.const
.align 3
.align 0
_c1Gn_str:
	.byte	45
	.byte	117
	.byte	0
.text
.align 3
_s1Ek_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ek_info)+32
	.quad	0
	.quad	4294967312
_s1Ek_info:
Lc1Go:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Gp
Lc1Gq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Gn_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Gp:
	jmp *-16(%r13)
	.long  _s1Ek_info - _s1Ek_info_dsp
.const
.align 3
.align 0
_c1Gw_str:
	.byte	47
	.byte	117
	.byte	115
	.byte	114
	.byte	47
	.byte	98
	.byte	105
	.byte	110
	.byte	47
	.byte	100
	.byte	105
	.byte	102
	.byte	102
	.byte	0
.text
.align 3
_s1Ej_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ej_info)+32
	.quad	0
	.quad	4294967312
_s1Ej_info:
Lc1Gx:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Gy
Lc1Gz:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Gw_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Gy:
	jmp *-16(%r13)
	.long  _s1Ej_info - _s1Ej_info_dsp
.text
.align 3
_s1Es_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Es_info)+32
	.quad	0
	.quad	141733920784
_s1Es_info:
Lc1GA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1GB
Lc1GC:
	addq $176,%r12
	cmpq 856(%r13),%r12
	ja Lc1GE
Lc1GD:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s1En_info(%rip),%rax
	movq %rax,-168(%r12)
	leaq -168(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rbx
	movq %rbx,-152(%r12)
	movq %rax,-144(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-136(%r12)
	leaq -150(%r12),%rax
	leaq _s1Em_info(%rip),%rbx
	movq %rbx,-128(%r12)
	leaq -128(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-112(%r12)
	movq %rbx,-104(%r12)
	movq %rax,-96(%r12)
	leaq -110(%r12),%rax
	leaq _s1El_info(%rip),%rbx
	movq %rbx,-88(%r12)
	leaq -88(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %rbx,-64(%r12)
	movq %rax,-56(%r12)
	leaq -70(%r12),%rax
	leaq _s1Ek_info(%rip),%rbx
	movq %rbx,-48(%r12)
	leaq -48(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %rax,-16(%r12)
	leaq -30(%r12),%rax
	leaq _s1Ej_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _processzm1zi2zi0zi0_SystemziProcess_readProcess_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_ppp_fast
Lc1GE:
	movq $176,904(%r13)
Lc1GB:
	jmp *-16(%r13)
	.long  _s1Es_info - _s1Es_info_dsp
.text
.align 3
_s1Ev_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ev_info)+32
	.quad	0
	.quad	210453397520
_s1Ev_info:
Lc1GF:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1GG
Lc1GH:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc1GJ
Lc1GI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s1Eu_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s1Es_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1GJ:
	movq $32,904(%r13)
Lc1GG:
	jmp *-16(%r13)
	.long  _s1Ev_info - _s1Ev_info_dsp
.text
.align 3
_s1Ez_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ez_info)+32
	.quad	0
	.quad	270582939670
_s1Ez_info:
Lc1GK:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1GL
Lc1GM:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc1GO
Lc1GN:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Fj
Lc1Fi:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1Ey_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s1Ev_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1Fj:
	jmp *(%rbx)
Lc1GO:
	movq $32,904(%r13)
Lc1GL:
	jmp *-16(%r13)
	.long  _s1Ez_info - _s1Ez_info_dsp
.data
.align 3
.align 0
_s1Ei_closure:
	.quad	_s1Ei_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1I4_str:
	.byte	109
	.byte	111
	.byte	100
	.byte	117
	.byte	108
	.byte	101
	.byte	95
	.byte	76
	.byte	69
	.byte	83
	.byte	95
	.byte	111
	.byte	99
	.byte	108
	.byte	95
	.byte	84
	.byte	69
	.byte	77
	.byte	80
	.byte	76
	.byte	46
	.byte	102
	.byte	57
	.byte	53
	.byte	0
.text
.align 3
_s1Ec_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ec_info)+32
	.quad	0
	.quad	4294967312
_s1Ec_info:
Lc1I5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1I6
Lc1I7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1I4_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1I6:
	jmp *-16(%r13)
	.long  _s1Ec_info - _s1Ec_info_dsp
.const
.align 3
.align 0
_c1Il_str:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	95
	.byte	0
.text
.align 3
_s1Ef_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ef_info)+32
	.quad	0
	.quad	4294967312
_s1Ef_info:
Lc1Im:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1In
Lc1Io:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Il_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1In:
	jmp *-16(%r13)
	.long  _s1Ef_info - _s1Ef_info_dsp
.text
.align 3
_s1Eg_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Eg_info)+32
	.quad	1
	.quad	279172874257
_s1Eg_info:
Lc1Ip:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Iq
Lc1Ir:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc1It
Lc1Is:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1Ef_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1It:
	movq $16,904(%r13)
Lc1Iq:
	jmp *-16(%r13)
	.long  _s1Eg_info - _s1Eg_info_dsp
.text
.align 3
_s1Eh_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Eh_info)+32
	.quad	4294967301
	.quad	1
	.quad	828928688138
_s1Eh_info:
Lc1Iu:
Lc1Iw:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1Iy
Lc1Ix:
	movq 7(%rbx),%rax
	leaq _s1Eg_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %r14,%rsi
	movq %rax,%r14
	leaq _F95SrcIO_writezuF95zusrc_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc1Iy:
	movq $24,904(%r13)
Lc1Iv:
	jmp *-8(%r13)
	.long  _s1Eh_info - _s1Eh_info_dsp
.text
.align 3
_s1Ed_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ed_info)+96
	.quad	1
	.quad	4294967313
_s1Ed_info:
Lc1ID:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1IE
Lc1IF:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95SrcIO_readzuF95zusrc_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1IE:
	jmp *-16(%r13)
	.long  _s1Ed_info - _s1Ed_info_dsp
.text
.align 3
_s1Ei_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1Ei_info)+32
	.quad	0
	.quad	1997159792662
_s1Ei_info:
Lc1IG:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1IH
Lc1II:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc1IK
Lc1IJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1HZ
Lc1HY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1Ec_info(%rip),%rax
	movq %rax,-48(%r12)
	leaq -48(%r12),%rax
	leaq _s1Eh_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	leaq -31(%r12),%rbx
	leaq _s1Ed_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rax,-32(%rbp)
	movq %rbx,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1HZ:
	jmp *(%rbx)
Lc1IK:
	movq $56,904(%r13)
Lc1IH:
	jmp *-16(%r13)
	.long  _s1Ei_info - _s1Ei_info_dsp
.data
.align 3
.align 0
_r11G_closure:
	.quad	_r11G_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r11G_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_r11G_info)+64
	.quad	0
	.quad	416611827734
_r11G_info:
Lc1Jn:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Jo
Lc1Jp:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Jm
Lc1Jl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s1Ei_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s1Ez_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc1Jm:
	jmp *(%rbx)
Lc1Jo:
	jmp *-16(%r13)
	.long  _r11G_info - _r11G_info_dsp
.data
.align 3
.align 0
_s1ED_closure:
	.quad	_s1ED_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1JJ_str:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_s1EC_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1EC_info)+32
	.quad	0
	.quad	4294967312
_s1EC_info:
Lc1JK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1JL
Lc1JM:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1JJ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1JL:
	jmp *-16(%r13)
	.long  _s1EC_info - _s1EC_info_dsp
.text
.align 3
_s1EB_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1EB_info)+120
	.quad	0
	.quad	12884901904
_s1EB_info:
Lc1JR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1JS
Lc1JT:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfAssertableZLZR_closure(%rip),%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfTestableIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1JS:
	jmp *-16(%r13)
	.long  _s1EB_info - _s1EB_info_dsp
.text
.align 3
_s1ED_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1ED_info)+32
	.quad	0
	.quad	131945690300438
_s1ED_info:
Lc1JU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1JV
Lc1JW:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc1JY
Lc1JX:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1JE
Lc1JD:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1EC_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s1EB_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _r11G_closure(%rip),%rdi
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_z7eUZC_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_ppp_fast
Lc1JE:
	jmp *(%rbx)
Lc1JY:
	movq $32,904(%r13)
Lc1JV:
	jmp *-16(%r13)
	.long  _s1ED_info - _s1ED_info_dsp
.data
.align 3
.align 0
_s1EE_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_s1ED_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_s1EF_closure:
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_TestList_static_info
	.quad	_s1EE_closure+2
	.quad	0
.data
.align 3
.align 0
_s1EA_closure:
	.quad	_s1EA_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Kq_str:
	.byte	70
	.byte	57
	.byte	53
	.byte	83
	.byte	114
	.byte	99
	.byte	73
	.byte	79
	.byte	0
.text
.align 3
_s1EA_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_s1EA_info)+32
	.quad	0
	.quad	4294967318
_s1EA_info:
Lc1Kr:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ks
Lc1Kt:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Kp
Lc1Ko:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1Kq_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Kp:
	jmp *(%rbx)
Lc1Ks:
	jmp *-16(%r13)
	.long  _s1EA_info - _s1EA_info_dsp
.data
.align 3
.align 0
.globl _Main_main_closure
_Main_main_closure:
	.quad	_Main_main_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_Main_main_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_Main_main_info)+152
	.quad	0
	.quad	30064771094
.globl _Main_main_info
_Main_main_info:
Lc1KH:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1KI
Lc1KJ:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1KG
Lc1KF:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1EF_closure+2(%rip),%rsi
	leaq _s1EA_closure(%rip),%r14
	leaq _RunTestWV_runTestWV_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1KG:
	jmp *(%rbx)
Lc1KI:
	jmp *-16(%r13)
	.long  _Main_main_info - _Main_main_info_dsp
.data
.align 3
.align 0
.globl _ZCMain_main_closure
_ZCMain_main_closure:
	.quad	_ZCMain_main_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_ZCMain_main_info_dsp:
.text
.align 3
	.quad	_S1ES_srt-(_ZCMain_main_info)+176
	.quad	0
	.quad	12884901910
.globl _ZCMain_main_info
_ZCMain_main_info:
Lc1KW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1KX
Lc1KY:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1KV
Lc1KU:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _Main_main_closure(%rip),%r14
	leaq _base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1KV:
	jmp *(%rbx)
Lc1KX:
	jmp *-16(%r13)
	.long  _ZCMain_main_info - _ZCMain_main_info_dsp
.const_data
.align 3
.align 0
_S1ES_srt:
	.quad	_base_GHCziShow_zdfShowZMZN_closure
	.quad	_base_GHCziShow_zdfShowChar_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure
	.quad	_r1BA_closure
	.quad	_r1Cb_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_processzm1zi2zi0zi0_SystemziProcess_readProcess_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_F95SrcIO_writezuF95zusrc_closure
	.quad	_F95SrcIO_readzuF95zusrc_closure
	.quad	_s1Ei_closure
	.quad	_s1Ez_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfTestableIO_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfAssertableZLZR_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_z7eUZC_closure
	.quad	_r11G_closure
	.quad	_RunTestWV_runTestWV_closure
	.quad	_s1EA_closure
	.quad	_s1EF_closure
	.quad	_base_GHCziTopHandler_runMainIO_closure
	.quad	_Main_main_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

