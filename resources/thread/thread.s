//  SYSTEM CALLS
.set	EXIT,	   0x01	  // Exit system call
.set	CLONE,	   0x78	  // Clone system call
.set	NANOSLEEP, 0xa2   // Nanosleep system call
.set	MUNMAP,    0x5b   // Memory Unmap system call
.set	MMAP2,	   0xc0   // Memory Map 2 system call
.set	WRITE,	   0x04	  // Write system call

// CLONE FLAGS
.set	CLONE_VM,	0x100
.set	CLONE_FS,	0x200
.set	CLONE_FILES,	0x400
.set	CLONE_SIGHAND,	0x800
.set	CLONE_PARENT,	0x8000
.set	CLONE_THREAD,	0x10000
.set	CLONE_IO,	0x80000000
.set	CLONE_FLAGS,	(CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_PARENT | CLONE_THREAD | CLONE_IO)

// MEMORY MAP FLAGS
.set	PROT_READ,	0x1	// Reading privileges
.set	PROT_WRITE,	0x2	// Writing privileges
.set	PROT_FLAGS,	(PROT_READ | PROT_WRITE)
.set	MAP_SHARED,	0x1	// Shared between processes
.set	MAP_PRIVATE,	0x2	// Not shared between processes
.set	MAP_ANONYMOUS,	0x20	// Not mapped to a file (memory only)
.set	MAP_GROWSDOWN,	0x100	// For stacks (like this one)
.set	MAP_FLAGS,	(MAP_SHARED | MAP_ANONYMOUS)

// OTHER CONSTANTS
.set	STDOUT,	   0x1	  // The standard output stream
.set	STRLEN,	   12	  // How many characters to print
.set	STACKSIZE, 0x4000 // The size of the child thread's stack (16KB)

// SHARED DATA AND STRINGS
.data
.align	2
SHAREDDATA: // Also used as a semaphore to exit main thread when > '9'
	.ascii	"0"
TEXT1:
	.ascii	"Thread 1: "
DATA1:
	.ascii	"0\n" // Edit memory to change number for TEXT1
TEXT2:
	.ascii	"Thread 2: "
DATA2:
	.ascii	"0\n" // Edit memory to change number for TEXT2
// Makes the main thread sleep for a quarter of a second
SLEEP1:
	.word	0	  // seconds
	.word	250000000 // nano seconds
// Makes the second thread sleep for a fifth of a second
SLEEP2:
	.word	0	  // seconds
	.word	200000000 // nano seconds
.text
.align	2

/* void main() */
/* The main thread */
.global	main
main:
.global _start
_start:
	//  Create a new thread
	bl	createThread
	push	{r0}	// Save its memory region for later
.Loop1:
	// Print the shared data then exit the loop if it is 9 or greater
	bl	print1	// Print the shared data
.LWaitForSecondThread: // Busy wait for other thread to finish (SHAREDDATA > 9)
	ldr	r0, =SHAREDDATA
	ldrb	r0, [r0]
	cmp	r0, #'9'
	blo	.Loop1
	beq	.LWaitForSecondThread

	// Unallocate the 16KB of memory that was allocated on thread creation
	mov	r7, #MUNMAP	// MUNMAP system call
	pop	{r0}		// Address to memory region
	mov	r1, #STACKSIZE	// 16K memory
	svc	#0		// Call MUNMAP

	// Exit the program
	mov	r0, #0
	b	exit

/* void thread_main() */
/* The second thread */
.global	thread_main
thread_main:
	// Print the shared data then exit the loop if it is 9 or greater
	bl	print2	// Print the shared data
	mov	r0, #'9'
	cmp	r3, r0
	blo	thread_main

	// Exit the program
	ldr	r1, =SHAREDDATA
	mov	r0, #':' // Tell main thread to go ahead and close
	strb	r0, [r1]
	mov	r0, #0
	b	exit

/* void* stackMem[r0] createThread() */
/* Creates a thread, returning the memory used to create its stack */
.global createThread
createThread:
	push	{r4, r5, r7}	// Save variables for later

	// Allocate 16K of memory using MMAP2
	mov	r7, #MMAP2	// MMAP2 system call
	mov	r0, #0		// Address (just a hint)
	mov	r1, #STACKSIZE	// 16K memory
	mov	r2, #PROT_FLAGS	// Read and write file protocol
	movw	r3, #MAP_FLAGS	// Use the specified MMAP flags
	mov	r4, #0		// File handle (No file)
	mov	r5, #0		// Offset
	svc	#0		// Call MMAP2

	// Save memory for later
	pop	{r4, r5, r7}
	push	{r0, r4, r5, r7, lr}

	// Prepare the thread's stack (see below as to why)
	// Note that the thread's stack will start
	// assuming it is {r0, r4, r5, r7, lr}
	add	r0, #STACKSIZE
	sub	r0, #24		 // STACKSIZE is top, we need to be down a bit
	mov	r1, r0		 // Stack pointer
	add	r1, #16		 // push {???, ???, ???, ???, thread_main}
	ldr	r0, =thread_main // Put new PC on bottom of stack
	str	r0, [r1]
	sub	r1, #16		 // Return sp to its normal position

	// Prepare to create a new thread by passing the arguments for clone()
	movw	r0, #:lower16:CLONE_FLAGS
	movt	r0, #:upper16:CLONE_FLAGS
	mov	r2, #0		// Parent process id
	mov	r3, #0		// Child process id
	mov	r4, #0		// Not sure what this does, it's ignored.
	mov	r7, #CLONE	// Prepare to make clone system call
	svc	#0		// Make clone system call

	// NEW THREAD STARTS HERE
	// KNOW THAT ITS STACK NEEDS TO HAVE THESE REGISTERS INSIDE!!!
	// The function pointer needs to be where pc is supposed to be.
	pop	{r0, r4, r5, r7, pc}

/* int[r3] print1() */
/* Prints the shared data onto the screen (for main thread) */
.global	print1
print1:
	push	{r7, lr}

	// Increment the shared data and then store it in the private data
	ldr	r0, =SHAREDDATA
	ldr	r2, =DATA1
	ldrb	r3, [r0]	// Read value from address SHAREDDATA
	add	r3, #1		// Add 1 to it
	strb	r3, [r0]	// Store it in SHAREDDATA
	strb	r3, [r2]	// Store it in DATA1

	// Print the shared data
	ldr	r1, =TEXT1
	bl	print

	// Sleep for a while (We'll assume we aren't interrupted in the middle)
	// Allocate 16B of temp space to store remaining time
	push	{r0, r1}
	ldr	r0, =SLEEP1
	mov	r1, sp
	mov	r7, #NANOSLEEP
	svc	#0

	pop	{r0, r1, r7, pc}

/* void print2() */
/* Prints the shared data onto the screen (for second thread) */
.global	print2
print2:
	push	{r7, lr}

	// Load the shared data and then store it in the private data
	ldr	r0, =SHAREDDATA
	ldr	r2, =DATA2
	ldrb	r3, [r0]	// Read value from address SHAREDDATA
	strb	r3, [r2]	// Store it in DATA2

	// Print the shared data
	ldr	r1, =TEXT2
	bl	print

	// Sleep for a while (We'll assume we aren't interrupted in the middle)
	// Allocate 16B of temp space to store remaining time
	push	{r0, r1}
	ldr	r0, =SLEEP2
	mov	r1, sp
	mov	r7, #NANOSLEEP
	svc	#0

	pop	{r0, r1, r7, pc}

/* int[r3] print(char* buf[r1]) */
/* Prints the string at a specific length, always. */
.global	print
print:
	push	{r7, lr}	// Save return point for later
	mov	r0, #STDOUT	// Write to the standard output stream
	mov	r2, #STRLEN	// Write a constant number of characters
	mov	r7, #WRITE	// Prepare to invoke write system call
	svc	#0		// Invoke write system call
	pop	{r7, pc}	// Return

/* void exit(int errorcode[r0]) */
/* Exits the thread with the given error code */
.global	exit
exit:
	mov	r7, #EXIT	// Exit with
	svc	#0		// 	whatever is in r0
