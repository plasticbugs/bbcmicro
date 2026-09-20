# The machine

The Acorn BBC Microcomputer Model B, 1981, as MAME's `bbcb` runs it: OS 1.20,
32K of RAM, an Acorn 8271 disc controller with DNFS 1.20 in sideways slot 0,
and BASIC II in slot 3.

Written from MAME 0.288, fetched verbatim into `ref/mame/`:

| file | what it settles |
|---|---|
| `acorn/bbcb.cpp` | address maps, machine configuration, clocks, ROM layout |
| `acorn/bbc_m.cpp` | interrupts, NMI sources, ROM insertion |
| `acorn/bbc_v.cpp` | video address translation, the video ULA, the row renderer |
| `acorn/bbc_kbd.cpp` | the key matrix, the links, the two scan modes |
| `bus/acorn.cpp` | the 8271 disc board: register map, motor and side control |
| `devices/*` | 6522, HD6845S, SAA5050, SN76489, i8271, uPD7002, 6850 |

Everything the gateware does should be traceable to a line here. Where this
core deliberately differs from MAME, section 10 says so.

## 1. Parts and clocks

One 16 MHz crystal runs the whole machine; every clock below is a division of
it, so on the Pocket they are all exact divisions of one system clock
(`docs/core-design.md` section 1).

| part | type | clock | notes |
|---|---|---|---|
| CPU | MOS 6502 | 16 MHz / 8 = **2 MHz** | stretched to 1 MHz for slow peripherals — section 9 |
| video | Hitachi HD6845S CRTC | 2 MHz or 1 MHz, selected by video ULA bit 4 | 8 bytes fetched per character time |
| video | Ferranti Video ULA | 16 MHz dot clock | 1, 2, 4 or 8 bits per pixel from each byte |
| video | Mullard SAA5050 | 12 MHz / 2 = 6 MHz | teletext, MODE 7 only |
| I/O | 2× MOS 6522 VIA | 16 MHz / 16 = **1 MHz** | system VIA and user VIA |
| I/O | 74LS259 addressable latch | — | written through system VIA port B |
| sound | TI SN76489A | 16 MHz / 4 = **4 MHz** | 3 tones + noise, write-only |
| disc | Intel 8271 | 16 MHz / 4 = **4 MHz** | on a board clocked at 16 MHz / 2 |
| analogue | NEC µPD7002 | 1 MHz | 4-channel 12-bit ADC, joysticks |
| serial | 6850 ACIA + Serial ULA | 16 MHz / 13 | cassette and RS423 |
| network | 68B54 ADLC | — | Econet; not fitted in this core |

Raster: MAME's container screen is `set_raw(16_MHz_XTAL, 1024, 0, 640, 312, 0,
256)` — 1024 dots by 312 lines at 16 MHz, which is **50.080 Hz**. The CRTC is
free to program something else and games do; the figures above are the PAL-ish
default the OS sets up (R0=63, so 64 character times of 8 dots = 1024 dots per
line, 312 lines).

Audio pacing (METHODOLOGY section 5.3): the SN76489A generates from its own
4 MHz clock, so tempo does not depend on how fast the CPU runs. The *sequence*
of notes is driven by the OS's 100 Hz interrupt (system VIA T1), so a core that
runs the CPU at the right rate and the sound chip at the right rate has the
right music.

## 2. Memory map — 6502

From `bbcb_state::bbcb_mem` in `ref/mame/acorn/bbcb.cpp`.

| range | size | what | R/W | notes |
|---|---|---|---|---|
| `0000-7FFF` | 32K | main RAM | R/W | shared with the video circuit, which reads it during phase 1 |
| `8000-BFFF` | 16K | paged ROM | R | one of 4 sideways ROM sockets, selected by ROMSEL |
| `C000-FBFF` | 15K | OS ROM | R | writes ignored |
| `FC00-FCFF` | 256 | FRED | R/W | 1 MHz bus; reads `FF` with nothing fitted |
| `FD00-FDFF` | 256 | JIM | R/W | 1 MHz bus; reads `FF` with nothing fitted |
| `FE00-FEFF` | 256 | SHEILA | R/W | on-board I/O, below; unmapped reads give `FE` |
| `FF00-FFFF` | 256 | OS ROM | R | vectors live here |

SHEILA, with the mirrors MAME gives each device:

| address | mirror | device | notes |
|---|---|---|---|
| `FE00` | `+0,2,4,6` | 6845 address / status | write address, read status |
| `FE01` | `+0,2,4,6` | 6845 data | read/write the selected register |
| `FE08-FE0F` | | 6850 ACIA | serial |
| `FE10-FE17` | | Serial ULA | cassette/RS423 rate and select |
| `FE18-FE1F` | | Econet station ID | read; also clears the Econet NMI enable |
| `FE20-FE2F` | | **Video ULA** | write only: `FE20` control, `FE21` palette |
| `FE30-FE3F` | | **ROMSEL** | write only on a Model B; low 2 bits select the socket |
| `FE40-FE5F` | `FE40-4F` +`0x10` | **system VIA** | keyboard, sound, screen start, LEDs, ADC handshake |
| `FE60-FE7F` | `FE60-6F` +`0x10` | **user VIA** | printer and user port |
| `FE80-FE9F` | | **8271 FDC** | `FE80-83` registers, `FE84-87` data (bit 2 selects) |
| `FEA0-FEBF` | | 68B54 ADLC | Econet |
| `FEC0-FEDF` | | µPD7002 | ADC |
| `FEE0-FEFF` | | Tube ULA | second processor |

ROMSEL (`FE30`) on a Model B keeps only **bits 1:0** — four sockets, not
sixteen (`m_romsel = data & 0x03`). Software written for expansion boards still
writes 0-15; the top bits are simply dropped, so a write of 12 selects socket 0.

ROM socket contents, matching MAME's `bbcb` ROM region exactly:

| socket | image offset in MAME's `rom` region | fitted here |
|---|---|---|
| 0 (IC52) | `0x00000` | DNFS 1.20 — inserted by the 8271 board at startup |
| 1 (IC88) | `0x04000` | empty, reads `FF` |
| 2 (IC100) | `0x08000` | empty, reads `FF` |
| 3 (IC101) | `0x0C000` | BASIC II |

The OS scans sockets high to low, so BASIC in 3 is the language and DFS in 0 is
the filing system. `docs/core-design.md` section 3 keeps the ROM image in this
order so the two can be compared byte for byte.

## 3. Inputs

### 3.1 The key matrix

The keyboard is a 10-column × 8-row matrix (MAME declares 16 columns; 10 are
wired). It is addressed through system VIA port A:

| PA bits | meaning |
|---|---|
| `PA3-PA0` | column, 0-15, into a 4-bit counter |
| `PA6-PA4` | row, 0-7 |
| `PA7` | read back: 1 = the key at (column,row) is down |

PA7 is an input while PA0-6 are outputs; the OS writes the address with PA7's
direction set to input and reads the answer back on the same port. Two modes,
selected by the addressable latch's Q3 (**`kb_en`, active low**):

- **Q3 = 0, polled:** the column comes from PA3-0 as above.
- **Q3 = 1, free-running:** a 1 MHz counter walks the columns by itself and
  raises **CA2** on the system VIA whenever any key in the current column
  *other than row 0* is down. This is how the OS gets a keyboard interrupt
  while it is doing something else.

Row 0 is excluded from the interrupt because it is not keys: it is SHIFT,
CTRL and the **startup links**, read at reset by the OS.

| column | row 0 = link | meaning when fitted (reads 0) |
|---|---|---|
| 0 | SHIFT | — |
| 1 | CTRL | — |
| 2 | Default filing system | which filing system ROM the OS starts in |
| 3 | Not used | MAME labels it so |
| 4 | Disc timings bit 0 | drive step rate |
| 5 | Disc timings bit 1 | |
| 6 | Boot | fitted: BREAK alone boots the disc; open: SHIFT+BREAK does |
| 7 | Screen mode bit 0 | the MODE the OS selects at reset |
| 8 | Screen mode bit 1 | |
| 9 | Screen mode bit 2 | |

The full matrix is in `ref/mame/acorn/bbc_kbd.cpp` (`bbc_keyboard` ports) and
is reproduced in `rtl/bbc_keyboard.sv`; the columns as MAME lists them are the
authority, and `tools/list_ports.lua` prints them.

### 3.2 BREAK

BREAK is not in the matrix: it is a separate key that pulls the 6502's RESET
line, and — on a Model B — resets the user VIA, the ADLC, the FDC, the 1 MHz
bus and the Tube, but **not** the system VIA, the CRTC or the video ULA
(`bbcb_state::trigger_reset`). A core that resets everything on BREAK loses the
screen mode, which the OS re-establishes anyway, but it also loses the
addressable latch, which it does not.

### 3.3 Analogue

The µPD7002 converts four channels, 10 or 12 bits, taking about 10 ms; EOC
raises system VIA CB1. Joystick fire buttons arrive on system VIA **PB4** and
**PB5**, active low. Games that read the analogue joystick are a minority;
Exile is keyboard-only.

## 4. Interrupts

**IRQ** is the wired-OR of: system VIA, user VIA, ACIA, 1 MHz bus, Tube,
internal expansion (`m_irqs`, an `INPUT_MERGER_ANY_HIGH`). Of those the core
implements the two VIAs.

Inside the system VIA the sources that matter are:

| source | line | what raises it |
|---|---|---|
| vertical sync | CA1 | the CRTC's VSYNC output, once a frame — the OS's 50 Hz tick |
| keyboard | CA2 | a key down in the free-running scan |
| timer 1 | — | the OS programs it for the 100 Hz clock |
| ADC end of conversion | CB1 | µPD7002 |
| light pen | CB2 | also latches the CRTC's light pen register |

**NMI** is `fdc_irq | fdc_drq | (econet_ie & econet_irq) | bus_nmi`
(`bbc_state::update_nmi`). The disc controller's data requests are NMIs: DFS
transfers every byte in an NMI handler, which is why disc access is timing
critical and why the 8271's data rate has to be right (section 7).

## 5. Video

### 5.1 The three chips

The CRTC generates addresses and sync; the video ULA turns each byte into
pixels and holds the palette; the SAA5050 replaces the ULA's pixel generation
in MODE 7. The CRTC fetches one byte per character time, always 8 dots wide at
its own clock — 2 MHz (8 dots at 16 MHz) for modes 0-3, 1 MHz for modes 4-6.

### 5.2 Video ULA control register — `FE20`

| bit | meaning |
|---|---|
| 7 | master cursor size |
| 6-5 | cursor width in bytes (0,0,1,2,1,0,2,4 for the 8 values of 7:5) |
| 4 | 6845 clock: 1 = 2 MHz, 0 = 1 MHz |
| 3-2 | characters per line: 00=10, 01=20, 10=40, 11=80 |
| 1 | 1 = teletext (MODE 7) |
| 0 | flash colour select — inverts which of the flashing pair is shown |

Bits 3-2 also set the pixel rate: pixels per byte is
`{2,4,8,16,1,2,4,8}[bits 4:2]` and pixel width `1 << (~bits[3:2] & 3)`. In
teletext, 12 pixels per character and width 1.

### 5.3 Palette — `FE21`

Sixteen entries, written as `{logical[7:4], physical[3:0]}`. The physical
nibble is **inverted on the way in**: the ULA's stored value is `data ^ 7` for
the colour bits, and bit 3 marks a flashing colour. Rendering is

```
col = palette_lookup[ bitswap4(data, 7,5,3,1) ]      // MSB of each pixel plane
```

so a byte holds its pixels interleaved: bits 7,5,3,1 are pixel 0's four planes
and the byte shifts left (with 1s coming in) once per pixel. For a 2-colour
mode only bit 7 varies and the other three planes follow from the shift; this
is why the palette has 16 entries in every mode.

Physical colours are three bits, one each of R, G and B, so the base palette is
the eight saturated colours; bit 3 selects the flashing pair, which alternates
with the ULA control register's bit 0 (the OS toggles it every 50 frames).

### 5.4 Where the picture lives — the address translation

`bbc_state::calculate_video_address` in `ref/mame/acorn/bbc_v.cpp` is the whole
of it, and it is not a straight address. The CRTC's MA13 selects between the
two latch pairs, and MA8-11 are added to four NAND terms of C0, C1 (latch Q4,
Q5) and MA12 to wrap the screen for hardware scrolling:

```
b3 = ~(c0 & ma12);  b1 = ~(c1 & c0 & ma12);  b2 = ~(c1 & b3 & ma12);  b4 = ~(b3 & ma12)
s  = (ma[11:8] + {b4,b3,b2,b1} + 1) & 0xF

MA13 = 1 (teletext):  addr = (ma & 0x3FF) | 0x3C00 | ((s & 8) << 11)
MA13 = 0 (graphics):  addr = ((ma & 0xFF) << 3) | (s << 11) | (ra & 7)
```

C0 and C1 are the screen-size bits the OS sets per MODE; they decide where the
wrap happens, which is what makes hardware scrolling work without moving bytes.
`ra & 7` is the row within the character — eight consecutive bytes are one
character cell's eight lines, which is why the graphics modes are stored in
character-cell order rather than in scanlines.

RA bit 3 blanks the output (`!(ra & 0x08) ? colour : 0`): a character row taller
than 8 shows black in the rows past the eighth.

### 5.5 Teletext

In MODE 7 the ULA passes the byte to the SAA5050 instead of serialising it. The
latch between them carries bits 0-5 always, bit 6 only while DE is high, and
DE's inverse into bit 7 (LOSE). The SAA5050 is clocked 12 pixels per character,
and MAME doubles the row rate because it does not implement interlace — the
real machine displays MODE 7 interlaced, with the SAA5050 producing its 20-line
characters over two fields.

Teletext reads from `0x7C00-0x7FFF` (the `0x3C00` term above), which is why
MODE 7 costs only 1K.

### 5.6 What MAME's snapshot looks like

MAME reconfigures the screen per mode (`crtc_reconfigure` multiplies the width
by the pixel width), so a snapshot is 480×500 in MODE 7 and 512×160 on Exile's
menu screen. A core that emits a fixed raster cannot be compared with those
directly: the comparison is made on **palette indices per CRTC character and
pixel**, against the reference renderer, which is what
`tools/render_model.py` and the frozen states exist for.

## 6. Sound

One SN76489A at 4 MHz, write-only, connected to the **system VIA's port A** —
the same eight lines as the keyboard. The addressable latch's **Q0 is the
chip's write enable** (active low): the OS puts a byte on PA, pulses Q0 low,
and waits. The chip's `READY` line is not connected, so software must respect
the write timing itself; the OS does.

The addressable latch (74LS259) is written through system VIA **port B**: bits
2:0 are the address, bit 3 the data (`write_nibble_d3`).

| Q | drives |
|---|---|
| 0 | SN76489A `/WE` |
| 1 | speech `/RS` |
| 2 | speech `/WS` |
| 3 | keyboard enable (`kb_en`) |
| 4 | screen wrap C0 |
| 5 | screen wrap C1 |
| 6 | CAPS LOCK LED |
| 7 | SHIFT LOCK LED |

Tone period is `clock / (32 × n)` — 4 MHz / 32 = 125 kHz at n=1 — and the noise
generator is the SN76489A's 15-bit LFSR, tapped at bits 0 and 1 (`ref/mame/devices/sn76496.cpp`).

The speech chip (TMS5220) is a factory option, not fitted in this core, and
Exile does not use it.

## 7. Disc

### 7.1 The board

The Acorn 8271 board answers `FE80-FE9F` (`ref/mame/bus/acorn.cpp`):

| address | direction | meaning |
|---|---|---|
| `FE80` + bit2=0, offset 0-3 | R/W | 8271 registers: 0 command/status, 1 parameter/result, 2 reset, 3 — |
| `FE84` + bit2=1 | R/W | 8271 data register |

The 8271's `HDL` output drives both drives' motors *and* its own READY input;
`OPT` selects the side.

### 7.2 What DFS asks of it

DFS 1.20 uses a small subset: `READ DATA` (single and multi-sector), `READ ID`,
`SEEK`, `VERIFY`, `WRITE DATA`, `READ DRIVE STATUS` and the special-register
writes that set drive parameters. Every byte of a transfer is moved by an NMI
handler in the OS, so the byte rate is what makes disc access work or fail:
250 kbit/s FM, one byte per 64 µs, which is 128 CPU cycles — comfortable for
the NMI handler, and the reason a core that answers *too fast* breaks DFS.

### 7.3 The disc image

`Disc040-ExileR.ssd` is a plain DFS single-sided image: 80 tracks × 10 sectors
× 256 bytes = 204,800 bytes, sector *n* of track *t* at byte `(t*10 + n)*256`.
Its catalogue, from `tools/ssd_info.py`:

```
title EXILE, 7 files, boot option 3 (*EXEC), 800 sectors
  $.!BOOT    sector 2   *BASIC / PAGE=&1900 / *FX21 / CLOSE#0:CHAIN "EXILE"
  $.EXILE    sector 3    load 1900 exec 8023
  $.EXILE2   sector 20   load 3000 exec 4A10
  $.ExileL   sector 47   load 3000 exec 74E0
  $.ExileB   sector 117  load 1200 exec 7200   the Model B game
  $.ExileSR  sector 214  sideways-RAM version
  $.ExileMC  sector 231  Master Compact version
```

So Exile needs BASIC (for `CHAIN`), DFS (for the disc) and about 25K of RAM —
and it picks `ExileB` on a Model B.

## 8. What this core does not implement

Each of these is a real part of the machine, and each is written down so that
"not implemented" never looks like "broken":

- **Cassette and RS423** (6850 + Serial ULA). The OS's cassette filing system
  will hang waiting for data if selected.
- **Econet** (68B54 ADLC) — DNFS's NFS half will report no network.
- **Speech** (TMS5220 + VSM ROMs).
- **Printer / user port** — the user VIA is present because software reads its
  timers, but nothing is connected to its ports.
- **Tube** — a second processor changes nothing for Model B software.
- **1 MHz bus devices** (FRED, JIM). Reads give `FF`, which is what "nothing
  fitted" reads on a real machine and what `Alien 8` and others check for.
- **Light pen**.
- **Video NuLA** — MAME emulates this modern add-on when the `BBCCONFIG` bit is
  set; the default is off and this core is the plain Ferranti ULA.

## 9. Timing the gateware has to get right and MAME does not model

MAME runs the 6502 at a flat 2 MHz. The real machine **stretches the clock** so
that every access to a 1 MHz device (both VIAs, the ACIA, the serial ULA, the
ADC, the FDC, the ADLC, FRED and JIM) takes a full 1 MHz cycle and lands on the
1 MHz phase: a 2 MHz cycle addressing a slow device is extended to 2 or 3 clock
phases depending on where in the 1 MHz cycle it started. The video ULA, ROMSEL,
RAM and ROM stay at 2 MHz.

This matters twice. Software that times a loop by counting cycles through VIA
accesses runs at a different speed without it; and the video circuit reads RAM
in the phase the CPU is not using, which only works because the two are locked.
The core implements stretching (`rtl/bbcmicro_core.sv`); MAME does not, so a
bus trace against MAME matches in *sequence* but not in *cycle count* once
slow devices are touched, and the benches must not claim otherwise.

MAME's own list of benchmark games (`ref/mame/acorn/bbc_v.cpp`, top of file)
names Exile as needing "correct handling of flags in BCD mode, and palette
change timing" — two facts worth having before the first frame is compared:
the 6502's N and V flags after a decimal-mode ADC/SBC are computed from the
binary result, and palette writes have to take effect at the pixel they land
on, not at the end of the line.
