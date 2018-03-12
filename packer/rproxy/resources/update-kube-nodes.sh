#!/usr/bin/env bash

NODES=$(gcloud compute instances list --filter="gke-*" --format=json | jq -r '.[].networkInterfaces | .[].networkIP')
PORT=@@PORT@@
FILE=/etc/nginx/kube-nodes.inc

echo -n "" > ${FILE}
for node in ${NODES}; do
  echo "server ${node}:${PORT};" >> ${FILE}
done

systemctl reload nginx
[ $? -ne 0 ] && systemctl restart nginx
