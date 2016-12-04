#!/usr/bin/env bash

if [[ ! -e /etc/nginx/ssl/server.crt || ! -e /etc/nginx/ssl/server.key ]]; then
  rm -f /etc/nginx/ssl/server.crt 
  rm -f /etc/nginx/ssl/server.key
  mkdir -p /etc/nginx/ssl

  openssl genrsa -out /etc/nginx/ssl/server-ca-key.pem 4096
  openssl req -x509 -new -key /etc/nginx/ssl/server-ca-key.pem -days 1825 -out /etc/nginx/ssl/server-ca.pem -subj '/C=US/ST=California/L=Palo Alto/O=matthias\/nginx/CN=Dangerous Root CA'
  openssl genrsa -out /etc/nginx/ssl/server-key.pem 4096
  openssl req -subj '/CN=*' -sha256 -new -key /etc/nginx/ssl/server-key.pem -out /etc/nginx/ssl/server.csr
  echo "subjectAltName = IP:127.0.0.1" > /etc/nginx/ssl/server-extfile.cnf
  openssl x509 -req -days 1825 -sha256 -in /etc/nginx/ssl/server.csr -CA /etc/nginx/ssl/server-ca.pem -CAkey /etc/nginx/ssl/server-ca-key.pem -CAcreateserial -out /etc/nginx/ssl/server.pem -extfile /etc/nginx/ssl/server-extfile.cnf
fi

if [[ ! -e /etc/nginx/ssl/dhparam.pem ]]; then
  openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048
fi

