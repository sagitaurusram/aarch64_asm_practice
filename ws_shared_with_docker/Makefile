# Makefile for AArch64 Assembly Project with .S includes + library folder

.RECIPEPREFIX := >

# Tools
AS      = aarch64-linux-gnu-as
LD      = aarch64-linux-gnu-ld
CC      = aarch64-linux-gnu-gcc   # for .S (preprocessed asm)

# Defaults (override with: make TARGET=foo LIBDIR=... INCDIR=...)
TARGET  ?= convert_file_to_upper
LIBDIR  ?= my_library
INCDIR  ?= my_includes

# Detect main source (prefer .S over .s if both exist)
SRC := $(firstword $(wildcard $(TARGET).S) $(wildcard $(TARGET).s))
OBJ := $(patsubst %.S,%.o,$(patsubst %.s,%.o,$(SRC)))
BIN := $(TARGET)

# Library sources: compile code in LIBDIR (but NOT files from INCDIR)
LIB_SRCS := $(wildcard $(LIBDIR)/*.s) $(wildcard $(LIBDIR)/*.S)
LIB_OBJS := $(LIB_SRCS:.s=.o)
LIB_OBJS := $(LIB_OBJS:.S=.o)

# Header-like includes (not compiled)
INC_HEADERS := $(wildcard $(INCDIR)/*.S) $(wildcard $(INCDIR)/*.s)

# Debug flags
ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

# Include paths
ASFLAGS   = $(DEBUGFLGS) -I $(INCDIR) -I $(LIBDIR)
CPPFLAGS  = $(DEBUGFLGS) -I $(INCDIR) -I $(LIBDIR)

.PHONY: all clean run help lib

# Default: build and run
all: $(BIN) run

# Build just library objects
lib: $(LIB_OBJS)

# Assemble raw .s -> .o (no C preprocessor)
%.o: %.s $(INC_HEADERS)
> $(AS) $(ASFLAGS) -o $@ $<

# Assemble preprocessed .S -> .o (via gcc -c)
%.o: %.S $(INC_HEADERS)
> $(CC) $(CPPFLAGS) -c -o $@ $<

# Link main + library objects
$(BIN): $(OBJ) $(LIB_OBJS)
> $(LD) -o $@ $^

# Run
run: $(BIN)
> ./$(BIN)

# Clean
clean:
> rm -f $(OBJ) $(LIB_OBJS) $(BIN)

# Help
help:
> @echo "make [TARGET=foo] [LIBDIR=my_library] [INCDIR=my_includes] [DEBUG=1]"
> @echo "  TARGET: main without extension (auto-detects .S or .s)"
> @echo "  INCDIR: folder with include-only asm (e.g., fileio.S)"
> @echo "  LIBDIR: folder with code to compile (e.g., upper.s)"
> @echo "Examples:"
> @echo "  make all DEBUG=1 TARGET=convert_file_to_upper"
> @echo "  make lib"
> @echo "  make run TARGET=convert_file_to_upper"
> @echo "  make clean"
