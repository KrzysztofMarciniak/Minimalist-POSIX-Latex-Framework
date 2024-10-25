#!/usr/bin/env bash

exists_return_1() {
    local filename="$1"
    local message="$2"

    if [[ ! -f "$filename" ]]; then
        echo "$message"
        return 1
    fi
}
