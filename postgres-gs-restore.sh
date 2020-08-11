#!/bin/sh

set -e
set -o pipefail

createdb ${POSTGRES_CONNECTION_DETAILS} --template template1 ${POSTGRES_DATABASE}

gsutil cat gs://${GCP_BUCKET}/${POSTGRES_DATABASE_BACKUP_NAME} \
  | gunzip \
  | psql ${POSTGRES_CONNECTION_DETAILS} ${POSTGRES_DATABASE}
