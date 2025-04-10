title: Inspect Incoming HTTP Traffic to Dropwizard micro services
date: 2025-04-10
category: java
tags: java, network, http

To Debug HTTP traffic into any Dropwizard micro service, can easily be
done by enabling `DEBUG` logging on these two Jetty components:

```yaml
logging:
  level: ERROR
  loggers:
    org.eclipse.jetty.server.HttpChannel: DEBUG
    org.eclipse.jetty.http.HttpParser: DEBUG
```

Example output:

```text
2024-01-26 13:27:45.375	DEBUG [2024-01-26 12:27:45,375] org.eclipse.jetty.http.HttpParser: parseNext s=START HeapByteBuffer@3824e567[p=0,l=326,c=8192,r=326]={<<<GET /user/me?access_token...t: application/json\r\n\r\n>>>ttp://www...\x00\x00\x00\x00\x00\x00\x00}
..
2024-01-26 13:27:45.376	DEBUG [2024-01-26 12:27:45,375] org.eclipse.jetty.http.HttpParser: HEADER:User-Agent: Stibo DX CUE DAM (DC-X) 7.0.0 (http://www.digicol.de/) --> IN_VALUE
2024-01-26 13:27:45.376	DEBUG [2024-01-26 12:27:45,375] org.eclipse.jetty.http.HttpParser: HEADER:User-Agent: Stibo DX CUE DAM (DC-X) 7.0.0 (http://www.digicol.de/) --> FIELD
2024-01-26 13:27:45.376	DEBUG [2024-01-26 12:27:45,375] org.eclipse.jetty.http.HttpParser: HEADER:Accept: application/json --> IN_VALUE
2024-01-26 13:27:45.376	DEBUG [2024-01-26 12:27:45,375] org.eclipse.jetty.http.HttpParser: HEADER:Accept: application/json --> FIELD
..
2024-01-26 13:27:45.376	DEBUG [2024-01-26 12:27:45,375] org.eclipse.jetty.server.HttpChannel: REQUEST for //um.example.com/user/me?access_token=eyfoobarbaz on HttpChannelOverHttp@38e0621e{s=HttpChannelState@534aa4d7{s=IDLE rs=BLOCKING os=OPEN is=IDLE awp=false se=false i=true al=0},r=5,c=false/false,a=IDLE,uri=//um.example.com/user/me?access_token=eyfoobarbaz,age=0}
```

