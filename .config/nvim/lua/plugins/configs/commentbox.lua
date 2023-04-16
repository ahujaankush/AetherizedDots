return {
  doc_width = 80, -- width of the document
  box_width = 60, -- width of the boxes
  borders = { -- symbols used to draw a box
    top = "─",
    bottom = "─",
    left = "│",
    right = "│",
    top_left = "╭",
    top_right = "╮",
    bottom_left = "╰",
    bottom_right = "╯",
  },
  line_width = 70, -- width of the lines
  line = { -- symbols used to draw a line
    line = "─",
    line_start = "─",
    line_end = "─",
  },
  outer_blank_lines = false, -- insert a blank line above and below the box
  inner_blank_lines = false, -- insert a blank line above and below the text
  line_blank_line_above = false, -- insert a blank line above the line
  line_blank_line_below = false, -- insert a blank line below the line
}
