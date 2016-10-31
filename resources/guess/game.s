	.arch armv7-a
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu neon-vfpv4
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"game.c"
	.text
	.align	2
	.global	guess
	.type	guess, %function
guess:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r0, r1, r4, r6, r7, lr}
	mov	r6, r0
	mov	r7, r1
	mov	r4, #0
.L5:
	ldr	r0, .L9
	add	r4, r4, #1
	bl	printf
	ldr	r0, .L9+4
	mov	r1, sp
	bl	__isoc99_scanf
	ldrd	r2, [sp]
	cmp	r3, r7
	cmpeq	r2, r6
	ldrcc	r0, .L9+8
	bcc	.L7
	bls	.L4
	ldr	r0, .L9+12
.L7:
	bl	puts
	b	.L5
.L4:
	ldr	r0, .L9+16
	mov	r1, r4
	mov	r2, r6
	mov	r3, r7
	bl	printf
	mov	r0, r4
	add	sp, sp, #8
	@ sp needed
	ldmfd	sp!, {r4, r6, r7, pc}
.L10:
	.align	2
.L9:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	guess, .-guess
	.align	2
	.global	guessByte
	.type	guessByte, %function
guessByte:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	ldr	r0, .L13
	bl	puts
	bl	randomByte
	uxtb	r0, r0
	mov	r1, #0
	bl	guess
	ldr	r0, .L13+4
	ldmfd	sp!, {r3, lr}
	b	puts
.L14:
	.align	2
.L13:
	.word	.LC5
	.word	.LC6
	.size	guessByte, .-guessByte
	.align	2
	.global	guessShort
	.type	guessShort, %function
guessShort:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	ldr	r0, .L17
	bl	puts
	bl	randomShort
	uxth	r0, r0
	mov	r1, #0
	bl	guess
	ldr	r0, .L17+4
	ldmfd	sp!, {r3, lr}
	b	puts
.L18:
	.align	2
.L17:
	.word	.LC7
	.word	.LC8
	.size	guessShort, .-guessShort
	.align	2
	.global	guessInt
	.type	guessInt, %function
guessInt:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	ldr	r0, .L21
	bl	puts
	bl	randomInt
	mov	r1, #0
	bl	guess
	ldr	r0, .L21+4
	ldmfd	sp!, {r3, lr}
	b	puts
.L22:
	.align	2
.L21:
	.word	.LC9
	.word	.LC10
	.size	guessInt, .-guessInt
	.align	2
	.global	guessLong
	.type	guessLong, %function
guessLong:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, lr}
	ldr	r0, .L25
	bl	puts
	bl	randomLong
	bl	guess
	ldr	r0, .L25+4
	ldmfd	sp!, {r3, lr}
	b	puts
.L26:
	.align	2
.L25:
	.word	.LC11
	.word	.LC12
	.size	guessLong, .-guessLong
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC0:
	.ascii	"? \000"
.LC1:
	.ascii	"%llu\000"
.LC2:
	.ascii	"Guess higher!\000"
.LC3:
	.ascii	"Guess lower!\000"
.LC4:
	.ascii	"You took %d tries to guess %llu!\012\000"
.LC5:
	.ascii	"Guess a number between 0 and 255.\000"
.LC6:
	.ascii	"\012Easy? Good. Now try this one.\000"
.LC7:
	.ascii	"Guess a number between 0 and 65535.\000"
.LC8:
	.ascii	"\012Nice! See if you can beat this one.\000"
.LC9:
	.ascii	"Guess a number between 0 and 4294967295. Good luck!"
	.ascii	"\000"
.LC10:
	.ascii	"\012Hard? That was only 32 bits! Let's see how well"
	.ascii	" you do with 64!\000"
.LC11:
	.ascii	"Guess a number between 0 and 18446744073709551616.."
	.ascii	".\012I hope you live through this one.\000"
.LC12:
	.ascii	"\012I don't know how you did it, but congratulation"
	.ascii	"s.\000"
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
