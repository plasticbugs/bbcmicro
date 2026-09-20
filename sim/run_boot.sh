#!/bin/sh
# Whole machine, ideal memories: boot the Beeb and capture frames.
#
#   sim/run_boot.sh [rom] [-frames N] [-snap a,b,c] [-keys "f:col,row,hold"]
#
# Fast bench.  It knows nothing about the Pocket's memory glue -- that is
# sim/run_mem.sh and, before the first flash, sim/run_pocket.sh
# (METHODOLOGY section 5.16).  What it does carry from the platform is the
# download: the image goes in at the loader's real rate, with the strobe held
# the way the APF holds it.
set -e
here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/.." && pwd)
cd "$here"
verilator --version >/dev/null 2>&1 || { echo "verilator not found" >&2; exit 2; }
mkdir -p "$root/artifacts/boot"

. "$here/waivers.sh"

verilator --cc --exe --build -j "${JOBS:-8}" -O2 \
    -Wall -Wno-DECLFILENAME -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM \
    -Wno-PINCONNECTEMPTY -Wno-TIMESCALEMOD "$WAIVERS" \
    --top-module tb_boot_top -Mdir obj_boot \
    "$root"/rtl/*.sv "$root"/modules/*/gen/*.v \
    tb_boot_top.sv tb_boot.cpp > obj_boot.log 2>&1 \
    || { tail -40 obj_boot.log; exit 1; }
exec ./obj_boot/Vtb_boot_top "$@"
