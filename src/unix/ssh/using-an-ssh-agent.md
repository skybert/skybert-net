date:    2012-10-07
category: unix
title: Using an SSH Agent
tags: ssh, security

Using```ssh-agent``` for managing your keys makes
logging into multiple servers a breeze. However, if I'm not
running an X session, the agent normally responds with:

    $ ssh-add
Could not open a connection to your authentication agent.


To remedy this, simply do:

    $ eval $(ssh-agent)


You can now add your keys with```ssh-add``` and enjoy
password less logins to your servers

