#!/bin/zsh

DOT_VERBOSE=${DOT_VERBOSE:-true}

init_dir=${0:a:h}

puts "Running initialization setup..."

puts && puts "Dot:"
source "$init_dir/dot/index.zsh"

puts && puts "Zsh:"
source "$init_dir/zsh/index.zsh"

puts && puts "SSH:"
source "$init_dir/ssh/index.zsh"

puts && puts "Git:"
source "$init_dir/git/index.zsh"

puts && puts "Homebrew:"
source "$init_dir/homebrew/index.zsh"

puts && puts "Ruby:"
source "$init_dir/ruby/index.zsh"

puts && puts "tmux:"
source "$init_dir/tmux/index.zsh"

puts && puts "Done."
