-- Log the 6502's bus transactions so the core's CPU can be held to exactly
-- the same sequence.  For a processor whose only I/O is memory, the ordered
-- list of (read|write, address, data) *is* its behaviour -- a stronger and
-- much simpler statement than comparing register dumps, and it needs no
-- debugger (METHODOLOGY section 4).
--
--   BUS_N=400000 BUS_OUT=.mame/bus.txt tools/mame.sh \
--       -autoboot_script tools/bus_trace.lua -seconds_to_run 4
--
-- Two things to know before trusting a mismatch, both from the methodology:
-- MAME runs this 6502 at a flat 2 MHz with no 1 MHz stretching, so the
-- *sequence* is comparable but the timing is not; and anything the CPU polls
-- -- a VIA timer, the disc controller's status, the vsync flag -- will
-- eventually sample differently, after which the traces are unrelated.  The
-- first divergence is the one that means something.
local OUT = os.getenv("BUS_OUT") or ".mame/bus.txt"
local N   = tonumber(os.getenv("BUS_N") or "400000")

local mach = manager.machine
local sp   = mach.devices[":maincpu"].spaces["program"]

local f = assert(io.open(OUT, "w"))
local n = 0
local done = false

local function log(kind, addr, data)
    if done then return end
    n = n + 1
    f:write(string.format("%s %04X %02X\n", kind, addr & 0xffff, data & 0xff))
    if n >= N then
        f:close()
        done = true
        print(string.format("bus trace: %d transactions -> %s", n, OUT))
    end
end

-- a tap that is garbage collected stops working, so both are kept in a global
_G.KEEP = {}
_G.KEEP.r = sp:install_read_tap(0x0000, 0xffff, "busr", function(off, data, mask)
    log("R", off, data)
    return data
end)
_G.KEEP.w = sp:install_write_tap(0x0000, 0xffff, "busw", function(off, data, mask)
    log("W", off, data)
    return data
end)

emu.add_machine_stop_notifier(function()
    if not done then
        f:close()
        print(string.format("bus trace: %d transactions -> %s (run ended first)", n, OUT))
    end
end)
