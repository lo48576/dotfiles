# * `N`: Take only paths which exists now.
# * `-`: Think about not symlink itself, but files pointed by simlink.
# * `/`: Take only directories.
# * `^W`: Take only non-writable paths.
# * `${^spec}`: enable `RC_EXPAND_PARAM`.

# Cleanup `$PATH`: Remove world-writable directories.
path=( ${^path}(N-/^W) )

# Cleanup `$fpath`.
fpath=( ${^fpath}(N-/^W) )

# Cleanup `$LD_PRELOAD`.
[[ -n "${ld_preload:+x}" ]] && ld_preload=( ${^ld_preload}(N-/^W) )

# Cleanup unused variables
[[ -z ${LD_LIBRARY_PATH:-} ]] && unset LD_LIBRARY_PATH || true
[[ -z ${LD_PRELOAD:-} ]] && unset LD_PRELOAD || true
[[ -z ${SUDO_PATH:-} ]] && unset SUDO_PATH || true
[[ -z ${MANPATH:-} ]] && unset MANPATH || true
