title: json_xs can't locate YAML/XS.pm
date: 2023-04-25
category: linux
tags: linux, redhat, rhel

I have this YAML file that I want to convert to JSON:
```yaml
foo: bar
```

However, `json_xs` doesn't work:

```text
$ json_xs -f yaml -t json < foo.yaml
Can't locate YAML/XS.pm in @INC (you may need to install the YAML::XS
module) (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5
/usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl
/usr/lib64/perl5 /usr/share/perl5) at /usr/bin/json_xs line 187,
<STDIN> line 1.
```


To fix this on RHEL8, you need to enable the code ready repository:
```text
# subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
```

Then, you can install the missing Perl library:
```text
# dnf install perl-YAML-LibYAML
```

Now, `json_xs` works as expected:
```json
# json_xs -f yaml -t json < foo.yaml 
{"foo":"bar"}
```
