#!/usr/bin/env bash
create_section_maintex() {
    local section_name="$1"
    local project_dir="$2" 
    local section_dir="${project_dir}/${section_name}"
    local section_tex="${section_dir}/main.tex"

    if [[ ! -d "$project_dir" ]]; then
        echo "Error: Project directory '$project_dir' does not exist."
        return 1
    fi

    mkdir -p "$section_dir"

    {
        echo "\\section{${section_name^}}"
        echo ""
        echo "% Content for the $section_name section goes here."
    } > "$section_tex"
}
