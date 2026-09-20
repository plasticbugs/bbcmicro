#!/usr/bin/env python3
"""Compare a frame the core drew with the same frame from MAME.

    tools/compare_frame.py <mame.png> <core.rgb> [-w 1024] [-h 320]
                           [-x0 N] [-y0 N] [-out diff.png]

The two do not have the same shape, and cannot: MAME renders each mode into
its own bitmap (480x500 for MODE 7, because it draws both interlaced fields
and 12 dots per character), while the core emits one fixed raster of 16 MHz
dots and one field, with teletext sampled at 16 MHz so that a 12-dot
character occupies 16 dots and MODE 7 fills the same width as MODE 0
(docs/core-design.md section 6).

So the comparison maps MAME's picture onto the core's: column x of the core
is column round(x * mw / cw) of MAME's, and row y is MAME's row 2y + phase
for MODE 7, where phase is whichever field the core is showing.  Both phases
are tried and the better one reported, because which field a non-interlaced
render shows is not something either side chooses.

What it prints is the fraction of pixels that agree at the best alignment,
counted twice: over the whole picture, and over the pixels that are lit in
either image.  The second number is the one that means anything on a mostly
black teletext screen, where agreeing about the background is free.  A
perfect score is not expected while the sampling is 4:3 -- what is expected
is that every character is in the right place and the wrong pixels are at
the edges of strokes.

With -search, a window of alignments is tried and the best is printed, which
is how the raster's offset was found in the first place.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    cw, ch, x0, y0, out, search = 1024, 320, 0, 0, None, False
    args = []
    i = 1
    while i < len(argv):
        a = argv[i]
        if a == "-w": i += 1; cw = int(argv[i])
        elif a == "-h": i += 1; ch = int(argv[i])
        elif a == "-x0": i += 1; x0 = int(argv[i])
        elif a == "-y0": i += 1; y0 = int(argv[i])
        elif a == "-out": i += 1; out = argv[i]
        elif a == "-search": search = True
        else: args.append(a)
        i += 1

    mw, mh, mame = pngio.read(args[0])
    core = open(args[1], "rb").read()
    if len(core) != cw * ch * 3:
        print(f"{args[1]}: {len(core)} bytes is not {cw}x{ch}x3")
        return 2
    print(f"MAME {mw}x{mh}, core {cw}x{ch} (window at {x0},{y0})")

    # the core's picture is the part of its raster MAME also drew
    W = min(cw - x0, mw * 4 // 3)
    H = mh // 2

    def score(px0, py0, phase):
        same = ink_same = ink = total = 0
        worst_row, worst_bad = -1, -1
        for y in range(H):
            cy = py0 + y
            my = 2 * y + phase
            if cy >= ch or my >= mh:
                break
            bad = 0
            for x in range(W):
                mx = (x * mw) // W
                ci = (cy * cw + px0 + x) * 3
                mi = (my * mw + mx) * 3
                c = core[ci:ci + 3]
                m = mame[mi:mi + 3]
                lit = (c != b"\x00\x00\x00") or (m != b"\x00\x00\x00")
                if lit:
                    ink += 1
                if c == m:
                    same += 1
                    if lit:
                        ink_same += 1
                else:
                    bad += 1
                total += 1
            if bad > worst_bad:
                worst_bad, worst_row = bad, y
        return same, total, ink_same, ink, worst_row, worst_bad

    best = None
    xs = range(x0 - 8, x0 + 9, 2) if search else [x0]
    ys = range(y0 - 4, y0 + 5) if search else [y0]
    for px0 in xs:
        for py0 in ys:
            if px0 < 0 or py0 < 0 or px0 + W > cw:
                continue
            for phase in (0, 1):
                same, total, ink_same, ink, wr, wb = score(px0, py0, phase)
                if not ink:
                    continue
                key = ink_same / ink
                if best is None or key > best[0]:
                    best = (key, px0, py0, phase, same, total, ink_same, ink, wr, wb)

    key, px0, py0, phase, same, total, ink_same, ink, wr, wb = best
    print(f"best alignment: x0={px0} y0={py0} field phase {phase}")
    print(f"  whole picture: {same*100.0/total:.2f}% of {total} pixels agree")
    print(f"  where either is lit: {ink_same*100.0/ink:.2f}% of {ink} pixels agree")
    print(f"  worst row {wr}: {wb} of {W} pixels differ")
    x0, y0 = px0, py0

    if out:
        img = bytearray(W * H * 3)
        for y in range(H):
            for x in range(W):
                ci = ((y0 + y) * cw + x0 + x) * 3
                mi = ((2 * y + phase) * mw + (x * mw) // W) * 3
                if core[ci:ci + 3] == mame[mi:mi + 3]:
                    v = core[ci] // 3
                    img[(y * W + x) * 3:(y * W + x) * 3 + 3] = bytes((v, v, v))
                else:
                    img[(y * W + x) * 3:(y * W + x) * 3 + 3] = b"\xff\x00\x00"
        pngio.write(out, W, H, img)
        print(f"wrote {out}: red where they differ")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
