# issues with the cacti ethereum ledger plugin connector specifically with the web3 private async getTransactionFromTxConfig method

- Errors:
- Retrieving Data...
{"message":"Internal Server Error","error":"{\"name\":\"MissingGasError\",\"code\":415,\"message\":\"Invalid value given \\\"gas: 0x6469, gasPrice: undefined, maxPriorityFeePerGas: undefined, maxFeePerGas: undefined\\\". Error: \\\"gas\\\" is missing.\",\"cause\":{\"name\":\"MissingGasInnerError\",\"code\":440,\"message\":\"Missing properties in transaction, either define \\\"gas\\\" and \\\"gasPrice\\\" for type 0 transactions or \\\"gas\\\", \\\"maxPriorityFeePerGas\\\" and \\\"maxFeePerGas\\\" for type 2 transactions\"},\"innerError\":{\"name\":\"MissingGasInnerError\",\"code\":440,\"message\":\"Missing properties in transaction, either define \\\"gas\\\" and \\\"gasPrice\\\" for type 0 transactions or \\\"gas\\\", \\\"maxPriorityFeePerGas\\\" and \\\"maxFeePerGas\\\" for type 2 transactions\"}}"}
- the: ethereum web3 connection directory, contains the cactus api server setup and the query code together with the prevalent issue that occurs
- the: web3-ethereum-connection, directory contains a simple connection code to ethereum via web3 with keys & addresses used to reproduce same results for testing.
