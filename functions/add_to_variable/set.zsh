#!/bin/zsh

add_to_variable() {
  local variable_name="$1"
  local addition="$2"
  local delimiter="$3"
  local variable_value=${(P)variable_name}

  # TODO: echoing "\$$variable_name" is actually printing out the value!

  if [[ -z "${variable_value// }" ]]; then
    puts warn "\$$variable_name undefined, setting..."
    local cmd="export $variable_name=\"$addition\""
    puts cmd "  $cmd"
    eval ${(e)cmd}
  elif [[ ${PATH} != *"$addition"* ]]; then
    puts warn "$addition not found in \$$variable_name, adding..."
    local cmd="export $variable_name=\"\$$variable_name$delimiter$addition\""
    puts cmd "  $cmd"
    eval ${(e)cmd}
  else
    puts succ "$addition found in \$$variable_name, skipping."
  fi
}
