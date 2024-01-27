
if [[ -z "$1" ]]; then
	echo "missing network. first argument must be [mainnet|preprod]"
	exit -1
fi &&

#Secrets:
#TODO: CREATE A PROPER READ ONLY ROLE FOR POSTGREST SERVICE, THIS IS UNSAFE:
POSTGREST_DB=$(<config/secrets/cardano-db-sync/postgres_db)
POSTGREST_PASSWORD=$(<config/secrets/cardano-db-sync/postgres_password)
POSTGREST_USER=$(<config/secrets/cardano-db-sync/postgres_user)

# User config
EMAIL=zxpectre@gamechanger.finance
# User config
EMAIL=zxpectre@gamechanger.finance
EMAIL_SANITIZED=`echo "${EMAIL}" | tr @ _`

#Params:
NETWORK=$1
PROJECT_NAME=gc-node-${NETWORK}
OGMIOS_VERSION=latest
#CARDANO_NODE_VERSION=8.1.1  # fails with PeerStatusChangeFailure errors on P2P network sync phase at around 55% of sync (seems due to old peers on network)
CARDANO_NODE_VERSION=8.1.2 # https://github.com/IntersectMBO/cardano-node/releases/tag/8.1.2
CARDANO_DB_SYNC_VERSION=13.1.1.3
SWAGGER_API_URL=http://127.0.0.1:3000/  # public / internal postgrest exposed host
TOKEN_REGISTRY_GIT_REPO=https://github.com/cardano-foundation/cardano-token-registry
TOKEN_REGISTRY_GIT_BRANCH=master
TOKEN_REGISTRY_DEST=/app/cardano-token-registry
TOKEN_REGISTRY_SYNC_INTERVAL=60 #3600s=1h
TOKEN_REGISTRY_MAPPINGS_DIR=$TOKEN_REGISTRY_DEST/mappings



echo "Initializing $PROJECT_NAME with this params:" &&
echo "NETWORK	= $NETWORK" &&
echo "PROJECT_NAME	= $PROJECT_NAME" &&
echo "OGMIOS_VERSION	= $OGMIOS_VERSION" &&
echo "CARDANO_NODE_VERSION	= $CARDANO_NODE_VERSION" &&
echo "CARDANO_DB_SYNC_VERSION	= $CARDANO_DB_SYNC_VERSION" &&
echo "SWAGGER_API_URL 	= $SWAGGER_API_URL" &&
echo "TOKEN_REGISTRY_GIT_REPO	= $TOKEN_REGISTRY_GIT_REPO" &&
echo "TOKEN_REGISTRY_GIT_BRANCH 	= $TOKEN_REGISTRY_GIT_BRANCH" &&
echo "TOKEN_REGISTRY_DEST	= $TOKEN_REGISTRY_DEST" &&
echo "TOKEN_REGISTRY_SYNC_INTERVAL	= $TOKEN_REGISTRY_SYNC_INTERVAL" &&
echo "TOKEN_REGISTRY_MAPPINGS_DIR	= $TOKEN_REGISTRY_MAPPINGS_DIR" &&

#sudo docker pull cardanosolutions/cardano-node-ogmios:v5.5.8_1.35.4-$NETWORK &&\
#echo "Ogmios image pulled successfully" &&
NETWORK=$NETWORK \
OGMIOS_VERSION=$OGMIOS_VERSION \
CARDANO_NODE_VERSION=$CARDANO_NODE_VERSION \
CARDANO_DB_SYNC_VERSION=$CARDANO_DB_SYNC_VERSION \
PROJECT_NAME=$PROJECT_NAME \
POSTGREST_DB=$POSTGREST_DB \
POSTGREST_PASSWORD=$POSTGREST_PASSWORD \
POSTGREST_USER=$POSTGREST_USER \
SWAGGER_API_URL=$SWAGGER_API_URL \
TOKEN_REGISTRY_GIT_REPO=$TOKEN_REGISTRY_GIT_REPO \
TOKEN_REGISTRY_GIT_BRANCH=$TOKEN_REGISTRY_GIT_BRANCH \
TOKEN_REGISTRY_DEST=$TOKEN_REGISTRY_DEST \
TOKEN_REGISTRY_SYNC_INTERVAL=$TOKEN_REGISTRY_SYNC_INTERVAL \
TOKEN_REGISTRY_MAPPINGS_DIR=$TOKEN_REGISTRY_MAPPINGS_DIR \
EMAIL=$EMAIL \
EMAIL_SANITIZED=$EMAIL_SANITIZED \
docker compose -p $PROJECT_NAME --env-file docker-${NETWORK}.env up -d &&
docker compose -p $PROJECT_NAME logs -f
