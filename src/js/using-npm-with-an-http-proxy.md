title: Using npm with an HTTP proxy
date: 2021-10-22
category: js
tags: js

```text
npm config set proxy http://proxy:8899
npm config set https-proxy http://proxy:8899
```

The `npm config set` and `get` commands are just a convenient way of
editing the configuration file, though. You can just as well set it in
plain text:

```text
$ cat ~/.npmrc
proxy=http://proxy:8899/
https-proxy=http://proxy:8899
```



