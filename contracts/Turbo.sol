// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./ERC721Tradable.sol";
import "hardhat/console.sol";

/**
 * @title Turbo
 * Turbo mod - a contract that can be applied to an engine to upgrade its speed attribute.
 */
contract Turbo is ERC721Tradable {

    uint256 tokenCount = 0;

    event ComponentMinted(uint256 tokenId, address owner);

    constructor(address _proxyRegistryAddress)
        ERC721Tradable("Turbo", "TBO", _proxyRegistryAddress)
    {}

    function mint(
        address to
    ) public returns (uint256) {
        uint256 tokenId = createTokenId();

        _mint(to, tokenId);

        emit ComponentMinted(tokenId, to);

        return tokenId;
    }

    function burn(uint256 tokenId) public {
        console.log("ERC721:ownerOf = %s", ERC721.ownerOf(tokenId));
        console.log("msg.sender = %s", msg.sender);

        super._burn(tokenId);
    }

    function createTokenId() private returns (uint256) {
        uint256 token = tokenCount;
        tokenCount++;
        return token;
    }

    function baseTokenURI() override public pure returns (string memory) {
        return "https://creatures-api.opensea.io/api/creature/";
    }

    function contractURI() public pure returns (string memory) {
        return "https://creatures-api.opensea.io/contract/opensea-creatures";
    }

    function getBoost() public pure returns (uint256) {
        return 10;
    }
}