// FILE STREAMS
.set STDIN,  0
.set STDOUT, 1

// SYSCALLS (In octal)
.set	EXIT,	 0001
.set	READ,	 0003
.set	WRITE,	 0004
.set	BRK,	 0055
.set	IOCTL,	 0066

.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

//int main()
.thumb
.global main
main:
	bl rawMode

	sub sp, sp, #4 // Allocate input space
while_loop:
	mov r7, #READ
	mov r0, #STDIN
	mov r1, sp
	mov r2, #1
	svc #0

	// If nothing was read, don't bother writing
	cmp r0, #0
	beq skip_print

	ldrb r0, [sp]
	bl p_byte
@	mov r7, #WRITE
@	mov r0, #STDOUT
@	mov r1, sp
@	mov r2, #1
@	svc #0
skip_print:
	ldrb r0, [sp]
	cmp r0, #32
	bne while_loop

	add sp, sp, #4
	bl restoreTerminal

	mov r7, #1
	svc #0


// Print a byte as a number
p_byte:
	mov r3, sp // String pointer
	sub sp, sp, #4

	mov r4, #10

	mov r1, #10	// Newline
	sub r3, r3, #1
	strb r1, [r3]

	mov r5, #0xff
	and r0, r5
	b test_non_zero
while_digits:
	// Divide/Modulus (r1, r2)
	udiv r1, r0, r4
	mls r2, r1, r4, r0

	add r2, r2, #48  // r2 = r2 + "0"
	sub r3, r3, #1
	strb r2, [r3]

	mov r0, r1

test_non_zero:
	cmp r0, #0
	bne while_digits


	mov r7, #WRITE
	mov r0, #STDOUT
	mov r1, r3
	add r2, sp, #4
	sub r2, r2, r1
	svc #0

	add sp, sp, #4
	bx lr

.thumb
theend:	
	mov	r0, #13		//Move #13 to r0
	b	sysExit		//Exit
