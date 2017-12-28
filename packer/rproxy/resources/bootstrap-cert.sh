#!/usr/bin/env bash

sleep $((40 + ($RANDOM % 30)))

while [ -f /var/run/certbot-is-running ]; do
  sleep 1;
done

touch /var/run/certbot-is-running
certbot certonly --test-cert --agree-tos --register-unsafely-without-email -n --standalone --preferred-challenges http -d $1

rm -f /var/run/certbot-is-running
