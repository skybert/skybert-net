title: Investigating Emacs CPU Usage
date: 2015-05-14

I'm using [emacs-eclim](https://github.com/senny/emacs-eclim) for
programming Java. It gives me a lot of
[the goodness from Eclipse](http://skybert.net/emacs/java/), including
true auto completion and highlighting of warnings and errors in the
buffer. However, I've found that sometimes it's close to unusuable
because it consumes too much CPU and hangs for several seconds (~8 in
my last case) before doing what I told it to.

Today, I thought I'd get to the bottom of this, and I ventured on my
first adventure with
[the Emacs native profiler](http://www.emacswiki.org/emacs/EmacsNativeProfiler)
and it was surprisingly *easy* to use!

First, I started the profiler with `M-x profiler-start`, then I did
what was the probblem in eclim, namely opening a Java file with lots
of errors. Once it was done hogging my CPU (100% for 5-8 seconds,
thank you very much), I asked the profiler to give me the function
calls that were generating CPU load by issuing `M-x profiler-report`:

```
- command-execute                                                3122  84%
 - call-interactively                                            3122  84%
  - apply                                                        3122  84%
   - ad-Advice-call-interactively                                3122  84%
    - #<subr call-interactively>                                 3122  84%
     - Buffer-menu-this-window                                   2734  73%
      - switch-to-buffer                                         2734  73%
       - apply                                                   2734  73%
        - ad-Advice-switch-to-buffer                             2734  73%
         - eclim-problems-highlight                              2734  73%
          - remove-if-not                                        2701  73%
           - apply                                               2701  73%
            - cl-remove                                          2701  73%
             - apply                                             2697  72%
              - cl-delete                                        2693  72%
               - #<compiled 0x1586729>                           2693  72%
                - file-truename                                  2641  71%
                 - file-truename                                 2420  65%
                  - file-truename                                2295  62%
[..]
```

As you can see, it's the `eclim-problems-highlight` method which is
the culprit and its call to `file-truename`. You can also see that
there's some kind of looping going on from the `#<compiled 0x1586729>`
as `file-truename` is constantly being called.

With that out of the way, I checkout the source code for emacs-eclim
and localed the function `eclim-problems-highlight`. A quick `git
annotate` later, I've found who made the change when and, most
importantly, why the developer made it. I also asked Emacs to tell me
what `file-truename` does with `C-h f file-truename`. So, it's code
that's there to resolve any symlinks present in the path to the source
code file we're looking at.

I now tried to remove the call to `file-truename` to see if it would
improve performance. And what a difference it made! CPU usage went
down to normaly levels, seldomly rising above 5% and Emacs managed to
open Java files instantly without any lag or hang. Big success as far
as I'm concerned :-)

I've
[made a fix to emacs-eclim](https://github.com/skybert/emacs-eclim/commit/0a36e29e1d1dd4863e38525c9f9f77722363e6ba),
but I'm not sure if this is something the maintainers of emacs-eclim
wants merged. Nevertheless, this was a great lesson for me on how to
investigate performance issue in Emacs and I can now use Emacs/eclim
for projects than before. Yeah!

