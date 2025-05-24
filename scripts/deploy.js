const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying DecentralizedComments contract with account:", deployer.address);

  const DecentralizedComments = await hre.ethers.getContractFactory("DecentralizedComments");
  const decentralizedComments = await DecentralizedComments.deploy();

  await decentralizedComments.deployed();

  console.log("DecentralizedComments deployed to:", decentralizedComments.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
