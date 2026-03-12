#!/bin/bash

error() {
    echo "Error: $1" >&2
    exit 1
}

schema="org.gnome.settings-daemon.plugins.media-keys"
custom_schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"

current=$(gsettings get "$schema" custom-keybindings)

if [ "$current" = "[]" ] || [ -z "$current" ]; then
    echo "No custom keybindings found."
    exit 0
fi

# strip outer brackets and split on ','
current="${current:1:-1}"

echo "Custom keybindings:"
echo "==================="
echo ""

IFS=',' read -ra BINDINGS <<< "$current"
for entry in "${BINDINGS[@]}"; do
    # strip surrounding whitespace and single quotes
    path="${entry## }"
    path="${path//\'/}"

    name=$(gsettings get "${custom_schema}:${path}" name 2>/dev/null)
    command=$(gsettings get "${custom_schema}:${path}" command 2>/dev/null)
    binding=$(gsettings get "${custom_schema}:${path}" binding 2>/dev/null)

    echo "  Name:     ${name:-<unknown>}"
    echo "  Command:  ${command:-<unknown>}"
    echo "  Binding:  ${binding:-<unset>}"
    echo ""
done
