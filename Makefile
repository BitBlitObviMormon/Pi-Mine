# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a

# Directories
LIB = lib
BIN = bin
SRC = src

# Library Files
IOLIBT = $(LIB)/iolibt/iolibt
GAMELIBT = $(LIB)/gamelibt/gamelibt
NETLIBT = $(LIB)/netlibt/netlibt
RNDLIBT = $(LIB)/rndlibt/rndlibt

# Source Files
DRAW = /client/draw
CLIENT = /client/client
SERVER = /server/server

ifeq ($(USINGSCRIPT),true)
all: mine mine-server
else
all: pre-build
endif

pre-build:
	@./color make USINGSCRIPT=true

mine: $(IOLIBT).o $(GAMELIBT).o $(NETLIBT).o $(BIN)$(DRAW).o $(BIN)$(CLIENT).o
	ld -o $@ $+

mine-server: $(NETLIBT).o $(RNDLIBT).o $(BIN)$(SERVER).o
	ld -o $@ $+

# LIBRARIES
$(IOLIBT).o: $(IOLIBT).s
	cd $(LIB)/iolibt; make; cd ../..
$(GAMELIBT).o: $(GAMELIBT).s
	cd $(LIB)/gamelibt; make; cd ../..
$(NETLIBT).o: $(NETLIBT).s
	cd $(LIB)/netlibt; make; cd ../..
$(RNDLIBT).o: $(RNDLIBT).s
	cd $(LIB)/rndlibt; make; cd ../..

# DIRECTORIES
$(BIN)/server:
	mkdir -p $(BIN)/server
$(BIN)/client:
	mkdir -p $(BIN)/client

# SOURCE CODE
$(BIN)$(DRAW).o: $(SRC)$(DRAW).s $(BIN)/client
	as $(SW) -o $@ $<
$(BIN)$(SERVER).o: $(SRC)$(SERVER).s $(BIN)/server
	as $(SW) -o $@ $<
$(BIN)$(CLIENT).o: $(SRC)$(CLIENT).s $(BIN)/client
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
