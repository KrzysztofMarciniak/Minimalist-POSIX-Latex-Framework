#!/usr/bin/env bash

declare -g -A commands

define_command() {
    local command_name="$1"
    local command_func="$2"
    commands["$command_name"]="$command_func"
}
