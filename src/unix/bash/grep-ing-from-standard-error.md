date:    2012-10-07
category: bash
title: Grep-ing from standard error

Sometimes you find yoruself wanting to grep for content that's
being sent to standard error instead of standard out. One
example is the response header information sent from
```wget``` when passing the
```--server-response``` parameter.


What you do is to add this at the end of the command you want
to grep the output of:

    2>&1 >/dev/null


So, to grep on the response HTTP headers returned by
```wget``` command, you'd do:


    $ wget \
      --quiet \
      --server-response \
      http://example.com \
      2>&1 >/dev/null | \
      grep <what ever you are looking for>


That's it!

