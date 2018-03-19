#!/usr/bin/env bash

DOMAINS="$1"
TIMEOUT=600
LEGO_PATH=/etc/lego
EMAIL=@@LE_EMAIL_ADDRESS@@
SERVER=${SERVER:-https://acme-v01.api.letsencrypt.org/directory}

CMD_DOMS=""
for dom in $(echo ${DOMAINS} | tr -s "," " "); do
  CMD_DOMS="${CMD_DOMS} --domains ${dom}"
done

sudo GCE_PROJECT=$(gcloud config list --format 'value(core.project)') \
  /usr/local/bin/lego \
  --server ${SERVER} \
  --dns gcloud \
  --email ${EMAIL} \
  --path ${LEGO_PATH} \
  --accept-tos --dns-timeout ${TIMEOUT} \
  ${CMD_DOMS} \
  run

sudo systemctl reload nginx
