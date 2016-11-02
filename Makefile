SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a
LIB = lib
BIN = bin
SRC = src

# Library Files
IOLIBT = $(LIB)/iolibt/iolibt
GAMELIBT = $(LIB)/gamelibt/gamelibt
ARMMEM = $(LIB)/armmem/armmem
NETLIBT = $(LIB)/netlibt/netlibt

# Source Files
DRAW = /client/draw

ifeq ($(USINGSCRIPT),true)
all: mine mine-server
else
all: pre-build
endif

pre-build:
	@./color make USINGSCRIPT=true

mine: $(IOLIBT).o $(GAMELIBT).o $(NETLIBT).o $(BIN)$(DRAW).o
	ld -o $@ $+

mine-server: $(NETLIBT).o
	ld -o $@ $+

$(IOLIBT).o: $(IOLIBT).s
	cd $(LIB)/iolibt; make; cd ../..

$(GAMELIBT).o: $(GAMELIBT).s
	cd $(LIB)/gamelibt; make; cd ../..

$(ARMMEM).o: $(ARMMEM).s
	cd $(LIB)/armmem; make; cd ../..

$(NETLIBT).o: $(NETLIBT).s
	cd $(LIB)/netlibt; make; cd ../..

$(BIN)$(DRAW).o: $(SRC)$(DRAW).s
	mkdir -p $(BIN)/client
	as $(SW) -o $@ $<

ifeq ($(USINGSCRIPT),true)
clean:
	# Clean temporary files
	find . -name *~ -delete
	find . -name *# -delete

	# Clean the compiled code
	rm -rf bin
	find . -name *.out -delete
	find . -name *.o -delete
	rm -f mine mine-server
else
clean:
	@./color make clean USINGSCRIPT=true
endif
