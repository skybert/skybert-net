title: UTF-8 for the Impatient
date: 2016-02-09

> This is a no nonsense guide to get your full stack Unicode
> compliant. No more squares, no more question marks.

To get you off to a good start, I'll mention that
[Unicode is a character set and UTF-8 is one of several encodings for it](http://skybert.net/talks/charset-and-encoding/).
For all practical use cases, UTF-8 is the best Unicode encoding and
the one you shold use throughout your stack.

I highly recommend reading the
[UTF-8 and Unicode FAQ for Unix/Linux](http://www.cl.cam.ac.uk/~mgk25/unicode.html)
guide and browse the beautifully presented
[Unicode Character Table](http://unicode-table.com/en/), but for now,
let's jump straight into the nitty gritty details on how to turn your
stack, your app, into a fully Unicode speaking and reading system.

## UNIX, Linux & Cygwin

Be sure to have at least one UTF-8 locale.

### Debian, Ubuntu & friends

See all UTF-8 locales on your system:

```bash
$ locales -a | grep UTF-8
```

If you cannot see any, run this command, select some and generate
them:

```
# dpkg-reconfigure locales
```

### BASH
Set your LANG and LC_ALL environment variables to one of the UTF-8
locales available on your system.

```bash
export LANG=en_GB.utf8
export LC_ALL=en_GB.utf8
```

You may to put this in your `$HOME/.bashrc`.

### Terminal

<img class="right" src="/graphics/2016/konsole.png" alt="konsole"/>

Your terminal emulator must have support for Unicode. I love
[urxvt](http://software.schmorp.de/pkg/rxvt-unicode.html), even though
it only support 3 byte UTF-8 characters. for 4 byte UTF-8, you have to
use terminals like
[gnome-terminal](https://wiki.gnome.org/Apps/Terminal) or
[konsole](https://konsole.kde.org/).

### Fonts

If you're seeing squares instead of characters, it means that the font
you're using is missing a glyph to represent that character.

The trick is to pick a font which has support for the characters that
you need. There are a good number of fonts which support everything up
to and including the 3 byte UTF-8 characters, but not the 4 byte
characters (like 👻). In some contexts, you can have a primary font and
several fall back fonts which may provide the more exotic characters.

My favourite fonts at the moment are:

- Adobe Source Code Pro (manual installation)
- Terminus (```apt-get install xfonts-terminus```)

To use `Adobe Source Code Pro`, I start my `urxvt` like this:
```bash
urxvt -fn 'xft:Source Code Pro:pixelsize=14'
```

## DB

### MySQL, MariaDB & Percona

The MySQL `utf8` table & column encoding is not real UTF-8 Only 1-3
byte characters supported.  For full UTF-8 support, use the `utf8mb4`
type instead.

#### Create new DBs with 4 byte UTF-8 character support

```sql
mysql> create database mydb character set utf8mb4 collate utf8mb4_general_ci;
```

#### Check the default encoding and collation

```sql
mysql> select schema_name, default_character_set_name, default_collation_name from information_schema.schemata;
```

## Java

### Resource bundles

Contrary to popular myth, it *is* possible to use UTF-8 in your
`.properties` files (aka resource bundles).  You just need to do this:

```java
public String getPropertyFromUTF8File(final String pKey)
  throws IOException {

  ResourceBundle bundle = ResourceBundle.getBundle(
    "ghost-text-utf8", Locale.ENGLISH);
  String value = bundle.getString(pKey);
  return new String(value.getBytes("ISO-8859-1"), "UTF-8");
}
```

### File encoding

The encoding of the actual Java source files only affect the
characters which you write in the `.java` file itself. The file
encoding does not affect in any way the data that flows through the
Java program you write.

### Maven

Have you ever seen this one?

```
[WARNING] File encoding has not been set, using platform encoding
          UTF-8, i.e. build is platform dependent!
```

Just add this to your POM to get rid of it:

```xml
<properties>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

You can now use UTF-8 in your source files.  A ♥ looks so much better
than `\u2665`

### JDBC
Add the following to your JDBC connection string:
```html
useUnicode=true&amp;characterEncoding=UTF-8&amp;characterSetResults=UTF-8"
```

### JVM parameters
```
-Dsun.jnu.encoding=utf-8
-Dfile.encoding=utf-8
```

## HTTP

HTTP calls a character encoding, character set (!):

```
Content-Type: text/html; charset=iso-8859-1
```

The one to blame is MIME, the specification which gives bold text and
pictures with our emails. MIME,
[RFC 2045, May 1996](https://tools.ietf.org/html/rfc2045), used the
term "charset", so HTTP 1.0
[RFC 1945, May 1996](http://tools.ietf.org/html/rfc1945) wanting to
keep the terminology consistent, also went
with this term. It did add a note, however:

> Note: This use of the term "character set" is more commonly referred
> to as a "character encoding." However, since HTTP and MIME share the
> same registry, it is important that the terminology also be shared.

No wonder people get confused!

## HTML

Since HTTP uses `charset` to mean character encoding, HTML does too:


```html
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
```

## XML


The [XML specification](http://www.w3.org/TR/xml/#charencoding) says
the standard encoding is
[UTF-8](http://en.wikipedia.org/wiki/UTF-8). All XML parsers must as a
minimum support UTF-8

```xml
<?xml version="1.0" encoding="utf-8"?>
```


## Server Sent Events (SSE)

The Server Sent Events are
[always UTF-8 encoded](https://html.spec.whatwg.org/multipage/comms.html#server-sent-events)


## Converting a file to UTF-8 on the command line

To convert one (or a thousand) text files to use UTF-8 on the command
line, use the standard [iconv](http://linux.die.net/man/1/iconv)
utility, it's a part of the GNU C library. On Debian, it's provided by
the `libc-bin` package:

```bash
$ iconv -f ISO-8859-1 -t UTF-8 my-file.xml -o my-file.xml.utf8
```

## Checking encoding of a text file from the command line

```bash
$ file -i /tmp/test.txt.latin1
/tmp/test.txt.latin1: text/plain; charset=iso-8859-1
```

## Editors

### VIM

On my machine, using VIM 7.4 and UTF-8 compatible locale settings (see
the notes on `LC_ALL` above), files that contain non-ASCII characters
are automatically saved using UTF-8 encoding.

If you prefer to be explicit about it, to always use UTF-8, add this
to your `.vimrc`:

```conf
set encoding=utf-8
set fileencoding=utf-8
```

### Emacs

Emacs will respect whatever encoding an existing file uses, but you
can ask it to prefer UTF-8 when it has a choice (like creating a new
file):

```lisp
(prefer-coding-system 'utf-8-unix)
```

You may also ask Emacs to use a specific Unicode friendly font:

```lisp
(set-frame-font "-adobe-Source Code Pro-semibold-normal-normal-*-*-*-*-*-m-0-iso10646-1")
```

### editorconf

```conf
[*]
charset = utf-8
```
