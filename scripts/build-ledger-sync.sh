#!/bin/bash

APPLICATION_NAME=cf-ledger-sync
VERSION=$(git describe --tags --always)
#PRIVATE_DOCKER_REGISTRY_URL="pro.registry.gitlab.metadata.dev.cf-deployments.org/base-infrastructure/docker-registry/"
DOCKER_IMAGE="${PRIVATE_DOCKER_REGISTRY_URL}${APPLICATION_NAME}:${VERSION:-latest}"

set -x 

mkdir -p build
cd build

# Install cf-ledger-sync
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.deb
sudo dpkg -i jdk-21_linux-x64_bin.deb
git clone https://github.com/cardano-foundation/cf-ledger-sync.git

cd cf-ledger-sync


./gradlew application:bootJar -x test && \
# sudo docker buildx use amd64 && \
  sudo docker buildx build --platform linux/amd64 --load \
    --no-cache \
    --progress plain \
    -t "${DOCKER_IMAGE}" \
    .

#docker push "${DOCKER_IMAGE}"
sudo docker save cf-ledger-sync:latest | gzip > cf-ledger-sync:latest.tar.gz
