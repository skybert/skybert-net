title: Counting Objects Created in the JVM
date: 2021-09-23
category: java
tags: java

Here, I wanted to find out how many `java.net.HttpClient` objects were
created in the JVM. I sorted on the second column which is the number
of objects, giving me all `Httpclient` related objects, sorted
descending on count:

```text
$ jmap -histo $(pidof java) | sort -k 2 -V | grep net.http.HttpClient
```

This produced the following listing:

```text
 711:            17            272  jdk.internal.net.http.HttpClientImpl$$Lambda$189/0x00000008401be840 (java.net.http@11.0.12)
 544:            28            448  jdk.internal.net.http.HttpClientImpl$SelectorAttachment$$Lambda$190/0x00000008401bec40 (java.net.http@11.0.12)
 545:            28            448  jdk.internal.net.http.HttpClientImpl$SelectorManager$$Lambda$191/0x00000008401bf040 (java.net.http@11.0.12)
 546:            28            448  jdk.internal.net.http.HttpClientImpl$SelectorManager$$Lambda$193/0x00000008401bfc40 (java.net.http@11.0.12)
 547:            28            448  jdk.internal.net.http.HttpClientImpl$SelectorManager$$Lambda$195/0x00000008401c4040 (java.net.http@11.0.12)
 462:            28            672  jdk.internal.net.http.HttpClientImpl$SelectorManager$$Lambda$192/0x00000008401bf840 (java.net.http@11.0.12)
1744:             1             16  jdk.internal.net.http.HttpClientImpl$SelectorManager$$Lambda$196/0x00000008401c4440 (java.net.http@11.0.12)
1742:             1             16  jdk.internal.net.http.HttpClientImpl$$Lambda$122/0x000000084013e440 (java.net.http@11.0.12)
1743:             1             16  jdk.internal.net.http.HttpClientImpl$$Lambda$123/0x000000084013d840 (java.net.http@11.0.12)
1425:             1             24  [Ljava.net.http.HttpClient$Version; (java.net.http@11.0.12)
1323:             1             32  [Ljava.net.http.HttpClient$Redirect; (java.net.http@11.0.12)
 727:             2            256  jdk.internal.net.http.HttpClientImpl (java.net.http@11.0.12)
 411:             2            800  jdk.internal.net.http.HttpClientImpl$SelectorManager (java.net.http@11.0.12)
1381:             2             32  jdk.internal.net.http.HttpClientFacade (java.net.http@11.0.12)
1382:             2             32  jdk.internal.net.http.HttpClientImpl$$Lambda$120/0x000000084013ec40 (java.net.http@11.0.12)
1201:             2             48  java.net.http.HttpClient$Version (java.net.http@11.0.12)
1222:             2             48  jdk.internal.net.http.HttpClientImpl$DefaultThreadFactory (java.net.http@11.0.12)
1223:             2             48  jdk.internal.net.http.HttpClientImpl$DelegatingExecutor (java.net.http@11.0.12)
1125:             2             64  jdk.internal.net.http.HttpClientImpl$SSLDirectBufferSupplier (java.net.http@11.0.12)
1074:             3             72  java.net.http.HttpClient$Redirect (java.net.http@11.0.12)
 898:             4            128  jdk.internal.net.http.HttpClientImpl$SelectorAttachment (java.net.http@11.0.12)
```

