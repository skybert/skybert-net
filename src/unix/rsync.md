date:    2012-10-07
category: unix
title: rsync

## rsyncing using SSH running on a non standard port

This is how I backup my files to a remote server using SSH
running on a non standard port and identifying using my RSA
key.


    $ rsync -au \
      -e 'ssh -p 5555 -i /home/torstein/.ssh/id_rsa' \
      /home/torstein/graphics/ \
      myserver:/var/backups/graphics/


For an in-depth explanation of the various switches, see
```man rsync```.


