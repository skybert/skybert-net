title: Viewing the LDAP schema (cn=config)
date: 2018-05-03
category: ldap
tags: ldap, unix

The LDAP schema isn't viewable in the regular view of the LDAP
tree. It's stored in a parallel universe called `cn=config`, the brain
child of something called LDAP OLC (on line configuration). Someone
thought it was a good idea to allow runtime configuration of
LDAP. They forgot the part of being easy and maintainable on par with
other Unix services on the server. Hence, they abandoned configuration
files under `/etc` to go with this parallel LDAP tree under
`cn=config`. Oh well, in any case, to view it, you can use `slapcat`:


```text
$ slapcat -H "ldap:///cn=config??sub?(olcDatabase=*)"
```




