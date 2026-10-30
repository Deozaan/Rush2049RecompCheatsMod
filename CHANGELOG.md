# Changelog

## [1.1.2] - 2026-10-29

- Fix the Cheats entry not appearing on some launches. 1.1.1 wrote `cheat_state` once on the first
  retrace, which raced with the game's own boot-time initialization, so it only worked intermittently.
  The hook now checks every flag each retrace and writes back only the ones the game has changed,
  which re-asserts the unlock within a frame of any reset while normally doing no stores at all.

## [1.1.1] - 2026-10-29

- Write `cheat_state` once on the first retrace instead of every frame. This turned out to race with
  the game's boot-time initialization, so it only worked on some launches; see 1.1.2.

## [1.1.0] - 2026-10-18

- Fix Track 3 scenery disappearing along the tunnel dips under the bridges.

## [1.0.0] - 2026-10-14

- Unlocks everything in the in-game cheat menu.
