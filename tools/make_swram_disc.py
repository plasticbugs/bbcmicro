#!/usr/bin/env python3
"""Build a DFS disc that answers the sideways-RAM question by itself.

    tools/make_swram_disc.py [out.ssd]

Typing the test on the Pocket's on-screen keyboard is 124 keystrokes.  This
puts the same program -- character for character the one checked against MAME
in artifacts/swram/ -- in a `!BOOT` file with boot option 3 (*EXEC), so with
"Auto-boot disc" on, BREAK runs it and the machine prints the answer.

The program cannot be BASIC alone: BASIC lives in socket 3, so the byte after
a write to ROMSEL would be fetched from whichever socket was just selected.
It assembles a routine into BASIC's own heap, runs it with interrupts off, and
restores ROMSEL from &F4 -- the copy of it the MOS keeps -- before returning.

DFS catalogue, for what the byte-laying below is doing (`ref/mame` has the
controller; the format is Acorn's):

  sector 0   8 bytes of title, then 31 entries of 7-character name + dir char
  sector 1   4 more title bytes, cycle number, entries x 8, boot option and
             the sector count, then 31 entries of load/exec/length/start with
             their top bits packed into byte 6
"""
import sys

SECTOR = 256
SECTORS = 800                      # 80 tracks x 10, a single-sided 200K disc

# Each line is handed to BASIC as if typed.  ?&70 is the byte the routine read
# back out of &8000; &5A is what it wrote there.  A socket with no RAM and no
# ROM in it reads &FF.
BOOT = (
    "*BASIC\r"
    "DIM C% 50:P%=C%:[OPT 2:SEI:LDA #1:STA &FE30:LDA #&5A:STA &8000:"
    "LDA &8000:STA &70:LDA &F4:STA &FE30:CLI:RTS:]:CALL C%\r"
    'P.\'"&8000 READS &";~?&70\r'
    'IF ?&70=&5A THEN P."SIDEWAYS RAM: ON" ELSE P."SIDEWAYS RAM: OFF"\r'
)


def entry(name, directory, load, exec_, length, start):
    """One catalogue entry, split across the two sectors as DFS splits it."""
    assert len(name) <= 7, name
    n = name.ljust(7).encode('ascii') + directory.encode('ascii')
    top = ((load >> 16) & 3) | (((length >> 16) & 3) << 4) \
        | (((exec_ >> 16) & 3) << 2) | (((start >> 8) & 3) << 6)
    a = bytes([load & 0xFF, (load >> 8) & 0xFF,
               exec_ & 0xFF, (exec_ >> 8) & 0xFF,
               length & 0xFF, (length >> 8) & 0xFF,
               top, start & 0xFF])
    return n, a


def main(argv):
    out = argv[1] if len(argv) > 1 else 'artifacts/swram/swramtest.ssd'
    boot = BOOT.encode('ascii')
    files = [entry('!BOOT', '$', 0x0000, 0x0000, len(boot), 2)]

    s0 = bytearray(SECTOR)
    s1 = bytearray(SECTOR)
    title = 'SWRAMTEST'.ljust(12)
    s0[0:8] = title[:8].encode('ascii')
    s1[0:4] = title[8:12].encode('ascii')
    s1[4] = 0                                  # cycle number, BCD
    s1[5] = len(files) * 8
    s1[6] = ((3 & 3) << 4) | ((SECTORS >> 8) & 3)   # boot option 3 = *EXEC
    s1[7] = SECTORS & 0xFF
    for i, (n, a) in enumerate(files):
        s0[8 + i * 8:16 + i * 8] = n
        s1[8 + i * 8:16 + i * 8] = a

    img = bytearray(SECTOR * SECTORS)
    img[0:SECTOR] = s0
    img[SECTOR:SECTOR * 2] = s1
    img[SECTOR * 2:SECTOR * 2 + len(boot)] = boot
    open(out, 'wb').write(img)
    print('wrote %s (%d bytes), !BOOT is %d bytes:' % (out, len(img), len(boot)))
    for line in BOOT.split('\r'):
        if line:
            print('    %s' % line)
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
