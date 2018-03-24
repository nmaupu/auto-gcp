#!/usr/bin/env bash

# Detect and format/mount extra disk to /etc/lego for storing certs
# If FS is already formatted, don't reformat
# If script has already been executed, do not execute again

set -e

WITNESS_FILE=/usr/local/startup-script-ok

[ -e ${WITNESS_FILE} ] && exit 0

if DISK_NAME=$(curl -H 'Metadata-Flavor: Google' http://metadata.google.internal/computeMetadata/v1/instance/disks/1/device-name); then
  eval $(blkid /dev/disk/by-id/google-${DISK_NAME} | awk ' { print $3 } ') # TYPE var contains fs type oris empty
  if [ "${TYPE}" != "xfs" ]; then
    echo "Formatting /dev/disk/by-id/google-${DISK_NAME}"
    mkfs.xfs /dev/disk/by-id/google-${DISK_NAME}
  fi

  if ! grep -q ${DISK_NAME} /etc/fstab ; then
    echo "/dev/disk/by-id/google-${DISK_NAME} /etc/lego xfs defaults,noatime 0 0" >> /etc/fstab
  fi
  mkdir -p /etc/lego && mount /etc/lego
  systemctl restart nginx
  touch ${WITNESS_FILE}
fi
