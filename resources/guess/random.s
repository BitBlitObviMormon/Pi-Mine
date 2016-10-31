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
	.file	"random.c"
	.text
	.align	2
	.global	seedBGen
	.type	seedBGen, %function
seedBGen:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L2
	strb	r0, [r3]
	bx	lr
.L3:
	.align	2
.L2:
	.word	.LANCHOR0
	.size	seedBGen, .-seedBGen
	.align	2
	.global	seedSGen
	.type	seedSGen, %function
seedSGen:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L5
	strh	r0, [r3, #2]	@ movhi
	bx	lr
.L6:
	.align	2
.L5:
	.word	.LANCHOR0
	.size	seedSGen, .-seedSGen
	.align	2
	.global	seedIGen
	.type	seedIGen, %function
seedIGen:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L8
	str	r0, [r3, #4]
	bx	lr
.L9:
	.align	2
.L8:
	.word	.LANCHOR0
	.size	seedIGen, .-seedIGen
	.align	2
	.global	seedLGen
	.type	seedLGen, %function
seedLGen:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L11
	strd	r0, [r3, #8]
	bx	lr
.L12:
	.align	2
.L11:
	.word	.LANCHOR0
	.size	seedLGen, .-seedLGen
	.align	2
	.global	seedGens
	.type	seedGens, %function
seedGens:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, lr}
	bl	clock
	mov	r7, r0
	mov	r0, #0
	bl	time
	add	r0, r0, r7
	uxtb	r7, r0
	bl	clock
	mov	r6, r0
	mov	r0, #0
	bl	time
	add	r0, r0, r6
	uxtb	r6, r0
	bl	clock
	mov	r5, r0
	mov	r0, #0
	bl	time
	add	r0, r0, r5
	uxtb	r5, r0
	bl	clock
	mov	r4, r0
	mov	r0, #0
	bl	time
	ldr	r3, .L15
	mov	r1, #0
	strb	r7, [r3]
	strh	r6, [r3, #2]	@ movhi
	str	r5, [r3, #4]
	add	r0, r0, r4
	uxtb	r0, r0
	strd	r0, [r3, #8]
	ldmfd	sp!, {r3, r4, r5, r6, r7, pc}
.L16:
	.align	2
.L15:
	.word	.LANCHOR0
	.size	seedGens, .-seedGens
	.align	2
	.global	randomByte
	.type	randomByte, %function
randomByte:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L19
	ldrb	r0, [r4]	@ zero_extendqisi2
	bl	srand
	bl	rand
	add	r0, r0, #2
	uxtb	r0, r0
	strb	r0, [r4]
	ldmfd	sp!, {r4, pc}
.L20:
	.align	2
.L19:
	.word	.LANCHOR0
	.size	randomByte, .-randomByte
	.align	2
	.global	randomShort
	.type	randomShort, %function
randomShort:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L23
	ldrsh	r0, [r4, #2]
	bl	srand
	bl	rand
	add	r0, r0, #2
	uxth	r0, r0
	strh	r0, [r4, #2]	@ movhi
	sxth	r0, r0
	ldmfd	sp!, {r4, pc}
.L24:
	.align	2
.L23:
	.word	.LANCHOR0
	.size	randomShort, .-randomShort
	.align	2
	.global	randomInt
	.type	randomInt, %function
randomInt:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	ldr	r4, .L27
	ldr	r0, [r4, #4]
	bl	srand
	bl	rand
	add	r0, r0, #2
	str	r0, [r4, #4]
	ldmfd	sp!, {r4, pc}
.L28:
	.align	2
.L27:
	.word	.LANCHOR0
	.size	randomInt, .-randomInt
	.align	2
	.global	randomLong
	.type	randomLong, %function
randomLong:
	push	{r4, lr}
	ldr	r4, THESEEDS
	ldr	r0, [r4, #8]
	bl	srand
	bl	rand
	add	r0, r0, #2
	str	r0, [r4, #4]
	push	{r0}
	bl	rand
	add	r0, r0, #2
	str	r0, [r4, #4]
	pop	{r1, r4, pc}
THESEEDS:
	.word	.LANCHOR0
	.size	randomLong, .-randomLong
	.global	seeds
	.bss
	.align	3
.LANCHOR0 = . + 0
	.type	seeds, %object
	.size	seeds, 16
seeds:
	.space	16
	.ident	"GCC: (Raspbian 4.9.2-10) 4.9.2"
	.section	.note.GNU-stack,"",%progbits
