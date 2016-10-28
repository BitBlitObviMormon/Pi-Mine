This'll take a while to compile since there is so much empty space in it,
but if you run "time ./arm.out" and "time ./vfp.out" then you'll see whether
arm memory accesses or floating point memory accesses are faster.
The neat thing about this is that you can do floating point memory accesses
while running arm code as long as the arm code does not access memory during
that time (Since the floating point processor is a separate entity).
