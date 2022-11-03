#!/bin/zsh

mytmux_dir="$root_dir/tmux"

mytmux_path="$mytmux_dir/bin"

# TODO: clean up with openssl.zsh, zlib.zsh
if [[ -z "${PATH// }" ]]; then
  puts warn "PATH undefined, setting..."
  puts cmd "  export PATH=\"$mytmux_path\""
  export PATH="$mytmux_path"
elif [[ ${PATH} != *"$mytmux_path"* ]]; then
  puts warn "$mytmux_path not found in PATH, adding..."
  puts cmd "  export PATH=\"$mytmux_path:\$PATH\""
  export PATH="$mytmux_path:$PATH"
else
  puts succ "$mytmux_path found in PATH, skipping."
fi

# TODO
# puts cmd "  bundle update --gemfile=\"$root_dir/tmux/Gemfile\""
# bundle update --gemfile="$root_dir/tmux/Gemfile"

# puts cmd "  bundle clean --force --gemfile=\"$root_dir/tmux/Gemfile\""
# bundle clean --force --gemfile="$root_dir/tmux/Gemfile"

puts succ "mytmux available."
