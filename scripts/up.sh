

#Params:
NETWORK=$1
PROJECT_NAME=gc-node-${NETWORK}

./scripts/generate-config.sh "${NETWORK}"
#CARDANO_NODE_VERSION=8.1.1  # fails with PeerStatusChangeFailure errors on P2P network sync phase at around 55% of sync (seems due to old peers on network)

echo "Initializing $PROJECT_NAME with this params:" &&
echo "NETWORK	= $NETWORK" &&
cat docker-${NETWORK}.env
cat token-reg.env

docker compose -p $PROJECT_NAME --env-file docker-${NETWORK}.env up -d &&
docker compose -p $PROJECT_NAME logs -f
