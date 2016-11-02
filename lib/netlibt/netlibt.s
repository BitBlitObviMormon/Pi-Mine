/* Network Library (Thumb) */
// SYSCALLS (In octal)
.set	READ,	 0003
.set	WRITE,	 0004
.set	SELECT,	 0122
.set	BIND,	 0432
.set	CONNECT, 0433
.set	LISTEN,	 0434
.set	ACCEPT,	 0435

// Some syscalls are too big for mov, so we'll do some shenanigans
.set	BASE,	  0xff
.set	BBIND,	  0x1b
.set	BCONNECT, 0x1c
.set	BLISTEN,  0x1d
.set	BACCEPT,  0x1e
	
/* ssize_t[r0] sysRead(uint fd[r0], char* buf[r1], size_t count[r2]) */
/* Uses the system call to read from a buffer */
/* Data Races: The string buf is written to */
.thumb
sysRead:
	push	{r7, lr}	//Save return point for later
	mov	r7, $READ	//Prepare to invoke read system call
	svc	#0		//Invoke read system call
	pop	{r7, pc}	//Return
	
/* ssize_t[r0] sysWrite(uint fd[r0], const char* buf[r1], size_t count[r2]) */
/* Uses the system call to write to a buffer */
/* Data Races: The string buf is read from */
.thumb
sysWrite:
	push	{r7, lr}	//Save return point for later
	mov	r7, $WRITE	//Prepare to invoke write system call
	svc	#0		//Invoke write system call
	pop	{r7, pc}	//Return

/* int[r0] sysBind(int sockfd[r0], struct sockaddr* my_addr[r1],
		socklen_t addrlen[r2]) */
/* Uses the system call to bind an address to a socket */
/* Data Races: The socket address my_addr is written to */
.thumb
sysBind:
	push	{r7, lr}	//Save return point for later
	mov	r7, $BASE
	add	r7, $BBIND	//Prepare to invoke bind system call
	svc	#0		//Invoke bind system call
	pop	{r7, pc}	//Return
	
/* int[r0] sysConnect(int sockfd[r0], const struct sockaddr* serv_addr[r1],
		socklen_t addrlen[r2]) */
/* Uses the system call to initiate a connection on a socket */
/* Data Races: The socket address serv_addr is read from */
.thumb
sysConnect:
	push	{r7, lr}	//Save return point for later
	mov	r7, $BASE
	add	r7, $BCONNECT	//Prepare to invoke connect system call
	svc	#0		//Invoke connect system call
	pop	{r7, pc}	//Return

/* int[r0] sysListen(int s[r0], int backlog[r1]) */
/* Uses the system call to make a socket "listen" for new connections */
/* Data Races: No memory is accessed */
.thumb
sysListen:
	push	{r7, lr}	//Save return point for later
	mov	r7, $BASE
	add	r7, $BLISTEN	//Prepare to invoke listen system call
	svc	#0		//Invoke listen system call
	pop	{r7, pc}	//Return
	
/* int[r0] sysAccept(int s[r0], struct sockaddr* addr[r1],
		socklen_t addrlen[r2]) */
/* Uses the system call to accept an incoming connection */
/* Data Races: The socket address addr is written to */
.thumb
sysAccept:
	push	{r7, lr}	//Save return point for later
	mov	r7, $BASE
	add	r7, $BACCEPT	//Prepare to invoke accept system call
	svc	#0		//Invoke accept system call
	pop	{r7, pc}	//Return

/* int[r0] sysSelect(int n[r0], fd_set* readfds[r1], fd_set* writefds[r2],
		fd_set* exceptfds[r3], struct timeval* timeout[r4]) */
/* Uses the select system call to wait for a bunch of files to change status */
/* Data Races: The filehandle structs readfds and exceptfds are read from,
		the time value struct timeout is read from,
		and the filehandle struct writefds is written to */
.thumb
sysSelect:
	push	{r7, lr}	//Save return point for later
	mov	r7, $SELECT	//Prepare to invoke select system call
	svc	#0		//Invoke select system call
	pop	{r7, pc}	//Return

