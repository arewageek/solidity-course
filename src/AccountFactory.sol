// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.24;

contract Account {
    address payable public immutable owner;

    modifier(address _owner) {
        require(_owner == owner, "Unauthorized");
    }

    constructor(address payable _owner) payable{
        owner = _owner;
    }

    receive() external payable {}

    function balance() external view returns (uint){
        return address(this).balance;
    }

    function withdraw () external OnlyOwner() {
        uint balance = address(this).balance;
        (bool success,) = address(owner).call{value: balance}("");
        require(success, "Withdrawal failed");
    }

    function send(address _receiver, uint _amount) external {
        uint balance = address(this).balance;
        if(balance > 0){
            address(_receiver).transfer(balance);
        }
    }
}

contact AccountFactory {
    Account[] public accounts;
    
    function deploy(address payable _owner) external returns(address){
        Account account = new Account{value: msg.value}(msg.sender);
        accounts.push(account);

        return account;
    }

    function deployedContracts() external returns (Account[] memory){
        return accounts;
    }

    function addLiquidity(address payable _account) external {
        address(_account).transfer(msg.value);
    }
}