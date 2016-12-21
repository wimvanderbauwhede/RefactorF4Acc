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
Lc3dU:
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
_s3da_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3da_info)+0
	.quad	2
	.quad	4294967315
_s3da_info:
Lc3em:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3en
Lc3eo:
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
Lc3en:
	jmp *-16(%r13)
	.long  _s3da_info - _s3da_info_dsp
.text
.align 3
_s3d9_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3d9_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s3d9_info:
Lc3ex:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3eB
Lc3eC:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c3eu_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc3eu
Lc3ev:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3g4_srt-(_c3eu_info)+8
	.quad	3
	.quad	4294967328
_c3eu_info:
Lc3eu:
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
Lc3eB:
	jmp *-8(%r13)
	.long  _s3d9_info - _s3d9_info_dsp
.text
.align 3
_s3db_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3db_info)+0
	.quad	5
	.quad	30064771088
_s3db_info:
Lc3eD:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3eE
Lc3eF:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc3eH
Lc3eG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rsi
	movq 48(%rbx),%rbx
	leaq _s3da_info(%rip),%rdi
	movq %rdi,-56(%r12)
	movq %rsi,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s3d9_info(%rip),%rsi
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
Lc3eH:
	movq $64,904(%r13)
Lc3eE:
	jmp *-16(%r13)
	.long  _s3db_info - _s3db_info_dsp
.text
.align 3
_s3d3_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3d3_info)+0
	.quad	2
	.quad	4294967315
_s3d3_info:
Lc3eY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3eZ
Lc3f0:
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
Lc3eZ:
	jmp *-16(%r13)
	.long  _s3d3_info - _s3d3_info_dsp
.text
.align 3
_s3d2_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3d2_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s3d2_info:
Lc3f9:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fd
Lc3fe:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c3f6_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc3f6
Lc3f7:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3g4_srt-(_c3f6_info)+8
	.quad	3
	.quad	4294967328
_c3f6_info:
Lc3f6:
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
Lc3fd:
	jmp *-8(%r13)
	.long  _s3d2_info - _s3d2_info_dsp
.text
.align 3
_s3d4_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3d4_info)+0
	.quad	5
	.quad	30064771088
_s3d4_info:
Lc3ff:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fg
Lc3fh:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc3fj
Lc3fi:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rsi
	movq 48(%rbx),%rbx
	leaq _s3d3_info(%rip),%rdi
	movq %rdi,-56(%r12)
	movq %rsi,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s3d2_info(%rip),%rsi
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
Lc3fj:
	movq $64,904(%r13)
Lc3fg:
	jmp *-16(%r13)
	.long  _s3d4_info - _s3d4_info_dsp
.text
.align 3
_s3cW_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3cW_info)+0
	.quad	2
	.quad	4294967315
_s3cW_info:
Lc3fA:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fB
Lc3fC:
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
Lc3fB:
	jmp *-16(%r13)
	.long  _s3cW_info - _s3cW_info_dsp
.text
.align 3
_s3cV_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3cV_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s3cV_info:
Lc3fL:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fP
Lc3fQ:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c3fI_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc3fI
Lc3fJ:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3g4_srt-(_c3fI_info)+8
	.quad	3
	.quad	4294967328
_c3fI_info:
Lc3fI:
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
Lc3fP:
	jmp *-8(%r13)
	.long  _s3cV_info - _s3cV_info_dsp
.text
.align 3
_s3cX_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3cX_info)+0
	.quad	5
	.quad	30064771088
_s3cX_info:
Lc3fR:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3fS
Lc3fT:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc3fV
Lc3fU:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rcx
	movq 32(%rbx),%rdx
	movq 40(%rbx),%rsi
	movq 48(%rbx),%rbx
	leaq _s3cW_info(%rip),%rdi
	movq %rdi,-56(%r12)
	movq %rsi,-40(%r12)
	movq %rbx,-32(%r12)
	leaq -56(%r12),%rbx
	leaq _s3cV_info(%rip),%rsi
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
Lc3fV:
	movq $64,904(%r13)
Lc3fS:
	jmp *-16(%r13)
	.long  _s3cX_info - _s3cX_info_dsp
.text
.align 3
_RunTestWV_assertEqualListTuple_info_dsp:
.text
.align 3
	.quad	_RunTestWV_assertEqualListTuple_slow-(_RunTestWV_assertEqualListTuple_info)+0
	.quad	9
	.quad	_S3g4_srt-(_RunTestWV_assertEqualListTuple_info)+0
	.quad	38654705664
	.quad	0
	.quad	64424509455
.globl _RunTestWV_assertEqualListTuple_info
_RunTestWV_assertEqualListTuple_info:
Lc3fW:
	movq (%rbp),%rax
	movq 8(%rbp),%rax
	movq 16(%rbp),%rax
	movq 24(%rbp),%rbx
	leaq -56(%rbp),%rbx
	cmpq %r15,%rbx
	jb Lc3g2
Lc3g3:
	leaq _c3e4_info(%rip),%rbx
	movq %rbx,-40(%rbp)
	movq %rax,%rbx
	movq %rsi,-32(%rbp)
	movq %rdi,-24(%rbp)
	movq %r8,-16(%rbp)
	movq %r9,-8(%rbp)
	movq %r14,16(%rbp)
	addq $-40,%rbp
	testq $7,%rbx
	jne Lc3e4
Lc3e5:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3g4_srt-(_c3e4_info)+0
	.quad	8
	.quad	30064771104
_c3e4_info:
Lc3e4:
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
	leaq _c3e9_info(%rip),%rsi
	movq %rsi,-16(%rbp)
	movq %rbx,%rsi
	movq %rax,%rbx
	movq %rsi,-8(%rbp)
	movq %rdx,(%rbp)
	movq %rcx,64(%rbp)
	addq $-16,%rbp
	testq $7,%rbx
	jne Lc3e9
Lc3ea:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3g4_srt-(_c3e9_info)+0
	.quad	10
	.quad	30064771104
_c3e9_info:
Lc3e9:
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
	ja Lc3g0
Lc3fZ:
	movq %rax,64(%rsp)
	movq 7(%rbx),%rax
	movq %rcx,72(%rsp)
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	movq %rdx,80(%rsp)
	leaq _s3db_info(%rip),%rdx
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
	leaq _s3d4_info(%rip),%rdx
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
	leaq _s3cX_info(%rip),%rcx
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
Lc3g0:
	movq $240,904(%r13)
	jmp *_stg_gc_unpt_r1@GOTPCREL(%rip)
Lc3g2:
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
_s3do_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3do_info)+0
	.quad	2
	.quad	4294967315
_s3do_info:
Lc3he:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3hf
Lc3hg:
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
Lc3hf:
	jmp *-16(%r13)
	.long  _s3do_info - _s3do_info_dsp
.text
.align 3
_s3dn_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dn_info)+8
	.quad	4294967301
	.quad	3
	.quad	4294967305
_s3dn_info:
Lc3hp:
	leaq -32(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ht
Lc3hu:
	movq 7(%rbx),%rax
	movq 15(%rbx),%rcx
	movq 23(%rbx),%rbx
	leaq _c3hm_info(%rip),%rdx
	movq %rdx,-32(%rbp)
	movq %rbx,%rdx
	movq %r14,%rbx
	movq %rax,-24(%rbp)
	movq %rcx,-16(%rbp)
	movq %rdx,-8(%rbp)
	addq $-32,%rbp
	testq $7,%rbx
	jne Lc3hm
Lc3hn:
	jmp *(%rbx)
.text
.align 3
	.quad	_S3g4_srt-(_c3hm_info)+8
	.quad	3
	.quad	4294967328
_c3hm_info:
Lc3hm:
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
Lc3ht:
	jmp *-8(%r13)
	.long  _s3dn_info - _s3dn_info_dsp
.text
.align 3
_RunTestWV_assertEqualList_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_RunTestWV_assertEqualList_info)+0
	.quad	21474836505
	.quad	0
	.quad	98784247823
.globl _RunTestWV_assertEqualList_info
_RunTestWV_assertEqualList_info:
Lc3hv:
Lc3hx:
	addq $64,%r12
	cmpq 856(%r13),%r12
	ja Lc3hz
Lc3hy:
	leaq _s3do_info(%rip),%rax
	movq %rax,-56(%r12)
	movq %r8,-40(%r12)
	movq %r9,-32(%r12)
	leaq -56(%r12),%rax
	leaq _s3dn_info(%rip),%rbx
	movq %rbx,-24(%r12)
	movq %r14,-16(%r12)
	movq %rsi,-8(%r12)
	movq %rdi,(%r12)
	leaq -23(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc3hz:
	movq $64,904(%r13)
Lc3hw:
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
_s3du_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3du_info)+40
	.quad	1
	.quad	4294967313
_s3du_info:
Lc3i1:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3i2
Lc3i3:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_DataziTuple_fst_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3i2:
	jmp *-16(%r13)
	.long  _s3du_info - _s3du_info_dsp
.text
.align 3
_s3dA_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dA_info)+48
	.quad	1
	.quad	4294967313
_s3dA_info:
Lc3io:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ip
Lc3iq:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_failures_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3ip:
	jmp *-16(%r13)
	.long  _s3dA_info - _s3dA_info_dsp
.text
.align 3
_s3dz_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dz_info)+56
	.quad	1
	.quad	4294967313
_s3dz_info:
Lc3iw:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3ix
Lc3iy:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_errors_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3ix:
	jmp *-16(%r13)
	.long  _s3dz_info - _s3dz_info_dsp
.text
.align 3
_s3dy_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dy_info)+64
	.quad	1
	.quad	4294967313
_s3dy_info:
Lc3iE:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iF
Lc3iG:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_tried_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3iF:
	jmp *-16(%r13)
	.long  _s3dy_info - _s3dy_info_dsp
.text
.align 3
_s3dx_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dx_info)+72
	.quad	1
	.quad	4294967313
_s3dx_info:
Lc3iM:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iN
Lc3iO:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziBase_cases_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3iN:
	jmp *-16(%r13)
	.long  _s3dx_info - _s3dx_info_dsp
.text
.align 3
_s3dw_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dw_info)+80
	.quad	0
	.quad	4294967312
_s3dw_info:
Lc3iU:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iV
Lc3iW:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _base_GHCziShow_zdfShowInt_closure(%rip),%r14
	addq $-16,%rbp
	jmp _base_GHCziShow_show_info
Lc3iV:
	jmp *-16(%r13)
	.long  _s3dw_info - _s3dw_info_dsp
.text
.align 3
_s3dF_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dF_info)+16
	.quad	1
	.quad	2134598746129
_s3dF_info:
Lc3iX:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3iY
Lc3iZ:
	addq $208,%r12
	cmpq 856(%r13),%r12
	ja Lc3j1
Lc3j0:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s3dA_info(%rip),%rbx
	movq %rbx,-200(%r12)
	movq %rax,-184(%r12)
	leaq -200(%r12),%rbx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-176(%r12)
	movq %rbx,-168(%r12)
	leaq _ghczmprim_GHCziTypes_ZMZN_closure+1(%rip),%rbx
	movq %rbx,-160(%r12)
	leaq -174(%r12),%rbx
	leaq _s3dz_info(%rip),%rcx
	movq %rcx,-152(%r12)
	movq %rax,-136(%r12)
	leaq -152(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-128(%r12)
	movq %rcx,-120(%r12)
	movq %rbx,-112(%r12)
	leaq -126(%r12),%rbx
	leaq _s3dy_info(%rip),%rcx
	movq %rcx,-104(%r12)
	movq %rax,-88(%r12)
	leaq -104(%r12),%rcx
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rdx
	movq %rdx,-80(%r12)
	movq %rcx,-72(%r12)
	movq %rbx,-64(%r12)
	leaq -78(%r12),%rbx
	leaq _s3dx_info(%rip),%rcx
	movq %rcx,-56(%r12)
	movq %rax,-40(%r12)
	leaq -56(%r12),%rax
	leaq _ghczmprim_GHCziTypes_ZC_con_info(%rip),%rcx
	movq %rcx,-32(%r12)
	movq %rax,-24(%r12)
	movq %rbx,-16(%r12)
	leaq -30(%r12),%rax
	leaq _s3dw_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3j1:
	movq $208,904(%r13)
Lc3iY:
	jmp *-16(%r13)
	.long  _s3dF_info - _s3dF_info_dsp
.text
.align 3
_s3dG_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dG_info)+16
	.quad	1
	.quad	4333622001681
_s3dG_info:
Lc3j2:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3j3
Lc3j4:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3j6
Lc3j5:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s3dF_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _base_DataziList_unwords_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc3j6:
	movq $24,904(%r13)
Lc3j3:
	jmp *-16(%r13)
	.long  _s3dG_info - _s3dG_info_dsp
.const
.align 3
.align 0
_c3jb_str:
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
_s3dv_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dv_info)+96
	.quad	0
	.quad	4294967312
_s3dv_info:
Lc3jc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jd
Lc3je:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _c3jb_str(%rip),%r14
	leaq _ghczmprim_GHCziCString_unpackCStringzh_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_n_fast
Lc3jd:
	jmp *-16(%r13)
	.long  _s3dv_info - _s3dv_info_dsp
.text
.align 3
_s3dH_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dH_info)+16
	.quad	1
	.quad	17527761534993
_s3dH_info:
Lc3jf:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jg
Lc3jh:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc3jj
Lc3ji:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s3dG_info(%rip),%rbx
	movq %rbx,-32(%r12)
	movq %rax,-16(%r12)
	leaq -32(%r12),%rax
	leaq _s3dv_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3jj:
	movq $40,904(%r13)
Lc3jg:
	jmp *-16(%r13)
	.long  _s3dH_info - _s3dH_info_dsp
.text
.align 3
_s3dI_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dI_info)+16
	.quad	2
	.quad	17527761534995
_s3dI_info:
Lc3jk:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jl
Lc3jm:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc3jo
Lc3jn:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq 24(%rbx),%rbx
	leaq _s3dH_info(%rip),%rcx
	movq %rcx,-16(%r12)
	movq %rbx,(%r12)
	leaq -16(%r12),%rbx
	movq %rbx,%rsi
	movq %rax,%r14
	leaq _base_GHCziBase_zpzp_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3jo:
	movq $24,904(%r13)
Lc3jl:
	jmp *-16(%r13)
	.long  _s3dI_info - _s3dI_info_dsp
.text
.align 3
_s3dJ_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dJ_info)+16
	.quad	4294967301
	.quad	1
	.quad	35154307317770
_s3dJ_info:
Lc3jp:
Lc3jr:
	addq $56,%r12
	cmpq 856(%r13),%r12
	ja Lc3jt
Lc3js:
	movq 7(%rbx),%rax
	leaq _s3du_info(%rip),%rbx
	movq %rbx,-48(%r12)
	movq %r14,-32(%r12)
	leaq -48(%r12),%rbx
	leaq _s3dI_info(%rip),%rcx
	movq %rcx,-24(%r12)
	movq %rax,-8(%r12)
	movq %rbx,(%r12)
	leaq -24(%r12),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_putStrLn_closure(%rip),%rbx
	jmp _stg_ap_p_fast
Lc3jt:
	movq $56,904(%r13)
Lc3jq:
	jmp *-8(%r13)
	.long  _s3dJ_info - _s3dJ_info_dsp
.text
.align 3
_s3dr_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3dr_info)+120
	.quad	0
	.quad	12884901904
_s3dr_info:
Lc3jC:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jD
Lc3jE:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	leaq _ghczmprim_GHCziTypes_False_closure+1(%rip),%rsi
	leaq _base_GHCziIOziHandleziFD_stderr_closure(%rip),%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziText_putTextToHandle_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3jD:
	jmp *-16(%r13)
	.long  _s3dr_info - _s3dr_info_dsp
.text
.align 3
_s3ds_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_s3ds_info)+120
	.quad	1
	.quad	30064771089
_s3ds_info:
Lc3jF:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jG
Lc3jH:
	addq $16,%r12
	cmpq 856(%r13),%r12
	ja Lc3jJ
Lc3jI:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s3dr_info(%rip),%rbx
	movq %rbx,-8(%r12)
	leaq -8(%r12),%rbx
	movq %rax,%rsi
	movq %rbx,%r14
	leaq _HUnitzm1zi2zi5zi2_TestziHUnitziText_runTestText_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_pp_fast
Lc3jJ:
	movq $16,904(%r13)
Lc3jG:
	jmp *-16(%r13)
	.long  _s3ds_info - _s3ds_info_dsp
.text
.align 3
_RunTestWV_runTestWV_info_dsp:
.text
.align 3
	.quad	_S3g4_srt-(_RunTestWV_runTestWV_info)+16
	.quad	8589934607
	.quad	0
	.quad	1125869842071567
.globl _RunTestWV_runTestWV_info
_RunTestWV_runTestWV_info:
Lc3jK:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc3jL
Lc3jM:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc3jO
Lc3jN:
	leaq _s3dJ_info(%rip),%rax
	movq %rax,-32(%r12)
	movq %r14,-24(%r12)
	leaq -31(%r12),%rax
	leaq _s3ds_info(%rip),%rbx
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
Lc3jO:
	movq $40,904(%r13)
Lc3jL:
	leaq _RunTestWV_runTestWV_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _RunTestWV_runTestWV_info - _RunTestWV_runTestWV_info_dsp
.const_data
.align 3
.align 0
_S3g4_srt:
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
	.quad	_base_GHCziIOziHandleziFD_stderr_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziText_putTextToHandle_closure
	.quad	_HUnitzm1zi2zi5zi2_TestziHUnitziText_runTestText_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_RunTestWV_runTestWV_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

