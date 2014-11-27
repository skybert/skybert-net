title: A handful packages that will turbo boost your Emacs
date: 2014-01-22
category: emacs
tags: emacs

Whatever you use Emacs for, you'll definitely want these packages set
up to get blistering fast code and file navigation.

## Blistering fast M-x Install
[smex](http://www.emacswiki.org/emacs/Smex) and you'll never look
back. It makes you so much faster in Emacs as it not only auto
completes whatever you do with =M-x=, but it also remembers what you
did previously, listing often used commands at the top.

<img src="/graphics/2014/emacs-smex.gif" alt="Emacs using smex for minibuffer completion"/>

## Out of the box IDO setup for all your project Install
[projectile](http://www.emacswiki.org/emacs/Projectile) and get
automatic setup of IDO for all your projects.

Projectile will also give you other project specialised features such
as:

* searching for a string inside your project using =projectile-grep=,
  I use this all of the time, quite seldom, I venture back to
  =grep-find=.

* replacing a string in the project

All of this for free. No setup required.

While you're at it, also consider installing these packages for
an even better IDO experience:
* [flx-ido](https://github.com/lewang/flx)
* [ido-vertical-mode](https://github.com/gempesaw/ido-vertical-mode.el)
* [ido-ubiquitous](https://github.com/technomancy/ido-ubiquitous)

<img src="/graphics/2014/emacs-projectile.gif" alt="Emacs projectile"/>

To see my full IDO & friends setup, [check out my settings here](https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-smart-file-name-completion.el):

## Find file at point
It's a breeze navigating referenced files in your configuration files
using the built-in ```find-file-at-point```.

<img src="/graphics/2014/emacs-find-file-at-point.gif" alt="Emacs find-file-at-point"/>

## Word completion
In addition to the built-in ```dabbrev-expand``` which will expand any
word, I recommend that you install the excellent ```auto-complete```
package and turn it on in all modes. It gives you a nice intellisense
like menu where you can auto complete any word/method name that you
have in a buffer.

<img src="/graphics/2014/emacs-auto-complete-mode.gif" alt="Emacs auto complete mode"/>

## Sentence & block completion
The built-in ```hippie-expand``` will let you auto complete previously
written blocks of code, or indeed sentences.

## Summary
With these packages in place, you will dramatically improve the speed
with which you fly through your Emacs windows and buffers!

