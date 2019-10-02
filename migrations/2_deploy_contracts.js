var PharmaChain = artifacts.require("PharmaChain");

module.exports = function(deployer) {
    deployer.deploy(PharmaChain, "PharmaChain");
    // Additional contracts can be deployed here
};