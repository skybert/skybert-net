
# Squares and question marks

> An adventure into the world of character sets and encodings

<a href="torstein.k.johansen AT gmail DOT com">Torstein Krause Johansen</a>

---

## Goals for this talk
- Understanding for what a character set is
- Understanding for what an encoding is
- Ability to differentiate encoding problems from rendering problems
- Debunk 2 myths

---

### Shouldn't it say "Kjører" here?

> KjÃ¸rer

and other questions

---

You'll get a *Quiz* at the end, so pay attention!

---

## Crash course: character sets and encodings

---

###  American Standard Code for Information Interchange

<img src="usa-uk.jpg" alt="usa &amp; uk"/>

- An absolute genius of a standard
- ...as long as you speak English

---

### ASCII - for nerds
- 7 bit
- One character corresponds to one numeric value e.g.:

```

Character | Desimal | Binær         |
A         | 65      | 1 0 0 0 0 0 1 |
B         | 66      | 1 0 0 0 0 1 0 |
```

Value for upper case letter + 32 = value for the lower case letter:
```

Character | Desimal | Binær         |
a         | 97      | 1 1 0 0 0 0 1 |
b         | 98      | 1 1 0 0 0 1 0 |
```

Brilliant!

---

### And then came the Europeans

<img src="columbus.jpg" alt="Columbus"/>

One needed new characters that didn't exist

---

### And then came the Europeans - II

- ...but the house was full, all the 127 rooms were taken
- ...so they added another zero

> **0** 1 0 0 0 0 0 1

---

### 256 characters, hurrah!

---

### And then came the Asians

<img src="dragon.png" alt="Dragon"/>

> 你好嗎？

---

### A whole lot of nonsense

- Many made their own character sets
- Incompatibility all around

---

### Finally peace: Unicode

- Caters for all characters and letters in all dead and spoken
  languages (has today more than 110 000 characters)
- And more room to spare if other languages decide to drop by

---

### Unicode is a character set

A table with entries for all letters and character in the entire
world. Each entry has:

- Numeric values (code points)
- A name

---

### Unicode examples

- The character "Ω" has the numeric value 937 an the name "GREEK
  CAPITAL LETTER OMEGA"

- The character "Å" has the numeric value 197 and the name "LATIN
  CAPITAL LETTER A WITH RING ABOVE"

---

### How to find the Unicode value (code point) for a character

For instance "~" (tilde)?

Word wide web: [Unicode Character Table](http://unicode-table.com/en/)

Java:

    String c = "~";
    int unicodeCodepoint = (int) c.charAt(0);

JavaScript:

    var c = "~";
    var unicodeCodepoint = c.codePointAt(0);

Emacs:

    M-x describe-char

---

### UTF-8

- Has conquered the world
- ASCII compatible
- Invented by Ken Thompson in 1992 while he was having dinner in a
  restaurant
- A standard so simple you can explain it on a napkin

---

### UTF-8 - for nerds

- Killer feature #1: All ASCII strings are valid UTF-8; An ASCII
  string encoded in UTF-8 has **0** as the first bit.

- Killer feature #2: Easy to navigate and find current, previous and
  next character.

- Unicode characters can use up to **4** bytes (the digits are the
  header fields, the **x**s can be used for actual values):

```
11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
```

---

### The difference between Unicode and UTF-8

- Unicode is a table with numeric values and names for all characters
in the whole wide world.

- UTF-8 is of several ways to encode a Unicode numeric value to
  bytes.

---

### Why is this important?

For instance, consider this:

- UTF-8 : ASCII compatible
- UTF-16 : **not** ASCII compatible (Windows & Java)
- UTF-32 : **not** ASCII compatible

---

## Character set & encoding in Java, HTML, HTTP & friends

---

### Java

[Java's internal representation of strings is Unicode](https://docs.oracle.com/javase/7/docs/technotes/guides/intl/overview.html)
(with UTF-16 encoding)

    final String name = getNameFromFacebook(id);

---

### Java Resource bundles

- [Java resource bundles must be encoded in ISO-8859-1](http://docs.oracle.com/javase/7/docs/api/java/util/PropertyResourceBundle.html).

- Characters that don't fit into ISO-8859-1 must therefore be
  represented using Unicode escape notation:

```
native2ascii -encoding utf8 resources.utf8 resources.properties
```

- Or, it is still possible to write UTF-8 into your .properties if you
on the Java side do:
```
return new String(val.getBytes("ISO-8859-1"), "UTF-8");
```

---

### Flex & ActionScript

- [Default encoding in Flex](https://www.adobe.com/support/documentation/en/flex/1/internationalization_flex_short/internationalization_flex_short9.html)
is UTF-8.

- You can override this in the MXML file:
  ```<?xml version="1.0" encoding="iso-8859-1"?>```

- Or your editor can specify the encoding when it writes the file to
disk, burning a mark in it using a so called BOM

---

### Did you say BOM?

- BOM is something that we can use if cannot write the encoding into
the file's contents.

- For instance when we when write a plain text file

- An example of a [UTF-8 encoded file without BOM](hello-without-bom.txt)

- An example of a [UTF-8 encoded file with BOM](hello-with-bom.txt)

---

### XML

    <?xml version="1.0" encoding="utf-8"?>

- The [XML specification](http://www.w3.org/TR/xml/#charencoding)
dictates that the standard encoding to be
[UTF-8](http://en.wikipedia.org/wiki/UTF-8)

- All XML parsers must as a minimum support UTF-8

---

### HTTP

When we surf on [facebook.com](http://facebook.com) or write Java code
that consume REST, RPC over HTTP and SOAP services, the server says
with which encoding the contents is serialised:

    $ GET http://vg.no
    [..]
    Content-Type: text/html; charset=iso-8859-1

<img src="facebook.png" alt="facebook"/>

---

### HTML

Inside the HTML file itself, it's also important that the encoding
is correct so that the contents is _displayed_ properly in the web
browser:

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

---

### Runtime environment

In additoin to how the data are stored and serialised it's also
important that we take care of things on our side:

- Fonts

---

### Runtime environment - for nerds

#### JVM parameters

```

-Dsun.jnu.encoding=utf-8
-Dfile.encoding=utf-8
```

#### JDBC connection string

    jdbc:jtds:sybase://db01:4100/mydb?characterEncoding=utf8

#### UNIX locale
```

$ export LC_ALL=en_GB.utf8
$ export LANG=en_GB.utf8
```
---

### Myth #1

> The encoding of the Java file decides how the data that are written
> by this Java component is written to the database.

---

### Myth #1 busted

The file encoding only decides how the characters in the Java file
itself are stored and displayed:
```
/**
 * @author Søren Westergård
 */
 final static String PRODUKT = "UFØ";
```

Data encoding, on the other hand, decides how the _data_ (which the
Java program writes or reads) are read and written:
```
database.writeData(data, Encoding.UTF-8);
```

---

### Myth #2

> The encoding inside system X affects the data it sends out and how
> our system saves these data in our system.

---

### Myth #2 busted

It's irrelevant that system X stores its data internally as
[Windows 1252](http://en.wikipedia.org/wiki/Windows-1252) as long as
the web services through which it exposes these data returns XML
encoded as [UTF-8](http://no.wikipedia.org/wiki/UTF-8).

---

## The database

- Many databases in Europe used (and several still use!)
  [ISO-8859-1](http://no.wikipedia.org/wiki/ISO_8859-1) encoding.
- If someone attempts to write a character into these databases that's
  not covered by
  [ISO-8859-1](http://no.wikipedia.org/wiki/ISO_8859-1), for instance "*–*"
  [Unicode EN DASH](http://no.wikipedia.org/wiki/Unicode)
  (hyphen), the database will throw an error up to the web application.

<a href="different-encodings.svg">
<img src="different-encodings.svg" "different encodings"/>
</a>


```
User (ok!) => Flex (ok!) => BlazeDS (ok!) => Java (ok!) => Database (BANG!)
```

---

## Quiz

---

### Unicode is ....

1. An encoding
2. A character set

---

### UTF-8 is ....

1. An encoding
2. A character set

---

### Can you save "Alfa and Ω" in a database with ISO 8859-1 encoding?

1. Yes
2. No

---

### If you see big squares instead of letters, it's because ...

1. The data are saved using one encoding and are displayed with another
2. The character set used when saving the data didn't have support for
   the letter(s)
2. The font you're using (say "Times New Roman") is missing the letter(s)

---

### If my Java source file uses Windows 1252 encoding, will æ, ø and å be written correctly to the database?

1. Yes
2. No
3. That depends on how the DB and the JDBC connection are set up

---

### What has happened here?

> KjÃ¸rer

1. You're missing a font to show the letter after "Kj".
2. There's a mismatch between the encoding used when saving the data
   and displaying them.

---

## Summary - for everyone

- If you're seeing **squares** it's because the font your program is
  using doesn't have support for the letter (but _everything is ok
  with the system_).

- If you're seeing complete nonsense like **KjÃ¸rer** it's because
  something has gone wrong with the encoding one or more places in the
  system you're using.

---

## Summary - for everyone - II

- Which character sets and encoding third party systems are using
  internally is irrelevant.

- What matters is how the data is _transported_ between the systems.

---

## Summary - for nerds

- Character set and encoding are not the same (at least since 1992)
- Unicode and UTF-8 are not the same
- Use [UTF-8](http://no.wikipedia.org/wiki/UTF-8) encoding everywhere:
  file encoding, data encoding, JDBC connection strings, UNIX locales.

---

## Q?

---

## Further exploration into the world of Unicode

-
  [UTF-8 and Unicode FAQ for Unix/Linux](http://www.cl.cam.ac.uk/~mgk25/unicode.html):
  very thorough and good introduction to character sets and encoding.

- [Unicode Character Table](http://unicode-table.com/en/): lets you
  explore the entire Unicode table visually

- [UTF-8](http://en.wikipedia.org/wiki/UTF-8) on Wikipeidia

- [Java Rough Guide To Character Encoding](http://illegalargumentexception.blogspot.no/2009/05/java-rough-guide-to-character-encoding.html)

-
[Unicode in Windows' CLI](http://illegalargumentexception.blogspot.no/2009/04/i18n-unicode-at-windows-command-prompt.html#charsets_javaconsole)

---

# echo comments >

## [\@torsteinkrausew](https://twitter.com/torsteinkrausew)

## [http://skybert.net](http://skybert.net)
