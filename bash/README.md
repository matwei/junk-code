# Bash Junk Code

## Editing text

### Activate / deactivate a line

Try it out:

```
./activate-line.bash
Usage: ./activate-line.bash ( a | d ) [ file [ line [ comment ]]]
```

The script needs at least the first argument ('a' or 'd').
It will either activate (or insert) the line in the file
or deactivate it by prepending it with the comment.

Default file is *test.txt*,
default line is *"this.line.is.active = true"*,
default comment is *"#"*.

## Options

Try it out:

```
./get-options.bash -h
./get-options.bash cmd -h
./get-options.bash -g gopt cmd -c copt
```

## My IP address

I use this like this to distinguish between cloned machines
that have different IP addresses.

```
if ./i-have-address.bash a.b.c.d; then echo "yes"; else echo "no"; fi
```

or

```
source ./i-have-address.bash
if i_have_address a.b.c.d; then echo "yes"; else echo "no"; fi
```
## Setup Git configuration

```
Usage: ./setup-git.bash [ -h ] [ -e <email address> ] [ -n <user name> ]
 -d         - dry run
 -e <email> - use this as email address
 -h         - show this help
 -n <name>  - use this as username
```

## Synchronisation

### Wait for Process listening at a TCP port

Try it out:

```
./wait-for-tcp-socket.bash
```

The command will look every 5 seconds for a process
listening at localhost:9000/tcp.

Open a different shell and start the following:

```
nc -l localhost 9000
```

After at most 5 seconds both processes should end.

