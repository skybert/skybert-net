title: Copy files to Openshift Pods
date: 2021-01-12
category: linux
tags: linux, openshift, kubernetes, containers

```text
$ oc project myproject
$ oc get pods | grep running
engine-1-4bxfg                     1/1     Running     0          55m
```

Now that we know the pod name, we can copy files to it. 

```text
$ oc rsync /tmp/bar engine-1-4bxfg:/tmp/
```

Note that using `oc rsync`, we can only transfer directories. The
above will create a `bar` directory in the `/tmp` directory on the
`engine-1-4bxfg` pod.
