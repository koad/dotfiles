#!/bin/bash

# Get the active window ID
WINDOW_ID=$(xprop -root _NET_ACTIVE_WINDOW | awk '{print $5}')

# Get the window geometry using xwininfo
X=$(xwininfo -id $WINDOW_ID | grep "Absolute upper-left X" | awk '{print $4}')
Y=$(xwininfo -id $WINDOW_ID | grep "Absolute upper-left Y" | awk '{print $4}')
WIDTH=$(xwininfo -id $WINDOW_ID | grep "Width:" | awk '{print $2}')
HEIGHT=$(xwininfo -id $WINDOW_ID | grep "Height:" | awk '{print $2}')

# Format as x,y,width,height
GEOMETRY="$X,$Y,$WIDTH,$HEIGHT"

# Copy to clipboard
echo $GEOMETRY | xclip -selection clipboard

echo "Current window position (x,y,width,height) copied to clipboard: $GEOMETRY"

