/* Memory Library (Thumb) */
/* Depends on System and Macro Libraries */

.include "memconst.inc"
.include "../macrolib/macrolib.inc"	// For mov32

.set	PROT_ANON_FLAGS, (PROT_READ | PROT_WRITE)
.set	MAP_ANON_FLAGS,	 (MAP_SHARED | MAP_ANONYMOUS)

.text
.thumb
.syntax	unified

/* void*[r0] malloc(int length[r1]) */
/* Allocates the given length of memory */
.thumb_func
.global	malloc
.type	malloc, %function
malloc:
	push	{r4, r5, lr}		// Save return point for later

	// Allocate memory using MMAP2
	mov	r0, #0			// Address (just a hint)
	mov	r2, #PROT_ANON_FLAGS	// Read and write file protocol
	movw	r3, #MAP_ANON_FLAGS	// Use the specified MMAP flags
	mov	r4, #0			// File handle (No file)
	mov	r5, #0			// Offset
	bl	sysMMap2

	pop	{r4, r5, pc}		// Return


