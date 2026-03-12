#!/usr/bin/env bash

echo 'Killing all browser tabs, but leaving them in place.  Reload them individually when necessary...'
pgrep -f -a 'vivaldi' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'vivaldi-stable' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'google-chrome' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'google-chrome-stable' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'chrome' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'chromium' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'brave' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'brave-browser' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
pgrep -f -a 'opera' | grep 'type=renderer' | grep -v "extension" | egrep -o '^[0-9]{0,}' | while read pid; do kill $pid; done
