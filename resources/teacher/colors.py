print chr(27) + "[7m"

for i in xrange(0, 16):
	print chr(27) + "[38;5;" + str(i) + "m" + "{:>2}".format(i),
	if i == 7:
		print

print
print
for i in xrange(16, 0xE8):
	print chr(27) + "[38;5;" + str(i) + "m"+ "{:>3}".format(i),
	if ((i - 16) % 6) == 5:
		print
print
for i in xrange(0xE8, 256):
	print chr(27) + "[38;5;" + str(i) + "m" + str(i),
	if i % 8 == 7:
		print

print chr(27) + "[0m"
