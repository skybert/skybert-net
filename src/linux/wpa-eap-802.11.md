title: WPA-EAP & IEEE 802.11 auth using only wpa_supplicant
date: 2018-02-05
category: linux
tags: linux, wpa, security

I don't like NetworkManager so this is how I've configured IEEE 802.11
authentication through WPA-EAP using pure `wpa_supplicant` and
`ifup`/`ifdown` on Debian:

```
# vim /etc/network/wireless-networks.conf
```

```
ctrl_interface=/var/run/wpa_supplicant
 
# WPA2-EAP                                                                       
network={
  ssid="Foo"
  key_mgmt=WPA-EAP
  proto=WPA2
  eap=TLS
  identity="tkj"
  client_cert="/home/torstein/doc/2018/wireless/tkj.pem"
  private_key="/home/torstein/doc/2018/wireless/tkj.des3.key"
  private_key_passwd="<my-pass-set-on-tkj.des3.key>"
}

```

`tkj` is my Active Directory user name and this file contains the
configuration for all wireless networks I'm using.

To use this `wireless-networks.conf`, I wire it up like this to
Debian's main network interfaces file:

```
# vim /etc/network/interfaces
iface wlan0 inet dhcp
      wpa-conf /etc/network/wireless-networks.conf
      post-up /etc/init.d/firewall start
```

To connect to the "Foo" wireless access point using WPA-EAP and
IEEEE 802.11, I do:

```
# ifup -v wlan0
```

That's it. Not pesky Network Manager adding smoke to the land of
confusion 😃
