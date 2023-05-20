#!/bin/zsh

if which brew > /dev/null; then
  puts succ "Homebrew installed, updating..."
  puts cmd "  brew update"
  brew update
else
  puts warn "Homebrew not installed, installing..."

  puts cmd "  /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  puts cmd "  eval \"$(/opt/homebrew/bin/brew shellenv)\""
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

homebrew_dir=${0:a:h}

source "$homebrew_dir/gpg.zsh"
source "$homebrew_dir/jq.zsh"
source "$homebrew_dir/tmux.zsh"
source "$homebrew_dir/tree.zsh"
