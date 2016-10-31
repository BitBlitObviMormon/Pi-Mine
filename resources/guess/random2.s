	.file	"random.s"
	.data
	//$$$ CREATE A STRUCT
seeds:	//Raw data that holds each of the different seeds
	//char
	//short
	//int
	//long long
	.space	16

	.text
	.align	2
	.global	seedBGen
	.type	seedBGen, %function
//Seeds the Random Byte Generator
seedBGen:	
	ldr	r3, THESEEDS
	strb	r0, [r3]
	bx	lr

//Seeds the Random Short Generator
seedSGen:
	ldr	r3, THESEEDS
	strh	r0, [r3, #2]	@ movhi
	bx	lr

//Seeds the Random Int Generator
seedIGen:
	ldr	r3, THESEEDS
	str	r0, [r3, #4]
	bx	lr

//Seeds the Random Long Generator
seedLGen:
	ldr	r3, THESEEDS
	strd	r0, [r3, #8]
	bx	lr

//Seeds all of the random generators
	.global	seedGens
	.type	seedGens, %function
seedGens:
	//$$$ CREATE AND TRAVERSE AN ARRAY
	push	{r3, r4, r5, r6, r7, lr}
	//Seed the random byte generator
	bl	clock
	mov	r7, r0
	mov	r0, #0
	bl	time
	add	r0, r0, r7
	uxtb	r7, r0

	//Seed the random short generator
	bl	clock
	mov	r6, r0
	mov	r0, #0
	bl	time
	add	r0, r0, r6
	uxtb	r6, r0

	//Seed the random int generator
	bl	clock
	mov	r5, r0
	mov	r0, #0
	bl	time
	add	r0, r0, r5
	uxtb	r5, r0

	//Seed the random long generator
	bl	clock
	mov	r4, r0
	mov	r0, #0
	bl	time
	ldr	r3, THESEEDS
	mov	r1, #0
	strb	r7, [r3]
	strh	r6, [r3, #2]	@ movhi
	str	r5, [r3, #4]
	add	r0, r0, r4
	uxtb	r0, r0
	strd	r0, [r3, #8]
	pop	{r3, r4, r5, r6, r7, pc}

//Generates a random byte
	.global	randomByte
	.type	randomByte, %function
randomByte:
	push	{r4, lr}
	ldr	r4, THESEEDS
	ldrb	r0, [r4]	@ zero_extendqisi2
	bl	srand
	bl	rand
	add	r0, r0, #2
	uxtb	r0, r0
	strb	r0, [r4]
	pop	{r4, pc}

//Generates a random short
	.global	randomShort
	.type	randomShort, %function
randomShort:
	push	{r4, lr}
	ldr	r4, THESEEDS
	ldrsh	r0, [r4, #2]
	bl	srand
	bl	rand
	add	r0, r0, #2
	uxth	r0, r0
	strh	r0, [r4, #2]	@ movhi
	sxth	r0, r0
	pop	{r4, pc}

//Generates a random int
	.global	randomInt
	.type	randomInt, %function
randomInt:
	push	{r4, lr}
	ldr	r4, THESEEDS
	ldr	r0, [r4, #4]
	bl	srand
	bl	rand
	add	r0, r0, #2
	str	r0, [r4, #4]
	pop	{r4, pc}

//Generates a random long
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
