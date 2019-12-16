var HDWalletProvider = require("truffle-hdwallet-provider");

var infura_apikey = "ad8ea364154b464eb6c7ff37f66ffc94";
var rpc_endpoint = "http://ethecctzc-dns-reg1.southeastasia.cloudapp.azure.com:8540";
var mnemonic = "crowd stage wool gold wire mango false found suggest slam nut cake";

module.exports = {
  solc: {
	version: "0.5.12",
	optimizer: {
		enabled: true,
		runs: 200
	}
  },
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
    },
	ropsten: {
	  provider: function() {
		return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/v3/ad8ea364154b464eb6c7ff37f66ffc94");
      },
      network_id: 3,
	  gas: 7900000,
	  from: "0x639B8826E931291C18EA74A805f96E71a301E741"
    }
  }
};