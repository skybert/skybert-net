title: Java programming in Emacs with Meghanada mode
date: 2017-10-09
category: emacs
tags: emacs, java

I can recommend Java coding Emacs users to try out
[meghanada](https://github.com/mopemope/meghanada-emacs) by
[@mopemope](http://twitter.com/mopemope) No project setup required as
it uses Maven directly.

<img 
  src="/graphics/2017/emacs-meghanada.gif"
  alt="emacs using meghanada mode to code java"
  class="centered"
/>  

Here you see some of Meghanada's features, including code completion,
inline doc (see below in the mini buffer), code navigation, automatic
imports, intelligent creation of local variables to hold return values
(e.g. `list.getSize()` becomes `int size = list.getSize()`) and on the
fly java linting (errors and warnings).

To get everything up and running, only two lines of conf is needed 👍
My complete [Meghanada configuration can be viewed on
Github](https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-java-meghanada.el).
