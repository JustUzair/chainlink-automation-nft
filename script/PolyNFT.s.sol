// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {PolyNFT} from "../src/PolyNFT.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";

contract PolyNFTScript is Script {
    address user = makeAddr("user");
    PolyNFT polynft;

    function run() public returns (PolyNFT) {
        HelperConfig helperConfig = new HelperConfig();

        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        // console.log("deployerKey balance : ", address(0x79f21D75Dd65a42E6083d5117174b1704B804BD8).balance);
        vm.startBroadcast(deployerKey);
        polynft = new PolyNFT(30 seconds);
        vm.stopBroadcast();
        return polynft;
    }

    function setUpForTest() public returns (PolyNFT) {
        vm.startPrank(user);
        polynft = new PolyNFT(30 seconds);
        vm.stopPrank();
        return polynft;
    }
}
