#!/bin/zsh

visual_studio_dir="/Applications/Visual Studio Code.app/Contents/Resources/app"

add_to_variable "PATH" "$visual_studio_dir/bin" ":"

puts succ "Visual Studio Code ready."
