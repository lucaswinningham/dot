# Dot

First, open a terminal window and change the preferred shell to zsh.

```zsh
chsh -s $(which zsh)
```

Clone the repo from wherever ($HOME is a good place) then run the first time script which will print out the ssh key.

```zsh
cd # or wherever
git clone https://github.com/lucaswinningham/dot.git
./dot/first/index.zsh
```

Copy the public key and add it to your GitHub's SSH and GPG keys settings.

[Install iTerm2](https://www.iterm2.com/downloads.html)

Update iTerm2's settings from the backup by first opening the application then:

iTerm2 > Preferences > Profiles > Other Actions > Import JSON Profiles...

Navigate to `$HOME/.dot/iTerm/profile.json` then > Open. The profile named "Dot" should appear in the list of profiles. Select "Dot" then Other Actions > Set as Default.

[Install Visual Studio Code](https://code.visualstudio.com/download)

 - Install the extension Settings Sync by Shan Khan

   - Click LOGIN WITH GITHUB

   - Click Authorize shanalikhan

   - Select Visual Studio Code Settings Sync Gist

 - CMD + SHIFT + P

   - download settings

Install Node

```zsh
brew install node
```

Setup .native environment

```zsh
cd && mkdir -p .native && cd .native && touch .profile
```

#### $HOME/.native/.profile

```zsh
#!/usr/bin/env bash

this_dir="${BASH_SOURCE%/*}"

# Recursively iterates over directories looking for .sh files sourcing them if they exist
for executable in $(find "$this_dir" -regex ".*\.sh"); do
  [ -f "$executable" ] && source "$executable"
done

unset this_dir

```

```zsh
cd && cd .native && mkdir -p .tmux && touch .tmux/.restore.sh
```

#### $HOME/.native/.tmux/.restore.sh

```zsh
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

  _initialize_pane "$HOME/code/api"

  # tmux split-window -v
  # _initialize_pane "$HOME/code/web"

  # tmux split-window -v
  # _initialize_pane "$HOME/code/mobile"

  # tmux select-layout even-vertical
}

_rebuild_servers_window() {
  tmux new-window -n servers

  _initialize_pane "$HOME/code/api"
  tmux send-keys "rails s" Enter

  # tmux split-window -v
  # _initialize_pane "$HOME/code/web"
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
  tmux send-keys "source $HOME/.bashrc" Enter
}

_clear_screen() {
  tmux send-keys clear Enter
  tmux clear-history # Not working
}

```

Make `$HOME/.bashrc` point to `$HOME/.zshrc`.

#### $HOME/.bashrc

```bash
#!/usr/bin/env bash

source "$HOME/.zshrc"

```

Reload the environment.

```zsh
source "$HOME/.zshrc"
```

Make a code directory.

```zsh
cd

mkdir -p code

```

Remove `$HOME/Downloads`.

```zsh
rm "$HOME/Downloads/*"
```

### Checks

Make sure that the Ruby executable is coming from rvm.

```zsh
$ which ruby
[$HOME]/.rvm/rubies/ruby-[RUBY_VERSION]/bin/ruby # SHOULD NOT BE /usr/bin/ruby
```
