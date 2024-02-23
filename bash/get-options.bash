#!/usr/bin/env bash
# shellcheck disable=SC2086

function command_help {
  echo "command_help: $0 command [ -c <cmd_opt> ]" 1>&2
  exit $1
} # command_help()

function get_command_options {
  OPTIND=0
  while getopts "c:h" opt; do
    case "${opt}" in
      c)
        COMMANDOPT=${OPTARG}
        ;;
      h)
        command_help 0
        ;;
      *)
        command_help 1
        ;;
    esac
  done
} # get_command_options()

function usage {
  echo "Usage: $0 [ -h | -g <global_opt> ] command [ -h -c <cmd_opt> ]" 1>&2
  exit $1
} # usage()

function get_global_options {
  while getopts "g:h" opt; do
    case "${opt}" in
      g)
        GLOBALOPT=${OPTARG}
        ;;
      h)
        usage 0
        ;;
      *)
        usage 1
        ;;
    esac
  done
} # get_global_options()

function main {

  # These are the options that come before the first non-option.
  #
  get_global_options "$@"
  shift $((OPTIND-1))

  # This is the first argument after the global options.
  #
  COMMAND=$1
  shift

  # These are the options after the "COMMAND".
  #
  get_command_options "$@"
  shift $((OPTIND-1))

  echo "glb_opt: ${GLOBALOPT}"
  echo "command: ${COMMAND}"
  echo "cmd_opt: ${COMMANDOPT}"
}

main "$@"
