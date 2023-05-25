# Dot

## Set up

### Shell

First, open a terminal window and change the preferred shell to zsh.

```zsh
chsh -s $(which zsh)
```

### Xcode

Ensure `xcode` is installed.

```zsh
git --help || xcode-select --install
```

### Repository

Clone the repo from wherever (`$HOME` is a good place) then run the initialization script which will print out the ssh key. This script is idempotent so if something goes awry, feel free to fix and run again.

```zsh
cd # or wherever
git clone https://github.com/lucaswinningham/dot.git
```

### Initialization

```zsh
# cd .../dot
./dot/init.zsh
```

### GitHub

Copy the public key and add it to your [GitHub's SSH and GPG keys settings](https://github.com/settings/keys).

### iTerm

[Install iTerm2](https://www.iterm2.com/downloads.html)

Update iTerm2's settings from backup by first opening the application then:

iTerm2 > Settings > Profiles > Other Actions > Import JSON Profiles...

Navigate to `$HOME/.dot/iTerm/profile.json` then > Open. The profile named "Dot" should appear in the list of profiles. Select "Dot" then Other Actions > Set as Default.

Open a new terminal session to start with the new profile.

### Visual Studio Code

[Install Visual Studio Code](https://code.visualstudio.com/download)

Update Visual Studio Code's settings from backup by first opening the application then:

Left Toolbar > Accounts > Turn on Settings Sync... > Sign in & Turn on > Sign in with GitHub

### `run`

Run `run`, a command for personalizing local machine commands. See `.../dot/local/bin/run` for customizing the command and `.../dot/local/tmux/work.yaml` for the tmux configuration file.

```zsh
run work up
```

## Clean up

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

## Check

Make sure that the Ruby executable is coming from rvm.

```zsh
$ which ruby
[$HOME]/.rvm/rubies/ruby-[RUBY_VERSION]/bin/ruby # SHOULD NOT BE /usr/bin/ruby
```

## Local

`.../dot/local/**/*` is where we'll find everything we can set up for a specific machine but not exactly set up for all machines.

A good example of this would be if our work machine requires `PostgreSQL`. After installation, we would see something like:

```zsh
If you need to have postgresql@13 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/postgresql@13/bin:$PATH"' >> ~/.zshrc

For compilers to find postgresql@13 you may need to set:
  export LDFLAGS="-L/usr/local/opt/postgresql@13/lib"
  export CPPFLAGS="-I/usr/local/opt/postgresql@13/include"

For pkg-config to find postgresql@13 you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/postgresql@13/lib/pkgconfig"


To restart postgresql@13 after an upgrade:
  brew services restart postgresql@13
Or, if you don't want/need a background service you can just run:
  /usr/local/opt/postgresql@13/bin/postgres -D /usr/local/var/postgresql@13
```

In this case, we want to add a file `.../dot/local/postgresql.zsh` with:

```zsh
#!/bin/zsh

# If you need to have postgresql@13 first in your PATH, run:
#   echo 'export PATH="/usr/local/opt/postgresql@13/bin:$PATH"' >> ~/.zshrc

# For compilers to find postgresql@13 you may need to set:
#   export LDFLAGS="-L/usr/local/opt/postgresql@13/lib"
#   export CPPFLAGS="-I/usr/local/opt/postgresql@13/include"

# For pkg-config to find postgresql@13 you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/postgresql@13/lib/pkgconfig"


# To restart postgresql@13 after an upgrade:
#   brew services restart postgresql@13
# Or, if you don't want/need a background service you can just run:
#   /usr/local/opt/postgresql@13/bin/postgres -D /usr/local/var/postgresql@13

postgresql_dir="/usr/local/opt/postgresql@13"

add_to_variable "PATH" "$postgresql_dir/bin" ":"
add_to_variable "LDFLAGS" "-L$postgresql_dir/lib" " "
add_to_variable "CPPFLAGS" "-I$postgresql_dir/include" " "
add_to_variable "PKG_CONFIG_PATH" "$postgresql_dir/lib/pkgconfig" ":"

puts succ "PostgreSQL initialized."

```

The last line, `/usr/local/opt/postgresql@13/bin/postgres -D /usr/local/var/postgresql@13`, could be implemented in a tmux configuration file pane; see `.../dot/local/tmux/work.yaml`

Then we want to reference `.../dot/local/postgresql.zsh` from `.../dot/local/index.zsh` so it will be called every time when we start a new session:

```zsh
#!/bin/zsh

...

puts && puts "PostgreSQL:"
source "$local_dir/postgresql.zsh"

```

For more information on `add_to_variable`, `puts` or any other function available for use during session or initialization setup, see `.../dot/functions/**/*`.

`DOT_VERBOSE` is a configurable environment variable in `.../dot/init/index.zsh` during initialization and `.../dot/index.zsh` during session startup. Setting this to anything other than `true` will quiet the stdout output during the respective phases.

### Default changes

To make changes to a default local file, run:

```zsh
git add --force local/[file]
```

Then commit and push as normal.

## Additional setup

### Node / NVM / NPM / Yarn

```zsh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

Which outputs:

```zsh
...
=> Close and reopen your terminal to start using nvm or run the following to use it now:

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

Which means that it automatically added those lines to the end of the `~/.zshrc` file which is symlinked to our `zshrc` file here. Remove those lines from `.../dot/zshrc` to keep it clean then add a file `.../dot/local/nvm.zsh` with those lines instead:

```zsh
#!/bin/zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

puts succ "NVM initialized."

```

Then add to `.../dot/local/index.zsh` with:

```zsh
...

puts && puts "NVM"
source "$local_dir/nvm.zsh"

```

Reload the environment.

```zsh
source "$HOME/.zshrc"
```

And we should see successful `NVM` diagnostics:

```zsh
command -v nvm
nvm -v
```

Next, install the latest LTS `Node` via `NVM`:

```zsh
nvm install --lts
```

And we should see successful `Node` and `NPM` diagnostics:

```zsh
command -v node
node -v
command -v npm
npm -v
```

Next, activate the latest stable `Yarn` via `corepack`:

```zshrc
corepack enable
corepack prepare yarn@stable --activate
```

And we should see successful `Yarn` diagnostics:

```zsh
command -v yarn
yarn -v
```
