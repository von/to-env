#!/bin/sh
#
# to-env()
#
# Run a command and assign each line of it's output to an environment
# variable.
#
# If command returns non-zero, exit, returning the same status.
#
# Homepage: https://github.com/von/to-env
#
# Usage example:
# to_env "ls -1t ~/Downloads/* | head"

function to-env()
{
  local prefix="e"
  local field=""  # whole line
  local usage="Usage: to-env [-p <prefix>] [-<field>] <command>"
  local OPTIND  # Not just a good idea, required for proper bahavior
  while getopts ":p:123456789" opt "$@" ; do
    case $opt in
      p) prefix=${OPTARG} ;;
      1|2|3|4|5|6|7|8|9) field=${opt} ;;
      \?) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
  done

  shift $(($OPTIND - 1))
  if test $# -eq 0 ; then
    echo "Missing command."
    echo $usage
    return 1
  fi

  # Using 'local' here obscured $?
  output="$(eval $@)"
  local laststatus=$?

  if test $laststatus -ne 0 ; then
    return $laststatus
  fi

  if test -z "${output}" ; then
    echo "No output."
    return 0
  fi

  local count=1
  while read -r line ; do
    local var=${prefix}${count}
    if test -n "${field}"; then
      local value=$(echo ${line} | awk "{print \$${field}}")
      eval "${var}=${value}"
      echo "\$${var}: ${value}"
    else
      eval "${var}=${(q)line}"
      echo "\$${var}: ${line}"
    fi
    let count=count+1
  done <<< "$output"
}
