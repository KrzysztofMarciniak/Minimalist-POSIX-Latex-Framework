#!/usr/bin/env bash

delete_section() {
    if [[ -z "$1" ]]; then
        echo "Section name is required."
        return 1
    fi

    local section_name="$1"
    exists_return_1 ".mplf.sections" "Error: .mplf.sections file not found. Cannot delete section." || return 1
    if [[ ! -d "$section_name" ]]; then
        echo "Error: Section '$section_name' does not exist."
        return 1
    fi

    rm -rf "$section_name"
    echo "Deleted section directory '$section_name'."

    sed -i "\|^$section_name\$|d" .mplf.sections
    echo "Removed '$section_name' from .mplf.sections."
}

define_command --delete delete_section
