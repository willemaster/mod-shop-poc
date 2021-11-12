import { ethers } from "hardhat";
import { Signer } from "ethers";
import { expect } from "chai";

describe("ModShop", function () {

  beforeEach(async function () {
  });

  it("should do all the things", async function () {
      const [proxyRegistryAccountAddress, ownerAccount, operatorAccount] = await ethers.getSigners();

      console.log("PROXY ACCOUNT: " + proxyRegistryAccountAddress.address);
      console.log("OWNER ACCOUNT: " + ownerAccount.address);
      console.log("OPERATOR ACCOUNT: " + operatorAccount.address);

      const Engine = await ethers.getContractFactory("Engine");
      const engine = await Engine.deploy(proxyRegistryAccountAddress.address);
      await engine.deployed();
      console.log("Engine deployed to:", engine.address);

      const Turbo = await ethers.getContractFactory("Turbo");
      const turbo = await Turbo.deploy(proxyRegistryAccountAddress.address);
      await turbo.deployed();
      console.log("Turbo deployed to:", turbo.address);

      const ModShop = await ethers.getContractFactory("ModShop");
      const modShop = await ModShop.deploy(engine.address, turbo.address);
      await modShop.deployed();
      console.log("ModShop deployed to:", modShop.address);

      await engine.mint(ownerAccount.address, 100);
      expect(await engine.ownerOf(0)).to.equal(ownerAccount.address);
      expect(await engine.getSpeed(0)).to.equal(100);

      await turbo.mint(ownerAccount.address);
      expect(await turbo.ownerOf(0)).to.equal(ownerAccount.address);

      await engine.connect(ownerAccount).setApprovalForAll(operatorAccount.address, true);
      await engine.connect(ownerAccount).approve(operatorAccount.address, 0);


      console.log("getApproved():" + await engine.getApproved(0));
      console.log("isApprovedForAll():" + await engine.isApprovedForAll(ownerAccount.address, operatorAccount.address));
      console.log("ownerOf(0):" + await engine.ownerOf(0));

      expect(await engine.balanceOf(ownerAccount.address)).to.equal(1);
      expect(await turbo.balanceOf(ownerAccount.address)).to.equal(1);
      await modShop.connect(operatorAccount).mod(0, 0);
      
      // old engine burnt, new engine minted
      expect(await engine.balanceOf(ownerAccount.address)).to.equal(1);
      expect(await engine.ownerOf(1)).to.equal(ownerAccount.address);
      
      expect(await turbo.balanceOf(ownerAccount.address)).to.equal(0); // turbo burnt
      expect(await engine.getSpeed(1)).to.equal(110);
  });
});