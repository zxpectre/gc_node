# based on https://github.com/input-output-hk/cardano-configurations
# actually this repo can be linked from this one and reuse the github flows to automatically update the files via cron job
# an example of this setup can be found at https://github.com/cardano-foundation/cardano-graphql

CARDANO_CONFIG_URL=https://book.world.dev.cardano.org/environments/
mkdir -p config/
cd config/
../scripts/download-config.sh $CARDANO_CONFIG_URL mainnet
../scripts/download-config.sh $CARDANO_CONFIG_URL preprod
