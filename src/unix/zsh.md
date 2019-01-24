title: ZSH
date: 2019-01-24
category: unix
tags: unix, bash

I 💘 [BASH](https://www.gnu.org/software/bash/), I used it every day
since 1999 👨‍🎓👨‍💻. But [ZSH](http://zsh.sourceforge.net/) looks so
nice and after giving it a proper shot, using it for a day in January
2019, I fell in love with it.

## Tab completion with documentation

<img src="/graphics/2019/zsh/zsh-auto-complete-with-doc.png" alt="zsh" />

## Kill with tab completion

<img src="/graphics/2019/zsh/zsh-kill-completion-with-fzf.png" alt="zsh" />

## Auto suggestions

<img src="/graphics/2019/zsh/zsh-auto-suggest-overlay.png" alt="zsh"/>

## Forgetting a pipe

```text
$ bash
$ echo hi |
> wc
```

```
$ zsh
$ echo i |
pipe> wc
```

## Forgetting a quote
```text
$ bash
$ echo 'hi
> '
```

```
$ zsh
$ echo 'hi
quote> '
```

## Shows you if command will be found

<img src="/graphics/2019/zsh/zsh-color-codes-found-and-unfound-commands.png" alt="zsh" />

## Powerful recursive file name matching

<img src="/graphics/2019/zsh/zsh-recursive-globbing.png" alt="zsh" />

## BASH has this too, albeit not enabled by default

```text
$ ls ~/.m2/repository/org/**/*.pom | tail -n 3
ls: cannot access '/home/torstein/.m2/repository/org/**/*.pom': No such file or directory
$ shopt -s globstar
$ ls ~/.m2/repository/org/**/*.pom | tail -n 3
/home/torstein/.m2/repository/org/yaml/snakeyaml/1.15/snakeyaml-1.15.pom
/home/torstein/.m2/repository/org/yaml/snakeyaml/1.17/snakeyaml-1.17.pom
/home/torstein/.m2/repository/org/yaml/snakeyaml/1.18/snakeyaml-1.18.pom
$
```

## Closing a shell where you've started an app

Unlike BASH, you must `disown` the process(es) you've started in the
shell, before closing it:

```text
$ firefox &
$ disown %firefox
$ exit
```

Fortunately, `zsh` gives you auto completion on the jobs to `diswown`,
still it's more cumbersome than `bash` and `dash`.

## Pure prompt

## Async
Fancy prompts with things like git status in them are more snappy than
in `bash`. I suspect this is because ZSH executes those fancy prompt
functions on a separate thread and then decorates your prompt when it
has gotten the data it needs.

## Can re-use BASH aliases
In both my `.bashrc.` and `.zshrc`, I've got the line:
```bash
source $HOME/.bashrc.aliases
```

## My .zshrc

My [.zshrc can be found here](https://gitlab.com/skybert/my-little-friends/blob/master/zsh/.zshrc).
