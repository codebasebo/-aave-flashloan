// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/interfaces/WethInterface.sol";

contract GetWETH is Script {
    function run() external {
        // Load network-specific configuration
        string memory network = vm.envString("NETWORK");
        address wethAddress = vm.envAddress("WETH");

        // Start broadcasting transactions
        vm.startBroadcast();

        // Get WETH by depositing ETH
        IWETH weth = IWETH(wethAddress);
        weth.deposit{value: 1 ether}();

        // Stop broadcasting transactions
        vm.stopBroadcast();

        // Log the transaction
        console.log("Received 1 WETH");
    }
}