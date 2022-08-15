
# This is for enabling directory specific aliases,
# eg "yt" = yarn test, but calls with specific args depending on the project dir.
# There are a couple ways of doing this with just bash
# The simpler way doesn't unalias when you leave a directory, but that's not necessarily a problem: you shouldn't be using those aliases in the wrong dir, and if the new dir does use them, then they should be overwritten.


# https://unix.stackexchange.com/questions/52997/how-to-set-an-alias-on-a-per-directory-basis
# this will simply source the .aliases file if it exists, it won't clear up old aliases, but maybe that's okay?
function cd () {
  builtin cd "$@" && [[ -f .local_aliases ]] && . .local_aliases
  return 0
}

function make_local_alias() {
  # need two string args, alias name and alias command, abort if not
  if [ $# -ne 2 ]; then
    echo "This function takes exactly two string arguments and makes an alias from them. You provided too few or too many."
    exit 1
  fi
  echo "Making local alias: $1=\"$2\""
  # put the alias in the the ".local_aliases" file
  echo "alias $1=\"$2\"" >> ".local_aliases"
  alias $1="$2"
  return 0
}

function show_local_aliases() {
  cat ".local_aliases"
}


#####
# 1 #
#####

# https://unix.stackexchange.com/questions/52997/how-to-set-an-alias-on-a-per-directory-basis
# this will simply source the .aliases file if it exists, it won't clear up old aliases, but maybe that's okay?
# function cd () {
#   builtin cd "$@" && [[ -f .aliases ]] && . .aliases
#   return 0
# }


#####
# 2 #
#####

# https://coderwall.com/p/wvsndw/directory-specific-bash-aliases
# function on_leave_dir() {
#   if [ -e ".local-aliases" ]; then
#     export OLD_ALIAS_DIR="$PWD"
#   fi
# }

# function on_enter_dir() {
#   if [ -n "$OLD_ALIAS_DIR" ] && ! is_subdirectory "$PWD" "$OLD_ALIAS_DIR" ; then
#     aliases="$OLD_ALIAS_DIR/.local-aliases"

#     while IFS=':' read -r key value || [ -n "$key" ]; do
#       unalias "$key" > /dev/null 2>&1
#     done < $aliases

#     unset OLD_ALIAS_DIR
#     echo "Unloaded local aliases"
#   fi

#   if [ -e .aliases ]; then
#     echo "Loading local aliases"
#     while IFS=':' read -r key value || [ -n "$key" ]; do
#       alias "$key"="${value##*( )}"
#       echo ""
#     done < ".local-aliases"

#   fi
# }

# function is_subdirectory() {
#   local child="$1"
#   local parent="$2"
#   if [[ "${child##${parent}}" != "$child" ]]; then
#     return 0
#   else
#     return 1
#   fi
# }

# function make_local_alias() {
#   # need two string args, alias name and alias command, abort if not
#   echo "Making local alias"
#   # put the alias in the the ".local-aliases" file
#   # make the alias and echo it
# }

# function cd() {
#   on_leave_dir
#   builtin cd "$@"
#   on_enter_dir
# }

