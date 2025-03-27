store(){
echo "Storing Data..."
curl --location --request POST 'http://0.0.0.0:4000/api/v1/plugins/@hyperledger/cactus-plugin-ledger-connector-ethereum/run-transaction' \
--header 'Content-Type: application/json' \
--data-raw '{
  {
  "web3SigningCredential": {
    "ethAccount": "0x0faFcec090622cf14b8Fc214ea47872c12C9aCae",
    "secret": "7241cfbe2af2fe98d53c15ec4d6c2c6df99d48e87d442bef28592cd752f55937",
    "type": "PRIVATE_KEY_HEX"
  },
  "transactionConfig": {
    "from": "0x0faFcec090622cf14b8Fc214ea47872c12C9aCae",
    "to": "0x5BAd0e8EC4Cfbb39E9cb570Dd4C76365527d2dDf",
    "value": "1",
    "data": "0x6057361d00000000000000000000000000000000000000000000000000000000000007ea",
    "gasConfig": {
      "maxPriorityFeePerGas": "0x6FC23AC00",
      "maxFeePerGas": "0x6FC23AC000",
      "gasLimit": "0x5208"
    },
    "type": "0x2"
  }
}'
echo ""
}


getdata(){
echo "Retrieving Data..."
curl  --location --request POST 'http://localhost:4000/api/v1/plugins/@hyperledger/cactus-plugin-ledger-connector-ethereum/run-transaction' \
--header 'Content-Type: application/json' \
--data-raw '{
    "web3SigningCredential": {
      "ethAccount": "0x0faFcec090622cf14b8Fc214ea47872c12C9aCae",
      "secret": "7241cfbe2af2fe98d53c15ec4d6c2c6df99d48e87d442bef28592cd752f55937",
      "type": "PRIVATE_KEY_HEX"
    },
    "transactionConfig": {
      "from": "0x0faFcec090622cf14b8Fc214ea47872c12C9aCae",
      "to": "0x5BAd0e8EC4Cfbb39E9cb570Dd4C76365527d2dDf",
      "data": "0x6057361d00000000000000000000000000000000000000000000000000000000000007ea",
      "value": "1",
      "maxPriorityFeePerGas": "0",
      "maxFeePerGas": "40000000",
      "gasLimit": "210000",
      "type": 2
    }
}'
echo ""
}



# store
getdata
 




