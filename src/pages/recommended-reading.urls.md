## 2017

### Code
http://www.catb.org/esr/faqs/things-every-hacker-once-knew/

The famous spelling mistake in the HTTP/1.0 specification, `Referer`
instead of `Referrer` is blamed on the UNIX spell checker not having
neither of them in its dictionary at the time they wrote the
RFC. Check out this nugget from 1995:
https://lists.w3.org/Archives/Public/ietf-http-wg-old/1995JanApr/0107.html

http://www.se-radio.net/

https://writing.kemitchell.com/2017/03/29/OSS-Business-Perception-Report.html

### Linux & Unix
http://www.androidauthority.com/what-is-virtual-memory-gary-explains-747960/
https://learntemail.sam.today/blog/selinux-concepts-but-for-humans/
https://www.redhat.com/en/about/blog/do-we-really-need-swap-modern-systems
https://danielmiessler.com/study/tcpdump/
http://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/

Servers can run out of entropy (randomness needed to complete various
tasks such as JAR signing, SSL connections), one way to mitigate this
is to install `haveged`:
http://www.issihosts.com/haveged/downloads.html

#### Containers
Docker provides a great developer experience but it leaves many things
to be decided when it comes to taking it into production:
https://www.federacy.com/docker_image_vulnerabilities
https://www.certdepot.net/death-of-docker/

Really interesting to see what's moving in the container world. RedHat
is really shaking things up in the Docker world:
https://www.youtube.com/watch?v=2v-vTH71nSc

https://thehftguy.com/2017/02/23/docker-in-production-an-update/

https://consolia-comic.com/comics/containers-and-docker

Interesting read on containers and challenges of sharing a kernel in
spite of namespace & cgroups:
https://sysdig.com/blog/container-isolation-gone-wrong/

#### Reverse proxies 

Finally got around to upgrade from Varnish 3 to 4. The folks at
Varnish Software have been so nice to provide an upgrade guide which,
albeit not a complete guide, is a good starting point:
https://varnish-cache.org/docs/4.0/whats-new/upgrading.html

https://www.fastly.com/blog/varnish-tip-normalize-host-header
https://www.fastly.com/blog/ab-testing-edge

nginx can do TCP load balancing now, making it an alternative to
HAProxy in my setup:
https://serversforhackers.com/tcp-load-balancing-with-nginx-ssl-pass-thru

### Windows
An interesting extension to Cygwin: 
http://babun.github.io/

### JS
http://podefr.tumblr.com/post/30488475488/locally-test-your-npm-modules-without-publishing

### People
https://developers.redhat.com/blog/2017/04/07/working-with-a-dispersed-team-part-5-of-7/


### Fun
http://patorjk.com/software/taag/

---

## 2016

### Linux & Unix
https://www.youtube.com/watch?v=tc4ROCJYbm0
https://www.cyberciti.biz/faq/how-to-speed-up-apt-get-apt-command-ubuntu-linux/
https://www.youtube.com/watch?v=o5cASgBEXWY
https://thehftguy.com/2016/11/01/docker-in-production-an-history-of-failure/

Excellent live coding video spelling out in big letters what
containers really are (tarballs). They're *not* the same thing a s
virtual macines 😉
https://www.youtube.com/watch?v=gMpldbcMHuI

### Life
http://nymag.com/selectall/2016/09/andrew-sullivan-technology-almost-killed-me.html

### JS
https://snyk.io/

This article made me laugh out loud, making everyone in the metro car
think I was nuts 😉:
https://hackernoon.com/how-it-feels-to-learn-javascript-in-2016-d3a717dd577f

---

## 2015

### Linux & Unix
https://www.rileybrandt.com/2015/10/15/foss-photo-flow-2015/

### Network
https://www.youtube.com/watch?v=C8orjQLacTo

### Database
https://mathiasbynens.be/notes/mysql-utf8mb4

### Games
http://grumpygamer.com/monkey25

### Various
https://backchannel.com/why-i-m-saying-goodbye-to-apple-google-and-microsoft-78af12071bd
http://www.gq.com/story/president-obama-bill-simmons-interview-gq-men-of-the-year

### Language
https://www.babbel.com/en/magazine/139-norse-words

---

## 2014

### Politics
http://www.economist.com/news/leaders/21608752-any-ceasefire-will-be-temporary-unless-israel-starts-negotiating-seriously

---

## 2013

http://blog.vivekhaldar.com/post/40018875700/scaling-communication-email-vs-shared-documents

---

## 2010

### Code
http://nvie.com/posts/a-successful-git-branching-model/

---

## 2008

### Coding

[Steve Yegge](http://steve-yegge.blogspot.com) is as always dead
on. This post explains why every coder worth his or her salt should
learn to type:
http://steve-yegge.blogspot.com/2008/09/programmings-dirtiest-little-secret.html
