#!/bin/zsh

local_dir=${0:a:h}

puts && puts "bin:"
add_to_variable "PATH" "$HOME/.dot/local/bin" ":"

# puts && puts "Custom:"
# source "$local_dir/custom.zsh"
