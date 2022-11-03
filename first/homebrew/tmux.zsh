#!/bin/zsh

if which tmux > /dev/null; then
  puts succ "tmux installed, skipping installation."
else
  puts warn "tmux not installed, installing..."
  puts cmd "  brew install tmux"
  brew install tmux
fi
