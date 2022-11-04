#!/bin/zsh

zlib_dir="/usr/local/opt/zlib"

add_to_variable "PKG_CONFIG_PATH" "$zlib_dir/lib/pkgconfig" ":"
add_to_variable "LDFLAGS" "-L$zlib_dir/lib" " "
add_to_variable "CPPFLAGS" "-I$zlib_dir/include" " "

puts succ "zlib initialized."
