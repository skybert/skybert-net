title: Good OpenShift DX
date: 2020-07-20
category: linux
tags: linux, openshift, kubernetes, bash, containers

RedHat has been hard at work to give developers a good experience
(`DX` = *D*eveloper e*X*perience), here I share some gems I've found.


## Execute commands in a pod and pipe output to local commands

If you want to run a command on a container in an OpenShift cluster,
but want to do so from the comfort of your local command line, piping
it to locally installed tools and editors, you can use `exec` just
like in Docker. In this example, the `xmmlint` and `less` commands
exist only on my local machine:

```text
$ oc exec -ti dc/orange -- curl -u user:foo http://engine:8080/webservice/index.xml | 
  xmllint --format - | 
  less
```

Don't know if this was bleeding obvious to everyone and you've done
this for ages, but I for one, have up until now always started a shell
inside the container (passing `bash` as the command) and that's not
always the best user experience since the containers are very limited
in terms of what commands are available.

