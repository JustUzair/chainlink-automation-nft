// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {console} from "forge-std/console.sol";
import {Test} from "forge-std/Test.sol";
import {PolyNFTScript} from "../script/PolyNFT.s.sol";
import {PolyNFT} from "../src/PolyNFT.sol";
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";

contract PolyNFTTest is Test {
    address user = makeAddr("user");
    PolyNFTScript polyNftScript = new PolyNFTScript();
    PolyNFT polyNft;

    function setUp() public {
        vm.startPrank(user);
        polyNft = polyNftScript.setUpForTest();
        console.log("polynft address : ", address(polyNft));
        vm.stopPrank();
    }

    function test_safeMintAndOwner() public {
        vm.startPrank(user);
        polyNft.safeMint(address(user));
        console.log("polynft token 0 owner : ", IERC721(polyNft).ownerOf(0));
        assertEq(IERC721(polyNft).ownerOf(0), address(user));
        vm.stopPrank();
    }

    function test_checkUpKeepFail() public {
        vm.startPrank(user);
        polyNft.safeMint(address(user));
        vm.expectRevert("upkeep not needed");
        polyNft.performUpkeep("");
        vm.stopPrank();
    }

    function test_checkUpKeepPass() public {
        vm.startPrank(user);
        polyNft.safeMint(address(user));
        string memory uriBeforeUpkeep = polyNft.s_IPFSUri(0);
        console.log("uri before upkeep : ", uriBeforeUpkeep);
        vm.warp(block.timestamp + 1 minutes); // update the block.timestamp to 1 minute in future
        string memory uriAfterUpkeep = polyNft.s_IPFSUri(1);
        console.log("uri after upkeep : ", uriAfterUpkeep);
        polyNft.performUpkeep("");
        assert(keccak256(abi.encodePacked(uriAfterUpkeep)) != keccak256(abi.encodePacked(uriBeforeUpkeep)));
        vm.stopPrank();
    }

    function test_maxFlowerGrowth() public {
        vm.startPrank(user);
        polyNft.safeMint(address(user));
        polyNft.growFlower(0);
        polyNft.growFlower(0);
        vm.stopPrank();
    }

    function test_moreThanMaxFlowerGrowth() public {
        vm.startPrank(user);

        polyNft.safeMint(address(user));
        polyNft.growFlower(0);
        polyNft.growFlower(0);
        vm.expectRevert("grown fully");
        polyNft.growFlower(0);
        vm.stopPrank();
    }
}
