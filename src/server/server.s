/* CONSTANTS */
.set	PLRSPC, 2304	//How much space to allocate for player data

.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

.thumb
.syntax	unified

/* int[r0] main() */
.thumb_func
.global main
main:
	//Create a server
	bl	startNetServer

	//Allocate space for the players
	subs	sp, #PLRSPC
	mov	r4, sp
	movs	r0, r4

	//Zero out the player space
	bl	zeroPlayers
.LmainLoop:
	//Do one server tick
	movs	r0, r4
	bl	serverTick
	cbnz	r0, .LoopEnd	//If the server tick returns zero then
	b	.LmainLoop	//Loop again
.LoopEnd:
	//Unallocate space from the players
	adds	sp, #PLRSPC

	movs	r0, #0		//exit(0)
	b	sysExit

/* void zeroPlayers(struct player* players[r0]) */
.thumb_func
.type	zeroPlayers, %function
zeroPlayers:
	push	{r4-r12, lr}

	//Zero out registers
	movs	r1, #0
	movs	r2, #0
	movs	r3, #0
	movs	r4, #0
	movs	r5, #0
	movs	r6, #0
	movs	r7, #0
	movs	r8, #0
	movs	r9, #0
	movs	r10, #0
	movs	r11, #0
	movs	r12, #0

	//Get endpoint
	adds	lr, r0, #PLRSPC
.LzeroLoop:
	//Load instructions until we pass the maximum player space mark
	stmia	r0!, {r1-r12}
	cmp	r0, lr
	blo	.LzeroLoop
.LzeroEnd:
	pop	{r4-r12, pc}
