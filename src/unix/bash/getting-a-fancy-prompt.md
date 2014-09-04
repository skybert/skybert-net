date:    2012-10-07
category: bash
title: Getting a Fancy Prompt
## For Normal Users

I use this for my normal user.

    export PS1="\[\033[0;36m\]{\[\033[0;50m\]\w/\[\033[0;36m\]} \[\033[0;32m\]what now... \[\033[0;39m\]"


Produces:

```<span style="color:
cyan;">{</span>/var/www/<span style="color: cyan;">}</span>
<span style="color: green">what now...</span>```

## For the Root User

I use this for my root user, it's important for me that the
user name```root``` stands out in bold read colour to
remind me to be careful :-)

    export PS1="\[\033[1;31m\]\u\[\033[0;0m\]@\h "


This produces:
```
<span style="color: red; font-weight: bolder;">root</span>@mithrandir
/var/www#
```


