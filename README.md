nginx
=====

quick nginx serving via http2

```
docker build -t mattes/nginx .
docker push mattes/nginx

docker run --name project123 -d -v $PWD:/var/www -p 8443:443 mattes/nginx
open https://localhost:8443/
```

