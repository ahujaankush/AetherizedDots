function smooth_fzf() {
  local old_pwd="$PWD"
  local fname
  cd "$HOME/Dotfiles/dots.sh"
  fname="$(fzf)"
  if [[ "$fname" ]]; then
    $EDITOR "$fname"
  else
    cd "$old_pwd"
  fi
  cd "$old_pwd"
}

function replace_buffer() {
  local old=$1 new=$2 space=${2:+ }

  # if the cursor is positioned in the $old part of the text, make
  # the substitution and leave the cursor after the $new text
  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  # otherwise just replace $old with $new in the text before the cursor
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

function sudo_command_line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # If $SUDO_EDITOR or $VISUAL are defined, then use that as $EDITOR
    # Else use the default $EDITOR
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}

    # If $EDITOR is not set, just toggle the sudo prefix on and off
    if [[ -z "$EDITOR" ]]; then
      case "$BUFFER" in
        sudo\ -e\ *) replace_buffer "sudo -e" "" ;;
        sudo\ *) replace_buffer "sudo" "" ;;
        *) LBUFFER="sudo $LBUFFER" ;;
      esac
      return
    fi

    # Check if the typed command is really an alias to $EDITOR

    # Get the first part of the typed command
    local cmd="${${(Az)BUFFER}[1]}"
    # Get the first part of the alias of the same name as $cmd, or $cmd if no alias matches
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"

    # Note: ${var:c} makes a $PATH search and expands $var to the full path
    # The if condition is met when:
    # - $realcmd is '$EDITOR'
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "cmd --with --arguments"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "cmd"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is /alternative/path/to/cmd that appears in $PATH
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
      replace_buffer "$cmd" "sudo -e"
      return
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
      $editorcmd\ *) replace_buffer "$editorcmd" "sudo -e" ;;
      \$EDITOR\ *) replace_buffer '$EDITOR' "sudo -e" ;;
      sudo\ -e\ *) replace_buffer "sudo -e" "$EDITOR" ;;
      sudo\ *) replace_buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle redisplay
  }
}

function vi_search_fix() {
  zle vi-cmd-mode
  zle .vi-history-search-backward
}

function default_greeter() {
  c1="\033[1;30m"
  c2="\033[1;31m"
  c3="\033[1;32m"
  c4="\033[1;33m"
  c5="\033[1;34m"
  c6="\033[1;35m"
  c7="\033[1;36m"
  c8="\033[1;37m"
  reset="\033[1;0m"

  printf "\n $c1󰺕  $c2󰺕  $c3󰺕  $c4󰺕  $c5󰺕  $c6󰺕  $c7󰺕  $c8󰺕  $reset\n\n"
}

function toggle_prompt() {
  case "$1" in
    right) p10k display '*/right'=hide,show ;;
    left) p10k display '*/left'=hide,show ;;
  esac
}

function toggle_right_prompt() {
  toggle_prompt right
}

function toggle_left_prompt() {
  toggle_prompt left
}


# vim:ft=sh
