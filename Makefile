LIB = lib
BIN = bin
SRC = src

lib: FORCE
	# Build the libraries
	cd $(LIB)/iolibt; make; cd ../..
	cd $(LIB)/gamelibt; make; cd ../..
	cd $(LIB)/armmem; make; cd ../..
	cd $(LIB)/netlibt; make; cd ../..

mine-client:
	

mine-server:
	

mine:
	

clean:
	# Clean the libraries
	cd $(LIB)/iolibt; make clean; cd ../..
	cd $(LIB)/gamelibt; make clean; cd ../..
	cd $(LIB)/armmem; make clean; cd ../..
	cd $(LIB)/netlibt; make clean; cd ../..

	# Clean the compiled code
	rm *.out *.o *~ *# mine-client mine-server mine
	cd $(BIN); rm *.out *.o *~ *#; cd ..

FORCE:
