title: Full Screen Brightness on Linux
date: 2023-09-22
category: linux
tags: linux

On my laptop, a Thinkpad X1 Carbon with Intel chipset, I can set the
screen brightness to max with this simple command:

```text
$ cat /sys/class/backlight/intel_backlight/max_brightness | 
  sudo tee /sys/class/backlight/intel_backlight/brightness
```

Of course, you can set it to any value, as long as it doesn't exceed
the value in `max_brightness`:

```text
$ cat /sys/class/backlight/intel_backlight/max_brightness 
19393
$ echo 1800 | sudo tee /sys/class/backlight/intel_backlight/brightness
$
```

