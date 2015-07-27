title: Atlassian Stash
date: 2014-10-07
category: vcs
tags: atlassian, stash, bash, git, vcs

## Listing all clone URLs for a given project
This is easy using the REST API:

```
$ curl -s   http://git.example.com/rest/api/1.0/projects/BATCH/repos | \
  sed 's#[,]#,\n#g' | \
  sed -n 's#[ ]*["]cloneUrl["].*["]\([^"]*\)"[,].*#\1#p'
```
