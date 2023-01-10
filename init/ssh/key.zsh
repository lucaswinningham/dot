#!/bin/zsh

# https://gist.github.com/hongkongkiwi/fff178c3243ae5aaff8e

key_filepath="$HOME/.ssh/id_rsa"

if [[ -a "$key_filepath" ]]; then
  puts succ "$key_filepath.pub found, skipping key generation."
else
  puts warn "$key_filepath.pub not found, generating keys..."
  puts cmd "  ssh-keygen -t rsa -C \"`hostname`\" -f \"$key_filepath\" -P \"\""
  ssh-keygen -t rsa -C "`hostname`" -f "$key_filepath" -P ""
fi

echo $(cat "$key_filepath.pub")
