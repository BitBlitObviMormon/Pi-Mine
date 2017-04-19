//  FILE STREAMS
.set STDIN,  0
.set STDOUT, 1

//  SYSCALLS (In octal)
.set	EXIT,	 0001
.set	READ,	 0003
.set	WRITE,	 0004
.set	BRK,	 0055
.set	IOCTL,	 0066

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

	.thumb
	.syntax	unified

// int main()
.thumb_func
.global main
main:
	bl	rawMode

	subs	sp, sp, #4 //  Allocate input space
.Lwhile_loop:
	movs	r7, #READ
	movs	r0, #STDIN
	mov	r1, sp
	movs	r2, #1
	svc	#0

	//  If nothing was read, don't bother writing
	cmp	r0, #0
	beq	.Lskip_print

	ldrb	r0, [sp]
	movs	r1, r0
	bl	puti
	adds	sp, sp, #4
.Lskip_print:
	ldrb	r0, [sp]
	cmp	r0, #32
	bne	.Lwhile_loop

	adds	sp, sp, #4
	bl	restoreTerminal

	movs	r7, #1
	svc	#0
