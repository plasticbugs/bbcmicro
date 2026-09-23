The sideways RAM test.

WHAT SHIPS: a 64K board.  ROMSEL widens from two bits to four and banks 4-7
become RAM; banks 8-15 read &FF, as empty sockets do.  Banks 4-7 is where the
boards of the period put RAM and where software of the period looks -- Holed
Out's loader prints "BBC RAM VERSION LOADING INTO BANKS 4 AND 5" and probes
exactly those two.

The test program.  BASIC cannot poke ROMSEL itself: it lives in bank 3, so the
next byte it fetched would come from whatever bank was just selected.  This
assembles a routine into BASIC's heap that selects bank 4 with interrupts off,
writes &5A to &8000, reads it back into &70 and restores ROMSEL from &F4:

  DIM C% 50:P%=C%:[OPT 2:SEI:LDA #4:STA &FE30:LDA #&5A:STA &8000:LDA &8000:
  STA &70:LDA &F4:STA &FE30:CLI:RTS:]:CALL C%

tools/make_swram_disc.py puts it in a !BOOT with boot option 3, so BREAK runs
it.  (# prints as _ in these dumps: the BBC's # key is byte &5F, and these are
ASCII renderings of teletext screen memory.)

  disc-ours-on.txt    board fitted   &8000 READS &5A   SIDEWAYS RAM: ON
  disc-ours-off.txt   no board       &8000 READS &4C   SIDEWAYS RAM: OFF

&4C is not noise: with no board ROMSEL is two bits, bank 4 aliases onto bank 0,
and &4C is the DNFS ROM's own first byte showing through.  That aliasing is
exactly why Holed Out failed before this.

WHY MAME IS NOT THE ORACLE HERE.  MAME's bbcb masks ROMSEL to two bits
(`m_romsel = data & 0x03`), so it cannot present banks 4-7 at all; its
-romslot0..3 options put RAM in a socket of a bare motherboard, which is not a
thing anyone sold.  The real boards are under -internal (swr16/32/64/128,
ramamp, weromram, mr4200/4300/4800, aries, raven, memex).  Of those, the five
this romset can run all leave Holed Out at "Image has not loaded" in their
default configuration, and the rest need ROM files the bbcb set does not
carry.  So the bank-4 arrangement is checked against the software itself and
on hardware, not against MAME.

  bank1-*.txt   kept for the record: the earlier arrangement, when the RAM was
                a chip in socket 1 and MAME's -romslot1 ram was an exact match.
                Every one of the 25 rows agreed with MAME, typed at the prompt
                and booted from disc.  bank1-mame-*.txt and bank1-ours-*.txt
                are the typed test, bank1-disc-*.txt the same test booted from
                a disc.  The mechanism -- a bank that is RAM reads back what
                is written to it -- is the one shipping now; only where the
                banks are decoded has changed.
