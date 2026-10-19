// Hotwire 2049: cheat menu unlocker for San Francisco Rush 2049: Recompiled.
#include "rush2049_api.h"

// From syms/rush2049.us.datasyms.toml.
extern u16 cheat_state[11]; // 0x8011648C: per-cheat flags (0x0101 == on)

#define CHEAT_COUNT 11
#define CHEAT_ON 0x0101

static void apply_cheat_state(void) {
    for (int i = 0; i < CHEAT_COUNT; i++) {
        cheat_state[i] = CHEAT_ON;
    }
}

// Re-applied every frame: the game rebuilds its menu/cheat state during screen
// init, so a one-shot write is not enough.
RECOMP_HOOK("sched_on_retrace")
void cheat_menu_on_retrace(void) {
    apply_cheat_state();
}
