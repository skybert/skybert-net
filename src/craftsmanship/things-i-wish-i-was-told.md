title: Things I'd Like to Tell the Younger Me
date: 2017-07-07
category: craftsmanship
tags: emacs, vim, craftsmanship, hrm

<div style="text-align: center;">
 <a href="#learn">Learn how to learn</a> 
 <a href="#logs">Read the logs</a> 
 <a href="#strace">Unscrew the black box</a> 
 <a href="#read_code">Learn to read code</a> 
 <a href="#keyboard">Keyboard</a> 
 <a href="#editors">Test editors</a> 
 <a href="#people">People</a>
 <a href="#api_design">API design</a>
 <a href="#books">Books</a>
</div>


## <a name="learn"></a> Learn how to learn

This is by far the most important thing I can teach you: teach
yourself how to learn new things. Become used to acquiring knowledge
by yourself. Don't rely on others telling you how something
works. Learn how to find out this yourself. Then, nothing can stop
you.

For Unix commands, this means learning to use the `man` command (as in
`man`ual). If you wonder how the `scp` command works, type `man scp`
and read it. When I started out with Linux in 1999, I quickly learned
the term RTFM ("Read the F**** Manual"). Although, the tone online is
nicer these days, this saying is the greatest gift you can choose to
embrace: read the manual. On Linux and Mac, they're all available in
the correct version corresponding to the machine on which you use them
(to search for manuals of interest, you can use `man -k <query>`).

If the manual doesn't answer your questions, turn to a Google or
whatever is the best search engine of the day and make a query like
"how do I use the scp unix command?".

For other things, say a Java program that gives you a stacktrace: try
to read the stack trace. Even though you don't know Java (say), slowly
reading the stack trace will tell you something: a web service
something called an XML parser something which called a string buffer
something which complained about out of memory something. Ah, what
could that be? Think about it. Could it be that someone sent a large
XML file to the webservice of the Java app and it ran out of memory?

### <a name="logs"></a> Read the logs
Logs. Read the logs. This tip alone will set you apart from the bulk
of people you'll be working with. Read the logs, all of them, not just
the pretty little nice one. Read the logs. Most log entries have
timestamps. Use these to narrow down your search for the messages
related to the answers you seek.

### <a name="strace"></a> Figure out what a program does
On Linux, learn to use `strace` and run it in front of your
program. See what files it tries to open and what network connections
it attempts to open (`strace -f -e open <cmd>` and `strace -f -e
network <cmd>`). If you're on Solaris or FreeBSD, learn to do the same
using `dtrace`, or if you're on MacOS learn to use `dtruss`.

If the source of the app is available, check it out (`git` is the most
popular version control system these days, so a simple `git clone
<url>` will give you access to lots of software that you or your
company is using). Check out all the sources of the company's apps
that you are in some way interacting with (disk space is cheap). Don't
be afraid. Just because it's written in `C` and you don't understand
`C`, doesn't mean you can get a hunch about parts of what the problem
is.

Now, if that doesn't yield the results you're after, _then_ you can
ask someone. When you ask them, tell them what you've read and what
you've tried. People will be __much__ more motivated in helping you if
you can show them that you have made an effort to solve this yourself.

## <a name="read_code"></a> Learn to read other people's code

Everyone's guilty of this: you prefer reading your own code to reading
what other's have programmed. It's just so much easier to understand
your own logic. It's after all, more logical than what your colleagues
have done, right?

For a short time, 2-3 years, I was employed as a consultant providing
Java and Linux services to clients. During these few years, I worked
on a number of projects, all with large code bases. Lots of legacy
(that's the biggest different between coding in university and in the
real world, the size of the code base). More than anything, these
years taught me (forced me!) to read lots and lots of other people's
code.

It's a pity I didn't get this into my head sooner: slow down, try to
understand what other people have written, slow down again, try to
_really_ understand. Then, you can make adjustments, enhance it or
criticise it. But not before you've spent a substantial amount of time
trying to understand the code. Don't fall foul to
the
[Not invented Here Syndrome (NIH syndome)](https://en.wikipedia.org/wiki/Not_invented_here).

## <a name="editors"></a> Editors
### Learn vim
Whatever editor you use as your main editor, learn vim to the point
that you're fairly fluent in it. This is the editor that you're
guaranteed to find on any platform you'll work on.

### Learn one editor really, really well
A text editor is the most important piece of software you'll use as a
programmer. It's therefore important that you find one you really like.

Try out all the editors you like and find one you like. Then learn it
really, really well. It doesn't matter which one, but pick one which
runs on all the major platforms: Windows, Mac and Linux.

My advice would be to Emacs a fair shot (install it, follow the
builtin tutorial, then stick with it for 2-3 weeks), it's arguably the
most powerful editor in the world, but you must be willing to invest
some time learning it. 

If you don't like Emacs, I'd recommend you to try out these ones: vim,
Sublime, Atom, UltraEdit. 

But in any case, the important thing is that you pick one that you
like and you can run on all platforms (you will probably use different
platforms as you move jobs) and that you become as efficient as
possible in this one.

### Tell your editors to always add a final new line
It ensures the file looks nice in all contexts.

[Emacs](http://gnu.org/software/emacs) and [vim](http://www.vim.org)
do this out of the box.

IntelliJ IDEA: Settings → Editor → General → Ensure line feed at file end on Save

### Tell your editors to remove trailing white space
This makes your files look nice and tidy in any context.

For `vim`, put this in your `~/.vimrc`:
```
function! TrimWhiteSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd BufWritePre *.* :call TrimWhiteSpace()
```

For `emacs`, add this to your `~/.emacs`:
```
(ws-butler-global-mode)
(setq ws-butler-keep-whitespace-before-point nil)
```

### Tell your editors to insert spaces instead of tabs

This makes your files look nice and tidy in any context.

For `vim`, add this to your `~/.vimrc`:
```
set expandtab
```

For Emacs, add this to your `~/.emacs`:
```
(setq-default indent-tabs-mode nil)
```

## <a name="keyboard"></a> Keyboard
### Remap CAPS LOCK to an extra Ctrl keyboard
You almost never needs <kbd>CapsLock</kbd> but you often need
<kbd>Ctrl</kbd> especially if you're using shortcuts (which you
should).

Using <kbd>CapsLock</kbd> as <kbd>Ctrl</kbd> also reduces the risk of
[RSI](https://en.wikipedia.org/wiki/Repetitive_strain_injury). RSI is
something I didn't care about before I reached my middle 30s. I wish
someone had told me to use <kbd>CapsLock</kbd> from the early days
on. It would have saved me a lot of pain.

### Learn to touch type

> Touch typing isn't important at all. Most of the time, you spend
> time thinking, not writing code. Besides the IDE makes writing code
> super easy! 😠

Don't be offended by this, but after working for 15+ years, I'd say
with very few exceptions, the best coders are the ones that touch type
(or write fast on the keyboard by some self invented approach). This
probably upsets a lot of people, but it's my honest opinion. The good
news is that everyone can learn to touch type.

Text is the way of life as a programmer. Emails, chats, commit
messages, wiki pages, documents and presentations. The written
communication far outweighs the oral communication you do. Most jobs
today are even distributed, with colleagues and stake holders in
multiple countries and time zones. Limiting your communication to what
you get to do around the coffee machine and your co worker sitting
beside you and video conferences with the other colleagues just
doesn't cut it.

If you touch type, communicating and documenting will not be a pain
for you. If you don't touch type, you will tend to avoid written
communication and documentation tasks or you will reduce it. You will
write more cryptic commit messages (writing detailed messages costs
too much if you type with four fingers), you will hesitate to create a
wiki page to help out fellow coders on how to solve a tough problem
you have just overcome and so on.

If you're not convinced, reads this blog post by Steve Yegge:
[Programming's Dirtiest Little Secret](http://steve-yegge.blogspot.com/2008/09/programmings-dirtiest-little-secret.html)

## <a name="people"></a> People

### The ones that claim they know everything

Unless you're talking to someone who is a true leader in his/her
field, like Linus Thorvalds talking about operating systems or Kevin
Mitnick on IT security, there are seldom absolute truths. If someone
proclaims in front of everyoneq trying to solve a strange problem of a
software client dropping packages from one cloud vendor (but all other
downloads are fine):

> "This cannot be, TCP timestamps prevent this from happening"

I might be well intended, but often simple, absolute truths, presented
in an assertive manner, is a statement of less quality.  I've learned
to appreciate people saying:

> "In my option ..."

> "To my knowledge ..."

> "As far as I know,"

> "On the projects I've worked on in the past .."

The thing is, the more you know, the more you know that you don't
know. The best programmers I've worked with are the ones that have
realised this and therefore presents their opinions in this
light. These are the persons I listen the most to. The ones that would
say:

> "This seems extremely unlikely, normally, TCP timestamps should
> prevent this from happening. It could of course be some factor here
> that I am not aware of."

And in case you were wondering: of course it turned out that TCP
timestamps can indeed be turned off, which was why a client had
problems downloading data from Amazon's S3, but not from any other
server.

### Fellow developers

#### Spotting a good developer

#### Dare to say "I don't know"
The best developers I've worked with, are the ones that admit when
they don't know something. Daring to say "I don't know" among his/her
peers is often a sign of technical excellence.

#### Dare to ask "How does that work?"

Again, the best people I've worked with, dare to reveal that they
don't know everything when discussing with a group of
developers. Others fake it, just nod or don't say anything.


## <a name="learn"></a> Books

<a
  href="https://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X">
  The Pragmatic Programmer: From Journeyman to Master </a>, is without
a doubt the best programming book I've ever read


<a href="http://shop.oreilly.com/product/9780596003302.do">Unix Power
Tool</a> is a treasure chest for anyone working with Unix
systems. Linux, OSX, Solaris, IRX, FreeBSD, NetBSD, OpenBSD users are
all catered for alike. This is a true gem of a book. It's big and
heavy, yet it can be enjoyed in small sips. Just pick it up, flip
through the pages and read 2-3 of them. You'll turn away wiser than
when you opened it!

<a href="https://www.amazon.com/Effective-Java-2nd-Joshua-Bloch/dp/0321356683/">
  Effective Java
</a>
If I were to only read one Java book in my life, it should be this
on. This excellent book from Joshua Block focuses on core Java
programming and can be read by any developer, regardless of what
platform or frameworks you're using.


## Programming

### Learn a few languages

Good programmers are proficient in a good few languages. You should be
too. Start out by learning one scripting language, one object oriented
language and one functional language. 

### <a name="api_design"></a> API design

Start off by writing the client code, __then__ implement your
API. This is in some circles advocated through TDD (test driven
development), but you should do this regardless of TDDing (which is of
course, a good idea).

By writing the client code, I mean, write the code the way you as a
user of the great new API you're about to create, would like to
write. E.g. say you want to build a ice cream vending machine
backend. Before implementing all of that, start by writing the client
code that the clients talking to the vending  machine will use, e.g.:

```java
IceCream iceCream = vendingMachine.fillUp(new Cone(Size.BIG, 2));
customer.give(iceCream);
```

Once you're satisfied with the client code, __then__ start
implementing the actual vending machine, the REST calls, the database
layer, the business logic.

Too few developers do this. Therefore, their APIs and systems become
extremely complex to use. Good APIs to draw inspiration from are
the [XOM XML library for Java](http://xom.org) and
the
[Requests HTTP library for Python](http://docs.python-requests.org/). The
APIs "just work" the way you'd expect. At least, the way __I__ would
expect 😉

If you follow this principle and also puts your client code in a unit
test, you'll not only get a nice test that you can run automatically
whenever changing something in your program, but you also magically
ensure that your code becomes loosely coupled and easier to maintain
(trust me on this).
