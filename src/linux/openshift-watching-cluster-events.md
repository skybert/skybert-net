title: Watching Openshift cluster events
date: 2025-03-19
category: linux
tags: linux

When my Openshift cluster is bootstrapping, I prefer watching the
progress with:

```text
$ watch "oc get events --sort-by '{.metadata.creationTimestamp}' | tail -n 20"
```

The [animated topology
GUI](https://docs.redhat.com/en/documentation/openshift_container_platform/4.8/html/building_applications/odc-viewing-application-composition-using-topology-view#creating-a-visual-connection-between-components)
is nice, but the above command gives me more details as to exactly
what it is doing with what component.
