#!/usr/bin/env python3
#

from re import findall,I
from sys import stdin

import argparse

def convert_macaddr(addr,sep):
    if found := findall(r'\b([0-9a-f]{1,2})\b',addr,I):
        print(sep.join(found).upper())
    elif found := findall(r'([0-9a-f]{2})',addr,I):
        print(sep.join(found).upper())

parser = argparse.ArgumentParser()
parser.add_argument('-s','--sep',default=':',required=False,
        help='separate octets with this (default ":")')
parser.add_argument('addr',nargs='*',
        help='reads from STDIN if none given')
args = parser.parse_args()

if args.addr:
    for addr in args.addr:
        convert_macaddr(addr,args.sep)
else:
    for addr in stdin:
        convert_macaddr(addr,args.sep)

# eof
