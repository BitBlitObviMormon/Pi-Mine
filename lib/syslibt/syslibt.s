/* System Call Library (Thumb) */
.include "sysconst.s"

.text
.syntax	unified
.thumb_func

/* void sysExit(int[r0]) */
/* Exits with the error code given */
/* Data Races: sysExit closes the calling process */
.thumb_func
.global	sysExit
.type	sysExit, %function
sysExit:
	movs	r7, #EXIT	// Exit with
	svc	#0		// 	whatever is in r0

/* ssize_t[r0] sysRead(uint fd[r0], char* buf[r1], size_t count[r2]) */
/* Uses the system call to read from a buffer */
/* Data Races: The string buf is written to */
.thumb_func
.global	sysRead
.type	sysRead, %function
sysRead:
	push	{r7, lr}	// Save return point for later
	movs	r7, #READ	// Prepare to invoke read system call
	svc	#0		// Invoke read system call
	pop	{r7, pc}	// Return
	
/* ssize_t[r0] sysWrite(uint fd[r0], const char* buf[r1], size_t count[r2]) */
/* Uses the system call to write to a buffer */
/* Data Races: The string buf is read from */
.thumb_func
.global	sysWrite
.type	sysWrite, %function
sysWrite:
	push	{r7, lr}	// Save return point for later
	movs	r7, #WRITE	// Prepare to invoke write system call
	svc	#0		// Invoke write system call
	pop	{r7, pc}	// Return

/* int[r0] sysOpen(const char* pathname[r0], int flags[r1], mode_t mode[r2]) */
/* Uses the system call to open a file and get its file handle */
/* Data Races: The character array pathname is read */
.thumb_func
.global	sysOpen
.type	sysOpen, %function
sysOpen:	
	push	{r7, lr}	// Save return point for later
	movs	r7, #OPEN	// Prepare to invoke open system call
	svc	#0		// Invoke open system call
	pop	{r7, pc}	// Return

/* int[r0] sysClose(int fd[r0]) */
/* Uses the system call to close a file */
/* Data Races: close does not access memory */
.thumb_func
.global	sysClose
.type	sysClose, %function
sysClose:
	push	{r7, lr}	// Save return point for later
	movs	r7, #CLOSE	// Prepare to invoke close system call
	svc	#0		// Invoke close system call
	pop	{r7, pc}	// Return

/* int[r0] sysBrk(int br[r0]) */
/* Uses the system call to allocate more memory */
/* Data Races: No memory is accessed */
.thumb_func
.global	sysBrk
.type	sysBrk, %function
sysBrk:
	push	{r7, lr}	// Save return point for later
	movs	r7, #BRK	// Prepare to invoke break system call
	svc	#0		// Invoke break system call
	pop	{r7, pc}	// Return

/* int[r0] sysIoctl(int d[r0], int request[r1], ... args[r2-??]) */
/* Uses the system call to perform specific I/O Control functions */
/* Data Races: Look up the specific ioctl call you're using */
.thumb_func
.global	sysIoctl
.type	sysIoctl, %function
sysIoctl:
	push	{r7, lr}	// Save return point for later
	movs	r7, #IOCTL	// Prepare to invoke ioctl system call
	svc	#0		// Invoke ioctl system call
	pop	{r7, pc}	// Return

/* int[r0] sysSelect(int n[r0], fd_set* readfds[r1], fd_set* writefds[r2],
/*                   fd_set* exceptfds[r3], struct timeval* timeout[r4]) */
/* Uses the select system call to wait for a bunch of files to change status */
/* Data Races: The filehandle structs readfds, writefds, and exceptfds
               are read from, and the time value struct timeout is read from */
.thumb_func
.global	sysSelect
.type	sysSelect, %function
sysSelect:
	push	{r7, lr}	// Save return point for later
	movs	r7, #SELECT	// Prepare to invoke select system call
	svc	#0		// Invoke select system call
	pop	{r7, pc}	// Return

/* int[r0] sysMunMap(void* memPtr[r0], int length[r1]) */
/* Frees length bytes of memory starting at memPtr. */
/* Data Races: The given memory is freed and becomes invalid for use */
.thumb_func
.global	sysMunMap
.type	sysMunMap, %function
sysMunMap:
	push	{r7, lr}	// Save return point for later
	movs	r7, #MUNMAP	// Prepare to invoke munmap sytem call
	svc	#0		// Invoke munmap system call
	pop	{r7, pc}	// Return

/* pid_t[r0] sysWait4(pid_t[r0] upid, int* stat_addr[r1], */
/*                    int options[r2], struct rusage* ru) */
/* Uses the system call to make the calling thread join the given thread */
/* Data Races: The calling thread waits until the given thread closes */
.thumb_func
.global	sysWait4
.type	sysWait4, %function
sysWait4:
	push	{r7, lr}	// Save return point for later
	movs	r7, #WAIT4	// Prepare to invoke wait4 system call
	svc	#0		// Invoke wait4 system call
	pop	{r7, pc}	// Return

/* int[r0] sysClone(int flags[r0], void* stackPtr[r1], */
/*                  int* parent_tidPtr[r2], int tls_val[r3], */
/*                  int* child_ptr[r4]) */
/* Uses the system call to fork a new process or thread */
/* Data Races:	The passed stackPtr will be used as the stack for the new   */
/*		thread. It is the user's responsibility to not overflow,    */
/*		tamper with, or delete the stack until the thread closes.   */
.thumb_func
.global	sysClone
.type	sysClone, %function
sysClone:
	push	{r7, lr}	// Save return point for later
	movs	r7, #SELECT	// Prepare to invoke clone system call
	svc	#0		// Invoke clone system call
	pop	{r7, pc}	// Return

/* int[r0] sysNanoSleep(struct timespec* req[r0], struct timespec* rem[r1]) */
/* Uses the system call to sleep the calling thread for the given amount of */
/* seconds and nanoseconds in req. The amount of time to sleep is read in req */
/* and the remaining time is stored in rem. */
/* Data Races: req is read and rem is written to. */
.thumb_func
.global	sysNanoSleep
.type	sysNanoSleep, %function
sysNanoSleep:
	push	{r7, lr}	// Save return point for later
	movs	r7, #SELECT	// Prepare to invoke nanosleep system call
	svc	#0		// Invoke nanosleep system call
	pop	{r7, pc}	// Return
	

/* void*[r0] sysMMap2(void* start[r0], int length[r1], int prot[r2], */
/*                    int flags[r3], int fd[r4], int pageoffset[r5]) */
/* Uses the system call to map memory to a file (or simply allocate more) */
/* Data Races: The given file handle is read, written, and possibly locked */
.thumb_func
.global	sysMMap2
.type	sysMMap2, %function
sysMMap2:
	push	{r7, lr}	// Save return point for later
	movs	r7, #MMAP2	// Prepare to invoke mmap2 system call
	svc	#0		// Invoke mmap2 system call
	pop	{r7, pc}	// Return

/* int[r0] sysSocket(int domain[r0], int type[r1], int protocol[r2]) */
/* Uses the system call to create a socket */
/* Data Races: No memory is accessed */
.thumb_func
.global	sysSocket
.type	sysSocket, %function
sysSocket:
	push	{r7, lr}	// Save return point for later
	movw	r7, #SOCKET	// Prepare to invoke socket system call
	svc	#0		// Invoke socket system call
	pop	{r7, pc}	// Return
	
/* int[r0] sysBind(int sockfd[r0], struct sockaddr* my_addr[r1],
/*                 socklen_t addrlen[r2]) */
/* Uses the system call to bind an address to a socket */
/* Data Races: The socket address my_addr is written to */
.thumb_func
.global	sysBind
.type	sysBind, %function
sysBind:
	push	{r7, lr}	// Save return point for later
	movw	r7, #BIND	// Prepare to invoke bind system call
	svc	#0		// Invoke bind system call
	pop	{r7, pc}	// Return
	
/* int[r0] sysConnect(int sockfd[r0], const struct sockaddr* serv_addr[r1],
/*                    socklen_t addrlen[r2]) */
/* Uses the system call to initiate a connection on a socket */
/* Data Races: The socket address serv_addr is read from */
.thumb_func
.global	sysConnect
.type	sysConnect, %function
sysConnect:
	push	{r7, lr}	// Save return point for later
	movw	r7, #CONNECT	// Prepare to invoke connect system call
	svc	#0		// Invoke connect system call
	pop	{r7, pc}	// Return

/* int[r0] sysListen(int s[r0], int backlog[r1]) */
/* Uses the system call to make a bound socket "listen" for new connections */
/* Data Races: No memory is accessed */
.thumb_func
.global	sysListen
.type	sysListen, %function
sysListen:
	push	{r7, lr}	// Save return point for later
	movw	r7, #LISTEN	// Prepare to invoke listen system call
	svc	#0		// Invoke listen system call
	pop	{r7, pc}	// Return
	
/* int[r0] sysAccept(int s[r0], struct sockaddr* addr[r1],
/*                   socklen_t addrlen[r2]) */
/* Uses the system call to accept an incoming connection */
/* Data Races: The socket address addr is written to */
.thumb_func
.global	sysAccept
.type	sysAccept, %function
sysAccept:
	push	{r7, lr}	// Save return point for later
	movw	r7, #ACCEPT	// Prepare to invoke accept system call
	svc	#0		// Invoke accept system call
	pop	{r7, pc}	// Return

/* int[r0] sysSend(int s[r0], const void* msg[r1], int length[r2], */
/*                 int flags[r3]) */
/* Uses the system call to send a message to a connected socket */
/* Returns the number of bytes sent or -1 if an error occurred */
/* Note: The socket must be in the connected state for this to work! */
/* Data Races: No memory is accessed */
.thumb_func
.global	sysSend
.type	sysSend, %function
sysSend:
	push	{r7, lr}	// Save return point for later
	movw	r7, #SEND	// Prepare to invoke send system call
	svc	#0		// Invoke send system call
	pop	{r7, pc}	// Return
	
/* int[r0] sysRecv(int s[r0], const void* msg[r1], int length[r2], */
/*                 int flags[r3]) */
/* Uses the system call to recieve a message from connected sockets */
/* Returns the number of bytes recieved or negative if an error occurred */
/* Note: The socket must be in the connected state for this to work! */
/* Data Races: The buffer msg is written to */
.thumb_func
.global	sysRecv
.type	sysRecv, %function
sysRecv:
	push	{r7, lr}	// Save return point for later
	movw	r7, #RECV	// Prepare to invoke recieve system call
	svc	#0		// Invoke recieve system call
	pop	{r7, pc}	// Return


/* int[r0] sysShutdown(int sockfd[r0], int how[r1]) */
/* Shuts down all instances of sockfd and returns zero if successful */
/* If how is SHUT_RD, socket output is blocked */
/* If how is SHUT_WR, socket input is blocked */
/* If how is SHUT_RDWR, socket input and output are blocked */
/* Data Races: All instances of sockfd are shut down */
.thumb_func
.global	sysShutdown
.type	sysShutdown, %function
sysShutdown:
	push	{r7, lr}	// Save return point for later
	movw	r7, #SHUTDOWN	// Prepare to invoke shutdown system call
	svc	#0		// Invoke shutdown system call
	pop	{r7, pc}	// Return

