#!/bin/bash
DATADIR=~/.local/profiles/browser/chromium
[ ! -d "$DATADIR" ] && [ "$1" != "--create" ] && echo "Profile directory does not exist. Use --create to create it." &&  exit 1
[ ! -d "$DATADIR" ] && mkdir -p "$DATADIR" && echo "Created profile directory: $DATADIR"
echo "Spawning new browser session: $DATADIR"
chromium --user-data-dir=$DATADIR/discord --app=https://discord.com/channels/@me --class=discord-browser $*  >/dev/null 2>/dev/null & disown
