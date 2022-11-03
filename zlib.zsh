#!/bin/zsh

zlib_pkg_config="/usr/local/opt/zlib/lib/pkgconfig"
zlib_ld_flag="-L/usr/local/opt/zlib/lib"
zlib_cpp_flag="-I/usr/local/opt/zlib/include"

if [[ -z "${PKG_CONFIG_PATH// }" ]]; then
  puts warn "PKG_CONFIG_PATH undefined, setting..."
  puts cmd "  export PKG_CONFIG_PATH=\"$zlib_pkg_config\""
  export PKG_CONFIG_PATH="$zlib_pkg_config"
elif [[ ${PKG_CONFIG_PATH} != *"$zlib_pkg_config"* ]]; then
  puts warn "$zlib_pkg_config not found in PKG_CONFIG_PATH, adding..."
  puts cmd "  export PKG_CONFIG_PATH=\"$zlib_pkg_config:\$PKG_CONFIG_PATH\""
  export PKG_CONFIG_PATH="$zlib_pkg_config:$PKG_CONFIG_PATH"
else
  puts succ "$zlib_pkg_config found in PKG_CONFIG_PATH, skipping."
fi

if [[ -z "${LDFLAGS// }" ]]; then
  puts warn "LDFLAGS undefined, setting..."
  puts cmd "  export LDFLAGS=\"$zlib_ld_flag\""
  export LDFLAGS="$zlib_ld_flag"
elif [[ ${LDFLAGS} != *"$zlib_ld_flag"* ]]; then
  puts warn "$zlib_ld_flag not found in LDFLAGS, adding..."
  puts cmd "  export LDFLAGS=\"$zlib_ld_flag $LDFLAGS\""
  export LDFLAGS="$zlib_ld_flag $LDFLAGS"
else
  puts succ "$zlib_ld_flag found in LDFLAGS, skipping."
fi

if [[ -z "${CPPFLAGS// }" ]]; then
  puts warn "CPPFLAGS undefined, setting..."
  puts cmd "  export CPPFLAGS=\"$zlib_cpp_flag\""
  export CPPFLAGS="$zlib_cpp_flag"
elif [[ ${CPPFLAGS} != *"$zlib_cpp_flag"* ]]; then
  puts warn "$zlib_cpp_flag not found in CPPFLAGS, adding..."
  puts cmd "  export CPPFLAGS=\"$zlib_cpp_flag $CPPFLAGS\""
  export CPPFLAGS="$zlib_cpp_flag $CPPFLAGS"
else
  puts succ "$zlib_cpp_flag found in CPPFLAGS, skipping."
fi

puts succ "zlib available."
