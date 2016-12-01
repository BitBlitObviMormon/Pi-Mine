# Assembler switches
SW = -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv7-a -mcpu=cortex-a7

# Directories
LIB = lib
BIN = bin
SRC = src

# Library Files
IOLIBT   = $(LIB)/iolibt/iolibt
GAMELIBT = $(LIB)/gamelibt/gamelibt
NETLIBT  = $(LIB)/netlibt/netlibt
RNDLIBT  = $(LIB)/rndlibt/rndlibt
SYSLIBT  = $(LIB)/syslibt/syslibt
ERRLIBT  = $(LIB)/errlibt/errlibt
ERRNO    = $(LIB)/errlibt/errno
MEMLIBT  = $(LIB)/memlibt/memlibt

# Source Files
DRAW   = /client/draw
CLIENT = /client/client
SERVER = /server/server
PAINT  = /client/paint

ifeq ($(USINGSCRIPT),true)
all: mine mine-server
else
all: pre-build
endif

# Add color to all of the build scripts
pre-build:
	@./color make USINGSCRIPT=true

# Build the Pi-Mine client
mine: $(IOLIBT).o $(GAMELIBT).o $(NETLIBT).o $(SYSLIBT).o $(ERRLIBT).o $(BIN)$(DRAW).o $(BIN)$(CLIENT).o
	ld -o $@ $+

# Build the Pi-Mine server
mine-server: $(NETLIBT).o $(RNDLIBT).o $(SYSLIBT).o $(ERRLIBT).o $(IOLIBT).o $(BIN)$(SERVER).o
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
$(SYSLIBT).o: $(SYSLIBT).s
	cd $(LIB)/syslibt; make; cd ../..
$(MEMLIBT).o: $(MEMLIBT).s
	cd $(LIB)/memlibt; make; cd ../..
$(ERRLIBT).o: $(ERRLIBT).s
	cd $(LIB)/errlibt; make; cd ../..
$(ERRLIBT).s:
	cd $(LIB)/errlibt; make; cd ../..

# BIN DIRECTORIES
$(BIN)/server:
	mkdir -p $(BIN)/server
$(BIN)/client:
	mkdir -p $(BIN)/client

# SOURCE CODE
$(BIN)$(DRAW).o: $(SRC)$(DRAW).s $(BIN)/client
	as $(SW) -o $@ $<
$(BIN)$(PAINT).o: $(SRC)$(PAINT).s $(BIN)/client
	as $(SW) -o $@ $<
$(BIN)$(CLIENT).o: $(SRC)$(CLIENT).s $(BIN)/client
	as $(SW) -o $@ $<
$(BIN)$(SERVER).o: $(SRC)$(SERVER).s $(BIN)/server
	as $(SW) -o $@ $<

# Clean all built and backup files
ifeq ($(USINGSCRIPT),true)
clean:
	# Clean temporary files
	find . -name *~ -delete
	find . -name *# -delete

	# Clean compiled objects
	rm -rf bin
	find . -name *.out -delete
	find . -name *.o -delete
	rm -f mine mine-server

	# Clean generated code
	rm -f $(ERRLIBT).s $(ERRNO).s
else
clean:
	@./color make clean USINGSCRIPT=true
endif

# Run the client (mine)
runClient: mine
	./mine
	
# Run the server (mine-server)
runServer: mine-server
	./mine-server

# Lists all of the TODOs left in the source files
todo:
	@grep --color=yes --exclude=Makefile --exclude-dir=.git --exclude-dir=bin -Rnwi '.' -e "TODO"
