return {
  port = 8080,
  browser_command = "firefox", -- Empty string starts up with default browser
  quiet = false,
  no_css_inject = false, -- Disables css injection if true, might be useful when testing out tailwindcss
  install_path = vim.fn.stdpath "config" .. "/live-server/",
}
