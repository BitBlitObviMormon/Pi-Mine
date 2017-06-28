.include "lib/macrolib/macrolib.inc"

.bss
.balign	2
PLAYER_0:
	.word	0	// Status
	.word	0	// Socket File Descriptor
	.skip	16	// Name
PLAYER_1:
	.skip	24	// See above for data layout
PLAYER_2:
	.skip	24	// See above for data layout
PLAYER_3:
	.skip	24	// See above for data layout
PLAYER_4:
	.skip	24	// See above for data layout
PLAYER_5:
	.skip	24	// See above for data layout
PLAYER_6:
	.skip	24	// See above for data layout
PLAYER_7:
	.skip	24	// See above for data layout
PLAYER_8:
	.skip	24	// See above for data layout
PLAYER_9:
	.skip	24	// See above for data layout
PLAYER_A:
	.skip	24	// See above for data layout
PLAYER_B:
	.skip	24	// See above for data layout
PLAYER_C:
	.skip	24	// See above for data layout
PLAYER_D:
	.skip	24	// See above for data layout
PLAYER_E:
	.skip	24	// See above for data layout
PLAYER_F:
	.skip	24	// See above for data layout

.data
.global	PLAYERS
PLAYERS:
	.word	PLAYER_0
	.word	PLAYER_1
	.word	PLAYER_2
	.word	PLAYER_3
	.word	PLAYER_4
	.word	PLAYER_5
	.word	PLAYER_6
	.word	PLAYER_7
	.word	PLAYER_8
	.word	PLAYER_9
	.word	PLAYER_A
	.word	PLAYER_B
	.word	PLAYER_C
	.word	PLAYER_D
	.word	PLAYER_E
	.word	PLAYER_F

.text
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

.thumb
.syntax	unified

/* int[r0] main() */
.thumb_func
.global main
main:
	// Create a server
	bl	startNetServer

	// Allocate space for the players
	mov32	r4, #PLAYERS
.LmainLoop:
	// Do one server tick
	movs	r0, r4
	bl	serverTick
	cbnz	r0, .LoopEnd	// If the server tick returns non zero then
	b	.LmainLoop	// Loop again
.LoopEnd:

	movs	r0, #0		// exit(0)
	b	sysExit

