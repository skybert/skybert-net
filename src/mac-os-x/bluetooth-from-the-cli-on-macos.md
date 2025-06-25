title: Bluetooth from the CLI on macOS
date: 2025-06-25
category: mac-os-x
tags: mac-os-x

# Turn on and off Bluetooth

```text
$ blueutil --power 0 # off
$ blueutil --power 1 # on
```

## List connected Bluetooth devices

To list your connected Bluetooth devices, do:

```text
$ blueutil --connected
address: 50-c2-75-77-8c-d4, connected (master, -31 dBm), not favourite, paired, name: "skybert-Jabra Evolve2 65", recent access date: 2025-06-25 06:22:04 +0000
address: dd-d2-83-e2-74-02, connected (master, 0 dBm), not favourite, paired, name: "skybert-MX Master 3S B", recent access date: 2025-06-25 06:22:04 +0000
```

## Connect to a previously paired device

```text
$ blueutil --connect 50-c2-75-77-8c-d4
```

