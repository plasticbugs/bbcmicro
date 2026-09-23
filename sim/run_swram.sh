#!/bin/sh
# Sideways RAM on its own: rtl/bbc_rom.sv, driven the way the core drives it.
set -e
here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/.." && pwd)
cd "$here"
verilator --version >/dev/null 2>&1 || { echo "verilator not found" >&2; exit 2; }
. "$here/waivers.sh"
verilator --cc --exe --build -j "${JOBS:-8}" -O2 \
    -Wall -Wno-DECLFILENAME -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM \
    -Wno-PINCONNECTEMPTY -Wno-TIMESCALEMOD "$WAIVERS" \
    --top-module bbc_rom -Mdir obj_swram \
    "$root"/rtl/bbc_rom.sv tb_swram.cpp > obj_swram.log 2>&1 \
    || { tail -30 obj_swram.log; exit 1; }
exec ./obj_swram/Vbbc_rom "$@"
