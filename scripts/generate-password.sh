#!/bin/bash

password=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 20)

echo -n "$password" > ./config/secrets/cardano-db-sync/postgres_password