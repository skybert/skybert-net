date:    2012-10-07
category: unix
title: Bitlbee
tags: im

I use Bitlbee to expose Jabber group chat as IRC channels so
that I can use ERC to connect to them. Here's how I've set it
up.


First, I added my Jabber account (well, first I connected to
bitlbee on localhost:6667):


register my-bittlbee-user my-new-bittlbee-password
account add jabber user@chat.mycompany.com mypassword
account on



I then added our department Jabber group chat room:

    chat add 0 myroom@conference.chat.mycompany.com


The 0 refers to the first account inside my bitlbee
account. That's it for the bitlbee setup, I could now join the
Jabber chat room by a normal IRC command:

    /join saas@conference.chat.mycompany.com


Now, I can enjoy chatting in my company Jabber chat room in the
same client that I use for chatting in my company IRC chat
rooms. Excellent! Bitlbee also supports a lot of other IM
networks, like MSN, Yahoo and Facebook, just add more accounts
as I did in the first step above and off you go. Good luck!

## Setting a nick per chat

If you want to set a different nick for a particluar chat, you
can do (tested on Bitlbee 3.0.5+20120604+devel) the below
command, this approach works with nicks with spaces in them, as
opposed to the```/nick``` command:

    channel myroom set nick "Torstein Krause Johansen"

## Add HipChat chat room

```
chat add <bitlbee-account-id> <hipchat-id>_<hipchat-room-name>@conf.hipchat.com #<id>
```

My HipChat account set up in Bitlbee is called "hipchat", my company's
HipChat ID is 12334 and the HipChat room is called "myroom". If you're
uncertain about this funny lookin gaddress, the exact Jabber reference
string (JID) can be found on the room page on the HipChat web
interface under https://mycompany.hipchat.com/rooms

e.g.:
```
chat add hipchat 12345_myroom@conf.hipchat.com #myroom
```

I call my Bitlbee IRC channels the same as they're called in HipChat,
thus `#myroom` here, but of course, you can call it whatever you want
😉
