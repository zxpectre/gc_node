
if [[ -z "$1" ]]; then
	echo "missing network. first argument must be [mainnet|preprod]"
	exit -1
fi &&

#Secrets:
#TODO: CREATE A PROPER READ ONLY ROLE FOR POSTGREST SERVICE, THIS IS UNSAFE:
export POSTGREST_DB=$(<config/secrets/cardano-db-sync/postgres_db)
export POSTGREST_PASSWORD=$(<config/secrets/cardano-db-sync/postgres_password)
export POSTGREST_USER=$(<config/secrets/cardano-db-sync/postgres_user)

# User config
export EMAIL=zxpectre@gamechanger.finance
export EMAIL_SANITIZED=`echo "${EMAIL}" | tr @ _`

#Params:
export NETWORK=$1
export PROJECT_NAME=gc-node-${NETWORK}
export OGMIOS_VERSION=latest
#CARDANO_NODE_VERSION=8.1.1  # fails with PeerStatusChangeFailure errors on P2P network sync phase at around 55% of sync (seems due to old peers on network)
export CARDANO_NODE_VERSION=8.1.2 # https://github.com/IntersectMBO/cardano-node/releases/tag/8.1.2
export CARDANO_DB_SYNC_VERSION=13.1.1.3
export SWAGGER_API_URL=http://127.0.0.1:3000/  # public / internal postgrest exposed host

echo "Initializing $PROJECT_NAME with this params:" &&
echo "NETWORK	= $NETWORK" &&
echo "PROJECT_NAME	= $PROJECT_NAME" &&
echo "OGMIOS_VERSION	= $OGMIOS_VERSION" &&
echo "CARDANO_NODE_VERSION	= $CARDANO_NODE_VERSION" &&
echo "CARDANO_DB_SYNC_VERSION	= $CARDANO_DB_SYNC_VERSION" &&
echo "SWAGGER_API_URL 	= $SWAGGER_API_URL" &&
cat token-reg.env

docker compose -p $PROJECT_NAME --env-file docker-${NETWORK}.env up -d &&
docker compose -p $PROJECT_NAME logs -f
