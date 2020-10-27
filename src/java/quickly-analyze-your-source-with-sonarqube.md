title: Analyse Your Source with Sonarqube in 5 minutes
date: 2020-10-21
category: java
tags: java, maven, security

For quickly setting up Sonarqube and run a scan on your Java code, do
the following.

## Start the Sonarqube server Docker container

```
$ docker run -ti sonarqube:lts
```

## Get a hold of the IP of the Sonarqube container

```
$ docker ps -q |
  xargs docker inspect --format='{{range $n, $c := .NetworkSettings.Networks}}{{$c.IPAddress}}{{end}}'
172.17.0.2
```

## Run the Sonarqube scan on your source code

Run the Sonarqube scan and post the results to the process in the
Docker container.

```text
$ mvn sonar:sonar -Dsonar.host.url=http://172.17.0.2:9000
```

## Browse the Sonarqube results

Point your web browser at [http://172.17.0.2:9000](http://172.17.0.2:9000)

## Persistent storage

If you want a Docker cluster with Sonarqube and Postgres, download
[this docker-compose from the Sonarqube Docker
repository(https://github.com/SonarSource/docker-sonarqube/tree/master/example-compose-files/sq-with-postgres),
and run:

```text
$ sudo sysctl -w vm.max_map_count=262144
$ docker-compose up
```

To make the kernel setting permanent:
```conf
# cat >> /etc/sysctl.d/local.conf <<EOF

# Needed by Sonarqube/Elastic search
vm.max_map_count=262144 
EOF
```


## Closing words

The promise of doing all of this in `5` minutes depends on the speed
on your network connection, your computer and last but not least: the
size of your Java project 😄

Happy security scanning!
