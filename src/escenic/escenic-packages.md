title: Ways of using Escenic packages 📦
date: 2020-06-23
category: escenic
tags: escenic, linux, debian, redhat

## We provide 📦

- Maven packages (aka "artifacts")
- ZIP archives
- RPM packages
- DEB packages

## RedHat based systems 📦
#### CentOS, Fedora, ScientificOS++

```text
# rpm -Uvh https://rpm.escenic.com/path/to/escenic-content-engine-6.3.rpm
```
or

```text
# rpm -Uvh /path/to/local/escenic-content-engine-6.3.rpm
```

## Debian based systems 
#### Ubuntu, Kali, Tails, Mint++

- Use [apt.escenic.com](http://apt.escenic.com)
- Download + use `dpkg`
- Create apt.mycompany.com

## deb, dpkg & APT?

- `deb` is the package format
- `dpkg` is the tool to install `deb` _files_.
- APT adds dependency resolution, upgrade/downgrade-ablity, signing
  key management, repositories, search++

## Using apt.escenic.com 📦

```text
deb https://user:pass@apt.escenic.com stable main non-free
```

and:
```text
# curl --silent https://apt.escenic.com/repo.key | apt-key add -
# apt-get update 
# apt-cache search escenic
# apt-cache search cue
# apt-get install escenic-content-engine cue-web
```

## apt.mycompany.com 📦

Define code names corresponding to your server environment:

- `development` (developer PCs) 
- `testing` (test servers)
- `staging` (staging servers)
- `production` (production servers)

## Populate apt.mycompany.com

```
# apt-get install \
   --download-only \
   escenic-content-engine-6.3 \
   escenic-sse-proxy-1.0
# reprepro \
    --keepunreferencedfiles \
    -Vb /var/www/html/apt.mycompany.com \
    --component non-free \
    includedeb \
    development \
    /var/cache/apt/archives/escenic-content-engine-6.3_6.3.0-11_all.deb
```


## Use apt.mycompany.com 📦

On `pres1.staging.mycompany.com`, put in its
`/etc/apt/sources.list.d/escenic.list`

```text
deb https://user:pass@apt.mycompany.com staging main non-free
```
Can now install packages from it:
```text
# apt-get update
# apt-get install escenic-content-engine-6.3 cue-web-2.3
```

## Promote a package from staging to production

MyCompany QA has verified version `6.3.0-11` on staging and want
to roll this out in production:
```text
# reprepro \
    --keepunreferencedfiles \
    -Vb /var/www/html/apt.mycompany.com \
    --component non-free \
    includedeb \
    production \
    /var/cache/apt/archives/escenic-content-engine-6.3_6.3.0-11_all.deb
```

## Use apt.mycompany.com 📦🔒

Optionally, specify `code name` when installing packages:

```text
# apt-get install -t staging escenic-content-engine-6.3
```

## Use apt.mycompany.com 📦🔒

Optionally, pin package(s):

> No matter what's available, this machine should use version 1.2.3 of
> "foo-server"

## Further reading

- [3 ways of using the Escenic packages](http://blogs.escenic.com/rd/2017/3-ways-of-using-the-Escenic-packages)
- [man reprepro](https://mirrorer.alioth.debian.org/reprepro.1.html)
- [man dpkg](https://linux.die.net/man/1/dpkg)
- [man apt-get](https://linux.die.net/man/8/apt-get)
- [man apt-cache](https://linux.die.net/man/8/apt-cache)
- [APT Preferences](https://wiki.debian.org/AptPreferences) (pinning)
- [GPG sign and verify deb packages and APT - repositories](https://blog.packagecloud.io/eng/2014/10/28/howto-gpg-sign-verify-deb-packages-apt-repositories/)
- [HTTPS/TLS encryption on nginx](https://www.nginx.com/resources/admin-guide/nginx-ssl-termination/)
- [Basic HTTP authentication on nginx](https://www.digitalocean.com/community/tutorials/how-to-set-up-basic-http-authentication-with-nginx-on-ubuntu-14-04)
