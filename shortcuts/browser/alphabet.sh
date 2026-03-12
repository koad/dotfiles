#!/bin/bash

PROFILE=alphabet
BROWSER=brave-browser
DATADIR=~/.local/profiles/browser/$BROWSER/$PROFILE

[ ! -d "$DATADIR" ] && [ "$1" != "--create" ] && echo "Profile directory does not exist. Use --create to create it." &&  exit 1
[ ! -d "$DATADIR" ] && mkdir -p "$DATADIR" && echo "Created profile directory: $DATADIR"
echo "Spawning new browser session: $DATADIR"
$BROWSER --user-data-dir=$DATADIR --class=$PROFILE-$BROWSER $*  >/dev/null 2>/dev/null & disown
