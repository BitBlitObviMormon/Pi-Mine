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
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"print.c"
	.text
	.align	2
	.global	getInput
	.type	getInput, %function
getInput:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	sub	sp, sp, #8
	ldr	r4, .L3
	bl	printf
	add	r1, sp, #4
	ldr	r0, .L3+4
	bl	__isoc99_scanf
	ldr	r2, [r4]
	ldr	r1, [sp, #4]
	ldr	r0, .L3+8
	add	r3, r1, r2
	bl	printf
	ldr	r2, [r4]
	ldr	r1, [sp, #4]
	ldr	r0, .L3+12
	rsb	r3, r2, r1
	bl	printf
	ldr	r1, [sp, #4]
	ldr	r0, .L3+16
	mov	r2, r1, asl #1
	bl	printf
	ldr	r2, [sp, #4]
	ldr	r0, .L3+20
	mov	r1, r2
	add	r2, r2, r2, lsr #31
	mov	r2, r2, asr #1
	bl	printf
	ldr	r0, [sp, #4]
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, pc}
.L4:
	.align	2
.L3:
	.word	.LANCHOR0
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	getInput, .-getInput
	.align	2
	.global	print
	.type	print, %function
print:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, lr}
	mov	r4, #49
	ldr	r5, .L10
.L6:
	mov	r0, r4
	ldr	r1, [r5]
	add	r4, r4, #1
	bl	_IO_putc
	cmp	r4, #58
	bne	.L6
	ldmfd	sp!, {r3, r4, r5, pc}
.L11:
	.align	2
.L10:
	.word	stdout
	.size	print, .-print
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r0, .L14
	bl	getInput
	mov	r4, r0
	bl	print
	ldr	r3, .L14+4
	mov	r0, #10
	ldr	r1, [r3]
	bl	_IO_putc
	mov	r0, r4
	ldmfd	sp!, {r4, pc}
.L15:
	.align	2
.L14:
	.word	.LC5
	.word	stdout
	.size	main, .-main
	.global	global
	.data
	.align	2
.LANCHOR0 = . + 0
	.type	global, %object
	.size	global, 4
global:
	.word	5
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%d\000"
	.space	1
.LC1:
	.ascii	"Your answer, %d, plus %d is %d.\012\000"
	.space	3
.LC2:
	.ascii	"Your answer, %d, minus %d is %d.\012\000"
	.space	2
.LC3:
	.ascii	"Your answer, %d, times 2 is %d.\012\000"
	.space	3
.LC4:
	.ascii	"Your answer, %d, divided by 2 is more or less %d.\012"
	.ascii	"\000"
	.space	1
.LC5:
	.ascii	"What is your favorite number? \000"
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
