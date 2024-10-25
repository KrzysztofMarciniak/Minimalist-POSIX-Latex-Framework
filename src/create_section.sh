#!/usr/bin/env bash

create_section() {
    if [[ -z "$1" ]]; then
        echo "Error: Section name is required."
        return 1
    fi

    local section_name="$1"
    local section_dir="${section_name}/"
    local section_main_tex="${section_dir}main.tex"

    exists_return_1 ".mplf.project" "Error: .mplf.project file not found in the project directory." || return 1
    exists_return_1 ".mplf.sections" "Error: .mplf.sections file not found in the project directory." || return 1

    mkdir -p "$section_dir"
    if [[ ! -f "$section_main_tex" ]]; then
        create_section_maintex "$section_name" "$(pwd)" 
        echo "main.tex created for section '$section_name'."
    fi

    add_section_to_mplf_sections "$section_name"
    echo "Section '$section_name' setup complete."
}

define_command --create create_section

