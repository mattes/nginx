FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean

ADD nginx.conf /etc/nginx/nginx.conf
ADD generate-nginx-certs.sh /usr/local/bin/

RUN mkdir -p /var/www
WORKDIR /var/www

EXPOSE 80 443

CMD generate-nginx-certs.sh && nginx

