The sideways RAM system test.  BASIC runs from socket 3, so it cannot poke
ROMSEL itself -- the next byte it fetched would come from whatever the new
socket holds.  The test assembles a short routine into main RAM that switches
to socket 1 with interrupts off, writes &5A to &8000, reads it back into &70
and restores ROMSEL from &F4 before letting BASIC continue:

  DIM C% 50:P%=C%:[OPT 2:SEI:LDA #1:STA &FE30:LDA #&5A:STA &8000:LDA &8000:
  STA &70:LDA &F4:STA &FE30:CLI:RTS:]:CALL C%:P.?&70

90 is &5A read back out of RAM; 255 is an unwritable ROM socket floating high.
All 25 rows of each screen are identical to MAME's.  (# prints as _ here: the
BBC's # key is byte &5F, and this is an ASCII rendering of teletext memory.)
