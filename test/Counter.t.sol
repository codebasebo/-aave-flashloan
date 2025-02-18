// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "src/contracts/v1/FlashloanV1.sol";
import "src/contracts/v2/FlashloanV2.sol"; // Import FlashloanV2 contract

contract FlashloanTest is Test {
    // Define contract instances
    FlashloanV1 flashloanV1;
    FlashloanV2 flashloanV2;

    // Define token addresses (mainnet addresses)
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    // Aave lending pool addresses
    address constant AAVE_LENDING_POOL_V1 = 0x24a42fD28C976A61Df5D00D0599C34c4f90748c8;
    address constant AAVE_LENDING_POOL_V2 = 0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5;

    // Uniswap DAI exchange (for swapping ETH to DAI)
    address constant UNISWAP_DAI_EXCHANGE = 0x2a1530C4C41db0B0b2bB646CB5Eb1A67b7158667;

    // Test accounts
    address user;

    function setUp() public {
        // Deploy Flashloan contracts
        flashloanV1 = new FlashloanV1(AAVE_LENDING_POOL_V1);
        flashloanV2 = new FlashloanV2(AAVE_LENDING_POOL_V2);

        // Set up test account
        user = address(this); // Use the test contract as the user
        vm.deal(user, 100 ether); // Fund the user with 100 ETH
    }

    // Helper function to swap ETH for DAI on Uniswap
    function _swapETHForDAI(uint256 ethAmount) internal {
        // Approve Uniswap to spend ETH
        (bool success, ) = UNISWAP_DAI_EXCHANGE.call{value: ethAmount}(
            abi.encodeWithSignature("ethToTokenSwapInput(uint256,uint256)", 1, block.timestamp + 1000)
        );
        require(success, "Uniswap swap failed");
    }

    // Test ETH flashloan for FlashloanV1
    function testEthFlashloanV1() public {
        // Transfer ETH to the flashloan contract
        vm.deal(address(flashloanV1), 2 ether);

        // Execute flashloan
        flashloanV1.flashloan(ETH);
    }

    // Test DAI flashloan for FlashloanV1
    function testDaiFlashloanV1() public {
        // Swap ETH for DAI
        _swapETHForDAI(2 ether);

        // Transfer DAI to the flashloan contract
        uint256 daiBalance = IERC20(DAI).balanceOf(user);
        IERC20(DAI).transfer(address(flashloanV1), daiBalance);

        // Execute flashloan
        flashloanV1.flashloan(DAI);
    }

    // Test ETH flashloan for FlashloanV2
    function testEthFlashloanV2() public {
        // Transfer WETH to the flashloan contract
        vm.deal(user, 2 ether);
        IWETH(WETH).deposit{value: 2 ether}();
        IERC20(WETH).transfer(address(flashloanV2), 2 ether);

        // Execute flashloan
        flashloanV2.flashloan(WETH);
    }

    // Test DAI flashloan for FlashloanV2
    function testDaiFlashloanV2() public {
        // Swap ETH for DAI
        _swapETHForDAI(2 ether);

        // Transfer DAI to the flashloan contract
        uint256 daiBalance = IERC20(DAI).balanceOf(user);
        IERC20(DAI).transfer(address(flashloanV2), daiBalance);

        // Execute flashloan
        flashloanV2.flashloan(DAI);
    }

    // Test batch ETH and DAI flashloan for FlashloanV2
    function testBatchEthDaiFlashloanV2() public {
        // Swap ETH for DAI
        _swapETHForDAI(2 ether);

        // Transfer DAI to the flashloan contract
        uint256 daiBalance = IERC20(DAI).balanceOf(user);
        IERC20(DAI).transfer(address(flashloanV2), daiBalance);

        // Transfer WETH to the flashloan contract
        vm.deal(user, 2 ether);
        IWETH(WETH).deposit{value: 2 ether}();
        IERC20(WETH).transfer(address(flashloanV2), 2 ether);

        // Execute batch flashloan
        address[] memory tokens = new address[](2);
        tokens[0] = WETH;
        tokens[1] = DAI;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 1 ether;
        amounts[1] = 1 ether;

        flashloanV2.flashloan(tokens, amounts);
    }
}

// Mock IERC20 interface for token interactions
interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

// Mock IWETH interface for WETH interactions
interface IWETH {
    function deposit() external payable;
    function transfer(address recipient, uint256 amount) external returns (bool);
}