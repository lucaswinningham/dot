#!/bin/zsh

openssl_dir=$(brew --prefix openssl)

add_to_variable "PATH" "$openssl_dir/bin" ":"
add_to_variable "LDFLAGS" "-L$openssl_dir/lib" " "
add_to_variable "CPPFLAGS" "-I$openssl_dir/include" " "

puts succ "openssl initialized."
