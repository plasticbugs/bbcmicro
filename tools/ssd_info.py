#!/usr/bin/env python3
"""Print a DFS disc image's catalogue.

    tools/ssd_info.py Disc040-ExileR.ssd

An SSD is the sectors of a single-sided DFS disc end to end, 256 bytes each,
ten to a track: sector n of track t is at (t*10 + n)*256.  The catalogue is
sectors 0 and 1 -- names in the first, load/exec/length/start in the second,
with the top bits of each packed into one byte.  Written from the DFS format
as MAME's formats/acorn_dsk.cpp reads it; no ROM or disc data is stored here.
"""
import sys

BOOT = {0: "none", 1: "*LOAD", 2: "*RUN", 3: "*EXEC"}


def catalogue(d):
    title = (d[0:8] + d[256:256 + 4]).decode("latin1").rstrip("\0 ")
    nfiles = d[256 + 5] // 8
    opt = (d[256 + 6] >> 4) & 3
    sectors = ((d[256 + 6] & 3) << 8) | d[256 + 7]
    out = [f"title {title!r}, {nfiles} files, boot option {opt} ({BOOT[opt]}), "
           f"{sectors} sectors, {len(d)} bytes"]
    for i in range(nfiles):
        o = 8 + i * 8
        name = d[o:o + 7].decode("latin1").rstrip()
        dirc = chr(d[o + 7] & 0x7f)
        locked = "L" if d[o + 7] & 0x80 else " "
        p = 256 + 8 + i * 8
        load = d[p] | d[p + 1] << 8
        exe = d[p + 2] | d[p + 3] << 8
        ln = d[p + 4] | d[p + 5] << 8
        ext = d[p + 6]
        start = ((ext & 3) << 8) | d[p + 7]
        load |= ((ext >> 2) & 3) << 16
        ln |= ((ext >> 4) & 3) << 16
        exe |= ((ext >> 6) & 3) << 16
        out.append(f"  {dirc}.{name:<7} {locked} load={load:06X} exec={exe:06X} "
                   f"len={ln:06X} start=sector {start}")
    return "\n".join(out)


def main(argv):
    if len(argv) != 2:
        print(__doc__)
        return 2
    d = open(argv[1], "rb").read()
    if len(d) < 512:
        print("not a disc image: shorter than a catalogue")
        return 1
    print(catalogue(d))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
