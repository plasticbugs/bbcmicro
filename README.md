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
| SN76489A @ 4 MHz | BeebFpga's `sn76489` | — (nothing has been listened to) |
| Intel 8271 + disc | `rtl/i8271.sv` | issues and answers exactly the command sequence MAME's DFS sends over a whole Exile boot, at the disc's own 64 µs a byte |
| RAM, MOS, sideways ROMs, font | block RAM, filled by the loader | image byte-identical to MAME's regions (`tools/verify_rom.py`) |
| on-screen keyboard | `rtl/bbc_osk.sv` | every panel pixel matches the generator, and a press sends the right matrix position (`sim/run_osk.sh`) |

## Status

**It has never run on a Pocket.** Everything below is simulation.

What is proven, and by what:

- **Exile loads from the disc image and runs**: SHIFT+BREAK reaches the title
  page, SPACE walks the intro pages, and the game's own F0–F7 menu comes up in
  a bitmap mode (`artifacts/play/`, `sim/run_boot.sh`)
- the machine boots to `BBC Computer 32K / Acorn DFS / BASIC / >` in MODE 7,
  at 50.00 Hz with 640×256 of active picture
- Exile's title page compared with MAME's render of the same page: 89.19% of
  the pixels lit in either agree, at the peak of the alignment sweep, and the
  disagreements are one-dot stroke edges from sampling 12 teletext dots at 16
- typing through the key matrix works: `MODE 1` typed on the pad's key events
  switches the machine to MODE 1 and redraws the prompt
- the ROM image the core is fed is byte-identical to the regions MAME loads
  (`tools/verify_rom.py`)
- the disc controller is asked for, and answers, the same command sequence
  MAME's DFS issues over a whole Exile boot
- **the whole machine on the Pocket's own memory glue** — real
  `bbcmicro_mem`, real SDRAM controller, behavioural chip, both images pushed
  in at the loader's rate — draws a frame identical to the fast bench's, all
  163,840 pixels (`sim/run_pocket.sh`)
- every byte of a disc image survives the download FIFO and comes back through
  the controller's port (`sim/run_mem.sh`)
- the on-screen keyboard draws pixel-for-pixel what its generator drew

What is **not** proven:

- no sound has been listened to or measured
- the game has been reached but not played: no frame of Exile's own
  gameplay has been compared with MAME
- the teletext path is about three characters later than the bitmap path and
  one later than the hardware's; the display window is placed to hide it
  (docs/core-design.md section 6) and the latency itself is untouched
- the core has never been fitted, timed or flashed

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
sim/run_boot.sh -ms 1200 -snap 1100 -dumpram /tmp/ram.bin
                               # boot the machine and capture a frame
sim/run_boot.sh -ms 4000 -disc ../game.ssd -links 0x10 -break 1700
                               # with a disc, and BREAK to boot it
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
