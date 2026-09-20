#!/bin/sh
# The on-screen keyboard on its own, against the panel the generator drew.
#
#   sim/run_osk.sh
#
# Runs from the repository root, because that is where the RTL's $readmemh
# path is relative to -- the same place Quartus reads it from, so the bench
# and the build load the same file.
set -e
here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/.." && pwd)
verilator --version >/dev/null 2>&1 || { echo "verilator not found" >&2; exit 2; }
cd "$here"
verilator --cc --exe --build -j "${JOBS:-8}" -O2 \
    -Wall -Wno-DECLFILENAME -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM \
    -Wno-PINCONNECTEMPTY -Wno-TIMESCALEMOD \
    --top-module bbc_osk -Mdir obj_osk \
    "$root"/rtl/bbc_osk.sv tb_osk.cpp > obj_osk.log 2>&1 \
    || { tail -30 obj_osk.log; exit 1; }
cd "$root"
exec sim/obj_osk/Vbbc_osk "$@"
