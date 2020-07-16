title: OpenShift container running out of PIDs all the time
date: 2020-07-15
category: linux
tags: linux, openshift, docker, kubernetes

My java application that I deployed on Openshift spectacularly. After
humming along happily for a good while, it got completely stuck,
botching the standard out stream in the process, leaving me in the
blind without even a log to tell me why Maven was hanging.

It turned out the reason why my JVM eventually fails to create new
threads. Openshift has created a cgroup with a maximum number of PIDs
to be 1024. Each native thread needs its own PID and will therefore
bail out when it reaches this number:

```
$ oc exec -ti dc/my-app bash
1001480000@my-app-n8shg-8lggr:/$ cat /sys/fs/cgroup/pids/pids.max
1024
```

Watching the JUnit tests as `/sys/fs/cgroup/pids/pids.current`
approaches 1024 beats anything Netflix has on offer.

The before mentioned cgroup is created with a Kubernetes feature
called `SupportPodPidsLimit`, it's off by default in Kubernetes and on
by default in OpenShift.

The reason why so many threads were created was because of
`java.net.http.HttpClient` couldn't close them fast enough to not hit
the `1024` boundary set by OpenShift (cri-o). In my case, the fix was
to re-use the clients, my-app now has one dedicated client for
non-authorized requests and one HTTP client per user/pass
combination. With these changes, my-app never exceeds 61 native
threads on OpenShift.

## Further reading

- [www.elastic.co/blog/we-are-out-of-memory-systemd-process-limits](https://www.elastic.co/blog/we-are-out-of-memory-systemd-process-limits)
- [www.kernel.org/doc/Documentation/cgroup-v1/pids.txt](https://www.kernel.org/doc/Documentation/cgroup-v1/pids.txt)
- [kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)
- [docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-enabling-features.html](https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-enabling-features.html)
- [github.com/containers/libpod/pull/4032](https://github.com/containers/libpod/pull/4032)
- [bugzilla.redhat.com/show_bug.cgi?id=1660876](https://bugzilla.redhat.com/show_bug.cgi?id=1660876)
