#!/bin/zsh

if gem which bundler > /dev/null; then
  puts succ "Bundler gem installed, skipping installation."
else
  puts warn "Bundler gem not installed, installing..."
  puts cmd "  gem install bundler"
  gem install bundler
fi
