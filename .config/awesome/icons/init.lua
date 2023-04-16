local gears = require("gears")
local awful = require("awful")
-- describes the collection of icons
icons = {}
-- describes the specific icon
local function file_exists(path)
    -- Try to open it
    local f = io.open(path)
    if f then
        f:close()
        return true
    end
    return false
end

function icons.getIcon(file)
    p = gears.filesystem.get_configuration_dir() .. "icons/"
    if (file_exists(p .. file)) then
        return p .. file
    else
        return ""
    end
end

return icons