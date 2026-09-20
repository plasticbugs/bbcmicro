#!/usr/bin/env python3
"""Check the .rom image the .mra builds against MAME's own loaded regions.

MAME is the oracle for the ROM path too: tools/dump_regions.lua writes out the
bytes MAME hands to each chip, and this compares them with the corresponding
slice of the image.  A mismatch here means the core would be fed different
bytes than the machine expects, which is the cheapest possible bug to find and
the most expensive to find later.

    REGION_DIR=.mame/regions tools/mame.sh -autoboot_script tools/dump_regions.lua \\
        -seconds_to_run 3
    python3 tools/mra_build.py bbcmicro.mra bbcb.zip bbcmicro.rom
    tools/verify_rom.py bbcmicro.rom .mame/regions

The image is not interleaved -- the 6502 is an 8-bit CPU and every region is
a flat byte array -- so each check is a plain slice comparison.
"""
import sys
import zlib

# must match bbcmicro.mra, target/pocket/bbcmicro_mem.sv and sim/tb_mem.cpp
PAGED_BASE, PAGED_LEN = 0x00000, 0x10000   # 4 sideways sockets of 16K
MOS_BASE, MOS_LEN = 0x10000, 0x04000       # the OS
FONT_BASE, FONT_LEN = 0x14000, 0x003C0     # SAA5050 chargen, 96 x 10
IMAGE_LEN = 0x14400                        # font padded to 1K

# MAME keeps the character generator in a 0x500 region with the 960-byte dump
# at 0x140, so that the device can index it as character_code * 10.
CHARGEN_OFFSET = 0x140

FONTS = {
    0x201490f3: "SAA5050, MAME's verified dump (datasheet listing and decap)",
    0x6298fc0b: "SAA5050, the variant dump common in merged romsets",
}


def fail(msg):
    print(f"FAIL: {msg}")
    sys.exit(1)


def compare(name, image, base, length, region, roffset=0):
    if len(region) < roffset + length:
        fail(f"{name}: MAME's region is {len(region)} bytes, need "
             f"{roffset + length}")
    want = region[roffset:roffset + length]
    got = image[base:base + length]
    if got != want:
        i = next(k for k in range(length) if got[k] != want[k])
        fail(f"{name} differs at image 0x{base + i:05x} (region 0x{roffset+i:05x}): "
             f"image {got[i]:02x}, MAME {want[i]:02x}")
    print(f"  {name:<22} {length:6d} bytes  identical to MAME")


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    image = open(sys.argv[1], "rb").read()
    d = sys.argv[2].rstrip("/")
    rom = open(f"{d}/rom.bin", "rb").read()
    mos = open(f"{d}/mos.bin", "rb").read()
    chargen = open(f"{d}/chargen.bin", "rb").read()

    if len(image) != IMAGE_LEN:
        fail(f"image is {len(image)} bytes, expected {IMAGE_LEN}")

    # The four sideways sockets a Model B decodes.  MAME's "rom" region is 16
    # sockets wide; the 8271 board inserts DFS into the lowest free one, which
    # is socket 0, and BASIC is linked into socket 3.
    compare("sideways sockets 0-3", image, PAGED_BASE, PAGED_LEN, rom)
    for slot in range(4):
        blob = image[slot * 0x4000:(slot + 1) * 0x4000]
        crc = zlib.crc32(blob) & 0xffffffff
        what = "empty (FF)" if blob.count(0xFF) == len(blob) else f"crc {crc:08x}"
        print(f"      socket {slot}: {what}")

    compare("MOS", image, MOS_BASE, MOS_LEN, mos)
    compare("SAA5050 chargen", image, FONT_BASE, FONT_LEN, chargen,
            CHARGEN_OFFSET)

    font_crc = zlib.crc32(image[FONT_BASE:FONT_BASE + FONT_LEN]) & 0xffffffff
    print(f"      font crc {font_crc:08x}: "
          f"{FONTS.get(font_crc, 'UNKNOWN dump -- teletext may not match a real machine')}")

    pad = image[FONT_BASE + FONT_LEN:IMAGE_LEN]
    if pad.count(0xFF) != len(pad):
        fail("the padding after the font is not all FF")

    print("OK: the image carries exactly the bytes MAME loads")


if __name__ == "__main__":
    main()
