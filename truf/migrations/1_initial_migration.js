var Migrations = artifacts.require("./Migrations.sol");
var SolTweet = artifacts.require("SolTweet");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
