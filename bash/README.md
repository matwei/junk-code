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

