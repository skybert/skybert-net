title: Home Assistant on Arch Linux
date: 2024-01-22
category: linux
tags: linux

If you're running Arhc Linux, it's *really* easy to set up Home
Assistant. No need to bother with Docker containers, just install
_one_ package and you're all set.

## Install

```text
# pacman -S home-assistant
```

## Enable and start

```text
# systemctl enable home-assistant
# systemctl start home-assistant
```

## Enjoy!

Give Home Assistant a minute or two and head over to
http://localhost:8123/ and start configuring your smart home.


