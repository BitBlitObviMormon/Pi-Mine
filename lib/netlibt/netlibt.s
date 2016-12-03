/* Network Library (Thumb) */
/* Depends on System and Input/Output Libraries */

/* CONSTANTS */
.set	ADDRLEN, 16	//The length of the address

/* Include network constants and error values */
.include "netconst.s"
.include "../errlibt/errno.s"

.data
.balign	4
STRUCT:
	// IFREQ [PF_INET]
	// char*   ifr_name
	// short   family
	// short   port       (REVERSE BYTE ORDER!) 0x0102 -> 0x0201
	// int     ip_address (REVERSE BYTE ORDER!) 0x01020304 -> 0x04030201
	// char[8] (padding)
	//
	// CLIENT
	// char*    name       //The client's name
	// int      ip_address //The client's ip address
	// char[12] (padding)  //Miscellaneous data to go with the client
	.skip	20	//20 bytes space for ifreq, sockaddr, or client structs
.balign	4
TIMEVAL:
	// TIMEVAL [select()]
	// int tv_sec  (seconds)
	// int tv_usec (microseconds)
	//
	// TIMESPEC [pselect()]
	// int tv_sec  (seconds)
	// int tv_nsec (nanoseconds)
	.skip	8	//8 bytes of space for timeval or timespec
.balign	4
POLL:
	.skip	40	//Space to hold the selection poll
ADDRLENMEM:
	.word	ADDRLEN

.text
.thumb
.syntax	unified

/* sockfd[r0] createSocket() */
/* Creates an IPv4 socket */
/* Data Races: No memory is accessed */
.thumb_func
.global	createSocket
.type	createSocket, %function
createSocket:
	//Create a socket
	mov	r0, #PF_INET	//Use IPv4 domain
	mov	r1, #SOCK_STREAM//Use standard socket stream
	mov	r2, #0		//Use the recommended protocol
	b	sysSocket	//Call socket system call

/* sockfd[r0] createServer(sockfd ip [r0], short port[r1], int backlog[r2]) */
/* Creates an IPv4 socket on the local host and binds it to a local address */
/* on the specified port where it will listen for incoming clients */
/* The backlog is the maximum amount of data the socket can hold before */
/* further requests are rejected */
/* The return value is negative and set to errno if it fails */
/* Data Races: The memory STRUCT is read and written to */
/* TODO: Need to set server socket to be nonblocking! */
.thumb_func
.global	createServer
.type	createServer, %function
createServer:
	push	{r4, r5, r6, r7, lr}	//Save variables and return point

	//Save the arguments into variables
	movs	r4, r0		//r4 = ip
	movs	r5, r1		//r5 = port
	movs	r6, r2		//r6 = backlog
	movs	r7, r3		//r7 = block
				//r8 = socket

	//Reverse the byte order of the ip and port (because memory structure)
	rev	r4, r4		//Reverse ip's byte order
	revsh	r5, r5		//Reverse port's byte order

	//Create a socket to work with
	movs	r0, #PF_INET	//Use IPv4 domain
	movs	r1, #SOCK_STREAM//Use standard socket stream
	movs	r2, #0		//Use the recommended protocol
	bl	sysSocket	//Call the socket system call
	movs	r8, r0		//Save the socket for later

//	//Get the local host's ip name
//	mov	r0, r8		//Get the socket
//	movw	r1, #SIOCGIFNAME//Prepare to use SIOCGIFNAME Ioctl call
//	ldr	r2, =STRUCT	//Prepare space for the ifreq struct
//	bl	sysIoctl	//Call the Ioctl system call
//
//	//Get the local host's ip address
//	mov	r0, r8		//Get the socket
//	movw	r1, #SIOCGIFADDR//Prepare to use SIOCGIFADDR Ioctl call
//	ldr	r2, =STRUCT	//Prepare space for the ifreq struct
//	bl	sysIoctl	//Call the Ioctl system call

	//Set the network's family to PF_INET
	ldr	r0, =STRUCT+4	//Load the family part of the struct
	movs	r1, #PF_INET	//Prepare to write PF_INET to family
	strh	r1, [r0]	//Write PF_INET to family 

	//Set the network's port
	adds	r0, r0, #2	//Load the port part of the struct
	strh	r5, [r0]	//Store the port number in the struct

	//Set the network's ip address
	adds	r0, r0, #2	//Load the address part of the struct
	str	r4, [r0]	//Write the ip address

	//Bind the server to the returned address and the given port
	movs	r0, r8		//Get the socket
	ldr	r1, =STRUCT+4	//Get the sockaddr part of the struct
	movs	r2, #ADDRLEN	//Give the length of the address
	bl	sysBind		//Call the Bind system call

	//Tell the server to listen for incoming connections
	movs	r0, r8		//Get the socket
	movs	r1, r6		//Get the backlog
	bl	sysListen	//Call the Listen system call

	movs	r0, r8			//Return the socket file descriptor
	pop	{r4, r5, r6, r7, pc}	//Return

/* sockfd[r0] connect(sockfd socket[r0], int ip[r1], short port[r2]) */
/* Connects the socket to the given address and port. */
/* Returns a negative error number on failure */
/* Data Races: STRUCT is read and written to */
.thumb_func
.global	connect
.type	connect, %function
connect:
	push	{r4, lr}	//Save return point for later

	//Save the socket for later
	movs	r4, r0

	//Reverse the byte order of the ip and port (because memory structure)
	rev	r1, r1		//Reverse ip's byte order
	revsh	r2, r2		//Reverse port's byte order

	//Set the network's family to PF_INET
	ldr	r0, =STRUCT+4	//Load the family part of the struct
	movs	r3, #PF_INET	//Prepare to write PF_INET to family
	strh	r3, [r0]	//Write PF_INET to family 

	//Set the network's port
	adds	r0, r0, #2	//Load the port part of the struct
	strh	r2, [r0]	//Store the port number in the struct

	//Set the network's ip address
	adds	r0, r0, #2	//Load the address part of the struct
	str	r1, [r0]	//Write the ip address

	//Use the connect system call
	movs	r0, r4		//Get the socket
	ldr	r1, =STRUCT+4	//Get the sockaddr part of the struct
	movs	r2, #ADDRLEN	//Give the length of the address
	bl	sysConnect	//Use the connect system call

	pop	{r4, pc}	//Return

/* sockaddr* [r0] createAddress() */
/* Allocates memory for and returns the pointer to an address */
/* Data Races: Allocates memory space */
/* TODO: Allocate memory for the address! */
.thumb_func
.type	createAddress, %function
createAddress:
	push	{lr}
	pop	{pc}

/* sockfd[r0], sockaddr*[r1] acceptClient(sockfd server[r0]) */
/* The server will accept any client that is waiting to connect to the server.*/
/* If a client connects then acceptClient will return its socket and ip */
/* address; it will return EAGAIN if no clients connected or a negative */
/* error number if an error occurred. */
/* Data Races: No memory is accessed */
/* TODO: Allocate memory for the address using createAddress! */
.thumb_func
.global	acceptClient
.type	acceptClient, %function
acceptClient:
	ldr	r1, =STRUCT	//Get the address
	ldr	r2, =ADDRLENMEM	//Give the length of the address
	push	{lr}		//Save return point for later

	bl	sysAccept	//Use the accept system call
	ldr	r1, =STRUCT	//Return the address

	pop	{pc}		//Return

/* int[r0] closeSocket(sockfd socket[r0]) */
/* Closes the given socket and returns zero if successful */
/* Data Races: No memory is accessed */
.thumb_func
.global	closeSocket
.type	closeSocket, %function
closeSocket:
	b	sysClose

/* int[r0] shutdownSocket(int sockfd[r0], int how) */
/* Shuts down all instances of sockfd and returns zero if successful */
/* Use this if you want to stop it on all threads or interrupt the connection */
/* between that socket and all of its clients without discarding the data */
/* previously recieved from them. */
/* If how is SHUT_RD, socket output is blocked */
/* If how is SHUT_WR, socket input is blocked */
/* If how is SHUT_RDWR, socket input and output are blocked */
/* Note: Shutting down the socket does not close it, you'll still need */
/*       to call closeSocket when you're done using it */
/* Data Races: All instances of sockfd are shut down */
.thumb_func
.global	shutdownSocket
.type	shutdownSocket, %function
shutdownSocket:
	b	sysShutdown

/* sockfd[r0], sockaddr*[r1] waitForClient(sockfd server[r0], int timeout[r1])*/
/* The server will wait for timeout number of microseconds until a client */
/* connects to the server. If a client connects then waitForClient will return*/
/* its socket and ip address; it will return EAGAIN if no clients connected */
/* or a negative error number if an error occurred. */
/* If timeout is equal to zero then the server will not wait for a client. */
/* If timeout is negative then server will wait indefinitely for a client. */
/* Data Races: The data POLL and TIMEVAL are read and written to */
.thumb_func
.global	waitForClient
.type	waitForClient, %function
waitForClient:
	push	{r4, r5, r6, lr}//Save return point for later

	//Save the arguments for later use
	movs	r5, r0		//Server socket
	movs	r6, r1		//timeout (in microseconds)

	//If the value is not negative then set up a timeout
	bpl	.LTimeout
	movs	r4, #0		//Otherwise, make no timeout
	b	.LSkipTimeout	//Skip the timeout setup
.LTimeout:
	ldr	r4, =TIMEVAL	//Get the timeval struct
	movs	r1, #0		//Prepare to...
	str	r1, [r4]	//Store 0 into the seconds area
	adds	r0, r4, #4	//Increment to the microseconds
	str	r6, [r0]	//Write the microseconds
.LSkipTimeout:
	ldr	r1, =POLL	//Set up the poll
	str	r5, [r1]	//Store the server's socket in the poll
	movs	r2, #0		//Don't watch for writing in the server
	movs	r3, #0		//Don't watch for exceptions in the server
	movs	r0, #1		//Watch for only 1 element (the server)
	bl	sysSelect	//Use the select system call

	mov	r1, #0		//Set the socket address to null for now
	adds	r0, r0, #0	//Test the return value
	beq	.LWaitSetZero	//If it's zero then return EAGAIN
	bmi	.LWaitReturn	//If it's an error then return it

	//Accept the incoming connection
	bl	acceptClient	//Get the client
	b	.LWaitReturn	//Return the client and its address
.LWaitSetZero:
	mov	r0, #-EAGAIN	//Return EAGAIN
.LWaitReturn:
	pop	{r4, r5, r6, pc}//Return
	
/* int sendBuffer(int sockfd[r0], char* buf[r1], int len[r2]) */
/* Sends the buffer to the socket sockfd and returns the number of bytes sent */
/* Data Races: The memory buf is read */
.thumb_func
.global	sendBuffer
.type	sendBuffer, %function
sendBuffer:
	//Use the send syscall
	mov	r3, #MSG_NOSIGNAL //Don't create an exception if the pipe broke
	b	sysSend

/* int receiveBuffer(int sockfd[r0], char* buf[r1], int len[r2]) */
/* Sends the buffer to the socket sockfd and returns the number of bytes sent */
/* Data Races: The memory buf is written to */
.thumb_func
.global	receiveBuffer
.type	receiveBuffer, %function
receiveBuffer:
	//Use the receive syscall
	mov	r3, #MSG_NOSIGNAL //Don't create an exception if the pipe broke
	b	sysRecv

/* int sendMessage(int sockfd[r0], char* buf[r1]) */
/* Sends the buffer to the socket sockfd and returns the number of bytes sent */
/* Data Races: The memory buf is read */
.thumb_func
.global	sendMessage
.type	sendMessage, %function
sendMessage:
	push	{lr}		//Save return point for later

	//Use the send syscall
	bl	len		//Determine the length of the array
	mov	r3, #0		//No flags for now
	bl	sysSend

	pop	{pc}		//Return
