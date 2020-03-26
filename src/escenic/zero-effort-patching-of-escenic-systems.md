title: Zero effort patching of Escenic6 systems
date: 2017-05-05
category: escenic
tags: escenic, debian

<iframe width="560" height="315"
src="https://www.youtube.com/embed/ZWma879eYdc" frameborder="0"
allow="accelerometer; autoplay; encrypted-media; gyroscope;
picture-in-picture" allowfullscreen></iframe>

Thanks to the new `escenic-content-engine-updater` package, keeping
Escenic systems up to date has never been easier.

```
# apt-get install escenic-content-engine-6.1
# apt-get install escenic-content-engine-updater-6.1
```

The updater package will take the currently deployed EAR file (it uses
the entries in `ece -i <instance>` list-deployments and the
corresponding file in `/var/cache/escenic` to find this) and
re-packages that EAR file with whatever ECE and/or ECE plugin packages
that you have installed on your system. It'll then deploy this newly
package EAR file on all ECE and search instances on your machine.

When you later upgrade the `escenic-content-engine-6.1` package or
install a new ECE plugin, the updater will automatically run and
repackage the currently deployed EAR file with the Escenic software:

```text
# apt-get install escenic-video
[..]
Processing triggers for escenic-content-engine-updater-6.1 (6.1.0-6) ...
Repackaging last deployed EAR with the latest ECE versions ...
Deploying 2017-05-05-1493974934-repackaged-fda99db4288c069f05fcdb02c6-created-on-debbie.zip on engine1 ... 
Setting up escenic-video (4.20-3) ...
```

As you can see in the `/escenic-admin` webapp or with the ece versions
command, the escenic-video plugin has been deployed on the machine's
ECE instance(s):

```
$ ece versions
[ece#engine-engine1] Installed on the engine1 instance running on port 8080:
   *  content-engine 6.1.0-6
   *  video 4.2.0-3
$
```

You can see this updater package in action in this screencast (as well
as the ece-install installation program. The updater package can be
used regardless of ece-install):

## Caveats
The currently deployed EAR file must be available

In case you have cron jobs wiping out `/var/cache/escenic` these must
be tweaked to not delete the currently deployed EAR file. This archive
can be identified through the ece list-deployments:

```text
$ ece -i engine1 list-deployments 
[ece#engine-engine1] These are all the deployments on engine1:
Wed 3 May 09:33:14 CEST 2017 minimal-1493796772.ear fda99db4285cffd78c069f05fcdb02c6
Fri 5 May 11:00:07 CEST 2017 2017-05-05-1493974773-repackaged-fda99db4285cffd78c069f05fcdb02c6-created-on-debbie.zip f71390b3b1707744e9b9de97d35d894c
Fri 5 May 11:02:47 CEST 2017 2017-05-05-1493974934-repackaged-fda99db4285cffd78c069f05fcdb02c6-created-on-debbie.zip 6ba3408e1426383ea4f601aafbdb1843
```

For safety reasons, the updater doesn't run DB scripts

The updater package will update the Java libraries and configuration
files of ECE & plugins. However, it will not run any database
scripts. This is a conscious decision by us at Escenic as this could
lead to surprising results or indeed broken components in multi
machine setups.
