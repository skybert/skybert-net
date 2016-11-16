title: Setting Up APT Repo With Signed Packages
tags: debian
date:    2012-10-07
category: linux

    # mkdir -p /var/www/html/apt/conf

Add the following contentsto a new
file,```/var/www/apt/conf/distributions```:

    Origin: Your Name
    Label: The Name of Your Repository
    Suite: stable
    Codename: wheezy
    Architectures: i386 amd64 source
    Components: main non-free
    Description: A longer description of the repository
    SignWith: yes


Install packages for easily managing the repository:

    # apt-get install reprepro dpkg-sig


Create a GPG if you don't already have it:

    # gpg --create


To sign a package with your server key, do:

```
# dpkg-sig --sign builder -k <key> my-package-2.0-2.0.0-8.deb
```

Finally, add the package to your repository:

```
# reprepro \
  --ask-passphrase \
  --keepunreferencedfiles \
  -Vb /var/www/html/apt \
  -C non-free \
  includedeb \
  stable \
  my-package-2.0-2.0.0-8.deb
```

Be sure to lookup the options in `man reprepro` before you execute the
above command 😄

