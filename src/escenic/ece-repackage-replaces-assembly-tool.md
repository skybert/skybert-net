title: How to keep Escenic v6 websites updated
date: 2016-11-06
category: escenic
tags: escenic

This is how you'll keep an Escenic v6 website on a Debian/Ubuntu based Linux distribution updated.

First, upgrade all the packages on your system, this of course, now includes Escenic Content Engine 6, all plugins as well as the new multi backend user interface, CUE:

```
# apt-get update
# apt-get upgrade
```

Then, change into the escenic user and apply the newly installed or upgraded versions to your current ECE:

```text
$ ece -i engine1 repackage stop deploy start
``` 

This will replace all JARs and WARs in the EAR that was last used to deploy your website.

You have now upgraded your Escenic system. Easy right?
Deploying an EAR from your build server

If you want to deploy a fresh EAR from your build server, and replace the libraries and Escenic webapps (like webservice.war) with the versions installed with apt-get, simply add --uri to the above command (the order of the parameters doesn't matter).:

```text
$ ece -i engine1 \
  repackage \
  stop deploy \
  start \
  --uri http://build.server.com/my-website-3.0.3.ear
```

You've now upgraded your engine1 instance with the latest ECE6 and all its plugins with all the publication webapps from my-website-3.0.3.ear.
Tracking the linage of deployed EARs

The lineage of the repacked EAR can be seen in the deployment log (lines wrapped for improved readability):
```text
$ ece -i engine1 list-deployments
[ece#engine-engine1] These are all the publications on engine1:
Fri Nov 4 13:38:28 UTC 2016
  2016-11-04-1478266690-repackaged-my-site-3.0.4.ear-created-on-quanah.zip
  523f32273c1add9c0034762ddb2e4a01
Fri Nov 4 13:41:21 UTC 2016
2016-11-04-1478266861-repackaged-523f32273c1add9c0034762ddb2e4a01-created-on-quanah.zip
  43ce5090f2e9255090ae4918f4b1bc86
 ``` 
 
Here, you can see that `my-site-3.0.4.ear` was repacked and deployed
Fri Nov 4 13:38:28 UTC 2016 and the archive had the checksum
`523f32273c1add9c0034762ddb2e4a01`.

Then later, a previous deployment with checksum
`523f32273c1add9c0034762ddb2e4a01` was repacked (probably after an
apt-get upgrade was executed) and deployed. This time the archive got
the checksum `43ce5090f2e9255090ae4918f4b1bc86` after it was
repackaged.  What if you haven't installed all the needed Escenic
packages?

If the `my-site-3.0.4.ear` contains Escenic dependencies, like Live
Center, that for some reason haven't been installed on the machine
(yet), ece repackage will simply do nothing. It will only replace JARs
and WARs present on the machine.  What if I want to provide ECE
configuration in my own DEB files?

Since the `escenic-content-engine` DEB package provides configuration
in:

`/etc/escenic/engine/common`

your own configuration packages cannot provide any of the same files
as `apt-get` will not install a second package providing (some) of the
same files as an already installed package. Therefore, a conf package
must populate one of the other Nursery layers, e.g. the instance
layer:

`/etc/escenic/engine/instance/engine1`

This will make it possible for the escenic-content-engine and your my-site-conf-3.0.3 package to co-exist without messing about with DEB diversions and similar complexities.
Conclusion

Upgrading Escenic systems has now gotten both easier and have become
an integral part of the operating system. Querying the machine for its
installed packages will list Escenic software among the other
components like apache2, nginx and ssh.

As an added bonus, the operating system now understands that
configuration files from the package under `/etc/escenic` is
configuration files and will not overwrite this on upgrades, but will
instead offer the administrator a choice what to do, including showing
diff between the locally modified version and the new package's
version of the configuration file(s).

Happy upgrading!
