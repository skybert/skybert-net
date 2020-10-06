title: Secure Coding
date: 2020-10-06
category: security
tags: security, ssl, css, http, https, xml

Here are some of the notes I took while attending a 4 day secure
coding workshop. Even thought I've read about many of these things
before, getting hands on experience in exploiting them was a real eye
opener for me.

## Hands on hacking

[OWASP](https://owasp.org) has created [a container you can run and
hack](https://owasp.org/www-project-secure-coding-dojo/), exploiting
the most common web app vulnerabilities. A good accompanying [slide
deck explaining these
techniques](https://github.com/trendmicro/SecureCodingDojo/tree/master/workshop)
is also available.

Through these tasks in the dojo, you get to learn and exploit several
of the [CWE Top
25](https://cwe.mitre.org/top25/archive/2020/2020_cwe_top25.html)
vulnerabilities.

## SSL is secure, right?
- [DEF CON 17 - Moxie Marlinspike - More Tricks for Defeating SSL](https://www.youtube.com/watch?v=5dhSN9aEljg_)
- [DEF CON 19 - Moxie Marlinspike - SSL And The Future Of Authenticity](https://www.youtube.com/watch?v=UawS3_iuHoA)

### SSL strip
[sslstrip](https://github.com/moxie0/sslstrip) is a tool that exploits
the fact that many users connect to the `http` version of the website
first before they're redirected by the web server to the `https`
version.

To protect against sslstrip attacks, use we can use [HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security)

## Passwords
You can [gauge how long it'll take to crack your
password](https://howsecureismypassword.net/) by visiting this website
and enter your password.

tl;dr:

> I love sugar drinks and cupcakes

can be more secure than

> so#$%efoR

### Common passwords

[Rainbow tables](https://en.wikipedia.org/wiki/Rainbow_table) are
pre-generated hashes using the most popular algorithms. This means
that if you have the hash of a password, but not the password itself,
you can search the [Rainbow
tables](https://en.wikipedia.org/wiki/Rainbow_table) using [this
website](https://crackstation.net/) to get the password.

The way to mitigate this, is to use a
[salt](https://en.wikipedia.org/wiki/Salt_(cryptography)) so that the
hashes differ, even for the same password.

As for the most common passwords, [The
Register](https://www.theregister.com) has an interesting [article
about the most common passwords
here](https://www.theregister.com/2010/01/21/lame_passwords_exposed_by_rockyou_hack/)

### Store salt and hash together

[auth0.com](https://auth0.com) says we should have a salt per hash,
and store these together in the db:

> In practice, we store the salt in cleartext along with the hash in our
> database. We would store the salt f1nd1ngn3m0, the hash
> 07dbb6e6832da0841dd79701200e4b179f1a94a7b3dd26f612817f3c03117434, and
> the username together so that when the user logs in, we can lookup the
> username, append the salt to the provided password, hash it, and then
> verify if the stored hash matches the computed hash.

```
| username | salt     | hash               |
+----------+----------+--------------------+
| john     | jkbPo$#% | acbd18db4cc2f85ced |
```

See [the auth0.com
article](https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/)
for further details.

## Further reading
- [Smashing The Stack For Fun And Profit](http://phrack.org/issues/49/14.html)
- [Bug hunting bounties](https://www.hackerone.com/)
- [Certificate pinning](https://www.digicert.com/blog/certificate-pinning-what-is-certificate-pinning/)
- [XSS filter evasion cheatsheet](https://owasp.org/www-community/xss-filter-evasion-cheatsheet)
- [CSS injection]( https://owasp.org/www-project-web-security-testing-guide/v41/4-Web_Application_Security_Testing/11-Client_Side_Testing/05-Testing_for_CSS_Injection)
- Book recommendation: [The Web Application Hacker's Handbook : Finding
  and Exploiting Security Flaws](https://archive.org/details/TheWebApplicationHackersHandbook2ndEdition/page/n9/mode/2up)
- [inject code in a buffer overflow](https://en.wikipedia.org/wiki/NOP_slide)
- [burp suite](https://portswigger.net/burp)
- [MySpace XSS worm](https://en.wikipedia.org/wiki/Samy_(computer_worm))

