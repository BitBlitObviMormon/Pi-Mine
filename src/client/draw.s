/*******************************
* Paint stream format: FBS
* F - Foreground color (byte)
* B - Background color (byte)
* S - Shape (byte)
********************************
* Shapes
********************************
* 0x00-0x00: ASCII 0x20-0x7e
* 0x5f: 
* 0x60: 
* 0x61: 
* 0x62: 
* 0x63: 
********************************/

.text

/* void paint(struct pstream*[r0], char*[r1]) */
/* Generates a character array from the paint stream. */
/* Paint does not check if the array will be big enough, assume that paint */
/* will need at least 30 bytes of space per character in the paint stream */
/* Data Races: paint reads the paint stream and writes to the character array */
.thumb
.global	paint
.type	paint, %function%
paint:	
	
