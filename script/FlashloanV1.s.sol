// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/contracts/v1/FlashloanV1.sol";

contract DeployFlashloanV1 is Script {
    address constant AAVE_LENDING_POOL_ADDRESS_PROVIDER = 0x24a42fD28C976A61Df5D00D0599C34c4f90748c8;

    function run() external {
        // Start broadcasting transactions
        vm.startBroadcast();

        // Deploy FlashloanV1 contract
        FlashloanV1 flashloan = new FlashloanV1(AAVE_LENDING_POOL_ADDRESS_PROVIDER);

        // Stop broadcasting transactions
        vm.stopBroadcast();

        // Log the deployed contract address
        console.log("FlashloanV1 deployed at:", address(flashloan));
    }
}