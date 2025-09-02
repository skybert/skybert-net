title: cd to git repo with zsh and fzf
date: 2025-09-02
category: unix
tags: unix, git, zsh

# Navigate to any git checkout dir

In my
[.zshrc](https://gitlab.com/skybert/my-little-friends/-/blob/master/zsh/.zshrc#L163)
I have defined this function:

```bash
cdgit() {
    local dir=
    dir=$(
      stdbuf --output=L \
        find "$HOME/src" -maxdepth 4 -type d -name .git |
        sed -u 's#/\.git$##' |
        fzf)

    if [[ -n "${dir}" ]]; then
        cd "${dir}" || exit 1
        zle reset-prompt
    fi
}

```

# Create a zle widget and bind it to cdgit

Also in
[.zshrc](https://gitlab.com/skybert/my-little-friends/-/blob/master/zsh/.zshrc#L163),
I bind it to a shortcut, I like <kbd>Ctrl + g</kbd>:

```bash
zle -N cdgit
bindkey '^G' cdgit

```

