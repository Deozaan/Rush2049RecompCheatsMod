# Hotwire 2049: a cheat menu unlocker mod for San Francisco Rush 2049: Recompiled

A simple mod for [San Francisco Rush 2049: Recompiled](https://github.com/amazingalek/rush-2049-recomp) that unlocks everything in the game's own cheat menu.

*San Francisco Rush 2049* hides its **Cheats** screen behind a controller combo (on the main menu, highlight
**Options** and hold `L + R + Z + C-Up + C-Right`). But that's just to see the cheat menu. The cheats themselves also require complicated button combos to unlock individually. Furthermore, these complicated button combos are not remembered between game sessions and need to be entered every time you start the game.

This mod bypasses all that, so the **Cheats** entry is always available and all cheats contained within are accessible. This mod does not actually enable any cheats by default. It just exposes the in-game cheats menu so you can adjust the cheats to your liking when you play.

## Features

- The game's **Cheats** menu is available immediately.
- Non-invasive: it only writes to the game's own menu/cheat state in RAM; it does not run its own cheat code.

## Usage

Install it and play: **Cheats** is available right away from the main menu. Configure cheats there as usual.

## Installation

1. Download `hotwire_2049.nrm` from the [Releases](https://github.com/Deozaan/Rush2049RecompCheatsMod/releases) page.
2. Run the game and open the Mods menu item from the main Recomp UI.
3. Drag and drop the `.nrm` file onto the window to install the mod.

## Building

Prerequisites: MIPS-capable `clang` and `ld.lld` (see [`tools/README.md`](tools/README.md) for how the local
toolchain was set up), plus the `RecompModTool` packager.

```
build.ps1 clean
build.ps1
tools/bin/RecompModTool.exe mod.toml build
```

This produces `build/hotwire_2049.nrm`.

## Credits

- Mod icon from [iconmonstr](https://iconmonstr.com/), used under the [iconmonstr license](https://iconmonstr.com/license/) (attribution not required).

