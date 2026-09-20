#!/usr/bin/env python3
"""Turn the benches' raw RGB frame dumps into PNGs.

    tools/rgb2png.py [-w 640] [-h 256] <file.rgb> [more.rgb ...]

The benches write raw 8-bit RGB triples, width x height, because writing a PNG
from C++ would mean either a dependency or a compressor; the PNG beside it is
what gets kept and looked at (artifacts/ is a bisection tool, not a courtesy).
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio


def main(argv):
    w, h, files = 640, 256, []
    i = 1
    while i < len(argv):
        if argv[i] == "-w":
            i += 1; w = int(argv[i])
        elif argv[i] == "-h":
            i += 1; h = int(argv[i])
        else:
            files.append(argv[i])
        i += 1
    if not files:
        print(__doc__)
        return 2
    for f in files:
        d = open(f, "rb").read()
        if len(d) != w * h * 3:
            print(f"{f}: {len(d)} bytes is not {w}x{h}x3 ({w*h*3})")
            return 1
        out = os.path.splitext(f)[0] + ".png"
        pngio.write(out, w, h, bytearray(d))
        print(f"{f} -> {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
