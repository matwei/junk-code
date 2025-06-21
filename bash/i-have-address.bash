#!/usr/bin/env bash
#
# See https://unix.stackexchange.com/a/207191
# See 'man 8 ip-address' for arguments to 'ip addr'
#
# This works for IPv4 and IPv6.
# The function uses GNU grep.
#
# Usage:
#
#   if i_have_address a.b.c.d; then echo "yes"; else echo "no"; fi

function i_have_address {
  ip -o addr show up primary scope global| grep -E "\s$1[/ ]" > /dev/null
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && i_have_address "$@"
