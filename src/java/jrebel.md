title: Setting up JRebel
date: 2016-02-09

## Download

I went over to https://zeroturnaround.com/software/jrebel/download/
and downloaded the JRebel standalone archive.

```
$ unzip jrebel-6.3.3.zip -d /opt
$ cd /opt
$ mv jrebel jrebel-6.3.3
$ ln -s jrebel-6.3.3 jrebel
```

## Activation
```
/opt/jrebel/bin/activate.sh ~/.jrebel/jrebel.irc
```

## Generate the JRebel XML file

Added this to my project root POM
```
<profiles>
  <profile>
    <id>jrebel</id>
    <plugin>
      <groupId>org.zeroturnaround</groupId>
      <artifactId>jrebel-maven-plugin</artifactId>
      <version>1.1.5</version>
      <executions>
        <execution>
          <id>generate-rebel-xml</id>
          <phase>process-resources</phase>
          <goals>
            <goal>generate</goal>
          </goals>
        </execution>
      </executions>
    </plugin>
  </profile>
</profiles
```

Then ran:
```
$  mvn -Pjrebel clean package
```

If you check the JARs and WARs created, they should contain a
`rebel.xml` (no 'j') which points to your source files for that
artifact.

## Configuring my app server to use JRebel

Added this to my JVM options:
```
-javaagent:/opt/jrebel/jrebel.jar
```

## Deploy your application as normal

## Try it out!

Restart your app server and wathc its log file where system out
messages are written. On Tomcat this would be
`tomcat/logs/catalina.out`. You should see lines like these:

```
2016-02-09 10:57:41 JRebel: Directory
'/home/torstein/src/p4/escenic/engine/branches/5.7-unstable-VF-6385/engine-syndication/target/classes'
will be monitored for changes.
2016-02-09 10:57:41 JRebel: Directory
'/home/torstein/src/p4/escenic/engine/branches/5.7-unstable-VF-6385/engine-api/target/classes'
will be monitored for changes.
```
