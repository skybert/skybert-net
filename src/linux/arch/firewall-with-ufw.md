title: Set up a firewall in 2 minutes on Arch Linux
date: 2022-11-15
category: linux
tags: arch, security

Install the `ufw` `iptables-nft` wrapper with:

```text
# pacman -Sy ufw
```

Enable and start it with:
```text
# systemctl enable ufw
# systemctl start ufw
```

Configure it. By default, block all incoming connections and allow all
outgoing. This is what you typically want:

```text
# ufw default allow outgoing
# ufw default deny incoming
# ufw reload
```

Done!
