#!/bin/sh
#
# to-env()
#
# Run a command and assign each line of it's output to an environment
# variable.
#
# Homepage: https://github.com/von/to-env
#
# Usage example:
# to_env "ls -1t ~/Downloads/* | head"

function to-env()
{
    local prefix="e"
    local OPTIND  # Not just a good idea, required for proper bahavior
    while getopts ":p:" opt "$@" ; do
	case $opt in
	    p) prefix=${OPTARG} ;;
	    \?) echo "Invalid option: -$OPTARG" >&2 ;;
	esac
    done
    shift $(($OPTIND - 1))
    local output=`eval $@`
    local count=1
    while read -r line ; do
	local var=${prefix}${count}
	eval "${var}='${line}'"
	echo "[${count}] ${line}"
	let count=count+1
    done <<< "$output"
}
