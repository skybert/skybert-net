title: Don't Check in Commented Out Code
date: 2016-10-25
category: craftsmanship
tags: craftsmanship, vcs

Every now and then this topic comes up, why shouldn't you check in
commented out code? 

> It's so nice an convenient, then we have the code right there if we
> need it.

Well, yes, that may seem convenient to you at the time of writing, but
this has several disadvantages:

## The VCS remembers it for you

If the code you commented out was some previous implementation, this
information is safely kept in the version control system. It's easy to
resurrect old code by using the VCS. That's what it's there for!

## Less is more

The easiest code to read and understand is no code. If some code is
commented out, the reader will wonder if this was intentionally
commented out. The reader will read the commented out code and will
try to set it into the context in which it is written, compare it to
the running code and so on.

The less code there is to read and understand, the easier it is to
maintain and extend the code at hand.

## Commented code is hard to delete

Many people have a hard time deleting code. It feels dangerous. If
it's commented out, they may think it's better to leave it in "just in
case". We've got commented out code in our source tree being more than
10 years old. In my experience, commented out code never gets
commented in again.

## Housekeeping

Checking in commented out code also creates larger than necessary
commit diffs. People reading the diffs are put through unnecessary
work as they have to ensure that the commented out block is of no
interest and can safely be ignored.

## Conclusion

Before committing your code changes to the code repository, have a
look at the diff to be committed and verify that it doesn't contain
any commented out code blocks.

It'll save everyone working on the code base a lot of time and
effort. Trust me 😃
