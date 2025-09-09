#!/usr/bin/env python3

import argparse
import configparser
import json
import sys

from os.path import ( isfile, join as path_join )
from xdg_base_dirs import ( xdg_config_dirs, xdg_config_home )

def configure(args):
    cfn_default ='config.ini'
    cf_name = None
    if args.config is not None:
        cf_name = args.config
    else:
        if isfile('.{}'.format(cfn_default)):
            cf_name = '.{}'.format(cfn_default)
        elif isfile(path_join(str(xdg_config_home()), cfn_default)):
            cf_name = path_join(str(xdg_config_home()), cfn_default)
        else:
            for p in xdg_config_dirs():
                if isfile(path_join(str(p), cfn_default)):
                    cf_name = path_join(str(p), cfn_default)
                    break

    if cf_name is not None:
        conf = configparser.ConfigParser()
        conf.read(cf_name)
    else:
        print('No config file given and none found', file=sys.stderr)
        sys.exit(1)

    return conf

def parse_args():
    """CLI argument definitions and parsing"""

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--config', '-c',
        help='name of config file',
    )

    return parser.parse_args()

if '__main__' == __name__:
    args = parse_args()
    conf = configure(args)
    conf.write(sys.stdout)
    sys.exit()

