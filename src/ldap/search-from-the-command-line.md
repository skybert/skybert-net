date:    2012-10-07
category: ldap
title: Searching LDAP from the command line

This is one example for searching OpenLDAP using the command
line:


    $ ldapsearch \
        -h myldaphost \
        -p 389 \
        -D "cn=admin,dc=skybert,dc=net" \
        -w bar \
        -x \
        -b "ou=Users,ou=mysite,dc=skybert,dc=net" \
        "cn=myuser*"


