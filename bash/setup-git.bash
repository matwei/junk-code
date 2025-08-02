#!/bin/bash

ALIASES=(
  "br branch"
  "ci commit"
  "co checkout"
  "st status"
)

function run_this {
  local cmd=$1
  shift
  echo "run: $cmd $@"
  # shellcheck disable=SC2048
  if [[ -z "$DRYRUN" ]]; then
    $cmd "$@"
  fi
} # run_this()

function get_gecos_name {
  getent passwd \
    |grep -e "^$(id -u -n):" \
    |cut -d: -f5 \
    |cut -d, -f1
} # get_gecos_name()

function get_options {
  while getopts 'de:hn:' opt; do
    case "${opt}" in
      d)
        DRYRUN=1
        echo "## dry run:"
        ;;
      e)
        GITUSEREMAIL=${OPTARG}
        ;;
      h)
        usage 0
        ;;
      n)
        GITUSERNAME=${OPTARG}
        ;;
      *)
        usage 1
        ;;
    esac
  done
  if [[ -z "$GITUSEREMAIL" ]]; then
    GITUSEREMAIL="$(echo -n "$(id -un)@"; hostname)"
  fi
  if [[ -z "$GITUSERNAME" ]]; then
    GITUSERNAME="$(get_gecos_name)"
  fi
} # get_options()

function set_aliases {
  for alias in "${ALIASES[@]}"; do
    run_this "git config --global alias.$alias"
  done
} # set_aliases()

function set_user {
  run_this git config --global user.name "$GITUSERNAME"
  run_this git config --global user.email "$GITUSEREMAIL"
} # set_username()

function set_misc {
  run_this git config --global credential.helper 'cache --timeout 3600'
  run_this git config --global core.editor 'vim'
  run_this git config --global init.defaultbranch 'main'
} # set_misc()

function setup_git {
  get_options "$@"
  set_user
  set_aliases
  set_misc
} # setup_git()

function usage {
  (
    echo "Usage: $0 [ -h ] [ -e <email address> ] [ -n <user name> ]"
    echo " -d         - dry run"
    echo " -e <email> - use this as email address"
    echo " -h         - show this help"
    echo " -n <name>  - use this as username"
  ) 1>&2
  exit "$1"
} # usage()

[[ "${BASH_SOURCE[0]}" == "$0" ]] && setup_git "$@"
