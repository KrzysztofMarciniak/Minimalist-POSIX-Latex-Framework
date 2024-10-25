#!/usr/bin/env bash

init() {
    if [[ -z "$1" ]]; then
        echo "Project name is required."
        return 1
    fi

    project_name="$1"

    mkdir "$project_name" && cd "$project_name" || return

    touch main.tex

    touch .mplf.sections

    {
        echo "name: $project_name"
        echo "created: $(date +"%Y-%m-%d %H:%M:%S")"
    } > .mplf.project

    echo "Project '$project_name' initialized successfully."
}

define_command --init init
