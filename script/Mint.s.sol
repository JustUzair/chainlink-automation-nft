// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {PolyNFT} from "../src/PolyNFT.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";
import {IERC721Metadata} from "@openzeppelin/contracts/interfaces/IERC721Metadata.sol";

contract Mint is Script {
    address user = makeAddr("user");
    PolyNFT polynft;

    function run() public returns (PolyNFT) {
        HelperConfig helperConfig = new HelperConfig();

        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        // console.log("deployerKey balance : ", address(0x79f21D75Dd65a42E6083d5117174b1704B804BD8).balance);
        vm.startBroadcast(deployerKey);
        PolyNFT(0x155d5EF456C97C9193b9d4A2f835fDDE1A22e853).safeMint(
            address(0x79f21D75Dd65a42E6083d5117174b1704B804BD8)
        );
        vm.stopBroadcast();
        return polynft;
    }
}
