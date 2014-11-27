date:    2012-10-07
category: emacs
tags: emacs
title: Navigating source code effortlessly

## C, C++ and Java

I use <a href="http://gnu.org/software/global">GNU Global</a>
for navigating my Java source code. It's brilliant. Global is
blistering fast, having indexes with 1000s of Java files is no
problem. It doesn't require any external process (unlike how
e.g. malabar mode does it) and it's very easy to set up:

### Go to the root of your Java sources

    $ cd ~/src/my-project
    $ gtags


### Add this to your .emacs

(autoload 'gtags-mode "gtags" "" t)
(add-hook 'c-mode-common-hook
'(lambda ()
(gtags-mode 1)))


### You can now fly through your Java source code

When Global is active (it'll say "Gtags" in the buffer status
bar), you can use standard tags shortcuts to jump to the
decleration of something:```M-.```


To go back were you were, you can press
```M-*```. This will "pop" the navigation stack, so if
you've navigated from:


    public class CarFactory {
    car.getName(); ->
    class Car {
    public String getName() {
    super.getModel(); ->
    class Vehicle {
    public String getModel() {
    <cursor>


```M-*``` will take you to the previous place were you
pressed```M-.```. The
```M-.``` also lets you
search for any method or class you like. Try it out, it's
brilliant!

<h2><a name="bash">BASH (and other non-C like languages)</a></h2>

To navigate BASH source code, I use the standard <a
href="http://www.emacswiki.org/emacs/EmacsTags">etags</a>. Here,
you need to do the following to set it up:

### Go to the root of your BASH sources

    $ cd ~/src/my-bash-lib
    $ find | etags -


### Add the following to your .emacs

(require 'etags)
(setq tags-table-list '("/home/use/src/my-bash-lib"))


### You can now fly through your BASH source code

That's it. You can now use the same shortcuts as described
above to fly through your BASH source code.


etags has support for many languages, not only BASH, see the
output from```etags --help``` for a list of languages
it provides special parsing for. Others work too, so just try
creating the TAGS file as above, hit```M-.``` in your
source code and see what hapepns :-)

