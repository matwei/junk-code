# Python Junk Code

## Argparse

```
./convert_macaddr -h
usage: convert_macaddr.py [-h] [-s SEP] [addr ...]

positional arguments:
  addr               reads from STDIN if none given

options:
  -h, --help         show this help message and exit
  -s SEP, --sep SEP  separate octets with this (default ":")
```

## Handle log lines

Identify similar log lines by removing timestamps, etc..
See [artificial ignorance: how-to guide](https://www.ranum.com/security/computer_security/papers/ai/)
to get an idea for what this is useful as a starting point.

```
./blur_log.py
usage: blur_log.py [-h] [filename ...]

positional arguments:
  filename    reads from STDIN if none given

options:
  -h, --help  show this help message and exit
```

## Find default config file

```
./xdg_config -h
usage: xdg_config.py [-h] [--config CONFIG]

options:
  -h, --help            show this help message and exit
  --config CONFIG, -c CONFIG
                        name of config file
```

This script searches for a config file in these places (first one wins):

1. File with pathname given in `--config` option.
2. File named *.config.ini* in current directory (note the prepended dot).
3. File named *config.ini* in `$XDG_CONFIG_HOME`.
4. First file named *config.ini* in any of the directories in `$XDG_CONFIG_DIRS`.

If it can't find a config file, the scripts exits with an error message.
