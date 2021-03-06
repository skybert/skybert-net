date:    2013-01-06
category: escenic
title: Deploying and rolling back using ece-deploy

<iframe src="http://www.screenr.com/embed/zwp7"
width="650"
height="396"
frameborder="0">
</iframe>

The```ece-deploy``` command makes it easy to deploy a new EAR and,
optionally, a DEB or RPM configuration package (in which case you'd
also pass a```--conf``` parameter):

```
$ ece-deploy \
    --ear http://my.builder.com/snow/releases/snow-trunk-rev5233-2012-10-04_1608.ear \
    --update-publication-resources
[ece-deploy-0] Started @ Fri Dec 21 21:41:47 CST 2012
[ece-deploy-0] This deployment has ID pres1-1356097307 and is logging
[ece-deploy-0] to /var/log/escenic/ece-deploy.log
[ece-deploy-0] Remembering the deployment states for all instances ...
[ece#engine-engine1] Stopping the engine1 instance of engine on pres1 ...
[ece#engine-engine1] Deploying
[ece#engine-engine1] http://my.builder.com/snow/releases/snow-trunk-rev5233-2012-10-04_1608.ear
[ece#engine-engine1] on engine1 ...
[ece#engine-engine1] Deploying
[ece#engine-engine1] /var/cache/escenic/snow-trunk-rev5233-2012-10-04_1608.ear
[ece#engine-engine1] on tomcat ...
[ece#engine-engine1] Deployment white list active, only deploying:
[ece#engine-engine1] escenic-admin ski wool
[ece#engine-engine1] Deployment state file updated:
[ece#engine-engine1] /var/lib/escenic/engine1.state
[ece#engine-engine1] Deployment log file updated:
[ece#engine-engine1] /var/lib/escenic/engine1-deployment.log
[ece#engine-engine1] Cleaning up generated files in /opt/escenic/assemblytool
[ece#engine-engine1] ...
[ece#engine-engine1] Cleaning up engine1's work directory in
[ece#engine-engine1] /opt/tomcat-engine1/work ...
[ece#engine-engine1] Cleaning up engine1's temp directory in
[ece#engine-engine1] /opt/tomcat-engine1/temp ...
[ece#engine-engine1] Starting the engine1 instance of engine on pres1 ...
[ece-deploy-22] Will now update the publication resources, first getting a
[ece-deploy-22] list of all publications on engine1 ...
[ece-deploy-47] engine1@pres1 has the following publications: ski snow
[ece-deploy-47] Updating resources for publication ski ...
[ece-deploy-52] Applying 21 changes to
[ece-deploy-52] /opt/tomcat-engine1/webapps-ski/ski/META-INF/escenic/publication-resources/escenic/content-type
[ece-deploy-52] Applying 6 changes to
[ece-deploy-52] /opt/tomcat-engine1/webapps-ski/ski/META-INF/escenic/publication-resources/escenic/layout-group
[ece-deploy-57] Updating resources for publication snow ...
[ece-deploy-62] Applying 12 changes to
[ece-deploy-62] /opt/tomcat-engine1/webapps-wool/wool/META-INF/escenic/publication-resources/escenic/content-type
[ece#engine-engine1] Stopping the engine1 instance of engine on pres1 ...
[ece#engine-engine1] Starting the engine1 instance of engine on pres1 ...
[ece-deploy-71] Remembering the deployment states for all instances ...
[ece-deploy-72] Here are the diffs of all publication resources and files
[ece-deploy-72] that were changed:
/var/lib/escenic/ece-deploy/pres1-1356097307/new/snow/escenic/content-type.diff 12 changes
/var/lib/escenic/ece-deploy/pres1-1356097307/new/snow/escenic/layout-group.diff 6 changes
/var/lib/escenic/ece-deploy/pres1-1356097307/new/engine1.state.diff 8 changes
/var/lib/escenic/ece-deploy/pres1-1356097307/new/ski/escenic/content-type.diff 21 changes
[ece-deploy-73] Finished @ Fri Dec 21 21:43:00 CST 2012
```

Rolling back to a previous deployment is also easy. Note that it's
optional to also roll back the publication resources, hence you need
to specify the `--update-publication-resources` the switch if you also
want to roll back the publication resources:

```
$ ece-deploy --rollback pres1-1356015120 --update-publication-resources
[ece-deploy-0] Started @ Fri Dec 21 21:39:48 CST 2012
[ece-deploy-0] This deployment has ID pres1-1356097188 and is logging
[ece-deploy-0] to /var/log/escenic/ece-deploy.log
[ece-deploy-0] Remembering the deployment states for all instances ...
[ece-deploy-0] Rolling back to pres1-1356015120 from Thu Dec 20 22:52:00
[ece-deploy-0] CST 2012 ...
[ece-deploy-1] Using data in
[ece-deploy-1] /var/lib/escenic/ece-deploy/pres1-1356015120/new to
[ece-deploy-1] perform the rollback
[ece-deploy-1] WARNING Coulski't find the previous version
[ece-deploy-1] for vosa-conf-pres1 you must get a hold of the
[ece-deploy-1] latest/approriate one yourself.
[ece-deploy-1] Rolling back engine1's EAR to
[ece-deploy-1] http://builder.vizrtsaas.com/snow/releases/snow-trunk-rev5893-2012-11-14_1127.ear
[ece-deploy-1] ...
[ece#engine-engine1] Stopping the engine1 instance of engine on pres1 ...
[ece#engine-engine1] Deploying
[ece#engine-engine1] http://builder.vizrtsaas.com/snow/releases/snow-trunk-rev5893-2012-11-14_1127.ear
[ece#engine-engine1] on engine1 ...
[ece#engine-engine1] Deploying
[ece#engine-engine1] /var/cache/escenic/snow-trunk-rev5893-2012-11-14_1127.ear
[ece#engine-engine1] on tomcat ...
[ece#engine-engine1] Deployment white list active, only deploying:
[ece#engine-engine1] escenic-admin ski wool
[ece#engine-engine1] Deployment state file updated:
[ece#engine-engine1] /var/lib/escenic/engine1.state
[ece#engine-engine1] Deployment log file updated:
[ece#engine-engine1] /var/lib/escenic/engine1-deployment.log
[ece#engine-engine1] Cleaning up generated files in /opt/escenic/assemblytool
[ece#engine-engine1] ...
[ece#engine-engine1] Cleaning up engine1's work directory in
[ece#engine-engine1] /opt/tomcat-engine1/work ...
[ece#engine-engine1] Cleaning up engine1's temp directory in
[ece#engine-engine1] /opt/tomcat-engine1/temp ...
[ece#engine-engine1] Starting the engine1 instance of engine on pres1 ...
[ece-deploy-22] Will now update the publication resources, first getting a
[ece-deploy-22] list of all publications on engine1 ...
[ece-deploy-46] engine1@pres1 has the following publications: ski snow
[ece-deploy-46] Updating resources for publication ski ...
[ece-deploy-52] Applying 21 changes to
[ece-deploy-52] /var/lib/escenic/ece-deploy/pres1-1356015120/new/ski/escenic/content-type
[ece-deploy-52] Applying 4 changes to
[ece-deploy-52] /var/lib/escenic/ece-deploy/pres1-1356015120/new/ski/escenic/image-version
[ece-deploy-56] Updating resources for publication snow ...
[ece-deploy-62] Applying 12 changes to
[ece-deploy-62] /var/lib/escenic/ece-deploy/pres1-1356015120/new/snow/escenic/content-type
[ece-deploy-66] Remembering the deployment states for all instances ...
[ece-deploy-66] You have now rolled back to deployment pres1-1356015120
[ece-deploy-66] Here are the diffs of all publication resources and files
[ece-deploy-66] that were changed:
/var/lib/escenic/ece-deploy/pres1-1356097188/new/snow/escenic/content-type.diff 12 changes
/var/lib/escenic/ece-deploy/pres1-1356097188/new/snow/escenic/image-version.diff 4 changes
/var/lib/escenic/ece-deploy/pres1-1356097188/new/engine1.state.diff 2 changes
/var/lib/escenic/ece-deploy/pres1-1356097188/new/ski/escenic/content-type.diff 21 changes
[ece-deploy-67] Finished @ Fri Dec 21 21:40:55 CST 2012
```

There you go, deployment and rollback has never been easier. And this
works regardless of this being a development VMware image, test,
staging or production server. To get the ```ece-deploy``` command, you
can either <a href="http://github.com/escenic/ece-scripts">head over to
the ece-scripts module on Github</a> or you can install the
```escenic-content-engine-scripts``` package using the APT repository
at <a href="http://apt.escenic.com">apt.vizrt.com</a>

