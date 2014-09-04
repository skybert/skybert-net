date:    2012-10-07
category: webdesign
title: Handy Tools for Working With XML

Hi there, I'll will here keep small bits and pieces of XML
things that are handy to know. Right now this page is only
as a reminder for mysself, but I might produce a "real"
document later :-)

## Format an XML document
    xmllint -format &lt;xml.file&gt;

## Validate using the DTD

The DTD needs to be locally available. If it is referred by
a valid external URI, add the```--loaddtd```
option. 

    xmllint --validate &lt;xml.file&gt;

## Validate using Schema
    
xmllint --schema  &lt;file.xsd&gt;  &lt;file.xml&gt;


## Converting an W3C Schema to a Relax NG schema

Below I demonstrate converting to both human readable (RNG)
and compact (RNC) Relax NG from a normal W3C schema XSD
file:

    
    # converting from XSD to RNG
java -jar /opt/rngconv/rngconv.jar\
    $file.xsd\
> $file.rng

    # conveting from RNG to RNC    
java -jar /opt/trang/trang.jar\
-I rng\
-O rnc\
    $file.rng\
    $file.rnc



PS: The```trang``` utility is also available as a
Debian package.


