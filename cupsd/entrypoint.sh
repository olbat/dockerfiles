#!/usr/bin/env bash
set -eu

if [ "${LPADMIN_USER}" = 'lpadmin' ]; then
    echo "You can't use lpadmin as your username"
    exit 1
fi

useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/"$LPADMIN_USER" \
  --shell=/bin/bash \
  --password=$(mkpasswd "$LPADMIN_PASSWORD") \
  "$LPADMIN_USER" \
  && echo "Created user $LPADMIN_USER"

set -x
/usr/sbin/cupsd -F 
