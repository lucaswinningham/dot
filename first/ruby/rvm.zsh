#!/bin/zsh

puts cmd "  source $HOME/.rvm/scripts/rvm" && source "$HOME/.rvm/scripts/rvm"

if which rvm > /dev/null; then
  puts succ 'RVM installed, skipping installation.'
else
  puts warn "RVM not installed, installing..."
  puts cmd "  gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
  gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  puts cmd "  \curl -L https://get.rvm.io | bash -s stable --ruby"
  \curl -L https://get.rvm.io | bash -s stable --ruby
  puts cmd "  source \"$HOME/.rvm/scripts/rvm\""
  source "$HOME/.rvm/scripts/rvm"
fi
