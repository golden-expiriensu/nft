import { ethers } from "hardhat";

async function main() {
  const addr = await ethers.getSigners();

  const NFT = await ethers.getContractFactory("DevilFruit");
  const nft = await NFT.connect(addr[1]).deploy();

  await nft.deployed();

  console.log("Devil fruit creator deployed at: ", nft.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
