# 0.4.0

**Analogizer support, with a PS/2 keyboard.** The BBC Micro now works with
RndMnkIII's [Analogizer](https://github.com/RndMnkIII/Analogizer) adapter:
its picture on a CRT, and a keyboard or pad through SNAC. Confirmed on a
Pocket with an Analogizer and a CRT.

### What's new

- **Video out of the adapter's VGA port**: one **Analogizer** entry picks
  Off, RGBS, RGsB, YPbPr, Y/C NTSC, Y/C PAL, or "RGBS, Pocket off". The
  signal is the BBC's own 50 Hz, 15.6 kHz picture. There is no
  scandoubled (VGA-monitor) mode: the BBC's 16 MHz pixels are too fast for
  it at the adapter's clock.
- **A PS/2 keyboard types on the BBC** through SNAC ("PS/2 Keyboard", or
  with an SNES pad), mapped by position the way MAME maps it: F1-F10 are
  f0-f9, F12 is BREAK, End is COPY, Left Alt is SHIFT LOCK.
- **SNAC pads** (DB15, NES, SNES, PlayStation analog) drive the BBC's
  joystick. Choosing a pad type makes it player 1 and moves the Pocket's
  own controls to player 2, which the BBC does not read; with "PS/2
  Keyboard" alone the Pocket's controls still work.
- **H / V Position** centre the picture (64 pixels either way; 30 lines up
  to 24 down).
- The memory clock's timing moved to make room for the adapter; discs load
  and run on a Pocket with it.
- The menu is kept to 64 options: the Pocket refuses a menu with many more
  ("Error in interact" at startup).

### Before you install

**With this core the Pocket powers the cartridge slot.** Take any game
cartridge out first. Set the adapter up as its
[How to use it](https://github.com/RndMnkIII/Analogizer/wiki/How-to-use-it%3F)
page says (SNAC switch on A, 5 V into its USB-C port, the audio cable into
the Pocket's headphone socket). Settings are in the core's own menu; no
`analogizer.bin` file is needed, and with "Analogizer" off (the default)
the core plays as before.

### Installing

Unzip onto the SD card root, overwriting previous files. ROMs are not
included: build them with the included `mra_build.py` from your own MAME
romset, as the README describes.

---

**0.3.0** moves **Sideways RAM** to where software actually looks for it.

0.2.0 put 32K in banks 1 and 2 — a RAM chip in a spare socket of a bare
motherboard, which is what MAME models with `-romslot1 ram`, and which is not
a thing anybody sold. The boards people fitted (Solidisk, Watford, Aries,
Ramamp) replaced the machine's decoding and answered all sixteen banks, with
the RAM at **4-7**, and that is the only place period software looks. Holed
Out's loader says so on screen — `BBC RAM VERSION LOADING INTO BANKS 4 AND 5`
— then probes bank 4, finds the DNFS ROM that bank 4 aliases onto on a bare
Model B, and stops with `Image has not loaded` without writing a byte.

So the setting now fits a **64K board**: ROMSEL widens from two bits to four,
banks 4-7 become 64K of RAM, and banks 8-15 read `&FF` as empty sockets do. It
survives BREAK. With the setting off, ROMSEL stays two bits and the machine is
the bare Model B it always was, picture unchanged to the pixel.

**If you used 0.2.0's sideways RAM, banks 1 and 2 are no longer RAM.** Nothing
shipped could have depended on that — the whole point is that software looks
at 4-7 — but the test disc from 0.2.0 pokes bank 1 and will now report OFF.
Rebuild it with `tools/make_swram_disc.py`.

There is still no `*SRLOAD`: that is a Master command, and this is a Model B
with MOS 1.20. Software selects a bank by writing to ROMSEL at `&FE30`, and
cannot do it from BASIC, which lives in bank 3 and would fetch its next byte
from the bank it just selected — the routine has to run from main RAM with
interrupts off.

0.1.2 centres a picture narrower than the window. A game is free to tell
the CRTC to display fewer characters than its mode's full width, and until now
such a picture began at the window's left edge with all of the slack heaped on
the right — MODE 1 games sat hard left, Labyrinth among them. The window now
measures the display's width as well as its start and takes half the difference
off the start. A full-width picture is untouched.

0.1.1 corrected the ROM builder's instructions in
`Assets/bbcmicro/common/README.txt`, which named a `bbcmicro.zip` romset that
does not exist. It is MAME's **`bbcb`**.

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

The sideways RAM is checked against the software rather than against MAME,
because MAME's `bbcb` masks ROMSEL to two bits and cannot present banks 4-7 at
all. Twenty-three unit checks cover the banks: 4-7 read back what is written
and stay independent, 0-3 still answer from the ROM image, 8-15 read `&FF`,
and with the board out nothing above bank 3 is reachable. The boot banner is
unchanged with the board fitted, so the MOS's sixteen-bank reset scan rejects
the empty banks on its copyright check rather than trying to enter one.

With the sideways RAM switched off the picture is byte-identical to the build
from before the feature existed — 0 of 163,840 pixels differ on the boot frame.

On hardware: a line drawn across the full width of the screen reaches both
edges with none of it missing, three consecutive frames of a still picture are
identical, Exile and Chuckie Egg load from disc and play, and the sideways-RAM
test disc reports the RAM present with the setting on — and Holed Out, which
wants banks 4 and 5, loads and plays.

Timing closes with no negative slack on any check at either corner.

## What is not

One piece of third-party sideways-RAM software has been run against it, Holed
Out, and it works on hardware. The Exile disc's own `ExileSR` does not start
in MAME either, so it is not a check on anything.

No frame of a game's own gameplay has been compared with MAME — the screens
compared are teletext ones — and no game's sound has been compared, only a
single BASIC note. `README.md` has the full list.
