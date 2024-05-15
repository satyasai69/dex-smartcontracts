// SPDX-License-Identifier: GPL-3.0

pragma solidity =0.5.16;

import "./interfaces/IERC20.sol";

contract TaxResiver {
    // Address of the contract owner
    address public owner;
    event Withdraw(address indexed token, address indexed to, uint amount);

    constructor() public {
        owner = msg.sender;
    }

    // Modifier to restrict function calls to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function withdraw(address _token, address _to) external onlyOwner {
        require(_to != address(0), "Invalid address");
        uint balance = IERC20(_token).balanceOf(address(this));
        require(balance > 0, "No balance to withdraw");
        require(IERC20(_token).transfer(_to, balance), "Transfer failed");
        emit Withdraw(_token, _to, balance);
    }
}
