
if [[ -z "$1" ]]; then
	echo "missing network. first argument must be [mainnet|preprod]"
	exit -1
fi &&

export NETWORK=$1 &&\
export PROJECT_NAME=gc-node-${NETWORK} &&\

sudo docker compose -p ${PROJECT_NAME} ps
