// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract Spacebear is ERC721, Ownable {
    uint internal counter;

    constructor() ERC721("Spacebear", "SBR") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ethereum-blockchain-developer.com/2022-06-nft-truffle-hardhat-foundry/nftdata/";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = counter;
        counter++;
        _safeMint(to, tokenId);
    }

    function buyToken() public payable {
        uint256 tokenId = counter;
        require(msg.value == tokenId * 0.1 ether, "Not enough funds sent");

        counter ++;
        _safeMint(msg.sender, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        pure
        override(ERC721)
        returns (string memory)
    {
        return string(abi.encodePacked(_baseURI(),"_",tokenId+1,".json"));
    }
}