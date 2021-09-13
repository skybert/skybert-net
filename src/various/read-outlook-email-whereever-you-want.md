title: Read Outlook 365 email in your favourite email client
date: 2021-03-02
category: various
tags: various, email, outlook

<a href="/graphics/2021/2020-04-17-read-stibodx-where-you-want..png">
  <img src="/graphics/2021/2020-04-17-read-stibodx-where-you-want..png"
    alt="setup with davmail offlineimap and emacs"
    class="centered"
    style="width: 845px; height: 400px;"
  />
</a>

After a couple of months of using the Outlook web client I was slowly
going mad and returned to reading email in my favourite email client.

Since my company didn't to enable app passwords for our Office 365
account, you must use an email client which supports EWS, which
seriously limits the number of choices you have. In this article, I
will describe how you can use whatever email client you like, even
Emacs or Mutt if that's your fancy.

## 1 Install and run DavMail

[DavMail](https://sourceforge.net/projects/davmail/) works on Windows,
macOS and Linux alike, all you need is a Java runtime.

On Debian & Ubuntu, you can install it with:
```text
# apt-get install davmail
```

You run it as your own, regular user. It must have access to a
display, so start it from your graphical desktop session:

```
$ davmail &
```

If you see just a grey window where the DavMail O365 dialogue
should've been, add this env parameter (see this article for more
details):

```text
$ _JAVA_AWT_WM_NONREPARENTING=1 davmail &
```

## 2 Configure davmail

The crucial bits here are:

```text
Exchange protocol: O365Interactive
OWA or EWS (Exchange URL): https://outlook.office365.com/EWS/Exchange.asmx
```

The O365Interactive option here will make davmail open up a Java
browser window, in which you'll answer the AD authentication
challenges, as well as the 2-factor authentication request. You only
need to do this once after starting `davmail`.

## 3 Configure your email client

Use the local IMAP, SMTP, CalDAV++ ports that are listed in the
davmail window in #2 to configure your favourite email client (here
showing my
[offlineimap](https://www.offlineimap.org/doc/offlineimap.html) conf
which I use to sync the email to a
[maildir](https://en.wikipedia.org/wiki/Maildir) which my
Emacs/[mu4e](https://www.djcbsoftware.nl/code/mu/mu4e.html) email
client reads in #4)

## 4 Use your favourite email client to read your company email

Notice how you start to like email a little more? How your pulse calms
down as you don't have to wrestle with the stupidly bad search and
clunky UI in Outlook? Perhaps you'll even start to care about emails
more than skimming through auto generated Jira emails and "Ok!",
"Check this!" messages to your colleagues?

Happy emailing!

