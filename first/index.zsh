#!/bin/zsh

first_dir=${0:a:h}

puts "Running first time setup..."

puts && puts "Dot:"
source "$first_dir/dot/index.zsh"

puts && puts "Zsh:"
source "$first_dir/zsh/index.zsh"

puts && puts "SSH:"
source "$first_dir/ssh/index.zsh"

puts && puts "Git:"
source "$first_dir/git/index.zsh"

puts && puts "Homebrew:"
source "$first_dir/homebrew/index.zsh"

puts && puts "Ruby:"
source "$first_dir/ruby/index.zsh"

puts && puts "tmux:"
source "$first_dir/tmux/index.zsh"

puts && puts "Done."
