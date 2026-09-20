#!/bin/sh
# The whole machine on the real memory glue -- run this before the first
# flash, and after anything that touches target/pocket/.
#
#   sim/run_pocket.sh [-ms N] [-disc f] [-break ms] [-keys ...] [-snap a,b]
#                     [-compare DIR] [-gap N] [-hold N]
#
# sim/run_boot.sh answers the disc from an array; this one puts
# target/pocket/bbcmicro_mem.sv, the real SDRAM controller and a behavioural
# chip in the path, and pushes both images in at the loader's rate.  With
# -compare it requires the picture to be identical to the fast bench's,
# which is the only statement worth making about glue: it is transparent or
# it is not (METHODOLOGY section 5.16).
#
# With no arguments it runs the gate: boot to the prompt with the Exile disc
# in drive 0 and compare two frames with the fast bench's.
set -e
here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/.." && pwd)
cd "$here"
verilator --version >/dev/null 2>&1 || { echo "verilator not found" >&2; exit 2; }
mkdir -p "$root/artifacts/pocket"

. "$here/waivers.sh"

verilator --cc --exe --build -j "${JOBS:-8}" -O3 --x-assign fast --x-initial fast \
    -Wall -Wno-DECLFILENAME -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM \
    -Wno-PINCONNECTEMPTY -Wno-TIMESCALEMOD -Wno-MULTIDRIVEN -Wno-SYNCASYNCNET \
    -Wno-BLKSEQ -Wno-WIDTHTRUNC -Wno-WIDTHEXPAND "$WAIVERS" \
    --top-module tb_pocket_top -Mdir obj_pocket \
    "$root"/rtl/*.sv "$root"/modules/*/gen/*.v \
    "$root"/target/pocket/bbcmicro_mem.sv "$root"/target/pocket/sdram_ctrl.sv \
    sdram_model.sv tb_pocket_top.sv tb_pocket.cpp > obj_pocket.log 2>&1 \
    || { tail -40 obj_pocket.log; exit 1; }
exec ./obj_pocket/Vtb_pocket_top "$@"
