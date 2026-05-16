# PiggyBank Smart Contract 

A secure, educational Solidity smart contract that allows users to deposit Ether, tracks the deposit history, and permits the owner to safely withdraw funds to any specified address.

## Description

This project was built to demonstrate fundamental and intermediate Solidity concepts. It acts as a digital piggy bank where anyone can deposit funds, but only the deployer (owner) has the authority to cash out. The code emphasizes security, modern syntax (Solidity ^0.8.26), and gas optimization.

## Features

- **Accepts Direct Deposits:** Uses a `receive() external payable` function to safely catch incoming Ether.
- **Deposit Tracking:** Maintains an on-chain array recording the sender's address and the amount deposited.
- **Access Control:** Implements an `onlyOwner` modifier to restrict withdrawals.
- **Targeted Withdrawals:** Allows the owner to withdraw the contract's balance and send it directly to a specified wallet address.
- **Gas Optimization:** Utilizes **Custom Errors** (`revert InsufficientFunds()`) instead of standard `require` strings to save gas on reverted transactions.
- **Off-Chain Visibility:** Emits `Deposited` and `Withdrawn` events to allow front-end applications (like a React/Ethers.js UI) to easily track contract activity.

## Security Best Practices Implemented

- **Modern Ether Transfers:** Uses the recommended `(bool success, ) = payable(address).call{value: amount}("");`.
- **Transaction Validation** 

## Technologies Used

- **Solidity:** `^0.8.26`
- **Environment:** EVM 
- **Development Tool:** Remix IDE 

## How to Deploy and Test (Remix IDE)

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file named `PiggyBank.sol` and paste the contract code.
3. Go to the **Solidity Compiler** tab and compile the contract using version `0.8.26`.
4. Go to the **Deploy & Run Transactions** tab.
5. Select the `PiggyBank` contract and click **Deploy**.
6. **To Deposit:** Put a value (e.g., `100 wei`) in the "Value" field at the top, scroll down to the "Low level interactions" section of the deployed contract, and click **Transact** (this triggers the `receive()` function).
7. **To Withdraw:** Ensure you are using the owner account, input an amount and a destination address into the `withdraw` function, and execute.

## License

This project is licensed under the GPL-3.0 License.
