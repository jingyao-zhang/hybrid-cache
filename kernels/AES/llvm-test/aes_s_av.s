	.text
	.file	"aes_scalar.c"
	.globl	RotWord                         # -- Begin function RotWord
	.p2align	4, 0x90
	.type	RotWord,@function
RotWord:                                # @RotWord
	.cfi_startproc
# %bb.0:                                # %entry
	movd	(%rdi), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	movdqa	%xmm0, %xmm1
	psrld	$8, %xmm1
	pslld	$24, %xmm0
	por	%xmm1, %xmm0
	movd	%xmm0, (%rdi)
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
	movzbl	(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, (%rdi)
	movzbl	1(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 1(%rdi)
	movzbl	2(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 2(%rdi)
	movzbl	3(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 3(%rdi)
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
	movzbl	(%rdi), %eax
	movb	%al, (%rsi)
	movzbl	1(%rdi), %eax
	movb	%al, 1(%rsi)
	movzbl	2(%rdi), %eax
	movb	%al, 2(%rsi)
	movzbl	3(%rdi), %eax
	movb	%al, 3(%rsi)
	movzbl	4(%rdi), %eax
	movb	%al, 4(%rsi)
	movzbl	5(%rdi), %eax
	movb	%al, 5(%rsi)
	movzbl	6(%rdi), %eax
	movb	%al, 6(%rsi)
	movzbl	7(%rdi), %eax
	movb	%al, 7(%rsi)
	movzbl	8(%rdi), %eax
	movb	%al, 8(%rsi)
	movzbl	9(%rdi), %eax
	movb	%al, 9(%rsi)
	movzbl	10(%rdi), %eax
	movb	%al, 10(%rsi)
	movzbl	11(%rdi), %eax
	movb	%al, 11(%rsi)
	movzbl	12(%rdi), %eax
	movb	%al, 12(%rsi)
	movzbl	13(%rdi), %eax
	movb	%al, 13(%rsi)
	movzbl	14(%rdi), %eax
	movb	%al, 14(%rsi)
	movzbl	15(%rdi), %eax
	movb	%al, 15(%rsi)
	movd	12(%rsi), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	movl	$16, %eax
	jmp	.LBB2_1
	.p2align	4, 0x90
.LBB2_3:                                # %if.end
                                        #   in Loop: Header=BB2_1 Depth=1
	movd	-16(%rsi,%rax), %xmm1           # xmm1 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm0
	movd	%xmm0, (%rsi,%rax)
	leaq	4(%rax), %rcx
	addq	$3, %rax
	cmpq	$175, %rax
	movq	%rcx, %rax
	jae	.LBB2_4
.LBB2_1:                                # %for.cond4.preheader
                                        # =>This Inner Loop Header: Depth=1
	testb	$12, %al
	jne	.LBB2_3
# %bb.2:                                # %if.then
                                        #   in Loop: Header=BB2_1 Depth=1
	movdqa	%xmm0, -24(%rsp)
	movzbl	-23(%rsp), %ecx
	movzbl	-22(%rsp), %edx
	movzbl	-21(%rsp), %edi
	movzbl	s_box(%rdi), %edi
	movzbl	-24(%rsp), %r8d
	movl	%eax, %r9d
	shrl	$4, %r9d
	movzbl	rcon(%r9), %r9d
	xorb	s_box(%rcx), %r9b
	movzbl	s_box(%r8), %ecx
	shll	$8, %ecx
	orl	%edi, %ecx
	movzbl	%r9b, %edi
	movzbl	s_box(%rdx), %edx
	shll	$8, %edx
	orl	%edi, %edx
	movd	%edx, %xmm0
	pinsrw	$1, %ecx, %xmm0
	jmp	.LBB2_3
.LBB2_4:                                # %while.end
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
	movzbl	(%rsi), %eax
	xorb	%al, (%rdi)
	movzbl	1(%rsi), %eax
	xorb	%al, 1(%rdi)
	movzbl	2(%rsi), %eax
	xorb	%al, 2(%rdi)
	movzbl	3(%rsi), %eax
	xorb	%al, 3(%rdi)
	movzbl	4(%rsi), %eax
	xorb	%al, 4(%rdi)
	movzbl	5(%rsi), %eax
	xorb	%al, 5(%rdi)
	movzbl	6(%rsi), %eax
	xorb	%al, 6(%rdi)
	movzbl	7(%rsi), %eax
	xorb	%al, 7(%rdi)
	movzbl	8(%rsi), %eax
	xorb	%al, 8(%rdi)
	movzbl	9(%rsi), %eax
	xorb	%al, 9(%rdi)
	movzbl	10(%rsi), %eax
	xorb	%al, 10(%rdi)
	movzbl	11(%rsi), %eax
	xorb	%al, 11(%rdi)
	movzbl	12(%rsi), %eax
	xorb	%al, 12(%rdi)
	movzbl	13(%rsi), %eax
	xorb	%al, 13(%rdi)
	movzbl	14(%rsi), %eax
	xorb	%al, 14(%rdi)
	movzbl	15(%rsi), %eax
	xorb	%al, 15(%rdi)
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
	movzbl	(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, (%rdi)
	movzbl	1(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 1(%rdi)
	movzbl	2(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 2(%rdi)
	movzbl	3(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 3(%rdi)
	movzbl	4(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 4(%rdi)
	movzbl	5(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 5(%rdi)
	movzbl	6(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 6(%rdi)
	movzbl	7(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 7(%rdi)
	movzbl	8(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 8(%rdi)
	movzbl	9(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 9(%rdi)
	movzbl	10(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 10(%rdi)
	movzbl	11(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 11(%rdi)
	movzbl	12(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 12(%rdi)
	movzbl	13(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 13(%rdi)
	movzbl	14(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 14(%rdi)
	movzbl	15(%rdi), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, 15(%rdi)
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
	movzbl	5(%rdi), %eax
	movzbl	1(%rdi), %ecx
	movzbl	2(%rdi), %edx
	movb	%al, 1(%rdi)
	movzbl	9(%rdi), %eax
	movb	%al, 5(%rdi)
	movzbl	13(%rdi), %eax
	movb	%al, 9(%rdi)
	movb	%cl, 13(%rdi)
	movzbl	10(%rdi), %eax
	movb	%al, 2(%rdi)
	movb	%dl, 10(%rdi)
	movzbl	6(%rdi), %eax
	movzbl	14(%rdi), %ecx
	movb	%cl, 6(%rdi)
	movb	%al, 14(%rdi)
	movzbl	3(%rdi), %eax
	movzbl	15(%rdi), %ecx
	movb	%cl, 3(%rdi)
	movzbl	11(%rdi), %ecx
	movb	%cl, 15(%rdi)
	movzbl	7(%rdi), %ecx
	movb	%cl, 11(%rdi)
	movb	%al, 7(%rdi)
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
                                        # kill: def $esi killed $esi def $rsi
                                        # kill: def $edi killed $edi def $rdi
	movl	%esi, %eax
	andb	$1, %al
	negb	%al
	andb	%dil, %al
	leal	(%rdi,%rdi), %ecx
	movzbl	%cl, %edx
	xorb	$27, %cl
	testb	%dil, %dil
	movzbl	%cl, %ecx
	cmovnsl	%edx, %ecx
	movl	%esi, %edx
	shlb	$6, %dl
	sarb	$7, %dl
	andb	%cl, %dl
	xorb	%al, %dl
	leal	(%rcx,%rcx), %eax
	movzbl	%al, %edi
	xorb	$27, %al
	testb	%cl, %cl
	movzbl	%al, %eax
	cmovnsl	%edi, %eax
	movl	%esi, %ecx
	shlb	$5, %cl
	sarb	$7, %cl
	andb	%al, %cl
	xorb	%dl, %cl
	leal	(%rax,%rax), %edx
	movzbl	%dl, %edi
	xorb	$27, %dl
	testb	%al, %al
	movzbl	%dl, %eax
	cmovnsl	%edi, %eax
	movl	%esi, %edx
	shlb	$4, %dl
	sarb	$7, %dl
	andb	%al, %dl
	xorb	%cl, %dl
	leal	(%rax,%rax), %ecx
	movzbl	%cl, %edi
	xorb	$27, %cl
	testb	%al, %al
	movzbl	%cl, %eax
	cmovnsl	%edi, %eax
	leal	(,%rsi,8), %ecx
	sarb	$7, %cl
	andb	%al, %cl
	xorb	%dl, %cl
	leal	(%rax,%rax), %edx
	movzbl	%dl, %edi
	xorb	$27, %dl
	testb	%al, %al
	movzbl	%dl, %eax
	cmovnsl	%edi, %eax
	leal	(,%rsi,4), %edx
	sarb	$7, %dl
	andb	%al, %dl
	xorb	%cl, %dl
	leal	(%rax,%rax), %ecx
	movzbl	%cl, %edi
	xorb	$27, %cl
	testb	%al, %al
	movzbl	%cl, %eax
	cmovnsl	%edi, %eax
	leal	(%rsi,%rsi), %ecx
	sarb	$7, %cl
	andb	%al, %cl
	xorb	%dl, %cl
	leal	(%rax,%rax), %edx
	movzbl	%dl, %edi
	xorb	$27, %dl
	testb	%al, %al
	movzbl	%dl, %eax
	cmovnsl	%edi, %eax
	sarb	$7, %sil
	andb	%sil, %al
	xorb	%cl, %al
                                        # kill: def $al killed $al killed $eax
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
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset %rbx, -24
	.cfi_offset %rbp, -16
	movzbl	(%rdi), %ecx
	leal	(%rcx,%rcx), %eax
	movzbl	%al, %esi
	xorb	$27, %al
	testb	%cl, %cl
	movzbl	%al, %edx
	cmovnsl	%esi, %edx
	movzbl	3(%rdi), %eax
	leal	(%rax,%rax), %esi
	movzbl	%sil, %r8d
	xorb	$27, %sil
	testb	%al, %al
	movzbl	%sil, %esi
	cmovnsl	%r8d, %esi
	movzbl	2(%rdi), %r8d
	leal	(%r8,%r8), %r9d
	movzbl	%r9b, %r11d
	xorb	$27, %r9b
	testb	%r8b, %r8b
	movzbl	%r9b, %r10d
	cmovnsl	%r11d, %r10d
	movzbl	1(%rdi), %r9d
	leal	(%r9,%r9), %r11d
	movzbl	%r11b, %ebx
	xorb	$27, %r11b
	testb	%r9b, %r9b
	movzbl	%r11b, %r11d
	cmovnsl	%ebx, %r11d
	movl	%eax, %ebx
	xorb	%r8b, %bl
	movl	%ebx, %ebp
	xorb	%r9b, %bpl
	xorb	%dl, %bpl
	xorb	%r11b, %bpl
	xorb	%cl, %bl
	xorb	%r11b, %bl
	xorb	%r10b, %bl
	xorb	%cl, %r9b
	xorb	%r9b, %al
	xorb	%r10b, %al
	xorb	%sil, %al
	xorb	%r8b, %r9b
	xorb	%dl, %r9b
	xorb	%sil, %r9b
	movb	%bpl, (%rdi)
	movb	%bl, 1(%rdi)
	movb	%al, 2(%rdi)
	movb	%r9b, 3(%rdi)
	movzbl	4(%rdi), %ecx
	leal	(%rcx,%rcx), %eax
	movzbl	%al, %esi
	xorb	$27, %al
	testb	%cl, %cl
	movzbl	%al, %edx
	cmovnsl	%esi, %edx
	movzbl	7(%rdi), %eax
	leal	(%rax,%rax), %esi
	movzbl	%sil, %r8d
	xorb	$27, %sil
	testb	%al, %al
	movzbl	%sil, %esi
	cmovnsl	%r8d, %esi
	movzbl	6(%rdi), %r8d
	leal	(%r8,%r8), %r9d
	movzbl	%r9b, %r11d
	xorb	$27, %r9b
	testb	%r8b, %r8b
	movzbl	%r9b, %r10d
	cmovnsl	%r11d, %r10d
	movzbl	5(%rdi), %r9d
	leal	(%r9,%r9), %r11d
	movzbl	%r11b, %ebx
	xorb	$27, %r11b
	testb	%r9b, %r9b
	movzbl	%r11b, %r11d
	cmovnsl	%ebx, %r11d
	movl	%eax, %ebx
	xorb	%r8b, %bl
	movl	%ebx, %ebp
	xorb	%r9b, %bpl
	xorb	%dl, %bpl
	xorb	%r11b, %bpl
	xorb	%cl, %bl
	xorb	%r11b, %bl
	xorb	%r10b, %bl
	xorb	%cl, %r9b
	xorb	%r9b, %al
	xorb	%r10b, %al
	xorb	%sil, %al
	xorb	%r8b, %r9b
	xorb	%dl, %r9b
	xorb	%sil, %r9b
	movb	%bpl, 4(%rdi)
	movb	%bl, 5(%rdi)
	movb	%al, 6(%rdi)
	movb	%r9b, 7(%rdi)
	movzbl	8(%rdi), %ecx
	leal	(%rcx,%rcx), %eax
	movzbl	%al, %esi
	xorb	$27, %al
	testb	%cl, %cl
	movzbl	%al, %edx
	cmovnsl	%esi, %edx
	movzbl	11(%rdi), %eax
	leal	(%rax,%rax), %esi
	movzbl	%sil, %r8d
	xorb	$27, %sil
	testb	%al, %al
	movzbl	%sil, %esi
	cmovnsl	%r8d, %esi
	movzbl	10(%rdi), %r8d
	leal	(%r8,%r8), %r9d
	movzbl	%r9b, %r11d
	xorb	$27, %r9b
	testb	%r8b, %r8b
	movzbl	%r9b, %r10d
	cmovnsl	%r11d, %r10d
	movzbl	9(%rdi), %r9d
	leal	(%r9,%r9), %r11d
	movzbl	%r11b, %ebx
	xorb	$27, %r11b
	testb	%r9b, %r9b
	movzbl	%r11b, %r11d
	cmovnsl	%ebx, %r11d
	movl	%eax, %ebx
	xorb	%r8b, %bl
	movl	%ebx, %ebp
	xorb	%r9b, %bpl
	xorb	%dl, %bpl
	xorb	%r11b, %bpl
	xorb	%cl, %bl
	xorb	%r11b, %bl
	xorb	%r10b, %bl
	xorb	%cl, %r9b
	xorb	%r9b, %al
	xorb	%r10b, %al
	xorb	%sil, %al
	xorb	%r8b, %r9b
	xorb	%dl, %r9b
	xorb	%sil, %r9b
	movb	%bpl, 8(%rdi)
	movb	%bl, 9(%rdi)
	movb	%al, 10(%rdi)
	movb	%r9b, 11(%rdi)
	movzbl	12(%rdi), %ecx
	leal	(%rcx,%rcx), %eax
	movzbl	%al, %esi
	xorb	$27, %al
	testb	%cl, %cl
	movzbl	%al, %edx
	cmovnsl	%esi, %edx
	movzbl	15(%rdi), %eax
	leal	(%rax,%rax), %esi
	movzbl	%sil, %r8d
	xorb	$27, %sil
	testb	%al, %al
	movzbl	%sil, %esi
	cmovnsl	%r8d, %esi
	movzbl	14(%rdi), %r8d
	leal	(%r8,%r8), %r9d
	movzbl	%r9b, %r11d
	xorb	$27, %r9b
	testb	%r8b, %r8b
	movzbl	%r9b, %r10d
	cmovnsl	%r11d, %r10d
	movzbl	13(%rdi), %r9d
	leal	(%r9,%r9), %r11d
	movzbl	%r11b, %ebx
	xorb	$27, %r11b
	testb	%r9b, %r9b
	movzbl	%r11b, %r11d
	cmovnsl	%ebx, %r11d
	movl	%eax, %ebx
	xorb	%r8b, %bl
	movl	%ebx, %ebp
	xorb	%r9b, %bpl
	xorb	%dl, %bpl
	xorb	%r11b, %bpl
	xorb	%cl, %bl
	xorb	%r11b, %bl
	xorb	%r10b, %bl
	xorb	%cl, %r9b
	xorb	%r9b, %al
	xorb	%r10b, %al
	xorb	%sil, %al
	xorb	%r8b, %r9b
	xorb	%dl, %r9b
	xorb	%sil, %r9b
	movb	%bpl, 12(%rdi)
	movb	%bl, 13(%rdi)
	movb	%al, 14(%rdi)
	movb	%r9b, 15(%rdi)
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
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
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$248, %rsp
	.cfi_def_cfa_offset 304
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rsi, %rbx
	movups	(%rdi), %xmm0
	movaps	%xmm0, (%rsp)
	movups	(%rdx), %xmm0
	movaps	%xmm0, 64(%rsp)
	movl	$16, %eax
	movd	76(%rsp), %xmm0                 # xmm0 = mem[0],zero,zero,zero
	jmp	.LBB8_1
	.p2align	4, 0x90
.LBB8_3:                                # %if.end.i
                                        #   in Loop: Header=BB8_1 Depth=1
	movd	48(%rsp,%rax), %xmm1            # xmm1 = mem[0],zero,zero,zero
	pxor	%xmm1, %xmm0
	movd	%xmm0, 64(%rsp,%rax)
	leaq	4(%rax), %rcx
	addq	$3, %rax
	cmpq	$175, %rax
	movq	%rcx, %rax
	jae	.LBB8_4
.LBB8_1:                                # %for.cond4.preheader.i
                                        # =>This Inner Loop Header: Depth=1
	testb	$12, %al
	jne	.LBB8_3
# %bb.2:                                # %if.then.i
                                        #   in Loop: Header=BB8_1 Depth=1
	movdqa	%xmm0, 48(%rsp)
	movzbl	49(%rsp), %ecx
	movzbl	50(%rsp), %edx
	movzbl	51(%rsp), %esi
	movzbl	s_box(%rsi), %esi
	movzbl	48(%rsp), %edi
	movl	%eax, %r8d
	shrl	$4, %r8d
	movzbl	rcon(%r8), %r8d
	xorb	s_box(%rcx), %r8b
	movzbl	s_box(%rdi), %ecx
	shll	$8, %ecx
	orl	%esi, %ecx
	movzbl	%r8b, %esi
	movzbl	s_box(%rdx), %edx
	shll	$8, %edx
	orl	%esi, %edx
	movd	%edx, %xmm0
	pinsrw	$1, %ecx, %xmm0
	jmp	.LBB8_3
.LBB8_4:                                # %KeyExpansion.exit
	movaps	(%rsp), %xmm0
	xorps	64(%rsp), %xmm0
	movl	$16, %r15d
	movq	%rsp, %r14
	.p2align	4, 0x90
.LBB8_5:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movaps	%xmm0, 32(%rsp)
	movzbl	32(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movb	%al, (%rsp)
	movzbl	33(%rsp), %eax
	movzbl	s_box(%rax), %ecx
	movzbl	34(%rsp), %eax
	movzbl	s_box(%rax), %edx
	movzbl	35(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movzbl	36(%rsp), %esi
	movzbl	s_box(%rsi), %esi
	movb	%sil, 4(%rsp)
	movzbl	37(%rsp), %esi
	movzbl	s_box(%rsi), %r8d
	movzbl	38(%rsp), %esi
	movzbl	s_box(%rsi), %esi
	movzbl	39(%rsp), %edi
	movzbl	s_box(%rdi), %edi
	movzbl	40(%rsp), %r9d
	movzbl	s_box(%r9), %r9d
	movb	%r9b, 8(%rsp)
	movzbl	41(%rsp), %r9d
	movzbl	s_box(%r9), %r9d
	movzbl	42(%rsp), %r10d
	movzbl	s_box(%r10), %r10d
	movzbl	43(%rsp), %r11d
	movzbl	s_box(%r11), %r11d
	movzbl	44(%rsp), %r12d
	movzbl	s_box(%r12), %ebp
	movb	%bpl, 12(%rsp)
	movzbl	45(%rsp), %r12d
	movzbl	s_box(%r12), %ebp
	movzbl	46(%rsp), %r12d
	movzbl	s_box(%r12), %r12d
	movzbl	47(%rsp), %r13d
	movzbl	s_box(%r13), %r13d
	movb	%r8b, 1(%rsp)
	movb	%r9b, 5(%rsp)
	movb	%bpl, 9(%rsp)
	movb	%cl, 13(%rsp)
	movb	%r10b, 2(%rsp)
	movb	%dl, 10(%rsp)
	movb	%r12b, 6(%rsp)
	movb	%sil, 14(%rsp)
	movb	%r13b, 3(%rsp)
	movb	%r11b, 15(%rsp)
	movb	%dil, 11(%rsp)
	movb	%al, 7(%rsp)
	movq	%r14, %rdi
	callq	MixColumns
	movaps	(%rsp), %xmm0
	xorps	64(%rsp,%r15), %xmm0
	movaps	%xmm0, (%rsp)
	addq	$16, %r15
	cmpq	$160, %r15
	jne	.LBB8_5
# %bb.6:                                # %for.cond.cleanup
	movaps	%xmm0, 16(%rsp)
	movzbl	27(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm0
	movzbl	22(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm1
	movzbl	17(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm3
	movzbl	28(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm2
	movzbl	23(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm4
	movzbl	18(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm6
	movzbl	29(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm7
	movzbl	24(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm5
	movzbl	19(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm8
	movzbl	30(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm9
	movzbl	25(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm10
	movzbl	20(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm11
	movzbl	31(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm12
	movzbl	26(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm13
	movzbl	21(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm14
	movzbl	16(%rsp), %eax
	movzbl	s_box(%rax), %eax
	movd	%eax, %xmm15
	punpcklbw	%xmm0, %xmm1            # xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
	punpcklbw	%xmm3, %xmm2            # xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1],xmm2[2],xmm3[2],xmm2[3],xmm3[3],xmm2[4],xmm3[4],xmm2[5],xmm3[5],xmm2[6],xmm3[6],xmm2[7],xmm3[7]
	punpcklwd	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	punpcklbw	%xmm4, %xmm6            # xmm6 = xmm6[0],xmm4[0],xmm6[1],xmm4[1],xmm6[2],xmm4[2],xmm6[3],xmm4[3],xmm6[4],xmm4[4],xmm6[5],xmm4[5],xmm6[6],xmm4[6],xmm6[7],xmm4[7]
	punpcklbw	%xmm7, %xmm5            # xmm5 = xmm5[0],xmm7[0],xmm5[1],xmm7[1],xmm5[2],xmm7[2],xmm5[3],xmm7[3],xmm5[4],xmm7[4],xmm5[5],xmm7[5],xmm5[6],xmm7[6],xmm5[7],xmm7[7]
	punpcklwd	%xmm6, %xmm5            # xmm5 = xmm5[0],xmm6[0],xmm5[1],xmm6[1],xmm5[2],xmm6[2],xmm5[3],xmm6[3]
	punpckldq	%xmm2, %xmm5            # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1]
	punpcklbw	%xmm8, %xmm9            # xmm9 = xmm9[0],xmm8[0],xmm9[1],xmm8[1],xmm9[2],xmm8[2],xmm9[3],xmm8[3],xmm9[4],xmm8[4],xmm9[5],xmm8[5],xmm9[6],xmm8[6],xmm9[7],xmm8[7]
	punpcklbw	%xmm10, %xmm11          # xmm11 = xmm11[0],xmm10[0],xmm11[1],xmm10[1],xmm11[2],xmm10[2],xmm11[3],xmm10[3],xmm11[4],xmm10[4],xmm11[5],xmm10[5],xmm11[6],xmm10[6],xmm11[7],xmm10[7]
	punpcklwd	%xmm9, %xmm11           # xmm11 = xmm11[0],xmm9[0],xmm11[1],xmm9[1],xmm11[2],xmm9[2],xmm11[3],xmm9[3]
	punpcklbw	%xmm12, %xmm13          # xmm13 = xmm13[0],xmm12[0],xmm13[1],xmm12[1],xmm13[2],xmm12[2],xmm13[3],xmm12[3],xmm13[4],xmm12[4],xmm13[5],xmm12[5],xmm13[6],xmm12[6],xmm13[7],xmm12[7]
	punpcklbw	%xmm14, %xmm15          # xmm15 = xmm15[0],xmm14[0],xmm15[1],xmm14[1],xmm15[2],xmm14[2],xmm15[3],xmm14[3],xmm15[4],xmm14[4],xmm15[5],xmm14[5],xmm15[6],xmm14[6],xmm15[7],xmm14[7]
	punpcklwd	%xmm13, %xmm15          # xmm15 = xmm15[0],xmm13[0],xmm15[1],xmm13[1],xmm15[2],xmm13[2],xmm15[3],xmm13[3]
	punpckldq	%xmm11, %xmm15          # xmm15 = xmm15[0],xmm11[0],xmm15[1],xmm11[1]
	punpcklqdq	%xmm5, %xmm15           # xmm15 = xmm15[0],xmm5[0]
	pxor	224(%rsp), %xmm15
	movdqa	%xmm15, (%rsp)
	movdqu	%xmm15, (%rbx)
	addq	$248, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
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
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$128, %rsp
	.cfi_def_cfa_offset 160
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 48(%rsp)
	movaps	%xmm0, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	leaq	48(%rsp), %rbx
	leaq	32(%rsp), %r14
	leaq	16(%rsp), %r15
	movq	%rsp, %rdi
	leaq	64(%rsp), %rsi
	movl	$.L__const.main.key, %edx
	callq	AES128Encrypt
	leaq	80(%rsp), %rsi
	movl	$.L__const.main.key, %edx
	movq	%r15, %rdi
	callq	AES128Encrypt
	leaq	96(%rsp), %rsi
	movl	$.L__const.main.key, %edx
	movq	%r14, %rdi
	callq	AES128Encrypt
	leaq	112(%rsp), %rsi
	movl	$.L__const.main.key, %edx
	movq	%rbx, %rdi
	callq	AES128Encrypt
	xorl	%eax, %eax
	addq	$128, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
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

	.ident	"clang version 16.0.6 (https://github.com/llvm/llvm-project.git 7cbf1a2591520c2491aa35339f227775f4d3adf6)"
	.section	".note.GNU-stack","",@progbits
