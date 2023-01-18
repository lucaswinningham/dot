#!/bin/zsh

DOT_VERBOSE=${DOT_VERBOSE:-true}

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

puts && puts "Aliases:"
source "$root_dir/aliases.zsh"

puts && puts "Visual Studio Code:"
source "$root_dir/visual_studio_code.zsh"

puts && puts "tmux:"
source "$root_dir/tmux.zsh"

puts && puts "  --- LOCAL ---"
source "$root_dir/local/index.zsh"

# Must be last in order for puts calls to display correctly!
# With `setopt promptsubst` in place before all others are initialized utilizing `puts`, it causes
#   echoing "\$$variable_name" to actually printing out the value!
puts && puts "Prompt:"
source "$root_dir/prompt.zsh"

puts && puts "Done."

source "$root_dir/functions/unset.zsh"
