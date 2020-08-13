title: Kubernetes CLI on Debian
date: 2020-08-13
category: linux
tags: linux, containers, kubernetes

## Getting the kubectl command

```text
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |
  apt-key add -
# echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" |
  tee -a /etc/apt/sources.list.d/kubernetes.list
# apt-get update
# apt-get install kubectl
```

## kubectl auto completion for ZSH

I don't use
 [oh-my-zsh](https://twitter.com/torsteinkrause/status/1268163616932605970),
 so I do this manually.
 
First, create the auto completion file:
```text
$ kubectl completion zsh > ~/.zsh/kubectl-completion.zsh
```

Then load it from `.zshrc`:
```conf
source ~/.zsh/kubectl-completion.zsh
```

That's it, enjoy using `kubectl`!
