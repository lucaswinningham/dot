#!/bin/zsh

puts cmd "  eval \"$(/opt/homebrew/bin/brew shellenv)\""
eval "$(/opt/homebrew/bin/brew shellenv)"

puts succ "Homebrew initialized."
