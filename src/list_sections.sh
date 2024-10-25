#!/usr/bin/env bash

list_sections() {
    if [[ ! -f .mplf.sections ]]; then
        echo "No sections file found. Please initialize a project first."
        return 1
    fi

    echo "Available Sections:"
    local index=1
    while IFS= read -r section; do
        echo "$index: $section"
        ((index++))
    done < .mplf.sections
}

define_command --list list_sections
