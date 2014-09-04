title: Import hacks
date:    2012-10-17
category: escenic

Import and especially big data migration is a domain full of
dark art and vodoo magic. Here, I've written done some things
which will make your life easier when working with Escenic
Content Engine imports.

## Analysing the logs for import errors

I've created the following command to analyse the import
related errors:
<a href="https://github.com/skybert/ece-scripts/blob/master/usr/share/escenic/import-scripts/import-error-log-analyzer">
import-error-log-analyzer
</a>


Among other things, it will output things like:


- Missing multimedia files
- Multimedia files with the wrong case (typical problem with
import jobs only tested on a Windows platform before moving
into staging/production.
- Empty multimedia files.

- Images with the wrong colour space (images imported into
Escenic Content Engine must use the RGB colour space).

- SAX parsing errors

- Resulting Escenic XML (after parsing it from the origin XML
format) having unknown/unhandled fields++


The script will also suggest shell commands on how to fix some
of these errors.

## Retrying all failed import jobs

    $ cd /var/spoo/escenic/import/my-import-job/error
    $ i=0; for el in *.xml; do i=$(( $i + 1 )); mv $el ../new/${i}.xml; done

## Convert all images to use the RGB colour space

The ECE importer will fail to import images that uses e.g. the
CMYK colour space. If you've got images that come from a print
CMS, there are good chances for these to have pictures using
CMYK as this is the de facto standard in the print and
photography worlds.


It's easy fixing this using ImageMagick, though. I've written <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/graphics/convert-images-from-cmyk-to-rgb-colour-space">a
script which converts all pictures to RGB</a>.

## Making all images r/o

The ECE importer will move imported (and failed) images to the
archive and error diretories. If you wish to keep them in
their original folder, remove the writable bit on the files:


    $ find /var/exports/import-data/images/ -iname "*.jpg" | while read f; do chmod 444 "$f"; done


## Confirming that the XSL does its intended job

    $ xsltproc transform-from-3rd-party-content-to-escenic.xsl 3rd-party-content.xml


## Checking that XML files are well formed

    $ xmllint --format my-file.xml


## Getting import status per import job

Use my <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/escenic/import-status">
import-status script</a> and pass the base directory of your imports:

    $ import-status --dir /var/spool/escenic/import/dn
    Status of imports in /var/spool/escenic/import/dn
    Seconds since last import status: 317
    New    : 124813 since last: -2529
    Error  : 1244 since last: 6
    Archive: 466398 since last: 2528
    Speed  : 7 files/s
    Estimated finish: 4h 32m


## Converting images from the CMYK colour space to RGB

The Escenic Content Engine will fail if you try importing an image
with a CMYK colour profile. To remedy this, you can first run my wee
script <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/graphics/convert-images-from-cmyk-to-rgb-colour-space">
convert-images-from-cmyk-to-rgb-colour-space </a>:

```
$ convert-images-from-cmyk-to-rgb-colour-space
Press ENTER to convert all images in the current directory and all sub
directories to standard RGB colour space if they're currently CMYK.

To abort, press Ctrl + c now.

Started: Thu Sep 27 16:36:29 IST 2012
Number of pictures in /var/spool/escenic/import/images: 1892
Picture #23 uses CMYK color profile, converting it to RGB ...
Picture #43 uses CMYK color profile, converting it to RGB ...
Picture #45 uses CMYK color profile, converting it to RGB ...
Picture #72 uses CMYK color profile, converting it to RGB ...
Picture #526 uses CMYK color profile, converting it to RGB ...
Picture #651 uses CMYK color profile, converting it to RGB ...
Picture #690 uses CMYK color profile, converting it to RGB ...
Picture #1371 uses CMYK color profile, converting it to RGB ...
Picture #1667 uses CMYK color profile, converting it to RGB ...
Picture #1675 uses CMYK color profile, converting it to RGB ...
Picture #1678 uses CMYK color profile, converting it to RGB ...
Picture #1679 uses CMYK color profile, converting it to RGB ...
Picture #1727 uses CMYK color profile, converting it to RGB ...
Picture #1736 uses CMYK color profile, converting it to RGB ...
Picture #1740 uses CMYK color profile, converting it to RGB ...
Picture #1770 uses CMYK color profile, converting it to RGB ...
Picture #1830 uses CMYK color profile, converting it to RGB ...
Picture #1838 uses CMYK color profile, converting it to RGB ...
Picture #1875 uses CMYK color profile, converting it to RGB ...
Finished: Thu Sep 27 16:38:02 IST 2012
```


