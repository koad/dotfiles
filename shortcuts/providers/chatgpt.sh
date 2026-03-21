#!/bin/bash

PROFILE=personal
BROWSER=google-chrome
DATADIR=~/.local/profiles/browser/$BROWSER/$PROFILE
APPWINDOW=https://chat.openai.com/chat

[ ! -d "$DATADIR" ] && [ "$1" != "--create" ] && echo "Profile directory does not exist. Use --create to create it." &&  exit 1
[ ! -d "$DATADIR" ] && mkdir -p "$DATADIR" && echo "Created profile directory: $DATADIR"
echo "Spawning new browser session: $DATADIR"
$BROWSER --app=$APPWINDOW --user-data-dir=$DATADIR --class=$APPWINDOW $*  >/dev/null 2>/dev/null & disown
