#!/bin/zsh

git diff --color "$@" | sed -E 's/^([^-+ ]*)[-+ ]/\1/'
