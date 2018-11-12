title: Installing Debian on Thinkpad X1 Carbon 5th Gen
date: 2018-06-01
category: linux
tags: debian, linux

Debian stable (code name "stretch") installed without any problems,
but a few tweaks were in order.

## Wireless
Since non free firmware isn't included in Debian, I had to manually
download and copy over `firmware-iwlwifi` to the machine using a USB
stick.

Once that was installed, the `4.9.0-6` kernel recognised my wireless
network card and I got it up and running with WPA EAP without any
problems.

## Adjusting screen brightness

I prefer using a command line tool like `xbacklight` for
this. However, it failed with the message:

```text
No outputs have backlight property
```

To remedy this, I added the following to `/etc/X11/xorg.conf` to make
it locate `/sys/class/backlight/intel_backlight`:

```text
Section "Device"
    Identifier  "Card0"
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
EndSection
```

After restarting my login manager, `xbacklight` worked as it should.

## i3
I added these lines to `~/.config/i3/config` to make the multimedia
keys work:

```text
bindsym XF86MonBrightnessDown exec xbacklight -inc -10
bindsym XF86MonBrightnessUp exec xbacklight -inc 10
```

## Network port on the Thunderbolt 3 dock

```text
# echo r8152 >> /etc/modules
```

## Updating BIOS

Download BIOS update ISO from
[lenovo.com](https://pcsupport.lenovo.com/no/en/products/laptops-and-netbooks/thinkpad-x-series-laptops/thinkpad-x1-carbon-type-20hr-20hq/downloads?linkTrack=Caps:Body_SearchProduct&searchType=3&keyWordSearch=X1%20Carbon%205th%20Gen%20-%20Kabylake%20(Type%2020HR,%2020HQ)%20Laptop%20(ThinkPad)),
it was called `n1mur19w.iso` when I download it.

Convert it to a proper ISO:
```text
# geteltorito -o lenovo-bios-update.iso n1mur19w.iso
```

Write it to the USB drive. Be sure to pick the correct device path for
your USB stick, in my case, this was `/dev/sda`:
```text
# dd if=lenovo-bios-update.iso of=/dev/sda bs=1M
```

