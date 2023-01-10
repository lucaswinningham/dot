#!/bin/zsh

if which tree > /dev/null; then
  puts succ "tree installed, skipping installation."
else
  puts warn "tree not installed, installing..."
  puts cmd "  brew install tree"
  brew install tree
fi
