title: Fixing Java PKIX path building failed errors
date: 2021-04-14
category: java
tags: java, https, tls, sonarqube, security

We use Maven to perform Sonarqube scanning on our project:
```bash
$ mvn sonar:sonar \
    -Dsonar.host.url=https://sonarqube.example.com \
    -Dsonar.login=71b7130c8 \
    -Dsonar.projectKey=FOO_bar \
    -Dsonar.branch.name=release/6.0
```

However, for projects using an old JDK `1.8.0_60`, this failed with:
```
[ERROR] SonarQube server [https://sonarqube.example.com] can not be reached
[ERROR] Failed to execute goal
  org.sonarsource.scanner.maven:sonar-maven-plugin:3.8.0.2131:sonar
  (default-cli) on project core: Unable to execute SonarScanner
  analysis: Fail to get bootstrap index from server:
  sun.security.validator.ValidatorException: PKIX path building failed:
  sun.security.provider.certpath.SunCertPathBuilderException: unable to
  find valid certification path to requested target -> [Help 1]
```

Adding this parameter was helpful in seeing what was going inside the
JDK:
```bash
-Djavax.net.debug="ssl,handshake"
```

The reason was that the `cacerts` SSL/TLS certificate store in the JDK
was out of date. It didn't have the certificates needed to establish
the chain of trust used when generating the TLS certificate on
`sonarqube.example.com`.

To remedy this, I used the `cacerts` provided with `apt-get` installed
`openjdk-11-jdk-headless` package:

```text
# cd /usr/lib/jvm/java-1.8.0_60-oracle/jre/lib/security
# mv cacerts cacerts.orig
# ln -s /etc/ssl/certs/java/cacerts 
```

That's it. Java, and by that, the Maven and the Sonarqube scanner, can
now connect to websites served over `https`.

