# Load the latest user environment from systemd.
#
# The environment would be automatically set when the user logged in. However, environment files
# updates are not applied to the apps (including shells) executed side the session.
#
# This script dupms the latest environments and set them manually for a shell.

# Output of `systemctl --user show-environment` can be escaped as `$'...'`,
# so it should be unescaped using `eval`.
# Not passing the environment directly to `eval`, to prevent `$PATH` from being cleared.
__TEMP_SESSION_ENV="$(systemctl --user show-environment)"
eval "export $(echo "$__TEMP_SESSION_ENV" | grep -v '^PATH=' | tr '\n' ' ')"
export PATH="$(eval "echo $(echo "$__TEMP_SESSION_ENV" | sed -ne 's/^PATH=\(.*\)$/\1:/gp')")${PATH}"
unset __TEMP_SESSION_ENV
