
# Why I'm in love with ZSH

What made me switch from `BASH` to `ZSH` and why I haven't looked
back.

> by <a href="https://twitter.com/torsteinkrause">@torsteinkrause</a>

---

# Tab completion with documentation

---

# Kill with tab completion

---

# Auto suggestions

---

# Pure prompt

---

# Async

---

# Can re-use BASH aliases

---

# Forgetting a pipe

```text
$ bash
$ echo hi |
> wc
```

```
$ zsh
$ echo i |
pipe> wc
```

---

# Forgetting a quote
```text
$ bash
$ echo 'hi 
> '
```

```
$ zsh
$ echo 'hi
quote> '
```

---

# Shows you if command will be found

---

# Powerful recursive file name matching

<img
  src="/graphics/2019/zsh/zsh-recursive-globbing.png"
  alt="zsh"
/>  

---

# BASH has this too, albeit not enabled by default

```text
$ ls ~/.m2/repository/org/**/*.pom | tail -n 3
ls: cannot access '/home/torstein/.m2/repository/org/**/*.pom': No such file or directory
$ shopt -s globstar
$ ls ~/.m2/repository/org/**/*.pom | tail -n 3
/home/torstein/.m2/repository/org/yaml/snakeyaml/1.15/snakeyaml-1.15.pom
/home/torstein/.m2/repository/org/yaml/snakeyaml/1.17/snakeyaml-1.17.pom
/home/torstein/.m2/repository/org/yaml/snakeyaml/1.18/snakeyaml-1.18.pom
$ 
```
