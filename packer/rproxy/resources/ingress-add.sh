#!/usr/bin/env bash

DOMAINS="$1"
TIMEOUT=600
LEGO_PATH=/etc/lego
EMAIL=@@LE_EMAIL_ADDRESS@@
SERVER=${SERVER:-https://acme-v02.api.letsencrypt.org/directory}
WEBROOT=/var/www/acme

CMD_DOMS=""
for dom in $(echo ${DOMAINS} | tr -s "," " "); do
  CMD_DOMS="${CMD_DOMS} --domains ${dom}"
done

#sudo GCE_PROJECT=$(gcloud config list --format 'value(core.project)') \
  sudo /usr/local/bin/lego \
  --server ${SERVER} \
  --email ${EMAIL} \
  --path ${LEGO_PATH} \
  --accept-tos \
  ${CMD_DOMS} \
  --http \
  --http.webroot ${WEBROOT} \
  run

sudo systemctl restart nginx
