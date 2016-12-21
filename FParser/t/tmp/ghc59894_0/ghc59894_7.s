.data
.align 3
.align 0
.globl ___stginit_RunTestWV
___stginit_RunTestWV:
.data
.align 3
.align 0
.globl _RunTestWV_assertEqualListTuple_closure
_RunTestWV_assertEqualListTuple_closure:
	.quad	_RunTestWV_assertEqualListTuple_info
	.quad	0
.text
.align 3
.globl _RunTestWV_assertEqualListTuple_slow
_RunTestWV_assertEqualListTuple_slow:
Lc1Tl:
	movq (%rbp),%rax
	movq 8(%rbp),%rcx
	movq 16(%rbp),%rdx
	movq 24(%rbp),%rsi
	movq 32(%rbp),%rdi
	movq 40(%rbp),%r8
	movq 48(%rbp),%r8
	movq 56(%rbp),%r8
	movq 64(%rbp),%r8
	movq %rdi,%r9
	movq %rsi,%r8
	movq %rdx,%rdi
	movq %rcx,%rsi
	movq %rax,%r14
	addq $40,%rbp
	jmp _RunTestWV_assertEqualListTuple_info
.text
.align 3
_s1SB_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SB_info)+0
	.quad	2
	.quad	4294967315
_s1SB_info:
Lc1TN:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1TO
Lc1TP:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziList_zzip_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1TO:
	jmp *-16(%r13)
	.long  _s1SB_info - _s1SB_info_dsp
.text
.align 3
_s1SA_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SA_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s1SA_info:
Lc1TY:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1U2
Lc1U3:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c1TV_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc1TV
Lc1TW:
	jmp *(%rbx)
.text
.align 3
	.quad	_S1Vv_srt-(_c1TV_info)+8
	.quad	3
	.quad	4294967328
_c1TV_info:
Lc1TV:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 24(%rbp),%rdx
	movq 7(%rbx),%rsi
	movq 15(%rbx),%rbx
	movq %rbx,%r9
	movq %rsi,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	movq %rcx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure(%rip),%rbx
	addq $32,%rbp
	jmp _stg_ap_ppppp_fast
Lc1U2:
	jmp *-8(%r13)
	.long  _s1SA_info - _s1SA_info_dsp
.text
.align 3
_s1SC_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SC_info)+0
	.quad	5
	.quad	30064771088
_s1SC_info:
Lc1U4:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1U5
Lc1U6:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc1U8
Lc1U7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rsi
	movq 48(%rbx),%rbx
	leaq _s1SB_info(%rip),%rdi
	movq %rdi,-56(%r12)
	movq %rsi,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s1SA_info(%rip),%rsi
	movq %rsi,-24(%r12)
	movq %rax,-16(%r12)
	movq %rcx,-8(%r12)
	movq %rdx,(%r12)
	leaq -23(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1U8:
	movq $64,904(%r13)
Lc1U5:
	jmp *-16(%r13)
	.long  _s1SC_info - _s1SC_info_dsp
.text
.align 3
_s1Su_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1Su_info)+0
	.quad	2
	.quad	4294967315
_s1Su_info:
Lc1Up:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Uq
Lc1Ur:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziList_zzip_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1Uq:
	jmp *-16(%r13)
	.long  _s1Su_info - _s1Su_info_dsp
.text
.align 3
_s1St_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1St_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s1St_info:
Lc1UA:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1UE
Lc1UF:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c1Ux_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc1Ux
Lc1Uy:
	jmp *(%rbx)
.text
.align 3
	.quad	_S1Vv_srt-(_c1Ux_info)+8
	.quad	3
	.quad	4294967328
_c1Ux_info:
Lc1Ux:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 24(%rbp),%rdx
	movq 7(%rbx),%rsi
	movq 15(%rbx),%rbx
	movq %rbx,%r9
	movq %rsi,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	movq %rcx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure(%rip),%rbx
	addq $32,%rbp
	jmp _stg_ap_ppppp_fast
Lc1UE:
	jmp *-8(%r13)
	.long  _s1St_info - _s1St_info_dsp
.text
.align 3
_s1Sv_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1Sv_info)+0
	.quad	5
	.quad	30064771088
_s1Sv_info:
Lc1UG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1UH
Lc1UI:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc1UK
Lc1UJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rsi
	movq 48(%rbx),%rbx
	leaq _s1Su_info(%rip),%rdi
	movq %rdi,-56(%r12)
	movq %rsi,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s1St_info(%rip),%rsi
	movq %rsi,-24(%r12)
	movq %rax,-16(%r12)
	movq %rcx,-8(%r12)
	movq %rdx,(%r12)
	leaq -23(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1UK:
	movq $64,904(%r13)
Lc1UH:
	jmp *-16(%r13)
	.long  _s1Sv_info - _s1Sv_info_dsp
.text
.align 3
_s1Sn_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1Sn_info)+0
	.quad	2
	.quad	4294967315
_s1Sn_info:
Lc1V1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1V2
Lc1V3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziList_zzip_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1V2:
	jmp *-16(%r13)
	.long  _s1Sn_info - _s1Sn_info_dsp
.text
.align 3
_s1Sm_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1Sm_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s1Sm_info:
Lc1Vc:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Vg
Lc1Vh:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c1V9_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc1V9
Lc1Va:
	jmp *(%rbx)
.text
.align 3
	.quad	_S1Vv_srt-(_c1V9_info)+8
	.quad	3
	.quad	4294967328
_c1V9_info:
Lc1V9:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 24(%rbp),%rdx
	movq 7(%rbx),%rsi
	movq 15(%rbx),%rbx
	movq %rbx,%r9
	movq %rsi,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	movq %rcx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure(%rip),%rbx
	addq $32,%rbp
	jmp _stg_ap_ppppp_fast
Lc1Vg:
	jmp *-8(%r13)
	.long  _s1Sm_info - _s1Sm_info_dsp
.text
.align 3
_s1So_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1So_info)+0
	.quad	5
	.quad	30064771088
_s1So_info:
Lc1Vi:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Vj
Lc1Vk:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc1Vm
Lc1Vl:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rsi
	movq 48(%rbx),%rbx
	leaq _s1Sn_info(%rip),%rdi
	movq %rdi,-56(%r12)
	movq %rsi,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s1Sm_info(%rip),%rsi
	movq %rsi,-24(%r12)
	movq %rax,-16(%r12)
	movq %rcx,-8(%r12)
	movq %rdx,(%r12)
	leaq -23(%r12),%rax
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1Vm:
	movq $64,904(%r13)
Lc1Vj:
	jmp *-16(%r13)
	.long  _s1So_info - _s1So_info_dsp
.text
.align 3
_RunTestWV_assertEqualListTuple_info_dsp:
.text
.align 3
	.quad	_RunTestWV_assertEqualListTuple_slow-(_RunTestWV_assertEqualListTuple_info)+0
	.quad	9
	.quad	_S1Vv_srt-(_RunTestWV_assertEqualListTuple_info)+0
	.quad	38654705664
	.quad	0
	.quad	64424509455
.globl _RunTestWV_assertEqualListTuple_info
_RunTestWV_assertEqualListTuple_info:
Lc1Vn:
	movq (%rbp),%rax
	movq 8(%rbp),%rax
	movq 16(%rbp),%rax
	movq 24(%rbp),%rbx
	leaq -56(%rbp),%rbx
	cmpq %r15,%rbx
	jb Lc1Vt
Lc1Vu:
	leaq _c1Tv_info(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,%rbx
	movq %rsi,-32(%rbp)
	movq %rdi,-24(%rbp)
	movq %r8,-16(%rbp)
	movq %r9,-8(%rbp)
	movq %r14,16(%rbp)
	addq $-40,%rbp
	testq $7,%rbx
	jne Lc1Tv
Lc1Tw:
	jmp *(%rbx)
.text
.align 3
	.quad	_S1Vv_srt-(_c1Tv_info)+0
	.quad	8
	.quad	30064771104
_c1Tv_info:
Lc1Tv:
	movq 56(%rbp),%rax
	movq 8(%rbp),%rax
	movq 16(%rbp),%rax
	movq 24(%rbp),%rax
	movq 32(%rbp),%rax
	movq 40(%rbp),%rax
	movq 48(%rbp),%rax
	movq 64(%rbp),%rax
	movq 7(%rbx),%rcx
	movq 15(%rbx),%rdx
	movq 23(%rbx),%rbx
	leaq _c1TA_info(%rip),%rsi
	movq %rsi,-16(%rbp)
	movq %rbx,%rsi
	movq %rax,%rbx
	movq %rsi,-8(%rbp)
	movq %rdx,(%rbp)
	movq %rcx,64(%rbp)
	addq $-16,%rbp
	testq $7,%rbx
	jne Lc1TA
Lc1TB:
	jmp *(%rbx)
.text
.align 3
	.quad	_S1Vv_srt-(_c1TA_info)+0
	.quad	10
	.quad	30064771104
_c1TA_info:
Lc1TA:
	movq 72(%rbp),%rax
	movq 24(%rbp),%rcx
	movq 32(%rbp),%rdx
	movq 40(%rbp),%rsi
	movq 48(%rbp),%rdi
	movq 56(%rbp),%r8
	movq 64(%rbp),%r9
	movq 80(%rbp),%r10
	movq 16(%rbp),%r11
	movq 8(%rbp),%r14
	addq $240,%r12
	cmpq 856(%r13),%r12
	ja Lc1Vr
Lc1Vq:
	movq %rax,64(%rsp)
	movq 7(%rbx),%rax
	movq %rcx,72(%rsp)
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	movq %rdx,80(%rsp)
	leaq _s1SC_info(%rip),%rdx
	movq %rdx,-232(%r12)
	movq 64(%rsp),%rdx
	movq %rdx,-216(%r12)
	movq %rsi,-208(%r12)
	movq %r9,-200(%r12)
	movq %r14,-192(%r12)
	movq %rbx,-184(%r12)
	leaq -232(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-176(%r12)
	movq %rbx,-168(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,-160(%r12)
	leaq -174(%r12),%rbx
	leaq _s1Sv_info(%rip),%rdx
	movq %rdx,-152(%r12)
	movq 72(%rsp),%rdx
	movq %rdx,-136(%r12)
	movq %rdi,-128(%r12)
	movq %r9,-120(%r12)
	movq %r11,-112(%r12)
	movq %rcx,-104(%r12)
	leaq -152(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-96(%r12)
	movq %rcx,-88(%r12)
	movq %rbx,-80(%r12)
	leaq -94(%r12),%rbx
	leaq _s1So_info(%rip),%rcx
	movq %rcx,-72(%r12)
	movq 80(%rsp),%rcx
	movq %rcx,-56(%r12)
	movq %r8,-48(%r12)
	movq %r9,-40(%r12)
	movq %r10,-32(%r12)
	movq %rax,-24(%r12)
	leaq -72(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -14(%r12),%rax
	movq %rax,%rbx
	addq $88,%rbp
	jmp *(%rbp)
Lc1Vr:
	movq $240,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc1Vt:
	leaq _RunTestWV_assertEqualListTuple_closure(%rip),%rbx
	movq %r14,-40(%rbp)
	movq %rsi,-32(%rbp)
	movq %rdi,-24(%rbp)
	movq %r8,-16(%rbp)
	movq %r9,-8(%rbp)
	addq $-40,%rbp
	jmp *-8(%r13)
	.long  _RunTestWV_assertEqualListTuple_info - _RunTestWV_assertEqualListTuple_info_dsp
.data
.align 3
.align 0
.globl _RunTestWV_assertEqualList_closure
_RunTestWV_assertEqualList_closure:
	.quad	_RunTestWV_assertEqualList_info
	.quad	0
.text
.align 3
_s1SP_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SP_info)+0
	.quad	2
	.quad	4294967315
_s1SP_info:
Lc1WF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1WG
Lc1WH:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziList_zzip_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1WG:
	jmp *-16(%r13)
	.long  _s1SP_info - _s1SP_info_dsp
.text
.align 3
_s1SO_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SO_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s1SO_info:
Lc1WQ:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1WU
Lc1WV:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c1WN_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc1WN
Lc1WO:
	jmp *(%rbx)
.text
.align 3
	.quad	_S1Vv_srt-(_c1WN_info)+8
	.quad	3
	.quad	4294967328
_c1WN_info:
Lc1WN:
	movq 8(%rbp),%rax
	movq 16(%rbp),%rcx
	movq 24(%rbp),%rdx
	movq 7(%rbx),%rsi
	movq 15(%rbx),%rbx
	movq %rbx,%r9
	movq %rsi,%r8
	movq %rdx,%rdi
	movq %rax,%rsi
	movq %rcx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure(%rip),%rbx
	addq $32,%rbp
	jmp _stg_ap_ppppp_fast
Lc1WU:
	jmp *-8(%r13)
	.long  _s1SO_info - _s1SO_info_dsp
.text
.align 3
_RunTestWV_assertEqualList_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_RunTestWV_assertEqualList_info)+0
	.quad	21474836505
	.quad	0
	.quad	98784247823
.globl _RunTestWV_assertEqualList_info
_RunTestWV_assertEqualList_info:
Lc1WW:
Lc1WY:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc1X0
Lc1WZ:
	leaq _s1SP_info(%rip),%rax
	movq %rax,-56(%r12)
	movq %r8,-40(%r12)
	movq %r9,-32(%r12)
	leaq -56(%r12),%rax
	leaq _s1SO_info(%rip),%rbx
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	movq %rsi,-8(%r12)
	movq %rdi,(%r12)
	leaq -23(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc1X0:
	movq $64,904(%r13)
Lc1WX:
	leaq _RunTestWV_assertEqualList_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _RunTestWV_assertEqualList_info - _RunTestWV_assertEqualList_info_dsp
.data
.align 3
.align 0
.globl _RunTestWV_runTestWV_closure
_RunTestWV_runTestWV_closure:
	.quad	_RunTestWV_runTestWV_info
	.quad	0
.text
.align 3
_s1SV_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SV_info)+40
	.quad	1
	.quad	4294967313
_s1SV_info:
Lc1Xs:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Xt
Lc1Xu:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_DataziTuple_fst_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Xt:
	jmp *-16(%r13)
	.long  _s1SV_info - _s1SV_info_dsp
.text
.align 3
_s1T1_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1T1_info)+48
	.quad	1
	.quad	4294967313
_s1T1_info:
Lc1XP:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1XQ
Lc1XR:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_failures_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1XQ:
	jmp *-16(%r13)
	.long  _s1T1_info - _s1T1_info_dsp
.text
.align 3
_s1T0_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1T0_info)+56
	.quad	1
	.quad	4294967313
_s1T0_info:
Lc1XX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1XY
Lc1XZ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_errors_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1XY:
	jmp *-16(%r13)
	.long  _s1T0_info - _s1T0_info_dsp
.text
.align 3
_s1SZ_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SZ_info)+64
	.quad	1
	.quad	4294967313
_s1SZ_info:
Lc1Y5:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Y6
Lc1Y7:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_tried_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Y6:
	jmp *-16(%r13)
	.long  _s1SZ_info - _s1SZ_info_dsp
.text
.align 3
_s1SY_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SY_info)+72
	.quad	1
	.quad	4294967313
_s1SY_info:
Lc1Yd:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ye
Lc1Yf:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_cases_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Ye:
	jmp *-16(%r13)
	.long  _s1SY_info - _s1SY_info_dsp
.text
.align 3
_s1SX_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SX_info)+80
	.quad	0
	.quad	4294967312
_s1SX_info:
Lc1Yl:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Ym
Lc1Yn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _base_GHCziShow_zdfShowInt_closure(%rip),%r14
	addq $-16,%rbp
	jmp _base_GHCziShow_show_info
Lc1Ym:
	jmp *-16(%r13)
	.long  _s1SX_info - _s1SX_info_dsp
.text
.align 3
_s1T6_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1T6_info)+16
	.quad	1
	.quad	2134598746129
_s1T6_info:
Lc1Yo:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Yp
Lc1Yq:
	addq $208,%r12
	cmpq 856(%r13),%r12
	ja Lc1Ys
Lc1Yr:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1T1_info(%rip),%rbx
	movq %rbx,-200(%r12)
	movq %rax,-184(%r12)
	leaq -200(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-176(%r12)
	movq %rbx,-168(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,-160(%r12)
	leaq -174(%r12),%rbx
	leaq _s1T0_info(%rip),%rcx
	movq %rcx,-152(%r12)
	movq %rax,-136(%r12)
	leaq -152(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-128(%r12)
	movq %rcx,-120(%r12)
	movq %rbx,-112(%r12)
	leaq -126(%r12),%rbx
	leaq _s1SZ_info(%rip),%rcx
	movq %rcx,-104(%r12)
	movq %rax,-88(%r12)
	leaq -104(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-80(%r12)
	movq %rcx,-72(%r12)
	movq %rbx,-64(%r12)
	leaq -78(%r12),%rbx
	leaq _s1SY_info(%rip),%rcx
	movq %rcx,-56(%r12)
	movq %rax,-40(%r12)
	leaq -56(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -30(%r12),%rax
	leaq _s1SX_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1Ys:
	movq $208,904(%r13)
Lc1Yp:
	jmp *-16(%r13)
	.long  _s1T6_info - _s1T6_info_dsp
.text
.align 3
_s1T7_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1T7_info)+16
	.quad	1
	.quad	4333622001681
_s1T7_info:
Lc1Yt:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Yu
Lc1Yv:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1Yx
Lc1Yw:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1T6_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _base_DataziList_unwords_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1Yx:
	movq $24,904(%r13)
Lc1Yu:
	jmp *-16(%r13)
	.long  _s1T7_info - _s1T7_info_dsp
.const
.align 3
.align 0
_c1YC_str:
	.byte	32
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	58
	.byte	32
	.byte	0
.text
.align 3
_s1SW_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SW_info)+96
	.quad	0
	.quad	4294967312
_s1SW_info:
Lc1YD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1YE
Lc1YF:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c1YC_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc1YE:
	jmp *-16(%r13)
	.long  _s1SW_info - _s1SW_info_dsp
.text
.align 3
_s1T8_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1T8_info)+16
	.quad	1
	.quad	17527761534993
_s1T8_info:
Lc1YG:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1YH
Lc1YI:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc1YK
Lc1YJ:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1T7_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s1SW_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1YK:
	movq $40,904(%r13)
Lc1YH:
	jmp *-16(%r13)
	.long  _s1T8_info - _s1T8_info_dsp
.text
.align 3
_s1T9_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1T9_info)+16
	.quad	2
	.quad	17527761534995
_s1T9_info:
Lc1YL:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1YM
Lc1YN:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1YP
Lc1YO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s1T8_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,(%r12)
	leaq -16(%r12),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1YP:
	movq $24,904(%r13)
Lc1YM:
	jmp *-16(%r13)
	.long  _s1T9_info - _s1T9_info_dsp
.text
.align 3
_s1Ta_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1Ta_info)+16
	.quad	4294967301
	.quad	1
	.quad	35154307317770
_s1Ta_info:
Lc1YQ:
Lc1YS:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc1YU
Lc1YT:
	movq 7(%rbx),%rax
	leaq _s1SV_info(%rip),%rbx
	movq %rbx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rbx
	leaq _s1T9_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	jmp _stg_ap_p_fast
Lc1YU:
	movq $56,904(%r13)
Lc1YR:
	jmp *-8(%r13)
	.long  _s1Ta_info - _s1Ta_info_dsp
.text
.align 3
_s1SS_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1SS_info)+120
	.quad	0
	.quad	12884901904
_s1SS_info:
Lc1Z3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Z4
Lc1Z5:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rsi
	leaq _base_GHCziIOziHandleziFD_stderr_closure(%rip),%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziText_putTextToHandle_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1Z4:
	jmp *-16(%r13)
	.long  _s1SS_info - _s1SS_info_dsp
.text
.align 3
_s1ST_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_s1ST_info)+120
	.quad	1
	.quad	30064771089
_s1ST_info:
Lc1Z6:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Z7
Lc1Z8:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc1Za
Lc1Z9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1SS_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziText_runTestText_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc1Za:
	movq $16,904(%r13)
Lc1Z7:
	jmp *-16(%r13)
	.long  _s1ST_info - _s1ST_info_dsp
.text
.align 3
_RunTestWV_runTestWV_info_dsp:
.text
.align 3
	.quad	_S1Vv_srt-(_RunTestWV_runTestWV_info)+16
	.quad	8589934607
	.quad	0
	.quad	1125869842071567
.globl _RunTestWV_runTestWV_info
_RunTestWV_runTestWV_info:
Lc1Zb:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1Zc
Lc1Zd:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc1Zf
Lc1Ze:
	leaq _s1Ta_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-24(%r12)
	leaq -31(%r12),%rax
	leaq _s1ST_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rsi,(%r12)
	leaq -16(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1Zf:
	movq $40,904(%r13)
Lc1Zc:
	leaq _RunTestWV_runTestWV_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _RunTestWV_runTestWV_info - _RunTestWV_runTestWV_info_dsp
.const_data
.align 3
.align 0
_S1Vv_srt:
	.quad	_base_GHCziList_zzip_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_assertEqual_closure
	.quad	_base_GHCziBase_map_closure
	.quad	_RunTestWV_assertEqualListTuple_closure
	.quad	_RunTestWV_assertEqualList_closure
	.quad	_base_DataziTuple_fst_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_failures_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_errors_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_tried_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziBase_cases_closure
	.quad	_base_GHCziShow_zdfShowInt_closure
	.quad	_base_DataziList_unwords_closure
	.quad	_ghczmprim_GHCziCString_unpackCStringzh_closure
	.quad	_base_GHCziBase_zpzp_closure
	.quad	_base_SystemziIO_putStrLn_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziText_putTextToHandle_closure
	.quad	_base_GHCziIOziHandleziFD_stderr_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziText_runTestText_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_RunTestWV_runTestWV_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

