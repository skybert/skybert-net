title: Resolving corrupt AUR packages installed with paru
date: 2024-12-18
category: linux
tags: arch, linux

```text
$ paru -Syu
..
error: failed to download sources for 'amazon-ssm-agent-bin-3.3.1345.0-1':
..
```

The reason was a corrupt download from a previous run, so I removed
the local cache entry for that package:

```text
$ rm -rf  ~/.cache/paru/clone/amazon-ssm-agent-bin
```

Now, it installed without any problems:
```text
$ paru
..
==> Finished making: amazon-ssm-agent-bin 3.3.1345.0-1 (Wed 18 Dec 2024 11:00:54 CET)
==> Cleaning up...
loading packages...
resolving dependencies...
looking for conflicting packages...

Packages (1) amazon-ssm-agent-bin-3.3.1345.0-1

Total Installed Size:  121.81 MiB
Net Upgrade Size:        8.03 MiB
..
(1/1) upgrading amazon-ssm-agent-bin   [############################################] 100%
..
$
```
