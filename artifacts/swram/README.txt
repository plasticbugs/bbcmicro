The sideways RAM test.

BASIC runs from socket 3, so it cannot poke ROMSEL itself -- the next byte it
fetched would come from whatever the new socket holds.  The test assembles a
short routine into main RAM that switches to socket 1 with interrupts off,
writes &5A to &8000, reads it back into &70 and restores ROMSEL from &F4
before letting BASIC continue:

  DIM C% 50:P%=C%:[OPT 2:SEI:LDA #1:STA &FE30:LDA #&5A:STA &8000:LDA &8000:
  STA &70:LDA &F4:STA &FE30:CLI:RTS:]:CALL C%:P.?&70

&5A is the value read back out of RAM; &FF is an unwritable socket floating
high.  (# prints as _ below: the BBC's # key is byte &5F, and these are ASCII
renderings of teletext screen memory.)

Typed at the prompt, 124 keystrokes, ours against MAME's bbcb:

  ours-on.txt    -swram 2      90    mame-on.txt    -romslot1 ram   90
  ours-off.txt   -swram 0     255    mame-off.txt   plain          255

All 25 rows identical to MAME in both cases.

The same program on a bootable disc, swramtest.ssd, built by
tools/make_swram_disc.py -- one BREAK instead of 124 keystrokes, which is what
makes it usable on the Pocket:

  disc-ours-on.txt    -swram 2    SIDEWAYS RAM: ON    &8000 READS &5A
  disc-ours-off.txt   -swram 0    SIDEWAYS RAM: OFF   &8000 READS &FF
  disc-mame-on.txt / disc-mame-off.txt   the same disc in MAME

Every row matches MAME's once MAME's typed ">*EXEC !BOOT" line is dropped:
ours auto-boots from the keyboard link instead, so it never echoes a command.
