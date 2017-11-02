title: VIM spell checking by file type
date: 2017-10-30
category: unix
tags: unix, vim

Wish I'd figured out this tweak to `.vimrc` before:

```
set spelllang=en
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal spell
autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell
```

Getting spell checking in non-text files was just too annoying, so I
turned it off.

Haven't come across a vim equivalent of Emacs' `flyspell-prog-mode`
which considers (programming) context before painting your file red,
but I haven't looked too hard either. Now at least, I get spell
checking in text, markdown and git commit buffers. And not in all
other files I open. Pretty neat, me thinks.

