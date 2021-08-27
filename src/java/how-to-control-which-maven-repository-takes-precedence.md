title: How to control which Maven repository takes precedence
date: 2021-07-26
category: java
tags: java, maven

The order of which you've listed the `<repository>` elements in your
`~/.m2/settings.xml` instructs Maven which repository takes precedence
over another. This is important if you want to override an upstream
artifact with a specially crafted one in your own Nexus repository.

```xml
<repositories>
   <repository>
     <id>maven-releases</id>
     <url>http://example.com/repository/maven-releases/</url>
     <releases>
       <enabled>true</enabled>
     </releases>
     <snapshots>
       <enabled>false</enabled>
     </snapshots>
   </repository>
   <repository>
     <id>maven-snapshots</id>
     <url>http://example.com/repository/maven-snapshots/</url>
     <releases>
       <enabled>false</enabled>
     </releases>
     <snapshots>
       <enabled>true</enabled>
     </snapshots>
   </repository>
  <repository>
    <id>central</id>
    <url>http://example.com/repository/maven-central</url>
    <releases>
      <enabled>true</enabled>
    </releases>
    <snapshots>
      <enabled>false</enabled>
    </snapshots>
   </repository>
</repositories>
```

Here, I want my own `maven-releases` and `maven-snapshots`
repositories to take precedence over the upstream `central`
repository. The `central` repo is proxied through my own Nexus, hence
the same base URL as the others.

It's not often you run into the need for this, but knowing how to may
save your bacon one day.

Happy building!
