#!/bin/zsh

# ls
alias ls="command ls -G"
alias l='ls -F1'
alias la='ls -laFh'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# history
alias history='history -in 0'

# man
alias man='MANPAGER=cat man'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Recursively delete `.DS_Store` files
alias clean_DS_Store="find . -type f -name '*.DS_Store' -ls -delete"

puts succ "Aliases set."
