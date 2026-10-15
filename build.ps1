# Builds build/mod.elf with the vendored MSYS2 clang64 toolchain (see tools/README.md).
# Extra arguments are passed through to make, e.g. `./build.ps1 clean`.
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$MakeArgs
)
$ErrorActionPreference = "Stop"

function ConvertTo-UnixPath([string]$path) {
    $p = $path -replace '\\', '/'
    if ($p.Length -ge 3 -and $p[1] -eq ':') {
        return "/" + $p.Substring(0, 1).ToLower() + $p.Substring(2)
    }
    return $p
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$msys = Join-Path $root "tools\msys64"
$bash = Join-Path $msys "usr\bin\bash.exe"

if (-not (Test-Path $bash)) {
    throw "MSYS2 toolchain not found at $msys. See tools/README.md for setup."
}

$clang    = ConvertTo-UnixPath (Join-Path $msys "clang64\bin\clang.exe")
$lld      = ConvertTo-UnixPath (Join-Path $msys "clang64\bin\ld.lld.exe")
$unixroot = ConvertTo-UnixPath $root

$env:MSYSTEM = "CLANG64"
$make = "make MIPS_CC='$clang' MIPS_LD='$lld' " + ($MakeArgs -join ' ')
& $bash -lc "cd '$unixroot' && $make"
exit $LASTEXITCODE
