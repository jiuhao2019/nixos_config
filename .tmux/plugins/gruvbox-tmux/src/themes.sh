#!/usr/bin/env bash

SELECTED_THEME="$(tmux show-option -gv @gruvbox-tmux_theme)"

case $SELECTED_THEME in
"dark")
  declare -A THEME=(
    ["background"]="#1d2021"
    ["foreground"]="#d4be98"
    ["black"]="#32302f"
    ["blue"]="#7daea3"
    ["cyan"]="#89b482"
    ["green"]="#a9b665"
    ["magenta"]="#d3869b"
    ["red"]="#ea6962"
    ["white"]="#d4be98"
    ["yellow"]="#e78a4e"

    ["bblack"]="#32302f"
    ["bblue"]="#7daea3"
    ["bcyan"]="#89b482"
    ["bgreen"]="#a9b665"
    ["bmagenta"]="#d3869b"
    ["bred"]="#ea6962"
    ["bwhite"]="#a89984"
    ["byellow"]="#e78a4e"
  )
  ;;

"light")
  declare -A THEME=(
    ["background"]="#f8f4d6"
    ["foreground"]="#282828"
    ["black"]="#f8f4d6"
    ["blue"]="#076678"
    ["cyan"]="#427b58"
    ["green"]="#79740e"
    ["magenta"]="#8f3f71"
    ["red"]="#9d0006"
    ["white"]="#3c3836"
    ["yellow"]="#b57614"

    ["bblack"]="#b8b49a"
    ["bblue"]="#458588"
    ["bcyan"]="#689d69"
    ["bgreen"]="#98971a"
    ["bmagenta"]="#b16186"
    ["bred"]="#cc241d"
    ["bwhite"]="#7c6f64"
    ["byellow"]="#d79921"
  )
  ;;

*)

  # Default to medium theme
  declare -A THEME=(
    ["background"]="#1d2021"
    ["foreground"]="#d4be98"
    ["black"]="#32302f"
    ["blue"]="#7daea3"
    ["cyan"]="#89b482"
    ["green"]="#a9b665"
    ["magenta"]="#d3869b"
    ["red"]="#ea6962"
    ["white"]="#d4be98"
    ["yellow"]="#e78a4e"

    ["bblack"]="#32302f"
    ["bblue"]="#7daea3"
    ["bcyan"]="#89b482"
    ["bgreen"]="#a9b665"
    ["bmagenta"]="#d3869b"
    ["bred"]="#ea6962"
    ["bwhite"]="#a89984"
    ["byellow"]="#e78a4e"
  )
  ;;
esac

THEME['ghgreen']="#a9b665"
THEME['ghmagenta']="#d3869b"
THEME['ghred']="#ea6962"
THEME['ghyellow']="#e78a4e"

RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"
