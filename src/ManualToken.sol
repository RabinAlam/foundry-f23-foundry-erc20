// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address => uint256) private s_balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        s_balances[msg.sender] = totalSupply();
        emit Transfer(address(0), msg.sender, totalSupply());
    }

    function name() public pure returns (string memory) {
        return "Manual Token";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public {
        require(_to != address(0), "Transfer to zero address");
        require(_amount > 0, "Transfer amount must be positive");
        require(s_balances[msg.sender] >= _amount, "Insufficient balance");

        if (msg.sender != _to) {
            s_balances[msg.sender] -= _amount;
            s_balances[_to] += _amount;
        }

        emit Transfer(msg.sender, _to, _amount);
    }
}
