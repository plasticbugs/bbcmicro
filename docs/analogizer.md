# The Analogizer

[Analogizer](https://github.com/RndMnkIII/Analogizer) is RndMnkIII's adapter
for the Pocket's cartridge slot. It gives analog video out of a VGA connector
(RGBS, RGsB, YPbPr, Y/C, and a scandoubled RGBHV) and takes native controllers
through SNAC adapters. Its wiki is the authority on the adapter itself:
[specifications](https://github.com/RndMnkIII/Analogizer/wiki/Analogizer-Specifications),
[how to configure it](https://github.com/RndMnkIII/Analogizer/wiki/Supported-Cores-and-How-to-Configure-Them).

This page covers what this core does with it, for the person using it and for
whoever changes the core next. It was added after the core shipped, following
the pocket-core-template's `docs/analogizer-retrofit.md`; the wrapper and the
vendored module are the template's, unchanged.

## For the player

**Settings are in the core's own menu**, under the game's other options,
like RndMnkIII's own "Pocket Menu" Analogizer cores (the wiki's list calls the
other kind, which reads a shared `analogizer.bin`, "Analogizer File"; this
core does not read that file). The Pocket remembers them for this core.

The BBC's own menu already has twelve entries and Analogue's limit is sixteen,
so the Analogizer has four here rather than the six other cores have: on/off,
the video mode and the Pocket-screen blank are one list, and there is no SNAC
Assignment entry (the SNAC device is always player 1).

| entry | options |
|---|---|
| Analogizer | Off (the default); RGBS, RGsB, YPbPr, Y/C NTSC, Y/C PAL; each of those again with ", Pocket off" (the picture goes to the CRT only) |
| SNAC Adapter | None, PS/2 Keyboard, PS/2 Keyboard + NES / + SNES / + DB15, DB15, NES, SNES, PCE 2-button, PCE 6-button, DB15 Fast, SNES A,B<->X,Y, PSX Digital, PSX Digital Fast, PSX Analog, PSX Analog Fast |
| Analogizer H Position | -64 to +64 dots (of 16 MHz: a dot is 1/16 µs); + moves the picture right |
| Analogizer V Position | -30 to +24 lines; + moves the picture down |

**No scandoubler.** The BBC draws 16 MHz dots (MODE 0's 640 across), and the
Analogizer runs at 48 MHz like every shipped Analogizer core: three clocks a
dot. RGBS, YPbPr and Y/C are fine at that; the scandoubler and HQ2x need four
clocks a dot and are not offered. A faster Analogizer clock would put a
higher rate on the cartridge pins than any shipped core has tried.

With **Analogizer** off the core behaves exactly as it did without Analogizer
support. The adapter itself is set up as its wiki's
[How to use it](https://github.com/RndMnkIII/Analogizer/wiki/How-to-use-it%3F)
says: SNAC switch in position A, 5 V into its USB-C port, the SCART cable's
audio jack in the Pocket's headphone socket.

**Position.** The two sliders move the picture on the CRT, in the core's
own dots and lines, for a set whose picture sits off centre (the first one
tried with Moo Mesa showed it about 10 lines high). They move the syncs,
not the picture, so nothing is cropped and every screen mode follows; the
size is still the set's to adjust. 0 is the machine's own timing.

**Video.** The core sends the machine's own signal: 15.625 kHz lines, 312 a
frame, 50.08 Hz progressive -- what a BBC Micro gives a monitor, with the
6845's interlace left off as the Pocket picture has it. What reaches the CRT
is the core's 640 × 256 window, the same picture the Pocket shows (the
on-screen keyboard and the bring-up panel included); outside it the port is
blanked. A game that reprograms the CRTC moves its picture on the CRT as it
would on the real machine.

| mode | SOG switch | notes |
|---|---|---|
| RGBS | off | VGA-to-SCART or VGA-to-BNC |
| RGsB | on | R2/R3 adapters only |
| YPbPr | on | R2/R3 adapters only |
| Y/C NTSC, Y/C PAL | off | needs an active Y/C adapter on the VGA port |
The ", Pocket off" choices turn the Pocket's own picture black while the
CRT keeps it.

**A PS/2 keyboard.** "PS/2 Keyboard" on SNAC Adapter types on the BBC from a
PS/2 keyboard on the adapter's SNAC port (the wiring is the adapter's; see its
wiki). The keys are where they are on the BBC, not where the PC's legends say,
the way MAME maps a PC keyboard onto this machine: SHIFT+2 is the BBC's `"`.
The keys a PC does not have:

| BBC | PC key |
|---|---|
| f0-f9 | F1-F10 |
| BREAK | F12 (held: the machine is in reset until it is let go) |
| COPY | End |
| DELETE | Delete or Backspace |
| SHIFT LOCK | Left Alt |
| CAPS LOCK, CTRL, SHIFT, ESCAPE, TAB, RETURN, cursor keys | the same keys (both SHIFTs, both CTRLs, either Enter) |
| `@` `:` `^` `_` `\` | PC `\`, `'`, `=`, `` ` ``, and the ISO key left of Z |

With "PS/2 Keyboard" alone the Pocket's own controls still work as they do
without an adapter (the d-pad and buttons press their mapped keys, L+R+Select
brings up the on-screen keyboard). The keyboard, the pad mapping and the
on-screen keyboard all type into the same matrix; a key held from two of them
is let go by whichever releases first.

**Pads.** A SNAC pad (any of the pad types, or "PS/2 Keyboard + NES / SNES /
DB15") takes player 1's place: it drives the same key mapping and joystick
the Pocket's d-pad and buttons do, including L+R+Select for the on-screen
keyboard and L+R+Start for BREAK on pads that have those buttons. The
Pocket's own controls then go to player 2, which the BBC does not read, so
they stop doing anything while a pad type is chosen. A PlayStation pad in
analog mode steers with its left stick as a d-pad.

**Cart power is on for everyone.** `core.json` declares the cartridge adapter,
so the Pocket powers the slot whether or not an Analogizer is in it. Do not
leave a game cartridge in the slot while this core runs.

**Confirmed on a Pocket with an Analogizer and a CRT** (0.4.0). What the
benches prove is listed under *What was measured* below. Send problems with the adapter itself
to the Analogizer project.

## For the developer

### The pieces

| file | what |
|---|---|
| `target/pocket/analogizer/` | RndMnkIII's `openFPGA_Pocket_Analogizer` and what it instantiates, **verbatim** (modules/VENDOR.md has the commit). Its `analogizer.qip` is ours: only what is used. |
| `target/pocket/pocket_analogizer.sv` | the wrapper: clock hand-over, Y/C constants, SNAC → controller words, picture position. Core-agnostic; the same file as the template's (d9503cc). |
| `target/pocket/core_top.sv` | `USE_ANALOGIZER`, the instance (after the bring-up panel, `LINE_LEN` 1024), `key1..key4` in place of `cont1..4_key`, the bridge read at `0xF7xxxxxx`, the Pocket-screen blank, the cart pins' idle levels when it is off, and the PS/2 keyboard's bytes into `rtl/bbc_ps2.sv`. |
| `rtl/bbc_ps2.sv` | the PS/2 keyboard: scancode set 2 into BBC key matrix events and BREAK. `sim/run_ps2.sh` checks it. |
| `core_pll` `outclk_4` | the Analogizer's 48 MHz, `clk_sys / 2` in phase; in the SDC's PLL group. |
| `pkg/.../interact.json` | ids 70 (enable, video and Pocket blank in one list), 72 (SNAC type) at `0xF7000000`, masked; 74–75, signed sliders at `0xF7000004` and `0xF7000008`. With the BBC's twelve that is 16, Analogue's limit; 77 options in all, more than any installed core has been seen with (Analogue's docs do not count list options against a limit) |
| `pkg/.../core.json` | `"cartridge_adapter": 0` (powers the slot) |
| `sim/run_analogizer.sh` | the bench (below), at MODE 7's raster |
| `tools/check_json.py` | fails if an entry writes outside its mask, none sets the enable, a position slider is not signed within ±127, a data slot also writes `0xF7000000`, or the slot is not powered |

### The settings word

One 32-bit word at `0xF7000000`, the layout RndMnkIII's adapter module (1.4)
decodes. Each menu entry is a list with a mask that keeps every bit but its
own field (or fields), so the entries share the word:

| bits | field | values |
|---|---|---|
| 4:0 | SNAC type | 0 none, 1 DB15, 2 NES, 3 SNES, 4 PCE 2-button, 5 PCE 6-button, 6 PCE multitap (not offered: the BBC reads one player), 9 DB15 fast, 0xB SNES A/B↔X/Y, 0xC PS/2 keyboard + NES, 0xD + SNES, 0xE + DB15, 0xF PS/2 keyboard alone, 0x10/0x11 PSX digital (125/250 kHz), 0x12/0x13 PSX analog. 16 and up select the adapter's B wiring. |
| 5 | enable | 0: the port stays idle and nothing else applies |
| 9:6 | SNAC assignment | no menu entry: stays 0, SNAC pad 1 as player 1 and the Pocket's controls as player 2 |
| 13:10 | video | 0 RGBS, 1 RGsB, 2 YPbPr, 3 Y/C NTSC, 4 Y/C PAL; 5–9 the scandoubler modes, not offered (above) |
| 14 | blank the Pocket screen | |
| 15 | OSD on the Analogizer output | not used; no menu entry |

**Read-back.** The word is written as a number (the adapter module is told
`bridge_endian_little = 1`, so it does not byte-swap it as it would a file),
and `pocket_analogizer` keeps its own copy to read back, combinationally.
The Pocket's bridge (`io_bridge_peripheral.sv`) samples read data four clocks
after it presents the address and pulses `bridge_rd` only afterwards; the
adapter module updates its read-back on that pulse, so it would hand back
the *previous* read's value. The firmware merges a masked entry by
reading the word back (Analogue's interact.json docs: every entry not
`writeonly` is read back every frame), so that stale value would wipe the
other fields: in the bench, choosing a video mode turned the Analogizer off. RndMnkIII's menu
cores (Gauntlet) read the word back the same way, from a register.

**Picture position.** Two more words, each a whole signed slider value
(no mask): `0xF7000004` horizontal in dots, + right, and `0xF7000008`
vertical in lines, + down. `pocket_analogizer` reads the low 8 bits and
reads both words back. The adapter module stores them in a table it never
reads (`config_mem`). They move the syncs, not the picture: hsync n dots
earlier puts the picture n dots right, vsync n lines earlier puts it n
lines down. Earlier is built as a line (or frame) less n later: each sync
is re-made from the source's own rising edge after a delay counted in
dots, as wide as the source's, with the line and frame measured from the
source's syncs; the vsync's delay is whole lines, so its edges keep their
place in the line. RGB and blanking go through one clock later with them,
and at 0 each sync passes straight through.

A re-made sync starts only once it has been off at least as long as it is
on. The adapter module's `sync_fix` decides each sync's polarity afresh
every period, by whether the signal was high longer than low. A jump
between settings in one write (one "large" slider step, or a value loaded
at start) can put the next pulse just after the last one ends, and that
period reads as active-low: csync turned inside out for a frame (a line,
for hsync). With the rule such a jump skips one pulse instead.

**The range, from this core's blanking.** Moving right, hsync may come
earlier until it meets the end of the picture; moving left, it may come
later until the Y/C colour burst, which ends about 3.5 µs after hsync does
(56 dots at 16 MHz), would reach the picture. Vsync may move either way
until it reaches a picture line.

- Vertically the core fixes the window at lines 32-287 after the vsync edge
  in every mode (`V_START`, `V_HEIGHT` in `rtl/bbcmicro_core.sv`), 312 lines
  a frame, vsync 2 lines: 24 blank lines before vsync and 30 after it, so
  -30 to +24, the whole of it. The bench fails at -31 and at +25.
- Horizontally the window's place depends on the mode and on the game,
  because it follows the CRTC's display enable. As the OS sets them: MODE 7
  leaves 110 dots between the window's end and hsync and 210 after hsync;
  MODE 0-6 about 136 and 184. Less the colour burst after hsync, that is
  +110/-154 and +136/-128. ±64 keeps 46 dots of that on every side for games that move
  the CRTC. The bench, at MODE 7, would allow up to +110.

**The file scheme, not used here.** The adapter module 1.4 was written for
`analogizer.bin`, a file Pupdate and AnalogizerConfigurator write to
`/Assets/analogizer/common/`, loaded through a data slot at the same address.
It needs a data slot naming the file, a second platform id `analogizer`
that the slot's parameters point at, and the file on the card before the
adapter does anything. A player who has never heard of the file has an
Analogizer that stays dark, so this core uses the menu. A data slot at
`0xF7000000` would load the file over the menu's word; `tools/check_json.py`
refuses one.

### Clocks

`openFPGA_Pocket_Analogizer` runs its logic on `i_clk`, puts `video_clk` on the
cartridge pin that clocks the ADV7123, and assumes that is `i_clk` too. The
shipped Analogizer cores use 42.95–48 MHz. This core's system clock is 96 MHz,
more than the cart's level translators have been asked to pass, so the PLL's
spare output gives 48 MHz, in phase with `clk_sys`.

The BBC's dot is 16 MHz, six system clocks and three Analogizer clocks.
`pocket_analogizer` takes each pixel `PIX_LAG` (2) system clocks after the dot
enable into a holding register and hands it over with a toggle; the
Analogizer side takes it two or three of its clocks later -- the last clock of
the dot at the latest, a same-edge path the timing analysis checks, since both
clocks come from the one PLL. The bench shows every dot of a frame arriving
intact. The scandoubler needs four clocks a dot (its output pixel is half an
input one) and is not offered.

The Y/C encoder's subcarrier step and colour-burst window are computed in
integers from `CLK_HZ`. The reals used elsewhere lose the bits past 32 in some
tools, and MSX2's hand-typed NTSC step is a few counts off.

### Using SNAC in the game's inputs

`pocket_analogizer` outputs `key1..key4`, the Pocket's controller words with
SNAC pads put in place by the assignment. SNAC's bit order is the Pocket's
(0 up, 1 down, 2 left, 3 right, 4 A, 5 B, 6 X, 7 Y, 8 L1, 9 R1, … 14 select,
15 start). They feed the `gamepad` helper and the direct player-3/4 reads in
place of `cont1..4_key`; this core reads its controllers nowhere else.

### The PS/2 keyboard

The adapter module's receiver (`ps2_keyboard.vhd`, in the Analogizer's clock)
hands over each byte the keyboard sends on `ps2_code`, and holds
`ps2_code_new` high from the end of the byte until the next byte starts: a
level, not a pulse. `rtl/bbc_ps2.sv` synchronises it into `clk_sys`, takes
the code two clocks after the edge (it cannot change while the level is
high), decodes set 2 (`E0` extends the next code, `F0` releases it, `E1`
starts Pause, skipped whole) and sends one key event at a time in the same
shape as the pad mapping and the on-screen keyboard. Its event waits until a
clock when neither of those is sending. The map is MAME's
(`ref/mame/acorn/bbc_kbd.cpp`), positional. The keyboard is only listened to
with a PS/2 type chosen: otherwise the module ties the receiver's inputs
idle.

### What was measured

- `sim/run_analogizer.sh` (PASS): the wrapper and the vendored module at this
  core's raster -- MODE 7 as the OS sets it, 1024 × 312 dots of 16 MHz, the
  640 × 256 window -- and clocks (three Analogizer clocks a dot), read at the
  cartridge pins as the DAC reads them.
  - With the menu at its defaults, every pin sits as on a core without the
    adapter, and the controller words pass through.
  - Every option of both list entries in the package's `interact.json` (27),
    set as the firmware sets a masked entry, read back as the bridge samples
    it, merged and written: the word, the adapter's copy and the enable each
    followed.
  - RGBS: all 163,840 visible dots of a frame reach the DAC pins, in raster
    order, as their top six bits per channel, with 0 differing. Csync is one
    64-dot pulse a line (310 of them outside vsync).
  - Position, at both ends of the sliders (+64,+24 and -64,-30): read back
    as written, the settings word untouched; at the pins csync moves by
    exactly 192 clocks (64 dots) each way and by 24 and 30 lines, the
    picture is still every dot with 0 differing, csync is never low while a
    dot is drawn. One line further either way (+25, -31) fails it. Jumps
    written just after a pulse that put the next one right after it (V +24
    to +21, H +64 to -1): csync stays out of the picture for three frames.
  - YPbPr and Y/C NTSC/PAL: no unknown on any pin for a frame.
  - All six SNAC assignments (the wrapper's; the menu uses the first), the
    analog stick, and type "none" map as tabled.
  - The blank bit, and enable off again returning the port to idle.
  - The scandoubler is not checked: it is skipped below four clocks a dot.
- `sim/run_ps2.sh` (PASS): `rtl/bbc_ps2.sv` fed bytes as the receiver hands
  them over, in its own 48 MHz clock. All 74 host keys MAME maps onto the
  matrix (its port list, joined to the standard set 2 codes -- not the
  module's own table) each give one press and one release at MAME's
  position. Cursor down `E0 72` followed by keypad 2 `72` (unmapped) and its
  release: the prefix applies once. A shifted cursor key wrapped in fake
  shifts (`E0 F0 12`, `E0 12`) leaves SHIFT alone. Pause's eight bytes send
  nothing and the next key works. F12 holds BREAK for as long as it is
  down. Scroll Lock sends nothing. With `E0` left set after its code, the
  run fails.
- The machine's own gates (nothing in it changed; `rtl/bbc_ps2.sv` is new and
  only core_top uses it): `sim/run_mem.sh -quick` 0 wrong, `sim/run_osk.sh`
  and `sim/run_swram.sh` PASS, `sim/run_boot.sh -ms 1500` boots at 50.08 Hz.
- `sim/lint.sh`: clean, the wrapper and `bbc_ps2` included. The vendored
  files' warnings are dropped by path; their errors are not.
- Quartus 18.1: every constraint in `projects/bbcmicro_pocket.sdc` applied;
  no negative slack at any corner (worst setup +0.645 ns slow 0C, worst hold
  +0.123 ns fast 0C, inside the Analogizer's own Y/C encoder). The
  Analogizer and the PS/2 decoder cost 1,781 ALMs (3,438 → 5,219, 28%), 26
  RAM blocks (227 → 253 of 308; the scandoubler's line buffers at 1024 dots,
  built although no menu entry reaches them) and 2 DSP blocks. The first
  fit took the SDRAM read capture's hold to -0.065 ns; the SDRAM clock
  shift moved two VCO steps, 5.859 → 6.119 ns, and capture hold is no longer
  among the 20 worst (capture setup +1.279 ns).

**Not proven:** anything on hardware with this core -- the Analogizer path,
the 16 MHz dot at three clocks a dot on a real DAC, and the PS/2 keyboard
through the adapter's receiver (the bench feeds its output, not the PS/2
wire); that the firmware writes a signed slider as a two's-complement word;
a menu with 77 options on the real firmware (documented, not seen on an
installed core); the SNAC serial protocols, which are the adapter module's
and are forced at its outputs in the bench rather than driven over the pins.
The Y/C and YPbPr encodings have no reference to compare against, only a
run without unknowns.

### Turning it off

Set `USE_ANALOGIZER = 0` in `core_top.sv`, remove `general[4]` from the PLL
group in the SDC (it would match nothing), and take the four menu entries
and `cartridge_adapter: 0` out of the JSON. `rtl/bbc_ps2.sv` then gets no
bytes and does nothing.

**The menu's size, measured on hardware (2026-10-09).** The first build of
this menu had over 68 options in all and the Pocket refused it ("Error in
interact" at core setup); MSX2 loads with 68, Cadash and Cloak with 54.
Analogue's docs say a list's options count toward no limit; this firmware
disagrees. The Analogizer's lists were trimmed to keep the whole menu at 64
(SNAC types a one- or two-player game has no use for, and the rarer
Pocket-off variants); `tools/check_json.py` now refuses more than 68
options, or more than 80 options and entries together.
