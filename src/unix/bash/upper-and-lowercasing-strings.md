title: Upper and Lowercasing Strings
date: 2017-11-28
category: bash
tags: unix, bash

Many people use external commands such as `tr` and `awk` for
uppercasing and lowercasing strings, but this is not necessary. BASH 4
and later can do this all by itself.

## To upper case

```bash
jira_key=foo-2343
printf "%s\n" ${jira_key^^}
```

Result:
```
FOO-2343
```

## To lower case

```bash
jira_key=FOO-2343
printf "%s\n" ${jira_key,,}
```

Result:
```
foo-2343
```
