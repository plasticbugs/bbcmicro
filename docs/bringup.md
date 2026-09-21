# The first flash

Read this with the Pocket in your hand. It says what to do, what to look at,
and — for each thing that can be wrong — what the panel will show.

Everything here is untested on hardware; this core has never run on a Pocket.
That is the point of the first flash, and of the panel: to find out what the
benches could not.

## What goes on the card

```
Assets/bbcmicro/common/bbcmicro.rom      built by tools/mra_build.py
Assets/bbcmicro/common/<your>.ssd        any disc images you want
Cores/plasticbugs.bbcmicro/…             the core
Platforms/bbcmicro.json                  the platform entry
```

Copy with `cp -X` and `COPYFILE_DISABLE=1` — and then delete the `._*` files
anyway, because on this machine neither stops `cp -R` writing them to an exFAT
card:

    find /Volumes/POCKET/Cores/<yours> /Volumes/POCKET/Assets/<yours> \
        -name '._*' -delete

Check the md5 of every file on the card against the build, not just
`bbcmicro.rom`; `md5` is not always on the PATH a script runs with, and a
comparison of two empty strings passes silently.

## What should happen

1. **openFPGA → BBC Micro.** The core loads the ROM image; the screen should
   come up black for under a second.
2. **The boot screen**, in MODE 7 teletext:

   ```
   BBC Computer 32K

   Acorn DFS

   BASIC

   >
   ```

   White on black, the cursor flashing under the `>`.
3. **Core Settings → Drive 0**, choose a `.ssd`. The machine keeps running:
   loading a disc must not reset it.
4. **L + R + Start** is BREAK. With **Boot disc on BREAK** ticked in Core
   Settings, that boots the disc; without it, hold the on-screen keyboard's
   SHIFT (or map SHIFT to a button) while pressing BREAK.
5. **L + R + Select** brings up the keyboard over the picture. The d-pad moves
   the highlight, A or B presses, and SHIFT, CTRL, CAPS and SHIFT LOCK latch
   so you can type the combinations. The same chord puts it away.

## If something is wrong

Turn on **Core Settings → Bring-up: panel**. Four rows of 32 green and grey
squares appear on the bottom sixteen lines of the picture. Green is 1. Read
each row left to right; **row 0 must begin `1010 1010`** — if it does not, the
reading is misaligned and nothing after it can be trusted.

| row | squares | meaning |
|---|---|---|
| 0 | 1-8 | `1010 1010`, the marker |
| 0 | 9-16 | frame counter — if it is not changing, the video is not running |
| 0 | 17 | PLL locked |
| 0 | 18 | memory ready |
| 0 | 19 | a download is in progress |
| 0 | 20 | the host said "all complete" |
| 0 | 21 | the core has seen a complete load and left reset |
| 0 | 22 | the machine is in reset |
| 0 | 23 | the CPU is stretched (it should flicker; solid means stuck on a slow device) |
| 0 | 24 | a watchdog was seen |
| 0 | 25-32 | the disc controller's state: phase in the top two, then what it is doing |
| 1 | 1-17 | the CPU's address bus, bit 16 leftmost |
| 1 | 18 | the CPU is fetching an opcode |
| 1 | 19 | the CPU is halted |
| 2 | 1-16 | a checksum of the ROM image as it went into block RAM |
| 2 | 17-32 | how many bytes of it arrived (low 16 bits; 0x4400 is right) |
| 3 | 1-8 | which drives have an image |
| 3 | 9-16 | which of those are double-sided |

**A black screen with the frame counter running.** The video is alive and the
machine is not. Look at row 2: the checksum should be `5C0F` and the count
`4400` for a correct image. If the count is short, the download was cut off;
if the checksum differs with the right count, the image arrived corrupted,
which is the fault that black-screened two earlier cores.

**A black screen with the frame counter stopped.** The PLL or the video clock;
check row 0 square 17.

**The boot screen, but no `Acorn DFS` line.** The disc controller is not
answering. That line is DFS announcing itself, and it only does so if the 8271
responds.

**The picture rolls or is torn.** The CRTC's sync is what the Pocket sees, so
this is the video window or the scaler preset, not the machine.

**Sound.** The boot beep should be a short high note. If there is a click at
power-on and nothing else, the audio hand-over is running but the sound chip
is not being written; if there is a continuous tone, the chip is being written
but never silenced.

## What to report

For each run, the four rows as you read them (or a photograph of the panel),
and: what was on screen, what you had loaded, and what you had pressed. If the
machine is running at all, the most useful single thing is **the boot screen
photographed**, because every character in it comes through the whole video
path — teletext, the character generator, the CRTC's timing and the ULA's
palette.
