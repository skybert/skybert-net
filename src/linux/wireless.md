date:    2014-08-16
category: linux
title: Setting up Wireless

## The Old School Way

Configure your wireless networks in
e.g.```/etc/wpa_supplicant/my-networks.conf```:

```
 ctrl_interface=/var/run/wpa_supplicant

# WEP network
network={
  ssid="myessid"
  scan_ssid=1
  key_mgmt=NONE
  auth_alg=OPEN
  wep_key0=myverydifficultpassword
  wep_tx_keyidx=0
}

# WPA network
network={
  ssid="myothernetw2ork"
  scan_ssid=1
  key_mgmt=WPA-PSK
  psk="myverydifficultpassword"
}
```

and make```/etc/network/interfaces``` use it:

    iface wlan0 inet dhcp
    wpa-conf /etc/wpa_supplicant/my-networks.conf
    post-up /etc/init.d/firewall start


wpasupplicant also supports roaming, to use roaming, replace
```wpa-conf``` with ```wpa-roam```.

## Getting help with all the required fields

If you've got problems figuring out all the correct settings
for your```wpasupplicant``` configuration file, you
may use NetworkManager to read the settings:

    $ grep "Config: added" /var/log/daemon.log | grep NetworkManager

## Troubleshooting
### wpa_supplicant fails to start

If you see that```wpa_supplicant``` fails to start
with this message:

    wpa_supplicant: /sbin/wpa_supplicant daemon failed to start


run the wpa_supplicant command manually in the foreground
(this means not adding the```-B``` switch) with
debugging (this means adding the```-q``` switch):

    # /sbin/wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/my-networks.conf -q

### SIOCSIFFLAGS: Unknown error 132

I was all of a sudden, without changing my system (as far as I
know) getting this really odd error on kernel
version```2.6.32-trunk-686```:

    # ifup -v wlan
    [..]
    SIOCSIFFLAGS: Unknown error 132
    Failed to bring up wlan0.

I was just about trying another kernel, when I checked the wifi on/off
switch on my laptop. It turned out, my wifi wasn't properly turned
on. Pushing the switch in place made a world of diffrence,```ifup
wlan0``` now got the interface up!

