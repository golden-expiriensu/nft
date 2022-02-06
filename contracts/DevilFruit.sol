// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DevilFruit is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _numberOfFruitsInTheWorld;

    constructor() ERC721("Devil fruit", "DVF") {}

    function grantDevilFruit(address to, string memory uri) public onlyOwner {
        uint256 newFruitNumber = _numberOfFruitsInTheWorld.current();
        _numberOfFruitsInTheWorld.increment();
        _safeMint(to, newFruitNumber);
        _setTokenURI(newFruitNumber, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}