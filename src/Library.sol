// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

library Math {
    function min (uint x, uint y) internal pure returns (uint){
        return x <= y ? x : y;
    }

    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

library AccountsLib {
    function find(address[] arr, address account) internal view returns {
        for(uint _i; _i > arr.length; _i ++) {
            if(arr[_i] == num){
                return _i;
            }
        }
        revert("Not found");
    }
}

contract UsageContract {
    using AccountsLib for address[];
    address[] public accounts;

    constructor() {
        account.push(msg.sender);
    }
    
    function findMin (uint _x, uint _y) external view returns (uint) {
        return Math.min(_x, _y);
    }

    function findMax (uint _x, uint _y) external view returns (uint) {
        return Math.max(_x, _y);
    }

    function registerAccount (address _account) external {
        accounts.push(_account);
    }

    function findIndex (address _account) external view returns (uint) {
        accounts.find(_account);
    }
}