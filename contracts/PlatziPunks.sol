// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";
import "./PlatziPunksDNA.sol";

contract PlatziPunks is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;

    constructor() ERC721("ZRXPlatziPunks", "ZRXGN") {}

    function mint() public {
        uint256 current = _idCounter.current();
        require(current < maxSupply, "No quedan mas NFT para agregar");
        _safeMint(msg.sender, current);
        //Hay que agregar el incrementar
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721 Metadata: URI query for nonexistent token"
        );
        //TODO: ver como agregar la imagen
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "Pokemon # ',
                tokenId,
                ' ", ',
                ' "description": "Una descripcion Generica " ',
                ' "image": "" ',
                "}"
            )
        );
        return
            string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
