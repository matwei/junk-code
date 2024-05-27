#!/usr/bin/env python3
#

import argparse
import re
import sys

def BlurLog(infile,outfile):
    for line in infile:
        # remove timestamp from line
        line = re.sub(
            r'^\w{3} [ 1-3][0-9] [0-9:]{8} ',
            '',
            line
        )
        # put anything else to blur the line here
        outfile.write(line)

def ParseArgs(args):
    """CLI argument definitions and parsing"""

    parser = argparse.ArgumentParser()
    parser.add_argument(
        'filename',
        nargs='*',
        help='reads from STDIN if none given'
    )

    return parser.parse_args(args)

if '__main__' == __name__:

    args = ParseArgs(sys.argv[1:])

    if args.filename:
        for fname in args.filename:
            with open(fname, 'r') as file:
                BlurLog(file,sys.stdout)
    else:
        BlurLog(sys.stdin,sys.stdout)
