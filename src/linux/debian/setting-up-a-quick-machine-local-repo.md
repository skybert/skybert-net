title: Setting up a Quick Machine Local Repo
date: 2017-12-05
category: linux
tags: linux, debian

```text
# apt-get install dpkg-dev
# mkdir /opt/apt
# cp /tmp/*.deb /opt/apt
# cd /opt/apt
# dpkg-scanpackages . | gzip -c9 > Packages.gz
```

You can now use it by adding this to your `/etc/apt/sources.list`:

```text
deb file:/tmp/apt ./
```


