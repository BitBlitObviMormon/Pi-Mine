	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"input.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Error getting term attribs\012\000"
	.align	2
.LC1:
	.ascii	"Error setting term attribs\012\000"
	.align	2
.LC2:
	.ascii	"oops, bytes read return val is %d\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #72
	sub	r3, fp, #68
	mov	r0, #0
	mov	r1, r3
	bl	tcgetattr
	mov	r3, r0
	cmp	r3, #0
	beq	.L2
	ldr	r3, .L7
	ldr	r3, [r3]
	ldr	r0, .L7+4
	mov	r1, #1
	mov	r2, #27
	bl	fwrite
.L2:
	sub	r3, fp, #68
	mov	r0, r3
	bl	cfmakeraw
	sub	r3, fp, #68
	mov	r0, #0
	mov	r1, #0
	mov	r2, r3
	bl	tcsetattr
	mov	r3, r0
	cmp	r3, #0
	beq	.L3
	ldr	r3, .L7
	ldr	r3, [r3]
	ldr	r0, .L7+8
	mov	r1, #1
	mov	r2, #27
	bl	fwrite
.L3:
	mov	r3, #79
	strb	r3, [fp, #-70]
.L6:
	sub	r3, fp, #69
	mov	r0, #0
	mov	r1, r3
	mov	r2, #1
	bl	read
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bgt	.L4
	ldr	r3, .L7
	ldr	r3, [r3]
	mov	r0, r3
	ldr	r1, .L7+12
	ldr	r2, [fp, #-8]
	bl	fprintf
	b	.L5
.L4:
	sub	r3, fp, #70
	mov	r0, #2
	mov	r1, r3
	mov	r2, #1
	bl	write
.L5:
	b	.L6
.L8:
	.align	2
.L7:
	.word	stderr
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
