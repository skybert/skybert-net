date:    2012-10-07
category: linux
tags: debian
title: Getting the Fonts Right

With these packages and environment configuration, Chinese and
Bangladeshi (and all other languages I've tested) works everywhere:
Iceweasel, Opera and GNOME.

```
$ dpkg -l | grep font | grep ^ii
ii  console-setup                        1.55                                 console font and keymap setup program
ii  console-terminus                     4.30-2                               Fixed-width fonts for fast reading on the Linux console
ii  defoma                               0.11.11                              Debian Font Manager -- automatic font configuration framework
ii  emacs-intl-fonts                     1.2.1-8                              Fonts to allow multi-lingual PostScript printing from Emacs
ii  fontconfig                           2.8.0-2.1                            generic font configuration library - support binaries
ii  fontconfig-config                    2.8.0-2.1                            generic font configuration library - configuration
ii  gsfonts                              1:8.11+urwcyr1.0.7~pre44-4.2         Fonts for the Ghostscript interpreter(s)
ii  gsfonts-x11                          0.21                                 Make Ghostscript fonts available to X11
ii  gucharmap                            1:2.30.2-1                           Unicode character picker and font browser
ii  kbd                                  1.15.2-1                             Linux console font and keytable utilities
ii  libfont-afm-perl                     1.20-1                               Font::AFM - Interface to Adobe Font Metrics files
ii  libfont-freetype-perl                0.03-1                               Read font files and render glyphs from Perl using FreeType2
ii  libfontconfig1                       2.8.0-2.1                            generic font configuration library - runtime
ii  libfontconfig1-dev                   2.8.0-2.1                            generic font configuration library - development
ii  libfontenc1                          1:1.0.5-2                            X11 font encoding library
ii  libfreetype6                         2.4.2-1                              FreeType 2 font engine, shared library files
ii  libfreetype6-dev                     2.4.2-1                              FreeType 2 font engine, development files
ii  libfs6                               2:1.0.2-1                            X11 Font Services library
ii  libgraphite3                         1:2.3.1-0.2                          SILGraphite - a "smart font" rendering engine
ii  libotf0                              0.9.11-1                             A Library for handling OpenType Font - runtime
ii  libt1-5                              5.1.2-3                              Type 1 font rasterizer library - runtime
ii  libxfont1                            1:1.4.1-2                            X11 font rasterisation library
ii  libxft-dev                           2.1.14-2                             FreeType-based font drawing library for X (development files)
ii  libxft2                              2.1.14-2                             FreeType-based font drawing library for X
ii  ttf-arphic-bkai00mp                  2.10-8                               "AR PL KaitiM Big5" Chinese TrueType font by Arphic Technology
ii  ttf-arphic-bsmi00lp                  2.10-8                               "AR PL Mingti2L Big5" Chinese TrueType font by Arphic Technology
ii  ttf-arphic-gbsn00lp                  2.11-9                               "AR PL SungtiL GB" Chinese TrueType font by Arphic Technology
ii  ttf-arphic-gkai00mp                  2.11-8                               "AR PL KaitiM GB" Chinese TrueType font by Arphic Technology
ii  ttf-arphic-ukai                      0.2.20080216.1-1                     "AR PL UKai" Chinese Unicode TrueType font collection Kaiti styl
ii  ttf-arphic-uming                     0.2.20080216.1-3                     "AR PL UMing" Chinese Unicode TrueType font collection Mingti st
ii  ttf-dejavu-core                      2.31-1                               Vera font family derivate with additional characters
ii  ttf-dejavu-extra                     2.31-1                               Vera font family derivate with additional characters
ii  ttf-freefont                         20090104-7                           Freefont Serif, Sans and Mono Truetype fonts
ii  ttf-liberation                       1.05.2.20091019-4                    Fonts with the same metrics as Times, Arial and Courier
ii  ttf-lyx                              1.6.7-1                              TrueType versions of some TeX fonts
ii  ttf-opensymbol                       1:3.2.1-6                            OpenSymbol TrueType font
ii  ttf-sil-gentium                      20081126:1.02-11                     extended Unicode Latin font ("a typeface for the nations")
ii  ttf-sil-gentium-basic                1.1-2                                smart Unicode font families (Basic and Book Basic) based on Gent
ii  ttf-sil-nuosusil                     2.1.1-2                              Unicode font for Yi (a script used in southwestern China)
ii  ttf-wqy-microhei                     0.2.0-beta-1                         A droid derived Sans-Seri style CJK font
ii  ttf-wqy-zenhei
```

Furthermore, I've got these settings:

```
$ dpkg -l *xfs* | grep ^ii
ii  x11-xfs-utils                        7.4+1                                X font server utilities
$ locale -a
C
en_GB.utf8
POSIX
$ echo $LC_ALL
en_GB.utf8
$ echo $LANG
en_GB.utf8
```




