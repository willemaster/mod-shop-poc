// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./Engine.sol";
import "./Turbo.sol";
import "hardhat/console.sol";

/**
 * @title ModShop
 * Takes an engine and a turbo mod, burns the engine and mints an upgraded one to the original engine's owner.
 */
contract ModShop is IERC721Receiver {

    Engine engineContract;
    Turbo turboContract;
    address engineContractAddress;
    address turboContractAddress;

    constructor(address _engineContractAddress, address _turboContractAddress) {
        engineContractAddress = _engineContractAddress;
        turboContractAddress = _turboContractAddress;
        engineContract = Engine(engineContractAddress);
        turboContract = Turbo(turboContractAddress);
    }

    function mod(uint _engineTokenId, uint _turboTokenId) public {

        console.log("msg.sender is %s", msg.sender);

        address owner = engineContract.ownerOf(_engineTokenId);

        engineContract.mint(owner, engineContract.getSpeed(_engineTokenId) + turboContract.getBoost());

        console.log("engine token id = %s", _engineTokenId);

        engineContract.burn(_engineTokenId);

        turboContract.burn(_turboTokenId);

        //(bool success, bytes memory data) = engineContractAddress.delegatecall(abi.encodeWithSignature("burn(uint256)", _engineTokenId));

        //console.log("delegatecall success = %s", success);


        //engineContractAddress.delegatecall(abi.encodeWithSignature("transferFrom(address,address,uint256)", owner, address(0), _turboTokenId));
    }

    function onERC721Received (
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override pure returns (bytes4) {
        return "hi";
    }    
}