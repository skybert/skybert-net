title: X Related Java Problems
date:    2013-05-07
category: java
tags: x11, linux

## Failed to retrieve atom name.

If you're getting this odd bugger when launching Java
applications on your Linux machine:

```
Caused by: java.lang.NullPointerException: Failed to retrieve atom name.
  at sun.awt.X11.XlibWrapper.XGetAtomName(Native Method)
  at sun.awt.X11.XAtom.getName(XAtom.java:169)
  at sun.awt.X11.XDataTransferer.getTargetNameForAtom(XDataTransferer.java:123)
  at sun.awt.X11.XDataTransferer.getNativeForFormat(XDataTransferer.java:112)
  at sun.awt.datatransfer.DataTransferer.getFlavorsForFormatsAsSet(DataTransferer.java:845)
  at sun.awt.datatransfer.SunClipboard.formatArrayAsDataFlavorSet(SunClipboard.java:333)
  at sun.awt.datatransfer.SunClipboard.addFlavorListener(SunClipboard.java:361)
```


It's because of some <a
href="http://bugs.sun.com/bugdatabase/view_bug.do?bug_id=6322854">buggy
Sun/Oracle code</a> in the way JRE makes assumptions regarding the
window manager in which Java runs. More specifically, it's the
clipboard which confuses JRE here.

I got around this error by first disabling my current clipboard
manager and then start another one. This seemed to clean the clipboard
slate and thereby kicked Java/Swing into working again.

    $ killall clipit
    $ xclipboard &

If you're an application developer, you might
want to catch the NullPointer above where you call
```sun.awt.datatransfer.SunClipboard#addFlavorListener```

For your interest, I bumped into this bugger when running <a
href="http://www.vizrt.com/products/escenic_content_studio/">Escenic
Content Studio 5.3</a> on <a href="http://debian.org">Debian
Squeeze</a> using the <a href="http://kernel.org">Linux kernel
3.2.0</a> and the <a href="http://x.org">X.org 7.7 display server</a>
and the <a href="http://fluxbox.org">Fluxbox 1.3.2</a> window
manager. The full stack trace in my case was:

```
Caused by: java.lang.NullPointerException: Failed to retrieve atom name.
  at sun.awt.X11.XlibWrapper.XGetAtomName(Native Method)
  at sun.awt.X11.XAtom.getName(XAtom.java:169)
  at sun.awt.X11.XDataTransferer.getTargetNameForAtom(XDataTransferer.java:123)
  at sun.awt.X11.XDataTransferer.getNativeForFormat(XDataTransferer.java:112)
  at sun.awt.datatransfer.DataTransferer.getFlavorsForFormatsAsSet(DataTransferer.java:845)
  at sun.awt.datatransfer.SunClipboard.formatArrayAsDataFlavorSet(SunClipboard.java:333)
  at sun.awt.datatransfer.SunClipboard.addFlavorListener(SunClipboard.java:361)
  at org.jdesktop.application.TextActions.&lt;init&gt;(TextActions.java:65)
  at org.jdesktop.application.ActionManager$KeyboardFocusPCL.&lt;init&gt;(ActionManager.java:184)
  at org.jdesktop.application.ActionManager.initProxyActionSupport(ActionManager.java:109)
  at org.jdesktop.application.ActionManager.getActionMap(ActionManager.java:102)
  at org.jdesktop.application.ActionManager.getActionMap(ActionManager.java:174)
  at org.jdesktop.application.ApplicationContext.getActionMap(ApplicationContext.java:303)
  at com.escenic.swing.application.DefaultUndoManager.&lt;init&gt;(DefaultUndoManager.java:52)

```

