#!/bin/bash

if [[ -z "$1" ]]; then
	echo "missing network. first argument must be [mainnet|preprod]"
	exit -1
fi &&

if [[ -s config/secrets/cardano-db-sync/postgres_password ]]
then
     echo "Password is set"
else
     echo "Please generate a password first, use:"
     echo "./scripts/generate-password.sh" 
     exit 0
fi

TOKEN_REGISTRY_GIT_REPO=https://github.com/cardano-foundation/cardano-token-registry
TOKEN_REGISTRY_GIT_BRANCH=master
TOKEN_REGISTRY_DEST=/app/cardano-token-registry
TOKEN_REGISTRY_MAPPINGS_DIR=${TOKEN_REGISTRY_DEST}/mappings
TOKEN_REGISTRY_SYNC_INTERVAL=60

TOKEN_REGISTRY_SCRIPT="echo 'Token Registry will be updated from ${TOKEN_REGISTRY_GIT_REPO}:${TOKEN_REGISTRY_GIT_BRANCH} into ${TOKEN_REGISTRY_DEST} each ${TOKEN_REGISTRY_SYNC_INTERVAL} seconds...' && while true; do if [ ! -e ${TOKEN_REGISTRY_DEST}/.git ]; then git clone ${TOKEN_REGISTRY_GIT_REPO} ${TOKEN_REGISTRY_DEST}; fi; cd ${TOKEN_REGISTRY_DEST} && git reset && git checkout ${TOKEN_REGISTRY_GIT_BRANCH} && git pull; sleep ${TOKEN_REGISTRY_SYNC_INTERVAL}; done;"

#Secrets:
#TODO: CREATE A PROPER READ ONLY ROLE FOR POSTGREST SERVICE, THIS IS UNSAFE:
POSTGREST_DB=$(<config/secrets/cardano-db-sync/postgres_db)
POSTGREST_PASSWORD=$(<config/secrets/cardano-db-sync/postgres_password)
POSTGREST_USER=$(<config/secrets/cardano-db-sync/postgres_user)
echo -n "*:5432:*:cardano-db-sync:${POSTGREST_PASSWORD}" > config/secrets/cardano-db-sync/pgpass

# User config
EMAIL=$(<config/user/e-mail)
EMAIL_SANITIZED=`echo "${EMAIL}" | tr @ _`

cat common.env > docker-preprod.env 
cat preprod.env >> docker-preprod.env
echo "POSTGREST_DB=${POSTGREST_DB}" >> docker-preprod.env
echo "POSTGREST_PASSWORD=${POSTGREST_PASSWORD}" >> docker-preprod.env
echo "POSTGREST_USER=${POSTGREST_USER}" >> docker-preprod.env
echo "EMAIL=${EMAIL}" >> docker-preprod.env
echo "EMAIL_SANITIZED=${EMAIL_SANITIZED}" >> docker-preprod.env
echo "TOKEN_REGISTRY_SCRIPT=${TOKEN_REGISTRY_SCRIPT}" >> docker-preprod.env
echo "TOKEN_REGISTRY_DEST=${TOKEN_REGISTRY_DEST}" >> docker-preprod.env


cat common.env > docker-mainnet.env 
cat mainnet.env >> docker-mainnet.env
echo "POSTGREST_DB=${POSTGREST_DB}" >> docker-mainnet.env
echo "POSTGREST_PASSWORD=${POSTGREST_PASSWORD}" >> docker-mainnet.env
echo "POSTGREST_USER=${POSTGREST_USER}" >> docker-mainnet.env
echo "EMAIL=${EMAIL}" >> docker-mainnet.env
echo "EMAIL_SANITIZED=${EMAIL_SANITIZED}" >> docker-mainnet.env
echo "TOKEN_REGISTRY_SCRIPT=${TOKEN_REGISTRY_SCRIPT}" >> docker-mainnet.env
echo "TOKEN_REGISTRY_DEST=${TOKEN_REGISTRY_DEST}" >> docker-mainnet.env
