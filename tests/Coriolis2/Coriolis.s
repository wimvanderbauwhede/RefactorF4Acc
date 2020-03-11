	.file	"Coriolis.f95"
	.section .rdata,"dr"
.LC8:
	.ascii "Coriolis.f95\0"
.LC9:
	.ascii "output1.txt"
.LC10:
	.ascii "formatted"
.LC11:
	.ascii "output2.txt"
	.text
	.def	MAIN__;	.scl	3;	.type	32;	.endef
	.seh_proc	MAIN__
MAIN__:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$632, %rsp
	.seh_stackalloc	632
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	movaps	%xmm6, 480(%rbp)
	.seh_savexmm	%xmm6, 608
	.seh_endprologue
	movl	.LC0(%rip), %eax
	movl	%eax, 472(%rbp)
	movl	.LC0(%rip), %eax
	movl	%eax, 464(%rbp)
	movl	.LC1(%rip), %eax
	movl	%eax, 412(%rbp)
	movl	.LC2(%rip), %eax
	movl	%eax, 408(%rbp)
	movl	.LC3(%rip), %eax
	movl	%eax, 456(%rbp)
	movss	456(%rbp), %xmm0
	addss	%xmm0, %xmm0
	movss	.LC4(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	.LC5(%rip), %xmm1
	xorps	%xmm1, %xmm0
	movss	%xmm0, 424(%rbp)
	movss	424(%rbp), %xmm0
	addss	%xmm0, %xmm0
	movss	%xmm0, 452(%rbp)
	movl	.LC6(%rip), %eax
	movl	%eax, 428(%rbp)
	movss	428(%rbp), %xmm0
	movss	452(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, 448(%rbp)
	movss	448(%rbp), %xmm1
	movss	.LC7(%rip), %xmm0
	mulss	%xmm1, %xmm0
	mulss	448(%rbp), %xmm0
	movss	%xmm0, 444(%rbp)
	movl	$200, 420(%rbp)
	movl	$1, 440(%rbp)
	cmpl	$1, 440(%rbp)
	jne	.L2
	leaq	.LC8(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	$34, -64(%rbp)
	leaq	.LC9(%rip), %rax
	movq	%rax, -32(%rbp)
	movl	$11, -36(%rbp)
	leaq	.LC10(%rip), %rax
	movq	%rax, 0(%rbp)
	movl	$9, 8(%rbp)
	movl	$2304, -80(%rbp)
	movl	$10, -76(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	_gfortran_st_open
	jmp	.L3
.L2:
	leaq	.LC8(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	$36, -64(%rbp)
	leaq	.LC11(%rip), %rax
	movq	%rax, -32(%rbp)
	movl	$11, -36(%rbp)
	leaq	.LC10(%rip), %rax
	movq	%rax, 0(%rbp)
	movl	$9, 8(%rbp)
	movl	$2304, -80(%rbp)
	movl	$10, -76(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	_gfortran_st_open
.L3:
	leaq	.LC8(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	$39, -64(%rbp)
	movl	$128, -80(%rbp)
	movl	$10, -76(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	_gfortran_st_write
	leaq	424(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rcx
	call	_gfortran_transfer_real_write
	leaq	428(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rcx
	call	_gfortran_transfer_real_write
	leaq	420(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rcx
	call	_gfortran_transfer_integer_write
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	_gfortran_st_write_done
	movl	420(%rbp), %ebx
	movl	$1, 476(%rbp)
	cmpl	%ebx, 476(%rbp)
	jg	.L1
.L7:
	cvtsi2ss	476(%rbp), %xmm0
	movss	428(%rbp), %xmm1
	mulss	%xmm1, %xmm0
	movss	%xmm0, 416(%rbp)
	cmpl	$1, 440(%rbp)
	jne	.L5
	movss	.LC12(%rip), %xmm0
	subss	444(%rbp), %xmm0
	movaps	%xmm0, %xmm1
	mulss	472(%rbp), %xmm1
	movss	448(%rbp), %xmm0
	mulss	464(%rbp), %xmm0
	addss	%xmm1, %xmm0
	movss	444(%rbp), %xmm2
	movss	.LC12(%rip), %xmm1
	addss	%xmm2, %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, 468(%rbp)
	movss	.LC12(%rip), %xmm0
	subss	444(%rbp), %xmm0
	mulss	464(%rbp), %xmm0
	movss	448(%rbp), %xmm1
	mulss	472(%rbp), %xmm1
	subss	%xmm1, %xmm0
	movss	444(%rbp), %xmm2
	movss	.LC12(%rip), %xmm1
	addss	%xmm2, %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, 460(%rbp)
	jmp	.L6
.L5:
	movl	448(%rbp), %eax
	movl	%eax, -84(%rbp)
	movss	-84(%rbp), %xmm0
	call	cosf
	movaps	%xmm0, %xmm6
	mulss	472(%rbp), %xmm6
	movl	448(%rbp), %eax
	movl	%eax, -84(%rbp)
	movss	-84(%rbp), %xmm0
	call	sinf
	mulss	464(%rbp), %xmm0
	addss	%xmm6, %xmm0
	movss	%xmm0, 468(%rbp)
	movl	448(%rbp), %eax
	movl	%eax, -84(%rbp)
	movss	-84(%rbp), %xmm0
	call	cosf
	movaps	%xmm0, %xmm6
	mulss	464(%rbp), %xmm6
	movl	448(%rbp), %eax
	movl	%eax, -84(%rbp)
	movss	-84(%rbp), %xmm0
	call	sinf
	mulss	472(%rbp), %xmm0
	subss	%xmm0, %xmm6
	movaps	%xmm6, %xmm0
	movss	%xmm0, 460(%rbp)
.L6:
	movss	428(%rbp), %xmm0
	mulss	468(%rbp), %xmm0
	movss	.LC13(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	412(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, 436(%rbp)
	movss	428(%rbp), %xmm0
	mulss	460(%rbp), %xmm0
	movss	.LC13(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	408(%rbp), %xmm1
	addss	%xmm1, %xmm0
	movss	%xmm0, 432(%rbp)
	movl	468(%rbp), %eax
	movl	%eax, 472(%rbp)
	movl	460(%rbp), %eax
	movl	%eax, 464(%rbp)
	movl	436(%rbp), %eax
	movl	%eax, 412(%rbp)
	movl	432(%rbp), %eax
	movl	%eax, 408(%rbp)
	leaq	.LC8(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	$67, -64(%rbp)
	movl	$128, -80(%rbp)
	movl	$10, -76(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	_gfortran_st_write
	leaq	412(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rcx
	call	_gfortran_transfer_real_write
	leaq	408(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rcx
	call	_gfortran_transfer_real_write
	leaq	416(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$4, %r8d
	movq	%rax, %rcx
	call	_gfortran_transfer_real_write
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	_gfortran_st_write_done
	cmpl	%ebx, 476(%rbp)
	sete	%al
	movzbl	%al, %eax
	addl	$1, 476(%rbp)
	testl	%eax, %eax
	jne	.L1
	jmp	.L7
.L1:
	movaps	480(%rbp), %xmm6
	addq	$632, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	movq	24(%rbp), %rax
	movq	%rax, %rdx
	movl	16(%rbp), %ecx
	call	_gfortran_set_args
	leaq	options.4.1899(%rip), %rdx
	movl	$7, %ecx
	call	_gfortran_set_options
	call	MAIN__
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 16
options.4.1899:
	.long	68
	.long	1023
	.long	0
	.long	0
	.long	1
	.long	1
	.long	0
	.align 4
.LC0:
	.long	1056964608
	.align 4
.LC1:
	.long	0
	.align 4
.LC2:
	.long	1084227584
	.align 4
.LC3:
	.long	1078530011
	.align 4
.LC4:
	.long	1202241536
	.align 16
.LC5:
	.long	2147483648
	.long	0
	.long	0
	.long	0
	.align 4
.LC6:
	.long	1138229248
	.align 4
.LC7:
	.long	1048576000
	.align 4
.LC12:
	.long	1065353216
	.align 4
.LC13:
	.long	1148846080
	.ident	"GCC: (GNU) 4.8.2"
	.def	_gfortran_st_open;	.scl	2;	.type	32;	.endef
	.def	_gfortran_st_write;	.scl	2;	.type	32;	.endef
	.def	_gfortran_transfer_real_write;	.scl	2;	.type	32;	.endef
	.def	_gfortran_transfer_integer_write;	.scl	2;	.type	32;	.endef
	.def	_gfortran_st_write_done;	.scl	2;	.type	32;	.endef
	.def	cosf;	.scl	2;	.type	32;	.endef
	.def	sinf;	.scl	2;	.type	32;	.endef
	.def	_gfortran_set_args;	.scl	2;	.type	32;	.endef
	.def	_gfortran_set_options;	.scl	2;	.type	32;	.endef
