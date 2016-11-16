title: Why is there no picture or user link in the Stash Commit List?
date: 2016-11-03
category: vcs
tags: git, vcs

Stash is Atlassian's `git` web interface, much like `github.com`. The
killer feature of Stash over [Github](http://github.com)
or [GitLab](http://gitlab.org) is that it integrates "seemlessly" with
Jira (the issue tracker).

When browsing the commit list on Stash, however, I someties find that
there's no profile picture of the user nor a link to that user's Jira
or Confluence profile page.

The reason for this is that the user has a different email in his/her
`~/.gitconfig` than what's registered for that user in Atlassian
Confluence/Jira/Stash.

The fix is easy, just two steps:

1. Head over to your profile page on Confluence or Jira and check the
   email address there.
   
2. Open your `~/.gitconfig` in your favourite editor and make sure the
   email reads the same as what you found on your Confluence profile
   page:
   
```
[user]
    name = John Doe
    email = john@example.com
```
