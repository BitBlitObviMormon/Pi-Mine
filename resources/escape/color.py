for x in xrange(0, 256):
	for y in xrange(0, 256):
		print chr(27) + "[38;5;" + "{0:0>3}".format(str(y)) + "m" + chr(27) + "[48;5;" + "{0:0>3}".format(str(x)) + "m" + " " + (format(y, 'x').zfill(2) + format(x, 'x').zfill(2)),
		if (y % 16) == 15:
			print chr(27) + "[38;5;7m" + chr(27) + "[48;5;0m"
print 
