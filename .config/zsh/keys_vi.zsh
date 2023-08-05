# prepend sudo on the current commmand
bindkey -M vicmd '^S' sudo_command_line
bindkey -M viins '^S' sudo_command_line
# fix backspace and other stuff in vi-mode
bindkey -M vicmd '^\' toggle_right_prompt
bindkey -M vicmd '^]' toggle_left_prompt

# vim:ft=zsh:nowrap
