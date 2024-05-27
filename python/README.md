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
