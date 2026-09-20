#!/usr/bin/env python3
"""Render the on-screen keyboard's panel and its key map.

The Pocket has no keyboard, and a BBC game reads one, so the core draws the
machine's keyboard over the picture and the pad presses keys on it
(rtl/bbc_osk.sv).  This writes what that module reads:

  rtl/rom/osk_panel.mif    the panel bitmap and the key map, for the block RAM
  rtl/rom/osk_panel.hex    the same, for the benches
  docs/osk_panel.png       what it looks like, to check by eye

Layout: a 16 x 6 grid of 16 x 12 cells, so 256 x 72 pixels, drawn at twice
that size on screen.  The bitmap is 1 bit per pixel, 32 bytes a row, MSB
leftmost, 2,304 bytes; the key map follows at 0x1000, one byte per grid cell
({1'b0, column[3:0], row[2:0]}), 96 bytes, so the RTL can look up what the
highlighted cell presses without a table of its own.

Every key is a position in the matrix as MAME's ports list it
(ref/mame/acorn/bbc_kbd.cpp; docs/hardware.md section 3.1).  BREAK is not in
the matrix -- it is a reset line -- and is marked 0x7F, which the RTL treats
as "pull reset" rather than "press a key".

Usage: tools/make_osk_panel.py [--preview] [--png]
"""
import os
import sys

CELLS_X, CELLS_Y = 16, 6
CELL_W, CELL_H = 16, 12
W, H = CELLS_X * CELL_W, CELLS_Y * CELL_H
MAP_BASE = 0x1000
ROM_SIZE = 0x1060

NO_KEY = 0x7E          # a cell with nothing in it
BREAK_KEY = 0x7F       # the one key that is not in the matrix

FONT = {  # 3x5, rows top-down, 3 bits each (MSB left)
    'A': "010 101 111 101 101", 'B': "110 101 110 101 110",
    'C': "011 100 100 100 011", 'D': "110 101 101 101 110",
    'E': "111 100 110 100 111", 'F': "111 100 110 100 100",
    'G': "011 100 101 101 011", 'H': "101 101 111 101 101",
    'I': "111 010 010 010 111", 'J': "001 001 001 101 010",
    'K': "101 110 100 110 101", 'L': "100 100 100 100 111",
    'M': "101 111 101 101 101", 'N': "110 101 101 101 101",
    'O': "010 101 101 101 010", 'P': "110 101 110 100 100",
    'Q': "010 101 101 110 011", 'R': "110 101 110 101 101",
    'S': "011 100 010 001 110", 'T': "111 010 010 010 010",
    'U': "101 101 101 101 111", 'V': "101 101 101 101 010",
    'W': "101 101 101 111 101", 'X': "101 101 010 101 101",
    'Y': "101 101 010 010 010", 'Z': "111 001 010 100 111",
    '0': "010 101 101 101 010", '1': "010 110 010 010 111",
    '2': "110 001 010 100 111", '3': "111 001 010 001 110",
    '4': "101 101 111 001 001", '5': "111 100 110 001 110",
    '6': "011 100 110 101 010", '7': "111 001 010 010 010",
    '8': "010 101 010 101 010", '9': "010 101 011 001 110",
    '-': "000 000 111 000 000", '=': "000 111 000 111 000",
    '[': "011 010 010 010 011", ']': "110 010 010 010 110",
    ';': "000 010 000 010 100", "'": "010 010 000 000 000",
    ',': "000 000 000 010 100", '.': "000 000 000 000 010",
    '/': "001 001 010 100 100", '\\': "100 100 010 001 001",
    '@': "010 101 111 100 011", ' ': "000 000 000 000 000",
    '^': "010 101 000 000 000", '_': "000 000 000 000 111",
    ':': "000 010 000 010 000", '*': "101 010 111 010 101",
    '<': "001 010 100 010 001", '>': "100 010 001 010 100",
    '?': "110 001 010 000 010", '!': "010 010 010 000 010",
    '"': "101 101 000 000 000", '#': "101 111 101 111 101",
    '$': "011 110 010 011 110", '%': "101 001 010 100 101",
    '&': "010 101 010 101 011", '(': "001 010 010 010 001",
    ')': "100 010 010 010 100", '+': "000 010 111 010 000",
    'UP': "010 111 010 010 010", 'DN': "010 010 010 111 010",
    'LT': "001 010 111 010 001", 'RT': "100 010 111 010 100",
}

# (label, grid row, grid column, cell span, column, row) -- the last two are
# the position in the key matrix.  The keyboard as Acorn laid it out.
LAYOUT = [
    ("ESC", 0, 0, 1, 0, 7), ("F0", 0, 1, 1, 0, 2), ("F1", 0, 2, 1, 1, 7),
    ("F2", 0, 3, 1, 2, 7), ("F3", 0, 4, 1, 3, 7), ("F4", 0, 5, 1, 4, 1),
    ("F5", 0, 6, 1, 4, 7), ("F6", 0, 7, 1, 5, 7), ("F7", 0, 8, 1, 6, 1),
    ("F8", 0, 9, 1, 6, 7), ("F9", 0, 10, 1, 7, 7),
    ("BRK", 0, 11, 2, None, None),

    ("1", 1, 0, 1, 0, 3), ("2", 1, 1, 1, 1, 3), ("3", 1, 2, 1, 1, 1),
    ("4", 1, 3, 1, 2, 1), ("5", 1, 4, 1, 3, 1), ("6", 1, 5, 1, 4, 3),
    ("7", 1, 6, 1, 4, 2), ("8", 1, 7, 1, 5, 1), ("9", 1, 8, 1, 6, 2),
    ("0", 1, 9, 1, 7, 2), ("-", 1, 10, 1, 7, 1), ("^", 1, 11, 1, 8, 1),
    ("\\", 1, 12, 1, 8, 7), ("LT", 1, 13, 1, 9, 1), ("RT", 1, 14, 1, 9, 7),

    ("TAB", 2, 0, 1, 0, 6), ("Q", 2, 1, 1, 0, 1), ("W", 2, 2, 1, 1, 2),
    ("E", 2, 3, 1, 2, 2), ("R", 2, 4, 1, 3, 3), ("T", 2, 5, 1, 3, 2),
    ("Y", 2, 6, 1, 4, 4), ("U", 2, 7, 1, 5, 3), ("I", 2, 8, 1, 5, 2),
    ("O", 2, 9, 1, 6, 3), ("P", 2, 10, 1, 7, 3), ("@", 2, 11, 1, 7, 4),
    ("[", 2, 12, 1, 8, 3), ("_", 2, 13, 1, 8, 2), ("UP", 2, 14, 1, 9, 3),
    ("DN", 2, 15, 1, 9, 2),

    ("CTL", 3, 0, 1, 1, 0), ("A", 3, 1, 1, 1, 4), ("S", 3, 2, 1, 1, 5),
    ("D", 3, 3, 1, 2, 3), ("F", 3, 4, 1, 3, 4), ("G", 3, 5, 1, 3, 5),
    ("H", 3, 6, 1, 4, 5), ("J", 3, 7, 1, 5, 4), ("K", 3, 8, 1, 6, 4),
    ("L", 3, 9, 1, 6, 5), (";", 3, 10, 1, 7, 5), (":", 3, 11, 1, 8, 4),
    ("]", 3, 12, 1, 8, 5), ("DEL", 3, 13, 1, 9, 5), ("CPY", 3, 14, 2, 9, 6),

    ("SHF", 4, 0, 1, 0, 0), ("Z", 4, 1, 1, 1, 6), ("X", 4, 2, 1, 2, 4),
    ("C", 4, 3, 1, 2, 5), ("V", 4, 4, 1, 3, 6), ("B", 4, 5, 1, 4, 6),
    ("N", 4, 6, 1, 5, 5), ("M", 4, 7, 1, 5, 6), (",", 4, 8, 1, 6, 6),
    (".", 4, 9, 1, 7, 6), ("/", 4, 10, 1, 8, 6), ("SHF", 4, 11, 1, 0, 0),
    ("RETURN", 4, 12, 4, 9, 4),

    ("CAPS", 5, 0, 3, 0, 4), ("SHLK", 5, 3, 3, 0, 5),
    ("SPACE", 5, 6, 10, 2, 6),
]


def render():
    img = [[0] * W for _ in range(H)]
    keymap = [NO_KEY] * (CELLS_X * CELLS_Y)

    def putc(ch, x, y):
        rows = FONT[ch].split()
        for r in range(5):
            for c in range(3):
                if rows[r][c] == '1' and 0 <= x + c < W and 0 <= y + r < H:
                    img[y + r][x + c] = 1

    for label, row, col, span, kc, kr in LAYOUT:
        x0, y0 = col * CELL_W, row * CELL_H
        w, h = span * CELL_W, CELL_H
        for x in range(x0, x0 + w):
            img[y0][x] = img[y0 + h - 1][x] = 1
        for y in range(y0, y0 + h):
            img[y][x0] = img[y][x0 + w - 1] = 1
        glyphs = [label] if label in FONT else list(label)
        tw = 4 * len(glyphs) - 1
        tx, ty = x0 + (w - tw) // 2, y0 + (h - 5) // 2
        for i, ch in enumerate(glyphs):
            if ch in FONT:
                putc(ch, tx + i * 4, ty)
        code = BREAK_KEY if kc is None else ((kc << 3) | kr)
        for c in range(col, col + span):
            keymap[row * CELLS_X + c] = code
    return img, keymap


def rom_bytes(img, keymap):
    data = bytearray(ROM_SIZE)
    for y in range(H):
        for xb in range(W // 8):
            b = 0
            for i in range(8):
                b = (b << 1) | img[y][xb * 8 + i]
            data[y * (W // 8) + xb] = b
    for i, k in enumerate(keymap):
        data[MAP_BASE + i] = k
    return data


def main():
    img, keymap = render()
    data = rom_bytes(img, keymap)
    root = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')
    os.makedirs(os.path.join(root, 'rtl/rom'), exist_ok=True)

    with open(os.path.join(root, 'rtl/rom/osk_panel.hex'), 'w') as f:
        f.write('\n'.join(f'{b:02x}' for b in data) + '\n')
    with open(os.path.join(root, 'rtl/rom/osk_panel.mif'), 'w') as f:
        f.write(f"DEPTH = {ROM_SIZE};\nWIDTH = 8;\nADDRESS_RADIX = HEX;\n"
                "DATA_RADIX = HEX;\nCONTENT\nBEGIN\n")
        for a, b in enumerate(data):
            f.write(f"{a:04X} : {b:02X};\n")
        f.write("END;\n")
    keys = sum(1 for _, _, _, _, kc, _ in LAYOUT if kc is not None)
    print(f"osk_panel: {W}x{H}, {len(LAYOUT)} keys ({keys} in the matrix), "
          f"{ROM_SIZE} bytes")

    if '--preview' in sys.argv:
        for y in range(H):
            print(''.join('#' if v else '.' for v in img[y]))

    if '--png' in sys.argv:
        import struct
        import zlib
        scale = 3
        fg, bg = (255, 255, 255), (24, 28, 48)
        rows = bytearray()
        for y in range(H):
            line = bytearray()
            for x in range(W):
                line += bytes(fg if img[y][x] else bg) * scale
            for _ in range(scale):
                rows += b'\x00' + line

        def chunk(tag, payload):
            return (struct.pack('>I', len(payload)) + tag + payload +
                    struct.pack('>I', zlib.crc32(tag + payload)))

        png = (b'\x89PNG\r\n\x1a\n'
               + chunk(b'IHDR', struct.pack('>IIBBBBB', W * scale, H * scale,
                                            8, 2, 0, 0, 0))
               + chunk(b'IDAT', zlib.compress(bytes(rows), 9))
               + chunk(b'IEND', b''))
        path = os.path.join(root, 'docs/osk_panel.png')
        with open(path, 'wb') as f:
            f.write(png)
        print(f"wrote {path} ({W*scale}x{H*scale})")


if __name__ == "__main__":
    main()
