title: Mounting drives over SSH
date:    2012-10-07
category: linux

<img src="http://tuxbrewr.fedorapeople.org/tuxbrewer.png"
alt="tuxbrewer"
style="float: right;"
/>

As long as you have SSH access to a server, you can comfortably mount
it as a local disk to your own computer. You can either do this in
your file manager (this is the easiest, e.g in GNOME's Nautilus), you
can do it on the command line. However, my favourite, is to do it over
the standard ```/etc/fstab``` mechanism.


These are my entries for mounting two servers over SSH to my
local machine. The file server runs SSH on a non-standard
port, so I need an extra parameter in the```fstab```.


    sshfs#files@myfiles:/           /mnt/myfiles      fuse noauto,user,port=7722 0 0
    sshfs#music@mymusic:/home/music /mnt/mymusic      fuse noauto,user           0 0


I can now mount these file shares from the shell with a standard:

    $ mount /mnt/myfiles
    $ mount /mnt/mymusic


