.text
.syntax	unified
.arm
.global _start
_start:
	blx	main	//Call the thumb function main

//int main()
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

	//Tell the server to accept the client
	movs	r0, r7		//Get the server's socket
	bl	acceptClient	//Accept the client's connection

	//Close the sockets
	movs	r0, r4		//Close the client
	bl	closeSocket
	movs	r0, r7		//Close the server
	bl	closeSocket
	
	movs	r0, #13		//Move #13 to r0
	b	sysExit

.text
ADDRESS:
	.word	0x00000000	//The address 0x00.0x00.0x00.0x00
