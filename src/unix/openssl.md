title: Using the openssl command
date: 2018-08-07
category: unix
tags: unix, ssl, security

## When you want to request a new certificate

Create a certificate request file with: 
```text
$ openssl req -new -sha1 -newkey rsa:2048 -nodes -keyout tkj.key -out tkj.csr
```

## Create a PFX file

Create a PFX file which includes both your certificate and your
private key:

```text
$ openssl pkcs12 -export -in tkj.cer -inkey tkj.key -out tkj.pfx
```

