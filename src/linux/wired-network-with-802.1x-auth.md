title: Wired Network With 802.1x authentication
date: 2022-09-29
category: linux
tags: linux, networking


This is how I set up wired networking with 802.1x authentication
*without* NetworkManager (which I don't like).

## wpa_supplicant

Even though this is a wired connection, you need `wpa_supplicant`:

```text
# vim /etc/wpa_supplicant/wpa_supplicant-wired-adapter.conf
```

```conf
ctrl_interface=/run/wpa_supplicant
ap_scan=0

network={
  key_mgmt=IEEE8021X
  eap=PEAP
  identity="john"
  password="foo"
  phase2="autheap=MSCHAPV2"
}
```

Since it contains a password, hashed or not, be sure that only `root`
can read it:

```text
# chmod 600 /etc/wpa_supplicant/wpa_supplicant-wired-adapter.conf
```

Now, start `wpa_supplicant` for your network interface, `enp0s20f0u7`
in my case:

```text
# wpa_supplicant -i enp0s20f0u7 -D wired -c /etc/wpa_supplicant/wpa_supplicant-wired-adapter.conf
Successfully initialized wpa_supplicant
enp0s20f0u7: Associated with 99:43:33:23:1d:21
enp0s20f0u7: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
```

## Getting an IP 
Now, when I run `dhclient`, the `wpa_supplicant` kicks into play:

```text
enp0s20f0u7: CTRL-EVENT-EAP-STARTED EAP authentication started
enp0s20f0u7: CTRL-EVENT-EAP-PROPOSED-METHOD vendor=0 method=25
enp0s20f0u7: CTRL-EVENT-EAP-METHOD EAP vendor 0 method 25 (PEAP) selected
enp0s20f0u7: CTRL-EVENT-EAP-PEER-CERT depth=1 subject='/DC=com/DC=example/CN=Company Issuing CA02 256' hash=234234asdfadsf23424
enp0s20f0u7: CTRL-EVENT-EAP-PEER-CERT depth=0 subject='/CN=radius.example.com hash=asd234243243sadfsfd234243
enp0s20f0u7: CTRL-EVENT-EAP-PEER-ALT depth=0 DNS:radius.example.com
EAP-MSCHAPV2: Authentication succeeded
EAP-TLV: TLV Result - Success - EAP-TLV/Phase2 Completed
enp0s20f0u7: CTRL-EVENT-EAP-SUCCESS EAP authentication completed successfully
enp0s20f0u7: CTRL-EVENT-CONNECTED - Connection to 99:43:33:23:1d:21 completed [id=0 id_str=]
```

And there! You're connected to your company network, authenticated
with your AD user name and password.
