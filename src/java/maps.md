title: Maps in Java
date: 2015-09-03
category: java
tags: java

## Iterating a map

I've Googled this so many times so I better write it down. Who knows,
perhaps I will actually remember it someday.

```java
for (Map.Entry<String, Integer> entry : map.entrySet()) {
  System.out.println("key=" + entry.getKey() + "=" + entry.getValue());
}
```
