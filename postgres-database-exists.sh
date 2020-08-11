#!/bin/sh

set -e
set -o pipefail

if [ "`psql ${POSTGRES_CONNECTION_DETAILS} --tuples-only --no-align --command "SELECT 1 FROM pg_database WHERE datname='${POSTGRES_DATABASE}'" template1`" = '1' ]; then
    exit 0
else
    exit 1
fi
