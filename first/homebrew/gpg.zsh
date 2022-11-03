#!/bin/zsh

if which gpg > /dev/null; then
  puts succ "gpg installed, skipping installation."
else
  puts warn "gpg not installed, installing..."
  puts cmd "  brew install gnupg"
  brew install gnupg
fi

