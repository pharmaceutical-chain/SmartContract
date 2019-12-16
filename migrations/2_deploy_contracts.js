// var ChainPoint = artifacts.require("ChainPoint");
// var MedicineBatch = artifacts.require("MedicineBatch");
// var MedicineBatchTransfer = artifacts.require("MedicineBatchTransfer");
// var Ownable = artifacts.require("Ownable");
var PharmaChain = artifacts.require("PharmaChain");

module.exports = function(deployer) {
    deployer.deploy(PharmaChain);
    // Additional contracts can be deployed here
};