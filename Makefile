# Builds build/mod.elf; then `RecompModTool mod.toml build` turns it into build/<mod_filename>.nrm.
#
# clang needs a MIPS backend. Point CC/LD at a MIPS clang toolchain, or export MIPS_CC/MIPS_LD
# (see tools/README.md for a self-contained toolchain). The Makefile only replaces make's built-in
# `cc`/`ld` defaults.
ifneq ($(origin MIPS_CC),undefined)
CC := $(MIPS_CC)
endif
ifneq ($(origin MIPS_LD),undefined)
LD := $(MIPS_LD)
endif
ifeq ($(origin CC),default)
CC := clang
endif
ifeq ($(origin LD),default)
LD := ld.lld
endif

BUILD_DIR := build
TARGET    := $(BUILD_DIR)/mod.elf

CFLAGS   := -target mips -mips2 -mabi=32 -O2 -G0 -mno-abicalls -mno-odd-spreg -mno-check-zero-division \
            -fomit-frame-pointer -ffast-math -fno-unsafe-math-optimizations -fno-builtin-memset -ffreestanding \
            -ffunction-sections -Wall -Wextra -Wno-incompatible-library-redeclaration -Wno-unused-parameter \
            -Wno-unknown-pragmas -Wno-unused-variable -Wno-missing-braces -Wno-unsupported-floating-point-opt \
            -Werror=section
CPPFLAGS := -D_LANGUAGE_C -DMIPS -I include
LDFLAGS  := -m elf32btsmip -T mod.ld -e 0 -Map $(BUILD_DIR)/mod.map --unresolved-symbols=ignore-all --emit-relocs --no-nmagic -gc-sections

C_SRCS := $(wildcard src/*.c)
C_OBJS := $(C_SRCS:src/%.c=$(BUILD_DIR)/%.o)

$(TARGET): $(C_OBJS) mod.ld
	$(LD) $(C_OBJS) $(LDFLAGS) -o $@

$(BUILD_DIR)/%.o: src/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) $< -MMD -MP -MF $(@:.o=.d) -c -o $@

$(BUILD_DIR):
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR)

-include $(C_OBJS:.o=.d)

.PHONY: clean
