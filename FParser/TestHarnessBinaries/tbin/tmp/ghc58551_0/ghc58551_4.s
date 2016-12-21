.data
.align 3
.align 0
.globl ___stginit_Main
___stginit_Main:
.data
.align 3
.align 0
_r1dG_closure:
	.quad	_r1dG_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2kM_str:
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
	.byte	82
	.byte	69
	.byte	70
	.byte	46
	.byte	102
	.byte	57
	.byte	53
	.byte	0
.text
.align 3
_r1dG_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_r1dG_info)+0
	.quad	0
	.quad	4294967318
_r1dG_info:
Lc2kN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2kO
Lc2kP:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2kL
Lc2kK:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _c2kM_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2kL:
	jmp *(%rbx)
Lc2kO:
	jmp *-16(%r13)
	.long  _r1dG_info - _r1dG_info_dsp
.data
.align 3
.align 0
_s2kF_closure:
	.quad	_s2kF_info
	.quad	0
.text
.align 3
_s2ky_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2ky_info)+8
	.quad	1
	.quad	4294967313
_s2ky_info:
Lc2lw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lx
Lc2ly:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_length_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2lx:
	jmp *-16(%r13)
	.long  _s2ky_info - _s2ky_info_dsp
.text
.align 3
_s2kz_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kz_info)+8
	.quad	1
	.quad	12884901905
_s2kz_info:
Lc2lz:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lA
Lc2lB:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2lD
Lc2lC:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ky_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _base_GHCziShow_zdfShowInt_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziShow_show_info
Lc2lD:
	movq $24,904(%r13)
Lc2lA:
	jmp *-16(%r13)
	.long  _s2kz_info - _s2kz_info_dsp
.text
.align 3
_s2kA_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kA_info)+8
	.quad	1
	.quad	30064771089
_s2kA_info:
Lc2lF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lG
Lc2lH:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2lJ
Lc2lI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2kz_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq _stg_CHARLIKE_closure@GOTPCREL(%rip),%rbx
	addq $753,%rbx
	movq %rbx,-8(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,(%r12)
	leaq -14(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2lJ:
	movq $48,904(%r13)
Lc2lG:
	jmp *-16(%r13)
	.long  _s2kA_info - _s2kA_info_dsp
.text
.align 3
_s2ku_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2ku_info)+32
	.quad	1
	.quad	12884901905
_s2ku_info:
Lc2lS:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lT
Lc2lU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _base_GHCziNum_zdfNumInteger_closure(%rip),%r14
	leaq _base_DataziList_sum_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2lT:
	jmp *-16(%r13)
	.long  _s2ku_info - _s2ku_info_dsp
.text
.align 3
_s2kv_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kv_info)+32
	.quad	1
	.quad	30064771089
_s2kv_info:
Lc2lV:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2lW
Lc2lX:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2lZ
Lc2lY:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2ku_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	leaq _base_GHCziShow_zdfShowInteger_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziShow_show_info
Lc2lZ:
	movq $24,904(%r13)
Lc2lW:
	jmp *-16(%r13)
	.long  _s2kv_info - _s2kv_info_dsp
.text
.align 3
_s2kB_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kB_info)+8
	.quad	1
	.quad	270582939665
_s2kB_info:
Lc2m0:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2m1
Lc2m2:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2m4
Lc2m3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2kA_info(%rip),%rbx
	movq %rbx,-40(%r12)
	movq %rax,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2kv_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2m4:
	movq $48,904(%r13)
Lc2m1:
	jmp *-16(%r13)
	.long  _s2kB_info - _s2kB_info_dsp
.const
.align 3
.align 0
_c2m9_str:
	.byte	77
	.byte	97
	.byte	105
	.byte	110
	.byte	32
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	58
	.byte	32
	.byte	110
	.byte	111
	.byte	110
	.byte	45
	.byte	109
	.byte	97
	.byte	116
	.byte	99
	.byte	104
	.byte	105
	.byte	110
	.byte	103
	.byte	32
	.byte	108
	.byte	105
	.byte	110
	.byte	101
	.byte	115
	.byte	58
	.byte	32
	.byte	0
.text
.align 3
_s2kt_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kt_info)+0
	.quad	0
	.quad	4294967312
_s2kt_info:
Lc2ma:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mb
Lc2mc:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2m9_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2mb:
	jmp *-16(%r13)
	.long  _s2kt_info - _s2kt_info_dsp
.text
.align 3
_s2kC_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kC_info)+0
	.quad	1
	.quad	545460846609
_s2kC_info:
Lc2md:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2me
Lc2mf:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc2mh
Lc2mg:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2kB_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2kt_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2mh:
	movq $40,904(%r13)
Lc2me:
	jmp *-16(%r13)
	.long  _s2kC_info - _s2kC_info_dsp
.text
.align 3
_s2kD_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kD_info)+0
	.quad	4294967301
	.quad	4294967296
	.quad	1095216660491
_s2kD_info:
Lc2mi:
Lc2mk:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2mm
Lc2ml:
	leaq _s2kC_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	jmp _stg_ap_p_fast
Lc2mm:
	movq $24,904(%r13)
Lc2mj:
	jmp *-8(%r13)
	.long  _s2kD_info - _s2kD_info_dsp
.text
.align 3
_s2kh_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kh_info)+64
	.quad	0
	.quad	12884901904
_s2kh_info:
Lc2mX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2mY
Lc2mZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2mY:
	jmp *-16(%r13)
	.long  _s2kh_info - _s2kh_info_dsp
.text
.align 3
_s2ko_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2ko_info)+80
	.quad	1
	.quad	12884901905
_s2ko_info:
Lc2n4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2n5
Lc2n6:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _NormaliseF95Code_normalisezuF95zucode_closure(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2n5:
	jmp *-16(%r13)
	.long  _s2ko_info - _s2ko_info_dsp
.text
.align 3
_s2kk_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kk_info)+96
	.quad	1
	.quad	4294967313
_s2kk_info:
Lc2nk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nl
Lc2nm:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2nl:
	jmp *-16(%r13)
	.long  _s2kk_info - _s2kk_info_dsp
.text
.align 3
_s2km_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2km_info)+72
	.quad	1
	.quad	38654705681
_s2km_info:
Lc2nn:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2no
Lc2np:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2nr
Lc2nq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2kk_info(%rip),%rbx
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
Lc2nr:
	movq $24,904(%r13)
Lc2no:
	jmp *-16(%r13)
	.long  _s2km_info - _s2km_info_dsp
.text
.align 3
_s2kj_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2kj_info:
Lc2nw:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nx
Lc2ny:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	movq %rbx,-32(%rbp)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2nx:
	jmp *-16(%r13)
	.long  _s2kj_info - _s2kj_info_dsp
.text
.align 3
_s2kn_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kn_info)+72
	.quad	4294967301
	.quad	1
	.quad	107374182410
_s2kn_info:
Lc2nz:
Lc2nB:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2nD
Lc2nC:
	movq 7(%rbx),%rax
	leaq _s2km_info(%rip),%rbx
	movq %rbx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rbx
	leaq _s2kj_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -24(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2nD:
	movq $56,904(%r13)
Lc2nA:
	jmp *-8(%r13)
	.long  _s2kn_info - _s2kn_info_dsp
.text
.align 3
_s2kp_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kp_info)+64
	.quad	1
	.quad	545460846609
_s2kp_info:
Lc2nE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nF
Lc2nG:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2nI
Lc2nH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2kh_info(%rip),%rbx
	movq %rbx,-48(%r12)
	leaq -48(%r12),%rbx
	leaq _s2ko_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2kn_info(%rip),%rcx
	movq %rcx,-8(%r12)
	movq %rbx,(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2nI:
	movq $56,904(%r13)
Lc2nF:
	jmp *-16(%r13)
	.long  _s2kp_info - _s2kp_info_dsp
.text
.align 3
_s2k8_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k8_info)+64
	.quad	0
	.quad	12884901904
_s2k8_info:
Lc2nR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nS
Lc2nT:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2nS:
	jmp *-16(%r13)
	.long  _s2k8_info - _s2k8_info_dsp
.text
.align 3
_s2kf_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kf_info)+80
	.quad	1
	.quad	12884901905
_s2kf_info:
Lc2nY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2nZ
Lc2o0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%rsi
	leaq _NormaliseF95Code_normalisezuF95zucode_closure(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2nZ:
	jmp *-16(%r13)
	.long  _s2kf_info - _s2kf_info_dsp
.text
.align 3
_s2kb_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kb_info)+96
	.quad	1
	.quad	4294967313
_s2kb_info:
Lc2oe:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2of
Lc2og:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_GHCziList_head_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2of:
	jmp *-16(%r13)
	.long  _s2kb_info - _s2kb_info_dsp
.text
.align 3
_s2kd_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kd_info)+72
	.quad	1
	.quad	38654705681
_s2kd_info:
Lc2oh:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oi
Lc2oj:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2ol
Lc2ok:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2kb_info(%rip),%rbx
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
Lc2ol:
	movq $24,904(%r13)
Lc2oi:
	jmp *-16(%r13)
	.long  _s2kd_info - _s2kd_info_dsp
.text
.align 3
_s2ka_info_dsp:
.text
.align 3
	.quad	2
	.quad	19
_s2ka_info:
Lc2oq:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2or
Lc2os:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	movq %rbx,-32(%rbp)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
Lc2or:
	jmp *-16(%r13)
	.long  _s2ka_info - _s2ka_info_dsp
.text
.align 3
_s2ke_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2ke_info)+72
	.quad	4294967301
	.quad	1
	.quad	107374182410
_s2ke_info:
Lc2ot:
Lc2ov:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2ox
Lc2ow:
	movq 7(%rbx),%rax
	leaq _s2kd_info(%rip),%rbx
	movq %rbx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rbx
	leaq _s2ka_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -24(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zaza_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2ox:
	movq $56,904(%r13)
Lc2ou:
	jmp *-8(%r13)
	.long  _s2ke_info - _s2ke_info_dsp
.text
.align 3
_s2kg_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kg_info)+64
	.quad	1
	.quad	545460846609
_s2kg_info:
Lc2oy:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oz
Lc2oA:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc2oC
Lc2oB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2k8_info(%rip),%rbx
	movq %rbx,-48(%r12)
	leaq -48(%r12),%rbx
	leaq _s2kf_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s2ke_info(%rip),%rcx
	movq %rcx,-8(%r12)
	movq %rbx,(%r12)
	leaq -7(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziList_filter_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oC:
	movq $56,904(%r13)
Lc2oz:
	jmp *-16(%r13)
	.long  _s2kg_info - _s2kg_info_dsp
.text
.align 3
_s2kq_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kq_info)+64
	.quad	2
	.quad	1095216660499
_s2kq_info:
Lc2oD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oE
Lc2oF:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2oH
Lc2oG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2kp_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rbx,-24(%r12)
	leaq -40(%r12),%rbx
	leaq _s2kg_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziList_zzip_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2oH:
	movq $48,904(%r13)
Lc2oE:
	jmp *-16(%r13)
	.long  _s2kq_info - _s2kq_info_dsp
.text
.align 3
_s2jI_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jI_info)+128
	.quad	0
	.quad	12884901904
_s2jI_info:
Lc2oM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oN
Lc2oO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexLikeRegexZMZN_closure(%rip),%r14
	leaq _regexzmbasezm0zi93zi2_TextziRegexziBaseziContext_zdfRegexContextabBool_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2oN:
	jmp *-16(%r13)
	.long  _s2jI_info - _s2jI_info_dsp
.text
.align 3
_s2jJ_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jJ_info)+64
	.quad	0
	.quad	12884901904
_s2jJ_info:
Lc2oT:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2oU
Lc2oV:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziClasses_zdfEqChar_closure(%rip),%r14
	leaq _ghczmprim_GHCziClasses_zdfEqZMZN_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2oU:
	jmp *-16(%r13)
	.long  _s2jJ_info - _s2jJ_info_dsp
.text
.align 3
_s2jQ_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jQ_info)+40
	.quad	0
	.quad	4294967312
_s2jQ_info:
Lc2pf:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pg
Lc2ph:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2pj
Lc2pi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $0,(%r12)
	leaq -7(%r12),%rax
	leaq _base_GHCziNum_zdfNumInteger_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziNum_fromInteger_info
Lc2pj:
	movq $16,904(%r13)
Lc2pg:
	jmp *-16(%r13)
	.long  _s2jQ_info - _s2jQ_info_dsp
.const
.align 3
.align 0
_c2pu_str:
	.byte	115
	.byte	104
	.byte	97
	.byte	112
	.byte	101
	.byte	0
.text
.align 3
_s2jT_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jT_info)+0
	.quad	0
	.quad	4294967312
_s2jT_info:
Lc2pv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pw
Lc2px:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2pu_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2pw:
	jmp *-16(%r13)
	.long  _s2jT_info - _s2jT_info_dsp
.text
.align 3
_s2jU_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jU_info)+0
	.quad	2
	.quad	3377704015495187
_s2jU_info:
Lc2py:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pz
Lc2pA:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2pC
Lc2pB:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2jT_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rcx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2pC:
	movq $16,904(%r13)
Lc2pz:
	jmp *-16(%r13)
	.long  _s2jU_info - _s2jU_info_dsp
.const
.align 3
.align 0
_c2pL_str:
	.byte	115
	.byte	104
	.byte	97
	.byte	112
	.byte	101
	.byte	0
.text
.align 3
_s2jR_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jR_info)+0
	.quad	0
	.quad	4294967312
_s2jR_info:
Lc2pM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pN
Lc2pO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2pL_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2pN:
	jmp *-16(%r13)
	.long  _s2jR_info - _s2jR_info_dsp
.text
.align 3
_s2jS_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jS_info)+0
	.quad	2
	.quad	3377704015495187
_s2jS_info:
Lc2pP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2pQ
Lc2pR:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2pT
Lc2pS:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2jR_info(%rip),%rcx
	movq %rcx,-8(%r12)
	leaq -8(%r12),%rcx
	movq %rcx,%r8
	movq %rbx,%rdi
	movq %rax,%rsi
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure(%rip),%r14
	leaq _regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pppp_fast
Lc2pT:
	movq $16,904(%r13)
Lc2pQ:
	jmp *-16(%r13)
	.long  _s2jS_info - _s2jS_info_dsp
.text
.align 3
_s2k3_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k3_info)+40
	.quad	0
	.quad	4294967312
_s2k3_info:
Lc2q7:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2q8
Lc2q9:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2qb
Lc2qa:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $1,(%r12)
	leaq -7(%r12),%rax
	leaq _base_GHCziNum_zdfNumInteger_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziNum_fromInteger_info
Lc2qb:
	movq $16,904(%r13)
Lc2q8:
	jmp *-16(%r13)
	.long  _s2k3_info - _s2k3_info_dsp
.text
.align 3
_s2k4_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k4_info)+40
	.quad	0
	.quad	140741783322640
_s2k4_info:
Lc2qc:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qd
Lc2qe:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2qg
Lc2qf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _s2k3_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziBase_return_info
Lc2qg:
	movq $16,904(%r13)
Lc2qd:
	jmp *-16(%r13)
	.long  _s2k4_info - _s2k4_info_dsp
.const
.align 3
.align 0
_c2qB_str:
	.byte	32
	.byte	60
	.byte	62
	.byte	32
	.byte	0
.text
.align 3
_s2jX_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jX_info)+0
	.quad	0
	.quad	4294967312
_s2jX_info:
Lc2qC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qD
Lc2qE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2qB_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2qD:
	jmp *-16(%r13)
	.long  _s2jX_info - _s2jX_info_dsp
.text
.align 3
_s2jY_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jY_info)+0
	.quad	1
	.quad	38654705681
_s2jY_info:
Lc2qF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qG
Lc2qH:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2qJ
Lc2qI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s2jX_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2qJ:
	movq $16,904(%r13)
Lc2qG:
	jmp *-16(%r13)
	.long  _s2jY_info - _s2jY_info_dsp
.text
.align 3
_s2jZ_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jZ_info)+0
	.quad	2
	.quad	38654705683
_s2jZ_info:
Lc2qK:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qL
Lc2qM:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc2qO
Lc2qN:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2jY_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,(%r12)
	leaq -16(%r12),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2qO:
	movq $24,904(%r13)
Lc2qL:
	jmp *-16(%r13)
	.long  _s2jZ_info - _s2jZ_info_dsp
.const
.align 3
.align 0
_c2qT_str:
	.byte	78
	.byte	79
	.byte	75
	.byte	33
	.byte	32
	.byte	0
.text
.align 3
_s2jW_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jW_info)+0
	.quad	0
	.quad	4294967312
_s2jW_info:
Lc2qU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qV
Lc2qW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2qT_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2qV:
	jmp *-16(%r13)
	.long  _s2jW_info - _s2jW_info_dsp
.text
.align 3
_s2k0_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k0_info)+0
	.quad	2
	.quad	38654705683
_s2k0_info:
Lc2qX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2qY
Lc2qZ:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2r1
Lc2r0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2jZ_info(%rip),%rcx
	movq %rcx,-40(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -40(%r12),%rax
	leaq _s2jW_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc2r1:
	movq $48,904(%r13)
Lc2qY:
	jmp *-16(%r13)
	.long  _s2k0_info - _s2k0_info_dsp
.text
.align 3
_s2k1_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k1_info)+0
	.quad	2
	.quad	588410519571
_s2k1_info:
Lc2r2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2r3
Lc2r4:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2r6
Lc2r5:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2k0_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2r6:
	movq $32,904(%r13)
Lc2r3:
	jmp *-16(%r13)
	.long  _s2k1_info - _s2k1_info_dsp
.text
.align 3
_s2k6_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k6_info)+40
	.quad	0
	.quad	4294967312
_s2k6_info:
Lc2re:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rf
Lc2rg:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2ri
Lc2rh:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _integerzmgmp_GHCziIntegerziType_Szh_con_info(%rip),%rax
	movq %rax,-8(%r12)
	movq $0,(%r12)
	leaq -7(%r12),%rax
	leaq _base_GHCziNum_zdfNumInteger_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-32(%rbp)
	movq %rax,-24(%rbp)
	addq $-32,%rbp
	jmp _base_GHCziNum_fromInteger_info
Lc2ri:
	movq $16,904(%r13)
Lc2rf:
	jmp *-16(%r13)
	.long  _s2k6_info - _s2k6_info_dsp
.text
.align 3
_s2k7_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2k7_info)+0
	.quad	4294967301
	.quad	2
	.quad	16889224452112396
_s2k7_info:
Lc2rj:
	leaq -56(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rL
Lc2rM:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rbx
	leaq _c2p1_info(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,%rcx
	movq %r14,%rbx
	movq %rax,-16(%rbp)
	movq %rcx,-8(%rbp)
	addq $-24,%rbp
	testq $7,%rbx
	jne Lc2p1
Lc2p2:
	jmp *(%rbx)
.text
.align 3
	.quad	_S2kQ_srt-(_c2p1_info)+0
	.quad	2
	.quad	16889224452112416
_c2p1_info:
Lc2p1:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rax
	movq 7(%rbx),%rcx
	movq 15(%rbx),%rbx
	leaq _c2p6_info(%rip),%rdx
	movq %rdx,-8(%rbp)
	movq %rax,%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-32(%rbp)
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rbx,(%rbp)
	movq %rcx,16(%rbp)
	addq $-32,%rbp
	jmp _ghczmprim_GHCziClasses_zsze_info
.text
.align 3
	.quad	_S2kQ_srt-(_c2p6_info)+0
	.quad	3
	.quad	16889224452112416
_c2p6_info:
Lc2p6:
	movq 16(%rbp),%rax
	movq 24(%rbp),%rcx
	movq 8(%rbp),%rdx
	movq %rbx,%rsi
	andq $7,%rsi
	cmpq $2,%rsi
	jae Lc2rp
Lc2rq:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2rJ
Lc2rI:
	leaq _s2jQ_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,16(%rbp)
	movq %rax,24(%rbp)
	addq $16,%rbp
	jmp _base_GHCziBase_return_info
.text
.align 3
	.quad	_S2kQ_srt-(_c2pU_info)+0
	.quad	131
	.quad	4504325476843552
_c2pU_info:
Lc2pU:
	movq 24(%rbp),%rax
	movq 8(%rbp),%rcx
	movq %rbx,%rdx
	andq $7,%rdx
	cmpq $2,%rdx
	jae Lc2rw
Lc2rx:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2rD
Lc2rC:
	leaq _s2k4_info(%rip),%rbx
	movq %rbx,-40(%r12)
	leaq -40(%r12),%rbx
	leaq _s2k1_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rcx,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,8(%rbp)
	movq %rax,16(%rbp)
	movq %rbx,24(%rbp)
	addq $8,%rbp
	jmp _base_GHCziBase_zgzg_info
Lc2rp:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc2rG
Lc2rF:
	leaq _s2jU_info(%rip),%rbx
	movq %rbx,-56(%r12)
	movq %rax,-40(%r12)
	movq %rdx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s2jS_info(%rip),%rdx
	movq %rdx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rcx,(%r12)
	leaq -24(%r12),%rax
	leaq _c2pU_info(%rip),%rcx
	movq %rcx,(%rbp)
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _ghczmprim_GHCziClasses_zbzb_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc2rw:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2rA
Lc2rz:
	leaq _s2k6_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,16(%rbp)
	movq %rax,24(%rbp)
	addq $16,%rbp
	jmp _base_GHCziBase_return_info
Lc2rA:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2rD:
	movq $48,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2rG:
	movq $64,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2rJ:
	movq $16,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc2rL:
	jmp *-8(%r13)
	.long  _s2k7_info - _s2k7_info_dsp
.text
.align 3
_s2kr_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kr_info)+0
	.quad	2
	.quad	36028423356809235
_s2kr_info:
Lc2rN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rO
Lc2rP:
	addq $88,%r12
	cmpq 856(%r13),%r12
	ja Lc2rR
Lc2rQ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s2kq_info(%rip),%rcx
	movq %rcx,-80(%r12)
	movq %rax,-64(%r12)
	movq %rbx,-56(%r12)
	leaq -80(%r12),%rax
	leaq _s2jI_info(%rip),%rbx
	movq %rbx,-48(%r12)
	leaq -48(%r12),%rbx
	leaq _s2jJ_info(%rip),%rcx
	movq %rcx,-32(%r12)
	leaq -32(%r12),%rcx
	leaq _s2k7_info(%rip),%rdx
	movq %rdx,-16(%r12)
	movq %rbx,-8(%r12)
	movq %rcx,(%r12)
	leaq -15(%r12),%rbx
	movq %rax,%rdi
	movq %rbx,%rsi
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	leaq _base_ControlziMonad_mapM_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_ppp_fast
Lc2rR:
	movq $88,904(%r13)
Lc2rO:
	jmp *-16(%r13)
	.long  _s2kr_info - _s2kr_info_dsp
.text
.align 3
_s2kE_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kE_info)+0
	.quad	4294967301
	.quad	1
	.quad	36028792723996682
_s2kE_info:
Lc2rS:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2rT
Lc2rU:
	addq $48,%r12
	cmpq 856(%r13),%r12
	ja Lc2rW
Lc2rV:
	movq 7(%rbx),%rax
	leaq _s2kD_info(%rip),%rbx
	movq %rbx,-40(%r12)
	leaq -39(%r12),%rbx
	leaq _s2kr_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %r14,(%r12)
	leaq -24(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2rW:
	movq $48,904(%r13)
Lc2rT:
	jmp *-8(%r13)
	.long  _s2kE_info - _s2kE_info_dsp
.text
.align 3
_s2jG_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jG_info)+184
	.quad	0
	.quad	12884901904
_s2jG_info:
Lc2s1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2s2
Lc2s3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _r1dG_closure(%rip),%r14
	leaq _F95SrcIO_readzuF95zusrc_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2s2:
	jmp *-16(%r13)
	.long  _s2jG_info - _s2jG_info_dsp
.text
.align 3
_s2kF_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2kF_info)+0
	.quad	4294967301
	.quad	0
	.quad	288230371856744463
_s2kF_info:
Lc2s4:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2s5
Lc2s6:
	addq $32,%r12
	cmpq 856(%r13),%r12
	ja Lc2s8
Lc2s7:
	leaq _s2kE_info(%rip),%rax
	movq %rax,-24(%r12)
	movq %r14,-16(%r12)
	leaq -23(%r12),%rax
	leaq _s2jG_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2s8:
	movq $32,904(%r13)
Lc2s5:
	leaq _s2kF_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _s2kF_info - _s2kF_info_dsp
.data
.align 3
.align 0
_s2jE_closure:
	.quad	_s2jE_info
	.quad	0
	.quad	0
	.quad	0
.const
.align 3
.align 0
_c2wr_str:
	.byte	46
	.byte	46
	.byte	47
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
	.byte	46
	.byte	102
	.byte	57
	.byte	53
	.byte	0
.text
.align 3
_s2jD_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jD_info)+0
	.quad	0
	.quad	4294967312
_s2jD_info:
Lc2ws:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wt
Lc2wu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c2wr_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc2wt:
	jmp *-16(%r13)
	.long  _s2jD_info - _s2jD_info_dsp
.text
.align 3
_s2jE_info_dsp:
.text
.align 3
	.quad	_S2kQ_srt-(_s2jE_info)+0
	.quad	0
	.quad	36028801313931286
_s2jE_info:
Lc2wv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2ww
Lc2wx:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc2wz
Lc2wy:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2wm
Lc2wl:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _s2jD_info(%rip),%rax
	movq %rax,-8(%r12)
	leaq -8(%r12),%rax
	movq %rax,%r14
	leaq _F95SrcIO_readzuF95zusrc_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2wm:
	jmp *(%rbx)
Lc2wz:
	movq $16,904(%r13)
Lc2ww:
	jmp *-16(%r13)
	.long  _s2jE_info - _s2jE_info_dsp
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
	.quad	_S2kQ_srt-(_Main_main_info)+160
	.quad	0
	.quad	416611827734
.globl _Main_main_info
_Main_main_info:
Lc2wS:
	leaq -40(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2wT
Lc2wU:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2wR
Lc2wQ:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rax
	movq %rax,-40(%rbp)
	leaq _s2jE_closure(%rip),%rax
	movq %rax,-32(%rbp)
	leaq _s2kF_closure+1(%rip),%rax
	movq %rax,-24(%rbp)
	addq $-40,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc2wR:
	jmp *(%rbx)
Lc2wT:
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
	.quad	_S2kQ_srt-(_ZCMain_main_info)+216
	.quad	0
	.quad	12884901910
.globl _ZCMain_main_info
_ZCMain_main_info:
Lc2xa:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc2xb
Lc2xc:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc2x9
Lc2x8:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _Main_main_closure(%rip),%r14
	leaq _base_GHCziTopHandler_runMainIO_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc2x9:
	jmp *(%rbx)
Lc2xb:
	jmp *-16(%r13)
	.long  _ZCMain_main_info - _ZCMain_main_info_dsp
.const_data
.align 3
.align 0
_S2kQ_srt:
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_base_GHCziList_length_closure
	.quad	_base_GHCziShow_zdfShowInt_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_DataziList_sum_closure
	.quad	_base_GHCziNum_zdfNumInteger_closure
	.quad	_base_GHCziShow_zdfShowInteger_closure
	.quad	_base_SystemziIO_putStrLn_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqZMZN_closure
	.quad	_ghczmprim_GHCziClasses_zdfEqChar_closure
	.quad	_base_GHCziBase_map_closure
	.quad	_NormaliseF95Code_normalisezuF95zucode_closure
	.quad	_base_GHCziList_head_closure
	.quad	_ghczmprim_GHCziClasses_zaza_closure
	.quad	_base_GHCziList_filter_closure
	.quad	_base_GHCziList_zzip_closure
	.quad	_regexzmbasezm0zi93zi2_TextziRegexziBaseziContext_zdfRegexContextabBool_closure
	.quad	_regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexLikeRegexZMZN_closure
	.quad	_regexzmtdfazm1zi2zi0_TextziRegexziTDFA_zez7eU_closure
	.quad	_regexzmtdfazm1zi2zi0_TextziRegexziTDFAziString_zdfRegexMakerRegexCompOptionExecOptionZMZN_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_ghczmprim_GHCziClasses_zbzb_closure
	.quad	_base_ControlziMonad_mapM_closure
	.quad	_F95SrcIO_readzuF95zusrc_closure
	.quad	_r1dG_closure
	.quad	_s2kF_closure
	.quad	_s2jE_closure
	.quad	_base_GHCziTopHandler_runMainIO_closure
	.quad	_Main_main_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

