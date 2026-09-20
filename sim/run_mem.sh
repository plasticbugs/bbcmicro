#!/bin/sh
# Pocket memory gate: target/pocket/bbcmicro_mem.sv and the real SDRAM
# controller against a behavioural chip.  A disc image goes in through the
# download port the way the Pocket sends it, and every byte is read back
# through the disc controller's port.  Run it whenever the memory module
# changes, and before the first flash.
#
# The SRAM is not part of this core (docs/core-design.md section 2), and the
# ROMs and RAM are block RAM inside the machine, so the disc is all there is
# out here -- and it is the only thing a corrupted download could break.
#
#   sim/run_mem.sh [-gap N] [-hold N] [-quick] [-size N]
set -e
here=$(cd "$(dirname "$0")" && pwd)
cd "$here"
verilator --version >/dev/null 2>&1 || { echo "verilator not found" >&2; exit 2; }
verilator --cc --exe --build -j "${JOBS:-8}" -O2 \
    -Wall -Wno-DECLFILENAME -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM \
    -Wno-PINCONNECTEMPTY -Wno-TIMESCALEMOD \
    -Wno-BLKSEQ -Wno-MULTIDRIVEN -Wno-WIDTHTRUNC -Wno-WIDTHEXPAND -Wno-SYNCASYNCNET \
    --top-module tb_mem_top -Mdir obj_mem \
    ../target/pocket/bbcmicro_mem.sv ../target/pocket/sdram_ctrl.sv \
    sdram_model.sv tb_mem_top.sv tb_mem.cpp > obj_mem.log 2>&1 \
    || { tail -40 obj_mem.log; exit 1; }
exec ./obj_mem/Vtb_mem_top "$@"
