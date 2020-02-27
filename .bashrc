#!/usr/bin/env bash

safe_source() {
  local file="$1"
  [ -r "$file" ] && [ -f "$file" ] && [ -s "$file" ] && source "$file"
}

#
# Profiles
#

for file in ~/{.native/.profile,.rvm/scripts/rvm}; do
  safe_source "$file"
done;
unset file;

#
# Imports
#

if [ ! -f ~/.git_completion ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git_completion
fi

for file in ~/.{functions,aliases,git_completion,colors,path,prompt,overrides}; do
  safe_source "$file"
done;
unset file;
