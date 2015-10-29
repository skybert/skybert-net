
# BASH foo ☯

Taking your BASH skills to the next level

> A talk by <a href="">torstein @ escenic</a>


---

## Finding things

---

## Meet your best friend

`grep`

---

## Meet your 2nd best friend

`find`

---

## And their cousins

`egrep`, `xargs` and `|`

---

## And their little brothers

`wc` & `cat`

---

## With them

<span class="fragment">You can do incredible things</span>

---

## How many...

Maven modules are there in your project?

    $ find -name pom.xml | wc -l

---

## How many...

lines of Java code is there in your project?

    $ find -name "*.java" | xargs cat | wc -l

---

## How many...
lines of production Java code?
I.e. not tests?

    $ find -name "*.java" | grep src/main/java | xargs cat | wc -l

---

## Where is the class used?

```
$ find -name "*.java" -o -name "*.properties" | \
    grep trunk | \
    grep src/main/java | \
    xargs grep -ni --color IOObjectLoader
```

---

## Which JAR has my class?

- Has my class been deployed at all?
- In which classloader is my class running?
- Are there multiple versions of my class deployed?

---

## Which JAR has my class?

Don't look at your IDEA project structure and guess.

---

## Which JAR has my class?

```
$ grep -r com.example.app.MyClass /opt/tomcat*
```

---

## Which JAR has my class?

What's the problem with `grep` here?

---

## Can we do better?

---

## Which JAR has my class?

```
$ find -L /opt/tomcat -name "*.jar" | \
  xargs grep com.example.app.MyClass
```

---

## Which JAR has my class?

What's the problem with `find` and `grep` here?

---

## Can we do better?

---

## Which JAR has my class?

```
$ find -L /opt/tomcat -name "*.jar" | \
  while read f; do \
    echo $f;
    unzip -t $f | grep com.example.app.MyClass; \
  done
```

---

## Can we do better?

---

## Which JAR has my class?

```
$ /opt/escenic/engine/bin/find-jar \
  /opt/tomcat \
  com.example.app.MyClass
```

---

## It remembers 🐘

How was that `ssh` command again?

---

## It remembers 🐘

<kbd class="escenic">↑</kbd>
<kbd class="escenic">↑</kbd>
<kbd class="escenic">↑</kbd>

---

## It remembers 🐘

```
$ history
```

---

## It remembers 🐘

    $ grep ssh ~/.bash_history

---

## It remembers 🐘

<kbd class="escenic">Ctrl</kbd> + <kbd class="escenic">r</kbd>

```
(reverse-i-search)`ssh': ssh -L 99:localhost:80 foo@login.example.com
```

---

## Yes, you can ✈

---

## Yes, you can ✈
At the start
<kbd class="escenic">Ctrl</kbd> + <kbd class="escenic">a</kbd>

‐

End of line.:
<kbd class="escenic">Ctrl</kbd> + <kbd class="escenic">e</kbd>

‐

Delete letter:
<kbd class="escenic">Ctrl</kbd> + <kbd class="escenic">d</kbd>

‐

Kill the rest:
<kbd class="escenic">Ctrl</kbd> + <kbd class="escenic">k</kbd>

---

## Yes, you can ✈ II
Delete word
<kbd class="escenic">Alt</kbd> + <kbd class="escenic">d</kbd>

‐

Delete pevious word:
<kbd class="escenic">Alt</kbd> + <kbd class="escenic">←</kbd>

‐

Uppercase word:
<kbd class="escenic">Alt</kbd> + <kbd class="escenic">u</kbd>

‐

Lowercase word:
<kbd class="escenic">Alt</kbd> + <kbd class="escenic">l</kbd>

---

## SSH

---

## Passwordless logins

```
$ ssh-keygen -t rsa
$ ssh-copy-id user@host
$ ssh user@host
```

---

## Different usernames

Different usernames on different servers

```
Host *.dev.example.com
     User frodo
```

---

## TAB completion

Install & enable BASH completion:

```
# apt-get install bash-completion
$ echo "source /usr/share/bash-completion/bash_completion" \
  >> ~/.bashrc
$ source ~/.bashrc
```

---

## TAB completion - II

Be sure that your system doesn't hash the host names in
`~/.ssh/known_hosts`:

```
$ echo "HashKnownHosts no" >> ~/.ssh/config
```

---

## TAB completion - III

```
$ ssh p[TAB][TAB]
p4.dev.example.com
projects.example.com
```

---

## Reverse tunnels

Super useful. Makes life bearable in a world of stubborn sys admins.

---

## Reverse tunnels

```
$ ssh -L 9980:localhost:80 closy
```

Now, browse [http://localhost:9980](http://localhost:9980) and you'll be in fact accessing
[http://closy:80](http://closy:80)

---

## Reverse tunnels

You may want to set the `Host` header right

    # echo 127.0.0.1 closy >> /etc/hosts

Now, you can use [http://closy:9980](http://closy:9980) passing the
correct `Host` header through the tunnel to your target system.

---

## Reverse tunnels

If the CLI is enough:

```
$ curl -H "Host: closy" http://localhost:9980
```

---

## Loops

---

## What did I do last week?

```
$ p4 changes | grep 2015/08/03

```

---

## Can we do better?

---

## What did I do last week?

```
$ for el in 3 4 5 6 7 ; do p4 changes | grep 2015/08/0${el}; done

```

---

## Can we do better?

---

## What did I do last week?

```
$ for el in {3..7} ; do p4 changes | grep 2015/08/0${el}; done

```

---

## Can we do better?

---

## What did I do last week?

```
$ for el in {03..7} ; do p4 changes | grep 2015/08/${el}; done

```

---

## Don't be good, be great

---

## Don't be good, be great

How to use `ssh`? Read the `man` pages!

```
$ man ssh
```

---

## Don't be good, be great

Searching `man` will open your eyes:

```
$ man -k ssh
```


---

# Fine

> ✏ torstein @ escenic dot com

<div style="margin-left: auto; margin-right: auto; width: 10em">
<img src="../lib/twitter.svg" style="box-shadow:none;
margin:0px; border:none;"/>
<a style="" href="https://twitter.com/torsteinkrausew">@torsteinkrause</a>
</div>
