# Building the mod

`make` builds `build/mod.elf` (a MIPS ELF), then `RecompModTool mod.toml build` turns it into
`build/<mod_filename>.nrm`, which goes in the game's mods folder.

## Toolchain

The compiler must be clang with a MIPS backend. The official llvm.org Windows build and llvm-mingw are built
without MIPS, so this project vendors MSYS2's `clang64` clang under `tools/msys64` (git-ignored, ~1 GB).

### One-time setup

```powershell
# 1. Download and extract the MSYS2 base into tools/msys64
Invoke-WebRequest -Uri "https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe" -OutFile tools\msys2-base.sfx.exe
Start-Process tools\msys2-base.sfx.exe -ArgumentList @("-y","-o`"$PWD\tools`"") -Wait -NoNewWindow

# 2. Install clang, lld and make into the clang64 subsystem
$env:MSYSTEM = "CLANG64"
& "$PWD\tools\msys64\usr\bin\bash.exe" -lc "pacman -S --noconfirm --needed mingw-w64-clang-x86_64-clang mingw-w64-clang-x86_64-lld make"
```

MSYS2's clang is built with `LLVM_TARGETS_TO_BUILD=all`, which includes MIPS.

### Build

`build.ps1` wires the vendored toolchain up and runs make:

```powershell
./build.ps1
```

Or manually, from an MSYS2 `clang64` shell (or with `MIPS_CC`/`MIPS_LD` exported):

```sh
make MIPS_CC=".../tools/msys64/clang64/bin/clang.exe" \
     MIPS_LD=".../tools/msys64/clang64/bin/ld.lld.exe"
```

## Packaging

```
RecompModTool mod.toml build
```

`RecompModTool` is built from the N64Recomp repo. Copy `build/<mod_filename>.nrm` into the game's `mods` folder.

## Notes

- The link step intentionally leaves `cheat_state` and `pad_array` undefined; `RecompModTool` resolves them from
  `data_reference_syms_files`.
- `ld.lld` needs `-m elf32btsmip` so it runs in ELF mode instead of COFF. The Makefile passes it.
