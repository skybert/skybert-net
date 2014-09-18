title: Setting Up Apt Repo With Signed Packages
tags: debian
date:    2012-10-07
category: linux

    # mkdir -p /var/www/apt/conf

Add the following contentsto a new
file,```/var/www/apt/conf/distributions```:

    Origin: Your Name
    Label: The Name of Your Repository
    Suite: stable
    Codename: wheezy
    Architectures: i386 amd64 source
    Components: main
    Description: A longer description of the repository
    SignWith: yes


Install packages for easily managing the repository:

    # apt-get install reprepro dpkg-sig


Create a GPG if you don't already have it:

    # gpg --create

