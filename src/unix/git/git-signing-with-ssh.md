title: Git Signing with SSH
date: 2022-11-09
category: vcs
tags: git, ssh, security


## Why sign your commits?

<img
  class="centered"
  src="/graphics/2022/supply-chain.png"
  alt="supply chain"
/>


## What we want

<img
  class="centered"
  src="/graphics/2022/github-verified.png"
  alt="github verified"
/>


## How to verify a commit?

```text
$ git verify-commit 54d75d3d5992bdbd5ddb5a5f6a12bd7ba1dc747d
Good "git" signature with ED25519 key SHA256:lyOfOeV7C0s0ygnRgkSd4S8LVC4mkoPmRvlLdcvWOzM
No principal matched.
```

```text
$ git verify-tag v1.2.3-4 
```

## Can anyone sign a commit?

```text
$ cat ~/.ssh/allowed_signers
```

## Verify committs of a release

```bash
git log --oneline ${source_rev}..${target_rev} |
  awk '{ print $1}') |
  while read -r commit; do
    git verify-commit ${commit}
  done
```

## Delve further

- Github: [about commit signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- Github: [displaying verification statuses for all of your commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/displaying-verification-statuses-for-all-of-your-commits)
- Github: [telling git about your ssh key](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-ssh-key)
- `man ssh-keygen`: [ALLOWED_SIGNERS](https://man7.org/linux/man-pages/man1/ssh-keygen.1.html#ALLOWED_SIGNERS)
- Blog: [git ssh signatures](https://blog.dbrgn.ch/2021/11/16/git-ssh-signatures/)
