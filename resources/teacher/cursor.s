.set STDIN, 0
.set STDOUT, 1

.set READ, 3
.set WRITE, 4


.data
hide:
	.byte 27
	.ascii "[?25l"

show:
	.byte 27
	.ascii "[?25h"

fore:
	.byte 27
	.ascii "[30m"

back:
	.byte 27
	.ascii "[40m"

home:
	.byte 27
	.ascii "[H"

position:
	.byte 27
	.ascii "[0000;0000H"

clear_l:
	.byte 27
	.ascii "[2K"

clear_s:
	.byte 27
	.ascii "[2J"

bold:
	.byte 27
	.ascii "[1m"

dim:
	.byte 27
	.ascii "[2m"

reset:
	.byte 27
	.ascii "[0m"


.balign 4
.text
.global cursor_show
cursor_show:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =show
	mov r2, #6
	svc #0
	bx lr

.global cursor_hide
cursor_hide:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =hide
	mov r2, #6
	svc #0
	bx lr

.global fore_color
fore_color:
	cmp r0, #10
	bxpl lr

	// Inject the color number into the string
	add r0, r0, #48
	ldr r1, =fore
	strb r0, [r1, #3]

	mov r7, #WRITE
	mov r0, #STDOUT
	mov r2, #5
	svc #0
	bx lr

.global back_color
back_color:
	cmp r0, #10
	bxpl lr

	// Inject the color number into the string
	add r0, r0, #48
	ldr r1, =back
	strb r0, [r1, #3]

	mov r7, #WRITE
	mov r0, #STDOUT
	mov r2, #5
	svc #0
	bx lr

.global cursor_home
cursor_home:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =home
	mov r2, #3
	svc #0
	bx lr

.global locate
locate:
	cmp r0, #1000
	bxpl lr
	cmp r1, #1000
	bxpl lr

	push {r4-r7, lr}
	ldr r12, =position
	mov r7, #10


	mov r6, #0  // Which coordiate are we working on? 0 = x, 1 = y
locate_loop:
	mov r3, #0  // Counter and shifter
	mov r2, #0  // Set this to zeroes
coordinate_loop:
	udiv r4, r0, r7		// Get x / 10
	mls  r5, r4, r7, r0	// Get x % 10
	add r5, r5, #48		// Convert digit to ascii
	mov r2, r2, LSL #8
	add r2, r2, r5		// Put digit in the appropriate byte of r2
	mov r0, r4
	cmp r3, #24
	addne r3, r3, #8
	bne coordinate_loop

	cmp r6, #0
	moveq r0, r1
	moveq r1, r2
	addeq r6, r6, #1
	beq locate_loop


	str r1, [r12, #2]	// Put x in string
	str r2, [r12, #7]	// Put y in string

	mov r7, #WRITE
	mov r0, #STDOUT
	mov r1, r12
	mov r2, #12
	svc #0

	pop {r4-r7, pc}


.global clear_line
clear_line:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =clear_l
	mov r2, #4
	svc #0
	bx lr

.global clear_screen
clear_screen:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =clear_s
	mov r2, #4
	svc #0
	bx lr

.global bold_text
bold_text:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =bold
	mov r2, #4
	svc #0
	bx lr

.global dim_text
dim_text:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =dim
	mov r2, #4
	svc #0
	bx lr

.global reset_text
reset_text:
	mov r7, #WRITE
	mov r0, #STDOUT
	ldr r1, =reset
	mov r2, #4
	svc #0
	bx lr


// Test code that should be commented out
.global _start
_start:
	bl ask
	bl cursor_hide
	bl ask
	bl cursor_show
	bl ask
	mov r0, #5
	bl fore_color
	bl ask
	mov r0, #9
	bl fore_color
	bl ask
	mov r0, #5
	bl back_color
	bl ask
	mov r0, #9
	bl back_color
	bl ask
	bl cursor_home
	bl ask
	mov r0, #50
	mov r1, #50
	bl locate
	bl ask
	bl clear_line
	bl ask
	bl clear_screen
	bl ask
	bl bold_text
	bl ask
	bl dim_text
	bl ask
	bl reset_text
	bl ask

	mov r7, #1
	svc #0


ask:
	sub sp, sp, #16
	mov r7, #WRITE
	mov r0, #STDOUT
	adr r1, prompt
	mov r2, #1
	svc #0

	mov r7, #READ
	mov r0, #STDIN
	mov r1, sp
	mov r2, #16
	svc #0

	add sp, sp, #16
	bx lr

prompt:
	.ascii ">"
