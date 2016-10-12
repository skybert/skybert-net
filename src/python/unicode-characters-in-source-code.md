title: Writing Unicode Characters in Python source code
date: 2016-07-14
category: python
tags: python, encoding, unicode

Python is so incredible smart, it understands both Emacs and VIM hints
about source code encoding. E.g. putting this in the beginning of the
file will make both Emacs and the Python interpreter able to properly
display, save, byte compile and run the Python program:

```
# -*- coding: utf-8-unix -*-
```

There's a corresponding setting for VIM as well as a non-editor
related one, check out [PEP-0263](
https://www.python.org/dev/peps/pep-0263/) for more information.
