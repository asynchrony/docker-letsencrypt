#!/bin/bash

set -e

while true
do
  aws s3 cp s3://${S3_BUCKET}/domains.txt /var/letsencrypt/domains.txt
  aws s3 sync s3://${S3_BUCKET}/certs /var/letsencrypt/certs --exact-timestamps --delete
  /var/letsencrypt/letsencrypt.sh --cron
  aws s3 sync /var/letsencrypt/certs s3://${S3_BUCKET}/certs --exact-timestamps --delete
  sleep ${RUN_INTERVAL}
done
