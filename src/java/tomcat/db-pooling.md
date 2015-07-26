date:    2012-10-07
category: tomcat
title: Setting Up Database Pooling
tags: tomcat

### server.xml
```
<GlobalNamingResources>
  <Resource
    name="ECE_READ_DS"
    auth="Container"
    type="javax.sql.DataSource"
    maxActive="20"
    maxIdle="20"
    maxWait="10000"
    initialSize="10"
    username="ece5user"
    password="nottelling"
    driverClassName="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost/ece5db?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8&amp;characterSetResults=UTF-8"
    removeAbandoned="true"
    removeAbandonedTimeout="120"
    logAbandoned="true"
    testOnBorrow="false"
    testOnReturn="false"
    timeBetweenEvictionRunsMillis="60000"
    numTestsPerEvictionRun="5"
    minEvictableIdleTimeMillis="30000"
    testWhileIdle="true"
    validationQuery="select now()"
  />
  <Resource
    name="ECE_UPDATE_DS"
    auth="Container"
    type="javax.sql.DataSource"
    maxActive="20"
    maxIdle="20"
    maxWait="10000"
    initialSize="10"
    username="ece5user"
    password="nottelling"
    driverClassName="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost/ece5db?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8&amp;characterSetResults=UTF-8"
    removeAbandoned="true"
    removeAbandonedTimeout="120"
    logAbandoned="true"
    testOnBorrow="false"
    testOnReturn="false"
    timeBetweenEvictionRunsMillis="60000"
    numTestsPerEvictionRun="5"
    minEvictableIdleTimeMillis="30000"
    testWhileIdle="true"
    validationQuery="select now()"
  />
</GlobalNamingResources>]]>
```

### context.xml
```
<ResourceLink
  global="ECE_READ_DS"
  name="ECE_READ_DS"
  type="javax.sql.DataSource"
/>
<ResourceLink
  global="ECE_UPDATE_DS"
  name="ECE_UPDATE_DS"
  type="javax.sql.DataSource"
/>
```



