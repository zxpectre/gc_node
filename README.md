# GC NODE
Backend Cardano node for development purposes

## Get started:

git pull https://github.com/zxpectre/gc_node.git

cd gc_node

./scripts/install.sh

### Preprod

./scripts/up.sh preprod

./scripts/stop.sh preprod

### Mainnet

./scripts/up.sh mainnet

./scripts/stop.sh mainnet


## Notes:

Docker image collection and setup based on https://github.com/IntersectMBO/cardano-db-sync/tree/13.1.1.3


Not verified community snapshots: 

https://csnapshots.io/


Postgrest setup based on Lantana and this resource:

https://medium.com/@shlomi.fenster1/setup-local-environment-for-postgresql-5531b8268397

### Koios

Postgresdb tunning:
https://cardano-community.github.io/guild-operators/Appendix/postgres/

Setup script:
https://github.com/cardano-community/guild-operators/tree/alpha/scripts/grest-helper-scripts (source)
https://cardano-community.github.io/guild-operators/Build/grest/

Nodes:
https://github.com/cardano-community/koios-artifacts/tree/main/topology
