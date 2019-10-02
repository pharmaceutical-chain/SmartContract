var HDWalletProvider = require("truffle-hdwallet-provider");

var rpc_endpoint = "http://ethecctzc-dns-reg1.southeastasia.cloudapp.azure.com:8540";
var mnemonic = "crowd stage wool gold wire mango false found suggest slam nut cake";

module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    poa: {
      provider: new HDWalletProvider(mnemonic, rpc_endpoint),
      network_id: 10101010,
      gasPrice : 0
    }
  }
};