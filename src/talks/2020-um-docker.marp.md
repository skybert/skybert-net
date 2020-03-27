
# Up and running with User Manager & Keycloak in 5 minutes

- by [tkj@stibodx.com](mailto:tkj@stibodx.com)

---

## When you just want something that works - quick

- Development
- Testing
- Demo

---

## Up and running in 4 steps

- First with slides
- Then with live code

---

## #1 - Install UM & Keycloak cluster

```text
# apt-get install cue-user-manager-docker-1.1
# vim /etc/escenic/user-manager/um-cluster.conf
# um-cluster start
```

---

## #2 - Set a web server in front (HTTP is fine)

```text
# vim /etc/nginx/sites-available/um
```


```perl
server {
  listen 80;
  server_name um.argon;
  location / {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://172.18.0.100:8680;
    proxy_buffer_size          128k;
    proxy_buffers              4 256k;
    proxy_busy_buffers_size    256k;
  }
}
server {
  listen 80;
  server_name keycloak.argon;
  location / {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://172.18.0.200:8080;
    proxy_buffer_size          128k;
    proxy_buffers              4 256k;
    proxy_busy_buffers_size    256k;
  }
}
```

--- 

## #2 - Set a web server in front (HTTP is fine)

```
# ln -s /etc/nginx/sites-available/um /etc/nginx/sites-enabled/um
# systemctl reload nginx
```

---

## #3 - Configure Content Store

```text
# vim /etc/escenic/engine/common/com/escenic/auth/um/UMConfiguration.properties
```

```conf
serviceEnabled=true
apiURI=http://um.argon/openapi.json
```

```text
$ ece restart
```

---

## #4 - Configure CUE editor

In case you have any SSO conf, remove it:

```text
# vim /etc/escenic/cue-web/oauth.yml
# dpkg-reconfigure cue-web
```

---

## #5 - /etc/hosts

```text
10.186.38.160   argon
10.186.38.160   proxy.argon
10.186.38.82    keycloak.argon
10.186.38.82    um.argon
```

---

## Your very own UM & IAM system

- User Manager: [http://um.argon/openapi.json](http://um.argon/openapi.json)
- User Manager in Content Store: [http://argon:8080/escenic-admin/browser/Global/com/escenic/auth/um/UMConfiguration](http://argon:8080/escenic-admin/browser/Global/com/escenic/auth/um/UMConfiguration)
- IAM/Keycloak: [http://keycloak.argon/](http://keycloak.argon/)
- CUE editor: [http://argon/cue-web](http://argon/cue-web/#/Login)

---

## That's it!
