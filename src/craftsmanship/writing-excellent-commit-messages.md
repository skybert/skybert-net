title: Excellent Commit Messages
date: 2017-10-20
category: vcs
tags: craftsmanship, vcs, git

<pre style="overflow-x: scroll;">
commit a87de13c60102b80e8288025fcb7951bbcedb433
Author: John Doe <jon@doe.com>
Date:   Fri Oct 20 11:08:53 2017 +0200

FOO-21311 :
- System A and B both send rockets in packs of 5, however, this becomes a problem for the truck over at Detroit which only can accept 3 at a time. I therefore changed the default size to 3.
- Fixed NPE
- Added unit tests for this
</pre>

Hi there, may I suggest a few small changes to the format of the
commit messages?

## #0
You already did this, but for completeness sake, I'd mention that the
first word of the commit message should be the bug tracker issue id so
that it's easy to script listings of issues related to a given issue
(and distinguish these from messages where you mention other issues).

## #1
The first line of the commit message should be a short description of
the commit. This line shows up in `git log --oneline`, in the Stash
review interface, in the generated merge commits and other places
(email patches++, `git annotate <file>`).

## #2
Then follow up with an empty line. Otherwise, everything is shown in
one pile, e.g. in the review interface in Stash, in the output from `git log
--oneline` and other places.

## #3
Lastly, wrap the messages on 72 or 80 characters so that it displays
nicely in standard terminal windows.

Following the above recommendations, I would suggest reformatting your
commit message like this:

```
FOO-21311 Rocket pack size now fits all ports, including Detroit.

- System A and B both send rockets in packs of 5, however, this
  becomes a problem for the truck over at Detroit which only can
  accept 3 at a time. I therefore changed the default size to 3.
- Fixed NPE
- Added unit tests for this
```

## #4
Oh yes, one more thing. When talking about commit messages, I would
also urge everyone when writing the commit messages, to focus on _why_
you made these changes and less on the _what_. The _what_ is in the
commit diff, so saying "Changed rocket package size from 5 to 3" isn't
that interesting:

```diff
- public static Integer ROCKET_PACK_SIZE = 5;
+ public static Integer ROCKET_PACK_SIZE = 3;
```

However, _why_ you made that change, now _that's_ very interesting 😄


That's it,

Happy coding!

