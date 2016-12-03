/* This driver depends on the input/output library */
.data
buf:
	.skip	64	//Enough data to hold a string buffer

.text
.syntax	unified
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

/* int main() */
/* Note how important it is to receive before sending! */
/* Every send must first have a receive beforehand! */
/* Apparently sending when there's stuff to receive clogs up the pipe */
.thumb_func
.global main
main:
	//Create a socket
	bl	createSocket
	movs	r4, r0		//Save the client's socket

	//Create a server
	ldr	r0, =ADDRESS	//Get the pointer of the ip address
	ldr	r0, [r0]	//Get the ip address
	movw	r1, #7777	//Host on port 12345
	movs	r2, #255	//Only 255 bytes of backlog
	movs	r3, #0		//Don't block in order to wait for clients
	movs	r5, r0		//Save the ip address
	movs	r6, r1		//Save the port
	bl	createServer	//Create the server socket
	movs	r7, r0		//Save the server's socket

	//Connect the client to the server
	movs	r0, r4		//Get the client's socket
	movs	r1, r5		//Get the ip address
	movs	r2, r6		//Get the port
	bl	connect		//Connect the client to the server

//	b	sysExit

	//Tell the server to accept the client
	movs	r0, r7		//Get the server's socket
	bl	acceptClient	//Accept the client's connection

	//Make the client say hello to the server
	bl	sendClient
	
	//Have the server recieve the client's message
	bl	recvServer

	//Make the server say hello to the client
	bl	sendServer

	//Have the client recieve the server's message
	bl	recvClient

	//Close the sockets
	movs	r0, r4		//Close the client
	bl	closeSocket
	movs	r0, r7		//Close the server
	bl	closeSocket
	
	movs	r0, #13		//Move #13 to r0
	b	sysExit

/* void clientMsg(char* message[r0]) */
/* Makes the client say something */
.thumb_func
clientMsg:
	push	{r0, lr}	//Save return point and message

	//Print "[CLIENT] "
	ldr	r1, =CLIENT
	bl	prints

	//Print the message and append a newline
	pop	{r1}
	bl	puts

	pop	{pc}		//Return

/* void serverMsg(char* message[r0]) */
/* Makes the server say something */
.thumb_func
serverMsg:
	push	{r0, lr}	//Save return point and message

	//Print "[SERVER] "
	ldr	r1, =SERVER
	bl	prints

	//Print the message and append a newline
	pop	{r1}
	bl	puts

	pop	{pc}		//Return

/* void sendClient() */
/* Makes the client greet the server via message */
.thumb_func
sendClient:
	push	{lr}		//Save return point

	//Say the client is going to send a message
	ldr	r0, =CLIENTHELLO
	bl	clientMsg

	//Send the message
	mov	r0, r4		//Get the client's socket
	ldr	r1, =CLIENTSEND	//Prepare to send a packet over
	bl	sendMessage	//Send the packet

	//If we sent the data then return happily
	cbnz	r0, .LsendClientEnd

	//If we sent zero bytes then something must be wrong
	ldr	r0, =CLIENTFAIL
	bl	clientMsg
.LsendClientEnd:
	pop	{pc}		//Return

/* void sendServer() */
/* Makes the server greet the client via message */
.thumb_func
sendServer:
	push	{lr}		//Save return point

	//Say the server is going to send a message
	ldr	r0, =SERVERHELLO
	bl	serverMsg

	//Send the message
	mov	r0, r7		//Get the server's socket
	ldr	r1, =SERVERSEND	//Prepare to send a packet over
	bl	sendMessage	//Send the packet

	//If we sent the data then return happily
	cbnz	r0, .LsendServerEnd

	//If we sent zero bytes then something must be wrong
	ldr	r0, =SERVERFAIL
	bl	serverMsg
.LsendServerEnd:
	pop	{pc}		//Return


recvServer:
	bx	lr
recvClient:
	bx	lr
	
.text
ADDRESS:
	.word	0x00000000	//The address 0x00.0x00.0x00.0x00
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
