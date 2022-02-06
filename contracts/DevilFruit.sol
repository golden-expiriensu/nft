// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DevilFruit is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private numberOfFruitsInTheWorld;
    bool private isURIChangeable;

    constructor(bool _isURIChangeable) ERC721("Devil fruit", "DVF") {
        isURIChangeable = _isURIChangeable;
    }

    function grantDevilFruit(address _to, string calldata _uri) public onlyOwner {
        uint256 newFruitNumber = numberOfFruitsInTheWorld.current();
        numberOfFruitsInTheWorld.increment();
        _safeMint(_to, newFruitNumber);
        _setTokenURI(newFruitNumber, _uri);
    }

    function updateFruitURI(uint256 _fruitId, string calldata _newURI) external onlyOwner {
        require(isURIChangeable, "Existing fruits URIs have been frozen forever");
        _setTokenURI(_fruitId, _newURI);
    }

    function frozeFruitsURI() external onlyOwner {
        isURIChangeable = false;
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 _tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(_tokenId);
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(_tokenId);
    }
}