title: persistent window splits
date: 2023-05-10
category: emacs
tags: emacs


Ever created windows splits in Emacs, say two vertical with code and
one large horizontal beneath with compilation output, and then having
it ruined when firing off a command or starting a mode?

I had this for years, mitigating it with `winner-mode` and
`winner-undo`. It allowed me to navigate back and forth between my
different window split setups. However, it was a bit tedious and
didn't always work (some modes grabbed my shortcut).

I then started storing the window splits in Emacs registers: 1) split
the windows the way you want them 2) store it with `C-x r w RET 1` and
then jump back to it with `C-x r j RET 1`. The only problem was they
didn't persist between session.

Finally, I read up on `workgroup2` and have *finally* gotten stable,
persistent window split configuration. What's more, it allows me to
store different splits and buffer contents for my different contexts,
e.g. I have:
- user-manager # 2 vertical code buffers, horizontal compilation buffer
- user-manager-wide # 4 vertical code buffers, compile, vterm
- zipline #  2 python buffers, python REPL, vterm

And so on. Creating a split is done with `wg-create-workgroup RET
<name>` and opening a split is done with `wg-open-workgroup RET
<name>`.

Highly recommended.
