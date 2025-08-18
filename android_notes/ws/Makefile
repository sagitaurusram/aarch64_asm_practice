NDK     := /Users/srimad01/Library/Android/sdk/ndk/27.0.12077973
API     := 26
TRIPLE  := aarch64-linux-android$(API)
HOST_TAG:= darwin-x86_64

# Option 1: compose safely
CLANG   := $(NDK)/toolchains/llvm/prebuilt/$(HOST_TAG)/bin/$(TRIPLE)-clang

# Option 2: hardcode the full path (bulletproof)
# CLANG := /Users/srimad01/Library/Android/sdk/ndk/27.0.12077973/toolchains/llvm/prebuilt/darwin-x86_64/bin/aarch64-linux-android26-clang

ASFLAGS := -fPIE
LDFLAGS := -pie -nostdlib -Wl,-e,_start

hello-asm: HelloWorld.o
	"$(CLANG)" $(LDFLAGS) -o $@ $^
	"$(NDK)"/toolchains/llvm/prebuilt/$(HOST_TAG)/bin/llvm-strip -s $@

HelloWorld.o: HelloWorld.s
	"$(CLANG)" $(ASFLAGS) -c $< -o $@
