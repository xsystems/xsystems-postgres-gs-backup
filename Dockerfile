FROM xsystems/postgres-gsutil:1.0.0

ENV PGPASSFILE=/run/secrets/.pgpass \
    POSTGRES_GS_BACKUP_INTERVAL="0 7,19 * * *" \
    POSTGRES_HOST=172.18.0.1 \
    POSTGRES_PORT=5432 \
    POSTGRES_USER=postgres

COPY entrypoint.sh \
     postgres-database-exists.sh \
     postgres-gs-backup.sh \
     /

ENTRYPOINT [ "sh", "-c" ]

CMD [ "/entrypoint.sh" ]
