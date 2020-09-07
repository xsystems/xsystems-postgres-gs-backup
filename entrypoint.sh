#!/bin/sh

export POSTGRES_DATABASE_BACKUP_NAME=${POSTGRES_DATABASE}.gz
export POSTGRES_CONNECTION_DETAILS="--host ${POSTGRES_HOST} --port ${POSTGRES_PORT} --username ${POSTGRES_USER}"

./init-gsutil.sh

gsutil versioning set on gs://${GCP_BUCKET}/

if [ -z "$@" ]; then
  if ./postgres-database-exists.sh; then
    ./postgres-gs-backup.sh
  fi

  echo "${POSTGRES_GS_BACKUP_INTERVAL} /postgres-gs-backup.sh" | crontab -

  exec crond -f
else
  exec "$@"
fi
