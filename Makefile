LIB = lib
BIN = bin
SRC = src

all:
	# Build the libraries
	cd $(LIB)/iolibt; make; cd ../..
	cd $(LIB)/gamelibt; make; cd ../..
	cd $(LIB)/armmem; make; cd ../..

	# Build the source code
	ls
clean:
	# Clean the libraries
	cd $(LIB)/iolibt; make clean; cd ../..
	cd $(LIB)/gamelibt; make clean; cd ../..
	cd $(LIB)/armmem; make clean; cd ../..

	# Clean the compiled code
	rm *.out *.o *~ *#
	cd $(BIN); rm *.out *.o *~ *#; cd ..
