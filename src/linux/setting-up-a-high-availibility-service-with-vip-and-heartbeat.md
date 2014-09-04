title: Setting Up a High Availibility Service With Vip and Heartbeat
date:    2012-10-07
category: linux
tags: performance, high-availability

## Objective

We've got two hosts on the same network, wind (.108) and fire
(.109) and they are to provide the VIP .200, which again
relates to a crucial service which users only relate to by the
host name of the VIP.


This VIP should at all times answer to requests, directing the
traffic to wind normally, but in case wind is down, fire
should take over automatically and answer to requests to the
VIP.

## Before we start

I used Debian Wheezy (testing at the time of writing) for
setting this up. It should be pretty straight shooting to
follow this guide on Debian based systems, such as Ubuntu too.


Start by setting up wind, then replicate the configuration to fire.


We don't need a CRM such as Pacemaker as Heartbeat is more
than capable handling two nodes providing a service. If we'd
needed three or more nodes providing one VIP or service,
Pacemaker is the most used companion to heartbeat (previously
called the crm module, now the directive is called pacemaker
as it's diverged into its own project).


## /etc/hosts

All hosts must know about each other by the node name, so wind
has:

    192.168.1.109 fire


and fire has:

    192.168.1.108 wind

## kernel tweaking

Add this to your /etc/sysctl.conf:

    # needed to bind to VIP
net.ipv4.ip_nonlocal_bind=1


Load this with sysctl -p and make it persistent by running it
at boot time, such as from /etc/rc.local

## install heart beat
    # apt-get install heartbeat

## /etc/ha.d/authkeys
    ( echo -ne "auth 1\n1 sha1 "; \
dd if=/dev/urandom bs=512 count=1 | openssl md5 ) \
&gt; /etc/ha.d/authkeys
chmod 0600 /etc/ha.d/authkeys

## /etc/ha.d/ha.cf
    ###############################
    # logging
debugfile /var/log/ha-debug

    ###############################
    # communication
autojoin none
udpport 694
    # the other node
ucast eth0 192.168.1.109
udp eth0

    ###############################
    # thresholds
warntime 5
deadtime 15
initdead 60
keepalive 2

    ###############################
    # nodes
node wind
node fire

## /etc/ha.d/haresources

    # &lt;primary node&gt; &lt;virtual IP (VIP)&gt;
wind 192.168.1.200>

## Propagate the settings to fire
    $ /usr/share/heartbeat/ha_propagate


Watch out, the path on Debian differs from <a
href="http://www.linux-ha.org/doc/users-guide/_propagating_the_cluster_configuration_to_cluster_nodes.html">the
official HA Proxy guide</a>


Be sure to look over ha.cf, change the reference to the other
node and confirm that the interface name is the same as on
wind.

## Read, set, go!

Now, you should be ready to try it out.


    $ ssh root@wind
    # /etc/init.d/heartbeat restart


wind should have bound the VIP to itself now as we've defined
it to be the master node:

    $ ifconfig eth0:0


Then, go to fire and restart heartbeat there too. Once you've
done that, go back to wind and stop the network.

    $ ssh wind
    $ /etc/init.d/networking stop


Then switch to fire and confirm that it has "stolen" the VIP:

    $ ssh fire
    $ ifconfig eth0:0


Last step now, is to bring wind up again and see that it re-acclaims
the VIP.

Congrats, you've just set up a high availability solution with VIPs!
All clients can now safely relate to the VIP instead of the actual IP
of any server providing the service.

