# Makefile for AArch64 Assembly Project with Debug Support

# Tools
AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld

# Files
SRC     = hello.s
OBJ     = hello.o
BIN     = hello

# Debug flags
ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

.PHONY: all clean run help

# Default target: build and run
all: $(BIN) run

# Assemble: .s -> .o
$(OBJ): $(SRC)
	$(AS) $(DEBUGFLGS) -o $@ $<

# Link: .o -> executable
$(BIN): $(OBJ)
	$(LD) -o $@ $<

# Run the program
run: $(BIN)
	./$(BIN)

# Remove build artifacts
clean:
	rm -f $(OBJ) $(BIN)

# Show available commands
help:
	@echo "Available make commands:"
	@echo "  make            - Build and run the project (default)"
	@echo "  make all        - Build and run the project"
	@echo "  make DEBUG=1    - Build with debug symbols (-g)"
	@echo "  make run        - Run the program"
	@echo "  make clean      - Remove build artifacts"
	@echo "  make help       -
