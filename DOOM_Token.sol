//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Token {
    uint256 public totalSuppl = 1000000e18;
    mapping(address => uint256) public balancOf;
    mapping(address => mapping(address => uint256)) public allowance;
    mapping(address => bool) public blackList;
    address public owner;
    string public name = "DOOM";
    string public symbol = "DT";
    uint8 public decimal = 18;

    constructor() {
        owner = msg.sender;
        // address that deploys contract will be the owner
    }

    function addToBlackList(address bad_guy) external returns (bool) {
        require(msg.sender == owner, "You are not token owner");
        require(!blackList[bad_guy], "He is in black list");
        blackList[bad_guy] = true;
        return true;
    }

    function totalSupply() external view returns (uint256) {
        return totalSuppl;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balancOf[account];
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        require(msg.sender != recipient, "You can't send money to yourself!");
        require(!blackList[msg.sender], "You are in blackList");
        balancOf[msg.sender] -= amount;
        balancOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowanc(address owne, address spender)
        external
        view
        returns (uint256)
    {
        return allowance[owne][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function mint() public {
        require(!blackList[msg.sender], "You are in blackList");
        balancOf[msg.sender] = 500e18;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        allowance[sender][recipient] -= amount;
        balancOf[sender] -= amount;
        balancOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approve(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
}
