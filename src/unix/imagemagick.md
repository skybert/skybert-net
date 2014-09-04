title: ImageMagick
date:    2012-10-07
category: unix
tags: java, graphics

ImageMagick is a gem of a library, indispensable in my tool
box. Here are some of my notes on using this excellent piece of
software.

## Converting from CMYK to RGB colour space

Several pieces of software, included, have problems handling
images with the CMYK colour space. Sun/Oracle Java, for
instance, will bail out with this error:

```
Caused by: javax.imageio.IIOException: Unsupported Image Type
at com.sun.imageio.plugins.jpeg.JPEGImageReader.readInternal(JPEGImageReader.java:977)
at com.sun.imageio.plugins.jpeg.JPEGImageReader.read(JPEGImageReader.java:948)
at javax.imageio.ImageIO.read(ImageIO.java:1422) at
```


Luckily, ImageMagick can easily help you out, just do:

    $ convert image.jpg -colorspace rgb image.jpg

ImageMagick can also specific CMYK and RGB profiles for the
conversion, but for most cases, were you <cite>just want
RGB</cite>, the above should suffice.


I've created <a
href="https://github.com/skybert/my-little-friends/blob/master/bash/convert-images-from-cmyk-to-rgb-colour-space">
a wee script which does this en masse</a>. It works on large
archives (where the BASH expansion will go out of bounds if you
use wildcards and/or for loops) and file names containing white
space characters.

```
$ convert-images-from-cmyk-to-rgb-colour-space
Press ENTER to convert all images in the current directory and all sub
directories to standard RGB colour space if they're currently CMYK.

To abort, press Ctrl + c now.

./WCC1.jpg is using the CMYK colour space, converting it to RGB ...
./fds1.jpg is using the CMYK colour space, converting it to RGB ...
./ABNIVSEN2.jpg is using the CMYK colour space, converting it to RGB ...
./MM1.jpg is using the CMYK colour space, converting it to RGB ...
```


And yes, the 'u' in colour is intended :-)




