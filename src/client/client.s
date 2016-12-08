/* CONSTANTS */
.set	WIDTH,    80
.set	HEIGHT,   24
.set	BLOCKS,   HEIGHT * WIDTH
.set	BLOCKLEN, BLOCKS * 3
.set	BUFLEN,   BLOCKS * 30

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
	subs	sp, #BLOCKLEN
	mov	r4, sp

	//Allocate 57,600 bytes of space for buffer
	subs	sp, #BUFLEN
	mov	r5, sp

	//Initialize the gui
	movs	r0, #WIDTH	//width  = 80
	movs	r1, #HEIGHT	//height = 24
	movs	r2, r4		//blockBuffer
	bl	initMessenger

	//Paint the gui into a printable format
	movs	r0, r4		//blockBuffer
	movs	r1, r5		//charBuffer
	movs	r2, #BLOCKS	//length
	bl	paint		//Paint blockBuffer -> charBuffer

	//Print the buffer
	movs	r1, r5
	bl	prints

	//Move the cursor to (3, HEIGHT-1)
	movs	r0, #3
	movs	r1, #HEIGHT-1
	bl	setCursor
	
	//Unallocate all of the buffers
	adds	sp, #BUFLEN
	adds	sp, #BLOCKLEN

	//Exit
	movs	r0, #2		//Move #13 to r0
	b	sysExit
