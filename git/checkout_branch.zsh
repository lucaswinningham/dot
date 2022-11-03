#!/bin/zsh

# Depends on `git note`!

branch_name=$1
rest=${@:2}

git checkout -b "$branch_name" && git note "$rest"
