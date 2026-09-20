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
| HD6845S CRTC | Mike Stirling's `mc6845` | 50.00 Hz, 640×256 of active picture, MODE 7 and MODE 1 seen |
| Video ULA | Mike Stirling's `vidproc` | — (no frame has been compared with MAME pixel for pixel yet) |
| SAA5050 teletext | Mike Stirling's `saa5050` + `rtl/bbc_charrom.sv` | the boot screen reads correctly; font from the user's own romset |
| SN76489A @ 4 MHz | BeebFpga's `sn76489` | — (nothing has been listened to) |
| Intel 8271 + disc | `rtl/i8271.sv` | issues and answers exactly the command sequence MAME's DFS sends, traced side by side |
| RAM, MOS, sideways ROMs, font | block RAM, filled by the loader | image byte-identical to MAME's regions (`tools/verify_rom.py`) |
| on-screen keyboard | `rtl/bbc_osk.sv` | every panel pixel matches the generator, and a press sends the right matrix position (`sim/run_osk.sh`) |

## Status

**It has never run on a Pocket.** Everything below is simulation.

What is proven, and by what:

- the machine boots to `BBC Computer 32K / Acorn DFS / BASIC / >` in MODE 7,
  at 50.00 Hz with 640×256 of active picture (`sim/run_boot.sh`)
- typing through the key matrix works: `MODE 1` typed on the pad's key events
  switches the machine to MODE 1 and redraws the prompt
- the ROM image the core is fed is byte-identical to the regions MAME loads
  (`tools/verify_rom.py`)
- the disc controller is asked for, and answers, the same command sequence
  MAME's DFS issues over a whole Exile boot, and hands back the disc's own
  catalogue bytes
- the on-screen keyboard draws pixel-for-pixel what its generator drew

What is **not** proven:

- no frame has been compared with MAME pixel for pixel
- no sound has been listened to or measured
- the Exile disc has not yet reached the game's own screen
- everything between the core's ports and the Pocket's pins — the SDRAM
  controller, the download path, the video hand-over — is untested in this
  core: `sim/run_mem.sh` has not been rewritten for this machine's memory
  map, and `sim/run_pocket.sh` does not exist yet
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
