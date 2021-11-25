title: List All Configured Passwords and Secrets in Jenkins
date: 2021-10-08
category: java
tags: java, security, jenkins


Sometimes, like when you want to migrate an old Jenkins to a new one
and you don't know or remember all the configured passwords, secrets
and signing keys, there's a simple way to get them.

First, log in to Jenkins, then head over to
`https://jenkins.example.com/script`

In the text area, you can enter Groovy code and to get all the stored
secrets, you can enter:

```java
com.cloudbees.plugins.credentials.SystemCredentialsProvider
.getInstance()
.getCredentials()
.forEach {
  println it.dump().replace(' ', '\n')
}
```

That's it, you can now got all the credentials. For secrets, like
private SSH keys, you'll need to inspect the specific objects further
(or in general, anything that doesn't have a sane `toString()` method
that `dump()` calls, like:

```text
privateKeySource=com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$DirectEntryPrivateKeySource@739ab83
```

If you don't have login access to Jenkins, but Unix access to the
machine it's running on, you can instead poke in `/proc/<pid>` when a
job using one of the credentials you're interested in. You can then
see all the environment variables it has access to with:

```text
$ cat /proc/<pid>/environ | tr '\0' '\n'
```

Happy snooping!

