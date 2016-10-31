// Setup some constants
.set STDIN,  0
.set STDOUT, 1

.set TCGETS, 0x5401
.set TCSETS, 0x5402

.set ICANON, 2
.set ECHO, 8

.set VMIN, 6
.set VTIME, 5

.set NCCS, 32

.set IFLAG, 0
.set OFLAG, 4
.set CFLAG, 8
.set LFLAG, 12
.set C_CC,  17
.set ISPEED, 52
.set OSPEED, 56

.set READ,  0x03
.set WRITE, 0x04
.set IOCTL, 0x36

.data
// This is where we will store the old termios
// struct, so we can restore it later.
.balign 4
termios:
	.skip 60


.balign 4
.text
.global term_init
term_init:
	push {r4-r12, lr}
	sub sp, sp, #60  // Allocate stack space for the termios struct

	// ioctl(unsigned int fd, unsigned int cmd, void* arg)  r7 = 0x36
	ldr r2, =termios // Pointer to the global struct
	ldr r1, =TCGETS // Select ioctl function
	mov r0, #STDIN  // Set device file handle
	mov r7, #IOCTL
	svc #0

	// Copy the global struct to local stack for modification
	mov r1, sp
	ldr r0, =termios
	ldm r0!, {r2-r11} // Copy 40 bytes
	stm r1!, {r2-r11}
	ldm r0, {r2-r6} // Copy 20 bytes
	stm r1, {r2-r6}

	// Now we need to modify the struct on the stack
	// Disable Echo and Canonical mode
	ldr r0, [sp, #LFLAG]  // Get the control flags
	bic r0, r0, #(ECHO | ICANON)
	str r0, [sp, #LFLAG]
	// Make input non-blocking, with no timeout (essentially set to polling mode)
	mov r0, #0
	strh r0, [sp, #(C_CC + VTIME)]  // VTIME and VMIN are adjacent bytes, so writing a halfword to VTIME should overwrite both

	// Ready to write back to the device driver now
	mov r2, sp
	ldr r1, =TCSETS
	mov r0, #STDIN
	mov r7, #IOCTL
	svc #0

	add sp, sp, #60
	pop {r4-r12, pc}

.global term_quit
term_quit:
	push {lr}
	ldr r2, =termios
	ldr r1, =TCSETS
	mov r0, #STDIN
	mov r7, #IOCTL
	svc #0
	pop {pc}


// This is a test function that should generally be commented out
.global _start
_start:
	bl term_init

	sub sp, sp, #1 // Allocate input space
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

	add sp, sp, #1
	bl term_quit

	mov r7, #1
	svc #0


// Print a byte as a number
p_byte:
	mov r3, sp // String pointer
	sub sp, sp, #4

	mov r12, #10

	mov r1, #10	// Newline
	strb r1, [r3, #-1]!


	b test_non_zero
while_digits:
	// Divide/Modulus (r1, r2)
	udiv r1, r0, r12
	mls r2, r1, r12, r0

	add r2, r2, #48  // r2 = r2 + "0"
	strb r2, [r3, #-1]!

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
