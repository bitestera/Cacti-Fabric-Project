
#-----------------------------WSL-------------------------------------#
# if using wsl subsystem for linux, use the created bridge network here
#  --network=ether
# then use localhost or 0.0.0.0 to curl access network and/container.

docker network create --driver bridge ether

# -------------------------------------Linux system------------------------------------------#
# if directly using a linux system, you can ignore this and use networ mode= host instead and
#  --network=host
# then use the ip address of the pc hosting the linux system to curl access docker network.
 
docker run \
  --network=ether \
  --rm \
   --env AUTHORIZATION_PROTOCOL='NONE' \
  --publish 3000:3000 \
  --publish 4000:4000 \
  --env AUTHORIZATION_PROTOCOL='NONE' \
  --env AUTHORIZATION_CONFIG_JSON='{}' \
  --env GRPC_TLS_ENABLED=false \
  --env API_TLS_CERT_PEM=- \
  --env API_TLS_CLIENT_CA_PEM=- \
  --env API_TLS_KEY_PEM=- \
  --env API_TLS_ENABLED=false \
  --env API_MTLS_ENABLED=false \
  --env API_HOST=0.0.0.0 \
  --env LOG_LEVEL=DEBUG\
  --env PLUGINS='[
  {
    "packageName": "@hyperledger/cactus-plugin-ledger-connector-ethereum",
    "type": "org.hyperledger.cactus.plugin_import_type.LOCAL",
    "action": "org.hyperledger.cactus.plugin_import_action.INSTALL",
    "options": {
    "instanceId": "some-unique-ethereum-connector-instance-id",
    "rpcApiHttpHost": "https://eth-sepolia.g.alchemy.com/v2/34XcB_u94wH_V7MiXbgnHcz-SDNhwoUF",
    "logLevel": "debug"
    }
  }
]' \
  ghcr.io/hyperledger/cactus-cmd-api-server:2024-07-03t18-38-45-dev-65adc3255
