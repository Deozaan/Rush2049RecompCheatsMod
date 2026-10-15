// Hotwire 2049: cheat menu unlocker for San Francisco Rush 2049: Recompiled.
#include "rush2049_api.h"

// From syms/rush2049.us.datasyms.toml.
extern u16 cheat_state[11];        // 0x8011648C: per-cheat flags (0x0101 == on)
extern s8  gCheatActive[23];       // 0x8011C878: per-cheat "active" flags
extern s16 gCheatState[23];        // 0x8011C890: per-cheat state
extern s8  start_valid_option[10]; // 0x8012A780: which start-menu items are shown (index 6 = CHEAT)

#define CHEAT_COUNT 11
#define CHEAT_ON 0x0101
#define CHEAT_FLAG_COUNT 23
#define START_OPTION_CHEAT 6

static void apply_cheat_state(void) {
    for (int i = 0; i < CHEAT_COUNT; i++) {
        cheat_state[i] = CHEAT_ON;
    }
    for (int i = 0; i < CHEAT_FLAG_COUNT; i++) {
        gCheatActive[i] = 1;
        gCheatState[i]  = 1;
    }
    start_valid_option[START_OPTION_CHEAT] = 1;
}

// Re-applied every frame: the game rebuilds its menu/cheat state during screen
// init, so a one-shot write is not enough.
RECOMP_HOOK("sched_on_retrace")
void cheat_menu_on_retrace(void) {
    apply_cheat_state();
}
