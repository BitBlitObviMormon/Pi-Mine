// SYSCALLS
.set	EXIT, 1
.set	BRK, 45

.data
heap:
	.word	0
heap_end:
	.word	0

.text
.arm
.global _start
_start:
	//Ask where the heap is
	ldr	r0, =heap
	mov	r7, #BRK
	mov	r0, #0
	svc	#0

	//Store the heap location in memory
	ldr	r4, =heap
	ldr	r5, =heap_end
	str	r0, [r4]
	str	r0, [r5]

	mov	r4, r0
	mov	r5, r0
	
.Lcount_start:
	cmp	r4, r5
	blo	.Lskip_alloc

	add	r0, r4, #1
	mov	r7, #BRK
	svc	#0

	mov	r5, r0
	ldr	r1, =heap_end
	str	r0, [r1]
.Lskip_alloc:
	add	r6, r6, #1
	str	r6, [r4], #1
.Lcount_test:
	cmp	r6, #1000
	bne	.Lcount_start
.Lcount_end:
	mov	r7, #EXIT
	svc	#0