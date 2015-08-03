
# BASH foo

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

you can do incredible things

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

## SSH

---

## Passwordless logins

```
$ ssh-keygen -t rsa
$ ssh-copy-id user@host
$ ssh user@host
```

---

## Different username on different servers

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

or if the CLI is enough:

```
$ curl -H "Host: closy" http://localhost:9980
```

---

## Loops

---

## What was done this week?

```
$ p4 changes | grep 2015/08/03

```

---

## Can you do better?

---

## What was done this week?

```
$ for el in 3 4 5 6 7 ; do p4 changes | grep 2015/08/0${el}; done

```

---

## Can you do better?

---

## What was done this week?

```
$ for el in {3..7} ; do p4 changes | grep 2015/08/0${el}; done

```

---

## Can you do better?

---

## What was done this week?

```
$ for el in {03..7} ; do p4 changes | grep 2015/08/${el}; done

```

---

# Fine

<div style="margin-left: auto; margin-right: auto; width: 10em">
<img src="twitter.svg" style="box-shadow:none;
margin:0px; border:none;"/>
<a style="" href="https://twitter.com/torsteinkrausew">@torsteinkrausew</a>
</div>
