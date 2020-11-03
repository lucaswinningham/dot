Open a terminal.

Generate keys if they don't exist.

```bash
$ cat ~/.ssh/id_rsa.pub
$ ssh-keygen -t rsa # ↵
$ cat ~/.ssh/id_rsa.pub
$ touch ~/.ssh/config
```

Add the public key to GitHub.

Get the repo.

```bash
$ cd
$ git init
$ git remote add origin git@github.com:lucaswinningham/dot.git
$ git pull origin master
$ source .bashrc
$ git push --set-upstream origin master
```

[Install iTerm2](https://www.iterm2.com/downloads.html)

iTerm2 > Preferences

 - Profiles > Text > Font > 18

 - Profiles > Colors > Color Presets... > Import

   - Press CMD + SHIFT + . to get hidden files and folders to show

   - Navigate to ~/.iterm/

   - Select all

 - Profiles > Colors > Color Presets... > chalk

 - Profiles > Keys > Left Option Key: Esc+

 - Profiles > Keys > OPTION + LEFT

   - Action: Send Escape Sequence

   - Esc+: b

 - Profiles > Keys > OPTION + RIGHT

   - Action: Send Escape Sequence

   - Esc+: f

[Install Visual Studio Code](https://code.visualstudio.com/download)

 - Install Settings Sync by Shan Khan

   - Click LOGIN WITH GITHUB

   - Click Authorize shanalikhan

   - Select Visual Studio Code Settings Sync Gist

 - CMD + SHIFT + P

   - download settings

 - Multi-select case sensitive

   - Open a new file

   - COMMAND + OPTION + C

[Install Homebrew](https://brew.sh/)

```bash
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

[Install RVM with latest stable Ruby](https://usabilityetc.com/articles/ruby-on-mac-os-x-with-rvm/)

```bash
$ brew install gnupg
$ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
# if that fails then
# $ command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
# $ command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
$ \curl -L https://get.rvm.io | bash -s stable --ruby
$ source .bashrc
$ which ruby # should not be /usr/bin/ruby
```

Install Bundler

```bash
$ gem install bundler
```

Install PostgreSQL

```bash
$ brew install postgresql
$ brew services start postgresql
```

Install pgcli

```bash
$ brew install pgcli
```

Install Node

```bash
$ brew install node
```

Install Angular CLI

```bash
$ npm install -g @angular/cli@latest
```

Install RabbitMQ

```bash
$ brew install rabbitmq
```

```bash
$ source ~/.bashrc
# $ brew services start rabbitmq
$ rabbitmq-server
```

Install jq

```bash
brew install jq
```

Install tree

```bash
$ brew install tree
```

Install tmux

```bash
$ brew install tmux
```

Setup .native environment

```bash
$ cd && mkdir -p .native && cd .native && touch .profile
```

#### ~/.native/.profile

```bash
#!/usr/bin/env bash

this_dir="${BASH_SOURCE%/*}"

shopt -s dotglob # Include dotfiles ".*"

# Recursively iterates over directories looking for .sh files sourcing them if they exist
for dir in "$this_dir"/**/*/; do
  dir=$(echo "$dir" | sed 's/.$//') # Remove last character "/"

  for executable in "$dir"/*.sh; do
    [ -f "$executable" ] && source "$executable"
  done
done

shopt -u dotglob

unset executable
unset dir
unset this_dir

```

```bash
$ cd && cd .native && mkdir -p .tmux && touch .tmux/.restore.sh
```

#### ~/.native/.tmux/.restore.sh

```bash
#!/usr/bin/env bash

restore_tmux_work() {
  local session_name="work"
  local default_window_name="repo"

  tmux has-session -t "$session_name" &> /dev/null

  if [ $? != 0 ]; then
    tmux new-session -s "$session_name" -d
    _rebuild_session
    tmux select-window -t "$default_window_name"
  fi
}

_rebuild_session() {
  _rebuild_repo_window
  _rebuild_serve_window
  # _rebuild_test_window
  # _rebuild_lint_window
  # _rebuild_db_window
  # _rebuild_irb_window
  # _rebuild_ssh_window
  # _rebuild_bg_window
}

_rebuild_repo_window() {
  tmux rename-window repo

  _initialize_pane "~/code/api"

  # tmux split-window -v
  # _initialize_pane "~/code/web"

  # tmux split-window -v
  # _initialize_pane "~/code/mobile"

  # tmux select-layout even-vertical
}

_rebuild_serve_window() {
  tmux new-window -n serve

  _initialize_pane "~/code/api"
  tmux send-keys "rails s" Enter

  # tmux split-window -v
  # _initialize_pane "~/code/web"
  # tmux send-keys "npm run" Enter

  # tmux select-layout even-vertical
}

_initialize_pane() {
  local dir="$1"

  _source_profile
  tmux send-keys "cd $dir" Enter
  _clear_screen
}

_source_profile() {
  tmux send-keys "source ~/.bashrc" Enter
}

_clear_screen() {
  tmux send-keys clear Enter
  tnux clear-history # Not working
}

```

Reload bash

```bash
$ source ~/.bashrc
```

Make a code directory

```bash
$ cd
$ mkdir code
```

Remove ~/Downloads

```bash
$ rm ~/Downloads/*
```
