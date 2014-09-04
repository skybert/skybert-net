date:    2012-10-07
category: unix
title: Screen

To put a nice footer on your screen session, enter the
following in your```~/.screenrc```

    hardstatus alwayslastline "%{= kR}%H %{= kY}%M %d %{= kG}%c %{= kB}%?%-Lw%?%{= kW}%n*%f %t%?(%u)%?%{= kB}%?%+Lw%?"


To be able to use Emacs shortcuts (in BASH and in the editor),
map the escape to```C-z```; whoever wrote screen wasn't
an Emacs user!

    # use C-z as Screen control key
    escape ^Zz

