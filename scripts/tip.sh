if [[ -z "$1" ]]; then
        echo "missing network. first argument must be [mainnet|preprod]"
        exit -1
fi &&

NETWORK=$1 &&\
PROJECT_NAME=gc-node-${NETWORK} &&\
#CONTAINER_NAME=${PROJECT_NAME}-cardano-node-ogmios-1
CONTAINER_NAME=${PROJECT_NAME}-cardano-node-1

if [ "$NETWORK" = "mainnet" ]; then
	sudo docker exec -it ${CONTAINER_NAME} /bin/bash -c "cardano-cli query tip --mainnet --socket-path=/ipc/node.socket"
    
else
	sudo docker exec -it ${CONTAINER_NAME}  /bin/bash -c "cardano-cli query tip --testnet-magic 1 --socket-path=/ipc/node.socket"
fi

