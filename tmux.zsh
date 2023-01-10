#!/bin/zsh

tmux_dir="$root_dir/tmux"

add_to_variable "PATH" "$tmux_dir/bin" ":"

puts succ "tmux initialized."
