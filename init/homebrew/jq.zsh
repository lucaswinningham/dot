#!/bin/zsh

if which jq > /dev/null; then
  puts succ "jq installed, skipping installation."
else
  puts warn "jq not installed, installing..."
  puts cmd "  brew install jq"
  brew install jq
fi
