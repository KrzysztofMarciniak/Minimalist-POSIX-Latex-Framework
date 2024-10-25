#!/usr/bin/env bash

reorder_sections() {
    exists_return_1 ".mplf.sections" "Error: .mplf.sections file not found." || return 1
    mapfile -t sections < .mplf.sections

    echo "Available sections:"
    for idx in "${!sections[@]}"; do
        echo "$idx: ${sections[$idx]}"
    done

    echo "Enter the new order of indices (e.g., '1 0 3 2'):"
    read -r new_order

    reordered_sections=()
    for index in $new_order; do
        if [[ "$index" =~ ^[0-9]+$ ]] && [[ "$index" -lt ${#sections[@]} ]]; then
            reordered_sections+=("${sections[$index]}")
        else
            echo "Invalid index '$index' detected. Aborting reordering."
            return 1
        fi
    done

    {
        for section in "${reordered_sections[@]}"; do
            echo "$section"
        done
    } > .mplf.sections

    echo "Sections reordered successfully."
}

define_command --reorder reorder_sections
