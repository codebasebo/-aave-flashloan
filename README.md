# Aave Flash Loan Foundry Mix

![Aave Banner](box-img-sm.png)



This Foundry mix provides everything you need to start developing on Aave flash loans using Foundry. It supports both **Aave V1 and V2**.

---

## Installation and Setup

1. **Install Foundry**:
   Follow the [Foundry installation guide](https://book.getfoundry.sh/getting-started/installation).

   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Set Up Environment Variables**:
   Create a `.env` file:

   ```plaintext
   PRIVATE_KEY=your_private_key_here
   INFURA_API_KEY=your_infura_project_id
   ETHERSCAN_API_KEY=your_etherscan_api_key
   ```

   Load the variables:

   ```bash
   source .env
   ```

3. **Initialize a Foundry Project**:
   ```bash
   forge init aave-flashloan
   cd aave-flashloan
   ```

4. **Install Dependencies**:
   ```bash
   forge install OpenZeppelin/openzeppelin-contracts@v3.0.0
   ```

5. **Configure `foundry.toml`**:
   Update `foundry.toml` with network and compiler settings.

---

## Quickstart (Kovan)

### 1. Get WETH
Run the script to get WETH on Kovan:

```bash
forge script script/GetWETH.sol --rpc-url kovan --broadcast
```

### 2. Deploy FlashloanV2
Deploy the `FlashloanV2` contract:

```bash
forge script script/DeployFlashloanV2.sol --rpc-url kovan --broadcast
```

### 3. Execute Flash Loan
Run the flash loan script:

```bash
forge script script/ExecuteFlashloan.sol --rpc-url kovan --broadcast
```

---

## Testing

Write tests in Solidity under the `test` directory. Run tests with:

```bash
forge test
```

---

## Deployment

Deploy to mainnet:

```bash
forge script script/DeployFlashloanV2.sol --rpc-url mainnet --broadcast
```

---

## Resources

- [Aave Flash Loan Documentation](https://docs.aave.com/developers/guides/flash-loans)
- [Foundry Documentation](https://book.getfoundry.sh/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/3.x/)

---

This mix is designed for developers familiar with Foundry. Adjust scripts and configurations as needed for your use case.