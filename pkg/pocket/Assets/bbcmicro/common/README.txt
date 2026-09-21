Put bbcmicro.rom here.

Build it from your own MAME `bbcb` romset with the builder in the release
zip, which needs nothing but Python 3:

    python3 mra_build.py bbcmicro.mra bbcb.zip

`bbcb` is MAME's BBC Micro Model B; there is no `bbcmicro` machine.  The image
needs four parts -- os12.rom, basic2.rom, dnfs120.rom and the SAA5050's
character generator -- and a merged set has all four in bbcb.zip.  If yours is
split, unzip the parts into one directory and point the builder at that
directory instead: it reads either.

It reads the zip (or a directory of loose files) directly, checks every ROM's
CRC32, and verifies the finished image against a known md5, so
a wrong or damaged romset is reported rather than quietly built into
something that half works.

Already using pupdate or the standard `mra` tool? Point it at bbcmicro.mra;
it is an ordinary MRA file.
