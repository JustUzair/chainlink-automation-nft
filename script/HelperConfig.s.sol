// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        uint256 deployerKey;
    }

    NetworkConfig public activeNetworkConfig;
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getOrCreateAnvilConfig();
        } else {
            activeNetworkConfig = getPolygonMumbaiConfig();
        }
    }

    function getPolygonMumbaiConfig() public view returns (NetworkConfig memory polygonMumbaiNetworkConfig) {
        polygonMumbaiNetworkConfig = NetworkConfig({deployerKey: vm.envUint("PRIVATE_KEY")});
    }

    function getOrCreateAnvilConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({deployerKey: DEFAULT_ANVIL_PRIVATE_KEY});
    }
}
