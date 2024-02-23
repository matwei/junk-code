#!/usr/bin/env bash

LINE="this.line.is.active = true"

# If the text in $line is already in the file,
# the whole line will be replaced with the text.
# If it is not in the file,
# it will be appended at the end of the file.
#
function activate_line {
  local fname=$1
  local line=$2

  if grep -q -F "${line}" "$fname"; then
    sed -i "s/^.*${line}.*$/${line}/" "${fname}"
  else
    echo "${line}" >> "$fname"
  fi
} # activate_line()

# If the text in $line is at the beginning of a line in the file,
# it is prepended with $comment.
#
function deactivate_line {
  local fname=$1
  local line=$2
  local comment=$3

  sed -i "s/^${line}.*$/${comment} ${line}/" "${fname}"
}

# The rest is just to test this interactive
function usage {
  echo "Usage: $0 ( a | d ) [ file [ line [ comment ]]]" 1>&2
  exit 1
}

function main {
  local cmd=${1-a}
  local fname=${2-test.txt}
  local line=${3-$LINE}
  local comment=${4-#}

  [[ 1 -gt $# ]] && usage

  touch "$fname"

  case $cmd in
    A* | a*)
      activate_line "${fname}" "${line}"
      ;;
    D* | d*)
      deactivate_line "${fname}" "${line}" "${comment}"
      ;;
    *)
      usage
      ;;
  esac

  cat "$fname"
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"

# end of script
