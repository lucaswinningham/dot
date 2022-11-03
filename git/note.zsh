#!/bin/zsh

if [ "$#" -eq 0 ]; then
  git config branch."$(git branch --show-current)".note
else
  git config --replace-all branch."$(git branch --show-current)".note "$*"
fi
