// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "./utils/Counters.sol";

contract PolyNFT is ERC721URIStorage {
    ////////////////////////////////
    /////// Storage Variables //////
    ////////////////////////////////
    string[] public s_IPFSUri = [
        "https://ipfs.io/ipfs/QmYaTsyxTDnrG4toc8721w62rL4ZBKXQTGj9c9Rpdrntou/seed.json",
        "https://ipfs.io/ipfs/QmYaTsyxTDnrG4toc8721w62rL4ZBKXQTGj9c9Rpdrntou/purple-sprout.json",
        "https://ipfs.io/ipfs/QmYaTsyxTDnrG4toc8721w62rL4ZBKXQTGj9c9Rpdrntou/purple-blooms.json"
    ];
    uint256 s_interval;
    uint256 s_lastTimeStamp;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor(uint256 _interval) ERC721("PolyNFT", "PNFT") {
        s_interval = _interval;
        s_lastTimeStamp = block.timestamp;
    }

    function checkUpkeep(bytes calldata /*checkData*/ ) external view returns (bool upkeepNeeded) {
        // check if upkeep is needed
        upkeepNeeded = (block.timestamp - s_lastTimeStamp) > s_interval;
    }

    function performUpkeep(bytes calldata /*performData*/ ) external {
        // do upkeep
        require((block.timestamp - s_lastTimeStamp) > s_interval, "upkeep not needed");
        if ((block.timestamp - s_lastTimeStamp) > s_interval) {
            s_lastTimeStamp = block.timestamp;
            growFlower(0);
        }
    }

    function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, s_IPFSUri[0]);
    }

    function growFlower(uint256 _tokenId) public {
        uint256 currentStage = flowerStage(_tokenId);
        // If invalid stage, return
        require(currentStage < 2, "grown fully");
        // new stage = previous stage + 1
        uint256 newval = currentStage + 1;
        // use index of new stage to get new token uri
        string memory newUri = s_IPFSUri[newval];
        _setTokenURI(_tokenId, newUri);
    }

    function flowerStage(uint256 _tokenId) public view returns (uint256) {
        string memory tokenUri = tokenURI(_tokenId);
        // hardcoding nft stages
        if (keccak256(abi.encodePacked(tokenUri)) == keccak256(abi.encodePacked(s_IPFSUri[0]))) {
            return 0;
        } else if (keccak256(abi.encodePacked(tokenUri)) == keccak256(abi.encodePacked(s_IPFSUri[1]))) {
            return 1;
        } else if (keccak256(abi.encodePacked(tokenUri)) == keccak256(abi.encodePacked(s_IPFSUri[2]))) {
            return 2;
        }
        return 0;
    }
}
