/* Network Library (Thumb) */
// SYSCALLS (In octal)
.set	EXIT,	 0001
.set	READ,	 0003
.set	WRITE,	 0004
.set	OPEN,	 0005
.set	CLOSE,	 0006
.set	BRK,	 0055
.set	SELECT,	 0122
.set	BIND,	 0432
.set	CONNECT, 0433
.set	LISTEN,	 0434
.set	ACCEPT,	 0435

.text

/* void sysExit(int[r0]) */
/* Exits with the error code given */
/* Data Races: sysExit closes the calling process */
.thumb
.global	sysExit
.type	sysExit, %function
sysExit:
	mov	r7, #EXIT	//Exit with
	svc	#0		//	whatever is in r0

/* ssize_t[r0] sysRead(uint fd[r0], char* buf[r1], size_t count[r2]) */
/* Uses the system call to read from a buffer */
/* Data Races: The string buf is written to */
.thumb
.global	sysRead
.type	sysRead, %function
sysRead:
	push	{r7, lr}	//Save return point for later
	mov	r7, #READ	//Prepare to invoke read system call
	svc	#0		//Invoke read system call
	pop	{r7, pc}	//Return
	
/* ssize_t[r0] sysWrite(uint fd[r0], const char* buf[r1], size_t count[r2]) */
/* Uses the system call to write to a buffer */
/* Data Races: The string buf is read from */
.thumb
.global	sysWrite
.type	sysWrite, %function
sysWrite:
	push	{r7, lr}	//Save return point for later
	mov	r7, #WRITE	//Prepare to invoke write system call
	svc	#0		//Invoke write system call
	pop	{r7, pc}	//Return

/* int[r0] sysOpen(const char* pathname[r0], int flags[r1], mode_t mode[r2]) */
/* Uses the system call to open a file and get its file handle */
/* Data Races: The character array pathname is read */
.thumb
.global	sysOpen
.type	sysOpen, %function
sysOpen:	
	push	{r7, lr}	//Save return point for later
	mov	r7, #OPEN	//Prepare to invoke open system call
	svc	#0		//Invoke open system call
	pop	{r7, pc}	//Return

/* int[r0] sysClose(int fd[r0]) */
/* Uses the system call to close a file */
/* Data Races: close does not access memory */
.thumb
.global	sysClose
.type	sysClose, %function
sysClose:
	push	{r7, lr}	//Save return point for later
	mov	r7, #CLOSE	//Prepare to invoke close system call
	svc	#0		//Invoke close system call
	pop	{r7, pc}	//Return

/* int[r0] sysBrk(int br[r0]) */
/* Uses the system call to allocate more memory */
/* Data Races: No memory is accessed */
.thumb
.global	sysBrk
.type	sysBrk, %function
sysBrk:
	push	{r7, lr}	//Save return point for later
	mov	r7, #BRK	//Prepare to invoke read system call
	svc	#0		//Invoke read system call
	pop	{r7, pc}	//Return

/* int[r0] sysBind(int sockfd[r0], struct sockaddr* my_addr[r1],
		socklen_t addrlen[r2]) */
/* Uses the system call to bind an address to a socket */
/* Data Races: The socket address my_addr is written to */
.thumb
.global	sysBind
.type	sysBind, %function
sysBind:
	push	{r7, lr}	//Save return point for later
	movw	r7, #BIND	//Prepare to invoke bind system call
	svc	#0		//Invoke bind system call
	pop	{r7, pc}	//Return
	
/* int[r0] sysConnect(int sockfd[r0], const struct sockaddr* serv_addr[r1],
		socklen_t addrlen[r2]) */
/* Uses the system call to initiate a connection on a socket */
/* Data Races: The socket address serv_addr is read from */
.thumb
.global	sysConnect
.type	sysConnect, %function
sysConnect:
	push	{r7, lr}	//Save return point for later
	movw	r7, #CONNECT	//Prepare to invoke connect system call
	svc	#0		//Invoke connect system call
	pop	{r7, pc}	//Return

/* int[r0] sysListen(int s[r0], int backlog[r1]) */
/* Uses the system call to make a socket "listen" for new connections */
/* Data Races: No memory is accessed */
.thumb
.global	sysListen
.type	sysListen, %function
sysListen:
	push	{r7, lr}	//Save return point for later
	movw	r7, #LISTEN	//Prepare to invoke listen system call
	svc	#0		//Invoke listen system call
	pop	{r7, pc}	//Return
	
/* int[r0] sysAccept(int s[r0], struct sockaddr* addr[r1],
		socklen_t addrlen[r2]) */
/* Uses the system call to accept an incoming connection */
/* Data Races: The socket address addr is written to */
.thumb
.global	sysAccept
.type	sysAccept, %function
sysAccept:
	push	{r7, lr}	//Save return point for later
	movw	r7, #ACCEPT	//Prepare to invoke accept system call
	svc	#0		//Invoke accept system call
	pop	{r7, pc}	//Return

/* int[r0] sysSelect(int n[r0], fd_set* readfds[r1], fd_set* writefds[r2],
		fd_set* exceptfds[r3], struct timeval* timeout[r4]) */
/* Uses the select system call to wait for a bunch of files to change status */
/* Data Races: The filehandle structs readfds and exceptfds are read from,
		the time value struct timeout is read from,
		and the filehandle struct writefds is written to */
.thumb
.global	sysSelect
.type	sysSelect, %function
sysSelect:
	push	{r7, lr}	//Save return point for later
	mov	r7, #SELECT	//Prepare to invoke select system call
	svc	#0		//Invoke select system call
	pop	{r7, pc}	//Return
