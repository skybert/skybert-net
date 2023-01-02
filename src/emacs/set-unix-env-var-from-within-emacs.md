title: Set Unix env var from within Emacs
date: 2023-01-02
category: emacs
tags: emacs, unix

You've started Emacs before you added your SSH keys to your keyring?
No problem!

In the shell where you have your keys added to your keyring:
```text
$ ssh-add -l
2048 SHA256:FPafasdfasf234 /home/torstein/.ssh/id_rsa (RSA)
256 SHA256:234124sdfsadf234234123 torstein@quanah (ED25519)
```

Get a hold of the values for these two variables that were set by the
`ssy-agent` program:

```text
$ set | grep ^SSH_
SSH_AGENT_PID=1315
SSH_AUTH_SOCK=/tmp/ssh-XXXXXX6O4ePc/agent.1306
```

Now, in Emacs, evaluate the following elisp:
```lisp
(setenv "SSH_AGENT_PID" "1315")
(setenv "SSH_AUTH_SOCK" "/tmp/ssh-XXXXXX6O4ePc/agent.1306")
```

That's it. Everything in Emacs that uses SSH, like a typical Magit
session, will use the same keyring that your shell uses.

Happy coding!
