.data
.align 3
.align 0
.globl ___stginit_Main
___stginit_Main:
.data
.align 3
.align 0
_r1Gd_closure:
	.quad	_r1Gd_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r1Gd_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_r1Gd_info)+0
	.quad	0
	.quad	12884901910
_r1Gd_info:
Lc1Hs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ht
Lc1Hu:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Hr
Lc1Hq:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _base_GHCziShow_zdfShowChar_closure(%rip),%r14
	leaq _base_GHCziShow_zdfShowZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Hr:
	jmp *(%rbx)
Lc1Ht:
	jmp *-16(%r13)
	.long  _r1Gd_info - _r1Gd_info_dsp
.data
.align 3
.align 0
_r1GO_closure:
	.quad	_r1GO_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r1GO_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_r1GO_info)+16
	.quad	0
	.quad	12884901910
_r1GO_info:
Lc1HI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1HJ
Lc1HK:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1HH
Lc1HG:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1HH:
	jmp *(%rbx)
Lc1HJ:
	jmp *-16(%r13)
	.long  _r1GO_info - _r1GO_info_dsp
.data
.align 3
.align 0
_s1Hf_closure:
	.quad	_s1Hf_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1I6_str:
	.byte	68
	.byte	105
	.byte	102
	.byte	102
	.byte	0
.text
.align 3
_s1Hd_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hd_info)+32
	.quad	0
	.quad	4294967312
_s1Hd_info:
Lc1I7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1I8
Lc1I9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1I6_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1I8:
	jmp *-16(%r13)
	.long  _s1Hd_info - _s1Hd_info_dsp
.text
.align 3
_s1He_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1He_info)+32
	.quad	4294967301
	.quad	4294967296
	.quad	64424509451
_s1He_info:
Lc1Ia:
Lc1Ic:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc1Ie
Lc1Id:
	leaq _s1Hd_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%r9
	movq %r14,%r8
	movq %rax,%rdi
	leaq _r1Gd_closure(%rip),%rsi
	leaq _r1GO_closure(%rip),%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure(%rip),%rbx
	jmp _stg_ap_ppppp_fast
Lc1Ie:
	movq $16,904(%r13)
Lc1Ib:
	jmp *-8(%r13)
	.long  _s1He_info - _s1He_info_dsp
.text
.align 3
_s1Ha_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Ha_info)+64
	.quad	4294967301
	.quad	4294967296
	.quad	4294967307
_s1Ha_info:
Lc1Io:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ip
Lc1Iq:
	movq %r14,%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc1Ip:
	jmp *-8(%r13)
	.long  _s1Ha_info - _s1Ha_info_dsp
.const
.align 3
.align 0
_c1Iz_str:
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
_s1H3_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1H3_info)+32
	.quad	0
	.quad	4294967312
_s1H3_info:
Lc1IA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1IB
Lc1IC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Iz_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1IB:
	jmp *-16(%r13)
	.long  _s1H3_info - _s1H3_info_dsp
.const
.align 3
.align 0
_c1II_str:
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
_s1H2_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1H2_info)+32
	.quad	0
	.quad	4294967312
_s1H2_info:
Lc1IJ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1IK
Lc1IL:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1II_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1IK:
	jmp *-16(%r13)
	.long  _s1H2_info - _s1H2_info_dsp
.const
.align 3
.align 0
_c1IR_str:
	.byte	45
	.byte	105
	.byte	0
.text
.align 3
_s1H1_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1H1_info)+32
	.quad	0
	.quad	4294967312
_s1H1_info:
Lc1IS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1IT
Lc1IU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1IR_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1IT:
	jmp *-16(%r13)
	.long  _s1H1_info - _s1H1_info_dsp
.const
.align 3
.align 0
_c1J0_str:
	.byte	45
	.byte	117
	.byte	0
.text
.align 3
_s1H0_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1H0_info)+32
	.quad	0
	.quad	4294967312
_s1H0_info:
Lc1J1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1J2
Lc1J3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1J0_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1J2:
	jmp *-16(%r13)
	.long  _s1H0_info - _s1H0_info_dsp
.const
.align 3
.align 0
_c1J9_str:
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
_s1GZ_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GZ_info)+32
	.quad	0
	.quad	4294967312
_s1GZ_info:
Lc1Ja:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Jb
Lc1Jc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1J9_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Jb:
	jmp *-16(%r13)
	.long  _s1GZ_info - _s1GZ_info_dsp
.text
.align 3
_s1H8_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1H8_info)+32
	.quad	0
	.quad	141733920784
_s1H8_info:
Lc1Jd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Je
Lc1Jf:
	addq $176,%r12
	cmpq 856(%r13),%r12
	ja Lc1Jh
Lc1Jg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s1H3_info(%rip),%rax
	movq %rax,-168(%r12)
	leaq -168(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rbx
	movq %rbx,-152(%r12)
	movq %rax,-144(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-136(%r12)
	leaq -150(%r12),%rax
	leaq _s1H2_info(%rip),%rbx
	movq %rbx,-128(%r12)
	leaq -128(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-112(%r12)
	movq %rbx,-104(%r12)
	movq %rax,-96(%r12)
	leaq -110(%r12),%rax
	leaq _s1H1_info(%rip),%rbx
	movq %rbx,-88(%r12)
	leaq -88(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq %rbx,-64(%r12)
	movq %rax,-56(%r12)
	leaq -70(%r12),%rax
	leaq _s1H0_info(%rip),%rbx
	movq %rbx,-48(%r12)
	leaq -48(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rbx,-24(%r12)
	movq %rax,-16(%r12)
	leaq -30(%r12),%rax
	leaq _s1GZ_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdi
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _processzm1zi2zi0zi0_SystemziProcess_readProcess_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_ppp_fast
Lc1Jh:
	movq $176,904(%r13)
Lc1Je:
	jmp *-16(%r13)
	.long  _s1H8_info - _s1H8_info_dsp
.text
.align 3
_s1Hb_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hb_info)+32
	.quad	0
	.quad	210453397520
_s1Hb_info:
Lc1Ji:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Jj
Lc1Jk:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc1Jm
Lc1Jl:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s1Ha_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s1H8_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1Jm:
	movq $32,904(%r13)
Lc1Jj:
	jmp *-16(%r13)
	.long  _s1Hb_info - _s1Hb_info_dsp
.text
.align 3
_s1Hf_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hf_info)+32
	.quad	0
	.quad	270582939670
_s1Hf_info:
Lc1Jn:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Jo
Lc1Jp:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc1Jr
Lc1Jq:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1HW
Lc1HV:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1He_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -23(%r12),%rax
	leaq _s1Hb_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-40(%rbp)
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1HW:
	jmp *(%rbx)
Lc1Jr:
	movq $32,904(%r13)
Lc1Jo:
	jmp *-16(%r13)
	.long  _s1Hf_info - _s1Hf_info_dsp
.data
.align 3
.align 0
_s1GY_closure:
	.quad	_s1GY_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1KH_str:
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
_s1GS_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GS_info)+32
	.quad	0
	.quad	4294967312
_s1GS_info:
Lc1KI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1KJ
Lc1KK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1KH_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1KJ:
	jmp *-16(%r13)
	.long  _s1GS_info - _s1GS_info_dsp
.const
.align 3
.align 0
_c1KY_str:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	95
	.byte	0
.text
.align 3
_s1GV_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GV_info)+32
	.quad	0
	.quad	4294967312
_s1GV_info:
Lc1KZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1L0
Lc1L1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1KY_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1L0:
	jmp *-16(%r13)
	.long  _s1GV_info - _s1GV_info_dsp
.text
.align 3
_s1GW_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GW_info)+32
	.quad	1
	.quad	279172874257
_s1GW_info:
Lc1L2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1L3
Lc1L4:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc1L6
Lc1L5:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1GV_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1L6:
	movq $16,904(%r13)
Lc1L3:
	jmp *-16(%r13)
	.long  _s1GW_info - _s1GW_info_dsp
.text
.align 3
_s1GX_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GX_info)+32
	.quad	4294967301
	.quad	1
	.quad	828928688138
_s1GX_info:
Lc1L7:
Lc1L9:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1Lb
Lc1La:
	movq 7(%rbx),%rax
	leaq _s1GW_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %r14,%rsi
	movq %rax,%r14
	leaq _F95SrcIO_writezuF95zusrc_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc1Lb:
	movq $24,904(%r13)
Lc1L8:
	jmp *-8(%r13)
	.long  _s1GX_info - _s1GX_info_dsp
.text
.align 3
_s1GT_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GT_info)+96
	.quad	1
	.quad	4294967313
_s1GT_info:
Lc1Lg:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Lh
Lc1Li:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _F95SrcIO_readzuF95zusrc_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Lh:
	jmp *-16(%r13)
	.long  _s1GT_info - _s1GT_info_dsp
.text
.align 3
_s1GY_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1GY_info)+32
	.quad	0
	.quad	1997159792662
_s1GY_info:
Lc1Lj:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Lk
Lc1Ll:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc1Ln
Lc1Lm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1KC
Lc1KB:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1GS_info(%rip),%rax
	movq %rax,-48(%r12)
	leaq -48(%r12),%rax
	leaq _s1GX_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-24(%r12)
	leaq -31(%r12),%rbx
	leaq _s1GT_info(%rip),%rcx
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
Lc1KC:
	jmp *(%rbx)
Lc1Ln:
	movq $56,904(%r13)
Lc1Lk:
	jmp *-16(%r13)
	.long  _s1GY_info - _s1GY_info_dsp
.data
.align 3
.align 0
_r1qg_closure:
	.quad	_r1qg_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_r1qg_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_r1qg_info)+64
	.quad	0
	.quad	416611827734
_r1qg_info:
Lc1M0:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1M1
Lc1M2:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1LZ
Lc1LY:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s1GY_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s1Hf_closure(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc1LZ:
	jmp *(%rbx)
Lc1M1:
	jmp *-16(%r13)
	.long  _r1qg_info - _r1qg_info_dsp
.data
.align 3
.align 0
_s1Hj_closure:
	.quad	_s1Hj_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1Mm_str:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	49
	.byte	0
.text
.align 3
_s1Hi_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hi_info)+32
	.quad	0
	.quad	4294967312
_s1Hi_info:
Lc1Mn:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Mo
Lc1Mp:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1Mm_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1Mo:
	jmp *-16(%r13)
	.long  _s1Hi_info - _s1Hi_info_dsp
.text
.align 3
_s1Hh_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hh_info)+120
	.quad	0
	.quad	12884901904
_s1Hh_info:
Lc1Mu:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Mv
Lc1Mw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfAssertableZLZR_closure(%rip),%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfTestableIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Mv:
	jmp *-16(%r13)
	.long  _s1Hh_info - _s1Hh_info_dsp
.text
.align 3
_s1Hj_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hj_info)+32
	.quad	0
	.quad	131945690300438
_s1Hj_info:
Lc1Mx:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1My
Lc1Mz:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc1MB
Lc1MA:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Mh
Lc1Mg:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1Hi_info(%rip),%rax
	movq %rax,-24(%r12)
	leaq -24(%r12),%rax
	leaq _s1Hh_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _r1qg_closure(%rip),%rdi
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_z7eUZC_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_ppp_fast
Lc1Mh:
	jmp *(%rbx)
Lc1MB:
	movq $32,904(%r13)
Lc1My:
	jmp *-16(%r13)
	.long  _s1Hj_info - _s1Hj_info_dsp
.data
.align 3
.align 0
_s1Hk_closure:
	.quad	_ghczmprim_GHCziTypes_ZC_static_info
	.quad	_s1Hj_closure
	.quad	_ghczmprim_GHCziTypes_ZMZN_closure+1
	.quad	0
.data
.align 3
.align 0
_s1Hl_closure:
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_TestList_static_info
	.quad	_s1Hk_closure+2
	.quad	0
.data
.align 3
.align 0
_s1Hg_closure:
	.quad	_s1Hg_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c1N3_str:
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
_s1Hg_info_dsp:
.text
.align 3
	.quad	_S1Hv_srt-(_s1Hg_info)+32
	.quad	0
	.quad	4294967318
_s1Hg_info:
Lc1N4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1N5
Lc1N6:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1N2
Lc1N1:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c1N3_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1N2:
	jmp *(%rbx)
Lc1N5:
	jmp *-16(%r13)
	.long  _s1Hg_info - _s1Hg_info_dsp
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
	.quad	_S1Hv_srt-(_Main_main_info)+152
	.quad	0
	.quad	30064771094
.globl _Main_main_info
_Main_main_info:
Lc1Nk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Nl
Lc1Nm:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Nj
Lc1Ni:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s1Hl_closure+2(%rip),%rsi
	leaq _s1Hg_closure(%rip),%r14
	leaq _RunTestWV_runTestWV_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1Nj:
	jmp *(%rbx)
Lc1Nl:
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
	.quad	_S1Hv_srt-(_ZCMain_main_info)+176
	.quad	0
	.quad	12884901910
.globl _ZCMain_main_info
_ZCMain_main_info:
Lc1Nz:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1NA
Lc1NB:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1Ny
Lc1Nx:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _Main_main_closure(%rip),%r14
	leaq _base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Ny:
	jmp *(%rbx)
Lc1NA:
	jmp *-16(%r13)
	.long  _ZCMain_main_info - _ZCMain_main_info_dsp
.const_data
.align 3
.align 0
_S1Hv_srt:
	.quad	_base_GHCziShow_zdfShowZMZN_closure
	.quad	_base_GHCziShow_zdfShowChar_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure
	.quad	_r1Gd_closure
	.quad	_r1GO_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_processzm1zi2zi0zi0_SystemziProcess_readProcess_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_F95SrcIO_writezuF95zusrc_closure
	.quad	_F95SrcIO_readzuF95zusrc_closure
	.quad	_s1GY_closure
	.quad	_s1Hf_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfTestableIO_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_zdfAssertableZLZR_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_z7eUZC_closure
	.quad	_r1qg_closure
	.quad	_RunTestWV_runTestWV_closure
	.quad	_s1Hg_closure
	.quad	_s1Hl_closure
	.quad	_base_GHCziTopHandler_runMainIO_closure
	.quad	_Main_main_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

