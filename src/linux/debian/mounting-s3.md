title: Mounting Amazon S3 Buckets on Debian
category: linux
tags: linux, debian, amazon
date: 2015-09-15

## Install build dependencies

```
# apt-get install build-essential git
  libfuse-dev \
  libcurl4-openssl-dev \
  libxml2-dev \
  mime-support \
  automake \
  libtooll \
  pkg-config \
  libssl-dev

```

## Build the S3 FUSE plugin

```
$ cd /tmp
$ git clone https://github.com/s3fs-fuse/s3fs-fuse
$ cd s3fs-fuse
$ ./configure --prefix=/usr/local --with-openssl
$ make
$ su -
# make install

```

## Add Amazon S3 credentials to /etc

Add your user/pass on the form <user>:<pass> in a file like:

```
# vim /etc/amazon-s3-passwd
```

Be sure to make it only readable and writeable by root:

```
# chmod 600 /etc/amazon-s3-passwd
```

## Mount your S3 bucket

You should now be able to mount an S3 bucket like this:

```
# /usr/local/bin/s3fs my-s3-bucket-name \
  /tmp/my-s3-bucket \
  -o passwd_file=/etc/amazon-s3-passwd
```


