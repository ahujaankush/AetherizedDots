local notify = require "notify"
dofile(vim.g.base46_cache .. "notify")
local options = {
  stages = "slide",
  on_open = nil,
  on_close = nil,
  render = "default",
  timeout = 1500,
  max_width = 150,
  max_height = 25,
  background_colour = "TabLine",
  minimum_width = 50,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "",
  },
}

vim.notify = function(msg, ...)
  if
    msg:match "warning: multiple different client offset_encodings"
    or "fidget.nvim will soon be rewritten. Please checkout the 'legacy' tag to avoid breaking changes."
  then
    return
  end

  notify(msg, ...)
end

notify.setup(options)
