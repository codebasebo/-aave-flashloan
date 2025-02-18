// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/contracts/v2/FlashloanV2.sol";
import "../src/interfaces/WethInterface.sol";

contract ExecuteFlashloan is Script {
    uint256 constant MINIMUM_FLASHLOAN_WETH_BALANCE = 0.2 ether;

    function run() external {
        // Load network-specific configuration
        string memory network = vm.envString("NETWORK");
        address wethAddress = vm.envAddress("WETH");

        // Start broadcasting transactions
        vm.startBroadcast();

        // Get the latest deployed FlashloanV2 contract
        FlashloanV2 flashloan = FlashloanV2(vm.envAddress("FLASHLOAN_V2"));

        // Get WETH interface
        IWETH weth = IWETH(wethAddress);

        // Fund the Flashloan contract if it doesn't have enough WETH
        if (weth.balanceOf(address(flashloan)) < MINIMUM_FLASHLOAN_WETH_BALANCE) {
            console.log("Funding Flashloan contract with WETH...");
            weth.transfer(address(flashloan), 2 ether);
        }

        // Execute flashloan
        console.log("Executing Flashloan...");
        flashloan.flashloan(wethAddress);

        // Stop broadcasting transactions
        vm.stopBroadcast();

        // Log the transaction
        console.log("Flashloan executed successfully!");
    }
}