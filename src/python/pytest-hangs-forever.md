title: Python pytest hangs forever
date: 2020-09-02
category: python
tags: python, linux, testing

## The problem

Our Python project has hundreds of tests. All the tests run through:
```
$ pytest
[..]
======================= 291 passed, 9 skipped in 20.68s ========================
```
but somehow `pytest` doesn't move along. It just hangs and hangs, for
hours on end:

```text
jenkins  29472  0.2  0.9 1031840 75556 ?       Sl   12:34   0:04
/home/jenkins/.local/share/virtualenvs/src.1-g-rtNnkp/bin/python3.6m
/home/jenkins/.local/share/virtualenvs/src.1-g-rtNnkp/bin/pytest
```

## Getting the Linux call stack

At some point, Python calls the Linux APIs, sometimes seeing the OS
call stack can give a hunch of what's failing:
```text
# cat /proc/29472/stack
[<0>] futex_wait_queue_me+0xc4/0x120
[<0>] futex_wait+0x10a/0x250
[<0>] do_futex+0x325/0x500
[<0>] SyS_futex+0x13b/0x180
[<0>] do_syscall_64+0x73/0x130
[<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[<0>] 0xffffffffffffffff
```

Reading the documentation on [futex - fast user-space
locking](https://man7.org/linux/man-pages/man2/futex.2.html) revealed
that Python was waiting for a lock to proceed. Ok, that's nice, but no
way enough to figure out what I must fix in _my_ Python app or tests
to make the eternal hangs go away.

## Connect gdb to the running Python process - take 1
The next step was then attach `gdb` to the running process, however,
Python wasn't too talkative:

```
$ pipenv shell
$ gdb python -p <pid>
(gdb) bt
#0  0x00007f0d5b920896 in ?? ()
#1  0x0000000000503fd0 in PyImport_Cleanup () at ../Python/import.c:436
#2  0x0000000000000001 in ?? ()
#3  0x00007f0d30000d50 in ?? ()
#4  0x0000000000000000 in ?? ()
```


## Install Python with debugging symbols
To make Python tell more about what it was doing, I had to use a
version of the Python interpreter with debugging symbols:

```text
# apt-get install python3-dbg
```

## Set up your virtual env to use this Python interpreter

```text
$ pipenv --python /usr/bin/python3.7-dbg
```

## Get pytest to hang
One of the challenges with this problem, was that there was no way of
making it fail at will, it just failed _sometimes_. Every 50s run or
every 150s run.

To make it fail at will, I just had a little patience and let `bash`
do it for me:
```bash
$ start=$(date +%s);
  for i in {1..161}; do
    echo "pytest run #${i}, elapsed $(( $(date +%s) - start )) seconds";
    pipenv run pytest;
  done
```

## Connect gdb to the running Python process - take 2

```text
$ pipenv shell
$ gdb python -p <pid>
(gdb) py-bt
Traceback (most recent call first):
  File "/usr/lib/python3.7/threading.py", line 1048, in _wait_for_tstate_lock
    elif lock.acquire(block, timeout):
  File "/usr/lib/python3.7/threading.py", line 1032, in join
    self._wait_for_tstate_lock()
  File "/usr/lib/python3.7/threading.py", line 1281, in _shutdown
    t.join()
```
There, finally, I got somewhere: it hangs in `threading.py` and it's a
call to `join()` without any timeout that makes it stay there forever.

As an alternative to running `gdb` on the command line like below, you
can run `gdb` through Emacs with `M-x gdb`. This gives you auto completion on
the debugger commands among other things:

<img
  src="/graphics/2020/2020-09-02-184709_748x663_scrot.png"
  alt="Emacs running GDB against the Python process"
  title="Emacs running GDB against the Python process"
  class="centered"
/>

## Analysis

The call to `t.join()` is called from `_shutdown()` in `threading.py`
which again is called from `Thread#shutdown()`. So what in my code is
creating a thread and calls `shutdown()` on that object?

```text
$ grep -rn 'threading.Thread' --include=*.py src                      
src/skybert/concurrent/wire.py:289:        self._thread = threading.Thread(
src/skybert/concurrent/player.py:145:            self._thread = threading.Thread(
src/skybert/horse_whisperer.py:61:class Whisperer(threading.Thread):
```
I also searched for `import threading` to be on the safe side, but
since Python's own package names are so short, we tend to use the full
path so there were no additional cases.

Now I knew which places in my code which potentially directly or
indirectly called this troublesome code in Python's `threading.py`.

## The fix

Two of our app's threads were not daemonic, so Python would wait
around forever for until they exited: As none of them were writing
precious information to a database, I set them to daemonic. That way,
they'd be shut down whenever the `python` program wanted to quit
(that's what you normally want, right?):

In the words of the [Python
documentation](https://docs.python.org/3/library/threading.html#thread-objects):

> The significance of this flag is that the entire Python program
> exits when only daemon threads are left.

As often is, once you know it, the remedy is simple:

```diff
-t = threading.Thread(name="My thread")
+t = threading.Thread(name="My thread", daemon=True)
```

With that wee change to my application, the tests have at the time of
writing run `152` times successfully without any hang.

Happy testing!

