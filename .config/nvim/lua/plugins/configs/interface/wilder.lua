local wilder = require "wilder"
wilder.setup { modes = { ":", "/", "?" } }

wilder.set_option("pipeline", {
  wilder.branch(
    wilder.cmdline_pipeline {
      -- sets the language to use, 'vim' and 'python' are supported
      language = "python",
      -- 0 turns off fuzzy matching
      -- 1 turns on fuzzy matching
      -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
      fuzzy = 1,
    },
    wilder.python_search_pipeline {
      -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
      pattern = wilder.python_fuzzy_pattern(),
      -- omit to get results in the order they appear in the buffer
      sorter = wilder.python_difflib_sorter(),
      -- can be set to 're2' for performance, requires pyre2 to be installed
      -- see :h wilder#python_search() for more details
      engine = "re2",
    }
  ),
})

local gradient = {
  "#ff4040",
  "#f96322",
  "#e9880d",
  "#d0ad02",
  "#b0ce01",
  "#8be80c",
  "#66f920",
  "#42ff3d",
  "#25fa60",
  "#0eeb85",
  "#02d2aa",
  "#01b3cb",
  "#0a8ee6",
  "#1e69f7",
  "#3a45ff",
  "#5d27fb",
  "#8210ed",
  "#a703d5",
  "#c900b6",
  "#e40992",
  "#f61c6c",
  "#ff3848",
}

for i, fg in ipairs(gradient) do
  gradient[i] = wilder.make_hl("WilderGradient" .. i, "Pmenu", { { a = 1 }, { a = 1 }, { foreground = fg } })
end

wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    highlights = {
      gradient = gradient, -- must be set
      selected_gradient = gradient,
      default = "WilderPrompt",
      selected = "WilderPromptCursor",
      -- error = "",
      -- accent = "",
      -- selected_accent = "",
      -- empty_message = ""
      border = "WilderBorder",
    },
    highlighter = wilder.highlighter_with_gradient {
      wilder.basic_highlighter(),
    },
    border = "rounded",
    left = { " ", wilder.popupmenu_devicons() },
    right = { " ", wilder.popupmenu_scrollbar() },
  })
)
