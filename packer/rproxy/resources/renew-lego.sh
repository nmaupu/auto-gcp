#!/usr/bin/env bash

set -e
LEGO_PATH=/etc/lego
SERVER=${SERVER:-https://acme-v02.api.letsencrypt.org/directory}
DAYS=15
EMAIL=@@LE_EMAIL_ADDRESS@@
WEBROOT=/var/www/acme

find ${LEGO_PATH}/certificates -name "*.json" | while read -r conf_file; do
  dom=$(jq -r .domain ${conf_file})
  #GCE_PROJECT=$(gcloud config list --format 'value(core.project)') \
    /usr/local/bin/lego \
    --server ${SERVER} \
    --email ${EMAIL} \
    --path ${LEGO_PATH} \
    --domains ${dom} \
    --http \
    --http.webroot ${WEBROOT} \
    renew --days ${DAYS}
done
