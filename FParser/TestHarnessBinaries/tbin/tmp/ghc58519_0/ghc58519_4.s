.data
.align 3
.align 0
.globl ___stginit_F95OpenACCParser
___stginit_F95OpenACCParser:
.data
.align 3
.align 0
.globl _F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_closure
_F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_closure:
	.quad	_F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info
	.quad	0
.text
.align 3
_s2Jq_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Jq_info)+0
	.quad	0
	.quad	12884901904
_s2Jq_info:
Lc2Nd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ne
Lc2Nf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexLikeRegexZMZN_closure(%rip),%r14
	leaq _regexzmbasezm0zi93zi2_TextziRegexziBaseziContext_zdfRegexContextabBool_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Ne:
	jmp *-16(%r13)
	.long  _s2Jq_info - _s2Jq_info_dsp
.const
.align 3
.align 0
_c2Nv_str:
	.byte	46
	.byte	46
	.byte	47
	.byte	70
	.byte	57
	.byte	53
	.byte	79
	.byte	112
	.byte	101
	.byte	110
	.byte	65
	.byte	67
	.byte	67
	.byte	80
	.byte	97
	.byte	114
	.byte	115
	.byte	101
	.byte	114
	.byte	46
	.byte	104
	.byte	115
	.byte	58
	.byte	52
	.byte	48
	.byte	58
	.byte	57
	.byte	45
	.byte	51
	.byte	57
	.byte	124
	.byte	108
	.byte	105
	.byte	110
	.byte	101
	.byte	32
	.byte	58
	.byte	32
	.byte	114
	.byte	95
	.byte	115
	.byte	114
	.byte	99
	.byte	95
	.byte	108
	.byte	105
	.byte	110
	.byte	101
	.byte	115
	.byte	0
.text
.align 3
_s2JB_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2JB_info)+16
	.quad	1
	.quad	4294967313
_s2JB_info:
Lc2Ns:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ND
Lc2NE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _c2Ni_info(%rip),%rbx
	movq %rbx,-24(%rbp)
	movq %rax,%rbx
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2Ni
Lc2Nj:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2Sr_srt-(_c2Ni_info)+16
	.quad	0
	.quad	4294967328
_c2Ni_info:
Lc2Ni:
	movq %rbx,%rax
	andq $7,%rax
	cmpq $2,%rax
	jae Lc2Nq
Lc2Nr:
	leaq _c2Nv_str(%rip),%r14
	addq $8,%rbp
	jmp _base_ControlziExceptionziBase_irrefutPatError_info
Lc2Nq:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2NB
Lc2NA:
	movq 6(%rbx),%rax
	movq 14(%rbx),%rbx
	leaq _ghczmprim_GHCziTuple_Z2T_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -15(%r12),%rax
	movq %rax,%rbx
	addq $8,%rbp
	jmp *(%rbp)
Lc2NB:
	movq $24,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2ND:
	jmp *-16(%r13)
	.long  _s2JB_info - _s2JB_info_dsp
.const
.align 3
.align 0
_c2NH_str:
	.byte	94
	.byte	32
	.byte	42
	.byte	36
	.byte	0
.text
.align 3
_s2JW_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2JW_info)+24
	.quad	0
	.quad	4294967312
_s2JW_info:
Lc2NI:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NJ
Lc2NK:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2NH_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2NJ:
	jmp *-16(%r13)
	.long  _s2JW_info - _s2JW_info_dsp
.const
.align 3
.align 0
_c2NV_str:
	.byte	94
	.byte	92
	.byte	115
	.byte	42
	.byte	33
	.byte	92
	.byte	115
	.byte	42
	.byte	92
	.byte	36
	.byte	0
.text
.align 3
_s2K0_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K0_info)+24
	.quad	0
	.quad	4294967312
_s2K0_info:
Lc2NW:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2NX
Lc2NY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2NV_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2NX:
	jmp *-16(%r13)
	.long  _s2K0_info - _s2K0_info_dsp
.text
.align 3
_s2K1_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K1_info)+24
	.quad	2
	.quad	30064771091
_s2K1_info:
Lc2NZ:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O0
Lc2O1:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2O3
Lc2O2:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2K0_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rcx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2O3:
	movq $16,904(%r13)
Lc2O0:
	jmp *-16(%r13)
	.long  _s2K1_info - _s2K1_info_dsp
.text
.align 3
_s2K2_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K2_info)+24
	.quad	2
	.quad	64424509459
_s2K2_info:
Lc2O4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2O5
Lc2O6:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2O8
Lc2O7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2K1_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_not_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2O8:
	movq $32,904(%r13)
Lc2O5:
	jmp *-16(%r13)
	.long  _s2K2_info - _s2K2_info_dsp
.const
.align 3
.align 0
_c2Of_str:
	.byte	94
	.byte	32
	.byte	42
	.byte	91
	.byte	99
	.byte	42
	.byte	33
	.byte	93
	.byte	0
.text
.align 3
_s2JY_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2JY_info)+24
	.quad	0
	.quad	4294967312
_s2JY_info:
Lc2Og:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oh
Lc2Oi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Of_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Oh:
	jmp *-16(%r13)
	.long  _s2JY_info - _s2JY_info_dsp
.text
.align 3
_s2JZ_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2JZ_info)+24
	.quad	2
	.quad	30064771091
_s2JZ_info:
Lc2Oj:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ok
Lc2Ol:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2On
Lc2Om:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2JY_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rcx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2On:
	movq $16,904(%r13)
Lc2Ok:
	jmp *-16(%r13)
	.long  _s2JZ_info - _s2JZ_info_dsp
.const
.align 3
.align 0
_c2Ou_str:
	.byte	58
	.byte	123
	.byte	50
	.byte	125
	.byte	0
.text
.align 3
_s2K6_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K6_info)+24
	.quad	0
	.quad	4294967312
_s2K6_info:
Lc2Ov:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Ow
Lc2Ox:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Ou_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Ow:
	jmp *-16(%r13)
	.long  _s2K6_info - _s2K6_info_dsp
.text
.align 3
_s2K7_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K7_info)+24
	.quad	2
	.quad	30064771091
_s2K7_info:
Lc2Oy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Oz
Lc2OA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2OC
Lc2OB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2K6_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rcx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2OC:
	movq $16,904(%r13)
Lc2Oz:
	jmp *-16(%r13)
	.long  _s2K7_info - _s2K7_info_dsp
.const
.align 3
.align 0
_c2OJ_str:
	.byte	44
	.byte	32
	.byte	123
	.byte	48
	.byte	44
	.byte	49
	.byte	125
	.byte	112
	.byte	97
	.byte	114
	.byte	97
	.byte	109
	.byte	101
	.byte	116
	.byte	101
	.byte	114
	.byte	32
	.byte	123
	.byte	49
	.byte	44
	.byte	52
	.byte	125
	.byte	0
.text
.align 3
_s2K4_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K4_info)+24
	.quad	0
	.quad	4294967312
_s2K4_info:
Lc2OK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OL
Lc2OM:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2OJ_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2OL:
	jmp *-16(%r13)
	.long  _s2K4_info - _s2K4_info_dsp
.text
.align 3
_s2K5_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K5_info)+24
	.quad	2
	.quad	30064771091
_s2K5_info:
Lc2ON:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OO
Lc2OP:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2OR
Lc2OQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2K4_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rcx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2OR:
	movq $16,904(%r13)
Lc2OO:
	jmp *-16(%r13)
	.long  _s2K5_info - _s2K5_info_dsp
.const
.align 3
.align 0
_c2OU_str:
	.byte	94
	.byte	33
	.byte	92
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	32
	.byte	97
	.byte	114
	.byte	103
	.byte	117
	.byte	109
	.byte	101
	.byte	110
	.byte	116
	.byte	115
	.byte	0
.text
.align 3
_s2K9_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2K9_info)+24
	.quad	0
	.quad	4294967312
_s2K9_info:
Lc2OV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2OW
Lc2OX:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2OU_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2OW:
	jmp *-16(%r13)
	.long  _s2K9_info - _s2K9_info_dsp
.const
.align 3
.align 0
_c2P0_str:
	.byte	94
	.byte	33
	.byte	92
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	32
	.byte	101
	.byte	110
	.byte	100
	.byte	32
	.byte	97
	.byte	114
	.byte	103
	.byte	117
	.byte	109
	.byte	101
	.byte	110
	.byte	116
	.byte	115
	.byte	0
.text
.align 3
_s2Kb_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Kb_info)+24
	.quad	0
	.quad	4294967312
_s2Kb_info:
Lc2P1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2P2
Lc2P3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2P0_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2P2:
	jmp *-16(%r13)
	.long  _s2Kb_info - _s2Kb_info_dsp
.const
.align 3
.align 0
_c2P6_str:
	.byte	94
	.byte	33
	.byte	92
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	32
	.byte	99
	.byte	111
	.byte	110
	.byte	115
	.byte	116
	.byte	97
	.byte	114
	.byte	103
	.byte	117
	.byte	109
	.byte	101
	.byte	110
	.byte	116
	.byte	115
	.byte	0
.text
.align 3
_s2Ke_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Ke_info)+24
	.quad	0
	.quad	4294967312
_s2Ke_info:
Lc2P7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2P8
Lc2P9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2P6_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2P8:
	jmp *-16(%r13)
	.long  _s2Ke_info - _s2Ke_info_dsp
.const
.align 3
.align 0
_c2Pc_str:
	.byte	94
	.byte	33
	.byte	92
	.byte	36
	.byte	97
	.byte	99
	.byte	99
	.byte	32
	.byte	101
	.byte	110
	.byte	100
	.byte	32
	.byte	99
	.byte	111
	.byte	110
	.byte	115
	.byte	116
	.byte	97
	.byte	114
	.byte	103
	.byte	117
	.byte	109
	.byte	101
	.byte	110
	.byte	116
	.byte	115
	.byte	0
.text
.align 3
_s2Kg_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Kg_info)+24
	.quad	0
	.quad	4294967312
_s2Kg_info:
Lc2Pd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pe
Lc2Pf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2Pc_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2Pe:
	jmp *-16(%r13)
	.long  _s2Kg_info - _s2Kg_info_dsp
.text
.align 3
_s2Kj_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Kj_info)+56
	.quad	1
	.quad	4294967313
_s2Kj_info:
Lc2Pl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pm
Lc2Pn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2Pm:
	jmp *-16(%r13)
	.long  _s2Kj_info - _s2Kj_info_dsp
.text
.align 3
_s2Kn_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Kn_info)+64
	.quad	2
	.quad	4294967315
_s2Kn_info:
Lc2Ps:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2Pt
Lc2Pu:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2Pw
Lc2Pv:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,(%r12)
	leaq -14(%r12),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2Pw:
	movq $24,904(%r13)
Lc2Pt:
	jmp *-16(%r13)
	.long  _s2Kn_info - _s2Kn_info_dsp
.text
.align 3
_s2Kp_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Kp_info)+64
	.quad	2
	.quad	4294967315
_s2Kp_info:
Lc2PB:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PC
Lc2PD:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2PF
Lc2PE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,(%r12)
	leaq -14(%r12),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2PF:
	movq $24,904(%r13)
Lc2PC:
	jmp *-16(%r13)
	.long  _s2Kp_info - _s2Kp_info_dsp
.text
.align 3
_s2Kr_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_s2Kr_info)+64
	.quad	2
	.quad	4294967315
_s2Kr_info:
Lc2PK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PL
Lc2PM:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2PO
Lc2PN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,(%r12)
	leaq -14(%r12),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2PO:
	movq $24,904(%r13)
Lc2PL:
	jmp *-16(%r13)
	.long  _s2Kr_info - _s2Kr_info_dsp
.text
.align 3
_F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info_dsp:
.text
.align 3
	.quad	_S2Sr_srt-(_F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info)+0
	.quad	4294967301
	.quad	0
	.quad	17587891077135
.globl _F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info
_F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info:
Lc2PP:
	leaq -88(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2PY
Lc2PZ:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2Sg
Lc2Q0:
	leaq _s2Jq_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rcx
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rdx
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rsi
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rdi
Ln2V6:
	movq %rdi,%r8
	movq %rbx,%rdi
	movq %rsi,%rbx
	movq %rcx,%rsi
	movq %r14,%rcx
Lc2Lw:
	leaq _c2Lz_info(%rip),%r9
	movq %r9,-56(%rbp)
	movq %rbx,%r9
	movq %rcx,%rbx
	movq %rax,-48(%rbp)
	movq %r8,-40(%rbp)
	movq %r9,-32(%rbp)
	movq %rdx,-24(%rbp)
	movq %rsi,-16(%rbp)
	movq %rdi,-8(%rbp)
	addq $-56,%rbp
	testq $7,%rbx
	jne Lc2Lz
Lc2LA:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2Sr_srt-(_c2PS_info)+16
	.quad	775
	.quad	2194728288288
_c2PS_info:
Lc2PS:
	movq 16(%rbp),%rax
	movq 8(%rbp),%rcx
	movq 40(%rbp),%rdx
	movq 48(%rbp),%rsi
	movq 56(%rbp),%rdi
	movq %rbx,%r8
	andq $7,%r8
	cmpq $2,%r8
	jae Lc2RF
Lc2RG:
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rbx
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%r8
Lu2Sq:
	addq $64,%rbp
	jmp Lc2Lw
Lc2Qd:
Lu2Sh:
	addq $72,%rbp
Ln2V5:
	movq %r8,%rdx
	movq %rdi,%rbx
	movq %r10,%rdi
	movq %rsi,%r8
	movq %r9,%rsi
	jmp Lc2Lw
Lc2Qn:
Lu2Si:
	addq $72,%rbp
Ln2V4:
	movq %r8,%rdx
	movq %rdi,%rbx
	movq %r10,%rdi
	movq %rsi,%r8
	movq %r9,%rsi
	jmp Lc2Lw
Lc2Qx:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2QB
Lc2QA:
	leaq _s2Kr_info(%rip),%rbx
	movq %rbx,-24(%r12)
	movq %r10,-8(%r12)
	movq %rdx,(%r12)
	leaq -24(%r12),%rbx
Lu2Sj:
	addq $72,%rbp
Ln2V3:
	movq %r8,%rdx
	movq %rsi,%r8
	movq %r9,%rsi
	movq %rbx,88(%rsp)
	movq %rdi,%rbx
	movq 88(%rsp),%rdi
	jmp Lc2Lw
Lc2QH:
	leaq _ghczmprim_GHCziTypes_True_closure+2(%rip),%rbx
Lu2Sk:
	addq $72,%rbp
Ln2V2:
	movq %rdi,%rdx
	movq %r9,%rdi
	movq %rbx,64(%rsp)
	movq %rsi,%rbx
	movq %r8,%rsi
	movq 64(%rsp),%r8
	jmp Lc2Lw
Lc2QR:
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rbx
Lu2Sl:
	addq $72,%rbp
Ln2V1:
	movq %rdi,%rdx
	movq %r9,%rdi
	movq %rbx,64(%rsp)
	movq %rsi,%rbx
	movq %r8,%rsi
	movq 64(%rsp),%r8
	jmp Lc2Lw
Lc2R1:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2R5
Lc2R4:
	leaq _s2Kp_info(%rip),%rbx
	movq %rbx,-24(%r12)
	movq %rdi,-8(%r12)
	movq %rdx,(%r12)
	leaq -24(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_True_closure+2(%rip),%rdx
Lu2Sm:
	addq $72,%rbp
Ln2V0:
	movq %r9,%rdi
	movq %rbx,80(%rsp)
	movq %rsi,%rbx
	movq %r8,%rsi
	movq %rdx,%r8
	movq 80(%rsp),%rdx
	jmp Lc2Lw
Lc2Rb:
	leaq _ghczmprim_GHCziTypes_True_closure+2(%rip),%rbx
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rdx
Lu2Sn:
	addq $72,%rbp
Ln2UZ:
	movq %rdx,64(%rsp)
	movq %rsi,%rdx
	movq %rdi,%rsi
	movq %r8,%rdi
	movq 64(%rsp),%r8
	jmp Lc2Lw
Lc2Rl:
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rbx
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rdx
Lu2So:
	addq $72,%rbp
Ln2UY:
	movq %rdx,64(%rsp)
	movq %rsi,%rdx
	movq %rdi,%rsi
	movq %r8,%rdi
	movq 64(%rsp),%r8
	jmp Lc2Lw
Lc2Rv:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Rz
Lc2Ry:
	leaq _s2Kn_info(%rip),%rbx
	movq %rbx,-24(%r12)
	movq %rdi,-8(%r12)
	movq %rdx,(%r12)
	leaq -24(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_True_closure+2(%rip),%rdx
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rdi
Lu2Sp:
	addq $72,%rbp
Ln2UX:
	movq %rdi,64(%rsp)
	movq %r8,%rdi
	movq 64(%rsp),%r8
	movq %rbx,72(%rsp)
	movq %rdx,%rbx
	movq %rsi,%rdx
	movq 72(%rsp),%rsi
	jmp Lc2Lw
.text
.align 3
	.quad	_S2Sr_srt-(_c2Lz_info)+16
	.quad	6
	.quad	2194728288288
_c2Lz_info:
Lc2Lz:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 24(%rbp),%rcx
	movq 32(%rbp),%rcx
	movq 40(%rbp),%rdx
	movq 48(%rbp),%rsi
	movq %rbx,%rdi
	andq $7,%rdi
	cmpq $2,%rdi
	jae Lc2Q6
Lc2Q7:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2Se
Lc2Sd:
	leaq _ghczmprim_GHCziTuple_Z3T_con_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %rcx,-16(%r12)
	movq %rdx,-8(%r12)
	movq %rsi,(%r12)
	leaq -23(%r12),%rax
	movq %rax,%rbx
	addq $56,%rbp
	jmp *(%rbp)
.text
.align 3
	.quad	_S2Sr_srt-(_c2LR_info)+16
	.quad	8
	.quad	2194728288288
_c2LR_info:
Lc2LR:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 32(%rbp),%rsi
	movq 40(%rbp),%rdi
	movq 48(%rbp),%r8
	movq 56(%rbp),%r9
	movq 64(%rbp),%r10
	movq %rbx,%r11
	andq $7,%r11
	cmpq $2,%r11
	jae Lc2Qd
Lc2Qe:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc2S8
Lc2S7:
	leaq _s2K2_info(%rip),%rbx
	movq %rbx,-56(%r12)
	movq %rax,-40(%r12)
	movq %rdx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s2JZ_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rdx,(%r12)
	leaq -24(%r12),%rax
	leaq _c2LZ_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
.text
.align 3
	.quad	_S2Sr_srt-(_c2LZ_info)+16
	.quad	8
	.quad	2194728288288
_c2LZ_info:
Lc2LZ:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 32(%rbp),%rsi
	movq 40(%rbp),%rdi
	movq 48(%rbp),%r8
	movq 56(%rbp),%r9
	movq 64(%rbp),%r10
	movq %rbx,%r11
	andq $7,%r11
	cmpq $2,%r11
	jae Lc2Qn
Lc2Qo:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc2S5
Lc2S4:
	leaq _s2K7_info(%rip),%rbx
	movq %rbx,-56(%r12)
	movq %rax,-40(%r12)
	movq %rdx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s2K5_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rdx,(%r12)
	leaq -24(%r12),%rax
	leaq _c2M7_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
.text
.align 3
	.quad	_S2Sr_srt-(_c2M7_info)+16
	.quad	8
	.quad	2194728288288
_c2M7_info:
Lc2M7:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 32(%rbp),%rsi
	movq 40(%rbp),%rdi
	movq 48(%rbp),%r8
	movq 56(%rbp),%r9
	movq 64(%rbp),%r10
	movq %rbx,%r11
	andq $7,%r11
	cmpq $2,%r11
	jae Lc2Qx
Lc2Qy:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2S2
Lc2S1:
	leaq _s2K9_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Md_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2Sr_srt-(_c2Md_info)+16
	.quad	8
	.quad	2194728288288
_c2Md_info:
Lc2Md:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 32(%rbp),%rsi
	movq 40(%rbp),%rsi
	movq 48(%rbp),%rdi
	movq 56(%rbp),%r8
	movq 64(%rbp),%r9
	movq %rbx,%r10
	andq $7,%r10
	cmpq $2,%r10
	jae Lc2QH
Lc2QI:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2RZ
Lc2RY:
	leaq _s2Kb_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Mj_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2Sr_srt-(_c2Mj_info)+16
	.quad	8
	.quad	2194728288288
_c2Mj_info:
Lc2Mj:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 32(%rbp),%rdx
	movq 40(%rbp),%rsi
	movq 48(%rbp),%rdi
	movq 56(%rbp),%r8
	movq 64(%rbp),%r9
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2QR
Lc2QS:
	leaq _c2Mn_info(%rip),%rax
	movq %rax,(%rbp)
	movq %rdx,%rbx
	testq $7,%rbx
	jne Lc2Mn
Lc2Mo:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2Sr_srt-(_c2Mn_info)+16
	.quad	520
	.quad	2194728288288
_c2Mn_info:
Lc2Mn:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 40(%rbp),%rsi
	movq 48(%rbp),%rdi
	movq 56(%rbp),%r8
	movq 64(%rbp),%r9
	movq %rbx,%r10
	andq $7,%r10
	cmpq $2,%r10
	jae Lc2R1
Lc2R2:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2RV
Lc2RU:
	leaq _s2Ke_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2Mu_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2Sr_srt-(_c2Mu_info)+16
	.quad	520
	.quad	2194728288288
_c2Mu_info:
Lc2Mu:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 40(%rbp),%rsi
	movq 48(%rbp),%rsi
	movq 56(%rbp),%rdi
	movq 64(%rbp),%r8
	movq %rbx,%r9
	andq $7,%r9
	cmpq $2,%r9
	jae Lc2Rb
Lc2Rc:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2RS
Lc2RR:
	leaq _s2Kg_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _c2MA_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	jmp _stg_ap_pppp_fast
.text
.align 3
	.quad	_S2Sr_srt-(_c2MA_info)+16
	.quad	520
	.quad	2194728288288
_c2MA_info:
Lc2MA:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 40(%rbp),%rdx
	movq 48(%rbp),%rsi
	movq 56(%rbp),%rdi
	movq 64(%rbp),%r8
	andq $7,%rbx
	cmpq $2,%rbx
	jae Lc2Rl
Lc2Rm:
	leaq _c2ME_info(%rip),%rax
	movq %rax,(%rbp)
	movq %rdx,%rbx
	testq $7,%rbx
	jne Lc2ME
Lc2MF:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2Sr_srt-(_c2ME_info)+16
	.quad	1544
	.quad	2194728288288
_c2ME_info:
Lc2ME:
	movq 24(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq 48(%rbp),%rsi
	movq 56(%rbp),%rdi
	movq 64(%rbp),%r8
	movq %rbx,%r9
	andq $7,%r9
	cmpq $2,%r9
	jae Lc2Rv
Lc2Rw:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2RO
Lc2RN:
	leaq _s2Kj_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %rcx,(%r12)
	leaq -16(%r12),%rax
	leaq _c2PS_info(%rip),%rbx
	movq %rbx,8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqInt_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	movq _stg_INTLIKE_closure@GOTPCREL(%rip),%rax
	addq $257,%rax
	movq %rax,(%rbp)
	addq $-16,%rbp
	jmp _ghczmprim_GHCziClasses_zeze_info
Lc2Sg:
	movq $16,904(%r13)
Lc2PY:
	leaq _F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_closure(%rip),%rbx
	jmp *-8(%r13)
Lc2Q6:
	addq $160,%r12
	cmpq 856(%r13),%r12
	ja Lc2Sb
Lc2Sa:
	movq 6(%rbx),%rcx
	movq 14(%rbx),%rcx
	leaq _s2JB_info(%rip),%rcx
	movq %rcx,-152(%r12)
	movq %rbx,-136(%r12)
	leaq -152(%r12),%rbx
	leaq _stg_sel_1_upd_info(%rip),%rcx
	movq %rcx,-128(%r12)
	movq %rbx,-112(%r12)
	leaq -128(%r12),%rcx
	leaq _stg_sel_0_upd_info(%rip),%rdx
	movq %rdx,-104(%r12)
	movq %rbx,-88(%r12)
	leaq -104(%r12),%rbx
	leaq _ghczmprim_GHCziTuple_Z2T_con_info(%rip),%rdx
	movq %rdx,-80(%r12)
	movq %rbx,-72(%r12)
	movq %rcx,-64(%r12)
	leaq -79(%r12),%rbx
	leaq _stg_sel_1_upd_info(%rip),%rcx
	movq %rcx,-56(%r12)
	movq %rbx,-40(%r12)
	leaq -56(%r12),%rcx
	leaq _stg_sel_0_upd_info(%rip),%rdx
	movq %rdx,-32(%r12)
	movq %rbx,-16(%r12)
	leaq -32(%r12),%rbx
	leaq _s2JW_info(%rip),%rdx
	movq %rdx,-8(%r12)
	leaq -8(%r12),%rdx
	leaq _c2LR_info(%rip),%rsi
	movq %rsi,-16(%rbp)
	movq %rdx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	movq %rbx,%rax
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	movq %rax,-8(%rbp)
	movq %rcx,(%rbp)
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2QB:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2R5:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Rz:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RF:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2RJ
Lc2RI:
	leaq _ghczmprim_GHCziTuple_Z3T_con_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %rdx,-16(%r12)
	movq %rsi,-8(%r12)
	movq %rdi,(%r12)
	leaq -23(%r12),%rax
	movq %rax,%rbx
	addq $64,%rbp
	jmp *(%rbp)
Lc2RJ:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RO:
	movq $24,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RS:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RV:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2RZ:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2S2:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2S5:
	movq $64,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2S8:
	movq $64,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Sb:
	movq $160,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2Se:
	movq $32,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
	.long  _F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info - _F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_info_dsp
.const_data
.align 3
.align 0
_S2Sr_srt:
	.quad	_regexzmbasezm0zi93zi2_TextziRegexziBaseziContext_zdfRegexContextabBool_closure
	.quad	_regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexLikeRegexZMZN_closure
	.quad	_base_ControlziExceptionziBase_irrefutPatError_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure
	.quad	_regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure
	.quad	_ghczmprim_GHCziClasses_not_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_ghczmprim_GHCziClasses_zaza_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqInt_closure
	.quad	_F95OpenACCParser_extractzuOpenACCzuregionszufromzuF95zusrc_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

