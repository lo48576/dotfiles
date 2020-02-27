# See `man 1 manpath`.
#
# > If `$MANPATH` is prefixed by a colon, then the value of the variable is
# > appended to the list determined from the content of the configuration files.
# > If the colon comes at the end of the value in the variable,
# > then the determined list is appended to the content of the variable.
# > If the value of the variable contains a double colon (`::`),
# > then the determined list is inserted in the middle of the value,
# > between the two colons.
#
# If `$MANPATH` is not empty, then remove a trailing colon (if exists) and append a trailing colon.
MANPATH="${MANPATH:+"${MANPATH%:}:"}"
