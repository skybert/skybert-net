title: Projectile
category: emacs
tags: emacs
date: 2015-03-05

Projectile is one of my favourite Emacs packages and I recommend it
for everyone coding in Emacs . It sets up many things for you that you'll
appreciate whatever language you're programming in. 

One day, ```M-x projectile-regenerate-tags``` gave me this errors:

```
projectile-regenerate-tags: ctags: invalid option -- 'e'
    Try `ctags --help' for a complete list of options.
```

Of course, everything was
[perfectly well laid out in the documention](https://github.com/bbatsov/projectile/blob/master/README.md),
I just had to install
[Exuberant ctags](http://ctags.sourceforge.net/):

```
# apt-get install exuberant-ctags
```

After that, ```projectile-regenerate-tags``` and consequently
```M-.``` (```find-tag```) and ```M-*``` (```pop-tag-mark```) worked like a charm.
