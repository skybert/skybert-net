title: Jenkins out of inodes
date: 2016-11-15
category: unix
tags: unix, jenkins, ci

The first symptom that something really strange was at play, was that
some Jenkins jobs, for some seemingly completely illogical reason,
started to fail jobs. After hours of trying to tweak the job's
configuration, I logged on to the server to find that it was slow and
constantly gave "No space left on device" errors.

`df` reported only 75% usage leaving me somewhat puzzled. However, as
a few times before, it was because the server was out of `inodes`, not
space, that this error message was given. A quick:

```
$ df -i /
```

Showed that the kernel didn't have any `inodes` to spare. Something
had to be done. I fired off this command to get a list of directories
containing the most files on the system. I let it run in the `nohup`
wrapper so that I could exit the shell and go home while it finished
up:

```
$ echo "find / -xdev -printf '%h\n' | sort | uniq -c | sort -k 1 -n" > find-dirs-with-inodes.sh
$ nohup find-dirs-with-inodes.sh &
```

After some investigation, it turned out that Jenkins was to blame, and
specifically two of its concepts: fingerprints and config history.
E.g. there was 2,711,693 `inode`s because of the Jenkins configuration
history:

```
$ awk '/config-history/{ c += $1; } END { print c; }' nohup.out 
2711693
```

The finger print is an XML file for each build it has ever done (!) to
facilitates nice cross referencing like "this artifact has been used
in the following jobs " and so on. The config history is an XML backup
created each time someone changes something in any of the build jobs
through Jenkins' web UI.

I therefore wrote this wee script that deletes files older than one
year for a selected set of Jenkins directories.

This has two objectives: Save inodes and save diskspace. The first is
by far the most pressing one as Jenkins creates a *lot* of files and
although these may not all be big, like configuration files, they all
need an inode, which the kernel has a limited set of.

```bash
#! /usr/bin env bash

main() {
  local base_dir=/var/lib/jenkins
  local dir_list="
    ${base_dir}/fingerprints
    ${base_dir}/config-history
  "

  for dir in ${dir_list}; do
    /usr/bin/find "${dir}" -type f -mtime +365 -delete
    /usr/bin/find "${dir}" -type d -empty -delete
  done
}

main "$@"
```

After running this script, the `inode` usage dropped from 100% to 33%.

To prevent this problem from reoccuring, I added it to the cront tab
for the Hudson user:

```
$ crontab -e
```

And added this to make it run every week on Saturday:

```
* * * * 6 $HOME/bin/delete-old-jenkins-files
```

That's hopefully the last time we'll see Jenkins all of a sudden
throwing unexplainable errors due to the lack of `inode`s 😄
