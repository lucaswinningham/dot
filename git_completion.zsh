#!/bin/zsh

# https://www.oliverspryn.com/blog/adding-git-completion-to-zsh

downloads_dir=$1

git_completion_bash_filepath="$downloads_dir/git-completion.bash"
git_completion_bash_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"

git_completion__git_filepath="$downloads_dir/_git"
git_completion__git_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh"

if [[ -a "$git_completion_bash_filepath" ]]; then
  puts succ "$git_completion_bash_filepath found, skipping download."
else
  puts warn "$git_completion_bash_filepath not found, downloading..."
  puts cmd "  curl $git_completion_bash_url -o \"$git_completion_bash_filepath\""
  curl "$git_completion_bash_url" -o "$git_completion_bash_filepath"
fi

if [[ -a "$git_completion__git_filepath" ]]; then
  puts succ "$git_completion__git_filepath found, skipping download."
else
  puts warn "$git_completion__git_filepath not found, downloading..."
  puts cmd "  curl $git_completion__git_url -o \"$git_completion__git_filepath\""
  curl "$git_completion__git_url" -o "$git_completion__git_filepath"
fi

zstyle ':completion:*:*:git:*' script "$git_completion_bash_filepath"
fpath=($downloads_dir $fpath)

autoload -Uz compinit && compinit

puts cmd "  rm \"$HOME/.zcompdump\"" && rm "$HOME/.zcompdump"

puts succ "Git completion ready."
