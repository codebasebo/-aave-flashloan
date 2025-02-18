// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/FlashloanV2.sol";

contract DeployFlashloanV2 is Script {
    function run() external {
        // Load network-specific configuration
        string memory network = vm.envString("NETWORK");
        address aaveLendingPoolV2 = vm.envAddress("AAVE_LENDING_POOL_V2");

        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy FlashloanV2 contract
        FlashloanV2 flashloan = new FlashloanV2(aaveLendingPoolV2);

        // Stop broadcasting transactions
        vm.stopBroadcast();

        // Log the deployed contract address
        console.log("FlashloanV2 deployed at:", address(flashloan));
    }
}