# Dot

## Set up

First, open a terminal window and change the preferred shell to zsh.

```zsh
chsh -s $(which zsh)
```

Test that xcode is installed and install it if not.

```zsh
git
xcode-select --install
```

Clone the repo from wherever ($HOME is a good place) then run the initialization script which will print out the ssh key. This script is idempotent so if something goes awry, feel free to fix and run again.

```zsh
cd # or wherever
git clone https://github.com/lucaswinningham/dot.git
./dot/init.zsh
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

Run `run`, a command for personalizing local machine commands.

```zsh
run work up
```

<!-- Make `$HOME/.bashrc` point to `$HOME/.zshrc`.

#### $HOME/.bashrc

```bash
#!/usr/bin/env bash

source "$HOME/.zshrc"

``` -->

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
