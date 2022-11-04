#!/bin/zsh

# autoload -Uz add-zsh-hook vcs_info
autoload -U colors && colors # black, red, green, yellow, blue, magenta, cyan, white

precmd() {
  # vcs_info

  git_status="$(git status --long 2> /dev/null)"

  if [[ -z "$git_status" ]]; then
    PROMPT='%F{blue}%~ %F{white}$%f '
  else
    git_branch="$(git branch --show-current)"

    if [[ "$git_status" == *"Changes not staged for commit"* ]]; then
      PROMPT='%F{blue}%~ %F{red}[${git_branch}] %F{white}$%f '
    elif [[ "$git_status" == *"Changes to be committed"* ]]; then
      PROMPT='%F{blue}%~ %F{yellow}[${git_branch}] %F{white}$%f '
    elif [[ "$git_status" == *"Your branch is ahead of"* ]]; then
      PROMPT='%F{blue}%~ %F{white}[${git_branch}] %F{white}$%f '
    elif [[ "$git_status" == *"nothing to commit, working tree clean"* ]]; then
      PROMPT='%F{blue}%~ %F{green}[${git_branch}] %F{white}$%f '
    else
      PROMPT='%F{blue}%~ %F{magenta}[${git_branch}] %F{white}$%f '
    fi
  fi

  # if [[ -n ${git_status} ]]; then
  #   git_status=$(command git status --long 2> /dev/null)

  #   if [[ -n $git_status ]]; then
  #     PROMPT='%F{blue}%~ %F{red}[${branch}] %F{white}$%f '
  #   else
  #     PROMPT='%F{blue}%~ %F{green}[${branch}] %F{white}$%f '
  #   fi
  # else
  #   PROMPT='%F{blue}%~ %F{white}$%f '
  # fi

  # if [[ -n ${vcs_info_msg_0_} ]]; then
  #   status=$(command git status --long 2> /dev/null)

  #   if [[ -n $status ]]; then
  #     PROMPT='%F{blue}%~ %F{red}${vcs_info_msg_0_} %F{white}$%f '
  #   else
  #     PROMPT='%F{blue}%~ %F{green}${vcs_info_msg_0_} %F{white}$%f '
  #   fi
  # else
  #   PROMPT='%F{blue}%~ %F{white}$%f '
  # fi
}

# zstyle ':vcs_info:git:*' formats "[%b]"

setopt promptsubst

# https://salferrarello.com/zsh-git-status-prompt/

# precmd() { vcs_info }
# PROMPT='%F{blue}%~${vcs_info_msg_0_} %F{white}$%f '

# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' unstagedstr ' %F{red}*'
# zstyle ':vcs_info:*' stagedstr ' %F{yellow}+'
# zstyle ':vcs_info:git:*' formats " %F{white}[%b]%u%c%f"
# zstyle ':vcs_info:git:*' actionformats " %F{white}[%b]|%F{magenta}%a%u%c%f"

# https://medium.com/pareture/simplest-zsh-prompt-configs-for-git-branch-name-3d01602a6f33

# function git_branch_name()
# {
#   branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
#   if [[ $branch == "" ]];
#   then
#     :
#   else
#     echo '- ('$branch')'
#   fi
# }

# # Enable substitution in the prompt.
# setopt prompt_subst

# # Config for prompt. PS1 synonym.
# prompt='%2/ $(git_branch_name) > '

puts succ "Prompt initialized."
