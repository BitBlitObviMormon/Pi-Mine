/* Game Input Library (Thumb) */
// I/O CONSTANTS
.set	STDIN,  0
.set	STDOUT, 1
.set	STDERR, 2

// SYSCALLS
.set	READ, 3	
.set	WRITE, 4

/* void sysRead(uint fd, char* buf, size_t count) */
/* Uses the system call to read from a buffer */
/* Data Races: No memory is changed */
.thumb
sysRead:
	mov	r7, $READ	//Prepare to invoke read system call
	svc	#0		//Invoke read system call
	bx	lr		//Return
	
/* void sysWrite(uint fd, const char* buf, size_t count) */
/* Uses the system call to write to a buffer */
/* Data Races: No memory is changed */
.thumb
sysWrite:
	mov	r7, $WRITE	//Prepare to invoke write system call
	svc	#0		//Invoke write system call
	bx	lr		//Return
