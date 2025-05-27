title: Encrypt all files in dir using GPG
date: 2025-05-27
category: unix
tags: unix, bash, security

If you have your unencrypted files in a directory "unencrypted":
```
$ find unencrypted -type f
unencrypted/foo.conf
unencrypted/secret/bar.conf
```

You can write a wee bash function like this:

```bash
## $1 :: dir with files you want to encrypt
gpg_key=your.user@example.com

encrypt_files_in_dir() {
  local dir=$1
  find "${dir}" -type f -and -not -name "*.asc" |
    while read -r f; do
      gpg --encrypt --armour --yes --recipient "${gpg_key}" "${f}"
      target_dir=$(dirname "${f}" | sed 's#/unencrypted##')
      mkdir -p "${target_dir}"
      mv "${f}".asc "${target_dir}/."
    done
}
```

Then call it with a directory holding _unencrypted_ files:
```bash
main() {
  encrypt_files_in_dir /path/to/unencrypted
}
```

This will encrypt all the files and put them in a similar structure:
```text
$ find -type f
unencrypted/foo.conf
unencrypted/secret/bar.conf
foo.conf.asc
secret/bar.conf.asc
```

Nice, eh?
