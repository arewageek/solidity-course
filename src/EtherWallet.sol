// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.24;

contract EtherWallet {
    address payable public immutable owner = msg.sender;

    modifier OnlyOwner() {
        require(msg.sender == owner, "Unauthorized");
        _;
    }

    modifier OnlyValidAmount(uint amount) {
        require(address(this).balance >= amount, "Insufficient funds")
    }

    receive() external payable{}

    function withdraw(uint _amount) external OnlyOwner() OnlyValidAmount(_amount) {
        payable(msg.sender).transfer(_amount);
    }

    function send(address payable _receiver, uint _amount, string not_e) external OnlyOwner() OnlyValidAmount(_amount) {
        if(!note){
            _receiver.transfer(_amount);
        }
        else{
            // trying a new alternative I learnt
            (bool success,) = _receiver.call{value: _amount}(note);

            require(success, "Transaction failed");
        }
    }

    function balance() external OnlyOwner() view returns(uint) {
        return address(this).balance;
    }
}