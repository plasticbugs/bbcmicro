**0.1.1** corrects one line that was wrong in 0.1.0: the ROM builder's
instructions in `Assets/bbcmicro/common/README.txt` named a `bbcmicro.zip`
romset, which does not exist. The romset is MAME's **`bbcb`**, as the MRA and
the README have always said. The gateware is unchanged from 0.1.0.

---

The BBC Microcomputer Model B for the Analogue Pocket: a 6502 at 2 MHz with
the 1 MHz cycle stretching, 32K, MODE 0 to 7 including teletext, the
SN76489's four channels, and an Intel 8271 disc controller reading `.ssd` and
`.dsd` images from two drives.

**No ROMs are included.** Build the image from your own MAME `bbcb` romset:

```sh
python3 mra_build.py bbcmicro.mra bbcb.zip bbcmicro.rom
```

and put `bbcmicro.rom` in `Assets/bbcmicro/common/`. The builder checks every
part's CRC32 and the finished image's md5, so a wrong or damaged romset is
reported rather than quietly built into something that half works.

## Loading a disc

Core Settings, Load Drive 0. **Auto-boot disc** makes BREAK (L + R + Start)
boot it, which is what SHIFT+BREAK does on a real machine.

A disc with no `!BOOT` file answers with `File not found`. Type `*CAT` to list
it, then `*RUN <name>` for a game or `CHAIN "<name>"` for a BASIC loader. DFS
filenames are the machine's characters and not ASCII — Chuckie Egg's is
`CH#EGG`, where the `#` is SHIFT+3.

## Controls

* **L + R + Select** — the on-screen keyboard, and dismiss it
* **L + R + Start** — BREAK
* The d-pad and A B X Y press keys; which ones is a Core Setting, with eight
  d-pad sets covering the conventions BBC games used, including CAPS and CTRL
  for left and right
* **Joystick** turns the pad into the analogue port instead, with A and B as
  the two fire buttons

On the on-screen keyboard the d-pad moves a whole key at a time, A or B
presses, and SHIFT, CTRL, CAPS LOCK and SHIFT LOCK latch so combinations can
be typed one key at a time. SHIFT swaps the panel for the legends the machine
prints on the front of each key, so the punctuation it types is on the keys.
A latched modifier is drawn amber.

## What is verified

Against MAME, which this core is written from: the ROM image is byte-identical
to the regions MAME loads; 18,831 consecutive CPU writes match over a boot;
the disc controller is asked for and answers the same command sequence MAME's
DFS issues over a whole Exile boot; Exile's MODE 7 title page agrees with
MAME's render on 89.19% of the pixels lit in either, at the peak of an
alignment sweep; a BASIC `SOUND` note is 527.423 Hz against MAME's 527.426,
with the AC RMS ratio 1.009.

On hardware: a line drawn across the full width of the screen reaches both
edges with none of it missing, three consecutive frames of a still picture are
identical, and Exile and Chuckie Egg load from disc and play.

Timing closes with no negative slack on any check at either corner.

## What is not

No frame of a game's own gameplay has been compared with MAME — the screens
compared are teletext ones — and no game's sound has been compared, only a
single BASIC note. `README.md` has the full list.
