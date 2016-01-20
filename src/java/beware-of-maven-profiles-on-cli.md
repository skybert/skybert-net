title: Beware of passing -P<profile> to Maven
date: 2016-01-06
category: java
tags: java, maven

Maven has a cool feature where you can separate different
settings/build configuration bundles in what it calls profiles. To
active a profile, one would pass:

```
$ mvn -Pdevelopment-only-settings compile
```

If there's a profile you want to always activate, it can itself have a
setting like this:

```
<settings>
..
  <profiles>
    <profile>
      <id>development-only-settings</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
    </profile>
  </profiles>
</settings>
```

Alternatively, you can activate the profile(s) you need by passing the
`-P` parameter to Maven:

```
$ mvn -Pfoo compile
```

The thing, though, is that this will disable all the profiles you have
defined with `<activeByDefault/>` (warning)

To be sure that a profile always is activated, even if the user (like
Jenkins) passes -P to Maven, instead use:

```
<settings>
..
  <profiles>
    <profile>
      <id>development-only-settings</id>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>development</activeProfile>
  </activeProfiles>
</settings>
```
