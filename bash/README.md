# Bash Junk Code

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

