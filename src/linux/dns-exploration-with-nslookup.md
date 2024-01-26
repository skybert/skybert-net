title: DNS & server exploration from the command line
date: 2023-08-18
category: linux
tags: linux, network, dns

## Most common use case

Which IPv4 addresses does this domain answer to?
```text
$ nslookup -type=A vg.no
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	vg.no
Address: 195.88.55.16
Name:	vg.no
Address: 195.88.54.16
```

If you want to see the IPv6 addresses, specify `AAAA` instead:
```text
$ nslookup -type=AAAA vg.no
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
Name:	vg.no
Address: 2001:67c:21e0::16
```


## See what mail provider the company is using
```text
$ nslookup -type=MX vg.no
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
vg.no	mail exchanger = 5 alt2.aspmx.l.google.com.
vg.no	mail exchanger = 10 alt3.aspmx.l.google.com.
vg.no	mail exchanger = 10 alt4.aspmx.l.google.com.
vg.no	mail exchanger = 1 aspmx.l.google.com.
vg.no	mail exchanger = 5 alt1.aspmx.l.google.com.

Authoritative answers can be found from:
```

## The TXT records may hold interesting info

```text
$ nslookup -type=TXT vg.no
;; Truncated, retrying in TCP mode.
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
vg.no	text = "fastly-domain-delegation-29tfXEmvnByNT8JY-442665-2021-10-26"
vg.no	text = "google-site-verification=1pgyIHHF6q_XtdnSiBJFZiJrXtcg-vpNdfWzhJtb8pM"
vg.no	text = "google-site-verification=CvJrFeKFUvWtMd11AkMfLIwBCKnMr2e4f6dzowPw32A"
vg.no	text = "google-site-verification=uRwOU1tXpvCsRXnHyApK_yaMeXiTmni8cIW2KelXWO8"
vg.no	text = "v=spf1 include:_u.vg.no._spf.smart.ondmarc.com include:amazonses.com ~all"
vg.no	text = "YbAMQjB2yzXf6DTU9dR9LYMQNGptykV9gN251w0knS5h2Iu4Nhk9kw6s1nzmgOCFnvxo/lekGs1PSCy3Z3oXAA=="
vg.no	text = "wiz-domain-verification=52455ec02f13dfe89b5827fd5085e7ab8e918767f8461a2f5b443b5e0dd6cd56"
vg.no	text = "MS=ms58603718"
vg.no	text = "docker-verification=ab84c6ca-d2b1-4aca-a2b4-e39155b6c1bd"
vg.no	text = "miro-verification=eff9412c1aa1655d0a279f7d6704841b6a02b591"

Authoritative answers can be found from:
```

## dig

Another great tool is `dig`.

Here, I want to ask [Cloudflare](cloudflare.com)'s DNS (`1.1.1.1`),
what mail server handles [vg](vg.no)'s email:

```text
$ dig @1.1.1.1 vg.no MX

; <<>> DiG 9.18.18 <<>> @1.1.1.1 vg.no MX
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 24222
;; flags: qr rd ra; QUERY: 1, ANSWER: 5, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;vg.no.				IN	MX

;; ANSWER SECTION:
vg.no.			300	IN	MX	5 alt2.aspmx.l.google.com.
vg.no.			300	IN	MX	10 alt3.aspmx.l.google.com.
vg.no.			300	IN	MX	10 alt4.aspmx.l.google.com.
vg.no.			300	IN	MX	1 aspmx.l.google.com.
vg.no.			300	IN	MX	5 alt1.aspmx.l.google.com.

;; Query time: 26 msec
;; SERVER: 1.1.1.1#53(1.1.1.1) (UDP)
;; WHEN: Fri Aug 18 14:38:15 CEST 2023
;; MSG SIZE  rcvd: 152

```

## DNS dumpster

It's not on the command line, but [extremely cool](https://dnsdumpster.com).

<img
  class="centered"
  src="https://dnsdumpster.com/static/map/skybert.net.png"
  alt="dnsdumpster of skybert.net"
/>

## Shodan

I would normally use `curl` for gathering web server and TLS
certificate info, but there's a website (well, probably many) that
does this for you:

[shodan.io/search?query=skybert.net](https://www.shodan.io/search?query=skybert.net)

The `curl` command I'd use is:

```text
$ curl -v https://skybert.net 2>&1 | \grep -E '(subjectAltName|server|issuer):'
*  subjectAltName: host "skybert.net" matched cert's "skybert.net"
*  issuer: C=US; O=Let's Encrypt; CN=R3
< server: nginx
```
