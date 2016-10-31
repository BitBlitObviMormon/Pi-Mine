import sys
for x in xrange(0, 256):
	for y in xrange(0, 256):
		sys.stdout.write(chr(27) + "[38;5;" + str(x) + "m" + chr(27) + "[48;5;" + str(y) + "m" + chr(0xe2) + chr(0x97) + chr(0xaf)),
		if (y % 64) == 63:
			print chr(27) + "[38;5;7m" + chr(27) + "[48;5;0m"
print 
