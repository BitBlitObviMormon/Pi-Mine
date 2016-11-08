// SYSCALLS
.set	EXIT, 1
.set	BRK, 45

.data
mem_end:
	.word	0
mem_break:
	.word	0

.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

.thumb
.global exit
/* void exit(int) */
/* Exits with the error code given */
exit:
	mov	r7, #EXIT	//Exit with
	svc	#0		//	whatever is in r0

//int main()
.thumb
.global main
main:
	ldr	r0, =_end
	ldr	r1, =mem_end
	str	r0, [r1]

	mov	r7, #BRK
	svc	#0

	ldr	r1, =mem_break
	str	r0, [r1]

	mov	r4, #0
	ldr	r5, =mem_end
	ldr	r5, [r5]
	ldr	r6, =mem_break
	ldr	r6, [r6]

.Loop:
	cmp	r5, r6
	blo	.Lwrite

	add	r5, r5, #1
	mov	r7, #BRK
	mov	r0, r5
	svc	#0
	mov	r6, r0
.Lwrite:
	strb	r4, [r5]
	add	r4, #1
.Loop_test:
	mov	r0, #125
	lsl	r0, r0, #6
	cmp	r4, r0
	bne	.Loop

	mov	r0, #13		//Move #13 to r0
	b	exit
