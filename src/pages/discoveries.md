title: Discoveries
date: 2014-11-22

Skybert's small and big discoveries.

## 2015-02-02

You cannot create files directories on Windows starting with a dot and
no suffix. Try this: create a directory in Windows Explorer
called ".ssh".

Windows will not only fail to do this, but ask you to enter a file
name as if you hadn't written anything at all.

Apparantly this is
[something inherited from the days of old](http://superuser.com/questions/64471/create-rename-a-file-folder-that-begins-with-a-dot-in-windows#comment66479_64471),
i.e. Windows' DOS heritage.

## 2015-01-20

Ugly looking capitalised  music, pictures, documents directories
begone! I prefer to have all my directories and files lower case. It's
easier on my eyes and it reads faster. Thus, I've hated how GNOME and
others enforced a pile of directories with names like "Documents" and
"Music" on me. Deleting them was no good as some kept coming back and
my actual music and document directories didn't get the icon
decoration that their capitalised counterparts got.

As you can understand, I was thrilled when I discovered today that
sanity was a mere text edit away (I thought so!):

    $ vim ~/.config/user-dirs.dir

And then set these to my preferred directories:
```
XDG_DESKTOP_DIR="$HOME/"
XDG_DOWNLOAD_DIR="$HOME/tmp"
XDG_TEMPLATES_DIR="$HOME/tmp"
XDG_PUBLICSHARE_DIR="$HOME/tmp"
XDG_DOCUMENTS_DIR="$HOME/doc"
XDG_MUSIC_DIR="$HOME/music"
XDG_PICTURES_DIR="$HOME/pictures"
XDG_VIDEOS_DIR="$HOME/videos"
```

Logging out and in again in GNOME gave immediate success. The file
manager even had my "pictures" and "music" and "tmp" directories
nicely decorated with meta icons.

## 2015-01-12

[puppet-lint](http://puppet-lint.com/) will not only spot errors and
deviations from Puppet Lab's best practices, it will also fix many of
these issues for you:

``` $ puppet-lint --fix init.pp ```

## 2014-12-23

When using [GNU sed](https://www.gnu.org/software/sed), you can use
much more powerful regular expressions by passing the
```--regexp-extended``` switch to ```sed```.

Passing ```--regexp-extended```, or just ```-r```, also makes some of
the syntax easier as you don't have to escape group parenthesis and I
find ```sed``` overall becomes more predictable using this switch.


## 2014-12-22

<div>
  <a href="http://de.wikipedia.org/wiki/Markdown">
    <img src="http://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/208px-Markdown-mark.svg.png"
         style="height: 200px;"
         alt="markdown"
     />
   </a>
</div>

It's easy writing presentation slides using Markdown and generate
these into beautiful HTML5 slides with CSS3 transitions from
[reval.js](https://github.com/hakimel/reveal.js/)  by using
[pandoc](http://johnmacfarlane.net/pandoc/demo/example9/producing-slide-shows-with-pandoc.html)

Previously, I've been using an exporter to Emacs org, but ```pandoc```
is so much more stable and flexible.

## 2014-12-18

[PlantUML](https://yar.fruct.org/projects/plantuml-deb) is a great
command for generating diagrams from plain text files. It also sports
a Confluence plugin - among other things.

## 2014-12-12

This presenter at [Computerphile](http://youtube.com/user/Computerphile),
he's absolutely brilliant. It's rare to find someone so technical in
computer science being so good at presenting.

<iframe width="560" height="315" src="//www.youtube.com/embed/MijmeoH9LT4" frameborder="0" allowfullscreen></iframe>
## 2014-11-26

[Flask](https://github.com/mitsuhiko/flask): Impressed with what I've
read and tried out so far. In less than 20 lines of code, I've a
standalone micro service Python application which routes different
HTTP URLs to internal methods, reads user input and outputs JSON
objects.

From the (first hour) look at it, it seems that Flask strikes just the
right balance between simplicity and bare bones Python on the one hand
and support for real world world features like security, complex
objects, templating, database integration, application types, error
handling, logging and easy deployment on the other.

<div>
  <a href="http://flask.pocoo.org">
    <img src="http://flask.pocoo.org/static/logo/flask.png"
         style="height: 200px;"
         alt="flask"
    />
  </a>
</div>
## 2014-11-22

I've read about these
[free HTML grids before,](http://www.smashingmagazine.com/2013/08/07/type-grids-free-template/)
but I didn't check them out to see how simple and beautiful they were
before now.

<div>
  <a href="http://www.smashingmagazine.com/2013/08/07/type-grids-free-template/">
    <img
      src="http://media.mediatemple.netdna-cdn.com/wp-content/uploads/2013/08/typeandgrids_05.png"
      alt="html grids"
      style="height: 200px;"
    />
  </a>
</div>

## 2014-11-12
Excellent geeky comic strips: [commitstrip](http://www.commitstrip.com/)

<div>
  <a href="http://www.commitstrip.com/">
    <img
      src="http://www.commitstrip.com/wp-content/uploads/2014/11/Strip-Départ-Adrien-650-finalenglish1.jpg"
      alt="commit strip comic"
      style="height: 200px;"
    />
  </a>
</div>

## 2004-11-10
[Idle highlight](http://www.emacswiki.org/cgi-bin/wiki/IdleHighlight)
mode gives you IDEA/Eclipse-like highlighting of other uses of the
variable/method under your cursor. It only triggers after a slight
delay, which is excellent.

<div>
  <img src="http://i.imgur.com/YJs5WeZ.png"
       alt="idle highlight"
       style="height: 200px;"
  />
</div>


