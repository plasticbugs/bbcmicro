# BBC Micro — Analogue Pocket core (openFPGA)

The Acorn BBC Microcomputer Model B — 6502 at 2 MHz, 32K, MODE 0 to 7, the
SN76489's four channels, and a real 8271 disc controller reading `.ssd` images
— as an openFPGA core for the Analogue Pocket. The machine is written against
MAME's `bbcb` driver (`ref/mame/`), with the chips vendored from the FPGA
implementations that have been running BBC software for a decade
(`modules/VENDOR.md`).

> **ROMs are not included and never will be.** You supply your own MAME
> `bbcb` romset; `tools/mra_build.py` builds the one image the core reads, and
> checks every part's CRC on the way.

| part | implementation | verified by |
|---|---|---|
| 6502 @ 2 MHz, 1 MHz stretching | T65 (`modules/cpu-t65`) | boots the OS, runs BASIC and DFS; stretching is not yet held to a cycle count |
| 6522 VIA ×2 @ 1 MHz | MikeJ's `m6522` | the OS's keyboard, sound, timers and interrupts all work |
| HD6845S CRTC | Mike Stirling's `mc6845` | 50.00 Hz, 640×256 of active picture, MODE 7, 1 and 2 seen |
| Video ULA | Mike Stirling's `vidproc` | Exile's MODE 7 title page against MAME's render of it: 89.19% of the lit pixels agree, the rest one-dot stroke edges from sampling 12 teletext dots at 16 |
| SAA5050 teletext | Mike Stirling's `saa5050` + `rtl/bbc_charrom.sv` | same comparison; font from the user's own romset |
| SN76489A @ 4 MHz | BeebFpga's `sn76489` | a BASIC `SOUND` note against MAME's recording of the same: 527.423 Hz against 527.426, level within 1% |
| Intel 8271 + disc | `rtl/i8271.sv` | issues and answers exactly the command sequence MAME's DFS sends over a whole Exile boot, at the disc's own 64 µs a byte |
| RAM, MOS, sideways ROMs, font | block RAM, filled by the loader | image byte-identical to MAME's regions (`tools/verify_rom.py`) |
| on-screen keyboard | `rtl/bbc_osk.sv` | every panel pixel matches the generator, and a press sends the right matrix position (`sim/run_osk.sh`) |

## Status

**It runs on an Analogue Pocket.** Exile and Chuckie Egg load from disc images
and play; the keyboard types, the joystick works, sound comes out. What
follows is what has been measured and what has not.

Held against MAME, which is the oracle here:

- the ROM image the core is fed is byte-identical to the regions MAME loads
  (`tools/verify_rom.py`)
- 18,831 consecutive CPU writes are identical to MAME's over a whole boot
  (`tools/diff_bus.py -writes`)
- the disc controller is asked for, and answers, the same command sequence
  MAME's DFS issues over a whole Exile boot, at the disc's own 64 µs a byte
- Exile's MODE 7 title page against MAME's render of it: 89.19% of the pixels
  lit in either agree, at the peak of an alignment sweep, the rest being
  one-dot stroke edges from sampling 12 teletext dots at 16
- a BASIC `SOUND` note: 527.423 Hz against MAME's 527.426 — the same divider,
  4 MHz / 32 / 237, counted over a thousand cycles — with the AC RMS ratio
  1.009 and silence at exactly zero

Checked on the machine itself:

- the raster is right: `MODE0:DRAW1279,0` draws a line across the full 640
  dots and it reaches both edges with none of it missing, on hardware and in
  simulation (docs/core-design.md section 6)
- three consecutive frames of a still picture are identical — the core does
  not alternate fields, which a fixed panel would show as a shimmer and an
  OLED would hold (`tools/check_frames.py`)
- the whole machine on the Pocket's own memory glue draws a frame identical
  to the fast bench's, all 163,840 pixels (`sim/run_pocket.sh`)
- every byte of two disc images survives the download FIFO and reads back
  through the controller's port (`sim/run_mem.sh`)
- it fits and closes timing: no negative slack on any check at either corner,
  with the worst path the SDRAM capture, where the SDC says to expect it

What is **not** proven:

- no frame of a game's own *gameplay* has been compared with MAME; the screens
  compared are teletext ones
- no game's sound has been compared with MAME — one BASIC note has
- the teletext path is about three characters later than the bitmap path and
  one later than the hardware's; the display window is placed to match it
  (docs/core-design.md section 6) and the latency itself is untouched
- 1 MHz and 2 MHz character clocks use one measured pipeline figure each; a
  mode with an unusual colour depth may sit a dot from centre

## Controls

| | |
|---|---|
| **L + R + Select** | the on-screen keyboard, and dismiss it |
| **L + R + Start** | BREAK |
| d-pad, A B X Y | press keys — which ones is a Core Setting |

On the on-screen keyboard the d-pad moves a whole key at a time, A or B
presses, and SHIFT, CTRL, CAPS LOCK and SHIFT LOCK latch so combinations can
be typed one key at a time. SHIFT swaps the panel for the legends the machine
prints on the front of each key, so the punctuation it types is on the keys
rather than remembered. A latched modifier is drawn amber.

## Core Settings

| setting | what it does |
|---|---|
| Auto-boot disc | fits keyboard link 6, so BREAK boots the disc as SHIFT+BREAK does on a real machine |
| Joystick | the pad drives the analogue port instead of pressing keys; A and B are the two fire buttons |
| D-pad keys | eight sets: cursor keys, `: / Z X`, `A Z , .`, `W A S D`, and CAPS/CTRL for left and right paired with each of the three common up/down pairs |
| A / B / X / Y button key | eight keys each: SPACE, RETURN, SHIFT, ESCAPE, Z, X, `:` and `/` |
| Screen Shape | 4:3, or fill the Pocket's screen |
| Scanlines, Shadow Mask | the Pocket's own filters |

A disc that has no `!BOOT` file will answer BREAK with `File not found`. Type
`*CAT` to list it, then `*RUN <name>` for a game or `CHAIN "<name>"` for a
BASIC loader. Note that DFS filenames are the machine's characters, not
ASCII: Chuckie Egg's is `CH#EGG`, and the `#` is SHIFT+3.

## Building the ROM image

```sh
python3 tools/mra_build.py bbcmicro.mra bbcb.zip bbcmicro.rom
```

The builder needs only Python 3. It reads the MAME zip (or a directory of
loose files), checks every ROM's CRC32, and verifies the finished image
against a known md5. Copy the result to `Assets/bbcmicro/common/bbcmicro.rom`
on the SD card. Disc images (`.ssd`, `.dsd`) go in the same folder and are
loaded from **Core Settings → Drive 0 / Drive 1**.

Two notes on romsets:

- merged sets often name DNFS 1.20 `dnfs120-201666.rom`; the builder finds a
  part by CRC when the name is missing, and says which file it used
- there are two SAA5050 font dumps in circulation. They differ in five rows
  of one glyph (the teletext ¼), and either builds a working image; the
  builder names the one you used.

## Building the core

`./build-local.sh` compiles with Quartus 18.1 in Docker and leaves the SD-card
package in `release/pocket/`. `./build-local.sh map` runs analysis and
synthesis only — a couple of minutes, and it catches what Verilator cannot.

## Checking it

```sh
sim/lint.sh                    # every module on its own; seconds
sim/run_osk.sh                 # the on-screen keyboard against its generator
sim/run_mem.sh                 # every byte of two disc images, through the
                               # download FIFO at the loader's own rate
sim/run_pocket.sh -compare ../artifacts/boot
                               # the whole machine on the real memory glue,
                               # required to draw the same frame as the fast
                               # bench, pixel for pixel
sim/run_boot.sh -ms 1200 -snap 1100 -dumpram /tmp/ram.bin
                               # boot the machine and capture a frame
sim/run_boot.sh -ms 4000 -disc ../game.ssd -links 0 -break 1700
                               # with a disc, and BREAK to boot it
tools/check_frames.py artifacts/still -w 640 -h 256
                               # three consecutive frames of a still picture
                               # must be identical: a core that alternates
                               # fields marks the Pocket's OLED
tools/check_json.py pkg/pocket --active 640x256
                               # what the Pocket's firmware silently refuses
```

`tools/rgb2png.py` turns the captured frames into PNGs;
`artifacts/` is where they land, to be looked at.

The bench's trace options are how faults get localised: `-trace N
-trace_from MS` prints CPU bus cycles, `-io` narrows that to FRED, JIM and
SHEILA, and `-pc LO,HI` to one address range over a whole run.

## Credits

`CREDITS.md` is the full list. The short of it: **Marcus Andrade**
([@boogermann](https://github.com/boogermann),
[OpenGateware](https://github.com/opengateware)) wrote everything between the
machine and the Pocket; **Mike Stirling** and **David Banks**
([BeebFpga](https://github.com/hoglet67/BeebFpga)) wrote the BBC's video and
I/O chips in FPGA form; **MikeJ** wrote the 6522; the **T65** authors wrote
the 6502; **Nigel Barnes** and **Gordon Jefferyes** maintain MAME's BBC
driver, which this core is written from; and Acorn built a machine documented
well enough to rebuild forty-five years later.
