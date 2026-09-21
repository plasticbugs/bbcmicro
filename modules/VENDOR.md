# Vendored modules

Third-party HDL cores copied into the tree — no submodules, so the build is
self-contained and reproducible. Each keeps its own licence header; those
headers *are* the licence and are never trimmed or rewritten.

Every one of these is VHDL, and Verilator reads no VHDL. Rather than keep two
sources — Quartus compiling the VHDL while the benches compile something else —
each module is converted once with `tools/vhdl2v.sh` and **the generated
Verilog in `gen/` is what both the benches and Quartus build**. What is
simulated is then exactly what is synthesised. The VHDL stays beside it as the
licence, the provenance and the thing to re-convert when upstream moves:

```sh
tools/vhdl2v.sh modules/cpu-t65 T65        # and so on, per the table
```

| module | what it is | upstream | commit | licence |
|---|---|---|---|---|
| `cpu-t65` | T65: 6502/65C02/65816 CPU, in 6502 mode here | [MiSTer-devel/BBCMicro_MiSTer](https://github.com/MiSTer-devel/BBCMicro_MiSTer) `rtl/t65`, itself from Daniel Wallner's T65 by way of MikeJ and the MiSTer maintainers | `d37f7d2001c6` | see each file's header (Daniel Wallner's BSD-style terms) |
| `via-6522` | MOS 6522 VIA, two instances | [hoglet67/BeebFpga](https://github.com/hoglet67/BeebFpga) `src/common/m6522.vhd`, by MikeJ (FPGAArcade), written for the VIC-20 model | `f0c99eb72b5d` | BSD-style, in the header |
| `video-mc6845` | Hitachi HD6845S CRTC | BeebFpga `src/common/mc6845.vhd`, Mike Stirling 2011, David Banks 2022 | `f0c99eb72b5d` | BSD-style |
| `video-saa5050` | Mullard SAA5050 teletext generator | BeebFpga `src/common/saa5050.vhd`, Mike Stirling 2011 | `f0c99eb72b5d` | BSD-style |
| `video-ula` | Ferranti video ULA (`vidproc_orig`) | BeebFpga `src/common/vidproc_orig.vhd`, Mike Stirling 2011 | `f0c99eb72b5d` | BSD-style |
| `sound-sn76489` | TI SN76489A | BeebFpga `src/common/sn76489.vhd` | `f0c99eb72b5d` | see header |
| `adc-upd7002` | NEC µPD7002 ADC | BeebFpga `src/common/upd7002.vhd` | `f0c99eb72b5d` | see header |

## Modifications

Two vendored files are changed, and each change is marked `MODIFIED` in place:

- **`video-saa5050/saa5050.vhd`** — upstream instantiates
  `saa5050_rom_dual_port`, which carries the teletext font as a literal table
  in VHDL. This repository may not hold ROM data (`CLAUDE.md`), and the font
  is in the user's own romset anyway, so the two ROM ports are brought out of
  the entity (`ROM_A1/ROM_D1`, `ROM_A2/ROM_D2`) and answered by
  `rtl/bbc_charrom.sv`, which reads the font loaded from `bbcmicro.rom` and
  generates the mosaic graphics characters that upstream's table held.

  The address arithmetic and the one-clock read latency are unchanged, so the
  module sees exactly what it saw before. Measured while doing it: upstream's
  table and this romset's SAA5050 dump agree on every one of the 96×10 font
  rows except five rows of character `0x7B` (the teletext ¼), which differ by
  a one-column shift.

  The stale comment "6 MHz dot clock enable" on `CLKEN` is corrected to 12 MHz,
  which is what upstream's `bbc_micro_core.vhd` drives it at.

## Written here rather than vendored

- **Intel 8271 disc controller** (`rtl/i8271.sv`) — no open implementation
  exists; written from MAME's `i8271.cpp` device model (`ref/mame/devices/`)
  and held to DFS 1.20's actual use of it.
- **The machine itself** (`rtl/bbcmicro_core.sv`) — address decode, ROM
  paging, 1 MHz clock stretching, the addressable latch, interrupts, the
  keyboard matrix. BeebFpga's `bbc_micro_core.vhd` covers the same ground for
  a dozen machine variants; this is Model B only, in SystemVerilog, written
  from `docs/hardware.md`.
- **The teletext character generator** (`rtl/bbc_charrom.sv`), for the reason
  above.

## To update one

Re-copy from upstream at the new commit, re-run `tools/vhdl2v.sh`, and record
the new commit here. Then run every bench: the generated Verilog is the build.

- **`sound-sn76489/sn76489.vhd`** — the tone generator counted 0 to FREQ
  inclusive, a half-period of FREQ+1, which the comment above it in the file
  already warns is wrong. Every note came out one divider step flat.
  Measured against MAME on `SOUND 1,-15,100,50` typed into BASIC: MAME's tone
  was 527.426 Hz, which is 4 MHz / 32 / 237 for the divider the OS wrote, and
  this chip's was 525.211 Hz, which is 4 MHz / 32 / 238 exactly. Counting 1 to
  FREQ gives the datasheet's f = clock / (32 x N) and leaves N = 0 behaving as
  N = 1; after it, 527.423 Hz.
