local awful = require("awful")

local volume_old = -1
local muted_old = -1
local function emit_volume_info()
  awful.spawn.easy_async_with_shell(
    [[ pamixer --get-mute --get-volume]],
    function(stdout)
      local output = string.gmatch(stdout, "%S+")
      local muted = output() == "true" and 1 or 0
      local volume = tonumber(output())
      if volume ~= volume_old or muted ~= muted_old then
        awesome.emit_signal("widget::volume", volume, muted == 1 and true or false)
        ---@diagnostic disable-next-line: cast-local-type
        volume_old = volume
        muted_old = muted
      end
    end
  )
end

-- Run once to initialize widgets
emit_volume_info()

-- Sleeps until pactl detects an event (volume up/down/toggle mute)
local volume_script = [[
    bash -c "
    LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "]]


-- Kill old pactl subscribe processes
awful.spawn.easy_async({ "pkill", "--full", "--uid", os.getenv("USER"), "^pactl subscribe" }, function()
  -- Run emit_volume_info() with each line printed
  awful.spawn.with_line_callback(volume_script, {
    stdout = function(line)
      emit_volume_info()
    end
  })
end)
