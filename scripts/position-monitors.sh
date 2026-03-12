#!/bin/bash

error() {
    echo "Error: $1" >&2
    exit 1
}

usage() {
    echo "Usage: position-monitors.sh <monitor> <XxY> [<monitor> <XxY> ...]"
    echo ""
    echo "  <monitor>  Output name as shown by xrandr (e.g. DVI-D-1, HDMI-1)"
    echo "  <XxY>      Position offset in pixels (e.g. 0x140, 1920x0)"
    echo ""
    echo "Example:"
    echo "  position-monitors.sh DVI-D-1 0x140 HDMI-1 1920x0"
    exit 1
}

command -v xrandr >/dev/null 2>&1 || error "xrandr not found"

[ $# -lt 2 ] && usage
[ $(( $# % 2 )) -ne 0 ] && error "Arguments must be pairs of <monitor> <XxY>"

# Collect connected monitor names
connected=$(xrandr --query | awk '/ connected/{print $1}')

declare -A positions

while [ $# -gt 0 ]; do
    monitor="$1"
    pos="$2"
    shift 2

    # Validate monitor exists and is connected
    if ! grep -qw "$monitor" <<< "$connected"; then
        error "Monitor '$monitor' not found or not connected. Connected monitors: $(echo $connected | tr '\n' ' ')"
    fi

    # Validate position format NxM
    if ! [[ "$pos" =~ ^[0-9]+x[0-9]+$ ]]; then
        error "Invalid position '$pos' for '$monitor'. Expected format: XxY (e.g. 0x140)"
    fi

    positions["$monitor"]="$pos"
done

# Build xrandr command
args=()
for monitor in "${!positions[@]}"; do
    pos="${positions[$monitor]}"
    x="${pos%%x*}"
    y="${pos##*x}"
    args+=(--output "$monitor" --pos "${x}x${y}")
done

echo "Applying positions..."
xrandr "${args[@]}" || error "xrandr failed"

echo "Done."
echo ""

# Show updated state
while IFS= read -r line; do
    if [[ "$line" =~ ^([A-Za-z0-9_-]+)\ connected\ (primary\ )?([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
        monitor="${BASH_REMATCH[1]}"
        primary="${BASH_REMATCH[2]}"
        width="${BASH_REMATCH[3]}"
        height="${BASH_REMATCH[4]}"
        offset_x="${BASH_REMATCH[5]}"
        offset_y="${BASH_REMATCH[6]}"
        echo "  $monitor${primary:+ (primary)}: ${width}x${height} at +${offset_x}+${offset_y}"
    fi
done < <(xrandr --query)
