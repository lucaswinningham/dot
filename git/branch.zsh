#!/bin/zsh

current=$(git rev-parse --abbrev-ref HEAD)
branches=$(git for-each-ref --format="%(refname)" refs/heads/ | sed "s|refs/heads/||")
longest_branch_name_size=0

green="\033[0;32m"
blue="\033[0;34m"
reset="\033[0m"

for branch in $branches; do
  branch_name_size=${#branch}

  if [ $branch_name_size -gt $longest_branch_name_size ]; then
    longest_branch_name_size=$branch_name_size
  fi
done

for branch in $branches; do
  note=$(git config branch.$branch.note)
  prefix="  "
  branch_name_size=${#branch}
  num_spacers=$(($longest_branch_name_size-$branch_name_size+3))
  spacer=""

  if [[ ! -z "$note" ]]; then
    spacer=$(seq 1 $num_spacers | sed "s/.*/\./" | tr -d "\n")
  fi

  if [ "$branch" == "$current" ]; then
    prefix="* ${green}"
  fi

  echo "$prefix$branch${reset}$spacer${blue}$note${reset}"
done
