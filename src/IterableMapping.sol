// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

contract IterableMapping{
    mapping (address => uint) public balances;
    mapping (address => bool) public inserted;
    address[] accounts;

    function add(address _account, uint _value) external {
        balances[_account] = _value;

        if(inserted[_account]){
            inserted[_account] = true;
            accounts.push(_account);
        }
    }

    function getSize() external returns (uint){
        return accounts.length;
    }

    function first() external returns (uint){
        return balances[accounts[0]];
    }

    function last() external returns (uint){
        return balances[accounts.length - 1];
    }

    function get(uint _index) external returns (uint) {
        return balances[accounts[_index]];
    }
}