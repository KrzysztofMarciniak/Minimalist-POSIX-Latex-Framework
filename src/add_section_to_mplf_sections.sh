#!/usr/bin/env bash

add_section_to_mplf_sections() {
    if [[ -z "$1" ]]; then
        echo "Section name is required."
        return 1
    fi

    local section_name="$1"
    exists_return_1 ".mplf.sections" "Error: .mplf.sections file not found in the project directory." || return 1

    if ! grep -Fxq "$section_name" .mplf.sections; then
        echo "$section_name" >> .mplf.sections
        echo "Section '$section_name' added to .mplf.sections."
    else
        echo "Section '$section_name' is already listed in .mplf.sections."
    fi
}
