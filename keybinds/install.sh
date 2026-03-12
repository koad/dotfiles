#!/usr/bin/env bash

SCRIPT_DIR="$HOME/.dotfiles/scripts"
ADD="$SCRIPT_DIR/add-keybinding.sh"

"$ADD" "file-explorer"         "nautilus"                                            "<Super>f"
"$ADD" "gnome-terminal"        "gnome-terminal"                                      "<Ctrl><Alt>t"
"$ADD" "copy-window-position"  "$HOME/.dotfiles/scripts/copy-window-position.sh"     "<Super>t"
"$ADD" "kill-all-tabs"         "$HOME/.dotfiles/scripts/kill-all-tabs.sh"            "<Ctrl><Alt>k"
"$ADD" "personal-browser"      "$HOME/.dotfiles/shortcuts/browser/personal.sh"       "<Super>g"
"$ADD" "unattached-browser"    "$HOME/.dotfiles/shortcuts/browser/unattached.sh"     "<Super>i"
"$ADD" "kingofalldata-browser" "$HOME/.dotfiles/shortcuts/browser/kingofalldata.sh"  "<Super>k"
"$ADD" "book.koad.sh"          "$HOME/.dotfiles/shortcuts/book.koad.sh.sh"           "<Super>b"


SHAPES_DIR="$(dirname "$(realpath "$0")")/shapes"
shape_key=$(xrandr --query \
  | grep ' connected' \
  | grep -oP '\d+x\d+\+\d+\+\d+' \
  | sort -t'+' -k2 -n \
  | grep -oP '^\d+x\d+' \
  | paste -sd'+')

if [[ -z "$shape_key" ]]; then
  echo "fixture: could not determine monitor layout" >&2
  exit 1
fi

shape_file="$SHAPES_DIR/${shape_key}.sh"

if [[ -f "$shape_file" ]]; then
  exec bash "$shape_file"
else
  echo "fixture: no shape file found for layout: $shape_key" >&2
  echo "fixture: expected: $shape_file" >&2
  exit 1
fi
