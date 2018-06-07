title: CUE Content Store
date: 2018-05-24
category: escenic
tags: escenic, cue

> I've got ECE & CUE without sse-proxy: I can log into CUE, but I get
> an HTTP auth challenge for the web service. Why is this?

Content Engine's SSE endpoint is protected using the standard auth
mechanisms.  However, CUE and most browsers don't allow us to add auth
headers or anything at all to the sse request.  The SSE Proxy, however
has no authentication but adds authentication requests when it makes
requests to the backend(s) it has.

If ECE is not configured to let its client know where to find the
proxy, ECE will fallback to it's own password protected sse stream
