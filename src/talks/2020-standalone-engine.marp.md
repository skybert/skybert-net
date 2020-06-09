

# Standalone Content Store

— by [tkj@stibodx]()

---

# Also known as

- Content Store as a micro service
- Self contained Content Store

---

# Why?

- No dependency on external app server
- Docker & OpenShift friendly
- Can ship more conf defaults
- Less to document
- We can optimise the embedded app server 
- No bugs because the customer used version `1.2.3` of Tomcat and
  we've only tested `1.2.2`

---

# Goals

- Great DX experience
- Installation as simple as:

```text
# apt install cue-content-store
$ ece start                          # could even be omitted 🤔
```

- Easier to upgrade
- Same URIs as before (a bit of work since our services are a mix)

---

# Using it

```text
$ java -jar engine-<ver>.jar server engine.yaml
```

Configure it in `/etc/escenic/engine` as usual.

---

# Details

- Use slf4j instead of log4j
- Wrap all services in DW services

---

# Pros and cons of an engine micro service

---

# Pros

- :+1: Customers can't add their own Java code
- :+1: Can't add other webapps in the same app server as where Content
  Store runs.

---

# Cons

- :-1: Customers can't add their own Java code
- :-1: Can't add other webapps in the same app server as where Content
  Store runs.

---

# When can I have it?

- Must add auth
- Must wrap all our services
- Should be introduced as a supplement to the current ECE
  distribution, not a replacement. At least not yet.
- Estimated work left: 4 weeks
---

# Show me the code

```text
feature/VF-8976-self-contained-content-store
```

---

# Cheers!

Feedback welcome → [@skybert]()
