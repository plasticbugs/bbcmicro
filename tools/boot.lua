-- Drive the machine from reset to a state worth capturing, then snapshot.
--
-- MAME's BREAK key is wired to a PORT_CHANGED handler, and setting the field
-- from Lua does not reliably pull the CPU's reset line, so the disc is booted
-- the way the OS would have done it: the DFS boot option on the Exile disc is
-- 3 (*EXEC), so "*EXEC !BOOT" from the prompt runs exactly what SHIFT+BREAK
-- would have run.  Typed through the natural keyboard, which needs -natural.
--
--   BOOT=1            type the boot command (default: just sit at the prompt)
--   BOOT_CMD=...      what to type (default *EXEC !BOOT)
--   BOOT_AT=200       frame to type it at
--   SNAP_AT=400,900   frames to snapshot (screen only, no artwork)
--   OUT=dir           where dumps go; snapshots follow -snapshot_directory
--
-- Frames are counted from the first frame MAME completes, so a run is
-- repeatable to the frame as long as -seconds_to_run covers the last one.
local mac   = manager.machine
local scr   = mac.screens[":screen"]
local frame = 0

local function numlist(s)
    local t = {}
    for v in string.gmatch(s or "", "%d+") do t[tonumber(v)] = true end
    return t
end

local boot_at  = tonumber(os.getenv("BOOT_AT") or "200")
local boot_cmd = os.getenv("BOOT_CMD") or "*EXEC !BOOT\n"
local do_boot  = os.getenv("BOOT") == "1"
local snap_at  = numlist(os.getenv("SNAP_AT"))
local last     = 0
for f in pairs(snap_at) do if f > last then last = f end end

emu.register_frame_done(function()
    frame = frame + 1
    if do_boot and frame == boot_at then
        mac.natkeyboard:post(boot_cmd)
    end
    if snap_at[frame] then
        scr:snapshot()
        print(string.format("snapshot at frame %d", frame))
    end
end)

emu.add_machine_stop_notifier(function()
    print(string.format("ran %d frames (last wanted %d)", frame, last))
    if frame < last then
        print("WARNING: the run ended before the last wanted frame")
    end
end)
