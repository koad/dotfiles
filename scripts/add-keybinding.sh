#!/bin/bash

error() {
    echo "Error: $1" >&2
    exit 1
}

if [ $# -ne 3 ]; then
    error "Usage: add-keybinding.sh <name> <command> <binding>"
fi

name="$1"
command="$2"
binding="$3"

if [ -z "$name" ] || [ -z "$command" ] || [ -z "$binding" ]; then
    error "All arguments must be non-empty"
fi

if [[ "$name" == *'"'* ]] || [[ "$name" == *"'"* ]]; then
    error "Name must not contain quotes"
fi

if [[ "$command" == *'"'* ]] || [[ "$command" == *"'"* ]]; then
    error "Command must not contain quotes"
fi

if [ ${#name} -gt 256 ]; then
    error "Name too long (max 256 characters)"
fi

schema="org.gnome.settings-daemon.plugins.media-keys"
custom_schema="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
base_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
firstname="custom"

current=$(gsettings get "$schema" custom-keybindings)
# strip optional GVariant type annotation (e.g. "@as "), then outer [ ]
current="${current#@as }"
current="${current:1:-1}"

# Scan existing entries for name/binding conflicts
existing_path=""
if [ -n "$current" ]; then
    IFS=',' read -ra BINDINGS <<< "$current"
    for entry in "${BINDINGS[@]}"; do
        path="${entry## }"
        path="${path//\'/}"

        existing_name=$(gsettings get "${custom_schema}:${path}" name 2>/dev/null)
        existing_name="${existing_name//\'/}"

        existing_binding=$(gsettings get "${custom_schema}:${path}" binding 2>/dev/null)
        existing_binding="${existing_binding//\'/}"

        if [ "$existing_name" = "$name" ]; then
            existing_path="$path"
        elif [ "$existing_binding" = "$binding" ]; then
            error "Binding '$binding' is already used by '$existing_name'"
        fi
    done
fi

if [ -n "$existing_path" ]; then
    # Overwrite the existing entry with the same name
    gsettings set "${custom_schema}:${existing_path}" name "$name" || error "Failed to set name"
    gsettings set "${custom_schema}:${existing_path}" command "$command" || error "Failed to set command"
    gsettings set "${custom_schema}:${existing_path}" binding "$binding" || error "Failed to set binding"
    echo "Successfully updated keybinding '$name' with binding '$binding'"
else
    # Find next available slot
    n=1
    while [[ $current == *"'${base_path}/${firstname}${n}/'"* ]]; do
        n=$((n + 1))
    done

    new="'${base_path}/${firstname}${n}/'"

    if [ -z "$current" ]; then
        updated="[$new]"
    else
        updated="[$current, $new]"
    fi

    gsettings set "$schema" custom-keybindings "$updated" || error "Failed to set keybinding list"
    gsettings set "${custom_schema}:${base_path}/${firstname}${n}/" name "$name" || error "Failed to set name"
    gsettings set "${custom_schema}:${base_path}/${firstname}${n}/" command "$command" || error "Failed to set command"
    gsettings set "${custom_schema}:${base_path}/${firstname}${n}/" binding "$binding" || error "Failed to set binding"
    echo "Successfully added keybinding '$name' with binding '$binding'"
fi
