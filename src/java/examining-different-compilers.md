title: Examining Different Java Compilers
date: 2018-12-04
category: java
tags: java, openjdk, oracle

I have three JDKs on my system and I'd like to see if I can tell if
they produce different `.class` files when compiling `.java` sources
and if I can tell which one produced which `.class` file. The JDKs on
my system are:

```text
$ dpkg -l '*jdk*' | grep ^ii | cut -d' ' -f3
openjdk-11-jdk-headless:amd64
openjdk-8-jdk-headless:amd64
oracle-java8-jdk
```

For each of these compilers, I want to do:
```bash
mkdir compiler-foo && compiler-foo
echo "public class Test { }" > Test.java
javac Test.java
javap -verbose Test.class > Test.javap
```

With a bit of BASH foo, this becomes:

```bash
find /usr/lib/jvm/ -name javac |
  while read -r java_compiler; do
    compiler=$(basename "$(dirname "$(dirname "${java_compiler}")")")
    fn=${compiler//-/}
    mkdir "${fn}"
    echo "public class Test { }" > "${fn}"/Test.java
    "${java_compiler}" "${fn}"/Test.java
    "$(dirname "${java_compiler}")"/javap -verbose "${fn}"/Test.class \
      &> "${fn}"/Test.javap
  done
```

Since I had three compilers, I now have three directories, each with
its own set of `Test` files:

```text
$ tree
.
├── java11openjdkamd64
│   ├── Test.class
│   ├── Test.java
│   └── Test.javap
├── java8openjdkamd64
│   ├── Test.class
│   ├── Test.java
│   └── Test.javap
└── oraclejava8jdkamd64
    ├── Test.class
    ├── Test.java
    └── Test.javap

3 directories, 9 files
```

Now, on to the fun part, diffing. There's no difference between the
`.class` files generated by Oracle JDK 8 and OpenJDK 8:

```text
$ diff java8openjdkamd64/Test.class oraclejava8jdkamd64/Test.class
$ echo $?
0
```

The only difference is the path to the source file as reported by `javap`:
```text
$ diff java8openjdkamd64/Test.javap oraclejava8jdkamd64/Test.javap
1c1
< Classfile /tmp/examine/java8openjdkamd64/Test.class
---
> Classfile /tmp/examine/oraclejava8jdkamd64/Test.class
```

On the other hand, when examining the difference in the `.class` files
produced by OpenJDK 8 and OpenJDK 11, there are several
difference. First off, the `.class` files differ:
```text
$ diff java8openjdkamd64/Test.class java11openjdkamd64/Test.class
Binary files java8openjdkamd64/Test.class and java11openjdkamd64/Test.class differ
```

`javap` has more details for us:
```bash
$ diff java8openjdkamd64/Test.javap java11openjdkamd64/Test.javap
```

```diff
1,3c1,3
< Classfile /home/torstein/tmp/examine/java8openjdkamd64/Test.class
<   Last modified 04-Dec-2018; size 182 bytes
<   MD5 checksum f22f52551c287057ed6d62d392d5647e
---
> Classfile /home/torstein/tmp/examine/java11openjdkamd64/Test.class
>   Last modified 4 Dec 2018; size 182 bytes
>   MD5 checksum 893ccf6fab86d0488097a4052360d7c1
7,8c7,11
<   major version: 52
<   flags: ACC_PUBLIC, ACC_SUPER
---
>   major version: 55
>   flags: (0x0021) ACC_PUBLIC, ACC_SUPER
>   this_class: #2                          // Test
>   super_class: #3                         // java/lang/Object
>   interfaces: 0, fields: 0, methods: 1, attributes: 1
25c28
<     flags: ACC_PUBLIC
---
>     flags: (0x0001) ACC_PUBLIC
```

The difference here that really tells us that these are two compilers
defaulting to different Java language versions is the `major version`
field:

```text
<   major version: 52
---
>   major version: 55
```

Pretty interesting, eh?