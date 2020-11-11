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

 - [The following hex codes were found using xxd command and are used for tmux](https://stackoverflow.com/questions/36321230/finding-the-hex-code-sequence-for-a-key-combination)

 - Profiles > Keys > Add

   - Keyboard Shortcut: OPTION + COMMAND + UP

   - Action: Send Hex Code

   - 0x1b 0x5b 0x31 0x3b 0x32 0x41

     - maps to SHIFT + UP

 - Profiles > Keys > Add

   - Keyboard Shortcut: OPTION + COMMAND + DOWN

   - Action: Send Hex Code

   - 0x1b 0x5b 0x31 0x3b 0x32 0x42

     - maps to SHIFT + DOWN

 - Profiles > Keys > Add

   - Keyboard Shortcut: OPTION + COMMAND + RIGHT

   - Action: Send Hex Code

   - 0x1b 0x5b 0x31 0x3b 0x32 0x43

     - maps to SHIFT + RIGHT

 - Profiles > Keys > Add

   - Keyboard Shortcut: OPTION + COMMAND + LEFT

   - Action: Send Hex Code

   - 0x1b 0x5b 0x31 0x3b 0x32 0x44

     - maps to SHIFT + LEFT

 - Profiles > Keys > Add

   - Keyboard Shortcut: COMMAND + RIGHT

   - Action: Send Hex Code

   - 0x1a 0x1b 0x5b 0x43

     - maps to CTRL + Z + RIGHT

 - Profiles > Keys > Add

   - Keyboard Shortcut: COMMAND + LEFT

   - Action: Send Hex Code

   - 0x1a 0x1b 0x5b 0x44

     - maps to CTRL + Z + LEFT

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

# Recursively iterates over directories looking for .sh files sourcing them if they exist
for executable in $(find "$this_dir" -regex ".*\.sh"); do
  [ -f "$executable" ] && source "$executable"
done

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

  tmux has-session -t "$session_name" &> /dev/null

  if [ $? != 0 ]; then
    tmux new-session -s "$session_name" -d
    _rebuild_session
    tmux select-window -t repos
  fi

  tmux attach -t "$session_name"

  return 0
}

_rebuild_session() {
  _rebuild_repos_window
  _rebuild_servers_window
  # _rebuild_testers_window
  # _rebuild_linters_window
  # _rebuild_dbs_window
  # _rebuild_irb_window
  # _rebuild_ssh_window
  # _rebuild_bg_window
}

_rebuild_repos_window() {
  tmux rename-window repos

  _initialize_pane "~/code/api"

  # tmux split-window -v
  # _initialize_pane "~/code/web"

  # tmux split-window -v
  # _initialize_pane "~/code/mobile"

  # tmux select-layout even-vertical
}

_rebuild_servers_window() {
  tmux new-window -n servers

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
  tmux clear-history # Not working
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
