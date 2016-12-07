.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

.thumb
.syntax	unified

/* int main() */
.thumb_func
.global main
main:
	//Allocate 5,760 bytes of space for block data
	subs	sp, #5760
	mov	r4, sp

	//Allocate 57,600 bytes of space for buffer
	subs	sp, #57600
	mov	r5, sp

	//Initialize the gui
	movs	r0, #80	//width  = 80
	movs	r1, #24	//height = 24
	movs	r2, r4	//blockBuffer
	bl	initMessenger

	//Paint the gui into a printable format
	movs	r0, r4	//blockBuffer
	movs	r1, r5	//charBuffer
	bl	paint	//Paint blockBuffer -> charBuffer

	//Save the terminal's cursor
	bl	saveCursor

	//Print the buffer
	movs	r1, r5
	bl	prints

	//Load the terminal's saved cursor
	bl	loadCursor

	//Unallocate all of the buffers
	adds	sp, #57600
	adds	sp, #5760

	//Exit
	movs	r0, #2		//Move #13 to r0
	b	sysExit
