/* This driver depends on the Macro and Input/Output libraries */

.include "../macrolib/macrolib.inc"	// For mov32

/* CONSTANTS */
.set	PORT,   7777
.set	BACKLOG, 255

.bss
BUF:
	.skip	256	// Enough data to hold a string buffer

.text
.syntax	unified
.arm
.global _start
_start:
	blx	main	// Call the thumb function main

/* int main() */
.thumb_func
.global main
main:
	// Create a socket
	bl	createSocket
	movs	r4, r0		// Save the client's socket

	// Create a server
	mov32	r0, ADDRESS	// Get the pointer of the ip address
	ldr	r0, [r0]	// Get the ip address
	movw	r1, #PORT	// Host on port 7777
	movs	r2, #BACKLOG	// Only 255 bytes of backlog
	movs	r3, #0		// Don't block in order to wait for clients
	movs	r5, r0		// Save the ip address
	movs	r6, r1		// Save the port
	bl	createServer	// Create the server socket
	movs	r7, r0		// Save the server's socket

	// Connect the client to the server
	movs	r0, r4		// Get the client's socket
	movs	r1, r5		// Get the ip address
	movs	r2, r6		// Get the port
	bl	connect		// Connect the client to the server

// 	b	sysExit

	// Tell the server to accept the client
	movs	r0, r7		// Get the server's socket
	bl	acceptClient	// Accept the client's connection
	movs	r8, r0		// Store the client's socket (server-side)

	// Make the client say hello to the server
	bl	sendClient
	
	// Make the server say hello to the client
	bl	sendServer

	// Have the server recieve the client's message
	bl	recvServer

	// Have the client recieve the server's message
	bl	recvClient

	// Close the sockets
	movs	r0, r4		// Close the client
	bl	closeSocket
	movs	r0, r7		// Close the server
	bl	closeSocket
	
	movs	r0, #13		// Move #13 to r0
	b	sysExit

/* void clientMsg(char* message[r0], bool serverSays[r1]) */
/* Makes the client say something */
.thumb_func
clientMsg:
	push	{r0, lr}	// Save return point and message
	push	{r1}		// Save the bool

	// Print "[CLIENT] "
	mov32	r1, CLIENT
	bl	prints

	// If the message is coming from the server, print "Server said: "
	pop	{r0}		// Get the bool
	cbz	r0, .LclientMsgNotServer

	// Print "Server said: "
	mov32	r1, CLIENTRECV	// "Server said: "
	bl	prints		// Print "Server said: "
.LclientMsgNotServer:
	// Print the message and append a newline
	pop	{r1}
	bl	puts

	pop	{pc}		// Return

/* void serverMsg(char* message[r0]) */
/* Makes the server say something */
.thumb_func
serverMsg:
	push	{r0, lr}	// Save return point and message
	push	{r1}		// Save the bool

	// Print "[SERVER] "
	mov32	r1, SERVER
	bl	prints

	// If the message is coming from the server, print "Client said: "
	pop	{r0}		// Get the bool
	cbz	r0, .LserverMsgNotClient

	// Print "Client said: "
	mov32	r1, SERVERRECV	// "Client said: "
	bl	prints		// Print "Client said: "
.LserverMsgNotClient:
	// Print the message and append a newline
	pop	{r1}
	bl	puts

	pop	{pc}		// Return

/* void sendClient() */
/* Makes the client greet the server via message */
.thumb_func
sendClient:
	push	{lr}		// Save return point

	// Say the client is going to send a message
	mov32	r0, CLIENTHELLO
	movs	r1, #0
	bl	clientMsg

	// Send the message
	movs	r0, r4		// Get the client's socket
	mov32	r1, CLIENTSEND	// Prepare to send a packet over
	bl	sendMessage	// Send the packet

	// If we sent the data then return happily
	cbnz	r0, .LsendClientEnd

	// If we sent zero bytes then something must be wrong
	mov32	r0, CLIENTFAIL
	movs	r1, #0
	bl	clientMsg
.LsendClientEnd:
	pop	{pc}		// Return

/* void sendServer() */
/* Makes the server greet the client via message */
.thumb_func
sendServer:
	push	{lr}		// Save return point

	// Say the server is going to send a message
	mov32	r0, SERVERHELLO
	movs	r1, #0
	bl	serverMsg

	// Send the message
	movs	r0, r8		// Get the client's socket (server-side)
	mov32	r1, SERVERSEND	// Prepare to send a packet over
	bl	sendMessage	// Send the packet

	// If we sent the data then return happily
	cbnz	r0, .LsendServerEnd

	// If we sent zero bytes then something must be wrong
	mov32	r0, SERVERFAIL
	movs	r1, #0
	bl	serverMsg
.LsendServerEnd:
	pop	{pc}		// Return


/* void recvServer() */
/* Makes the server receive the client's message */
recvServer:
	push	{lr}		// Save return point for later

	// Receive the client's message
	movs	r0, r8		// Get the client's socket (server-side)
	mov32	r1, BUF		// Prepare to receive data
	movs	r2, #64		// Prepare to receive 64 bytes of data
	bl	receiveBuffer	// Receive the data

	// If we received zero bytes of data from the client, complain
	cbnz	r0, .LrecvServerSend
	mov32	r0, SERVERNORECV
	movs	r1, #0
	bl	serverMsg	// Print the message
	pop	{pc}		// Return

.LrecvServerSend:
	// If we received some data then print it out
	mov32	r0, BUF		// Get the received data
	movs	r1, #1		// Tell serverMsg we got it from the client
	bl	serverMsg	// Print the message
	pop	{pc}		// Return

/* void recvClient() */
/* Makes the client receive the server's message */
recvClient:
	push	{lr}		// Save return point for later

	// Receive the server's message
	movs	r0, r4		// Get the client's socket
	mov32	r1, BUF		// Prepare to receive data
	movs	r2, #64		// Prepare to receive 64 bytes of data
	bl	receiveBuffer	// Receive the data

	// If we received zero bytes of data from the server, complain
	cbnz	r0, .LrecvClientSend
	mov32	r0, CLIENTNORECV
	movs	r1, #0
	bl	clientMsg	// Print the message
	pop	{pc}		// Return

.LrecvClientSend:
	// If we received some data then print it out
	mov32	r0, BUF		// Get the received data
	movs	r1, #1		// Tell clientMsg we got it from the server
	bl	clientMsg	// Print the message
	pop	{pc}		// Return
	
.text
ADDRESS:
	.word	0x00000000	// The address 0x00.0x00.0x00.0x00
CLIENT:
	.asciz	"[CLIENT] "
SERVER:
	.asciz	"[SERVER] "
CLIENTRECV:
	.asciz	"Server said: "
SERVERRECV:
	.asciz	"Client said: "
CLIENTHELLO:
	.asciz	"I say hello!"
SERVERHELLO:
	.asciz	"I say hi back!"
CLIENTSEND:
	.asciz	"Hi, my name is client!"
SERVERSEND:
	.asciz	"Hi client, my name is server!"
CLIENTFAIL:
	.asciz	"Could not send message to server!"
SERVERFAIL:
	.asciz	"Could not send message to client!"
CLIENTNORECV:
	.asciz	"Did not receive anything from the server!"
SERVERNORECV:
	.asciz	"Did not receive anything from the client!"
