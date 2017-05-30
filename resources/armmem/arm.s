.bss
memory:
	.skip	40960000
more:	
	.skip	40960000

.text
.arm
.global _start
_start:
	ldr	r0, =memory
	ldr	r1, =more
	mov	r2, r1

loop:	
	ldmia	r0!, {r3-r12}
	stmia	r1!, {r3-r12}
	cmp	r0, r2
	bne	loop

	mov	r7, #1
	svc	#0
