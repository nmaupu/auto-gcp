#!/usr/bin/env bash

DOMAINS="$1"
CMD_DOMS=""
for dom in $(echo ${DOMAINS} | tr -s "," " "); do
  CMD_DOMS="${CMD_DOMS} -d ${dom}"
done

sudo certbot certonly --agree-tos --register-unsafely-without-email -n --standalone --expand --preferred-challenges http ${CMD_DOMS}
sudo systemctl reload nginx
