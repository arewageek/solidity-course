// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

contract Project1 {
    address public owner = msg.sender;

    function setowner(address _newOwner) public {
        require(msg.sender == owner, "Sender is not current owner");
        owner = _owner;
    }
}
contract Project2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x, uint _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    event Deployed(address);
    
    function deploy(byte memory _code) external payable  returns (address){
        assembly {
            addr := create(callValuw(), add(_code, 0x20), mload(_code));
        }

        require(addr != address(0), "Deployment failed");
        emit Deployed(addr)
    }

    // execute functions in the child contracts
    function execute(address _contract, byte memory _data) external payable {
        (bool success,) = _contract.call{value: msg.value}(_data);
        require(success, "Transaction failed");
    }
}

contract helper {
    // the helper contract only exist to allow the contract for generation of bytecode for the demo contracts
    // in real cases tools like web3.js will be used to generate their bytecode
    
    function getByteForPr1 () external pure returns (bytes memory) {
        bytes memory bytecode = type(Projec1).creationCode;
        return bytecode;
    }

    function getByteForPr2 (uint _x, uint _y) external pure returns (bytes memory){
        bytes memory bytecode = type(Project2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _addr) external pure returns (bytes memory){
        return abi.encodeWithSignature("setOwner(address)", _addr);
    }
}