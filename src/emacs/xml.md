date:    2012-10-07
category: emacs
title: xml
tags: xml

<img class="right" src="/graphics/emacs/emacs.png" alt="png"/>

## XML development in Emacs

I will on this page describe how I
use <a href="http://gnu.org/software/emacs">GNU Emacs</a> as a
powerful XML editor using the excellent
<a href="http://www.thaiopensource.com/nxml-mode/">nxml-mode</a>.

On this page, you'll learn how you can:


- Get <a href="#element-autocompletion">element and attribute
auto completion</a>

- Get <a href="#on-the-fly-syntax-checking">on the fly syntax
checking</a> of your XML code.


## Auto completion of elements and attributes

Out of the box,```nxml-mode``` will do auto completion
for XHTML and Docbook documents. It can support any other XML
format, as long as it can find an```RNC``` file to
describe it. Here, I'm getting auto completion of elements in
a Maven```pom.xml``` file:

<img src="/graphics/emacs/nxml_mode_maven_pom.png" alt="auto complete
element"/>

## On the fly syntax checking

Emacs will also give you on the fly syntax checking. Here, I
am editing an Ant build file, where I've added an illegal
attribute:

<img src="/graphics/emacs/nxml_mode_ant.png" alt="ant and nxml-mode"/>

## Setting it all up
### Installing trang &amp; rngconv

```nxml-mode``` instists on using the RNC
format. Hence, you need to convert your XSDs and DTDs to RNC,
which```nxml-mode``` can use.


You need two pieces of software, <a
href="https://msv.dev.java.net/files/documents/61/31333/rngconv.20060319.zip">rngconv</a>
to convert from```XSD``` to
```RNG``` and <a
href="http://www.thaiopensource.com/relaxng/trang.html"> trang
</a> to convert from```RNG``` (or
```DTD```) to
```RNC```. As you might have guessed,
```rngconv``` is only needed if you've got an
XSD as Trang can deal with DTDs.


Trang &amp; RNGConv might be available in your system's
software repository, such as <a
href="http://packages.debian.org/sid/trang">Debian SID</a>, if
not, this is how to install it manually:

    $ cd /tmp/
    $ wget http://jing-trang.googlecode.com/files/trang-20081028.zip
    $ wget https://msv.dev.java.net/files/documents/61/31333/rngconv.20060319.zip
    $ cd /opt/
    $ unzip /tmp/trang-20081028.zip
    $ ln -s trang-20081028 trang
    $ unzip /tmp/rngconv.20060319.zip
    $ ln -s rngconv.20060319 rngconv

### Creating RNCs from W3C XML Schemas

This is how I convert the Maven POM XML Schema to RNC:

    $ cd ~/library/xml/
    $ wget http://maven.apache.org/maven-v4_0_0.xsd
    $ java -jar /opt/rngconv/rngconv.jar maven-v4_0_0.xsd &gt; maven-v4_0_0.rnc
    $ java -jar  /opt/trang/trang.jar \
-I rng \
-O rnc \
maven-v4_0_0.rng maven-v4_0_0.rnc

### Converting DTDs to RNCs

This is how I created an RNC for Ant```build.xml```
files. First, I created a DTD from <a
href="http://wiki.apache.org/ant/AntDTD">wiki.apache.org</a>

    $ java -jar  /opt/trang/trang.jar -I dtd -O rnc ant-1.6.dtd ant-1.6.rnc

### Download my RNC files

To save you some hassle, you may download my RNC files
here.

- <a href="files/maven-v4_0_0.rnc">maven-v4_0_0.rnc</a>
- <a href="files/ant-1.6.rnc">ant-1.6.rnc</a>
- <a href="files/web-app_2_4.rnc">web-app_2_4.rnc</a>
- <a href="files/struts-config_1_2.rnc">struts-config_1_2.rnc</a>
- <a href="files/spring-beans-2.0.rnc">spring-beans-2.0.rnc</a>


### Make nxml-mode use these RNC files

This is my <a href="files/schemas.xml">~/.emacs.d/schemas.xml</a>
which ```nxml-mode``` will look in to find schema mappings outside its
standard set (which includes Docbook, XHTML).


