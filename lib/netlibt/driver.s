.text
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

//int main()
.thumb
.global main
main:
	//Create a socket
	bl	createSocket
	mov	r4, r0		//Save the client's socket

	//Create a server
	ldr	r0, =ADDRESS	//Get the pointer of the ip address
	ldr	r0, [r0]	//Get the ip address
	movw	r1, #12345	//Host on port 12345
	mov	r2, #255	//Only 255 bytes of backlog
	mov	r3, #0		//Don't block in order to wait for clients
	mov	r5, r0		//Save the ip address
	mov	r6, r1		//Save the port
	bl	createServer	//Create the server socket
	mov	r7, r0		//Save the server's socket

	//Connect the client to the server
	mov	r0, r4		//Get the client's socket
	mov	r1, r5		//Get the ip address
	mov	r2, r6		//Get the port
	bl	connect		//Connect the client to the server

	//Tell the server to accept the client
	mov	r0, r7		//Get the server's socket
	bl	acceptClient	//Accept the client's connection

	mov	r0, #13		//Move #13 to r0
	b	sysExit

.text
ADDRESS:
	.word	0x00000000
