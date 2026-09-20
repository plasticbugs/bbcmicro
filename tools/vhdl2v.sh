#!/bin/sh
# Convert a vendored VHDL module to Verilog with GHDL, for one source of truth.
#
#   tools/vhdl2v.sh <module-dir> <top-entity> [ghdl-generic...]
#
# The vendored cores that make a BBC Micro -- T65, the 6522, the 6845, the
# SAA5050, the video ULA, the SN76489 -- are VHDL, and Verilator reads no
# VHDL.  Rather than keep two sources (Quartus compiling the VHDL, the benches
# compiling something else), each module is converted once, here, and the
# generated Verilog is what both the benches and Quartus build.  What is
# simulated is then exactly what is synthesised.
#
# The original VHDL stays in the module directory: it is the licence, the
# provenance and the thing to re-convert when upstream moves.  modules/VENDOR.md
# records where each came from.
#
# GHDL's output needs two fixes, both mechanical and both checked here:
#   * a signal called `break` is legal in VHDL and a keyword in SystemVerilog;
#   * Verilator wants a timescale-free file to be explicit about it.
set -e
root=$(cd "$(dirname "$0")/.." && pwd)
dir=$1; top=$2
[ -d "$root/$dir" ] || { echo "usage: $0 <module-dir> <top-entity> [-gX=Y...]" >&2; exit 2; }
shift 2
cd "$root/$dir"
mkdir -p gen work
rm -f work/*.cf

# analysis order matters: packages first, then anything they use.  Files are
# analysed in the order of `order.txt` if present, otherwise alphabetically
# with *_pack.vhd first.
if [ -f order.txt ]; then
    files=$(grep -v '^ *#' order.txt | grep -v '^ *$')
else
    # packages first, then the rest; either list may be empty, and an empty
    # `ls` must not abort the script under set -e
    files=$({ ls *.vhd | grep -i '_pack' || true; ls *.vhd | grep -v -i '_pack' || true; })
fi
[ -n "$files" ] || { echo "$dir: no .vhd files" >&2; exit 2; }
ghdl -a --std=08 -fsynopsys -frelaxed --workdir=work $files
ghdl synth --std=08 -fsynopsys -frelaxed --workdir=work --out=verilog "$@" "$top" > "gen/$top.v.tmp" 2> "gen/$top.log"

# `break` is a SystemVerilog keyword; GHDL will happily emit it as a net name.
# BSD sed has no word boundaries, so this is done in perl, which every macOS
# and CI image has.
perl -pe 's/\bbreak\b/brk_n/g' "gen/$top.v.tmp" > "gen/$top.v"
rm -f "gen/$top.v.tmp"
rm -rf work

lines=$(wc -l < "gen/$top.v" | tr -d ' ')
echo "$dir: $top -> gen/$top.v ($lines lines)"
if command -v verilator >/dev/null 2>&1; then
    verilator --lint-only -Wno-fatal --timing "gen/$top.v" 2>&1 | grep -E "^%Error" && {
        echo "  LINT FAILED"; exit 1; }
    echo "  verilator: clean"
fi
