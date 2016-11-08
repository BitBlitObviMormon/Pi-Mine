/* Memory Library (Thumb) */
// SYSCALLS
.set	BRK, 45

.data
mem_end:
	.word	0
mem_break:
	.word	0

.text

/* int[r0] sysBrk(int br[r0]) */
/* Uses the system call to allocate more memory */
/* Data Races: No memory is accessed */
.thumb
sysBrk:
	push	{r7, lr}	//Save return point for later
	mov	r7, #BRK	//Prepare to invoke read system call
	svc	#0		//Invoke read system call
	pop	{r7, pc}	//Return
