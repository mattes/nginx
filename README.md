nginx
=====

nginx image used for debugging purposes.

fugu.yaml

```
image: mattes/nginx
name: foobar
detach: true
volume:
  - $PWD:/www-data
publish:
  - 9090:80
```


Minimal Nginx Conf

```
http {
    include /etc/nginx/mime.types;
    server {
        listen 80;
        location / {
            root /www-data/build;
        }
    }
}
```