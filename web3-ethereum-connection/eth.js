const { Web3 } = require("web3");

const rpcUrl = "https://eth-sepolia.g.alchemy.com/v2/34XcB_u94wH_V7MiXbgnHcz-SDNhwoUF";
const privateKey = "0x7241cfbe2af2fe98d53c15ec4d6c2c6df99d48e87d442bef28592cd752f55937";
const account = "0x0faFcec090622cf14b8Fc214ea47872c12C9aCae";
const contractAddress = "0x5BAd0e8EC4Cfbb39E9cb570Dd4C76365527d2dDf";

const abi = [
  {
    "inputs": [{"internalType": "uint256", "name": "num", "type": "uint256"}],
    "name": "store",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "anonymous": false,
    "inputs": [
      {"indexed": true, "name": "sender", "type": "address"},
      {"indexed": false, "name": "value", "type": "uint256"}
    ],
    "name": "NumberStored",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "getNumber",
    "outputs": [{"internalType": "uint256", "name": "", "type": "uint256"}],
    "stateMutability": "view",
    "type": "function"
  }
];

const web3 = new Web3(rpcUrl);
const contract = new web3.eth.Contract(abi, contractAddress);

async function sendTransaction() {
  try {
    web3.eth.accounts.wallet.add(web3.eth.accounts.privateKeyToAccount(privateKey));
    const nonce = await web3.eth.getTransactionCount(account, "pending");
    const tx = {
      from: account,
      to: contractAddress,
      value: "1",
      data: contract.methods.store(2026).encodeABI(),
      maxPriorityFeePerGas: "1500000000", // 1.5 Gwei
      maxFeePerGas: "20000000000", // 20 Gwei
      gasLimit: "50000",
      type: "0x2",
      chainId: 11155111
    };
    const gasEstimate = await web3.eth.estimateGas(tx);
    console.log("Gas estimate:", gasEstimate.toString());

    const signedTx = await web3.eth.accounts.signTransaction(tx, privateKey);
    const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);

    const txDetails = await web3.eth.getTransaction(receipt.transactionHash);
    const block = await web3.eth.getBlock(receipt.blockNumber);
    const storedNumber = await contract.methods.getNumber().call();
    const events = await contract.getPastEvents("NumberStored", {
      fromBlock: receipt.blockNumber,
      toBlock: receipt.blockNumber
    });

    console.log("\nTransaction Details:");
    console.log("  Tx Hash:", receipt.transactionHash);
    console.log("  Block Number:", receipt.blockNumber.toString());
    console.log("  Timestamp:", new Date(Number(block.timestamp) * 1000).toISOString());
    console.log("  Gas Used:", receipt.gasUsed.toString());
    console.log("  Effective Gas Price:", txDetails.effectiveGasPrice 
      ? web3.utils.fromWei(txDetails.effectiveGasPrice, "gwei") + " Gwei" 
      : "Not available (EIP-1559)");
    console.log("  Value Sent:", web3.utils.fromWei(tx.value, "ether"), "ETH");
    console.log("\nContract State:");
    console.log("  Stored Number:", storedNumber.toString());
    console.log("\nEvents Emitted:");
    events.forEach((event, i) => {
      console.log(`  Event ${i + 1}:`);
      console.log("    Sender:", event.returnValues.sender);
      console.log("    Value Stored:", event.returnValues.value.toString());
    });
  } catch (error) {
    console.error("Error:", error.message);
    if (error.data) console.error("Revert reason:", error.data);
  }
}

function webe3(){

  const web3 = new Web3('https://eth-sepolia.g.alchemy.com/v2/34XcB_u94wH_V7MiXbgnHcz-SDNhwoUF');
  web3.eth.getBlock('latest').then(console.log);
  
}

sendTransaction();


// webe3();
