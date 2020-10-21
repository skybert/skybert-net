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
$ mvn sonar:sonar -sonar.host.url=172.17.0.2:9000
```

## Browse the Sonarqube results

Open your web browser http://172.17.0.2:9000


## Closing words

The promise of doing all of this in `5` minutes depends on the speed
on your network connection, your computer and last but not least: the
size of your Java project 😄

Happy security scanning!
