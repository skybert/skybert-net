title: Python pytest hangs forever
date: 2020-09-02
category: python
tags: python, linux, testing

## The problem

Tests are great. Our Python project has hundreds of them. And all of
these the tests run successfully. Every time:

```
$ pytest
[..]
======================= 291 passed, 9 skipped in 20.68s ========================
```
However, somehow `pytest` doesn't move along. It just hangs and hangs, for
hours on end. This typically happens on the CI server, impeding other
projects' builds:

```text
$ ssh jenkins@builder.example.com
$ ps auxww
jenkins  29472  0.2  0.9 1031840 75556 ?       Sl   12:34   0:04
/home/jenkins/.local/share/virtualenvs/src.1-g-rtNnkp/bin/python3.6m
/home/jenkins/.local/share/virtualenvs/src.1-g-rtNnkp/bin/pytest
```

To make it even more interesting, it doesn't do this every
time. Sometimes `pytest` hangs the 10th time, sometimes the 43th time
and yet other times the 130th time `pytest` runs. Very fascinating.

## Getting the Linux call stack

At some point, Python calls the Linux APIs, so seeing the OS
call stack can sometimes give a hunch of what's failing:
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

## Connect gdb to the running Python process - take 2
You should now see a more details trace of what's going on:
```text
(gdb) bt
#0  0x00007f3669a91896 in do_futex_wait.constprop () from /lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00007f3669a91988 in __new_sem_wait_slow.constprop.0 () from /lib/x86_64-linux-gnu/libpthread.so.0
#2  0x00000000005279d2 in PyThread_acquire_lock_timed (lock=lock@entry=0x7f3644002080, microseconds=<optimized out>, microseconds@entry=-1000000, intr_flag=intr_flag@entry=1) at ../Python/thread_pthread.h:372
#3  0x00000000005827fb in acquire_timed (lock=0x7f3644002080, timeout=-1000000000) at ../Modules/_threadmodule.c:61
#4  0x0000000000582992 in lock_PyThread_acquire_lock (self=self@entry=0x7f36636582a8, args=args@entry=0x7f3667d100c8, kwds=kwds@entry=0x0) at ../Modules/_threadmodule.c:144
#5  0x00000000004370cb in _PyMethodDef_RawFastCallKeywords (method=<optimized out>, self=self@entry=0x7f36636582a8, args=args@entry=0x7f364c0054a0, nargs=nargs@entry=2, kwnames=kwnames@entry=0x0) at ../Objects/call.c:690
#6  0x000000000061a8bf in _PyMethodDescr_FastCallKeywords (descrobj=descrobj@entry=0x7f366915bdf0, args=args@entry=0x7f364c005498, nargs=nargs@entry=3, kwnames=kwnames@entry=0x0) at ../Objects/descrobject.c:288
#7  0x00000000004e8787 in call_function (kwnames=0x0, oparg=3, pp_stack=<synthetic pointer>) at ../Python/ceval.c:4593
#8  _PyEval_EvalFrameDefault (f=0x7f364c0052f8, throwflag=<optimized out>) at ../Python/ceval.c:3110
#9  0x00000000004dda6a in PyEval_EvalFrameEx (f=f@entry=0x7f364c0052f8, throwflag=throwflag@entry=0) at ../Python/ceval.c:547
#10 0x00000000004de488 in _PyEval_EvalCodeWithName (_co=0x7f3668ee1940, globals=<optimized out>, locals=locals@entry=0x0, args=args@entry=0x7f365c077298, argcount=1, kwnames=0x0, kwargs=0x7f365c0772a0, kwcount=0, kwstep=1, defs=0x7f3668ef6be0, defcount=2, kwdefs=0x0, closure=0x0, name=0x7f3668ef4400, qualname=0x7f3668ef35c0) at ../Python/ceval.c:3930
#11 0x0000000000436a21 in _PyFunction_FastCallKeywords (func=func@entry=0x7f3668e25f70, stack=stack@entry=0x7f365c077298, nargs=nargs@entry=1, kwnames=kwnames@entry=0x0) at ../Objects/call.c:433
#12 0x00000000004e8828 in call_function (kwnames=0x0, oparg=<optimized out>, pp_stack=<synthetic pointer>) at ../Python/ceval.c:4616
#13 _PyEval_EvalFrameDefault (f=0x7f365c077108, throwflag=<optimized out>) at ../Python/ceval.c:3110
#14 0x00000000004dda6a in PyEval_EvalFrameEx (f=f@entry=0x7f365c077108, throwflag=throwflag@entry=0) at ../Python/ceval.c:547
#15 0x00000000004de488 in _PyEval_EvalCodeWithName (_co=0x7f3668ee1880, globals=<optimized out>, locals=locals@entry=0x0, args=args@entry=0x7f3667cd87e8, argcount=1, kwnames=0x0, kwargs=0x7f3667cd87f0, kwcount=0, kwstep=1, defs=0x7f3668ef5f88, defcount=1, kwdefs=0x0, closure=0x0, name=0x7f36691be930, qualname=0x7f3668ef6200) at ../Python/ceval.c:3930
#16 0x0000000000436a21 in _PyFunction_FastCallKeywords (func=func@entry=0x7f3668e25eb8, stack=stack@entry=0x7f3667cd87e8, nargs=nargs@entry=1, kwnames=kwnames@entry=0x0) at ../Objects/call.c:433
#17 0x00000000004e8828 in call_function (kwnames=0x0, oparg=<optimized out>, pp_stack=<synthetic pointer>) at ../Python/ceval.c:4616
#18 _PyEval_EvalFrameDefault (f=0x7f3667cd8658, throwflag=<optimized out>) at ../Python/ceval.c:3110
#19 0x00000000004dda6a in PyEval_EvalFrameEx (f=f@entry=0x7f3667cd8658, throwflag=throwflag@entry=0) at ../Python/ceval.c:547
#20 0x00000000004360b5 in function_code_fastcall (co=co@entry=0x7f3668efd040, args=args@entry=0x0, nargs=nargs@entry=0, globals=globals@entry=0x7f3668f539b8) at ../Objects/call.c:283
#21 0x00000000004367e0 in _PyFunction_FastCallDict (func=func@entry=0x7f3668e2a058, args=args@entry=0x0, nargs=nargs@entry=0, kwargs=kwargs@entry=0x0) at ../Objects/call.c:322
#22 0x0000000000437e78 in _PyObject_FastCallDict (callable=callable@entry=0x7f3668e2a058, args=args@entry=0x0, nargs=nargs@entry=0, kwargs=kwargs@entry=0x0) at ../Objects/call.c:98
#23 0x0000000000438143 in _PyObject_CallFunctionVa (callable=callable@entry=0x7f3668e2a058, format=format@entry=0x0, va=va@entry=0x7ffddeaca568, is_size_t=is_size_t@entry=0) at ../Objects/call.c:931
#24 0x00000000004383e3 in callmethod (callable=callable@entry=0x7f3668e2a058, format=format@entry=0x0, va=va@entry=0x7ffddeaca568, is_size_t=is_size_t@entry=0) at ../Objects/call.c:1027
#25 0x00000000004386eb in _PyObject_CallMethodId (obj=obj@entry=0x7f3668f57d58, name=name@entry=0x830fc0 <PyId__shutdown.17745>, format=format@entry=0x0) at ../Objects/call.c:1096
#26 0x00000000005104e8 in wait_for_thread_shutdown () at ../Python/pylifecycle.c:2246
#27 0x0000000000511a74 in Py_FinalizeEx () at ../Python/pylifecycle.c:1129
#28 0x0000000000511d9d in Py_Exit (sts=sts@entry=0) at ../Python/pylifecycle.c:2278
#29 0x000000000051a057 in handle_system_exit () at ../Python/pythonrun.c:636
#30 0x000000000051b601 in PyErr_PrintEx (set_sys_last_vars=set_sys_last_vars@entry=1) at ../Python/pythonrun.c:646
#31 0x000000000051b94e in PyErr_Print () at ../Python/pythonrun.c:542
#32 0x000000000051cac8 in PyRun_SimpleFileExFlags (fp=fp@entry=0x198eec0, filename=<optimized out>, filename@entry=0x7f3668e67750 "/home/torstein/.local/share/virtualenvs/myapp-EYf4qmw2/bin/pytest", closeit=closeit@entry=1, flags=flags@entry=0x7ffddeaca82c) at ../Python/pythonrun.c:435
#33 0x000000000051cbdf in PyRun_AnyFileExFlags (fp=fp@entry=0x198eec0, filename=0x7f3668e67750 "/home/torstein/.local/share/virtualenvs/myapp-EYf4qmw2/bin/pytest", closeit=closeit@entry=1, flags=flags@entry=0x7ffddeaca82c) at ../Python/pythonrun.c:84
#34 0x0000000000425daa in pymain_run_file (fp=0x198eec0, filename=0x1986a90 L"/home/torstein/.local/share/virtualenvs/myapp-EYf4qmw2/bin/pytest", p_cf=p_cf@entry=0x7ffddeaca82c) at ../Modules/main.c:427
#35 0x0000000000425e6a in pymain_run_filename (pymain=pymain@entry=0x7ffddeaca850, cf=cf@entry=0x7ffddeaca82c) at ../Modules/main.c:1627
#36 0x0000000000425f77 in pymain_run_python (pymain=pymain@entry=0x7ffddeaca850) at ../Modules/main.c:2877
#37 0x0000000000429571 in pymain_main (pymain=pymain@entry=0x7ffddeaca850) at ../Modules/main.c:3038
#38 0x0000000000429654 in _Py_UnixMain (argc=<optimized out>, argv=<optimized out>) at ../Modules/main.c:3073
#39 0x0000000000422e5b in main (argc=<optimized out>, argv=<optimized out>) at ../Programs/python.c:15
```

But that still didn't give me a clue as to what I should fix in *my*
program, or if it is at all possible to fix it (could it be a bug in
`pytest` or `python`?)

## Ensure your gdb version supports Python scripting

```text
$ gdb
(gdb) python print("Hello world!")
Python scripting is not supported in this copy of GDB.
```

If this is the case, you probably have `gdb-minimal` instead of `gdb`
installed. This is easily fixed with:

```text
# apt-get install gdb
```

## Get the py extensions for gdb

`gdb` must be able to source a Python file called
`python3.7-dbg-gdb.py` (changes according to the `major.minor` version
of the `python` binary).

I found it the easiest to put
`/usr/share/gdb/auto-load/usr/bin/python3.7-dbg-gdb.py` inside my
`pipenv` next to where the `python` symlink is:

```text
$ pipenv shell
$ cd $(dirname $(which python))
$ ln -s /usr/share/gdb/auto-load/usr/bin/python3.7-dbg-gdb.py
```

Now, when I started up `gdb` with:
```text
$ pipenv shell
$ gdb -p 17709 python 
```

I saw:
```text
Reading symbols from python...done.
Attaching to program: /home/torstein/.local/share/virtualenvs/myapp-EpEGAS3U/bin/python, process 17709
```

This also gave me a number of new `gdb` commands to play with,
including `py-bt`.

## Get pytest to hang
One of the challenges with this problem, was that there was no way of
making it fail at will, it just failed _sometimes_. Every 50s run or
every 150s run.

To make it fail at will, I had `bash` do it for me:
```bash
$ start=$(date +%s);
  for i in {1..161}; do
    echo "pytest run #${i}, elapsed $(( $(date +%s) - start )) seconds";
    pipenv run pytest;
  done
```

## Connect gdb to the running Python process - take 3

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

## Bonus for Emacs users

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

