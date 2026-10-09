#!/bin/sh
# The PS/2 keyboard on the Analogizer's SNAC port (rtl/bbc_ps2.sv), fed byte
# by byte the way the adapter's receiver hands them over, and checked against
# a key map that does not come from bbc_ps2.sv: MAME's own host-key ports for
# this machine (ref/mame/acorn/bbc_kbd.cpp, PORT_CODE) joined to the standard
# PS/2 set 2 scancodes for those host keys.  Every key MAME maps is pressed
# and released; then the sequences a decoder gets wrong (E0, fake shifts,
# Pause, BREAK) are checked on their own.  Seconds.
set -e
here=$(cd "$(dirname "$0")" && pwd)
cd "$here"
verilator --version >/dev/null 2>&1 || { echo "verilator not found" >&2; exit 2; }
mkdir -p obj_ps2
python3 - ../ref/mame/acorn/bbc_kbd.cpp > obj_ps2/keys.svh <<'PY'
import re, sys
# MAME KEYCODE -> PS/2 set 2 (extended, code): the standard US/ISO table
SET2 = {
 'A':0x1C,'B':0x32,'C':0x21,'D':0x23,'E':0x24,'F':0x2B,'G':0x34,'H':0x33,'I':0x43,
 'J':0x3B,'K':0x42,'L':0x4B,'M':0x3A,'N':0x31,'O':0x44,'P':0x4D,'Q':0x15,'R':0x2D,
 'S':0x1B,'T':0x2C,'U':0x3C,'V':0x2A,'W':0x1D,'X':0x22,'Y':0x35,'Z':0x1A,
 '0':0x45,'1':0x16,'2':0x1E,'3':0x26,'4':0x25,'5':0x2E,'6':0x36,'7':0x3D,'8':0x3E,'9':0x46,
 'F1':0x05,'F2':0x06,'F3':0x04,'F4':0x0C,'F5':0x03,'F6':0x0B,'F7':0x83,'F8':0x0A,
 'F9':0x01,'F10':0x09,'F11':0x78,'F12':0x07,
 'ESC':0x76,'TAB':0x0D,'CAPSLOCK':0x58,'LSHIFT':0x12,'RSHIFT':0x59,'LCONTROL':0x14,
 'LALT':0x11,'SPACE':0x29,'ENTER':0x5A,'BACKSPACE':0x66,
 'MINUS':0x4E,'EQUALS':0x55,'TILDE':0x0E,'OPENBRACE':0x54,'CLOSEBRACE':0x5B,
 'BACKSLASH':0x5D,'COLON':0x4C,'QUOTE':0x52,'COMMA':0x41,'STOP':0x49,'SLASH':0x4A,
 'BACKSLASH2':0x61,
 'LEFT':0x16B,'RIGHT':0x174,'UP':0x175,'DOWN':0x172,'DEL':0x171,'END':0x169,
}
src = open(sys.argv[1]).read()
body = src[src.index('INPUT_PORTS_START(bbc_keyboard)'):]
body = body[:body.index('INPUT_PORTS_END')]
n = 0
print('task automatic map_keys();')
col = None
for line in body.splitlines():
    if 'PORT_START' in line:          # BREAK is a port of its own: checked apart
        m = re.search(r'PORT_START\("COL(\d+)"\)', line)
        col = int(m.group(1)) if m else None
        continue
    m = re.search(r'PORT_BIT\(0x([0-9a-f]+)', line)
    if not m or col is None: continue
    row = int(m.group(1), 16).bit_length() - 1
    for kc in re.findall(r'PORT_CODE\(KEYCODE_(\w+)\)', line):
        v = SET2[kc]
        print(f'    key_try(1\'b{v >> 8}, 8\'h{v & 0xFF:02X}, 4\'d{col}, 3\'d{row}, "{kc}");')
        n += 1
print('endtask')
print(f'localparam int MAPPED = {n};')
PY
verilator --binary --timing -j "${JOBS:-8}" -O2 -Wno-fatal -Wno-TIMESCALEMOD \
    --top-module tb_bbc_ps2 -Mdir obj_ps2 -Iobj_ps2 \
    ../rtl/bbc_ps2.sv tb_bbc_ps2.sv > obj_ps2.log 2>&1 \
    || { tail -40 obj_ps2.log; exit 1; }
./obj_ps2/Vtb_bbc_ps2 | tee obj_ps2/run.log
grep -q "^PASS" obj_ps2/run.log
