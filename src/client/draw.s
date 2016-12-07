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
	b	prints
