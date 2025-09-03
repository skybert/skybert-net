title: How to find an app's id on macOS
date: 2025-07-30
category: mac-os-x
tags: mac-os-x, macos

Sometimes, you need to know the app id, like configuring the window
manager to always put Slack on workspace number 6. To get the app id,
you can use `mdls` and just give it the path to the app directory:

```text
$ mdls -name kMDItemCFBundleIdentifier -r /Applications/Slack.app
com.tinyspeck.slackmacgap
```

