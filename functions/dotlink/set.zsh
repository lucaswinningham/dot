#!/bin/zsh

dotlink() {
  local source_filepath="$1"
  local target_filepath="$2"

  if [[ ! -e "$source_filepath" ]]; then
    puts err "$source_filepath has a broken target!"

    read "confirm?Do you wish to replace $source_filepath with a symlink to $target_filepath? (Y/N): "

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      puts cmd "  rm \"$source_filepath\""
      rm "$source_filepath"
      puts cmd "  ln -s \"$target_filepath\" \"$source_filepath\""
      ln -s "$target_filepath" "$source_filepath"
    else
      puts err "$source_filepath left in place, configuration might be corrupted!"
    fi
  elif [[ -a $(readlink -f "$source_filepath") ]]; then
    if [[ $(readlink -f "$source_filepath") != "$target_filepath" ]]; then
      puts err "$source_filepath found but is not properly linked to $target_filepath!"

      read "confirm?Do you wish to replace $source_filepath with a symlink to $target_filepath? (Y/N): "

      if [[ "$confirm" =~ ^[Yy]$ ]]; then
        puts cmd "  rm \"$source_filepath\""
        rm "$source_filepath"
        puts cmd "  ln -s \"$target_filepath\" \"$source_filepath\""
        ln -s "$target_filepath" "$source_filepath"
      else
        puts err "$source_filepath left in place, configuration might be corrupted!"
      fi
    else
      puts succ "$source_filepath properly linked to $target_filepath, skipping."
    fi
  else
    puts warn "$source_filepath not found, creating symlink..."
    puts cmd "  ln -s \"$target_filepath\" \"$source_filepath\""
    ln -s "$target_filepath" "$source_filepath"
  fi
}
