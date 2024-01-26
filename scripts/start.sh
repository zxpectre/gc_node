if [[ -z "$1" ]]; then
        echo "missing network. first argument must be [mainnet|preprod]"
        exit -1
fi &&
set -x
export NETWORK=$1 &&\
export PROJECT_NAME=gc-node-${NETWORK} &&\

docker compose -p ${PROJECT_NAME} --env-file docker-${NETWORK}.env create
docker compose -p ${PROJECT_NAME} --env-file docker-${NETWORK}.env start

