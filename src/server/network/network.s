/* Server.Network.s */
.include "lib/netlibt/netconst.inc"
.include "lib/macrolib/macrolib.inc"

/* CONSTANTS */
.set	PORT,           7777 // The server's port
.set	BACKLOG,        2048 // How much data each socket can read
.set	BLOCKS,            0 // Whether or not to allow blocking server
.set	BLOCKC,            1 // Whether or not to allow blocking clients
.set	MAXPLAYERS,       16 // The max amount of players that can join
.set	MAXNAMECHAR,      15 // The max amount of characters in a name
.set	MAXWAITSEC,        0 // The number in seconds to wait for connections
.set	MAXWAITNSEC, 1000000 // The number in nanoseconds to wait (<1 second)

.bss
SERVER:	// The place to store the server's socket
	.word	0
ADDRESS:// The place to store the server's ip address
	.word	0
BUFFER:	// Where all of the read data is stored
	.skip	BACKLOG

.data
TIMETOWAIT: // How long the server should wait for incoming data or clients
	.word	MAXWAITSEC
	.word	MAXWAITNSEC
SERVERLISTENTEXT:
	.asciz	"Listening for clients on port 0.0.0.0:7777"

/*
struct player
{
   int status; (0=dead, 1=alive)
   int sockfd;
   char[16] name;
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
	mov32	r0, ADDRESS	// Ip address
	movw	r1, #PORT	// Port
	movw	r2, #BACKLOG	// Maximum backlog
	movs	r3, #BLOCK	// Allow blocking?
	ldr	r0, [r0]
	bl	createServer

	// Save the socket file descriptor for later
	push	{r0}

	// Save the server's socket and ip address
	mov32	r1, SERVER
	str	r0, [r1]
	mov32	r1, ADDRESS
	movs	r0, #0
	str	r0, [r1]

	// Tell the user that we're now listening for clients
	mov32	r1, SERVERLISTENTEXT
	bl	prints

	pop	{r0, pc}	// Return

/* bool serverTick(struct player* players[r0]) */
/* Advances the server by one tick */
/* Data races: Reads and modifies each of the players' memory regions */
.thumb_func
.global	serverTick
.type	serverTick, %function
serverTick:
	push	{lr}		// Save return point for later

	// Check if any clients want to join the server
	bl	getIncomingClients

	// Check if any of the players can do anything
	bl	getIncomingData

	pop	{pc}		// Return

/* void	getIncomingClients() */
/* Checks if clients want to join the server */
/* Data Races: Reads and writes to each of the players' memory regions */
.thumb_func
getIncomingClients:
	push	{lr}		// Save return point for later
	pop	{pc}		// Return

/* void	getIncomingData() */
/* Checks all of the clients to see if they can do anything */
/* Data Races: Reads each of the players' memory regions */
.thumb_func
getIncomingData:
	push	{lr}		// Save return point for later
	pop	{pc}		// Return
