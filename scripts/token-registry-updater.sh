TOKEN_REGISTRY_GIT_REPO=https://github.com/cardano-foundation/cardano-token-registry
TOKEN_REGISTRY_GIT_BRANCH=master
TOKEN_REGISTRY_DEST=build/token-registry-test/
TOKEN_REGISTRY_SYNC_INTERVAL=120 # 3600s=1h
TOKEN_REGISTRY_MAPPINGS_DIR=$TOKEN_REGISTRY_DEST/mappings

while true; do if [ ! -e ${TOKEN_REGISTRY_DEST}/.git ]; then git clone ${TOKEN_REGISTRY_GIT_REPO} ${TOKEN_REGISTRY_DEST}; fi;cd ${TOKEN_REGISTRY_DEST} && git reset && git checkout ${TOKEN_REGISTRY_GIT_BRANCH} && git pull; sleep ${TOKEN_REGISTRY_SYNC_INTERVAL}; done
