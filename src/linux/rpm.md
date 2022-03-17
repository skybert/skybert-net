date: 2012-10-07
category: linux
title: My RPM Notes
tags: linux, redhat

## Listing installed packages

```
$ rpm -qa
```    

## Listing only the package names

```bash
$ rpm -qa --qf "%{NAME}\n"
```

As you've probably already guessed, it's possible to modify the format
of the package listing to whatever you want by putting other
expressions in `--qf`. e.g. to get package names and package versions
separated by a space, you'd do:

```
$ rpm -qa --qf "%{NAME} %{VERSION}\n"
```

## Listing all files of an installed package
```
$ rpm -ql <package>
```

## Viewing package information
```
$ rpm -qi <package name without version and arch>
```

Or you can ask YUM:

```
$ yum info <package>
```

## Listing all dependencies of a package
```text
$ rpm -qpR <file.rpm>
```

Or using `yum`
```text
$ yum deplist <package>
```

## Installing a package

```text
# rpm -Uvh package-name-arch-version.rpm
```

## Which package provides a file

```
$ rpm -qf <file>
```

You can also query `yum`:
```
$ yum whatprovides <file>
```

## List the licences of all packages installed

```bash
$ rpm -qa --qf "%{name}: %{license}\n"
```


