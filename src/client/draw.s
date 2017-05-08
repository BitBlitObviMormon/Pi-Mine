/* Draw.s */

.include "lib/macrolib/macrolib.inc"

.text
.thumb
.syntax	unified

/* void draw(char* buf[r1]) */
/* Draws the painted buffer buf onto the screen */
/* Data Races: The buffer buf is read */
.thumb_func
.global	draw
.type	draw, %function
draw:
	push	{r1, lr}	// Save return point for later

	// Save the cursor
	bl	saveCursor

	// Set the cursor to home
	bl	homeCursor

	// Get buffer and print it
	pop	{r1}
	bl	prints

	// Load the cursor
	bl	loadCursor

	pop	{pc}		// Return
