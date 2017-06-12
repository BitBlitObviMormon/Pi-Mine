.global	_start
_start:
	// Start with a 1 and a 2
	mov	r0, #1
//	mov	r2, #2
	mov	r2, #0	// For -2 instead
	sub	r2, #2

	// Do some math with bytes
	sadd8	r0, r0, r2

	// Convert the bytes to shorts
	sxtb	r0, r0
	sxtb	r2, r2

	// Do some more math with shorts
	sadd16	r0, r0, r2

	// Convert the shorts to ints
	sxth	r0, r0
	sxth	r2, r2

	// Do some more math with ints
	add	r0, r0, r2

	// Convert the ints to longs
	mov	r1, r0
	mov	r0, #0
	cmp	r1, r0
	sublt	r0, r0, #1	// Subtract by 1 if number is negative
	mov	r3, r2
	mov	r2, #0
	cmp	r3, r2
	sublt	r2, r2, #1	// Subtract by 1 if number is negative

	// Do some more math with longs
	add	r1, r1, r3
	adc	r0, r0, r2

	// Exit with error code 9 (Or -7 if adding -2)
	mov	r0, r1
	mov	r7, #1
	svc	#0
