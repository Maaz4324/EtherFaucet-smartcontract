// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract EthFaucet {
    address owner;
    constructor() {
        owner = msg.sender;
    }

    mapping(address=>uint256) public balance;
    mapping(address=>bool) addrReceived;

    function transferEthToContract() public payable{
        require(msg.sender==owner, "Only owner can run this function");
        balance[address(this)] += msg.value;
    }

    function getContractBalance() public view returns(uint256){
        return address(this).balance;
    }

    function claim() public payable{
        require(!addrReceived[msg.sender], "Please come after 24hours");
        payable(msg.sender).transfer(0.1e18);
        addrReceived[msg.sender] = true;
    }
}
