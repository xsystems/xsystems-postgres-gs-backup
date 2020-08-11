#!/bin/sh

set -e
set -o pipefail

pg_dump ${POSTGRES_CONNECTION_DETAILS} ${POSTGRES_DATABASE} \
  | gzip \
  | gsutil cp - gs://${GCP_BUCKET}/${POSTGRES_DATABASE_BACKUP_NAME}
