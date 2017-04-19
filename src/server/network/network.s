/* Server.Network.s */
.include "lib/netlibt/netconst.s"

/* CONSTANTS */
.set	PORT,      7777
.set	BACKLOG,   2048 // How much data each socket can read
.set	BLOCK,        0
.set	SOCKSPACE, 1024 // How much space to allocate for sockets

.data
SERVER:	// The place to store the server's socket
	.word	0
ADDRESS:// The place to store the server's ip address
	.word	0

/*
struct player
{
   byte status; (0=dead, 1=alive)
   int sockfd;
   char* name;
}
*/

.text
.thumb
.syntax	unified

/* sockfd[r0] startNetServer() */
/* Starts a net server and then stores player info in the given memory */
/* Data races: Reads and modifies the memory region players */
.thumb_func
.global	startNetServer
.type	startNetServer, %function
startNetServer:
	push	{lr}		// Save return point for later

	// Create a server
	ldr	r0, =ADDRESS	// Ip address
	movw	r1, #PORT	// Port
	movw	r2, #BACKLOG	// Maximum backlog
	movs	r3, #BLOCK	// Allow blocking?
	ldr	r0, [r0]
	bl	createServer

	pop	{pc}		// Return

/* void serverTick(struct player* players[r0]) */
/* Advances the server by one tick */
/* Data races: Reads and modifies the memory region players */
.thumb_func
.global	serverTick
.type	serverTick, %function
serverTick:
	push	{lr}		// Save return point for later
	pop	{pc}		// Return
