#!/usr/bin/env bash
# shellcheck disable=SC2086
function wait_for_tcp_socket {
  local addr=${1-localhost}
  local port=${2-9000}
  local time=${3-5}

  while (! (: </dev/tcp/$addr/$port) &> /dev/null ); do
    sleep $time;
  done
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && wait_for_tcp_socket "$@"

# Wait for a process listening at a TCP socket
#
# Idea taken from https://unix.stackexchange.com/q/5277/42476 - there are
# other ideas and further explanations.
#
# To test, just call the script like this:
#
#     ./wait-for-tcp-socket.bash
#     ./wait-for-tcp-socket.bash some_address
#     ./wait-for-tcp-socket.bash some_address some_port
#     ./wait-for-tcp-socket.bash some_address some_port wait_time
#
# The function 'wait_for_tcp_socket' needs a Bash that is compiled with
# --enable-net-redirections to work.
#
# If your Bash is not compiled with this option or you have another shell
# without this feature, you should use one of the other solutions given
# in the URL above.
#
