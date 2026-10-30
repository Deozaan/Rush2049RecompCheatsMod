// Hotwire 2049: cheat menu unlocker for San Francisco Rush 2049: Recompiled.
#include "rush2049_api.h"

// From syms/rush2049.us.datasyms.toml.
extern u16 cheat_state[11]; // 0x8011648C: per-cheat flags (0x0101 == on)

#define CHEAT_COUNT 11
#define CHEAT_ON 0x0101

// The game initializes cheat_state during boot, and exactly when it does that relative to the first
// frame varies from launch to launch. A single write therefore races with the game's own init and
// only works some of the time, so re-check it every retrace. Only flags the game has changed are
// written back, which means the steady state does no stores at all.
RECOMP_HOOK("sched_on_retrace")
void cheat_menu_on_retrace(void) {
    for (int i = 0; i < CHEAT_COUNT; i++) {
        if (cheat_state[i] != CHEAT_ON) {
            cheat_state[i] = CHEAT_ON;
        }
    }
}
