title: Scaling a pod in Openshift
date: 2025-03-17
category: linux
tags: linux, containers, openshift


Scaling a pod down an up again is the same as restarting a pod, it's
just that the container folks like to use fancy words:

The thing you scale down and up is a
[deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/),
which is one abstraction above a pod.

You can get a list of deployments with:
```text
$ oc get deployments
foo-ice-cream
```

```text
$ oc scale deployment/foo-ice-cream --replicas=0
```

Give it a second or two, and then scale it up again to get a fresh pod
with containers, fresh of any disk or in-memory state left behind that
wasn't mounted or injected:

```text
$ oc scale deployment/foo-ice-cream --replicas=1
```

Happy scaling!
