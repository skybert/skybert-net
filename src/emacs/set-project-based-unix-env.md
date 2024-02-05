title: Set project based Unix environment variables
date: 2024-01-24
category: emacs
tags: emacs

## Emacs side of things
```text
package-install RET envrc
```

## In your project

This is what I used for Python based projects. I use `pipenv` and
`Pipfiles`. Thus, I need to set `VIRTUAL_ENV` to make everything work.

```text
$ cd ~/src/awesome-app
$ direnv allow
```

Find where the virtual environemnt _actualy_ resides:
```text
$ pipenv run which python3 | sed 's#/bin/python3$##'
/home/torstein/.local/share/virtualenvs/awesome-app-EpEGAS3U
```

Add this to an `.envrc` in your project root:
```text
$ vim .envrc
```

```conf
export VIRTUAL_ENV=/home/torstein/.local/share/virtualenvs/awesome-app-EpEGAS3U
export PATH=${VIRTUAL_ENV}/bin:$PATH
```


