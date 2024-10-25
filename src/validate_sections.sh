#!/usr/bin/env bash

validate_sections() {
    exists_return_1 ".mplf.sections" "" || return 0
    mapfile -t sections < .mplf.sections
    missing_sections=()

    for section in "${sections[@]}"; do
        if [[ ! -d "$section" ]]; then
            echo "Directory for section '$section' not found."
            missing_sections+=("$section")
        fi
    done

    if [[ ${#missing_sections[@]} -gt 0 ]]; then
        for missing in "${missing_sections[@]}"; do
            read -r -p "Would you like to create the directory for section '$missing'? (y/n) " response
            if [[ "$response" == "y" ]]; then
                mkdir -p "$missing"
                echo "Directory created for section '$missing'."
                create_section_maintex "$missing"
            else
                echo "Skipped creation for section '$missing'."
            fi
        done
    fi

    orphaned_dirs=()
    for dir in */; do
        dir="${dir%/}" # Strip trailing slash
        if [[ ! " ${sections[*]} " =~ " $dir " ]]; then
            orphaned_dirs+=("$dir")
        fi
    done

    if [[ ${#orphaned_dirs[@]} -gt 0 ]]; then
        for orphan in "${orphaned_dirs[@]}"; do
            read -r -p "Would you like to add '$orphan' to .mplf.sections? (y/n) " response
            if [[ "$response" == "y" ]]; then
                echo "$orphan" >> .mplf.sections
                echo "'$orphan' added to .mplf.sections."
            else
                echo "Skipped adding '$orphan' to .mplf.sections."
            fi
        done
    fi
}

validate_sections
