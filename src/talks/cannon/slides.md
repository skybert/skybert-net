
# Cannon 💥

Automagic status reports & time reporting

by <a href="https://twitter.com/torsteinkrause">@torsteinkrause</a>

---

## Why cannon? 💥

<img src="http://www.military-today.com/artillery/zuzana.jpg" alt="cannon"/>


---

## Why cannon? 💥

- Let Jenkins do the time reporting for you
- Know what everyone in R&D, Cloud & QA are working on
- The source of truth is Git
- Predictable results (Dead simple work log algorithm)

---

<img src="/graphics/2019/cannon-sketch.jpg" alt="cannon sketch" />

---

## Time reports for everyone

Pick a date and get a report of:

💥 All users

💥 All git repositories

💥 All branches

---

> Talk is cheap. Show me the code.

— Torvalds, Linus (2000-08-25)

---

## It has 📚

```
❯ cannon --help
Usage: cannon [OPTIONS]

DESCRIPTION
  Create time reports for all users in any git project

OPTIONS
  -d, --data-dir             Where ./bin/cannon stores its files. Default is /tmp
  -h, --help                 Don't panic.
  -j, --report-hours-in-jira Report the hours on the issues on behalf of the comitter.
  -o, --offline              Use the git repositories that we have.
  -r, --repo                 Git repo URI. Multiple --repo <repo> are supported
  -t, --report-date          Report date. Default is 2019-05-23 (today)

EXAMPLES

  -- Create time reports based on two repos:

    ./bin/cannon \
      --report-date 2019-05-07 \
      --repo ssh://git@example.com/proj/foo.git \
      --repo ssh://git@example.com/proj/bar.git

  -- Create time reports based on two repos and log the hours in Jira too:

    ./bin/cannon \
      --report-date 2019-05-07 \
      --report-hours-in-jira \
      --repo ssh://git@example.com/proj/foo.git \
      --repo ssh://git@example.com/proj/bar.git

FILES
  Optionally, you can specify options in /home/torstein/.cannon.conf, e.g.:

  repo_list="
    ssh://git@cci-jira-stash.ccieurope.com:7999/escrd/cue-archive.git
    ssh://git@cci-jira-stash.ccieurope.com:7999/escrd/dpres-cook.git
  "
```

---

## Want it?

Install: 

```
$ git clone https://cci-jira.ccieurope.com/stash/scm/~tkj/cannon.git
$ vim ~/.cannon.conf
```

Run:
```
$ cannon
```

---

## Bonus: it can be pretty too 💄

```
$ cannon --pretty
John Doe, john@example.com
  FOO-154 Foo sees no events when running with urllib3 version 1.25.2
  🕥 2.0h
  ➡ foo-line
Lisa Jenkins, lisa@example.com
  BAR-8183 Running constants database script fails
  🕥 6.0h
  ➡ bar-engine
```

---

## Happy reporting! 💥

✏✉ torstein @ escenic dot com



