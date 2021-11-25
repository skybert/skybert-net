title: Outlook in tmux
date: 2021-11-04
category: linux
tags: linux

<a href="/graphics/2021/outlook-in-tmux.png">
  <img
    class="centered"
    src="/graphics/2021/outlook-in-tmux.png"
    alt="outlook in tmux"
    style="width: 1024px;"
  />
</a>

Here you see [tmux](https://github.com/tmux/tmux) running showing a
summary of my Outlook agenda. There's also some other nice things that
I like to keep track of, like the time and battery usage.

To get this working, I have done a few things:

## Exporting Outlook calendar as ical

I've gotten a hold of the [.ics
URL](https://fileinfo.com/extension/ics) of my Outlook calendar.

## cron job to convert ical to Org
Since I also want the calendar in Emacs, I convert it to
[.org](https://orgmode.org/) using
[ical2orgpy](https://github.com/asoroa/ical2org.py):

```bash
#! /usr/bin/env bash

# pre-requisite: pip install ical2orgpy

ics_url=https://outlook.office365.com/owa/calendar/234243@example.com/235452314/calendar.ics
org_file=$HOME/doc/scribbles/$(date +%Y)/outlook.org

curl -s "${ics_url}" | ~/.local/bin/ical2orgpy - "${org_file}"
```

## Convert the ICS calendar export to something nice looking  

I then convert the `outlook.org` into something that looks nice in the
terminal:

```bash
#! /usr/bin/env bash

sleep=3600

create_nice_ascii_agenda() {
    grep "$(date --iso)" -B 2 |
    sed 's#:RECURRING:##' |
    sed 's/-[ ]*$//' |                                # remove trailing dash and space
    sed 's#\*#\n❯#g' |
    sed '/^-$/d' |                                    # remove empty lines
    sed "s#$(date +'%F %a') ##g" |                    # remove day abbreviation
    sed 's#--# → #' |
    xargs |                                           # remove all newlines
    sed 's#❯#\n❯#g' |                                 # one entry per line
    sed -r 's#❯ (.*) <(.*)> → <(.*)>#\2 → \3 ❯ \1#' | # put time first
    sort -u |
    cat
}

main() {
  while true; do
    clear
    cat "$HOME/doc/scribbles/$(date +%Y)/outlook.org" |
      create_nice_ascii_agenda
    sleep "${sleep}"
  done

}

main "$@"
```
