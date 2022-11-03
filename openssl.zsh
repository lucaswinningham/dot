#!/bin/zsh

openssl_dir=$(brew --prefix openssl)

openssl_path="$openssl_dir/bin"
openssl_ld_flag="-L$openssl_dir/lib"
openssl_cpp_flag="-I$openssl_dir/include"

if [[ -z "${PATH// }" ]]; then
  puts warn "PATH undefined, setting..."
  puts cmd "  export PATH=\"$openssl_path\""
  export PATH="$openssl_path"
elif [[ ${PATH} != *"$openssl_path"* ]]; then
  puts warn "$openssl_path not found in PATH, adding..."
  puts cmd "  export PATH=\"$openssl_path:\$PATH\""
  export PATH="$openssl_path:$PATH"
else
  puts succ "$openssl_path found in PATH, skipping."
fi

if [[ -z "${LDFLAGS// }" ]]; then
  puts warn "LDFLAGS undefined, setting..."
  puts cmd "  export LDFLAGS=\"$openssl_ld_flag\""
  export LDFLAGS="$openssl_ld_flag"
elif [[ ${LDFLAGS} != *"$openssl_ld_flag"* ]]; then
  puts warn "$openssl_ld_flag not found in LDFLAGS, adding..."
  puts cmd "  export LDFLAGS=\"$openssl_ld_flag $LDFLAGS\""
  export LDFLAGS="$openssl_ld_flag $LDFLAGS"
else
  puts succ "$openssl_ld_flag found in LDFLAGS, skipping."
fi

if [[ -z "${CPPFLAGS// }" ]]; then
  puts warn "CPPFLAGS undefined, setting..."
  puts cmd "  export CPPFLAGS=\"$openssl_cpp_flag\""
  export CPPFLAGS="$openssl_cpp_flag"
elif [[ ${CPPFLAGS} != *"$openssl_cpp_flag"* ]]; then
  puts warn "$openssl_cpp_flag not found in CPPFLAGS, adding..."
  puts cmd "  export CPPFLAGS=\"$openssl_cpp_flag $CPPFLAGS\""
  export CPPFLAGS="$openssl_cpp_flag $CPPFLAGS"
else
  puts succ "$openssl_cpp_flag found in CPPFLAGS, skipping."
fi

puts succ "openssl available."
