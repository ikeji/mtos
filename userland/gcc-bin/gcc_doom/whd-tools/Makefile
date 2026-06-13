# userland/gcc-bin/gcc_doom/whd-tools/Makefile — host build for whd_gen.
#
# Produces build/whd_gen, a single executable that converts a Doom WAD
# into the compressed WHD format the on-device DOOM reader consumes
# (see VENDOR.md for the upstream provenance and license summary).
#
# Build: `make -C userland/gcc-bin/gcc_doom/whd-tools`
#   → userland/gcc-bin/gcc_doom/whd-tools/build/whd_gen
# Use:   `userland/gcc-bin/gcc_doom/whd-tools/build/whd_gen <wad> <whd>`
#        (exact CLI documented by whd_gen.cpp at line ~5000; we'll
#        usually wrap this in a higher-level script that trims the
#        WAD to E1M1 first.)
#
# Notes on the build:
#   - whd_gen is C++17. The vendored upstream missed a few <cstdint>
#     includes that newer GCC trips on; we force-include cstdint and
#     friends via the -include flags below rather than patching the
#     vendor source. If we ever rebase against a newer rp2040-doom,
#     drop these -include flags first and see if upstream caught up.
#   - tiny_huff.c, musx_decoder.c, image_decoder.c, and adpcm-lib.c
#     are C, not C++. We compile each with `gcc -c` and link at the
#     end so the void*/typed-pointer mismatch on `malloc()` doesn't
#     trip the C++ front-end.
#   - PICO_BUILD and PICO_ON_DEVICE stay undefined — that gates out
#     the embedded-only #include "pico.h" sections inside tiny_huff,
#     image_decoder, and doomtype.h, so we don't need a pico.h shim.
#   - IS_WHD_GEN=1 matches the upstream CMake define and selects the
#     host-only code paths inside whd_gen.cpp.

ROOT      := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
BUILD     := $(ROOT)/build
BIN       := $(BUILD)/whd_gen

CXX       ?= g++
CC        ?= gcc

INCLUDES  := -I$(ROOT)/src -I$(ROOT)/src/doom \
             -I$(ROOT)/src/whd_gen -I$(ROOT)/src/adpcm-xq
DEFINES   := -DIS_WHD_GEN=1
FORCE_INC := -include cstdint -include cstdio -include cstdlib
WARN      := -w
CXXFLAGS  := -std=c++17 -O2 $(WARN) $(DEFINES) $(INCLUDES) $(FORCE_INC)
CFLAGS    := -std=c11 -O2 $(WARN) $(DEFINES) $(INCLUDES)

CPP_SRCS  := \
    src/whd_gen/whd_gen.cpp \
    src/whd_gen/wad.cpp \
    src/whd_gen/huff.cpp \
    src/whd_gen/lodepng.cpp \
    src/whd_gen/compress_mus.cpp \
    src/whd_gen/mus2seq.cpp

C_SRCS    := \
    src/tiny_huff.c \
    src/musx_decoder.c \
    src/image_decoder.c \
    src/adpcm-xq/adpcm-lib.c

CPP_OBJS  := $(patsubst %.cpp,$(BUILD)/%.o,$(CPP_SRCS))
C_OBJS    := $(patsubst %.c,$(BUILD)/%.o,$(C_SRCS))
OBJS      := $(CPP_OBJS) $(C_OBJS)

.PHONY: all clean

all: $(BIN)

$(BIN): $(OBJS) | $(BUILD)
	$(CXX) $(OBJS) -o $@

$(BUILD)/%.o: $(ROOT)/%.cpp | $(BUILD)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/%.o: $(ROOT)/%.c | $(BUILD)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD):
	@mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
