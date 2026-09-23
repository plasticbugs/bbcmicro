# The core on the Pocket

How the machine in `docs/hardware.md` maps onto the Pocket, and the budgets
that mapping has to meet. Decided on paper first; METHODOLOGY section 5.2.

## 1. Clocks

The whole BBC Micro divides one 16 MHz crystal, and 96 MHz is 6 × 16, so every
clock in the machine is an exact division of the Pocket system clock. There is
no fractional accumulator anywhere in `rtl/clk_enables.sv`.

| enable | divider of 96 MHz | frequency | drives |
|---|---|---|---|
| `cen_16m` | 6 | 16.000 MHz | the video ULA's dot clock, modes 0-6 |
| `cen_12m` | 8 | 12.000 MHz | the SAA5050's dot clock, MODE 7 |
| `cen_4m` | 24 | 4.000 MHz | SN76489A, 8271 |
| `cen_2m` | 48 | 2.000 MHz | 6502 and the CRTC when the ULA selects fast |
| `cen_1m` | 96 | 1.000 MHz | both VIAs, the CRTC when the ULA selects slow, the 1 MHz bus |

Error against the real machine: **zero**, every clock exact.

`clk_vid` is 16 MHz, 96/6 from the same PLL, so a pixel handed over to the
video clock is a whole one: `pix_sync` pins the core's dot divider to `clk_vid`
exactly as the template does (METHODOLOGY section 5.4).

Refresh rate is whatever the CRTC is programmed for, because the core's sync
outputs *are* the CRTC's, as on a real monitor. The OS's usual setups give
50.080 Hz (312 lines of 64 µs) in modes 0-6 and 50.241 Hz (311 lines) in
MODE 7; a game that reprograms the CRTC moves it, and the Pocket's scaler
relocks. Measured from MAME: MODE 7 period 19.904 ms, Exile's menu screen
19.968 ms.

## 2. Where each memory lives

| memory | size | Pocket resource | why | access pattern |
|---|---|---|---|---|
| main RAM | 32K × 8 | block RAM, dual port | the CPU and the video circuit read it in opposite phases of the 2 MHz cycle; both must be single-cycle | CPU one byte per 2 MHz cycle, video one byte per character time |
| sideways ROM sockets | 64K × 8 | block RAM | `{romsel[1:0], a[13:0]}` — one flat power-of-two RAM, nothing for a synthesiser to interpret (section 5.18) | CPU only |
| sideways RAM | 32K × 8 | block RAM | the "Sideways RAM" setting, sockets 1 and 2. A second flat RAM beside the ROM, not a writable slice of it: the ROM is loaded by the downloader and a socket has to be able to go back to being a ROM when the setting is turned off | CPU only |
| MOS ROM | 16K × 8 | block RAM | as above | CPU only |
| SAA5050 font | 1K × 8 | block RAM | read once per character time in MODE 7 | video only |
| disc images | 2 × 512K | **SDRAM** | 200K a side is far too much for block RAM | one byte per 64 µs while a transfer runs |
| — | | SRAM (128K) | **unused**: the disc does not fit in it and nothing else needs it | |

Block RAM used: 81K of ROM plus 32K of RAM plus 32K of sideways RAM plus the
font and the on-screen keyboard's panel, about 162K of the 5CEBA4's 385K. The Pocket's SRAM is left
alone, so `USE_SRAM` is 0 and the template's SRAM self-test is replaced by a
checksum of the loaded image (section 7).

This is the shape METHODOLOGY section 6 argues for: everything the CPU touches
is in block RAM and single-cycle, so there is no arbiter in the CPU's path, no
fetch latency to budget and no way for a refresh to land in the middle of an
instruction. Only the disc controller talks to SDRAM, and it wants one byte
every 64 µs.

## 3. The ROM image

`bbcmicro.rom`, 82,944 bytes, built by `tools/mra_build.py` from `bbcmicro.mra`
and proven byte-identical to MAME's regions by `tools/verify_rom.py`:

| image offset | size | region | in the core |
|---|---|---|---|
| `0x00000` | 64K | sideways sockets 0-3 (DFS, FF, FF, BASIC) | `rtl/bbc_rom.sv` paged RAM |
| `0x10000` | 16K | MOS 1.20 | `rtl/bbc_rom.sv` MOS RAM |
| `0x14000` | 1K | SAA5050 font, 960 bytes then FF | `rtl/bbc_rom.sv` font RAM |

The image arrives on data slot 0 and is written **straight into block RAM** as
it streams in: a block RAM write cannot stall, so no FIFO is needed on this
path — unlike the SDRAM path, which is what METHODOLOGY section 5.16 is about.
Each byte is still taken on the rising edge of the strobe, never its level
(section 5.8).

Disc images arrive on data slots 1 and 2, one per drive, and go to SDRAM
through the download FIFO. A `.ssd` is 200K, a `.dsd` 400K; each drive gets
512K of SDRAM so either fits with the sector arithmetic staying a shift.

| SDRAM byte address | size | what |
|---|---|---|
| `0x000000` | 512K | drive 0 image |
| `0x080000` | 512K | drive 1 image |

## 4. SDRAM clients and the arbiter

Two clients: the download (writes, cannot be told to wait, so it goes through
the 64-word FIFO) and the disc controller (reads and writes one byte at a
time, and can wait as long as it likes — the 8271 is asked for a byte every
64 µs). The download has priority; it only runs while a disc is being loaded.

There is no shared-port ack to misroute here (section 5.17) because there is
only one requester once the download is done, but the ack is still latched
with the owner for the same reason.

## 5. Budgets — measured, not assumed

| stage | budget | ideal-memory bench | real-memory bench | hardware (panel) |
|---|---|---|---|---|
| CPU cycle | 48 clocks at 96 MHz | | | |
| video fetch | one byte per 24 or 48 clocks | | | |
| disc byte | one per 6,144 clocks (64 µs) | | | |

The video fetch is the only hard deadline and it is met by construction: the
byte comes from block RAM in one clock, inside a 24-clock character time.

## 6. Video out

The core emits a fixed-geometry raster derived from the CRTC's own sync, the
way a monitor sees it: `hsync`/`vsync` follow the CRTC, and the active window
is a fixed number of dots after each sync edge. Whatever the CRTC is
programmed to do — mid-frame mode changes, palette splits per scanline,
hardware scrolling, a display window smaller than the screen — reaches the
panel unchanged, because nothing in the path depends on the mode except
where the window starts, and that is forced (below).

- **Dot rate.** 16 MHz, one output pixel per dot, 640 across the window.
- **MODE 7.** The SAA5050 runs at its real 12 MHz and the output samples it at
  16 MHz, so a teletext character 12 dots wide occupies 16 output dots and the
  40-column screen fills the same width as an 80-column one, as on a real
  machine. The cost is that one dot in three is doubled: glyph strokes come
  out 2 or 3 dots wide instead of a uniform 2. The alternative — switching the
  output to 480 active dots and letting the Pocket's scaler relock — keeps the
  glyphs exact but breaks the moment a game puts MODE 7 and a graphics mode in
  the same frame, which BBC software does.
- **Window.** 640 × 256, positioned from the sync edges. Where it starts is
  the one thing that follows the mode, and it has to: the OS programs hsync at
  character 51 of 64 in MODE 7 and at 98 of 128 in MODE 0-6, so the machine
  itself puts the teletext picture 32 dots (2 µs) left of a bitmap one — which
  is why MODE 7 sits left of the other modes on a real monitor. Each path then
  adds its own delay, measured against MAME's render of the Exile title page
  and against where the MODE 1 cursor block lands:

  | | CRTC display start | picture | delay |
  |---|---|---|---|
  | MODE 0-6 | 240 dots after hsync | 248 | 8 dots, one ULA character |
  | MODE 7 | 208 | 275 | 67 dots, about four characters |

  Both pictures are exactly 640 dots wide and they end up 27 dots apart, so no
  single 640-dot window holds both: with one window, four characters of every
  teletext line fell off the right. `H_START` therefore follows the video
  ULA's own teletext bit, sampled at the hsync edge so it cannot move inside a
  line. The teletext path's four characters of delay are three more than the
  bitmap path's and one more than the hardware's; the window hides that, and
  it has not been chased down.
- **Where the window sits is measured, not counted.** It latches the dot at
  which the CRTC's display enable rises, once a frame, and adds what this
  core's own pipeline costs after it: one character of the video ULA, which is
  9 dots with a 2 MHz character clock (MODE 0-3) and 17 with 1 MHz (MODE 4-6,
  from the ULA control register's bit 4, snooped in `bbcmicro_core.sv`), and
  51 for the teletext path. Anchoring on DE rather than on the hsync edge is
  what makes a game that reprograms the CRTC keep its picture inside the
  window.

  Checked with a single line drawn the full width of the screen —
  `MODE0:DRAW1279,0` — which is 640 dots with no rounding to misread:

  | mode | dots a pixel | gap at the left | right edge |
  |---|---|---|---|
  | MODE 0 | 1 | 0 | 639 |
  | MODE 1 | 2 | 1 | 639 |
  | MODE 2 | 4 | 3 | 639 |
  | MODE 5 | 4 | 3 | 639 |

  Every mode ends on the window's last dot; the gap at the left is
  (dots a pixel − 1), which is where `MOVE 0,0` lands inside pixel 0 and not
  a misplaced window. **Confirmed on hardware**: the MODE 0 line reaches both
  edges with nothing missing. A game that looks shifted after this is showing
  its own margins — a CRT's overscan hid them, a panel showing exactly the
  machine's 640 dots does not.

- **Phase.** The clock enables are gated by reset. Without that they fire on
  every 96 MHz clock while reset is held (the dividers sit at zero and the
  enable is `d == 0`), and the video ULA's `CLKEN_COUNT` — which its `nRESET`
  does not clear — free-runs through the download and comes out at a phase
  that depends on how long the loader took. Measured before the fix: the same
  frame sampled one dot differently between two benches whose downloads
  differed by 1.6M clocks, and reproducible with 14 extra clocks of reset.

## 7. Bring-up

The panel (`rtl/dbg_overlay.sv`, METHODOLOGY section 5.21) keeps its marker
row and frame counter. What the template's rows carried changes with the
machine:

| row | contents |
|---|---|
| 0 | `1010 1010`, frame counter, PLL locked / memory ready / downloading / all-complete / loaded / reset / CPU halted / watchdog |
| 1 | first-fault capture: the first vector the 6502 fetches that a healthy boot never does, and the address before it |
| 2 | a checksum of the ROM image as it was written to block RAM, and the first byte of the MOS — the path *and* the image |
| 3 | disc: image size as loaded, last sector the 8271 was asked for, and the FDC's state |

The SRAM self-test goes, because nothing uses the SRAM.

## 8. Timing exceptions

None yet. Every multicycle added to `projects/bbcmicro_pocket.sdc` has to say
here why everything its filter matches qualifies, and which registers sit at
the edge of the relaxed region (section 5.11), and the build fails on a
constraint that matched nothing (section 5.20).

## 9. What is not cycle-exact, and why that is acceptable

- **The 6502 is T65**, a widely used core, not a transistor-level model. It
  does not implement every undocumented opcode's bus behaviour. Held to MAME
  by a bus trace (`sim/run_trace.sh`) from reset; where it differs, the
  difference is recorded there.
- **1 MHz stretching is implemented** (docs/hardware.md section 9) — MAME does
  not model it, so the trace diverges in *time* once a slow device is touched,
  and the bench says so rather than masking it.
- **The 8271 is written from MAME's device model** and answers at the rate a
  250 kbit/s FM disc would, not at the real rotational latency of an unformatted
  gap. Software that times the index pulse will notice; DFS does not.
