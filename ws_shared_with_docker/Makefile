# Makefile for AArch64 Assembly Project

# Tools
AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld

# Files
SRC     = hello.s
OBJ     = hello.o
BIN     = hello

.PHONY: all clean run help

# Default target: build and run
all: $(BIN) run

# Assemble: .s -> .o
$(OBJ): $(SRC)
	$(AS) -o $@ $<

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
	@echo "  make run        - Run the program"
	@echo "  make clean      - Remove build artifacts"
	@echo "  make help       - Show this help message"
