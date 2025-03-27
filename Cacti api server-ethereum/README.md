- run the ./Api-server.sh to launch the cactus api server. (this runs with no issues)
- run the ./query.sh to query the ethereum network.
- errors that results:
- 
  Retrieving Data...
{"message":"Internal Server Error","error":"{\"name\":\"MissingGasError\",\"code\":415,\"message\":\"Invalid value given \\\"gas: 0x6469, gasPrice: undefined, maxPriorityFeePerGas: undefined, maxFeePerGas: undefined\\\". Error: \\\"gas\\\" is missing.\",\"cause\":{\"name\":\"MissingGasInnerError\",\"code\":440,\"message\":\"Missing properties in transaction, either define \\\"gas\\\" and \\\"gasPrice\\\" for type 0 transactions or \\\"gas\\\", \\\"maxPriorityFeePerGas\\\" and \\\"maxFeePerGas\\\" for type 2 transactions\"},\"innerError\":{\"name\":\"MissingGasInnerError\",\"code\":440,\"message\":\"Missing properties in transaction, either define \\\"gas\\\" and \\\"gasPrice\\\" for type 0 transactions or \\\"gas\\\", \\\"maxPriorityFeePerGas\\\" and \\\"maxFeePerGas\\\" for type 2 transactions\"}}"}

So i troubleshooted extensively an narrowed it down to the method :
- "private async getTransactionFromTxConfig:
- line from> 903 in the plugin-ledger-connector-ethereum.ts
- thought this piece of the code was the issue:
-  // Apply gas config to the transaction
    - if (txConfig.gasConfig) {
     - if (isGasTransactionConfigLegacy(txConfig.gasConfig)) {
       - if (isGasTransactionConfigEIP1559(txConfig.gasConfig)) {
        -  throw new RuntimeError(
          - `Detected mixed gasConfig! Use either legacy or EIP-1559 mode. gasConfig - ${JSON.stringify(
           - txConfig.gasConfig,
            - }`,
         - );
       - }
       - tx.maxPriorityFeePerGas = txConfig.gasConfig.gasPrice;
       - tx.maxFeePerGas = txConfig.gasConfig.gasPrice;
       - tx.gasLimit = txConfig.gasConfig.gas;
      - } else {
       - tx.maxPriorityFeePerGas = txConfig.gasConfig.maxPriorityFeePerGas;
       - tx.maxFeePerGas = txConfig.gasConfig.maxFeePerGas;
       - tx.gasLimit = txConfig.gasConfig.gasLimit;
      -}
   - }

Tried to remodify the codes to no avail. tested out several modification to no avail.

-N/B: the keys, contract and addresses used here work well. it can be tested by running the eth.js code in this repository.
