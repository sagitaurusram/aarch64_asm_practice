# Makefile for AArch64 Assembly Project with Debug Support

.RECIPEPREFIX := >

# Tools
AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld

# Default target name (can be overridden)
TARGET  ?= hello
SRC     = $(TARGET).s
OBJ     = $(TARGET).o
BIN     = $(TARGET)

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
> $(AS) $(DEBUGFLGS) -o $@ $<

# Link: .o -> executable
$(BIN): $(OBJ)
> $(LD) -o $@ $<

# Run the program
run: $(BIN)
> ./$(BIN)

# Remove build artifacts
clean:
> rm -f *.o $(BIN)

# Show available commands
help:
> @echo "Available make commands:"
> @echo "  make [TARGET=foo]      - Build and run foo.s (default TARGET=hello)"
> @echo "  make all TARGET=foo    - Build and run foo.s"
> @echo "  make DEBUG=1 ...       - Build with debug symbols (-g)"
> @echo "  make run TARGET=foo    - Run the program"
> @echo "  make clean             - Remove build artifacts"
> @echo "  make help              - Show this help"

misc:
> @echo "Miscellaneous commands:" make all DEBUG=1 TARGET=hello"
