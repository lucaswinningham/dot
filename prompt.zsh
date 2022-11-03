#!/bin/zsh

autoload -Uz add-zsh-hook vcs_info
autoload -U colors && colors # black, red, green, yellow, blue, magenta, cyan, white

precmd() {
  vcs_info

  # git branch --show-current
  # local git_status="$(git status 2> /dev/null)"

  # if [[ $git_status == *"Changes not staged for commit"* ]]; then
  #   echo -e $RED
  # elif [[ $git_status == *"Changes to be committed"* ]]; then
  #   echo -e $YEL
  # elif [[ $git_status == *"Your branch is ahead of"* ]]; then
  #   echo -e $WHI
  # elif [[ $git_status == *"nothing to commit, working tree clean"* ]]; then
  #   echo -e $GRN
  # else
  #   echo -e $PUR
  # fi

  if [[ -n ${vcs_info_msg_0_} ]]; then
    STATUS=$(command git status --porcelain 2> /dev/null)

    if [[ -n $STATUS ]]; then
      PROMPT='%F{blue}%~ %F{red}${vcs_info_msg_0_} %F{white}$%f '
    else
      PROMPT='%F{blue}%~ %F{green}${vcs_info_msg_0_} %F{white}$%f '
    fi
  else
    PROMPT='%F{blue}%~ %F{white}$%f '
  fi
}

zstyle ':vcs_info:git:*' formats "[%b]"

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

puts succ "Prompt set."
