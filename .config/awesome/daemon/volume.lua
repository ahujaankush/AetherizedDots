-- Provides:
-- evil::volume
--      percentage (integer)
--      muted (boolean)
local awful = require("awful")

local volume_old = -1
local muted_old = -1

local volume
local muted

local function emit_volume_info()
	-- is muted?
	awful.spawn.easy_async_with_shell("pamixer --get-mute", function(stdout)
		muted = (stdout:gsub("\n", "") == "true")
	end)

	-- get volume
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
		volume = tonumber(stdout)
		if volume <= 1 then
			muted = true
		end

		if volume ~= volume_old or muted ~= muted_old then
			awesome.emit_signal("evil::volume", volume, muted)
			volume_old = volume
			muted_old = muted
		end
	end)
end

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
		end,
	})
end)

-- Run once to initialize widgets
emit_volume_info()
