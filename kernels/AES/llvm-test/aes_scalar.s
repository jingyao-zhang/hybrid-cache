	.text
	.file	"aes_scalar.c"
	.globl	RotWord                         # -- Begin function RotWord
	.p2align	4, 0x90
	.type	RotWord,@function
RotWord:                                # @RotWord
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movb	(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	1(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, (%rax)
	movq	-8(%rbp), %rax
	movb	2(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 1(%rax)
	movq	-8(%rbp), %rax
	movb	3(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 2(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 3(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	RotWord, .Lfunc_end0-RotWord
	.cfi_endproc
                                        # -- End function
	.globl	SubWord                         # -- Begin function SubWord
	.p2align	4, 0x90
	.type	SubWord,@function
SubWord:                                # @SubWord
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	$0, -12(%rbp)
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$4, -12(%rbp)
	jge	.LBB1_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, %ecx
	leaq	s_box(%rip), %rax
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB1_1
.LBB1_4:                                # %for.end
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	SubWord, .Lfunc_end1-SubWord
	.cfi_endproc
                                        # -- End function
	.globl	KeyExpansion                    # -- Begin function KeyExpansion
	.p2align	4, 0x90
	.type	KeyExpansion,@function
KeyExpansion:                           # @KeyExpansion
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$0, -20(%rbp)
	movl	$0, -20(%rbp)
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$16, -20(%rbp)
	jge	.LBB2_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movb	(%rax,%rcx), %dl
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB2_1 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB2_1
.LBB2_4:                                # %for.end
	movl	$16, -20(%rbp)
.LBB2_5:                                # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #     Child Loop BB2_13 Depth 2
	cmpl	$176, -20(%rbp)
	jge	.LBB2_17
# %bb.6:                                # %while.body
                                        #   in Loop: Header=BB2_5 Depth=1
	movl	$0, -28(%rbp)
.LBB2_7:                                # %for.cond4
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$4, -28(%rbp)
	jge	.LBB2_10
# %bb.8:                                # %for.body6
                                        #   in Loop: Header=BB2_7 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	subl	$4, %ecx
	addl	-28(%rbp), %ecx
	movslq	%ecx, %rcx
	movb	(%rax,%rcx), %cl
	movslq	-28(%rbp), %rax
	movb	%cl, -24(%rbp,%rax)
# %bb.9:                                # %for.inc11
                                        #   in Loop: Header=BB2_7 Depth=2
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB2_7
.LBB2_10:                               # %for.end13
                                        #   in Loop: Header=BB2_5 Depth=1
	movl	-20(%rbp), %eax
	movl	$16, %ecx
	cltd
	idivl	%ecx
	cmpl	$0, %edx
	jne	.LBB2_12
# %bb.11:                               # %if.then
                                        #   in Loop: Header=BB2_5 Depth=1
	leaq	-24(%rbp), %rdi
	callq	RotWord
	leaq	-24(%rbp), %rdi
	callq	SubWord
	movzbl	-24(%rbp), %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	movl	-20(%rbp), %eax
	movl	$16, %ecx
	cltd
	idivl	%ecx
	movl	%eax, %ecx
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movslq	%ecx, %rdx
	leaq	rcon(%rip), %rcx
	movzbl	(%rcx,%rdx), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -24(%rbp)
.LBB2_12:                               # %if.end
                                        #   in Loop: Header=BB2_5 Depth=1
	movl	$0, -32(%rbp)
.LBB2_13:                               # %for.cond23
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$4, -32(%rbp)
	jge	.LBB2_16
# %bb.14:                               # %for.body26
                                        #   in Loop: Header=BB2_13 Depth=2
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	subl	$16, %ecx
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %eax
	movslq	-32(%rbp), %rcx
	movzbl	-24(%rbp,%rcx), %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
# %bb.15:                               # %for.inc39
                                        #   in Loop: Header=BB2_13 Depth=2
	movl	-32(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB2_13
.LBB2_16:                               # %for.end41
                                        #   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_5
.LBB2_17:                               # %while.end
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	KeyExpansion, .Lfunc_end2-KeyExpansion
	.cfi_endproc
                                        # -- End function
	.globl	AddRoundKey                     # -- Begin function AddRoundKey
	.p2align	4, 0x90
	.type	AddRoundKey,@function
AddRoundKey:                            # @AddRoundKey
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$0, -20(%rbp)
.LBB3_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$16, -20(%rbp)
	jge	.LBB3_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB3_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %esi
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB3_1 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB3_1
.LBB3_4:                                # %for.end
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	AddRoundKey, .Lfunc_end3-AddRoundKey
	.cfi_endproc
                                        # -- End function
	.globl	SubBytes                        # -- Begin function SubBytes
	.p2align	4, 0x90
	.type	SubBytes,@function
SubBytes:                               # @SubBytes
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	$0, -12(%rbp)
.LBB4_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$16, -12(%rbp)
	jge	.LBB4_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, %ecx
	leaq	s_box(%rip), %rax
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB4_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB4_1
.LBB4_4:                                # %for.end
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	SubBytes, .Lfunc_end4-SubBytes
	.cfi_endproc
                                        # -- End function
	.globl	ShiftRows                       # -- Begin function ShiftRows
	.p2align	4, 0x90
	.type	ShiftRows,@function
ShiftRows:                              # @ShiftRows
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movb	1(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	5(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 1(%rax)
	movq	-8(%rbp), %rax
	movb	9(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 5(%rax)
	movq	-8(%rbp), %rax
	movb	13(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 9(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 13(%rax)
	movq	-8(%rbp), %rax
	movb	2(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	10(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 2(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 10(%rax)
	movq	-8(%rbp), %rax
	movb	6(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	14(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 6(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 14(%rax)
	movq	-8(%rbp), %rax
	movb	3(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	15(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 3(%rax)
	movq	-8(%rbp), %rax
	movb	11(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 15(%rax)
	movq	-8(%rbp), %rax
	movb	7(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 11(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 7(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	ShiftRows, .Lfunc_end5-ShiftRows
	.cfi_endproc
                                        # -- End function
	.globl	gmul                            # -- Begin function gmul
	.p2align	4, 0x90
	.type	gmul,@function
gmul:                                   # @gmul
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%sil, %al
	movb	%dil, %cl
	movb	%cl, -1(%rbp)
	movb	%al, -2(%rbp)
	movb	$0, -3(%rbp)
	movb	$0, -4(%rbp)
.LBB6_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movzbl	-4(%rbp), %eax
	cmpl	$8, %eax
	jge	.LBB6_8
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB6_1 Depth=1
	movzbl	-2(%rbp), %eax
	andl	$1, %eax
	cmpl	$0, %eax
	je	.LBB6_4
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB6_1 Depth=1
	movzbl	-1(%rbp), %ecx
	movzbl	-3(%rbp), %eax
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -3(%rbp)
.LBB6_4:                                # %if.end
                                        #   in Loop: Header=BB6_1 Depth=1
	movzbl	-1(%rbp), %eax
	andl	$128, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -5(%rbp)
	movzbl	-1(%rbp), %eax
	shll	$1, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -1(%rbp)
	movzbl	-5(%rbp), %eax
	cmpl	$0, %eax
	je	.LBB6_6
# %bb.5:                                # %if.then16
                                        #   in Loop: Header=BB6_1 Depth=1
	movzbl	-1(%rbp), %eax
	xorl	$27, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -1(%rbp)
.LBB6_6:                                # %if.end20
                                        #   in Loop: Header=BB6_1 Depth=1
	movzbl	-2(%rbp), %eax
	sarl	$1, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -2(%rbp)
# %bb.7:                                # %for.inc
                                        #   in Loop: Header=BB6_1 Depth=1
	movb	-4(%rbp), %al
	addb	$1, %al
	movb	%al, -4(%rbp)
	jmp	.LBB6_1
.LBB6_8:                                # %for.end
	movzbl	-3(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	gmul, .Lfunc_end6-gmul
	.cfi_endproc
                                        # -- End function
	.globl	MixColumns                      # -- Begin function MixColumns
	.p2align	4, 0x90
	.type	MixColumns,@function
MixColumns:                             # @MixColumns
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -8(%rbp)
	movb	$0, -9(%rbp)
.LBB7_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movzbl	-9(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB7_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	movslq	%ecx, %rcx
	movb	(%rax,%rcx), %al
	movb	%al, -13(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	movb	(%rax,%rcx), %al
	movb	%al, -12(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	addl	$2, %ecx
	movslq	%ecx, %rcx
	movb	(%rax,%rcx), %al
	movb	%al, -11(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	addl	$3, %ecx
	movslq	%ecx, %rcx
	movb	(%rax,%rcx), %al
	movb	%al, -10(%rbp)
	movl	$2, %esi
	movzbl	-13(%rbp), %edi
	callq	gmul
	movzbl	%al, %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-10(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-68(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-11(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-64(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	movl	$3, %esi
	movzbl	-12(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-60(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -17(%rbp)
	movl	$2, %esi
	movzbl	-12(%rbp), %edi
	callq	gmul
	movzbl	%al, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-13(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-10(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movl	$3, %esi
	movzbl	-11(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-48(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -16(%rbp)
	movl	$2, %esi
	movzbl	-11(%rbp), %edi
	callq	gmul
	movzbl	%al, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-12(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-44(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-13(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-40(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	movl	$3, %esi
	movzbl	-10(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -15(%rbp)
	movl	$2, %esi
	movzbl	-10(%rbp), %edi
	callq	gmul
	movzbl	%al, %eax
	movl	%eax, -32(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-11(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-32(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -28(%rbp)                 # 4-byte Spill
	movl	$1, %esi
	movzbl	-12(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-28(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
	movl	%eax, -24(%rbp)                 # 4-byte Spill
	movl	$3, %esi
	movzbl	-13(%rbp), %edi
	callq	gmul
	movb	%al, %cl
	movl	-24(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -14(%rbp)
	movb	-17(%rbp), %dl
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	movb	-16(%rbp), %dl
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	addl	$1, %ecx
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	movb	-15(%rbp), %dl
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	addl	$2, %ecx
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
	movb	-14(%rbp), %dl
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	shll	$2, %ecx
	addl	$3, %ecx
	movslq	%ecx, %rcx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB7_1 Depth=1
	movb	-9(%rbp), %al
	addb	$1, %al
	movb	%al, -9(%rbp)
	jmp	.LBB7_1
.LBB7_4:                                # %for.end
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end7:
	.size	MixColumns, .Lfunc_end7-MixColumns
	.cfi_endproc
                                        # -- End function
	.globl	AES128Encrypt                   # -- Begin function AES128Encrypt
	.p2align	4, 0x90
	.type	AES128Encrypt,@function
AES128Encrypt:                          # @AES128Encrypt
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$240, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	8(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rdi
	leaq	-224(%rbp), %rsi
	callq	KeyExpansion
	leaq	-48(%rbp), %rdi
	leaq	-224(%rbp), %rsi
	callq	AddRoundKey
	movl	$1, -228(%rbp)
.LBB8_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$10, -228(%rbp)
	jge	.LBB8_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB8_1 Depth=1
	leaq	-48(%rbp), %rdi
	callq	SubBytes
	leaq	-48(%rbp), %rdi
	callq	ShiftRows
	leaq	-48(%rbp), %rdi
	callq	MixColumns
	leaq	-48(%rbp), %rdi
	leaq	-224(%rbp), %rsi
	movl	-228(%rbp), %eax
	shll	$4, %eax
	cltq
	addq	%rax, %rsi
	callq	AddRoundKey
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB8_1 Depth=1
	movl	-228(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -228(%rbp)
	jmp	.LBB8_1
.LBB8_4:                                # %for.end
	leaq	-48(%rbp), %rdi
	callq	SubBytes
	leaq	-48(%rbp), %rdi
	callq	ShiftRows
	leaq	-48(%rbp), %rdi
	leaq	-224(%rbp), %rsi
	addq	$160, %rsi
	callq	AddRoundKey
	movq	-16(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	%rcx, (%rax)
	movq	-40(%rbp), %rcx
	movq	%rcx, 8(%rax)
	addq	$240, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	AES128Encrypt, .Lfunc_end8-AES128Encrypt
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movl	$0, -4(%rbp)
	leaq	-32(%rbp), %rdi
	xorl	%esi, %esi
	movl	$16, %edx
	callq	memset@PLT
	movq	.L__const.main.key(%rip), %rax
	movq	%rax, -48(%rbp)
	movq	.L__const.main.key+8(%rip), %rax
	movq	%rax, -40(%rbp)
	leaq	-64(%rbp), %rdi
	xorl	%esi, %esi
	movl	$16, %edx
	callq	memset@PLT
	leaq	-32(%rbp), %rdi
	leaq	-64(%rbp), %rsi
	leaq	-48(%rbp), %rdx
	callq	AES128Encrypt
	leaq	.L.str(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	movl	$0, -68(%rbp)
.LBB9_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$16, -68(%rbp)
	jge	.LBB9_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB9_1 Depth=1
	movslq	-68(%rbp), %rax
	movzbl	-64(%rbp,%rax), %esi
	leaq	.L.str.1(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB9_1 Depth=1
	movl	-68(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB9_1
.LBB9_4:                                # %for.end
	leaq	.L.str.2(%rip), %rdi
	movb	$0, %al
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	main, .Lfunc_end9-main
	.cfi_endproc
                                        # -- End function
	.type	s_box,@object                   # @s_box
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
s_box:
	.ascii	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321\000\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.size	s_box, 256

	.type	rcon,@object                    # @rcon
rcon:
	.ascii	"\000\001\002\004\b\020 @\200\0336"
	.size	rcon, 11

	.type	.L__const.main.key,@object      # @__const.main.key
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.L__const.main.key:
	.ascii	"\000\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017"
	.size	.L__const.main.key, 16

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Ciphertext: "
	.size	.L.str, 13

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%02x "
	.size	.L.str.1, 6

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"\n"
	.size	.L.str.2, 2

	.ident	"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym RotWord
	.addrsig_sym SubWord
	.addrsig_sym KeyExpansion
	.addrsig_sym AddRoundKey
	.addrsig_sym SubBytes
	.addrsig_sym ShiftRows
	.addrsig_sym gmul
	.addrsig_sym MixColumns
	.addrsig_sym AES128Encrypt
	.addrsig_sym printf
	.addrsig_sym s_box
	.addrsig_sym rcon
