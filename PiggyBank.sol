// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;

contract PiggyBank {
    struct Deposit {
        uint amount;
        address sender;
    }
    Deposit[] deposits;

    address public owner;

    event Deposited(uint _amount, address sender);
    event Withdrawn(uint _amount, address _address);

    error InsufficientFunds(uint _amount);
    error InvalidAmount(uint _amount);

    constructor() {
        owner = msg.sender;
    }

    // Validates the address of the sender.
    modifier onlyOwner() {
        require(
            owner == msg.sender,
            "Only owner is allowed to perform this action."
        );
        _;
    }

    // Validates the amount.
    modifier validWithdrawal(uint _amount) {
        if (_amount <= 0) {
            revert InvalidAmount(_amount);
        }

        if (_amount > address(this).balance) {
            revert InsufficientFunds(_amount);
        }
        _;
    }

    // Adds the deposit received to the array.
    receive() external payable {
        uint _amount = msg.value;
        address _sender = msg.sender;

        if (_amount < 0) {
            revert InvalidAmount(_amount);
        }

        deposits.push(Deposit({amount: _amount, sender: _sender}));

        emit Deposited(_amount, _sender);
    }

    function withdraw(
        uint _amount,
        address _address
    ) public onlyOwner validWithdrawal(_amount) {
        (bool success, ) = payable(_address).call{value: _amount}("");

        require(success, "Ether transfer failed.");

        emit Withdrawn(_amount, _address);
    }
}
