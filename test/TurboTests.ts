// import { ethers } from "hardhat";
// import { Signer } from "ethers";
// import { expect } from "chai";

// describe("Turbo", function () {

//   beforeEach(async function () {
//   });

//   it("should do something right", async function () {
//       const [proxyRegistryAccountAddress, playerAccount] = await ethers.getSigners();

//       console.log("PROXY ACCOUNT: " + proxyRegistryAccountAddress.address);
//       console.log("PLAYER ACCOUNT: " + playerAccount.address);

//       const Turbo = await ethers.getContractFactory("Turbo");
//       const turbo = await Turbo.deploy(proxyRegistryAccountAddress.address);
//       await turbo.deployed();
//       console.log("Turbo deployed to:", turbo.address);
      
//       await turbo.mintTo(playerAccount.address);

//       expect(await turbo.ownerOf(1)).to.equal(playerAccount.address);

//       await turbo.mintTo(playerAccount.address);

//       expect(await turbo.ownerOf(2)).to.equal(playerAccount.address);

//       console.log(await turbo.ownerOf(1));
//       console.log(await turbo.ownerOf(2));
//   });
// });