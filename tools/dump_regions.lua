-- Dump MAME's loaded ROM regions to raw files, so tools/verify_rom.py can
-- check the image the .mra builds against what MAME actually feeds the chips.
--
--   REGION_DIR=.mame/regions tools/mame.sh -autoboot_script tools/dump_regions.lua \
--       -seconds_to_run 2
--
-- The regions of `bbcb`, as MAME names them:
--   :mos                        16K  the OS ROM at C000-FFFF
--   :rom                       256K  the sideways ROM sockets, 16K each; a
--                                    Model B decodes only the first four, and
--                                    the 8271 board inserts DFS into one of
--                                    them at startup
--   :saa5050:chargen           1.2K  the teletext character generator
--   :fdc:acorn8271:dfs_rom      16K  DFS as the disc board holds it
local mac = manager.machine
local dir = os.getenv("REGION_DIR") or "."
_G.KEEP = {}
_G.KEEP.s = emu.add_machine_stop_notifier(function() end)

local REGIONS = {
  [":mos"] = "mos.bin",
  [":rom"] = "rom.bin",
  [":saa5050:chargen"] = "chargen.bin",
  [":fdc:acorn8271:dfs_rom"] = "dfs_rom.bin",
}

for tag, name in pairs(REGIONS) do
  local r = mac.memory.regions[tag]
  if r then
    local f = io.open(dir .. "/" .. name, "wb")
    local buf = {}
    for i = 0, r.size - 1 do
      buf[#buf + 1] = string.char(r:read_u8(i))
      if #buf == 4096 then f:write(table.concat(buf)); buf = {} end
    end
    f:write(table.concat(buf))
    f:close()
    print(string.format("wrote %s (%d bytes) from %s", name, r.size, tag))
  else
    print("MISSING region " .. tag)
  end
end
