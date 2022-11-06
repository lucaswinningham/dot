#!/bin/zsh

autoload -U colors && colors # black, red, green, yellow, blue, magenta, cyan, white

# https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html
# https://github.com/joshdick/dotfiles/blob/main/zshrc.symlink

ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo "%(!.%F{red}.%F{yellow})%n%f@%F{green}%m%f:" || echo ""
}

git_info() {
  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local git_location=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local ahead="%F{red}⇡NUM%f"
  local behind="%F{cyan}⇣NUM%f"
  local merging="%F{magenta}⚡︎%f"
  local untracked="%F{red}●%f"
  local modified="%F{yellow}●%f"
  local staged="%F{green}●%f"

  local -a divergences
  local -a flags

  local num_ahead="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$num_ahead" -gt 0 ]; then
    divergences+=( "${ahead//NUM/$num_ahead}" )
  fi

  local num_behind="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$num_behind" -gt 0 ]; then
    divergences+=( "${behind//NUM/$num_behind}" )
  fi

  local git_dir="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $git_dir ] && test -r $git_dir/MERGE_HEAD; then
    flags+=( "$merging" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    flags+=( "$untracked" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    flags+=( "$modified" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    flags+=( "$staged" )
  fi

  local -a info
  info+=( "%F{white}$git_location%f" )
  [[ ${#divergences[@]} -ne 0 ]] && info+=( "${(j::)divergences}" )
  [[ ${#flags[@]} -ne 0 ]] && info+=( "${(j::)flags}" )
  echo "${(j: :)info} "
}

PS1="\$(ssh_info)%F{blue}%~ \$(git_info)%F{white}$%f "

setopt promptsubst

puts succ "Prompt initialized."
