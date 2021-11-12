// import { ethers } from "hardhat";
// import { Signer } from "ethers";
// import { expect } from "chai";

// describe("Engine", function () {

//   beforeEach(async function () {
//   });

//   it("should do something right", async function () {
//       const [proxyRegistryAccountAddress, playerAccount] = await ethers.getSigners();

//       console.log("PROXY ACCOUNT: " + proxyRegistryAccountAddress.address);
//       console.log("PLAYER ACCOUNT: " + playerAccount.address);

//       const Engine = await ethers.getContractFactory("Engine");
//       const engine = await Engine.deploy(proxyRegistryAccountAddress.address);
//       await engine.deployed();
//       console.log("EngineFactory deployed to:", engine.address);
      
//       await engine.mintTo(playerAccount.address);

//       expect(await engine.ownerOf(1)).to.equal(playerAccount.address);

//       await engine.mintTo(playerAccount.address);

//       expect(await engine.ownerOf(2)).to.equal(playerAccount.address);

//       console.log(await engine.ownerOf(1));
//       console.log(await engine.ownerOf(2));
//   });
// });