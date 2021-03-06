title: Installing Debian on Thinkpad X1 Carbon
date: 2015-05-05
category: linux
tags: debian, linux, alsa

Debian stable (as of 2015-05) installed practically without a
hitch. Most things "just worked" after installing the necessary
packages from the official Debian repositories, including wireless and
suspend to RAM. However, as always there were a few things I had to
tweak to get everything the way I wanted to. On this page, I've
documented most of these wee changes. Enjoy!

## VirtualBox
Problem that VirtualBox just hangs forever at 0% when starting a
virtual machine (and then 20% and another "forever hang").

This seemd to be
[caused by this bug](https://www.virtualbox.org/ticket/13820) which
was
[fixed in version 4.3.22 of VirtualBox](https://www.virtualbox.org/ticket/13820#comment:16)
So I added [Debian testing](https://wiki.debian.org/DebianTesting) to
my `/etc/apt/sources.list` and upgraded my VirtualBox from there
(using [pinning](../preferring-stable-debian-packages) so that I
didn't pull more packages from the testing pool than necessary).

After upgrading VirtualBox, the problem went away. The performance of
my virtual machines is impeccable after turning on the vitalisation
extensions.

## Sound 🔉

I prefer using pure
[ALSA](http://www.alsa-project.org/main/index.php/Main_Page) instead
of of
[PulseAudio](http://www.freedesktop.org/wiki/Software/PulseAudio/) as
it has messed up and obfuscated the audio setup on all machines I've
ever had.

Since ALSA registered two sound devices on the X1 Carbon and it's the
second card I want to use, I added the following to my `~/.asoundrc`
to make everything use this card by default:

```
$ cat ~/.asoundrc
pcm.!default {
  type hw
  card PCH
}

ctl.!default {
  type hw
  card PCH
}
```

I got the "PCM" name from looking at `/proc/asound/cards`:
```
$ cat /proc/asound/cards
 0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xf1130000 irq 64
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf1134000 irq 61
29 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
                      ThinkPad Console Audio Control at EC reg 0x30, fw unknown
```

I prefer using [MPD](http://www.musicpd.org/) for playing music on my
work machine. It's the least obtrusive music player that I know of,
while yet offering many different clients, CLI, web and graphical. I
had to add this to `/etc/mpd.conf` to get
[MPD](http://www.musicpd.org/) to play music through my prefferred
sound card:

```
audio_output {
        type                    "alsa"
        name                    "Sound Card"
        device                  "hw:1"
}
```

## Trackpad buttons

The two (mouse) buttons on the trackpad didn't work as left and right
mouse button respectively, but as scroll up and scroll down
(!). [This bug](https://bugs.freedesktop.org/show_bug.cgi?id=88609)
was midly annoying, but I got by by pressing the touchpad itself for a
(left) mouse click.

However, having the mouse button under the space bar is *so* much more
convenient, so this is something that had to be remedied. The
[bug has been fixed in Linux 4.0](https://bugs.freedesktop.org/show_bug.cgi?id=88609),
so I'll just have to wait till it arrives in Debian testing or unstable
(my days of compiling the kernel myself are over 😃)

```
psmouse serio2: alps: Unknown ALPS touchpad: E7=10 00 64, EC=10 00 64
psmouse serio2: trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3
```

## Extra Thinkpad options

I added the `thinkpad_acpi` to the setup. Currently (2015-05-05), it
has to be forced in:
```
$ grep -v '^#' /etc/modules
thinkpad_acpi
$ cat /etc/modprobe.d/thinkpad_acpi.conf
options thinkpad_acpi force_load=1
```

I now got some Thinkpad goodness in the kernel log:

```
thinkpad_acpi: ThinkPad ACPI Extras v0.25
thinkpad_acpi: http://ibm-acpi.sf.net/
thinkpad_acpi: ThinkPad BIOS N14ET25W (1.03 ), EC unknown
thinkpad_acpi: Unsupported brightness interface, please contact ibm-acpi-devel@lists.sourceforge.net
thinkpad_acpi: radio switch found; radios are enabled
thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
thinkpad_acpi: rfkill switch tpacpi_wwan_sw: radio is unblocked
thinkpad_acpi: Console audio control enabled, mode: monitor (read only)
```

## Flawless suspend and resume 💤

The suspend and resume on this laptop is the best I've ever had. For
more than two weeks now, I've suspended and resumed at least once a
day with tons of applications running. Never *any* problem. And this
is using Debian stable. Linux wise, this is totally amazing! 😃

## Adjust brighness from the command line

Get the current value:
```bash
$ cat /sys/class/backlight/intel_backlight/brightness
```

Dim it, but leave it useable:
```text
# echo 200 > /sys/class/backlight/intel_backlight/brightness
```
