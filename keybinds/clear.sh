#!/bin/bash

error() {
    echo "Error: $1" >&2
    exit 1
}

schema="org.gnome.settings-daemon.plugins.media-keys"
custom_schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"

current=$(gsettings get "$schema" custom-keybindings)

if [ "$current" = "[]" ] || [ -z "$current" ]; then
    echo "No custom keybindings to clear."
    exit 0
fi

# strip outer brackets and split on ','
inner="${current:1:-1}"

IFS=',' read -ra BINDINGS <<< "$inner"
for entry in "${BINDINGS[@]}"; do
    # strip surrounding whitespace and single quotes
    path="${entry## }"
    path="${path//\'/}"

    gsettings reset "${custom_schema}:${path}" name 2>/dev/null
    gsettings reset "${custom_schema}:${path}" command 2>/dev/null
    gsettings reset "${custom_schema}:${path}" binding 2>/dev/null
done

gsettings set "$schema" custom-keybindings "[]" || error "Failed to clear keybinding list"

echo "All custom keybindings cleared."
