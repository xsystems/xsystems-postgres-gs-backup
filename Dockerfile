FROM postgres:12.3-alpine

RUN apk add --no-cache \
      gcc \
      libffi-dev \
      musl-dev \
      openssl-dev \
      python3-dev \
      py3-pip \
      py3-setuptools \
      py3-wheel \
 && pip install gsutil

ENV PGPASSFILE=/run/secrets/.pgpass \
    POSTGRES_GS_BACKUP_INTERVAL="0 7,19 * * *" \
    POSTGRES_HOST=172.18.0.1 \
    POSTGRES_PORT=5432 \
    POSTGRES_USER=postgres

COPY start.sh \
     postgres-database-exists.sh \
     postgres-gs-backup.sh \
     postgres-gs-restore.sh \
     /

ENTRYPOINT [ "sh", "-c" ]

CMD [ "/start.sh" ]
