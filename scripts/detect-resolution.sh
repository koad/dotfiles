#!/bin/bash

error() {
    echo "Error: $1" >&2
    exit 1
}

command -v xrandr >/dev/null 2>&1 || error "xrandr not found"

# Overall desktop (combined) resolution
desktop=$(xrandr --query | grep -oP 'current \K[0-9]+ x [0-9]+')
echo "Desktop resolution: ${desktop// /}"
echo ""
echo "Monitors:"
echo "========="
echo ""

while IFS= read -r line; do
    if [[ "$line" =~ ^([A-Za-z0-9_-]+)\ connected\ (primary\ )?([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+).*\ ([0-9]+)mm\ x\ ([0-9]+)mm ]]; then
        monitor="${BASH_REMATCH[1]}"
        primary="${BASH_REMATCH[2]}"
        width="${BASH_REMATCH[3]}"
        height="${BASH_REMATCH[4]}"
        offset_x="${BASH_REMATCH[5]}"
        offset_y="${BASH_REMATCH[6]}"
        phys_w="${BASH_REMATCH[7]}"
        phys_h="${BASH_REMATCH[8]}"

        # Calculate diagonal in inches (1 inch = 25.4 mm)
        diag_mm=$(awk "BEGIN { printf \"%.1f\", sqrt($phys_w^2 + $phys_h^2) }")
        diag_in=$(awk "BEGIN { printf \"%.1f\", sqrt($phys_w^2 + $phys_h^2) / 25.4 }")

        # Calculate PPI
        ppi=$(awk "BEGIN { printf \"%.0f\", sqrt($width^2 + $height^2) / ($diag_mm / 25.4) }")

        echo "  Monitor:    $monitor${primary:+ (primary)}"
        echo "  Resolution: ${width}x${height}"
        echo "  Position:   +${offset_x}+${offset_y}"
        echo "  Size:       ${phys_w}mm x ${phys_h}mm (${diag_in}\" diagonal)"
        echo "  PPI:        ${ppi}"
        echo ""
    fi
done < <(xrandr --query)
