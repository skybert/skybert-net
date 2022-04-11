title: iwd on Garuda Linux
date: 2022-03-03
category: linux
tags: arch, garuda, linux, network

Getting `iwd` up and running was a bit tricky. It basically broke both
`sudo` and `systemctl` (!). The reason was that it has some dependency
on systemd's `resolved`, but since it wasn't enabled, it kept
hanging. Massively frustratingly. On the positive side, it let me
explore Garuda's smooth BTRFS snapshot integration from the GRUB
menu. Using that, I selected a snapshot from before I installed `iwd`.

Anyways, to solve this, I did:
```text
# pacman -Syu iwd
# systemctl enable --now iwd.service
# systemctl enable --now systemd-netword.service
# systemctl enable --now systemd-resolved.service
```

And then, I had to enable on-the-fly configuration of `iwd`. Odd
default if you ask me, on Debian, it "just worked" without any of
this:

```text
# vim /etc/iwd/main.conf
```

```conf
[General]
EnableNetworkConfiguration=true
```

After a restart, `iwd` worked flawlessly:
```text
# systectl restart iwd.service
```

On my work machines, I chose to disable Network Manager since I don't like it:
```text
# systemctl stop NetworkManager
# systemctl disable NetworkManager
```

With my private machine, I travel more, so keeping Network Manager in
the mix makes more sense. I thus set it to use `iwd` instead of
`wpa_supplicant`:

```text
# vim /etc/NetworkManager/NetworkManager.conf
```

And add:
```conf
[device]
wifi.backend=iwd
```

Then:

```text
# systemctl stop NetworkManager
# systemctl disable --now wpa_supplicant
# systemctl restart NetworkManager
```
