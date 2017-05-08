/* Threading Library (Thumb) */
/* Depends on System Call and Memory Libraries */

.include "threadconst.inc"	// Include thread flags and info

// FLAGS
.set	CLONE_FLAGS,	(CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_PARENT | CLONE_THREAD | CLONE_IO)
.set	WAIT_FLAGS,	0 //(WNOHANG | WUNTRACED)

// OTHER CONSTANTS
.set	STDOUT,	   0x1	  // The standard output stream
.set	STRLEN,	   12	  // How many characters to print
.set	STACKSIZE, 0x4000 // The size of the child thread's stack (16KB)

.text
.thumb
.syntax	unified
.align 2


/* int p_id[r0], void* stackMem[r1] createThread(void* funcPtr[r0], */
/*						  int stackSize[r1]) */
/* Creates a thumb thread starting on the given function and returns */
/* its process id and stack pointer. */
.thumb_func
.global createThread
.type	createThread, %function
createThread:
	push	{r0-r1, r4-r5, r7, lr}	// Save variables for later

	// Use our own malloc to allocate memory
	bl	malloc

	// Prepare the thread's stack (see below as to why)
	// Note that the thread's stack will start
	// assuming it is {r7, lr} (at sysClone)
	pop	{r2-r3}		// Get the stored arguments back
	add	r0, r3
	sub	r0, #12		// STACKSIZE is top, we need to be down a bit
	mov	r1, r0		// Stack pointer
	add	r1, #4		// push {???, funcPtr}
	add	r0, r2, #1	// Put new PC on bottom of stack
	str	r0, [r1]
	sub	r1, #4		// Return sp to its normal position

	// Prepare to create a new thread by passing the arguments for clone()
	movw	r0, #:lower16:CLONE_FLAGS
	movt	r0, #:upper16:CLONE_FLAGS
	mov	r2, #0		// Parent process id
	mov	r3, #0		// Child process id
	mov	r4, #0		// Not sure what this does, it's ignored.
	bl	sysClone

	pop	{r4-r5, r7, pc}

/* int[r0] getCurrentThread() */
/* Gets the process id of the current thread */
.thumb_func
.global	getCurrentThread
.type	getCurrentThread, %function
getCurrentThread:
	b	sysGetPID

/* void join(int p_id[r0]) */
/* Makes the current thread wait for the given thread to finish execution */
/* TODO: join does not recognize other threads as joinable... */
/*       Fix either join or clone... somebody's responsible! */
.thumb_func
.global	join
.type	join, %function
join:
	mov	r1, #0		// Status address (Use none)
	mov	r2, #WAIT_FLAGS	// Options
	mov	r3, #0		// Resource Usage address (Use none)
	b	sysWait4

/* void nanosleep(int& seconds[r0], int& nanoseconds[r1]) */
/* Makes the current thread sleep for the time given or until interrupted. */
/* Stores the time left over in the arguments */
.thumb_func
.global	nanosleep
.type	nanosleep, %function
nanosleep:
	// Store the variables on the stack for reading / writing
	push	{r0, r1, lr}
	mov	r0, sp	// Keep the stack pointer for writing memory
	mov	r1, sp	// Keep the stack pointer for reading memory

	// Make a nanosleep system call
	bl	sysNanosleep

	// Pop the returned variables from the stack
	pop	{r0, r1, pc}

