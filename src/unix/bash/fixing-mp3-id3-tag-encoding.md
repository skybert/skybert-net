title: Fixing MP3 ID3 Tag Encoding
date:    2012-10-07
category: bash
tags: music, mp3, encoding

I had a huge music library of mostly Taiwanese and Japanese
music. The encoding of the text inside the MP3 ID3 tags were
wrong. After observing that using the```big5```
encoding, the output always looked right:


    $ mid3iconv --encoding=big5 --dry-run --debug file.mp3



I ran this command inside the root folder of the music
collection to fix up the encoding of the ID3 tags of all the
MP3 files:


    $ cd ~/music/strange-encoding/
    $ find -type f | while read f; do mid3iconv -e big5 "$f"; done



And now, all the MP3 files have readable title, artist and
album information!

