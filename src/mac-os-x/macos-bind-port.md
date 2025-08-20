title: macOS Lets Regular User Process Bind to Privileged Ports
date: 2025-08-20
category: mac-os-x
tags: mac-os-x, unix

Recently, I learned that macOS allows a regular user process to bind
to a privileged port.

To test this out, in one terminal, do:

```bash
$ nc -l 0.0.0.0 80
```

In a second terminal, talk to the process listening on port `80`:

```bash
echo "hello world" | nc 127.0.0.1 80
```

The first terminal should now print:
```text
hello world
```

Cool eh? Happy networking!
