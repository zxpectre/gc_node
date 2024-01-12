
if [[ -z "$1" ]]; then
	echo "missing network. first argument must be [mainnet|preprod]"
	exit -1
fi &&

#Params:
NETWORK=$1 &&
PROJECT_NAME=gc-node-${NETWORK} &&
OGMIOS_VERSION=v5.5.8 &&
#CARDANO_NODE_VERSION=1.35.4 &&
#CARDANO_NODE_VERSION=8.1.1 && # fails with PeerStatusChangeFailure errors on P2P network sync phase at around 55% of sync (seems due to old peers on network)
CARDANO_NODE_VERSION=8.1.2 && # https://github.com/IntersectMBO/cardano-node/releases/tag/8.1.2
CARDANO_DB_SYNC_VERSION=13.1.1.3 &&

#Secrets:
#TODO: CREATE A PROPER READ ONLY ROLE FOR POSTGREST SERVICE, THIS IS UNSAFE:
POSTGREST_DB=$(<config/secrets/cardano-db-sync/postgres_db)
POSTGREST_PASSWORD=$(<config/secrets/cardano-db-sync/postgres_password)
POSTGREST_USER=$(<config/secrets/cardano-db-sync/postgres_user)

if [ "$NETWORK" == "preprod" ]; then
        OGMIOS_PORT=1338 
        POSTGRES_PORT=5434 
fi &&

echo "Initializing $PROJECT_NAME with this params:" &&
echo "NETWORK	= $NETWORK" &&
echo "PROJECT_NAME	= $PROJECT_NAME" &&
echo "OGMIOS_VERSION	= $OGMIOS_VERSION" &&
echo "CARDANO_NODE_VERSION	= $CARDANO_NODE_VERSION" &&
echo "CARDANO_DB_SYNC_VERSION	= $CARDANO_DB_SYNC_VERSION" &&
echo "OGMIOS_PORT 	= $OGMIOS_PORT" &&
echo "POSTGRES_PORT 	= $POSTGRES_PORT" &&

#sudo docker pull cardanosolutions/cardano-node-ogmios:v5.5.8_1.35.4-$NETWORK &&\
#echo "Ogmios image pulled successfully" &&
sudo \
	NETWORK=$NETWORK \
	OGMIOS_VERSION=$OGMIOS_VERSION \
	CARDANO_NODE_VERSION=$CARDANO_NODE_VERSION \
	CARDANO_DB_SYNC_VERSION=$CARDANO_DB_SYNC_VERSION \
	PROJECT_NAME=$PROJECT_NAME \
	OGMIOS_PORT=$OGMIOS_PORT \
	POSTGRES_PORT=$POSTGRES_PORT \
	POSTGREST_DB=$POSTGREST_DB \
	POSTGREST_PASSWORD=$POSTGREST_PASSWORD \
	POSTGREST_USER=$POSTGREST_USER \
	docker compose -p $PROJECT_NAME up -d &&
sudo docker compose -p $PROJECT_NAME logs -f
