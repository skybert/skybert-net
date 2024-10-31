title: Signal Desktop Freezes All the Time
date: 2024-10-21
category: linux
tags: linux, i3

```text
$ signal-desktop &
..

(signal-desktop:181107): libnotify-WARNING **: 08:44:20.567: Failed to
connect to proxy
[181107:1021/084445.667395:ERROR:libnotify_notification.cc(50)]
notify_notification_show: domain=1250 code=24 message="Error calling
StartServiceByName for org.freedesktop.Notifications: Timeout was
reached"
```

This was because I didn't have a notification daemon in my `i3` based
setup. Searching the bug track lead me to [this
issue](https://github.com/signalapp/Signal-Desktop/issues/4653) which
suggested either disabling notifications in the app, or installing a
notification daemon. Since I find _not_ having notification an awesome
feature of any desktop or phone, I went ahead and disabled the
notifications in the `File` → `Preferences...` dialogue.

<img
  class="centered"
  src="/graphics/2024/signal-desktop-notifications-settings.png"
  alt="The Signal Desktop preferences tab for notifications"
/>


An lo and behold, no more freezes.


