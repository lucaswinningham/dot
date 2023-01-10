#!/bin/zsh

root_dir=$(readlink -f ${0:a:h})

echo "$root_dir"

source "$root_dir/functions/set.zsh"
source "$root_dir/init/index.zsh"
source "$root_dir/functions/unset.zsh"
