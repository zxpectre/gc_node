
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

cat common.env > docker-mainnet.env 
cat mainnet.env >> docker-mainnet.env
echo "POSTGREST_DB=${POSTGREST_DB}" >> docker-mainnet.env
echo "POSTGREST_PASSWORD=${POSTGREST_PASSWORD}" >> docker-mainnet.env
echo "POSTGREST_USER=${POSTGREST_USER}" >> docker-mainnet.env
echo "EMAIL=${EMAIL}" >> docker-mainnet.env
echo "EMAIL_SANITIZED=${EMAIL_SANITIZED}" >> docker-mainnet.env

#Params:
NETWORK=$1
PROJECT_NAME=gc-node-${NETWORK}

#CARDANO_NODE_VERSION=8.1.1  # fails with PeerStatusChangeFailure errors on P2P network sync phase at around 55% of sync (seems due to old peers on network)

echo "Initializing $PROJECT_NAME with this params:" &&
echo "NETWORK	= $NETWORK" &&
cat docker-${NETWORK}.env
cat token-reg.env

docker compose -p $PROJECT_NAME --env-file docker-${NETWORK}.env config 
docker compose -p $PROJECT_NAME --env-file docker-${NETWORK}.env config > config.yml