title: JAXB gives excellent error messages
date: 2014-10-15
category: java
tags: java, soap

Annoying as it is, that JAXB can't handle interfaces, the matter in
which it reports about this is spotless:

```
Caused by: com.sun.xml.bind.v2.runtime.IllegalAnnotationsException: 1 counts of IllegalAnnotationExceptions
net.skybert.moccasin.model.Tribe is an interface, and JAXB can't handle interfaces.
    this problem is related to the following location:
        at net.skybert.moccasin.model.Tribe
        at public net.skybert.moccasin.model.Tribe net.skybert.moccasin.model.AbstractIndian.getTribe()
        at net.skybert.moccasin.model.AbstractIndian
        at net.skybert.moccasin.model.WildIndian
        at private net.skybert.moccasin.model.WildIndian net.skybert.moccasin.ws.soap.jaxws_asm.GetIndianResponse.indian
        at net.skybert.moccasin.ws.soap.jaxws_asm.GetIndianResponse
```
