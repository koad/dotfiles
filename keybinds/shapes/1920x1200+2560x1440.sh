#!/usr/bin/env bash
#
# Shape: 1920x1200 (left, DVI-D-1 @ +0+120) + 2560x1440 (right, HDMI-1 @ +1920+0)
# (1440-1200)/2 == 120
# ~/.dotfiles/keybinds/.scripts/position-monitors.sh DVI-D-1 0x120 HDMI-1 1920x0
# 
# Key layout mirrors physical position on the desktop:
#
#   Super + Q  W  E  R      top row, right screen
#            A  S  D        middle row, left screen
#             Z  X          bottom row, unused

SCRIPT_DIR="$HOME/.dotfiles/scripts"
ADD="$SCRIPT_DIR/add-keybinding.sh"

"$ADD" "right-bottom-left"   "wmctrl -r :ACTIVE: -e 0,1916,965,2048,413"  "<Super>q"
"$ADD" "right-left"          "wmctrl -r :ACTIVE: -e 0,1916,29,2048,1141"  "<Super>w"
"$ADD" "right-top"           "wmctrl -r :ACTIVE: -e 0,2162,28,2321,1273"  "<Super>e"
"$ADD" "right-bottom-right"  "wmctrl -r :ACTIVE: -e 0,2894,623,1388,558"  "<Super>r"

"$ADD" "left-top"     "wmctrl -r :ACTIVE: -e 0,19,182,1905,829"  "<Super>a"
"$ADD" "left-bottom"  "wmctrl -r :ACTIVE: -e 0,839,833,959,361"  "<Super>s"
