title: Maven
date: 2014-10-01

## Passing JVM parameters to Maven from the command line
Use the ```-D``` switch and clunk the JVM parameters onto that one,
like so:

    $ mvn clean install -DXmx1024m -DXX:MaxPermSize=256m

## Always pass the same JVM parameters to Maven
Define MAVEN_OPTS in your ```.bashrc```:

    export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=256m"


