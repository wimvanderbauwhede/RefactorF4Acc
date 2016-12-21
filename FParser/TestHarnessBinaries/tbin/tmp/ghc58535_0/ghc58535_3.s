.data
.align 3
.align 0
.globl ___stginit_F95SrcIO
___stginit_F95SrcIO:
.data
.align 3
.align 0
.globl _F95SrcIO_writezuF95zusrc_closure
_F95SrcIO_writezuF95zusrc_closure:
	.quad	_F95SrcIO_writezuF95zusrc_info
	.quad	0
.text
.align 3
_s1kS_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_s1kS_info)+0
	.quad	1
	.quad	4294967313
_s1kS_info:
Lc1l7:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1l8
Lc1l9:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_DataziList_unlines_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1l8:
	jmp *-16(%r13)
	.long  _s1kS_info - _s1kS_info_dsp
.text
.align 3
_F95SrcIO_writezuF95zusrc_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_F95SrcIO_writezuF95zusrc_info)+0
	.quad	8589934607
	.quad	0
	.quad	30064771087
.globl _F95SrcIO_writezuF95zusrc_info
_F95SrcIO_writezuF95zusrc_info:
Lc1la:
Lc1lc:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1le
Lc1ld:
	leaq _s1kS_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %rsi,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%rsi
	leaq _base_SystemziIO_writeFile_closure(%rip),%rbx
	jmp _stg_ap_pp_fast
Lc1le:
	movq $24,904(%r13)
Lc1lb:
	leaq _F95SrcIO_writezuF95zusrc_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _F95SrcIO_writezuF95zusrc_info - _F95SrcIO_writezuF95zusrc_info_dsp
.data
.align 3
.align 0
_rWz_closure:
	.quad	_rWz_info
	.quad	0
	.quad	0
	.quad	0
.text
.align 3
_rWz_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_rWz_info)+24
	.quad	0
	.quad	12884901910
_rWz_info:
Lc1lv:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1lw
Lc1lx:
	movq %r13,%rdi
	movq %rbx,%rsi
	subq $8,%rsp
	movl $0,%eax
	call _newCAF
	addq $8,%rsp
	testq %rax,%rax
	je Lc1lu
Lc1lt:
	movq _stg_bh_upd_frame_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	leaq _base_GHCziUnicode_toLower_closure(%rip),%r14
	leaq _base_GHCziBase_map_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1lu:
	jmp *(%rbx)
Lc1lw:
	jmp *-16(%r13)
	.long  _rWz_info - _rWz_info_dsp
.data
.align 3
.align 0
.globl _F95SrcIO_readzuF95zusrc_closure
_F95SrcIO_readzuF95zusrc_closure:
	.quad	_F95SrcIO_readzuF95zusrc_info
	.quad	0
.text
.align 3
_s1kW_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_s1kW_info)+40
	.quad	1
	.quad	4294967313
_s1kW_info:
Lc1lV:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1lW
Lc1lX:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _rWz_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1lW:
	jmp *-16(%r13)
	.long  _s1kW_info - _s1kW_info_dsp
.text
.align 3
_s1kX_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_s1kX_info)+40
	.quad	1
	.quad	12884901905
_s1kX_info:
Lc1lY:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1lZ
Lc1m0:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1m2
Lc1m1:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	leaq _s1kW_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %rax,(%r12)
	leaq -16(%r12),%rax
	movq %rax,%r14
	leaq _base_DataziList_lines_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1m2:
	movq $24,904(%r13)
Lc1lZ:
	jmp *-16(%r13)
	.long  _s1kX_info - _s1kX_info_dsp
.text
.align 3
_s1kY_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_s1kY_info)+40
	.quad	4294967301
	.quad	4294967296
	.quad	30064771083
_s1kY_info:
Lc1m3:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1m4
Lc1m5:
	addq $24,%r12
	cmpq 856(%r13),%r12
	ja Lc1m7
Lc1m6:
	leaq _s1kX_info(%rip),%rax
	movq %rax,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rax
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_p_info@GOTPCREL(%rip),%rbx
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-16,%rbp
	jmp _base_GHCziBase_return_info
Lc1m7:
	movq $24,904(%r13)
Lc1m4:
	jmp *-8(%r13)
	.long  _s1kY_info - _s1kY_info_dsp
.text
.align 3
_s1kU_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_s1kU_info)+64
	.quad	1
	.quad	4294967313
_s1kU_info:
Lc1mc:
	leaq -16(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1md
Lc1me:
	movq _stg_upd_frame_info@GOTPCREL(%rip),%rax
	movq %rax,-16(%rbp)
	movq %rbx,-8(%rbp)
	movq 16(%rbx),%rax
	movq %rax,%r14
	leaq _base_SystemziIO_readFile_closure(%rip),%rbx
	addq $-16,%rbp
	jmp _stg_ap_p_fast
Lc1md:
	jmp *-16(%r13)
	.long  _s1kU_info - _s1kU_info_dsp
.text
.align 3
_F95SrcIO_readzuF95zusrc_info_dsp:
.text
.align 3
	.quad	_S1lf_srt-(_F95SrcIO_readzuF95zusrc_info)+40
	.quad	4294967301
	.quad	0
	.quad	133143986191
.globl _F95SrcIO_readzuF95zusrc_info
_F95SrcIO_readzuF95zusrc_info:
Lc1mf:
	leaq -24(%rbp),%rax
	cmpq %r15,%rax
	jb Lc1mg
Lc1mh:
	addq $40,%r12
	cmpq 856(%r13),%r12
	ja Lc1mj
Lc1mi:
	leaq _s1kY_info(%rip),%rax
	movq %rax,-32(%r12)
	leaq -31(%r12),%rax
	leaq _s1kU_info(%rip),%rbx
	movq %rbx,-16(%r12)
	movq %r14,(%r12)
	leaq -16(%r12),%rbx
	leaq _base_GHCziBase_zdfMonadIO_closure(%rip),%r14
	movq _stg_ap_pp_info@GOTPCREL(%rip),%rcx
	movq %rcx,-24(%rbp)
	movq %rbx,-16(%rbp)
	movq %rax,-8(%rbp)
	addq $-24,%rbp
	jmp _base_GHCziBase_zgzgze_info
Lc1mj:
	movq $40,904(%r13)
Lc1mg:
	leaq _F95SrcIO_readzuF95zusrc_closure(%rip),%rbx
	jmp *-8(%r13)
	.long  _F95SrcIO_readzuF95zusrc_info - _F95SrcIO_readzuF95zusrc_info_dsp
.const_data
.align 3
.align 0
_S1lf_srt:
	.quad	_base_DataziList_unlines_closure
	.quad	_base_SystemziIO_writeFile_closure
	.quad	_F95SrcIO_writezuF95zusrc_closure
	.quad	_base_GHCziBase_map_closure
	.quad	_base_GHCziUnicode_toLower_closure
	.quad	_rWz_closure
	.quad	_base_DataziList_lines_closure
	.quad	_base_GHCziBase_zdfMonadIO_closure
	.quad	_base_SystemziIO_readFile_closure
	.quad	_F95SrcIO_readzuF95zusrc_closure
.subsections_via_symbols
.ident "GHC 7.8.3"

