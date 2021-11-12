// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./ERC721Tradable.sol";
import "hardhat/console.sol";

/**
 * @title Engine
 * An engine that can be turboed.
 */
contract Engine is ERC721Tradable {

    // tokenId => topSpeed
    mapping(uint256 => uint256) _topSpeeds;

    uint256 tokenCount = 0;

    event ComponentMinted(uint256 tokenId, address owner);

    constructor(address _proxyRegistryAddress)
        ERC721Tradable("Engine", "ENG", _proxyRegistryAddress)
    {
    }

    function baseTokenURI() override public pure returns (string memory) {
        return "";
    }

    function contractURI() public pure returns (string memory) {
        return "engineContractUri";
    }

    function getSpeed(uint256 tokenId) public view returns (uint256) {
        return _topSpeeds[tokenId];
    }   

    function mint(
        address to,
        uint256 topSpeed
    ) public returns (uint256) {
        uint256 tokenId = createTokenId();

        _topSpeeds[tokenId] = topSpeed;
        _mint(to, tokenId);

        emit ComponentMinted(tokenId, to);

        return tokenId;
    }

    function burn(uint256 tokenId) public {
        console.log("ERC721:ownerOf = %s", ERC721.ownerOf(tokenId));
        console.log("msg.sender = %s", msg.sender);

        super._burn(tokenId);
    }

    // function transferFrom(address from, address to, uint256 tokenId) public override {
    //     console.log("ERC721:ownerOf = %s", ERC721.ownerOf(tokenId));
    //     console.log("from = %s", from);
    //     console.log("to = %s", to);
    //     console.log("msg.sender = %s", msg.sender);

    //     super.transferFrom(from, to, tokenId);
    // }

    function createTokenId() private returns (uint256) {
        uint256 token = tokenCount;
        tokenCount++;
        return token;
    }

}