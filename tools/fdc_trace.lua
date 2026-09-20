-- Log every access to the 8271's registers while the disc boots, so the core's
-- own controller can be written against what DFS actually asks for rather than
-- against the whole datasheet.
--
--   BOOT=1 DISC=... tools/mame.sh -autoboot_script tools/fdc_trace.lua -seconds_to_run 30
--
-- A tap that is garbage collected stops working, so it is kept in a global.
local mac = manager.machine
local sp  = mac.devices[":maincpu"].spaces["program"]
taps = {}
local names = {[0]="cmd/status", [1]="param/result", [2]="reset", [3]="reg3",
               [4]="data", [5]="data", [6]="data", [7]="data"}
local t0 = os.clock()
local function stamp() return string.format("%7.3f", os.clock() - t0) end

taps[#taps+1] = sp:install_write_tap(0xfe80, 0xfe9f, "fdcw", function(offset, data, mask)
  local r = offset & 0x07
  print(string.format("%s W %04X %-12s %02X", stamp(), offset, names[r], data))
  return data
end)
taps[#taps+1] = sp:install_read_tap(0xfe80, 0xfe9f, "fdcr", function(offset, data, mask)
  local r = offset & 0x07
  print(string.format("%s R %04X %-12s %02X", stamp(), offset, names[r], data))
  return data
end)
local f = 0
emu.register_frame_done(function()
  f = f + 1
  if f == 200 then mac.natkeyboard:post("*EXEC !BOOT\n") end
end)
