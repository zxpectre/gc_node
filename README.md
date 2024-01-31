# GC NODE
Backend Cardano node for development purposes

## Get started:

git pull https://github.com/zxpectre/gc_node.git

cd gc_node

./scripts/install.sh

### Generate a password

./scripts/generate-password.sh

### Email

Add your email for access to pgAdmin. Into this file
./config/user/e-mail

## Domain

Set your domain name 
./config/user/domain

### Preprod

./scripts/up.sh preprod

./scripts/stop.sh preprod

### Mainnet

./scripts/up.sh mainnet

./scripts/stop.sh mainnet

## Traefik

Start outside interned access. 
Maker sure you have set the correct ip-address to your computer from your domain and open ports 80 and 443
Uncomment this line in docker-compose-traefik.yml to first test your setup. Otherwise you can hit a rate limit on letsencrypt. If you made a 
misconfiguration somewhere 
# - "--certificatesresolvers.myresolver.acme.caserver=https://acme-staging-v02.api.letsencrypt.org/directory"

./scripts/up.sh traefik

./scripts/down.sh traefik

## Notes:

Docker image collection and setup based on https://github.com/IntersectMBO/cardano-db-sync/tree/13.1.1.3


Not verified community snapshots: 

https://csnapshots.io/


Postgrest setup based on Lantana and this resource:

https://medium.com/@shlomi.fenster1/setup-local-environment-for-postgresql-5531b8268397


## List ports
docker ps --format 'table {{.Names}}\t{{.Ports}}'

## Test ogmios
curl -H 'Accept: application/json' http://localhost:1338/health
