#!/bin/zsh

autoload -U colors && colors # black, red, green, yellow, blue, magenta, cyan, white

puts() {
  local kind="$1"
  local message="$2"
  local color
  declare -A color_map
  local color_map=( [info]=white [cmd]=blue [succ]=green [warn]=yellow [err]=red [mute]=black )

  # if message is null (has not been set / sent)
  if [ -z ${2+x} ]; then
    color=white
    message="$1" # set message to first arg
  else
    color="$color_map[$kind]"
    color=${color:-white}
  fi

  print -P "%F{$color}$message%f"
}
