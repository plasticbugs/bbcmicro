#!/bin/sh
# Run MAME on the BBC Micro model B, headless and deterministic.
#
# The MAME machine is `bbcb` -- an OS 1.20 Model B with 32K, the Acorn 8271
# disc controller and DNFS 1.20 in sideways slot 0, which is exactly the
# machine this core implements.  The romset is the user's own `bbcb.zip`,
# which is expected in the repository root and is never committed.
#
# Always pass -seconds_to_run: a Lua script that ends the run with
# machine:exit() has proved unreliable, while -seconds_to_run plus an
# add_machine_stop_notifier that writes the results is repeatable to the frame.
#
# Nothing here may touch the display.  `-video none` stops MAME rendering to a
# window but does NOT stop it creating one, and MAME's own defaults are
# fullscreen (window 0, maximize 1) -- which on macOS makes the desktop jump
# to another Space every time a probe runs, several times a minute.  Three
# measures, because they fail independently: SDL_VIDEODRIVER=dummy keeps SDL
# from opening the display at all (it is read before MAME parses anything),
# -videodriver dummy says the same through MAME, and -window -nomaximize
# means that if a window is created regardless it is a small one that steals
# no Space.  Verified: snapshots come out byte-identical to a normal run.
#
# -snapview native is what makes a snapshot comparable with the core's output:
# without it MAME renders the bbc layout, which adds the cassette-motor and
# lock LEDs below the picture.
#
#   tools/mame.sh [mame options...]
#   DISC=path/to/game.ssd tools/mame.sh ...   also mounts drive 0
root=$(cd "$(dirname "$0")/.." && pwd)
MAME_SYS=${MAME_SYS:-bbcb}
set -- -rompath "$root;$root/.mame/roms" \
    -video none -videodriver dummy -window -nomaximize \
    -sound none -nothrottle -skip_gameinfo -natural \
    -snapview native \
    -cfg_directory "$root/.mame/cfg" \
    -nvram_directory "$root/.mame/nvram" \
    -snapshot_directory "$root/.mame/snap" \
    "$@"
[ -n "$DISC" ] && set -- -flop1 "$DISC" "$@"
mkdir -p "$root/.mame/cfg" "$root/.mame/nvram" "$root/.mame/snap"
SDL_VIDEODRIVER=dummy exec mame "$MAME_SYS" "$@"
