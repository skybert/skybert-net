title: Ensure that your full stack is UTF-8 compliant
date: 2016-02-09

UTF-8 is for all use cases I've seen, the best Unicode encoding and
the one you shold use throughout your stack.

## UNIX, Linux & Cygwin

Be sure to have at least one UTF-8 locale.

### Debian, Ubuntu & friends

See all UTF-8 locales on your system:

```
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

```
export LANG=en_GB.utf8
export LC_ALL=en_GB.utf8
```

You may to put this in your `$HOME/.bashrc`.

### Fonts

## DB

### MySQL, MariaDB & Percona

The `utf8` typeThe MySQL `utf8` table & column encoding is not real
UTF-8 Only 1-3 byte characters supported.  For full UTF-8 support, use
the `utf8mb4` type instead.

#### Create new DBs with 4 byte UTF-8 character support

```
mysql> create database mydb character set utf8mb4 collate utf8mb4_general_ci;
```

> Note, MySQL's utf8 type isn't full UTF-8, you need to use utf8mb4.

#### Check the default encoding and collation
```
mysql> select schema_name, default_character_set_name, default_collation_name from information_schema.schemata;
```

## Java

### Resource bundles

Contrary to popular mythin, it *is* possible to use UTF-8 in your
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

### Maven

Have you ever seen this one?

```
[WARNING] File encoding has not been set, using platform encoding
          UTF-8, i.e. build is platform dependent!
```

Just add this to your POM to get rid of it:

```
<properties>
  <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

You can now use UTF-8 in your source files.  A ♥ looks so much better
than `\u2665`

### JDBC
Add the following to your JDBC connection string:
```
useUnicode=true&amp;characterEncoding=UTF-8&amp;characterSetResults=UTF-8"
```

## JVM parameters
```
-Dsun.jnu.encoding=utf-8
-Dfile.encoding=utf-8
```

## HTML

```
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
```

## XML

```
<?xml version="1.0" encoding="utf-8"?>
```

The [XML specification](http://www.w3.org/TR/xml/#charencoding) says
the standard encoding is
[UTF-8](http://en.wikipedia.org/wiki/UTF-8). All XML parsers must as a
minimum support UTF-8

## Editors

### Emacs
