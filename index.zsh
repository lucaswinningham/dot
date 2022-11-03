#!/bin/zsh

root_dir=${0:a:h}

source "$root_dir/functions/set.zsh"

puts "Initializing..."

puts && puts "openssl:"
source "$root_dir/openssl.zsh"

puts && puts "zlib:"
source "$root_dir/zlib.zsh"

puts && puts cmd "  mkdir -p \"$root_dir/downloads\"" && mkdir -p "$root_dir/downloads"

puts && puts "Git Completion:"
source "$root_dir/git_completion.zsh" "$root_dir/downloads"

puts && puts "RVM:"
source "$root_dir/rvm.zsh"

puts && puts "Prompt:"
source "$root_dir/prompt.zsh"

puts && puts "Aliases:"
source "$root_dir/aliases.zsh"

puts && puts "Visual Studio Code:"
source "$root_dir/visual_studio_code.zsh"

puts && puts "tmux:"
source "$root_dir/tmux.zsh"

puts && puts "  --- LOCAL ---"
source "$root_dir/local/index.zsh"

puts && puts "Done."

source "$root_dir/functions/unset.zsh"
