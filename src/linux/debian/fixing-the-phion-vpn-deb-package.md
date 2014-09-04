date:    2012-10-07
category: linux
tags: debian
title: Fixing the Phion VPN DEB package

## Or, how to re-build a Debian package

The Phion VPN package has a version string which isn't
compatible with the latest APT system, you'll find that Debian
and derivatives like Ubuntu will complain about the version
string being illegal and will refuse to install the
package:


    dpkg: error processing /tmp/v/phionVPN-R8-SP2.deb (--install):
    parsing file '/var/lib/dpkg/tmp.ci/control' near line 2 package 'phionvpn':
    error in Version string 'R8-SP2': version number does not start with digit


Here is how you can fix this so that the package will install
on your your system.


    $ mkdir -p /tmp/vpn/debian
    $ dpkg -x phionVPN-R8-SP2.deb /tmp/vpn/debian
    $ mkdir -p /tmp/vpn/debian/DEBIAN
    $ dpkg -e phionVPN-R8-SP2.deb /tmp/vpn/debian/DEBIAN


Now, let's change the version string:


    $ vi /tmp/vpn/debian/DEBIAN/control


Change from:

    Version: R8-SP2

to:

    Version: 8-SP2


Now, let's re-build the package:

    $ cd /tmp/vpn
    $ dpkg-deb --build debian
    $ mv debian.deb phionvpn_8-SP2.deb


That's it, you can now install the package successfully:

    # dpkg -i /tmp/vpn/phionvpn_8-SP2.deb

