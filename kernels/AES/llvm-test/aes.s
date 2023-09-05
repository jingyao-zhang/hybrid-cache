	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0	sdk_version 13, 3
	.globl	_aes128_ecb_keyexp              ; -- Begin function aes128_ecb_keyexp
	.p2align	2
_aes128_ecb_keyexp:                     ; @aes128_ecb_keyexp
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #224
	.cfi_def_cfa_offset 224
	stp	x29, x30, [sp, #208]            ; 16-byte Folded Spill
	add	x29, sp, #208
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	str	x0, [sp, #16]
	str	x1, [sp, #8]
	mov	x0, #704
	bl	_malloc
	ldr	x8, [sp, #16]
	str	x0, [x8]
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_2
	b	LBB0_1
LBB0_1:
	mov	w0, #111
	bl	_exit
LBB0_2:
	ldr	x1, [sp, #8]
	add	x0, sp, #24
	str	x0, [sp]                        ; 8-byte Folded Spill
	mov	w2, #16
	bl	_br_aes_ct64_keysched
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	ldr	x8, [sp, #16]
	ldr	x0, [x8]
	mov	w2, #10
	bl	_br_aes_ct64_skey_expand
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB0_4
	b	LBB0_3
LBB0_3:
	bl	___stack_chk_fail
LBB0_4:
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	add	sp, sp, #224
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_aes_ct64_keysched
_br_aes_ct64_keysched:                  ; @br_aes_ct64_keysched
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #416
	.cfi_def_cfa_offset 416
	stp	x28, x27, [sp, #384]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #400]            ; 16-byte Folded Spill
	add	x29, sp, #400
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #64]
	str	x1, [sp, #56]
	str	w2, [sp, #52]
	ldr	w8, [sp, #52]
	subs	w8, w8, #16
	lsr	w8, w8, #2
	add	w8, w8, #10
	str	w8, [sp, #24]
	ldr	w8, [sp, #52]
	lsr	w8, w8, #2
	str	w8, [sp, #36]
	ldr	w8, [sp, #24]
	add	w8, w8, #1
	lsl	w8, w8, #2
	str	w8, [sp, #32]
	ldr	w8, [sp, #52]
	lsr	w8, w8, #2
	mov	x1, x8
	ldr	x2, [sp, #56]
	add	x0, sp, #136
	str	x0, [sp, #16]                   ; 8-byte Folded Spill
	bl	_br_range_dec32le
	ldr	x8, [sp, #16]                   ; 8-byte Folded Reload
	ldr	w9, [sp, #52]
	lsr	w9, w9, #2
	subs	w9, w9, #1
	ldr	w8, [x8, w9, uxtw #2]
	str	w8, [sp, #28]
	ldr	w8, [sp, #36]
	str	w8, [sp, #48]
	str	wzr, [sp, #44]
	str	wzr, [sp, #40]
	b	LBB1_1
LBB1_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #48]
	ldr	w9, [sp, #32]
	subs	w8, w8, w9
	cset	w8, hs
	tbnz	w8, #0, LBB1_12
	b	LBB1_2
LBB1_2:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #44]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB1_4
	b	LBB1_3
LBB1_3:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	w9, [sp, #28]
	ldr	w8, [sp, #28]
	lsr	w8, w8, #8
	orr	w8, w8, w9, lsl #24
	str	w8, [sp, #28]
	ldr	w0, [sp, #28]
	bl	_sub_word
	ldr	w8, [sp, #40]
	mov	x9, x8
	adrp	x8, _Rcon@PAGE
	add	x8, x8, _Rcon@PAGEOFF
	ldrb	w8, [x8, x9]
	eor	w8, w0, w8
	str	w8, [sp, #28]
	b	LBB1_8
LBB1_4:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #36]
	subs	w8, w8, #6
	cset	w8, ls
	tbnz	w8, #0, LBB1_7
	b	LBB1_5
LBB1_5:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #44]
	subs	w8, w8, #4
	cset	w8, ne
	tbnz	w8, #0, LBB1_7
	b	LBB1_6
LBB1_6:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	w0, [sp, #28]
	bl	_sub_word
	str	w0, [sp, #28]
	b	LBB1_7
LBB1_7:                                 ;   in Loop: Header=BB1_1 Depth=1
	b	LBB1_8
LBB1_8:                                 ;   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #48]
	ldr	w9, [sp, #36]
	subs	w8, w8, w9
	add	x9, sp, #136
	ldr	w10, [x9, w8, uxtw #2]
	ldr	w8, [sp, #28]
	eor	w8, w8, w10
	str	w8, [sp, #28]
	ldr	w8, [sp, #28]
	ldr	w10, [sp, #48]
                                        ; kill: def $x10 killed $w10
	str	w8, [x9, x10, lsl #2]
	ldr	w8, [sp, #44]
	add	w8, w8, #1
	str	w8, [sp, #44]
	ldr	w9, [sp, #36]
	subs	w8, w8, w9
	cset	w8, ne
	tbnz	w8, #0, LBB1_10
	b	LBB1_9
LBB1_9:                                 ;   in Loop: Header=BB1_1 Depth=1
	str	wzr, [sp, #44]
	ldr	w8, [sp, #40]
	add	w8, w8, #1
	str	w8, [sp, #40]
	b	LBB1_10
LBB1_10:                                ;   in Loop: Header=BB1_1 Depth=1
	b	LBB1_11
LBB1_11:                                ;   in Loop: Header=BB1_1 Depth=1
	ldr	w8, [sp, #48]
	add	w8, w8, #1
	str	w8, [sp, #48]
	b	LBB1_1
LBB1_12:
	str	wzr, [sp, #48]
	str	wzr, [sp, #44]
	b	LBB1_13
LBB1_13:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #48]
	ldr	w9, [sp, #32]
	subs	w8, w8, w9
	cset	w8, hs
	tbnz	w8, #0, LBB1_16
	b	LBB1_14
LBB1_14:                                ;   in Loop: Header=BB1_13 Depth=1
	add	x0, sp, #72
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	add	x1, x0, #32
	ldr	w8, [sp, #48]
	mov	x9, x8
	add	x8, sp, #136
	add	x2, x8, x9, lsl #2
	bl	_br_aes_ct64_interleave_in
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x8, [sp, #72]
	str	x8, [sp, #80]
	ldr	x8, [sp, #72]
	str	x8, [sp, #88]
	ldr	x8, [sp, #72]
	str	x8, [sp, #96]
	ldr	x8, [sp, #104]
	str	x8, [sp, #112]
	ldr	x8, [sp, #104]
	str	x8, [sp, #120]
	ldr	x8, [sp, #104]
	str	x8, [sp, #128]
	bl	_br_aes_ct64_ortho
	ldr	x8, [sp, #72]
	and	x8, x8, #0x1111111111111111
	ldr	x9, [sp, #80]
	and	x9, x9, #0x2222222222222222
	orr	x8, x8, x9
	ldr	x9, [sp, #88]
	and	x9, x9, #0x4444444444444444
	orr	x8, x8, x9
	ldr	x9, [sp, #96]
	and	x9, x9, #0x8888888888888888
	orr	x8, x8, x9
	ldr	x9, [sp, #64]
	ldr	w10, [sp, #44]
	add	w10, w10, #0
	str	x8, [x9, w10, uxtw #3]
	ldr	x8, [sp, #104]
	and	x8, x8, #0x1111111111111111
	ldr	x9, [sp, #112]
	and	x9, x9, #0x2222222222222222
	orr	x8, x8, x9
	ldr	x9, [sp, #120]
	and	x9, x9, #0x4444444444444444
	orr	x8, x8, x9
	ldr	x9, [sp, #128]
	and	x9, x9, #0x8888888888888888
	orr	x8, x8, x9
	ldr	x9, [sp, #64]
	ldr	w10, [sp, #44]
	add	w10, w10, #1
	str	x8, [x9, w10, uxtw #3]
	b	LBB1_15
LBB1_15:                                ;   in Loop: Header=BB1_13 Depth=1
	ldr	w8, [sp, #48]
	add	w8, w8, #4
	str	w8, [sp, #48]
	ldr	w8, [sp, #44]
	add	w8, w8, #2
	str	w8, [sp, #44]
	b	LBB1_13
LBB1_16:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB1_18
	b	LBB1_17
LBB1_17:
	bl	___stack_chk_fail
LBB1_18:
	ldp	x29, x30, [sp, #400]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #384]            ; 16-byte Folded Reload
	add	sp, sp, #416
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_aes_ct64_skey_expand
_br_aes_ct64_skey_expand:               ; @br_aes_ct64_skey_expand
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	str	x0, [sp, #56]
	str	x1, [sp, #48]
	str	w2, [sp, #44]
	ldr	w8, [sp, #44]
	add	w8, w8, #1
	lsl	w8, w8, #1
	str	w8, [sp, #32]
	str	wzr, [sp, #40]
	str	wzr, [sp, #36]
	b	LBB2_1
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #40]
	ldr	w9, [sp, #32]
	subs	w8, w8, w9
	cset	w8, hs
	tbnz	w8, #0, LBB2_4
	b	LBB2_2
LBB2_2:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	x8, [sp, #48]
	ldr	w9, [sp, #40]
                                        ; kill: def $x9 killed $w9
	ldr	x8, [x8, x9, lsl #3]
	str	x8, [sp]
	str	x8, [sp, #8]
	str	x8, [sp, #16]
	str	x8, [sp, #24]
	ldr	x8, [sp, #24]
	and	x8, x8, #0x1111111111111111
	str	x8, [sp, #24]
	ldr	x8, [sp, #16]
	and	x8, x8, #0x2222222222222222
	str	x8, [sp, #16]
	ldr	x8, [sp, #8]
	and	x8, x8, #0x4444444444444444
	str	x8, [sp, #8]
	ldr	x8, [sp]
	and	x8, x8, #0x8888888888888888
	str	x8, [sp]
	ldr	x8, [sp, #16]
	lsr	x8, x8, #1
	str	x8, [sp, #16]
	ldr	x8, [sp, #8]
	lsr	x8, x8, #2
	str	x8, [sp, #8]
	ldr	x8, [sp]
	lsr	x8, x8, #3
	str	x8, [sp]
	ldr	x8, [sp, #24]
	lsl	x8, x8, #4
	ldr	x9, [sp, #24]
	subs	x8, x8, x9
	ldr	x9, [sp, #56]
	ldr	w10, [sp, #36]
	add	w10, w10, #0
	str	x8, [x9, w10, uxtw #3]
	ldr	x8, [sp, #16]
	lsl	x8, x8, #4
	ldr	x9, [sp, #16]
	subs	x8, x8, x9
	ldr	x9, [sp, #56]
	ldr	w10, [sp, #36]
	add	w10, w10, #1
	str	x8, [x9, w10, uxtw #3]
	ldr	x8, [sp, #8]
	lsl	x8, x8, #4
	ldr	x9, [sp, #8]
	subs	x8, x8, x9
	ldr	x9, [sp, #56]
	ldr	w10, [sp, #36]
	add	w10, w10, #2
	str	x8, [x9, w10, uxtw #3]
	ldr	x8, [sp]
	lsl	x8, x8, #4
	ldr	x9, [sp]
	subs	x8, x8, x9
	ldr	x9, [sp, #56]
	ldr	w10, [sp, #36]
	add	w10, w10, #3
	str	x8, [x9, w10, uxtw #3]
	b	LBB2_3
LBB2_3:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #40]
	add	w8, w8, #1
	str	w8, [sp, #40]
	ldr	w8, [sp, #36]
	add	w8, w8, #4
	str	w8, [sp, #36]
	b	LBB2_1
LBB2_4:
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes128_ctr_keyexp              ; -- Begin function aes128_ctr_keyexp
	.p2align	2
_aes128_ctr_keyexp:                     ; @aes128_ctr_keyexp
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x0, [sp, #8]
	ldr	x1, [sp]
	bl	_aes128_ecb_keyexp
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes192_ecb_keyexp              ; -- Begin function aes192_ecb_keyexp
	.p2align	2
_aes192_ecb_keyexp:                     ; @aes192_ecb_keyexp
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #272
	.cfi_def_cfa_offset 272
	stp	x28, x27, [sp, #240]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #256]            ; 16-byte Folded Spill
	add	x29, sp, #256
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #16]
	str	x1, [sp, #8]
	mov	x0, #832
	bl	_malloc
	ldr	x8, [sp, #16]
	str	x0, [x8]
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB4_2
	b	LBB4_1
LBB4_1:
	mov	w0, #111
	bl	_exit
LBB4_2:
	ldr	x1, [sp, #8]
	add	x0, sp, #24
	str	x0, [sp]                        ; 8-byte Folded Spill
	mov	w2, #24
	bl	_br_aes_ct64_keysched
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	ldr	x8, [sp, #16]
	ldr	x0, [x8]
	mov	w2, #12
	bl	_br_aes_ct64_skey_expand
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB4_4
	b	LBB4_3
LBB4_3:
	bl	___stack_chk_fail
LBB4_4:
	ldp	x29, x30, [sp, #256]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #240]            ; 16-byte Folded Reload
	add	sp, sp, #272
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes192_ctr_keyexp              ; -- Begin function aes192_ctr_keyexp
	.p2align	2
_aes192_ctr_keyexp:                     ; @aes192_ctr_keyexp
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x0, [sp, #8]
	ldr	x1, [sp]
	bl	_aes192_ecb_keyexp
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes256_ecb_keyexp              ; -- Begin function aes256_ecb_keyexp
	.p2align	2
_aes256_ecb_keyexp:                     ; @aes256_ecb_keyexp
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #304
	.cfi_def_cfa_offset 304
	stp	x28, x27, [sp, #272]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #288]            ; 16-byte Folded Spill
	add	x29, sp, #288
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #16]
	str	x1, [sp, #8]
	mov	x0, #960
	bl	_malloc
	ldr	x8, [sp, #16]
	str	x0, [x8]
	ldr	x8, [sp, #16]
	ldr	x8, [x8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB6_2
	b	LBB6_1
LBB6_1:
	mov	w0, #111
	bl	_exit
LBB6_2:
	ldr	x1, [sp, #8]
	add	x0, sp, #24
	str	x0, [sp]                        ; 8-byte Folded Spill
	mov	w2, #32
	bl	_br_aes_ct64_keysched
	ldr	x1, [sp]                        ; 8-byte Folded Reload
	ldr	x8, [sp, #16]
	ldr	x0, [x8]
	mov	w2, #14
	bl	_br_aes_ct64_skey_expand
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB6_4
	b	LBB6_3
LBB6_3:
	bl	___stack_chk_fail
LBB6_4:
	ldp	x29, x30, [sp, #288]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #272]            ; 16-byte Folded Reload
	add	sp, sp, #304
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes256_ctr_keyexp              ; -- Begin function aes256_ctr_keyexp
	.p2align	2
_aes256_ctr_keyexp:                     ; @aes256_ctr_keyexp
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x0, [sp, #8]
	ldr	x1, [sp]
	bl	_aes256_ecb_keyexp
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes128_ecb                     ; -- Begin function aes128_ecb
	.p2align	2
_aes128_ecb:                            ; @aes128_ecb
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	x8, [sp]
	ldr	x3, [x8]
	mov	w4, #10
	bl	_aes_ecb
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function aes_ecb
_aes_ecb:                               ; @aes_ecb
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #224
	.cfi_def_cfa_offset 224
	stp	x29, x30, [sp, #208]            ; 16-byte Folded Spill
	add	x29, sp, #208
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	str	x0, [sp, #64]
	str	x1, [sp, #56]
	str	x2, [sp, #48]
	str	x3, [sp, #40]
	str	w4, [sp, #36]
	b	LBB9_1
LBB9_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #48]
	subs	x8, x8, #4
	cset	w8, lo
	tbnz	w8, #0, LBB9_3
	b	LBB9_2
LBB9_2:                                 ;   in Loop: Header=BB9_1 Depth=1
	ldr	x2, [sp, #56]
	sub	x0, x29, #72
	str	x0, [sp, #24]                   ; 8-byte Folded Spill
	mov	x1, #16
	bl	_br_range_dec32le
	ldr	x1, [sp, #24]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #64]
	ldr	x2, [sp, #40]
	ldr	w3, [sp, #36]
	bl	_aes_ecb4x
	ldr	x8, [sp, #48]
	subs	x8, x8, #4
	str	x8, [sp, #48]
	ldr	x8, [sp, #56]
	add	x8, x8, #64
	str	x8, [sp, #56]
	ldr	x8, [sp, #64]
	add	x8, x8, #64
	str	x8, [sp, #64]
	b	LBB9_1
LBB9_3:
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB9_5
	b	LBB9_4
LBB9_4:
	ldr	x8, [sp, #48]
	lsl	x1, x8, #2
	ldr	x2, [sp, #56]
	sub	x0, x29, #72
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	bl	_br_range_dec32le
	ldr	x1, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x2, [sp, #40]
	ldr	w3, [sp, #36]
	add	x0, sp, #72
	str	x0, [sp, #16]                   ; 8-byte Folded Spill
	bl	_aes_ecb4x
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #64]
	ldr	x8, [sp, #48]
	lsl	x2, x8, #4
	mov	x3, #-1
	bl	___memcpy_chk
	b	LBB9_5
LBB9_5:
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB9_7
	b	LBB9_6
LBB9_6:
	bl	___stack_chk_fail
LBB9_7:
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	add	sp, sp, #224
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes128_ctr                     ; -- Begin function aes128_ctr
	.p2align	2
_aes128_ctr:                            ; @aes128_ctr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	x8, [sp]
	ldr	x3, [x8]
	mov	w4, #10
	bl	_aes_ctr
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function aes_ctr
_aes_ctr:                               ; @aes_ctr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #224
	.cfi_def_cfa_offset 224
	stp	x29, x30, [sp, #208]            ; 16-byte Folded Spill
	add	x29, sp, #208
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sub	x8, x29, #72
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	str	x0, [sp, #64]
	str	x1, [sp, #56]
	str	x2, [sp, #48]
	str	x3, [sp, #40]
	str	w4, [sp, #36]
	str	wzr, [sp, #20]
	ldr	x2, [sp, #48]
	sub	x0, x29, #72
	mov	x1, #3
	bl	_br_range_dec32le
	ldr	x9, [sp, #8]                    ; 8-byte Folded Reload
	ldur	x8, [x29, #-72]
	str	x8, [x9, #16]
	ldur	w8, [x29, #-64]
	stur	w8, [x29, #-48]
	ldur	x8, [x29, #-72]
	str	x8, [x9, #32]
	ldur	w8, [x29, #-64]
	stur	w8, [x29, #-32]
	ldur	x8, [x29, #-72]
	str	x8, [x9, #48]
	ldur	w8, [x29, #-64]
	stur	w8, [x29, #-16]
	ldr	w0, [sp, #20]
	bl	_br_swap32
	stur	w0, [x29, #-60]
	ldr	w8, [sp, #20]
	add	w0, w8, #1
	bl	_br_swap32
	stur	w0, [x29, #-44]
	ldr	w8, [sp, #20]
	add	w0, w8, #2
	bl	_br_swap32
	stur	w0, [x29, #-28]
	ldr	w8, [sp, #20]
	add	w0, w8, #3
	bl	_br_swap32
	stur	w0, [x29, #-12]
	b	LBB11_1
LBB11_1:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #56]
	subs	x8, x8, #64
	cset	w8, ls
	tbnz	w8, #0, LBB11_3
	b	LBB11_2
LBB11_2:                                ;   in Loop: Header=BB11_1 Depth=1
	ldr	x0, [sp, #64]
	ldr	x2, [sp, #40]
	ldr	w3, [sp, #36]
	sub	x1, x29, #72
	bl	_aes_ctr4x
	ldr	x8, [sp, #64]
	add	x8, x8, #64
	str	x8, [sp, #64]
	ldr	x8, [sp, #56]
	subs	x8, x8, #64
	str	x8, [sp, #56]
	b	LBB11_1
LBB11_3:
	ldr	x8, [sp, #56]
	subs	x8, x8, #0
	cset	w8, ls
	tbnz	w8, #0, LBB11_9
	b	LBB11_4
LBB11_4:
	ldr	x2, [sp, #40]
	ldr	w3, [sp, #36]
	add	x0, sp, #72
	sub	x1, x29, #72
	bl	_aes_ctr4x
	str	xzr, [sp, #24]
	b	LBB11_5
LBB11_5:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #56]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB11_8
	b	LBB11_6
LBB11_6:                                ;   in Loop: Header=BB11_5 Depth=1
	ldr	x9, [sp, #24]
	add	x8, sp, #72
	add	x8, x8, x9
	ldrb	w8, [x8]
	ldr	x9, [sp, #64]
	ldr	x10, [sp, #24]
	add	x9, x9, x10
	strb	w8, [x9]
	b	LBB11_7
LBB11_7:                                ;   in Loop: Header=BB11_5 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB11_5
LBB11_8:
	b	LBB11_9
LBB11_9:
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB11_11
	b	LBB11_10
LBB11_10:
	bl	___stack_chk_fail
LBB11_11:
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	add	sp, sp, #224
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes192_ecb                     ; -- Begin function aes192_ecb
	.p2align	2
_aes192_ecb:                            ; @aes192_ecb
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	x8, [sp]
	ldr	x3, [x8]
	mov	w4, #12
	bl	_aes_ecb
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes192_ctr                     ; -- Begin function aes192_ctr
	.p2align	2
_aes192_ctr:                            ; @aes192_ctr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	x8, [sp]
	ldr	x3, [x8]
	mov	w4, #12
	bl	_aes_ctr
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes256_ecb                     ; -- Begin function aes256_ecb
	.p2align	2
_aes256_ecb:                            ; @aes256_ecb
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	x8, [sp]
	ldr	x3, [x8]
	mov	w4, #14
	bl	_aes_ecb
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes256_ctr                     ; -- Begin function aes256_ctr
	.p2align	2
_aes256_ctr:                            ; @aes256_ctr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	x8, [sp]
	ldr	x3, [x8]
	mov	w4, #14
	bl	_aes_ctr
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes128_ctx_release             ; -- Begin function aes128_ctx_release
	.p2align	2
_aes128_ctx_release:                    ; @aes128_ctx_release
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	x0, [x8]
	bl	_free
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes192_ctx_release             ; -- Begin function aes192_ctx_release
	.p2align	2
_aes192_ctx_release:                    ; @aes192_ctx_release
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	x0, [x8]
	bl	_free
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_aes256_ctx_release             ; -- Begin function aes256_ctx_release
	.p2align	2
_aes256_ctx_release:                    ; @aes256_ctx_release
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	x0, [x8]
	bl	_free
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_range_dec32le
_br_range_dec32le:                      ; @br_range_dec32le
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	b	LBB19_1
LBB19_1:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #16]
	subs	x9, x8, #1
	str	x9, [sp, #16]
	subs	x8, x8, #0
	cset	w8, ls
	tbnz	w8, #0, LBB19_3
	b	LBB19_2
LBB19_2:                                ;   in Loop: Header=BB19_1 Depth=1
	ldr	x0, [sp, #8]
	bl	_br_dec32le
	ldur	x8, [x29, #-8]
	add	x9, x8, #4
	stur	x9, [x29, #-8]
	str	w0, [x8]
	ldr	x8, [sp, #8]
	add	x8, x8, #4
	str	x8, [sp, #8]
	b	LBB19_1
LBB19_3:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function sub_word
_sub_word:                              ; @sub_word
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	str	w0, [sp, #20]
	add	x0, sp, #24
	str	x0, [sp]                        ; 8-byte Folded Spill
	mov	w1, #0
	mov	x2, #64
	bl	_memset
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	ldr	w8, [sp, #20]
                                        ; kill: def $x8 killed $w8
	str	x8, [sp, #24]
	bl	_br_aes_ct64_ortho
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	_br_aes_ct64_bitslice_Sbox
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	_br_aes_ct64_ortho
	ldr	x8, [sp, #24]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB20_2
	b	LBB20_1
LBB20_1:
	bl	___stack_chk_fail
LBB20_2:
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	mov	x0, x8
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_aes_ct64_interleave_in
_br_aes_ct64_interleave_in:             ; @br_aes_ct64_interleave_in
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	ldur	x8, [x29, #-24]
	ldr	w8, [x8]
                                        ; kill: def $x8 killed $w8
	stur	x8, [x29, #-32]
	ldur	x8, [x29, #-24]
	ldr	w8, [x8, #4]
                                        ; kill: def $x8 killed $w8
	str	x8, [sp, #40]
	ldur	x8, [x29, #-24]
	ldr	w8, [x8, #8]
                                        ; kill: def $x8 killed $w8
	str	x8, [sp, #32]
	ldur	x8, [x29, #-24]
	ldr	w8, [x8, #12]
                                        ; kill: def $x8 killed $w8
	str	x8, [sp, #24]
	ldur	x9, [x29, #-32]
	ldur	x8, [x29, #-32]
	orr	x8, x8, x9, lsl #16
	stur	x8, [x29, #-32]
	ldr	x9, [sp, #40]
	ldr	x8, [sp, #40]
	orr	x8, x8, x9, lsl #16
	str	x8, [sp, #40]
	ldr	x9, [sp, #32]
	ldr	x8, [sp, #32]
	orr	x8, x8, x9, lsl #16
	str	x8, [sp, #32]
	ldr	x9, [sp, #24]
	ldr	x8, [sp, #24]
	orr	x8, x8, x9, lsl #16
	str	x8, [sp, #24]
	mov	w0, #4
	str	w0, [sp, #12]                   ; 4-byte Folded Spill
	mov	w1, #16
	bl	_LeftShift_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	ldur	x8, [x29, #-32]
	and	x8, x8, #0xffff0000ffff
	stur	x8, [x29, #-32]
	ldr	x8, [sp, #40]
	and	x8, x8, #0xffff0000ffff
	str	x8, [sp, #40]
	ldr	x8, [sp, #32]
	and	x8, x8, #0xffff0000ffff
	str	x8, [sp, #32]
	ldr	x8, [sp, #24]
	and	x8, x8, #0xffff0000ffff
	str	x8, [sp, #24]
	bl	_AndCC_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	ldur	x9, [x29, #-32]
	ldur	x8, [x29, #-32]
	orr	x8, x8, x9, lsl #8
	stur	x8, [x29, #-32]
	ldr	x9, [sp, #40]
	ldr	x8, [sp, #40]
	orr	x8, x8, x9, lsl #8
	str	x8, [sp, #40]
	ldr	x9, [sp, #32]
	ldr	x8, [sp, #32]
	orr	x8, x8, x9, lsl #8
	str	x8, [sp, #32]
	ldr	x9, [sp, #24]
	ldr	x8, [sp, #24]
	orr	x8, x8, x9, lsl #8
	str	x8, [sp, #24]
	mov	w1, #8
	str	w1, [sp, #16]                   ; 4-byte Folded Spill
	bl	_LeftShift_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	ldur	x8, [x29, #-32]
	and	x8, x8, #0xff00ff00ff00ff
	stur	x8, [x29, #-32]
	ldr	x8, [sp, #40]
	and	x8, x8, #0xff00ff00ff00ff
	str	x8, [sp, #40]
	ldr	x8, [sp, #32]
	and	x8, x8, #0xff00ff00ff00ff
	str	x8, [sp, #32]
	ldr	x8, [sp, #24]
	and	x8, x8, #0xff00ff00ff00ff
	str	x8, [sp, #24]
	bl	_AndCC_counter
	ldr	w1, [sp, #16]                   ; 4-byte Folded Reload
	ldur	x8, [x29, #-32]
	ldr	x9, [sp, #32]
	orr	x8, x8, x9, lsl #8
	ldur	x9, [x29, #-8]
	str	x8, [x9]
	ldr	x8, [sp, #40]
	ldr	x9, [sp, #24]
	orr	x8, x8, x9, lsl #8
	ldur	x9, [x29, #-16]
	str	x8, [x9]
	mov	w0, #2
	str	w0, [sp, #20]                   ; 4-byte Folded Spill
	bl	_LeftShift_counter
	ldr	w0, [sp, #20]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_aes_ct64_ortho
_br_aes_ct64_ortho:                     ; @br_aes_ct64_ortho
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #240
	.cfi_def_cfa_offset 240
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	b	LBB22_1
LBB22_1:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	stur	x8, [x29, #-16]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #8]
	stur	x8, [x29, #-24]
	ldur	x8, [x29, #-16]
	and	x8, x8, #0x5555555555555555
	ldur	x9, [x29, #-24]
	and	x9, x9, #0x5555555555555555
	orr	x8, x8, x9, lsl #1
	ldur	x9, [x29, #-8]
	str	x8, [x9]
	ldur	x8, [x29, #-16]
	and	x9, x8, #0xaaaaaaaaaaaaaaaa
	ldur	x8, [x29, #-24]
	and	x8, x8, #0xaaaaaaaaaaaaaaaa
	orr	x8, x8, x9, lsr #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #8]
	b	LBB22_2
LBB22_2:
	b	LBB22_3
LBB22_3:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #16]
	stur	x8, [x29, #-32]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #24]
	stur	x8, [x29, #-40]
	ldur	x8, [x29, #-32]
	and	x8, x8, #0x5555555555555555
	ldur	x9, [x29, #-40]
	and	x9, x9, #0x5555555555555555
	orr	x8, x8, x9, lsl #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #16]
	ldur	x8, [x29, #-32]
	and	x9, x8, #0xaaaaaaaaaaaaaaaa
	ldur	x8, [x29, #-40]
	and	x8, x8, #0xaaaaaaaaaaaaaaaa
	orr	x8, x8, x9, lsr #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #24]
	b	LBB22_4
LBB22_4:
	b	LBB22_5
LBB22_5:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #32]
	stur	x8, [x29, #-48]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #40]
	stur	x8, [x29, #-56]
	ldur	x8, [x29, #-48]
	and	x8, x8, #0x5555555555555555
	ldur	x9, [x29, #-56]
	and	x9, x9, #0x5555555555555555
	orr	x8, x8, x9, lsl #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #32]
	ldur	x8, [x29, #-48]
	and	x9, x8, #0xaaaaaaaaaaaaaaaa
	ldur	x8, [x29, #-56]
	and	x8, x8, #0xaaaaaaaaaaaaaaaa
	orr	x8, x8, x9, lsr #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #40]
	b	LBB22_6
LBB22_6:
	b	LBB22_7
LBB22_7:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #48]
	stur	x8, [x29, #-64]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #56]
	stur	x8, [x29, #-72]
	ldur	x8, [x29, #-64]
	and	x8, x8, #0x5555555555555555
	ldur	x9, [x29, #-72]
	and	x9, x9, #0x5555555555555555
	orr	x8, x8, x9, lsl #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #48]
	ldur	x8, [x29, #-64]
	and	x9, x8, #0xaaaaaaaaaaaaaaaa
	ldur	x8, [x29, #-72]
	and	x8, x8, #0xaaaaaaaaaaaaaaaa
	orr	x8, x8, x9, lsr #1
	ldur	x9, [x29, #-8]
	str	x8, [x9, #56]
	b	LBB22_8
LBB22_8:
	mov	w0, #16
	bl	_AndCC_counter
	mov	w0, #4
	str	w0, [sp, #16]                   ; 4-byte Folded Spill
	mov	w1, #1
	str	w1, [sp, #20]                   ; 4-byte Folded Spill
	bl	_LeftShift_counter
	mov	w0, #8
	bl	_OrCC_counter
	ldr	w0, [sp, #16]                   ; 4-byte Folded Reload
	ldr	w1, [sp, #20]                   ; 4-byte Folded Reload
	bl	_RightShift_counter
	b	LBB22_9
LBB22_9:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	stur	x8, [x29, #-80]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #16]
	stur	x8, [x29, #-88]
	ldur	x8, [x29, #-80]
	and	x8, x8, #0x3333333333333333
	ldur	x9, [x29, #-88]
	and	x9, x9, #0x3333333333333333
	orr	x8, x8, x9, lsl #2
	ldur	x9, [x29, #-8]
	str	x8, [x9]
	ldur	x8, [x29, #-80]
	and	x9, x8, #0xcccccccccccccccc
	ldur	x8, [x29, #-88]
	and	x8, x8, #0xcccccccccccccccc
	orr	x8, x8, x9, lsr #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #16]
	b	LBB22_10
LBB22_10:
	b	LBB22_11
LBB22_11:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #8]
	stur	x8, [x29, #-96]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #24]
	stur	x8, [x29, #-104]
	ldur	x8, [x29, #-96]
	and	x8, x8, #0x3333333333333333
	ldur	x9, [x29, #-104]
	and	x9, x9, #0x3333333333333333
	orr	x8, x8, x9, lsl #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #8]
	ldur	x8, [x29, #-96]
	and	x9, x8, #0xcccccccccccccccc
	ldur	x8, [x29, #-104]
	and	x8, x8, #0xcccccccccccccccc
	orr	x8, x8, x9, lsr #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #24]
	b	LBB22_12
LBB22_12:
	b	LBB22_13
LBB22_13:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #32]
	str	x8, [sp, #112]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #48]
	str	x8, [sp, #104]
	ldr	x8, [sp, #112]
	and	x8, x8, #0x3333333333333333
	ldr	x9, [sp, #104]
	and	x9, x9, #0x3333333333333333
	orr	x8, x8, x9, lsl #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #32]
	ldr	x8, [sp, #112]
	and	x9, x8, #0xcccccccccccccccc
	ldr	x8, [sp, #104]
	and	x8, x8, #0xcccccccccccccccc
	orr	x8, x8, x9, lsr #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #48]
	b	LBB22_14
LBB22_14:
	b	LBB22_15
LBB22_15:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #40]
	str	x8, [sp, #96]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #56]
	str	x8, [sp, #88]
	ldr	x8, [sp, #96]
	and	x8, x8, #0x3333333333333333
	ldr	x9, [sp, #88]
	and	x9, x9, #0x3333333333333333
	orr	x8, x8, x9, lsl #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #40]
	ldr	x8, [sp, #96]
	and	x9, x8, #0xcccccccccccccccc
	ldr	x8, [sp, #88]
	and	x8, x8, #0xcccccccccccccccc
	orr	x8, x8, x9, lsr #2
	ldur	x9, [x29, #-8]
	str	x8, [x9, #56]
	b	LBB22_16
LBB22_16:
	mov	w0, #16
	bl	_AndCC_counter
	mov	w0, #4
	str	w0, [sp, #8]                    ; 4-byte Folded Spill
	mov	w1, #2
	str	w1, [sp, #12]                   ; 4-byte Folded Spill
	bl	_LeftShift_counter
	mov	w0, #8
	bl	_OrCC_counter
	ldr	w0, [sp, #8]                    ; 4-byte Folded Reload
	ldr	w1, [sp, #12]                   ; 4-byte Folded Reload
	bl	_RightShift_counter
	b	LBB22_17
LBB22_17:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	str	x8, [sp, #80]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #32]
	str	x8, [sp, #72]
	ldr	x8, [sp, #80]
	and	x8, x8, #0xf0f0f0f0f0f0f0f
	ldr	x9, [sp, #72]
	and	x9, x9, #0xf0f0f0f0f0f0f0f
	orr	x8, x8, x9, lsl #4
	ldur	x9, [x29, #-8]
	str	x8, [x9]
	ldr	x8, [sp, #80]
	and	x9, x8, #0xf0f0f0f0f0f0f0f0
	ldr	x8, [sp, #72]
	and	x8, x8, #0xf0f0f0f0f0f0f0f0
	orr	x8, x8, x9, lsr #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #32]
	b	LBB22_18
LBB22_18:
	b	LBB22_19
LBB22_19:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #8]
	str	x8, [sp, #64]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #40]
	str	x8, [sp, #56]
	ldr	x8, [sp, #64]
	and	x8, x8, #0xf0f0f0f0f0f0f0f
	ldr	x9, [sp, #56]
	and	x9, x9, #0xf0f0f0f0f0f0f0f
	orr	x8, x8, x9, lsl #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #8]
	ldr	x8, [sp, #64]
	and	x9, x8, #0xf0f0f0f0f0f0f0f0
	ldr	x8, [sp, #56]
	and	x8, x8, #0xf0f0f0f0f0f0f0f0
	orr	x8, x8, x9, lsr #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #40]
	b	LBB22_20
LBB22_20:
	b	LBB22_21
LBB22_21:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #16]
	str	x8, [sp, #48]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #48]
	str	x8, [sp, #40]
	ldr	x8, [sp, #48]
	and	x8, x8, #0xf0f0f0f0f0f0f0f
	ldr	x9, [sp, #40]
	and	x9, x9, #0xf0f0f0f0f0f0f0f
	orr	x8, x8, x9, lsl #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #16]
	ldr	x8, [sp, #48]
	and	x9, x8, #0xf0f0f0f0f0f0f0f0
	ldr	x8, [sp, #40]
	and	x8, x8, #0xf0f0f0f0f0f0f0f0
	orr	x8, x8, x9, lsr #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #48]
	b	LBB22_22
LBB22_22:
	b	LBB22_23
LBB22_23:
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #24]
	str	x8, [sp, #32]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #56]
	str	x8, [sp, #24]
	ldr	x8, [sp, #32]
	and	x8, x8, #0xf0f0f0f0f0f0f0f
	ldr	x9, [sp, #24]
	and	x9, x9, #0xf0f0f0f0f0f0f0f
	orr	x8, x8, x9, lsl #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #24]
	ldr	x8, [sp, #32]
	and	x9, x8, #0xf0f0f0f0f0f0f0f0
	ldr	x8, [sp, #24]
	and	x8, x8, #0xf0f0f0f0f0f0f0f0
	orr	x8, x8, x9, lsr #4
	ldur	x9, [x29, #-8]
	str	x8, [x9, #56]
	b	LBB22_24
LBB22_24:
	mov	w0, #16
	bl	_AndCC_counter
	mov	w1, #4
	str	w1, [sp, #4]                    ; 4-byte Folded Spill
	mov	x0, x1
	bl	_LeftShift_counter
	mov	w0, #8
	bl	_OrCC_counter
	ldr	w1, [sp, #4]                    ; 4-byte Folded Reload
	mov	x0, x1
	bl	_RightShift_counter
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	add	sp, sp, #240
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_dec32le
_br_dec32le:                            ; @br_dec32le
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	ldrb	w8, [x8]
	ldr	x9, [sp, #8]
	ldrb	w9, [x9, #1]
	orr	w8, w8, w9, lsl #8
	ldr	x9, [sp, #8]
	ldrb	w9, [x9, #2]
	orr	w8, w8, w9, lsl #16
	ldr	x9, [sp, #8]
	ldrb	w9, [x9, #3]
	orr	w0, w8, w9, lsl #24
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_aes_ct64_bitslice_Sbox
_br_aes_ct64_bitslice_Sbox:             ; @br_aes_ct64_bitslice_Sbox
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	sub	sp, sp, #1008
	stur	x0, [x29, #-24]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #56]
	stur	x8, [x29, #-32]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #48]
	stur	x8, [x29, #-40]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #40]
	stur	x8, [x29, #-48]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #32]
	stur	x8, [x29, #-56]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #24]
	stur	x8, [x29, #-64]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #16]
	stur	x8, [x29, #-72]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8, #8]
	stur	x8, [x29, #-80]
	ldur	x8, [x29, #-24]
	ldr	x8, [x8]
	stur	x8, [x29, #-88]
	ldur	x8, [x29, #-56]
	ldur	x9, [x29, #-72]
	eor	x8, x8, x9
	stur	x8, [x29, #-200]
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-80]
	eor	x8, x8, x9
	stur	x8, [x29, #-192]
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-56]
	eor	x8, x8, x9
	stur	x8, [x29, #-160]
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-72]
	eor	x8, x8, x9
	stur	x8, [x29, #-152]
	ldur	x8, [x29, #-40]
	ldur	x9, [x29, #-48]
	eor	x8, x8, x9
	str	x8, [sp, #616]
	ldr	x8, [sp, #616]
	ldur	x9, [x29, #-88]
	eor	x8, x8, x9
	stur	x8, [x29, #-96]
	ldur	x8, [x29, #-96]
	ldur	x9, [x29, #-56]
	eor	x8, x8, x9
	stur	x8, [x29, #-120]
	ldur	x8, [x29, #-192]
	ldur	x9, [x29, #-200]
	eor	x8, x8, x9
	stur	x8, [x29, #-184]
	ldur	x8, [x29, #-96]
	ldur	x9, [x29, #-32]
	eor	x8, x8, x9
	stur	x8, [x29, #-104]
	ldur	x8, [x29, #-96]
	ldur	x9, [x29, #-80]
	eor	x8, x8, x9
	stur	x8, [x29, #-128]
	ldur	x8, [x29, #-128]
	ldur	x9, [x29, #-152]
	eor	x8, x8, x9
	stur	x8, [x29, #-112]
	ldur	x8, [x29, #-64]
	ldur	x9, [x29, #-184]
	eor	x8, x8, x9
	str	x8, [sp, #608]
	ldr	x8, [sp, #608]
	ldur	x9, [x29, #-72]
	eor	x8, x8, x9
	stur	x8, [x29, #-208]
	ldr	x8, [sp, #608]
	ldur	x9, [x29, #-40]
	eor	x8, x8, x9
	stur	x8, [x29, #-248]
	ldur	x8, [x29, #-208]
	ldur	x9, [x29, #-88]
	eor	x8, x8, x9
	stur	x8, [x29, #-136]
	ldur	x8, [x29, #-208]
	ldr	x9, [sp, #616]
	eor	x8, x8, x9
	stur	x8, [x29, #-168]
	ldur	x8, [x29, #-248]
	ldur	x9, [x29, #-160]
	eor	x8, x8, x9
	stur	x8, [x29, #-176]
	ldur	x8, [x29, #-88]
	ldur	x9, [x29, #-176]
	eor	x8, x8, x9
	stur	x8, [x29, #-144]
	ldur	x8, [x29, #-168]
	ldur	x9, [x29, #-176]
	eor	x8, x8, x9
	stur	x8, [x29, #-224]
	ldur	x8, [x29, #-168]
	ldur	x9, [x29, #-152]
	eor	x8, x8, x9
	stur	x8, [x29, #-240]
	ldr	x8, [sp, #616]
	ldur	x9, [x29, #-176]
	eor	x8, x8, x9
	stur	x8, [x29, #-216]
	ldur	x8, [x29, #-192]
	ldur	x9, [x29, #-216]
	eor	x8, x8, x9
	stur	x8, [x29, #-256]
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-216]
	eor	x8, x8, x9
	stur	x8, [x29, #-232]
	mov	w0, #23
	bl	_XorCC_counter
	ldur	x8, [x29, #-184]
	ldur	x9, [x29, #-208]
	and	x8, x8, x9
	str	x8, [sp, #600]
	ldur	x8, [x29, #-112]
	ldur	x9, [x29, #-136]
	and	x8, x8, x9
	str	x8, [sp, #592]
	ldr	x8, [sp, #592]
	ldr	x9, [sp, #600]
	eor	x8, x8, x9
	str	x8, [sp, #584]
	ldur	x8, [x29, #-120]
	ldur	x9, [x29, #-88]
	and	x8, x8, x9
	str	x8, [sp, #576]
	ldr	x8, [sp, #576]
	ldr	x9, [sp, #600]
	eor	x8, x8, x9
	str	x8, [sp, #568]
	ldur	x8, [x29, #-192]
	ldur	x9, [x29, #-216]
	and	x8, x8, x9
	str	x8, [sp, #560]
	ldur	x8, [x29, #-128]
	ldur	x9, [x29, #-96]
	and	x8, x8, x9
	str	x8, [sp, #552]
	ldr	x8, [sp, #552]
	ldr	x9, [sp, #560]
	eor	x8, x8, x9
	str	x8, [sp, #544]
	ldur	x8, [x29, #-104]
	ldur	x9, [x29, #-144]
	and	x8, x8, x9
	str	x8, [sp, #536]
	ldr	x8, [sp, #536]
	ldr	x9, [sp, #560]
	eor	x8, x8, x9
	str	x8, [sp, #528]
	ldur	x8, [x29, #-160]
	ldur	x9, [x29, #-176]
	and	x8, x8, x9
	str	x8, [sp, #520]
	ldur	x8, [x29, #-200]
	ldur	x9, [x29, #-224]
	and	x8, x8, x9
	str	x8, [sp, #512]
	ldr	x8, [sp, #512]
	ldr	x9, [sp, #520]
	eor	x8, x8, x9
	str	x8, [sp, #504]
	ldur	x8, [x29, #-152]
	ldur	x9, [x29, #-168]
	and	x8, x8, x9
	str	x8, [sp, #496]
	ldr	x8, [sp, #496]
	ldr	x9, [sp, #520]
	eor	x8, x8, x9
	str	x8, [sp, #488]
	ldr	x8, [sp, #584]
	ldr	x9, [sp, #504]
	eor	x8, x8, x9
	str	x8, [sp, #480]
	ldr	x8, [sp, #568]
	ldr	x9, [sp, #488]
	eor	x8, x8, x9
	str	x8, [sp, #472]
	ldr	x8, [sp, #544]
	ldr	x9, [sp, #504]
	eor	x8, x8, x9
	str	x8, [sp, #464]
	ldr	x8, [sp, #528]
	ldr	x9, [sp, #488]
	eor	x8, x8, x9
	str	x8, [sp, #456]
	ldr	x8, [sp, #480]
	ldur	x9, [x29, #-248]
	eor	x8, x8, x9
	str	x8, [sp, #448]
	ldr	x8, [sp, #472]
	ldur	x9, [x29, #-240]
	eor	x8, x8, x9
	str	x8, [sp, #440]
	ldr	x8, [sp, #464]
	ldur	x9, [x29, #-256]
	eor	x8, x8, x9
	str	x8, [sp, #432]
	ldr	x8, [sp, #456]
	ldur	x9, [x29, #-232]
	eor	x8, x8, x9
	str	x8, [sp, #424]
	mov	w0, #14
	bl	_AndCC_counter
	mov	w0, #9
	bl	_XorCC_counter
	ldr	x8, [sp, #448]
	ldr	x9, [sp, #440]
	eor	x8, x8, x9
	str	x8, [sp, #416]
	ldr	x8, [sp, #448]
	ldr	x9, [sp, #432]
	and	x8, x8, x9
	str	x8, [sp, #408]
	ldr	x8, [sp, #424]
	ldr	x9, [sp, #408]
	eor	x8, x8, x9
	str	x8, [sp, #400]
	ldr	x8, [sp, #416]
	ldr	x9, [sp, #400]
	and	x8, x8, x9
	str	x8, [sp, #392]
	ldr	x8, [sp, #392]
	ldr	x9, [sp, #440]
	eor	x8, x8, x9
	str	x8, [sp, #384]
	ldr	x8, [sp, #432]
	ldr	x9, [sp, #424]
	eor	x8, x8, x9
	str	x8, [sp, #376]
	ldr	x8, [sp, #440]
	ldr	x9, [sp, #408]
	eor	x8, x8, x9
	str	x8, [sp, #368]
	ldr	x8, [sp, #368]
	ldr	x9, [sp, #376]
	and	x8, x8, x9
	str	x8, [sp, #360]
	ldr	x8, [sp, #360]
	ldr	x9, [sp, #424]
	eor	x8, x8, x9
	str	x8, [sp, #352]
	ldr	x8, [sp, #432]
	ldr	x9, [sp, #352]
	eor	x8, x8, x9
	str	x8, [sp, #344]
	ldr	x8, [sp, #400]
	ldr	x9, [sp, #352]
	eor	x8, x8, x9
	str	x8, [sp, #336]
	ldr	x8, [sp, #424]
	ldr	x9, [sp, #336]
	and	x8, x8, x9
	str	x8, [sp, #328]
	ldr	x8, [sp, #328]
	ldr	x9, [sp, #344]
	eor	x8, x8, x9
	str	x8, [sp, #320]
	ldr	x8, [sp, #400]
	ldr	x9, [sp, #328]
	eor	x8, x8, x9
	str	x8, [sp, #312]
	ldr	x8, [sp, #384]
	ldr	x9, [sp, #312]
	and	x8, x8, x9
	str	x8, [sp, #304]
	ldr	x8, [sp, #416]
	ldr	x9, [sp, #304]
	eor	x8, x8, x9
	str	x8, [sp, #296]
	mov	w0, #5
	str	w0, [sp, #12]                   ; 4-byte Folded Spill
	bl	_AndCC_counter
	mov	w0, #11
	bl	_XorCC_counter
	ldr	x8, [sp, #296]
	ldr	x9, [sp, #320]
	eor	x8, x8, x9
	str	x8, [sp, #288]
	ldr	x8, [sp, #384]
	ldr	x9, [sp, #352]
	eor	x8, x8, x9
	str	x8, [sp, #280]
	ldr	x8, [sp, #384]
	ldr	x9, [sp, #296]
	eor	x8, x8, x9
	str	x8, [sp, #272]
	ldr	x8, [sp, #352]
	ldr	x9, [sp, #320]
	eor	x8, x8, x9
	str	x8, [sp, #264]
	ldr	x8, [sp, #280]
	ldr	x9, [sp, #288]
	eor	x8, x8, x9
	str	x8, [sp, #256]
	ldr	x8, [sp, #264]
	ldur	x9, [x29, #-208]
	and	x8, x8, x9
	str	x8, [sp, #760]
	ldr	x8, [sp, #320]
	ldur	x9, [x29, #-136]
	and	x8, x8, x9
	str	x8, [sp, #752]
	ldr	x8, [sp, #352]
	ldur	x9, [x29, #-88]
	and	x8, x8, x9
	str	x8, [sp, #744]
	ldr	x8, [sp, #272]
	ldur	x9, [x29, #-216]
	and	x8, x8, x9
	str	x8, [sp, #736]
	ldr	x8, [sp, #296]
	ldur	x9, [x29, #-96]
	and	x8, x8, x9
	str	x8, [sp, #728]
	ldr	x8, [sp, #384]
	ldur	x9, [x29, #-144]
	and	x8, x8, x9
	str	x8, [sp, #720]
	ldr	x8, [sp, #280]
	ldur	x9, [x29, #-176]
	and	x8, x8, x9
	str	x8, [sp, #712]
	ldr	x8, [sp, #256]
	ldur	x9, [x29, #-224]
	and	x8, x8, x9
	str	x8, [sp, #704]
	ldr	x8, [sp, #288]
	ldur	x9, [x29, #-168]
	and	x8, x8, x9
	str	x8, [sp, #696]
	ldr	x8, [sp, #264]
	ldur	x9, [x29, #-184]
	and	x8, x8, x9
	str	x8, [sp, #688]
	ldr	x8, [sp, #320]
	ldur	x9, [x29, #-112]
	and	x8, x8, x9
	str	x8, [sp, #680]
	ldr	x8, [sp, #352]
	ldur	x9, [x29, #-120]
	and	x8, x8, x9
	str	x8, [sp, #672]
	ldr	x8, [sp, #272]
	ldur	x9, [x29, #-192]
	and	x8, x8, x9
	str	x8, [sp, #664]
	ldr	x8, [sp, #296]
	ldur	x9, [x29, #-128]
	and	x8, x8, x9
	str	x8, [sp, #656]
	ldr	x8, [sp, #384]
	ldur	x9, [x29, #-104]
	and	x8, x8, x9
	str	x8, [sp, #648]
	ldr	x8, [sp, #280]
	ldur	x9, [x29, #-160]
	and	x8, x8, x9
	str	x8, [sp, #640]
	ldr	x8, [sp, #256]
	ldur	x9, [x29, #-200]
	and	x8, x8, x9
	str	x8, [sp, #632]
	ldr	x8, [sp, #288]
	ldur	x9, [x29, #-152]
	and	x8, x8, x9
	str	x8, [sp, #624]
	mov	w0, #18
	bl	_AndCC_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	bl	_XorCC_counter
	ldr	x8, [sp, #640]
	ldr	x9, [sp, #632]
	eor	x8, x8, x9
	str	x8, [sp, #248]
	ldr	x8, [sp, #680]
	ldr	x9, [sp, #672]
	eor	x8, x8, x9
	str	x8, [sp, #240]
	ldr	x8, [sp, #720]
	ldr	x9, [sp, #656]
	eor	x8, x8, x9
	str	x8, [sp, #232]
	ldr	x8, [sp, #688]
	ldr	x9, [sp, #680]
	eor	x8, x8, x9
	str	x8, [sp, #224]
	ldr	x8, [sp, #744]
	ldr	x9, [sp, #664]
	eor	x8, x8, x9
	str	x8, [sp, #216]
	ldr	x8, [sp, #744]
	ldr	x9, [sp, #720]
	eor	x8, x8, x9
	str	x8, [sp, #208]
	ldr	x8, [sp, #704]
	ldr	x9, [sp, #696]
	eor	x8, x8, x9
	str	x8, [sp, #200]
	ldr	x8, [sp, #760]
	ldr	x9, [sp, #736]
	eor	x8, x8, x9
	str	x8, [sp, #192]
	ldr	x8, [sp, #712]
	ldr	x9, [sp, #704]
	eor	x8, x8, x9
	str	x8, [sp, #184]
	ldr	x8, [sp, #632]
	ldr	x9, [sp, #624]
	eor	x8, x8, x9
	str	x8, [sp, #176]
	ldr	x8, [sp, #664]
	ldr	x9, [sp, #232]
	eor	x8, x8, x9
	str	x8, [sp, #168]
	ldr	x8, [sp, #216]
	ldr	x9, [sp, #192]
	eor	x8, x8, x9
	str	x8, [sp, #160]
	ldr	x8, [sp, #728]
	ldr	x9, [sp, #248]
	eor	x8, x8, x9
	str	x8, [sp, #152]
	ldr	x8, [sp, #736]
	ldr	x9, [sp, #184]
	eor	x8, x8, x9
	str	x8, [sp, #144]
	ldr	x8, [sp, #248]
	ldr	x9, [sp, #160]
	eor	x8, x8, x9
	str	x8, [sp, #136]
	ldr	x8, [sp, #648]
	ldr	x9, [sp, #160]
	eor	x8, x8, x9
	str	x8, [sp, #128]
	ldr	x8, [sp, #200]
	ldr	x9, [sp, #152]
	eor	x8, x8, x9
	str	x8, [sp, #120]
	ldr	x8, [sp, #224]
	ldr	x9, [sp, #152]
	eor	x8, x8, x9
	str	x8, [sp, #112]
	ldr	x8, [sp, #728]
	ldr	x9, [sp, #144]
	eor	x8, x8, x9
	str	x8, [sp, #104]
	ldr	x8, [sp, #128]
	ldr	x9, [sp, #120]
	eor	x8, x8, x9
	str	x8, [sp, #96]
	ldr	x8, [sp, #752]
	ldr	x9, [sp, #112]
	eor	x8, x8, x9
	str	x8, [sp, #88]
	ldr	x8, [sp, #144]
	ldr	x9, [sp, #112]
	eor	x8, x8, x9
	str	x8, [sp, #72]
	ldr	x9, [sp, #168]
	ldr	x8, [sp, #120]
	eon	x8, x8, x9
	str	x8, [sp, #24]
	ldr	x9, [sp, #232]
	ldr	x8, [sp, #136]
	eon	x8, x8, x9
	str	x8, [sp, #16]
	ldr	x8, [sp, #104]
	ldr	x9, [sp, #96]
	eor	x8, x8, x9
	str	x8, [sp, #80]
	ldr	x8, [sp, #192]
	ldr	x9, [sp, #88]
	eor	x8, x8, x9
	str	x8, [sp, #48]
	ldr	x8, [sp, #208]
	ldr	x9, [sp, #88]
	eor	x8, x8, x9
	str	x8, [sp, #40]
	ldr	x8, [sp, #240]
	ldr	x9, [sp, #96]
	eor	x8, x8, x9
	str	x8, [sp, #32]
	ldr	x9, [sp, #104]
	ldr	x8, [sp, #48]
	eon	x8, x8, x9
	str	x8, [sp, #64]
	ldr	x9, [sp, #176]
	ldr	x8, [sp, #80]
	eon	x8, x8, x9
	str	x8, [sp, #56]
	mov	w0, #30
	bl	_XorCC_counter
	mov	w0, #4
	bl	_NotCC_counter
	ldr	x8, [sp, #72]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #56]
	ldr	x8, [sp, #64]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #48]
	ldr	x8, [sp, #56]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #40]
	ldr	x8, [sp, #48]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #32]
	ldr	x8, [sp, #40]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #24]
	ldr	x8, [sp, #32]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #16]
	ldr	x8, [sp, #24]
	ldur	x9, [x29, #-24]
	str	x8, [x9, #8]
	ldr	x8, [sp, #16]
	ldur	x9, [x29, #-24]
	str	x8, [x9]
	add	sp, sp, #1008
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function aes_ecb4x
_aes_ecb4x:                             ; @aes_ecb4x
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #208
	.cfi_def_cfa_offset 208
	stp	x29, x30, [sp, #192]            ; 16-byte Folded Spill
	add	x29, sp, #192
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-8]
	str	x0, [sp, #48]
	str	x1, [sp, #40]
	str	x2, [sp, #32]
	str	w3, [sp, #28]
	ldr	x1, [sp, #40]
	sub	x0, x29, #72
	mov	x2, #64
	bl	_memcpy
	mov	w0, #16
	bl	_WriteCC_counter
	str	wzr, [sp, #24]
	b	LBB25_1
LBB25_1:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #24]
	subs	w8, w8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB25_4
	b	LBB25_2
LBB25_2:                                ;   in Loop: Header=BB25_1 Depth=1
	ldr	w8, [sp, #24]
	mov	x10, x8
	add	x8, sp, #56
	mov	x9, x8
	add	x0, x9, x10, lsl #3
	ldr	w9, [sp, #24]
	add	w9, w9, #4
	add	x1, x8, w9, uxtw #3
	ldr	w8, [sp, #24]
	lsl	w9, w8, #2
	sub	x8, x29, #72
	add	x2, x8, w9, uxtw #2
	bl	_br_aes_ct64_interleave_in
	b	LBB25_3
LBB25_3:                                ;   in Loop: Header=BB25_1 Depth=1
	ldr	w8, [sp, #24]
	add	w8, w8, #1
	str	w8, [sp, #24]
	b	LBB25_1
LBB25_4:
	add	x0, sp, #56
	str	x0, [sp, #16]                   ; 8-byte Folded Spill
	bl	_br_aes_ct64_ortho
	ldr	x0, [sp, #16]                   ; 8-byte Folded Reload
	ldr	x1, [sp, #32]
	bl	_add_round_key
	mov	w8, #1
	str	w8, [sp, #24]
	b	LBB25_5
LBB25_5:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #24]
	ldr	w9, [sp, #28]
	subs	w8, w8, w9
	cset	w8, hs
	tbnz	w8, #0, LBB25_8
	b	LBB25_6
LBB25_6:                                ;   in Loop: Header=BB25_5 Depth=1
	add	x0, sp, #56
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	bl	_br_aes_ct64_bitslice_Sbox
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	bl	_shift_rows
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	bl	_mix_columns
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x8, [sp, #32]
	ldr	w9, [sp, #24]
	lsl	w9, w9, #3
	add	x1, x8, w9, uxtw #3
	bl	_add_round_key
	b	LBB25_7
LBB25_7:                                ;   in Loop: Header=BB25_5 Depth=1
	ldr	w8, [sp, #24]
	add	w8, w8, #1
	str	w8, [sp, #24]
	b	LBB25_5
LBB25_8:
	add	x0, sp, #56
	str	x0, [sp]                        ; 8-byte Folded Spill
	bl	_br_aes_ct64_bitslice_Sbox
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	_shift_rows
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	ldr	x8, [sp, #32]
	ldr	w10, [sp, #28]
	mov	w9, #8
	mul	w9, w9, w10
	add	x1, x8, w9, uxtw #3
	bl	_add_round_key
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	_br_aes_ct64_ortho
	str	wzr, [sp, #24]
	b	LBB25_9
LBB25_9:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #24]
	subs	w8, w8, #4
	cset	w8, hs
	tbnz	w8, #0, LBB25_12
	b	LBB25_10
LBB25_10:                               ;   in Loop: Header=BB25_9 Depth=1
	ldr	w8, [sp, #24]
	lsl	w9, w8, #2
	sub	x8, x29, #72
	add	x0, x8, w9, uxtw #2
	ldr	w8, [sp, #24]
	mov	x9, x8
	add	x8, sp, #56
	ldr	x1, [x8, x9, lsl #3]
	ldr	w9, [sp, #24]
	add	w9, w9, #4
	ldr	x2, [x8, w9, uxtw #3]
	bl	_br_aes_ct64_interleave_out
	b	LBB25_11
LBB25_11:                               ;   in Loop: Header=BB25_9 Depth=1
	ldr	w8, [sp, #24]
	add	w8, w8, #1
	str	w8, [sp, #24]
	b	LBB25_9
LBB25_12:
	ldr	x0, [sp, #48]
	sub	x1, x29, #72
	mov	x2, #16
	bl	_br_range_enc32le
	ldur	x9, [x29, #-8]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB25_14
	b	LBB25_13
LBB25_13:
	bl	___stack_chk_fail
LBB25_14:
	ldp	x29, x30, [sp, #192]            ; 16-byte Folded Reload
	add	sp, sp, #208
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function add_round_key
_add_round_key:                         ; @add_round_key
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x8, [sp]
	ldr	x10, [x8]
	ldr	x9, [sp, #8]
	ldr	x8, [x9]
	eor	x8, x8, x10
	str	x8, [x9]
	ldr	x8, [sp]
	ldr	x10, [x8, #8]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #8]
	eor	x8, x8, x10
	str	x8, [x9, #8]
	ldr	x8, [sp]
	ldr	x10, [x8, #16]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #16]
	eor	x8, x8, x10
	str	x8, [x9, #16]
	ldr	x8, [sp]
	ldr	x10, [x8, #24]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #24]
	eor	x8, x8, x10
	str	x8, [x9, #24]
	ldr	x8, [sp]
	ldr	x10, [x8, #32]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #32]
	eor	x8, x8, x10
	str	x8, [x9, #32]
	ldr	x8, [sp]
	ldr	x10, [x8, #40]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #40]
	eor	x8, x8, x10
	str	x8, [x9, #40]
	ldr	x8, [sp]
	ldr	x10, [x8, #48]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #48]
	eor	x8, x8, x10
	str	x8, [x9, #48]
	ldr	x8, [sp]
	ldr	x10, [x8, #56]
	ldr	x9, [sp, #8]
	ldr	x8, [x9, #56]
	eor	x8, x8, x10
	str	x8, [x9, #56]
	mov	w0, #8
	bl	_XorCC_counter
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function shift_rows
_shift_rows:                            ; @shift_rows
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	wzr, [x29, #-12]
	b	LBB27_1
LBB27_1:                                ; =>This Inner Loop Header: Depth=1
	ldur	w8, [x29, #-12]
	subs	w8, w8, #8
	cset	w8, ge
	tbnz	w8, #0, LBB27_4
	b	LBB27_2
LBB27_2:                                ;   in Loop: Header=BB27_1 Depth=1
	ldur	x8, [x29, #-8]
	ldursw	x9, [x29, #-12]
	ldr	x8, [x8, x9, lsl #3]
	str	x8, [sp, #24]
	ldrh	w8, [sp, #24]
                                        ; kill: def $x8 killed $w8
	ldr	x9, [sp, #24]
	and	x9, x9, #0xfff00000
	orr	x8, x8, x9, lsr #4
	ldr	x9, [sp, #24]
	and	x9, x9, #0xf0000
	orr	x8, x8, x9, lsl #12
	ldr	x9, [sp, #24]
	and	x9, x9, #0xff0000000000
	orr	x8, x8, x9, lsr #8
	ldr	x9, [sp, #24]
	and	x9, x9, #0xff00000000
	orr	x8, x8, x9, lsl #8
	ldr	x9, [sp, #24]
	and	x9, x9, #0xf000000000000000
	orr	x8, x8, x9, lsr #12
	ldr	x9, [sp, #24]
	and	x9, x9, #0xfff000000000000
	orr	x8, x8, x9, lsl #4
	ldur	x9, [x29, #-8]
	ldursw	x10, [x29, #-12]
	str	x8, [x9, x10, lsl #3]
	mov	w0, #7
	bl	_AndCC_counter
	mov	w0, #6
	bl	_OrCC_counter
	mov	w0, #1
	str	w0, [sp, #16]                   ; 4-byte Folded Spill
	mov	w1, #4
	str	w1, [sp, #20]                   ; 4-byte Folded Spill
	bl	_RightShift_counter
	ldr	w0, [sp, #16]                   ; 4-byte Folded Reload
	mov	w1, #8
	str	w1, [sp, #12]                   ; 4-byte Folded Spill
	bl	_RightShift_counter
	ldr	w0, [sp, #16]                   ; 4-byte Folded Reload
	mov	w1, #12
	str	w1, [sp, #8]                    ; 4-byte Folded Spill
	bl	_RightShift_counter
	ldr	w1, [sp, #8]                    ; 4-byte Folded Reload
	ldr	w0, [sp, #16]                   ; 4-byte Folded Reload
	bl	_LeftShift_counter
	ldr	w1, [sp, #12]                   ; 4-byte Folded Reload
	ldr	w0, [sp, #16]                   ; 4-byte Folded Reload
	bl	_LeftShift_counter
	ldr	w0, [sp, #16]                   ; 4-byte Folded Reload
	ldr	w1, [sp, #20]                   ; 4-byte Folded Reload
	bl	_LeftShift_counter
	b	LBB27_3
LBB27_3:                                ;   in Loop: Header=BB27_1 Depth=1
	ldur	w8, [x29, #-12]
	add	w8, w8, #1
	stur	w8, [x29, #-12]
	b	LBB27_1
LBB27_4:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function mix_columns
_mix_columns:                           ; @mix_columns
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #224
	.cfi_def_cfa_offset 224
	stp	x29, x30, [sp, #208]            ; 16-byte Folded Spill
	add	x29, sp, #208
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8]
	stur	x8, [x29, #-16]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #8]
	stur	x8, [x29, #-24]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #16]
	stur	x8, [x29, #-32]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #24]
	stur	x8, [x29, #-40]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #32]
	stur	x8, [x29, #-48]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #40]
	stur	x8, [x29, #-56]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #48]
	stur	x8, [x29, #-64]
	ldur	x8, [x29, #-8]
	ldr	x8, [x8, #56]
	stur	x8, [x29, #-72]
	ldur	x9, [x29, #-16]
	ldur	x8, [x29, #-16]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	stur	x8, [x29, #-80]
	ldur	x9, [x29, #-24]
	ldur	x8, [x29, #-24]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	stur	x8, [x29, #-88]
	ldur	x9, [x29, #-32]
	ldur	x8, [x29, #-32]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	stur	x8, [x29, #-96]
	ldur	x9, [x29, #-40]
	ldur	x8, [x29, #-40]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	str	x8, [sp, #104]
	ldur	x9, [x29, #-48]
	ldur	x8, [x29, #-48]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	str	x8, [sp, #96]
	ldur	x9, [x29, #-56]
	ldur	x8, [x29, #-56]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	str	x8, [sp, #88]
	ldur	x9, [x29, #-64]
	ldur	x8, [x29, #-64]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	str	x8, [sp, #80]
	ldur	x9, [x29, #-72]
	ldur	x8, [x29, #-72]
	lsl	x8, x8, #48
	orr	x8, x8, x9, lsr #16
	str	x8, [sp, #72]
	mov	w0, #8
	str	w0, [sp, #68]                   ; 4-byte Folded Spill
	mov	w1, #16
	bl	_RightShift_counter
	ldr	w0, [sp, #68]                   ; 4-byte Folded Reload
	mov	w1, #48
	bl	_LeftShift_counter
	ldr	w0, [sp, #68]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	ldur	x8, [x29, #-72]
	ldr	x9, [sp, #72]
	eor	x8, x8, x9
	ldur	x9, [x29, #-80]
	eor	x8, x8, x9
	str	x8, [sp]                        ; 8-byte Folded Spill
	ldur	x8, [x29, #-16]
	ldur	x9, [x29, #-80]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp]                        ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9]
	ldur	x8, [x29, #-16]
	ldur	x9, [x29, #-80]
	eor	x8, x8, x9
	ldur	x9, [x29, #-72]
	eor	x8, x8, x9
	ldr	x9, [sp, #72]
	eor	x8, x8, x9
	ldur	x9, [x29, #-88]
	eor	x8, x8, x9
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	ldur	x8, [x29, #-24]
	ldur	x9, [x29, #-88]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9, #8]
	ldur	x8, [x29, #-24]
	ldur	x9, [x29, #-88]
	eor	x8, x8, x9
	ldur	x9, [x29, #-96]
	eor	x8, x8, x9
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-96]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #16]                   ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9, #16]
	ldur	x8, [x29, #-32]
	ldur	x9, [x29, #-96]
	eor	x8, x8, x9
	ldur	x9, [x29, #-72]
	eor	x8, x8, x9
	ldr	x9, [sp, #72]
	eor	x8, x8, x9
	ldr	x9, [sp, #104]
	eor	x8, x8, x9
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-40]
	ldr	x9, [sp, #104]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9, #24]
	ldur	x8, [x29, #-40]
	ldr	x9, [sp, #104]
	eor	x8, x8, x9
	ldur	x9, [x29, #-72]
	eor	x8, x8, x9
	ldr	x9, [sp, #72]
	eor	x8, x8, x9
	ldr	x9, [sp, #96]
	eor	x8, x8, x9
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-48]
	ldr	x9, [sp, #96]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9, #32]
	ldur	x8, [x29, #-48]
	ldr	x9, [sp, #96]
	eor	x8, x8, x9
	ldr	x9, [sp, #88]
	eor	x8, x8, x9
	str	x8, [sp, #40]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-56]
	ldr	x9, [sp, #88]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #40]                   ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9, #40]
	ldur	x8, [x29, #-56]
	ldr	x9, [sp, #88]
	eor	x8, x8, x9
	ldr	x9, [sp, #80]
	eor	x8, x8, x9
	str	x8, [sp, #48]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-64]
	ldr	x9, [sp, #80]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	eor	x8, x8, x0
	ldur	x9, [x29, #-8]
	str	x8, [x9, #48]
	ldur	x8, [x29, #-64]
	ldr	x9, [sp, #80]
	eor	x8, x8, x9
	ldr	x9, [sp, #72]
	eor	x8, x8, x9
	str	x8, [sp, #56]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-72]
	ldr	x9, [sp, #72]
	eor	x0, x8, x9
	bl	_rotr32
	ldr	x8, [sp, #56]                   ; 8-byte Folded Reload
	mov	x9, x0
	ldr	w0, [sp, #68]                   ; 4-byte Folded Reload
	eor	x8, x8, x9
	ldur	x9, [x29, #-8]
	str	x8, [x9, #56]
	mov	w1, #32
	str	w1, [sp, #64]                   ; 4-byte Folded Spill
	bl	_LeftShift_counter
	ldr	w1, [sp, #64]                   ; 4-byte Folded Reload
	ldr	w0, [sp, #68]                   ; 4-byte Folded Reload
	bl	_RightShift_counter
	ldr	w0, [sp, #68]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	mov	w0, #38
	bl	_XorCC_counter
	ldp	x29, x30, [sp, #208]            ; 16-byte Folded Reload
	add	sp, sp, #224
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_aes_ct64_interleave_out
_br_aes_ct64_interleave_out:            ; @br_aes_ct64_interleave_out
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	ldur	x8, [x29, #-16]
	and	x8, x8, #0xff00ff00ff00ff
	stur	x8, [x29, #-32]
	ldur	x8, [x29, #-24]
	and	x8, x8, #0xff00ff00ff00ff
	str	x8, [sp, #40]
	mov	w0, #2
	str	w0, [sp, #12]                   ; 4-byte Folded Spill
	bl	_AndCC_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	ldur	x8, [x29, #-16]
	lsr	x8, x8, #8
	and	x8, x8, #0xff00ff00ff00ff
	str	x8, [sp, #32]
	ldur	x8, [x29, #-24]
	lsr	x8, x8, #8
	and	x8, x8, #0xff00ff00ff00ff
	str	x8, [sp, #24]
	mov	w1, #8
	str	w1, [sp, #16]                   ; 4-byte Folded Spill
	bl	_RightShift_counter
	ldr	w0, [sp, #12]                   ; 4-byte Folded Reload
	bl	_AndCC_counter
	ldr	w1, [sp, #16]                   ; 4-byte Folded Reload
	ldur	x9, [x29, #-32]
	ldur	x8, [x29, #-32]
	orr	x8, x8, x9, lsr #8
	stur	x8, [x29, #-32]
	ldr	x9, [sp, #40]
	ldr	x8, [sp, #40]
	orr	x8, x8, x9, lsr #8
	str	x8, [sp, #40]
	ldr	x9, [sp, #32]
	ldr	x8, [sp, #32]
	orr	x8, x8, x9, lsr #8
	str	x8, [sp, #32]
	ldr	x9, [sp, #24]
	ldr	x8, [sp, #24]
	orr	x8, x8, x9, lsr #8
	str	x8, [sp, #24]
	mov	w0, #4
	str	w0, [sp, #20]                   ; 4-byte Folded Spill
	bl	_RightShift_counter
	ldr	w0, [sp, #20]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	ldr	w0, [sp, #20]                   ; 4-byte Folded Reload
	ldur	x8, [x29, #-32]
	and	x8, x8, #0xffff0000ffff
	stur	x8, [x29, #-32]
	ldr	x8, [sp, #40]
	and	x8, x8, #0xffff0000ffff
	str	x8, [sp, #40]
	ldr	x8, [sp, #32]
	and	x8, x8, #0xffff0000ffff
	str	x8, [sp, #32]
	ldr	x8, [sp, #24]
	and	x8, x8, #0xffff0000ffff
	str	x8, [sp, #24]
	bl	_AndCC_counter
	ldr	w0, [sp, #20]                   ; 4-byte Folded Reload
	ldur	x8, [x29, #-32]
                                        ; kill: def $w8 killed $w8 killed $x8
	ldur	x9, [x29, #-32]
	lsr	x9, x9, #16
                                        ; kill: def $w9 killed $w9 killed $x9
	orr	w8, w8, w9
	ldur	x9, [x29, #-8]
	str	w8, [x9]
	ldr	x8, [sp, #40]
                                        ; kill: def $w8 killed $w8 killed $x8
	ldr	x9, [sp, #40]
	lsr	x9, x9, #16
                                        ; kill: def $w9 killed $w9 killed $x9
	orr	w8, w8, w9
	ldur	x9, [x29, #-8]
	str	w8, [x9, #4]
	ldr	x8, [sp, #32]
                                        ; kill: def $w8 killed $w8 killed $x8
	ldr	x9, [sp, #32]
	lsr	x9, x9, #16
                                        ; kill: def $w9 killed $w9 killed $x9
	orr	w8, w8, w9
	ldur	x9, [x29, #-8]
	str	w8, [x9, #8]
	ldr	x8, [sp, #24]
                                        ; kill: def $w8 killed $w8 killed $x8
	ldr	x9, [sp, #24]
	lsr	x9, x9, #16
                                        ; kill: def $w9 killed $w9 killed $x9
	orr	w8, w8, w9
	ldur	x9, [x29, #-8]
	str	w8, [x9, #12]
	mov	w1, #16
	bl	_RightShift_counter
	ldr	w0, [sp, #20]                   ; 4-byte Folded Reload
	bl	_OrCC_counter
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_range_enc32le
_br_range_enc32le:                      ; @br_range_enc32le
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	b	LBB30_1
LBB30_1:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	subs	x9, x8, #1
	str	x9, [sp, #8]
	subs	x8, x8, #0
	cset	w8, ls
	tbnz	w8, #0, LBB30_3
	b	LBB30_2
LBB30_2:                                ;   in Loop: Header=BB30_1 Depth=1
	ldur	x0, [x29, #-8]
	ldr	x8, [sp, #16]
	add	x9, x8, #4
	str	x9, [sp, #16]
	ldr	w1, [x8]
	bl	_br_enc32le
	ldur	x8, [x29, #-8]
	add	x8, x8, #4
	stur	x8, [x29, #-8]
	b	LBB30_1
LBB30_3:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function rotr32
_rotr32:                                ; @rotr32
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	x9, [sp, #8]
	ldr	x8, [sp, #8]
	lsr	x8, x8, #32
	orr	x0, x8, x9, lsl #32
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_enc32le
_br_enc32le:                            ; @br_enc32le
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	str	w1, [sp, #4]
	ldr	w8, [sp, #4]
	ldr	x9, [sp, #8]
	strb	w8, [x9]
	ldr	w8, [sp, #4]
	lsr	w8, w8, #8
	ldr	x9, [sp, #8]
	strb	w8, [x9, #1]
	ldr	w8, [sp, #4]
	lsr	w8, w8, #16
	ldr	x9, [sp, #8]
	strb	w8, [x9, #2]
	ldr	w8, [sp, #4]
	lsr	w8, w8, #24
	ldr	x9, [sp, #8]
	strb	w8, [x9, #3]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function br_swap32
_br_swap32:                             ; @br_swap32
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	w0, [sp, #12]
	ldr	w8, [sp, #12]
	and	w9, w8, #0xff00ff
	ldr	w8, [sp, #12]
	lsr	w8, w8, #8
	and	w8, w8, #0xff00ff
	orr	w8, w8, w9, lsl #8
	str	w8, [sp, #12]
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #12]
	lsr	w8, w8, #16
	orr	w0, w8, w9, lsl #16
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function aes_ctr4x
_aes_ctr4x:                             ; @aes_ctr4x
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	w3, [sp, #4]
	ldur	x0, [x29, #-8]
	ldr	x1, [sp, #16]
	ldr	x2, [sp, #8]
	ldr	w3, [sp, #4]
	bl	_aes_ecb4x
	ldr	x8, [sp, #16]
	add	x0, x8, #12
	bl	_inc4_be
	ldr	x8, [sp, #16]
	add	x0, x8, #28
	bl	_inc4_be
	ldr	x8, [sp, #16]
	add	x0, x8, #44
	bl	_inc4_be
	ldr	x8, [sp, #16]
	add	x0, x8, #60
	bl	_inc4_be
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function inc4_be
_inc4_be:                               ; @inc4_be
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	ldr	w0, [x8]
	bl	_br_swap32
	add	w8, w0, #4
	str	w8, [sp, #4]
	ldr	w0, [sp, #4]
	bl	_br_swap32
	ldr	x8, [sp, #8]
	str	w0, [x8]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__const
_Rcon:                                  ; @Rcon
	.ascii	"\001\002\004\b\020 @\200\0336"

.subsections_via_symbols
