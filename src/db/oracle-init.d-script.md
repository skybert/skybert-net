title: Oracle start/stop script that works
date:    2012-10-07
category: db
tags: db, oracle

The oracle start/stop script I’ve found on the net (written
for REHL, I believe), didn’t work for me. Thus, I wrote a
wee script that works for my 11g install (on Debian).


    #! /usr/bin/env bash

    function stop_db()
    {
      sqlplus /nolog <<EOF
      connect /as sysdba
      shutdown
      EOF
      lsnrctl stop
    }

    function start_db()
    {
      sqlplus /nolog <<EOF
      connect /as sysdba
      startup
      EOF
      lsnrctl start
    }

    case "$1" in
      start)
        start_db
        ;;
      stop)
        stop_db
        ;;
      *)
        echo "Usage:" `basename $0` ""
        ;;
    esac

    exit 0



As you can see, its far simpler than the more “official” scripts, but
it does exactly what I want it to, so I’m happy <img
src="http://s2.wp.com/wp-includes/images/smilies/icon_smile.gif?m=1235676807g"
alt=":-)" />

