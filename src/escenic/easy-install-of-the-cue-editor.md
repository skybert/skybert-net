title: Easy install of the CUE editor
date: 2017-05-19
category: escenic
tags: escenic

The latest version of `ece-install`, 3.1.1, can install the CUE web editor and configure it, including installing and setting up a web server in front of it with correct CORS headers.

To install CUE using ece-install, you need to add our stable APT repo to `/etc/apt/sources.list.d/escenic`.list and add our repo key to your system's APT key ring. Then finally, install the scripts and installer packages:

```text
# echo deb http://user:pass@apt.escenic.com stable main non-free >> /etc/apt/sources.list.d/escenic.list
# curl --silent http://apt.escenic.com/repo.key | apt-key add -
# apt-get update
# apt-get install escenic-content-engine-scripts
# apt-get install escenic-content-engine-installer
```

Then, tell `ece-install` what to install. Here, we just want CUE (and a web server to serve it).

```text
# cat > ece-install.yaml <<EOF
credentials:
  - site: maven.escenic.com
    user: foo
    password: bar

profiles:
  cue:
    install: true

packages:
  - cue-web-2.2
EOF
```

Now, run `ece-install` to install CUE:

```text
# ece-install -f ece-install.yaml
```

That's it, CUE is now installed, so is nginx and it's configured with
CORS headers.

It makes a number of assumptions about your system, like that ECE is
running on standard ports on the same machine and that the hostname of
the machine is the same as the hostname through which users will
connect to it to use CUE. All of these settings are naturally
overrideable:

```yaml
profiles:
  cue:
    install: true
    backend_ece: http://ece6.example.com:81
    backend_ng: https://ng.example.com
    cors_origins:
      - editor.example.com
      - cue.example.com
      - edit.example.com
```

## ECE, DB, Solr & CUE on the same machine

For a low traffic system or a developer machine, you may want to
install ECE, DB, Solr, the search indexer and CUE all on one machine,
you can use the following to the YAML file:

```yaml
credentials:
  - site: maven.escenic.com
    user: foo
    password: bar

environment: 
  # 'true' means you've read & accepted:
  # http://www.oracle.com/technetwork/java/javase/terms/license/index.html
  java_oracle_licence_accepted: true

profiles:
  cue:
    install: true
  db:
    install: true
  editor:
    install: true
  search:
    install: true
    port: 9980
    shutdown: 9981
    redirect: 9982
    indexer_ws_uri: http://localhost:8080/indexer-webservice/index/

packages:
  - name: escenic-content-engine-6.1
  - name: cue-web-2.2
```  
