#!/usr/bin/env python3
"""Hold the core's 6502 to MAME's, one bus transaction at a time.

    tools/diff_bus.py <mame.txt> <core.txt> [-context N] [-skip N]
                      [-noalign] [-writes]

Both files are lines of `R|W AAAA DD`, in order, from the CPU's reset:
tools/bus_trace.lua writes MAME's, `sim/run_boot.sh -bus FILE` writes the
core's.  The first line that differs is printed with the transactions either
side, because that is where the two machines stopped agreeing and everything
after it is a consequence.

Two things to know before believing a mismatch (METHODOLOGY section 4):

  * MAME runs this 6502 at a flat 2 MHz and does not model the 1 MHz clock
    stretching the real board has, so the *sequence* is comparable and the
    timing is not;
  * anything the CPU polls -- a VIA timer, the vsync flag, the disc
    controller's status -- will eventually sample differently, and from there
    the traces are unrelated.  A divergence at FE4x, FE8x or FE0x is
    expected; one in the ROM or in RAM is a fault.

With -writes, only the writes are compared.  Fetch patterns differ between
any two 6502 models -- this core's T65 does not perform the dummy read after
a taken branch that MAME's does, for instance -- while the writes are what
the program actually did, so a long run of identical writes is the strongest
simple statement that the two CPUs agree.

With -align (the default), both traces start at their own fetch of the reset
vector at FFFC, because the two machines spend different numbers of cycles in
reset before it: MAME's 6502 does five dummy reads, and this core holds its
CPU in reset for 256 cycles while the memories settle.
"""
import sys


def load(path, skip, align, writes_only):
    out = []
    with open(path) as f:
        for line in f:
            p = line.split()
            if len(p) == 3 and p[0] in ("R", "W"):
                out.append((p[0], int(p[1], 16), int(p[2], 16)))
    if align:
        for i, t in enumerate(out):
            if t[0] == "R" and t[1] == 0xFFFC:
                out = out[i:]
                break
    if writes_only:
        out = [t for t in out if t[0] == "W"]
    return out[skip:]


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    context, skip, align, writes = 8, 0, True, False
    args = []
    i = 1
    while i < len(argv):
        if argv[i] == "-context":
            i += 1; context = int(argv[i])
        elif argv[i] == "-skip":
            i += 1; skip = int(argv[i])
        elif argv[i] == "-noalign":
            align = False
        elif argv[i] == "-writes":
            writes = True
        else:
            args.append(argv[i])
        i += 1

    a = load(args[0], skip, align, writes)
    b = load(args[1], skip, align, writes)
    print(f"{args[0]}: {len(a)} transactions")
    print(f"{args[1]}: {len(b)} transactions")

    n = min(len(a), len(b))
    for i in range(n):
        if a[i] != b[i]:
            lo = max(0, i - context)
            print(f"\nfirst difference at transaction {i}:\n")
            print(f"{'':>10}  {'MAME':<14}  {'core':<14}")
            for k in range(lo, min(n, i + context + 1)):
                mark = " <-- here" if k == i else ""
                ka = f"{a[k][0]} {a[k][1]:04X} {a[k][2]:02X}"
                kb = f"{b[k][0]} {b[k][1]:04X} {b[k][2]:02X}"
                print(f"{k:>10}  {ka:<14}  {kb:<14}{mark}")
            addr = a[i][1]
            if 0xFC00 <= addr < 0xFF00:
                print("\nThat address is I/O: expected once the CPU polls "
                      "something whose timing the two do not share.")
            else:
                print("\nThat address is memory, not I/O: the two CPUs "
                      "disagree, which is a fault in one of them.")
            return 1
    print(f"\nidentical for all {n} transactions")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
