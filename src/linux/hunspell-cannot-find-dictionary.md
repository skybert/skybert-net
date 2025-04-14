title: Hunspell cannot find dictionary
date: 2025-04-14
category: linux
tags: linux, emacs, language


Emacs complained wherever I opened a file:

```text
Can't open affix or dictionary files for dictionary named "en_GB". arch linux
```

I first thought this was an Emacs problem, but it turned out to be `hunspell` itself. Running it from the command line showed:

```text
$ hunspell -D
SEARCH PATH:
.::/usr/share/hunspell:/usr/share/myspell:/usr/share/myspell/dicts:/Library/Spelling:/home/torstein/.openoffice.org/3/user/wordbook:/home/torstein/.openoffice.org2/user/wordbook:/home/torstein/.openoffice.org2.0/user/wordbook:/home/torstein/Library/Spelling:/opt/openoffice.org/basis3.0/share/dict/ooo:/usr/lib/openoffice.org/basis3.0/share/dict/ooo:/opt/openoffice.org2.4/share/dict/ooo:/usr/lib/openoffice.org2.4/share/dict/ooo:/opt/openoffice.org2.3/share/dict/ooo:/usr/lib/openoffice.org2.3/share/dict/ooo:/opt/openoffice.org2.2/share/dict/ooo:/usr/lib/openoffice.org2.2/share/dict/ooo:/opt/openoffice.org2.1/share/dict/ooo:/usr/lib/openoffice.org2.1/share/dict/ooo:/opt/openoffice.org2.0/share/dict/ooo:/usr/lib/openoffice.org2.0/share/dict/ooo
AVAILABLE DICTIONARIES (path is not mandatory for -d option):
Can't open affix or dictionary files for dictionary named "en_GB".
```

So, I tried the most obvious thing, search for a hunspell dictionary
for English. I thought English was installed by default, but alas:

```text
$ pacman -Ss hunspell english
extra/hunspell-en_au 2020.12.07-5
    AU English hunspell dictionaries
extra/hunspell-en_ca 2020.12.07-5
    CA English hunspell dictionaries
extra/hunspell-en_gb 2020.12.07-5
    GB English hunspell dictionaries
extra/hunspell-en_us 2020.12.07-5
    US English hunspell dictionaries
```

None of these were installed by default. To get the British
dictionary, I just did:

```text
# pacman -S extra/hunspell-en_gb
```

And with that, Hunspell works everywhere, including in Emacs.

Happy spell checking!
